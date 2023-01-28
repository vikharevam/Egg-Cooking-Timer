//
//  ViewController.swift
//  Egg Cooking Timer
//
//  Created by Александр Вихарев on 26.01.2023.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    @IBOutlet weak var Indicator: UILabel!
    
    @IBOutlet weak var ProgressBar: UIProgressView!
    
    
    let eggsDict = ["Soft": 300, "Medium": 420, "Hard": 720 ]
    var timer = Timer()
    var secondPassed = 0
    var player: AVAudioPlayer?
    
    
 override func viewDidLoad() {
     ProgressBar.progress = 0.0
     self.Indicator.text = "Какие яйца готовим?"
       
    }
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        let hardness = sender.currentTitle! //Получение значения твердоси
        let totalTime = eggsDict[hardness]! //Общее время полученное со словаря
        secondPassed = 0 //Пройденное время
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.secondPassed < totalTime { //условие если пойденное время меньше общего
                
                self.secondPassed += 1 //увеличиваем на единицу и перезаписываем значение в переменную
                self.ProgressBar.progress = Float(self.secondPassed) / Float(totalTime) //меняем индикацию прогресс бара после вычислений, чтобы результат был точным.
                self.Indicator.text = "Осталось \(String(Int(Float(totalTime) - Float(self.secondPassed)))) секунд"
                
            } else { //как только условме вернет false, код переходит в блок else
                self.Indicator.text = "Готово!"//На табло отображается результат
                Timer.invalidate() //Таймер обнуляется
                playSound() //воспроизвести звук
                sleep(4)
                self.Indicator.text = "Какие яйца готовим?"
                self.ProgressBar.progress = 0.0
    
            }
        }
        
       
        
        func playSound() {
            guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
                return }
            let url = URL(fileURLWithPath: path)
            
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
