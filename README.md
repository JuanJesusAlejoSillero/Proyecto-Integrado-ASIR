# **Proyecto Integrado**

<p align="center">
  <img src="img/Portada.png" alt="Portada" />
</p>

**Tabla de contenidos**

- [**Proyecto Integrado**](#proyecto-integrado)
  - [**Información del proyecto**](#información-del-proyecto)
    - [**Título**](#título)
    - [**Descripción**](#descripción)
    - [**Tecnologías que se van a utilizar**](#tecnologías-que-se-van-a-utilizar)
    - [**Resultados que se esperan obtener**](#resultados-que-se-esperan-obtener)
    - [**Precio**](#precio)
  - [**Memoria descriptiva**](#memoria-descriptiva)

## **Información del proyecto**

### **Título**

Página web serverless con GitHub Actions, Terraform, Hugo y AWS.

### **Descripción**

El objetivo del proyecto es desplegar una web estática utilizando un flujo de CI/CD de GitHub Actions que automáticamente despliegue la web sobre AWS a partir de los ficheros markdown que subiremos al repositorio.

En concreto, los ficheros estáticos se encontrarán ubicados en un bucket de S3.

Este tipo de configuración se conoce como *serverless* ya que prescindimos completamente de tener una instancia/máquina sirviendo el contenido 24 horas al día de forma dedicada.

La infraestructura se gestionará utilizando Terraform.

### **Tecnologías que se van a utilizar**

Amazon Web Services (AWS), Terraform, GitHub Actions, generador de páginas web estáticas a partir de ficheros markdown (Hugo).

### **Resultados que se esperan obtener**

La finalidad del proyecto sería contar con una página web y su infraestructura generada y desplegada de forma automática a partir de los ficheros que subamos al repositorio de GitHub.

Cualquier cambio que realicemos en el repositorio se verá reflejado en la web automáticamente.

### **Precio**

El proyecto está enfocado en la posibilidad de poner en funcionamiento una web estática (liviana) a coste cero, por lo que se usarán los tiers gratuitos de AWS ([lista de servicios gratuitos](https://aws.amazon.com/es/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all)).

El único coste a tener en cuenta será el de registrar un dominio, que según el proveedor puede costarnos incluso menos de 2€ al año.

## **Memoria descriptiva**

La memoria puede ser consultada en el siguiente enlace: [www.juanje.eu](https://www.juanje.eu)

---

✒️ **Documentación realizada por Juan Jesús Alejo Sillero.**
