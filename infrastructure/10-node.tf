resource "aws_iam_role" "worker" { 
  name = "ed-eks-worker" 
  assume_role_policy = file("./ec2-policy.json")   
 
} 
resource "aws_iam_policy" "autoscaler" { 
  name   = "ed-eks-autoscaler-policy" 
  policy = file("./autoscaler-policy.json")

} 

resource "aws_iam_role_policy_attachment" "autoscaler" { 
  policy_arn = aws_iam_policy.autoscaler.arn 
  role       = aws_iam_role.worker.name 
} 

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" { 
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy" 
  role       = aws_iam_role.worker.name 
} 
resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" { 
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy" 
  role       = aws_iam_role.worker.name 
} 
resource "aws_iam_role_policy_attachment" "AmazonSSMManagedInstanceCore" { 
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore" 
  role       = aws_iam_role.worker.name 
} 
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" { 
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly" 
  role       = aws_iam_role.worker.name 
} 

resource "aws_eks_node_group" "general" {
    cluster_name = aws_eks_cluster.eks.name
    version = local.eks_version
    node_group_name = "${var.eks_name}-general"

    subnet_ids = [
        aws_subnet.public_zone1.id,
        aws_subnet.public_zone2.id
    ]

    capacity_type = "ON_DEMAND"
    instance_types = ["t3.large"]

    scaling_config {
      desired_size = 3
      max_size = 10
      min_size = 1
    }
    update_config {
      max_unavailable = 1
     // max_unavailable_percentage = 50%
    }
    labels = {
      role = "${var.eks_name}-general"
    }

    depends_on = [ aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
                aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
                aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy
               ]
    lifecycle {
      ignore_changes = [ scaling_config[0].desired_size ]
    }

    node_role_arn = aws_iam_role.worker.arn

  
}