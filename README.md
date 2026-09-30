# Atlas K8s Foundation: Enterprise-Grade Internal Developer Platform 🚀

[![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=flat&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=flat&logo=kubernetes&logoColor=white)](https://kubernetes.io/)
[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=flat&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![ArgoCD](https://img.shields.io/badge/ArgoCD-%23EF7B4D.svg?style=flat&logo=argo&logoColor=white)](https://argoproj.github.io/cd/)
[![Python](https://img.shields.io/badge/python-3670A0?style=flat&logo=python&logoColor=ffdd54)](https://www.python.org/)

## 🎯 The Problem

In modern cloud environments, engineering teams often face bottlenecks when deploying microservices. Traditional infrastructure provisioning is slow, idle compute resources drive up cloud costs, and shared Kubernetes clusters suffer from the "noisy neighbor" effect and security risks due to over-privileged applications. Furthermore, manual `kubectl` deployments lead to configuration drift and operational overhead.

## 💡 The Solution

**Atlas K8s Foundation** is a highly available, multi-tenant Internal Developer Platform (IDP) built on AWS Elastic Kubernetes Service (EKS). It provides a secure, automated, and cost-efficient environment for engineering teams to deploy containerized applications without worrying about underlying infrastructure management.

This project implements AWS Well-Architected best practices, focusing on **Operational Excellence, Security, Reliability, and Cost Optimization**.

## ⚙️ Architecture & Workflow

1. **Infrastructure as Code (IaC):** Foundation infrastructure (VPC, EKS Control Plane, IAM) is declaratively provisioned using modular **Terraform**.
2. **DevSecOps & Shift-Left (CI):** Every Pull Request triggers **GitHub Actions** that run **Checkov** to prevent IaC misconfigurations, **Infracost** to estimate cloud expenditures before deployment, and **Trivy** to scan Docker images for CVEs.
3. **Advanced Auto-Scaling:** Traditional Cluster Autoscaler is replaced by **Karpenter**, which observes aggregate un-schedulable pod resources and dynamically provisions right-sized, cost-effective EC2 Spot instances in seconds.
4. **Least-Privilege Security:** Workloads (Python APIs) interact with AWS services using **IRSA** (IAM Roles for Service Accounts), eliminating the need for hardcoded AWS credentials.
5. **GitOps Delivery (CD):** **ArgoCD** acts as the cluster reconciler. Direct `kubectl` access is blocked. ArgoCD continuously monitors the `k8s-manifests/` directory and synchronizes the cluster to match the desired state declared in Git.

## 🛠️ Tech Stack

- **Cloud Provider:** AWS
- **Orchestration:** Kubernetes (Amazon EKS)
- **Infrastructure as Code:** Terraform
- **Just-in-Time Provisioning:** Karpenter
- **GitOps (CD):** ArgoCD
- **CI / Automation:** GitHub Actions
- **DevSecOps:** Checkov (IaC), Trivy (Containers)
- **FinOps:** Infracost
- **Workload:** Python (FastAPI/Flask) & Docker

## 📂 Repository Structure

    atlas-k8s-foundation/
    ├── .github/workflows/         # CI/CD pipelines (Actions, Infracost, Checkov, Trivy)
    ├── infrastructure/            # Terraform IaC
    │   ├── modules/               # Reusable local Terraform modules (Network, EKS, Karpenter)
    │   └── environments/          # Environment-specific configurations (dev, prod)
    ├── k8s-manifests/             # GitOps source of truth for ArgoCD
    │   ├── platform/              # Infrastructure add-ons (Karpenter claims, Ingress)
    │   └── tenants/               # Application namespaces and workload manifests
    └── src/image-processor/       # Python workload source code and Dockerfile

## 📋 Prerequisites

Before you begin, ensure you have the following tools installed and configured:

- [AWS CLI v2](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) configured with Administrator access.
- [Terraform](https://developer.hashicorp.com/terraform/downloads) (v1.5.0+)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Docker](https://docs.docker.com/get-docker/)

## 🚀 Getting Started

**Note:** This project is divided into phases. Detailed instructions will be added as each phase is completed.

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/YOUR_USERNAME/atlas-k8s-foundation.git](https://github.com/YOUR_USERNAME/atlas-k8s-foundation.git)
   cd atlas-k8s-foundation
   ```
