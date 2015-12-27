//
//  ViewController.swift
//  MauvaisePluieDA
//
//  Created by m2sar on 27/10/2014.
//  Copyright (c) 2014 m2sar. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UIScrollViewDelegate {

    
    //let v = MainView(frame: rect);
    //@IBOutlet var mainv: MainView!
    @IBOutlet var gamev: GameView!
    @IBOutlet var scoresv: ScoreView!
    @IBOutlet var prefv: PrefView!
   
    @IBOutlet var fond: UIImageView!
    private let terminal = UIDevice.currentDevice()
    private let screen   = UIScreen.mainScreen()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let ecran = UIScreen.mainScreen();
        let rect = ecran.bounds;
        
        fond = UIImageView(image: UIImage(named: "MauvaisePluie-photos/fond-mauvaise-pluie.jpg"))
        fond.contentMode = UIViewContentMode.ScaleAspectFill
        
        
        //mainv = MainView(frame: rect);
        gamev = GameView(frame: rect);
        scoresv = ScoreView(frame: rect);
        prefv = PrefView(frame: rect);
        prefv.hidden = true
        
        
        
        self.view.backgroundColor = UIColor.blackColor()
        gamev.bscores.addTarget(self, action: "showscores:", forControlEvents: .TouchUpInside);
        gamev.bjouer.addTarget(self, action: "showgame:", forControlEvents: .TouchUpInside);
        gamev.bpref.addTarget(self, action: "showpref:", forControlEvents: .TouchUpInside);
        
        gamev.droite.addTarget(self, action: "allerdroite:", forControlEvents: .TouchDown);
        //gamev.droite.addTarget(self, action: "releasedroite:", forControlEvents: .TouchUpInside & .TouchUpOutside);
        gamev.droite.addTarget(self, action: "releasedroite:", forControlEvents: .TouchUpInside);
        gamev.droite.addTarget(self, action: "releasedroite:", forControlEvents: .TouchUpOutside);
        
        
        gamev.gauche.addTarget(self, action: "allergauche:", forControlEvents: .TouchDown);
        gamev.gauche.addTarget(self, action: "releasegauche:", forControlEvents: .TouchUpInside);
        gamev.gauche.addTarget(self, action: "releasegauche:", forControlEvents: .TouchUpOutside);
        
        scoresv.done.addTarget(self, action: "showhome:", forControlEvents: .TouchUpInside);
        scoresv.hidden = true
        
        prefv.done.addTarget(self, action: "doneAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        
        let effetH = UIInterpolatingMotionEffect(keyPath: "center.x",type:
            .TiltAlongHorizontalAxis)
        
        effetH.minimumRelativeValue = -50.0
        effetH.maximumRelativeValue =  50.0
        
        let effetV = UIInterpolatingMotionEffect(keyPath: "centre.y", type:
            .TiltAlongVerticalAxis)
        effetV.minimumRelativeValue = -50.0
        effetV.maximumRelativeValue =  50.0
        
        fond.addMotionEffect(effetH)
        fond.addMotionEffect(effetV)
        
        
        
        self.view.addSubview(fond);
        //self.view = gamev;
        self.view.addSubview(prefv)
        self.view.addSubview(scoresv)
        
        self.view.addSubview(gamev)
        //self.view.addSubview(fond);
        
        if(terminal.userInterfaceIdiom == .Pad){
            fond.frame = CGRectMake(0,CGFloat((rect.size.height/3)-50),rect.size.width,rect.size.height);
            
            
        }else{
            fond.frame = CGRectMake(0,CGFloat((rect.size.height/2)-15),rect.size.width,rect.size.height);
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /*override func shouldAutorotate() -> Bool{
        // This method is the same for all the three custom ViewController
        return false
    }*/
    
    
//    override func supportedInterfaceOrientations() -> Int{
//        // Portrait for the first 2 ViewController
//        return Int(UIInterfaceOrientationMask.LandscapeLeft.rawValue + UIInterfaceOrientationMask.LandscapeRight.rawValue)
//        // LandscapeRight for the third
//        //Int()
//    }
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        let orientation: UIInterfaceOrientationMask = [UIInterfaceOrientationMask.LandscapeLeft, UIInterfaceOrientationMask.LandscapeRight]
        return orientation
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func gotoscore(s:Int){
        

        gamev.lfin.hidden = false
        gamev.lfin.hidden = false
        scoresv.valeurScore.text = NSString(format: "%d", s) as String
        scoresv.addnewscore(s)
        
        gamev.hidden = true
        scoresv.hidden = false
        scoresv.saisie.hidden = false
    }
    
    
    @IBAction func doneAction(sender: UIButton) {
        gamev.hidden = false
        scoresv.hidden = true
        prefv.hidden = true
    }
    
    @IBAction func showscores(sender: UIButton) {
        
        gamev.hidden = true
        scoresv.hidden = false
        scoresv.saisie.hidden = true
        
        //self.view = scoresv;
        
    }
    
    @IBAction func showgame(sender: UIButton) {
        gamev.bscores.hidden = true;
        gamev.bpref.hidden = true;
        gamev.bjouer.hidden = true;
        
        gamev.droite.hidden = false;
        gamev.gauche.hidden = false;
        
        gamev.player.hidden = false;
        gamev.lscore.hidden = false;
        gamev.lniveau.hidden = false;
        
        //self.view = gamev;
        
        gamev.start(prefv.niveau,ref: self)
        
        
    }
    
    @IBAction func showpref(sender: UIButton) {
        
        gamev.hidden = true
        prefv.hidden = false
        
        
        //self.view = prefv;
        
    }
    
    @IBAction func showhome(sender: UIButton) {
        
        
        self.view.endEditing(true)
        gamev.bscores.hidden = false;
        gamev.bpref.hidden = false;
        gamev.bjouer.hidden = false;
        
        gamev.droite.hidden = true;
        gamev.gauche.hidden = true;
        
        gamev.player.hidden = true;
        gamev.lscore.hidden = true;
        gamev.lniveau.hidden = true;
        gamev.lfin.hidden = true;
        //self.view = gamev;

        prefv.hidden = true
        scoresv.hidden = true
        gamev.hidden = false
        
    }
    
    @IBAction func allerdroite(sender: UIButton) {
        
        gamev.droite.tag = 1;
        
    }

    @IBAction func releasedroite(sender: UIButton) {
        gamev.droite.tag = 0;
    }
    
    @IBAction func releasegauche(sender: UIButton) {
        gamev.gauche.tag = 0;
    }
    
    @IBAction func allergauche(sender: UIButton) {
        gamev.gauche.tag = 1;
        
        
        //TouchDownRepeat
    }
    
    
    
    
    

}

