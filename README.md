# PesterInfrastructureTests
A collection of infrastructure related tests for use with Pester &amp; PowerShell.


![Image](https://raw.githubusercontent.com/EvotecIT/PesterInfrastructureTests/Images/master/PesterAD.png)


```
Describing Domain Controller Infrastructure Test
  [+] Active Directory is available 1.03s

  Context AD2.ad.evotec.xyz Availability
    [+] AD2.ad.evotec.xyz Responds to Ping 3.93s
    [+] AD2.ad.evotec.xyz Responds on Port 53 193ms
    [+] AD2.ad.evotec.xyz DNS Service is Running 93ms
    [+] AD2.ad.evotec.xyz ADDS Service is Running 19ms
    [+] AD2.ad.evotec.xyz ADWS Service is Running 21ms
    [+] AD2.ad.evotec.xyz KDC Service is Running 15ms
    [+] AD2.ad.evotec.xyz Netlogon Service is Running 25ms

  Context Replication Status
    [+] AD2.ad.evotec.xyz Last Replication Result is 0 (Success) 655ms

  Context AD1.ad.evotec.xyz Availability
    [+] AD1.ad.evotec.xyz Responds to Ping 226ms
    [+] AD1.ad.evotec.xyz Responds on Port 53 166ms
    [+] AD1.ad.evotec.xyz DNS Service is Running 21.03s
    [+] AD1.ad.evotec.xyz ADDS Service is Running 17ms
    [+] AD1.ad.evotec.xyz ADWS Service is Running 14ms
    [+] AD1.ad.evotec.xyz KDC Service is Running 16ms
    [+] AD1.ad.evotec.xyz Netlogon Service is Running 19ms

  Context Replication Status
    [+] AD1.ad.evotec.xyz Last Replication Result is 0 (Success) 362ms

  Context Replication Link Status

    Context Source DSA = AD2

      Context Target DSA = AD1
        [+] DC=ad,DC=evotec,DC=xyz - should have zero replication failures 297ms
        [+] CN=Configuration,DC=ad,DC=evotec,DC=xyz - should have zero replication failures 13ms
        [+] CN=Schema,CN=Configuration,DC=ad,DC=evotec,DC=xyz - should have zero replication failures 8ms
        [+] DC=DomainDnsZones,DC=ad,DC=evotec,DC=xyz - should have zero replication failures 9ms
        [+] DC=ForestDnsZones,DC=ad,DC=evotec,DC=xyz - should have zero replication failures 15ms
        [+] DC=ad,DC=evotec,DC=pl - should have zero replication failures 10ms

      Context Target DSA = ADPREVIEW2019
        [+] CN=Configuration,DC=ad,DC=evotec,DC=xyz - should have zero replication failures 41ms
        [+] CN=Schema,CN=Configuration,DC=ad,DC=evotec,DC=xyz - should have zero replication failures 7ms
        [+] DC=ForestDnsZones,DC=ad,DC=evotec,DC=xyz - should have zero replication failures 16ms
        [+] DC=ad,DC=evotec,DC=xyz - should have zero replication failures 7ms

    Context Source DSA = AD1

      Context Target DSA = AD2
        [+] DC=ad,DC=evotec,DC=xyz - should have zero replication failures 139ms
        [+] CN=Configuration,DC=ad,DC=evotec,DC=xyz - should have zero replication failures 9ms
        [+] CN=Schema,CN=Configuration,DC=ad,DC=evotec,DC=xyz - should have zero replication failures 15ms
        [+] DC=DomainDnsZones,DC=ad,DC=evotec,DC=xyz - should have zero replication failures 9ms
        [+] DC=ForestDnsZones,DC=ad,DC=evotec,DC=xyz - should have zero replication failures 9ms
        [+] DC=ad,DC=evotec,DC=pl - should have zero replication failures 12ms

    Context Source DSA = ADPREVIEW2019

      Context Target DSA = AD2
        [+] CN=Configuration,DC=ad,DC=evotec,DC=xyz - should have zero replication failures 287ms
        [+] CN=Schema,CN=Configuration,DC=ad,DC=evotec,DC=xyz - should have zero replication failures 8ms
        [+] DC=ForestDnsZones,DC=ad,DC=evotec,DC=xyz - should have zero replication failures 25ms
        [+] DC=ad,DC=evotec,DC=pl - should have zero replication failures 11ms

```
