Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91735161F6E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2020 04:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgBRDSg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Feb 2020 22:18:36 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38772 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbgBRDSg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Feb 2020 22:18:36 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3C7E6C7E0EA2E52A80A4;
        Tue, 18 Feb 2020 11:18:33 +0800 (CST)
Received: from [127.0.0.1] (10.65.58.147) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 18 Feb 2020
 11:18:24 +0800
Subject: Re: PCI: bus resource allocation error
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "Bjorn Helgaas" <helgaas@kernel.org>
References: <f0cab9da-8e74-e923-a2fe-591d065228ee@hisilicon.com>
 <2e588019-0a42-c386-7314-e1cf5dbc3371@hisilicon.com>
 <SL2P216MB04433D05965A7D1C0E6A4BD680180@SL2P216MB0443.KORP216.PROD.OUTLOOK.COM>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        fangjian 00545541 <f.fangjian@huawei.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <80dcfe64-e66a-feef-fbc7-f094b2ab423c@hisilicon.com>
Date:   Tue, 18 Feb 2020 11:18:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <SL2P216MB04433D05965A7D1C0E6A4BD680180@SL2P216MB0443.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nicholas,


On 2020/2/11 21:43, Nicholas Johnson wrote:
>> There are 4 functions of a network card under one root port as below:
>>  +-[0000:7c]---00.0-[7d]--+-00.0  Device 19e5:a222
>>  |                        +-00.1  Device 19e5:a222
>>  |                        +-00.2  Device 19e5:a222
>>  |                        \-00.3  Device 19e5:a221
>>
>> When I remove one function and rescan the bus[7c], the kernel print the error
>> message as below:
> Why do you need to remove and rescan the bus? It is possible that we 
> should be addressing the problem of why you have the need to do that in 
> the first place, rather than why the rescan does not work.

It is found in a test procedure coincidently. There is no certain condition to do it,
but the problem does exists.


>
>> [  391.770030] pci 0000:7d:00.3: [19e5:a221] type 00 class 0x020000
>> [  391.776024] pci 0000:7d:00.3: reg 0x10: [mem 0x1210c0000-0x1210cffff 64bit pref]
>> [  391.783394] pci 0000:7d:00.3: reg 0x18: [mem 0x120c00000-0x120cfffff 64bit pref]
>> [  391.790786] pci 0000:7d:00.3: reg 0x224: [mem 0x1210d0000-0x1210dffff 64bit pref]
>> [  391.798238] pci 0000:7d:00.3: VF(n) BAR0 space: [mem 0x1210d0000-0x1210fffff 64bit pref] (contains BAR0 for 3 VFs)
>> [  391.808543] pci 0000:7d:00.3: reg 0x22c: [mem 0x120d00000-0x120dfffff 64bit pref]
>> [  391.815994] pci 0000:7d:00.3: VF(n) BAR2 space: [mem 0x120d00000-0x120ffffff 64bit pref] (contains BAR2 for 3 VFs)
>> [  391.826391] pci 0000:7c:00.0: bridge window [mem 0x00100000-0x002fffff] to [bus 7d] add_size 300000 add_align 100000
>> [  391.836869] pci 0000:7c:00.0: BAR 14: no space for [mem size 0x00500000]
>>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> [  391.843543] pci 0000:7c:00.0: BAR 14: failed to assign [mem size 0x00500000]
>>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> [  391.850562] pci 0000:7c:00.0: BAR 14: no space for [mem size 0x00200000]
>>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> [  391.857237] pci 0000:7c:00.0: BAR 14: failed to assign [mem size 0x00200000]
>>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
>> or the machine in the pastebin prints:
>>
>> [  790.671091] pci 0000:7d:00.3: Removing from iommu group 5
>> [  937.541937] pci 0000:7d:00.3: [19e5:a221] type 00 class 0x020000
>> [  937.541949] pci 0000:7d:00.3: reg 0x10: [mem 0x1221f0000-0x1221fffff 64bit pref]
>> [  937.541953] pci 0000:7d:00.3: reg 0x18: [mem 0x121f00000-0x121ffffff 64bit pref]
>> [  937.542113] pci 0000:7c:00.0: BAR 14: no space for [mem size 0x00200000]
>>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> [  937.542116] pci 0000:7c:00.0: BAR 14: failed to assign [mem size 0x00200000]
>>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> [  937.542120] pci 0000:7d:00.3: BAR 2: assigned [mem 0x121f00000-0x121ffffff 64bit pref]
>> [  937.542125] pci 0000:7d:00.3: BAR 0: assigned [mem 0x1221f0000-0x1221fffff 64bit pref]
>> [  937.542253] hns3 0000:7d:00.3: Adding to iommu group 5
>>
>> Both the function and the root ports work well, and the function get the resource it requested as before
>> remove. So from my perspective the message shouldn't be printed and should be eliminated.
>>
>> I looked into the codes and got some informations:
>>
>> when echo 1 > bus_rescan, kernel calls:
>>     pci_rescan_bus()
>>         pci_assign_unassigned_bus_resources()
>>             __pci_bus_size_bridges()
>>                /* first try to put the resource in 64 bit MMIO window(Bar 15). 
>>                 * As it's not empty, function will return directly.
>>                 */
>>                pbus_size_mem()
>>
>>                /* Then try to put rest resource in 32-bit MMIO window(Bar 14)
>>                 * As it's not occupied by any functions, the resources are
>>                 * put here. As no io memory is reserved in the bios for bar14,
>>                 * error message prints when allocated.
>>                 */
>>                pbus_size_mem() /* problem is here */
>>
>> In pbus_size_mem(), kernel try to size the bar to contain function resource.
>> If it's occupied by any function (judged by find_bus_resource_of_type() in
>> pbus_size_mem()), it'll return directly without any sizing. Otherwise the bar
>> will be sized to put the request resource in.
>>
>> It's just a rescan process, the bar size shouldn't be sized or allocated by
>> calling __pci_bus_size_bridges(). As previous resource space in the bar
>> reserved and the function will demands no extra spaces after rescan.
>> The current process seems unreasonable.
> If the BIOS assigned the resources with different packing than what the 
> kernel would do, then the rescan may not fit into the space. You can try 
> pci=realloc,nocrs if you have not already. Your system looks like it is 
> ARM64 so you cannot use pci=nocrs, unfortunately. The ideal situation is 
> if the kernel throws away everything the BIOS did and does everything 
> itself (assuming that this will not cause platform conflicts). But there 
> is no way of doing this without modifying the kernel, and I am not sure 
> how to do it fully.

pci=realloc affects when allocating the root bridge and root bus. So it doesn't
meet the condition here, as the root bus resource has been allocated and the problem
occurs when allocating and assigning resource on subordinate bus [7d]. And it does do
no help as I add pci=realloc when boot.

Luckily, I found your patch c13704f5685d ("PCI: Avoid double hpmemsize MMIO window assignment")
which have solved the problem. It's merged in v5.5 kernel so I didn't test it as the
issues happened on v5.4.

The find_free_bus_resource() is modified to find_bus_resource_of_type() in the patch, and it'll return the
first assigned resource matching the target type rather than previous NULL if not found. Then when
allocating target resource (64 bit pref) in 64 bit pref bar15 when first time call pbus_size_mem(),
we'll get success 0 rather than -ENOSPEC. Then we'll not try to put the target resource in
bar14 subsequently as previous did, which will avoid opening bar14 and wrong allocating. Thanks for you
good work!

But for me it still seems unnecessary to call __pci_bus_size_bridges() to try to size
the bus in a rescan routine, actually it seems redundant here. Is it possible to call
__pci_bus_assign_resources() in pci_rescan_bus() directly? However, I haven't look further
in it, just thoughts.

Thanks,
Yicong Yang

>
> However, I have come to find that the code in drivers/pci/setup-bus.c is 
> very old and full of holes. It does require a re-write (in my opinion, 
> and some other people have agreed to some extent), which I want to do, 
> but will need much more experience before I can pull something like that 
> off and get it accepted by others.
>
> Unfortunately without the system in front of me and the ability to make 
> lots of changes to the kernel very quickly to find a fix, I might not be 
> able to figure it out.
>
>> Thanks,
>> Yicong Yang
>>
>>
> Regards,
> Nicholas
>
> .
>


