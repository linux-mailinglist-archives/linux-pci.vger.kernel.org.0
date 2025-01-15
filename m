Return-Path: <linux-pci+bounces-19799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EABA115F1
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 01:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4BC188803D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 00:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF1220ED;
	Wed, 15 Jan 2025 00:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijJ0wii/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2F0801;
	Wed, 15 Jan 2025 00:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899991; cv=none; b=Ns5qUhErG/pnFa0B9v4iVbUXRczDUqOqbq05raqarwo7PnXClGXguAG2oldkWeeCcjanEJKCvf7cCd1M3F2ZPt86Njw884Lu0rcKoAs5zWIJ5eASBALhNficuYpBjmzfQKaWHL51bhhrqZ2A5xH/2xSyZKaO5sY3PsUbAmU8+QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899991; c=relaxed/simple;
	bh=QCdx+7T6KB4BIkX67bM4rEWTwO+57c4nzW6/2P/N9iI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=c3nX1Bd9ospwiC3QBf5C0UhrR/2aQ2vxRypuADymN0GU71PkAgbIOe0oGT6fLjc1aFE6umKtcmbdYPTewiMC0x2g59hozuMXOB4U7JZygPCzqEb53ZgM038xWKXqGrXcZxg3C50GEqEPj1rRsn3sPAAdGTzZOpw9hhxRYryWc30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijJ0wii/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB06C4CEDD;
	Wed, 15 Jan 2025 00:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736899990;
	bh=QCdx+7T6KB4BIkX67bM4rEWTwO+57c4nzW6/2P/N9iI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ijJ0wii/pQrY1T35xNhRorMcOPQM+Mr0TZNZoCO4Tb8WKxiheHAY3fTnW5O9NRkWE
	 QSoOEsFZfWh0cgUcP7i2IGvOzKQXt6b9gCQdbhGnsEEg/igjbY9dSCPh9eHXlJ+mQL
	 P+iaMNzmSXG70Lsh9BDhQe4zj0KZLNTVEC7WLxOBqvF1A/x9l0j/G9J64RkvHfvFYR
	 UBXkU7uMSM/IXGnB2YAqvUco1FydsKp5isMa4m6RVHXXuSYx7Ubw8Xycz3LZu4/YdX
	 s6bJc6sOFxSPTjbYsI9HD15Z5k8rw+Exa+hHMwjTYhquwh7gISQcUP8r/J2QS3SLxU
	 WhC+Hcdd1elpg==
Date: Tue, 14 Jan 2025 18:13:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: daire.mcnamara@microchip.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	conor.dooley@microchip.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ilpo.jarvinen@linux.intel.com,
	kevin.xie@starfivetech.com
Subject: Re: [PATCH v10 1/3] PCI: microchip: Fix outbound address translation
 tables
Message-ID: <20250115001309.GA508227@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011140043.1250030-2-daire.mcnamara@microchip.com>

On Fri, Oct 11, 2024 at 03:00:41PM +0100, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> On Microchip PolarFire SoC (MPFS) the PCIe Root Port can be behind one of
> three general-purpose Fabric Interface Controller (FIC) buses that
> encapsulate an AXI-M interface. That FIC is responsible for managing
> the translations of the upper 32-bits of the AXI-M address. On MPFS,
> the Root Port driver needs to take account of that outbound address
> translation done by the parent FIC bus before setting up its own
> outbound address translation tables.  In all cases on MPFS,
> the remaining outbound address translation tables are 32-bit only.
> 
> Limit the outbound address translation tables to 32-bit only.

I don't quite understand what this is saying.  It seems like the code
keeps only the low 32 bits of a PCI address and throws away any
address bits above the low 32.

If that's what the FIC does, I wouldn't describe the FIC as
"translating the upper 32 bits" since it sounds like the translation
is just truncation.

I guess it must be more complicated than that?  I assume you can still
reach BARs that have PCI addresses above 4GB using CPU loads/stores?

The apertures through the host bridge for MMIO access are described by
DT ranges properties, so this must be something that can't be
described that way?

> Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip Polarfire PCIe controller driver")
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  .../pci/controller/plda/pcie-microchip-host.c | 30 ++++++++++++++++---
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
> index 48f60a04b740..fa4c85be21f0 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -21,6 +21,8 @@
>  #include "../../pci.h"
>  #include "pcie-plda.h"
>  
> +#define MC_OUTBOUND_TRANS_TBL_MASK		GENMASK(31, 0)
> +
>  /* PCIe Bridge Phy and Controller Phy offsets */
>  #define MC_PCIE1_BRIDGE_ADDR			0x00008000u
>  #define MC_PCIE1_CTRL_ADDR			0x0000a000u
> @@ -612,6 +614,27 @@ static void mc_disable_interrupts(struct mc_pcie *port)
>  	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
>  }
>  
> +static int mc_pcie_setup_iomems(struct pci_host_bridge *bridge,
> +			   struct plda_pcie_rp *port)
> +{
> +	void __iomem *bridge_base_addr = port->bridge_addr;
> +	struct resource_entry *entry;
> +	u64 pci_addr;
> +	u32 index = 1;
> +
> +	resource_list_for_each_entry(entry, &bridge->windows) {
> +		if (resource_type(entry->res) == IORESOURCE_MEM) {
> +			pci_addr = entry->res->start - entry->offset;
> +			plda_pcie_setup_window(bridge_base_addr, index,
> +					       entry->res->start & MC_OUTBOUND_TRANS_TBL_MASK,
> +					       pci_addr, resource_size(entry->res));
> +			index++;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int mc_platform_init(struct pci_config_window *cfg)
>  {
>  	struct device *dev = cfg->parent;
> @@ -622,15 +645,14 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  	int ret;
>  
>  	/* Configure address translation table 0 for PCIe config space */
> -	plda_pcie_setup_window(bridge_base_addr, 0, cfg->res.start,
> -			       cfg->res.start,
> -			       resource_size(&cfg->res));
> +	plda_pcie_setup_window(bridge_base_addr, 0, cfg->res.start & MC_OUTBOUND_TRANS_TBL_MASK,
> +			       0, resource_size(&cfg->res));
>  
>  	/* Need some fixups in config space */
>  	mc_pcie_enable_msi(port, cfg->win);
>  
>  	/* Configure non-config space outbound ranges */
> -	ret = plda_pcie_setup_iomems(bridge, &port->plda);
> +	ret = mc_pcie_setup_iomems(bridge, &port->plda);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.43.0
> 

