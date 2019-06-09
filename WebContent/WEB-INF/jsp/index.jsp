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
    <meta charset="utf-8">
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
    <title></title>
</head>
<body class="easyui-layout">
<div title="软件工程专业工作管理系统" data-options="region:'north',border:false"
     style="height:80px;padding:10px;background:url('images/1.jpg') no-repeat right;">
    <div>
        <img src="images/2.png" height="30px" border="0">
    </div>
    <div id="sessionInfoDiv"
         style="position: absolute;right: 5px;top:10px;">
        [<strong>超级管理员<font color="red">${name }</font></strong>]，欢迎你！
    </div>

    <div style="position: absolute; right: 5px; bottom: 10px; ">
        <a href="javascript:void(0);" class="easyui-menubutton"
           data-options="menu:'#layout_north_pfMenu',iconCls:'icon-ok'">更换皮肤</a>
        <a href="javascript:void(0);" class="easyui-menubutton"
           data-options="menu:'#layout_north_kzmbMenu',iconCls:'icon-help'">系统设置</a>
    </div>

    <div id="layout_north_pfMenu" style="width: 120px; display: none;">
        <div onclick="changeTheme('default');">default</div>
        <div onclick="changeTheme('gray');">gray</div>
        <div onclick="changeTheme('black');">black</div>
        <div onclick="changeTheme('bootstrap');">bootstrap</div>
        <div onclick="changeTheme('metro');">metro</div>
    </div>
    <div id="layout_north_kzmbMenu" style="width: 100px; display: none;">
        <div onclick="editPassword();">修改密码</div>
        <div onclick="showAbout();">联系管理员</div>
        <div class="menu-sep"></div>
        <div onclick="logoutFun();">退出系统</div>
    </div>

</div>
<div title="系统菜单" data-options="region:'west'" style="width: 200px">
    <!-- 折叠面板效果 -->
    <div class="easyui-accordion" data-options="fit:true">
        <!-- 每个子div是其中的一个面板 -->

        <script type="text/javascript">
            function doAdd() {
                //动态添加一个选项卡面板
                //	var e=$("#tt").tabs("exists",treeNode.name);
                $("#tt").tabs(
                    "add", {
                        title: '管理员列表',
                        content: '<iframe frameborder="0" width="100%" height="100%" src="page_base_staff.action"></iframe>',
                        closable: true,
                        iconCls: 'icon-search'
                    });
            }

            changeTheme = function (themeName) {
                var $easyuiTheme = $('#easyuiTheme');
                var url = $easyuiTheme.attr('href');
                var href = url.substring(0, url.indexOf('themes')) + 'themes/'
                    + themeName + '/easyui.css';
                $easyuiTheme.attr('href', href);
                var $iframe = $('iframe');
                if ($iframe.length > 0) {
                    for (var i = 0; i < $iframe.length; i++) {
                        var ifr = $iframe[i];
                        $(ifr).contents().find('#easyuiTheme').attr('href', href);
                    }
                }
            };

            function editPassword() {
                $('#editPwdWindow').window('open');

            }

            // 退出登录
            function logoutFun() {
                $.messager
                    .confirm('系统提示', '您确定要退出本次登录吗?', function (isConfirm) {
                        if (isConfirm) {
                            location.href = 'exit';
                        }
                    });
            }
        </script>

        <script type="text/javascript">
            $(function () {
                window.setTimeout(function () {
                    $.messager.show({
                        title: '欢迎信息',
                        msg: '欢迎${name}登陆系统',
                        timeout: 3000,
                        showType: 'slide'
                    });
                }, 3000);


            });
        </script>
        <!-- </div> -->

        <div title="管理员设置">
            <!-- 展示树形菜单 ：使用简单json数据构造-->
            <!-- 展示树形菜单 ：使用简单json数据构造-->
            <ul id="ztree2" class="ztree"></ul>
            <script type="text/javascript">
                $(function () {
                    //当页面加载完成后，动态创建ztree菜单
                    var setting2 = {
                        data: {
                            simpleData: {
                                enable: true
                                //启用简单json数据描述节点数据
                            }
                        },
                        callback: {   //绑定事件
                            onClick: function (a, b, c) {
                                var page = c.page;
                                if (page != undefined) {
                                    var e = $("#tt").tabs("exists", c.name);
                                    if (e) {
                                        //已经打开
                                        $("#tt").tabs("select", c.name);  //选中这个选项卡
                                    } else {

                                        $("#tt").tabs(
                                            "add", {
                                                title: c.name,
                                                content: '<iframe frameborder="0" width="100%" height="100%" src="' + page + '"></iframe>',
                                                closable: true,
                                                iconCls: 'icon-edit'
                                            });
                                    }
                                }
                            }
                        }
                    };//设置ztree相关的属性
                    //构造json数据
                    var zNodes2 = [{
                        id: '1',
                        pId: '0',
                        name: '管理员列表',
                        page: 'admin/adminlist'
                    },//每个json对象对应一个节点数据
                        {
                            id: '2',
                            pId: '0',
                            name: '权限管理'
                        },//每个json对象对应一个节点数据
                        {
                            id: '21',
                            pId: '2',
                            name: '设置管理员',
                            page: 'admin/addadmin'
                        },//每个json对象对应一个节点数据
                        {
                            id: '22',
                            pId: '2',
                            name: '删除管理员',
                            page: 'admin/removedamin'
                        },//每个json对象对应一个节点数据
                        {
                            id: '3',
                            pId: '0',
                            name: '用户管理'
                        },//每个json对象对应一个节点数据
                        {
                            id: '31',
                            pId: '3',
                            name: '添加教师',
                            page: 'admin/addteacher'
                        },
                        {
                            id: '32',
                            pId: '3',
                            name: '修改用户个人信息',
                            page: 'editmessage'
                        }

                    ];
                    //创建ztree
                    $.fn.zTree.init($("#ztree2"), setting2, zNodes2);
                });
            </script>

        </div>

        <div title="监考管理">
            <!-- 展示树形菜单 ：使用简单json数据构造-->
            <!-- 展示树形菜单 ：使用简单json数据构造-->
            <ul id="ztree3" class="ztree"></ul>
            <script type="text/javascript">
                $(function () {
                    //当页面加载完成后，动态创建ztree菜单
                    var setting3 = {
                        data: {
                            simpleData: {
                                enable: true
                                //启用简单json数据描述节点数据
                            }
                        },
                        callback: {   //绑定事件
                            onClick: function (a, b, c) {
                                var page = c.page;
                                if (page != undefined) {
                                    var e = $("#tt").tabs("exists", c.name);
                                    if (e) {
                                        //已经打开
                                        $("#tt").tabs("select", c.name);  //选中这个选项卡
                                    } else {

                                        $("#tt").tabs(
                                            "add", {
                                                title: c.name,
                                                content: '<iframe frameborder="0" width="100%" height="100%" src="' + page + '"></iframe>',
                                                closable: true,
                                                iconCls: 'icon-edit'
                                            });
                                    }


                                }

                            }
                        }
                    };//设置ztree相关的属性
                    //构造json数据
                    var zNodes3 = [{
                        id: '1',
                        pId: '0',
                        name: '添加监考信息',
                        page: 'admin/addtest'
                    },//每个json对象对应一个节点数据
                        {
                            id: '2',
                            pId: '0',
                            name: '监考信息查询',
                            page: 'searchtest'
                        }//每个json对象对应一个节点数据

                    ];
                    //创建ztree
                    $.fn.zTree.init($("#ztree3"), setting3, zNodes3);
                });
            </script>

        </div>


        <div title="任务管理">
            <!-- 展示树形菜单 ：使用简单json数据构造-->
            <!-- 展示树形菜单 ：使用简单json数据构造-->
            <ul id="ztree4" class="ztree"></ul>
            <script type="text/javascript">
                $(function () {
                    //当页面加载完成后，动态创建ztree菜单
                    var setting4 = {
                        data: {
                            simpleData: {
                                enable: true
                                //启用简单json数据描述节点数据
                            }
                        },
                        callback: {   //绑定事件
                            onClick: function (a, b, c) {
                                var page = c.page;
                                if (page != undefined && page != "") {
                                    var e = $("#tt").tabs("exists", c.name);
                                    if (e) {
                                        //已经打开
                                        $("#tt").tabs("select", c.name);  //选中这个选项卡
                                    } else {

                                        $("#tt").tabs(
                                            "add", {
                                                title: c.name,
                                                content: '<iframe frameborder="0" width="100%" height="100%" src="' + page + '"></iframe>',
                                                closable: true,
                                                iconCls: 'icon-edit'
                                            });
                                    }


                                }

                            }
                        }
                    };//设置ztree相关的属性
                    //构造json数据
                    var zNodes4 = [{
                        id: '1',
                        pId: '0',
                        name: '创建任务',
                        page: 'admin/addtask'
                    },//每个json对象对应一个节点数据
                        {
                            id: '2',
                            pId: '0',
                            name: '修改任务',
                            page: 'admin/edittask'
                        },//每个json对象对应一个节点数据
                        {
                            id: '3',
                            pId: '0',
                            name: '关闭任务',
                            page: 'admin/closetask'
                        },
                        {
                            id: '4',
                            pId: '0',
                            name: '任务信息查询',
                            page: 'searchtask'
                        }
                    ];
                    //创建ztree
                    $.fn.zTree.init($("#ztree4"), setting4, zNodes4);
                });
            </script>

        </div>


    </div>
</div>

<div id="tt" data-options="region:'center'" class="easyui-tabs"></div>

<!--修改密码窗口-->
<div id="editPwdWindow" class="easyui-window" title="修改密码" collapsible="false" minimizable="false" modal="true"
     closed="true" resizable="false"
     maximizable="false" icon="icon-save" style="width: 300px; height: 160px; padding: 5px;
        background: #fafafa">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="editPasswordForm">
                <table cellpadding=3>
                    <tr>
                        <td>新密码：</td>
                        <td><input id="txtNewPass" type="Password" class="txt01 easyui-validatebox"
                                   required="true" name="newpassword"
                        /></td>
                    </tr>
                    <tr>
                        <td>确认密码：</td>
                        <td><input id="txtRePass" type="Password" class="txt01 easyui-validatebox"
                                   required="true"
                        /></td>
                    </tr>
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a id="btnEp" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)">确定</a>
            <a id="btnCancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)">取消</a>
        </div>
    </div>
</div>
<script type="text/javascript">
    //为“确定”按钮绑定事件
    $("#btnEp").click(function () {
        //进行表单校验
        var v = $("#editPasswordForm").form("validate");//对应表单中的所有输入框进行校验
        if (v) {//表单校验通过
            //判断两次输入是否一致
            var v1 = $("#txtNewPass").val();
            var v2 = $("#txtRePass").val();
            if (v1 == v2) {
                //输入一致，发送ajax请求，修改当前用户的密码
                var url = "editpassword";
                $.post(url, {"password": v1}, function (data) {
                    if (data.count == '1') {
                        //修改密码成功
                        $.messager.alert("提示信息", "密码修改成功！", "info");
                    } else {
                        //修改失败
                        $.messager.alert("提示信息", "密码修改失败！", "warning");
                    }
                    //关闭修改密码的窗口
                    $("#editPwdWindow").window("close");
                });
            } else {
                //输入不一致，提示用户输入不一致
                $.messager.alert("提示信息", "两次输入密码不一致！", "warning");
            }
        }
    });

    $("#btnCancel").click(function () {
        $("#editPwdWindow").window("close");
    })
</script>

</body>
</html>