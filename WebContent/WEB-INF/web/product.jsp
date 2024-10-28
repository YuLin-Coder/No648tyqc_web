<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<meta charset="utf-8">
<title>体育器材预约管理系统</title>
  <link rel="stylesheet" href="<%=path %>/static/res/layui/css/layui.css">
  <link rel="stylesheet" href="<%=path %>/static/res/css/global.css">
  <style>
 	 .header{border-bottom: 1px solid #404553; border-right: 1px solid #404553;}
  </style>
</head>
<body class="fly-full">
   <jsp:include   page="header.jsp" flush="true"/> 
    


<div class="fly-main" style="overflow: hidden;">

  <div class="fly-tab-border fly-case-tab">
    <span>
      <a href="" class="tab-this">体育器材列表</a>
    </span>
  </div>
  <div class="layui-tab layui-tab-brief">
  </div>

  <ul class="fly-case-list"  id="tbody1">
  	
  	
    
    
  </ul>
   <input type="hidden" id="dataTotal1" value='${dataTotal1}'>
   <input type="hidden" id="initPageSize1" value='${dataSize}'>
   <div class="pages" id="dataPage1">


   </div>

  <div style="text-align: center;">
    <!-- <div class="laypage-main">
      <span class="laypage-curr">1</span>
      <a href="">2</a><a href="">3</a>
      <a href="">4</a>
      <a href="">5</a>
      <span>…</span>
      <a href="" class="laypage-last" title="尾页">尾页</a>
      <a href="" class="laypage-next">下一页</a>
    </div> -->
  </div>

</div>
<div class="fly-footer">
 <p> 2022 &copy; <a href="http://www.ymkz.top/"  target="_blank">源码客栈制作</a></p>
  <p>
  
  </p>
</div>
<script src="<%=path %>/static/res/layui/layui.js"></script>
<script src="<%=path %>/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
    $(function() {
        // 初始化数据分页列表
        initDataList1();
    });

    // 初始化数据分页列表
    var initDataList1 = function() {
        var pageNum = 1;// 初始化当前是第一页
        var pageSize = $("#initPageSize1").val();// 初始化每页条数
        var total = $("#dataTotal1").val();// 总条数
        var pageDivId = 'dataPage1';// 分页的div的id
        var url = '${pageContext.request.contextPath}/selectWebProductData';// 获取分页数据的连接
        var param = {page:pageNum, limit:pageSize}// 查询条件
        getDataList1(pageDivId, total, param, url);
    }

    //ajax后台请求获得数据列表
    var getDataList1 = function(pageDivId, total, param, url) {
        $.ajax({
            type : "get",
            url : url,
            data : param,
            async : false,
            dataType:"json",
            success : function(data){
                createDataList1(data, pageDivId, total, param, url);
            }
        });
    }
    //创建数据列表html
    var createDataList1 = function(data, pageDivId, total, param, url) {
        total = data.total;
        param.page = data.pageNum;
         param.limit = data.pageSize;
        var list = data.list;
        var html = '';
        for(var i in list){
            html +=
                '<li data-id="123" >'
                +'<a   class="fly-case-img" href="<%=path %>/webProductDetail?id='+list[i].id +'"  >'  
                +' <img src="upload/'+list[i].photo +'" alt="项目">'
                +'</a>'
                +' <h2><a href="<%=path %>/webProductDetail?id='+list[i].id +'" >'+list[i].title +'</a></h2>'
                +'<p class="fly-case-desc">'+list[i].detail +'</p>'
                +' <div class="fly-case-info">'
                +' <p class="layui-elip" style="font-size: 12px;"><span style="color: #666;">数量:'+list[i].stock +'</span> </p>'
                +' <p class="layui-elip" style="font-size: 12px;"><span style="color: #666;">编号:'+list[i].qcbh +'</span> </p>'
                +' </div>'
                +'</li>';
        }
        $("#tbody1").html('').append(html);

        // 创建分页div的html
        createPageDiv1(pageDivId, total, param, url);
    }
    //创建分页div的html
    var createPageDiv1 = function(pageDivId, total, param, url) {
        layui.use([ 'laypage', 'layer' ], function() {
            var laypage = layui.laypage, layer = layui.layer;
            laypage.render({
                elem : pageDivId,
                curr : param.page,
                limit : param.limit,
                count : total,
                prev : '<',
                next: '>',
                limits : [ 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 ],
                layout : [ 'prev', 'page', 'next', 'count',  'limit', 'skip' ],
                jump : function(obj, first) {
                	param.page  = obj.curr;
                    param.limit = obj.limit;
                    total = obj.count;
                    if (!first) {
                        getDataList1(pageDivId, total, param, url);
                    }
                }
            });
        })
    }
</script>
</body>
</html>