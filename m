Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C41F7DF8C4
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 18:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjKBRdb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 13:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjKBRda (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 13:33:30 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D42B123
        for <linux-pci@vger.kernel.org>; Thu,  2 Nov 2023 10:33:25 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-66d1a05b816so7359336d6.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Nov 2023 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698946404; x=1699551204; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QMUtaNcyMJONDb+NRTDB5A2cdiVh8ep8ZeoczkWG0cY=;
        b=NPeQcBgNQ2/rHTtvy71BICr0d0g5wXpUc7NKdVZRGHXTpAB6hmZhVmHHu11MbIZFBv
         QCaFn0l6kax2M/T7/DS6ccYjHP2vCYgU5ig5JDV73fEsiE1sOJ3yLOCe1/SEfmLBL2Vy
         5cp5699V/T6uvQSTiHK85AUpR7luadxdhzgssniNMlBw7ZET40rluiwzFgIsyZUS2rle
         /WroydCE838FaIQgv3sORwUijXmefl8S17dCrHefUA5cxIb88chvexZHv/FK2YMuM1pl
         cLPY+Oyq8K33ZIOpIN5vy8vcF2G+ZpJLGekBssoGEfqH3Uho5egVxo7E8/ZNwHih/t2t
         TJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698946404; x=1699551204;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMUtaNcyMJONDb+NRTDB5A2cdiVh8ep8ZeoczkWG0cY=;
        b=aw6B4mUzWmAkwQgKQOiyHuK/Vrvmdu5bEja583yj+pXmY4zJykoE1wQAGzS68aL1xC
         38Jw1lnHHs5oZI4M8CNaHLvVMEgN9KrkuQnTgrl7x1ipYwseDEYG7i8X1+7WmqraJafg
         UrvDaj2w93Z6G4dZeQ0BGZtj9oeIx6q4cHT9mcXuiydBu8+bwQUcek5e1IEeWmwiYIkq
         7Ifo5J2E4yvLyORR11rR7KWuyLXbeSMT/4baEfLrdMD5PC1diHxEyHPXqYl/4rt6zBHm
         nOHS4K3kAwS+DxraxgmptYgI0p2GozBkT8/6Kr4Z9lZAGEhm6jFzZHjG9Ku3kSK8Acqp
         3uHA==
X-Gm-Message-State: AOJu0Yw67cM7GixGLt4g9LkRQ3M3DAsDh1mrkkUWHIQXkPUACbmG6jPv
        rkIQxKgQmFeXmqvKQjqAoCII
X-Google-Smtp-Source: AGHT+IHX7EI2x7veOgf/GXDdZbsRu/5EohayNZh0ZiyAzJQnH+S4mjA6yTOVfB6lGTAOudjhbyAuRQ==
X-Received: by 2002:a05:6214:529c:b0:66d:2af4:c423 with SMTP id kj28-20020a056214529c00b0066d2af4c423mr21097024qvb.2.1698946404249;
        Thu, 02 Nov 2023 10:33:24 -0700 (PDT)
Received: from thinkpad ([117.217.189.228])
        by smtp.gmail.com with ESMTPSA id p15-20020a0cc3cf000000b00670e7ae4964sm125621qvi.91.2023.11.02.10.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 10:33:23 -0700 (PDT)
Date:   Thu, 2 Nov 2023 23:03:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     bhelgaas@google.com, imx@lists.linux.dev, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lpieralisi@kernel.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        robh@kernel.org, roy.zang@nxp.com
Subject: Re: [PATCH v3 3/4] PCI: layerscape: Rename pf_* as pf_lut_*
Message-ID: <20231102173314.GE20943@thinkpad>
References: <20231017193145.3198380-1-Frank.Li@nxp.com>
 <20231017193145.3198380-4-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017193145.3198380-4-Frank.Li@nxp.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 17, 2023 at 03:31:44PM -0400, Frank Li wrote:
> 'pf' and 'lut' is just difference name in difference chips, but basic it is
> a MMIO base address plus an offset.
> 
> Rename it to avoid duplicate pf_* and lut_* in driver.
> 

"pci-layerscape-ep.c" uses "ls_lut_" prefix and now you are using "pf_lut_". May
I know the difference between these two? Can we just use a common name?

- Mani

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     change from v1 to v3
>     - new patch at v3
> 
>  drivers/pci/controller/dwc/pci-layerscape.c | 34 ++++++++++-----------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 6f47cfe146c44..4b663b20d8612 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -46,7 +46,7 @@
>  #define LS_PCIE_DRV_SCFG	BIT(0)
>  
>  struct ls_pcie_drvdata {
> -	const u32 pf_off;
> +	const u32 pf_lut_off;
>  	const struct dw_pcie_host_ops *ops;
>  	int (*exit_from_l2)(struct dw_pcie_rp *pp);
>  	int flags;
> @@ -56,13 +56,13 @@ struct ls_pcie_drvdata {
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
> @@ -103,20 +103,20 @@ static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
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
> @@ -126,11 +126,11 @@ static void ls_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
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
> @@ -149,15 +149,15 @@ static int ls_pcie_exit_from_l2(struct dw_pcie_rp *pp)
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
> @@ -245,7 +245,7 @@ static const struct ls_pcie_drvdata ls1021a_drvdata = {
>  };
>  
>  static const struct ls_pcie_drvdata layerscape_drvdata = {
> -	.pf_off = 0xc0000,
> +	.pf_lut_off = 0xc0000,
>  	.pm_support = true,
>  	.exit_from_l2 = ls_pcie_exit_from_l2,
>  };
> @@ -295,7 +295,7 @@ static int ls_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->big_endian = of_property_read_bool(dev->of_node, "big-endian");
>  
> -	pcie->pf_base = pci->dbi_base + pcie->drvdata->pf_off;
> +	pcie->pf_lut_base = pci->dbi_base + pcie->drvdata->pf_lut_off;
>  
>  	if (pcie->drvdata->flags & LS_PCIE_DRV_SCFG) {
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
