<%@ page import="webubb.domain.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <style>
        .asset-name {
            background-color: cornflowerblue;
            border-right: solid 1px black;
        }
        td:focus {
            background: red;
        }
        td {border: 1px red; padding: 5px; cursor: pointer;}
        .selected {
            background-color: red;
            color: red;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="style.css">
    <script src="js/jquery-2.0.3.js"></script>
    <script src="js/ajax-utils1.js"></script>


</head>

<body>
<%
    response.addHeader("Cache-Control", "no-cache,no-store,private,must-revalidate,max-stale=0,post-check=0,pre-check=0");
    if (session.getAttribute("user") == null){
        response.sendRedirect("index.jsp");
    }
    /*response.addHeader("Pragma", "no-cache");
    response.addDateHeader ("Expires", 0);*/
%>



<%! User user; %>
<%  user = (User) session.getAttribute("user");
    if (user != null) {
        out.println("Welcome "+user.getUsername());
%>

        <br/>
        <div>
            <p><button id="getStart" type="button" class="button" >Get start station</button></p>
        <p id="curr"></p>
        <table id="table"></table>

            <p><button id="gotoPrev" type="button" class="button" style="display: none;">Go to previous</button></p>
            <p><button id="chooseStation" type="button" class="button" style="display: none;">Choose this station</button></p>
            <p><button id="finish" type="button" class="button" style="display: none;">End your trip</button></p>

        <!--<p><button id="logoutBtn" type="button">Log out</button></p>-->
        <form action="LogoutController" method="post">
            <input type="submit" value="Logout" style="background-color:red;" />
        </form>

        <p id="validation"></p>
        </div>

        <script  type="text/javascript">
            var curr="";
            var count=0;
            $(document).ready(function() {


                $("#getStart").click(function() {
                    console.log(1);
                    getChooseStation(<%= user.getId() %>, function(assets) {
                        $("#table").html("");
                        $("#table").append("<tr><td>Choose start station:</td></tr>");// style='background-color: mediumseagreen'
                        for(var elem in assets) {
                            $("#table").append("<tr class='asset-name' tabindex='1'><td>"+assets[elem].name+"</td></tr>");// class='asset-name' tabindex='1'
                        }
                    })
                    $("#getStart").remove();
                    //document.getElementById("getStart").style.visibility = "hidden";

                    document.getElementById("gotoPrev").style.display = "inline";
                    document.getElementById("chooseStation").style.display = "inline";
                    document.getElementById("finish").style.display = "inline";

                })

                $("#chooseStation").click(function () {
                    console.log(1);
                    console.log(curr);

                    if(curr==""){
                        $("#validation").html("Please choose a station!");
                        return;
                    }
                    $("#curr").html("You are at:"+curr);
                    getChooseNext(<%= user.getId() %>, curr, function (assets) {
                        $("#table").html("");
                        $("#table").append("<tr><td>Choose next station:</td></tr>");// style='background-color: mediumseagreen'
                        for (var elem in assets) {
                            $("#table").append("<tr class='asset-name' tabindex='1'><td>" + assets[elem].name + "</td></tr>");// class='asset-name' tabindex='1'
                        }

                    })
                    $("#validation").html("");
                    count=count+1;
                    curr="";
                })

                $("#gotoPrev").click(function () {
                    console.log(1);
                    console.log(curr);
                    //$("#curr").html("You are at:",curr);
                    if(count==1){
                        $("#validation").html("There is no previous station");
                        return;
                    }

                    getChoosePrev(<%= user.getId() %>, function (assets) {
                        $("#table").html("");
                        $("#table").append("<tr><td>Choose next station:</td></tr>");// style='background-color: mediumseagreen'
                        for (var elem in assets) {
                            $("#table").append("<tr class='asset-name' tabindex='1'><td>" + assets[elem].name + "</td></tr>");// class='asset-name' tabindex='1'
                        }
                    })
                    getPrevStation(<%= user.getId() %>, function (assets) {
                        $("#curr").html("You are at:" + assets[0].name);
                    })
                    $("#validation").html("");
                    count=count-1;
                })

                $("#finish").click(function () {
                    console.log(1);
                    console.log(curr);
                    //$("#curr").html("You are at:",curr);
                    getRoute(<%= user.getId() %>, function (assets) {
                        $("#table").html("");
                        $("#table").append("<tr><td>You went on this route</td></tr>");// style='background-color: mediumseagreen'
                        for (var elem in assets) {
                            $("#table").append("<tr class='asset-name' tabindex='1'><td>" + assets[elem].name + "</td></tr>");// class='asset-name' tabindex='1'
                        }
                    })
                })


            });



            //$(document).ready(function(){
            /*
                $("#getStart").click(function() {
                    console.log(1);
                    getChooseStation(, function(assets) {
                        $("#table").html("");
                        $("#table").append("<tr><td>Choose start station:</td></tr>");// style='background-color: mediumseagreen'
                        for(var elem in assets) {
                            $("#table").append("<tr class='asset-name' tabindex='1'><td>"+assets[elem].name+"</td></tr>");// class='asset-name' tabindex='1'
                        }
                    })
                })*/

            //});


            /*$("#logout").click(function () {

            })*/



            $(function() {
                $(document).on('click','#logoutBtn', function() {
                    <%
                    //if (session.getAttribute("user") != null){
                    //    session.invalidate();
                    //    response.sendRedirect("index.html");
                        System.out.println("invalidated");
                    //}
                    %>
                });
            });

            $(function() {
                $(document).on('click','#table tr', function() {
                    //alert(this.rowIndex);
                    //alert($(this).index()); // jQuery way
                    curr=$(this).text();
                    console.log($(this).index());
                    console.log($(this).text());
                });
            });

        </script>
<%
    }
%>

</body>
</html>