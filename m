Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E215EDC44
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 14:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiI1MFT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 08:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiI1MFR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 08:05:17 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0EE6527A;
        Wed, 28 Sep 2022 05:05:15 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id b6so14058684ljr.10;
        Wed, 28 Sep 2022 05:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=JToMWnthxvbhGcGIaDx+3g0Iu1vuHY2x2/8hvbLhJ0Q=;
        b=godYrL5Fo1TAyNwxflmfbhN0snuAFrPDr6bnkVI5KZEhY0YmCDxv6oEtoWChNX175H
         eRjDNsPFAAwsBbMh9supSTSuurEU7plvCvwZTkYWRz/o0657iZnQUPqR+MdyR+QzwItl
         bye0POIjglkhoOCcv7p/aL2ZsiykqMP7TIdvV0wmjo/H4XQbHPNFmxwPvu5MVYjPVcJ5
         fR7yuASr8t8Ylc8AT8t9BAcNTXbxbTk267ma8I7/jqx/0bZttP6oSnIvzqr+GgWFj8WB
         u05fGLerkGSjdllpjp4VoHdz0MVURiz1h/L5Xga7ct7vIJ5WR5G1hMbkRQBFTTCrpJ/T
         qWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JToMWnthxvbhGcGIaDx+3g0Iu1vuHY2x2/8hvbLhJ0Q=;
        b=ictunwnV5Nx3IER287qqOY3hIcTZt4IiizfC5E9QQGz6jCvAZCPliaSW5y1EV3/Xlg
         dih2lqL0+cpdA9xKblgh3JQ89sgKA06ltCAsYNeY3ezJgUxNdQOsYxkEJMmn4rD0zMYN
         FmCU1i4Y61ZuPdUSb9rM6Ab4v5CnMh2nXbjLl9qWM7l8uxg8QzYG0QUFz5mZR7vncWCl
         LUac73u0XErCJ7PBuXkc0DexshufU7WXTZs24+r/ZG0olehIyHs8q5BG2KMCltO/B1dF
         kpag4aodvfmDzm0lpGMsWHFyHD7iZ+MgXycTSbFAtqisN4060LhrmSkGm4h3UnrAqukB
         epkw==
X-Gm-Message-State: ACrzQf0iZVbF7jLKYxOk9oTZbdOi4OGOxvRGT4lTW4GV4fbhCjZTBQtq
        17lHiMrD8ZktFFIaCWQxbbk=
X-Google-Smtp-Source: AMsMyM7oMo9Q62NEWqImgptJTTsSlC3FXSRLeUHgLrrcfM9TVxyEZChulnEVJjVTNHbUZ4YLUgt7gg==
X-Received: by 2002:a2e:a5c2:0:b0:261:d23a:2009 with SMTP id n2-20020a2ea5c2000000b00261d23a2009mr11123311ljp.303.1664366713609;
        Wed, 28 Sep 2022 05:05:13 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id 2-20020ac25f42000000b0049aa7a56715sm459795lfz.267.2022.09.28.05.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 05:05:12 -0700 (PDT)
Date:   Wed, 28 Sep 2022 15:05:10 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Will McVicker <willmcvicker@google.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 2/2] PCI: dwc: Add support for 64-bit MSI target
 address
Message-ID: <20220928120510.rkdlnczytxuioxcn@mobilestation>
References: <20220825185026.3816331-1-willmcvicker@google.com>
 <20220825185026.3816331-3-willmcvicker@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825185026.3816331-3-willmcvicker@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 25, 2022 at 06:50:25PM +0000, Will McVicker wrote:
> Since not all devices require a 32-bit MSI address, add support to the
> PCIe host driver to allow setting the DMA mask to 64-bits if the 32-bit
> allocation fails. This allows kernels to disable ZONE_DMA32 and bounce
> buffering (swiotlb) without risking not being able to get a 32-bit address
> during DMA allocation.

What is a problem in having the ZONE_DMA32 enabled anyway?

> 
> Basically, in the slim chance that there are no 32-bit allocations
> available, the current PCIe host driver will fail to allocate the msi_msg
> page due to a DMA address overflow (seen in [1]). With this patch, the
> PCIe host can retry the allocation with a 64-bit DMA mask if the current
> PCIe device advertises 64-bit support via its MSI capabilities.
> 
> [1] https://lore.kernel.org/all/Yo0soniFborDl7+C@google.com/

Note the reported error isn't caused by the allocation procedure, but
by the mapping procedure.

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 38 ++++++++++++++-----
>  drivers/pci/controller/dwc/pcie-designware.c  |  8 ++++
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  3 files changed, 38 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 39f3b37d4033..8928a9a29d58 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -330,6 +330,9 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  	u64 *msi_vaddr;
>  	int ret;
>  	u32 ctrl, num_ctrls;
> +	bool msi_64bit = false;
> +	bool retry_64bit = false;
> +	u16 msi_capabilities;
>  
>  	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
>  		pp->irq_mask[ctrl] = ~0;
> @@ -367,16 +370,33 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  						    dw_chained_msi_isr, pp);
>  	}
>  
> -	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> -	if (ret)
> -		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");

> +	msi_capabilities = dw_pcie_msi_capabilities(pci);
> +	if (msi_capabilities & PCI_MSI_FLAGS_ENABLE)
> +		msi_64bit = msi_capabilities & PCI_MSI_FLAGS_64BIT;

Note this capability flag has nothing to do with the DW PCIe iMSI-RX
engine, which is used here to detect and report MSI TLPs. By design
iMSI-RX always support 64-bit addresses. If you imply having that flag
set by the DW PCIe platform drivers on the platform-specific probe
stage as an indication of MSI address range, then ok.

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

> +		ret = dma_set_mask_and_coherent(dev, retry_64bit ?
> +						DMA_BIT_MASK(64) :
> +						DMA_BIT_MASK(32));

I'd suggest to just drop this. No DMA actually performed on getting the
MSI TLPs. So modifying the device DMA-mask due to something which
doesn't cause DMA and based on the flag which doesn't indicates the
device DMA-capability is at least inappropriate.

> +		if (ret)
> +			dev_warn(dev, "Failed to set DMA mask to %s-bit.\n",
> +				 retry_64bit ? "64" : "32");
> +

> +		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> +						GFP_KERNEL);

As I noted earlier the DMA-coherent memory can be too expensive. So
it's a waste of one allocating with no intent of usage. Instead of this
just get back the alloc_page() method here and pass the flag GFP_DMA32
to that function if MSI-capability reported the PCI_MSI_FLAGS_64BIT
unset.

-Sergey

> +		if (!msi_vaddr) {
> +			dev_err(dev, "Failed to alloc and map MSI data\n");
> +			if (msi_64bit && !retry_64bit) {
> +				retry_64bit = true;
> +				continue;
> +			}
> +
> +			dw_pcie_free_msi(pp);
> +			return -ENOMEM;
> +		}
> +		break;
>  	}
>  
>  	return 0;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index c6725c519a47..650a7f22f9d0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -82,6 +82,14 @@ u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
>  
> +u16 dw_pcie_msi_capabilities(struct dw_pcie *pci)
> +{
> +	u8 offset;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> +	return dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
> +}
> +
>  static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
>  					    u8 cap)
>  {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index a871ae7eb59e..45fcdfc8c035 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -332,6 +332,7 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
>  
>  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
>  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
> +u16 dw_pcie_msi_capabilities(struct dw_pcie *pci);
>  
>  int dw_pcie_read(void __iomem *addr, int size, u32 *val);
>  int dw_pcie_write(void __iomem *addr, int size, u32 val);
> -- 
> 2.37.2.672.g94769d06f0-goog
> 
> 
