Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95942586C4B
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 15:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiHANxy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 09:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbiHANxv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 09:53:51 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C4C25E93
        for <linux-pci@vger.kernel.org>; Mon,  1 Aug 2022 06:53:47 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s5-20020a17090a13c500b001f4da9ffe5fso5233468pjf.5
        for <linux-pci@vger.kernel.org>; Mon, 01 Aug 2022 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xR8LvYyXz7qqwbCnjpKvvI2My3wyvnoE7ZWZRZnvwHo=;
        b=CBvdoxOjhUXoiX1VZzdP4G0RsJ9cXBiL5FHEOgawKcLpzAb+NWONtJUjIgy4X/+KXy
         IxbVh2fef7cs5RNBMTbMLe8kgJDcdsJF6/nnATBB9I2KI9CnWjl0ssiesza/gZeguY7o
         UUkO8DrLmzT0QrKau3LcwsElRrGiMLIMUCgaj/K8UTddL7gs/hAl7jOVSSZBOGnub7LK
         E0QYYAcLIXB4ykTUzYz3npL8AMpFvXt5FMvFGwevR9eQIJP3xHHhKff5sj3EUj5W7iEQ
         jXGK1cZ7yTW7A/T5mBS6/LOdpTRQAan8bI34mTZ9oa9gbF9gARN7Jsg4O3ZzGsp02hlY
         58nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xR8LvYyXz7qqwbCnjpKvvI2My3wyvnoE7ZWZRZnvwHo=;
        b=uYdZsh7o3529a34AuRNtcoBLZDIShqp9wLuWdlashO7En41qhNhXWI1WmU5MWw/ZaE
         W9JavZ1bcBtbGUiWmj80pO5MHOsemb9yljJQxy0fmV7QRdg3J+iWDosyGhzs5PhZD0Pt
         8KZmHyzt56lFwccml5QTN9vARcgn7/aoM8i0r8dLJFXs6B2ohOSStmH1KUAkmXs4VSN0
         XuKetHwodA2s3bihXFiju01EkxDHGYg8nXS5S3+1AZLb2RpnlNN/NXy7GraMOWtSS9w4
         sZZFesX6WpJAv7wsY7iOMi53DXEvhu2qqmN8Jbc2m2Oix3M6Xr86N38kF1XNjdMKzhpN
         qOug==
X-Gm-Message-State: ACgBeo2KDEw/X2U2S2YXL15GE71nSwuMQolmbIIFbf2zqekEByXk0hB3
        fG2GQS4YbuZsD9VXU8g4PA+G
X-Google-Smtp-Source: AA6agR6QY+fI2mZLspfLJOKR9w2tiTFOH0UN1n5DFx1CLPS0Wk0YB33lYfiNoniEVmWpcVpG6GLUaA==
X-Received: by 2002:a17:90b:1c8e:b0:1f1:b5a9:20c3 with SMTP id oo14-20020a17090b1c8e00b001f1b5a920c3mr19656346pjb.47.1659362026423;
        Mon, 01 Aug 2022 06:53:46 -0700 (PDT)
Received: from thinkpad ([117.217.185.73])
        by smtp.gmail.com with ESMTPSA id b29-20020aa7951d000000b0052d0a93f6d5sm710423pfp.116.2022.08.01.06.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 06:53:46 -0700 (PDT)
Date:   Mon, 1 Aug 2022 19:23:38 +0530
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
Subject: Re: [PATCH RESEND v4 13/15] PCI: dwc: Verify in/out regions against
 iATU constraints
Message-ID: <20220801135338.GM93763@thinkpad>
References: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
 <20220624143947.8991-14-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624143947.8991-14-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:39:45PM +0300, Serge Semin wrote:
> Since the DWC PCIe driver private data now contains the iATU inbound and
> outbound regions constraints info like alignment, minimum and maximum
> limits, we can use them to make the in- and outbound iATU regions setup
> methods more strict to the ranges a callee tries to specify.  That will
> give us the safer dw_pcie_prog_outbound_atu(),
> dw_pcie_prog_ep_outbound_atu() and dw_pcie_prog_inbound_atu() functions.
> 
> First of all let's update the outbound ATU entries setup methods to
> returning the operation status. The methods will fail either in case if
> the range is failed to be activated or the passed region doesn't fulfill
> iATU constraints. Secondly the passed to the
> dw_pcie_prog_{ep_}outbound_atu() methods region-related parameters are
> verified against the detected iATU regions constraints. In particular the
> region limit address must not overflow the lower/upper limit CSR RW-fields
> otherwise the specified range will be just silently clamped. That
> verification will also protect the code from having u64 type overflow.
> Secondly let's make sure base address (CPU-address), target address
> (PCI-address) and size are properly aligned. Unaligned ranges will be
> silently aligned down (addresses) and up (limit) on writing the values to
> the corresponding registers, which in it turn may lead to unpredictable
> results like ranges virtual overlap. Finally the CPU-address alignment
> needs to be verified in the dw_pcie_prog_inbound_atu() method too as the
> DWC PCIe RC/EP registers manual demands seeing the lower bits of the in-
> and outbound iATU base address are always zeros.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Changelog v3:
> - Drop outbound iATU window size alignment constraint. (@Manivannan)
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 38 +++++++++++++-------
>  drivers/pci/controller/dwc/pcie-designware.h | 10 +++---
>  2 files changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 776752891d11..9c622b635fdd 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -8,6 +8,7 @@
>   * Author: Jingoo Han <jg1.han@samsung.com>
>   */
>  
> +#include <linux/align.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
>  #include <linux/of.h>
> @@ -308,9 +309,9 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
>  	return val | PCIE_ATU_TD;
>  }
>  
> -static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> -					int index, int type, u64 cpu_addr,
> -					u64 pci_addr, u64 size)
> +static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> +				       int index, int type, u64 cpu_addr,
> +				       u64 pci_addr, u64 size)
>  {
>  	u32 retries, val;
>  	u64 limit_addr;
> @@ -320,6 +321,12 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>  
>  	limit_addr = cpu_addr + size - 1;
>  
> +	if ((limit_addr & ~pci->region_limit) != (cpu_addr & ~pci->region_limit) ||
> +	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
> +	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
> +		return -EINVAL;
> +	}
> +
>  	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_BASE,
>  			      lower_32_bits(cpu_addr));
>  	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_BASE,
> @@ -353,27 +360,29 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>  	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
>  		val = dw_pcie_readl_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2);
>  		if (val & PCIE_ATU_ENABLE)
> -			return;
> +			return 0;
>  
>  		mdelay(LINK_WAIT_IATU);
>  	}
>  
>  	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
> +
> +	return -ETIMEDOUT;
>  }
>  
> -void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> -			       u64 cpu_addr, u64 pci_addr, u64 size)
> +int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> +			      u64 cpu_addr, u64 pci_addr, u64 size)
>  {
> -	__dw_pcie_prog_outbound_atu(pci, 0, index, type,
> -				    cpu_addr, pci_addr, size);
> +	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
> +					   cpu_addr, pci_addr, size);
>  }
>  
> -void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -				  int type, u64 cpu_addr, u64 pci_addr,
> -				  u64 size)
> +int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> +				 int type, u64 cpu_addr, u64 pci_addr,
> +				 u64 size)
>  {
> -	__dw_pcie_prog_outbound_atu(pci, func_no, index, type,
> -				    cpu_addr, pci_addr, size);
> +	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
> +					   cpu_addr, pci_addr, size);
>  }
>  
>  static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index, u32 reg)
> @@ -392,6 +401,9 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
>  {
>  	u32 retries, val;
>  
> +	if (!IS_ALIGNED(cpu_addr, pci->region_align))
> +		return -EINVAL;
> +
>  	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_TARGET,
>  			      lower_32_bits(cpu_addr));
>  	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_TARGET,
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 25c86771c810..60f1ddc54933 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -304,12 +304,10 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
>  int dw_pcie_link_up(struct dw_pcie *pci);
>  void dw_pcie_upconfig_setup(struct dw_pcie *pci);
>  int dw_pcie_wait_for_link(struct dw_pcie *pci);
> -void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
> -			       int type, u64 cpu_addr, u64 pci_addr,
> -			       u64 size);
> -void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -				  int type, u64 cpu_addr, u64 pci_addr,
> -				  u64 size);
> +int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> +			      u64 cpu_addr, u64 pci_addr, u64 size);
> +int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> +				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
>  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
>  			     int type, u64 cpu_addr, u8 bar);
>  void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
