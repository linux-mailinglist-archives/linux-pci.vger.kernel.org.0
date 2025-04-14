Return-Path: <linux-pci+bounces-25788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83134A87736
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 07:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE6016E926
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 05:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D87E1A2630;
	Mon, 14 Apr 2025 05:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eONhvGqd"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEFD1A01CC;
	Mon, 14 Apr 2025 05:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744608607; cv=none; b=qzMPjiSgm+Q10Un97tiFj/F0KBXDKPxK1fGDXF4aOwu9b+Eq5kpA1fW3yhZDUzsKgU0TJJcf3YHRTxq8vON2qFB40SiMuYq75glJevHrW/BiyZ8DvbaWApyPcWVl3w2PdRDkUEYgG9pNhdFVtHyb6Y+TdeLIsBeroyZe3tggWaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744608607; c=relaxed/simple;
	bh=iZY9QAKOfXVun3HWANZNIRrBgogPcLzmhf78/TcVOjs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2tF1IUCqQsesy/XLbHk6MufGJmyP8rOSc7nHpu0C5PFM9Yysu1p/C1S5UsrU6gr3x4OmM4ckzZZDKalArgBpRjYlQhhV/QAn7rSZTEDwetryb3dtrpwtbU0AFO1k5mQH4TK6D4q0/W9yXRQJMda+9+vrvdllZ6elgSM/TVVisc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eONhvGqd; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53E5TTA72067104
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 00:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744608569;
	bh=CMYMCaqeBwu/Fe6FSF4eS3p6oexTggwtdf65Un1px78=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=eONhvGqd2L2Utz0BA5kTwrlIN/n0Ude6PCTmVodo/rUFoo0dVVAAC513ARWb4uiS8
	 O/tXc92cLgpy2K3IRYMqu5xwMdBPCuKr1M9iHIT/bYVNXKqFR7Ce61Llbka4lKm2Yt
	 0sGphcv1REgoO08u9OJWaFt1hdRrTXxtNE9CWK/4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53E5TTq8117012
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Apr 2025 00:29:29 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Apr 2025 00:29:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Apr 2025 00:29:28 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53E5TR4g113799;
	Mon, 14 Apr 2025 00:29:28 -0500
Date: Mon, 14 Apr 2025 10:59:26 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <vigneshr@ti.com>, <kishon@kernel.org>, <18255117159@163.com>,
        <cassel@kernel.org>, <wojciech.jasko-EXT@continental-corporation.com>,
        <thomas.richard@bootlin.com>, <bwawrzyn@cisco.com>,
        <linux-pci@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH v2 4/4] PCI: j721e: Add support to build as a loadable
 module
Message-ID: <7ec59716-a4e2-4727-801d-07e227dcfece@ti.com>
References: <20250330083914.529222-1-s-vadapalli@ti.com>
 <20250330083914.529222-5-s-vadapalli@ti.com>
 <zsxnx7biwogov5dw5yiafkgk6tsrtspac75bjbrca5uevweaim@ly67hwfyk7qh>
 <20250409064227.ctzznnb2shaygxhm@uda0492258>
 <6bi5gul3sqvycmkf6cwokkvownjffaf2tkonjlefo2d7cautwx@uhfexzgz3okp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6bi5gul3sqvycmkf6cwokkvownjffaf2tkonjlefo2d7cautwx@uhfexzgz3okp>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sun, Apr 13, 2025 at 07:43:05PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Apr 09, 2025 at 12:12:27PM +0530, Siddharth Vadapalli wrote:
> > On Wed, Apr 09, 2025 at 12:06:35PM +0530, Manivannan Sadhasivam wrote:
> > 
> > Hello Mani,
> > 
> > > On Sun, Mar 30, 2025 at 02:09:14PM +0530, Siddharth Vadapalli wrote:
> > > > The 'pci-j721e.c' driver is the application/glue/wrapper driver for the
> > > > Cadence PCIe Controllers on TI SoCs. Implement support for building it as a
> > > > loadable module.
> > > > 
> > > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > > ---
> > > > 
> > > > v1:
> > > > https://lore.kernel.org/r/20250307103128.3287497-5-s-vadapalli@ti.com/
> > > > Changes since v1:
> > > > - Based on feedback from Thomas at:
> > > >   https://lore.kernel.org/r/88b3ecbe-32b6-4310-afb9-da19a2d0506a@bootlin.com/
> > > >   the "check" for a non-NULL "pcie-refclk" in j721e_pcie_remove() has been
> > > >   dropped.
> > > > 
> > > > Regards,
> > > > Siddharth.
> > > > 
> > > >  drivers/pci/controller/cadence/Kconfig     |  6 ++--
> > > >  drivers/pci/controller/cadence/pci-j721e.c | 33 +++++++++++++++++++++-
> > > >  2 files changed, 35 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> > > > index 82b58096eea0..72d7d264d6c3 100644
> > > > --- a/drivers/pci/controller/cadence/Kconfig
> > > > +++ b/drivers/pci/controller/cadence/Kconfig
> > > > @@ -43,10 +43,10 @@ config PCIE_CADENCE_PLAT_EP
> > > >  	  different vendors SoCs.
> > > >  
> > > >  config PCI_J721E
> > > > -	bool
> > > > +	tristate
> > > >  
> > > >  config PCI_J721E_HOST
> > > > -	bool "TI J721E PCIe controller (host mode)"
> > > > +	tristate "TI J721E PCIe controller (host mode)"
> > > >  	depends on ARCH_K3 || COMPILE_TEST
> > > >  	depends on OF
> > > >  	select PCIE_CADENCE_HOST
> > > > @@ -57,7 +57,7 @@ config PCI_J721E_HOST
> > > >  	  core.
> > > >  
> > > >  config PCI_J721E_EP
> > > > -	bool "TI J721E PCIe controller (endpoint mode)"
> > > > +	tristate "TI J721E PCIe controller (endpoint mode)"
> > > >  	depends on ARCH_K3 || COMPILE_TEST
> > > >  	depends on OF
> > > >  	depends on PCI_ENDPOINT
> > > > diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> > > > index ef1cfdae33bb..8bffcd31729c 100644
> > > > --- a/drivers/pci/controller/cadence/pci-j721e.c
> > > > +++ b/drivers/pci/controller/cadence/pci-j721e.c
> > > > @@ -15,6 +15,7 @@
> > > >  #include <linux/irqchip/chained_irq.h>
> > > >  #include <linux/irqdomain.h>
> > > >  #include <linux/mfd/syscon.h>
> > > > +#include <linux/module.h>
> > > >  #include <linux/of.h>
> > > >  #include <linux/pci.h>
> > > >  #include <linux/platform_device.h>
> > > > @@ -27,6 +28,7 @@
> > > >  #define cdns_pcie_to_rc(p) container_of(p, struct cdns_pcie_rc, pcie)
> > > >  
> > > >  #define ENABLE_REG_SYS_2	0x108
> > > > +#define ENABLE_CLR_REG_SYS_2	0x308
> > > >  #define STATUS_REG_SYS_2	0x508
> > > >  #define STATUS_CLR_REG_SYS_2	0x708
> > > >  #define LINK_DOWN		BIT(1)
> > > > @@ -116,6 +118,15 @@ static irqreturn_t j721e_pcie_link_irq_handler(int irq, void *priv)
> > > >  	return IRQ_HANDLED;
> > > >  }
> > > >  
> > > > +static void j721e_pcie_disable_link_irq(struct j721e_pcie *pcie)
> > > > +{
> > > > +	u32 reg;
> > > > +
> > > > +	reg = j721e_pcie_intd_readl(pcie, ENABLE_CLR_REG_SYS_2);
> > > > +	reg |= pcie->linkdown_irq_regfield;
> > > > +	j721e_pcie_intd_writel(pcie, ENABLE_CLR_REG_SYS_2, reg);
> > > > +}
> > > > +
> > > >  static void j721e_pcie_config_link_irq(struct j721e_pcie *pcie)
> > > >  {
> > > >  	u32 reg;
> > > > @@ -633,9 +644,25 @@ static void j721e_pcie_remove(struct platform_device *pdev)
> > > >  	struct j721e_pcie *pcie = platform_get_drvdata(pdev);
> > > >  	struct cdns_pcie *cdns_pcie = pcie->cdns_pcie;
> > > >  	struct device *dev = &pdev->dev;
> > > > +	struct cdns_pcie_ep *ep;
> > > > +	struct cdns_pcie_rc *rc;
> > > > +
> > > > +	if (pcie->mode == PCI_MODE_RC) {
> > > > +		rc = container_of(cdns_pcie, struct cdns_pcie_rc, pcie);
> > > > +		cdns_pcie_host_disable(rc);
> > > > +	} else {
> > > > +		ep = container_of(cdns_pcie, struct cdns_pcie_ep, pcie);
> > > > +		cdns_pcie_ep_disable(ep);
> > > > +	}
> > > > +
> > > > +	if (pcie->reset_gpio) {
> > > > +		msleep(PCIE_T_PVPERL_MS);
> > > 
> > > There is no point in adding a delay before PERST# assertion.
> > 
> > True :)
> > 
> > > 
> > > > +		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
> > > 
> > > This is not PERST# assert, isn't it? Typo?
> > 
> > It is PERST# assert.
> 
> Since the reset-gpios polarity is defined as GPIO_ACTIVE_HIGH in DT (which is
> wrong unless you have an external component that changes polarity), for PERST#
> assert, you need to set 0. If you set 1, then PERST# will be signalled as
> deassert.

I realize now that I have accidentally set it to 1 when it should have
been 0. It was meant to be PERST# assert since it is the .remove callback.
The v3 patch at:
https://patchwork.kernel.org/project/linux-pci/patch/20250410104426.463453-5-s-vadapalli@ti.com/
dropped the delay which is not required for PERST# assert, but the
polarity is still incorrect. I will fix it in the v4 series.

Thank you for noticing this and pointing it out.

Regards,
Siddharth.

