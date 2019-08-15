Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAD9B8EBE5
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2019 14:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbfHOMvH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 08:51:07 -0400
Received: from foss.arm.com ([217.140.110.172]:43702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730555AbfHOMvG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Aug 2019 08:51:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B30E8344;
        Thu, 15 Aug 2019 05:51:05 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AB473F694;
        Thu, 15 Aug 2019 05:51:05 -0700 (PDT)
Date:   Thu, 15 Aug 2019 13:51:03 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        lorenzo.pieralisi@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 05/10] PCI: layerscape: Modify the way of getting
 capability with different PEX
Message-ID: <20190815125103.GH43882@e119886-lin.cambridge.arm.com>
References: <20190815083716.4715-1-xiaowei.bao@nxp.com>
 <20190815083716.4715-5-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815083716.4715-5-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 15, 2019 at 04:37:11PM +0800, Xiaowei Bao wrote:
> The different PCIe controller in one board may be have different
> capability of MSI or MSIX, so change the way of getting the MSI
> capability, make it more flexible.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-layerscape-ep.c | 28 +++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index be61d96..9404ca0 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -22,6 +22,7 @@
>  
>  struct ls_pcie_ep {
>  	struct dw_pcie		*pci;
> +	struct pci_epc_features	*ls_epc;
>  };
>  
>  #define to_ls_pcie_ep(x)	dev_get_drvdata((x)->dev)
> @@ -40,25 +41,26 @@ static const struct of_device_id ls_pcie_ep_of_match[] = {
>  	{ },
>  };
>  
> -static const struct pci_epc_features ls_pcie_epc_features = {
> -	.linkup_notifier = false,
> -	.msi_capable = true,
> -	.msix_capable = false,
> -};
> -
>  static const struct pci_epc_features*
>  ls_pcie_ep_get_features(struct dw_pcie_ep *ep)
>  {
> -	return &ls_pcie_epc_features;
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct ls_pcie_ep *pcie = to_ls_pcie_ep(pci);
> +
> +	return pcie->ls_epc;
>  }
>  
>  static void ls_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct ls_pcie_ep *pcie = to_ls_pcie_ep(pci);
>  	enum pci_barno bar;
>  
>  	for (bar = BAR_0; bar <= BAR_5; bar++)
>  		dw_pcie_ep_reset_bar(pci, bar);
> +
> +	pcie->ls_epc->msi_capable = ep->msi_cap ? true : false;
> +	pcie->ls_epc->msix_capable = ep->msix_cap ? true : false;
>  }
>  
>  static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> @@ -118,6 +120,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct dw_pcie *pci;
>  	struct ls_pcie_ep *pcie;
> +	struct pci_epc_features *ls_epc;
>  	struct resource *dbi_base;
>  	int ret;
>  
> @@ -129,6 +132,10 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
>  	if (!pci)
>  		return -ENOMEM;
>  
> +	ls_epc = devm_kzalloc(dev, sizeof(*ls_epc), GFP_KERNEL);
> +	if (!ls_epc)
> +		return -ENOMEM;
> +
>  	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
>  	pci->dbi_base = devm_pci_remap_cfg_resource(dev, dbi_base);
>  	if (IS_ERR(pci->dbi_base))
> @@ -139,6 +146,13 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
>  	pci->ops = &ls_pcie_ep_ops;
>  	pcie->pci = pci;
>  
> +	ls_epc->linkup_notifier = false,
> +	ls_epc->msi_capable = true,
> +	ls_epc->msix_capable = true,

As [msi,msix]_capable is shortly set from ls_pcie_ep_init - is there any
reason to set them here (to potentially incorrect values)?

Thanks,

Andrew Murray

> +	ls_epc->bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4),
> +
> +	pcie->ls_epc = ls_epc;
> +
>  	platform_set_drvdata(pdev, pcie);
>  
>  	ret = ls_add_pcie_ep(pcie, pdev);
> -- 
> 2.9.5
> 
