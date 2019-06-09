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

        function doSet() {
            //alert("设置...");
            var rows = $("#grid").datagrid("getSelections");
            if (rows.length == 0) {
                //没有选中，提示
                $.messager.alert("提示信息", "请选择需要设为管理员的教师！", "warning");
            } else {
                var array = new Array();
                //选中了记录,获取选中行的id
                for (var i = 0; i < rows.length; i++) {
                    var id = rows[i].id;
                    array.push(id);
                }
                var ids = array.join(",");
                //发送请求，传递ids参数
                window.location.href = 'setadmin/' + ids;

            }
        }

    </script>
</head>
<body>
修改用户个人信息

<table id="grid">
</table>
<script type="text/javascript">
    $(function () {
        // 先将body隐藏，再显示，不会出现页面刷新效果
        $("body").css({visibility: "visible"});


        $("#grid").datagrid({
            columns: [[//定义标题行所有的列
                {field: 'id', title: '编号', checkbox: true},
                {
                    field: 'userName',
                    title: '姓名',
                    width: 120,
                    align: 'center'
                },
                {
                    field: 'password',
                    title: '密码',
                    width: 120,
                    align: 'center'
                },
                {
                    field: 'phone',
                    title: '手机号',
                    width: 120,
                    align: 'center'
                },
                {
                    field: 'title',
                    title: '职称',
                    width: 120,
                    align: 'center'
                },
                {
                    field: 'times',
                    title: '监考次数',
                    width: 120,
                    align: 'center'
                },
                {
                    field: 'content',
                    title: '介绍',
                    width: 200,
                    align: 'center'
                }

            ]],
            url: 'selectonlyteachers',//指定URL地址，控件自动发送ajax请求获取数据
            toolbar: [//工具栏

                {text: '设为管理员', iconCls: 'icon-edit', handler: doSet}
            ],
            singleSelect: true,//是否可以单选
            pagination: true,//分页条
            pageList: [3, 5, 7],  //分页条中的下拉框选项

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
        //alert("双击事件");
        $('#editStaffWindow').window("open");//打开修改窗口
        $("#editStaffForm").form("load", rowData);

    }

    //扩展校验规则
    $(function () {
        var reg = /^1[3|4|5|7|8|9][0-9]{9}$/;
        $.extend($.fn.validatebox.defaults.rules, {
            phonenumber: {
                validator: function (value, param) {
                    return reg.test(value);
                },
                message: '手机号输入有误！'
            }
        });

    });
</script>

<!-- 修改窗口 -->
<div class="easyui-window" title="对用户进行修改" id="editStaffWindow" collapsible="false"
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
    <div region="center" style="overflow:auto;padding:5px;" border="false">
        <form id="editStaffForm" action="update"
              method="post">
            <input type="hidden" name="id">
            <table class="table-edit" width="80%" align="center">
                <tr class="title">
                    <td colspan="2">教师信息</td>
                </tr>
                <tr>
                    <td>姓名</td>
                    <td><input type="text" name="userName" class="easyui-validatebox" required="true"/></td>
                </tr>
                <tr>
                    <td>密码</td>
                    <td><input type="text" name="password" class="easyui-validatebox" required="true"/></td>
                </tr>

                <tr>
                    <td>手机</td>
                    <td><input type="text" name="phone" class="easyui-validatebox" required="true"
                               data-options="validType:'phonenumber'"
                    /></td>
                </tr>
                <tr>
                    <td>职称</td>
                    <td><input type="text" name="title" class="easyui-validatebox" required="true"/></td>
                </tr>
                <tr>
                    <td>监考次数</td>
                    <td><input type="text" name="times" class="easyui-validatebox" required="true"/>
                    </td>
                </tr>
                <tr>
                    <td>个人介绍</td>
                    <td>
                        <input type="text" name="content" class="easyui-validatebox" required="true"/>
                    </td>
                </tr>
            </table>
            <input type="submit"></input>
        </form>
    </div>
</div>


<!-- 修改窗口 -->
<div class="easyui-window" title="对教师进行修改" id="editStaffWindow" collapsible="false"
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