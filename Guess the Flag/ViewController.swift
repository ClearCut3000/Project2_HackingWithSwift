//
//  ViewController.swift
//  Project2_HackingWithSwift
//
//  Created by Николай Никитин on 04.12.2021.
//

import UIKit

class ViewController: UIViewController {

  //MARK: - Properties
  @IBOutlet var buttonOne: UIButton!
  @IBOutlet var buttonTwo: UIButton!
  @IBOutlet var buttonThree: UIButton!

  var contries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "us", "uk"]
  var score = 0 {
    didSet {
      if score <= 0 {
        self.score = 0
      }
    }
  }
  var count = 10 {
    didSet {
      if count == 0 {
        let alert = UIAlertController(title: "End of round!", message: "You scored \(score)!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "New round", style: .default, handler: {[self] (_) in
          score = 0
          count = 10
          askQuestion(action: nil)
        }))
        present(alert, animated: true)
      }
    }
  }
  var correctAnswer = 0

  //MARK: - UIViewController methods
  override func viewDidLoad() {
    super.viewDidLoad()
    askQuestion(action: nil)
    buttonOne.layer.borderWidth = 1
    buttonTwo.layer.borderWidth = 1
    buttonThree.layer.borderWidth = 1

    buttonOne.layer.borderColor = UIColor.lightGray.cgColor
    buttonTwo.layer.borderColor = UIColor.lightGray.cgColor
    buttonThree.layer.borderColor = UIColor.lightGray.cgColor
  }

  //MARK: - Methods
  func askQuestion(action: UIAlertAction!) {
    contries.shuffle()
    correctAnswer = Int.random(in: 0...2)
    buttonOne.setImage(UIImage(named: contries[0]), for: .normal)
    buttonTwo.setImage(UIImage(named: contries[1]), for: .normal)
    buttonThree.setImage(UIImage(named: contries[2]), for: .normal)
    title = "Score: \(score) \(contries[correctAnswer].uppercased()) Left: \(count)"
  }


  @IBAction func buttonTapped(_ sender: UIButton) {
    var title: String
    var message: String
    count -= 1
    if sender.tag == correctAnswer {
      title = "Correct"
      score += 1
    } else {
      title = "Wrong!"
      score -= 1
    }
    if title == "Wrong!" {
      message = "That’s the flag of \(contries[sender.tag].uppercased())\nYour score is \(score)"
    } else {
      message = "Wright!\nYour score is \(score)"
    }
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
    present(alert, animated: true)
  }

}

