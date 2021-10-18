Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B58E431402
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 12:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhJRKEr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 06:04:47 -0400
Received: from foss.arm.com ([217.140.110.172]:34824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231213AbhJRKEj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Oct 2021 06:04:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2C5AED1;
        Mon, 18 Oct 2021 03:02:28 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55BCA3F70D;
        Mon, 18 Oct 2021 03:02:27 -0700 (PDT)
Date:   Mon, 18 Oct 2021 11:02:24 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, kishon@ti.com
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Songxiaowei <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v13 02/10] PCI: kirin: Add support for a PHY layer
Message-ID: <20211018100224.GB17152@lpieralisi>
References: <cover.1634539769.git.mchehab+huawei@kernel.org>
 <a71b60d2c35ba9c2c5398380bc8ad5533e8160f1.1634539769.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a71b60d2c35ba9c2c5398380bc8ad5533e8160f1.1634539769.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+kishon]

@Kishon, please can you review from a PHY perspective ?

Thanks,
Lorenzo

On Mon, Oct 18, 2021 at 08:07:27AM +0100, Mauro Carvalho Chehab wrote:
> The pcie-kirin driver contains both PHY and generic PCI driver
> on it.
> 
> The best would be, instead, to support a PCI PHY driver, making
> the driver more generic.
> 
> However, it is too late to remove the Kirin 960 PHY, as a change
> like that would make the DT schema incompatible with past versions.
> 
> So, add support for an external PHY driver without removing the
> existing Kirin 960 PHY from it.
> 
> Acked-by: Xiaowei Song <songxiaowei@hisilicon.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> See [PATCH v13 00/10] at: https://lore.kernel.org/all/cover.1634539769.git.mchehab+huawei@kernel.org/
> 
>  drivers/pci/controller/dwc/pcie-kirin.c | 95 +++++++++++++++++++++----
>  1 file changed, 80 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index b4063a3434df..31514a5d4bb4 100644
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
> +static const struct of_device_id kirin_pcie_match[] = {
> +	{
> +		.compatible = "hisilicon,kirin960-pcie",
> +		.data = (void *)PCIE_KIRIN_INTERNAL_PHY
> +	},
> +	{},
> +};
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
