<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

<%@ include file="/WEB-INF/jsp/common/css.jsp"%>
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}

	</style>
  </head>

  <body>

	<jsp:include page="/WEB-INF/jsp/common/top.jsp"></jsp:include>
	<div class="container-fluid">
		<div class="row">
			<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp"></jsp:include>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="glyphicon glyphicon-th"></i> 菜单树
						</h3>
					</div>
					<div class="panel-body">
                        		<ul id="treeDemo" class="ztree"></ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	
 <!--BootStrap 增加模态框  -->   
 <div id="addModal" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">菜单维护</h4>
      </div>
      <div class="modal-body">
                  <input type="hidden" id="pid" name="pid">
				  <div class="form-group">
					<label for="exampleInputPassword1">菜单名称</label>
					<input type="text" class="form-control" id="name" name="name" placeholder="请输入菜单名称">
				  </div>
				  <div class="form-group">
					<label for="exampleInputPassword1">功能</label>
					<input type="text" class="form-control" id="url" name="url" placeholder="请输入菜单功能">
				  </div>
				  <div class="form-group">
					<label for="exampleInputPassword1">图标</label>
					<input type="text" class="form-control" id="icon" name="icon" placeholder="请输入菜单图标">
				  </div>
      </div>
      <div class="modal-footer">
        <button id="saveBtn" type="button" class="btn btn-primary">保存</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<!--BootStrap 修改模态框  -->   
 <div id="updateModal" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">菜单维护</h4>
      </div>
      <div class="modal-body">
                  <input type="hidden" id="id" name="id">
				  <div class="form-group">
					<label for="exampleInputPassword1">菜单名称</label>
					<input type="text" class="form-control" id="name" name="name" placeholder="请输入菜单名称">
				  </div>
				  <div class="form-group">
					<label for="exampleInputPassword1">功能</label>
					<input type="text" class="form-control" id="url" name="url" placeholder="请输入菜单功能">
				  </div>
				  <div class="form-group">
					<label for="exampleInputPassword1">图标</label>
					<input type="text" class="form-control" id="icon" name="icon" placeholder="请输入菜单图标">
				  </div>
      </div>
      <div class="modal-footer">
        <button id="updateBtn" type="button" class="btn btn-primary">保存</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

	<%@ include file="/WEB-INF/jsp/common/js.jsp"%>
        <script type="text/javascript">
            $(function () {
			    $(".list-group-item").click(function(){
				    if ( $(this).find("ul") ) {
						$(this).toggleClass("tree-closed");
						if ( $(this).hasClass("tree-closed") ) {
							$("ul", this).hide("fast");
						} else {
							$("ul", this).show("fast");
						}
					}
				});			
			    
			    initTree();
            });
            

     function initTree(){
            	
        $.get("${PATH}/menu/loadTree", {},
           function(result){
                console.log(result);
	    		var setting = {	
			    				data: {
									simpleData: {
													enable: true,
												   	pIdKey: "pid"
							                    }
				                       },
				                view: {
				                		addDiyDom: function(treeId, treeNode){
				                			$("#"+treeNode.tId+"_ico").removeClass();//.addClass();
				                			$("#"+treeNode.tId+"_span").before("<span class='"+treeNode.icon+"'></span>")
				                		},
										addHoverDom: function(treeId, treeNode){  
											var aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
											aObj.attr("href", "javascript:;");
											if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
											var s = '<span id="btnGroup'+treeNode.tId+'">';
											if ( treeNode.level == 0 ) {   ///根节点(只有增加)
												s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="addBtn('+treeNode.id+')" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
											} else if ( treeNode.level == 1 ) {     ///分支节点 有叶子,修改功能
												s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  onclick="updateBtn('+treeNode.id+')" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
												if (treeNode.children.length == 0) {    //没有叶子,添加删除功能
													s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteBtn('+treeNode.id+')" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
												}
												s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="addBtn('+treeNode.id+')" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
											} else if ( treeNode.level == 2 ) {   ///叶子节点(只有修改,删除)
												s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  onclick="updateBtn('+treeNode.id+')" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
												s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteBtn('+treeNode.id+')">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
											}
							
											s += '</span>';
											aObj.after(s);
										},
										removeHoverDom: function(treeId, treeNode){
											$("#btnGroup"+treeNode.tId).remove();
										}

				                	}
				                
	    		              };
                var newJson={id:0,name:"系统菜单",icon:"glyphicon glyphicon-th-list"};
    		    var zNodes =result;
     		    zNodes.push(newJson); 

    			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
    			var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
    			treeObj.expandAll(true);
    			
    			
             })

            	
     }
     
     
 
     ///////增加菜单节点  开始///////////////////////////////////////////////////////////////////
     function addBtn(id){
    	 $('#addModal').modal({
    		 backdrop:'static',
    		 keyboard: false,
    		     show: true   
    		})
    	$("#addModal input[name='pid']").val(id);
 
     }   
     
     $("#saveBtn").click(function(){

    	 var name=$("#addModal input[name='name']").val();
    	 var pid=$("#addModal input[name='pid']").val();
    	 var icon=$("#addModal input[name='icon']").val();
    	 var url=$("#addModal input[name='url']").val();
    	 var json={name:name, pid:pid, icon:icon ,url:url}
    	 console.log(json);
    	 $.post("${PATH}/menu/doAdd", json,
    			   function(result){
    			     if ("ok"==result){
    			    	 layer.msg("保存成功",{time:1000},function(){
    			    		 $("#addModal").modal('hide');
    			    		 $("#addModal input[name='name']").val("");
    			    		 $("#addModal input[name='pid']").val("");
    			    		 $("#addModal input[name='icon']").val("");
    			    		 $("#addModal input[name='url']").val("");
    			    		 initTree(); 
    			    	 })
    			    	 }else{
    			    		 layer.msg("保存失败");
    			    	 } 
    			     
    			   });
     });
     ///////增加菜单节点  结束///////////////////////////////////////////////////////////////////

     ///////删除菜单节点  开始///////////////////////////////////////////////////////////////////
     function deleteBtn(id){
    	 layer.confirm('您确定删除吗？', {
    		  btn: ['确定','取消'] //按钮
    		}, function(index){
                 $.post('${PATH}/menu/doDelete',{id:id},function(result){
			            	   if (result=='ok'){
			            		   layer.msg('删除成功');
			            		   initTree();
			            	   }else{
			            		   layer.msg('删除失败');
			            	   }		            	   
            	     })
               },
    			
             function(index){

 			      layer.close(index);
             }     
     )
     }
     ///////删除菜单节点  结束///////////////////////////////////////////////////////////////////
     
     ///////修改菜单节点  开始///////////////////////////////////////////////////////////////////
     function updateBtn(id){
    	$.get('${PATH}/menu/getMenuById',{id:id},function(result){
    	 $('#updateModal').modal({
    		 backdrop:'static',
    		 keyboard: false,
    		     show: true   
    		});
    		
    		$("#updateModal input[name='name']").val(result.name);
    		$("#updateModal input[name='url']").val(result.url);
    		$("#updateModal input[name='icon']").val(result.icon);
    	    $("#updateModal input[name='id']").val(id);
    	});
    	
     }  
     
     
     $("#updateBtn").click(function(){

    	 var name=$("#updateModal input[name='name']").val();
    	 var id=$("#updateModal input[name='id']").val();
    	 var icon=$("#updateModal input[name='icon']").val();
    	 var url=$("#updateModal input[name='url']").val();
    	 var json={name:name, id:id, icon:icon ,url:url}
    	 console.log(json);
    	 $.post("${PATH}/menu/doUpdate", json,
    			   function(result){
    			     if ("ok"==result){
    			    	 layer.msg("保存成功",{time:1000},function(){
    			    		 $("#updateModal").modal('hide');
    			    		 $("#updateModal input[name='name']").val("");
    			    		 $("#updateModal input[name='id']").val("");
    			    		 $("#updateModal input[name='icon']").val("");
    			    		 $("#updateModal input[name='url']").val("");
    			    		 initTree(); 
    			    	 })
    			    	 }else{
    			    		 layer.msg("保存失败");
    			    	 } 
    			     
    			   });
     });
     ///////修改菜单节点  结束///////////////////////////////////////////////////////////////////

        </script>
  </body>
</html>
    