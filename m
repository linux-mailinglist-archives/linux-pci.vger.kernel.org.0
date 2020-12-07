Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71262D1A92
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 21:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgLGUdF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 15:33:05 -0500
Received: from foss.arm.com ([217.140.110.172]:32982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgLGUdE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 15:33:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32D9531B;
        Mon,  7 Dec 2020 12:32:19 -0800 (PST)
Received: from [10.57.61.6] (unknown [10.57.61.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A3EE3F66B;
        Mon,  7 Dec 2020 12:32:17 -0800 (PST)
Subject: Re: [PATCH] PCI: dwc: Set 32-bit DMA mask for MSI target address
 allocation
To:     Vidya Sagar <vidyas@nvidia.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, robh@kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20201117165312.25847-1-vidyas@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a5d8c24b-c605-8753-b022-ab959cf52340@arm.com>
Date:   Mon, 7 Dec 2020 20:32:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201117165312.25847-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-11-17 16:53, Vidya Sagar wrote:
> Set DMA mask to 32-bit while allocating the MSI target address so that
> the address is usable for both 32-bit and 64-bit MSI capable devices.
> Throw a warning if it fails to set the mask to 32-bit to alert that
> devices that are only 32-bit MSI capable may not work properly.

This is slightly wacky, but no more so than the rest of the not-DMA 
shenanigans here... Ultimately it probably is the least-worst way to 
avoid the issue, so in terms of functionality,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Given the other patch that I've pushed to the MSI sub-system
> http://patchwork.ozlabs.org/project/linux-pci/patch/20201117145728.4516-1-vidyas@nvidia.com/
> which is going to catch any mismatch between MSI capability (32-bit) of the
> device and system's inability to allocate the required MSI target address,
> I'm not sure how much sense is this patch going to be make. But, I can
> certainly say that if the memory allocation mechanism gives the addresses
> from 64-bit pool by default, this patch at least makes sure that MSI target
> address is allocated from 32-bit pool.

Note that this doesn't change where anything is allocated as such, it 
just means that on systems with most of their RAM above 4GB, those few 
bytes of private data that you map "for free" will be copied into the 
SWIOTLB buffer and hog 2KB of its typical 64MB capacity effectively for 
ever.

>   drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 44c2a6572199..e6a230eddf66 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -388,6 +388,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
>   							    dw_chained_msi_isr,
>   							    pp);
>   
> +			ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
> +			if (!ret) {
> +				dev_warn(pci->dev,
> +					 "Failed to set DMA mask to 32-bit. "
> +					 "Devices with only 32-bit MSI support"
> +					 " may not work properly\n");
> +			}

Ironically, the only real reason for that dma_set_mask() to ever fail is 
if the system had no 32-bit addressable memory, in which case you could 
likely pick any 32-bit doorbell address with impunity, just not via this 
mechanism (although whether it would be worthwhile is another matter).

Robin.

> +
>   			pp->msi_data = dma_map_single_attrs(pci->dev, &pp->msi_msg,
>   						      sizeof(pp->msi_msg),
>   						      DMA_FROM_DEVICE,
> 
