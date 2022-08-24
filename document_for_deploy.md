# デプロイスクリプト

はじめに以下のコマンドで実行権限を与える

```bash
chmod 755 ./deploy.sh
```

## ファイル名変更

先に `yourname.env` を変更しておくこと

```bash
./deploy.sh
```

## Lambda

### Lambda のデプロイ(新規)

./lambda 以下の全ファイルがデプロイされる

```bash
./deploy.sh lambda_deploy
```

### Lambda のデプロイ(更新)

```bash
./deploy.sh lambda_update
```

## S3

### S3 バケットの作成
```bash
./deploy.sh s3_deploy
```

### S3 へのデプロイ

```bash
npm run build
./deploy.sh s3_update
```

もしくは

```bash
npm run build && ./deploy.sh s3_update
```
