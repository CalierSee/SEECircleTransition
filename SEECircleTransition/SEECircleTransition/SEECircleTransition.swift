//
//  SEECircleTransition.swift
//  SEECircleTransition
//
//  Created by 景彦铭 on 2016/12/16.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

import UIKit
let animationDuration: TimeInterval = 0.5
class SEECircleTransition: NSObject,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning,CAAnimationDelegate {

    var isPresenting: Bool = true
    
    weak var transitionContext: UIViewControllerContextTransitioning?
    
    private func animation(withView view: UIView) {
        
        //创建遮罩layer
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        //添加遮罩
        view.layer.mask = shapeLayer
        
        let viewWidth: CGFloat = UIScreen.main.bounds.size.width
        let viewHeight: CGFloat = UIScreen.main.bounds.size.height
        
        //起始圆半径
        let beginRadius: CGFloat = 30
        //动画中心点  （圆心中心点,如果要改变动画起始位置请求改这里）
        let animationCenter: CGPoint = CGPoint(x: viewWidth / 2 , y: viewHeight / 2)
        let beginRect: CGRect = CGRect(x: animationCenter.x - beginRadius , y: animationCenter.y - beginRadius / 2, width: beginRadius * 2, height: beginRadius * 2)
        //起始路径
        let beginPath: UIBezierPath = UIBezierPath(ovalIn: beginRect)
        
        //结束圆半径
        let endRadius: CGFloat = sqrt(viewWidth * viewWidth + viewHeight * viewHeight)
        let endRect: CGRect = beginRect.insetBy(dx: -endRadius, dy: -endRadius)
        //结束路径
        let endPath: UIBezierPath = UIBezierPath(ovalIn: endRect)
        
        //动画
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "path")
        animation.fromValue = isPresenting ? beginPath.cgPath : endPath.cgPath
        animation.toValue = isPresenting ? endPath.cgPath : beginPath.cgPath
        animation.duration = transitionDuration(using: transitionContext)
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.delegate = self
        shapeLayer.add(animation, forKey: nil)
    }
    
    //MARK: - UIViewControllerPreviewingDelegate
    ///返回提供展现动画的对象
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    ///返回提供消失动画的对象
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    //MARK: - UIViewControllerAnimatedTransitioning
    //返回转场动画时间
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //1. 得到容器视图
        let container: UIView = transitionContext.containerView
        //2. 得到展现视图
        let view: UIView = transitionContext.view(forKey: isPresenting ? .to : .from)!
        //3. 将展现的视图添加到容器
        container.addSubview(view)
        //4. 动画
        animation(withView: view)
        //5. 记录上下文
        self.transitionContext = transitionContext
    }
    
    //MARK: - CAAnimationDelegate
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        // 转场完成 开启用户交互 ********
        transitionContext?.completeTransition(true)
    }
    
}
