//
//  SlideViewController.swift
//  Essbio
//
//  Created by Matias Villagran on 04-06-17.
//  Copyright © 2017 Matias Villagran. All rights reserved.
//

import UIKit

class SlideViewController: UIViewController, UIPageViewControllerDataSource {

    var pageViewController: UIPageViewController?
    
    let asdasd = ["sao3", "sao4","sao1","sao2","sao5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

createPageViewController()
    setupPageControl()
        

        

     }
    func createPageViewController() {
    let pageController = self.storyboard?.instantiateViewController(withIdentifier: "PageController") as! UIPageViewController
        
        pageController.dataSource = self
        
        if asdasd.count > 0 {
        let firstController = getItemController(0)!
            let startingViewControllers = [firstController]
            
            pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMove(toParentViewController: self)
    }
    
    func setupPageControl(){
     
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.gray
        appearance.currentPageIndicatorTintColor = UIColor.white
        appearance.backgroundColor = UIColor.darkGray
        
        
        
        
        
        
    
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let itemController = viewController as! ImageViewController
        
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
            
        }
        
    
        
        return nil
    }

    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let itemController = viewController as! ImageViewController
        
        if itemController.itemIndex + 1 < asdasd.count {

            return getItemController(itemController.itemIndex+1)
    }

        return nil
        
    
}


    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return asdasd.count
        
}


    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
        
}


    func currentControllerIndex() -> Int {

        let pageItemController = self.currentControllerIndex()
        if let controller = pageItemController as?  ImageViewController{
            return controller.itemIndex
        }
        return -1
        
        
}


    func currentController() -> UIViewController? {

        if (self.pageViewController?.viewControllers?.count)! > 0 {
            return self.pageViewController?.viewControllers![0]
            
        }
        
        return nil
}


    func getItemController(_ itemIndex: Int) -> ImageViewController? {

        if itemIndex < asdasd.count {
        
        let pageItemController = self.storyboard?.instantiateViewController(withIdentifier: "ItemController") as! ImageViewController
            
            pageItemController.itemIndex = itemIndex
            pageItemController.imageName = asdasd[itemIndex]

            
            return pageItemController
        }
        
        return nil
        
        
}
    


}


