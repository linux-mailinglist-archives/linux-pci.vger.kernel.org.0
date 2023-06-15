Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB767311DF
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jun 2023 10:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243988AbjFOIPW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jun 2023 04:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243790AbjFOIPS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2023 04:15:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949CD269A;
        Thu, 15 Jun 2023 01:15:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31A4960A05;
        Thu, 15 Jun 2023 08:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60323C433C0;
        Thu, 15 Jun 2023 08:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686816910;
        bh=WeovI7rajZxovg2FExZZodivoJQZzw867iDK5ovAvt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JSO64BdU/2Fgb8NcsA73faA0Nc3XcsbUpRbaf0zhR8VlmwyaRycq4sYtb4vY7Myl6
         LKiw02rbIvxObLXBe5MZngfvCiwzrDCDCuKbXjXBG/6n+9PV4XiX1VlvJfJhqYRpom
         XdDFj3KAfx8tHf0DtVsYB9EoopfnBPkyjpUzZFao3ZnQ6RZOTGOCNlV3RYISj6FAHG
         XnHKh3NJZXKgkTBA6pl+tJJBVhgDqQCDuyfz+6154YUQz4i1OuDTcXLffa3NLS3mLh
         1wXWmPn+StnAklSpuB0mh0sCGkD8xsCeb5wrqo0KoSgp7dllezfw69HyfLr8olH6oq
         0uzOD0jOmMnlQ==
Date:   Thu, 15 Jun 2023 10:15:04 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     manivannan.sadhasivam@linaro.org,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
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
Subject: Re: [PATCH v4 1/1] PCI: layerscape: Add the endpoint linkup notifier
 support
Message-ID: <ZIrIiPLsXAPGlJqX@lpieralisi>
References: <20230515151049.2797105-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515151049.2797105-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 15, 2023 at 11:10:49AM -0400, Frank Li wrote:
> Layerscape has PME interrupt, which can be used as linkup notifier.
> Set CFG_READY bit of PEX_PF0_CONFIG to enable accesses from root complex
> when linkup detected.
> 
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v3 to v4
>  - swap irq and big_endian
> Change from v2 to v3
>  - align 80 column
>  - clear irq firstly
>  - dev_info to dev_dbg
>  - remove double space
>  - update commit message
> 
> Change from v1 to v2
> - pme -> PME
> - irq -> IRQ
> - update dev_info message according to Bjorn's suggestion
> 
>  .../pci/controller/dwc/pci-layerscape-ep.c    | 102 +++++++++++++++++-
>  1 file changed, 101 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index c640db60edc6..5398641b6b7e 100644
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
> @@ -30,8 +44,86 @@ struct ls_pcie_ep {
>  	struct dw_pcie			*pci;
>  	struct pci_epc_features		*ls_epc;
>  	const struct ls_pcie_ep_drvdata *drvdata;
> +	int				irq;
> +	bool				big_endian;
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
> +static void ls_lut_writel(struct ls_pcie_ep *pcie, u32 offset, u32 value)
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
> +	struct ls_pcie_ep *pcie = dev_id;
> +	struct dw_pcie *pci = pcie->pci;
> +	u32 val, cfg;
> +
> +	val = ls_lut_readl(pcie, PEX_PF0_PME_MES_DR);
> +	ls_lut_writel(pcie, PEX_PF0_PME_MES_DR, val);
> +
> +	if (!val)
> +		return IRQ_NONE;
> +
> +	if (val & PEX_PF0_PME_MES_DR_LUD) {
> +		cfg = ls_lut_readl(pcie, PEX_PF0_CONFIG);
> +		cfg |= PEX_PF0_CFG_READY;
> +		ls_lut_writel(pcie, PEX_PF0_CONFIG, cfg);
> +		dw_pcie_ep_linkup(&pci->ep);
> +
> +		dev_dbg(pci->dev, "Link up\n");
> +	} else if (val & PEX_PF0_PME_MES_DR_LDD) {
> +		dev_dbg(pci->dev, "Link down\n");
> +	} else if (val & PEX_PF0_PME_MES_DR_HRD) {
> +		dev_dbg(pci->dev, "Hot reset\n");
> +	}
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

I will remove this log, platform_get_irq_byname() already logs an
error.

Lorenzo

> +		return pcie->irq;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, pcie->irq, ls_pcie_ep_event_handler,
> +			       IRQF_SHARED, pdev->name, pcie);
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
> @@ -125,6 +217,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
>  	struct ls_pcie_ep *pcie;
>  	struct pci_epc_features *ls_epc;
>  	struct resource *dbi_base;
> +	int ret;
>  
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>  	if (!pcie)
> @@ -144,6 +237,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
>  	pci->ops = pcie->drvdata->dw_pcie_ops;
>  
>  	ls_epc->bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4);
> +	ls_epc->linkup_notifier = true;
>  
>  	pcie->pci = pci;
>  	pcie->ls_epc = ls_epc;
> @@ -155,9 +249,15 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
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
> +		return ret;
> +
> +	return ls_pcie_ep_interrupt_init(pcie, pdev);
>  }
>  
>  static struct platform_driver ls_pcie_ep_driver = {
> -- 
> 2.34.1
> 
