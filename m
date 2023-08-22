Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32E3783C69
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 11:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbjHVJCX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 05:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbjHVJCX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 05:02:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C06F113;
        Tue, 22 Aug 2023 02:02:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8344612CB;
        Tue, 22 Aug 2023 09:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281D1C433C7;
        Tue, 22 Aug 2023 09:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692694940;
        bh=54luh6aWDj+Dj6PCgagvuO1k+5MIOroKY5M7KCBKnsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I5NWbbQmafaI/unLPzRx2CDciEoxctCBCvzlAgz2f0THOSfkd6gFdWSKEx3ZHmox6
         5g3aIfJgb3li19UAfb41tbDKfwnxVn6OD3bvIkx085TRPEm11sXWYz0q76RKDkeuWs
         86CsYc8qV+tXfj7ANzydP9E+9I0kYqVrVqgwIm+45ZCW6Cnt5H39EZvuwxgLWm1nCx
         ZOJMiLxNlYz/FdtelyeoXu5MrT3FQSTCDJ3/avpHrmhjoId5hs7Qm6vMTcAa0nC5tB
         mF3+KyKwPhMuyutmf2nDVDS2u+TcQDfdyRA8n7g7BW89aAeeeEMNcWmWUZ4z75xu68
         Tb828Ha8kERMQ==
Date:   Tue, 22 Aug 2023 11:02:11 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, helgaas@kernel.org,
        imx@lists.linux.dev, kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v12 3/3] PCI: layerscape: Add power management support
 for ls1028a
Message-ID: <ZOR5k7B3qRFEjPXR@lpieralisi>
References: <20230821184815.2167131-1-Frank.Li@nxp.com>
 <20230821184815.2167131-4-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821184815.2167131-4-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 21, 2023 at 02:48:15PM -0400, Frank Li wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Add PME_Turn_off/PME_TO_Ack handshake sequence for ls1028a platform. Call
> common dwc dw_pcie_suspend(resume)_noirq() function when system enter/exit
> suspend state.
> 
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-layerscape.c | 135 ++++++++++++++++++--
>  1 file changed, 126 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index ed5fb492fe08..97b8d3329df7 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -8,9 +8,11 @@
>   * Author: Minghuan Lian <Minghuan.Lian@freescale.com>
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/interrupt.h>
>  #include <linux/init.h>
> +#include <linux/iopoll.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
>  #include <linux/of_address.h>
> @@ -20,6 +22,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
>  
> +#include "../../pci.h"
>  #include "pcie-designware.h"
>  
>  /* PEX Internal Configuration Registers */
> @@ -27,12 +30,26 @@
>  #define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
>  #define PCIE_ABSERR_SETTING	0x9401 /* Forward error of non-posted request */
>  
> +/* PF Message Command Register */
> +#define LS_PCIE_PF_MCR		0x2c
> +#define PF_MCR_PTOMR		BIT(0)
> +#define PF_MCR_EXL2S		BIT(1)
> +
>  #define PCIE_IATU_NUM		6
>  
> +struct ls_pcie_drvdata {
> +	const u32 pf_off;
> +	bool pm_support;
> +};
> +
>  struct ls_pcie {
>  	struct dw_pcie *pci;
> +	const struct ls_pcie_drvdata *drvdata;
> +	void __iomem *pf_base;
> +	bool big_endian;
>  };
>  
> +#define ls_pcie_pf_readl_addr(addr)	ls_pcie_pf_readl(pcie, addr)
>  #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
>  
>  static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
> @@ -73,6 +90,64 @@ static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
>  	iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
>  }
>  
> +static u32 ls_pcie_pf_readl(struct ls_pcie *pcie, u32 off)
> +{
> +	if (pcie->big_endian)
> +		return ioread32be(pcie->pf_base + off);
> +
> +	return ioread32(pcie->pf_base + off);
> +}
> +
> +static void ls_pcie_pf_writel(struct ls_pcie *pcie, u32 off, u32 val)
> +{
> +	if (pcie->big_endian)
> +		iowrite32be(val, pcie->pf_base + off);
> +	else
> +		iowrite32(val, pcie->pf_base + off);
> +}
> +
> +static void ls_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct ls_pcie *pcie = to_ls_pcie(pci);
> +	u32 val;
> +	int ret;
> +
> +	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
> +	val |= PF_MCR_PTOMR;
> +	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
> +
> +	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
> +				 val, !(val & PF_MCR_PTOMR),
> +				 PCIE_PME_TO_L2_TIMEOUT_US/10,
> +				 PCIE_PME_TO_L2_TIMEOUT_US);
> +	if (ret)
> +		dev_err(pcie->pci->dev, "PME_Turn_off timeout\n");
> +}
> +
> +static void ls_pcie_exit_from_l2(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct ls_pcie *pcie = to_ls_pcie(pci);
> +	u32 val;
> +	int ret;
> +
> +	/*
> +	 * Set PF_MCR_EXL2S bit in LS_PCIE_PF_MCR register for the link
> +	 * to exit L2 state.
> +	 */
> +	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
> +	val |= PF_MCR_EXL2S;
> +	ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
> +
> +	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
> +				 val, !(val & PF_MCR_EXL2S),
> +				 1000,
> +				 10000);

I can add a comment myself - please explain how this delay was chosen,
any piece of information could be useful for a future developer, let
me know and I will add it.

> +	if (ret)
> +		dev_err(pcie->pci->dev, "L2 exit timeout\n");
> +}
> +
>  static int ls_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -91,18 +166,27 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
>  
>  static const struct dw_pcie_host_ops ls_pcie_host_ops = {
>  	.host_init = ls_pcie_host_init,
> +	.pme_turn_off = ls_pcie_send_turnoff_msg,
> +};
> +
> +static const struct ls_pcie_drvdata ls1021a_drvdata = {

I suggest adding .pm_support = false explicitly here, I can
do it myself.

Thanks,
Lorenzo

> +};
> +
> +static const struct ls_pcie_drvdata layerscape_drvdata = {
> +	.pf_off = 0xc0000,
> +	.pm_support = true,
>  };
>  
>  static const struct of_device_id ls_pcie_of_match[] = {
> -	{ .compatible = "fsl,ls1012a-pcie", },
> -	{ .compatible = "fsl,ls1021a-pcie", },
> -	{ .compatible = "fsl,ls1028a-pcie", },
> -	{ .compatible = "fsl,ls1043a-pcie", },
> -	{ .compatible = "fsl,ls1046a-pcie", },
> -	{ .compatible = "fsl,ls2080a-pcie", },
> -	{ .compatible = "fsl,ls2085a-pcie", },
> -	{ .compatible = "fsl,ls2088a-pcie", },
> -	{ .compatible = "fsl,ls1088a-pcie", },
> +	{ .compatible = "fsl,ls1012a-pcie", .data = &layerscape_drvdata },
> +	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021a_drvdata },
> +	{ .compatible = "fsl,ls1028a-pcie", .data = &layerscape_drvdata },
> +	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1021a_drvdata },
> +	{ .compatible = "fsl,ls1046a-pcie", .data = &layerscape_drvdata },
> +	{ .compatible = "fsl,ls2080a-pcie", .data = &layerscape_drvdata },
> +	{ .compatible = "fsl,ls2085a-pcie", .data = &layerscape_drvdata },
> +	{ .compatible = "fsl,ls2088a-pcie", .data = &layerscape_drvdata },
> +	{ .compatible = "fsl,ls1088a-pcie", .data = &layerscape_drvdata },
>  	{ },
>  };
>  
> @@ -121,6 +205,8 @@ static int ls_pcie_probe(struct platform_device *pdev)
>  	if (!pci)
>  		return -ENOMEM;
>  
> +	pcie->drvdata = of_device_get_match_data(dev);
> +
>  	pci->dev = dev;
>  	pci->pp.ops = &ls_pcie_host_ops;
>  
> @@ -131,6 +217,10 @@ static int ls_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(pci->dbi_base))
>  		return PTR_ERR(pci->dbi_base);
>  
> +	pcie->big_endian = of_property_read_bool(dev->of_node, "big-endian");
> +
> +	pcie->pf_base = pci->dbi_base + pcie->drvdata->pf_off;
> +
>  	if (!ls_pcie_is_bridge(pcie))
>  		return -ENODEV;
>  
> @@ -139,12 +229,39 @@ static int ls_pcie_probe(struct platform_device *pdev)
>  	return dw_pcie_host_init(&pci->pp);
>  }
>  
> +static int ls_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct ls_pcie *pcie = dev_get_drvdata(dev);
> +
> +	if (!pcie->drvdata->pm_support)
> +		return 0;
> +
> +	return dw_pcie_suspend_noirq(pcie->pci);
> +}
> +
> +static int ls_pcie_resume_noirq(struct device *dev)
> +{
> +	struct ls_pcie *pcie = dev_get_drvdata(dev);
> +
> +	if (!pcie->drvdata->pm_support)
> +		return 0;
> +
> +	ls_pcie_exit_from_l2(&pcie->pci->pp);
> +
> +	return dw_pcie_resume_noirq(pcie->pci);
> +}
> +
> +static const struct dev_pm_ops ls_pcie_pm_ops = {
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(ls_pcie_suspend_noirq, ls_pcie_resume_noirq)
> +};
> +
>  static struct platform_driver ls_pcie_driver = {
>  	.probe = ls_pcie_probe,
>  	.driver = {
>  		.name = "layerscape-pcie",
>  		.of_match_table = ls_pcie_of_match,
>  		.suppress_bind_attrs = true,
> +		.pm = &ls_pcie_pm_ops,
>  	},
>  };
>  builtin_platform_driver(ls_pcie_driver);
> -- 
> 2.34.1
> 
