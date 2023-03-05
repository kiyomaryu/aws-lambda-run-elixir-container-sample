#!/bin/bash
# Usage
# 環境変数を入れた状態でコンテナをビルドする方法
# bash container-builder.sh $ENVIRONMENT
ELIXIR_VERSION=1.14.0
MODULE_NAME="LambdaElixirSample"
CONTAINER_NAME="lambda-elixir-sample"
rm -rf _build
mkdir -p _build
# elixirをlambdaで動かすためのbuilder
docker run -d -it --name elx erintheblack/elixir-lambda-builder:al2_${ELIXIR_VERSION}
docker cp mix.exs elx:/tmp
docker cp lib elx:/tmp
# configファイルを追加
docker cp config elx:/tmp
docker exec elx /bin/bash -c "mix deps.get; MIX_ENV=prod mix aws.release ${MODULE_NAME}"
docker cp elx:/tmp/_aws ./_build
docker stop elx

# dockerファイルに環境変数を設定(ローカル実行用)
cat <<EOF > ./_build/_aws/Dockerfile
FROM amazon/aws-lambda-provided:al2.2021.07.05.11

COPY docker/bootstrap /var/runtime/

COPY docker/ /var/task/

ENV ENVIRONMENT=$1

CMD [ "${MODULE_NAME}" ]

EOF

# lambdaにデプロイ用のコンテナをビルド
docker build -t ${CONTAINER_NAME}:latest ./_build/_aws/