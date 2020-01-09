Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D76071351FD
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 04:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbgAIDfO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 22:35:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9137 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbgAIDfO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jan 2020 22:35:14 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DE97188F85ECB12F2A29;
        Thu,  9 Jan 2020 11:35:12 +0800 (CST)
Received: from [127.0.0.1] (10.65.58.147) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 Jan 2020
 11:35:05 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
Subject: PCI: bus resource allocation error
To:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     fangjian 00545541 <f.fangjian@huawei.com>
Message-ID: <f0cab9da-8e74-e923-a2fe-591d065228ee@hisilicon.com>
Date:   Thu, 9 Jan 2020 11:35:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

recently I met a problem with pci bus resource allocation. The allocation strategy
makes me confused and leads to a wrong allocation results.

There is a hisilicon network device with four functions under one root port. The
original bios resources allocation looks like:

7c:00.0 Root Port
     prefetchable memory behind bridge: 12000000-0x1210fffff 17M [64bit pref]
    7d:00.0
        bar0: 0x121000000-0x12100ffff 64k  [64bit pref]
        bar2: 0x120000000-0x1200fffff 1M   [64bit pref]
        bar7: 0x121010000-0x12103ffff 128K [64bit pref]
        bar9: 0x120100000-0x1203fffff 3M   [64bit pref]
    7d:00.1
        bar0: 0x121040000-0x12104ffff 64k  [64bit pref]
        bar2: 0x120400000-0x1204fffff 1M   [64bit pref]
        bar7: 0x121050000-0x12107ffff 128K [64bit pref]
        bar9: 0x120500000-0x1207fffff 3M   [64bit pref]
    7d:00.2
        bar0: 0x121080000-0x12108ffff 64k  [64bit pref]
        bar2: 0x120800000-0x1208fffff 1M   [64bit pref]
        bar7: 0x121090000-0x1210bffff 128K [64bit pref]
        bar9: 0x120900000-0x120bfffff 3M   [64bit pref]
    7d:00.3
        bar0: 0x1210c0000-0x1210cffff 64k  [64bit pref]
        bar2: 0x120c00000-0x120cfffff 1M   [64bit pref]
        bar7: 0x121010000-0x12103ffff 128K [64bit pref]
        bar9: 0x120d00000-0x120ffffff 3M   [64bit pref]

When I remove function 7d:00.3 and try to rescan the bus[7c], kernel prints the
error information.
[  391.770030] pci 0000:7d:00.3: [19e5:a221] type 00 class 0x020000
[  391.776024] pci 0000:7d:00.3: reg 0x10: [mem 0x1210c0000-0x1210cffff 64bit pref]
[  391.783394] pci 0000:7d:00.3: reg 0x18: [mem 0x120c00000-0x120cfffff 64bit pref]
[  391.790786] pci 0000:7d:00.3: reg 0x224: [mem 0x1210d0000-0x1210dffff 64bit pref]
[  391.798238] pci 0000:7d:00.3: VF(n) BAR0 space: [mem 0x1210d0000-0x1210fffff 64bit pref] (contains BAR0 for 3 VFs)
[  391.808543] pci 0000:7d:00.3: reg 0x22c: [mem 0x120d00000-0x120dfffff 64bit pref]
[  391.815994] pci 0000:7d:00.3: VF(n) BAR2 space: [mem 0x120d00000-0x120ffffff 64bit pref] (contains BAR2 for 3 VFs)
[  391.826391] pci 0000:7c:00.0: bridge window [mem 0x00100000-0x002fffff] to [bus 7d] add_size 300000 add_align 100000
[  391.836869] pci 0000:7c:00.0: BAR 14: no space for [mem size 0x00500000]
                                                            ^^^^^^^^^^^^^^^^^^^^^^^   
[  391.843543] pci 0000:7c:00.0: BAR 14: failed to assign [mem size 0x00500000]
                                                            ^^^^^^^^^^^^^^^^^^^^^^^^^
[  391.850562] pci 0000:7c:00.0: BAR 14: no space for [mem size 0x00200000]
                                                            ^^^^^^^^^^^^^^^^^^^^^^^
[  391.857237] pci 0000:7c:00.0: BAR 14: failed to assign [mem size 0x00200000]
                                                            ^^^^^^^^^^^^^^^^^^^^^^^^^
[  391.864261] pci 0000:7d:00.3: BAR 2: assigned [mem 0x120c00000-0x120cfffff 64bit pref]
[  391.872148] pci 0000:7d:00.3: BAR 9: assigned [mem 0x120d00000-0x120ffffff 64bit pref]
[  391.880035] pci 0000:7d:00.3: BAR 0: assigned [mem 0x1210c0000-0x1210cffff 64bit pref]
[  391.887920] pci 0000:7d:00.3: BAR 7: assigned [mem 0x1210d0000-0x1210fffff 64bit pref]

When looking into the code, the functions called like:
    pci_rescan_bus()
        pci_assign_unassigned_bus_resources()
            __pci_bus_size_bridges()
                pbus_size_mem()

The function 7d:00.3 is added and enabled well as the required resources are satisfied.
As it request 64bit prefetchable resources, there is no reason to open bar14 for it.

When a new function is added, the framework trys to size the bridge memory
window for it. In __pci_bus_size_bridges(), firstly the framework trys to size bar15 for the
new added 5M resources as we require 64bit pref mem. But bar15 has *parent*
so pbus_size_mem() return failure with bar15 unchanged. Then the framework try to put
resources in bar14, 32bit mem window, and the bar14 is unused so it is sized to 5M and
pbus_size_mem() return success.
After bridge size settles down, the framework assign resources for each bar. *As the bios
doesn't reserve a 32bit mem window for the bridge*, bar14 assignment is failed and print
the error assigen information. When assigning 7d:00.3, the framework try to find a space
in bar15 firstly and succeed. Then the flow is terminated. The bar14 is even not touched.

Here comes the question:
    Why should we resize the bridge memory window when only one function is removed and
rescanned later? The bridge memory window should remain unchanged in such a situation.
    Is there a *certain condition* which requirs such operation?
    If all the functions are removed, we should use pci_rescan_bus_bridge_resize() to rescan and add
devices as the required memory size maybe changed.  Otherwise, i think we should try to assign
resources directly without sizing the bridge resource.
   
Thanks,
Yang

