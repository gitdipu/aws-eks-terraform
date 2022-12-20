output "endpoint" {
  value = "${aws_eks_cluster.eks_cl.endpoint}"
}

output "kubeconfig-certificate-authority-data" {
  value = "${aws_eks_cluster.eks_cl.certificate_authority.0.data}"
}