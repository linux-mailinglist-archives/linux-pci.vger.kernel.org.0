Return-Path: <linux-pci+bounces-36579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2C3B8C3E8
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 10:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 011FB7B2D1D
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 08:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA01145B16;
	Sat, 20 Sep 2025 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVMXRi7a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8237A55;
	Sat, 20 Sep 2025 08:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758357074; cv=none; b=i22gCSpmIwGEOeoJ6ptnf6I2yf+JgYNh++gj0iQmRXc/KxacS1Kb4aCIq8Ah1fPSFVxxEXZO3cRDdGWyurFofAbxWWywwwx/moA7IBUWEfkMHIn5qL3CHISl2gwrBbmWF8LcGtXQk5vCEpVNv+/5FCBvoocVPkcC7AnHRigZWVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758357074; c=relaxed/simple;
	bh=iFDEz/KYezwMp/g+SvLqizpBoo1YifpObtw2ZOqaiMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvwasZ+1VNSq/7AbUTD6kk0eW7UnM8+LkpHuije0XBPJSOBMqJtIf5cmoOYhUTsfjbYfXj31D9r4jArkHi/D5qAjdRmIHssrLiKjw5yyLnNBl94kZUcEFM0nBhKUASpOszuswS098tBIgIQ/e5nZ0HN7GzjrjM7jxHws8I/ZODI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVMXRi7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB10C4CEEB;
	Sat, 20 Sep 2025 08:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758357074;
	bh=iFDEz/KYezwMp/g+SvLqizpBoo1YifpObtw2ZOqaiMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fVMXRi7a/LXkn5JmAaFdEnk7GZHH0VE2cmF/oRCCRCcgTjj34nviMSWVsc1UnzVzz
	 +JvtVLgpFcAtMkA2HPZ5Q2Ru8JEsWdGbbHLqykPX5dNIqKxT8OTx9Pju8T5epWP8Qh
	 fzuPGkpFdMO1FtczrdqI3O84SyM9wktJf6dMxhLaek3O9DyOxbBf743SMsTTz5b+2H
	 p0dk9yPV5B58VZg20ptdt/9UngYSNSAOmjrQvN4D822S6H/zIAn4f4HCTpE29CVEg1
	 Ifap3+Osb+Vx+arqxcSUZBzPILJVoIi8u7AnAs76QZW8x/FeH2iHtXrm4SyCkPrLtL
	 9PPx6VtDAa2Ug==
Date: Sat, 20 Sep 2025 14:01:03 +0530
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
Message-ID: <5cmkdeo6he3w5a3sqk5ptwwnv6oad5tl3xoll4knved2mo4y3h@enwotijbifvb>
References: <20250912122356.3326888-1-s-vadapalli@ti.com>
 <20250912122356.3326888-11-s-vadapalli@ti.com>
 <6nj2fkhxixpkneh7pdvyveu6ogpm5phbpvaw6cog3bshm5spfh@kb64rycphtft>
 <8582c87e-5f0d-4712-b93f-c7524f051fd7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8582c87e-5f0d-4712-b93f-c7524f051fd7@ti.com>

On Sat, Sep 20, 2025 at 01:41:35PM +0530, Siddharth Vadapalli wrote:
> On Sat, Sep 20, 2025 at 12:10:59AM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Sep 12, 2025 at 05:46:21PM +0530, Siddharth Vadapalli wrote:
> > > The 'pci-keystone.c' driver is the application/glue/wrapper driver for the
> > > Designware PCIe Controllers on TI SoCs. Now that all of the helper APIs
> > > that the 'pci-keystone.c' driver depends upon have been exported for use,
> > > enable support to build the driver as a loadable module.
> > > 
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > ---
> > > 
> > > v1: https://lore.kernel.org/r/20250903124505.365913-12-s-vadapalli@ti.com/
> > > Changes since v1:
> > > - Based on the feedback from Manivannan Sadhasivam <mani@kernel.org> at:
> > >   https://lore.kernel.org/r/2gzqupa7i7qhiscwm4uin2jmdb6qowp55mzk7w4o3f73ob64e7@taf5vjd7lhc5/
> > >   builtin_platform_driver() is being retained in the driver due to which
> > >   the change made in the v1 patch of replacing builtin_platform_driver()
> > >   with module_platform_driver() has been discarded in this patch.
> > > 
> > >  drivers/pci/controller/dwc/Kconfig        |  6 +++---
> > >  drivers/pci/controller/dwc/pci-keystone.c | 22 ++++++++++++++++++++++
> > >  2 files changed, 25 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > > index 34abc859c107..46012d6a607e 100644
> > > --- a/drivers/pci/controller/dwc/Kconfig
> > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > @@ -482,10 +482,10 @@ config PCI_DRA7XX_EP
> > >  	  This uses the DesignWare core.
> > >  
> > >  config PCI_KEYSTONE
> > > -	bool
> > > +	tristate
> > >  
> > >  config PCI_KEYSTONE_HOST
> > > -	bool "TI Keystone PCIe controller (host mode)"
> > > +	tristate "TI Keystone PCIe controller (host mode)"
> > >  	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
> > >  	depends on PCI_MSI
> > >  	select PCIE_DW_HOST
> > > @@ -497,7 +497,7 @@ config PCI_KEYSTONE_HOST
> > >  	  DesignWare core functions to implement the driver.
> > >  
> > >  config PCI_KEYSTONE_EP
> > > -	bool "TI Keystone PCIe controller (endpoint mode)"
> > > +	tristate "TI Keystone PCIe controller (endpoint mode)"
> > >  	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
> > >  	depends on PCI_ENDPOINT
> > >  	select PCIE_DW_EP
> > > diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> > > index e85942b4f6be..661e31b60a48 100644
> > > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/irqchip/chained_irq.h>
> > >  #include <linux/irqdomain.h>
> > >  #include <linux/mfd/syscon.h>
> > > +#include <linux/module.h>
> > >  #include <linux/msi.h>
> > >  #include <linux/of.h>
> > >  #include <linux/of_irq.h>
> > > @@ -132,6 +133,7 @@ struct keystone_pcie {
> > >  	struct			device_node *msi_intc_np;
> > >  	struct irq_domain	*intx_irq_domain;
> > >  	struct device_node	*np;
> > > +	struct gpio_desc	*reset_gpio;
> > >  
> > >  	/* Application register space */
> > >  	void __iomem		*va_app_base;	/* DT 1st resource */
> > > @@ -1211,6 +1213,7 @@ static const struct of_device_id ks_pcie_of_match[] = {
> > >  	},
> > >  	{ },
> > >  };
> > > +MODULE_DEVICE_TABLE(of, ks_pcie_of_match);
> > >  
> > >  static int ks_pcie_probe(struct platform_device *pdev)
> > >  {
> > > @@ -1329,6 +1332,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
> > >  			dev_err(dev, "Failed to get reset GPIO\n");
> > >  		goto err_link;
> > >  	}
> > > +	ks_pcie->reset_gpio = gpiod;
> > >  
> > >  	/* Obtain references to the PHYs */
> > >  	for (i = 0; i < num_lanes; i++)
> > > @@ -1440,9 +1444,23 @@ static void ks_pcie_remove(struct platform_device *pdev)
> > >  {
> > >  	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
> > >  	struct device_link **link = ks_pcie->link;
> > > +	struct dw_pcie *pci = ks_pcie->pci;
> > >  	int num_lanes = ks_pcie->num_lanes;
> > > +	const struct ks_pcie_of_data *data;
> > >  	struct device *dev = &pdev->dev;
> > > +	enum dw_pcie_device_mode mode;
> > > +
> > > +	ks_pcie_disable_error_irq(ks_pcie);
> > > +	data = of_device_get_match_data(dev);
> > > +	mode = data->mode;
> > > +	if (mode == DW_PCIE_RC_TYPE) {
> > > +		dw_pcie_host_deinit(&pci->pp);
> > > +	} else {
> > > +		pci_epc_deinit_notify(pci->ep.epc);
> > > +		dw_pcie_ep_deinit(&pci->ep);
> > > +	}
> > >  
> > > +	gpiod_set_value_cansleep(ks_pcie->reset_gpio, 0);
> > 
> > Can ks_pcie_remove() be called for a builtin_platform_driver?
> 
> It cannot be executed but I have added it for the sake of completeness - in
> the same manner that the initial implementation didn't simply make the
> 'ks_pcie_remove()' function a no-op and the code exists as if it could
> be executed or if it were to be executed at some point in the future.
> 

It is a dead code, that's it. Drop it in this patch or separately before and add
it back later when irq subsystem fixes the irq disposal issues.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

