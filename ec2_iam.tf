resource "aws_iam_instance_profile" "bastion_iam_profile" {
    name = "bastion_iam_profile"
    role = aws_iam_role.bastion_iam_role.name
}
resource "aws_iam_role" "bastion_iam_role" {
    assume_role_policy = data.aws_iam_policy_document.bastion_iam_role_policy_document.json
}
data "aws_iam_policy_document" "bastion_iam_role_policy_document" {
    statement {
        actions = ["sts:AssumeRole"]
        principals {
            type = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }
    }
}
resource "aws_iam_policy_attachment" "ssm_core_policy_attach" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    roles = [aws_iam_role.bastion_iam_role.name]
    name = "ssm_core_policy_attach"
}
resource "aws_iam_policy_attachment" "rds_policy_attach" {
    policy_arn = "arn:aws:iam::aws:policy/RDSFullAccess"
    roles = [aws_iam_role.bastion_iam_role.name]
    name = "rds_policy_attach"
}
resource "aws_iam_policy_attachment" "ssm_patch_policy_attach" {
    policy_arn = "arn:aws:iam::aws:policy/SSMPatchAssociation"
    roles =[aws_iam_role.bastion_iam_role.name]
    name = "ssm_patch_policy_attach" 
}