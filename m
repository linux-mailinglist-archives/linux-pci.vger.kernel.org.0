Return-Path: <linux-pci+bounces-41256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 614EBC5E9FC
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 18:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 52C13361E04
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 17:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599032D3A93;
	Fri, 14 Nov 2025 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoCOcPaO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242782D24AD;
	Fri, 14 Nov 2025 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140795; cv=none; b=S6mcUi5fvHkbWhntWM7CAm2bwdlz/yHjzZqU41V0QGm2XbRhsBd9s08X1A4ztbLZw3P4MPcfe22cJA7au2IZ0lMtKtq5l7SG8it0zd/jEPzZzuHMDVkKI3RITJDO3/zfRmsTwkFTQelKramqc9uLlDw+eEdBVtlNZ7wcuJIFV1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140795; c=relaxed/simple;
	bh=Ry2NX3YpOns0VgrqIFLUrBPQMwDNS0mEtioSCIef/gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5VcG6eqbaGTojrwdiHqZfciYI/u9S2c1LGL0Y0mq9KBnuueFnsZgGIuP+aqupumatXZkhN1LuXoZ3bCNPKaT/jhUQGKG6ysHQhTITmJzLM5b9EitNeQQup9Cqq+ctBILb82oE54cyFtWCDxgUcJ7FxNrRqm0PZ0uYL7adqPBJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoCOcPaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83020C4CEF1;
	Fri, 14 Nov 2025 17:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763140794;
	bh=Ry2NX3YpOns0VgrqIFLUrBPQMwDNS0mEtioSCIef/gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OoCOcPaOU5UuKRnc7WU+t/JAHoUc3skwMmTFEXYt5RbezAa0rFQtVuNy0abPW8+RR
	 ROkw3svS8LHk6Kl+r87a8ImmmwKV2stsnQVdpGw4tmYuOAC5zVMCNC8/NBxA427Of3
	 lOWMR5YqYc4SYoeEEGn+iCNpBv6E5eb0h/VZu56UH7/O75cpemV13pO6YcDROm2tXx
	 33cN1KoHZ6LZbwheJwP/bqDvMBEFO64CcqpN5iYS4Tsqa7hYBapU7+7eiVlp14HKen
	 riQZswyhgKwLAxyp8t5pxR00nB0BfF+2CqkYq/w5QXAxHlnI4bclpkchUJcZuEvhex
	 LJ4wr5fJVqp2w==
Date: Fri, 14 Nov 2025 22:49:40 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v6 0/6] PCI: rzg3s-host: Add PCIe driver for Renesas
 RZ/G3S SoC
Message-ID: <akw7hzxci73gd7zlbo56matorjihffuq45l22mzkmavzlm66k7@zjujvakf76ve>
References: <20251029133653.2437024-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251029133653.2437024-1-claudiu.beznea.uj@bp.renesas.com>

On Wed, Oct 29, 2025 at 03:36:47PM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> Series adds a PCIe driver for the Renesas RZ/G3S SoC.
> It is split as follows:
> - patches 1-2/6:	add PCIe support for the RZ/G3S SoC
> - patches 3-6/6:	add device tree support and defconfig flag
> 
> Please provide your feedback.
> 
> Merge strategy, if any:
> - patches 1-2/6 can go through the PCI tree

Patch 2 is not applying on top of v6.18-rc1. Please fix it up and resend.

- Mani

> - patches 3-6/6 can go through the Renesas tree
> 
> Thank you,
> Claudiu Beznea
> 
> Changes in v6:
> - addressed review comments on DT bindings and driver code
> - per-patch changes are described in each individual patch
> 
> Changes in v5:
> - dropped patch
>   "arm64: dts: renesas: rzg3s-smarc-som: Update dma-ranges for PCIe"
>   and introduced patch
>   "arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock"
> - addressed review comments
> - per-patch changes are described in each individual patch
> 
> Changes in v4:
> - dropped v3 patches:
>   - "clk: renesas: r9a08g045: Add clocks and resets support for PCIe"
>   - "soc: renesas: rz-sysc: Add syscon/regmap support"
>   as they are already integrated
> - dropped v3 patch "PCI: of_property: Restore the arguments of the
>   next level parent" as it is not needed anymore in this version due
>   port being added in device tree
> - addressed review comments
> - per-patch changes are described in each individual patch
> 
> Changes in v3:
> - added patch "PCI: of_property: Restore the arguments of the next level parent"
>   to fix the legacy interrupt request
> - addressed review comments
> - per-patch changes are described in each individual patch
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
> Claudiu Beznea (6):
>   dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add Renesas RZ/G3S
>   PCI: rzg3s-host: Add Renesas RZ/G3S SoC host driver
>   arm64: dts: renesas: r9a08g045: Add PCIe node
>   arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock
>   arm64: dts: renesas: rzg3s-smarc: Enable PCIe
>   arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC
> 
>  .../bindings/pci/renesas,r9a08g045-pcie.yaml  |  249 +++
>  MAINTAINERS                                   |    8 +
>  arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |   65 +
>  .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |    5 +
>  arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |   11 +
>  arch/arm64/configs/defconfig                  |    1 +
>  drivers/pci/controller/Kconfig                |    9 +
>  drivers/pci/controller/Makefile               |    1 +
>  drivers/pci/controller/pcie-rzg3s-host.c      | 1759 +++++++++++++++++
>  9 files changed, 2108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
>  create mode 100644 drivers/pci/controller/pcie-rzg3s-host.c
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

