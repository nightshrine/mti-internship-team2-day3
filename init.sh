#!/bin/bash

CLI_V2_PATH="awscliv2.zip"

# aws cli version2
sudo pip uninstall awscli -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o $CLI_V2_PATH
unzip $CLI_V2_PATH
sudo ./aws/install
rm -rf ./aws/
rm $CLI_V2_PATH

# タブ補完を有効にする
complete -C aws_completer aws
echo '# aws completer' >> ~/.bash_profile
echo complete -C \'$(which aws_completer)\' aws >> ~/.bash_profile
source ~/.bash_profile

# cliをシェルスクリプトから連続で叩いたときにlessでプロセスが停止しないようにする。
aws configure set cli_pager ''