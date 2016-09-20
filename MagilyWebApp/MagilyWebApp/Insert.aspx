<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Insert.aspx.cs" Inherits="MagilyWebApp.Insert" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Insert Records</title>
    <script src="scripts\angular.js"></script>
</head>
<body data-ng-app="myApp">
    <form id="form1" runat="server">
    <div data-ng-controller="myCtrl">
        Name:<asp:TextBox runat="server" ID="txtName" data-ng-model="Name"></asp:TextBox><br />
        Email:<asp:TextBox runat="server" ID="txtEmail" data-ng-model="Email" ></asp:TextBox><br />
        Phone:<asp:TextBox runat="server" ID="txtPhone" data-ng-model="Phone" ></asp:TextBox><br />
        Username:<asp:TextBox runat="server" ID="txtUname" data-ng-model="Username" ></asp:TextBox><br />
        Password:<asp:TextBox runat="server" ID="txtPass" data-ng-model="Password" ></asp:TextBox><br />
        <asp:Button runat="server" ID="button1" Text="Submit" data-ng-click="SubmitData()" />
        <br />
        
    <!--    <input type="submit" value="View Data" data-ng-click="SubmitData()" />-->

    </div>

        <script>
            var app = angular.module("myApp", [])
            app.controller("myCtrl", function ($scope, $http) 
            {
                $scope.Name = "";
                $scope.Email = "";
                $scope.Phone = "";
                $scope.Username = "";
                $scope.Password = "";
                $scope.SubmitData = function () {
                    var httpreq =
                        {
                            method: 'POST',
                            url: "Insert.aspx/SubmitData",
                            headers:
                            {
                                'Content-Type': 'application/json; characterset=utf-8',
                                'Data-Type': 'json'
                            },
                            data:
                                {
                                    Name: $scope.Name,
                                    Email: $scope.Email,
                                    Phone: $scope.Phone,
                                    Username: $scope.Username,
                                    Password: $scope.Password
                                }
                        }
                    $http(httpreq).success(function (response) {
                        $scope.fillList();
                        alert("Submitted Successfully");
                    }).error(function (data, status) {alert("Error:"+status) })

                };
            $scope.fillList() = function () {
                $scope.Name = "";
                $scope.Email = "";
                $scope.Phone = "";
                $scope.Username = "";
                $scope.Password = "";

                var httpreq = {
                    method: 'POST',
                    url: "Insert.aspx/Get",
                    headers:
                    {
                        'Content-Type': 'application/json; characterset=utf-8',
                        'Data-Type': 'json'
                    },
                    data:
                        {}
                          
                }
                $http(httpreq).success(function (response) {
                    $scope.StudentList=response.data;
                })

            };
            $scope.fillList();
        });
        </script>
    </form>
</body>
</html>
