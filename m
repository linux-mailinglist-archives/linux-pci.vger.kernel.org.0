Return-Path: <linux-pci+bounces-8194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEC18D88D3
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 20:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2D41F2393B
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 18:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6261210E6;
	Mon,  3 Jun 2024 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgB7SAWG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EBB13A252;
	Mon,  3 Jun 2024 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717440318; cv=none; b=XedirqdirUs5/v7dbuJR0SOlYBMm75rwy4M3d+FxPmCQgLLmYSpP8hE5ZymjPoP+msDVELtqGNm66R0W9alQPAoZk4YQLkyrIeyL6nx4p3mHpGGZRnssNCg8ccj3mMDpiSFpr7RdalRmkPZD7s8nS7FwsLdNSIOoGeHrLVCxMSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717440318; c=relaxed/simple;
	bh=CYD9CNW0hZo4GzQTwjKIvClwD4HPTw+g0MIeUFCe3Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VB4PZkykqkW7Kh1bFYCThZo1eNootJI+Y4e9A6l+7N/5bQJ+FxJOCr0IckeBg370O5mZ29jbmdvSuASqlgTdsPiTcwBQK1mXB0d8l16UqXylYYObGo3or9yFcX3+GMG53NgSE5sjtnzCzQQy3FIi4Rxtsx/yjN3LRJtmJnylOVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgB7SAWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F3BC2BD10;
	Mon,  3 Jun 2024 18:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717440318;
	bh=CYD9CNW0hZo4GzQTwjKIvClwD4HPTw+g0MIeUFCe3Y0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lgB7SAWG7DZyT4ECryCmxnq/4wdodJoEmymX6A+mU2SJNfhdoxiDi9wcUyi0CZbNf
	 aJrI8sX0L+/RmOMZWOxd/oA4RqT7YdkI3PrOE8mMWb7pyVcLZUDJXqkstRXxyJyv1C
	 SJn4721FDUz4OXwCW5iVAX/NgAAzCe8G9+tfCvQTvWdBQRiWmKxgrVRGfxffUyck/Q
	 Fr98dkDZtI8JRN6OqIzXp3AqTbPHgvjAqV1K1xz87DmuZhyHLAbLlFkUDfZZPbuR1D
	 VCOrRU22ozmOl3skUJcIsz6eg9+cPtpYf7AfCsPT5ChhGL6clybsShOp2aAVUZRRBF
	 7dcZl2qxjB+6Q==
Date: Mon, 3 Jun 2024 13:45:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daire McNamara <daire.mcnamara@microchip.com>
Cc: linux-pci@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: microchip: Fix outbound address translation
 tables
Message-ID: <20240603184516.GA687362@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531085333.2501399-2-daire.mcnamara@microchip.com>

On Fri, May 31, 2024 at 09:53:32AM +0100, Daire McNamara wrote:
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
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> ---
>  drivers/pci/controller/pcie-microchip-host.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> index 137fb8570ba2..0795cd122a4a 100644
> --- a/drivers/pci/controller/pcie-microchip-host.c
> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -983,7 +983,8 @@ static int mc_pcie_setup_windows(struct platform_device *pdev,
>  		if (resource_type(entry->res) == IORESOURCE_MEM) {
>  			pci_addr = entry->res->start - entry->offset;
>  			mc_pcie_setup_window(bridge_base_addr, index,
> -					     entry->res->start, pci_addr,
> +					     entry->res->start & 0xffffffff,
> +					     pci_addr & 0xffffffff,
>  					     resource_size(entry->res));

Is this masking something that the PCI core needs to be aware of when
it allocates address space for BARs?

The PCI core knows about the CPU physical address range of each bridge
window and the corresponding PCI address range.  From this patch, it
looks like only the low 32 bits of the CPU address are used by the
Root Port.  That might not be a problem as long as the windows
described by DT are correct and none of them overlap after masking out
the upper 32 bits.  But for example, if DT has windows like this:

  [mem 0x1'0000'0000-0x1'8000'0000]
  [mem 0x2'0000'0000-0x2'8000'0000]

the PCI core will assume they are valid and non-overlapping, when
IIUC, they *do* overlap.

But also only the low 32 bits of the PCI address are used, and it
seems like the PCI core will need to know that so it doesn't program a
64-bit BAR with a value above 4GB?

>  			index++;
>  		}
> @@ -1117,8 +1118,8 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  	int ret;
>  
>  	/* Configure address translation table 0 for PCIe config space */
> -	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start,
> -			     cfg->res.start,
> +	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start & 0xffffffff,
> +			     cfg->res.start & 0xffffffff,
>  			     resource_size(&cfg->res));
>  
>  	/* Need some fixups in config space */
> -- 
> 2.34.1
> 

