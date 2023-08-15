resource "aws_iam_role" "web_instance_role" {
  name = "WebInstanceRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "web_instance_s3_policy_attachment" {
  name       = "web-instance-s3-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  roles      = [aws_iam_role.web_instance_role.name]
}

resource "aws_iam_instance_profile" "web_instance_profile" {
  name = "web-instance-profile"
  role = aws_iam_role.web_instance_role.name
}