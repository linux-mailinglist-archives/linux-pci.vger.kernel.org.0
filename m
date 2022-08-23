Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE93659E500
	for <lists+linux-pci@lfdr.de>; Tue, 23 Aug 2022 16:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241803AbiHWOQT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Aug 2022 10:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242898AbiHWOP2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Aug 2022 10:15:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3ED2270B17;
        Tue, 23 Aug 2022 04:28:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEBC7113E;
        Tue, 23 Aug 2022 04:28:04 -0700 (PDT)
Received: from [10.57.15.51] (unknown [10.57.15.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D9293F70D;
        Tue, 23 Aug 2022 04:27:59 -0700 (PDT)
Message-ID: <1e63a581-14ae-b4b5-a5bf-ca8f09c33af6@arm.com>
Date:   Tue, 23 Aug 2022 12:27:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v4 2/2] PCI: dwc: Add support for 64-bit MSI target
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
References: <20220812000327.3154251-1-willmcvicker@google.com>
 <20220812000327.3154251-3-willmcvicker@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220812000327.3154251-3-willmcvicker@google.com>
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

On 2022-08-12 01:03, Will McVicker wrote:
> Since not all devices require a 32-bit MSI address, add support to the
> PCIe host driver to allow setting the DMA mask to 64-bits. This allows
> kernels to disable ZONE_DMA32 and bounce buffering (swiotlb) without
> risking not being able to get a 32-bit address during DMA allocation.
> Basically, in the slim chance that there are no 32-bit allocations
> available, the current PCIe host driver will fail to allocate the
> msi_msg page due to a DMA address overflow (seen in [1]). With this
> patch, the PCIe device can advertise 64-bit support via its MSI
> capabilities to hint to the PCIe host driver to set the DMA mask to
> 64-bits.

It doesn't matter so much what the host's own capabilities are, though, 
what matters is that if you configure the MSI doorbell to decode some 
64-bit address because you can, and later an endpoint shows up whose DMA 
mask doesn't reach that address, you've broken MSIs for that endpoint. 
While the host is probing, it cannot possibly know what future endpoint 
drivers may or may not do.

Now, in the case where no ZONE_DMA{32} is configured, there's a fair 
likelihood that addressing-constrained endpoints are probably going to 
be broken in general, so that should not be fatal for the host. So *if* 
we fail to allocate a 32-bit MSI address, *then* we should fall back to 
a 64-bit one (when the host supports it), but to preserve compatibility 
we still must always attempt the 32-bit allocation first (oh, if there 
isn't a theme emerging here...)

TBH this has come up enough times, and has enough subtle complexity, 
that I think it's high time to factor this all out into a helper between 
the PCI core code and the DMA API for "please give me a bus address 
that's guaranteed not to conflict with any valid DMA address".

Thanks,
Robin.

> [1] https://lore.kernel.org/all/Yo0soniFborDl7+C@google.com/
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++++++--
>   drivers/pci/controller/dwc/pcie-designware.c      |  8 ++++++++
>   drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>   3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 39f3b37d4033..d7831040791b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -330,6 +330,8 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>   	u64 *msi_vaddr;
>   	int ret;
>   	u32 ctrl, num_ctrls;
> +	bool msi_64bit = false;
> +	u16 msi_capabilities;
>   
>   	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
>   		pp->irq_mask[ctrl] = ~0;
> @@ -367,9 +369,17 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>   						    dw_chained_msi_isr, pp);
>   	}
>   
> -	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +	msi_capabilities = dw_pcie_msi_capabilities(pci);
> +	if (msi_capabilities & PCI_MSI_FLAGS_ENABLE)
> +		msi_64bit = msi_capabilities & PCI_MSI_FLAGS_64BIT;
> +
> +	dev_dbg(dev, "Setting MSI DMA mask to %s-bit.\n",
> +		msi_64bit ? "64" : "32");
> +	ret = dma_set_mask_and_coherent(dev, msi_64bit ?
> +					DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
>   	if (ret)
> -		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> +		dev_warn(dev, "Failed to set DMA mask to %s-bit.\n",
> +			 msi_64bit ? "64" : "32");
>   
>   	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
>   					GFP_KERNEL);
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
