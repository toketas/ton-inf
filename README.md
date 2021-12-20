## Pre-requisitos

- terragrunt -> é a ferramenta para terraformar nossa infra
    https://github.com/gruntwork-io/terragrunt/releases -> download
- credenciais AWS -> criar profile e preencher https://github.com/toketas/ton-inf/blob/c2389e4e3edc4eeea2c4f3c9205a6c77b0bbbfbc/infra/terragrunt.hcl#L22
- criar banco dynamoDB com uma tabela chamada `ton-terraform-lock`
- criar a seguinte role com a seguinte policy:
  - policy: TerraformRemoteStatePolicy

        {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Sid": "VisualEditor0",
                    "Effect": "Allow",
                    "Action": [
                        "dynamodb:DeleteItem",
                        "dynamodb:DescribeContributorInsights",
                        "dynamodb:RestoreTableToPointInTime",
                        "dynamodb:ListTagsOfResource",
                        "dynamodb:CreateTableReplica",
                        "dynamodb:UpdateContributorInsights",
                        "dynamodb:UpdateGlobalTable",
                        "dynamodb:CreateBackup",
                        "dynamodb:DeleteTable",
                        "dynamodb:UpdateTableReplicaAutoScaling",
                        "dynamodb:UpdateContinuousBackups",
                        "dynamodb:PartiQLSelect",
                        "dynamodb:DescribeTable",
                        "dynamodb:PartiQLInsert",
                        "dynamodb:GetItem",
                        "dynamodb:DescribeContinuousBackups",
                        "dynamodb:DescribeExport",
                        "dynamodb:CreateGlobalTable",
                        "dynamodb:DescribeKinesisStreamingDestination",
                        "dynamodb:EnableKinesisStreamingDestination",
                        "dynamodb:BatchGetItem",
                        "dynamodb:DisableKinesisStreamingDestination",
                        "dynamodb:UpdateTimeToLive",
                        "dynamodb:BatchWriteItem",
                        "dynamodb:ConditionCheckItem",
                        "dynamodb:PutItem",
                        "dynamodb:PartiQLUpdate",
                        "dynamodb:Scan",
                        "dynamodb:Query",
                        "dynamodb:StartAwsBackupJob",
                        "dynamodb:DescribeStream",
                        "dynamodb:UpdateItem",
                        "dynamodb:DeleteTableReplica",
                        "dynamodb:DescribeTimeToLive",
                        "dynamodb:CreateTable",
                        "dynamodb:UpdateGlobalTableSettings",
                        "dynamodb:DescribeGlobalTableSettings",
                        "dynamodb:RestoreTableFromAwsBackup",
                        "dynamodb:GetShardIterator",
                        "dynamodb:DescribeGlobalTable",
                        "dynamodb:RestoreTableFromBackup",
                        "dynamodb:ExportTableToPointInTime",
                        "dynamodb:DescribeBackup",
                        "dynamodb:DeleteBackup",
                        "dynamodb:UpdateTable",
                        "dynamodb:GetRecords",
                        "dynamodb:PartiQLDelete",
                        "dynamodb:DescribeTableReplicaAutoScaling"
                    ],
                    "Resource": "arn:aws:dynamodb:*:583659277374:table/ton-terraform-lock"
                },
                {
                    "Sid": "VisualEditor1",
                    "Effect": "Allow",
                    "Action": "s3:*",
                    "Resource": "*"
                }
            ]
        }
  - role: TerraformRemoteState
  - preencher a `role_arn` na [linha 40](https://github.com/toketas/ton-inf/blob/c2389e4e3edc4eeea2c4f3c9205a6c77b0bbbfbc/infra/terragrunt.hcl#L40) do terragrunt.hcl raíz com o IAM role gerado.

## Comandos

`terragrunt init`
`terragrunt plan`
`terragrunt apply`


## Playbook

1. Para subir o recurso precisa estar no mesmo diretório do arquivo `terragrunt.hcl`
Ordem sugerida para subir recursos:

vpc
ec2
simple-nginx/sns
cloudwatch-alerts/cpu-alarm

2. Pegue o ip da instancia e coloque em seu `/etc/hosts` na seguinte forma:
`<ip_instancia> app.ton.com.br`

3. Teste a aplicação acessando https://app.ton.com.br
    - Abra uma exceção no navegador para o self-signed certificate.
