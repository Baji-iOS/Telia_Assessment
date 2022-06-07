//
//  Helpers.swift
//  iOS_Assessment
//
//  Created by Baji on 07/06/22.
//

import UIKit

class ProgressView {

    // MARK: - Variables
    private var containerView = UIView()
    private var progressView = UIView()
    private var activityIndicator = UIActivityIndicatorView()

    static var shared = ProgressView()

    // To close for instantiation
    private init() {}

    // MARK: - Functions
     func startAnimating(view: UIView = UIApplication.shared.windows.filter {$0.isKeyWindow}.first!) {
        containerView.center = view.center
        containerView.frame = view.frame
        containerView.backgroundColor = .clear

        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = containerView.center
        progressView.backgroundColor = .clear
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10

        activityIndicator.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        activityIndicator.center = CGPoint(x: progressView.bounds.width/2, y: progressView.bounds.height/2)

        activityIndicator.style = .large

        view.addSubview(containerView)
        containerView.addSubview(progressView)
        progressView.addSubview(activityIndicator)

        activityIndicator.startAnimating()
    }

    /// animate UIActivityIndicationView without blocking UI
    func startSmoothAnimation(view: UIView = UIApplication.shared.windows.filter {$0.isKeyWindow}.first!) {
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        activityIndicator.center = view.center
        activityIndicator.style = .large
        activityIndicator.color = .gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    func stopAnimatimating() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }

}
