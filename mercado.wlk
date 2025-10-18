import wollok.game.*
import personaje.*

object mercados{

    const mercado1 = mercadoFactory.crear( game.at(0, 0), 1000 )
    const mercado2 = mercadoFactory.crear( game.at(9, 0), 2000 )
    const mercado3 = mercadoFactory.crear( game.at(0, 9), 300 )

    const mercadosTotales = [mercado1,mercado2,mercado3]

    method hayMercadoEn(position){  return game.getObjectsIn(position).any({obj => mercadosTotales.contains(obj)})            }
    method mercadoEn(position)   {  return game.getObjectsIn(position).filter({obj => mercadosTotales.contains(obj)}).get(0)  }
    method plantarMercados()     {  mercadosTotales.forEach({mercado => game.addVisual(mercado)})                             }
}

object mercadoFactory {
    method crear(pos,_monedas) {     return new Mercado( position = pos ,monedas = _monedas )    }    
}

class Mercado {
    var property position  
    const property mercaderia = #{}
    var property monedas  = 1000
    method image() {   return "market.png"  }

    method comprarMercaderia(valorCompra) {
      self.validarCompra()
      monedas -=  personaje.valorDeCosechaTotal()
      mercaderia.addAll(personaje.cosecha())
    }
  
  method validarCompra() {
    if( monedas < personaje.valorDeCosechaTotal()){
      self.error("No tengo dinero suficiente para comprar")
    }
  }
  method text()      {  return monedas.toString()	}
	method textColor() {	return "000000"	          }

}



