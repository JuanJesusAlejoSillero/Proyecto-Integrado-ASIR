+++
title = "Post 24 - Taller 2"
date = "2023-05-18T11:26:04+02:00"
author = "Juanje"
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

# **Taller 2**

- [**Taller 2**](#taller-2)
  - [**Introducción a Markdown (IAW)**](#introducción-a-markdown-iaw)
    - [**Subapartado 1**](#subapartado-1)
    - [**Subapartado 2**](#subapartado-2)
    - [**Subapartado 3**](#subapartado-3)
    - [**Subapartado 4**](#subapartado-4)
    - [**Subapartado 5**](#subapartado-5)

## **Introducción a Markdown (IAW)**

### **Subapartado 1**

En markdown, el formato del texto se indica colocando ciertos caracteres al inicio y final del texto a formatear. Las palabras en negrita se escriben usando un doble asterisco como por ejemplo **así**. Si en cambio queremos que las palabras estén en cursiva, usamos un solo asterisco *de esta forma*. Si queremos que las palabras estén en negrita y cursiva al mismo tiempo, usamos tres asteriscos ***de este modo***. Y si queremos que las palabras estén tachadas, usaremos dos virgulillas ~~como aquí~~. Otra opción muy útil para los estudiantes del CFGS de ASIR es la de escribir texto como código para poder resaltar fácilmente los `comandos` que se usan en la terminal, en este caso se usa el acento grave.

Además, podemos colocar bloques de código completos usando tres acentos graves al inicio y al final del bloque de código. Por ejemplo:

```
apt install apache2
```

### **Subapartado 2**

Como extra no pedido en la práctica, es interesante resaltar que muchos editores de texto e IDEs son capaces de colorear el código de forma automática, facilitando mucho su legibilidad. Para ello, basta con añadir el nombre del lenguaje de programación al inicio del bloque de código, justo después de los tres acentos graves iniciales. Por ejemplo:

```python
#!/usr/bin/env python3
print("Hola mundo")
```

```bash
#!/bin/bash
echo "Hola mundo"
```

### **Subapartado 3**

También podemos crear listas ordenadas. Tan sencillo como escribir un número seguido de un punto y un espacio:

1. Primer elemento
2. Segundo elemento
3. Tercer elemento

De igual forma, podemos crear listas desordenadas usando asteriscos, guiones o signos de suma:

- Un elemento
- Otro elemento
- Otro más
- Y otro más

E incluso listas anidadas usando tabulaciones:

1. Primer elemento
    - Primer elemento anidado
    - Segundo elemento anidado
      - Primer elemento doblemente anidado

### **Subapartado 4**

También se pueden agregar [links](https://i.redd.it/t02zf6xyg2q41.jpg) a páginas web, para conseguirlo se escribe el texto que queremos que tenga el link entre corchetes seguido de la URL entre paréntesis, el ejemplo anterior está hecho así: `[links](https://i.redd.it/t02zf6xyg2q41.jpg)`.

Igualmente, podemos crear [links a otros archivos](./extra.md) dentro del mismo repositorio, la sintaxis es la misma pero en lugar de la URL se escribe la ruta al archivo entre paréntesis, el ejemplo anterior está hecho así: `[links a otros archivos](./extra.md)`.

Como era de esperar, también podemos incrustar imágenes. Para ello, se usa la misma sintaxis que para los links, pero con un signo de exclamación al inicio:

![Dilbert](https://assets.amuniversal.com/a8db0ae06cba01301d46001dd8b71c47)

![iesgn](/img/iesgn.jpg)

```
![Dilbert](https://assets.amuniversal.com/a8db0ae06cba01301d46001dd8b71c47)

![iesgn](/img/iesgn.jpg)
```

### **Subapartado 5**

Para finalizar esta introducción a Markdown, es importante recordar que también se pueden crear tablas:

| Columna 1 | Columna 2 | Columna 3 |
|-----------|-----------|-----------|
| Celda 1   | Celda 2   | Celda 3   |
| Celda 4   | Celda 5   | Celda 6   |
| Celda 7   | Celda 8   | Celda 9   |

Para crear la tabla anterior, se ha usado la siguiente sintaxis:

```
| Columna 1 | Columna 2 | Columna 3 |
|-----------|-----------|-----------|
| Celda 1   | Celda 2   | Celda 3   |
| Celda 4   | Celda 5   | Celda 6   |
| Celda 7   | Celda 8   | Celda 9   |
```

Esto sería todo en este taller de introducción al lenguaje de marcado Markdown.

---

✒️ **Documentación realizada por Juan Jesús Alejo Sillero.**
