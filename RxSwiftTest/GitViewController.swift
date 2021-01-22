//
//  GitViewController.swift
//  RxSwiftTest
//
//  Created by Juan Capponi on 1/21/21.
//

import UIKit
import RxSwift
import RxCocoa

class GitViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    /*
    private let tableView: UITableView = {
        let table = UITableView()
        //table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        table.register(GitCustomTableViewCell.self, forCellReuseIdentifier: "gitCustomCell")
        
        return table
    }()
    */
    
    private let githubRepo = GitHubRepo()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.frame = view.bounds
        view.addSubview(tableView)
        
        let reposObservable = githubRepo.getRepos().share()
        let randomNumber = Int.random(in: 0...50)
        
        reposObservable.map { repos -> String in
            let repo = repos[randomNumber]
            return repo.owner.login! + " / " + repo.name!
        }
        .startWith("Loading...")
        .bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        
        githubRepo.getRepos().flatMap { (repos) -> Observable<[Branch]> in
            
            let repo = repos[randomNumber]
            
            return self.githubRepo.getBranches(ownerName: repo.owner.login!, repoName: repo.name!)
            
        }.bind(to: tableView.rx.items(cellIdentifier: "gitCustomCell", cellType: GitCustomTableViewCell.self)) {
             index, branch, cell in
            
            cell.branchLabel?.text =  branch.name
        }.disposed(by: disposeBag)
    }
}


struct Repos: Codable {
    let name: String?
    let owner: Owner
}

struct Owner: Codable {
    let login: String?
}

struct Branch: Codable {
    let name: String?
}


class GitHubRepo {
    private let networkService = NetworkService()
    private let baseUrl = "https://api.github.com"
    
    func getRepos() -> Observable<[Repos]> {
        return networkService.execute(url: URL(string: baseUrl + "/repositories")!)
    }
 
    func getBranches(ownerName: String, repoName: String) -> Observable<[Branch]> {
        return networkService.execute(url: URL(string: baseUrl + "/repos/\(ownerName)/\(repoName)/branches")!)
    }
    
    
    
}

class NetworkService {
    func execute<T: Codable>(url: URL) -> Observable<T> {
        return Observable.create { observer -> Disposable in
            
            let task = URLSession.shared.dataTask(with: url) {
                data, _, _ in
                guard let data = data else {
                    return
                }
               
                
                let decoded = try? JSONDecoder().decode(T.self, from: data)
                
                observer.onNext(decoded!)
                observer.onCompleted()
                
            }
            task.resume()
        
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
