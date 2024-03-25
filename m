Return-Path: <linux-pci+bounces-5082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3DF88A53A
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 15:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1111F3E903
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 14:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFA115AD99;
	Mon, 25 Mar 2024 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDNf9urn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBF31BD5E2;
	Mon, 25 Mar 2024 11:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365792; cv=none; b=VgWFBWLsvyUhS+USFd2SK9NRfemmfPjzPxJs6if/GZmhEqRRNHZ1+SskuMbTIvDnEsMP++fsgMDBVrVMBm5vv7po9Q4LOwC2ADJcbuUfz6ZHscB4ClO82xTz0KVeZTU2NGeNIxA1bTx4HWgAaP4jpMyw8VDVoMOKFbApakDPFTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365792; c=relaxed/simple;
	bh=2JNQFjYNPVPxTSXEdzTDIvFBar8n4Vzc6fueech50RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5UTA1JEmVkGNAM+d6D3ogjuKzn5STfDfQQNp6hpz0s3aDqRzKBtn7FirI1JtU4Vuq/eCRiMwW0/5tcYfJ7mL9dthypk7G775l5N2/hxueK2mvYiggIdYHu4KkxE7ZfwdBb6+8Gcu+mVM0VPdW1yvCXMerR26/ZxWtdmdchWNNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDNf9urn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB56C433C7;
	Mon, 25 Mar 2024 11:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711365791;
	bh=2JNQFjYNPVPxTSXEdzTDIvFBar8n4Vzc6fueech50RA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mDNf9urnayjKnHME8f7+8KbiM5Q2KPrJtZDZzFOPhQsHFconJCwKstiSJCvgwadwC
	 MINur/NnfllB+oDF+sCjN/u3CNIjLjVDzl/aW+ueVg2W/WK8UL3wPl5AWdAl0tQomr
	 J4imBrauiuRu5m8BOOhaU5iq2E3qJDoSDVkppHFGuR8AipmRNJk4GROu+uu787G9th
	 dgb8o3wPGdeJYGlDj6e48rdkSpV+lTI8bYQEC6juJOpSN0JhS10nmH0V7jt3A76gAc
	 MW4b+DFWBFD1fI9WWaUon4THyRXmzR4ygTJf6ZHqihRetNmcTP2CPLbveDG6+6iOmV
	 i4mqfkJoJsbNQ==
Date: Mon, 25 Mar 2024 12:23:05 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
	fancer.lancer@gmail.com, u.kleine-koenig@pengutronix.de,
	dlemoal@kernel.org, yoshihiro.shimoda.uh@renesas.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v4] PCI: keystone: Fix pci_ops for AM654x SoC
Message-ID: <ZgFemQ8gHpB8yMef@ryzen>
References: <20240325053722.1955433-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325053722.1955433-1-s-vadapalli@ti.com>

On Mon, Mar 25, 2024 at 11:07:22AM +0530, Siddharth Vadapalli wrote:
> In the process of converting .scan_bus() callbacks to .add_bus(), the
> ks_pcie_v3_65_scan_bus() function was changed to ks_pcie_v3_65_add_bus().
> The .scan_bus() method belonged to ks_pcie_host_ops which was specific
> to controller version 3.65a, while the .add_bus() method had been added
> to ks_pcie_ops which is shared between the controller versions 3.65a and
> 4.90a. Neither the older ks_pcie_v3_65_scan_bus() method, nor the newer
> ks_pcie_v3_65_add_bus() method are applicable to the controller version
> 4.90a which is present in AM654x SoCs.
> 
> Thus, as a fix, move the contents of "ks_pcie_v3_65_add_bus()" to the
> .host_init callback "ks_pcie_host_init()" and execute it only for non
> AM654x SoC devices which have the v3.65a DWC PCIe IP Controllers.
> 
> Fixes: 6ab15b5e7057 ("PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus")
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on linux-next tagged next-20240325.
> This patch is technically the next version for the v3 patch at:
> https://patchwork.kernel.org/project/linux-pci/patch/20231019081330.2975470-1-s-vadapalli@ti.com/
> but the implementation is based on the RFC patch at:
> https://patchwork.kernel.org/project/linux-pci/patch/20231027084159.4166188-1-s-vadapalli@ti.com/
> Since the RFC patch mentioned above fixes the same issue being
> fixed by the v3 patch, I have dropped the v3 patch and am using
> the RFC patch since it is a cleaner implementation and was discussed at:
> https://lore.kernel.org/r/20231019220847.GA1413474@bhelgaas/
> 
> Regards,
> Siddharth.
> 
>  drivers/pci/controller/dwc/pci-keystone.c | 51 ++++++++---------------
>  1 file changed, 17 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 844de4418724..f45bdeac520a 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -445,44 +445,10 @@ static struct pci_ops ks_child_pcie_ops = {
>  	.write = pci_generic_config_write,
>  };
>  
> -/**
> - * ks_pcie_v3_65_add_bus() - keystone add_bus post initialization
> - * @bus: A pointer to the PCI bus structure.
> - *
> - * This sets BAR0 to enable inbound access for MSI_IRQ register
> - */
> -static int ks_pcie_v3_65_add_bus(struct pci_bus *bus)
> -{
> -	struct dw_pcie_rp *pp = bus->sysdata;
> -	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
> -
> -	if (!pci_is_root_bus(bus))
> -		return 0;
> -
> -	/* Configure and set up BAR0 */
> -	ks_pcie_set_dbi_mode(ks_pcie);
> -
> -	/* Enable BAR0 */
> -	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
> -	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
> -
> -	ks_pcie_clear_dbi_mode(ks_pcie);
> -
> -	 /*
> -	  * For BAR0, just setting bus address for inbound writes (MSI) should
> -	  * be sufficient.  Use physical address to avoid any conflicts.
> -	  */
> -	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
> -
> -	return 0;
> -}
> -
>  static struct pci_ops ks_pcie_ops = {
>  	.map_bus = dw_pcie_own_conf_map_bus,
>  	.read = pci_generic_config_read,
>  	.write = pci_generic_config_write,
> -	.add_bus = ks_pcie_v3_65_add_bus,
>  };
>  
>  /**
> @@ -822,6 +788,23 @@ static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret < 0)
>  		return ret;
>

> +	if (!ks_pcie->is_am6) {

Perhaps add a comment here stating WHY this is needed for v3.65a (!is_am6).

From reading the old threads, it appears that v3.65a:
-Has no support for iATUs. iATU-specific resource handling code is to be
 bypassed for v3.65 h/w. Thus v3.65a has it's own .child_ops implementation,
 so that pcie-designware-host.c does not configure the iATUs.
-v3.65a has it's own .msi_init implementation, so that pcie-designware-host.c
 does not call dw_pcie_msi_host_init() to configure the MSI controller.

While 4.90a:
-Does have iATU support.
-Does use the generic dw_pcie_msi_host_init().

Considering the major differences (with v3.65a being the outlier) here,
I think it would have been a much wiser idea to have two different glue
drivers for these two compatibles (ti,keystone-pcie and ti,am654-pcie-rc).

Right now the driver is quite hard to read, most of the functions in this
driver exist because v3.65a does not have an iATU and does not use the
generic DWC way to handle MSIs. Additionally, you have "if (!ks_pcie->is_am6)"
spread out all over the driver, to control quite major things, like if you
should overload .child_ops, or if you should set up inbound translation without
an iATU. This makes is even harder to see which code is actually used for
am654... like the fact that it actually uses the generic way to handle MSIs...

The driver for am654 would be much nicer since many of the functions in
this driver would not be needed (and the fact that you have only implemented
EP support for am654 and not for v3.65a). All EP related stuff would be in
the am654 file/driver.
You could keep the quirky stuff for v3.65a in the existing pci-keystone.c
driver.

(I guess if there is a function that is identical between the twos, you could
have a pci-keystone-common.{c,h}  that can be used by both drivers, but from
the looks of it, they seem to share very little code.


Kind regards,
Niklas



> +		/* Configure and set up BAR0 */
> +		ks_pcie_set_dbi_mode(ks_pcie);
> +
> +		/* Enable BAR0 */
> +		dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
> +		dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
> +
> +		ks_pcie_clear_dbi_mode(ks_pcie);
> +
> +		/*
> +		 * For BAR0, just setting bus address for inbound writes (MSI) should
> +		 * be sufficient.  Use physical address to avoid any conflicts.
> +		 */
> +		dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
> +	}
> +
>  #ifdef CONFIG_ARM
>  	/*
>  	 * PCIe access errors that result into OCP errors are caught by ARM as
> -- 
> 2.40.1
> 

