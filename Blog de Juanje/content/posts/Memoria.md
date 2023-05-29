+++
title = "Memoria"
date = "2023-05-22T11:37:33+02:00"
author = ""
authorTwitter = "" #do not include @
cover = ""
tags = ["", ""]
keywords = ["", ""]
description = ""
showFullContent = false
readingTime = false
hideComments = false
color = "" #color from the theme settings
+++

# **Página web serverless con GitHub Actions, Terraform, Hugo y AWS**

![Portada](/img/Portada.png)

**Tabla de contenidos**

- [**Página web serverless con GitHub Actions, Terraform, Hugo y AWS**](#página-web-serverless-con-github-actions-terraform-hugo-y-aws)
  - [**Descripción**](#descripción)
  - [**Tecnologías que se van a utilizar**](#tecnologías-que-se-van-a-utilizar)
  - [**Resultados que se esperan obtener**](#resultados-que-se-esperan-obtener)
  - [**Precio**](#precio)
  - [**Por qué automatizar el despliegue de una web estática**](#por-qué-automatizar-el-despliegue-de-una-web-estática)
  - [**Tecnologías a utilizar**](#tecnologías-a-utilizar)
    - [**Amazon Web Services (AWS)**](#amazon-web-services-aws)
    - [**Terraform**](#terraform)
    - [**Hugo**](#hugo)
    - [**GitHub Actions**](#github-actions)
  - [**Preparación del entorno**](#preparación-del-entorno)
    - [**Configuración de la MFA**](#configuración-de-la-mfa)
    - [**Creación del usuario de IAM**](#creación-del-usuario-de-iam)
    - [**Creación del certificado SSL**](#creación-del-certificado-ssl)
    - [**Creación del repositorio de GitHub**](#creación-del-repositorio-de-github)
  - [**Terraform**](#terraform-1)
    - [**Creación del bucket de S3 para el estado remoto**](#creación-del-bucket-de-s3-para-el-estado-remoto)
    - [**Configuración de Terraform**](#configuración-de-terraform)
  - [**Hugo**](#hugo-1)
  - [**GitHub**](#github)
    - [**GitHub Actions**](#github-actions-1)

## **Descripción**

El objetivo del proyecto es desplegar una web estática utilizando un flujo de CI/CD de GitHub Actions que automáticamente despliegue la web sobre AWS a partir de los ficheros markdown que subiremos al repositorio.

En concreto, los ficheros estáticos se encontrarán ubicados en un bucket de S3.

Este tipo de configuración se conoce como *serverless* ya que prescindimos completamente de tener una instancia (servidor) ofreciendo el contenido 24 horas al día de forma dedicada.

La infraestructura se gestionará utilizando Terraform.

## **Tecnologías que se van a utilizar**

Amazon Web Services (AWS), Terraform, GitHub Actions, Hugo y AWS CLI.

## **Resultados que se esperan obtener**

La finalidad del proyecto sería contar con una página web y su infraestructura generada y desplegada de forma automática a partir de los ficheros que subamos al repositorio de GitHub.

Cualquier cambio que realicemos en el repositorio se verá reflejado en la web automáticamente.

## **Precio**

El proyecto está enfocado en la posibilidad de poner en funcionamiento una web estática (liviana) a coste cero, por lo que se usarán los tiers gratuitos de AWS ([lista de servicios gratuitos](https://aws.amazon.com/es/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all)).

El único coste a tener en cuenta será el de registrar un dominio, que según el proveedor puede costarnos incluso menos de 2€ al año.

> Podríamos obtener un dominio con Route 53 evitando así salir del ecosistema de AWS, pero suele ser más caro que en otros proveedores (según disponibilidad y ofertas).

## **Por qué automatizar el despliegue de una web estática**

La automatización de tareas es una práctica muy extendida en el mundo de la informática, y en concreto en la filosofía DevOps. Nos permite ahorrar tiempo y esfuerzo, además de reducir la posibilidad de cometer errores.

Por esto, es interesante comenzar a aprender con un proyecto a menor escala como este, que nos permitirá familiarizarnos con las tecnologías que se van a utilizar y servirá de base para proyectos más complejos.

## **Tecnologías a utilizar**

### **Amazon Web Services (AWS)**

[Amazon Web Services](https://aws.amazon.com/es/) es un proveedor de servicios en la nube, ofrece almacenamiento, computación, bases de datos y un largo etcétera en lo referente a cloud computing.

A lo largo de este proyecto se utilizarán los siguientes servicios de AWS:

- **IAM**: [Identity and Access Management](https://aws.amazon.com/es/iam/) es un servicio que nos permite gestionar el acceso a los recursos de AWS de forma segura. Nos permitirá crear un usuario con permisos para gestionar los recursos que se van a crear, evitando, como recomiendan las buenas prácticas, utilizar el usuario root de la cuenta.

- **ACM**: [Amazon Certificate Manager](https://aws.amazon.com/es/certificate-manager/) nos permite gestionar certificados SSL/TLS para nuestros dominios.

- **S3**: [Amazon Simple Storage Service](https://aws.amazon.com/es/s3/) es un servicio de almacenamiento de objetos que ofrece escalabilidad, disponibilidad de datos, seguridad y rendimiento. Lo utilizaré para almacenar los ficheros estáticos de la web.

- **CloudFront**: [Amazon CloudFront](https://aws.amazon.com/es/cloudfront/) es un servicio de CDN (Content Delivery Network) que nos permite distribuir contenido a usuarios de todo el mundo con baja latencia y altas velocidades de transferencia. Será de utilidad para mejorar el rendimiento de la web y reducir el tiempo de carga. Aunque en este proyecto no se notará tanto su impacto debido a la poca cantidad de contenido que se va a servir, es conveniente explorar su funcionamiento para futuros proyectos más complejos.

- **AWS CLI**: [AWS Command Line Interface](https://aws.amazon.com/es/cli/) es una herramienta que nos permite interactuar con los servicios de AWS desde la línea de comandos. Para subir los ficheros estáticos a S3.

> Cabe mencionar que AWS dispone de diferentes ubicaciones (regiones) en las que se pueden desplegar los recursos. Mi infraestructura se ubicará en la región `us-east-1` (Norte de Virginia) ya que es la que ofrece el mayor número de servicios e integraciones.

### **Terraform**

[Terraform](https://www.terraform.io/) es una herramienta de infraestructura como código (IaC) que nos permite crear, modificar y versionar la infraestructura de forma segura y eficiente en diferentes proveedores de servicios en la nube. En este proyecto se utilizará para crear la infraestructura necesaria en AWS.

### **Hugo**

[Hugo](https://gohugo.io/) es un framework generador de sitios web estáticos (*el más rápido del mundo según su propia web*) escrito en Go. Me permitirá generar la web a partir de los ficheros markdown que subiré al repositorio de GitHub.

### **GitHub Actions**

[GitHub Actions](https://github.com/features/actions) es un servicio de integración y entrega continua (CI/CD) que nos permite automatizar tareas. Será el encargado de detectar los cambios que se produzcan en el repositorio y ejecutar los pasos necesarios para generar y desplegar la web en AWS invocando en el proceso a Hugo, Terraform y AWS CLI.

## **Preparación del entorno**

Antes de comenzar con la configuración de la infraestructura, es necesario preparar el entorno de trabajo.

### **Configuración de la MFA**

Es recomendable si no lo hemos hecho aún o si acabamos de crear la cuenta en [AWS](https://aws.amazon.com/es/), la configuración de la autenticación multifactor (MFA), al fin y al cabo, AWS es un servicio que puede llegar a incurrir grandes gastos a nuestra cuenta bancaria por lo que cualquier protección ante robos de credenciales debe ser considerada.

Para ello, accedemos a la consola (web) de AWS y buscamos el servicio IAM. Tras acceder a él, nos aparecerá el aviso de que la cuenta no tiene activado MFA. Seguimos las instrucciones y lo dejamos funcionando.

![AWS-MFA](/img/AWS-MFA.png)

En mi caso, como usuario de Android, tengo y recomiendo la app [Aegis](https://getaegis.app) ya que es de código abierto y me ha funcionado muy bien (además de sus múltiples opciones de configuración que no voy a detallar aquí). Para los usuarios de iOS existe [Raivo OTP](https://raivo-otp.com/) como alternativa.

![AWS-MFA2](/img/AWS-MFA2.png)

Con MFA activado, lo siguiente será crear un usuario alternativo al usuario root de la cuenta de AWS.

### **Creación del usuario de IAM**

Crearemos un usuario con acceso programático. Accedemos como usuario root a la consola (web) de AWS y buscamos el servicio IAM:

![IAM1](/img/IAM1.png)

Navegamos a la sección de usuarios y creamos un usuario:

![IAM2](/img/IAM2.png)

![IAM3](/img/IAM3.png)

Le damos un nombre (*u.ProyectoIntegrado*):

![IAM4](/img/IAM4.png)

En la siguiente pantalla, seleccionamos la opción *Adjuntar políticas directamente* y buscamos la política *AdministratorAccess*:

![IAM5](/img/IAM5.png)

Hacemos click en *Siguiente*, asignamos etiquetas si lo vemos oportuno, revisamos que todo esté correcto y creamos el usuario:

![IAM6](/img/IAM6.png)

Con el usuario creado, debemos generar unas credenciales de acceso. Para ello, hacemos click en el usuario:

![IAM7](/img/IAM7.png)

Y seleccionamos *Credenciales de seguridad*:

![IAM8](/img/IAM8.png)

Bajamos hasta la sección *Claves de acceso* y elegimos *Crear clave de acceso*:

![IAM9](/img/IAM9.png)

Seleccionamos el caso de uso:

![IAM10](/img/IAM10.png)

En la siguiente pantalla podremos asignar una descripción a la clave si lo vemos necesario. Tras hacerlo habremos terminado de crear la clave:

![IAM11](/img/IAM11.png)

> **IMPORTANTE**: En este punto se nos mostrará la clave de acceso y la clave secreta. Debemos guardarlas en un lugar seguro ya que no volveremos a tener acceso a la clave secreta.

### **Creación del certificado SSL**

Para poder utilizar HTTPS en nuestra web, necesitamos un certificado SSL. Para conseguir uno de forma gratuita y sencilla, usaré AWS Certificate Manager (ACM).

Accedemos a la consola (web) de AWS y buscamos el servicio ACM:

![ACM1](/img/ACM1.png)

Seleccionamos *Solicitar un certificado* y elegimos que sea de tipo *Público*:

![ACM2](/img/ACM2.png)

![ACM3](/img/ACM3.png)

En la siguiente pantalla introducimos nuestro dominio (en mi caso *juanje.eu* y *www.juanje.eu*), el resto de opciones podemos dejarlas por defecto (Validación DNS y RSA 2048):

![ACM4](/img/ACM4.png)

Al acabar, veremos el certificado y un aviso de que está pendiente de validación:

![ACM5](/img/ACM5.png)

Para validarlo, debemos crear un registro DNS, los datos a usar podremos verlos si abrimos el certificado:

![ACM6](/img/ACM6.png)

Copiamos los datos y accedemos a nuestro proveedor de dominio, agregamos los registros DNS correspondientes y esperamos a que se validen:

![ACM7](/img/ACM7.png)

Después de unos minutos (el tiempo de espera puede variar), el certificado estará validado:

![ACM8](/img/ACM8.png)

Ahora que ya tenemos nuestro certificado SSL, podemos pasar a crear el repositorio para subir todo el código que a continuación vamos a crear.

### **Creación del repositorio de GitHub**

Para la gestión del código, usaré Git y GitHub. Primero creo un repositorio en GitHub llamado `Proyecto-Integrado-ASIR`:

![GitHub1](/img/GitHub1.png)

A continuación creo una carpeta local, en la que iré guardando todo el código que vaya creando, y la conecto a mi repositorio remoto:

```bash
mkdir Proyecto-Integrado-ASIR

cd Proyecto-Integrado-ASIR

echo "# Proyecto-Integrado-ASIR" >> README.md

git init

git add README.md

git commit -m "first commit"

git branch -M main

git remote add origin https://github.com/JuanJesusAlejoSillero/Proyecto-Integrado-ASIR.git

git push -u origin main
```

Con esto ya tendremos nuestro repositorio creado y conectado a nuestra carpeta local, listo para almacenar código.

## **Terraform**

Para la configuración de la infraestructura, usaré Terraform, una herramienta de código abierto desarrollada por HashiCorp que nos permite crear, modificar y versionar la infraestructura de forma sencilla (**declarativa**).

Los archivos de configuración de Terraform se escriben con el lenguaje HCL (HashiCorp Configuration Language).

Su funcionamiento se divide en 3 fases que funcionan de la siguiente manera:

- **terraform init**: Inicializa el proyecto, descargando los plugins necesarios para los proveedores que hayamos declarado en su configuración (en nuestro caso, AWS).

  ![Terraform-init](/img/Terraform-init.png)

- **terraform plan**: Muestra los cambios que se van a realizar en base a los archivos de configuración que hayamos escrito.

  ![Terraform-plan](/img/Terraform-plan.png)

- **terraform apply**: Aplica los cambios que se han mostrado en la fase anterior.

  ![Terraform-apply](/img/Terraform-apply.png)

Cada objeto gestionado por Terraform es conocido como un recurso, estos pueden ser una instancia, una base de datos, un certificado, etc.

El ciclo de vida de los recursos se gestiona de forma completa, es decir, desde que se crean hasta que se destruyen. Terraform será el encargado de crear, modificar y eliminar los recursos que hayamos definido en los archivos de configuración.

Si algún recurso es modificado de forma paralela mediante la consola web de AWS u otra herramienta, al ejecutar después un `terraform apply`, Terraform se encargará de volver a dejar el recurso en el estado que nosotros le definimos en los archivos de configuración, revirtiendo los cambios que se hayan realizado.

Terraform guarda los cambios de estado de la infraestructura en un archivo de estado. Este archivo se puede almacenar de forma local o en un backend remoto.

Debido a la naturaleza de este proyecto, el archivo de estado se almacenará en un bucket de S3 (backend remoto), por lo que debemos crearlo antes de empezar con la configuración de Terraform.

### **Creación del bucket de S3 para el estado remoto**

Accedemos a la consola (web) de AWS y buscamos el servicio S3:

![S3](/img/S3.png)

Creamos un bucket:

![S32](/img/S32.png)

Le damos un nombre que debe ser único (`juanje-terraform-state`) y seleccionamos la región en la que queremos que se cree el bucket (`us-east-1`), no necesitaremos tocar las demás opciones por defecto:

![S33](/img/S33.png)

![S34](/img/S34.png)

Con el bucket para el estado remoto creado, podemos pasar a la configuración de Terraform.

### **Configuración de Terraform**

Para configurar Terraform, en el repositorio que creamos anteriormente, crearé una carpeta llamada *Terraform*. Ahora tenemos dos opciones, crear un archivo de configuración para cada recurso o crear un archivo de configuración general para todos los recursos. Por facilitar la organización, usaré la primera opción, de este modo, crearé los siguientes archivos (sus nombres no son importantes, pero la extensión y contenido sí):

- **remote-state.tf**: Archivo de configuración del estado remoto.

- **provider.tf**: Archivo con la configuración de los providers de Terraform. Un provider es un plugin que nos permite interactuar con un proveedor de infraestructura (en nuestro caso, AWS).

- **variables.tf**: Archivo con las variables que usaremos en los archivos de configuración de los recursos.

- **bucket-s3.tf**: Archivo de configuración del bucket de S3.

- **cloudfront.tf**: Archivo de configuración para la distribución de CloudFront.

El primer archivo a crear será el de estado remoto:

```terraform
/*
  remote-state.tf
  Archivo de configuración de remote state para el proyecto con Terraform + AWS
*/

terraform {
  backend "s3" {
    bucket = "juanje-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
```

Primero, indicamos que el backend que usaremos será S3 y le pasamos el nombre del bucket que creamos anteriormente para este propósito, el nombre del archivo de estado (podemos pasarle una ruta también como `estado/fichero.tfstate`) y la región en la que se encuentra el bucket, es bastante sencillo.

Contenido del *provider.tf*:

```terraform
/*
  providers.tf
  Archivo de providers para el proyecto con Terraform + AWS
*/

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
```

En este archivo, indicamos que requerimos el provider de AWS (`hashicorp/aws`) con una versión igual o superior a la 5.0.0 (pero permitiendo solo cambios de versión menores para evitar problemas de compatibilidad futuros) y le pasamos la región que usaremos, que será una variable que definiremos en el archivo *variables.tf*.

El archivo *variables.tf*:

```terraform
/*
  variables.tf
  Archivo de variables para el proyecto con Terraform + AWS

  Variables en uso en los ficheros:
    - providers.tf
    - bucket-s3.tf
    - cloudfront.tf
*/

variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "domain" {
  type = string
  default = "www.juanje.eu"
}

variable "aws_arn_certificado" {
  type = string
  default = "arn:aws:acm:us-east-1:540012000352:certificate/958c20ac-8c69-4809-adfc-c75812e3587f"
}
```

Aquí, definimos la región de AWS que usaremos, dándole el valor por defecto de `us-east-1` (Norte de Virginia), el dominio de nuestra web, que lo usaremos para dar nombre al bucket de S3 que tendrá los ficheros estáticos y el ARN (Amazon Resource Name) del certificado SSL que creamos anteriormente.

El archivo *bucket-s3.tf*:

```terraform
/*
  bucket-s3.tf
  Archivo de configuración del bucket de S3 que tendrá los ficheros de la web estática para el proyecto con Terraform + AWS
*/

// Creación del bucket de S3 con el nombre de la variable "domain":
resource "aws_s3_bucket" "bucket-s3" {
  bucket = var.domain
  force_destroy = true
}

// Configuración para habilitar el almacenamiento de sitios web estáticos en el bucket de S3:
resource "aws_s3_bucket_website_configuration" "bucket-s3-static" {
  bucket = aws_s3_bucket.bucket-s3.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "404.html"
  }
}

// Configuraciones para habilitar el acceso público al bucket de S3:
resource "aws_s3_bucket_public_access_block" "bucket-s3-public" {
  bucket = aws_s3_bucket.bucket-s3.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket-s3-policy" {
  bucket = aws_s3_bucket.bucket-s3.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "PublicReadGetObject"
        Effect = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject"
        ]
        Resource = [
          "${aws_s3_bucket.bucket-s3.arn}/*"
        ]
      }
    ]
  })
}
```

Este es un poco más denso que los anteriores, pero no es muy complicado:

1. Primero, creamos el bucket de S3 con el nombre de la variable `domain` y le indicamos que se destruya forzosamente si se elimina el recurso, en caso de no hacerlo, no se podría eliminar el bucket si tiene contenido.

2. Luego, configuramos el bucket para que pueda almacenar sitios web estáticos, indicándole el nombre del bucket y el nombre de los ficheros que serán la página principal y la página de error.

3. Por último, configuramos el bucket para que sea público y le añadimos una política para que se puedan leer los ficheros.

El último archivo, *cloudfront.tf*:

```terraform
/*
  cloudfront.tf
  Archivo de configuración de la distribución de CloudFront para el proyecto con Terraform + AWS
*/

// Política de caché para la distribución de CloudFront:
data "aws_cloudfront_cache_policy" "Managed-CachingOptimized" {
  id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
}

// Creación de la distribución de CloudFront:
resource "aws_cloudfront_distribution" "cloudfront" {
  enabled             = true
  is_ipv6_enabled     = false
  aliases = [var.domain]
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket_website_configuration.bucket-s3-static.website_endpoint
    origin_id   = aws_s3_bucket_website_configuration.bucket-s3-static.website_endpoint
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket_website_configuration.bucket-s3-static.website_endpoint
    cache_policy_id = data.aws_cloudfront_cache_policy.Managed-CachingOptimized.id
  }

  price_class = "PriceClass_100"

  viewer_certificate {
    acm_certificate_arn = var.aws_arn_certificado
    ssl_support_method  = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}
```

En su sintaxis se especifica que:

1. Definimos la política de caché que usaremos mediante su ID, es la que recomiend AWS para webs estáticas.

2. Después, creamos la distribución de CloudFront, indicándole que esté habilitada, que no use IPv6, que el nombre del dominio es el de la variable `domain` y que el fichero por defecto es el `index.html`.

3. En la segunda mitad, indicamos que el origen de la distribución será el bucket de S3 que definimos anteriormente, que puede comprimir los ficheros, redireccionar todas las conexiones HTTP a HTTPS, la clase de precio (ubicaciones geográficas del CDN de CloudFront), el certificado SSL que usará y que no imponga restricciones geográficas.

Y con estos 5 archivos quedaría toda nuestra infraestructura definida:

![Terraform-Files](/img/Terraform-Files.png)

Los subimos a GitHub:

```bash
git add .

git commit -m "Archivos Terraform"

git push
```

![Terraform-Files-GitHub](/img/Terraform-Files-GitHub.png)

## **Hugo**

Para crear la web estática, usaré Hugo (extended). En Ubuntu 22.04 lo he instalado de la siguiente forma ([instrucciones para otros sistemas operativos](https://gohugo.io/installation/)):

```bash
sudo apt update

sudo apt install hugo
```

Creamos la carpeta del sitio nuevo:

```bash
hugo new site "Blog de Juanje"

cd "Blog de Juanje"
```

Instalamos el tema que queramos, en mi caso, [terminal](https://themes.gohugo.io/hugo-theme-terminal/):

```bash
git init

git submodule add -f https://github.com/panr/hugo-theme-terminal.git themes/terminal
```

Para configurarlo, edito el fichero `config.toml` con el contenido que aparece en la [documentación](https://themes.gohugo.io/themes/hugo-theme-terminal/#how-to-configure) y lo dejo a mi gusto.

> **IMPORTANTE**: Para evitar fallos, como se menciona en [esta issue de GitHub](https://github.com/gohugoio/hugo/issues/8587#issuecomment-851018525), debemos eliminar el parámetro `baseURL` del fichero `config.toml`. En mi caso, si lo tenía, no funcionaba correctamente la web tras subirla a AWS.

Para crear una nueva entrada, ejecutamos:

```bash
hugo new posts/mi-entrada.md
```

Tras redactarla, podemos ver el resultado con:

```bash
hugo server -D
```

Y accediendo a la dirección que nos indique (normalmente [http://localhost:1313/](http://localhost:1313/)).

![Hugo-Server](/img/Hugo-Server.png)

Tras confirmar que funciona correctamente, eliminamos la carpeta `resources` que se ha creado al ejecutar el comando anterior:

```bash
rm -rf resources
```

Quedaría así:

![Hugo-Files](/img/Hugo-Files.png)

Y subimos el contenido a GitHub:

```bash
git add .

git commit -m "Archivos Hugo"

git push
```

![Hugo-Files-GitHub](/img/Hugo-Files-GitHub.png)

## **GitHub**

### **GitHub Actions**

Para automatizar el proceso de creación de la web estática y su subida a S3, usaré un *workflow* de GitHub Actions. Los *workflows* son archivos de configuración escritos en YAML que permiten automatizar procesos en GitHub. En mi caso, crearé uno que se ejecute cada vez que se haga un *push* a los directorios que contienen los archivos de Terraform o de Hugo.

El archivo se llamará `workflow.yaml` y estará en la carpeta `.github/workflows`:

```bash
mkdir -p .github/workflows

touch .github/workflows/workflow.yaml
```

El contenido del archivo será el siguiente:

```yaml
#
# hugo-deploy.yaml
# Archivo de configuración de GitHub Actions para:
# 1. Verificar y desplegar la infraestructura con Terraform cuando se haga push a alguno de los directorios "Terraform" o "Blog de Juanje"
# 2. Construir el sitio web con Hugo y desplegarlo en S3 cuando se haga push al directorio "Blog de Juanje"
#

name: "Workflow"

on:
  push:
    branches:
      - main
    paths:
      - "Terraform/**"
      - "Blog de Juanje/**"

env:
  AWS_REGION: "us-east-1"
  AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
  AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}

jobs:
  terraform:
    name: "Terraform"
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: "Terraform"
    steps:
      - name: "Clonar repositorio"
        uses: actions/checkout@v3
      - name: "Setup Terraform"
        uses: hashicorp/setup-terraform@v2.0.3
      - name: "Terraform Init"
        timeout-minutes: 2
        run: terraform init -input=false
      - name: "Terraform Apply"
        run: terraform apply -auto-approve
  hugo-deploy:
    needs: terraform
    name: "Hugo + Deploy"
    runs-on: ubuntu-latest
    steps:
      - name: "Clonar repositorio incluyendo submódulos (para el tema)"
        uses: actions/checkout@v3
        with:
          submodules: recursive
      - name: "Configurar credenciales AWS CLI"
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: ${{ env.AWS_REGION }}
      - name: "Setup Hugo"
        uses: peaceiris/actions-hugo@v2.6.0
        with:
          hugo-version: "latest"
          extended: true
      - name: "Build"
        run: |
          cd "Blog de Juanje"
          hugo --minify
      - name: "Deploy to S3"
        run: |
          cd "Blog de Juanje/public"
          aws s3 sync \
            --delete \
            . s3://www.juanje.eu
      - name: "CloudFront Invalidation"
        run: |
          aws cloudfront create-invalidation \
            --distribution-id ${{ secrets.CLOUDFRONT_DISTRIBUTION_ID }} \
            --paths "/" \
            "/index.html" \
            "/posts/" \
            "/posts/index.html" \
            "/tags/" \
            "/tags/index.html"
```

Es un archivo bastante sencillo de comprender, pero voy a detallar algunas partes:

1. Primero se indica el nombre del *workflow* y cuándo se ejecutará. En este caso, se ejecutará cuando se haga un *push* a la rama `main` y se modifique algún archivo de los directorios `Terraform` o `Blog de Juanje`.

2. A continuación, se definen las variables de entorno que se usarán en el *workflow*. En este caso, las credenciales de AWS y la región.

3. Después, se definen los *jobs* que se ejecutarán. En este caso, dos:

   - `terraform`: Se ejecutará en una máquina virtual de Ubuntu y se encargará de verificar y desplegar la infraestructura con Terraform si hiciera falta. Para ello, primero se clonará el repositorio, se instalará Terraform, se inicializará y se aplicará el plan.

   - `hugo-deploy`: Se ejecutará en una máquina virtual de Ubuntu y se encargará de construir el sitio web con Hugo y desplegarlo en S3, pero solo se ejecutará si el *job* de *terraform* termina satisfactoriamente, evitando así intentar subir los ficheros de la web si la infraestructura no está lista. Para ello, primero se clonará el repositorio incluyendo el submódulo del tema, se configurarán las credenciales de AWS CLI, se instalará Hugo, se crearán los archivos de la web y se sincronizarán con nuestro bucket de S3, además, se invalidará la caché de CloudFront (en aquellos archivos que es necesario) para tener los cambios disponibles de forma inmediata.

---

✒️ **Documentación realizada por Juan Jesús Alejo Sillero.**
