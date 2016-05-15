//
//  ViewController.swift
//  Memory
//
//  Created by etudiant on 29/02/2016.
//  Copyright © 2016 Langot Benjamin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let frontCard = UIView()
    let backCard = UIView()
    
    @IBOutlet weak var Carte1: UIView!
    @IBOutlet weak var Carte2: UIView!
    @IBOutlet weak var Carte3: UIView!
    @IBOutlet weak var Carte4: UIView!
    @IBOutlet weak var Carte5: UIView!
    @IBOutlet weak var Carte6: UIView!
    @IBOutlet weak var Carte7: UIView!
    @IBOutlet weak var Carte8: UIView!
    @IBOutlet weak var Carte9: UIView!
    @IBOutlet weak var Carte10: UIView!
    @IBOutlet weak var Carte11: UIView!
    @IBOutlet weak var Carte12: UIView!
    @IBOutlet weak var ViewForAnimation: UIView!
    @IBOutlet var tabCarte: [UIView]!
    @IBOutlet var Tap1: UITapGestureRecognizer!
    @IBOutlet var Tap2: UITapGestureRecognizer!
    @IBOutlet var Tap3: UITapGestureRecognizer!
    @IBOutlet var Tap4: UITapGestureRecognizer!
    @IBOutlet var Tap5: UITapGestureRecognizer!
    @IBOutlet var Tap6: UITapGestureRecognizer!
    @IBOutlet var Tap7: UITapGestureRecognizer!
    @IBOutlet var Tap8: UITapGestureRecognizer!
    @IBOutlet var Tap9: UITapGestureRecognizer!
    @IBOutlet var Tap10: UITapGestureRecognizer!
    @IBOutlet var Tap11: UITapGestureRecognizer!
    @IBOutlet var Tap12: UITapGestureRecognizer!
    @IBOutlet weak var label_Score: UILabel!
    @IBOutlet weak var button_retour: UIButton!

    var plateau:Plateau = Plateau()
    var tapBlocked:Bool = false
    var lastCardTapped: Int = -1
    var pseudoUsername: String = "";
    var logScore: LogScore = LogScore(username: "test")
    var s_ls: s_LogScore = s_LogScore()
    var logOption: LogOptions = LogOptions.init()
    var s_lo: s_logOption = s_logOption()
    
    var firstTapID: Int = -1
    var secondTapId: Int = -1
        
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        for i in 0 ..< self.tabCarte.count
        {
            self.tabCarte[i].setNeedsLayout()
            self.tabCarte[i].layoutIfNeeded()
            self.tabCarte[i].backgroundColor = setBackGroundCarte(tabCarte[i], nameImg: "verso.png")
        }
        
        logScore = LogScore(username: pseudoUsername)
        s_ls = logScore.ReadFromFile()
        print(s_lsToString())
        
        takeAccountOfOptions()
        music()
        
        if(s_lo.displayAnimatedBackground == true)
        {
            setVideoBackground()
        }
        
        button_retour.layer.masksToBounds = true
        button_retour.layer.cornerRadius = 3
        button_music.layer.masksToBounds = true
        button_music.layer.cornerRadius = 3
        button_soundEffect.layer.masksToBounds = true
        button_soundEffect.layer.cornerRadius = 3
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var backgroundVideoPlayer = AVPlayer()
    
    func setVideoBackground()
    {
        // Use a local or remote URL
        let path = NSBundle.mainBundle().pathForResource("BackgroundVideo.mp4", ofType:nil)!
        let url = NSURL(fileURLWithPath: path)
        
        // Make a player
        backgroundVideoPlayer = AVPlayer(URL: url)
        backgroundVideoPlayer.play()

        
        backgroundVideoPlayer.actionAtItemEnd = .None
        backgroundVideoPlayer.muted = true
        
        let playerLayer = AVPlayerLayer(player: backgroundVideoPlayer)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1
        
        playerLayer.frame = view.frame
        
        view.layer.addSublayer(playerLayer)
        
        backgroundVideoPlayer.play()
        
        //loop video
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.loopVideo), name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
    }
    
    func loopVideo() {
        backgroundVideoPlayer.seekToTime(kCMTimeZero)
        backgroundVideoPlayer.play()
    }
    func takeAccountOfOptions()
    {
        s_lo = LogOptions.ReadFromFile(logOption)()
        button_music.tintColor = s_lo.split_musique == true ? UIColor.blueColor() : UIColor.grayColor()
        button_soundEffect.tintColor = s_lo.split_soundEffect == true ? UIColor.blueColor() : UIColor.grayColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        
        // Reload Data here
        
        for i in 0 ..< self.tabCarte.count
        {
            self.tabCarte[i].setNeedsDisplay()
            self.tabCarte[i].layoutIfNeeded()
        }
        updateView()
    }
    
    var player = AVAudioPlayer()
    
    func music()
    {
        
        let path = NSBundle.mainBundle().pathForResource("Ambiance.m4a", ofType:nil)!
        let url = NSURL(fileURLWithPath: path)
        
        do { player = try AVAudioPlayer(contentsOfURL: url, fileTypeHint: nil) }
        catch let error as NSError { print(error.description) }
        
        player.numberOfLoops = -1
        player.volume = s_lo.split_musique == true ? 1.0 : 0.0
        player.prepareToPlay()
        player.play()
    }
    
    var soundplayer = AVAudioPlayer()
    
    func playsoundEffect(soundEffectID: Int)
    {
        var path = ""
        switch soundEffectID {
        case 1: path = NSBundle.mainBundle().pathForResource("Symmetra.m4a", ofType:nil)!;break;
        case 2: path = NSBundle.mainBundle().pathForResource("Tracer.m4a", ofType:nil)!;break;
        case 3: path = NSBundle.mainBundle().pathForResource("Hanzo.m4a", ofType:nil)!;break;
        case 4: path = NSBundle.mainBundle().pathForResource("Reaper.m4a", ofType:nil)!;break;
        case 5: path = NSBundle.mainBundle().pathForResource("Torbjörn.m4a", ofType:nil)!;break;
        case 6: path = NSBundle.mainBundle().pathForResource("Mercy.m4a", ofType:nil)!;break;
        default: path = ""
        }
        let url = NSURL(fileURLWithPath: path)
        
        do { soundplayer = try AVAudioPlayer(contentsOfURL: url, fileTypeHint: nil) }
        catch let error as NSError { print(error.description) }
        
        soundplayer.numberOfLoops = 0
        soundplayer.volume = s_lo.split_soundEffect == true ? 1.0 : 0.0
        soundplayer.prepareToPlay()
        soundplayer.play()
    }
    
    func addNewScoreToLogScore(newScore: Int)
    {
        s_ls.username = pseudoUsername;
        if(s_ls.TabScore.count < 10)
        {
            s_ls.TabScore.append(newScore)
            s_ls.TabScore.sortInPlace()
        }
        else
        {
            s_ls.TabScore.sortInPlace()
            s_ls.TabScore.removeLast()
            s_ls.TabScore.append(newScore)
            s_ls.TabScore.sortInPlace()
        }
        s_ls.highScore = s_ls.TabScore[0];
    }
    
    func s_lsToString() -> String
    {
        var str: String = String(s_ls.highScore)
        str += "/"
        for i in 0 ..< s_ls.TabScore.count
        {
            str += String(s_ls.TabScore[i])
            str += ";"
        }
        str += "/"
        str += s_ls.username
        return str
    }
    
    @IBAction func TapDetectCarte(sender: UITapGestureRecognizer)
    {
        var curCardTapped:Int = -2
        switch sender //Récupération de la
        {
        case Tap1 : curCardTapped = 0;break;
        case Tap2 : curCardTapped = 1;break;
        case Tap3 : curCardTapped = 2;break;
        case Tap4 : curCardTapped = 3;break;
        case Tap5 : curCardTapped = 4;break;
        case Tap6 : curCardTapped = 5;break;
        case Tap7 : curCardTapped = 6;break;
        case Tap8 : curCardTapped = 7;break;
        case Tap9 : curCardTapped = 8;break;
        case Tap10 : curCardTapped = 9;break;
        case Tap11 : curCardTapped = 10;break;
        case Tap12 : curCardTapped = 11;break;
        default :label_Score.text = "Erreur";break;
        }
        if(firstTapID == -1)
        {
            firstTapID = curCardTapped
        }
        else
        {
            secondTapId = curCardTapped
        }
        if(!tapBlocked && curCardTapped != lastCardTapped)
        {
            var nbCarte:Int = 0;
            switch sender
            {
                case Tap1 : nbCarte = plateau.TapCarte(0)
                            updateViewForTap(0)
                            if(nbCarte >= 2) {
                                if(plateau.getCarte(0).getIdCarte() == 7){ playsoundEffect(plateau.getCarte(0).getIdCarteForSoundEffect()) }
                            }
                            lastCardTapped = 0;break;
                case Tap2 : nbCarte = plateau.TapCarte(1)
                            updateViewForTap(1)
                            if(nbCarte >= 2) {
                            if(plateau.getCarte(1).getIdCarte() == 7){ playsoundEffect(plateau.getCarte(1).getIdCarteForSoundEffect()) }
                            }
                            lastCardTapped = 1;break;
                case Tap3 : nbCarte = plateau.TapCarte(2)
                            updateViewForTap(2)
                            if(nbCarte >= 2) {
                            if(plateau.getCarte(2).getIdCarte() == 7){ playsoundEffect(plateau.getCarte(2).getIdCarteForSoundEffect()) }
                            }
                            lastCardTapped = 2;break;
                case Tap4 : nbCarte = plateau.TapCarte(3)
                            updateViewForTap(3)
                            if(nbCarte >= 2) {
                            if(plateau.getCarte(3).getIdCarte() == 7){ playsoundEffect(plateau.getCarte(3).getIdCarteForSoundEffect()) }
                            }
                            lastCardTapped = 3;break;
                case Tap5 : nbCarte = plateau.TapCarte(4)
                            updateViewForTap(4)
                            if(nbCarte >= 2) {
                            if(plateau.getCarte(4).getIdCarte() == 7){ playsoundEffect(plateau.getCarte(4).getIdCarteForSoundEffect()) }
                            }
                            lastCardTapped = 4;break;
                case Tap6 : nbCarte = plateau.TapCarte(5)
                            updateViewForTap(5)
                            if(nbCarte >= 2) {
                            if(plateau.getCarte(5).getIdCarte() == 7){ playsoundEffect(plateau.getCarte(5).getIdCarteForSoundEffect()) }
                            }
                            lastCardTapped = 5;break;
                case Tap7 : nbCarte = plateau.TapCarte(6)
                            updateViewForTap(6)
                            if(nbCarte >= 2) {
                            if(plateau.getCarte(6).getIdCarte() == 7){ playsoundEffect(plateau.getCarte(6).getIdCarteForSoundEffect()) }
                            }
                            lastCardTapped = 6;break;
                case Tap8 : nbCarte = plateau.TapCarte(7)
                            updateViewForTap(7)
                            if(nbCarte >= 2) {
                            if(plateau.getCarte(7).getIdCarte() == 7){ playsoundEffect(plateau.getCarte(7).getIdCarteForSoundEffect()) }
                            }
                            lastCardTapped = 7;break;
                case Tap9 : nbCarte = plateau.TapCarte(8)
                            updateViewForTap(8)
                            if(nbCarte >= 2) {
                            if(plateau.getCarte(8).getIdCarte() == 7){ playsoundEffect(plateau.getCarte(8).getIdCarteForSoundEffect()) }
                            }
                            lastCardTapped = 8;break;
                case Tap10 : nbCarte = plateau.TapCarte(9);
                            updateViewForTap(9)
                            if(nbCarte >= 2) {
                            if(plateau.getCarte(9).getIdCarte() == 7){ playsoundEffect(plateau.getCarte(9).getIdCarteForSoundEffect()) }
                            }
                            lastCardTapped = 9;break;
                case Tap11 : nbCarte = plateau.TapCarte(10)
                            updateViewForTap(10)
                            if(nbCarte >= 2) {
                            if(plateau.getCarte(10).getIdCarte() == 7){ playsoundEffect(plateau.getCarte(10).getIdCarteForSoundEffect()) }
                            }
                            lastCardTapped = 10;break;
                case Tap12 : nbCarte = plateau.TapCarte(11)
                            updateViewForTap(11)
                            if(nbCarte >= 2) {
                            if(plateau.getCarte(11).getIdCarte() == 7){ playsoundEffect(plateau.getCarte(11).getIdCarteForSoundEffect()) }
                            }
                            lastCardTapped = 11;break;
                default :label_Score.text = "Erreur";break;
            }
            if(nbCarte >= 2)
            {
                self.tapBlocked = true; //Empeche de pouvoir a nouveau cliquer sur une carte tant qu'1 seconde ne s'est pas déroulé
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue())
                {
                    if(self.firstTapID <= 11 && self.firstTapID >= 0 && self.secondTapId <= 11 && self.secondTapId >= 0)
                    {
                        self.animateCardReverse(self.firstTapID)
                        self.animateCardReverse(self.secondTapId)
                    }
                    self.plateau.resetCarte()
                    self.updateView()
                    self.tapBlocked = false
                    self.lastCardTapped = -1
                    self.firstTapID = -1
                    self.secondTapId = -1
                    
                }
            }
            if(plateau.getNbCarteTrouvee() >= 5)
            {
                addNewScoreToLogScore(plateau.getScore())
                logScore.WriteToFile(s_lsToString())
                print(s_lsToString())
                showAlert();
            }
        }
    }
    
    func showAlert(){
        let createAccountErrorAlert: UIAlertView = UIAlertView()
        createAccountErrorAlert.delegate = self
        createAccountErrorAlert.title = "Bien joué !"
        createAccountErrorAlert.message = "Voulez vous rejouer ?"
        createAccountErrorAlert.addButtonWithTitle("Accepter")
        createAccountErrorAlert.addButtonWithTitle("Refuser")
        createAccountErrorAlert.show()
    }
    
    
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int)
    {
        
        switch buttonIndex{
            
        case 0:
            plateau.start();
            for i in 0 ..< self.tabCarte.count
            {
                self.tabCarte[i].backgroundColor = setBackGroundCarte(tabCarte[i], nameImg: "verso.png");
                self.tabCarte[i].hidden = false
            }
            break;
        case 1:
            NSLog("Refuser");
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("Accueil")
            self.presentViewController(vc, animated: true, completion: nil);
            player.stop()
            break;
        default:
            NSLog("Default");
            break;
            //Some code here..
            
        }
    }
    
    func updateViewForTap(TappedCardId: Int)
    {
        animateCard(TappedCardId);
        for i in 0 ..< self.tabCarte.count
        {
            if(i != TappedCardId)
            {
                let str = getImg(i + 1);
                self.tabCarte[i].backgroundColor = setBackGroundCarte(tabCarte[i], nameImg: str)
            }
        }
        label_Score.text = "Votre score : " + String(plateau.getScore());
    }
    
    func updateView()
    {
        for i in 0 ..< self.tabCarte.count
        {
            let str = getImg(i + 1);
            self.tabCarte[i].backgroundColor = setBackGroundCarte(tabCarte[i], nameImg: str)
            if(str == "blanc.png" && tabCarte[i].hidden == false)
            {
                tabCarte[i].hidden = true
            }
        }
        label_Score.text = "Votre score : " + String(plateau.getScore());
        frontCard.removeFromSuperview()
        backCard.removeFromSuperview()
    }

    
    func animateCard(idCard : Int)
    {
        self.tabCarte[idCard].addSubview(self.frontCard)
        self.frontCard.frame = tabCarte[idCard].frame
        self.backCard.setNeedsLayout()
        self.backCard.layoutIfNeeded()

        self.backCard.frame = CGRect(x: 0, y: 0, width: frontCard.frame.width, height: frontCard.frame.height)
        self.frontCard.backgroundColor = setBackGroundCarte(frontCard, nameImg: "verso.png")
        let str = getImg(idCard + 1);
        self.backCard.backgroundColor = setBackGroundCarte(backCard, nameImg: str)
        // create a 'tuple' (a pair or more of objects assigned to a single variable)
        var views : (frontView: UIView, backView: UIView)
        views = (frontView: self.frontCard, backView: self.backCard)
        // set a transition style
        let transitionOptions = UIViewAnimationOptions.TransitionFlipFromLeft
        // with no animation block, and a completion block set to 'nil' this makes a single line of code
        UIView.transitionFromView(views.frontView, toView: views.backView, duration: 0.5, options: transitionOptions, completion: nil)
    }
    
    
    func animateCardReverse(idCard : Int)
    {
        if(getImg(idCard + 1) == "blanc.png")
        {
            return;
        }
        self.tabCarte[idCard].addSubview(self.frontCard)
        self.frontCard.frame = tabCarte[idCard].frame
        self.backCard.setNeedsLayout()
        self.backCard.layoutIfNeeded()
        
        self.backCard.frame = CGRect(x: 0, y: 0, width: frontCard.frame.width, height: frontCard.frame.height)
        let str = getImg(idCard + 1);
        self.frontCard.backgroundColor = setBackGroundCarte(frontCard, nameImg: str)
        self.backCard.backgroundColor = setBackGroundCarte(backCard, nameImg: "verso.png")
        // create a 'tuple' (a pair or more of objects assigned to a single variable)
        var views : (frontView: UIView, backView: UIView)
        views = (frontView: self.frontCard, backView: self.backCard)
        // set a transition style
        let transitionOptions = UIViewAnimationOptions.TransitionFlipFromRight
        // with no animation block, and a completion block set to 'nil' this makes a single line of code
        UIView.transitionFromView(views.frontView, toView: views.backView, duration: 0.5, options: transitionOptions, completion: nil)
    }

    func setBackGroundCarte(view : UIView, nameImg : String) -> UIColor
    {
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: nameImg)?.drawInRect(view.bounds)
        let image: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIColor(patternImage : image!);
        
    }
    
    func getImg(pos: Int) -> String
    {
        var idCarte:Int;
        switch pos
        {
            case 1: idCarte = plateau.getCarte(0).getIdCarte();break;
            case 2: idCarte = plateau.getCarte(1).getIdCarte();break;
            case 3: idCarte = plateau.getCarte(2).getIdCarte();break;
            case 4: idCarte = plateau.getCarte(3).getIdCarte();break;
            case 5: idCarte = plateau.getCarte(4).getIdCarte();break;
            case 6: idCarte = plateau.getCarte(5).getIdCarte();break;
            case 7: idCarte = plateau.getCarte(6).getIdCarte();break;
            case 8: idCarte = plateau.getCarte(7).getIdCarte();break;
            case 9: idCarte = plateau.getCarte(8).getIdCarte();break;
            case 10: idCarte = plateau.getCarte(9).getIdCarte();break;
            case 11: idCarte = plateau.getCarte(10).getIdCarte();break;
            case 12: idCarte = plateau.getCarte(11).getIdCarte();break;
            default: idCarte = -1;break;
        }
        switch idCarte
        {
        case 0: return "verso.png";
        case 1 : return "1.png";
        case 2 : return "2.png";
        case 3 : return "3.png";
        case 4 : return "4.png";
        case 5 : return "5.png";
        case 6 : return "6.png";
        case 7 : return "blanc.png";
        default: return "";
        }
    }
    
    @IBAction func button_Retour_Click(sender: UIButton)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("Accueil")
        self.presentViewController(vc, animated: true, completion: nil);
        player.stop()
    }
    
    @IBOutlet weak var button_music: UIButton!
    
    @IBAction func button_Music_Click(sender: UIButton)
    {
        if( button_music.tintColor == UIColor.blueColor()) { button_music.tintColor = UIColor.grayColor() }
        else { button_music.tintColor = UIColor.blueColor() }
        player.stop()
        s_lo.split_musique = !s_lo.split_musique
        music()
    }
    
    @IBOutlet weak var button_soundEffect: UIButton!
    
    @IBAction func button_soundEffect_Click(sender: UIButton)
    {
        if( button_soundEffect.tintColor == UIColor.blueColor()) { button_soundEffect.tintColor = UIColor.grayColor() }
        else { button_soundEffect.tintColor = UIColor.blueColor() }
        s_lo.split_soundEffect = !s_lo.split_soundEffect
    }
}

