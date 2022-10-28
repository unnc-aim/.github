# 欢迎回到UNNC RoboMaster AIM战队  

__本组织开放给所有AIR战队内成员使用，所有成员需遵守以下规范：__
## __1. 仓库使用规范__  

### 1.1 仓库命名规范  
本组织的仓库创建规范为：前缀-使用平台（如果有）-使用软件-仓库名  
其中前缀为：
* Hardware （对应硬件组）  

* Embedded （对应软件组）  

* Vision （对应视觉组）  

* Control （对应控制组）  

使用平台只有软件组成员需要填写：
* 软件组为使用硬件平台的名称，如：STM32，ESP32，Arduino之类

使用软件所有都需要填写：
* 控制组为使用ROS版本的名称，如：Noetic，Humble等

* 视觉组为使用IDE的名称，如：VSCode，Clion，Pycharm等

* 软件组为使用IDE的名称，如：Keil，PIO，CubeIDE等

* 硬件组为使用硬件的名称，如：KiCAD，Cadence，AltiumDesigner等

样例命名为：  
**Hardware-KiCAD-HyperCap  
Embedded-STM32-CubeIDE-Balance，  
Control-Noetic-Infantry，  
Vision-VSCode-PowerRune**

### 1.2 仓库内容规范
所有仓库内 __不允许__ 出现任何编译文件，请妥善使用.gitignore文件来排除项目下所有潜在的编译文件

### 1.3 仓库进度管理
所有仓库禁止直接向master分支直接提交修改，请创建分支并使用Push & Pull request来提交修改，分支命名规范需要符合以下要求：  
* 新增功能无论有没有bug的按照功能的名字命名

* 阶段性成果没有显著问题的按照版本号命名

* 保证所有功能稳定可靠的才可merge到master分支