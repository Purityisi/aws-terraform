# Create an user
resource "aws_iam_user" "adam" {
  name = "adam.god"
}

# Create a group
resource "aws_iam_group" "devops" {
  name="devops"
}

# Get a policy from existing one.
data "aws_iam_policy" "Administrator_Access" {
  name="AdministratorAccess"
}

# attach policy to group
resource "aws_iam_group_policy_attachment" "attach" {
  group=aws_iam_group.devops.name
  policy_arn = data.aws_iam_policy.Administrator_Access.arn
}

resource "aws_iam_user" "eve" {
  name = "eve"

  tags = {
    Name = "Eve"
  }
}

resource "aws_iam_group_membership" "devops" {
    name = aws_iam_group.devops.name

    users = [
        aws_iam_user.eve.name
    ]
    group = aws_iam_group.devops.name
}

# Create s3 bucket
resource "aws_s3_bucket" "bucket1" {
    bucket = "Purity-bucket0604"
}

# Create on instance
resource "aws_instance" "web-1" {
  ami = "ami-06068bc7800ac1a83"
  instance_type = "t2.micro"  
}
