# Building a minimal Terraform module to deploy a single node ElasticSearch in an AWS 

This documentation below simply explain how I built a minimal Terraform module to deploy a single node ElasticSearch in an AWS 

## Tools used

Below are the tools and technologies I used for deploying my ElasticSearch cluster to AWS
 - [`Terraform`](https://www.terraform.io/) - This is an infrastructure as code software by [`Hashicorp`](https://www.hashicorp.com/). It allows users to define a data center infrastructure in a high-level configuration language, from which it can create an execution plan to build the infrastructure in a service provider such as [`AWS`](https://aws.amazon.com), [`Google cloud platform`](http://cloud.google.com), [`Microsoft Azure`](https://azure.microsoft.com/en-us/?v=solutions-dropdown) e.t.c.
 - [`Ansible`](https://www.ansible.com/) - This is an open source software that automates software provisioning, configuration management, and application deployment. Ansible connects via SSH, remote PowerShell or via other remote APIs.

 - [`Packer`](https://packer.io/) - This is an open source tool for creating identical machine images for multiple platforms from a single source configuration. Packer is lightweight, runs on every major operating system, and is highly performant, creating machine images for multiple platforms in parallel.
 - [`Nginx`](https://www.nginx.com/) - This is an open source software for web serving, reverse proxying, caching, load balancing, media streaming, and more. It started out as a web server designed for maximum performance and stability
 - [`ElasticSearch`](https://www.elastic.co/) - Elasticsearch is a search engine based on the Lucene library. It provides a distributed, multitenant-capable full-text search engine with an HTTP web interface and schema-free JSON documents.
 - [`Kibana`](https://www.elastic.co/products/kibana) - Kibana is an open source data visualization plugin for Elasticsearch. It provides visualization capabilities on top of the content indexed on an Elasticsearch cluster. Users can create bar, line and scatter plots, or pie charts and maps on top of large volumes of data.
 - [`Node.js`](https://nodejs.org/en/) - Node.js is an open-source, cross-platform JavaScript run-time environment that executes JavaScript code outside of a browser.
 - [`Babel`](``)
 - [`ES6`](``)
  
   Basically, I'm using Packer alongside Ansible as a provisoner to create a machine image for ElasticSearch. A machine image is a single static unit that contains a pre-configured operating system and installed software which is used to quickly create new running machines. So I use Terraform to launch an instance with the machine Image on AWS.

## Prerequisites
This guide assumes the following

- Terraform, Packer and Ansible installed on your machine
- Node.js install on your machine

## Getting Started
Follow the instruction below to set up this infrastructure on your AWS account.

1. Clone the project into your local machine
    ```bash
    git clone https://github.com/kensanni/Aula-test.git
    cd Aula-task
    ```
2.  Follow the steps below to build the elasticSearch Image

    * Export your AWS credentials to environment variables
        ```bash
        export AWS_ACCESS_KEY= YOUR_AWS_ACCESS_KEY
        export AWS_SECRET_KEY= YOUR AWS_SECRET_KEY
        ```
    * Move into the `images/ElasticSearch` directory
        ```bash
          $ cd images/ElasticSearch
        ```
    * Run the `packer build es_cluster.json` command to build the image
        ```bash
         $ packer build es_cluster.json
        ```

3. Follow the steps below to build up the infrastructure

    * Move into the `terraform` directory
        ```bash
         $ cd terraform
        ```
    * Create a `terraform.tfvars` file to hold your credentials
        ```bash
         $ touch terraform.tfvars
        ```
    * Add your credentials into your `terraform.tfvars` as shown below
        ```
            access_key = "YOUR_AWS_ACCESS_KEY"

            secret_key = "YOUR_SECRET_KEY"

            public_key = "YOUR_PUBLIC_KEY_PAIR"
        ```
        The `public_key` is an SSH-key which is used as authentication to create your server. You would use the ssh key to have terminal access to your server.  

        If you don't have a `public_key`, you can generate one by running the `ssh-keygen` command, copy and paste the content of the public_key as shown above.

    * Initialize terraform by running the `terraform init` command
        ```bash
         $ terraform init
        ```
    * You can check the changes that would be applied on the infrastructure by running `terraform plan`
        ```bash
         $ terraform plan
        ```
    * Run the `terraform apply` to apply the changes on your infrastructure
        ```bash
         $ terraform apply
        ```
        This command would create the infrastructure and output the public-DNS and IP-address to your console. Copy either of the public-DNS or IP-address to log into ElasticSearch cluster. This would prompt your for a login credentials which is shown below

        ```
        username: admin
        password: Testpassword1234@
        ```
4. Follow the steps below to setup the Node.js app to index random sample data and perform basic API queries.

    * Move into the `node.js` directory
        ```bash
        $ cd node.js
        ```
    * Run `npm install` to install the project dependencies
        ```bash
        $ npm install
        ```