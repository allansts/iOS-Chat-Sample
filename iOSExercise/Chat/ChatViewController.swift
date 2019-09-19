//
//  ChatViewController.swift
//  iOSExercise
//
//  Created by Allan Santos on 14/09/19.
//  Copyright © 2019 Allan Santos. All rights reserved.
//

import UIKit
import InputBarAccessoryView

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var inputBar = InputBarAccessoryView()
    fileprivate var keyboardManager: KeyboardManager!
    
    @IBOutlet weak var bubbleImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var bubbleBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var bubbleWidthConstraint: NSLayoutConstraint!
    fileprivate var bottomConstant: CGFloat = 0.0
    
    fileprivate var stackNavigation: UIStackView!
    private var newSections: [Int] = []
    
    var viewModel = ChatViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    fileprivate func setup() {
        setupTable()
        setupNavigationTitle()
        setupInputBarKeyboard()
    }
    
    fileprivate func sendMessage(_ text: String, _ incomming: Bool = false) {
        if !viewModel.addNewMessage(text, incomming) {
            let alert = UIAlertController(title: "Error", message: "Currently unable to send your message", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        let indexPath = viewModel.getLastIndexPath()
        
        self.tableView.beginUpdates()
        if !self.newSections.contains(indexPath.section) {
            self.newSections.append(indexPath.section)
            self.tableView.insertSections(IndexSet(arrayLiteral: indexPath.section), with: .bottom)
        }
        self.tableView.insertRows(at: [indexPath], with: .bottom)
        self.tableView.endUpdates()
        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
        // Disabled message animation it's awful
//        if !viewModel.getLastMessage().isIncoming {
//            bubbleAnimation(text)
//        }
        
    }
    
    fileprivate func bubbleAnimation(_ text: String) {
        bubbleBottomConstraint.constant = bottomConstant
        bubbleWidthConstraint.priority = UILayoutPriority(rawValue: 999)
        bubbleView.isHidden = false
        bubbleView.alpha = 0.0
        
        self.view.layoutIfNeeded()
        messageLabel.text = text
        viewModel.checkEmoji(messageLabel, bubbleImageView)
        
        if viewModel.getLastMessage().tail {
            viewModel.setupBubbleImageWithTail(bubbleImageView, false)
        } else {
            viewModel.setupBubbleImage(bubbleImageView, false)
        }
        
        self.view.bringSubviewToFront(bubbleView)
        
        bubbleBottomConstraint.constant += 55
        bubbleWidthConstraint.priority = UILayoutPriority.defaultLow
        UIView.animate(withDuration: 0.3, animations: {
            self.bubbleView.alpha = 1
            self.view.layoutIfNeeded()
            
        }) { (completion) in
            if completion {
                self.bubbleView.alpha = 0.2
                self.bubbleView.isHidden = true
                self.messageLabel.text = ""
            }
        }
    }
    
    @objc fileprivate func hideKeyboard(_ : UIGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func onSimulateReceivedClicked(_ sender: Any) {
        sendMessage(BaseRepository.shared.getRandomQuote(), true)
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BubbleTableViewCell.cellId) as! BubbleTableViewCell
        
        let message = viewModel.sections[indexPath.section].messages[indexPath.row]
        
        cell.bindViewModel(BubbleCellModelView(message))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        label.attributedText = viewModel.sections[section].date.sectionDateFormat()
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        sendMessage(text)
        inputBar.inputTextView.text = ""
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, textViewTextDidChangeTo text: String) {
        
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didChangeIntrinsicContentTo size: CGSize) {
        tableView.contentInset.bottom = size.height + inputBar.bounds.height
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didSwipeTextViewWith gesture: UISwipeGestureRecognizer) {
        
    }
}

extension ChatViewController {
    
    fileprivate func setupTable() {
        tableView.register(UINib(nibName: BubbleTableViewCell.nibName, bundle: nil),
                           forCellReuseIdentifier: BubbleTableViewCell.cellId)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.contentInset.bottom = 50
        tableView.scrollIndicatorInsets.bottom = 50
        tableView.scrollToBottom()
    }
    
    fileprivate func setupNavigationTitle() {
        let customView = CustomTitleView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        customView.imageView.image = UIImage(named: viewModel.user.picture ?? "") ?? #imageLiteral(resourceName: "batman_hero")
        customView.nameLabel.text = viewModel.user.name
        self.navigationItem.titleView = customView
    }
    
    fileprivate func setupInputBarKeyboard() {
        view.addSubview(inputBar)
        inputBar.delegate = self
        inputBar.inputTextView.placeholder = "Aa"
        inputBar.sendButton.setTitle("SEND", for: .normal)
        
        keyboardManager = KeyboardManager(inputAccessoryView: inputBar)
        keyboardManager.bind(to: tableView)
        
        keyboardManager.on(event: .didChangeFrame) { [weak self] (notification) in
            let barHeight = self?.inputBar.bounds.height ?? 0
            self?.tableView.contentInset.bottom = barHeight + notification.endFrame.height
            self?.tableView.scrollIndicatorInsets.bottom = barHeight + notification.endFrame.height
            }.on(event: .didHide) { [weak self] _ in
                let barHeight = self?.inputBar.bounds.height ?? 0
                self?.bottomConstant = barHeight
                UIView.animate(withDuration: 0.5, animations: {
                    self?.tableView.contentInset.bottom = barHeight
                    self?.tableView.scrollIndicatorInsets.bottom = barHeight
                })
        }
        
        keyboardManager.on(event: .didShow) { [weak self] (notification) in
            let barHeight = self?.inputBar.bounds.height ?? 0
            self?.bubbleBottomConstraint.constant = notification.endFrame.height
            self?.bottomConstant = notification.endFrame.height
            self?.tableView.contentInset.bottom = barHeight + notification.endFrame.height
            self?.tableView.scrollIndicatorInsets.bottom = barHeight + notification.endFrame.height
            self?.tableView.scrollToBottom()
            self?.view.layoutIfNeeded()
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        self.view.addGestureRecognizer(tap)
    }
}
