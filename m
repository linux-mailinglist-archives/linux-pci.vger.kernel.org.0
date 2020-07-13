Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080C321D688
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgGMNO3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:14:29 -0400
Received: from 8bytes.org ([81.169.241.247]:52542 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729523AbgGMNO3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jul 2020 09:14:29 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9B18D36B; Mon, 13 Jul 2020 15:14:27 +0200 (CEST)
Date:   Mon, 13 Jul 2020 15:14:26 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, iommu@lists.linux-foundation.org,
        jonathan.lemon@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] iommu/dma: Avoid SAC address trick for PCIe devices
Message-ID: <20200713131426.GQ27672@8bytes.org>
References: <e583fc6dd1fb4ffc90310ff4372ee776f9cc7a3c.1594207679.git.robin.murphy@arm.com>
 <d412c292d222eb36469effd338e985f9d9e24cd6.1594207679.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d412c292d222eb36469effd338e985f9d9e24cd6.1594207679.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 08, 2020 at 12:32:42PM +0100, Robin Murphy wrote:
> As for the intel-iommu implementation, relegate the opportunistic
> attempt to allocate a SAC address to the domain of conventional PCI
> devices only, to avoid it increasingly causing far more performance
> issues than possible benefits on modern PCI Express systems.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 4959f5df21bd..0ff124f16ad4 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -426,7 +426,8 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>  		dma_limit = min(dma_limit, (u64)domain->geometry.aperture_end);
>  
>  	/* Try to get PCI devices a SAC address */
> -	if (dma_limit > DMA_BIT_MASK(32) && dev_is_pci(dev))
> +	if (dma_limit > DMA_BIT_MASK(32) &&
> +	    dev_is_pci(dev) && !pci_is_pcie(to_pci_dev(dev)))
>  		iova = alloc_iova_fast(iovad, iova_len,
>  				       DMA_BIT_MASK(32) >> shift, false);
>  

Unfortunatly this patch causes XHCI initialization failures on my AMD
Ryzen system. I will remove both from the IOMMU tree for now.

I guess the XHCI chip in my system does not support full 64bit dma
addresses and needs a quirk or something like that. But until this is
resolved its better to not change the IOVA allocation behavior.

Regards,

	Joerg
