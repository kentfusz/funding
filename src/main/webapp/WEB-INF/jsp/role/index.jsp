<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
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
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#C00;}
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
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
			  </div>
			  <div class="panel-body">
<form class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input id="condition" class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button id="queryBtn" onclick="queryOnClick()" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<security:authorize access="hasRole('PM - 项目经理')">
	<button type="button" id="addBtn" class="btn btn-primary" style="float:right;"><i class="glyphicon glyphicon-plus"></i> 新增</button>
</security:authorize>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input type="checkbox"></th>
                  <th>名称</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>
						
              </tbody>
			  <tfoot>
			     <tr >
				     <td colspan="6" align="center">
						<ul class="pagination">
								<li class="disabled"><a href="#">上一页</a></li>
								<li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li>
								<li><a href="#">2</a></li>
								<li><a href="#">3</a></li>
								<li><a href="#">4</a></li>
								<li><a href="#">5</a></li>
								<li><a href="#">下一页</a></li>
							 </ul>
					 </td>
				 </tr>

			  </tfoot>
            </table>
          </div>
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
        <h4 class="modal-title">请输入角色名称</h4>
      </div>
      <div class="modal-body">
				  <div class="form-group">
					<label for="exampleInputPassword1">角色</label>
					<input type="text" class="form-control" id="name" name="name" placeholder="请输入角色名称">
				  </div>
      </div>
      <div class="modal-footer">
        <button id="saveBtn" type="button" class="btn btn-primary">保存</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

 <!--BootStrap 权限分配模态框  -->   
 <div id="assignModal" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">权限分配</h4>
      </div>
      <div class="modal-body">
				<ul id="treeDemo" class="ztree"></ul>
      </div>
      <div class="modal-footer">
        <button id="assignBtn" type="button" class="btn btn-primary">保存</button>
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
        <h4 class="modal-title">请输入角色名称</h4>
      </div>
      <div class="modal-body">
				  <div class="form-group">
				    <input type="hidden" id="id" name="id">
					<label for="exampleInputPassword1">角色</label>
					<input type="text" class="form-control" id="name" name="name" placeholder="请输入角色名称">
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
			    
			    initData(1);
			    

            });
            
              
            
            	var json={pageNum:1,
            			  pageSize:2
            			  };
            	
            function initData(pageNum){
            	
            	json.pageNum=pageNum;
            	var index=-1;
            	
			    $.ajax({
			    	type:'post',
			    	url:'${PATH}/role/loadData',
			    	data:json,
			    	beforeSend:function(){
			    		index=layer.load(0,{time:10*1000});
			    		return true;
			    	},
			    	
			    	success:function(result){
			    		console.log(result);
			    		
			    		layer.close(index);
			    		
			    		initShow(result);
			    		
			    		initNavy(result);
			    	}
			    	
			    });
		    
            }
            
            
            
            function initShow(result){
            	var list=result.list;
            	var content='';
            	
            	$('tbody').empty();
            	
            	$.each(list,function(i,e){
            		var tr=$("<tr></tr>");
            		tr.append("<td>"+(i+1)+"</td>");
            		tr.append('<td><input type="checkbox"></td>');
            		tr.append("<td>"+e.name+"</td>");

            		var td=$("<td></td>");
            		td.append('<button type="button" roleId='+e.id+' class="assignPermissionClass btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>');
            		td.append('<button type="button" roleId='+e.id+' class="updateClass btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>');
            		td.append('<button type="button" roleId='+e.id+' class="deleteClass btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>');

            		tr.append(td);


	        		$("tbody").append(tr);
         		
            	})
            	
            	 
            	
            }
            /////////////////调用树///////////////////////////////////////////////
            
            var roleId="";

            $("tbody").on("click",".assignPermissionClass",function(){
            	$('#assignModal').modal({
            		backdrop:'static',
            		keyboard:false,
            		show:true
            	});
            	  roleId=$(this).attr("roleId");
            	  console.log("树 1 roleId="+roleId);

            	  initTree();
           
            });
                     
            //////////////初始化树////////////////////////
            function initTree(){
                  	
              $.get("${PATH}/permission/listAllPerssionTree", 
                 function(result){                   
      	    		var setting = {	
		      	    				check: {
		      	    					enable: true
		      	    				},

      			    				data: {
      									simpleData: {
      													enable: true,
      												   	pIdKey: "pid"
      							                    
      				                                },
	      				                key:{name:"title"},
	      				                view: {
	      				                		addDiyDom: function(treeId, treeNode){
	      				                			$("#"+treeNode.tId+"_ico").removeClass();//.addClass();
	      				                			$("#"+treeNode.tId+"_span").before("<span class='"+treeNode.icon+"'></span>")
	      				                		}


      				                	      }
      			    				}
      	    		              };


          			var treeObj=$.fn.zTree.init($("#treeDemo"), setting, result);
          			//var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
          			treeObj.expandAll(true);
              	     console.log("树 2 roleId="+roleId);
              	     ///////回显已有的权限,并打钩/////////////////////////
              	    
              	     
              	     $.get('${PATH}/role/listPermissionIdByRoleId',{roleId,roleId},function(result){
	              	    	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	              	    	var nodes = treeObj.getSelectedNodes();
	              	    	              	    	
	              	    	$.each(result,function(i,id){
	              	    	    node = treeObj.getNodeByParam("id", id, null); 
	              	    		treeObj.checkNode(node, true,false, false);
	              	    	});
              	     }) ;
          			          			
                   })

                  	
           }
         /////////////////////////权限树  授权///////////////////////////////////////
            $('#assignBtn').click(function(){

           	var newJson={roleId:roleId}; 
            	
            	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
            	var nodes = treeObj.getCheckedNodes(true);

                
            	$.each(nodes, function(i, e){
            		  
            		  newJson['ids['+i+']']=e.id;
            		  
            		});
            	
            	
            	
            	$.ajax({type:"post",
            		     url: "${PATH}/role/doAssignPermissionToRole",
            		     data: newJson, 
            		     success: function(result){
            		    	       if (result=="ok"){
            		    	    	   layer.msg("授权成功",{icon:4,time:1000});
            		    	         }	    	 	              
            	                   else{
            	                	  layer.msg("授权失败",{icon:5,time:1000});
            	                  }
            		    	       $('#assignModal').modal('hide');
            		                 
            		     }
            	}); 
            	
            	
            	
            });
            
            
           
             ////////////////////////////////////////////////////////////////     
   
             
             
             
             
             
             ////////////////////////////////////////////////////////////////           
             ////////////////////////////////////////////////////////////////           
            function initNavy(result){
            	console.log(result);
            	
            	$('.pagination').empty();

            	var pages=result.navigatepageNums;
            	var ul=$(".pagination");

            	var li='';
            	if (result.isFirstPage){
            	   li='<li class="disabled"><a href="#">上一页</a></li>';
            	}else{
            	   li='<li ><a onclick="initData('+(result.pageNum-1)+')">上一页</a></li>';
            	}

            	ul.append($(li));
            		

            	$.each(pages,function(i,page){
            	    if (page==result.pageNum){
            		    li='<li class="active"><a href="#">'+page+' <span class="sr-only">(current)</span></a></li>';
            		}else{
            		    li='<li><a onclick="initData('+page+')">'+page+'</a></li>';
            		}

            		ul.append($(li));
            		
            	});


            	if (result.isLastPage){
            	   li='<li class="disabled"><a href="#">下一页</a></li>';
            	}else{
            	   li='<li ><a onclick="initData('+(result.pageNum+1)+')">下一页</a></li>';
            	}


            	ul.append($(li));
            }
            
            function queryOnClick(){
            	var condition=$("#condition").val();
            	json.condition=condition;
            	
            	
            	initData(json.pageNum);
            	
            }
            
            
/*             增加开始 */
            
            $("#addBtn").click(function(){
            	$('#addModal').modal({
            		backdrop:'static',
            		keyboard:false,
            		show:true
            	});
            });
            
            $("#saveBtn").click(function(){
            	var name=$("#addModal input[name='name']").val();
            	
            	$.ajax({
            		type:'post',
            		 url:'${PATH}/role/doAdd',
            		data:{name:name},
              beforeSend:function(){
            	         return true;
                    },
                	success:function(result){
                		if ('ok'==result){
                			layer.msg('保存成功', 
                				  {time: 1000},
                				  function(){
                						$('#addModal').modal('hide');
                						
                						$("#addModal input[name='name']").val('');
                					  initData(1);
                				  })
                		}else if("403"==result){
                			layer.msg("你无权使用",{icon:5,time:1000});
                		}else{
                			layer.msg("保存失败",{icon:5,time:1000});
                		}
                	}
            	
            	});
            	
            });
            /*             增加结束 */
            
            /*             修改开始 */
            $("tbody").on("click", '.updateClass',function(){
            	var id=$(this).attr("roleId");
            	console.log('update roleid='+id);
            	$.get("${PATH}/role/getRoleById", { id:id },
            			  function(result){
            			    console.log(result);
            			    
                        	$('#updateModal').modal({
                        		backdrop:'static',
                        		keyboard:false,
                        		show:true
                        	});
            			    
            			    $("#updateModal input[name='name']").val(result.name);
            			    $("#updateModal input[name='id']").val(result.id); 
            			  });
            	
            });
            
            
             $("#updateBtn").click(function(){
            	var name=$("#updateModal input[name='name']").val();
            	var id=$("#updateModal input[name='id']").val();
            	$.ajax({
            		type:'post',
            		 url:'${PATH}/role/doUpdate',
            		data:{name:name,
            			  id:id},
              beforeSend:function(){
            	         return true;
                    },
                	success:function(result){
                		if ('ok'==result){
                			layer.msg('保存成功', 
                				  {time: 1000},
                				  function(){
                						$('#updateModal').modal('hide');
                						initData(json.pageNum);		
                				  })
                				  
                		}else if('403'==result){
                			layer.msg("你无权使用",{icon:5,time:1000});
                		}else{
                			layer.msg('保存失败', 
                  				  {time: 1000},
                  				  function(){
                  						$('#updateModal').modal('hide');
                  								
                  				  })
                		}
                		             		
                	}
            	
            	}); 
            	
            });
             /*             修改结束 */       
             
            /*             删除开始 */	
				            $('tbody').on('click','.deleteClass',function(){
				            	var id=$(this).attr("roleId");
				            	
				                layer.confirm('你是否确认删除？', {
				              	  btn: ['确认','取消'] //按钮
				              	}, function(index){			            	
								       $.post("${PATH}/role/doDelete",{id:id},function(result){
										            	    	if ("ok"==result){
										            	    		layer.msg("删除成功",{time:1000});
										            	    		initData(json.pageNum);
										            	    	}else{
										            	    		layer.msg("删除失败");
										            	    	}
								            	 	            	  
						            		 
						            	     });   //   $.post
								            	
				            		layer.close(index);
				                },function(index){           		
            		                layer.close(index);
            	                });  //layer.confirm
				                
						            	     
				              	});
            
            /*             删除结束 */            

        </script>
  </body>
</html>
    