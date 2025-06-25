[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/8vzrTwB2)
# La Matriz

Nuveo escapó gracias a la ayuda de Morfero, Trinica y el resto de la tripulación del Nabucodonosor.
Pero, lamentablemente, no puede permanecer fuera de La Matriz, ya que tiene distintas obligaciones junto a la tripulación.
Zino, la ciudad que es el último bastión de la humanidad, necesita un sistema para poder manejar mejor el uso de los Hovercraft (naves que flotan).

## Aclaraciones sobre el parcial
- El parcial es **individual** y se entrega **pusheando a este repositorio** como en las entregas anteriores. Recomendamos _ir 
pusheando cada cierto tiempo_ para evitar inconvenientes; lo ideal es después de cada punto resuelto.
- No se tendrán en cuenta los commits realizados después de la hora de finalización del examen.
- Una vez hecho el _push_ final, **verifiquen en github.com** que haya quedado la versión final. 
Nosotros corregiremos lo que está en GitHub; si ustedes lo pueden ver ahí, entonces nosotros también.
- No olviden los **conceptos aprendidos**: polimorfismo, delegación, buenas abstracciones, no repetir lógica, guardar vs. calcular, 
lanzar excepciones cuando un método no puede cumplir con su responsabilidad, etc. Eso es lo que se está evaluando.
- La solución del examen consiste en la **implementación de un programa** que resuelva los requerimientos pedidos y sus **tests automatizados**.
- Este enunciado viene acompañado de un archivo `.wtest` que tiene diseñados los tests a realizar. Es importante aclarar que:
  - Estos tests se proponen para facilitar el desarrollo. Se pueden diseñar otros si así se considera necesario.
  - El conjunto de tests propuesto es suficiente para este ejercicio. No hace falta agregar nuevos, pero tampoco se prohíbe hacerlo.
  - Todos los objetos allí usados se asumen como instancias de una clase. Si el diseño de la solución utiliza objetos bien conocidos, 
entonces se debe remover la declaración de la variable y la línea en que se sugiere la instanciación.
  - Según el diseño de la solución, es probable que se requiera agregar más objetos a los sugeridos en los tests.
  - Los tests están comentados para _incorporarlos a medida que se avanza_ con la solución del ejercicio.



## 1. Los Tripulantes y su alimentación

De los tripulantes se conoce su **peso** e interesa saber cuántas calorías diarias deben consumir:

- Los tripulantes **nativos** de la ciudad de Zino consumen 25 calorías por cada kilo de peso: `peso * 25`.
- Aquellos tripulantes que fueron **liberados** consumen como máximo 3000 calorías. A ese valor base se le multiplica un factor de desarraigo entre 0 y 1. Los recién liberados (tienen un nivel de desarraigo alto) comerán más debido a su estado de ánimo. Un desarraigo bajo significa que están más acostumbrados y comerán menos. El desarraigo se indica para cada tripulante liberado. La fórmula de consumo diarios de calorías es: `3000 * desarraigo`.
* Los **cambiantes** son tripulantes liberados que utilizan como valor base 2000.  Además comen siempre 500 calorías extras: `2000 * desarraigo + 500`.
* Un **elegido** consume 30 calorías si pesa menos de 70 kg, y 50 si no.

Cada vez que un tripulante come, su peso aumenta en la cantidad de calorías consumidas dividida entre 10000: `calorías/10000`. El elegido, en cambio, aumenta su peso dividiendo las calorías por 50000: `calorías/50000`. 

Además, los liberados (incluyendo los cambiantes) disminuyen su arraigo en 0.01, pero nunca por debajo de 0.2: `(desarraigo - 0.01) ó 0.2`.

### Requerimientos
- Saber las calorías diarias que consume un tripulante.
- Que un tripulante consuma sus calorías diarias.

### Escenario de prueba:

Tripulantes:
  - **Tanque** es un tripulante nativo de peso 100
  - **Morfero** es un tripulante liberado de peso 90 y 0.5 de desarraigo
  - **Trinica** es una tripulente cambiante de peso 55 y 0.6 de desarraigo 
  - **Nuveo** es un Elegido de peso 80

Verificaciones:
 - Las calorías diarias que consume **Tanque** son **2500** : `100 * 25` y al comer queda con **100.25** de peso: `100 + 2500 / 100000`
 - Las calorías diarias que consume **Morfero** son **1500** : `3000 * 0.5` y al comer queda con **90.15** de peso: `90 + 1500 / 100000` y 0.49 de desarraigo `0.5 - 0.01`
 - Las calorías diarias que consume **Trinica** son **1700** : `2000 * 0.6 + 500` y al comer queda con **55.17** de peso: `55 + 1700 / 100000` y 0.59 de desarraigo `0.6 - 0.01`
 - Las calorías diarias que consume **Nuveo** son **50** : `80 >= 70` y al comer queda con **80.001** de peso: `80 + 50 / 50000`

## 2 Los Hovercraft    

### 2.1 Alimentación

Los Hovercraft son naves mediante las cuales se mueve la resistencia fuera de **Zino**.

En las naves hay una cantidad de proteína sintética con aminoácidos esenciales (medida en calorías).
Esta cantidad debe ser suficiente para toda la tripulación cada vez que deban cenar (comen una vez al día).
Cuando cenan, lo hacen todos en grupo, y los aminoácidos de la nave disminuyen en la cantidad consumida por todos los tripulantes (es decir, la sumatoria de las calorías diarias de la tripulación). 
¡Cuidado! Si la comida no alcanza, entonces no se puede cenar.

#### Requerimiento
- Alimentar a la tripulación de un Hovercraft.
- Abastecer con más reservas de proteinas al Hovercraft.

#### Caso de ejemplo:

**Nabucodonosor** (o **nabu** para los amigos ), es un Hovercraft cuya tripulación tiene a **Tanque**, **Morfero** y **Trinica**. 
Tiene una reserva de **10000** calorías en proteínas. Por lo tanto solo puede dar de comer una única vez a la tripulación,
luego de la cual la cantidad de reservas queda en **4300** ya que se debería restar 4700:`2500 + 1500 + 1700.` 

**Nota**: Los efectos de los tripulantes son los mismos que los mencionados en el ejemplo del **punto 1**. 

## Conexión en los Hovercraft
Los tripulantes pueden conectarse a _La Matriz_ desde el Hovercraft.

- Solo los miembros de la tripulación se pueden conectar desde un Hovercraft.
- No puede conectarse un tripulante ya conectado, ni desconectarse uno que no esté conectado.
- Para que un tripulante se pueda conectar, debe haber al menos otro tripulante no conectado a bordo de la nave, ya que alguien debe quedar para manejarla. 
- un tripulante **cambiante** necesita además tener un nivel de arraigo menor a 0.5.

**Tip**: Para saber si hay otro tripulante desconectado podés verificar que haya al menos dos desconectados entre todos los tripulantes, o también analizando que haya algún tripulante desconectado distinto del que se desea conectar.

**Nota**: Se puede asumir que un tripulante nunca está en más de un Hovercraft a la vez. 

### Requerimientos 

- Que un tripulante se conecte a _La Matriz_ desde un Hovercraft.
- Que un tripulante se desconecte de _La Matriz_ desde un Hovercraft.
- Saber si un tripulante de un Hovercraft está conectado o no.
- Saber todos los tripulantes conectados de un Hovercraft.

#### Caso de ejemplo:

Además de **Nabucodonosor** usada en el punto anterior, vamos a tener un segundo Hovercraft llamado **Logo**. 
Tiene como tripulantes a **Nuveo** y a un nuevo tripulante nativo llamado **Dosis**, de 82 de peso.
Las reservas de proteinas de **Logo** están en 0.

Probar que la siguiente secuencia:

- **Nuveo** se conecta sin problemas en **Logo**
- Si intenta volver a conectarse no podría hacerlo.
- **Tanque** no podría conectarse en **Logo** porque no es tripulante de esa nave.
- **Dosis** no podría conectarse en **Logo**, ya que no quedaría nadie desconectado para manejar la nave (nuveo estaba conectado).
- Si **Dosis** intenta desconectarse en **Logo** no podría, ya que nunca estuvo conectado.
- **Trinica** no podría conectarse en Nabucodonosor por su nivel de desarraigo.
- Si cambiamos el nivel de desarraigo de **Trinica** a 0.3, entonces sí va a conectar sin problemas en **Nabucodonosor**.
- **Morfero** se conecta sin problemas en **Nabucodonosor**.
- **Morfero** se deconecta sin problemas en **Nabucodonosor**.
- **Tanque** se conecta sin problemas en **Nabucodonosor**.
- Verificar que el único de los conectados de **Logo** es **Nuveo**.
- Verificar que los conectados de Nabucodonosor son **Trinica** y **Tanque**.


## Zino (ciudad)

La ciudad de **Zino** posee una flota de Hovercraft. Le interesa conocer la siguiente información:

- Los tripulantes más pesados: el conjunto que se forma por el tripulante más pesado de cada nave.
- La cantidad de calorías diarias necesarias para mantener a toda la flota.
- La nave con más tripulantes conectados a La Matriz.
- Obtener un Hovercraft cuya cantidad de tripulantes sea igual o superior a la cantidad solicitada.

#### Caso de ejemplo:
La flota de **Zino** está compuesta por **Nabucodonosor** y por **Logo**, con los mismos tripulantes de los puntos previos.
Conectar en **Nuveo** a **Logo**.
Conectar a **Tanque** y **Morfero** en **Nabucodonosor**.

Verificar que:

 - Los más pesados de **Zino** son **Tanque** y **Dosis**.
 - Las calorías diarias que consumen los tripulantes de la flota de **Zino** es 7800. 
 - **Nabucodonosor** es la nave con más conectados.
 - Si buscás una nave con 3 o más tripulantes, encontrarás a **Nabucodonosor**.
 - Sería imposible encontrar una nave con 4 tripulantes.
