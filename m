Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 987EA158CCB
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2020 11:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgBKKgq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Feb 2020 05:36:46 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:58926 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728237AbgBKKgq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Feb 2020 05:36:46 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 454D39C8AD51EEFAD1D2;
        Tue, 11 Feb 2020 18:36:44 +0800 (CST)
Received: from [127.0.0.1] (10.65.58.147) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Feb 2020
 18:36:34 +0800
Subject: Re: PCI: bus resource allocation error
To:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        "Nicholas Johnson" <nicholas.johnson-opensource@outlook.com.au>
References: <f0cab9da-8e74-e923-a2fe-591d065228ee@hisilicon.com>
CC:     fangjian 00545541 <f.fangjian@huawei.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <2e588019-0a42-c386-7314-e1cf5dbc3371@hisilicon.com>
Date:   Tue, 11 Feb 2020 18:36:42 +0800
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

Hi Bjorn and Nicholas,

Would you mind looking at the this and help me with the issues?

I reproduced the issues on another machine and pasted the console log along with
the lspci info on https://paste.ubuntu.com/p/5VHVnKWSty/.

As it has been a long time since last mail, I briefly illustrate the issues below:

There are 4 functions of a network card under one root port as below:
 +-[0000:7c]---00.0-[7d]--+-00.0  Device 19e5:a222
 |                        +-00.1  Device 19e5:a222
 |                        +-00.2  Device 19e5:a222
 |                        \-00.3  Device 19e5:a221

When I remove one function and rescan the bus[7c], the kernel print the error
message as below:

[  391.770030] pci 0000:7d:00.3: [19e5:a221] type 00 class 0x020000
[  391.776024] pci 0000:7d:00.3: reg 0x10: [mem 0x1210c0000-0x1210cffff 64bit pref]
[  391.783394] pci 0000:7d:00.3: reg 0x18: [mem 0x120c00000-0x120cfffff 64bit pref]
[  391.790786] pci 0000:7d:00.3: reg 0x224: [mem 0x1210d0000-0x1210dffff 64bit pref]
[  391.798238] pci 0000:7d:00.3: VF(n) BAR0 space: [mem 0x1210d0000-0x1210fffff 64bit pref] (contains BAR0 for 3 VFs)
[  391.808543] pci 0000:7d:00.3: reg 0x22c: [mem 0x120d00000-0x120dfffff 64bit pref]
[  391.815994] pci 0000:7d:00.3: VF(n) BAR2 space: [mem 0x120d00000-0x120ffffff 64bit pref] (contains BAR2 for 3 VFs)
[  391.826391] pci 0000:7c:00.0: bridge window [mem 0x00100000-0x002fffff] to [bus 7d] add_size 300000 add_align 100000
[  391.836869] pci 0000:7c:00.0: BAR 14: no space for [mem size 0x00500000]
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[  391.843543] pci 0000:7c:00.0: BAR 14: failed to assign [mem size 0x00500000]
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[  391.850562] pci 0000:7c:00.0: BAR 14: no space for [mem size 0x00200000]
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[  391.857237] pci 0000:7c:00.0: BAR 14: failed to assign [mem size 0x00200000]
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
or the machine in the pastebin prints:

[  790.671091] pci 0000:7d:00.3: Removing from iommu group 5
[  937.541937] pci 0000:7d:00.3: [19e5:a221] type 00 class 0x020000
[  937.541949] pci 0000:7d:00.3: reg 0x10: [mem 0x1221f0000-0x1221fffff 64bit pref]
[  937.541953] pci 0000:7d:00.3: reg 0x18: [mem 0x121f00000-0x121ffffff 64bit pref]
[  937.542113] pci 0000:7c:00.0: BAR 14: no space for [mem size 0x00200000]
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[  937.542116] pci 0000:7c:00.0: BAR 14: failed to assign [mem size 0x00200000]
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[  937.542120] pci 0000:7d:00.3: BAR 2: assigned [mem 0x121f00000-0x121ffffff 64bit pref]
[  937.542125] pci 0000:7d:00.3: BAR 0: assigned [mem 0x1221f0000-0x1221fffff 64bit pref]
[  937.542253] hns3 0000:7d:00.3: Adding to iommu group 5

Both the function and the root ports work well, and the function get the resource it requested as before
remove. So from my perspective the message shouldn't be printed and should be eliminated.

I looked into the codes and got some informations:

when echo 1 > bus_rescan, kernel calls:
    pci_rescan_bus()
        pci_assign_unassigned_bus_resources()
            __pci_bus_size_bridges()
               /* first try to put the resource in 64 bit MMIO window(Bar 15). 
                * As it's not empty, function will return directly.
                */
               pbus_size_mem()

               /* Then try to put rest resource in 32-bit MMIO window(Bar 14)
                * As it's not occupied by any functions, the resources are
                * put here. As no io memory is reserved in the bios for bar14,
                * error message prints when allocated.
                */
               pbus_size_mem() /* problem is here */

In pbus_size_mem(), kernel try to size the bar to contain function resource.
If it's occupied by any function (judged by find_bus_resource_of_type() in
pbus_size_mem()), it'll return directly without any sizing. Otherwise the bar
will be sized to put the request resource in.

It's just a rescan process, the bar size shouldn't be sized or allocated by
calling __pci_bus_size_bridges(). As previous resource space in the bar
reserved and the function will demands no extra spaces after rescan.
The current process seems unreasonable.

Thanks,
Yicong Yang


