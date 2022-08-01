Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B614A586C46
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 15:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiHANwl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 09:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiHANwk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 09:52:40 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4738525E93
        for <linux-pci@vger.kernel.org>; Mon,  1 Aug 2022 06:52:39 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id iw1so10500018plb.6
        for <linux-pci@vger.kernel.org>; Mon, 01 Aug 2022 06:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zEQ8Q/gsk8zAEymrDHs72x59RZFwj5GD4FqpcpWzXHw=;
        b=Y/44UGjGPbP6YSou6YcQp2xzQdcTQ2GdNTorWqya9K+Es9UHCEMLOZ205Wp6SVfQhH
         GuqtBxh6nEKMriWTgiDrjEZckOhyUhT7enZ9BVzAujIujY7DbBw+Gj8KbN6QLApN9TjG
         VQwTtPrFG0txOqN0ZUQaTQaFtla9RGC/ZEnUy4b6snt4qbCofbKvWZjcIvfMOaeq/RqS
         KFRsJFfHEaauFZoGb1Hh9aHBNQQsxuV4Y7UHOiTZ/CVI1rrsD+2Tnu7hbLabOy2GznyM
         dycvV4M2mQjjMjYojZ/JcVJP/3ALhJJ3n4yjXpFatr7t1IYuz8mO0D1tXMFJm80geSIn
         LDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zEQ8Q/gsk8zAEymrDHs72x59RZFwj5GD4FqpcpWzXHw=;
        b=S3JY5iQhfQh3wml22fvOa1fAdosWKCDuURChqogpPgsjsPQP2OkXLwQ/3ycsH/GEY4
         hR/z35pObZB9jJGCqIGgLxW9tHZ5qLd3YqTnd15A+fEp4ioRqOA96L/FYxCjN3CBH/yW
         rPyDuZpSBe3YMORvo6fUbxV3oMC4fLfLJW1bv3H4CpU7HtBL1gonyXEYeefEIEiacL47
         d93+uwwTKftcLkqhYg1rxaGZHd/aI3cydqyyAlSWEwa+LCJCZoPgicvFWVfcFhl75dFj
         jQ2zsAeMcS6ctYh9UMYAdX4UCMsfiahVREB9vXGeFS0VXb2BlmdBzj8SuwqslxPZqMtO
         7m6Q==
X-Gm-Message-State: ACgBeo1C2yi4g8C211atHiEgo8vVGPMMdwYkPVJ81nZARj3/h0f2SRUf
        hkRWdH43cJHkRxIZ7uY1Hnu5
X-Google-Smtp-Source: AA6agR6hoOuRb/ovKoGq6fkdr9Ch8pR9YG3/Rl2ZApxLeOtVlTn60xo5xE+c0ohyRxTpGBZi2khZ+g==
X-Received: by 2002:a17:90a:560c:b0:1f2:fd0d:3761 with SMTP id r12-20020a17090a560c00b001f2fd0d3761mr18913495pjf.15.1659361958719;
        Mon, 01 Aug 2022 06:52:38 -0700 (PDT)
Received: from thinkpad ([117.217.185.73])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709027e0200b0016dbe37cebdsm9525321plm.246.2022.08.01.06.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 06:52:38 -0700 (PDT)
Date:   Mon, 1 Aug 2022 19:22:28 +0530
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
Subject: Re: [PATCH RESEND v4 12/15] PCI: dwc: Add iATU regions size
 detection procedure
Message-ID: <20220801135228.GL93763@thinkpad>
References: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
 <20220624143947.8991-13-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624143947.8991-13-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:39:44PM +0300, Serge Semin wrote:
> Depending on the DWC PCIe RC/EP/DM IP-core configuration parameters the
> controllers can be equipped not only with various number of inbound and
> outbound iATU windows, but with varied regions settings like alignment
> (which is also the minimum window size), minimum and maximum sizes. So to
> speak if internal ATU is enabled for the denoted IP-cores then the former
> settings will be defined by the CX_ATU_MIN_REGION_SIZE parameter while the
> later one will be determined by the CX_ATU_MAX_REGION_SIZE configuration
> parameter. Anyway having these parameters used in the driver will help to
> verify whether the requested inbound or outbound memory mappings can be
> fully created. Currently the driver doesn't perform any corresponding
> checking.
> 
> Note 1. The extended iATU regions have been supported since DWC PCIe
> v4.60a. There is no need in testing the upper limit register availability
> for the older cores.
> 
> Note 2. The regions alignment is determined with using the fls() method
> since the lower four bits of the ATU Limit register can be occupied with
> the Circular Buffer Increment setting, which can be initialized with
> zeros.
> 
> The (dma-)ranges verification will be added a bit later in one of the next
> commits.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 33 +++++++++++++++++---
>  drivers/pci/controller/dwc/pcie-designware.h |  2 ++
>  2 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index f2aa65d02a6c..776752891d11 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -8,9 +8,11 @@
>   * Author: Jingoo Han <jg1.han@samsung.com>
>   */
>  
> +#include <linux/bitops.h>
>  #include <linux/delay.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> +#include <linux/sizes.h>
>  #include <linux/types.h>
>  
>  #include "../../pci.h"
> @@ -525,7 +527,8 @@ static bool dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
>  static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
>  {
>  	int max_region, ob, ib;
> -	u32 val;
> +	u32 val, min, dir;
> +	u64 max;
>  
>  	if (pci->iatu_unroll_enabled) {
>  		max_region = min((int)pci->atu_size / 512, 256);
> @@ -548,8 +551,29 @@ static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
>  			break;
>  	}
>  
> -	pci->num_ib_windows = ib;
> +	if (ob) {
> +		dir = PCIE_ATU_REGION_DIR_OB;
> +	} else if (ib) {
> +		dir = PCIE_ATU_REGION_DIR_IB;
> +	} else {
> +		dev_err(pci->dev, "No iATU regions found\n");
> +		return;
> +	}
> +
> +	dw_pcie_writel_atu(pci, dir, 0, PCIE_ATU_LIMIT, 0x0);
> +	min = dw_pcie_readl_atu(pci, dir, 0, PCIE_ATU_LIMIT);
> +
> +	if (dw_pcie_ver_is_ge(pci, 460A)) {
> +		dw_pcie_writel_atu(pci, dir, 0, PCIE_ATU_UPPER_LIMIT, 0xFFFFFFFF);
> +		max = dw_pcie_readl_atu(pci, dir, 0, PCIE_ATU_UPPER_LIMIT);
> +	} else {
> +		max = 0;
> +	}
> +
>  	pci->num_ob_windows = ob;
> +	pci->num_ib_windows = ib;
> +	pci->region_align = 1 << fls(min);
> +	pci->region_limit = (max << 32) | (SZ_4G - 1);
>  }
>  
>  void dw_pcie_iatu_detect(struct dw_pcie *pci)
> @@ -582,8 +606,9 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  	dev_info(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
>  		"enabled" : "disabled");
>  
> -	dev_info(pci->dev, "Detected iATU regions: %u outbound, %u inbound\n",
> -		 pci->num_ob_windows, pci->num_ib_windows);
> +	dev_info(pci->dev, "iATU regions: %u ob, %u ib, align %uK, limit %lluG\n",
> +		 pci->num_ob_windows, pci->num_ib_windows,
> +		 pci->region_align / SZ_1K, (pci->region_limit + 1) / SZ_1G);
>  }
>  
>  void dw_pcie_setup(struct dw_pcie *pci)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index c18f0db09b31..25c86771c810 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -272,6 +272,8 @@ struct dw_pcie {
>  	size_t			atu_size;
>  	u32			num_ib_windows;
>  	u32			num_ob_windows;
> +	u32			region_align;
> +	u64			region_limit;
>  	struct dw_pcie_rp	pp;
>  	struct dw_pcie_ep	ep;
>  	const struct dw_pcie_ops *ops;
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
