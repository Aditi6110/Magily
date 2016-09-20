<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrationForm.aspx.cs" Inherits="MagilyWebApp.RegistrationForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>REgistration Form</title>
    <script src="scripts\angular.js"></script> 
    <script src="scripts\jquery-3.1.0.js"></script>
    <script>
    $(document).ready(function()
    {
        alert("welcome..");
    }); 
        </script>
</head>
<body data-ng-app="myApp">
    <form id="myForm" runat="server" data-ng-controller="auth" ng-submit="Submit()" >
    <div >
        <table>
            <tr>
                <th colspan="3">
                    REGISTER
                </th>
            </tr>
            <tr>
                <td>Name</td>
                <td>
                    <input type="text" data-ng-model="Name" id="name" />
                </td>
                

            </tr>

            <tr>
                <td>Email</td>
                <td>
                    <input type="text" data-ng-model="Email" id="email" />
                </td>
                
            </tr>

             <tr>
                <td>Phone</td>
                <td>
                    <input type="text" data-ng-model="Phone" id="phone" />
                </td>
               
            </tr>

             <tr>
                <td>Username</td>
                <td>
                    <input type="text" data-ng-model="Username" id="username" />
                </td>
                 
            </tr>

             <tr>
                <td>Password</td>
                <td>
                    <input type="password" data-ng-model="Password" id="password" />
                </td>
                
            </tr>
            <tr data-ng-controller="EditCtrl">
                <td><input type="submit" value="Submit" /></td>
                <td><input type="button" value="Update" data-ng-click="Update()" /></td>
            </tr>
            <tr>
                <td colspan="2"><input type="text" hidden="hidden" id="hidden"/></td>
            </tr>

           <tr data-ng-controller="EditCtrl">
                
                <td colspan="2"><input type="button" value="Delete" data-ng-click="Delete()" /></td>
            </tr>

        </table>
    </div>
        
        <script>
            var app = angular.module("myApp", []);
           

            app.controller("auth", function ($scope, $http) {
                $scope.Submit = function () {
                    alert("in submit");
                    $http({
                        method: "GET",
                        url: "WebServiceForm1.asmx/Insert",
                        params: {
                            Name: $scope.Name,
                            Email: $scope.Email,
                            Phone: $scope.Phone,
                            Username: $scope.Username,
                            Password: $scope.Password
                        }
                    })
                        .error(function(status){alert("error:"+status)})
                        .then(function (response) { $scope.reply = response.data });
                };
            });

            app.controller("SelectCtrl", function ($scope, $http) {
                alert("in select controller");
                $http.get("WebServiceForm1.asmx/GetList").then(function (response) { $scope.reg1 = response.data; });
            });

            app.controller("EditCtrl", function ($scope, $http) {
                $scope.Edit = function (Rid,Rname,Remail,Rphone,Rusername,Rpass) {
                    $("#hidden").val(Rid);
                    $("#name").val(Rname);
                    $("#email").val(Remail);
                    $("#phone").val(Rphone);
                    $("#username").val(Rusername);
                    $("#password").val(Rpass);
                    alert("in edit");
                    
                    
                };

               /* $scope.Delete = function (RegID) {
                    alert("in delete");
                    $("#hidden").val(RegID);
                    var regid = RegID;
                    if (confirm("Are you sure you want to delete?")) {
                        $http({
                            method: 'POST',
                            url: 'WebServiceForm1.asmx/Delete',
                            params: { RegistrationID: $("#hidden").val() }
                        }).error(function (status) { alert("error:" + status) }).then();
                    }
                };
            */
                $scope.Update = function () {

                    alert("in update");
                    $http({
                        method: 'GET',
                        url: 'WebServiceForm1.asmx/Edit',
                        params: {
                            RegistrationID: $("#hidden").val(),
                            Name: $("#name").val(),
                            Email: $("#email").val(),
                            Phone: $("#phone").val(),
                            Username: $("#username").val(),
                            Password: $("#password").val()
                        }
                    })
                    .error(function (status) { alert("error:" + status) })
                    .then(function (response) { $scope.display = response.data; alert("Updated.");})


                };
            });

         

        </script>
        <div data-ng-controller="SelectCtrl">
        <table border="1" data-ng-controller="EditCtrl">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Username</th>
                    <th>Password</th>
                    <th>EDIT</th>
                    <th>DELETE</th>
                </tr>
            </thead>
            <tbody>
                <tr data-ng-repeat="Registration in reg1">
                    <td>{{Registration.RegistrationID}}</td>
                    <td>{{Registration.Name}}</td>
                    <td>{{Registration.Email}}</td>
                    <td>{{Registration.Phone}}</td>
                    <td>{{Registration.Username}}</td>
                    <td>{{Registration.Password}}</td>
                     <td><a href="#" data-ng-click="Edit(Registration.RegistrationID,Registration.Name,Registration.Email
                         ,Registration.Phone,Registration.Username,Registration.Password)">Edit</a></td>
                    <td><a href="#" data-ng-click="Delete(Registration.RegistrationID)">DELETE</a></td>
                </tr>
            </tbody>
        </table>
        </div>
    </form>
</body>
</html>
