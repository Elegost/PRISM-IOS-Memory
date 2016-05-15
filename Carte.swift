//
//  Carte.swift
//  Memory
//
//  Created by etudiant on 29/02/2016.
//  Copyright © 2016 Langot Benjamin. All rights reserved.
//

import Foundation

class Carte {
    private var idCarte: Int = 0;
    private var visible: Bool = true;
    private var recto: Bool = true;
    
    init(idCarte: Int, visible: Bool, recto: Bool)
    {
        self.idCarte = idCarte;
        self.visible = visible;
        self.recto = recto;
    }
    
    func getIdCarte() -> Int
    {
        if(!visible){return 7}
        if(recto){return 0}
        return idCarte
    }
    
    func getIdCarteForSoundEffect() -> Int
    {
        return idCarte
    }
    
    func getRecto() -> Bool
    {
        return self.recto;
    }
    
    func setVisible(visibleVar:Bool)
    {
        visible = visibleVar;
    }
    
    func setRecto(rectoversoVar:Bool)
    {
        self.recto = rectoversoVar;
    }
}