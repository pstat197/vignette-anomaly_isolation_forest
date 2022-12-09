# vignette-group_6

Vignette on implementing isolation forest anomaly detection to identify credit card fraud; created as a class project for PSTAT197A in Fall 2022.

## Contributors
Daniel Badilla Jr., Dan Le, Anya Macomber, and Sofia Spasibenko.

## Abstract
Isolation Forest (iForest) is an unsupervised machine learning algorithm which is used for anomaly detection. We will be using iForests to detect credit card fraud or money laundering. This repository will implement the iForest algorithm in both R and Python to allow for application to projects in different languages. 

## Repository contents
data - the datasets used in the vignette 
  * creditcard.RData - the dataset for the R implementation.
  * creditcard.csv - the dataset for the python implementation.
img - supplementary images
  * auroc-table.png - shows the models used in the vignette.
  
  * isolationForest.png - shows how isolation forest detects anomolies.
  
  * outlier-plot.png - shows the amount of outliers detected in the dataset.
  
scripts -

  * drafts - preliminary scripts
   
    * R - R scripts
     
      * .DS_Store

      * anyaScratch.R

      * sofspaseScratch.R
   
    * python - python scripts
    
      * .ipynb_checkpoints
        
        * anomolydetectioncreditcard-checkpoint.ipynb
      
      * anomolydetectioncreditcard.ipynb
   
   
  
    


## References
Dataset: https://www.kaggle.com/datasets/mlg-ulb/creditcardfraud

Method references:

https://cs.nju.edu.cn/zhouzh/zhouzh.files/publication/icdm08b.pdf	

https://blog.paperspace.com/anomaly-detection-isolation-forest/

https://github.com/h2oai/h2o-tutorials/blob/master/tutorials/isolation-forest/isolation-forest.ipynb
