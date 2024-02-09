resource "aws_iam_role" "eks-role" {
  name = "tagal-eks-cluster-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "tagal-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-role.name
}

resource "aws_eks_cluster" "tagal-eks" {
  name     = "tagal-eks"
  role_arn = aws_iam_role.eks-role.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.main-private-1.id,
      aws_subnet.main-private-2.id,
      aws_subnet.main-private-3.id,
      aws_subnet.main-public-1.id,
      aws_subnet.main-public-2.id,
      aws_subnet.main-public-3.id,
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.tagal-AmazonEKSClusterPolicy]
}