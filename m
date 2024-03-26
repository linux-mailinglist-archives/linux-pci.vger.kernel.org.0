Return-Path: <linux-pci+bounces-5181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0563988C42A
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 14:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520E91F3DCFE
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 13:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB545D724;
	Tue, 26 Mar 2024 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Euiac2GB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979F3125C9;
	Tue, 26 Mar 2024 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461393; cv=none; b=I2RbCvNWsjHRQyFDreEnd7FqY4ArtbuBKNIXzdPyoG653ROGjPkyfvhuH0xIBVfc3pqYtOCKlWRO4EdLCR9/YgdN5926cy5bSWVzVZPjr4shZc+/ndK3pX9d7xDICLkMqP4U8/8cd/fjN47mXEskYrRe+FSNhHJhUuVYZEa/YW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461393; c=relaxed/simple;
	bh=kFHIDWQI67kN/OX0dUZ5DC/EkIeuT7MrsCc1k2qtV4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiRbqzUb8/tcT8FPSAEmiRfQRk5uDpwC/51Pc3yQXL+9/hsafnFYI4gNrxOADLlinVp33LxqBywXjocbqmOZsyr1swzuZwmmHV+ea4ZvWstHDB9p9bO9T2HT41aR1GSbzq+11hRkcfvRrWWXXCaclMJ/8cO+Xjy8JvqmmKSAnxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Euiac2GB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B779C433F1;
	Tue, 26 Mar 2024 13:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711461393;
	bh=kFHIDWQI67kN/OX0dUZ5DC/EkIeuT7MrsCc1k2qtV4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Euiac2GBjlWSQQNq9+bL4zbkpwlDWDdJ/1P4L6K6p2Xk3aFL6a0WtzgH/AE9nGz38
	 FYntVfFjsnupMI4L3C8I7syWHizMxvpzZI06EkMVlP1aZ8tjLZ615tvKBtxkqUpV7L
	 VcL2I7/TVtMYiCSRG+mzqAZ8h19BP0GP7kFGAsmK6RazlG1krGgLjNbtNbJTjgH2fL
	 0yjTDFDOrUPh3gMIHhBUqwlM4JVwP3RHOzCJl5/0guoM5xQcvEjNFdCHyCYQBdyWQa
	 HBc7iFm6aWzz+TffNusXJ8QXcaXUuKs7xln4NJYJiSQY9+nwvZrzy2xnjfXFREu4Hp
	 os5xZTAUFxigQ==
Date: Tue, 26 Mar 2024 14:56:26 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
	fancer.lancer@gmail.com, u.kleine-koenig@pengutronix.de,
	dlemoal@kernel.org, yoshihiro.shimoda.uh@renesas.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v5] PCI: keystone: Fix pci_ops for AM654x SoC
Message-ID: <ZgLUCqh12RMApzyr@x1-carbon>
References: <20240326111905.2369778-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326111905.2369778-1-s-vadapalli@ti.com>

On Tue, Mar 26, 2024 at 04:49:05PM +0530, Siddharth Vadapalli wrote:
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
> .msi_init callback "ks_pcie_msi_host_init()" which is specific to the
> 3.65a controller. Also, move the definitions of ks_pcie_set_dbi_mode()
> and ks_pcie_clear_dbi_mode() above ks_pcie_msi_host_init() in order to
> avoid forward declaration.
> 
> Fixes: 6ab15b5e7057 ("PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus")
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on linux-next tagged next-20240326.
> 
> v4:
> https://lore.kernel.org/r/20240325053722.1955433-1-s-vadapalli@ti.com/
> Changes since v4:
> - As suggested by Niklas Cassel <cassel@kernel.org> at:
>   https://lore.kernel.org/r/ZgF_5fYsI5lOFjOv@ryzen/
>   the contents of "ks_pcie_v3_65_add_bus()" have been moved to
>   "ks_pcie_msi_host_init()" instead of "ks_pcie_host_init()". This
>   avoids unnecessary checks for "!ks_pcie->is_am6" since
>   "ks_pcie_msi_host_init()" is specific to the v3.65a controller version
>   which corresponds to "!ks_pcie->is_am6".
> - Updated commit message to match the change in implementation.
> - Added "Suggested-by" tag of Niklas Cassel <cassel@kernel.org> based on:
>   https://lore.kernel.org/r/ZgKaNrhoReJ0A525@x1-carbon/
> - Moved the definitions for ks_pcie_set_dbi_mode() and
>   ks_pcie_clear_dbi_mode() above ks_pcie_msi_host_init().
> 
> Regards,
> Siddharth.
> 
>  drivers/pci/controller/dwc/pci-keystone.c | 136 ++++++++++------------
>  1 file changed, 60 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 844de4418724..c2252448d9e8 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -245,8 +245,68 @@ static struct irq_chip ks_pcie_msi_irq_chip = {
>  	.irq_unmask = ks_pcie_msi_unmask,
>  };
>  
> +/**
> + * ks_pcie_set_dbi_mode() - Set DBI mode to access overlaid BAR mask registers
> + * @ks_pcie: A pointer to the keystone_pcie structure which holds the KeyStone
> + *	     PCIe host controller driver information.
> + *
> + * Since modification of dbi_cs2 involves different clock domain, read the
> + * status back to ensure the transition is complete.
> + */
> +static void ks_pcie_set_dbi_mode(struct keystone_pcie *ks_pcie)
> +{
> +	u32 val;
> +
> +	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
> +	val |= DBI_CS2;
> +	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
> +
> +	do {
> +		val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
> +	} while (!(val & DBI_CS2));
> +}
> +
> +/**
> + * ks_pcie_clear_dbi_mode() - Disable DBI mode
> + * @ks_pcie: A pointer to the keystone_pcie structure which holds the KeyStone
> + *	     PCIe host controller driver information.
> + *
> + * Since modification of dbi_cs2 involves different clock domain, read the
> + * status back to ensure the transition is complete.
> + */
> +static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
> +{
> +	u32 val;
> +
> +	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
> +	val &= ~DBI_CS2;
> +	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
> +
> +	do {
> +		val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
> +	} while (val & DBI_CS2);
> +}
> +
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
> +	 /*
> +	  * For BAR0, just setting bus address for inbound writes (MSI) should
> +	  * be sufficient.  Use physical address to avoid any conflicts.
> +	  */

This comment seems to have wrong indentation.
With that fixed:

Reviewed-by: Niklas Cassel <cassel@kernel.org>

> +	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
> +
>  	pp->msi_irq_chip = &ks_pcie_msi_irq_chip;
>  	return dw_pcie_allocate_domains(pp);
>  }

