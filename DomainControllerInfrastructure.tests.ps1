# These can possibly be stripped out if a control script is used.
Import-Module Pester

Describe -Name 'Domain Controller Infrastructure Test' -Tags 'Infrastructure,Domain Controllers' {
    try {
        $DCS = (Get-ADDomainController -Filter * -ErrorAction Stop | Select HostName).HostName
    } catch {
        $DCS = $null
    }
    It -Name 'Active Directory is available' {
        $DCS | Should -Not -BeNullOrEmpty
    }
    foreach ($DC01 in $DCS) {
        Context -Name "$DC01 Availability" {

            It -Name "$DC01 Responds to Ping" {
                $Ping = Test-NetConnection -ComputerName $DC01
                $Ping.PingSucceeded | Should -Be $true
            }
            It -Name "$DC01 Responds on Port 53" {
                $Port = Test-NetConnection -ComputerName $DC01 -Port 53
                $Port.TcpTestSucceeded | Should -Be $true
            }
            It -Name "$DC01 DNS Service is Running" {
                $DNSsvc = Get-Service -ComputerName $DC01 -DisplayName 'DNS Server' -ErrorAction Stop
                $DNSsvc.Status | Should -BeExactly 'Running'
            }
            It -Name "$DC01 ADDS Service is Running" {
                $NTDSsvc = Get-Service -ComputerName $DC01 -DisplayName 'Active Directory Domain Services' -ErrorAction Stop
                $NTDSsvc.Status | Should -BeExactly 'Running'
            }
            It -Name "$DC01 ADWS Service is Running" {
                $ADWSsvc = Get-Service -ComputerName $DC01 -DisplayName 'Active Directory Web Services' -ErrorAction Stop
                $ADWSsvc.Status | Should -BeExactly 'Running'
            }
            It -Name "$DC01 KDC Service is Running" {
                $KDCsvc = Get-Service -ComputerName $DC01 -DisplayName 'Kerberos Key Distribution Center' -ErrorAction Stop
                $KDCsvc.Status | Should -BeExactly 'Running'
            }
            It -Name "$DC01 Netlogon Service is Running" {
                $Netlogonsvc = Get-Service -ComputerName $DC01 -DisplayName 'Netlogon' -ErrorAction Stop
                $Netlogonsvc.Status | Should -BeExactly 'Running'
            }
        }
        Context -Name "Replication Status" {
            It -Name "$DC01 Last Replication Result is 0 (Success)" {
                $RepResult = Get-ADReplicationPartnerMetaData -Target "$DC01" -PartnerType Both -Partition *
                # using $null because success is 0, and that is considered a null value
                $RepResult.LastReplicationResult | Should -BeExactly $null
            }
        }
        #room for future tests if needed
    }
}