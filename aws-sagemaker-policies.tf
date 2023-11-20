data "aws_iam_policy" "AmazonSageMakerCanvasFullAccess" {
  name = "AmazonSageMakerCanvasFullAccess"
}

data "aws_iam_policy" "AmazonSageMakerFullAccess" {
  name = "AmazonSageMakerFullAccess"
}

data "aws_iam_policy" "AmazonSageMakerCanvasForecastAccess" {
  name = "AmazonSageMakerCanvasForecastAccess"
}

data "aws_iam_policy_document" "sagemaker_s3_data" {

  statement {
    actions   = ["s3:ListBucket"]
    effect    = "Allow"
    resources = var.load_buckets
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]
    effect    = "Allow"
    resources = var.load_buckets
  }
}

resource "aws_iam_policy" "sagemaker_s3_data" {
  provider = aws.neptune
  name     = "${local.stack}-sagemaker-s3-data"
  path     = local.path
  policy   = data.aws_iam_policy_document.sagemaker_s3_data.json
}

resource "aws_iam_role" "sagemaker" {
  provider             = aws.neptune
  name                 = "${local.stack}-sagemaker"
  path                 = local.path
  assume_role_policy   = data.aws_iam_policy_document.sagemaker_role_trust_policies.json
  permissions_boundary = local.permissions_boundary
  tags                 = local.default_tags
}

data "aws_iam_policy_document" "sagemaker_role_trust_policies" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
    actions = [
      "sts:AssumeRole",
      "sts:SetSourceIdentity"
    ]
  }

  statement {
    principals {
      type        = "Service"
      identifiers = ["ssm.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "sagemaker_CanvasFullAccess" {
  provider   = aws.neptune
  policy_arn = data.aws_iam_policy.AmazonSageMakerCanvasFullAccess.arn
  role       = aws_iam_role.sagemaker.id
}

resource "aws_iam_role_policy_attachment" "sagemaker_CanvasForecastAccess" {
  provider   = aws.neptune
  policy_arn = data.aws_iam_policy.AmazonSageMakerCanvasForecastAccess.arn
  role       = aws_iam_role.sagemaker.id
}

resource "aws_iam_role_policy_attachment" "sagemaker_FullAccess" {
  provider   = aws.neptune
  policy_arn = data.aws_iam_policy.AmazonSageMakerFullAccess.arn
  role       = aws_iam_role.sagemaker.id
}

resource "aws_iam_role_policy_attachment" "sagemaker_s3_data" {
  provider   = aws.neptune
  policy_arn = aws_iam_policy.sagemaker_s3_data.arn
  role       = aws_iam_role.sagemaker.id
}
