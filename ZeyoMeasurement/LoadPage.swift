//
//  page1.swift
//  test0507
//
//  Created by Yun Seokmin on 09/05/2019.
//  Copyright © 2019 Yun Seokmin. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class LoadPage : ARMeasureVC{
        

    
    func measureGuidePage1(pageView: UIView){
        let scaleWW = UIScreen.main.bounds.width / 375
        let scaleHH = UIScreen.main.bounds.height / 667
        
        //선을 그리기 위한 UIImageView
        let palletView = UIImageView.init(frame: CGRect.init(x: 0, y: 0,
                             width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        pageView.addSubview(palletView)
        palletView.translatesAutoresizingMaskIntoConstraints = false
        palletView.leftAnchor.constraint(equalTo: pageView.leftAnchor).isActive = true
        palletView.topAnchor.constraint(equalTo: pageView.topAnchor).isActive = true
        palletView.rightAnchor.constraint(equalTo: pageView.rightAnchor).isActive = true
        palletView.bottomAnchor.constraint(equalTo: pageView.bottomAnchor).isActive = true
        palletView.image = nil
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes :[NSAttributedString.Key: Any]
            = [.font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14*scaleWW) as Any,
               .paragraphStyle: paragraphStyle,
               .foregroundColor: UIColor.white,
               .kern: 0.21]
        
        pageView.backgroundColor = .init(displayP3Red: 29/255, green: 29/255, blue: 29/255, alpha: 0.6)
        
        
        //////// 조준점
        let aim = UIImageView(image: UIImage(named: "icPinPoint.pdf"))
        pageView.addSubview(aim)
        aim.translatesAutoresizingMaskIntoConstraints = false
        aim.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
        aim.centerYAnchor.constraint(equalTo: pageView.centerYAnchor).isActive = true
        aim.widthAnchor.constraint(equalToConstant: 40*scaleWW).isActive = true
        aim.heightAnchor.constraint(equalToConstant: 40*scaleWW).isActive = true
    
        ////////  측정 조준점 레이블
        let labelAim = UILabel.init(frame: CGRect.init())
        pageView.addSubview(labelAim)
        labelAim.translatesAutoresizingMaskIntoConstraints = false
        labelAim.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
        labelAim.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 255.4*scaleHH).isActive = true
        labelAim.widthAnchor.constraint(equalToConstant: 82*scaleWW).isActive = true
        labelAim.heightAnchor.constraint(equalToConstant: 17*scaleWW).isActive = true
        labelAim.numberOfLines = 0
        let attrStringAim = NSAttributedString(string:"측정 조준점", attributes: attributes)
        labelAim.attributedText = attrStringAim
    
        var startPoint = CGPoint.init(x: pageView.center.x/scaleWW, y: 275.4)
        var endPoint = CGPoint.init(x: pageView.center.x/scaleWW, y: pageView.center.y/scaleHH - 20)
        DrawLine(pallet: palletView, start: startPoint, end: endPoint)
        
        
        //////// 삭제
        let del = UIImageView(image: UIImage(named: "btnDeleteWhite.pdf"))
        pageView.addSubview(del)
        del.translatesAutoresizingMaskIntoConstraints = false
        del.leftAnchor.constraint(equalTo: pageView.leftAnchor, constant: 36.4*scaleWW).isActive = true
        del.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 589.4*scaleHH).isActive = true
        del.widthAnchor.constraint(equalToConstant: 24*scaleWW).isActive = true
        del.heightAnchor.constraint(equalToConstant: 24*scaleWW).isActive = true
        
        let circleDel = UIView(frame: CGRect.init())
        pageView.addSubview(circleDel)
        circleDel.translatesAutoresizingMaskIntoConstraints = false
        circleDel.topAnchor.constraint(equalTo: del.topAnchor, constant: -3*scaleWW).isActive = true
        circleDel.leftAnchor.constraint(equalTo: del.leftAnchor, constant: -6*scaleWW).isActive = true
        circleDel.rightAnchor.constraint(equalTo: del.rightAnchor, constant: 2*scaleWW).isActive = true
        circleDel.bottomAnchor.constraint(equalTo: del.bottomAnchor, constant: 5*scaleWW).isActive = true
        circleDel.backgroundColor = .clear
        circleDel.layer.borderWidth = 1
        circleDel.layer.borderColor = UIColor.init(displayP3Red: 16/255, green: 255/255, blue: 117/255, alpha: 1).cgColor
        circleDel.layer.cornerRadius = 32*scaleWW/2.0
        circleDel.clipsToBounds = true
        
        //////// 삭제 레이블 (점 1개 삭제)
        let labelDel = UILabel.init(frame: CGRect.init())
        pageView.addSubview(labelDel)
        labelDel.translatesAutoresizingMaskIntoConstraints = false
        labelDel.leftAnchor.constraint(equalTo: pageView.leftAnchor, constant: 0*scaleWW).isActive = true
        labelDel.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 509.4*scaleHH).isActive = true
        labelDel.widthAnchor.constraint(equalToConstant: 97.4*scaleWW).isActive = true
        labelDel.heightAnchor.constraint(equalToConstant: 17*scaleWW).isActive = true
        labelDel.numberOfLines = 0
        let attrStringDel = NSAttributedString(string:"점 1개 삭제", attributes: attributes)
        labelDel.attributedText = attrStringDel
        
        startPoint = CGPoint.init(x: 45.4, y: 528)
        endPoint = CGPoint.init(x: 45.4, y: 528+58)
        DrawLine(pallet: palletView, start: startPoint, end: endPoint)
        
        
        //////// 이전항목
        let prev = UIImageView(image: UIImage(named: "btnPrevMeasurement.pdf"))
        pageView.addSubview(prev)
        prev.translatesAutoresizingMaskIntoConstraints = false
        prev.leftAnchor.constraint(equalTo: pageView.leftAnchor, constant: 102.4*scaleWW).isActive = true
        prev.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 591.4*scaleHH).isActive = true
        prev.widthAnchor.constraint(equalToConstant: 16*scaleWW).isActive = true
        prev.heightAnchor.constraint(equalToConstant: 22*scaleWW).isActive = true
        
        let circlePrev = UIView(frame: CGRect.init())
        pageView.addSubview(circlePrev)
        circlePrev.translatesAutoresizingMaskIntoConstraints = false
        circlePrev.topAnchor.constraint(equalTo: prev.topAnchor, constant: -5*scaleWW).isActive = true
        circlePrev.leftAnchor.constraint(equalTo: prev.leftAnchor, constant: -5*scaleWW).isActive = true
        circlePrev.rightAnchor.constraint(equalTo: prev.rightAnchor, constant: 11*scaleWW).isActive = true
        circlePrev.bottomAnchor.constraint(equalTo: prev.bottomAnchor, constant: 5*scaleWW).isActive = true
        circlePrev.backgroundColor = .clear
        circlePrev.layer.borderWidth = 1
        circlePrev.layer.borderColor = UIColor.init(displayP3Red: 16/255, green: 255/255, blue: 117/255, alpha: 1).cgColor
        circlePrev.layer.cornerRadius = 32*scaleWW/2.0
        circlePrev.clipsToBounds = true
        
        //////// 이전항목 레이블 (이전 측정 부위로 이동)
        let labelPrev = UILabel.init(frame: CGRect.init())
        pageView.addSubview(labelPrev)
        labelPrev.translatesAutoresizingMaskIntoConstraints = false
        labelPrev.leftAnchor.constraint(equalTo: pageView.leftAnchor, constant: 64.4*scaleWW).isActive = true
        labelPrev.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 462.4*scaleHH).isActive = true
        labelPrev.widthAnchor.constraint(equalToConstant: 98*scaleWW).isActive = true
        labelPrev.heightAnchor.constraint(equalToConstant: 34*scaleWW).isActive = true
        labelPrev.numberOfLines = 0
        let attrStringPrev = NSAttributedString(string:"이전 측정 부위로\n 이동", attributes: attributes)
        labelPrev.attributedText = attrStringPrev
        
        startPoint = CGPoint.init(x: 112.4, y: 502.4)
        endPoint = CGPoint.init(x: 112.4, y: 502.4+84)
        DrawLine(pallet: palletView, start: startPoint, end: endPoint)
        
        
        //////// 측정 점 찍기
        let pickPin = UIImageView(image: UIImage(named: "btnPickPin.pdf"))
        pageView.addSubview(pickPin)
        pickPin.translatesAutoresizingMaskIntoConstraints = false
        pickPin.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
        pickPin.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 575.4*scaleHH).isActive = true
        pickPin.widthAnchor.constraint(equalToConstant: 54*scaleWW).isActive = true
        pickPin.heightAnchor.constraint(equalToConstant: 54*scaleWW).isActive = true
        
        let circlePickPin = UIView(frame: CGRect.init())
        pageView.addSubview(circlePickPin)
        circlePickPin.translatesAutoresizingMaskIntoConstraints = false
        circlePickPin.topAnchor.constraint(equalTo: pickPin.topAnchor, constant: -6*scaleWW).isActive = true
        circlePickPin.leftAnchor.constraint(equalTo: pickPin.leftAnchor, constant: -6*scaleWW).isActive = true
        circlePickPin.rightAnchor.constraint(equalTo: pickPin.rightAnchor, constant: 6*scaleWW).isActive = true
        circlePickPin.bottomAnchor.constraint(equalTo: pickPin.bottomAnchor, constant: 6*scaleWW).isActive = true
        circlePickPin.backgroundColor = .clear
        circlePickPin.layer.borderWidth = 1
        circlePickPin.layer.borderColor = UIColor.init(displayP3Red: 16/255, green: 255/255, blue: 117/255, alpha: 1).cgColor
        circlePickPin.layer.cornerRadius = 66*scaleWW/2.0
        circlePickPin.clipsToBounds = true
        
        //////// 점찍기 레이블 (측정 점 찍기)
        let labelPickPin = UILabel.init(frame: CGRect.init())
        pageView.addSubview(labelPickPin)
        labelPickPin.translatesAutoresizingMaskIntoConstraints = false
        labelPickPin.leftAnchor.constraint(equalTo: pageView.leftAnchor, constant: 147.4*scaleWW).isActive = true
        labelPickPin.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 415.4*scaleHH).isActive = true
        labelPickPin.widthAnchor.constraint(equalToConstant: 82*scaleWW).isActive = true
        labelPickPin.heightAnchor.constraint(equalToConstant: 17*scaleWW).isActive = true
        labelPickPin.numberOfLines = 0
        let attrStringPickPin = NSAttributedString(string:"측정 점 찍기", attributes: attributes)
        labelPickPin.attributedText = attrStringPickPin
        
        startPoint = CGPoint.init(x: pageView.center.x/scaleWW, y: 439)
        endPoint = CGPoint.init(x: pageView.center.x/scaleWW, y: 439 + 129)
        DrawLine(pallet: palletView, start: startPoint, end: endPoint)
        
        
        //////// 다음항목
        let next = UIImageView(image: UIImage(named: "btnNextMeasurement.pdf"))
        pageView.addSubview(next)
        next.translatesAutoresizingMaskIntoConstraints = false
        next.leftAnchor.constraint(equalTo: pageView.leftAnchor, constant: 257.4*scaleWW).isActive = true
        next.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 591.4*scaleHH).isActive = true
        next.widthAnchor.constraint(equalToConstant: 16*scaleWW).isActive = true
        next.heightAnchor.constraint(equalToConstant: 22*scaleWW).isActive = true
        
        let circleNext = UIView(frame: CGRect.init())
        pageView.addSubview(circleNext)
        circleNext.translatesAutoresizingMaskIntoConstraints = false
        circleNext.topAnchor.constraint(equalTo: next.topAnchor, constant: -5*scaleWW).isActive = true
        circleNext.leftAnchor.constraint(equalTo: next.leftAnchor, constant: -10*scaleWW).isActive = true
        circleNext.rightAnchor.constraint(equalTo: next.rightAnchor, constant: 6*scaleWW).isActive = true
        circleNext.bottomAnchor.constraint(equalTo: next.bottomAnchor, constant: 5*scaleWW).isActive = true
        circleNext.backgroundColor = .clear
        circleNext.layer.borderWidth = 1
        circleNext.layer.borderColor = UIColor.init(displayP3Red: 16/255, green: 255/255, blue: 117/255, alpha: 1).cgColor
        circleNext.layer.cornerRadius = 32*scaleWW/2.0
        circleNext.clipsToBounds = true
        
        //////// 다음항목 레이블 (다음 측정 부위로 이동)
        let labelNext = UILabel.init(frame: CGRect.init())
        pageView.addSubview(labelNext)
        labelNext.translatesAutoresizingMaskIntoConstraints = false
        labelNext.leftAnchor.constraint(equalTo: pageView.leftAnchor, constant: 215.4*scaleWW).isActive = true
        labelNext.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 462.4*scaleHH).isActive = true
        labelNext.widthAnchor.constraint(equalToConstant: 98*scaleWW).isActive = true
        labelNext.heightAnchor.constraint(equalToConstant: 34*scaleWW).isActive = true
        labelNext.numberOfLines = 0
        let attrStringNext = NSAttributedString(string:"다음 측정 부위로\n 이동", attributes: attributes)
        labelNext.attributedText = attrStringNext
        
        startPoint = CGPoint.init(x: 262.4, y: 502.4)
        endPoint = CGPoint.init(x: 262.4, y: 502.4+84)
        DrawLine(pallet: palletView, start: startPoint, end: endPoint)
        
        
        //////// 측정가이드
        let guide = UIImageView(image: UIImage(named: "btnRulerGuide.pdf"))
        pageView.addSubview(guide)
        guide.translatesAutoresizingMaskIntoConstraints = false
        guide.leftAnchor.constraint(equalTo: pageView.leftAnchor, constant: 315.4*scaleWW).isActive = true
        guide.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 590.4*scaleHH).isActive = true
        guide.widthAnchor.constraint(equalToConstant: 24*scaleWW).isActive = true
        guide.heightAnchor.constraint(equalToConstant: 24*scaleWW).isActive = true
        
        let circleGuide = UIView(frame: CGRect.init())
        pageView.addSubview(circleGuide)
        circleGuide.translatesAutoresizingMaskIntoConstraints = false
        circleGuide.topAnchor.constraint(equalTo: guide.topAnchor, constant: -4*scaleWW).isActive = true
        circleGuide.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: -4*scaleWW).isActive = true
        circleGuide.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: 4*scaleWW).isActive = true
        circleGuide.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 4*scaleWW).isActive = true
        circleGuide.backgroundColor = .clear
        circleGuide.layer.borderWidth = 1
        circleGuide.layer.borderColor = UIColor.init(displayP3Red: 16/255, green: 255/255, blue: 117/255, alpha: 1).cgColor
        circleGuide.layer.cornerRadius = 32*scaleWW/2.0
        circleGuide.clipsToBounds = true
        
        ////////  (측정 가이드 화면 가운데 표시)
        let labelGuid = UILabel.init(frame: CGRect.init())
        pageView.addSubview(labelGuid)
        labelGuid.translatesAutoresizingMaskIntoConstraints = false
        labelGuid.leftAnchor.constraint(equalTo: pageView.leftAnchor, constant: 260.4*scaleWW).isActive = true
        labelGuid.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 255.4*scaleHH).isActive = true
        labelGuid.widthAnchor.constraint(equalToConstant: 105*scaleWW).isActive = true
        labelGuid.heightAnchor.constraint(equalToConstant: 34*scaleWW).isActive = true
        labelGuid.numberOfLines = 0
        let attrStringGuide = NSAttributedString(string:"측정 가이드 화면 가운데 표시", attributes: attributes)
        labelGuid.attributedText = attrStringGuide
        
        startPoint = CGPoint.init(x: 309.4, y: 299)
        endPoint = CGPoint.init(x: 309.4+21.1, y: 299+287)
        DrawLine(pallet: palletView, start: startPoint, end: CGPoint.init(x: startPoint.x, y:400))
        DrawLine(pallet: palletView, start: CGPoint.init(x: startPoint.x, y: 400), end: CGPoint.init(x: endPoint.x, y:400))
        DrawLine(pallet: palletView, start: CGPoint.init(x: endPoint.x, y: 400), end: endPoint)
        
        
        
        //////// 취소
        let cancel = UIImageView(image: UIImage(named: "btnCloseCoachmark.pdf"))
        pageView.addSubview(cancel)
        cancel.translatesAutoresizingMaskIntoConstraints = false
        cancel.leftAnchor.constraint(equalTo: pageView.leftAnchor, constant: 335*scaleWW).isActive = true
        cancel.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 42.4*scaleHH).isActive = true
        cancel.widthAnchor.constraint(equalToConstant: 24*scaleWW).isActive = true
        cancel.heightAnchor.constraint(equalToConstant: 24*scaleWW).isActive = true
        
        let circleCancel = UIView(frame: CGRect.init())
        pageView.addSubview(circleCancel)
        circleCancel.translatesAutoresizingMaskIntoConstraints = false
        circleCancel.topAnchor.constraint(equalTo: cancel.topAnchor, constant: -4*scaleWW).isActive = true
        circleCancel.leftAnchor.constraint(equalTo: cancel.leftAnchor, constant: -4*scaleWW).isActive = true
        circleCancel.rightAnchor.constraint(equalTo: cancel.rightAnchor, constant: 4*scaleWW).isActive = true
        circleCancel.bottomAnchor.constraint(equalTo: cancel.bottomAnchor, constant: 4*scaleWW).isActive = true
        circleCancel.backgroundColor = .clear
        circleCancel.layer.borderWidth = 1
        circleCancel.layer.borderColor = UIColor.init(displayP3Red: 16/255, green: 255/255, blue: 117/255, alpha: 1).cgColor
        circleCancel.layer.cornerRadius = 32*scaleWW/2.0
        circleCancel.clipsToBounds = true
        
        //////// 취소 레이블 (측정 카테고리 선택 화면으로 이동)
        let labelCancel = UILabel.init(frame: CGRect.init())
        pageView.addSubview(labelCancel)
        labelCancel.translatesAutoresizingMaskIntoConstraints = false
        labelCancel.leftAnchor.constraint(equalTo: pageView.leftAnchor, constant: 258.4*scaleWW).isActive = true
        labelCancel.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 152.4*scaleHH).isActive = true
        labelCancel.widthAnchor.constraint(equalToConstant: 109*scaleWW).isActive = true
        labelCancel.heightAnchor.constraint(equalToConstant: 34*scaleWW).isActive = true
        labelCancel.numberOfLines = 0
        let attrStringCancel = NSAttributedString(string:"측정 카테고리 선택 화면으로 이동", attributes: attributes)
        labelCancel.attributedText = attrStringCancel
        
        startPoint = CGPoint.init(x: 312.9+34.5, y: 72)
        endPoint = CGPoint.init(x: 312.9, y: 70.4+79.1 )
        DrawLine(pallet: palletView, start: startPoint, end: CGPoint.init(x: startPoint.x, y:100.4))
        DrawLine(pallet: palletView, start: CGPoint.init(x: startPoint.x, y: 100.4), end: CGPoint.init(x: endPoint.x, y:100.4))
        DrawLine(pallet: palletView, start: CGPoint.init(x: endPoint.x, y: 100.4), end: endPoint)
        
        
        //////// 측정항목 레이블
        // 측정항목 배경
        let itemView = UIView(frame: CGRect.init())
        pageView.addSubview(itemView)
        itemView.translatesAutoresizingMaskIntoConstraints = false
        itemView.backgroundColor = .init(displayP3Red: 32/255, green: 125/255, blue: 255/255, alpha: 1)
        itemView.layer.cornerRadius = 10
        itemView.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
        itemView.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 37.4*scaleHH).isActive = true
        itemView.widthAnchor.constraint(equalToConstant: 96*scaleWW).isActive = true
        itemView.heightAnchor.constraint(equalToConstant: 32*scaleWW).isActive = true
        
        // 레이블
        let labelItem = UILabel.init(frame: CGRect.init())
        itemView.addSubview(labelItem)
        labelItem.translatesAutoresizingMaskIntoConstraints = false
        labelItem.topAnchor.constraint(equalTo: itemView.topAnchor).isActive = true
        labelItem.bottomAnchor.constraint(equalTo: itemView.bottomAnchor).isActive = true
        labelItem.leftAnchor.constraint(equalTo: itemView.leftAnchor).isActive = true
        labelItem.rightAnchor.constraint(equalTo: itemView.rightAnchor).isActive = true
        labelItem.numberOfLines = 0
        
        let paragraphStyle_item = NSMutableParagraphStyle()
        paragraphStyle_item.alignment = .center
        let attributes_item :[NSAttributedString.Key: Any] = [.font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16*scaleWW) as Any,
                                                              .paragraphStyle: paragraphStyle_item,
                                                              .foregroundColor: UIColor.white,
                                                              .kern: 0.24]
        let attrString_item = NSAttributedString(string:"어깨", attributes: attributes_item)
        labelItem.attributedText = attrString_item
        
        
        //////// 부위별 핀 색상과 동일
        let label2 = UILabel.init(frame: CGRect.init())
        itemView.addSubview(label2)
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
        label2.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 89.4*scaleHH).isActive = true
        label2.widthAnchor.constraint(equalToConstant: 128*scaleWW).isActive = true
        label2.heightAnchor.constraint(equalToConstant: 17*scaleWW).isActive = true
        label2.numberOfLines = 0
        let attrString2 = NSAttributedString(string:"부위별 핀 색상과 동일", attributes: attributes)
        label2.attributedText = attrString2
        
    }
    
    func DrawLine(pallet : UIImageView!, start : CGPoint, end : CGPoint) {
        let scaleWW = UIScreen.main.bounds.width / 375
        let scaleHH = UIScreen.main.bounds.height / 667
        
        //콘텍스트를 이미지뷰 크기와 같게 설정
        UIGraphicsBeginImageContext(pallet.frame.size)
        //생성한 콘텍스트의 정보를 가져온다.
        guard let context = UIGraphicsGetCurrentContext() else { return }
        pallet.image?.draw(in: pallet.bounds)

        //선굵기 설정
        context.setLineWidth(2.0)
        //선 칼라 설정
        context.setStrokeColor(UIColor.init(displayP3Red: 16/255, green: 255/255, blue: 117/255, alpha: 1).cgColor)

        let start_modi = CGPoint(x: start.x * scaleWW, y: start.y * scaleHH)
        let end_modi = CGPoint(x: end.x * scaleWW, y: end.y * scaleHH)
        
        //시작위치로 커서 이동
        context.move(to: start_modi)
        context.addLine(to: end_modi)
        context.strokePath()

        pallet.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    
    func measureGuidePage2(pageView: UIView){
        let scaleWW = UIScreen.main.bounds.width / 375
        let scaleHH = UIScreen.main.bounds.height / 667
        
        pageView.backgroundColor = .init(displayP3Red: 29/255, green: 29/255, blue: 29/255, alpha: 0.6)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes :[NSAttributedString.Key: Any]
            = [.font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 26*scaleWW) as Any,
               .paragraphStyle: paragraphStyle,
               .foregroundColor: UIColor.white,
               .kern: 0.19]
        let attrStringTitle = NSAttributedString(string:"측정 이렇게 하세요", attributes: attributes)
        
        let labelTitle = UILabel.init(frame: CGRect.init())
        pageView.addSubview(labelTitle)
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
        labelTitle.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 160.6*scaleHH).isActive = true
        labelTitle.widthAnchor.constraint(equalToConstant: 343.5*scaleWW).isActive = true
        labelTitle.heightAnchor.constraint(equalToConstant: 31*scaleWW).isActive = true
        labelTitle.numberOfLines = 0
        labelTitle.attributedText = attrStringTitle
        
        
        
        let attributedString1 = NSMutableAttributedString(string: "1. 점을 가까이 찍으면 더 정확한 길이를 잴 수 있어요.", attributes: [
            .font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14.0*scaleWW)!,
            .foregroundColor: UIColor(white: 1.0, alpha: 1.0),
            .kern: 0.21
            ])
        attributedString1.addAttribute(.foregroundColor, value: UIColor(red: 16.0 / 255.0, green: 1.0, blue: 117.0 / 255.0, alpha: 1.0), range: NSRange(location: 14, length: 8))

        let label1 = UILabel.init(frame: CGRect.init())
        pageView.addSubview(label1)
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
        label1.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 230*scaleHH).isActive = true
        label1.widthAnchor.constraint(equalToConstant: 311.2*scaleWW).isActive = true
        label1.heightAnchor.constraint(equalToConstant: 17*scaleWW).isActive = true
        label1.numberOfLines = 0
        label1.attributedText = attributedString1

        
        let attributedString2 = NSMutableAttributedString(string: "2. 측정 조준점을 기준으로 점이 찍혀요!", attributes: [
            .font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14.0*scaleWW)!,
            .foregroundColor: UIColor(white: 1.0, alpha: 1.0),
            .kern: 0.21
            ])
        attributedString2.addAttribute(.foregroundColor, value: UIColor(red: 16.0 / 255.0, green: 1.0, blue: 117.0 / 255.0, alpha: 1.0), range: NSRange(location: 3, length: 6))

        let label2 = UILabel.init(frame: CGRect.init())
        pageView.addSubview(label2)
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
        label2.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 279*scaleHH).isActive = true
        label2.widthAnchor.constraint(equalToConstant: 311.2*scaleWW).isActive = true
        label2.heightAnchor.constraint(equalToConstant: 17*scaleWW).isActive = true
        label2.numberOfLines = 0
        label2.attributedText = attributedString2
        
        
        let attributedString3 = NSMutableAttributedString(string: "3. 자세한 측정방법을 알고 싶으시다면 메뉴에 있는 \n   측정가이드를 참고해주세요!", attributes: [
            .font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14.0*scaleWW)!,
            .foregroundColor: UIColor(white: 1.0, alpha: 1.0),
            .kern: 0.21
            ])
        attributedString3.addAttribute(.foregroundColor, value: UIColor(red: 16.0 / 255.0, green: 1.0, blue: 117.0 / 255.0, alpha: 1.0), range: NSRange(location: 33, length: 5))
        
        let label3 = UILabel.init(frame: CGRect.init())
        pageView.addSubview(label3)
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
        label3.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 328*scaleHH).isActive = true
        label3.widthAnchor.constraint(equalToConstant: 311.2*scaleWW).isActive = true
        label3.heightAnchor.constraint(equalToConstant: 44*scaleWW).isActive = true
        label3.numberOfLines = 0
        label3.attributedText = attributedString3
        
        
        let cancel = UIImageView(image: UIImage(named: "btnCloseCoachmark.pdf"))
        pageView.addSubview(cancel)
        cancel.translatesAutoresizingMaskIntoConstraints = false
        cancel.leftAnchor.constraint(equalTo: pageView.leftAnchor, constant: 325*scaleWW).isActive = true
        cancel.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 42*scaleHH).isActive = true
        cancel.widthAnchor.constraint(equalToConstant: 24*scaleWW).isActive = true
        cancel.heightAnchor.constraint(equalToConstant: 24*scaleWW).isActive = true
        
        
    }
    
    func ScanPage(pageView: UIView){
        let scaleWW = UIScreen.main.bounds.width / 375
        let scaleHH = UIScreen.main.bounds.height / 667
        
        pageView.backgroundColor = .init(displayP3Red: 29/255, green: 29/255, blue: 29/255, alpha: 0.6)

        //////// 이미지 (gif 아님)
        let scanImg = UIImageView(image: UIImage(named: "illust.pdf"))
        pageView.addSubview(scanImg)
        scanImg.translatesAutoresizingMaskIntoConstraints = false
        scanImg.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
        scanImg.centerYAnchor.constraint(equalTo: pageView.centerYAnchor).isActive = true
        scanImg.widthAnchor.constraint(equalToConstant: 250*scaleWW).isActive = true
        scanImg.heightAnchor.constraint(equalToConstant: 112*scaleWW).isActive = true
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.minimumLineHeight = 22
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16) as Any,
                          .paragraphStyle: paragraphStyle,
                          .foregroundColor: UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1),
                          .kern: 0.24]
        let attrString = NSAttributedString(string:"측정을 시작하려면 스마트폰을\n 좌우로 움직여주세요", attributes: attributes)
     
        let labelScan = UILabel.init(frame: CGRect.init())
        pageView.addSubview(labelScan)
        labelScan.translatesAutoresizingMaskIntoConstraints = false
        labelScan.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
        labelScan.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 420*scaleHH).isActive = true
        labelScan.widthAnchor.constraint(equalToConstant: 311.3*scaleWW).isActive = true
        labelScan.heightAnchor.constraint(equalToConstant: 44*scaleWW).isActive = true
        labelScan.numberOfLines = 0
        labelScan.attributedText = attrString
    }
    
    func popupPage(pageView: UIView){
        let scaleWW = UIScreen.main.bounds.width / 375
        let scaleHH = UIScreen.main.bounds.height / 667
        
//        pageView.backgroundColor = .init(displayP3Red: 29/255, green: 29/255, blue: 29/255, alpha: 0.6)
        
        //////// baseRect
        let baseRect = UIView(frame : CGRect.init())
        pageView.addSubview(baseRect)
        baseRect.translatesAutoresizingMaskIntoConstraints = false
        baseRect.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
        baseRect.centerYAnchor.constraint(equalTo: pageView.centerYAnchor).isActive = true
        baseRect.widthAnchor.constraint(equalToConstant: 280*scaleWW).isActive = true
        baseRect.heightAnchor.constraint(equalToConstant: 350*scaleWW).isActive = true
        baseRect.backgroundColor = UIColor.white
        baseRect.layer.borderColor = UIColor.init(displayP3Red: 249/255, green: 249/255, blue: 249/255, alpha: 1).cgColor
        baseRect.layer.cornerRadius = 6*scaleWW

        //////// innerRect
        let innerRect = UIImageView(image: UIImage(named: "illust.pdf"))
        baseRect.addSubview(innerRect)
        innerRect.translatesAutoresizingMaskIntoConstraints = false
        innerRect.centerXAnchor.constraint(equalTo: baseRect.centerXAnchor).isActive = true
        innerRect.topAnchor.constraint(equalTo: baseRect.topAnchor, constant: 38*scaleWW).isActive = true
        innerRect.widthAnchor.constraint(equalToConstant: 262*scaleWW).isActive = true
        innerRect.heightAnchor.constraint(equalToConstant: 208*scaleWW).isActive = true
        innerRect.backgroundColor = UIColor.init(displayP3Red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        innerRect.layer.borderColor = UIColor.init(displayP3Red: 222/255, green: 222/255, blue: 222/255, alpha: 1).cgColor
        baseRect.layer.cornerRadius = 2*scaleWW

        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16) as Any,
                          .paragraphStyle: paragraphStyle,
                          .foregroundColor: UIColor(red: 119/255.0, green: 119/255.0, blue: 119/255.0, alpha: 1),
                          .kern: 0.24]
        let attrString = NSAttributedString(string:"체형 측정 방법 안내 줄 영역 체형\n 측정 방법 안내 줄 영역", attributes: attributes)
        
        let labelPopup = UILabel.init(frame: CGRect.init())
        baseRect.addSubview(labelPopup)
        labelPopup.translatesAutoresizingMaskIntoConstraints = false
        labelPopup.centerXAnchor.constraint(equalTo: baseRect.centerXAnchor).isActive = true
        labelPopup.topAnchor.constraint(equalTo: baseRect.topAnchor, constant: 278*scaleWW).isActive = true
        labelPopup.widthAnchor.constraint(equalToConstant: 264*scaleWW).isActive = true
        labelPopup.heightAnchor.constraint(equalToConstant: 38*scaleWW).isActive = true
        labelPopup.numberOfLines = 0
        labelPopup.attributedText = attrString
        
        let cancel = UIImageView(image: UIImage(named: "btnCloseCoachmark.pdf"))
        baseRect.addSubview(cancel)
        cancel.translatesAutoresizingMaskIntoConstraints = false
        cancel.leftAnchor.constraint(equalTo: baseRect.leftAnchor, constant: 248*scaleWW).isActive = true
        cancel.topAnchor.constraint(equalTo: baseRect.topAnchor, constant: 8*scaleHH).isActive = true
        cancel.widthAnchor.constraint(equalToConstant: 24*scaleWW).isActive = true
        cancel.heightAnchor.constraint(equalToConstant: 24*scaleWW).isActive = true
        cancel.tintColor = UIColor.red
    }
    
    
    func maesurePage(pageView: ARSCNView){
        let scaleWW = UIScreen.main.bounds.width / 375
        let scaleHH = UIScreen.main.bounds.height / 667
        
        let baseRect = UIView(frame : CGRect.init())
        pageView.addSubview(baseRect)
        baseRect.translatesAutoresizingMaskIntoConstraints = false
        baseRect.leftAnchor.constraint(equalTo: pageView.leftAnchor).isActive = true
        baseRect.bottomAnchor.constraint(equalTo: pageView.bottomAnchor).isActive = true
        baseRect.rightAnchor.constraint(equalTo: pageView.rightAnchor).isActive = true
        baseRect.heightAnchor.constraint(equalToConstant: 120*scaleWW).isActive = true
        baseRect.backgroundColor = UIColor.init(displayP3Red: 29/255, green: 29/255, blue: 29/255, alpha: 0.5)
    
        //////// 조준점
        //aim.setImage(UIImage(named: "icPinPoint.pdf"), for: .normal)
        baseRect.addSubview(aimView)
        aimView.translatesAutoresizingMaskIntoConstraints = false
        aimView.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
        aimView.centerYAnchor.constraint(equalTo: pageView.centerYAnchor).isActive = true
        aimView.widthAnchor.constraint(equalToConstant: 40*scaleWW).isActive = true
        aimView.heightAnchor.constraint(equalToConstant: 40*scaleWW).isActive = true

        
        //////// 삭제
        resetButton.setImage(UIImage(named: "btnDeleteWhite.pdf"), for: .normal)
        baseRect.addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.leftAnchor.constraint(equalTo: pageView.leftAnchor, constant: 36.4*scaleWW).isActive = true
        resetButton.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 589.4*scaleHH).isActive = true
        resetButton.widthAnchor.constraint(equalToConstant: 24*scaleWW).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 24*scaleWW).isActive = true
        resetButton.addTarget(self, action: #selector(resetButtonPressed(_:)), for: .touchUpInside)

        //////// 이전항목
        baseRect.addSubview(previousButton)
        previousButton.setImage(UIImage(named: "btnPrevMeasurement.pdf"), for: .normal)
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        previousButton.leftAnchor.constraint(equalTo: pageView.leftAnchor, constant: 102.4*scaleWW).isActive = true
        previousButton.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 591.4*scaleHH).isActive = true
        previousButton.widthAnchor.constraint(equalToConstant: 16*scaleWW).isActive = true
        previousButton.heightAnchor.constraint(equalToConstant: 22*scaleWW).isActive = true
        previousButton.addTarget(self, action: #selector(previousButtonPressed(_:)), for: .touchUpInside)
        
        //////// 측정 점 찍기
        baseRect.addSubview(createPointButton)
        createPointButton.setImage(UIImage(named: "btnPickPin.pdf"), for: .normal)
        createPointButton.translatesAutoresizingMaskIntoConstraints = false
        createPointButton.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
        createPointButton.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 575.4*scaleHH).isActive = true
        createPointButton.widthAnchor.constraint(equalToConstant: 54*scaleWW).isActive = true
        createPointButton.heightAnchor.constraint(equalToConstant: 54*scaleWW).isActive = true
        createPointButton.addTarget(self, action: #selector(createPointButtonPressed), for: .touchUpInside)
        createPointButton.addTarget(self, action: #selector(createPoint), for: .touchUpInside)

        //////// 다음항목
        baseRect.addSubview(nextButton)
        nextButton.setImage(UIImage(named: "btnNextMeasurement.pdf"), for: .normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.leftAnchor.constraint(equalTo: pageView.leftAnchor, constant: 257.4*scaleWW).isActive = true
        nextButton.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 591.4*scaleHH).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 16*scaleWW).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 22*scaleWW).isActive = true
        nextButton.addTarget(self, action: #selector(nextButtonPressed(_:)), for: .touchUpInside)
        
        //////// 측정가이드
        baseRect.addSubview(guideButton)
        guideButton.setImage(UIImage(named: "btnRulerGuide.pdf"), for: .normal)
        guideButton.translatesAutoresizingMaskIntoConstraints = false
        guideButton.leftAnchor.constraint(equalTo: pageView.leftAnchor, constant: 315.4*scaleWW).isActive = true
        guideButton.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 590.4*scaleHH).isActive = true
        guideButton.widthAnchor.constraint(equalToConstant: 24*scaleWW).isActive = true
        guideButton.heightAnchor.constraint(equalToConstant: 24*scaleWW).isActive = true
        
        //////// 취소
        pageView.addSubview(cancelButton)
        cancelButton.setImage(UIImage(named: "btnCloseCoachmark.pdf"), for: .normal)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.leftAnchor.constraint(equalTo: pageView.leftAnchor, constant: 335*scaleWW).isActive = true
        cancelButton.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 42*scaleHH).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 24*scaleWW).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 24*scaleWW).isActive = true
        cancelButton.addTarget(self, action: #selector(closeButtonPressed(_:)), for: .touchUpInside)
        
        //////// 측정항목 레이블
        // 측정항목 배경
        let itemView = UIView(frame: CGRect.init())
        pageView.addSubview(itemView)
        itemView.translatesAutoresizingMaskIntoConstraints = false
        itemView.backgroundColor = .init(displayP3Red: 32/255, green: 125/255, blue: 255/255, alpha: 1)
        itemView.layer.cornerRadius = 10
        itemView.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
        itemView.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 37.4*scaleHH).isActive = true
        itemView.widthAnchor.constraint(equalToConstant: 96*scaleWW).isActive = true
        itemView.heightAnchor.constraint(equalToConstant: 32*scaleWW).isActive = true
        
        // 레이블
        itemView.addSubview(itemLabel)
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        itemLabel.topAnchor.constraint(equalTo: itemView.topAnchor).isActive = true
        itemLabel.bottomAnchor.constraint(equalTo: itemView.bottomAnchor).isActive = true
        itemLabel.leftAnchor.constraint(equalTo: itemView.leftAnchor).isActive = true
        itemLabel.rightAnchor.constraint(equalTo: itemView.rightAnchor).isActive = true
        itemLabel.numberOfLines = 0
        

        let paragraphStyle_item = NSMutableParagraphStyle()
        paragraphStyle_item.alignment = .center
        let attributes_item :[NSAttributedString.Key: Any] = [.font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16*scaleWW) as Any,
                                                              .paragraphStyle: paragraphStyle_item,
                                                              .foregroundColor: UIColor.white,
                                                              .kern: 0.24]
        let attrString_item = NSAttributedString(string: itemText, attributes: attributes_item)
        itemLabel.attributedText = attrString_item
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes :[NSAttributedString.Key: Any]
            = [.font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14*scaleWW) as Any,
               .paragraphStyle: paragraphStyle,
               .foregroundColor: UIColor.white,
               .kern: 0.21]
        

        itemView.addSubview(instructionView)
        instructionView.translatesAutoresizingMaskIntoConstraints = false
        instructionView.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
        instructionView.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 89.4*scaleHH).isActive = true
        instructionView.widthAnchor.constraint(equalToConstant: 128*scaleWW).isActive = true
        instructionView.heightAnchor.constraint(equalToConstant: 17*scaleWW).isActive = true
        instructionView.isUserInteractionEnabled = true
        
        let labelView = UIView.init(frame: CGRect.init())
        instructionView.contentView.addSubview(labelView)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
        labelView.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 89.4*scaleHH).isActive = true
        labelView.widthAnchor.constraint(equalToConstant: 128*scaleWW).isActive = true
        labelView.heightAnchor.constraint(equalToConstant: 17*scaleWW).isActive = true
        labelView.isUserInteractionEnabled = true
        
        let instructionLabel = UILabel.init(frame: CGRect.init())
        labelView.addSubview(instructionLabel)
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
        instructionLabel.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 89.4*scaleHH).isActive = true
        instructionLabel.widthAnchor.constraint(equalToConstant: 128*scaleWW).isActive = true
        instructionLabel.heightAnchor.constraint(equalToConstant: 17*scaleWW).isActive = true
        instructionLabel.numberOfLines = 0
        let attrStringInstruction = NSAttributedString(string: instructionText, attributes: attributes)
        instructionLabel.attributedText = attrStringInstruction
        instructionLabel.isUserInteractionEnabled = true
    }
    
    func resultPage(pageView: UIView){
        let scaleWW = UIScreen.main.bounds.width / 375
        let scaleHH = UIScreen.main.bounds.height / 667

        pageView.backgroundColor = .white
        
        //////// 측정결과 레이블
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20*scaleWW) as Any,
                                                         .paragraphStyle: paragraphStyle,
                                                         .foregroundColor: UIColor(red: 29/255.0, green: 29/255.0, blue: 29/255.0, alpha: 1),
                                                         .kern: -0.3571429]
        let attrString = NSAttributedString(string:"측정 결과", attributes: attributes)
        
        let labelTitle = UILabel.init(frame: CGRect.init())
        pageView.addSubview(labelTitle)
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
        labelTitle.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 61.8*scaleHH).isActive = true
        labelTitle.widthAnchor.constraint(equalToConstant: 343*scaleWW).isActive = true
        labelTitle.heightAnchor.constraint(equalToConstant: 24*scaleWW).isActive = true
        labelTitle.numberOfLines = 0
        labelTitle.attributedText = attrString
        
        
        //////// 측정 의류 이미지
        let resultImg = UIImageView(image: UIImage(named: "Mobile"))
        pageView.addSubview(resultImg)
        resultImg.contentMode = .scaleAspectFill
        resultImg.translatesAutoresizingMaskIntoConstraints = false
        resultImg.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
        resultImg.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 110*scaleHH).isActive = true
        resultImg.widthAnchor.constraint(equalToConstant: 140*scaleWW).isActive = true
        resultImg.heightAnchor.constraint(equalToConstant: 140*scaleWW).isActive = true
        resultImg.layer.cornerRadius = 10*scaleWW
        
        resultView(pageView: pageView)
        ////// 측정 의류 이미지

    }
    
    func resultView(pageView: UIView){
        let scaleWW = UIScreen.main.bounds.width / 375
        let scaleHH = UIScreen.main.bounds.height / 667
        
        let attributesText: [NSAttributedString.Key: Any]
            = [.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16*scaleWW) as Any,
               .foregroundColor: UIColor(red: 29/255.0, green: 29/255.0, blue: 29/255.0, alpha: 1),
               .kern: -0.5714285]
        let attributesNum: [NSAttributedString.Key: Any]
            = [.font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16) as Any,
               .foregroundColor: UIColor(red: 52/255.0, green: 100/255.0, blue: 255/255.0, alpha: 1),
               .kern: -0.5714285]
        let attributesCM: [NSAttributedString.Key: Any]
            = [.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16) as Any,
               .foregroundColor: UIColor(red: 119/255.0, green: 119/255.0, blue: 119/255.0, alpha: 1),
               .kern: -0.5714285]
        let attrStringCM = NSAttributedString(string:"cm", attributes: attributesCM)
        
        // 측정항목을 받아오는 코드가 필요... 요기에
        
        //////// 측정 결과 레이블뷰
        let labelView = UIView(frame: CGRect.init())
        pageView.addSubview(labelView)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.centerXAnchor.constraint(equalTo: pageView.centerXAnchor).isActive = true
        labelView.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 307.7*scaleHH).isActive = true
        labelView.widthAnchor.constraint(equalToConstant: 242*scaleWW).isActive = true
        labelView.heightAnchor.constraint(equalToConstant: 229*scaleHH).isActive = true
        

        let length = 7 // 측정항목 개수
        let Hsize = CGFloat(235*scaleHH)/CGFloat(length)
        
        var Ltitle : [String] = ["어깨너비","소매길이","암홀","가슴둘레","허리둘레","엉덩이둘레","총기장(상의)"]
        var LValue : [String] = ["100","20","30","120","23","45","48"]
        
        for index in 0..<length {
            let labelTitle = UILabel.init(frame: CGRect.init())
            labelView.addSubview(labelTitle)
            labelTitle.translatesAutoresizingMaskIntoConstraints = false
            labelTitle.leftAnchor.constraint(equalTo: labelView.leftAnchor).isActive = true
            labelTitle.topAnchor.constraint(equalTo: labelView.topAnchor,
                    constant: Hsize*CGFloat(index)).isActive = true
            labelTitle.widthAnchor.constraint(equalToConstant: 100.8*scaleWW).isActive = true
            labelTitle.heightAnchor.constraint(equalToConstant: 19*scaleWW).isActive = true
            let attrString = NSAttributedString(string:Ltitle[index], attributes: attributesText)
            labelTitle.attributedText = attrString
            
            let labelVal = UILabel.init(frame: CGRect.init())
            labelView.addSubview(labelVal)
            labelVal.translatesAutoresizingMaskIntoConstraints = false
            labelVal.leftAnchor.constraint(equalTo: labelTitle.rightAnchor, constant: 36.2*scaleWW).isActive = true
            labelVal.topAnchor.constraint(equalTo: labelView.topAnchor,
                                            constant: Hsize*CGFloat(index)).isActive = true
            labelVal.widthAnchor.constraint(equalToConstant: 59*scaleWW).isActive = true
            labelVal.heightAnchor.constraint(equalToConstant: 19*scaleWW).isActive = true
            let attrStringNum = NSAttributedString(string:LValue[index], attributes: attributesNum)
            labelVal.attributedText = attrStringNum
            
            let labelCM = UILabel.init(frame: CGRect.init())
            labelView.addSubview(labelCM)
            labelCM.translatesAutoresizingMaskIntoConstraints = false
            labelCM.rightAnchor.constraint(equalTo: labelView.rightAnchor).isActive = true
            labelCM.topAnchor.constraint(equalTo: labelView.topAnchor,
                                             constant: Hsize*CGFloat(index)).isActive = true
            labelCM.widthAnchor.constraint(equalToConstant: 46*scaleWW).isActive = true
            labelCM.heightAnchor.constraint(equalToConstant: 19*scaleWW).isActive = true
            labelCM.attributedText = attrStringCM
        }
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributesRetake: [NSAttributedString.Key: Any]
            = [.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16) as Any,
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor(red: 52/255.0, green: 100/255.0, blue: 255/255.0, alpha: 1),
                .kern: -0.5]
        let attrStringRetake = NSAttributedString(string:"재촬영", attributes: attributesRetake)
        let buttonRetake = UIButton.init(frame: CGRect.init())
        pageView.addSubview(buttonRetake)
        buttonRetake.translatesAutoresizingMaskIntoConstraints = false
        buttonRetake.leftAnchor.constraint(equalTo: pageView.leftAnchor, constant: 42*scaleWW).isActive = true
        buttonRetake.bottomAnchor.constraint(equalTo: pageView.bottomAnchor, constant: -48*scaleWW).isActive = true
        buttonRetake.widthAnchor.constraint(equalToConstant: 139.5*scaleWW).isActive = true
        buttonRetake.heightAnchor.constraint(equalToConstant: 50*scaleWW).isActive = true
        buttonRetake.layer.borderColor = UIColor(red: 52/255.0, green: 100/255.0, blue: 255/255.0, alpha: 1).cgColor
        buttonRetake.layer.borderWidth = 1
        buttonRetake.layer.cornerRadius = 10*scaleWW
        buttonRetake.setAttributedTitle(attrStringRetake, for: .normal)
        
        
        let attributesSave: [NSAttributedString.Key: Any]
            = [.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16) as Any,
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1),
                .kern: -0.5]
        let attrStringSave = NSAttributedString(string:"저장", attributes: attributesSave)
        let buttonSave = UIButton.init(frame: CGRect.init())
        pageView.addSubview(buttonSave)
        buttonSave.translatesAutoresizingMaskIntoConstraints = false
        buttonSave.rightAnchor.constraint(equalTo: pageView.rightAnchor, constant: -42*scaleWW).isActive = true
        buttonSave.bottomAnchor.constraint(equalTo: pageView.bottomAnchor, constant: -48*scaleWW).isActive = true
        buttonSave.widthAnchor.constraint(equalToConstant: 139.5*scaleWW).isActive = true
        buttonSave.heightAnchor.constraint(equalToConstant: 50*scaleWW).isActive = true
        buttonSave.backgroundColor = UIColor(red: 52/255.0, green: 100/255.0, blue: 255/255.0, alpha: 1)
        buttonSave.layer.shadowColor = UIColor(red: 49/255.0, green: 69/255.0, blue: 248/255.0, alpha: 0.3).cgColor
        buttonSave.layer.shadowOpacity = 15
        buttonSave.layer.shadowRadius = 15
        buttonSave.layer.shadowOffset = CGSize.init(width: 0, height: 5)
        buttonSave.layer.cornerRadius = 10*scaleWW
        buttonSave.setAttributedTitle(attrStringSave, for: .normal)
//        buttonSave.sendActions(for: .touchUpInside)
        buttonSave.addTarget(self, action: #selector(finishMeasurement), for: .touchUpInside)
    }
}
