# L4D2_CloudBannedList
### Cloud Banned List For Left 4 Dead 2

# !!! 本项目处于DEMO状态 !!!    
# !!! 出现变化恕不另行通知 !!!    
    
## 本插件需要 sm-ripext 插件拓展才可正常工作  
https://github.com/ErikMinekus/sm-ripext  
本插件使用了该拓展进行HTTP请求以进行黑名单数据下载和JSON解析  
    
该插件仅在Sourcemod1.10平台上测试通过      
    

本项目

    
API:    
```
http://bannedlist.nekochocolate.space:2086/get.php
```    
用于提供标准的JSON信息    
          
```
http://bannedlist.nekochocolate.space:2086/BannedList.CFG
```    
用于提供标准的JSON信息(更快)