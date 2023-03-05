# import Config

# mix releaseの場合はビルド時じゃなくて実行時に環境変数を読む
# つまりlambda用のコンテナを動かすときはこちらの設定を読む config.exs より releases.exsが優先
# config :lambda_elixir_sample, LambdaElixirSample,
#    adapter: Swoosh.Adapters.Sendgrid,
#    api_key: System.get_env("API_KEY")
