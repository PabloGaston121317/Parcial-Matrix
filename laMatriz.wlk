class Tripulante {
    var peso

    method caloriasDiarias()

    method peso() = peso

    method comer(){

        peso += self.caloriasDiarias() / self.factorComer()
    }

    method factorComer() = 10000
}

class Nativo inherits Tripulante{

    override method caloriasDiarias(){

        return self.peso() * 25
    }
}

class Liberado inherits Tripulante{
    var desarraigo
    

    override method caloriasDiarias(){

        return self.maxCalorias() * desarraigo
    }

    method maxCalorias() = 3000

    override method comer(){
        super()
        desarraigo = (desarraigo - 0.01).max(0.2)
    }

    method desarraigo() = desarraigo
}

class Cambiante inherits Liberado{

    override method caloriasDiarias() {

        return super() + 500
    }

    override method maxCalorias() = 2000
}

class Elegido inherits Tripulante{

    override method caloriasDiarias(){

        return if(peso < 70) 30 else 50
    }

    override method factorComer() = 50000
}


class Nave {
    var proteina
    const tripulantes = #{}

    method cenar(){
        self.validarCenar()
        proteina -= self.consumoDeTripulantes()
        tripulantes.forEach({tripulante => tripulante.comer()})

    }

    method consumoDeTripulantes(){

        return tripulantes.sum({tripulante => tripulante.caloriasDiarias()})
    }

    method validarCenar(){
        if(! self.puedenCenar()){
            self.error("No se puede servir la cena")
        }
    }

    method puedenCenar() = proteina >= self.consumoDeTripulantes()
}