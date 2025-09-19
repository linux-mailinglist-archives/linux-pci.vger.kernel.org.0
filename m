Return-Path: <linux-pci+bounces-36538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AD9B8AF4A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 20:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9035E5A2144
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 18:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B013258ED2;
	Fri, 19 Sep 2025 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZWyLlKb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B011E3DE5;
	Fri, 19 Sep 2025 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307270; cv=none; b=SMhrJ4IAPQVPP0QVcp4WUOqw8/UIKZyaCKCW/1flXwi19/StpKx8NJOPMVoW8FWYqEqe10V7OV8NJB357Dcq1L7PRZGWnU20e6FJmQOzTnKQ4B0zMGlYaDokUnRsmdJpchzp1AlU6lUrjweq9GRUXx/QR3ii/hsP+Xm6MN51+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307270; c=relaxed/simple;
	bh=mqexrFz3ljxCYgU9d7/KUR9s+3jMqD7nGXKxzXiThmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TR/uU5epvenIKAXCNg7OJdSNpl3wOuEKZOFPZyB8obgCZiBzlxhXmr84OMReCQbim70vBVtCTmxyvPTNGXkNKqbNxRoZF4RbJvM3ctHSTZ92BiE2deGTivcYfuxnlSTwQKjPjv7Y0wBm7zhgLlo9YhrhvlFPPGDiWR/pIzaJLN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZWyLlKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB6DC4CEF0;
	Fri, 19 Sep 2025 18:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758307270;
	bh=mqexrFz3ljxCYgU9d7/KUR9s+3jMqD7nGXKxzXiThmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZWyLlKb88A2f3+kLfctcP2/Y4BvexTSu7W9DAeLIvJ7gftHAhfhfo5LiUR3ZiALN
	 nt66Ejy9NOeXL9YiSmar23uHmkF8KNdR6opFO3tUt5vcVf63TOSTkdYCcUmXtjDn1d
	 niAgXyt8GUqGe3oly8fNZgkrUSzqSsC6R/615HHO6463Dq6h+Q0q7ch6ojuBIpfVYL
	 RpdNwmWTnhxCIaEd1NTat0zkYppGmrXYS68GSYBl6hEAzlVwHtjFj9VVTcf80vfRfd
	 MEBk0N8/64nwjojGH7F1o3HTWoYx1kXnIRaVEvZ1PvYc3bmeYmXK0N0+IkaNmQ0c7e
	 CzYyh3UzB1D5A==
Date: Sat, 20 Sep 2025 00:10:59 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, jingoohan1@gmail.com, christian.bruel@foss.st.com, 
	qiang.yu@oss.qualcomm.com, mayank.rana@oss.qualcomm.com, thippeswamy.havalige@amd.com, 
	shradha.t@samsung.com, quic_schintav@quicinc.com, inochiama@gmail.com, 
	cassel@kernel.org, kishon@kernel.org, sergio.paracuellos@gmail.com, 
	18255117159@163.com, rongqianfeng@vivo.com, jirislaby@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v2 10/10] PCI: keystone: Add support to build as a
 loadable module
Message-ID: <6nj2fkhxixpkneh7pdvyveu6ogpm5phbpvaw6cog3bshm5spfh@kb64rycphtft>
References: <20250912122356.3326888-1-s-vadapalli@ti.com>
 <20250912122356.3326888-11-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912122356.3326888-11-s-vadapalli@ti.com>

On Fri, Sep 12, 2025 at 05:46:21PM +0530, Siddharth Vadapalli wrote:
> The 'pci-keystone.c' driver is the application/glue/wrapper driver for the
> Designware PCIe Controllers on TI SoCs. Now that all of the helper APIs
> that the 'pci-keystone.c' driver depends upon have been exported for use,
> enable support to build the driver as a loadable module.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> v1: https://lore.kernel.org/r/20250903124505.365913-12-s-vadapalli@ti.com/
> Changes since v1:
> - Based on the feedback from Manivannan Sadhasivam <mani@kernel.org> at:
>   https://lore.kernel.org/r/2gzqupa7i7qhiscwm4uin2jmdb6qowp55mzk7w4o3f73ob64e7@taf5vjd7lhc5/
>   builtin_platform_driver() is being retained in the driver due to which
>   the change made in the v1 patch of replacing builtin_platform_driver()
>   with module_platform_driver() has been discarded in this patch.
> 
>  drivers/pci/controller/dwc/Kconfig        |  6 +++---
>  drivers/pci/controller/dwc/pci-keystone.c | 22 ++++++++++++++++++++++
>  2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 34abc859c107..46012d6a607e 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -482,10 +482,10 @@ config PCI_DRA7XX_EP
>  	  This uses the DesignWare core.
>  
>  config PCI_KEYSTONE
> -	bool
> +	tristate
>  
>  config PCI_KEYSTONE_HOST
> -	bool "TI Keystone PCIe controller (host mode)"
> +	tristate "TI Keystone PCIe controller (host mode)"
>  	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>  	depends on PCI_MSI
>  	select PCIE_DW_HOST
> @@ -497,7 +497,7 @@ config PCI_KEYSTONE_HOST
>  	  DesignWare core functions to implement the driver.
>  
>  config PCI_KEYSTONE_EP
> -	bool "TI Keystone PCIe controller (endpoint mode)"
> +	tristate "TI Keystone PCIe controller (endpoint mode)"
>  	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>  	depends on PCI_ENDPOINT
>  	select PCIE_DW_EP
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index e85942b4f6be..661e31b60a48 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -17,6 +17,7 @@
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/mfd/syscon.h>
> +#include <linux/module.h>
>  #include <linux/msi.h>
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
> @@ -132,6 +133,7 @@ struct keystone_pcie {
>  	struct			device_node *msi_intc_np;
>  	struct irq_domain	*intx_irq_domain;
>  	struct device_node	*np;
> +	struct gpio_desc	*reset_gpio;
>  
>  	/* Application register space */
>  	void __iomem		*va_app_base;	/* DT 1st resource */
> @@ -1211,6 +1213,7 @@ static const struct of_device_id ks_pcie_of_match[] = {
>  	},
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(of, ks_pcie_of_match);
>  
>  static int ks_pcie_probe(struct platform_device *pdev)
>  {
> @@ -1329,6 +1332,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
>  			dev_err(dev, "Failed to get reset GPIO\n");
>  		goto err_link;
>  	}
> +	ks_pcie->reset_gpio = gpiod;
>  
>  	/* Obtain references to the PHYs */
>  	for (i = 0; i < num_lanes; i++)
> @@ -1440,9 +1444,23 @@ static void ks_pcie_remove(struct platform_device *pdev)
>  {
>  	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
>  	struct device_link **link = ks_pcie->link;
> +	struct dw_pcie *pci = ks_pcie->pci;
>  	int num_lanes = ks_pcie->num_lanes;
> +	const struct ks_pcie_of_data *data;
>  	struct device *dev = &pdev->dev;
> +	enum dw_pcie_device_mode mode;
> +
> +	ks_pcie_disable_error_irq(ks_pcie);
> +	data = of_device_get_match_data(dev);
> +	mode = data->mode;
> +	if (mode == DW_PCIE_RC_TYPE) {
> +		dw_pcie_host_deinit(&pci->pp);
> +	} else {
> +		pci_epc_deinit_notify(pci->ep.epc);
> +		dw_pcie_ep_deinit(&pci->ep);
> +	}
>  
> +	gpiod_set_value_cansleep(ks_pcie->reset_gpio, 0);

Can ks_pcie_remove() be called for a builtin_platform_driver?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

