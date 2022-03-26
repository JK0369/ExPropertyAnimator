//
//  ViewController.swift
//  ExPropertyAnimator
//
//  Created by 김종권 on 2022/03/26.
//

import UIKit

class ViewController: UIViewController {
  private lazy var startButton: UIButton = {
    let button = UIButton()
    button.setTitle("애니메이션 시작", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    button.setTitleColor(.blue, for: .highlighted)
    button.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(button)
    return button
  }()
  private lazy var pauseButton: UIButton = {
    let button = UIButton()
    button.setTitle("애니메이션 일시중지", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    button.setTitleColor(.blue, for: .highlighted)
    button.addTarget(self, action: #selector(didTapPauseButton), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(button)
    return button
  }()
  private lazy var stopButton: UIButton = {
    let button = UIButton()
    button.setTitle("애니메이션 정지", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    button.setTitleColor(.blue, for: .highlighted)
    button.addTarget(self, action: #selector(didTapStopButton), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(button)
    return button
  }()
  private lazy var addButton: UIButton = {
    let button = UIButton()
    button.setTitle("애니메이션 추가", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    button.setTitleColor(.blue, for: .highlighted)
    button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(button)
    return button
  }()
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(stackView)
    [
      self.startButton,
      self.pauseButton,
      self.stopButton,
      self.addButton
    ].forEach { stackView.addArrangedSubview($0) }
    return stackView
  }()
  private lazy var myView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemBlue
    view.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(view)
    return view
  }()
  
  // 1. 프로퍼티 선언
  var animator: UIViewPropertyAnimator?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NSLayoutConstraint.activate([
      self.stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 56),
      self.stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    ])
    
    NSLayoutConstraint.activate([
      self.myView.heightAnchor.constraint(equalToConstant: 120),
      self.myView.widthAnchor.constraint(equalToConstant: 120),
      self.myView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      self.myView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    ])
    
    // 2. 프러퍼티 초기화
    self.animator = UIViewPropertyAnimator(
      duration: 3.0,
      curve: .easeOut,
      animations: { self.myView.transform = .init(scaleX: 2.0, y: 1.3) }
    )
    
    // 3. completion
    self.animator?.addCompletion { position in
      switch position {
      case .start:
        print("start")
      case .end:
        print("end")
      case .current:
        print("current")
      @unknown default:
        fatalError()
      }
    }
  }
  
  @objc private func didTapStartButton() {
    // 애니메이션 시작 or 재개
    self.animator?.startAnimation()
  }
  @objc private func didTapPauseButton() {
    self.animator?.pauseAnimation()
  }
  @objc private func didTapStopButton() {
    self.animator?.stopAnimation(true)
  }
  @objc private func didTapAddButton() {
    self.animator?.addAnimations {
      self.myView.transform = .init(scaleX: 0.5, y: 0.5)
    }
  }
}
