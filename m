Return-Path: <linux-pci+bounces-34367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E116B2D723
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 10:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A3C3A1F5E
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 08:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E262DC32C;
	Wed, 20 Aug 2025 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rGCFhcD0"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19162DA767;
	Wed, 20 Aug 2025 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755679894; cv=none; b=LnkEcbtjQbOGyrqquLuFlGIs6Ip1xK2qQFF4hYfJSZ4CFAQNwl1NOb/ZAdZzxN0b0H3mtKIcqlcnH9pFxezZDFSQV6O8uIUf6vWAYW6q2zKsdcw2Sjo17dMBb5nJH+bbKycWPmvte74QZimLAakhcdYgkFckFSTjdlWNOhSWjjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755679894; c=relaxed/simple;
	bh=0+m0eeYiGq/DCgQ/+C/jou7UuBsuTZS5NJpKBFMWDsE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9XyAIsBZsKLlcZpc/V4V88U7p+uelQI2G40E7MmDvKfYjNsp9EjyfcbVFPeyhBLL6deVgvz2/VqzCbEuCr0yjsATP6G4lrr7AjrhKwKQnpyWQCmOW3SwjpiZLjDApQxFCsl9/kIdHLLmA+y+IsceQoSQpbEXuAVKCj7WkcE6pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rGCFhcD0; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57K8pOWL3095684;
	Wed, 20 Aug 2025 03:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755679884;
	bh=BmAZ2BdFIcm0GZcUMZUZlhZiZlUyDdcvv1g9sQMU0IQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=rGCFhcD0p8VlCoczb7RcDFp3nCeZ2mm0uWWXEdGj8jVT4exFdVsB+tHA6TkTFxauT
	 /MEeXhc2InNjWeATp4GF4/iN4mVHQvvB4A4ymcXqn1E9L7jRgr9FoK7w5pItvfCkep
	 Hofj9nKtHrD1cfE4/6wqjJUj9kyO5uRTqzFMGnis=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57K8pNUX1670831
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 20 Aug 2025 03:51:23 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 20
 Aug 2025 03:51:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 20 Aug 2025 03:51:23 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57K8pMmk4155000;
	Wed, 20 Aug 2025 03:51:23 -0500
Date: Wed, 20 Aug 2025 14:21:21 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <kishon@kernel.org>, <vigneshr@ti.com>,
        <stable@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v2] PCI: j721e: Fix programming sequence of "strap"
 settings
Message-ID: <f955f547-250e-49a7-aa06-f77ebf7425e1@ti.com>
References: <20250819101336.292013-1-s-vadapalli@ti.com>
 <20250819221748.GA598958@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250819221748.GA598958@bhelgaas>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Aug 19, 2025 at 05:17:48PM -0500, Bjorn Helgaas wrote:

Hello Bjorn,

> On Tue, Aug 19, 2025 at 03:43:35PM +0530, Siddharth Vadapalli wrote:
> > The Cadence PCIe Controller integrated in the TI K3 SoCs supports both
> > Root-Complex and Endpoint modes of operation. The Glue Layer allows
> > "strapping" the mode of operation of the Controller, the Link Speed
> > and the Link Width. This is enabled by programming the "PCIEn_CTRL"
> > register (n corresponds to the PCIe instance) within the CTRL_MMR
> > memory-mapped register space.
> > 
> > In the PCIe Controller's register space, the same set of registers
> > that correspond to the Root-Port configuration space when the
> > Controller is configured for Root-Complex mode of operation, also
> > correspond to the Physical Function configuration space when the
> > Controller is configured for Endpoint mode of operation. As a result,
> > the "reset-value" of these set of registers _should_ vary depending
> > on the selected mode of operation. This is the expected behavior
> > according to the description of the registers and their reset values
> > in the Technical Reference Manual for the SoCs.
> > 
> > However, it is observed that the "reset-value" seen in practice
> > do not match the description. To be precise, when the Controller
> > is configured for Root-Complex mode of operation, the "reset-value"
> > of the Root-Port configuration space reflect the "reset-value"
> > corresponding to the Physical Function configuration space.
> > This can be attributed to the fact that the "strap" settings play
> > a role in "switching" the "reset-value" of the registers to match
> > the expected values as determined by the selected mode of operation.
> > Since the "strap" settings are sampled the moment the PCIe Controller
> > is powered ON, the "reset-value" of the registers are setup at that
> > point in time. As a result, if the "strap" settings are programmed
> > at a later point in time, it _will not_ update the "reset-value" of
> > the registers. This will cause the Physical Function configuration
> > space to be seen when the Root-Port configuration space is accessed
> > after programming the PCIe Controller for Root-Complex mode of
> > operation.
> > 
> > Fix this by powering off the PCIe Controller before programming the
> > "strap" settings and powering it on after that. This will ensure
> > that the "strap" settings that have been sampled convey the intended
> > mode of operation, thereby resulting in the "reset-value" of the
> > registers being accurate.
> 
> This is a lot of text to convey the idea that:
> 
>   - The PCIe controller powers on and latches reset values of several
>     registers
> 
>   - Later, the driver programs Glue Layer "mode", which determines
>     those reset values
> 
>   - Therefore, controller has latched the wrong values

I will rephrase the commit message and will try to limit it to a few
sentences based on your feedback.

> 
> What does this problem look like to a user? 

Adding to the following statement in the commit message:
"... This will cause the Physical Function configuration space to be
seen when the Root-Port configuration space is accessed..."
All capability registers whose reset values differ in terms of
advertising the capability for Root-Port while denying it for the
Physical Function will be affected.

Examples of capabilities that will incorrectly be deemed as unsupported
by the Root-Port are:
Link Bandwidth Notification
ARI Forwarding Support
Next Capability Offset within the Advanced Error Reporting capability:
 - Points to an offset of 0x140 in Physical Function space versus
   0x150 in Root-Port space => 0x140 is non-existent in Root-Port space
   and therefore the reset value latching on will point to a
   non-existent offset in the Root-Port mode

As a result, the user will find that the above capabilities are not enabled
by Software despite being supported by the PCIe Controller.

> 
> > Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> > 
> > Hello,
> > 
> > This patch is based on commit
> > be48bcf004f9 Merge tag 'for-6.17-rc2-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> > of Mainline Linux.
> > 
> > v1 of this patch is at:
> > https://lore.kernel.org/r/20250716102851.121742-1-s-vadapalli@ti.com/
> > Changes since v1:
> > - Rebased patch on latest Mainline Linux.
> > 
> > Regards,
> > Siddharth.
> > 
> >  drivers/pci/controller/cadence/pci-j721e.c | 82 ++++++++++++++--------
> >  1 file changed, 53 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> > index 6c93f39d0288..d5e7cb7277dc 100644
> > --- a/drivers/pci/controller/cadence/pci-j721e.c
> > +++ b/drivers/pci/controller/cadence/pci-j721e.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/of.h>
> >  #include <linux/pci.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_domain.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/regmap.h>
> >  
> > @@ -173,10 +174,9 @@ static const struct cdns_pcie_ops j721e_pcie_ops = {
> >  	.link_up = j721e_pcie_link_up,
> >  };
> >  
> > -static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon,
> > -			       unsigned int offset)
> > +static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct device *dev,
> > +			       struct regmap *syscon, unsigned int offset)
> >  {
> > -	struct device *dev = pcie->cdns_pcie->dev;
> >  	u32 mask = J721E_MODE_RC;
> >  	u32 mode = pcie->mode;
> >  	u32 val = 0;
> > @@ -193,9 +193,9 @@ static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon,
> >  }
> >  
> >  static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
> > +				     struct device *dev,
> >  				     struct regmap *syscon, unsigned int offset)
> >  {
> > -	struct device *dev = pcie->cdns_pcie->dev;
> >  	struct device_node *np = dev->of_node;
> >  	int link_speed;
> >  	u32 val = 0;
> > @@ -214,9 +214,9 @@ static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
> >  }
> >  
> >  static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
> > +				     struct device *dev,
> >  				     struct regmap *syscon, unsigned int offset)
> >  {
> > -	struct device *dev = pcie->cdns_pcie->dev;
> >  	u32 lanes = pcie->num_lanes;
> >  	u32 mask = BIT(8);
> >  	u32 val = 0;
> > @@ -234,9 +234,9 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
> >  }
> >  
> >  static int j721e_enable_acspcie_refclk(struct j721e_pcie *pcie,
> > +				       struct device *dev,
> >  				       struct regmap *syscon)
> >  {
> > -	struct device *dev = pcie->cdns_pcie->dev;
> >  	struct device_node *node = dev->of_node;
> >  	u32 mask = ACSPCIE_PAD_DISABLE_MASK;
> >  	struct of_phandle_args args;
> > @@ -263,9 +263,8 @@ static int j721e_enable_acspcie_refclk(struct j721e_pcie *pcie,
> >  	return 0;
> >  }
> >  
> > -static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
> > +static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie, struct device *dev)
> >  {
> > -	struct device *dev = pcie->cdns_pcie->dev;
> >  	struct device_node *node = dev->of_node;
> >  	struct of_phandle_args args;
> >  	unsigned int offset = 0;
> > @@ -284,19 +283,19 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
> >  	if (!ret)
> >  		offset = args.args[0];
> >  
> > -	ret = j721e_pcie_set_mode(pcie, syscon, offset);
> > +	ret = j721e_pcie_set_mode(pcie, dev, syscon, offset);
> >  	if (ret < 0) {
> >  		dev_err(dev, "Failed to set pci mode\n");
> >  		return ret;
> >  	}
> >  
> > -	ret = j721e_pcie_set_link_speed(pcie, syscon, offset);
> > +	ret = j721e_pcie_set_link_speed(pcie, dev, syscon, offset);
> >  	if (ret < 0) {
> >  		dev_err(dev, "Failed to set link speed\n");
> >  		return ret;
> >  	}
> >  
> > -	ret = j721e_pcie_set_lane_count(pcie, syscon, offset);
> > +	ret = j721e_pcie_set_lane_count(pcie, dev, syscon, offset);
> >  	if (ret < 0) {
> >  		dev_err(dev, "Failed to set num-lanes\n");
> >  		return ret;
> > @@ -308,7 +307,7 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
> >  	if (!syscon)
> >  		return 0;
> >  
> > -	return j721e_enable_acspcie_refclk(pcie, syscon);
> > +	return j721e_enable_acspcie_refclk(pcie, dev, syscon);
> >  }
> >  
> >  static int cdns_ti_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
> > @@ -469,6 +468,47 @@ static int j721e_pcie_probe(struct platform_device *pdev)
> >  	if (!pcie)
> >  		return -ENOMEM;
> >  
> > +	pcie->mode = mode;
> > +
> > +	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
> > +	if (ret || num_lanes > data->max_lanes) {
> > +		dev_warn(dev, "num-lanes property not provided or invalid, setting num-lanes to 1\n");
> > +		num_lanes = 1;
> > +	}
> > +
> > +	pcie->num_lanes = num_lanes;
> > +	pcie->max_lanes = data->max_lanes;
> > +
> > +	/*
> > +	 * The PCIe Controller's registers have different "reset-values" depending
> > +	 * on the "strap" settings programmed into the Controller's Glue Layer.
> > +	 * This is because the same set of registers are used for representing the
> > +	 * Physical Function configuration space in Endpoint mode and for
> > +	 * representing the Root-Port configuration space in Root-Complex mode.
> > +	 *
> > +	 * The registers latch onto a "reset-value" based on the "strap" settings
> > +	 * sampled after the Controller is powered on. Therefore, for the
> > +	 * "reset-value" to be accurate, it is necessary to program the "strap"
> > +	 * settings when the Controller is powered off, and power on the Controller
> > +	 * after the "strap" settings have been programmed.
> > +	 *
> > +	 * The "strap" settings are programmed by "j721e_pcie_ctrl_init()".
> > +	 * Therefore, power off the Controller before invoking "j721e_pcie_ctrl_init()",
> > +	 * program the "strap" settings, and then power on the Controller. This ensures
> > +	 * that the reset values are accurate and reflect the "strap" settings.
> 
> Wrap to fit in 80 columns like the rest of the file.  And maybe
> shorten.

Ok.

> 
> > +	dev_pm_domain_detach(dev, true);
> > +
> > +	ret = j721e_pcie_ctrl_init(pcie, dev);
> 
> This moves the "num-lanes" lookup and the call of
> j721e_pcie_ctrl_init() earlier, but I don't think that move is
> necessary.  Even before this patch, we don't actually touch anything
> in the hardware before j721e_pcie_ctrl_init().  The code between the
> new call location and the old call location is just memory allocation,
> data structure initialization, ioremap, DMA mask setting, etc.
> 
> AFAICT, the important thing is to power off the PCIe controller before
> j721e_pcie_ctrl_init() programs the mode in the glue layer, and you
> should be able to do that without moving the call location.

Thank you for pointing it out. As long as it is ensured that the 'mode'
is configured before the call to 'pci_init_capabilities()', the issue
will be prevented.

> 
> And that means you probably don't have to add the "struct device *dev"
> parameter to all those interfaces.

Ok.

> 
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = dev_pm_domain_attach(dev, true);
> 
> dev_pm_domain_detach() takes a bool, but dev_pm_domain_attach() does
> not, so this doesn't look right.

Yes, I should have used "PD_FLAG_ATTACH_POWER_ON" instead of "true".
It works coincidentally due to the manner in which the parameter is
passed to "acpi_dev_pm_attach()". I will fix this.

[...]

Regards,
Siddharth.

