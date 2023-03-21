terraform {
  backend "s3" {
  bucket = "mybucket"
  key    = "path/to/my/key"
  region = "us-east-1"
	}
}


# Com isso configurado podemos testar dando um LS no bucket:

# $ aws s3 ls s3://meu-bucket-rafael

# E para verificar um bucket em outra região:

# $ aws s3 ls s3://meu-bucket-rafael --region ap-south-1
