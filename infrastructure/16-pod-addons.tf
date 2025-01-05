resource "aws_eks_addon" "pod-addon" {
    cluster_name = aws_eks_cluster.eks.name
    addon_name = "eks-pod-identity-agent"
    addon_version = "v1.3.4-eksbuild.1"
  
}