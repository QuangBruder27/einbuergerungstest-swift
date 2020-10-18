//
//  GeneralQuestionVC.swift
//  Nhap tich Duc Einbuegerungstest
//
//  Created by Nguyen Quang on 20.02.19.
//  Copyright © 2019 Nguyen Quang. All rights reserved.
//

import UIKit
import SQLite3
import AVFoundation
import GoogleMobileAds

class GeneralQuestionVC: UIViewController {

    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var btnB: UIButton!
    @IBOutlet weak var btnA: UIButton!
    @IBOutlet weak var btnD: UIButton!
    @IBOutlet weak var btnC: UIButton!
    
    @IBOutlet weak var unitDisplay: UILabel!
    @IBOutlet weak var scoreDisplay: UILabel!
    @IBOutlet weak var timeDisplay: UILabel!
    
    @IBOutlet weak var bannerViewGQ1: GADBannerView!
    
    
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
        
        unitDisplay.text = " Unit \(unitSelected)"
        startTimer()
        questionList = DBHelper().getData(u: unitSelected).shuffled()
        if(is_iphone5_or_less){
            questionText.font = .systemFont(ofSize: 14)
        }
        setText()
        
        if(unitSelected == 1){
            setAdmob()
        }
    }
    
    //----- Set admob ---------------------------
    func setAdmob(){
        // real UnitID 1:   ca-app-pub-2440183521770590/9348176488
        // real UnitID 2:   ca-app-pub-2440183521770590/9156604793
        // real UnitID 3:   ca-app-pub-2440183521770590/2591196444
        // test UnitID: ca-app-pub-3940256099942544/2934735716
        bannerViewGQ1.adUnitID = "ca-app-pub-2440183521770590/2591196444"
        bannerViewGQ1.rootViewController = self
        bannerViewGQ1.load(GADRequest())
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
    
    func setText(){
        let qu = questionList[questionIndex]
        let textquestion = "\(questionIndex+1). "
        
        questionText.text = textquestion + qu.quest
        if(qu.id == "289" || qu.id == "267" || qu.id == "235" || qu.id == "70" || qu.id == "102" || is_iphone5_or_less){
           questionText.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        } else {
            questionText.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        }
        
        let texta = "\n" + qu.a + "\n\n"
        setButtonProperties(btn: btnA, text: texta, qu: qu)
        setButtonProperties(btn: btnB, text: qu.b, qu: qu)
        setButtonProperties(btn: btnC, text: qu.c, qu: qu)
        setButtonProperties(btn: btnD, text: qu.d, qu: qu)
    }
    
    func setButtonProperties(btn: UIButton, text: String, qu: Question) {
        if(is_iphone5_or_less || qu.id == "5"){
            btn.titleLabel?.font = .systemFont(ofSize: 12)
        } else {
            btn.titleLabel?.font = .systemFont(ofSize: 15)
        }
        btn.setTitle(text, for:.normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = btn.tintColor.cgColor
        btn.layer.cornerRadius = 5
    }
    
    
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
    
    @IBAction func exitPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Stop the test?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        })) // Exit
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
 
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let lastHighScore = getHighScore()
        if(segue.identifier == "GeneralQuestiontoResult"){
            let sceneResultVC = segue.destination as! TestResultViewController
            sceneResultVC.textFromGeneralQuestion = "\n Last High Score:\(lastHighScore) \n Score:\(score) in \(minutes) mins \(seconds)s "
            sceneResultVC.isPass = isTestPass()
        }
    }

//----- Test Finish-------------------------
    func finishTest(){
        self.performSegue(withIdentifier: "GeneralQuestiontoResult", sender: self)
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
