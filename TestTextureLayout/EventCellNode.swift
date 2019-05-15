//
//  EventCellNode.swift
//  Czg_Parent
//
//  Created by susuyan on 2019/5/11.
//  Copyright © 2019 susuyan. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import SwiftyAttributes

class EventCellNode: ASCellNode {
    /// 事件名称
    let nameLabel = ASTextNode()
    /// 事件
    let timeLabel = ASTextNode()
    /// 日期
    let dateLabel = ASTextNode()
    /// 事件内容
    let contentLabel: ASTextNode = {
        let textNode = ASTextNode()
        textNode.backgroundColor = UIColor.green
        textNode.truncationMode = .byTruncatingTail
        textNode.maximumNumberOfLines = 10


        return textNode
    }()

    let leftLine = ASDisplayNode()

    /// 事件 icon
    let iconImageNode: ASNetworkImageNode = {
        let imageNode = ASNetworkImageNode()
        imageNode.contentMode = .scaleAspectFill
        imageNode.imageModificationBlock = ASImageNodeRoundBorderModificationBlock(0, nil)
        return imageNode
    }()

    let photoImageNode: ASNetworkImageNode = {
        let imageNode = ASNetworkImageNode()
        imageNode.contentMode = .scaleAspectFill
        return imageNode
    }()

    // MARK: Lifecycle

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        nameLabel.attributedText = "请假".withTextColor(UIColor.purple)
        iconImageNode.url = URL(string: "https://ylbb-business.oss-cn-beijing.aliyuncs.com/1545199946209ylbaby.png")
        timeLabel.attributedText = "10:00".withTextColor(UIColor.black)
        dateLabel.attributedText = "2019年 10 月 20 日".withTextColor(UIColor.black)
        contentLabel.attributedText = "北京鱼乐贝贝教育科技有限公司成立于2019年，一直专注于婴幼儿游泳和水上教育北京鱼乐贝贝教育科技有限公司成立于2019年，一直专注于婴幼儿游泳和水上教育".withTextColor(UIColor.gray)
        contentLabel.maximumNumberOfLines = 10

    }

    // MARK: ASDisplayNode

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        // left Stack
        let leftStack = ASStackLayoutSpec.vertical()
        iconImageNode.style.preferredSize = EventLayoutConstant.iconSize
        leftStack.children?.append(iconImageNode)

        leftStack.children?.append(timeLabel)
        leftStack.alignItems = .center

        leftLine.backgroundColor = UIColor.purple
        leftLine.style.width = ASDimension(unit: .points, value: 1)
        leftStack.children?.append(leftLine)
        leftLine.style.flexGrow = 1


        // right Stack
        let rightStack = ASStackLayoutSpec.vertical()
        rightStack.children?.append(nameLabel)
        rightStack.children?.append(dateLabel)
        rightStack.alignItems = .baselineFirst

        rightStack.children?.append(ASInsetLayoutSpec(insets: EventLayoutConstant.InsetsForContent, child: contentLabel))
        rightStack.style.flexShrink = 2


        let girdStack = ASStackLayoutSpec.horizontal()
        girdStack.spacing = 10
        girdStack.flexWrap = .wrap

        for _ in 0...8 {
            let gird = ASNetworkImageNode()
            gird.backgroundColor = UIColor.orange
            gird.style.preferredSize = CGSize(width: 100, height: 100)
            gird.url = URL(string: "https://ylbb-business.oss-cn-beijing.aliyuncs.com/1545199946209ylbaby.png")
            girdStack.children?.append(ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), child: gird))
        }

        rightStack.children?.append(girdStack)

        // event Stack
        let eventStack = ASStackLayoutSpec.horizontal()

        eventStack.children?.append(leftStack)
        eventStack.children?.append(rightStack)
        eventStack.alignContent = .start

        return eventStack
    }
}

struct EventLayoutConstant {
    static let iconSize = CGSize(width: 24, height: 24)
    static let InsetsForIcon = UIEdgeInsets(top: 20, left: 30, bottom: 4, right: 20)
    static let InsetsForName = UIEdgeInsets(top: 21, left: 0, bottom: 4.5, right: 0)
    static let InsetsForContent = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    static let InsetsForLine = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
}

