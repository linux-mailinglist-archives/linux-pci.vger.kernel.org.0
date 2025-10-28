Return-Path: <linux-pci+bounces-39552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E942DC1614A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 18:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7473D4E99FB
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 17:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8EC34A775;
	Tue, 28 Oct 2025 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHWgETQ1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A7234321B;
	Tue, 28 Oct 2025 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671614; cv=none; b=EvOMDtgS5X0tiCCAQucb0/fXgzZzz+HgKeF0ybXeUXU71icwWSuH7Q2VzTrJV2Mzz9ntwC9vFxTVGgtzrGJmk/BaizMdJ055Y6jiRI8K5581BgkAbrq11unO5KnPXJcCas5kv+2T9HlZO1EUconzNT8YB0d31oEFsiYpO3HIhc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671614; c=relaxed/simple;
	bh=+cenkb0yL5U6fkb9PXEJLOZBBfbIw/K5JcCnxUVgehI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=B315AAY8RW3CzJNNTcI7jrQftfdSb3ZKK5CwS3lwldZA4XvAO9crSJ7xZ9Yo+ra9p8IprJy/5F/n9GUQYc0UE+/d5Eap4SRewRQuLdSHAIUJsQbi0p4W10xk8Xqiq5iaaFtDtPR2RCG051LXD8Xd/skABKtfUAq6IDPn+Cc55cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHWgETQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B658BC4CEE7;
	Tue, 28 Oct 2025 17:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761671611;
	bh=+cenkb0yL5U6fkb9PXEJLOZBBfbIw/K5JcCnxUVgehI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GHWgETQ1RNiG4NgBjVLnhJH9atMiVJdloWNMv11jPg99tyK+rmBwAzqK9hTb4gVhT
	 2ZtFnJKwxLI4s2Q1P8yhoci5coU0j5l4vn2zCzKepsIfscxlIj7Zu5fXo/n3/KWGIz
	 hHMqKbrGfsuMHEa9JXdVniJNLDuD3aTag4FRYpY8MZC7Tdt+1tj5Isr/dt42Ncc8NJ
	 sH4jdipg5MKIr6H7mirxdjLBByUiKYKRocaUoLgV9TRC+GCZAmUas2q83NjwZJ561i
	 7CYd2BuJMIACVxarC+376c/AlA60uR1HFbp6n2bx39j1c/IyYibnP+f7s04InfotSN
	 hUMwQm5MxpCww==
Date: Tue, 28 Oct 2025 12:13:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	vkoul@kernel.org, kishon@kernel.org, linus.walleij@linaro.org,
	p.zabel@pengutronix.de, linux-aspeed@lists.ozlabs.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 8/9] PCI: aspeed: Add ASPEED PCIe RC driver
Message-ID: <20251028171330.GA1506282@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027095825.181161-9-jacky_chou@aspeedtech.com>

On Mon, Oct 27, 2025 at 05:58:24PM +0800, Jacky Chou wrote:
> Introduce PCIe Root Complex driver for ASPEED SoCs. Support RC
> initialization, reset, clock, IRQ domain, and MSI domain setup.
> Implement platform-specific setup and register configuration for
> ASPEED. And provide PCI config space read/write and INTx/MSI
> interrupt handling.

> +config PCIE_ASPEED
> +	bool "ASPEED PCIe controller"
> +	depends on ARCH_ASPEED || COMPILE_TEST
> +	depends on OF
> +	depends on PCI_MSI
> +	select IRQ_MSI_LIB
> +	help
> +	  Enable this option to support the PCIe controller found on ASPEED
> +	  SoCs.
> +
> +	  This driver provides initialization and management for PCIe
> +	  Root Complex functionality, including interrupt and MSI support.

Maybe "INTx and MSI support", since MSI is an interrupt?

> +/* Complete status */

"Completion"

> +static int aspeed_ast2700_ahb_remap_to_bar(struct aspeed_pcie *pcie)
> +{
> +	struct resource_entry *win, *tmp;
> +	struct pci_host_bridge *bridge = pcie->host;
> +
> +	/* Configure AHB remapping to BAR on AST27x0.
> +	 * The BAR region is HW-fixed in AST27x0, these BARs will be filled
> +	 * in the ranges of pcie node in DT.
> +	 */

I don't understand what "HW-fixed" means here.  It looks like you're
writing host bridge window addresses (that came from DT) to the
hardware.  That sounds like they're not actually "fixed" but
programmable.

Host bridge windows are not BARs themselves.  Mem space for devices
below the host bridge is allocated from the windows, and the addresses
are programmed into BARs of those downstream devices.

Multi-line comment style:

  /*
   * Configure ...
   */

Wrap to fill 78 columns, or add blank lines between paragraphs.

> +	resource_list_for_each_entry_safe(win, tmp, &bridge->windows) {
> +		struct resource *res = win->res;
> +
> +		if (resource_type(res) == IORESOURCE_MEM &&
> +		    !(res->flags & IORESOURCE_MEM_64)) {
> +			writel(ASPEED_REMAP_BAR_BASE(res->start),
> +			       pcie->reg + ASPEED_H2X_REMAP_DIRECT_ADDR);
> +			return 0;
> +		}
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static int aspeed_ast2700_setup(struct platform_device *pdev)
> +{
> +	struct aspeed_pcie *pcie = platform_get_drvdata(pdev);
> +	struct device *dev = pcie->dev;
> +	int ret;
> +
> +	pcie->cfg = syscon_regmap_lookup_by_phandle(dev->of_node,
> +						    "aspeed,pciecfg");
> +	if (IS_ERR(pcie->cfg))
> +		return dev_err_probe(dev, PTR_ERR(pcie->cfg),
> +				     "failed to map pciecfg base\n");
> +
> +	regmap_update_bits(pcie->cfg, ASPEED_SCU_60,
> +			   ASPEED_RC_E2M_PATH_EN | ASPEED_RC_H2XS_PATH_EN |
> +			   ASPEED_RC_H2XD_PATH_EN | ASPEED_RC_H2XX_PATH_EN |
> +			   ASPEED_RC_UPSTREAM_MEM_EN,
> +			   ASPEED_RC_E2M_PATH_EN | ASPEED_RC_H2XS_PATH_EN |
> +			   ASPEED_RC_H2XD_PATH_EN | ASPEED_RC_H2XX_PATH_EN |
> +			   ASPEED_RC_UPSTREAM_MEM_EN);
> +	regmap_write(pcie->cfg, ASPEED_SCU_64,
> +		     ASPEED_RC0_DECODE_DMA_BASE(0) |
> +		     ASPEED_RC0_DECODE_DMA_LIMIT(0xff) |
> +		     ASPEED_RC1_DECODE_DMA_BASE(0) |
> +		     ASPEED_RC1_DECODE_DMA_LIMIT(0xff));
> +	regmap_write(pcie->cfg, ASPEED_SCU_70, ASPEED_DISABLE_EP_FUNC);
> +
> +	aspeed_host_reset(pcie);
> +
> +	writel(0, pcie->reg + ASPEED_H2X_CTRL);
> +	writel(ASPEED_H2X_BRIDGE_EN | ASPEED_H2X_BRIDGE_DIRECT_EN,
> +	       pcie->reg + ASPEED_H2X_CTRL);
> +
> +	ret = aspeed_ast2700_ahb_remap_to_bar(pcie);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to assign BAR\n");

This is not assigning *BARs*.  A host bridge doesn't have BARs in the
PCI spec sense.  It might have programmable address ranges, but the
host bridge is not itself a PCI device, so its programmability is
device specific.

