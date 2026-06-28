resource "aws_security_group" "eks_cluster" {

  name = "${local.project_name}-eks-cluster-sg"

  description = "Security group for EKS cluster"

  vpc_id = aws_vpc.main.id


  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }


  tags = merge(
    local.common_tags,
    {
      Name = "${local.project_name}-eks-cluster-sg"
    }
  )
}



resource "aws_security_group" "eks_nodes" {

  name = "${local.project_name}-eks-nodes-sg"

  description = "Security group for EKS worker nodes"

  vpc_id = aws_vpc.main.id



  ingress {

    from_port = 0

    to_port = 0

    protocol = "-1"


    security_groups = [
      aws_security_group.eks_cluster.id
    ]
  }



  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"


    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }



  tags = merge(
    local.common_tags,
    {
      Name = "${local.project_name}-eks-nodes-sg"
    }
  )
}