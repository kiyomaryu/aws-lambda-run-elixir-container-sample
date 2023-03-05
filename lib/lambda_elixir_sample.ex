defmodule LambdaElixirSample do
  use FaasBase, service: :aws
  alias FaasBase.Logger
  alias FaasBase.Aws.Request
  alias FaasBase.Aws.Response

  # 参考にSendMailにて設定ファイルを引っ張ってくる場合の書き方
  # use Swoosh.Mailer, otp_app: :lambda_elixir_sample

  @impl FaasBase
  def init(context) do
    # call back one time
    {:ok, context}
  end

  @impl FaasBase
  def handle(%Request{body: body} = request, event, context) do
    Logger.info(request)
    Logger.info(event)
    Logger.info(context)

    {status, result} = JSON.decode(body)
    {:ok, Response.to_response(body |> String.upcase, %{}, 200)}
  end
end
