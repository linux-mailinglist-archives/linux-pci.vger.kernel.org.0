Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19DB7E751
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2019 18:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfD2QJm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Apr 2019 12:09:42 -0400
Received: from foss.arm.com ([217.140.101.70]:33200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbfD2QJl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Apr 2019 12:09:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DC65EBD;
        Mon, 29 Apr 2019 09:09:41 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1EA13F5C1;
        Mon, 29 Apr 2019 09:09:39 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] iommu/dma: Reserve IOVA for PCIe inaccessible DMA
 address
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        poza@codeaurora.org, Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
 <1555038815-31916-3-git-send-email-srinath.mannam@broadcom.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e6c812d6-0cad-4cfd-defd-d7ec427a6538@arm.com>
Date:   Mon, 29 Apr 2019 17:09:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555038815-31916-3-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/04/2019 04:13, Srinath Mannam wrote:
> dma_ranges field of PCI host bridge structure has resource entries in
> sorted order of address range given through dma-ranges DT property. This
> list is the accessible DMA address range. So that this resource list will
> be processed and reserve IOVA address to the inaccessible address holes in
> the list.
> 
> This method is similar to PCI IO resources address ranges reserving in
> IOMMU for each EP connected to host bridge.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
> Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
> ---
>   drivers/iommu/dma-iommu.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d19f3d6..fb42d7c 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -212,6 +212,7 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
>   	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
>   	struct resource_entry *window;
>   	unsigned long lo, hi;
> +	phys_addr_t start = 0, end;
>   
>   	resource_list_for_each_entry(window, &bridge->windows) {
>   		if (resource_type(window->res) != IORESOURCE_MEM)
> @@ -221,6 +222,24 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
>   		hi = iova_pfn(iovad, window->res->end - window->offset);
>   		reserve_iova(iovad, lo, hi);
>   	}
> +
> +	/* Get reserved DMA windows from host bridge */
> +	resource_list_for_each_entry(window, &bridge->dma_ranges) {
> +		end = window->res->start - window->offset;
> +resv_iova:
> +		if (end - start) {
> +			lo = iova_pfn(iovad, start);
> +			hi = iova_pfn(iovad, end);
> +			reserve_iova(iovad, lo, hi);
> +		}
> +		start = window->res->end - window->offset + 1;
> +		/* If window is last entry */
> +		if (window->node.next == &bridge->dma_ranges &&
> +		    end != DMA_BIT_MASK(sizeof(dma_addr_t) * BITS_PER_BYTE)) {

I still think that's a very silly way to write "~(dma_addr_t)0", but 
otherwise,

Acked-by: Robin Murphy <robin.murphy@arm.com>

> +			end = DMA_BIT_MASK(sizeof(dma_addr_t) * BITS_PER_BYTE);
> +			goto resv_iova;
> +		}
> +	}
>   }
>   
>   static int iova_reserve_iommu_regions(struct device *dev,
> 
