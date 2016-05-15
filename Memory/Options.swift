//
//  Accueil.swift
//  Memory
//
//  Created by etudiant on 04/04/2016.
//  Copyright © 2016 Langot Benjamin. All rights reserved.
//

import UIKit

class Options: UIViewController{
    @IBOutlet weak var Switch_Musique: UISwitch!
    @IBOutlet weak var Switch_SoundEffect: UISwitch!
    @IBOutlet weak var Switch_DisplayBackground: UISwitch!
    
    var logOption: LogOptions = LogOptions.init()
    var s_lo: s_logOption = s_logOption()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        s_lo = LogOptions.ReadFromFile(logOption)()
        // Do any additional setup after loading the view.
        
        Switch_Musique.on = s_lo.split_musique
        Switch_SoundEffect.on = s_lo.split_soundEffect
        Switch_DisplayBackground.on = s_lo.displayAnimatedBackground
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func s_loToString() -> String
    {
        var res = Switch_Musique.on == true ? "1" : "0"
        res += "/"
        res += Switch_SoundEffect.on == true ? "1" : "0"
        res += "/"
        res += Switch_DisplayBackground.on == true ? "1" : "0"
        return res
    }
    
    @IBAction func btn_ValidateChange_click(sender: UIButton)
    {
        logOption.WriteToFile(s_loToString())
        print(s_loToString())
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("Accueil")
        self.presentViewController(vc, animated: true, completion: nil);
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
