Return-Path: <linux-pci+bounces-7433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F16578C490A
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 23:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19FE2823ED
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 21:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93B683CD8;
	Mon, 13 May 2024 21:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPyD8bb3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEB383CD3;
	Mon, 13 May 2024 21:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715637232; cv=none; b=qd8yE/EYPg9aar4jONIdZVMYWvKNtJ5gBjiIZ7vVLHSlCJEBkmLedNWe/RJnNe+Gf3Qdztd22fbj1NVvYfnK/fiW527uA/ab7iDbGnQzxuXwaqpSD+83IcDw9bZpCfnWy/otgJiQnDXhvK3UjyM89FxXl3dU9uo1zX42egau+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715637232; c=relaxed/simple;
	bh=xYDOX8OokrT4sH7DNkwITxYGFuKzHAph5Phz8h32PK4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qOlXH9rhq2vTm5g8hDXtw0spneo/4UX96q4UdSh3zhPSSJL0C+4PgJKzGDuw3OcQFr1zwsEae2xnogANMVLOJBtKWQVMI16Ys1dILCVoiNJJAcvxVdko/1SJP5Eow7joNVN8kO3kvjCF53CUp+M785Owy0hDNXX6deA5ljU4fbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPyD8bb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE55C113CC;
	Mon, 13 May 2024 21:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715637232;
	bh=xYDOX8OokrT4sH7DNkwITxYGFuKzHAph5Phz8h32PK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UPyD8bb3PuObTLRJxghWQFxqvzE6uKt4fTrymkorfIBPn/bQuaSDPUjjsXjc5UFdn
	 FzB5fsSbpxbDDLvJ4f4PbdYNy9lAQsbBBTqa9EXQ30dWOzEKIvjjoX9BHKNi0J6EKa
	 gx3bDjUE6z5pSldC28Ts5s6Xs2U2xLxpdsDKDOlLGJgzRrP6boUIHD1XoQB+LnTEBT
	 AgGo9+LfW5hSWL8oHigg70jh052umXVrPHA39jZv+6GXvl6khaCFoXS3yzJ0nvDvp5
	 e4xFaLPgmf8zIwFSzs+FNpFZVq2xwlzmy7RBFS4Uk/gteQbO/IbSzZRvdpYHfR6ye8
	 5+VLGNIGII25g==
Date: Mon, 13 May 2024 16:53:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
	fancer.lancer@gmail.com, u.kleine-koenig@pengutronix.de,
	cassel@kernel.org, dlemoal@kernel.org,
	yoshihiro.shimoda.uh@renesas.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH v7 2/2] PCI: keystone: Fix pci_ops for AM654x SoC
Message-ID: <20240513215350.GA1996021@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328085041.2916899-3-s-vadapalli@ti.com>

On Thu, Mar 28, 2024 at 02:20:41PM +0530, Siddharth Vadapalli wrote:
> In the process of converting .scan_bus() callbacks to .add_bus(), the
> ks_pcie_v3_65_scan_bus() function was changed to ks_pcie_v3_65_add_bus().
> The .scan_bus() method belonged to ks_pcie_host_ops which was specific
> to controller version 3.65a, while the .add_bus() method had been added
> to ks_pcie_ops which is shared between the controller versions 3.65a and
> 4.90a. Neither the older ks_pcie_v3_65_scan_bus() method, nor the newer
> ks_pcie_v3_65_add_bus() method is applicable to the controller version
> 4.90a which is present in AM654x SoCs.
> 
> Thus, as a fix, remove "ks_pcie_v3_65_add_bus()" and move its contents
> to the .msi_init callback "ks_pcie_msi_host_init()" which is specific to
> the 3.65a controller.
> 
> Fixes: 6ab15b5e7057 ("PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus")
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Thanks for splitting this into two patches.  Krzysztof has applied
both to pci/controller/keystone and we hope to merge them for v6.10.

I *would* like the commit log to be at a little higher level if
possible.  Right now it's a detailed description at the level of the
code edits, but it doesn't say *why* we want this change.

I think the first cut at this was
https://lore.kernel.org/linux-pci/20231011123451.34827-1-s-vadapalli@ti.com/t/#u,
which mentioned Completion Timeouts during MSI-X configuration and 45
second delays during boot.

IIUC, prior to 6ab15b5e7057, ks_pcie_v3_65_scan_bus() initialized BAR
0 and was only used for v3.65a devices.  6ab15b5e7057 renamed it to
ks_pcie_v3_65_add_bus() and called it for both v3.65a and v4.90a.

I think the problem is that in the current code, the
ks_pcie_ops.add_bus() method (ks_pcie_v3_65_add_bus()) is used for all
devices (both v3.65a and v4.90a).  So I guess doing the BAR 0 setup on
v4.90a broke something there?

I'm not quite clear on the mechanism, but it would be helpful to at
least know what's wrong and on what platform.  E.g., currently v4.90
suffers Completion Timeouts and 45 second boot delays?  And this patch
fixes that?

> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 52 ++++++++---------------
>  1 file changed, 18 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 5c073e520628..6cb3a4713009 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -289,6 +289,24 @@ static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
>  
>  static int ks_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  {
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
> +
> +	/* Configure and set up BAR0 */
> +	ks_pcie_set_dbi_mode(ks_pcie);
> +
> +	/* Enable BAR0 */
> +	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
> +	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
> +
> +	ks_pcie_clear_dbi_mode(ks_pcie);
> +
> +	/*
> +	 * For BAR0, just setting bus address for inbound writes (MSI) should
> +	 * be sufficient.  Use physical address to avoid any conflicts.
> +	 */
> +	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
> +
>  	pp->msi_irq_chip = &ks_pcie_msi_irq_chip;
>  	return dw_pcie_allocate_domains(pp);
>  }
> @@ -445,44 +463,10 @@ static struct pci_ops ks_child_pcie_ops = {
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
> -- 
> 2.40.1
> 

