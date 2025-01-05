data "aws_caller_identity" "current" {}

resource "aws_iam_role" "eks_admin" {
  name = "${var.project_name}-${var.eks_name}-admin"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      }
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "eks_admin" {
    name = "AmazonEKSAdminPolicy"
    policy = file("./admin-poilcy.json")
}

resource "aws_iam_role_policy_attachment" "eks_admin" {
    policy_arn = aws_iam_policy.eks_admin.arn
    role = aws_iam_role.eks_admin.name
  
}

resource "aws_iam_user" "manager" {
    name = "eks_manager"
  
}
resource "aws_iam_policy" "eks_assuem_admin" {
    name = "AmazonEKSAssumeAdminPolicy"

    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "${aws_iam_role.eks_admin.arn}"
    }
  ]
}
POLICY
}


resource "aws_iam_user_policy_attachment" "eks_user_admin" {
    user = aws_iam_user.manager.name
    policy_arn = aws_iam_policy.eks_assuem_admin.arn
}

resource "aws_eks_access_entry" "eks_user_admin" {
    cluster_name = aws_eks_cluster.eks.name
    principal_arn = aws_iam_user.manager.arn
    kubernetes_groups = ["aws-admin"]
  
}