//
//  Expo1900 - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit
enum TestError: Error {
    case testError
}
class ViewController: UIViewController {

    //MARK: - Label
    @IBOutlet weak var pairTitleLabel: UILabel!
    @IBOutlet weak var pairSecondTitleLabel: UILabel!
    @IBOutlet weak var pariVisitorsLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK: - Button
    
    var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        obtainExpositionData { (result: Result<Exposition, TestError>) in
            switch result {
            case .success(let data):
                let titles = data.title.components(separatedBy: "(")
                
                if let firstTitle = titles.first, let secondTitle = titles.last {
                    self.pairTitleLabel.text = firstTitle
                    self.pairSecondTitleLabel.text = "(\(secondTitle)"
                }
                guard let visitor = self.numberFormatter.string(for: data.visitors) else { return }
                self.pariVisitorsLabel.text = "\(visitor) 명"
                self.locationLabel.text = "\(data.location)"
                self.durationLabel.text = "\(data.duration)"
                self.descriptionLabel.text = "\(data.description)"
                
                
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
        
    }
    //리턴으로 했을 때와, 이렇게 escaping completion을 통해서 했을 때 result의 사용 가능 불가능 판단?!
    //리턴형으로 했을 때 처리가 안되서 escaping을 사용해서 해봄.
    func obtainExpositionData(compleion: @escaping (Result<Exposition, TestError>) -> ())  {
        guard let mainPageDataAsset: NSDataAsset = NSDataAsset(name: "exposition") else { return }
        do {
            let expositionDatas = try PairJsonDecoder.shared.decoder.decode(Exposition.self, from: mainPageDataAsset.data)
            compleion(.success(expositionDatas))
        } catch {
            print(String(describing: error))
        }
    }
}

