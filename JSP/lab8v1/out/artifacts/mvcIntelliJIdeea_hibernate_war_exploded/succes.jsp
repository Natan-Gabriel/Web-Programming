<%@ page import="webubb.domain.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <style>
        .asset-name {
            background-color: cornflowerblue;
            border-right: solid 1px black;
        }
        td {border: 1px #DDD solid; padding: 5px; cursor: pointer;}
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
%>
<%! User user; %>
<%  user = (User) session.getAttribute("user");
    if (user != null) {
        out.println("Welcome "+user.getUsername());
%>

        <br/>
        <div style="width:50%;">
        <p><button id="getStart" type="button" class="button" style="width:100%;" >Get start station</button></p>
        <div id="curr"></div>
        <table id="table"></table>
        <p><button id="gotoPrev" type="button" class="button" style="display: none;width:100%;">Go to previous</button></p>
        <p><button id="chooseStation" type="button" class="button" style="display: none;width:100%;">Choose this station</button></p>
        <p><button id="finish" type="button" class="button" style="display: none;width:100%;">End your trip</button></p>
        <div id="validation" style="left:50%;"></div>
        <form action="LogoutController" method="post">
            <input type="submit" value="Logout" style="background-color:red;" />
        </form>
        </div>







        <script  type="text/javascript">
            var curr="";
            var count=0;
            $(document).ready(function() {


                $("#getStart").click(function() {
                    getChooseStation(<%= user.getId() %>, function(assets) {
                        $("#table").html("");
                        $("#table").append("<tr><td>Choose start station:</td></tr>");
                        for(var elem in assets) {
                            $("#table").append("<tr class='asset-name' tabindex='1'><td>"+assets[elem].name+"</td></tr>");
                        }
                    })
                    $("#getStart").remove();

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
                    if(count==1 || count==0){
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
                    document.getElementById("gotoPrev").style.display = "none";
                    document.getElementById("chooseStation").style.display = "none";
                    document.getElementById("finish").style.display = "none";

                    $("#validation").html("Thanks for choosing us!");
                })

            });

            $(function() {
                $(document).on('click','#table tr', function() {
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