Return-Path: <linux-pci+bounces-36581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7E4B8C409
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 10:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16C61B251AA
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 08:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0FC27816E;
	Sat, 20 Sep 2025 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sC4lnp28"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244FE1C700C;
	Sat, 20 Sep 2025 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758357629; cv=none; b=ABuffMasCuXUu8xDCw30NfY2CLzAl/sLWW9/XFIwJzuUJ2vODh3rQGWgmYrpGaWa0B6RHKlFOQminmWKOO3RswlzLmHqTYni5Jl2W4DtfpjCyuLI+UlTmjf3P/+pk1QOaCcajFqhSewO1+587r+49LnRcKxqx84hnLcA6v+yR8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758357629; c=relaxed/simple;
	bh=eJi10fn6F6g8qqc3lQTGmqgSP5NY4WAQLCK9VSbmhPY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9PhFXgjyBYxMeVDW4WykEbmK/fbYW9aDt4QQkz49LK6dAsdkbqWOBm/azIOeQk8B95wwrUNSb4kvmm5JauMs9O9jWGBJV2Y6UGVuvSO1+UC5tu4bF8QYEpxL2YomRFz101dbU0VMhDAMU6kSQnO8pQBIVl7aYF6xfzacXZAkgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sC4lnp28; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58K8e40F874896;
	Sat, 20 Sep 2025 03:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758357604;
	bh=f0+J3AcoY0da2JrGA4akS+0gRCutCuTWRlIKPg380lk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=sC4lnp28H4xbJoKmOxJSBRH+DwpwWi5tLv5cdxzPUEWjkdU8m/zhoo4a5Dlex7Ec7
	 czA+qMaBsbddtRtcK44ZhVV1//vvHCLaI8Gm61Cs0rDQPBV/hY7+43UP7FeuqUOWBE
	 CX375x+sDJ878GA+3u4j1/lfYT62fw8mCqyLdnzU=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58K8e4Dn2945600
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sat, 20 Sep 2025 03:40:04 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 20
 Sep 2025 03:40:04 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 20 Sep 2025 03:40:04 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58K8e3rn3874273;
	Sat, 20 Sep 2025 03:40:03 -0500
Date: Sat, 20 Sep 2025 14:10:02 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <robh@kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <christian.bruel@foss.st.com>,
        <qiang.yu@oss.qualcomm.com>, <mayank.rana@oss.qualcomm.com>,
        <thippeswamy.havalige@amd.com>, <shradha.t@samsung.com>,
        <quic_schintav@quicinc.com>, <inochiama@gmail.com>,
        <cassel@kernel.org>, <kishon@kernel.org>,
        <sergio.paracuellos@gmail.com>, <18255117159@163.com>,
        <rongqianfeng@vivo.com>, <jirislaby@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v2 10/10] PCI: keystone: Add support to build as a
 loadable module
Message-ID: <c1ae0f3e-32ec-45cb-96fb-ef45979c9e1b@ti.com>
References: <20250912122356.3326888-1-s-vadapalli@ti.com>
 <20250912122356.3326888-11-s-vadapalli@ti.com>
 <6nj2fkhxixpkneh7pdvyveu6ogpm5phbpvaw6cog3bshm5spfh@kb64rycphtft>
 <8582c87e-5f0d-4712-b93f-c7524f051fd7@ti.com>
 <5cmkdeo6he3w5a3sqk5ptwwnv6oad5tl3xoll4knved2mo4y3h@enwotijbifvb>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5cmkdeo6he3w5a3sqk5ptwwnv6oad5tl3xoll4knved2mo4y3h@enwotijbifvb>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sat, Sep 20, 2025 at 02:01:03PM +0530, Manivannan Sadhasivam wrote:
> On Sat, Sep 20, 2025 at 01:41:35PM +0530, Siddharth Vadapalli wrote:
> > On Sat, Sep 20, 2025 at 12:10:59AM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Sep 12, 2025 at 05:46:21PM +0530, Siddharth Vadapalli wrote:
> > > > The 'pci-keystone.c' driver is the application/glue/wrapper driver for the
> > > > Designware PCIe Controllers on TI SoCs. Now that all of the helper APIs
> > > > that the 'pci-keystone.c' driver depends upon have been exported for use,
> > > > enable support to build the driver as a loadable module.
> > > > 
> > > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > > ---
> > > > 
> > > > v1: https://lore.kernel.org/r/20250903124505.365913-12-s-vadapalli@ti.com/
> > > > Changes since v1:
> > > > - Based on the feedback from Manivannan Sadhasivam <mani@kernel.org> at:
> > > >   https://lore.kernel.org/r/2gzqupa7i7qhiscwm4uin2jmdb6qowp55mzk7w4o3f73ob64e7@taf5vjd7lhc5/
> > > >   builtin_platform_driver() is being retained in the driver due to which
> > > >   the change made in the v1 patch of replacing builtin_platform_driver()
> > > >   with module_platform_driver() has been discarded in this patch.
> > > > 
> > > >  drivers/pci/controller/dwc/Kconfig        |  6 +++---
> > > >  drivers/pci/controller/dwc/pci-keystone.c | 22 ++++++++++++++++++++++
> > > >  2 files changed, 25 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > > > index 34abc859c107..46012d6a607e 100644
> > > > --- a/drivers/pci/controller/dwc/Kconfig
> > > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > > @@ -482,10 +482,10 @@ config PCI_DRA7XX_EP
> > > >  	  This uses the DesignWare core.
> > > >  
> > > >  config PCI_KEYSTONE
> > > > -	bool
> > > > +	tristate
> > > >  
> > > >  config PCI_KEYSTONE_HOST
> > > > -	bool "TI Keystone PCIe controller (host mode)"
> > > > +	tristate "TI Keystone PCIe controller (host mode)"
> > > >  	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
> > > >  	depends on PCI_MSI
> > > >  	select PCIE_DW_HOST
> > > > @@ -497,7 +497,7 @@ config PCI_KEYSTONE_HOST
> > > >  	  DesignWare core functions to implement the driver.
> > > >  
> > > >  config PCI_KEYSTONE_EP
> > > > -	bool "TI Keystone PCIe controller (endpoint mode)"
> > > > +	tristate "TI Keystone PCIe controller (endpoint mode)"
> > > >  	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
> > > >  	depends on PCI_ENDPOINT
> > > >  	select PCIE_DW_EP
> > > > diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> > > > index e85942b4f6be..661e31b60a48 100644
> > > > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > > > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > > > @@ -17,6 +17,7 @@
> > > >  #include <linux/irqchip/chained_irq.h>
> > > >  #include <linux/irqdomain.h>
> > > >  #include <linux/mfd/syscon.h>
> > > > +#include <linux/module.h>
> > > >  #include <linux/msi.h>
> > > >  #include <linux/of.h>
> > > >  #include <linux/of_irq.h>
> > > > @@ -132,6 +133,7 @@ struct keystone_pcie {
> > > >  	struct			device_node *msi_intc_np;
> > > >  	struct irq_domain	*intx_irq_domain;
> > > >  	struct device_node	*np;
> > > > +	struct gpio_desc	*reset_gpio;
> > > >  
> > > >  	/* Application register space */
> > > >  	void __iomem		*va_app_base;	/* DT 1st resource */
> > > > @@ -1211,6 +1213,7 @@ static const struct of_device_id ks_pcie_of_match[] = {
> > > >  	},
> > > >  	{ },
> > > >  };
> > > > +MODULE_DEVICE_TABLE(of, ks_pcie_of_match);
> > > >  
> > > >  static int ks_pcie_probe(struct platform_device *pdev)
> > > >  {
> > > > @@ -1329,6 +1332,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
> > > >  			dev_err(dev, "Failed to get reset GPIO\n");
> > > >  		goto err_link;
> > > >  	}
> > > > +	ks_pcie->reset_gpio = gpiod;
> > > >  
> > > >  	/* Obtain references to the PHYs */
> > > >  	for (i = 0; i < num_lanes; i++)
> > > > @@ -1440,9 +1444,23 @@ static void ks_pcie_remove(struct platform_device *pdev)
> > > >  {
> > > >  	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
> > > >  	struct device_link **link = ks_pcie->link;
> > > > +	struct dw_pcie *pci = ks_pcie->pci;
> > > >  	int num_lanes = ks_pcie->num_lanes;
> > > > +	const struct ks_pcie_of_data *data;
> > > >  	struct device *dev = &pdev->dev;
> > > > +	enum dw_pcie_device_mode mode;
> > > > +
> > > > +	ks_pcie_disable_error_irq(ks_pcie);
> > > > +	data = of_device_get_match_data(dev);
> > > > +	mode = data->mode;
> > > > +	if (mode == DW_PCIE_RC_TYPE) {
> > > > +		dw_pcie_host_deinit(&pci->pp);
> > > > +	} else {
> > > > +		pci_epc_deinit_notify(pci->ep.epc);
> > > > +		dw_pcie_ep_deinit(&pci->ep);
> > > > +	}
> > > >  
> > > > +	gpiod_set_value_cansleep(ks_pcie->reset_gpio, 0);
> > > 
> > > Can ks_pcie_remove() be called for a builtin_platform_driver?
> > 
> > It cannot be executed but I have added it for the sake of completeness - in
> > the same manner that the initial implementation didn't simply make the
> > 'ks_pcie_remove()' function a no-op and the code exists as if it could
> > be executed or if it were to be executed at some point in the future.
> > 
> 
> It is a dead code, that's it. Drop it in this patch or separately before and add
> it back later when irq subsystem fixes the irq disposal issues.

I will discard the changes made to 'ks_pcie_remove()' in the v3 patch.

Regards,
Siddharth.

