Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7F2122D86
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2019 14:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfLQNyR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 08:54:17 -0500
Received: from mx2a.mailbox.org ([80.241.60.219]:12013 "EHLO mx2a.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728309AbfLQNyR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Dec 2019 08:54:17 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 29CB9A228B;
        Tue, 17 Dec 2019 14:54:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id L5H9b_BAUzT3; Tue, 17 Dec 2019 14:54:08 +0100 (CET)
Subject: Re: PCIe hotplug resource issues with PEX switch (NVMe disks) on AMD
 Epyc system
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Keith Busch <kbusch@kernel.org>
References: <20191216233759.GA249123@google.com>
From:   Stefan Roese <sr@denx.de>
Message-ID: <8a0d7768-55f1-c1c8-1507-04e977184a67@denx.de>
Date:   Tue, 17 Dec 2019 14:54:06 +0100
MIME-Version: 1.0
In-Reply-To: <20191216233759.GA249123@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 17.12.19 00:37, Bjorn Helgaas wrote:
> [+cc Keith]
> 
> On Fri, Dec 13, 2019 at 09:35:19AM +0100, Stefan Roese wrote:
>> Hi!
>>
>> I am facing an issue with PCIe-Hotplug on an AMD Epyc based system.
>> Our system is equipped with an HBA for NVMe SSDs incl. PCIe switch
>> (Supermicro AOC-SLG3-4E2P) [1] and we would like to be able to hotplug
>> NVMe disks.
> 
> Your system has several host bridges.  The address space routed to
> each host bridge is determined by firmware, and Linux has no support
> for changing it.  Here's the space routed to the hierarchy containing
> the NVMe devices:
> 
>    ACPI: PCI Root Bridge [S0D2] (domain 0000 [bus 40-5f])
>    pci_bus 0000:40: root bus resource [mem 0xeb000000-0xeb5fffff window] 6MB
>    pci_bus 0000:40: root bus resource [mem 0x7fc8000000-0xfcffffffff window] 501GB+
>    pci_bus 0000:40: root bus resource [bus 40-5f]
> 
> Since you have several host bridges, using "pci=nocrs" is pretty much
> guaranteed to fail if Linux changes any PCI address assignments.  It
> makes Linux *ignore* the routing information from firmware, but it
> doesn't *change* any of the routing.  That's why experiment (d) fails:
> we assigned this space:
> 
>    pci 0000:44:00.0: BAR 0: assigned [mem 0xec000000-0xec003fff 64bit]
> 
> but according to the BIOS, the [mem 0xec000000-0xefffffff window] area
> is routed to bus 00, not bus 40, so when we try to access that BAR, it
> goes to bus 00 where nothing responds.

Thanks for your analysis. I totally missed this multiple host bridges
aspect here. This explains completely what's happening with "nocrs",
which can't be used on this platform because of this (without ability
to change the routing in the PCI host bridges as well).
  
> There are three devices on bus 40 that consume memory address space:
> 
>    40:03.1 Root Port to [bus 41-47]  [mem 0xeb400000-0xeb5fffff] 2MB
>    40:07.1 Root Port to [bus 48]     [mem 0xeb200000-0xeb3fffff] 2MB
>    40:08.1 Root Port to [bus 49]     [mem 0xeb000000-0xeb1fffff] 2MB
> 
> Bridges (including Root Ports and Switch Ports) consume memory address
> space in 1MB chunks.  The devices on buses 48 and 49 need a little
> over 1MB, so 40:07.1 and 40:08.1 need at least 2MB each.  There's only
> 6MB available, so that leaves 2MB for 40:03.1, which leads to the PLX
> switch.
> 
> That 2MB of memory space is routed to the PLX Switch Upstream Port,
> which has a BAR of its own that requires 256K, which leaves 1MB for it
> to send to its Downstream Ports.
> 
> The Intel NVMe device only needs 16KB of memory space, but since the
> Switch Port windows are a minimum of 1MB, only one port gets memory
> space.
> 
> So with this configuration, I think you're stuck.  The only things I
> can think of are:
> 
>    - Put the PLX switch in a different slot to see if BIOS will assign
>      more space to it (the other host bridges have more space
>      available).

Thanks for this suggestions. Using a different slot (with more resources)
enables the resource assignment for a 4 HP slots of the PLX switch. Only
when I use this patch from Nicholas though (and pci=realloc):

https://lore.kernel.org/linux-pci/20191216233759.GA249123@google.com/T/#mbb5abd0131f05dbd5030952f567b3e4ec92f2af4
  
>    - Boot with all four PLX slots occupied by NVMe devices.  The BIOS
>      may assign space to accommodate them all.  If it does, you should
>      be able to hot-remove and add devices after boot.

Unfortunately, that's not an option. We need to be able to boot with
e.g. one NVMe device and hot-plug one or more devices later.
  
>    - Change Linux to use prefetchable space.  The Intel NVMe wants
>      *non-prefetchable* space, but there's an implementation note in
>      the spec (PCIe r5.0, sec 7.5.1.2.1) that says it should be safe to
>      put it in prefetchable space in certain cases (entire path is
>      PCIe, no PCI/PCI-X devices to peer-to-peer reads, host bridge does
>      no byte merging, etc).  The main problem is that we don't have a
>      good way to identify these cases.

Thanks for this suggestion. I might look into this. Right now, I'm
experimenting with the "solution" mentioned above, which looks like
it solves our issues for now.

Thanks,
Stefan
