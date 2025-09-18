Return-Path: <linux-pci+bounces-36449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2016BB87507
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 01:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486C15686F8
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 23:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE7B31BC9A;
	Thu, 18 Sep 2025 23:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrSxDm7g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784C131B834
	for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236417; cv=none; b=iCYkKcbV/Z1QcQp6xt40olLu6/R4K/maDq9cpyqwLfkV4BBce+5zRcsSKptyAP/PYz2vFV3Ixpo3MRFXR0Tzczhh/oIyjsmZSsF5FOyOSHufbqiPLl2d8nYGWJV56f0AWa1dqvW5yg5DpqgTuXrfSRk2wZfoFaWgp96P7OVkOAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236417; c=relaxed/simple;
	bh=QXI9dKpx92Ea/NibfeL8M4YhD5J2WSHb7eqL8Qwufh0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=htcKGHeNU/0UBurIYehlI8jxdnF2HP43yt2jUbJYAUDCLW+JtdxCWrP01WfoMWT7elgEdepcIvi0acNR+rpEBDR+VKctCmnohme1aEQXTSYApqkHN3hdZig7mQPeEIuonhPizUz+mMoynHB3XzkFvS3SEt2mnwDSnES2F9uXyJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrSxDm7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12E8C4CEFA;
	Thu, 18 Sep 2025 23:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758236416;
	bh=QXI9dKpx92Ea/NibfeL8M4YhD5J2WSHb7eqL8Qwufh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OrSxDm7gi2c8/Ilh/NL2lXJSjlFOTYtOc/t3cdXv9T5r/Cb966IsTKK07t38ldQS8
	 fjvlmpO3b0rWTYrgIDGlxCU7FvdDBKojiMl4cfLwoAE9ZOSmhH/NJUgeHO+zj1XQ/x
	 a7DBYy4F40o+IuC8+c3H2x9IP/5TInik8Xd6SdqI+h7e7UvtAnZHbDYBo5WLhW4r+V
	 KOXARLC0qBJf8aBS+hRXHr7kjhY0g1XKqKAExvgDtLOl4EzkRTcQyXKSCUewHyc/P9
	 gdAor2m7/ArQknFH8DBdWfN4t7u5TmY1h0bzewrGLyP+pNYDrlyfRRo14n/sz/OPcn
	 2ubkMSH56gLcA==
Date: Thu, 18 Sep 2025 18:00:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: daire.mcnamara@microchip.com
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v11 resend 1/1] PCI: microchip: fix outbound address
 translation tables
Message-ID: <20250918230014.GA1927726@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805150156.12392-1-daire.mcnamara@microchip.com>

On Tue, Aug 05, 2025 at 04:01:56PM +0100, daire.mcnamara@microchip.com wrote:
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
> Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip Polarfire PCIe controller driver")
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
> ---
> This patch was previously part of the linked series here:
> https://lore.kernel.org/linux-pci/20241011140043.1250030-2-daire.mcnamara@microchip.com/
> The rest of the linked series has been applied but we've recently
> noticed that this one hasn't been applied.
> 
> PolarFire SoC PCIe is currently broken in mainline. Can we get this
> fixed up and come up with something cross platform later?

Hi Daire,

Sorry for the late response here.

It looks like we merged 1390a33b3d04 ("PCI: microchip: Set inbound
address translation for coherent or non-coherent mode") in January,
but deferred this one because of the hard-coded
MC_OUTBOUND_TRANS_TBL_MASK that contains information we should be
getting from devicetree (there's more detail in the discussion of the
v10 series you pointed to above).

It was really hard to remove the .cpu_addr_fixup() stuff in the DWC
core (I think we still have some lingering even now), so I'm hesitant
to add more code that is conceptually similar.

Is there any progress on describing the PolarFire address translation
in devicetree since then?

> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c

> +#define MC_OUTBOUND_TRANS_TBL_MASK		GENMASK(31, 0)

> +static int mc_pcie_setup_iomems(struct pci_host_bridge *bridge,
> +				struct plda_pcie_rp *port)
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
> @@ -708,15 +731,15 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  	int ret;
>  
>  	/* Configure address translation table 0 for PCIe config space */
> -	plda_pcie_setup_window(port->bridge_base_addr, 0, cfg->res.start,
> -			       cfg->res.start,
> -			       resource_size(&cfg->res));
> +	plda_pcie_setup_window(port->bridge_base_addr, 0,
> +			       cfg->res.start & MC_OUTBOUND_TRANS_TBL_MASK,
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
> 2.45.2
> 

