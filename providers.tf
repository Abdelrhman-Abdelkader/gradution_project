terraform {
  required_version = ">= 1.4.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.23"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.11"
    }

    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_eks_cluster" "main" {
  name       = aws_eks_cluster.main.name
  depends_on = [aws_eks_cluster.main]
}

data "aws_eks_cluster_auth" "main" {
  name       = aws_eks_cluster.main.name
  depends_on = [aws_eks_cluster.main]
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.main.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.main.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.main.token
}



# # terraform {
# #   required_version = ">= 1.14.3"
# #   required_providers {
# #     aws = {
# #       source  = "hashicorp/aws"
# #       version = "> 5.0"
# #     }
# #     kubernetes = {
# #       source  = "hashicorp/kubernetes"
# #       version = "> 2.23"
# #     }
# #     helm = {
# #       source  = "hashicorp/helm"
# #       version = "> 2.11"
# #     }
# #   }
# #  }
# # provider "aws" {
# #   region = "ap-southeast-2"   # Change this to your preferred region (e.g., ap-southeast-2)
# # }

# # provider "kubernetes" {
# #   # host                   = aws_eks_cluster.main.endpoint
# #   # cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority[0].data)

# #   exec {
# #     api_version = "client.authentication.k8s.io/v1beta1"
# #     command     = "aws"
# #     args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.main.name]
# #   }
# # }


# # data "aws_eks_cluster" "main" {
# #   name = aws_eks_cluster.main.name
# # }

# # data "aws_eks_cluster_auth" "main" {
# #   name = aws_eks_cluster.main.name
# # }

# # provider "kubernetes" {
# #   host                   = data.aws_eks_cluster.main.endpoint
# #   cluster_ca_certificate = base64decode(data.aws_eks_cluster.main.certificate_authority[0].data)
# #   token                  = data.aws_eks_cluster_auth.main.token
# # }

# # provider "helm" {
# #   kubernetes {
# #     host                   = data.aws_eks_cluster.main.endpoint
# #     cluster_ca_certificate = base64decode(data.aws_eks_cluster.main.certificate_authority[0].data)
# #     token                  = data.aws_eks_cluster_auth.main.token
# #   }
# # }
# terraform {
#   required_version = ">= 1.4.3"

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = ">= 5.0"
#     }

#     kubernetes = {
#       source  = "hashicorp/kubernetes"
#       version = ">= 2.23"
#     }

#     helm = {
#       source  = "hashicorp/helm"
#       version = ">= 2.11"
#     }

#     tls = {
#       source  = "hashicorp/tls"
#       version = ">= 4.0"
#     }
#   }
# }

# provider "aws" {
#   region = var.aws_region
# }

# # بعد ما الـ EKS يتخلق، نقرأ بياناته عشان نكوّن kubernetes/helm providers
# data "aws_eks_cluster" "main" {
#   name = aws_eks_cluster.main.name
# }

# data "aws_eks_cluster_auth" "main" {
#   name = aws_eks_cluster.main.name
# }

# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.main.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.main.certificate_authority[0].data)
#   token                  = data.aws_eks_cluster_auth.main.token
# }

# provider "helm" {
#   kubernetes {
#     host                   = data.aws_eks_cluster.main.endpoint
#     cluster_ca_certificate = base64decode(data.aws_eks_cluster.main.certificate_authority[0].data)
#     token                  = data.aws_eks_cluster_auth.main.token
#   }
# }

# # provider "helm" {
# #   host                   = data.aws_eks_cluster.main.endpoint
# #   cluster_ca_certificate = base64decode(data.aws_eks_cluster.main.certificate_authority[0].data)
# #   token                  = data.aws_eks_cluster_auth.main.token
# # }
