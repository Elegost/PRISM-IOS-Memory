//
//  Accueil.swift
//  Memory
//
//  Created by etudiant on 04/04/2016.
//  Copyright © 2016 Langot Benjamin. All rights reserved.
//

import UIKit

class Accueil: UIViewController{
    
    var logConn: LogConn = LogConn.init()
    var logScore: LogScore = LogScore(username: "test")
    var s_ls: s_LogScore = s_LogScore()
    var s_lc: s_logConn = s_logConn()

    var usernameLogConn: s_logConn = s_logConn()
    
    @IBOutlet weak var textField_familyName: UITextField!
    @IBOutlet weak var textField_name: UITextField!
    @IBOutlet var colScore: [UILabel]!
    @IBOutlet weak var label_Username: UILabel!
    @IBOutlet weak var textField_Username: UITextField!
    @IBOutlet weak var button_Connection: UIButton!
    @IBOutlet weak var button_launch: UIButton!
    @IBOutlet weak var button_logIn: UIButton!
    @IBOutlet weak var ViewScore: UIView!
    @IBOutlet weak var ListScore: UITableView!
    @IBOutlet weak var Label_HighScore: UILabel!
    @IBOutlet weak var label_Username_Score: UILabel!
    @IBOutlet weak var button_Score: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLogConn = logConn.ReadFromFile()
       
        ViewScore.hidden = true

        if (usernameLogConn.username == "")
        {
            label_Username.text = "Enregistrez-vous"
            button_Score.hidden = true
            textField_Username.hidden = true
            textField_name.hidden = true
            textField_familyName.hidden = true
            button_launch.hidden = true
            button_logIn.hidden = false
            button_SeConnecter.hidden = true
            button_Connection.setTitle("Pas encore inscrit ? Veuillez créer un compte", forState: UIControlState.Normal)
        }
        else
        {
            label_Username.text = "Bonjour " + usernameLogConn.name + " " + usernameLogConn.familyName + " (" + usernameLogConn.username + ")"
            button_launch.setTitle("Jouer", forState: UIControlState.Normal)
            textField_name.text = usernameLogConn.name
            textField_Username.text = usernameLogConn.username
            textField_familyName.text = usernameLogConn.familyName
            button_launch.hidden = false
            button_Score.hidden = false
            button_logIn.hidden = true
            button_SeConnecter.hidden = true
            textField_Username.hidden = true;
            textField_name.hidden = true
            textField_familyName.hidden = true
            button_Connection.setTitle("Vous n'êtes pas " + usernameLogConn.username + " ? Cliquez ici", forState: UIControlState.Normal)
        }

        // Do any additional setup after loading the view.
    }
    
    func s_lcToString() -> String
    {
        var res = s_lc.username
        res += "/"
        res += s_lc.name
        res += "/"
        res += s_lc.familyName
        return res
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var button_SeConnecter: UIButton!
    @IBAction func button_seConnecter_click(sender: UIButton)
    {
        if(textField_Username.text != "")
        {
            s_lc.username = textField_Username.text!
            s_lc.name = textField_name.text!
            s_lc.familyName = textField_familyName.text!
            logConn.WriteToFile(s_lcToString())
            usernameLogConn = logConn.ReadFromFile()
            button_launch.hidden = false
            button_SeConnecter.hidden = true
            button_Score.hidden = false
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        s_lc.username = textField_Username.text!
        s_lc.name = textField_name.text!
        s_lc.familyName = textField_familyName.text!
        if(usernameLogConn.username != "")
        {
            textField_Username.text = usernameLogConn.username
        }
        if segue.identifier == "SegueToMain"
        {
            logConn.WriteToFile(s_lcToString())
            // Definition du controler de destinatation
            let destinationVC = segue.destinationViewController as? ViewController
            // Transfert de données
            destinationVC?.pseudoUsername = textField_Username.text!
        }
    }

    @IBAction func button_logIn_click(sender: UIButton)
    {
        textField_Username.hidden = false
        textField_name.hidden = false
        textField_familyName.hidden = false
        label_Username.hidden = true
        button_launch.hidden = true
        button_logIn.hidden = true
        button_SeConnecter.hidden = false
        button_Score.hidden = true
    }

    @IBAction func button_Score_click(sender: UIButton)
    {
        logScore = LogScore(username: usernameLogConn.username)
        s_ls = logScore.ReadFromFile()
        
        ViewScore.hidden = !ViewScore.hidden
        if(s_ls.highScore != Int.max)
        {
            Label_HighScore.text = String(s_ls.highScore)
        }
        else
        {
            Label_HighScore.text = "-"
        }
        label_Username_Score.text = usernameLogConn.username
        for i in 0 ..< 10
        {
            if(i < s_ls.TabScore.count)
            {
                if(s_ls.TabScore[i] != Int.max)
                {
                    colScore[i].text = String(s_ls.TabScore[i])
                }
                else
                {
                    colScore[i].text = "-"
                }
            }
            else
            {
                colScore[i].text = "-"
            }
        }
    }
}
