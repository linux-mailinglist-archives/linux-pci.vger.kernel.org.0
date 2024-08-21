Return-Path: <linux-pci+bounces-11973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A9295A3B0
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 19:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D43CB2290D
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 17:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F314F1B2EC7;
	Wed, 21 Aug 2024 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJTLsnpj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A4F1B2EC1;
	Wed, 21 Aug 2024 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260634; cv=none; b=rMhkqRjXKI0JynYadHBwWvuTdoI3N2snYZhzfuLnM73e3qMaSvnZNDLs1dsFeMLBML4Reoaeg7BHkJ7b/VZi/o705iaGVbuvDs60fjmjILeyRLigQqNZ6Qk9Xs6VLjj0VOjkQjWFm9IS8pY6BNfLlSYe26m7YzQHkuyLkUzCxuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260634; c=relaxed/simple;
	bh=TyLDjhy0ttfEqSAKwvAE+TyPIIdCunxanaRtbGipG5M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZVjigY9+PzUB3YrL3D+c3tXmj+vJOmeUw1CXLs8f4TYRgZ7QvnQFTX/tAJ+AxMsZgaeFfuGIKLeehqaysoKc58Fwc2qBsrljVaL5EzA+zJ4J2F9wIx8b+m2ChTlWmo5bRPE0kNXtSd/XtJ0kpqRsx0D8yWq78Qlm/ZMEtDPb7gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJTLsnpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB952C4AF13;
	Wed, 21 Aug 2024 17:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724260634;
	bh=TyLDjhy0ttfEqSAKwvAE+TyPIIdCunxanaRtbGipG5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qJTLsnpjPRqw2Ttkye4zhRT+sOXS+tl57VHKXelnWv3O7OBcK2j5giznTCNDhbh08
	 p3IeqfBKs7F4uCML5CV6CnX6DHasaRCEu5T4EJ/l0Z7S2OqkNQFbkMIY0vnObJU8mn
	 YNf8XF8pOJQqpP8tb9+QveomFi/RdyWwIkBPrw50iKGfUyItrnBZFZTP5sp3QJgxke
	 7/7iVj4GsMlKXWShUb+gUA0Q9rIew6ROkd5K5LSwJGuw2TsfZpya9yRr0Ggj5xCtFI
	 KyR5dop6W2A8B7veBSpMRvqsVWycCTgMHYnKw5ET2QvqLbvhPhFHqtzWYgS54A4elg
	 maLXDuhkXoYLA==
Date: Wed, 21 Aug 2024 12:17:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: daire.mcnamara@microchip.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	conor.dooley@microchip.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v8 2/3] PCI: microchip: Fix inbound address translation
 tables
Message-ID: <20240821171712.GA256242@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240821130217.957424-3-daire.mcnamara@microchip.com>

On Wed, Aug 21, 2024 at 02:02:16PM +0100, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> On Microchip PolarFire SoC the PCIe Root Port can be behind one of three
> general purpose Fabric Interface Controller (FIC) buses that encapsulates
> an AXI-S bus. Depending on which FIC(s) the Root Port is connected
> through to CPU space, and what address translation is done by that FIC,
> the Root Port driver's inbound address translation may vary.
> 
> For all current supported designs and all future expected designs,
> inbound address translation done by a FIC on PolarFire SoC varies
> depending on whether PolarFire SoC in operating in coherent DMA mode or
> noncoherent DMA mode.

s/in operating/is operating/

> The setup of the outbound address translation tables in the Root Port
> driver only needs to handle these two cases.
> 
> Setup the inbound address translation tables to one of two address
> translations, depending on whether the rootport is being used with coherent
> DMA or noncoherent DMA.

s/rootport/Root Port/ to match above

> +static void mc_pcie_setup_inbound_atr(int window_index, u64 axi_addr, u64 pcie_addr, u64 size)

Most of this file fits in 80 columns, maybe these new decls could, too.

> +static int mc_pcie_setup_inbound_ranges(struct platform_device *pdev, struct mc_pcie *port)

> @@ -525,13 +529,20 @@ void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>  	val = upper_32_bits(pci_addr);
>  	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
>  	       ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
> +}
> +EXPORT_SYMBOL_GPL(plda_pcie_setup_window);

I think the caller that needs this export is in a previous patch?

I wish we didn't need to export symbols like these since they're
really private to the driver, but I didn't look into the module
structure here.

Also, I get this error when building after both patch 1/3 and 2/3:

  drivers/pci/controller/plda/pcie-microchip-host.c:617:5: error: no previous prototype for ‘mc_pcie_setup_iomems’ [-Werror=missing-prototypes]
    617 | int mc_pcie_setup_iomems(struct pci_host_bridge *bridge,
	|     ^~~~~~~~~~~~~~~~~~~~

> +++ b/drivers/pci/controller/plda/pcie-starfive.c
> @@ -355,6 +355,11 @@ static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
>  	 */
>  	plda_pcie_set_pref_win_64bit(plda);
>  
> +	/*
> +	 * Setup the inbound address translation
> +	 */

Could be a single-line comment: /* Setup the ... */

> +	plda_pcie_setup_inbound_address_translation(plda);

