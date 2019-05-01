Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79C7910930
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 16:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfEAOhu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 10:37:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60248 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfEAOhu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 May 2019 10:37:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84B93A78;
        Wed,  1 May 2019 07:37:49 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A51063F719;
        Wed,  1 May 2019 07:37:47 -0700 (PDT)
Date:   Wed, 1 May 2019 15:37:42 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, poza@codeaurora.org,
        Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] PCI: iproc: Add sorted dma ranges resource
 entries to host bridge
Message-ID: <20190501143742.GA13089@e121166-lin.cambridge.arm.com>
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
 <1555038815-31916-4-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555038815-31916-4-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 12, 2019 at 08:43:35AM +0530, Srinath Mannam wrote:
> IPROC host has the limitation that it can use only those address ranges
> given by dma-ranges property as inbound address. So that the memory
> address holes in dma-ranges should be reserved to allocate as DMA address.
> 
> Inbound address of host accessed by PCIe devices will not be translated
> before it comes to IOMMU or directly to PE.

What does that mean "directly to PE" ?

IIUC all you want to say is that there is no entity translating
PCI memory transactions addresses before they it the PCI host
controller inbound regions address decoder.

> But the limitation of this host is, access to few address ranges are
> ignored. So that IOVA ranges for these address ranges have to be
> reserved.
> 
> All allowed address ranges are listed in dma-ranges DT parameter. These
> address ranges are converted as resource entries and listed in sorted
> order add added to dma_ranges list of PCI host bridge structure.
> 
> Ex:
> dma-ranges = < \
>   0x43000000 0x00 0x80000000 0x00 0x80000000 0x00 0x80000000 \
>   0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
>   0x43000000 0x80 0x00000000 0x80 0x00000000 0x40 0x00000000>
> 
> In the above example of dma-ranges, memory address from
> 0x0 - 0x80000000,
> 0x100000000 - 0x800000000,
> 0x1000000000 - 0x8000000000 and
> 0x10000000000 - 0xffffffffffffffff.
> are not allowed to use as inbound addresses.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
> Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
> ---
>  drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index c20fd6b..94ba5c0 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -1146,11 +1146,43 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
>  	return ret;
>  }
>  
> +static int
> +iproc_pcie_add_dma_range(struct device *dev, struct list_head *resources,
> +			 struct of_pci_range *range)
> +{
> +	struct resource *res;
> +	struct resource_entry *entry, *tmp;
> +	struct list_head *head = resources;
> +
> +	res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	resource_list_for_each_entry(tmp, resources) {
> +		if (tmp->res->start < range->cpu_addr)
> +			head = &tmp->node;
> +	}
> +
> +	res->start = range->cpu_addr;
> +	res->end = res->start + range->size - 1;
> +
> +	entry = resource_list_create_entry(res, 0);
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	entry->offset = res->start - range->cpu_addr;
> +	resource_list_add(entry, head);
> +
> +	return 0;
> +}
> +
>  static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
>  {
> +	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
>  	struct of_pci_range range;
>  	struct of_pci_range_parser parser;
>  	int ret;
> +	LIST_HEAD(resources);
>  
>  	/* Get the dma-ranges from DT */
>  	ret = of_pci_dma_range_parser_init(&parser, pcie->dev->of_node);
> @@ -1158,13 +1190,23 @@ static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
>  		return ret;
>  
>  	for_each_of_pci_range(&parser, &range) {
> +		ret = iproc_pcie_add_dma_range(pcie->dev,
> +					       &resources,
> +					       &range);
> +		if (ret)
> +			goto out;
>  		/* Each range entry corresponds to an inbound mapping region */
>  		ret = iproc_pcie_setup_ib(pcie, &range, IPROC_PCIE_IB_MAP_MEM);
>  		if (ret)
> -			return ret;
> +			goto out;
>  	}
>  
> +	list_splice_init(&resources, &host->dma_ranges);
> +
>  	return 0;
> +out:
> +	pci_free_resource_list(&resources);
> +	return ret;
>  }
>  
>  static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
> -- 
> 2.7.4
> 
