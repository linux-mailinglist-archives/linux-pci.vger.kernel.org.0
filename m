Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672102353D7
	for <lists+linux-pci@lfdr.de>; Sat,  1 Aug 2020 19:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgHARjl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Aug 2020 13:39:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:36744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgHARjk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 1 Aug 2020 13:39:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 13A3AB611;
        Sat,  1 Aug 2020 17:39:53 +0000 (UTC)
Message-ID: <e37ff97826cf006bf1c9a3e0a134847f8030c79a.camel@suse.de>
Subject: Re: [PATCH v9 09/12] PCI: brcmstb: Set additional internal memory
 DMA viewport sizes
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Sat, 01 Aug 2020 19:39:32 +0200
In-Reply-To: <20200724203407.16972-10-james.quinlan@broadcom.com>
References: <20200724203407.16972-1-james.quinlan@broadcom.com>
         <20200724203407.16972-10-james.quinlan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jim,

On Fri, 2020-07-24 at 16:33 -0400, Jim Quinlan wrote:
> The Raspberry Pi (RPI) is currently the only chip using this driver
> (pcie-brcmstb.c).  There, only one memory controller is used, without an
> extension region, and the SCB0 viewport size is set to the size of the
> first and only dma-range region.  Other BrcmSTB SOCs have more complicated
> memory configurations that require setting additional viewport sizes.
> 
> BrcmSTB PCIe controllers are intimately connected to the memory
> controller(s) on the SOC.  The SOC may have one to three memory
> controllers; they are indicated by the term SCBi.  Each controller has a
> base region and an optional extension region.  In physical memory, the base
> and extension regions of a controller are not adjacent, but in PCIe-space
> they are.
> 
> There is a "viewport" for each memory controller that allows DMA from
> endpoint devices.  Each viewport's size must be set to a power of two, and
> that size must be equal to or larger than the amount of memory each
> controller supports which is the sum of base region and its optional
> extension.  Further, the 1-3 viewports are also adjacent in PCIe-space.
> 
> Unfortunately the viewport sizes cannot be ascertained from the
> "dma-ranges" property so they have their own property, "brcm,scb-sizes".
> This is because dma-range information does not indicate what memory
> controller it is associated.  For example, consider the following case
> where the size of one dma-range is 2GB and the second dma-range is 1GB:
> 
>     /* Case 1: SCB0 size set to 4GB */
>     dma-range0: 2GB (from memc0-base)
>     dma-range1: 1GB (from memc0-extension)
> 
>     /* Case 2: SCB0 size set to 2GB, SCB1 size set to 1GB */
>     dma-range0: 2GB (from memc0-base)
>     dma-range1: 1GB (from memc0-extension)
> 
> By just looking at the dma-ranges information, one cannot tell which
> situation applies. That is why an additional property is needed.  Its
> length indicates the number of memory controllers being used and each value
> indicates the viewport size.
> 
> Note that the RPI DT does not have a "brcm,scb-sizes" property value,
> as it is assumed that it only requires one memory controller and no
> extension.  So the optional use of "brcm,scb-sizes" will be backwards
> compatible.
> 
> One last layer of complexity exists: all of the viewports sizes must be
> added and rounded up to a power of two to determine what the "BAR" size is.
> Further, an offset must be given that indicates the base PCIe address of
> this "BAR".  The use of the term BAR is typically associated with endpoint
> devices, and the term is used here because the PCIe HW may be used as an RC
> or an EP.  In the former case, all of the system memory appears in a single
> "BAR" region in PCIe memory.  As it turns out, BrcmSTB PCIe HW is rarely
> used in the EP role and its system of mapping memory is an artifact that
> requires multiple dma-ranges regions.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 68 ++++++++++++++++++++-------
>  1 file changed, 50 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 8dacb9d3b7b6..3ef2d37cc43b 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -715,22 +720,44 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
>  							u64 *rc_bar2_offset)
>  {
>  	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> -	struct device *dev = pcie->dev;
>  	struct resource_entry *entry;
> +	struct device *dev = pcie->dev;
> +	u64 lowest_pcie_addr = ~(u64)0;
> +	int ret, i = 0;
> +	u64 size = 0;
>  
> -	entry = resource_list_first_type(&bridge->dma_ranges, IORESOURCE_MEM);
> -	if (!entry)
> -		return -ENODEV;
> +	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
> +		u64 pcie_beg = entry->res->start - entry->offset;
>  
> +		size += entry->res->end - entry->res->start + 1;
> +		if (pcie_beg < lowest_pcie_addr)
> +			lowest_pcie_addr = pcie_beg;
> +	}
>  
> -	/*
> -	 * The controller expects the inbound window offset to be calculated as
> -	 * the difference between PCIe's address space and CPU's. The offset
> -	 * provided by the firmware is calculated the opposite way, so we
> -	 * negate it.
> -	 */
> -	*rc_bar2_offset = -entry->offset;
> -	*rc_bar2_size = 1ULL << fls64(entry->res->end - entry->res->start);
> +	if (lowest_pcie_addr == ~(u64)0) {
> +		dev_err(dev, "DT node has no dma-ranges\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = of_property_read_variable_u64_array(pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
> +						  PCIE_BRCM_MAX_MEMC);
> +
> +	if (ret <= 0) {
> +		/* Make an educated guess */
> +		pcie->num_memc = 1;
> +		pcie->memc_size[0] = 1 << fls64(size - 1);

You need to 1ULL here.

Regards,
Nicolas

> +	} else {
> +		pcie->num_memc = ret;
> +	}
> +
> +	/* Each memc is viewed through a "port" that is a power of 2 */
> +	for (i = 0, size = 0; i < pcie->num_memc; i++)
> +		size += pcie->memc_size[i];
> +
> +	/* System memory starts at this address in PCIe-space */
> +	*rc_bar2_offset = lowest_pcie_addr;
> +	/* The sum of all memc views must also be a power of 2 */
> +	*rc_bar2_size = 1ULL << fls64(size - 1);
>  
>  	/*
>  	 * We validate the inbound memory view even though we should trust

