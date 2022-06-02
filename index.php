<?php
session_start();

require_once "config.php";

$nim = $password = "";
$nim_err = $password_err = $login_err = "";

if($_SERVER["REQUEST_METHOD"] == "POST"){

    if(empty(trim($_POST["nim"]))){
        $nim_err = "Masukkan nim.";
    } else{
        $nim = trim($_POST["nim"]);
    }

    if(empty(trim($_POST["password"]))){
        $password_err = "Masukkan password.";
    } else{
        $password = trim($_POST["password"]);
    }

    if($nim == "admin" && $password == "admin"){
        header("location: admin.php");
    }

    if(empty($nim_err) && empty($password_err)){
        $sql = "SELECT nim, semester_mahasiswa FROM tmahasiswa WHERE semester_mahasiswa > 4 AND nim = ?";
        
        if($stmt = mysqli_prepare($link, $sql)){
            mysqli_stmt_bind_param($stmt, "s", $param_nim);
            
            $param_nim = $nim;
            
            if(mysqli_stmt_execute($stmt)){
                mysqli_stmt_store_result($stmt);
                
                if(mysqli_stmt_num_rows($stmt) == 1){                    
                    mysqli_stmt_bind_result($stmt, $nim, $semester_mahasiswa);
                    if(mysqli_stmt_fetch($stmt)){
                        if($nim == $password){
                            session_start();
                            
                            $_SESSION["loggedin"] = true;
                            $_SESSION["nim"] = $nim;   
                            $_SESSION["semester_mahasiswa"] = $semester_mahasiswa;               
                            
                            header("location: mahasiswa.php?id=". $nim);
                        } else{
                            $login_err = "Invalid nim or password.";
                        }
                    }
                } else{
                    $login_err = "Invalid nim or password.";
                }
            } else{
                echo "Oops! Something went wrong. Please try again later.";
            }

            mysqli_stmt_close($stmt);
        }
    }
    
    mysqli_close($link);
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MBKM - Login</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body{ font: 14px sans-serif; }
        .wrapper{ width: 360px; padding: 20px; }
    </style>
</head>
<body>
    <div class="wrapper">
        <h2>Login</h2>

        <?php 
        if(!empty($login_err)){
            echo '<div class="alert alert-danger">' . $login_err . '</div>';
        }        
        ?>

        <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
            <div class="form-group">
                <label>NIM</label>
                <input type="text" name="nim" class="form-control <?php echo (!empty($nim_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $nim; ?>">
                <span class="invalid-feedback"><?php echo $nim_err; ?></span>
            </div>    
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" class="form-control <?php echo (!empty($password_err)) ? 'is-invalid' : ''; ?>">
                <span class="invalid-feedback"><?php echo $password_err; ?></span>
            </div>
            <div class="form-group">
                <input type="submit" class="btn btn-primary" value="Login">
            </div>
        </form>
    </div>
</body>
</html>