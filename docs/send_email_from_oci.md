
# VMからOCIの通知サービスを利用した通知の実行構成

## OverView

OICでは一定の容量までのArmインスタンスを無料で利用することができる。
このインスタンスをKubernetesノード用として利用したいが、ハイパーバイザーリソースが足りなためか、
作成に失敗する。

そのため常時起動しているマシンから継続的に「tarraform apply」を実行し、
コンピュータリソースが空いたタイミングですぐにArmインスタンスを確保できるようにしたい。
併せて作成されたことを気づくために、OCIの通知サービスを利用して
通知できるようにする。

ここではTerraformを実行したマシンからOCIの通知サービスを利用した通知に必要な、VM上の設定手順をまとめておく。　

## Environment

Oracle Linuxでyumを使用するとなぜかスタックしてしまうため、代わりにUbuntuで代用

参考
- https://blog-swstudio.com/flex-instance/
- https://docs.oracle.com/ja-jp/iaas/Content/API/SDKDocs/cliinstall.htm#InstallingCLI__linux_and_unix


## How to

1. oci-utilsのインストール([参考](https://github.com/oracle/oci-utils/issues/136))
    - Githubから直接ソースコードをCloneし、ビルドすることでインストールする

```bash
$ git colne https://github.com/oracle/oci-utils.git
$ cd oci-utils
$ python3 ./setup.py build
$ sudo python3 ./setup.py install
```

2. これでoci-utilsのツールであるoci-notiyを実行することができる。
    - ただしrootユーザーでしか実行することができない
    - また使用するためにはoci-cliの構成も合わせて必要
    - そのため、rootユーザー上にoci-cliをインストールの上、セットアップする
    - さらにPytonライブラリとして依存関係のあるociも合わせてインストールが必要


3. rootユーザーへスイッチしてoci-cliをインストールする

```shell
$ sudo -i
$ bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
$ exec -l $SHELL
$ /root/bin/oci  --help
$ exit
```

4. インストールしたoci-cliをセットアップする
    - API Keyの作成は行う

```shell
$ sudo /root/bin/oci setup config
```

5. 作成されたAPIキーの公開鍵をOCI上に登録

    - OCI Console上で、「ユーザープロファイル」→「APIキー」の順で遷移して登録

```bash
$ sudo cat /root/.oci/oci_api_key_public.pem
```

6. OCI CLIの構成ファイルをoci-notifyから利用できるようにコピー

```bash
$ sudo cp  /root/.oci/config  /etc/oci-utils/oci_cli.conf
```
 
7. oci-notifyと依存関係のあるPytonライブラリであるociをインストール

```bash
$ sudo apt install pyhon3-pip
$ sudo pip3 install oci
```

8. OCI上でOCI通知サービスを作成

- 「開発者サービス」→「通知」へ遷移し、トピックを作成
- 作成したトピックのサブスクリプションを構成
    - プロトコルは電子メール
    - 電子メールに送信したいメールアドレスを入力

9. サブスクリプション作成後に登録したメールアドレスへ確認メールが届くのでメール内の「Confirm subscription」をクリック


10. oci-notifyによる通知を実行するための構成を行う。

```bash
$ sudo oci-notify -c <作成したトピックのOCID>
```

11. 実際に通知する際は以下のように実行

```bash
$ sudo oci-notify -t <通知タイトル> -f <通知本文が記載されたテキストファイルのパス>
```


## Other 

実際に実行する際は以下のようなスクリプトを実行する。
tmuxのセッション上で実行してSSHを切断しても実行されるようにする。

```shell
count=0 
while true
do
    count=`expr $count + 1` 
    terraform apply -auto-approve
    if [ $? -eq 0 ]; then
        echo OCIでKubernetesクラスタ用のインスタンスの確保に成功しました。> result.txt    
        echo $count回目でインスタンス獲得に成功 > result.txt
        echo Current Time :$(date) > result.txt
        sudo oci-notify -t "Created Kuberntes instance at OCI." -f result.txt # 通知
        exit 0
    fi
    echo Current count is $count.
    sleep 10 
done
```