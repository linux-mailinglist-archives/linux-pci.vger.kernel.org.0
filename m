Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A936A135225
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 05:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgAIE1H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 23:27:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgAIE1H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jan 2020 23:27:07 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74D3A206ED;
        Thu,  9 Jan 2020 04:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578544025;
        bh=O6d+E6vOA1Pfr2Sxi8lSgYOWaME7pJ5Ro/fwH8IG08U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UwJhh8HqtIAyqABdHTKGV7mwo5Q6VFjzuPMijbXky4wypWRCWUvQJOj04mgBIxfHb
         s6j3XRxsYJrqKzTXd8x8cIW56TFWZubxQWm87aj2yHZfI80bbJp8s8cc/WOTGsPjEh
         ikhhLAPy42G0OE6xqZqVgGFQiLTUqggW8d7z8K94=
Date:   Wed, 8 Jan 2020 22:27:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org,
        fangjian 00545541 <f.fangjian@huawei.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: Re: PCI: bus resource allocation error
Message-ID: <20200109042702.GA223211@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0cab9da-8e74-e923-a2fe-591d065228ee@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Nicholas, who is working in this area]

On Thu, Jan 09, 2020 at 11:35:09AM +0800, Yicong Yang wrote:
> Hi,
> 
> recently I met a problem with pci bus resource allocation. The allocation strategy
> makes me confused and leads to a wrong allocation results.
> 
> There is a hisilicon network device with four functions under one root port. The
> original bios resources allocation looks like:

What kernel is this?  Can you collect the complete dmesg log?

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
