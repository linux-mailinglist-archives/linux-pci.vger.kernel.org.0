Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D6F6F9066
	for <lists+linux-pci@lfdr.de>; Sat,  6 May 2023 09:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjEFH64 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 May 2023 03:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjEFH6r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 May 2023 03:58:47 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2981FEC
        for <linux-pci@vger.kernel.org>; Sat,  6 May 2023 00:58:45 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-643b60855c8so506156b3a.2
        for <linux-pci@vger.kernel.org>; Sat, 06 May 2023 00:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683359925; x=1685951925;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9N1rc/5Fi1FR3PRXTb19F/ZGifHjTtA2q2Cae30+mlA=;
        b=NQRCz43CT3Am3q/I02DZVA0uqVsD/A7hjEDQjanb1XYTXvdhgJhATgrvGC/pEKtZ53
         czw2fdaLr3ZB76Bw6/1H9YubH2IK2ap/hVjLZcCwc/Bs75xT96EizfONWjqYhcfQUGXl
         lwraI32bJREv8kOJ2O8aNUuSAN2Npeh9AFDoCzk6Nlrl4/YOkHEEPkdab4MOEyVV13gA
         pmRSW3ebFAApIF65wN8wyLf6i/mlBP2PvkqKZPsRG6iXzCyGZPKW9aKEANwVLl3jNrBy
         J2m0/s23etfyiSjR/Cbz+ylvBLzFaJBuHXbotkrFPdknOMrr4M6Na5Hoo2hysHuhtF81
         kgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683359925; x=1685951925;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9N1rc/5Fi1FR3PRXTb19F/ZGifHjTtA2q2Cae30+mlA=;
        b=ewttp+LdbnfX8yW4IxKlQswIdh/0HktIjuCEf2/4ON6j3BX5eZClluF55E10FwVdHx
         6zDgNvVCYPwezPr0nCY8ey+2pDEhWRHv5M/BDWOg8T6NwNuaFO0tHuNOJcj1TxK05uUY
         mOHEEYC1TWviszw0vPRMclp09uIgMbTPvj0PYfHN49u8Zb2RMpg2uQ+PeyuITy0qeOvp
         9Vt3DMlFb4oH4ea60gVIgFaaqQQ/sD0KWIBzi9RikhAndPgpXq6bCahWsPZ0cGXv8tn1
         ZKSI4SCFEZkwWT/FrZgAQv86ji0us+4nH9iuPJVPbYgVfd9pydEs9qriLhTGfHM9WKYL
         yIWw==
X-Gm-Message-State: AC+VfDwRNffc2ESMcyOjSrWFm5qcU3Uz+1pR0I7Qy37oXQdr/8e9rYLq
        gYSYKM4RJLo+IaWSGzcYN29B
X-Google-Smtp-Source: ACHHUZ6s1Jzex0YPfLJUb6h3oibL3F+U2pv0j40QoSsQ4BhKF3WctKGX8jpyOyBkUm482uYZcTvusw==
X-Received: by 2002:a05:6a00:1686:b0:643:a35d:b8dc with SMTP id k6-20020a056a00168600b00643a35db8dcmr5053349pfc.28.1683359924874;
        Sat, 06 May 2023 00:58:44 -0700 (PDT)
Received: from thinkpad ([120.138.12.87])
        by smtp.gmail.com with ESMTPSA id h16-20020aa786d0000000b0063b8f33cb81sm2728451pfo.93.2023.05.06.00.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 00:58:44 -0700 (PDT)
Date:   Sat, 6 May 2023 13:28:37 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-pci@vger.kernel.org>,
        "moderated list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] PCI: layerscape: Add the endpoint linkup notifier
 support
Message-ID: <20230506075837.GA9238@thinkpad>
References: <20230501144807.1616244-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230501144807.1616244-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 01, 2023 at 10:48:06AM -0400, Frank Li wrote:
> Layerscape has PME interrupt, which can be used as linkup notifier.
> Set CFG_READY bit when linkup detected.

Where are you setting this bit?

> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - pme -> PME
> - irq -> IRQ
> - update dev_info message according to Bjorn's suggestion
> - remove '.' at error message
> 	
>  .../pci/controller/dwc/pci-layerscape-ep.c    | 104 +++++++++++++++++-
>  1 file changed, 103 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index c640db60edc6..e974fbe3b6d8 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -18,6 +18,20 @@
>  
>  #include "pcie-designware.h"
>  
> +#define PEX_PF0_CONFIG			0xC0014
> +#define PEX_PF0_CFG_READY		BIT(0)
> +
> +/* PEX PFa PCIE PME and message interrupt registers*/
> +#define PEX_PF0_PME_MES_DR		0xC0020
> +#define PEX_PF0_PME_MES_DR_LUD		BIT(7)
> +#define PEX_PF0_PME_MES_DR_LDD		BIT(9)
> +#define PEX_PF0_PME_MES_DR_HRD		BIT(10)
> +
> +#define PEX_PF0_PME_MES_IER		0xC0028
> +#define PEX_PF0_PME_MES_IER_LUDIE	BIT(7)
> +#define PEX_PF0_PME_MES_IER_LDDIE	BIT(9)
> +#define PEX_PF0_PME_MES_IER_HRDIE	BIT(10)
> +
>  #define to_ls_pcie_ep(x)	dev_get_drvdata((x)->dev)
>  
>  struct ls_pcie_ep_drvdata {
> @@ -30,8 +44,88 @@ struct ls_pcie_ep {
>  	struct dw_pcie			*pci;
>  	struct pci_epc_features		*ls_epc;
>  	const struct ls_pcie_ep_drvdata *drvdata;
> +	bool				big_endian;
> +	int				irq;
>  };
>  
> +static u32 ls_lut_readl(struct ls_pcie_ep *pcie, u32 offset)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +
> +	if (pcie->big_endian)
> +		return ioread32be(pci->dbi_base + offset);
> +	else
> +		return ioread32(pci->dbi_base + offset);
> +}
> +
> +static void ls_lut_writel(struct ls_pcie_ep *pcie, u32 offset,
> +			  u32 value)

Above function argument could be wrapped within 80 columns.

> +{
> +	struct dw_pcie *pci = pcie->pci;
> +
> +	if (pcie->big_endian)
> +		iowrite32be(value, pci->dbi_base + offset);
> +	else
> +		iowrite32(value, pci->dbi_base + offset);
> +}
> +
> +static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
> +{
> +	struct ls_pcie_ep *pcie = (struct ls_pcie_ep *)dev_id;

No need to do explicit typecase for void pointer.

> +	struct dw_pcie *pci = pcie->pci;
> +	u32 val, cfg;
> +
> +	val = ls_lut_readl(pcie, PEX_PF0_PME_MES_DR);
> +	if (!val)
> +		return IRQ_NONE;
> +
> +	if (val & PEX_PF0_PME_MES_DR_LUD) {
> +		cfg = ls_lut_readl(pcie, PEX_PF0_CONFIG);
> +		cfg |= PEX_PF0_CFG_READY;
> +		ls_lut_writel(pcie, PEX_PF0_CONFIG, cfg);
> +		dw_pcie_ep_linkup(&pci->ep);
> +
> +		dev_info(pci->dev, "Link up\n");

These messages could be demoted to dev_dbg() logs.

> +	} else if (val & PEX_PF0_PME_MES_DR_LDD) {
> +		dev_info(pci->dev, "Link down\n");
> +	} else if (val & PEX_PF0_PME_MES_DR_HRD) {
> +		dev_info(pci->dev, "Hot reset\n");
> +	}
> +
> +	ls_lut_writel(pcie, PEX_PF0_PME_MES_DR, val);

You should clear the interrupts before processing.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ls_pcie_ep_interrupt_init(struct ls_pcie_ep *pcie,
> +				     struct platform_device *pdev)
> +{
> +	u32 val;
> +	int ret;
> +
> +	pcie->irq = platform_get_irq_byname(pdev, "pme");
> +	if (pcie->irq < 0) {
> +		dev_err(&pdev->dev, "Can't get 'pme' IRQ\n");

PME

> +		return pcie->irq;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, pcie->irq,
> +			       ls_pcie_ep_event_handler, IRQF_SHARED,
> +			       pdev->name, pcie);

Again, please wrap to fit the 80 column width.

> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't register PCIe IRQ\n");
> +		return ret;
> +	}
> +
> +	/* Enable interrupts */
> +	val = ls_lut_readl(pcie, PEX_PF0_PME_MES_IER);
> +	val |=  PEX_PF0_PME_MES_IER_LDDIE | PEX_PF0_PME_MES_IER_HRDIE |
> +		PEX_PF0_PME_MES_IER_LUDIE;
> +	ls_lut_writel(pcie, PEX_PF0_PME_MES_IER, val);
> +
> +	return 0;
> +}
> +
>  static const struct pci_epc_features*
>  ls_pcie_ep_get_features(struct dw_pcie_ep *ep)
>  {
> @@ -125,6 +219,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
>  	struct ls_pcie_ep *pcie;
>  	struct pci_epc_features *ls_epc;
>  	struct resource *dbi_base;
> +	int ret;
>  
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>  	if (!pcie)
> @@ -144,6 +239,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
>  	pci->ops = pcie->drvdata->dw_pcie_ops;
>  
>  	ls_epc->bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4);
> +	ls_epc->linkup_notifier = true;
>  
>  	pcie->pci = pci;
>  	pcie->ls_epc = ls_epc;
> @@ -155,9 +251,15 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
>  
>  	pci->ep.ops = &ls_pcie_ep_ops;
>  
> +	pcie->big_endian = of_property_read_bool(dev->of_node, "big-endian");
> +
>  	platform_set_drvdata(pdev, pcie);
>  
> -	return dw_pcie_ep_init(&pci->ep);
> +	ret = dw_pcie_ep_init(&pci->ep);
> +	if (ret)
> +		return  ret;

Double space after return.

> +
> +	return  ls_pcie_ep_interrupt_init(pcie, pdev);

Double space after return.

- Mani

>  }
>  
>  static struct platform_driver ls_pcie_ep_driver = {
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
