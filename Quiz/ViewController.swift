//
//  ViewController.swift
//  Quiz
//
//  Created by Arian Moslem on 5/14/16.
//  Copyright © 2016 Arian Moslem. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var c​u​r​r​e​n​t​Q​u​e​s​t​i​o​n​L​a​b​e​l​C​e​n​t​e​r​X​C​o​n​s​t​r​a​i​n​t​: NSLayoutConstraint!
    
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var n​e​x​t​Q​u​e​s​t​i​o​n​L​a​b​e​l​C​e​n​t​e​r​X​C​o​n​s​t​r​a​i​n​t​: NSLayoutConstraint!
    
    @IBOutlet var answerLabel: UILabel!
    
    let questions: [String] = ["From what is cognac made?", "What is 7+7", "What is the capital of Vermont?"]
    let answers: [String] = ["Grapes", "14", "Montpelier"]
    var currentQuestionIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let question = questions[currentQuestionIndex]
        currentQuestionLabel.text = question
        
        updateOffScreenLabel()
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        n​e​x​t​Q​u​e​s​t​i​o​n​L​a​b​e​l​C​e​n​t​e​r​X​C​o​n​s​t​r​a​i​n​t​.constant = -screenWidth
    }
    @IBAction func showNextQuestion(sender: AnyObject) {
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(sender: AnyObject) {
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Set the labels initial alpha
        nextQuestionLabel.alpha = 0
    }
    func animateLabelTransitions() {
        
        //Force any outstanding layout changes to occur
        view.layoutIfNeeded()
        
        //Animate the alpha
        //and the center x constraints
        let screenWidth = view.frame.width
        self.n​e​x​t​Q​u​e​s​t​i​o​n​L​a​b​e​l​C​e​n​t​e​r​X​C​o​n​s​t​r​a​i​n​t​.constant = 0
        self.c​u​r​r​e​n​t​Q​u​e​s​t​i​o​n​L​a​b​e​l​C​e​n​t​e​r​X​C​o​n​s​t​r​a​i​n​t​.constant += screenWidth
        UIView.animateWithDuration(0.5, delay: 0, options: [.CurveLinear], animations: {
            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1
            
            self.view.layoutIfNeeded()
            }, completion: { _ in
                swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                swap(&self.c​u​r​r​e​n​t​Q​u​e​s​t​i​o​n​L​a​b​e​l​C​e​n​t​e​r​X​C​o​n​s​t​r​a​i​n​t​, &self.n​e​x​t​Q​u​e​s​t​i​o​n​L​a​b​e​l​C​e​n​t​e​r​X​C​o​n​s​t​r​a​i​n​t​)
                self.updateOffScreenLabel()
        })
    }
}

