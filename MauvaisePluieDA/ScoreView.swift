//
//  ScoreView.swift
//  MauvaisePluieDA
//
//  Created by m2sar on 27/10/2014.
//  Copyright (c) 2014 m2sar. All rights reserved.
//

//
//  MaVue.swift
//  QuizSwiftGeek
//
//  Created by derdour ali on 18/10/2014.
//  Copyright (c) 2014 derdour ali. All rights reserved.
//
import UIKit
import Foundation



class ScoreView:UIView {
    
    
    private let terminal = UIDevice.currentDevice()
    private let screen   = UIScreen.mainScreen()
    private var lesscores = [Score]()
    private var labelscore = [UITextField]()
    
    
    @IBOutlet var affiche: UILabel!
    @IBOutlet var saisieLabel: UILabel!
    
    @IBOutlet var votreScore: UILabel!
    @IBOutlet var valeurScore: UILabel!
    
    @IBOutlet var done: UIButton!
    
    @IBOutlet var saisie: UITextField!
    
    private var minscore = 0
    
    var newscore = 0
    
    
    
    override init (frame:CGRect){
        
        
        
        super.init(frame:frame);
        
        
        
        self.backgroundColor = UIColor.clearColor()
        
        done = UIButton(type: UIButtonType.System) as UIButton
        done.setTitle("Done", forState: .Normal)
        done.titleLabel?.font = UIFont.boldSystemFontOfSize(20.0)
        done.sizeToFit()
        
        affiche = UILabel()
        affiche.text = "Meilleurs scores"
        affiche.textColor = UIColor.whiteColor()
        affiche.textAlignment = NSTextAlignment.Center
        affiche.font = UIFont.boldSystemFontOfSize(16.0)
        affiche.sizeToFit()
        
        
        votreScore = UILabel()
        votreScore.text = "Votre score"
        votreScore.textColor = UIColor.whiteColor()
        votreScore.textAlignment = NSTextAlignment.Center
        votreScore.font = UIFont.boldSystemFontOfSize(16.0)
        votreScore.sizeToFit()
        
        
        saisieLabel = UILabel()
        saisieLabel.text = "Saisissez votre nom"
        saisieLabel.textColor = UIColor.whiteColor()
        saisieLabel.textAlignment = NSTextAlignment.Center
        saisieLabel.font = UIFont.boldSystemFontOfSize(16.0)
        saisieLabel.sizeToFit()
        saisieLabel.hidden = true
        
        
        valeurScore = UILabel()
        valeurScore.text = "0000"
        valeurScore.textColor = UIColor.whiteColor()
        valeurScore.textAlignment = NSTextAlignment.Center
        valeurScore.sizeToFit()
        valeurScore.text = "0"
        
        
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark)) as UIVisualEffectView
        visualEffectView.frame = screen.bounds
        self.addSubview(visualEffectView)
        
        
        for i in 0...4 {
            lesscores.append(Score(nomp: "???", s: 0))
            
            labelscore.append(UITextField())
            labelscore[i].text = lesscores[i].nom + "     0"
            labelscore[i].backgroundColor = UIColor.clearColor()
            labelscore[i].textColor = UIColor.whiteColor()
            labelscore[i].userInteractionEnabled = false
            labelscore[i].textAlignment = NSTextAlignment.Center
            labelscore[i].sizeToFit()
            self.addSubview(labelscore[i])
        }
        
        saisie = UITextField()
        saisie.borderStyle = UITextBorderStyle.RoundedRect
        saisie.text = "entrez votre nom"
        saisie.textColor = UIColor.blackColor()
        saisie.font!.fontWithSize(18)

        saisie.backgroundColor = UIColor.clearColor()
        saisie.backgroundColor = UIColor.grayColor()
        saisie.textAlignment = NSTextAlignment.Left
        saisie.sizeToFit()
        saisie.keyboardType = UIKeyboardType.ASCIICapable
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"begintext:" ,name:UITextFieldTextDidBeginEditingNotification,
            object:nil)
        
        done.addTarget(self, action: "endtext:", forControlEvents: .TouchUpInside)
        
        
        self.addSubview(done)
        self.addSubview(affiche)
        self.addSubview(saisieLabel)
        
        self.addSubview(votreScore)
        self.addSubview(valeurScore)
        self.addSubview(saisie)
   
    }
    
    
    func begintext(sender: UITextField){
        saisie.text = ""
        //NSLog("%i", Int(44))
        if(terminal.userInterfaceIdiom == .Phone){
            saisieLabel.hidden = false
            affiche.hidden = true
            for i in 0...4{
                labelscore[i].hidden = true
            }
            votreScore.hidden = true
            valeurScore.hidden = true
        
            saisie.frame = CGRectMake((screen.bounds.size.width-saisie.frame.width-60)/2.0, CGFloat(40) ,saisie.frame.width+60,saisie.frame.height);
            
        }
    }
    
    
    func addnewscore(sp:Int){
        
        
        newscore = sp
        if(newscore >= minscore){
            
            lesscores[4].value = newscore
            lesscores[4].nom = "???"
            
            for i in  0...3{
                for j in (i+1)...4{
                    if(lesscores[i].value < lesscores[j].value){
                        var tmp = lesscores[i].value
                        lesscores[i].value = lesscores[j].value
                        lesscores[j].value = tmp
                    }
                }
            }
        }
        
        update()
        minscore = lesscores[4].value
    }
    
    func update(){
        
        for i in 0...4{
            labelscore[i].text = lesscores[i].nom + "   " + String(lesscores[i].value)
        }
        
    }
    
    func endtext(sender: UIButton){
        
        if(terminal.userInterfaceIdiom == .Phone){
            saisieLabel.hidden = true
            affiche.hidden = false
            for i in 0...4{
                labelscore[i].hidden = false
            }
            votreScore.hidden = false
            valeurScore.hidden = false
            saisie.frame = CGRectMake((screen.bounds.size.width-saisie.frame.width)/2.0, valeurScore.frame.origin.y+30 ,saisie.frame.width,saisie.frame.height);
            
        }
        
        var ok = true
        if(saisie.text != String("entrez votre nom") && saisie.text != String("")){
            for i in 0...4{
                if(ok && lesscores[i].value == newscore){
                    
                    lesscores[i].nom = saisie.text!
                    ok = false
                }
            }
        }
        
        update()
        saisie.text = "entrez votre nom"
        
        
    }

    required init(coder aDecoder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    

    
    override func drawRect(rect: CGRect) {
        
        var x = 10.0
        var y = 10.0
        
        
        affiche.frame = CGRectMake((rect.size.width-affiche.frame.width)/2.0, CGFloat(y) ,affiche.frame.width,affiche.frame.height);
        
        saisieLabel.frame = CGRectMake((rect.size.width-saisieLabel.frame.width)/2.0, CGFloat(y) ,saisieLabel.frame.width,saisieLabel.frame.height);
        
        
        done.frame = CGRectMake(rect.size.width-(done.frame.width)-CGFloat(x),CGFloat(y),done.frame.width ,done.frame.height);
        
        y += 40
        
        for i in 0...4{
            labelscore[i].text = lesscores[i].nom + "   " + String(lesscores[i].value)
            labelscore[i].frame = CGRectMake((rect.size.width-(rect.size.width-200))/2.0, CGFloat(y) ,rect.size.width-200,labelscore[i].frame.height);
            y += Double(labelscore[i].frame.height)
        }
        
        y += 20
        
        votreScore.frame = CGRectMake((rect.size.width-votreScore.frame.width)/2.0, CGFloat(y) ,votreScore.frame.width,votreScore.frame.height);
        
        y += Double(votreScore.frame.height)
        
        
        valeurScore.frame = CGRectMake((rect.size.width-valeurScore.frame.width)/2.0, CGFloat(y) ,valeurScore.frame.width,valeurScore.frame.height);
        
        y += 30
        saisie.frame = CGRectMake((rect.size.width-saisie.frame.width)/2.0, CGFloat(y) ,saisie.frame.width,saisie.frame.height);
        
    }
    
    
    }
