# Baixando o modulo da Branch main

module "demomodule" {
  source = "github.com/rafa3lmonteiro/tmp-repo"
}


# Baixando o modulo da Branch Dev

module "demomodule" {
  source = "github.com/rafa3lmonteiro/tmp-repo?ref=dev"
}

