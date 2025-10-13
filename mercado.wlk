import wollok.game.*


object mercadoFactory {
    
    method crear(pos) {
      return new Mercado( position = pos)

    }

}

class Mercado {
    var property position  
    const mercaderia = #{}
    var property monedas  = 0
    method image() {
      return "market.png"
    }




}



