//
//  GeneralQuestionWithImgVC.swift
//  Nhap tich Duc Einbuegerungstest
//
//  Created by Nguyen Quang on 27.02.19.
//  Copyright © 2019 Nguyen Quang. All rights reserved.
//

import UIKit
import AVFoundation

class GeneralQuestionWithImgVC: UIViewController {
    
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var btnA: UIButton!
    @IBOutlet weak var btnB: UIButton!
    @IBOutlet weak var btnC: UIButton!
    @IBOutlet weak var btnD: UIButton!
    
    @IBOutlet weak var unitDisplay: UILabel!
    @IBOutlet weak var scoreDisplay: UILabel!
    @IBOutlet weak var timeDisplay: UILabel!
    
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
    
    override func viewDidLoad(){
        super.viewDidLoad()
        unitDisplay.text = " Unit \(unitSelected)"
        startTimer()
        questionList = DBHelper().getData(u: unitSelected).shuffled()
        if(is_iphone5_or_less){
            questionText.font = .systemFont(ofSize: 14)
        }
        setTextAndImage()
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
    
    func setTextAndImage(){
        let q1 = questionList[questionIndex]
        let textquestion = "\(questionIndex+1). "
        questionText.text = textquestion + q1.quest
        //btnA.setImage( UIImage.init(named: "a130a"), for: .normal)
        getImageSrc()
    }
    
    func getImageSrc() {
        switch (Int(questionList[questionIndex].id)) {
        case 21:
            setImageButton(btn: btnA, btnSrc: "a21a")
            setImageButton(btn: btnB, btnSrc: "a21b")
            setImageButton(btn: btnC, btnSrc: "a21c")
            setImageButton(btn: btnD, btnSrc: "a21d")
        case 130:
            setImageButton(btn: btnA, btnSrc: "a130a")
            setImageButton(btn: btnB, btnSrc: "a130b")
            setImageButton(btn: btnC, btnSrc: "a130c")
            setImageButton(btn: btnD, btnSrc: "a130d")
        case 226:
            setImageButton(btn: btnA, btnSrc: "a226a")
            setImageButton(btn: btnB, btnSrc: "a226b")
            setImageButton(btn: btnC, btnSrc: "a226c")
            setImageButton(btn: btnD, btnSrc: "a226d")
        default:
            setImageButton(btn: btnA, btnSrc: "a21a")
            setImageButton(btn: btnB, btnSrc: "a21b")
            setImageButton(btn: btnC, btnSrc: "a21c")
            setImageButton(btn: btnD, btnSrc: "a21d")
        }
    }
    
    func setImageButton(btn: UIButton, btnSrc: String){
        btn.setImage(UIImage.init(named: btnSrc), for: .normal)
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
    
    //---------- Cancel the test --------------------
    @IBAction func exitPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Stop the test?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        })) // Exit
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    //----- Load the next question ----------------------
    @IBAction func loadNextQuestion(_ sender: UIButton) {
        if(questionIndex == questionList.count-1 ){
            finishTest()
            return
        }
        questionIndex += 1
        setTextAndImage()
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
        if(segue.identifier == "GeneralQuestionWithImgtoResult"){
            let sceneResultVC = segue.destination as! TestResultViewController
            sceneResultVC.textFromGeneralQuestion = "\n Last High Score:\(lastHighScore) \n Score:\(score) in \(minutes) mins \(seconds)s "
            sceneResultVC.isPass = isTestPass()
        }
    }
    
    func finishTest(){
        self.performSegue(withIdentifier: "GeneralQuestionWithImgtoResult", sender: self)
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
