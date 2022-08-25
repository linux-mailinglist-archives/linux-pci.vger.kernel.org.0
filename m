Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206225A1AA6
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 22:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiHYU7f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 16:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiHYU7e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 16:59:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE13EB2DA9;
        Thu, 25 Aug 2022 13:59:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EADAFD6E;
        Thu, 25 Aug 2022 13:59:36 -0700 (PDT)
Received: from [10.57.16.12] (unknown [10.57.16.12])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 138743F67D;
        Thu, 25 Aug 2022 13:59:29 -0700 (PDT)
Message-ID: <335d730d-529e-7ce0-8bac-008a4daa6e3c@arm.com>
Date:   Thu, 25 Aug 2022 21:59:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5 2/2] PCI: dwc: Add support for 64-bit MSI target
 address
Content-Language: en-GB
To:     Will McVicker <willmcvicker@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     kernel-team@android.com, Vidya Sagar <vidyas@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20220825185026.3816331-1-willmcvicker@google.com>
 <20220825185026.3816331-3-willmcvicker@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220825185026.3816331-3-willmcvicker@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-08-25 19:50, Will McVicker wrote:
> Since not all devices require a 32-bit MSI address, add support to the
> PCIe host driver to allow setting the DMA mask to 64-bits if the 32-bit
> allocation fails. This allows kernels to disable ZONE_DMA32 and bounce
> buffering (swiotlb) without risking not being able to get a 32-bit address
> during DMA allocation.
> 
> Basically, in the slim chance that there are no 32-bit allocations
> available, the current PCIe host driver will fail to allocate the msi_msg
> page due to a DMA address overflow (seen in [1]). With this patch, the
> PCIe host can retry the allocation with a 64-bit DMA mask if the current
> PCIe device advertises 64-bit support via its MSI capabilities.
> 
> [1] https://lore.kernel.org/all/Yo0soniFborDl7+C@google.com/
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
> ---
>   .../pci/controller/dwc/pcie-designware-host.c | 38 ++++++++++++++-----
>   drivers/pci/controller/dwc/pcie-designware.c  |  8 ++++
>   drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>   3 files changed, 38 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 39f3b37d4033..8928a9a29d58 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -330,6 +330,9 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>   	u64 *msi_vaddr;
>   	int ret;
>   	u32 ctrl, num_ctrls;
> +	bool msi_64bit = false;
> +	bool retry_64bit = false;
> +	u16 msi_capabilities;
>   
>   	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
>   		pp->irq_mask[ctrl] = ~0;
> @@ -367,16 +370,33 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>   						    dw_chained_msi_isr, pp);
>   	}
>   
> -	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> -	if (ret)
> -		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> +	msi_capabilities = dw_pcie_msi_capabilities(pci);
> +	if (msi_capabilities & PCI_MSI_FLAGS_ENABLE)
> +		msi_64bit = msi_capabilities & PCI_MSI_FLAGS_64BIT;
>   
> -	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> -					GFP_KERNEL);
> -	if (!msi_vaddr) {
> -		dev_err(dev, "Failed to alloc and map MSI data\n");
> -		dw_pcie_free_msi(pp);
> -		return -ENOMEM;
> +	while (true) {
> +		dev_dbg(dev, "Setting MSI DMA mask to %s-bit.\n",
> +			retry_64bit ? "64" : "32");

If only we has some sort of "variable" that could could store a 
numerical value, think of the possibilities... :)

> +		ret = dma_set_mask_and_coherent(dev, retry_64bit ?
> +						DMA_BIT_MASK(64) :
> +						DMA_BIT_MASK(32));
> +		if (ret)
> +			dev_warn(dev, "Failed to set DMA mask to %s-bit.\n",
> +				 retry_64bit ? "64" : "32");

Setting a 64-bit mask should never fail, since it represents having no 
possible limitation whatsoever (I'm not sure if there are any platforms 
left where setting a 32-bit mask can actually fail in practice either, 
but I have no strong opinion on the fate of the existing warning).

> +
> +		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> +						GFP_KERNEL);
> +		if (!msi_vaddr) {
> +			dev_err(dev, "Failed to alloc and map MSI data\n");

Possibly a mattrer of personal taste, but I'd say try to avoid dev_err() 
for things that aren't actually fatal; if you're still able to continue 
on, at best it's a warning, not an error. Especially if your use-case 
*expects* the 32-bit allocation fail. There's nothing more offputting 
than booting a typical vendor kernel and watching it scream tons of 
errors that look EXTREMELY IMPORTANT yet are also apparently 
inconsequential.

> +			if (msi_64bit && !retry_64bit) {
> +				retry_64bit = true;
> +				continue;
> +			}
> +
> +			dw_pcie_free_msi(pp);
> +			return -ENOMEM;
> +		}
> +		break;

TBH the whole loop design is a bit baroque for me, I'd have gone for a 
more straightforward tweak to the existing flow, something like:

	msi_vaddr = NULL;
	ret = dma_set_mask(32);
	if (!ret)
		msi_vaddr = dma_alloc();
	if (!msi_vaddr && msi_64bit) {
		dev_warn();
		dma_set_mask(64);
		msi_vaddr = dma_alloc();
	}
	if (!msi_vaddr) {
		dev_err();
		return;
	}
		
However I'm happy that you've captured the important functional point, 
so I'll leave the style matters up to Lorenzo.

Thanks,
Robin.

>   	}
>   
>   	return 0;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index c6725c519a47..650a7f22f9d0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -82,6 +82,14 @@ u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
>   }
>   EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
>   
> +u16 dw_pcie_msi_capabilities(struct dw_pcie *pci)
> +{
> +	u8 offset;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> +	return dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
> +}
> +
>   static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
>   					    u8 cap)
>   {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index a871ae7eb59e..45fcdfc8c035 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -332,6 +332,7 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
>   
>   u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
>   u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
> +u16 dw_pcie_msi_capabilities(struct dw_pcie *pci);
>   
>   int dw_pcie_read(void __iomem *addr, int size, u32 *val);
>   int dw_pcie_write(void __iomem *addr, int size, u32 val);
