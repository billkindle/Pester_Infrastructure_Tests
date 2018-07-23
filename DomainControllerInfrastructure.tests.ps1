$DC01 = ''
$DC02 = ''
Describe -Name 'Domain Controller Infrastructure Test' -Tags 'Infrastructure,Domain Controllers' {
    Context -Name "$DC01 Availability" {
        It -Name "$DC01 Responds to Ping" {
            $Ping = Test-NetConnection -ComputerName $DC01
            $Ping.PingSucceeded | Should -Be $true
        }
        It -Name "$DC01 Responds on Port 53" {
            $Port = Test-NetConnection -ComputerName $DC01
            $Port.TcpTestSucceeded | Should -Be $true
        }
        It -Name "$DC01 DNS Service is Running" {
            $DNSsvc = Get-Service -ComputerName $DC01 -DisplayName 'DNS Server'
            $DNSsvc.Status | Should -BeExactly 'Running'
        }
        It -Name "$DC01 Netlogon Service is Running" {
            $NTDSsvc = Get-Service -ComputerName $DC01 -DisplayName 'Active Directory Domain Services'
            $NTDSsvc.Status | Should -BeExactly 'Running'
        }
        It -Name "$DC01 DNS Service is Running" {
            $ADWSsvc = Get-Service -ComputerName $DC01 -DisplayName 'Active Directory Web Services'
            $ADWSsvc.Status | Should -BeExactly 'Running'
        }
        It -Name "$DC01 KDC Service is Running" {
            $KDCsvc = Get-Service -ComputerName $DC01 -DisplayName 'Kerberos Key Distribution Service'
            $KDCsvc.Status | Should -BeExactly 'Running'
        }
        It -Name "$DC01 Netlogon Service is Running" {
            $Netlogonsvc = Get-Service -ComputerName $DC01 -DisplayName 'Netlogon'
            $Netlogonsvc.Status | Should -BeExactly 'Running'
        }
    }
    Context -Name "$DC02 Availability" {
        It -Name '007DC02 Responds to Ping' {
            $Ping = Test-NetConnection -ComputerName $DC02
            $Ping.PingSucceeded | Should -Be $true
        }
        It -Name '007DC02 Responds on Port 53' {
            $Port = Test-NetConnection -ComputerName $DC02
            $Port.TcpTestSucceeded | Should -Be $true
        }
        It -Name '007DC02 DNS Service is Running' {
            $DNSsvc = Get-Service -ComputerName $DC02 -DisplayName 'DNS Server'
            $DNSsvc.Status | Should -BeExactly 'Running'
        }
        It -Name "$DC02 Netlogon Service is Running" {
            $NTDSsvc = Get-Service -ComputerName $DC02 -DisplayName 'Active Directory Domain Services'
            $NTDSsvc.Status | Should -BeExactly 'Running'
        }
        It -Name "$DC02 DNS Service is Running" {
            $ADWSsvc = Get-Service -ComputerName $DC02 -DisplayName 'Active Directory Web Services'
            $ADWSsvc.Status | Should -BeExactly 'Running'
        }
        It -name "$DC02 KDC Service is Running" {
            $KDCsvc = Get-Service -ComputerName $DC02 -DisplayName 'Kerberos Key Distribution Service'
            $KDCsvc.Status | Should -BeExactly 'Running'
        }
        It -Name "$DC02 Netlogon Service is Running" {
            $Netlogonsvc = Get-Service -ComputerName $DC02 -DisplayName 'Netlogon'
            $Netlogonsvc.Status | Should -BeExactly 'Running'
        }
    }
}