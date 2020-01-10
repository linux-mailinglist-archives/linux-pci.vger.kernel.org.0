Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2606136850
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2020 08:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgAJHdZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jan 2020 02:33:25 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:47992 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726564AbgAJHdZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jan 2020 02:33:25 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B5EBBFE965AAD02FE03D;
        Fri, 10 Jan 2020 15:33:21 +0800 (CST)
Received: from [127.0.0.1] (10.65.58.147) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 10 Jan 2020
 15:33:11 +0800
Subject: Re: PCI: bus resource allocation error
To:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        "Nicholas Johnson" <nicholas.johnson-opensource@outlook.com.au>
References: <f0cab9da-8e74-e923-a2fe-591d065228ee@hisilicon.com>
CC:     fangjian 00545541 <f.fangjian@huawei.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <1bcc117a-3fce-35c2-a52c-f417db3ce030@hisilicon.com>
Date:   Fri, 10 Jan 2020 15:33:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <f0cab9da-8e74-e923-a2fe-591d065228ee@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

It seems the attachments are blocked by the server.
The necessary console output is below.
The kernel version is 5.4, centos release 7.6.  I didn't
change the PCI codes.

[root@localhost ~]# echo 8 > /proc/sys/kernel/printk
[root@localhost ~]# lspci -vvv -s 7c:00.0
7c:00.0 PCI bridge: Huawei Technologies Co., Ltd. HiSilicon PCI-PCI Bridge (rev 20) (prog-if 00 [Normal decode])
        Bus: primary=7c, secondary=7d, subordinate=7d, sec-latency=0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 0000000120000000-00000001210fffff

[root@localhost ~]# lspci -vvv -s 7d:00.0
7d:00.0 Ethernet controller: Huawei Technologies Co., Ltd. HNS GE/10GE/25GE RDMA Network Controller (rev 21)
        Region 0: Memory at 121000000 (64-bit, prefetchable) [size=64K]
        Region 2: Memory at 120000000 (64-bit, prefetchable) [size=1M]
        Capabilities: [200 v1] Single Root I/O Virtualization (SR-IOV)
                Region 0: Memory at 0000000121010000 (64-bit, prefetchable)
                Region 2: Memory at 0000000120100000 (64-bit, prefetchable)
                VF Migration: offset: 00000000, BIR: 0

[root@localhost ~]# lspci -vvv -s 7d:00.1
7d:00.1 Ethernet controller: Huawei Technologies Co., Ltd. HNS GE/10GE/25GE Network Controller (rev 21)
        Region 0: Memory at 121040000 (64-bit, prefetchable) [size=64K]
        Region 2: Memory at 120400000 (64-bit, prefetchable) [size=1M]
        Capabilities: [200 v1] Single Root I/O Virtualization (SR-IOV)
                Region 0: Memory at 0000000121050000 (64-bit, prefetchable)
                Region 2: Memory at 0000000120500000 (64-bit, prefetchable)
                VF Migration: offset: 00000000, BIR: 0

[root@localhost ~]# lspci -vvv -s 7d:00.2
7d:00.2 Ethernet controller: Huawei Technologies Co., Ltd. HNS GE/10GE/25GE RDMA Network Controller (rev 21)
        Region 0: Memory at 121080000 (64-bit, prefetchable) [size=64K]
        Region 2: Memory at 120800000 (64-bit, prefetchable) [size=1M]
        Capabilities: [200 v1] Single Root I/O Virtualization (SR-IOV)
                Region 0: Memory at 0000000121090000 (64-bit, prefetchable)
                Region 2: Memory at 0000000120900000 (64-bit, prefetchable)
                VF Migration: offset: 00000000, BIR: 0

[root@localhost ~]# lspci -vvv -s 7d:00.3
7d:00.3 Ethernet controller: Huawei Technologies Co., Ltd. HNS GE/10GE/25GE Network Controller (rev 21)
        Region 0: Memory at 1210c0000 (64-bit, prefetchable) [size=64K]
        Region 2: Memory at 120c00000 (64-bit, prefetchable) [size=1M]
        Capabilities: [200 v1] Single Root I/O Virtualization (SR-IOV)
                Region 0: Memory at 00000001210d0000 (64-bit, prefetchable)
                Region 2: Memory at 0000000120d00000 (64-bit, prefetchable)
                VF Migration: offset: 00000000, BIR: 0
[root@localhost ~]# cat /proc/iomem
120000000-13fffffff : PCI Bus 0000:7c
  120000000-1210fffff : PCI Bus 0000:7d
    120000000-1200fffff : 0000:7d:00.0
      120000000-1200fffff : hclge
    120100000-1203fffff : 0000:7d:00.0
    120400000-1204fffff : 0000:7d:00.1
      120400000-1204fffff : hclge
    120500000-1207fffff : 0000:7d:00.1
    120800000-1208fffff : 0000:7d:00.2
      120800000-1208fffff : hclge
    120900000-120bfffff : 0000:7d:00.2
    120c00000-120cfffff : 0000:7d:00.3
      120c00000-120cfffff : hclge
    120d00000-120ffffff : 0000:7d:00.3
    121000000-12100ffff : 0000:7d:00.0
      121000000-12100ffff : hclge
    121010000-12103ffff : 0000:7d:00.0
    121040000-12104ffff : 0000:7d:00.1
      121040000-12104ffff : hclge
    121050000-12107ffff : 0000:7d:00.1
    121080000-12108ffff : 0000:7d:00.2
      121080000-12108ffff : hclge
    121090000-1210bffff : 0000:7d:00.2
    1210c0000-1210cffff : 0000:7d:00.3
      1210c0000-1210cffff : hclge
    1210d0000-1210fffff : 0000:7d:00.3
[root@localhost ~]# cd /sys/devices/pci0000\:7c/0000\:7c\:00.0/
[root@localhost 0000:7c:00.0]# echo 1 > 0000\:7d\:00.3/remove
[  687.008181] hns3 0000:7d:00.3 eth11: net stop
[  687.012769] hns3 0000:7d:00.3 eth11: link down
[  687.098528] pci 0000:7d:00.3: Removing from iommu group 40
[root@localhost 0000:7c:00.0]# echo 1 > ../pci_bus/0000\:7c/bus_rescan
[  705.747983] pci 0000:7d:00.3: [19e5:a221] type 00 class 0x020000
[  705.753983] pci 0000:7d:00.3: reg 0x10: [mem 0x1210c0000-0x1210cffff 64bit pref]
[  705.761351] pci 0000:7d:00.3: reg 0x18: [mem 0x120c00000-0x120cfffff 64bit pref]
[  705.768755] pci 0000:7d:00.3: reg 0x224: [mem 0x1210d0000-0x1210dffff 64bit pref]
[  705.776208] pci 0000:7d:00.3: VF(n) BAR0 space: [mem 0x1210d0000-0x1210fffff 64bit pref] (contains BAR0 for 3 VFs)
[  705.786515] pci 0000:7d:00.3: reg 0x22c: [mem 0x120d00000-0x120dfffff 64bit pref]
[  705.793967] pci 0000:7d:00.3: VF(n) BAR2 space: [mem 0x120d00000-0x120ffffff 64bit pref] (contains BAR2 for 3 VFs)
[  705.804377] pci 0000:7c:00.0: bridge window [mem 0x00100000-0x002fffff] to [bus 7d] add_size 300000 add_align 100000
[  705.814859] pci 0000:7c:00.0: BAR 14: no space for [mem size 0x00500000]
[  705.821532] pci 0000:7c:00.0: BAR 14: failed to assign [mem size 0x00500000]
[  705.828553] pci 0000:7c:00.0: BAR 14: no space for [mem size 0x00200000]
[  705.835228] pci 0000:7c:00.0: BAR 14: failed to assign [mem size 0x00200000]
[  705.842250] pci 0000:7d:00.3: BAR 2: assigned [mem 0x120c00000-0x120cfffff 64bit pref]
[  705.850135] pci 0000:7d:00.3: BAR 9: assigned [mem 0x120d00000-0x120ffffff 64bit pref]
[  705.858022] pci 0000:7d:00.3: BAR 0: assigned [mem 0x1210c0000-0x1210cffff 64bit pref]
[  705.865909] pci 0000:7d:00.3: BAR 7: assigned [mem 0x1210d0000-0x1210fffff 64bit pref]
[  705.873917] hns3 0000:7d:00.3: Adding to iommu group 40
[  705.879792] hns3 0000:7d:00.3: The firmware version is 1.9.23.6
[  705.887760] libphy: hisilicon MII bus: probed
[  705.948493] hns3 0000:7d:00.3: hclge driver initialization finished.
[  705.955523] RTL8211F Gigabit Ethernet mii-0000:7d:00.3:07: attached PHY driver [RTL8211F Gigabit Ethernet] (mii_bus:phy_addr=mii-0000:7d:00.3:07, irq=POLL)
[root@localhost 0000:7c:00.0]#


On 2020/1/9 11:35, Yicong Yang wrote:
> Hi,
>
> recently I met a problem with pci bus resource allocation. The allocation strategy
> makes me confused and leads to a wrong allocation results.
>
> There is a hisilicon network device with four functions under one root port. The
> original bios resources allocation looks like:
>
> 7c:00.0 Root Port
>      prefetchable memory behind bridge: 12000000-0x1210fffff 17M [64bit pref]
>     7d:00.0
>         bar0: 0x121000000-0x12100ffff 64k  [64bit pref]
>         bar2: 0x120000000-0x1200fffff 1M   [64bit pref]
>         bar7: 0x121010000-0x12103ffff 128K [64bit pref]
>         bar9: 0x120100000-0x1203fffff 3M   [64bit pref]
>     7d:00.1
>         bar0: 0x121040000-0x12104ffff 64k  [64bit pref]
>         bar2: 0x120400000-0x1204fffff 1M   [64bit pref]
>         bar7: 0x121050000-0x12107ffff 128K [64bit pref]
>         bar9: 0x120500000-0x1207fffff 3M   [64bit pref]
>     7d:00.2
>         bar0: 0x121080000-0x12108ffff 64k  [64bit pref]
>         bar2: 0x120800000-0x1208fffff 1M   [64bit pref]
>         bar7: 0x121090000-0x1210bffff 128K [64bit pref]
>         bar9: 0x120900000-0x120bfffff 3M   [64bit pref]
>     7d:00.3
>         bar0: 0x1210c0000-0x1210cffff 64k  [64bit pref]
>         bar2: 0x120c00000-0x120cfffff 1M   [64bit pref]
>         bar7: 0x121010000-0x12103ffff 128K [64bit pref]
>         bar9: 0x120d00000-0x120ffffff 3M   [64bit pref]
>
> When I remove function 7d:00.3 and try to rescan the bus[7c], kernel prints the
> error information.
> [  391.770030] pci 0000:7d:00.3: [19e5:a221] type 00 class 0x020000
> [  391.776024] pci 0000:7d:00.3: reg 0x10: [mem 0x1210c0000-0x1210cffff 64bit pref]
> [  391.783394] pci 0000:7d:00.3: reg 0x18: [mem 0x120c00000-0x120cfffff 64bit pref]
> [  391.790786] pci 0000:7d:00.3: reg 0x224: [mem 0x1210d0000-0x1210dffff 64bit pref]
> [  391.798238] pci 0000:7d:00.3: VF(n) BAR0 space: [mem 0x1210d0000-0x1210fffff 64bit pref] (contains BAR0 for 3 VFs)
> [  391.808543] pci 0000:7d:00.3: reg 0x22c: [mem 0x120d00000-0x120dfffff 64bit pref]
> [  391.815994] pci 0000:7d:00.3: VF(n) BAR2 space: [mem 0x120d00000-0x120ffffff 64bit pref] (contains BAR2 for 3 VFs)
> [  391.826391] pci 0000:7c:00.0: bridge window [mem 0x00100000-0x002fffff] to [bus 7d] add_size 300000 add_align 100000
> [  391.836869] pci 0000:7c:00.0: BAR 14: no space for [mem size 0x00500000]
>                                                             ^^^^^^^^^^^^^^^^^^^^^^^   
> [  391.843543] pci 0000:7c:00.0: BAR 14: failed to assign [mem size 0x00500000]
>                                                             ^^^^^^^^^^^^^^^^^^^^^^^^^
> [  391.850562] pci 0000:7c:00.0: BAR 14: no space for [mem size 0x00200000]
>                                                             ^^^^^^^^^^^^^^^^^^^^^^^
> [  391.857237] pci 0000:7c:00.0: BAR 14: failed to assign [mem size 0x00200000]
>                                                             ^^^^^^^^^^^^^^^^^^^^^^^^^
> [  391.864261] pci 0000:7d:00.3: BAR 2: assigned [mem 0x120c00000-0x120cfffff 64bit pref]
> [  391.872148] pci 0000:7d:00.3: BAR 9: assigned [mem 0x120d00000-0x120ffffff 64bit pref]
> [  391.880035] pci 0000:7d:00.3: BAR 0: assigned [mem 0x1210c0000-0x1210cffff 64bit pref]
> [  391.887920] pci 0000:7d:00.3: BAR 7: assigned [mem 0x1210d0000-0x1210fffff 64bit pref]
>
> When looking into the code, the functions called like:
>     pci_rescan_bus()
>         pci_assign_unassigned_bus_resources()
>             __pci_bus_size_bridges()
>                 pbus_size_mem()
>
> The function 7d:00.3 is added and enabled well as the required resources are satisfied.
> As it request 64bit prefetchable resources, there is no reason to open bar14 for it.
>
> When a new function is added, the framework trys to size the bridge memory
> window for it. In __pci_bus_size_bridges(), firstly the framework trys to size bar15 for the
> new added 5M resources as we require 64bit pref mem. But bar15 has *parent*
> so pbus_size_mem() return failure with bar15 unchanged. Then the framework try to put
> resources in bar14, 32bit mem window, and the bar14 is unused so it is sized to 5M and
> pbus_size_mem() return success.
> After bridge size settles down, the framework assign resources for each bar. *As the bios
> doesn't reserve a 32bit mem window for the bridge*, bar14 assignment is failed and print
> the error assigen information. When assigning 7d:00.3, the framework try to find a space
> in bar15 firstly and succeed. Then the flow is terminated. The bar14 is even not touched.
>
> Here comes the question:
>     Why should we resize the bridge memory window when only one function is removed and
> rescanned later? The bridge memory window should remain unchanged in such a situation.
>     Is there a *certain condition* which requirs such operation?
>     If all the functions are removed, we should use pci_rescan_bus_bridge_resize() to rescan and add
> devices as the required memory size maybe changed.  Otherwise, i think we should try to assign
> resources directly without sizing the bridge resource.
>    
> Thanks,
> Yang
>
>
> .
>


