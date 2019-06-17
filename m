Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 398484849C
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 15:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfFQNxK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 09:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfFQNxK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jun 2019 09:53:10 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D55042089E;
        Mon, 17 Jun 2019 13:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560779589;
        bh=15Z96CeLChu7uOhbi5jJqcKnv3Kk8UOquo5h+04dZ08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J9EJy+SeuYw8wRvcpL4ArV7IJnqRj9rKlvsEfwtdrg80oKqUBIgijBki+rSX+7nkr
         WRJXjMe8TWLtxcUJCeX1DVqBMNnnKNRr0uVf+Z7J+NaOk4axUfKlwawQRYwf3e0S56
         dV1V3JzNB9aJyRR6CXeHyZJTymKmoV9GpAGuoDlY=
Date:   Mon, 17 Jun 2019 08:53:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kit Chow <kchow@gigaio.com>, Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v3 2/2] PCI: Fix disabling of bridge BARs when assigning
 bus resources
Message-ID: <20190617135307.GA13533@google.com>
References: <20190531171216.20532-1-logang@deltatee.com>
 <20190531171216.20532-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531171216.20532-3-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 31, 2019 at 11:12:16AM -0600, Logan Gunthorpe wrote:
> One odd quirk of PLX switches is that their upstream bridge port has
> 256K of space allocated behind its BAR0 (most other bridge
> implementations do not report any BAR space).

Somewhat unusual, but completely legal, of course.

If a bridge has memory BARs, AFAIK it is impossible to enable a memory
window without also enabling the BARs, so if we want to use the bridge
at all, we *must* allocate space for its BARs, just like for any other
device.

> The lspci for such  device
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

Ugh, yep.  It took me a while to trace through this, but "lspci -v" by
default shows the kernel view of addresses, i.e., the pdev->resource[]
values, which it gets from the sysfs "resource" file (resource_show())
or "/proc/bus/pci/devices" (show_device()).

But "lspci -x" shows the config space values (I think "lspci -bv"
should also show these) from the sysfs "config" file
(pci_read_config()).

It's definitely a kernel bug that we lost track of what's in config
space.

> In many cases, this still isn't a problem. Nothing uses the memory,
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
> permanently. To fix the problem, we only set the flags to zero for
> bridge resources and treat any other resources like non-bridge devices.
> 
> Reported-by: Kit Chow <kchow@gigaio.com>
> Fixes: da7822e5ad71 ("PCI: update bridge resources to get more big ranges when allocating space (again)")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/setup-bus.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 0eb40924169b..7adbd4bedd16 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1784,11 +1784,16 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
>  	/* restore size and flags */
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
> +		if (fail_res->dev->subordinate &&
> +		    idx >= PCI_BRIDGE_RESOURCES &&
> +		    idx <= PCI_BRIDGE_RESOURCE_END)
>  			res->flags = 0;

In my ideal world we wouldn't zap the flags of any resource.  I think
we should derive the flags from the device's config space *once*
during enumeration and remember them for the life of the device.

This patch preserves res->flags for bridge BARs just like for any
other device, so I think this is definitely a step in the right
direction.

I'm not sure the "dev->subordinate" test is really correct, though.
I think the original intent of this code was to clear res->flags for
bridge windows under the assumptions that (a) we can identify bridges
by "dev->subordinate" being non-zero, and (b) bridges only have
windows and didn't have BARs.

This patch fixes assumption (b), but I think (a) is false, and we
should fix it as well.  One can imagine a bridge device without a
subordinate bus (maybe we ran out of bus numbers), so I don't think we
should test dev->subordinate.

We could test something like pci_is_bridge(), although testing for idx
being in the PCI_BRIDGE_RESOURCES range should be sufficient because I
don't think we use those resource for anything other than windows.

>  	}
>  	free_list(&fail_head);
> -- 
> 2.20.1
> 
