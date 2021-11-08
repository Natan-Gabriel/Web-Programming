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
            background: lightgreen;
        }
        td {border: 1px #DDD solid; padding: 5px; cursor: pointer;}
        .selected {
            background-color: brown;
            color: #FFF;
        }
    </style>
    <script src="js/jquery-2.0.3.js"></script>
    <script src="js/ajax-utils1.js"></script>

</head>

<body>
<%! User user; %>
<%  user = (User) session.getAttribute("user");
    if (user != null) {
        out.println("Welcome "+user.getUsername());
%>

        <br/>
        <p><button id="getStart" type="button">Get start station</button></p>
        <p id="curr"></p>
        <table id="table"></table><!--</section>-->

        <!--<input type="button" name="OK" class="ok" value="OK"/>

        <form action="ChooseNextController" method="post">
            <button id="station" type="button">Choose this one</button>
            <input type="submit" value="Choose"/>
        </form>-->

        <p><button id="gotoPrev" type="button">Go to previous</button></p>
        <p><button id="chooseStation" type="button">Choose next</button></p>
        <p><button id="finish" type="button">End your trip</button></p>

        <p id="demo"></p>

        <script  type="text/javascript">
            var curr="";
            document.getElementById("demo").innerHTML = "";
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
                })

                $("#chooseStation").click(function () {
                    console.log(1);
                    console.log(curr);
                    $("#curr").html("You are at:"+curr);
                    getChooseNext(<%= user.getId() %>, curr, function (assets) {
                        $("#table").html("");
                        $("#table").append("<tr><td>Choose next station:</td></tr>");// style='background-color: mediumseagreen'
                        for (var elem in assets) {
                            $("#table").append("<tr class='asset-name' tabindex='1'><td>" + assets[elem].name + "</td></tr>");// class='asset-name' tabindex='1'
                        }
                    })
                })

                $("#gotoPrev").click(function () {
                    console.log(1);
                    console.log(curr);
                    //$("#curr").html("You are at:",curr);

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