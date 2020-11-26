
import UIKit

class AnimateButton: UIButton {
    
    // MARK: - Public properties
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("AnimateButton: touchesBegan")
        
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("AnimateButton: touchesEnded")
        
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("AnimateButton: touchesCancelled")
        
        super.touchesCancelled(touches, with: event)
    }
    
    var animateTime: CFTimeInterval
    var rotationAngle: Double
    var changePosition: CGFloat
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var view = super.hitTest(point, with: event)
        print("AnimateButton hitTest: \(view)")
        
        return super.hitTest(point, with: event)
    }
    
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                backgroundColor = .green
            }
            else {
                backgroundColor = .gray
            }
            super.isHighlighted = newValue
        }
    }
    
    // MARK: - Initializers
    
    init(animateTime: CFTimeInterval, rotationAngle: Double, changePosition: CGFloat) {
        self.animateTime = animateTime
        self.rotationAngle = rotationAngle
        self.changePosition = changePosition
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private properties
    
    private let rotationKeyPath = "transform.rotation.z"
    private let positionXKeyPath = "position.x"
    private let positionYKeyPath = "position.y"
    private let animateKey = "animateKey"
    private var initialPosition: CGPoint?
    
    // MARK: - Public methods
    
    /// Начать анимацию
    func startAnimate() {
        initialPosition = center
        
        let rotateAnimation = CAKeyframeAnimation(keyPath: rotationKeyPath)
        rotateAnimation.values = [0, rotationAngle, 0, -rotationAngle, 0]
        rotateAnimation.beginTime = animateTime / 5
        rotateAnimation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        rotateAnimation.isAdditive = true

        let upDownAnimation = CAKeyframeAnimation(keyPath: positionYKeyPath)
        upDownAnimation.values = [0, -changePosition, 0, changePosition, 0]
        upDownAnimation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        upDownAnimation.isAdditive = true

        let lefRightAnimation = CAKeyframeAnimation(keyPath: positionXKeyPath)
        lefRightAnimation.values = [0, -changePosition, 0, changePosition, 0]
        lefRightAnimation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        lefRightAnimation.isAdditive = true

        let group = CAAnimationGroup()
        group.duration = animateTime
        group.animations = [rotateAnimation, upDownAnimation, lefRightAnimation]
        group.repeatCount = .infinity
        group.isRemovedOnCompletion = false

        layer.add(group, forKey: animateKey)
    }
    
    /// Прекратить анимацию
    func stopAnimate() {
        
        let rot = CABasicAnimation(keyPath: rotationKeyPath)
        rot.fromValue = layer.presentation()?.value(forKeyPath: rotationKeyPath)
        rot.toValue = 0
        rot.isAdditive = true
        
        let up = CABasicAnimation(keyPath: positionYKeyPath)
        up.fromValue = layer.presentation()?.value(forKeyPath: positionYKeyPath)
        up.toValue = initialPosition?.y

        let left = CABasicAnimation(keyPath: positionXKeyPath)
        left.fromValue = layer.presentation()?.value(forKeyPath: positionXKeyPath)
        left.toValue = initialPosition?.x

        let group = CAAnimationGroup()
        group.duration = animateTime
        group.animations = [rot, up, left]

        layer.add(group, forKey: animateKey)
    }
}
