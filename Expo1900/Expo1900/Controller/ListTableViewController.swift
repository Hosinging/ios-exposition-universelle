//
//  ListTableViewController.swift
//  Expo1900
//
//  Created by 편대호 on 2021/07/09.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var items: [Item] = []
    let showItemDetailSegue = "showItemDetailSegue"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showItemDetailSegue, let destination = segue.destination as? ItemTableViewController, let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            
            destination.itemName = items[indexPath.row].name
            destination.itemImage = UIImage(named: items[indexPath.row].imageName)
            destination.itemDescrption = items[indexPath.row].description
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        //MARK: - 첫번째 방법
//        obtainExpositionItemData()
        
        //MARK: - 두번째 방법
        obtainExpositionItemData { (result: Result<[Item], TestError>) in
            switch result {
            case .success(let data):
                self.items = data
            case .failure(let error):
                print("실패")
                print(String(describing: error))
                break
            }
        }
    }
    //MARK: - 첫번째 방법
    //리턴으로 했을 때와, 이렇게 escaping completion을 통해서 했을 때 result의 사용 가능 불가능 판단?!
    //리턴형으로 했을 때 처리가 안되서 escaping을 사용해서 해봄.
    //ExpositionType으로 하면 디코딩 에러(딕셔너리를 써야되는데 배열을 썼다고...)가 나와서 이렇게함
//    func obtainExpositionItemData()  {
//        guard let itemDataAsset: NSDataAsset = NSDataAsset(name: "items") else { return }
//        do {
//            let expositionItemDatas = try PairJsonDecoder.shared.decoder.decode([Item].self, from: itemDataAsset.data)
//            self.items = expositionItemDatas
//        }
//        catch {
//            print("실패")
//            print(String(describing: error))
//        }
//    }
    
    //MARK: - 두번째 방법
    func obtainExpositionItemData(compleion: @escaping (Result<[Item], TestError>) -> ())  {
        guard let itemDataAsset: NSDataAsset = NSDataAsset(name: "items") else { return }
        do {
            let expositionDatas = try PairJsonDecoder.shared.decoder.decode([Item].self, from: itemDataAsset.data)
            compleion(.success(expositionDatas))
        } catch {
            print(String(describing: error))
        }
    }
    
 
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
     
        let item = self.items[indexPath.row]
        cell.itemImageView.image = UIImage(named: item.imageName)
        cell.itemNameLabel.text = item.name
        cell.itemDescription.text = item.shortDescription
        
        return cell
    }
    
}
