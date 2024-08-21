Return-Path: <linux-pci+bounces-11968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E5195A371
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 19:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46AEA1C22B54
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 17:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0271B1D42;
	Wed, 21 Aug 2024 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PS3RBA2e"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3711113E022;
	Wed, 21 Aug 2024 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259813; cv=none; b=UP3U15i54M2I3Z8924DZSCrQTTUGJs88Qgz1O4urD4zAVKC1uJqNqTr6YbramVSqy7W6miEXOGSxd29nfH9hr6xzuNwrdZ2A72X2H39Hx/pLy+AMvJZBasSTwRPx/t9zyfKSMz8psRL4KY5Ibq4uB8aOXHjH94ThavUzq48l20o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259813; c=relaxed/simple;
	bh=BvNszQGq5G9jdxQKhTqBAUqUetCwogf6wGt+WiFSgUA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DxUMNwk5IDA8KOshX1EM8npeUD5Ek3cpGZjMtP0vP4TFARUtcD23Wjo96Vne8Ay5KQkpakcXQ7Osy7oDpZJqjrsaob6LHanmB7778e8XLEmcsbw2wccif2wWPBmrezp12mRNxZTt55UfiY1J87WoNvGvn63jzmXVvKqCSb7EIOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PS3RBA2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557C0C32781;
	Wed, 21 Aug 2024 17:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724259812;
	bh=BvNszQGq5G9jdxQKhTqBAUqUetCwogf6wGt+WiFSgUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PS3RBA2eI/GwPkD3GbZL6gNIXuoNovk+sCjNbEtbVy5jmg8PQ7oWwLJ5BR2XKsk1C
	 5ofhwvg6TlEfASU7ASnJ4H8t8i/JtYA+WUAuv6OctQY9J9nOxQR1z1/BWl1FiPoPvs
	 aEZKw8XwIC6UefAlkAWUFn3m+IG5pOtvGjiSi7KVDJlyv57XYYFjqVSAm/pA3zEuEa
	 /i3B2IQFGR/BahB+imHfnow+CFVC8+AqdO5eelkgfE+WU2Lzun9vBNTB7+7qq/xvfa
	 o+d6RiwbfBrTlnjSraiAU9gStXI2ZbaHNvwED8UYr4MgA9egG2xjw2fN4CMokxuKT/
	 SzW6jhxYfhyDQ==
Date: Wed, 21 Aug 2024 12:03:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: daire.mcnamara@microchip.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	conor.dooley@microchip.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v8 1/3] PCI: microchip: Fix outbound address translation
 tables
Message-ID: <20240821170330.GA256147@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821130217.957424-2-daire.mcnamara@microchip.com>

On Wed, Aug 21, 2024 at 02:02:15PM +0100, daire.mcnamara@microchip.com wrote:
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
> 
> This necessitates changing a size_t in mc_pcie_setup_window
> to a u64 to avoid a compile error on 32-bit platforms.

I don't see this size_t change in this patch.  Add "()" after function
name if there's a relevant function here.

> Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip Polarfire PCIe controller driver")
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  .../pci/controller/plda/pcie-microchip-host.c | 30 ++++++++++++++++---
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
> index 48f60a04b740..da766de347bd 100644
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
> +int mc_pcie_setup_iomems(struct pci_host_bridge *bridge,
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
> 2.34.1
> 

