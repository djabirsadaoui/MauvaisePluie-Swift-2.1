//
//  GameView.swift
//  MauvaisePluieDA
//
//  Created by m2sar on 27/10/2014.
//  Copyright (c) 2014 m2sar. All rights reserved.
//

import UIKit
import Foundation




class GameView:UIView,UIScrollViewDelegate {
    
    
    private let terminal = UIDevice.currentDevice()
    private let screen   = UIScreen.mainScreen()
    
    
    @IBOutlet var bscores: UIButton!
    @IBOutlet var bjouer: UIButton!
    @IBOutlet var bpref: UIButton!

    @IBOutlet var player: UIImageView!
    
    @IBOutlet var droite: UIButton!
    @IBOutlet var gauche: UIButton!
    
    
    @IBOutlet var lscore: UILabel!
    @IBOutlet var lniveau: UILabel!
    @IBOutlet var lfin: UILabel!
    
    @IBOutlet var ctrl: ViewController!
    
    
    private var asteroides = [Asteroide]()
    
    
    private var angle = CGFloat(0.0);
    private var dy = CGFloat(0.0);
    
    private var r : NSTimer?
    private var d : NSTimer?
    
    private var index = 0
    private var currentindex = 0
    private var score = 0
    private var niveau = 1
    
    private var maxastr = 0
    private var maxvv = 0
    private var cpt = 0
    
    
    var width = UInt32(UIScreen.mainScreen().bounds.width)
    var height = UInt32(UIScreen.mainScreen().bounds.height)
    
    
    override init (frame:CGRect){
        
        
        
        super.init(frame:frame);
        
        
        self.backgroundColor = UIColor.clearColor()
        
        player = UIImageView(image: UIImage(named: "player"))
        player.sizeToFit()
        player.hidden = true;
        player.contentMode = UIViewContentMode.ScaleAspectFill
        
        bscores = UIButton(type: UIButtonType.System) as UIButton

        bscores.setTitle("Scores", forState: .Normal)
        bscores.sizeToFit()
        
        bjouer = UIButton(type: UIButtonType.System) as UIButton

        bjouer.setTitle("Jouer", forState: .Normal)
        bjouer.sizeToFit()
        
        bpref = UIButton(type: UIButtonType.System) as UIButton
        bpref.setTitle("Préférences", forState: .Normal)
        bpref.sizeToFit()
        
        
        droite = UIButton(type: UIButtonType.System) as UIButton
        droite.setTitleColor(UIColor.whiteColor(), forState: .Normal);
        droite.setTitle(">>>", forState: .Normal)
        droite.titleLabel?.font = UIFont(name: "TrebuchetMS-Bold", size: 20.0)
        droite.sizeToFit()
        droite.hidden = true;
        
        gauche = UIButton(type: UIButtonType.System) as UIButton
        gauche.setTitleColor(UIColor.whiteColor(), forState: .Normal);
        gauche.setTitle("<<<", forState: .Normal)
        gauche.titleLabel?.font = UIFont(name: "TrebuchetMS-Bold", size: 20.0)
        gauche.sizeToFit()
        gauche.hidden = true;
        
        lscore = UILabel()
        lscore.text = "Score : 0"
        lscore.textColor = UIColor.whiteColor()
        lscore.textAlignment = NSTextAlignment.Right
        lscore.hidden = true
        lscore.sizeToFit()
        
        lniveau = UILabel()
        lniveau.text = "Niveau : 0"
        lniveau.textColor = UIColor.whiteColor()
        lniveau.textAlignment = NSTextAlignment.Left
        lniveau.hidden = true
        lniveau.sizeToFit()
        
        lfin = UILabel()
        lfin.text = "AAAAAARG..."
        lfin.textColor = UIColor.whiteColor()
        lfin.textAlignment = NSTextAlignment.Center
        lfin.font = UIFont.boldSystemFontOfSize(30.0)
        lfin.hidden = true
        lfin.sizeToFit()
        
        
        self.addSubview(bscores);
        self.addSubview(bjouer);
        self.addSubview(bpref);
        
        self.addSubview(player);
        self.addSubview(droite);
        self.addSubview(gauche);
        self.addSubview(lscore);
        self.addSubview(lniveau);
        self.addSubview(lfin)
        
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collisions(x:CGFloat, y:CGFloat, widthp:CGFloat, heightp:CGFloat)->Bool{
        
        /*
        var points = [MyPoint]()
        
        points.append(MyPoint(dx: x, dy: y))                //p1
        points.append(MyPoint(dx: x+widthp, dy: y))         //p2
        points.append(MyPoint(dx: x+widthp, dy: y+heightp)) //p3
        points.append(MyPoint(dx: x, dy: y+heightp))        //p4
        
        points.append(MyPoint(dx: x+widthp/2, dy: y+heightp/2)) //center
        points.append(MyPoint(dx: x+widthp/2, dy: y))           //p1
        points.append(MyPoint(dx: x+widthp, dy: y+heightp/2))   //p2
        points.append(MyPoint(dx: x+widthp/2, dy: y+heightp))   //p3
        points.append(MyPoint(dx: x, dy: y+heightp/2))          //p4
        
        for p in points{
        if p.x >= (player.center.x-(player.frame.width/2.0)+10) &&
            p.x <= (player.center.x+(player.frame.width/2.0)-10) &&
            p.y >= (player.center.y-(player.frame.height/2.0)+10) &&
            p.y <= (player.center.x+(player.frame.height/2.0)-10) {
                
                //r?.invalidate()
                return true
                
                
            }
        }
        return false;
        */
       
        let px = player.center.x
        let py = player.center.y
        let pw = player.frame.width
        let ph = player.frame.height
        
        return abs(x - px ) <= (pw + widthp-20)/2 && abs(y - py) <= (ph + heightp-20)/2
        //return false;
    }
    
    func attendre(time : NSTimer){
        ctrl.gotoscore(score)
    }
    
    
    func bouger(time : NSTimer){
        if(droite.tag == 1){
            if(player.center.x < CGFloat(width)){
                player.center.x += 3
            }
        }
        
        if(gauche.tag == 1){
            if(player.center.x > CGFloat(0)){
                player.center.x -= 3
            }
        }

    }
    
    
    func faireTourner(time : NSTimer){
        
        if (proba()){
            
            asteroides[currentindex].image.hidden = false;
            index++
            currentindex++
            if(currentindex == maxastr){
                currentindex = 0
            }
            
        }
        
        for var i = 0; i < maxastr; i++ {
            
            if(asteroides[i].image.hidden == false){
                
                
                asteroides[i].angle += asteroides[i].vitesser
                //asteroides[i].dy += asteroides[i].vitesse
                //asteroides[i].dx += asteroides[i].vitessex
                
                asteroides[i].image.center.y += asteroides[i].vitesse
                asteroides[i].image.center.x += asteroides[i].vitessex
                
                
                var coli = collisions(asteroides[i].image.center.x,
                    y: asteroides[i].image.center.y,
                    widthp: asteroides[i].image.frame.width,
                    heightp: asteroides[i].image.frame.height)
                if coli {
                    
                    
                                for astr in asteroides {
                                    astr.image.hidden = true;
                                }
                    lfin.hidden = false;
                    player.center.x = (CGFloat(width)-(player.frame.width/2.0))/2.0
                    r?.invalidate()
                    d?.invalidate()
                    r = NSTimer.scheduledTimerWithTimeInterval(2, target: self,selector:"attendre:",userInfo:nil,repeats:false)
                                
                
                }else{
                
                
                //if(CGFloat(asteroides[i].dy) > CGFloat(height+10)){
                if(CGFloat(asteroides[i].image.center.y) > CGFloat(height+10)){
                    //asteroides[i].dy = 0.0
                    //asteroides[i].image.center.y = 0
                    asteroides[i].image.image = UIImage(named:getTypeAsteroide())
                    //asteroides[i].dx = CGFloat(arc4random_uniform(width))
                    asteroides[i].image.center.x = CGFloat(arc4random_uniform(width))
                    //asteroides[i].image.center.x = asteroides[i].dx
                    asteroides[i].vitessex = CGFloat(randInRange(-2...2))
                
                    asteroides[i].image.center.y = 0 - asteroides[i].image.frame.height/2;
                    asteroides[i].vitesse = CGFloat(4+arc4random_uniform(UInt32(0+2*niveau)))
                    asteroides[i].vitesser = CGFloat(CGFloat(randInRange(-3...3))/10.0)
                    //Float(arc4random_uniform(3))/Float(10))
                    score++
                    asteroides[i].image.hidden = true;
                    lscore.text = "Score : " + String(score)
                
                }
            
                
                if(asteroides[i].image.center.x > CGFloat(width) && asteroides[i].vitessex > 0.0){
                    
                
                    //asteroides[i].dx = 0.0 - asteroides[i].image.frame.width/2;
                    asteroides[i].image.center.x = 0 - asteroides[i].image.frame.width/2;

                }
            

                if(Double(asteroides[i].image.center.x) < Double(0) && asteroides[i].vitessex < 0.0){
                        

                    asteroides[i].image.center.x = CGFloat(width) + asteroides[i].image.frame.width/2;
                    asteroides[i].dx = CGFloat(width) + asteroides[i].image.frame.width/2;

                }
            
            
                asteroides[i].image.transform = CGAffineTransformMakeRotation(asteroides[i].angle)
                asteroides[i].image.center.x +=  asteroides[i].vitessex
                asteroides[i].image.center.y +=  asteroides[i].vitesse
                //asteroides[i].image.transform = CGAffineTransformMake(cos(asteroides[i].angle), sin(asteroides[i].angle), -sin(asteroides[i].angle), cos(asteroides[i].angle), asteroides[i].dx, asteroides[i].dy);
                
                //asteroides[i].image.transform = CGAffineTransformMake(cos(asteroides[i].angle), sin(asteroides[i].angle), -sin(asteroides[i].angle), cos(asteroides[i].angle), asteroides[i].dx, asteroides[i].dy);
                }
            }
        }
        //ast.transform = CGAffineTransformMake(cos(angle), sin(angle), -sin(angle), cos(angle), 0, dy)
        //ast2.transform = CGAffineTransformMake(cos(angle), sin(angle), -sin(angle), cos(angle), 0, dy)
        
    }
    
    func start(niveaup:Int,ref:ViewController){
        
        ctrl = ref
        
        currentindex = 0
        index = 0
        niveau = niveaup
        //niveau = 5
        
        lscore.text = "Score : 0"
        lniveau.text = "Niveau : " + String(niveau)
        
   
        
        if(terminal.userInterfaceIdiom == .Phone){
            maxastr = 20+(10*niveau)
            //maxastr = 1
        }else{
            maxastr = 50+(10*niveau)
        }
        
        maxvv = 3+2*niveau
        
        var sss :Asteroide
        for var i = 0; i < maxastr; i++ {
            asteroides.append(Asteroide(idp:i ,name:getTypeAsteroide(),dxp: CGFloat(arc4random_uniform(width)),
                dyp:0.0,vitess:CGFloat(4+arc4random_uniform(UInt32(0+2*(niveau)))),vitessr:CGFloat(Float(arc4random_uniform(10))/Float(10)),
                //vitessx:CGFloat(random() % 5)));
            vitessx:CGFloat(randInRange(-2...2))))
            asteroides[i].image.hidden = true
            self.addSubview(asteroides[i].image)
            
            asteroides[i].image.center = CGPointMake(asteroides[i].dx,0)
        }
        
        

        var intervalle = NSTimeInterval(0.045 - (0.005*CGFloat(niveau)))
        r = NSTimer.scheduledTimerWithTimeInterval(intervalle, target: self,selector:"faireTourner:",userInfo:nil,repeats:true)
        var intervButton = NSTimeInterval(0.01)
        d = NSTimer.scheduledTimerWithTimeInterval(intervButton, target: self,selector:"bouger:",userInfo:nil,repeats:true)
        
    }
    
    
    func randInRange(range: Range<Int>) -> Int {
        // arc4random_uniform(_: UInt32) returns UInt32, so it needs explicit type conversion to Int
        // note that the random number is unsigned so we don't have to worry that the modulo
        // operation can have a negative output
        return  Int(arc4random_uniform(UInt32(range.endIndex + 1 - range.startIndex))) + range.startIndex
    }
    
    func proba()->Bool{
        if( (arc4random_uniform(101)+UInt32(cpt)) < 15 || cpt == 30){
            cpt = 0
            return true
        }else{
            cpt += 1
            return false
        }
    }
    
    func getTypeAsteroide()->String{
        var name = ""
        var rand = arc4random_uniform(4)
        
        if(terminal.userInterfaceIdiom == .Pad){
            rand += 4
        }
        
        switch(rand){
            case 0: name="asteroide-100-01"; break
            case 1: name="asteroide-100-02"; break
            case 2: name="asteroide-100-03"; break
            case 3: name="asteroide-100-04"; break
            case 4: name="asteroide-120-01"; break
            case 5: name="asteroide-120-02"; break
            case 6: name="asteroide-120-03"; break
            case 7: name="asteroide-120-04"; break
            default: name="asteroide-120-01" ;break
            
        }
        
                return name;
    }
    
    
    
    //override func shouldAutorotate() -> Bool{
    func shouldAutorotate() -> Bool{
        // This method is the same for all the three custom ViewController
        return false
    }
    

    override func drawRect(rect: CGRect) {
        
        let x = 10
        let y = 0
        
        
        //fond.frame = CGRectMake(0,CGFloat((rect.size.height/2)-15),rect.size.width,rect.size.height);
        
        
        player.frame = CGRectMake((rect.size.width-(player.frame.width/2))/2,rect.size.height-50,40,40);
        
        bscores.frame = CGRectMake(CGFloat(x),CGFloat(y),bscores.frame.width,bscores.frame.height);
        
        lniveau.frame = CGRectMake(CGFloat(x),CGFloat(y),lniveau.frame.width,lniveau.frame.height);
        
        lfin.frame = CGRectMake((rect.size.width-lfin.frame.width)/2,
                                (rect.size.height-lfin.frame.height)/2
                                ,lfin.frame.width,lfin.frame.height);
        
        
        bjouer.frame = CGRectMake(CGFloat((rect.size.width-bjouer.frame.width)/2),CGFloat(y),bjouer.frame.width,bjouer.frame.height);
        
        bpref.frame = CGRectMake(rect.size.width-bpref.frame.width-CGFloat(x),CGFloat(y),bpref.frame.width,bpref.frame.height);
        
        lscore.frame = CGRectMake(rect.size.width-(lscore.frame.width+50)-CGFloat(x),CGFloat(y),lscore.frame.width+50,lscore.frame.height);
        
        droite.frame = CGRectMake(rect.size.width-(droite.frame.width*2)-CGFloat(x),rect.size.height-(droite.frame.height*2)-10,droite.frame.width*2,droite.frame.height*2);
        
        gauche.frame = CGRectMake(CGFloat(x),rect.size.height-(gauche.frame.height*2)-10,gauche.frame.width*2,gauche.frame.height*2);
        
     
        
    }
    
    
}


