resource "aws_instance" "myec2" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.micro"

   provisioner "local-exec" {
    command = "echo ${aws_instance.myec2.private_ip} >> private_ips.txt"
    
    # aqui eu estou pegando a variavel da minha instancia ec2 sobre o ip privado e escrevendo no meu arquivo local
  }
}