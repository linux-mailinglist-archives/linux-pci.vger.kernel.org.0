Return-Path: <linux-pci+bounces-405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4D780312E
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 12:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3111C209EE
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 11:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B394224C9;
	Mon,  4 Dec 2023 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ljMUiRRg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79447BB
	for <linux-pci@vger.kernel.org>; Mon,  4 Dec 2023 03:02:35 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-58d98188dc0so2628163eaf.3
        for <linux-pci@vger.kernel.org>; Mon, 04 Dec 2023 03:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701687755; x=1702292555; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ytEXR2qK/0VcK3kLR46RxJ0mZjpWsqvBT5XoKZfshlg=;
        b=ljMUiRRgvZB31WpHNJVVnvTPz6F1LVFRbvYMkL1hhvqolNopGIYVTfECVE86kajz9n
         UplaZDIbieWLmoCBaroLqSaMH3JVpAJ7VOPsoDPybn2KCdH70yo/pWRH8OWbIAtCUxzJ
         N20TUsq9WWybNhHARJX+/E18YZCr8q2uQr/EXSJ+RcTwZS+hdMMsZgbDGKUT/zomLGOj
         zYDyyFBsbfWxf9XWMR0IKt/bIEptfp3gTUW6oiCQoPahRegBcY6ix0+AZzwGGXPG7s5f
         SBxMl9U5a+lyyOcArDVbcVS2Dofe/zCxu5P19iKyV38F4uD9RLB37Qz3nJxqqQiZQioL
         CJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701687755; x=1702292555;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytEXR2qK/0VcK3kLR46RxJ0mZjpWsqvBT5XoKZfshlg=;
        b=P2+EChKi4vb+G6+5fxmeIgAbCQWh2WuRhOLQrokKQUSygwJOCgNOf/Zc5aFsnGyJly
         sJv+sNz/qIM9va/VkMIQIot+P6DVsphEa3u/rFiRpI3h01oO5INi+Oe7fUb3T2mZqgf6
         pderIGXW0mx01+YNbj2CHupAtT+EHdWtnx1pY+ASCar+R1tXjkHrmTvMH2C5zE9QIyrB
         LA1NxKHrObsqBCyqnmoKM++slkgvCOAXFrbtHjpFASsxAFssOJn1UWKrUXUurvSuP0mn
         vcYXKksZBpuA+/km43WFGjnKgxXv4D92uxESO8a/D5z4znuXbE1NMBRdgG7VEMZ72hDg
         r6WA==
X-Gm-Message-State: AOJu0YxgNA+M1gnTFW9yILfTcLRWGhXtrujsLs0xyRLSF5SOYZXJTBKf
	LcPkoVvMoQrChrPeyRixDFHO
X-Google-Smtp-Source: AGHT+IE9Hrs5Bx4+uEPJIz+n1aZygMz0seYo1fq0qHEZlcgQ3Lsd7f4RDXxraFBiibGuRGVqDIaxmQ==
X-Received: by 2002:a05:6358:2904:b0:170:21b7:7321 with SMTP id y4-20020a056358290400b0017021b77321mr3297906rwb.20.1701687754654;
        Mon, 04 Dec 2023 03:02:34 -0800 (PST)
Received: from thinkpad ([117.213.101.240])
        by smtp.gmail.com with ESMTPSA id w2-20020a0c9c42000000b0067a4a0a7e6fsm962342qve.108.2023.12.04.03.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 03:02:34 -0800 (PST)
Date: Mon, 4 Dec 2023 16:32:24 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: bhelgaas@google.com, imx@lists.linux.dev, kw@linux.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	lpieralisi@kernel.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
	robh@kernel.org, roy.zang@nxp.com
Subject: Re: [PATCH v5 3/4] PCI: layerscape(ep): Rename pf_* as pf_lut_*
Message-ID: <20231204110224.GC35383@thinkpad>
References: <20231201161712.1645987-1-Frank.Li@nxp.com>
 <20231201161712.1645987-4-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231201161712.1645987-4-Frank.Li@nxp.com>

On Fri, Dec 01, 2023 at 11:17:11AM -0500, Frank Li wrote:
> 'pf' and 'lut' is just difference name in difference chips, but basic it is
> a MMIO base address plus an offset.
> 
> Rename it to avoid duplicate pf_* and lut_* in driver.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

One comment below. With that addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
> 
> Notes:
>     pf_lut is better than pf_* or lut* because some chip use 'pf', some chip
>     use 'lut'.
>     
>     Change from v4 to v5
>     - rename layerscape-ep code also
>     change from v1 to v4
>     - new patch at v3
> 
>  .../pci/controller/dwc/pci-layerscape-ep.c    | 16 ++++-----
>  drivers/pci/controller/dwc/pci-layerscape.c   | 36 +++++++++----------
>  2 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index 3d3c50ef4b6ff..2ca339f938a86 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -49,7 +49,7 @@ struct ls_pcie_ep {
>  	bool				big_endian;
>  };
>  
> -static u32 ls_lut_readl(struct ls_pcie_ep *pcie, u32 offset)
> +static u32 ls_pcie_pf_lut_readl(struct ls_pcie_ep *pcie, u32 offset)
>  {
>  	struct dw_pcie *pci = pcie->pci;
>  
> @@ -59,7 +59,7 @@ static u32 ls_lut_readl(struct ls_pcie_ep *pcie, u32 offset)
>  		return ioread32(pci->dbi_base + offset);
>  }
>  
> -static void ls_lut_writel(struct ls_pcie_ep *pcie, u32 offset, u32 value)
> +static void ls_pcie_pf_lut_writel(struct ls_pcie_ep *pcie, u32 offset, u32 value)
>  {
>  	struct dw_pcie *pci = pcie->pci;
>  
> @@ -76,8 +76,8 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
>  	u32 val, cfg;
>  	u8 offset;
>  
> -	val = ls_lut_readl(pcie, PEX_PF0_PME_MES_DR);
> -	ls_lut_writel(pcie, PEX_PF0_PME_MES_DR, val);
> +	val = ls_pcie_pf_lut_readl(pcie, PEX_PF0_PME_MES_DR);
> +	ls_pcie_pf_lut_writel(pcie, PEX_PF0_PME_MES_DR, val);
>  
>  	if (!val)
>  		return IRQ_NONE;
> @@ -96,9 +96,9 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
>  		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, pcie->lnkcap);
>  		dw_pcie_dbi_ro_wr_dis(pci);
>  
> -		cfg = ls_lut_readl(pcie, PEX_PF0_CONFIG);
> +		cfg = ls_pcie_pf_lut_readl(pcie, PEX_PF0_CONFIG);
>  		cfg |= PEX_PF0_CFG_READY;
> -		ls_lut_writel(pcie, PEX_PF0_CONFIG, cfg);
> +		ls_pcie_pf_lut_writel(pcie, PEX_PF0_CONFIG, cfg);
>  		dw_pcie_ep_linkup(&pci->ep);
>  
>  		dev_dbg(pci->dev, "Link up\n");
> @@ -130,10 +130,10 @@ static int ls_pcie_ep_interrupt_init(struct ls_pcie_ep *pcie,
>  	}
>  
>  	/* Enable interrupts */
> -	val = ls_lut_readl(pcie, PEX_PF0_PME_MES_IER);
> +	val = ls_pcie_pf_lut_readl(pcie, PEX_PF0_PME_MES_IER);
>  	val |=  PEX_PF0_PME_MES_IER_LDDIE | PEX_PF0_PME_MES_IER_HRDIE |
>  		PEX_PF0_PME_MES_IER_LUDIE;
> -	ls_lut_writel(pcie, PEX_PF0_PME_MES_IER, val);
> +	ls_pcie_pf_lut_writel(pcie, PEX_PF0_PME_MES_IER, val);
>  
>  	return 0;
>  }
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 8bdaae9be7d56..a9151e98fde6f 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -44,7 +44,7 @@
>  #define PCIE_IATU_NUM		6
>  
>  struct ls_pcie_drvdata {
> -	const u32 pf_off;
> +	const u32 pf_lut_off;
>  	const struct dw_pcie_host_ops *ops;
>  	int (*exit_from_l2)(struct dw_pcie_rp *pp);
>  	bool scfg_support;
> @@ -54,13 +54,13 @@ struct ls_pcie_drvdata {
>  struct ls_pcie {
>  	struct dw_pcie *pci;
>  	const struct ls_pcie_drvdata *drvdata;
> -	void __iomem *pf_base;
> +	void __iomem *pf_lut_base;
>  	struct regmap *scfg;
>  	int index;
>  	bool big_endian;
>  };
>  
> -#define ls_pcie_pf_readl_addr(addr)	ls_pcie_pf_readl(pcie, addr)
> +#define ls_pcie_pf_lut_readl_addr(addr)	ls_pcie_pf_lut_readl(pcie, addr)
>  #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
>  
>  static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
> @@ -101,20 +101,20 @@ static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
>  	iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
>  }
>  
> -static u32 ls_pcie_pf_readl(struct ls_pcie *pcie, u32 off)
> +static u32 ls_pcie_pf_lut_readl(struct ls_pcie *pcie, u32 off)
>  {
>  	if (pcie->big_endian)
> -		return ioread32be(pcie->pf_base + off);
> +		return ioread32be(pcie->pf_lut_base + off);
>  
> -	return ioread32(pcie->pf_base + off);
> +	return ioread32(pcie->pf_lut_base + off);
>  }
>  
> -static void ls_pcie_pf_writel(struct ls_pcie *pcie, u32 off, u32 val)
> +static void ls_pcie_pf_lut_writel(struct ls_pcie *pcie, u32 off, u32 val)
>  {
>  	if (pcie->big_endian)
> -		iowrite32be(val, pcie->pf_base + off);
> +		iowrite32be(val, pcie->pf_lut_base + off);
>  	else
> -		iowrite32(val, pcie->pf_base + off);
> +		iowrite32(val, pcie->pf_lut_base + off);
>  }
>  
>  static void ls_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
> @@ -124,11 +124,11 @@ static void ls_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
>  	u32 val;
>  	int ret;
>  
> -	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
> +	val = ls_pcie_pf_lut_readl(pcie, LS_PCIE_PF_MCR);
>  	val |= PF_MCR_PTOMR;
> -	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
> +	ls_pcie_pf_lut_writel(pcie, LS_PCIE_PF_MCR, val);
>  
> -	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
> +	ret = readx_poll_timeout(ls_pcie_pf_lut_readl_addr, LS_PCIE_PF_MCR,
>  				 val, !(val & PF_MCR_PTOMR),
>  				 PCIE_PME_TO_L2_TIMEOUT_US/10,
>  				 PCIE_PME_TO_L2_TIMEOUT_US);
> @@ -147,15 +147,15 @@ static int ls_pcie_exit_from_l2(struct dw_pcie_rp *pp)
>  	 * Set PF_MCR_EXL2S bit in LS_PCIE_PF_MCR register for the link
>  	 * to exit L2 state.
>  	 */
> -	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
> +	val = ls_pcie_pf_lut_readl(pcie, LS_PCIE_PF_MCR);
>  	val |= PF_MCR_EXL2S;
> -	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
> +	ls_pcie_pf_lut_writel(pcie, LS_PCIE_PF_MCR, val);
>  
>  	/*
>  	 * L2 exit timeout of 10ms is not defined in the specifications,
>  	 * it was chosen based on empirical observations.
>  	 */
> -	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
> +	ret = readx_poll_timeout(ls_pcie_pf_lut_readl_addr, LS_PCIE_PF_MCR,
>  				 val, !(val & PF_MCR_EXL2S),
>  				 1000,
>  				 10000);
> @@ -242,9 +242,9 @@ static const struct ls_pcie_drvdata ls1021a_drvdata = {
>  };
>  
>  static const struct ls_pcie_drvdata layerscape_drvdata = {
> -	.pf_off = 0xc0000,
> +	.pf_lut_off = 0xc0000,
>  	.pm_support = true,
> -	.ops = &ls_pcie_host_ops;
> +	.ops = &ls_pcie_host_ops,

This change should be part of the previous patch.

- Mani

>  	.exit_from_l2 = ls_pcie_exit_from_l2,
>  };
>  
> @@ -293,7 +293,7 @@ static int ls_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->big_endian = of_property_read_bool(dev->of_node, "big-endian");
>  
> -	pcie->pf_base = pci->dbi_base + pcie->drvdata->pf_off;
> +	pcie->pf_lut_base = pci->dbi_base + pcie->drvdata->pf_lut_off;
>  
>  	if (pcie->drvdata->scfg_support) {
>  		pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node, "fsl,pcie-scfg");
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

