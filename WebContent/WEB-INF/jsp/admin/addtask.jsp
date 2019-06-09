<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <base href="<%=basePath%>">
    <link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css"
          href="js/ext/portal.css">
    <link rel="stylesheet" type="text/css"
          href="css/default.css">
    <script type="text/javascript"
            src="js/ext/jquery.portal.js"></script>

    <script type="text/javascript"
            src="js/ext/jquery.cookie.js"></script>

    <script type="text/javascript" src="js/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="js/jquery.easyui.min.js"></script>
    <link rel="stylesheet" href="ztree/zTreeStyle.css" type="text/css">
    <script
            src="js/outOfBounds.js"
            type="text/javascript"></script>
    <script
            src="js/locale/easyui-lang-zh_CN.js"
            type="text/javascript"></script>
    <script type="text/javascript"
            src="ztree/jquery.ztree.all-3.5.js"></script>

    <meta charset="utf-8">
    <title></title>
    <script type="text/javascript">
        function doAdd() {
            //alert("增加...");
            $('#addStaffWindow').window("open");
        }

        function doView() {
            alert("查看...");
        }

        //批量关闭任务
        function doDelete() {
            //获得选中的行
            var rows = $("#grid").datagrid("getSelections");
            if (rows.length == 0) {
                //没有选中，提示
                $.messager.alert("提示信息", "请选择需要关闭的任务！", "warning");
            } else {
                var array = new Array();
                //选中了记录,获取选中行的id
                for (var i = 0; i < rows.length; i++) {
                    var id = rows[i].id;
                    array.push(id);
                }
                var ids = array.join(",");
                //发送请求，传递ids参数
                window.location.href = 'removeuser/' + ids;
                //window.location.reload ='admin/addteacher';

            }
            //window.location.href ='admin/addteacher';
        }

        function doRestore() {
            alert("将教师信息还原...");
        }

        $(function () {
            // 先将body隐藏，再显示，不会出现页面刷新效果
            $("body").css({visibility: "visible"});

            $('#grid').datagrid({
                columns: [[//定义标题行所有的列
                    {field: 'id', title: '编号', checkbox: true},
                    {
                        field: 'tasktype',
                        title: '任务类型',
                        width: 120,
                        align: 'center'
                    },
                    {
                        field: 'taskname',
                        title: '任务名称',
                        width: 120,
                        align: 'center'
                    },
                    {
                        field: 'taskinfo',
                        title: '任务描述',
                        width: 120,
                        align: 'center'
                    },
                    {
                        field: 'taskend',
                        title: '截止时间',
                        width: 120,
                        align: 'center'
                    }
                ]],
                url: 'selecttasks',//指定URL地址，控件自动发送ajax请求获取数据
                toolbar: [//工具栏
                    {
                        id: 'button-add',
                        text: '创建任务',
                        iconCls: 'icon-add',
                        handler: doAdd
                    },
                    {
                        id: 'button-delete',
                        text: '关闭任务',
                        iconCls: 'icon-cancel',
                        handler: doDelete
                    },
                    /* {text:'修改',iconCls:'icon-edit'} */
                ],


                //	singleSelect:true,//是否可以单选
                pageList: [3, 5, 10],
                pagination: true,
                rownumbers: true
            });

            // 添加教师窗口
            $('#addStaffWindow').window({
                title: '创建任务',
                width: 400,
                modal: true,//遮罩效果
                shadow: true,//阴影效果
                closed: true,//关闭状态
                height: 400,
                resizable: false//是否可以调整大小
            });

            // 修改教师窗口
            $('#editStaffWindow').window({
                title: '修改教师信息',
                width: 400,
                modal: true,//遮罩效果
                shadow: true,//阴影效果
                closed: true,//关闭状态
                height: 400,
                resizable: false//是否可以调整大小
            });

        });

        //双击事件处理函数
        function doDblClickRow(rowIndex, rowData) {//{id:xxx,name:xx,}
            $('#editStaffWindow').window("open");//打开修改窗口
            $("#editStaffForm").form("load", rowData);
        }

        //扩展校验规则
        /* 	$(function(){
                var reg = /^1[3|4|5|7|8|9][0-9]{9}$/;
                $.extend($.fn.validatebox.defaults.rules, {
                        phonenumber: {
                                    validator: function(value, param){
                                        return reg.test(value);
                                    },
                                    message: '手机号输入有误！'
                                    }
                        });
                }); */
    </script>

</head>
<body class="easyui-layout" style="visibility:hidden;">
创建任务
<div region="center" border="false">
    <table id="grid"></table>
</div>


<div class="easyui-window" title="对教师进行添加或者修改" id="addStaffWindow" collapsible="false" minimizable="false"
     maximizable="false" style="top:20px;left:200px">
    <div region="north" style="height:31px;overflow:hidden;" split="false" border="false">
        <div class="datagrid-toolbar">
            <a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true">保存</a>
            <script type="text/javascript">
                $(function () {
                    //绑定事件
                    $("#save").click(function () {
                        //校验表单输入项
                        var v = $("#addStaffForm").form("validate");
                        if (v) {
                            //校验通过，提交表单
                            $("#addStaffForm").submit();
                        }
                    });
                });
            </script>
        </div>
    </div>


    <!-- 点击增加之后出来的弹出框 -->

    <div region="center" style="overflow:auto;padding:5px;" border="false">
        <form id="addStaffForm" action="create"
              method="post">
            <table class="table-edit" width="80%" align="center">
                <tr class="title">
                    <td colspan="2">任务信息</td>
                </tr>
                <tr>
                    <td>任务类型</td>
                    <!-- 	<td><input type="select" name="tasktype" class="easyui-validatebox" required="true">
                        </td> -->
                    <td>
                        <!-- 						<select name="tasktype">
                                                <option value="回复类任务">回复类任务</option>
                                                <option value="文件类任务">文件类任务</option>
                                                </select> -->
                        <input type="text" name="tasktype" class="easyui-validatebox" required="true">

                    </td>
                </tr>
                <tr>
                    <td>任务名称</td>
                    <td><input type="text" name="taskname" class="easyui-validatebox" required="true"/></td>
                </tr>

                <tr>
                    <td>任务描述</td>
                    <td><input type="text" name="taskinfo" class="easyui-validatebox" required="true"

                    /></td>
                </tr>
                <tr>
                    <td>截止时间</td>
                    <td><input type="data" name="taskend" class="easyui-validatebox" required="true"/></td>
                </tr>

            </table>
            <input type="submit"></input>
        </form>
    </div>
</div>


<!-- 修改窗口 -->
<div class="easyui-window" title="对教师进行添加或者修改" id="editStaffWindow" collapsible="false"
     minimizable="false" maximizable="false" style="top:20px;left:200px">
    <div region="north" style="height:31px;overflow:hidden;" split="false" border="false">
        <div class="datagrid-toolbar">
            <a id="edit" icon="icon-save" href="#" class="easyui-linkbutton" plain="true">保存</a>
            <script type="text/javascript">
                $(function () {
                    //绑定事件
                    $("#edit").click(function () {
                        //校验表单输入项
                        var v = $("#editStaffForm").form("validate");
                        if (v) {
                            //校验通过，提交表单
                            $("#editStaffForm").submit();
                        }
                    });
                });
            </script>
        </div>
    </div>

</div>
</body>
</html>