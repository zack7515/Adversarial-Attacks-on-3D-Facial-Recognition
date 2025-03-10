# Adversarial-Attacks-on-3D-Facial-Recognition

## Project Description
This project aims to research and implement adversarial attacks on 3D facial recognition systems,
primarily using depth and normal images for testing and experimentation.

## Features
- Computes depth maps and normal maps from facial point clouds using the FRGC dataset.
- Enhances image quality by conducting facial attacks focused on regions of interest.
- Explores direct point cloud attacks utilizing 2D information.

## Acknowledgements
This project references code from the following GitHub repositories:

1. [Led3D by muyouhang](https://github.com/muyouhang/Led3D) - Used for depth map calculations.
2. [pytorch-grad-cam by jacobgil](https://github.com/jacobgil/pytorch-grad-cam) - Integrated for visualization and gradient-based attention maps.

We have made modifications to the original code to fit our project’s specific needs while adhering to the respective licenses.

## Installation and Usage
- All data path you need to rewrite by yourself
  
1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/your-username/your-repo-name.git
   ```
2. pip install requirement
   ```bash
   cd 專案名
   pip install -r requirements.txt
   ```
3. run jupyter notebook after loading your data path
   - grad-cam-attack folder: adversarial attacks on 2D image (depth and normal)
     - heatmap_attack.ipy: implement adversarial attacks on 2D image.
   - pointcloud_attack folder: adversarial attacks on point cloud
     - attack_dataset.ipy: implement adversarial attacks on point cloud.
     - recognition.ipy: recongnition 2D images.
   - util folder: depth and normal map calculations (modified from Led3D)
     - dataset_convert.m : used to convert dataset to depth and normal map.

