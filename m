Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16553D054D
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 01:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbhGTWqH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jul 2021 18:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234499AbhGTWqD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Jul 2021 18:46:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3338E610D2;
        Tue, 20 Jul 2021 23:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626823600;
        bh=/8zNYfsDamCGJhQ1wohZAhFPeMbTvfp5/6fWraoi0qU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=U6qCzEKSTOjdHTiHe+WshSbfpyr/BZAD0T1G6dIy+oLAR2kMtYinpSuzpbFaaffEH
         PyUJ8bwC0qkQxNbjJGDQ2KQmwjYTjo8jwuHMrnODiCB5vZS7xO2G5fxj22Tbg/D/fv
         EJrVKqD75NcUDsZyBD9OgKophdSBfn0FTjEKby2b9Aadi1FMF/cFR9anz45KgMjLBr
         tjJBSCBcvR3WoC/kDSs1Nuzwy3eykpu9lI8XNvvJmEkh50sckamsH+K5cncLBm+TpO
         eAL/B0VHlfwH2fESXKOUOuUEdVNGK3uE/l/CKhTnocR8XBHNMz9TUKXsnTJPThWr/Z
         SG/OFSWdnTdYA==
Date:   Tue, 20 Jul 2021 18:26:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 2/9] PCI: kirin: add support for a PHY layer
Message-ID: <20210720232638.GA140319@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f0580412968c2b2807251e36ba32da9aa092605.1626768323.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject:

  PCI: kirin: Add support for a PHY later

(s/add/Add/)

On Tue, Jul 20, 2021 at 10:09:04AM +0200, Mauro Carvalho Chehab wrote:
> While it is too late to remove the Kirin 960 PHY, the driver
> should be able to support different PHYs used by other devices.

Commit log doesn't actually say what this patch does.

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-kirin.c | 95 +++++++++++++++++++++----
>  1 file changed, 80 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index b4063a3434df..558188476372 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -8,16 +8,18 @@
>   * Author: Xiaowei Song <songxiaowei@huawei.com>
>   */
>  
> -#include <linux/compiler.h>
>  #include <linux/clk.h>
> +#include <linux/compiler.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/gpio.h>
>  #include <linux/interrupt.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/of_address.h>
> +#include <linux/of_device.h>
>  #include <linux/of_gpio.h>
>  #include <linux/of_pci.h>
> +#include <linux/phy/phy.h>
>  #include <linux/pci.h>
>  #include <linux/pci_regs.h>
>  #include <linux/platform_device.h>
> @@ -50,11 +52,18 @@
>  #define PCIE_DEBOUNCE_PARAM	0xF0F400
>  #define PCIE_OE_BYPASS		(0x3 << 28)
>  
> +enum pcie_kirin_phy_type {
> +	PCIE_KIRIN_INTERNAL_PHY,
> +	PCIE_KIRIN_EXTERNAL_PHY
> +};
> +
>  struct kirin_pcie {
> +	enum pcie_kirin_phy_type	type;
> +
>  	struct dw_pcie	*pci;
>  	struct phy	*phy;
>  	void __iomem	*apb_base;
> -	void		*phy_priv;	/* Needed for Kirin 960 PHY */
> +	void		*phy_priv;	/* only for PCIE_KIRIN_INTERNAL_PHY */
>  };
>  
>  /*
> @@ -476,8 +485,63 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
>  	.host_init = kirin_pcie_host_init,
>  };
>  
> +static const struct of_device_id kirin_pcie_match[] = {
> +	{
> +		.compatible = "hisilicon,kirin960-pcie",
> +		.data = (void *)PCIE_KIRIN_INTERNAL_PHY
> +	},
> +	{},
> +};

Is there a benefit to moving kirin_pcie_match[] up here?  Seemed nice
to have it close to its use in kirin_pcie_driver, and would make the
diff easier to read.  But if it helps to move it, no big deal.

> +static int kirin_pcie_power_on(struct platform_device *pdev,
> +			       struct kirin_pcie *kirin_pcie)
> +{
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	if (kirin_pcie->type == PCIE_KIRIN_INTERNAL_PHY) {
> +		ret = hi3660_pcie_phy_init(pdev, kirin_pcie);
> +		if (ret)
> +			return ret;
> +
> +		return hi3660_pcie_phy_power_on(kirin_pcie);
> +	}
> +
> +	kirin_pcie->phy = devm_of_phy_get(dev, dev->of_node, NULL);
> +	if (IS_ERR(kirin_pcie->phy))
> +		return PTR_ERR(kirin_pcie->phy);
> +
> +	ret = phy_init(kirin_pcie->phy);
> +	if (ret)
> +		goto err;
> +
> +	ret = phy_power_on(kirin_pcie->phy);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +err:
> +	phy_exit(kirin_pcie->phy);
> +	return ret;
> +}
> +
> +static int __exit kirin_pcie_remove(struct platform_device *pdev)
> +{
> +	struct kirin_pcie *kirin_pcie = platform_get_drvdata(pdev);
> +
> +	if (kirin_pcie->type == PCIE_KIRIN_INTERNAL_PHY)
> +		return 0;
> +
> +	phy_power_off(kirin_pcie->phy);
> +	phy_exit(kirin_pcie->phy);
> +
> +	return 0;
> +}
> +
>  static int kirin_pcie_probe(struct platform_device *pdev)
>  {
> +	enum pcie_kirin_phy_type phy_type;
> +	const struct of_device_id *of_id;
>  	struct device *dev = &pdev->dev;
>  	struct kirin_pcie *kirin_pcie;
>  	struct dw_pcie *pci;
> @@ -488,6 +552,14 @@ static int kirin_pcie_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> +	of_id = of_match_device(kirin_pcie_match, dev);
> +	if (!of_id) {
> +		dev_err(dev, "OF data missing\n");
> +		return -EINVAL;
> +	}
> +
> +	phy_type = (enum pcie_kirin_phy_type)of_id->data;
> +
>  	kirin_pcie = devm_kzalloc(dev, sizeof(struct kirin_pcie), GFP_KERNEL);
>  	if (!kirin_pcie)
>  		return -ENOMEM;
> @@ -500,31 +572,24 @@ static int kirin_pcie_probe(struct platform_device *pdev)
>  	pci->ops = &kirin_dw_pcie_ops;
>  	pci->pp.ops = &kirin_pcie_host_ops;
>  	kirin_pcie->pci = pci;
> -
> -	ret = hi3660_pcie_phy_init(pdev, kirin_pcie);
> -	if (ret)
> -		return ret;
> +	kirin_pcie->type = phy_type;
>  
>  	ret = kirin_pcie_get_resource(kirin_pcie, pdev);
>  	if (ret)
>  		return ret;
>  
> -	ret = hi3660_pcie_phy_power_on(kirin_pcie);
> -	if (ret)
> -		return ret;
> -
>  	platform_set_drvdata(pdev, kirin_pcie);
>  
> +	ret = kirin_pcie_power_on(pdev, kirin_pcie);
> +	if (ret)
> +		return ret;
> +
>  	return dw_pcie_host_init(&pci->pp);
>  }
>  
> -static const struct of_device_id kirin_pcie_match[] = {
> -	{ .compatible = "hisilicon,kirin960-pcie" },
> -	{},
> -};
> -
>  static struct platform_driver kirin_pcie_driver = {
>  	.probe			= kirin_pcie_probe,
> +	.remove	        	= __exit_p(kirin_pcie_remove),
>  	.driver			= {
>  		.name			= "kirin-pcie",
>  		.of_match_table		= kirin_pcie_match,
> -- 
> 2.31.1
> 
