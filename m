Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65CB41367ED
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2020 08:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgAJHIP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jan 2020 02:08:15 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51136 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbgAJHIP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jan 2020 02:08:15 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CBC47D7B78D6EC118462;
        Fri, 10 Jan 2020 15:08:11 +0800 (CST)
Received: from [127.0.0.1] (10.65.58.147) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 10 Jan 2020
 15:08:04 +0800
Subject: Re: PCI: bus resource allocation error
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
References: <20200109230026.GA30130@google.com>
CC:     <linux-pci@vger.kernel.org>,
        fangjian 00545541 <f.fangjian@huawei.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <a66a06d6-e795-2eb7-5163-ac59c2481b86@hisilicon.com>
Date:   Fri, 10 Jan 2020 15:08:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200109230026.GA30130@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2020/1/10 7:00, Bjorn Helgaas wrote:
> On Thu, Jan 09, 2020 at 11:35:09AM +0800, Yicong Yang wrote:
>> Hi,
>>
>> recently I met a problem with pci bus resource allocation. The allocation strategy
>> makes me confused and leads to a wrong allocation results.
>>
>> There is a hisilicon network device with four functions under one root port. The
>> original bios resources allocation looks like:
>>
>> 7c:00.0 Root Port
>>      prefetchable memory behind bridge: 12000000-0x1210fffff 17M [64bit pref]
>>     7d:00.0
>>         bar0: 0x121000000-0x12100ffff 64k  [64bit pref]
>>         bar2: 0x120000000-0x1200fffff 1M   [64bit pref]
>>         bar7: 0x121010000-0x12103ffff 128K [64bit pref]
>>         bar9: 0x120100000-0x1203fffff 3M   [64bit pref]
>>     7d:00.1
>>         bar0: 0x121040000-0x12104ffff 64k  [64bit pref]
>>         bar2: 0x120400000-0x1204fffff 1M   [64bit pref]
>>         bar7: 0x121050000-0x12107ffff 128K [64bit pref]
>>         bar9: 0x120500000-0x1207fffff 3M   [64bit pref]
>>     7d:00.2
>>         bar0: 0x121080000-0x12108ffff 64k  [64bit pref]
>>         bar2: 0x120800000-0x1208fffff 1M   [64bit pref]
>>         bar7: 0x121090000-0x1210bffff 128K [64bit pref]
>>         bar9: 0x120900000-0x120bfffff 3M   [64bit pref]
>>     7d:00.3
>>         bar0: 0x1210c0000-0x1210cffff 64k  [64bit pref]
>>         bar2: 0x120c00000-0x120cfffff 1M   [64bit pref]
>>         bar7: 0x121010000-0x12103ffff 128K [64bit pref]
>>         bar9: 0x120d00000-0x120ffffff 3M   [64bit pref]
> This looks like an incorrect assignment, i.e., possibly a BIOS defect:
> 7d:00.0 and 7d:00.3 are assigned the same space for bar7:
It seems I've made a wrong type. Ignore it and see the dmesg.log/console.log.
>
>   7d:00.0 bar7: 0x121010000-0x12103ffff 128K [64bit pref]
>   7d:00.3 bar7: 0x121010000-0x12103ffff 128K [64bit pref]
>
>> When I remove function 7d:00.3 and try to rescan the bus[7c], kernel prints the
>> error information.
>> [  391.770030] pci 0000:7d:00.3: [19e5:a221] type 00 class 0x020000
>> [  391.776024] pci 0000:7d:00.3: bar0 reg 0x10: [mem 0x1210c0000-0x1210cffff 64bit pref]
>> [  391.783394] pci 0000:7d:00.3: bar2 reg 0x18: [mem 0x120c00000-0x120cfffff 64bit pref]
>> [  391.790786] pci 0000:7d:00.3: bar7 reg 0x224: [mem 0x1210d0000-0x1210dffff 64bit pref]
>> [  391.798238] pci 0000:7d:00.3: bar7 VF(n) BAR0 space: [mem 0x1210d0000-0x1210fffff 64bit pref] (contains BAR0 for 3 VFs)
>> [  391.808543] pci 0000:7d:00.3: bar9 reg 0x22c: [mem 0x120d00000-0x120dfffff 64bit pref]
>> [  391.815994] pci 0000:7d:00.3: VF(n) BAR2 space: [mem 0x120d00000-0x120ffffff 64bit pref] (contains BAR2 for 3 VFs)
>> [  391.826391] pci 0000:7c:00.0: bridge window [mem 0x00100000-0x002fffff] to [bus 7d] add_size 300000 add_align 100000
>> [  391.836869] pci 0000:7c:00.0: BAR 14: no space for [mem size 0x00500000]
>>                                                             ^^^^^^^^^^^^^^^^^^^^^^^   
>> [  391.843543] pci 0000:7c:00.0: BAR 14: failed to assign [mem size 0x00500000]
>>                                                             ^^^^^^^^^^^^^^^^^^^^^^^^^
>> [  391.850562] pci 0000:7c:00.0: BAR 14: no space for [mem size 0x00200000]
>>                                                             ^^^^^^^^^^^^^^^^^^^^^^^
>> [  391.857237] pci 0000:7c:00.0: BAR 14: failed to assign [mem size 0x00200000]
>>                                                             ^^^^^^^^^^^^^^^^^^^^^^^^^
>> [  391.864261] pci 0000:7d:00.3: BAR 2: assigned [mem 0x120c00000-0x120cfffff 64bit pref]
>> [  391.872148] pci 0000:7d:00.3: BAR 9: assigned [mem 0x120d00000-0x120ffffff 64bit pref]
>> [  391.880035] pci 0000:7d:00.3: BAR 0: assigned [mem 0x1210c0000-0x1210cffff 64bit pref]
>> [  391.887920] pci 0000:7d:00.3: BAR 7: assigned [mem 0x1210d0000-0x1210fffff 64bit pref]
> What is the incorrect allocation here?  This looks the same as the
> original assignment from BIOS, except that BAR 7 (the VF BAR 2 space)
> no longer overlaps BAR 7 of 7d:00.0.
The allocation of the endpoints is fine and works well. But the Bar14 of the root port is wrong open and
the assignment is failed. It shouldn't be opened as none of the subordinates use it, the bios doesn't
reserve a  32bit memory region for it as well.
>> When looking into the code, the functions called like:
>>     pci_rescan_bus()
>>         pci_assign_unassigned_bus_resources()
>>             __pci_bus_size_bridges()
>>                 pbus_size_mem()
>>
>> The function 7d:00.3 is added and enabled well as the required resources are satisfied.
>> As it request 64bit prefetchable resources, there is no reason to open bar14 for it.
>>
>> When a new function is added, the framework trys to size the bridge memory
>> window for it. In __pci_bus_size_bridges(), firstly the framework trys to size bar15 for the
>> new added 5M resources as we require 64bit pref mem. But bar15 has *parent*
>> so pbus_size_mem() return failure with bar15 unchanged. Then the framework try to put
>> resources in bar14, 32bit mem window, and the bar14 is unused so it is sized to 5M and
>> pbus_size_mem() return success.
>> After bridge size settles down, the framework assign resources for each bar. *As the bios
>> doesn't reserve a 32bit mem window for the bridge*, bar14 assignment is failed and print
>> the error assigen information. When assigning 7d:00.3, the framework try to find a space
>> in bar15 firstly and succeed. Then the flow is terminated. The bar14 is even not touched.
>>
>> Here comes the question:
>>     Why should we resize the bridge memory window when only one function is removed and
>> rescanned later? The bridge memory window should remain unchanged in such a situation.
> In this case you removed a function and re-added the same function
> later, so it needs the same amount of resources.  In that case, I
> agree, we probably shouldn't change the bridge window.  But I don't
> think we *did* change the bridge window here.  Did I miss something?
We call pbus_size_mem() to size the bridge bars in __pci_bus_size_bridges().
    __pci_bus_size_bridges()
        pbus_size_mem()    // try to size bar15 [64bit pref]
        pbus_size_mem()    // try to size bar14 [32bit]
In pbus_size_mem(), if the bar isn't spare (which means resource[bar]->parent is not NULL),
the function will return directly. Otherwise, the bar size is changed to contain the necessary
resource.
In this condition, as all of the subordinates are allocated in bar15. so the pbus_size_mem()
returned directly when sizing bar15, but change the size of bar14. which leads to the error
in later assignment of bar14. As a 32bit memory window is not reserved for this root port.

>
> I agree the messages about BAR 14 (the non-prefetchable window) are
> confusing and we probably shouldn't have even tried to assign space
> for it.
>
> I guess I'm missing something, because other than the annoying BAR 14
> messages, I don't see the actual problem here.
I would like to remove  __pci_bus_size_bridges() from pci_rescan_bus() routine, as it's no
necessary to resize the bridges window. we'll call pci_rescan_bus_bridge_resize() if all the devices
down the rp is removed and resize the bridge window if necessary.

But I don't know whether there is a condition that needs to resize the bridge window
when rescanning the bus?

> Bjorn
>
> .
>


