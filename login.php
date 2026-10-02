<?php 
require_once 'config.php';
session_start();

//Verifica se o usuário já está logado
if(isset($_SESSION['usuario_id'])) {
    header('Location: index.php');
}

//Processo do login
$mensagemErro = "";
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($_POST['email'] ?? '');
    $senha = $_POST['senha'] ?? '';
    
    if(empty($email) || empty($senha)) {
        $mensagemErro = "Por favor, preencha todos os campos.";
    }else{
        try{
            $sql = "SELECT * FROM usuario WHERE email = :email";
            $stmt = $conn->prepare($sql);
            $stmt->execute(['email' => $email]);
            $usuario = $stmt->fetch();

            if(!$usuario){
                $mensagemErro = "Email ou senha incorretos.";
            } elseif ($usuario['ativo'] != 1){
                //se coluna do banco ativo for diferente de 1
                $mensagemErro = "Usuário inativo.";
            }elseif (($senha == $usuario['senha'])) {
                //sucesso!
                $_SESSION['usuario_id'] = $usuario['id'];
                $_SESSION['usuario_nome'] = $usuario['nome'];
                $_SESSION['usuario_email'] = $usuario['email'];
                header('Location: index.php');
            }
        
        
        
            } catch (PDOException $e) {
                $mensagemErro = "Erro ao processar login." . $e->getMessage();
        }
    }
}
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Fábrica</title>
</head>
<body>
    <h1>Sistema Fábrica de Metálicos</h1>

    <?php if(!empty($mensagemErro)){
        echo $mensagemErro;
    } 
    ?>

    <form action="" method="post">
        <div>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
        </div>
        <br>
        <div>
            <label for="senha">Senha:</label>
            <input type="password" id="senha" name="senha" required>
        </div>
        <br>
        <button type="submit">Entrar</button>
    </form>

    
</body>
</html>