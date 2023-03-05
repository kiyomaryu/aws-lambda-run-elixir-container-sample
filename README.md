# AwsLambdaRunElixirContainerSample

AWSのLambdaにてElixirをするサンプルです。

## 事前準備

- awscliがインストールされていること(APIキーも設定済み)

## Elixirをlambdaで実行するためにコンテナを作成する

手動で実行すると煩雑になるためシェルスクリプトにまとめました。

### コンテナのプレビルド→ビルドまで

```
export ENVIRONMENT=hogehoge
bash container-builder.sh $ENVIRONMENT
```
コンテナ内に設定する環境変数を引数としてサンプルではENVIRONMENTとしています。

## ローカル環境で実行

起動
```
docker run --rm -p 9000:8080 lambda-elixir-sample:latest
```
動作確認コマンド
```
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"key1":"kiyo","key2":"maru"}'
※サンプルとしてリクエストを大文字にして返す処理をelixirで書いている
```

## ECRにビルドしたコンテナイメージをpush

xxxxxxxxxxxx：プロジェクトID  
default: プロファイル名。defaultのみの想定のためdefaultを指定  
  
```
aws ecr get-login-password --region ap-northeast-1 --profile default | docker login --username AWS --password-stdin xxxxxxxxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com
aws ecr create-repository \
    --repository-name lambda-elixir-sample \
    --image-scanning-configuration scanOnPush=true \
    --region ap-northeast-1 \
    --profile default
docker tag lambda-elixir-sample:latest xxxxxxxxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com/lambda-elixir-sample
docker push xxxxxxxxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com/lambda-elixir-sample:latest
```

## lambdaにデプロイ

AWSのコンソールから作っていきます。  
本来はawscliがいいのですが時間の関係上GUIを書くことにしました。  
  
3.Lambda関数に Amazon ECR リポジトリ(の Docker イメージ) から ビルドする手順を参照
https://qiita.com/sasaco/items/b65ce36c05c50a74ac3e#3lambda%E9%96%A2%E6%95%B0%E3%81%AB-amazon-ecr-%E3%83%AA%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%81%AE-docker-%E3%82%A4%E3%83%A1%E3%83%BC%E3%82%B8-%E3%81%8B%E3%82%89-%E3%83%93%E3%83%AB%E3%83%89%E3%81%99%E3%82%8B%E6%89%8B%E9%A0%86

## 動作確認
AWSのコンソール＞Lambda＞今回作ったLambdaを選択＞テストから実行
リクエストが大文字に帰ってくれば成功
