Return-Path: <linux-pci+bounces-35921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E996B539E7
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 19:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97915A7BB1
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 17:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19EC36206A;
	Thu, 11 Sep 2025 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWg5mlZu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C248B329F05;
	Thu, 11 Sep 2025 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610215; cv=none; b=EvyVilcmbSMf+Zx6/yCFQMOTkGLdhzXNBH7V4CMeNNzgmQmmNfoIYvxSfmHMrCjsZcy2GngBkdTkLCCxasuJZMGS5ml76g3q6dP1/Ies4BAGcOEHoiqSw6rAPaCgqQJ+W3H+o5qOR+A5Z8TI9W18MtbEmuFYbIUa8F4Foi+rYQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610215; c=relaxed/simple;
	bh=TTvuVinawS9W8wQljk6tvfI7GWfVRErAFH+QsdIVE4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gdfq/sRKRSCJDhC7f/nGiEIeo/1HTPh4FPrlXcW//3o5IL+ggg/qvlHjYZ8uuqL6jZG4P3DWtqEQiLbB3BeC1wtlsbqJHIlf/94GmuoZY4fG4VJuLucrdg79VjI4XvIQRmGmgzkhRIw5vns3+FVsX18YVrKSkSgQ91wJQbFOwBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWg5mlZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F3EC4CEF0;
	Thu, 11 Sep 2025 17:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757610215;
	bh=TTvuVinawS9W8wQljk6tvfI7GWfVRErAFH+QsdIVE4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AWg5mlZueWphEPcsiD+kwmQxEI7Ezhsu6WDl4OW4KDkE1U3zFeH6Z27HNNML2NBgf
	 W+Fdlt9dr/92zKgGTbhtEgey1Ry2xc34L3adAFvpv4vwuvQGgVM2Y9VJPYS0YEY56u
	 PRgrmuDiufwz1wRyljITASUEfC4U5GZw4SRSuPbdzccLzxtopNeG2zypDoIv09hZaF
	 2qD/a2ZZjAQfQvKMGYLULtB93dUrA+VJSxFkYjfiGkScgAPQIdltwA1x5gB9nfI8+H
	 5yEbE+FZQAwy1LRGOYPGbN4KWYm+G8fp1LB67rmi8d5uzNm+nxK+UL0bSUIGGlY7Cu
	 8ARBZdCU/Kjvw==
Date: Thu, 11 Sep 2025 22:33:18 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicornxw@gmail.com>, kwilczynski@kernel.org, 
	u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, alex@ghiti.fr, arnd@arndb.de, 
	bwawrzyn@cisco.com, bhelgaas@google.com, unicorn_wang@outlook.com, 
	conor+dt@kernel.org, 18255117159@163.com, kishon@kernel.org, krzk+dt@kernel.org, 
	lpieralisi@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org, 
	s-vadapalli@ti.com, tglx@linutronix.de, thomas.richard@bootlin.com, 
	sycamoremoon376@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, sophgo@lists.linux.dev, 
	rabenda.cn@gmail.com, chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, 
	fengchun.li@sophgo.com
Subject: Re: [PATCH v2 3/7] PCI: sg2042: Add Sophgo SG2042 PCIe driver
Message-ID: <rarvqtex3vsve3sscaky3rw727hwp5avmxve3lluwoviqbt6m6@h3nlqbi2s3fd>
References: <cover.1757467895.git.unicorn_wang@outlook.com>
 <162d064228261ccd0bf9313a20288e510912effd.1757467895.git.unicorn_wang@outlook.com>
 <xmk5uvnw7mcizxpaoarvx2c2sejaz2skaiyyac7oo5y6loyjgp@5v3sldwbqpw5>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmk5uvnw7mcizxpaoarvx2c2sejaz2skaiyyac7oo5y6loyjgp@5v3sldwbqpw5>

On Wed, Sep 10, 2025 at 10:56:23AM GMT, Inochi Amaoto wrote:
> On Wed, Sep 10, 2025 at 10:08:39AM +0800, Chen Wang wrote:
> > From: Chen Wang <unicorn_wang@outlook.com>
> > 
> > Add support for PCIe controller in SG2042 SoC. The controller
> > uses the Cadence PCIe core programmed by pcie-cadence*.c. The
> > PCIe controller will work in host mode only, supporting data
> > rate(gen4) and lanes(x16 or x8).
> > 
> > Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> > ---
> >  drivers/pci/controller/cadence/Kconfig       |  10 ++
> >  drivers/pci/controller/cadence/Makefile      |   1 +
> >  drivers/pci/controller/cadence/pcie-sg2042.c | 104 +++++++++++++++++++
> >  3 files changed, 115 insertions(+)
> >  create mode 100644 drivers/pci/controller/cadence/pcie-sg2042.c
> > 
> > diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> > index 666e16b6367f..02a639e55fd8 100644
> > --- a/drivers/pci/controller/cadence/Kconfig
> > +++ b/drivers/pci/controller/cadence/Kconfig
> > @@ -42,6 +42,15 @@ config PCIE_CADENCE_PLAT_EP
> >  	  endpoint mode. This PCIe controller may be embedded into many
> >  	  different vendors SoCs.
> >  
> > +config PCIE_SG2042_HOST
> > +	tristate "Sophgo SG2042 PCIe controller (host mode)"
> > +	depends on OF && (ARCH_SOPHGO || COMPILE_TEST)
> > +	select PCIE_CADENCE_HOST
> > +	help
> > +	  Say Y here if you want to support the Sophgo SG2042 PCIe platform
> > +	  controller in host mode. Sophgo SG2042 PCIe controller uses Cadence
> > +	  PCIe core.
> > +
> >  config PCI_J721E
> >  	tristate
> >  	select PCIE_CADENCE_HOST if PCI_J721E_HOST != n
> > @@ -67,4 +76,5 @@ config PCI_J721E_EP
> >  	  Say Y here if you want to support the TI J721E PCIe platform
> >  	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
> >  	  core.
> > +
> >  endmenu
> > diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
> > index 9bac5fb2f13d..5e23f8539ecc 100644
> > --- a/drivers/pci/controller/cadence/Makefile
> > +++ b/drivers/pci/controller/cadence/Makefile
> > @@ -4,3 +4,4 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
> >  obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
> >  obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
> >  obj-$(CONFIG_PCI_J721E) += pci-j721e.o
> > +obj-$(CONFIG_PCIE_SG2042_HOST) += pcie-sg2042.o
> > diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c b/drivers/pci/controller/cadence/pcie-sg2042.c
> > new file mode 100644
> > index 000000000000..c026e1ca5d6e
> > --- /dev/null
> > +++ b/drivers/pci/controller/cadence/pcie-sg2042.c
> > @@ -0,0 +1,104 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * pcie-sg2042 - PCIe controller driver for Sophgo SG2042 SoC
> > + *
> > + * Copyright (C) 2025 Sophgo Technology Inc.
> > + * Copyright (C) 2025 Chen Wang <unicorn_wang@outlook.com>
> > + */
> > +
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/pci.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +
> > +#include "pcie-cadence.h"
> > +
> > +/*
> > + * SG2042 only supports 4-byte aligned access, so for the rootbus (i.e. to
> > + * read/write the Root Port itself, read32/write32 is required. For
> > + * non-rootbus (i.e. to read/write the PCIe peripheral registers, supports
> > + * 1/2/4 byte aligned access, so directly using read/write should be fine.
> > + */
> > +
> > +static struct pci_ops sg2042_pcie_root_ops = {
> > +	.map_bus	= cdns_pci_map_bus,
> > +	.read		= pci_generic_config_read32,
> > +	.write		= pci_generic_config_write32,
> > +};
> > +
> > +static struct pci_ops sg2042_pcie_child_ops = {
> > +	.map_bus	= cdns_pci_map_bus,
> > +	.read		= pci_generic_config_read,
> > +	.write		= pci_generic_config_write,
> > +};
> > +
> > +static int sg2042_pcie_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct pci_host_bridge *bridge;
> > +	struct cdns_pcie *pcie;
> > +	struct cdns_pcie_rc *rc;
> > +	int ret;
> > +
> > +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
> > +	if (!bridge) {
> > +		dev_err_probe(dev, -ENOMEM, "Failed to alloc host bridge!\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	bridge->ops = &sg2042_pcie_root_ops;
> > +	bridge->child_ops = &sg2042_pcie_child_ops;
> > +
> > +	rc = pci_host_bridge_priv(bridge);
> > +	pcie = &rc->pcie;
> > +	pcie->dev = dev;
> > +
> > +	platform_set_drvdata(pdev, pcie);
> > +
> > +	pm_runtime_set_active(dev);
> > +	pm_runtime_no_callbacks(dev);
> > +	devm_pm_runtime_enable(dev);
> > +
> > +	ret = cdns_pcie_init_phy(dev, pcie);
> > +	if (ret) {
> > +		dev_err_probe(dev, ret, "Failed to init phy!\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = cdns_pcie_host_setup(rc);
> > +	if (ret) {
> > +		dev_err_probe(dev, ret, "Failed to setup host!\n");
> > +		cdns_pcie_disable_phy(pcie);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> 
> > +static void sg2042_pcie_remove(struct platform_device *pdev)
> > +{
> > +	struct cdns_pcie *pcie = platform_get_drvdata(pdev);
> > +
> > +	cdns_pcie_disable_phy(pcie);
> > +}
> > +
> 
> I think this remove is useless, as it is almost impossible to
> remove a pcie at runtime.
> 

Why impossible? We only have concerns with removing PCIe controllers
implementing irqchip, but this driver is not implementing it and using an
external irqchip controller.

So it is safe and possible to remove this driver during runtime.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

