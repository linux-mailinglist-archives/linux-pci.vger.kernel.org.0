Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C306D4390F5
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 10:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhJYIRr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 04:17:47 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35468 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhJYIRq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 04:17:46 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19P8F3a3096818;
        Mon, 25 Oct 2021 03:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1635149703;
        bh=K9L4/3Wdw/QxZpGZIz0b9HAWUT6W4V5Pn353Tvv9tSk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vWV/Jqy811vQyq9vzddFgzET/MbXVr7yCxOiK1emliPcHDQGi+oap9f2NXmTplXUU
         MGVE2tKHhLuKqLZaq0ohEmeNdp6vs34oKEnfR4HXC3U1/2mPGoT0qUQcLmgWtfnlzV
         wWSBl4yBekgFT5Bhuo6sHEMD5MBAPkFzbh+LMf2Y=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19P8F3Iq021202
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Oct 2021 03:15:03 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 25
 Oct 2021 03:15:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 25 Oct 2021 03:15:03 -0500
Received: from [10.250.233.112] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19P8EwCX002249;
        Mon, 25 Oct 2021 03:14:59 -0500
Subject: Re: [PATCH v15 02/13] PCI: kirin: Add support for a PHY layer
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linuxarm@huawei.com>, <mauro.chehab@huawei.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <cover.1634812676.git.mchehab+huawei@kernel.org>
 <f38361df2e9d0dc5a38ff942b631f7fef64cdc12.1634812676.git.mchehab+huawei@kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <3919b668-cf6a-ffda-0115-c2a94750e56a@ti.com>
Date:   Mon, 25 Oct 2021 13:44:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f38361df2e9d0dc5a38ff942b631f7fef64cdc12.1634812676.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mauro,

On 21/10/21 4:15 pm, Mauro Carvalho Chehab wrote:
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
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Acked-by: Xiaowei Song <songxiaowei@hisilicon.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> To mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v15 00/13] at: https://lore.kernel.org/all/cover.1634812676.git.mchehab+huawei@kernel.org/
> 
>  drivers/pci/controller/dwc/pcie-kirin.c | 95 +++++++++++++++++++++----
>  1 file changed, 80 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index b4063a3434df..91a7c096bf8f 100644
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

Where is PCIE_KIRIN_EXTERNAL_PHY used?

Thanks,
Kishon

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
> +	phy_type = (long)of_id->data;
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
> 
