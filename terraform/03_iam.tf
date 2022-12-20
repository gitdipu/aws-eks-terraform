resource "aws_iam_role" "eks_cluster_role" {
  name               = "eks-cluster-role"
  assume_role_policy = file("policies/eks-cluster-role.json")
}

# resource "aws_iam_role_policy" "ecs-instance-role-policy" {
#   name   = "ecs_instance_role_policy"
#   policy = file("policies/ecs-instance-role-policy.json")
#   role   = aws_iam_role.ecs-host-role.id
# }

resource "aws_iam_role" "ec2_role" {
  name               = "ec2_role"
  assume_role_policy = file("policies/ec2-role.json")
}

# resource "aws_iam_role" "ecs-service-role" {
#   name               = "ecs_service_role_prod"
#   assume_role_policy = file("policies/ecs-role.json")
# }

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.eks_cluster_role.name}"
}


resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.eks_cluster_role.name}"
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.ec2_role.name
}


resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.ec2_role.name
}


resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.ec2_role.name
}
