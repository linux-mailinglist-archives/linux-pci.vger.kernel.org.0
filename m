Return-Path: <linux-pci+bounces-5083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B075188A5E2
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 16:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E1F1C3A0F6
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 15:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687D0B64E;
	Mon, 25 Mar 2024 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tu9BTNJM"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCBEFC0B;
	Mon, 25 Mar 2024 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369386; cv=none; b=K5HMEuOd87sFnhR2tz5BLjXtCPLse+5SPA37bfVAsskXJ9BwgamaP8xoGyneu0vZe/cjzdC5+Mtrhlcq3N6PRCngMw+cFcRpe6gGJnqmA4luS0zQ+Slhz1AA9tdGPn5/Mj1dmUNGxL+qqzi86BdT4fM89OA/FnrHCj1IFwGrm48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369386; c=relaxed/simple;
	bh=r8UjA0tzJEdftkavNI7Se+PD9E0z9IJO38kOQGBUvsk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIFQObGQxIxy/MLrsYhUvkWAIY2rDTybD8loYwiwvVa4NiPP2zbDIzd1vM+kEbwZKv2U+sCcptVdeGvJHkyhj/oqme+EJ0yCFTr20xKQYisLRRPKB+TfhmJSsiDP1d15WZVdTF4orp6o6tL4ridH3GCxsFLRXNiZ/CPsGm57qOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tu9BTNJM; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PCMUdD063116;
	Mon, 25 Mar 2024 07:22:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711369350;
	bh=4Ss1shl6ukABRr3y/H9h4v6sz1Ou9PsnshxhpL6yX9w=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=tu9BTNJMTl9jPMM0R1Z1d+kPekK7SKeT98y4MBdavEZ9ihtf4a10jtE1rFyStO3HT
	 a5o/mjNPuNHgNWxIBI+uRtm1RequRSLVkZgCGkJOCo6BwFWnJRfv6K/TOi2dk+Dow8
	 kKFl2ROGAYHs9TjbiCKQQbkxZsj+9EUPVJ5sKXWk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PCMUIF096697
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 07:22:30 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 07:22:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 07:22:30 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PCMT8e107758;
	Mon, 25 Mar 2024 07:22:29 -0500
Date: Mon, 25 Mar 2024 17:52:28 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Niklas Cassel <cassel@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <manivannan.sadhasivam@linaro.org>, <fancer.lancer@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <dlemoal@kernel.org>,
        <yoshihiro.shimoda.uh@renesas.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH v4] PCI: keystone: Fix pci_ops for AM654x SoC
Message-ID: <ea0294d4-85d1-4784-acd7-dd247165f69b@ti.com>
References: <20240325053722.1955433-1-s-vadapalli@ti.com>
 <ZgFemQ8gHpB8yMef@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZgFemQ8gHpB8yMef@ryzen>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mon, Mar 25, 2024 at 12:23:05PM +0100, Niklas Cassel wrote:
> On Mon, Mar 25, 2024 at 11:07:22AM +0530, Siddharth Vadapalli wrote:
> > In the process of converting .scan_bus() callbacks to .add_bus(), the
> > ks_pcie_v3_65_scan_bus() function was changed to ks_pcie_v3_65_add_bus().
> > The .scan_bus() method belonged to ks_pcie_host_ops which was specific
> > to controller version 3.65a, while the .add_bus() method had been added
> > to ks_pcie_ops which is shared between the controller versions 3.65a and
> > 4.90a. Neither the older ks_pcie_v3_65_scan_bus() method, nor the newer
> > ks_pcie_v3_65_add_bus() method are applicable to the controller version
> > 4.90a which is present in AM654x SoCs.
> > 
> > Thus, as a fix, move the contents of "ks_pcie_v3_65_add_bus()" to the
> > .host_init callback "ks_pcie_host_init()" and execute it only for non
> > AM654x SoC devices which have the v3.65a DWC PCIe IP Controllers.
> > 
> > Fixes: 6ab15b5e7057 ("PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus")
> > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> > 
> > Hello,
> > 
> > This patch is based on linux-next tagged next-20240325.
> > This patch is technically the next version for the v3 patch at:
> > https://patchwork.kernel.org/project/linux-pci/patch/20231019081330.2975470-1-s-vadapalli@ti.com/
> > but the implementation is based on the RFC patch at:
> > https://patchwork.kernel.org/project/linux-pci/patch/20231027084159.4166188-1-s-vadapalli@ti.com/
> > Since the RFC patch mentioned above fixes the same issue being
> > fixed by the v3 patch, I have dropped the v3 patch and am using
> > the RFC patch since it is a cleaner implementation and was discussed at:
> > https://lore.kernel.org/r/20231019220847.GA1413474@bhelgaas/
> > 
> > Regards,
> > Siddharth.
> > 
> >  drivers/pci/controller/dwc/pci-keystone.c | 51 ++++++++---------------
> >  1 file changed, 17 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> > index 844de4418724..f45bdeac520a 100644
> > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > @@ -445,44 +445,10 @@ static struct pci_ops ks_child_pcie_ops = {
> >  	.write = pci_generic_config_write,
> >  };
> >  
> > -/**
> > - * ks_pcie_v3_65_add_bus() - keystone add_bus post initialization
> > - * @bus: A pointer to the PCI bus structure.
> > - *
> > - * This sets BAR0 to enable inbound access for MSI_IRQ register
> > - */
> > -static int ks_pcie_v3_65_add_bus(struct pci_bus *bus)
> > -{
> > -	struct dw_pcie_rp *pp = bus->sysdata;
> > -	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > -	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
> > -
> > -	if (!pci_is_root_bus(bus))
> > -		return 0;
> > -
> > -	/* Configure and set up BAR0 */
> > -	ks_pcie_set_dbi_mode(ks_pcie);
> > -
> > -	/* Enable BAR0 */
> > -	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
> > -	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
> > -
> > -	ks_pcie_clear_dbi_mode(ks_pcie);
> > -
> > -	 /*
> > -	  * For BAR0, just setting bus address for inbound writes (MSI) should
> > -	  * be sufficient.  Use physical address to avoid any conflicts.
> > -	  */
> > -	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
> > -
> > -	return 0;
> > -}
> > -
> >  static struct pci_ops ks_pcie_ops = {
> >  	.map_bus = dw_pcie_own_conf_map_bus,
> >  	.read = pci_generic_config_read,
> >  	.write = pci_generic_config_write,
> > -	.add_bus = ks_pcie_v3_65_add_bus,
> >  };
> >  
> >  /**
> > @@ -822,6 +788,23 @@ static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
> >  	if (ret < 0)
> >  		return ret;
> >
> 
> > +	if (!ks_pcie->is_am6) {
> 
> Perhaps add a comment here stating WHY this is needed for v3.65a (!is_am6).
> 
> From reading the old threads, it appears that v3.65a:
> -Has no support for iATUs. iATU-specific resource handling code is to be
>  bypassed for v3.65 h/w. Thus v3.65a has it's own .child_ops implementation,
>  so that pcie-designware-host.c does not configure the iATUs.
> -v3.65a has it's own .msi_init implementation, so that pcie-designware-host.c
>  does not call dw_pcie_msi_host_init() to configure the MSI controller.
> 
> While 4.90a:
> -Does have iATU support.
> -Does use the generic dw_pcie_msi_host_init().
> 
> Considering the major differences (with v3.65a being the outlier) here,
> I think it would have been a much wiser idea to have two different glue
> drivers for these two compatibles (ti,keystone-pcie and ti,am654-pcie-rc).
> 
> Right now the driver is quite hard to read, most of the functions in this
> driver exist because v3.65a does not have an iATU and does not use the
> generic DWC way to handle MSIs. Additionally, you have "if (!ks_pcie->is_am6)"
> spread out all over the driver, to control quite major things, like if you
> should overload .child_ops, or if you should set up inbound translation without
> an iATU. This makes is even harder to see which code is actually used for
> am654... like the fact that it actually uses the generic way to handle MSIs...
> 
> The driver for am654 would be much nicer since many of the functions in
> this driver would not be needed (and the fact that you have only implemented
> EP support for am654 and not for v3.65a). All EP related stuff would be in
> the am654 file/driver.
> You could keep the quirky stuff for v3.65a in the existing pci-keystone.c
> driver.
> 
> (I guess if there is a function that is identical between the twos, you could
> have a pci-keystone-common.{c,h}  that can be used by both drivers, but from
> the looks of it, they seem to share very little code.

Thank you for reviewing the patch. I agree that two drivers will be
better considering the !ks_pcie->is_am6 present throughout the driver.
However, I hope you notice the fact that commit:
6ab15b5e7057 PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus
introduced a regression in a driver which was working prior to that
commit for AM654. While there are flaws in the driver and it needs to be
split to handle v3.65a and other versions in a cleaner manner, I am
unable to understand why that is a precursor to fixing the regression.

If splitting the driver is the only way to fix this regression, please
let me know and I will work on that instead, though it will take up more
time.

Regards,
Siddharth.

