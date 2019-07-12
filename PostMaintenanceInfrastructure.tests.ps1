<#
    Created By: Bill Kindle
    Date        10/12/18

    Purpose:

    This Pester test verifies that all production services
    are in their correct state. Treat this test as a continuous 
    work in progress, adding additional tests as needed. 

#>

# Here I have to store encrypted credentials to use when checking one of the websites. 
# Otherwise, you will get an error everytime which is a false failure.
$user = "[creds]"
$file = "C:\PScripts\[user]cred.txt"
$MyCredential = New-Object -TypeName System.Management.Automation.PSCredential `
    -ArgumentList $user, (Get-Content -Path $file | ConvertTo-SecureString)

# Here is the test set for Production servers only.
Describe -Name 'Production Applications Infrastructure Test' -Tag 'Prod' {

# These services must be running in order for the application stack to be considered fully operational.
    Context -Name 'BITS' {

        It -Name 'BITS is Running' {

            $BitsSvc = Invoke-Command -ComputerName 'Server01' -ScriptBlock {
                Get-Service -ServiceName BITS
            }
            $BitsSvc.Status | Should -BeExactly 'Running'

        }

    }

    Context -Name 'Service01 Services on Server01' {

        It -Name 'Service01 is Running' {

            $Svc01 = Invoke-Command -ComputerName 'Server01' -ScriptBlock {
                Get-Service -ServiceName 'Service01'
            }
            $Svc01.Status | Should -BeExactly 'Running'

        }

        It -Name 'Service02 is Running' {

            $Svc02 = Invoke-Command -ComputerName 'Server01' -ScriptBlock {
                Get-Service -ServiceName 'Service02'
            }
            $Svc02.Status | Should -BeExactly 'Running'

        }

        It -Name 'Service03 is Running' {

            $Svc03 = Invoke-Command -ComputerName 'Server01' -ScriptBlock {
                Get-Service -ServiceName 'Service03'
            }
            $Svc03.Status | Should -BeExactly 'Running'

        }

        It -Name 'ActiveMQ is Running' {

            $ActMQ = Invoke-Command -ComputerName 'Server01' -ScriptBlock {
                Get-Service -ServiceName 'ActiveMQ'
            }
            $ActMQ.Status | Should -BeExactly 'Running'

        }

        It -Name 'ZooKeeper is Running' {

            $ZooKpr = Invoke-Command -ComputerName 'Server01' -ScriptBlock {
                Get-Service -ServiceName 'ZooKeeper'
            }
            $ZooKpr.Status | Should -BeExactly 'Running'

        }

    }

    Context -Name 'IIS Application Pools' {

        It -Name 'MyAppPool is Started' {

            $MyAppPool = Invoke-Command -ComputerName 'Server01' -ScriptBlock {
                Get-WebAppPoolState -Name 'MyAppPool'
            }
            $MyAppPool.Value | Should -BeExactly 'Started'
            
        }

        It -Name 'TheirAppPool is Started' {

            $TheirAppPool = Invoke-Command -ComputerName 'Server02' -ScriptBlock {
                Get-WebAppPoolState -Name 'TheirAppPool'
            }
            $TheirAppPool.Value | Should -BeExactly 'Started'

        }

    }

# In this section I'm testing webpages that should be available as long as the application pools are running.
    Context -Name 'Website Applications' {

        It -Name 'http://server01/login.aspx is available' {

            $Svr1web = Invoke-WebRequest -Uri 'http://server01/login.aspx'
            $Svr1web.StatusCode | Should -BeExactly '200'

        }

        It -Name 'http://server02/about.aspx is available' {

            $Svr2web = Invoke-WebRequest -Uri 'http://server02/about.aspx' -Credential $MyCredential
            $Svr2web.StatusCode | Should -BeExactly '200'

        }
       
    }

}

