//
//  Plateau.swift
//  Memory
//
//  Created by etudiant on 29/02/2016.
//  Copyright © 2016 == Benjamin. All rights reserved.
//

import Foundation

class Plateau {
    var gamemode: Int = 0;
    var state: Int = 0;
    //var tabScore: [Int] = [];
    private var score:Int = 0;
    private var tabCarte: [Carte] = []
    private var nbCarteRetourne: Int;
    private var nbCarteTrouvee: Int = 0;
    
    init()
    {
        nbCarteRetourne = 0;
        PlaceCards();
    }
    
    func start()
    {
        score = 0;
        nbCarteRetourne = 0;
        nbCarteTrouvee = 0;
        tabCarte.removeAll();
        PlaceCards();
    }
    
    func PlaceCards()
    {
        var tabID:[Int] = [1,1,2,2,3,3,4,4,5,5,6,6];
        var diceRoll = 0;
        for _ in 0 ..< 12
        {
            diceRoll = Int(arc4random_uniform(UInt32(tabID.count))) + 1; //Chiffre choisi aléatoirement
            let valToInsert = tabID[diceRoll - 1];
            tabID.removeAtIndex(diceRoll - 1);
            let nouvelleCarte = Carte(idCarte: valToInsert, visible: true, recto: true)
            tabCarte.append(nouvelleCarte);
        }
    }
    
    func TapCarte(i : Int) -> Int
    {
        nbCarteRetourne += 1;
        if(tabCarte[i].getRecto())
        {
            tabCarte[i].setRecto(false);
            if(nbCarteRetourne >= 2)
            {
                if(IsCardSame())
                {
                    SameCardFound();
                }
                else
                {
                    score += 1;
                }
            }
        }
        return nbCarteRetourne;
    }
    
    func IsCardSame() -> Bool
    {
        var firstCard: Int = 0;
        var secondCard: Int = 0;
        for i in 0 ..< 12
        {
            let curIdCarte = tabCarte[i].getIdCarte()
            if(curIdCarte != 0 && curIdCarte != 7)
            {
                if(firstCard == 0)
                {
                    firstCard = curIdCarte;
                }
                else
                {
                    secondCard = curIdCarte;
                }
            }
        }
        if(firstCard != 0 && secondCard != 0 && firstCard == secondCard)
        {
            return true;
        }
        return false;
    }
    
    func SameCardFound()
    {
        nbCarteTrouvee += 1;
        for i in 0 ..< 12
        {
            if(tabCarte[i].getIdCarte() != 0)
            {
                tabCarte[i].setVisible(false);
            }
        }
    }
    
    func getScore() -> Int
    {
        return self.score;
    }
    
    func getNbCarteTrouvee() -> Int
    {
        return self.nbCarteTrouvee;
    }
    
    func resetCarte()
    {
        for j in 0 ..< 12 {tabCarte[j].setRecto(true)} //on retourne à nouveau les cartes
        nbCarteRetourne = 0;
    }
    
    func getCarte(i : Int) -> Carte
    {
        return tabCarte[i];
    }
}