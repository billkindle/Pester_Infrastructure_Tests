# These can possibly be stripped out if a control script is used.
Import-Module Pester

Describe -Name 'Domain Controller Infrastructure Test' {
    try {
        $AllDomains = (get-adforest -ErrorAction Stop).Domains
    } catch {
        $AllDomains = $null
    }

    It -Name 'Active Directory Forest is available' {
        $AllDomains | Should -Not -BeNullOrEmpty
    }
    if ($AllDomains -eq $null) { return }
    foreach ($Domain in $AllDomains) {
        try {
            $DCS = (Get-ADDomainController -Server $Domain -Filter * -ErrorAction Stop | Select HostName).HostName
        } catch {
            $DCS = $null
        }
        It -Name 'Active Directory Domain is available' {
            $DCS | Should -Not -BeNullOrEmpty
        }
        if ($DCS -eq $null) { return }
        foreach ($DC in $DCS) {
            Context -Name "$DC Availability" {

                It -Name "$DC Responds to Ping" {
                    $Ping = Test-NetConnection -ComputerName $DC
                    $Ping.PingSucceeded | Should -Be $true
                }
                It -Name "$DC Responds on Port 53" {
                    $Port = Test-NetConnection -ComputerName $DC -Port 53
                    $Port.TcpTestSucceeded | Should -Be $true
                }
                It -Name "$DC DNS Service is Running" {
                    $DNSsvc = Get-Service -ComputerName $DC -DisplayName 'DNS Server' -ErrorAction Stop
                    $DNSsvc.Status | Should -BeExactly 'Running'
                }
                It -Name "$DC ADDS Service is Running" {
                    $NTDSsvc = Get-Service -ComputerName $DC -DisplayName 'Active Directory Domain Services' -ErrorAction Stop
                    $NTDSsvc.Status | Should -BeExactly 'Running'
                }
                It -Name "$DC ADWS Service is Running" {
                    $ADWSsvc = Get-Service -ComputerName $DC -DisplayName 'Active Directory Web Services' -ErrorAction Stop
                    $ADWSsvc.Status | Should -BeExactly 'Running'
                }
                It -Name "$DC KDC Service is Running" {
                    $KDCsvc = Get-Service -ComputerName $DC -DisplayName 'Kerberos Key Distribution Center' -ErrorAction Stop
                    $KDCsvc.Status | Should -BeExactly 'Running'
                }
                It -Name "$DC Netlogon Service is Running" {
                    $Netlogonsvc = Get-Service -ComputerName $DC -DisplayName 'Netlogon' -ErrorAction Stop
                    $Netlogonsvc.Status | Should -BeExactly 'Running'
                }
            }
            Context -Name "Replication Status" {
                It -Name "$DC Last Replication Result is 0 (Success)" {
                    $RepResult = Get-ADReplicationPartnerMetaData -Target "$DC" -PartnerType Both -Partition *
                    # using $null because success is 0, and that is considered a null value
                    $RepResult.LastReplicationResult | Should -BeIn $null, 0
                }
            }
            #room for future tests if needed
        }
        Context 'Replication Link Status' {

            $results = repadmin /showrepl * /csv | ConvertFrom-Csv # Get the results of all replications between all DCs

            $groups = $results | Group-Object -Property 'Source DSA' # Group the results by the source DC

            foreach ($sourcedsa in $groups) {
                # Create a context for each source DC

                Context "Source DSA = $($sourcedsa.Name)" {

                    $targets = $sourcedsa.Group # Assign the value of the groupings to another var since .Group doesn't implement IComparable

                    $targetdsa = $targets | Group-Object -Property 'Destination DSA' # Now group within this source DC by the destination DC (pulling naming contexts per source and destination together)

                    foreach ($target in $targetdsa ) {
                        # Create a context for each destination DSA

                        Context "Target DSA = $($target.Name)" {

                            foreach ($entry in $target.Group) {
                                # List out the results and check each naming context for failures

                                It "$($entry.'Naming Context') - should have zero replication failures" {
                                    $entry.'Number of failures' | Should Be 0
                                }
                            }
                        }
                    }
                }
            }
        }
    }

}
