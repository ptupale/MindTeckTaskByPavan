//
//  ViewController.swift
//  MindTeckProjectByPavan
//
//  Created by Pavankumar Tupale on 02/12/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    
    let bLogic = BLogic()
    
    //MARK:View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MindTeck"
        self.setdata()
        self.tableviewRegisterMethod()
        pageView.numberOfPages = bLogic.imgArr.count
        pageView.currentPage = 0
        self.addGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(false, animated:   true)
    }
    
    //MARK:Setup methods
    private func setdata() {
        bLogic.craeteDataForUser(count: 10)
    }
    
    //MARK:Gesture methods
    private func addGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.sliderCollectionView.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.sliderCollectionView.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(gesture:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.sliderCollectionView.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(gesture:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.sliderCollectionView.addGestureRecognizer(swipeDown)
    }
    
    //MARK:Tableview setup methods
    func tableviewRegisterMethod() {
        self.userTableView.register(UINib(nibName: "MindTeckCell", bundle: nil), forCellReuseIdentifier: "MindTeckCell")
        self.userTableView.tableFooterView = UIView()
    }
    
    //MARK:Table view data source methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bLogic.userDataModelObject[pageView.currentPage].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MindTeckCell") as! MindTeckCell
        cell.userData = bLogic.userDataModelObject[pageView.currentPage][indexPath.row]
        return cell
    }
    
    //MARK: UISearchbar delegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        bLogic.isSearch = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        bLogic.isSearch = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        bLogic.isSearch = false
        self.setdata()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        bLogic.isSearch = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            bLogic.isSearch = false
            self.setdata()
            self.userTableView.reloadData()
        } else {
            bLogic.userDataModelObject[pageView.currentPage] = bLogic.userDataModelObject[pageView.currentPage].filter({ (text) -> Bool in
                let range = NSString(string: text.userName).range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
            if(bLogic.userDataModelObject.count == 0){
                bLogic.isSearch = false
                self.setdata()
            } else {
                bLogic.isSearch = true
            }
            self.userTableView.reloadData()
        }
    }
    
    //MARK:Selector methods
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                if bLogic.counter != 0 {
                    bLogic.counter -= 1
                    changeImage()
                }
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
                self.navigationController?.setNavigationBarHidden(false, animated:   true)
            case UISwipeGestureRecognizer.Direction.left:
                if bLogic.counter+1 < bLogic.imgArr.count {
                    bLogic.counter += 1
                    changeImage()
                }
            case UISwipeGestureRecognizer.Direction.up:
                self.navigationController?.setNavigationBarHidden(true, animated:   true)
            default:
                break
            }
        }
    }
    
    //MARK:Change View mwthod
    func changeImage() {
        let index = IndexPath.init(item: bLogic.counter, section: 0)
        self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        pageView.currentPage = bLogic.counter
        self.userTableView.reloadData()
    }
    
}

//MARK: Collection View Data source
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bLogic.imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let vc = cell.viewWithTag(111) as? UIImageView {
            vc.image = bLogic.imgArr[indexPath.row]
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sliderCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
