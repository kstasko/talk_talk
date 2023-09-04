# Talk Talk

## CONTRIBUTING

### Project Setup

**Dependencies**

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

**First Time Setup**

- Run `npm run init` at the top level to do any project setup needed to develop

**Available pre-baked operations**
    
- `npm run validate` : Validates terraform, GH Actions & runs any unit tests
- `npm run build` : Generates any build artifacts (TF Templates/JS Artifacts)