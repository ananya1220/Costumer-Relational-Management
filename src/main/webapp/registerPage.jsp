
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register - User Management System</title>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register - User Management System</title>
        <style>
            body {
                margin: 0;
                padding: 0;
                background-image: url('https://media.istockphoto.com/id/1344573706/fr/photo/homme-daffaires-touchant-%C3%A0-lic%C3%B4ne-humaine-virtuelle-pour-le-groupe-de-clients-de-focus-ou.jpg?s=612x612&w=0&k=20&c=2YiiJWHvvW-VhMH65kfCi41JjGUChjsmnL56ps5zDwM=');
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .container {
                width: 420px;
                padding: 35px 30px;
                border-radius: 16px;
                background: linear-gradient(135deg, rgba(255, 248, 220, 0.9), rgba(255, 204, 153, 0.9), rgba(255, 153, 102, 0.9));
                box-shadow: 0 12px 24px rgba(0, 0, 0, 0.3);
                color: #4e342e;
                transition: all 0.3s ease;
                animation: fadeIn 0.5s ease-in-out;
                text-align: center;
            }

            h2 {
                color: #6d4c41;
                font-weight: bold;
                font-size: 24px;
                margin-bottom: 10px;
            }

            h2 u {
                text-decoration: none;
                border-bottom: 3px solid #ff7043;
                padding-bottom: 5px;
            }

            form {
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            input {
                width: 95%;
                padding: 12px;
                margin-bottom: 15px;
                border: none;
                border-radius: 10px;
                box-shadow: inset 0 0 5px rgba(0,0,0,0.1);
                font-size: 15px;
                text-align: center;
            }

            input:focus {
                outline: none;
                box-shadow: 0 0 8px rgba(255, 87, 34, 0.5);
                border: 1px solid #ff7043;
            }

            button {
                width: 95%;
                padding: 12px;
                background: linear-gradient(to right, #ff7043, #ffab91);
                border: none;
                border-radius: 10px;
                color: white;
                font-size: 16px;
                font-weight: bold;
                cursor: pointer;
                transition: transform 0.3s ease, background 0.3s ease;
            }

            button:hover {
                background: linear-gradient(to right, #e64a19, #ff8a65);
                transform: scale(1.05);
            }

            p {
                text-align: center;
                margin-top: 20px;
                font-size: 14px;
                color: #3e2723;
            }

            p a {
                color: #bf360c;
                text-decoration: none;
                font-weight: bold;
            }

            p a:hover {
                text-decoration: underline;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>
    </head>
    
        <div class="container">
            <h2>Create an Account</h2>

            <div id="registerForm" style="margin-top: 30px;">
                <h2><u>Register</u></h2>

                <form id="register_Form" onsubmit="register(event)">
                    <input type="hidden" name="action" value="register">

                    <input type="text" name="username" placeholder="Enter Username" required>
                    <input type="password" name="password" placeholder="Enter Password" required>

                    <button type="submit">Register</button>
                </form>

                <p>
                    Already have an account?
                    <a href="index.html">Login here</a>
                </p>
            </div>
        </div>

        <script>
            function register(event) {
                event.preventDefault();
                const form = new FormData(document.getElementById('register_Form'));

                fetch("NewServlet", {
                    body: new URLSearchParams(form),
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    }
                }).then((res) => {
                    if (res.redirected) {
                        window.location.href = res.url;
                        return Promise.reject("Redirected");
                    }
                    return res.text();
                }).then(data => {
                    alert(data);
                }).catch(error => console.error("Registration Error:", error));
            }
        </script>
    </body>
</html>


</body>

        <script>
            function register(event) {
                event.preventDefault();
                const form = new FormData(document.getElementById('register_Form'));

                fetch("NewServlet", {
                    body: new URLSearchParams(form),
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    }
                }).then((res) => {
                    if (res.redirected) {
                        window.location.href = res.url;
                        return Promise.reject("Redirected");
                    }
                    return res.text();
                }).then(data => {
                    alert(data);
                }).catch(error => console.error("Registration Error:", error));
            }
        </script>

    
</html>

