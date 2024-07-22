Return-Path: <linux-pci+bounces-10623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C85939659
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 00:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16ABE1F220AC
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 22:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388A8487B3;
	Mon, 22 Jul 2024 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eS2GWIka"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072F647F6C;
	Mon, 22 Jul 2024 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721686503; cv=none; b=UO/Kvgjq6rv2jC5sYRSiy/Ly8AmMNMhQcaP97PQRJKg3HxSrEgm7cNLMxU52Rt8suaMX5advFwrEiHv1dUin8WeS1a8e4Y7elAFV72vc7r6aDCiubWko3cK4vGZsIFXL21VBW93R7Q2cDMHd4gXFCZQCPoijfLyxPVQDbGF5aTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721686503; c=relaxed/simple;
	bh=pltdNSZmHoCVSI5Sk1ELA9qb2K8O00alOaa1v/EU7+o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LbxiX3PQs/hQ7bjOQWik23w0ehhMjF46a/TNJeIZPdZiC5Xdsd+RGnnC93EQ0HB0AKg0FBvwRZ7QMkckK2yrKiWFlEDrevz7aXXChd3LBcThcwjZW2CXK7eZWxoZ+3mm6Ts2yGAqlC6yA4N6sfzAni5c5J5pQlOoDobNwE0Gaf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eS2GWIka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F13C4AF0B;
	Mon, 22 Jul 2024 22:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721686502;
	bh=pltdNSZmHoCVSI5Sk1ELA9qb2K8O00alOaa1v/EU7+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eS2GWIka5vU0Qn0pNkYc7lr5QHaxi1ZWuMgxqgY5Sy5iieoVqXwg/SZKOwF6SNNWz
	 /nZqJLDtjl4qoCXLrSVokX6tIh/e4WWyH/pBYDoXornJ6VtdYgSfkr3eCIeF5AT4ek
	 gw29mSYhAL4xycRBGfptWkJnlsUXf4B1UrtC2CFI2aTdnlJUBpO5obZS6aQVKLOt3p
	 OzrBfqlwqiuJje8zwiW+cMn+fZWTw7ycPn8EIQTXdvEY2xgBIe2ZAnp1gMPszE6CCt
	 b8+Bc90pK8zjMT3w6VrrewVLH+gSXymmwR3UlMskHFoyqhlDINDg3SAzd9Zfmw70ox
	 mmX4bTwSiIPIQ==
Date: Mon, 22 Jul 2024 17:15:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thippeswamy Havalige <thippesw@amd.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, thippeswamy.havalige@amd.com,
	linux-arm-kernel@lists.infradead.org, michal.simek@amd.com
Subject: Re: [PATCH v2 2/2] PCI: xilinx-xdma: Add Xilinx QDMA Root Port driver
Message-ID: <20240722221500.GA739438@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722062558.1578744-3-thippesw@amd.com>

On Mon, Jul 22, 2024 at 11:55:58AM +0530, Thippeswamy Havalige wrote:
> Add support for Xilinx QDMA Soft IP core as Root Port.
> 
> The versal prime devices support QDMA soft IP module in
> programmable logic.

Capitalize brand names.

> The integrated QDMA Soft IP block has integrated bridge function that
> can act as PCIe Root Port.

Rewrap to fill 75 columns.

> +#define QDMA_BRIDGE_BASE_OFF		0xCD8

Other #defines in this file user lower-case hex; please match them.

>  static inline u32 pcie_read(struct pl_dma_pcie *port, u32 reg)
>  {
> -	return readl(port->reg_base + reg);
> +	if (port->variant->version == XDMA)
> +		return readl(port->reg_base + reg);
> +	else
> +		return readl(port->reg_base + reg + QDMA_BRIDGE_BASE_OFF);
>  }
>  
>  static inline void pcie_write(struct pl_dma_pcie *port, u32 val, u32 reg)
>  {
> -	writel(val, port->reg_base + reg);
> +	if (port->variant->version == XDMA)
> +		writel(val, port->reg_base + reg);
> +	else
> +		writel(val, port->reg_base + reg + QDMA_BRIDGE_BASE_OFF);
>  }
>  
>  static inline bool xilinx_pl_dma_pcie_link_up(struct pl_dma_pcie *port)
> @@ -173,7 +198,10 @@ static void __iomem *xilinx_pl_dma_pcie_map_bus(struct pci_bus *bus,
>  	if (!xilinx_pl_dma_pcie_valid_device(bus, devfn))
>  		return NULL;
>  
> -	return port->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
> +	if (port->variant->version == XDMA)
> +		return port->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
> +	else
> +		return port->cfg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);

If you rework the variant tests above to use
"if (port->variant->version == QDMA)" instead, they will match the one
below, and you won't need to touch the existing code at all, e.g.,

  + if (port->variant->version == QDMA)
  +   return port->cfg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);

    return port->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);

>  }
>  
>  /* PCIe operations */
> @@ -731,6 +759,15 @@ static int xilinx_pl_dma_pcie_parse_dt(struct pl_dma_pcie *port,
>  
>  	port->reg_base = port->cfg->win;
>  
> +	if (port->variant->version == QDMA) {
> +		port->cfg_base = port->cfg->win;
> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "breg");
> +		port->reg_base = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(port->reg_base))
> +			return PTR_ERR(port->reg_base);
> +		port->phys_reg_base = res->start;
> +	}

