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
    - [**Configuración de la autenticación multifactor (MFA)**](#configuración-de-la-autenticación-multifactor-mfa)
    - [**Creación del usuario de IAM**](#creación-del-usuario-de-iam)
    - [**Creación del certificado SSL**](#creación-del-certificado-ssl)
  - [**Terraform**](#terraform-1)
    - [**Creación del bucket de S3 para el estado remoto**](#creación-del-bucket-de-s3-para-el-estado-remoto)

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

Amazon Web Services es un proveedor de servicios en la nube, ofrece almacenamiento, computación, bases de datos y un largo etcétera en lo referente a cloud computing.

A lo largo de este proyecto se utilizarán los siguientes servicios de AWS:

- **IAM**: Identity and Access Management es un servicio que nos permite gestionar el acceso a los recursos de AWS de forma segura. Nos permitirá crear un usuario con permisos para gestionar los recursos que se van a crear, evitando, como recomiendan las buenas prácticas, utilizar el usuario root de la cuenta.

- **ACM**: Amazon Certificate Manager nos permite gestionar certificados SSL/TLS para nuestros dominios.

- **S3**: Amazon Simple Storage Service es un servicio de almacenamiento de objetos que ofrece escalabilidad, disponibilidad de datos, seguridad y rendimiento. Lo utilizaré para almacenar los ficheros estáticos de la web.

- **CloudFront**: Amazon CloudFront es un servicio de CDN (Content Delivery Network) que nos permite distribuir contenido a usuarios de todo el mundo con baja latencia y altas velocidades de transferencia. Será de utilidad para mejorar el rendimiento de la web y reducir el tiempo de carga. Aunque en este proyecto no se notará tanto su impacto debido a la poca cantidad de contenido que se va a servir, es conveniente explorar su funcionamiento para futuros proyectos más complejos.

- **AWS CLI**: AWS Command Line Interface es una herramienta que nos permite interactuar con los servicios de AWS desde la línea de comandos. Para subir los ficheros estáticos a S3.

> Cabe mencionar que AWS dispone de diferentes ubicaciones (regiones) en las que se pueden desplegar los recursos. Mi infraestructura se ubicará en la región `us-east-1` (Norte de Virginia) ya que es la que ofrece el mayor número de servicios e integraciones.

### **Terraform**

Terraform es una herramienta de infraestructura como código (IaC) que nos permite crear, modificar y versionar la infraestructura de forma segura y eficiente en diferentes proveedores de servicios en la nube. En este proyecto se utilizará para crear la infraestructura necesaria en AWS.

### **Hugo**

Hugo es un generador de sitios web estáticos. Me permitirá generar la web a partir de los ficheros markdown que subiré al repositorio de GitHub.

### **GitHub Actions**

GitHub Actions es un servicio de integración y entrega continua (CI/CD) que nos permite automatizar tareas. Será el encargado de detectar los cambios que se produzcan en el repositorio y ejecutar los pasos necesarios para generar y desplegar la web en AWS invocando en el proceso a Hugo, Terraform y AWS CLI.

## **Preparación del entorno**

Antes de comenzar con la configuración de la infraestructura, es necesario preparar el entorno de trabajo.

### **Configuración de la autenticación multifactor (MFA)**

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

Ahora que ya tenemos nuestro certificado SSL, podemos pasar a la configuración de la infraestructura.

## **Terraform**

Para la configuración de la infraestructura, usaré Terraform, una herramienta de código abierto desarrollada por HashiCorp que nos permite crear, modificar y versionar la infraestructura de forma sencilla (**declarativa**).

Para escribir los archivos de configuración de Terraform lo haremos con el lenguaje HCL (HashiCorp Configuration Language).

Terraform tiene 3 fases que funcionan de la siguiente manera:

- **terraform init**: Inicializa el proyecto, descargando los plugins necesarios para el proveedor que vayamos a usar (en nuestro caso, AWS).

- **terraform plan**: Muestra los cambios que se van a realizar en base a los archivos de configuración que hayamos escrito.

- **terraform apply**: Aplica los cambios que se han mostrado en la fase anterior.

Cada objeto gestionado por Terraform es conocido como un recurso, estos pueden ser una instancia, una base de datos, un certificado, etc.

El ciclo de vida de los recursos se gestiona de forma completa, es decir, desde que se crean hasta que se destruyen. Terraform será el encargado de crear, modificar y eliminar los recursos que hayamos definido en los archivos de configuración, si algún recurso es modificado de forma paralela mediante la consola web de AWS u otra herramienta, si ejecutamos un `terraform apply`, Terraform se encargará de volver a dejar el recurso en el estado que nosotros le definimos en los archivos de configuración.

Terraform guarda los cambios de estado de la infraestructura en un archivo de estado. Este archivo se puede almacenar de forma local o en un backend remoto.

Debido a la naturaleza de este proyecto, el archivo de estado se almacenará en un bucket de S3, por lo que debemos crearlo antes de empezar con la configuración de Terraform.

### **Creación del bucket de S3 para el estado remoto**

Accedemos a la consola (web) de AWS y buscamos el servicio S3:

![S3](/img/S3.png)

Creamos un bucket:

![S32](/img/S32.png)

Le damos un nombre que debe ser único (`juanje-terraform-state`) y seleccionamos la región en la que queremos que se cree el bucket (`us-east-1`), no necesitaremos tocar las demás opciones por defecto:

![S33](/img/S33.png)

![S34](/img/S34.png)

Con el bucket para el estado remoto creado, podemos pasar a la configuración de Terraform.

---

✒️ **Documentación realizada por Juan Jesús Alejo Sillero.**
