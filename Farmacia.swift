//
//  Farmacia.swift
//  FarmciasTurnoSalto
//
//  Created by Juan Ariel on 14/3/17.
//  Copyright © 2017 Juan Ariel. All rights reserved.
//

import Foundation

class Farmacia {
    
    var nombre: String?
    var direccion: String?
    var telefono: String?
    var fechaDesde: String?
    var fechaHasta: String?
    
    init(nombre: String?,direccion: String?,telefono: String?,fechaDesde: String?,fechaHasta: String?){
        self.nombre = nombre
        self.direccion = direccion
        self.telefono = telefono
        self.fechaDesde = fechaDesde
        self.fechaHasta = fechaHasta
    }
}
