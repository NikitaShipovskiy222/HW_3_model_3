
import UIKit

//MARK: - Eye Button
final class EyeButton: UIButton {
    
    //MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupEyeButton()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Setup Button
    private func setupEyeButton() {
        setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        tintColor = .lightGray
        widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    }
    
}

