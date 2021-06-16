Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6283AA74B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 01:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbhFPXOm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 19:14:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234449AbhFPXOm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 19:14:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADE6660FD9;
        Wed, 16 Jun 2021 23:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623885156;
        bh=OVbXkTYPJYSvlb2ydGcDGL2dM5WRqImNo6pxfwfoU38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ekx6S2OTdtZxtF+IMx3PykQtRIAqidsmXP7oh5Kq/1cZPdYal3EkpifBZNyIbcN9I
         qH+4on2osOt7fJ82CkAXwT0kBa3tZLKUMvFq+9+jBtPnO5WtS1rfkpPf2SYiLKeEpz
         QvppmUUxxDCVEe6uTkXzSe8TyiH1ZMWa3Dgu8R72QycCN2/ol+6u/+Vck+sqyeMqwc
         HVg5LthcLFYPEdNQh8bmhLQiUbWvyIyIHgN7g6aI7VE16I0mCokZ/zXthy8t4g2w1r
         bcBokip2xSumuHGL6gOMGB8wSq8F4SBsGibz+FhIoWny27cWl4P4UZ8RtVlJ+GrVWe
         QsbEs1vWVbx3w==
Date:   Wed, 16 Jun 2021 18:12:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     robh+dt@kernel.org, maz@kernel.org, leobras.c@gmail.com,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alexandru.elisei@arm.com, wqu@suse.com,
        robin.murphy@arm.com, pgwipeout@gmail.com, ardb@kernel.org,
        briannorris@chromium.org, shawn.lin@rock-chips.com,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4] PCI: of: Clear 64-bit flag for non-prefetchable
 memory below 4GB
Message-ID: <20210616231234.GA3018015@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614230457.752811-1-punitagrawal@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 15, 2021 at 08:04:57AM +0900, Punit Agrawal wrote:
> Alexandru and Qu reported this resource allocation failure on
> ROCKPro64 v2 and ROCK Pi 4B, both based on the RK3399:
> 
>   pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff 64bit]
>   pci 0000:00:00.0: PCI bridge to [bus 01]
>   pci 0000:00:00.0: BAR 14: no space for [mem size 0x00100000]
>   pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
> 
> "BAR 14" is the PCI bridge's 32-bit non-prefetchable window, and our
> PCI allocation code isn't smart enough to allocate it in a host
> bridge window marked as 64-bit, even though this should work fine.
> 
> A DT host bridge description includes the windows from the CPU
> address space to the PCI bus space.  On a few architectures
> (microblaze, powerpc, sparc), the DT may also describe PCI devices
> themselves, including their BARs.
> 
> Before 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource
> flags for 64-bit memory addresses"), of_bus_pci_get_flags() ignored
> the fact that some DT addresses described 64-bit windows and BARs.
> That was a problem because the virtio virtual NIC has a 32-bit BAR
> and a 64-bit BAR, and the driver couldn't distinguish them.
> 
> 9d57e61bf723 set IORESOURCE_MEM_64 for those 64-bit DT ranges, which
> fixed the virtio driver.  But it also set IORESOURCE_MEM_64 for host
> bridge windows, which exposed the fact that the PCI allocator isn't
> smart enough to put 32-bit resources in those 64-bit windows.
> 
> Clear IORESOURCE_MEM_64 from host bridge windows since we don't need
> that information.
> 
> Fixes: 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit memory addresses")
> Reported-at: https://lore.kernel.org/lkml/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com/
> Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
> Reported-by: Qu Wenruo <wqu@suse.com>
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh+dt@kernel.org>

Applied with:

    Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
    Reviewed-by: Rob Herring <robh@kernel.org>
    Acked-by: Ard Biesheuvel <ardb@kernel.org>

to for-linus for v5.13, thanks a lot!

> ---
> Hi,
> 
> The patch is an updated version to fix the PCI allocation issues on
> RK3399 based platforms. Previous postings can be found at [0][1][2].
> 
> The updated patch instead of clearing the 64-bit flag for
> non-prefetchable memory below 4GB does it unconditionally on the basis
> that PCI allocation logic cannot deal with the 64-bit flag (although
> it should be able to). The result is a simpler patch that restores the
> input to the allocation logic to be identical to before 9d57e61bf723.
> 
> Tested locally on a RockPro64 on top of v5.13-rc6. Please consider
> merging.
> 
> Thanks,
> Punit
> 
> Changes:
> v4:
> 
> * Updated Patch 1 based on Bjorn's suggestion. Also dropped the
>   Tested-by tags due to the change of logic
> * Dropped patch 2 and 3 from the series as it's not critical to the
>   series
> * Dropped the device tree changes (Patch 4) as they are already queued
>   in the soc tree
> 
> v3:
> * Improved commit log for clarity (Patch 1)
> * Added Tested-by tags
> 
> v2:
> * Check ranges PCI / bus addresses rather than CPU addresses
> * (new) Restrict 32-bit size warnings on ranges that don't have the 64-bit attribute set
> * Refactor the 32-bit size warning to the range parsing loop. This
>   change also prints the warnings right after the window mappings are
>   logged.
> 
> [0] https://lore.kernel.org/linux-arm-kernel/20210527150541.3130505-1-punitagrawal@gmail.com/
> [1] https://lore.kernel.org/linux-pci/20210531221057.3406958-1-punitagrawal@gmail.com/
> [2] https://lore.kernel.org/linux-pci/20210607112856.3499682-1-punitagrawal@gmail.com/
> 
>  drivers/pci/of.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 85dcb7097da4..a143b02b2dcd 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -353,6 +353,8 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  				dev_warn(dev, "More than one I/O resource converted for %pOF. CPU base address for old range lost!\n",
>  					 dev_node);
>  			*io_base = range.cpu_addr;
> +		} else if (resource_type(res) == IORESOURCE_MEM) {
> +			res->flags &= ~IORESOURCE_MEM_64;
>  		}
>  
>  		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
> -- 
> 2.30.2
> 
