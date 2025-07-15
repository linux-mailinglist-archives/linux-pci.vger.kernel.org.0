Return-Path: <linux-pci+bounces-32163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC29AB061EF
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 16:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7297F173318
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 14:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71401E1E16;
	Tue, 15 Jul 2025 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhOI4oOc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8378C17B425;
	Tue, 15 Jul 2025 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590778; cv=none; b=oIsgVK+PkQp35W7/T6IOb+7tjntXPjtmQi+sZzw6hr4tagyaKS3SNjPN4Vbi+aJzg0YCvBVFLmfP9XLmAFvqmp5jChfIhiXSt5AlUanAx83252qFKUchiKVawJ9wqgDjxvEUXwxhDyhFHsagwQw4J05oBPnuGrOo6zyjU7ApN8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590778; c=relaxed/simple;
	bh=KZ1W7mzel2tzyENmIY/KyfG+sQOyLDK8atG59n7g34U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=g0c9EwCV6Sy199W37aG0IpkDavxAGlHDAIXgHJWTElUa7K6i5KqvhwIRSYz33hAm9fNHl+4aC988p/J6r+bH8m6DfD+8hw1yL9TWK2P3bb2QoufPEqtQTChFl2b3wiSNojuJLr9OmgpUxfR/d8YkeFIQqqELDnZH8OodCiUn3AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhOI4oOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3826DC4CEE3;
	Tue, 15 Jul 2025 14:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752590778;
	bh=KZ1W7mzel2tzyENmIY/KyfG+sQOyLDK8atG59n7g34U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nhOI4oOcjdEd81/BA+chqSa9l8uanzEnEhr+bgfqoi60EpD0cwakUJpbZX2fvZD9c
	 h0r1Tl3SHdyGUqyNniLCPaRBLWnhR4Mw4wlI0b9cxK2s7FO/4PCh/z68CLf37uqsbN
	 Ss57RFtoC1bv1VmoENClwao3WYlFrjJ6yC7SIvm9bi5akXlS/Oy+9OsgqHLoZsWQN+
	 aOS+cqX7rXhgqW0olOrGTZRfSSAUFdUoXJJXA1aV5LA9A12qLH5D2M+l2ZRGSowLbs
	 FUNKbLBEz/i0hS2tpLxxlwcQJOY2rIHFi2EcPvKl2lBHzOWGB1F27V57vVQ2nL9Xb7
	 ZNVpaMdVZGo+Q==
Date: Tue, 15 Jul 2025 09:46:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	john.madieu.xa@bp.renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2 0/8] PCI: rzg3s-host: Add PCIe driver for Renesas
 RZ/G3S SoC
Message-ID: <20250715144616.GA2458869@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530111917.1495023-1-claudiu.beznea.uj@bp.renesas.com>

On Fri, May 30, 2025 at 02:19:09PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> Series adds a PCIe driver for the Renesas RZ/G3S SoC.
> It is split as follows:
> - patch 1/8:		updates the max register offset for RZ/G3S SYSC;
> 			this is necessary as the PCIe need to setup the
> 			SYSC for proper functioning
> - patch 2/8:		adds clock, reset and power domain support for
> 			the PCIe IP
> - patches 3-4/8:	add PCIe support for the RZ/G3S SoC
> - patches 5-8/8:	add device tree support and defconfig flag
> 
> Please provide your feedback.
> 
> Merge strategy, if any:
> - patches 1-2,5-8/8 can go through the Renesas tree
> - patches 3-4/8 can go through the PCI tree
> 
> Thank you,
> Claudiu Beznea
> 
> Changes in v2:
> - dropped "of/irq: Export of_irq_count()" as it is not needed anymore
>   in this version
> - added "arm64: dts: renesas: rzg3s-smarc-som: Update dma-ranges for PCIe"
>   to reflect the board specific memory constraints
> - addressed review comments
> - updated patch "soc: renesas: rz-sysc: Add syscon/regmap support"
> - per-patch changes are described in each individual patch
> 
> Claudiu Beznea (7):
>   clk: renesas: r9a08g045: Add clocks, resets and power domain support
>     for the PCIe
>   dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add documentation for the
>     PCIe IP on Renesas RZ/G3S
>   PCI: rzg3s-host: Add Initial PCIe Host Driver for Renesas RZ/G3S SoC
>   arm64: dts: renesas: r9a08g045s33: Add PCIe node
>   arm64: dts: renesas: rzg3s-smarc-som: Update dma-ranges for PCIe
>   arm64: dts: renesas: rzg3s-smarc: Enable PCIe
>   arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC
> 
> John Madieu (1):
>   soc: renesas: rz-sysc: Add syscon/regmap support
> 
>  .../pci/renesas,r9a08g045s33-pcie.yaml        |  202 ++
>  MAINTAINERS                                   |    8 +
>  arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi |   60 +
>  .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |    5 +
>  arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |   11 +
>  arch/arm64/configs/defconfig                  |    1 +
>  drivers/clk/renesas/r9a08g045-cpg.c           |   19 +
>  drivers/pci/controller/Kconfig                |    7 +
>  drivers/pci/controller/Makefile               |    1 +
>  drivers/pci/controller/pcie-rzg3s-host.c      | 1686 +++++++++++++++++
>  drivers/soc/renesas/Kconfig                   |    1 +
>  drivers/soc/renesas/r9a08g045-sysc.c          |   10 +
>  drivers/soc/renesas/r9a09g047-sys.c           |   10 +
>  drivers/soc/renesas/r9a09g057-sys.c           |   10 +
>  drivers/soc/renesas/rz-sysc.c                 |   17 +-
>  drivers/soc/renesas/rz-sysc.h                 |    3 +
>  16 files changed, 2050 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml
>  create mode 100644 drivers/pci/controller/pcie-rzg3s-host.c

Where are we at with this series?

I see
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc-stm32&id=5a972a01e24b278f7302a834c6eaee5bdac12843,
but also this kernel robot report at that commit:
https://lore.kernel.org/all/202506270620.sf6EApJY-lkp@intel.com/

I normally don't include branches in pci/next until we get a
"BUILD SUCCESS" report from the robot, so this branch is in limbo at
the moment.

Bjorn

