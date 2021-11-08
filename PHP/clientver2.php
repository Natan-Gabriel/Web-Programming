<!DOCTYPE html>
<html>
<body>

<!--<form action="" method="post">
<p>1-st number: <input type="text" name="number1" /></p>
<p>2-nd number: <input type="text" name="number2" /></p>
<p><input type="submit"/></p>-->

<?php 
            function addNumbers($firstNumber, $secondNumber)
            {
            if (isset($_POST['number1']) && isset($_POST['number2']))
            {
                $firstNumber = $_POST['number1'];
                $secondNumber = $_POST['number2'];
                $result = $firstNumber + $secondNumber;
                    echo $result;
            }

            }
    ?>

            <!--<form action="urphpfilename.php" method="post">-->

            <p>1-st number: <input type="text" name="number1" /></p>
            <p>2-nd number: <input type="text" name="number2" /></p>
            <?php addNumbers($firstNumber, $secondNumber);?>
            <p><?php echo $result; ?></p>
            <p><input type="submit"/></p>


</body>
</html>