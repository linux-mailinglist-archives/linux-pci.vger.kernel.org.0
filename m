Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6B51332C4
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2020 22:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgAGVNn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jan 2020 16:13:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729946AbgAGVNl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jan 2020 16:13:41 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26725208C4;
        Tue,  7 Jan 2020 21:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431620;
        bh=i1qhWJd/JIv/EvnYvOd+bBbFKX9FBjpyZH4/2g/2b4U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VuyNT0vx/XbudQ2Gbc0TGX2wUKpjZv8Weu0kKC6w8ql8rK+p+I6Zf+yC9SMZqgwCW
         Q1DVei+Qm4jH8R1L7n1tMnA3gUlctkjgB0K0EoYsaU8GWktZbT2H5WTEkzdUtHha2x
         qludjgYJgeEv42vJifBCoYC8egPNQv2is8kgOstI=
Date:   Tue, 7 Jan 2020 15:13:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kit Chow <kchow@gigaio.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4] PCI: Fix disabling of bridge BARs when assigning bus
 resources
Message-ID: <20200107211338.GA31548@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107190902.5093-1-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 07, 2020 at 12:09:02PM -0700, Logan Gunthorpe wrote:
> One odd quirk of PLX switches is that their upstream bridge port has
> 256K of space allocated behind its BAR0 (most other bridge
> implementations do not report any BAR space). The lspci for such  device
> looks like:
> 
>   04:00.0 PCI bridge: PLX Technology, Inc. PEX 8724 24-Lane, 6-Port PCI
>             Express Gen 3 (8 GT/s) Switch, 19 x 19mm FCBGA (rev ca)
> 	    (prog-if 00 [Normal decode])
>       Physical Slot: 1
>       Flags: bus master, fast devsel, latency 0, IRQ 30, NUMA node 0
>       Memory at 90a00000 (32-bit, non-prefetchable) [size=256K]
>       Bus: primary=04, secondary=05, subordinate=0a, sec-latency=0
>       I/O behind bridge: 00002000-00003fff
>       Memory behind bridge: 90000000-909fffff
>       Prefetchable memory behind bridge: 0000380000800000-0000380000bfffff
>       Kernel driver in use: pcieport
> 
> It's not clear what the purpose of the memory at 0x90a00000 is, and
> currently the kernel never actually uses it for anything. In most cases,
> it's safely ignored and does not cause a problem.
> 
> However, when the kernel assigns the resource addresses (with the
> pci=realloc command line parameter, for example) it can inadvertently
> disable the struct resource corresponding to the bar. When this happens,
> lspci will report this memory as ignored:
> 
>    Region 0: Memory at <ignored> (32-bit, non-prefetchable) [size=256K]
> 
> This is because the kernel reports a zero start address and zero flags
> in the corresponding sysfs resource file and in /proc/bus/pci/devices.
> Investigation with 'lspci -x', however shows the bios-assigned address
> will still be programmed in the device's BAR registers.
> 
> It's clearly a bug that the kernel's view of the registers differs from
> what's actually programmed in the BAR, but in most cases, this still
> won't result in a visibile issue because nothing uses the memory,
> so nothing is affected. However, a big problem shows up when an IOMMU
> is in use: the IOMMU will not reserve this space in the IOVA because the
> kernel no longer thinks the range is valid. (See
> dmar_init_reserved_ranges() for the Intel implementation of this.)
> 
> Without the proper reserved range, we have a situation where a DMA
> mapping may occasionally allocate an IOVA which the PCI bus will actually
> route to a BAR in the PLX switch. This will result in some random DMA
> writes not actually writing to the RAM they are supposed to, or random
> DMA reads returning all FFs from the PLX BAR when it's supposed to have
> read from RAM.
> 
> The problem is caused in pci_assign_unassigned_root_bus_resources().
> When any resource from a bridge device fails to get assigned, the code
> sets the resource's flags to zero. This makes sense for bridge resources,
> as they will be re-enabled later, but for regular BARs, it disables them
> permanently.
> 
> The code in question seems to indent to check if "dev->subordinate" is
> zero to determine whether a device is a bridge, however this is not
> likely valid as there might be a bridge without a subordinate bus due to
> running out of bus numbers or other cases.
> 
> To fix these issues we instead check that the idx is in the
> PCI_BRIDGE_RESOURCES range which are only used for bridge windows and
> thus is sufficient for the "dev->subordinate" check and will also
> prevent the bug above from clobbering PLX devices' regular BARs.

s/bios/BIOS/
s/bar/BAR/
s/visibile/visible/
s/indent/intend/

> Reported-by: Kit Chow <kchow@gigaio.com>
> Fixes: da7822e5ad71 ("PCI: update bridge resources to get more big ranges when allocating space (again)")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/setup-bus.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> This patch was last submitted back in June as part of a series. I've
> dropped the first patch in the series as a similar patch from Nicholas
> takes care of the bug.
> 
> As a reminder, the previous discussion on this patch is here[1]. Per the
> feedback, I've updated the patch to remove the check on
> "dev->subordinate" entirely.
> 
> The patch is based on v5.5-rc5 and a git branch is available here:
> 
> https://github.com/sbates130272/linux-p2pmem pci_realloc_v4
> 
> [1] https://lore.kernel.org/linux-pci/20190617135307.GA13533@google.com/
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index f279826204eb..23f6c95f3fd7 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1803,11 +1803,15 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
>  	/* Restore size and flags */
>  	list_for_each_entry(fail_res, &fail_head, list) {
>  		struct resource *res = fail_res->res;
> +		int idx;
> 
>  		res->start = fail_res->start;
>  		res->end = fail_res->end;
>  		res->flags = fail_res->flags;
> -		if (fail_res->dev->subordinate)
> +
> +		idx = res - &fail_res->dev->resource[0];
> +		if (idx >= PCI_BRIDGE_RESOURCES &&
> +		    idx <= PCI_BRIDGE_RESOURCE_END)
>  			res->flags = 0;

So I guess previously, for everything on the fail_head list, we
restored flags/start/end *and* we cleared flags for every BAR and
window of a bridge.

Now we'll clear flags for only for bridge windows.  I'm sure that was
the original intent, but I don't see why we bother.  The next thing we
do is go back to "again", where we call __pci_bus_size_bridges(),
where we immediately call pci_bridge_check_ranges(), which recomputes
the flags.

Is there actually any point in clearing res->flags, or could we just
do this:

 		res->start = fail_res->start;
 		res->end = fail_res->end;
 		res->flags = fail_res->flags;
-		if (fail_res->dev->subordinate)
-			res->flags = 0;
 	}
 	free_list(&fail_head);
 
