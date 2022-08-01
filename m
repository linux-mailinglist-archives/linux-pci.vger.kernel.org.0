Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF95586C7C
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 16:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiHAOBH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 10:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiHAOBG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 10:01:06 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9775D9598
        for <linux-pci@vger.kernel.org>; Mon,  1 Aug 2022 07:01:05 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso12100760pjd.3
        for <linux-pci@vger.kernel.org>; Mon, 01 Aug 2022 07:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=10hnu0IasiN9BMqs6lfBX/MGfOJQ01A5ZPmIP3RjdiA=;
        b=XFVKymDj1uK88g1gcxObeXwCIZ6Yr4Up/ArU64JLn3M5aTEf72bufIr3mw4UMGIDYL
         3B/d803ElBTwev4V9FxeUriNOsZp6lYv1zFI6Mwo0V9G8/wSBG687X9f8BIxAE7sxwTb
         NrBcsKRhhFZyMdybaGDVJo8OKPRnsJctkUOCU3Gy9Yh12iSECFBeMFNl35oTxbchUcNP
         +Ce5wXW7olKasXxeQ2A8Erfm8OrsCyBVbMUs3VpBbVpqLX0O0s7b5+eoQBVbFjUjZaOs
         lQK6VqTkCTeT4FAxe2ec4lN/r+B901/0WrH+35JZDjZEIbi5M0Xf8AcpdsaMC11NtSgh
         1eQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=10hnu0IasiN9BMqs6lfBX/MGfOJQ01A5ZPmIP3RjdiA=;
        b=28V1MeM+wSrfzHxtSLklVsaVjIa7RxgmUd+X+XhWv0BAogpDSwL+9jWxOW35qEdkmA
         r1FhbCDGEOokEZslZUPOC+4wTwN/l20dXxtVtytjdADN1SG9m5P5kPR0DgqfxpMp+efg
         0wChIj1fPfQ/KcdjLNq+6k1Saf34WxtD3CNUNTea76y2EFsoSH0WnbM3VhUunHaNrPf1
         LS96dDRaBrHXUAST26921myWKITxBlhVmQ8LkdDCxISXIlq7mrFci2nBX83rg+cIbPos
         AUpE5DMf5DRgnh//23U2300IAbARIOqkrAk6BaXpsHhrQnzHWQrHWnMWCvNGJxgfoBx2
         hloA==
X-Gm-Message-State: ACgBeo0ze/xODNzqExIKmKBrg0Xvlx/9G0HDjEcJ1vl6QPptw710QhYy
        W6yPXYBwtRyCrxSPEnoxZTJm
X-Google-Smtp-Source: AA6agR5bLnIlnkdC5IzeE4M/ebptF5K9ZMzZMXbU4ybXtDQKYYnaKe1eGBv76a5dZfDe292f/jHH2A==
X-Received: by 2002:a17:903:18f:b0:16d:6e7a:44c with SMTP id z15-20020a170903018f00b0016d6e7a044cmr16815752plg.91.1659362464970;
        Mon, 01 Aug 2022 07:01:04 -0700 (PDT)
Received: from thinkpad ([117.217.185.73])
        by smtp.gmail.com with ESMTPSA id t2-20020aa79462000000b0052abc2438f1sm2607185pfq.55.2022.08.01.07.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 07:00:58 -0700 (PDT)
Date:   Mon, 1 Aug 2022 19:30:47 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 15/15] PCI: dwc: Introduce dma-ranges property
 support for RC-host
Message-ID: <20220801140047.GO93763@thinkpad>
References: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
 <20220624143947.8991-16-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624143947.8991-16-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:39:47PM +0300, Serge Semin wrote:
> In accordance with the generic PCIe Root Port DT-bindings the "dma-ranges"
> property has the same format as the "ranges" property. The only difference
> is in their semantics. The "dma-ranges" property describes the PCIe-to-CPU
> memory mapping in opposite to the CPU-to-PCIe mapping of the "ranges"
> property. Even though the DW PCIe controllers are normally equipped with
> the internal Address Translation Unit which inbound and outbound tables
> can be used to implement both properties semantics, it was surprising for
> me to discover that the host-related part of the DW PCIe driver currently
> supports the "ranges" property only while the "dma-ranges" windows are
> just ignored. Having the "dma-ranges" supported in the driver would be
> very handy for the platforms, that don't tolerate the 1:1 CPU-PCIe memory
> mapping and require a customized PCIe memory layout. So let's fix that by
> introducing the "dma-ranges" property support.
> 
> First of all we suggest to rename the dw_pcie_prog_inbound_atu() method to
> dw_pcie_prog_ep_inbound_atu() and create a new version of the
> dw_pcie_prog_inbound_atu() function. Thus we'll have two methods for the
> RC and EP controllers respectively in the same way as it has been
> developed for the outbound ATU setup methods.
> 
> Secondly aside with the memory window index and type the new
> dw_pcie_prog_inbound_atu() function will accept CPU address, PCIe address
> and size as its arguments. These parameters define the PCIe and CPU memory
> ranges which will be used to setup the respective inbound ATU mapping. The
> passed parameters need to be verified against the ATU ranges constraints
> in the same way as it is done for the outbound ranges.
> 
> Finally the DMA-ranges detected for the PCIe controller need to be
> converted to the inbound ATU entries during the host controller
> initialization procedure. It will be done in the framework of the
> dw_pcie_iatu_setup() method. Note before setting the inbound ranges up we
> need to disable all the inbound ATU entries in order to prevent unexpected
> PCIe TLPs translations defined by some third party software like
> bootloaders.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Small nitpick below,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Changelog v3:
> - Drop inbound iATU window size alignment constraint. (@Manivannan)
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   |  4 +-
>  .../pci/controller/dwc/pcie-designware-host.c | 32 ++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.c  | 56 ++++++++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h  |  6 +-
>  4 files changed, 89 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 627c4b69878c..441feff1917a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -167,8 +167,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
>  		return -EINVAL;
>  	}
>  
> -	ret = dw_pcie_prog_inbound_atu(pci, func_no, free_win, type,
> -				       cpu_addr, bar);
> +	ret = dw_pcie_prog_ep_inbound_atu(pci, func_no, free_win, type,
> +					  cpu_addr, bar);
>  	if (ret < 0) {
>  		dev_err(pci->dev, "Failed to program IB window\n");
>  		return ret;
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 6993ce9e856d..2fbe9dc11634 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -581,12 +581,15 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  	}
>  
>  	/*
> -	 * Ensure all outbound windows are disabled before proceeding with
> -	 * the MEM/IO ranges setups.
> +	 * Ensure all out/inbound windows are disabled before proceeding with
> +	 * the MEM/IO (dma-)ranges setups.
>  	 */
>  	for (i = 0; i < pci->num_ob_windows; i++)
>  		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_OB, i);
>  
> +	for (i = 0; i < pci->num_ib_windows; i++)
> +		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, i);
> +
>  	i = 0;
>  	resource_list_for_each_entry(entry, &pp->bridge->windows) {
>  		if (resource_type(entry->res) != IORESOURCE_MEM)
> @@ -623,9 +626,32 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  	}
>  
>  	if (pci->num_ob_windows <= i)
> -		dev_warn(pci->dev, "Resources exceed number of ATU entries (%d)\n",
> +		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
>  			 pci->num_ob_windows);
>  

I think a comment here explaining what's going on below would be helpful in the
future.

> +	i = 0;
> +	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
> +		if (resource_type(entry->res) != IORESOURCE_MEM)
> +			continue;
> +
> +		if (pci->num_ib_windows <= i)
> +			break;
> +
> +		ret = dw_pcie_prog_inbound_atu(pci, i++, PCIE_ATU_TYPE_MEM,
> +					       entry->res->start,
> +					       entry->res->start - entry->offset,
> +					       resource_size(entry->res));
> +		if (ret) {
> +			dev_err(pci->dev, "Failed to set DMA range %pr\n",
> +				entry->res);
> +			return ret;
> +		}
> +	}
> +
> +	if (pci->num_ib_windows <= i)
> +		dev_warn(pci->dev, "Dma-ranges exceed inbound iATU size (%u)\n",

"dma-ranges"

> +			 pci->num_ib_windows);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 9c622b635fdd..7a5be3c4f8e0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -396,8 +396,60 @@ static inline void dw_pcie_writel_atu_ib(struct dw_pcie *pci, u32 index, u32 reg
>  	dw_pcie_writel_atu(pci, PCIE_ATU_REGION_DIR_IB, index, reg, val);
>  }
>  
> -int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -			     int type, u64 cpu_addr, u8 bar)
> +int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
> +			     u64 cpu_addr, u64 pci_addr, u64 size)
> +{
> +	u64 limit_addr = pci_addr + size - 1;
> +	u32 retries, val;
> +
> +	if ((limit_addr & ~pci->region_limit) != (pci_addr & ~pci->region_limit) ||
> +	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
> +	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
> +		return -EINVAL;
> +	}
> +
> +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_BASE,
> +			      lower_32_bits(pci_addr));
> +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_BASE,
> +			      upper_32_bits(pci_addr));
> +
> +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LIMIT,
> +			      lower_32_bits(limit_addr));
> +	if (dw_pcie_ver_is_ge(pci, 460A))
> +		dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_LIMIT,
> +				      upper_32_bits(limit_addr));
> +
> +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_TARGET,
> +			      lower_32_bits(cpu_addr));
> +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_TARGET,
> +			      upper_32_bits(cpu_addr));
> +
> +	val = type;
> +	if (upper_32_bits(limit_addr) > upper_32_bits(pci_addr) &&
> +	    dw_pcie_ver_is_ge(pci, 460A))
> +		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_REGION_CTRL1, val);
> +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
> +
> +	/*
> +	 * Make sure ATU enable takes effect before any subsequent config
> +	 * and I/O accesses.
> +	 */
> +	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
> +		val = dw_pcie_readl_atu_ib(pci, index, PCIE_ATU_REGION_CTRL2);
> +		if (val & PCIE_ATU_ENABLE)
> +			return 0;
> +
> +		mdelay(LINK_WAIT_IATU);
> +	}
> +
> +	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
> +
> +	return -ETIMEDOUT;
> +}
> +
> +int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> +				int type, u64 cpu_addr, u8 bar)
>  {
>  	u32 retries, val;
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index c3e73ed9aff5..5954e8cf9eec 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -308,8 +308,10 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
>  			      u64 cpu_addr, u64 pci_addr, u64 size);
>  int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
>  				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
> -int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -			     int type, u64 cpu_addr, u8 bar);
> +int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
> +			     u64 cpu_addr, u64 pci_addr, u64 size);
> +int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> +				int type, u64 cpu_addr, u8 bar);
>  void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
>  void dw_pcie_setup(struct dw_pcie *pci);
>  void dw_pcie_iatu_detect(struct dw_pcie *pci);
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
