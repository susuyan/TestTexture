//
//  ViewController.swift
//  TestTextureLayout
//
//  Created by susuyan on 2019/5/14.
//  Copyright © 2019 susuyan. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import SnapKit
import ESPullToRefresh
class ViewController: UIViewController {

    lazy private var tableViewNode: ASTableNode = {
        let table = ASTableNode(style: .plain)
        table.delegate = self
        table.dataSource = self
        table.view.separatorStyle = .none

        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "事件列表"
        setupTableViewNode()

        tableViewNode.view.es.addPullToRefresh {
            self.tableViewNode.view.es.stopPullToRefresh()
            self.tableViewNode.reloadData()
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableViewNode.frame = view.bounds
        tableViewNode.view.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
            } else {
                make.edges.equalTo(self.view)
            }
        }
    }



}

// MARK: - Private Method
extension ViewController {
    private func setupTableViewNode(){
        view.addSubnode(tableViewNode)
    }
}


// MARK: - ASTableDelegate
extension ViewController: ASTableDelegate {

}

// MARK: - <#ASTableDataSource#>
extension ViewController: ASTableDataSource{
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            let cell = EventCellNode()

            return cell
        }
    }

//    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
//        let cell = EventCellNode()
//        cell.selectionStyle = .none
//
//        //        let node = ASTextCellNode()
//        //        node.text = String(format: "[%ld.%ld] says hello!", indexPath.section, indexPath.row)
//
//        return cell
//    }
}

