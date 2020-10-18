//
//  StatesQuestionVC.swift
//  Nhap tich Duc Einbuegerungstest
//
//  Created by Nguyen Quang on 11.05.19.
//  Copyright © 2019 Nguyen Quang. All rights reserved.
//

import UIKit
import SQLite3
import AVFoundation

class StatesQuestionVC: UIViewController {
    
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var btnB: UIButton!
    @IBOutlet weak var btnA: UIButton!
    @IBOutlet weak var btnD: UIButton!
    @IBOutlet weak var btnC: UIButton!
    
    @IBOutlet weak var unitDisplay: UILabel!
    @IBOutlet weak var scoreDisplay: UILabel!
    @IBOutlet weak var timeDisplay: UILabel!
    
    @IBOutlet weak var imga: UIImageView!
    @IBOutlet weak var imgb: UIImageView!
    @IBOutlet weak var imgc: UIImageView!
    @IBOutlet weak var imgd: UIImageView!
    @IBOutlet weak var map: UIImageView!
    
    let is_iphone5_or_less = UIDevice.current.userInterfaceIdiom == .phone &&  max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) <= 568.0
    
    let trueSound = "trueans"
    let falseSound = "falseans"
    
    var questionList : [Question] = []
    var questionIndex = 0
    var score = 0
    var highScore = 0
    var counter = 0.0
    var timer = Timer()
    var isPlaying = false
    var minutes = 0
    var seconds = 0
    var audioPlayer: AVAudioPlayer!
    var unitSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        setUnitDisplay()
        questionList = DBHelper().getData(u: unitSelected).shuffled()
        if(is_iphone5_or_less){
            questionText.font = .systemFont(ofSize: 14)
        }
        setText()
        
    }
    
    //--- Set Unit Display --------------------------
    func setUnitDisplay(){
        var stateName = ""
        switch unitSelected {
        case 12 : stateName = "Baden-Württemberg"    // Baden
        case 13 : stateName = "Bayern"  // Bayern
        case 14 : stateName = "Berlin"    // Berlin
        case 15 : stateName = "Brandenburg"  // Brandenburg
        case 16 : stateName = "Bremen"   // Bremen
        case 17 : stateName = "Hamburg"   // Hamburg
        case 18 : stateName = "Hessen"   // Hessen
        case 19 : stateName = "Mecklenburg-Vorpommern"   // Meckenburg
        case 20 : stateName = "Niedersachsen"    // Niedersachsen
        case 21 : stateName = "Nordrhein-Westfalen"   // NRW
        case 22 : stateName = "Rheinland-Pfalz"  // Rheinland pfalz
        case 23 : stateName = "Saarland"   // Saarland
        case 24 : stateName = "Sachsen"   // Sachsen
        case 25 : stateName = "Sachsen-Anhalt"    // Sachsen Anhalt
        case 26 : stateName = "Schleswig-Holstein"   // Schleswig Holstein
        case 27 : stateName = "Thüringen"   // Thüringen
        default: stateName = "Berlin"
        }
        unitDisplay.text = " " + stateName
    }
    //---- Screen -------------------------------------
    
    func getHighScore() -> Int{
        if((UserDefaults.standard.object(forKey: "HighScore")) == nil){
            UserDefaults.standard.set(1, forKey: "HighScore")
        } else {
            let highScore = UserDefaults.standard.integer(forKey: "HighScore")
            if(score > highScore){
                UserDefaults.standard.set(score, forKey: "HighScore")
            }
        }
        return highScore
    }
    
    func setnewScore(){
        score += 1
        scoreDisplay.text = "\(score) "
    }
    
    //---- Set text for question ------------------------
    func setText(){
        let qu = questionList[questionIndex]
        
        setImage(quest_id: Int(qu.id)!)
        let textquestion = "\(questionIndex+1). "
        
        questionText.text = textquestion + qu.quest
        if(is_iphone5_or_less){
            questionText.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        } else {
            questionText.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
            
        }
        
        let texta = "\n" + qu.a + "\n"
        setButtonProperties(btn: btnA, text: texta)
        setButtonProperties(btn: btnB, text: qu.b)
        setButtonProperties(btn: btnC, text: qu.c)
        setButtonProperties(btn: btnD, text: qu.d)
        /*
         btnA.setTitle(q1.a, for: UIControl.State.Normal)
         btnA.titleLabel.numberOfLines = 0; // Dynamic number of lines
         btnA.titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping;
         */
    }
    
    func setButtonProperties(btn: UIButton, text: String) {
        if(is_iphone5_or_less){
            btn.titleLabel?.font = .systemFont(ofSize: 12)
        }
        btn.setTitle(text, for:.normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = btn.tintColor.cgColor
        btn.layer.cornerRadius = 5
    }
    
    //----- Set Images -----------------------------
    func setImage(quest_id: Int){
        imga.image = nil
        imgb.image = nil
        imgc.image = nil
        imgd.image = nil
        map.image = nil
        
        switch (quest_id){  //Baden
        case 301:
            imga.image = UIImage(named: "b_baden")
            imgb.image = UIImage(named: "b_thueringen")
            imgc.image = UIImage(named: "b_sachan")
            imgd.image = UIImage(named: "b_ham")
            
        case 308:   map.image = UIImage(named: "m308")
            
             //Bayern
             case 311:
             imga.image = UIImage(named: "b_baden")
             imgb.image = UIImage(named: "b_bayern")
             imgc.image = UIImage(named: "b_sachan")
             imgd.image = UIImage(named: "b_meck")
             case 318:   map.image = UIImage(named: "m318")
             
             // Berlin
             case 321 :
             imga.image = UIImage(named: "b_ham")
             imgb.image = UIImage(named: "b_bremen")
             imgc.image = UIImage(named: "b_hessen")
             imgd.image = UIImage(named: "b_berlin")
             case 328:    map.image = UIImage(named: "m328")
             
             //Brandenburg
             case 331 :
             imga.image = UIImage(named: "b_brb")
             imgb.image = UIImage(named: "b_rlf")
             imgc.image = UIImage(named: "b_saarl")
             imgd.image = UIImage(named: "b_baden")
             
             case 338 :  map.image = UIImage(named: "m338")
             
             //Bremen
             case 341 :
             imga.image = UIImage(named: "b_schles")
             imgb.image = UIImage(named: "b_baden")
             imgc.image = UIImage(named: "b_bremen")
             imgd.image = UIImage(named: "b_bayern")
             
             case 348 :    map.image = UIImage(named: "m348")
             //Hamburg
             case 351 :
             imga.image = UIImage(named: "b_niedersa")
             imgb.image = UIImage(named: "b_ham")
             imgc.image = UIImage(named: "b_nrw")
             imgd.image = UIImage(named: "b_sachan")
             
             case 358 :  map.image = UIImage(named: "m358")
             //Hessen
             case 361 :
             imga.image = UIImage(named: "b_hessen")
             imgb.image = UIImage(named: "b_berlin")
             imgc.image = UIImage(named: "b_schless")
             imgd.image = UIImage(named: "b_sachsen")
             
             case 368 :   map.image = UIImage(named: "m368")
            
             //Mecklenburg-Vorpommern
             case 371 :
                imga.image = UIImage(named: "b_hessen")
                imgb.image = UIImage(named: "b_brb")
                imgc.image = UIImage(named: "b_meck")
                imgd.image = UIImage(named: "b_niedersa")

             case 378 :  map.image = UIImage(named: "m378")
             //Niedersachsen
             case 381 :
                imga.image = UIImage(named: "b_bayern")
                imgb.image = UIImage(named: "b_schles")
                imgc.image = UIImage(named: "b_niedersa")
                imgd.image = UIImage(named: "b_sachsen")
            
             case 388 :    map.image = UIImage(named: "m388")
             //NRW
             case 391 :
                imga.image = UIImage(named: "b_bremen")
                imgb.image = UIImage(named: "b_nrw")
                imgc.image = UIImage(named: "b_sachan")
                imgd.image = UIImage(named: "b_baden")
            
             case 398 :    map.image = UIImage(named: "m398")
             //Rheinland-Pfalz
             case 401 :
                imga.image = UIImage(named: "b_rlf")
                imgb.image = UIImage(named: "b_ham")
                imgc.image = UIImage(named: "b_thueringen")
                imgd.image = UIImage(named: "b_schles")
             case 408 :    map.image = UIImage(named: "m408")
             //Saarland
             case 411 :
                imga.image = UIImage(named: "b_rlf")
                imgb.image = UIImage(named: "b_hessen")
                imgc.image = UIImage(named: "b_meck")
                imgd.image = UIImage(named: "b_saarl")
             case 418 :    map.image = UIImage(named: "m418")
             // Sachsen
             case 421 :
                imga.image = UIImage(named: "b_bayern")
                imgb.image = UIImage(named: "b_berlin")
                imgc.image = UIImage(named: "b_niedersa")
                imgd.image = UIImage(named: "b_sachsen");
             case 428:    map.image = UIImage(named: "m428")
             // Sachsen Anhalt
             case 431 :
                imga.image = UIImage(named: "b_bayern")
                imgb.image = UIImage(named: "b_ham")
                imgc.image = UIImage(named: "b_rlf")
                imgd.image = UIImage(named: "b_sachan")
             case 438 :map.image = UIImage(named: "m438")
             
             // Schleswigholstein
             case 441 :
                imga.image = UIImage(named: "b_sachan")
                imgb.image = UIImage(named: "b_berlin")
                imgc.image = UIImage(named: "b_schles")
                imgd.image = UIImage(named: "b_thueringen")
             case 448 : map.image = UIImage(named: "m448")
             // Thüringen
             case 451 :
                imga.image = UIImage(named: "b_baden")
                imgb.image = UIImage(named: "b_meck")
                imgc.image = UIImage(named: "b_sachsen")
                imgd.image = UIImage(named: "b_thueringen")
             case 458 : map.image = UIImage(named: "m458")
            
        default:
            imga.image = nil
            imgb.image = nil
            imgc.image = nil
            imgd.image = nil
            map.image = nil
        }
    }
    //--------- Set time ------------------------------------
    func startTimer(){
        if(isPlaying) {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        isPlaying = true
    }
    
    func pauseTimer(){
        timer.invalidate()
        isPlaying = false
    }
    
    @objc func UpdateTimer() {
        counter = counter + 0.1
        //timeDisplay.text = String(format: "%.1f", counter)
        minutes = Int(counter) / 60 % 60
        seconds = Int(counter) % 60
        timeDisplay.text = String(format:"%02i:%02i", minutes, seconds)
    }
    
    //---- Set Audio  ----------------------------
    func playSound(note: String){
        let soundURL = Bundle.main.url(forResource: note, withExtension: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
        } catch {
            print(error)
        }
        audioPlayer.play()
    }
    //----- Event handle -----------------------------------------------------
    @IBAction func answerSelected(_ sender: UIButton) {
        var selectedAnswer : String
        var correctButton : UIButton
        
        // Find result
        switch questionList[questionIndex].result {
        case "A" : correctButton = btnA
        case "B" : correctButton = btnB
        case "C" : correctButton = btnC
        case "D" : correctButton = btnD
        default  : correctButton = btnA
        }
        
        // Find selected Answer
        switch sender.tag {
        case 1 : selectedAnswer = "A"
        case 2 : selectedAnswer = "B"
        case 3 : selectedAnswer = "C"
        case 4 : selectedAnswer = "D"
        default: selectedAnswer = "A"
        }
        
        // Display result
        if(selectedAnswer == questionList[questionIndex].result){
            // Correct
            sender.backgroundColor = UIColor.green
            playSound(note: trueSound)
            setnewScore()
        } else {
            // Wrong
            playSound(note: falseSound)
            correctButton.backgroundColor = UIColor.green
            sender.backgroundColor = UIColor.red
        }
        // disable Button
        btnA.isEnabled = false
        btnB.isEnabled = false
        btnC.isEnabled = false
        btnD.isEnabled = false
    }
    
    //------ Cancel the test ----------------------------
    @IBAction func exitPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Stop the test?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        })) // Exit
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    //-------- Load the next question --------------------
    @IBAction func loadNextQuestion(_ sender: UIButton) {
        if(questionIndex == questionList.count-1 ){
            finishTest()
            return
        }
        questionIndex += 1
        setText()
        // Enable Button
        btnA.isEnabled = true
        btnB.isEnabled = true
        btnC.isEnabled = true
        btnD.isEnabled = true
        // Set background color for button
        btnA.backgroundColor = UIColor.white
        btnB.backgroundColor = UIColor.white
        btnC.backgroundColor = UIColor.white
        btnD.backgroundColor = UIColor.white
    }
    
    
    
    //----- Test Finish-------------------------
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let lastHighScore = getHighScore()
        if(segue.identifier == "StatesQuestiontoTestResultSb"){
            let sceneResultVC = segue.destination as! TestResultViewController
            sceneResultVC.textFromGeneralQuestion = "\n Last High Score:\(lastHighScore) \n Score:\(score) in \(minutes) mins \(seconds)s "
            sceneResultVC.isPass = isTestPass()
        }
    }
    
    func finishTest(){
        self.performSegue(withIdentifier: "StatesQuestiontoTestResultSb", sender: self)
    }
    
    func isTestPass() -> Bool{
        let score_result = Double(score)
        let index_result = Double(questionIndex+1)
        let procent = score_result / index_result
        print("Procent = \(procent)")
        if(procent > 0.52){
            return true
        } else {
            return false
        }
    }
}
