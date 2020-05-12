resource "aws_cloudwatch_event_rule" "this" {
  name = var.application_name

  event_pattern = var.rule

  tags = {
    Application = var.application_name
  }
}

resource "aws_cloudwatch_event_target" "this" {
  rule = aws_cloudwatch_event_rule.this.name
  target_id = "SendToLambda"
  arn = aws_lambda_function.this.arn
}

resource "aws_lambda_permission" "this" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.this.arn
}