Return-Path: <linux-pci+bounces-25007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84635A766EC
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 15:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CCE188B737
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 13:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F212E212FAB;
	Mon, 31 Mar 2025 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8wfqMOR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C1E212B3D;
	Mon, 31 Mar 2025 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743427965; cv=none; b=PGhLA7m2DfzGeTCKIsr798qKBD5JQOHICabLzJTp7rWOGgDHO3mJmjfp6KlqXN/GCarhRJ2J5InNHwA3dlInyfnp6Rsf4ZfGca+ovS48Rn5wk58L9aS75j94iJ+pPV822zVFT9awQfhqZbngXMLwqREsw+vwr3Nk3+U8DcWcsXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743427965; c=relaxed/simple;
	bh=wCPV4I6wxnXDIBDU9w1IluZ+zjKn8hfElMW+5JaDEC0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=jQtazTfww9BdSx/BUr7KO3dEjmmXnoHP/kmISBsyZJbf8PNyd9l5I29SN99OiHfU7DNsZ7uzrkXkdeiNuOaSeHp3/5n45ruQe5RK0QEMm6LyhXGPnWN33Wy7fVOyXZ45h8u1lgwniuUvXgOxXk8EuW77RZo/EQWkSVHTS2ba4fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8wfqMOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA63C4CEE9;
	Mon, 31 Mar 2025 13:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743427965;
	bh=wCPV4I6wxnXDIBDU9w1IluZ+zjKn8hfElMW+5JaDEC0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=l8wfqMOR3nQ2jR199RvQllaryJPM3uSggSgD0a6d3Q+FS/v9hTzWlrmZ8HXw87d5o
	 a6IiI+sQ8X6AOo78ctWlNfCMqWJq9/vc4YAHT2WRPsMfCLzxuINRjmGcUYNi0zgHv+
	 43vldzx4q0+HmAnMml1kMGBwt4P8zeC7LxMM320Ue+H20uEO3MmMQhwTRdMBWHESuo
	 ELRDW1IDQESY8y3t4LHdIdzxTjIHBjrRbQkzJ5Y20g9jM2A42zVMCH+5RZAQ+OPxgI
	 MV8KqT8kmc+ZnbrVOoUa4bvHm7si9bj41qLY5kAUhS5vDKd0Gd0LbHivEeHzTR0Kwx
	 wG4V4NpoOL3wA==
Date: Mon, 31 Mar 2025 08:32:44 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Aradhya Bhatia <a-bhatia1@ti.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 linux-renesas-soc@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 linux-kernel@vger.kernel.org, Junhao Xie <bigfoot@classfun.cn>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250330195715.332106-1-marek.vasut+renesas@mailbox.org>
References: <20250330195715.332106-1-marek.vasut+renesas@mailbox.org>
Message-Id: <174342765546.2641812.18254954916877172569.robh@kernel.org>
Subject: Re: [PATCH 0/4] arm64: dts: renesas: r8a779g3: Add Renesas R-Car
 V4H Sparrow Hawk board support


On Sun, 30 Mar 2025 21:56:08 +0200, Marek Vasut wrote:
> Add Renesas R-Car V4H Sparrow Hawk board based on R-Car V4H ES3.0 (R8A779G3)
> SoC. This is a single-board computer with single gigabit ethernet, DSI-to-eDP
> bridge, DSI and two CSI2 interfaces, audio codec, two CANFD ports, micro SD
> card slot, USB PD supply, USB 3.0 ports, M.2 Key-M slot for NVMe SSD, debug
> UART and JTAG.
> 
> The board uses split clock for PCIe controller and device, which requires
> slight extension of rcar-gen4-pci-host.yaml DT schema, to cover this kind
> of description. The DWC PCIe controller driver already supports this mode
> of clock operation, hence no driver change is needed.
> 
> Marek Vasut (4):
>   dt-bindings: PCI: rcar-gen4-pci-host: Document optional aux clock
>   dt-bindings: vendor-prefixes: Add Retronix Technology Inc.
>   dt-bindings: soc: renesas: Document Renesas R-Car V4H Sparrow Hawk
>     board support
>   arm64: dts: renesas: r8a779g3: Add Renesas R-Car V4H Sparrow Hawk
>     board support
> 
>  .../bindings/pci/rcar-gen4-pci-host.yaml      |   8 +-
>  .../bindings/soc/renesas/renesas.yaml         |   7 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/arm64/boot/dts/renesas/Makefile          |   2 +
>  .../dts/renesas/r8a779g3-sparrow-hawk.dts     | 671 ++++++++++++++++++
>  5 files changed, 687 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
> 
> ---
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: "Rafał Miłecki" <rafal@milecki.pl>
> Cc: Aradhya Bhatia <a-bhatia1@ti.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Junhao Xie <bigfoot@classfun.cn>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> 
> --
> 2.47.2
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/next-20250328 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/renesas/' for 20250330195715.332106-1-marek.vasut+renesas@mailbox.org:

arch/arm64/boot/dts/renesas/r8a779g0-white-hawk.dtb: pcie@e65d0000: clock-names: ['core', 'ref'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rcar-gen4-pci-host.yaml#
arch/arm64/boot/dts/renesas/r8a779g0-white-hawk.dtb: pcie@e65d8000: clock-names: ['core', 'ref'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rcar-gen4-pci-host.yaml#
arch/arm64/boot/dts/renesas/r8a779g2-white-hawk-single.dtb: pcie@e65d0000: clock-names: ['core', 'ref'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rcar-gen4-pci-host.yaml#
arch/arm64/boot/dts/renesas/r8a779g2-white-hawk-single.dtb: pcie@e65d8000: clock-names: ['core', 'ref'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rcar-gen4-pci-host.yaml#
arch/arm64/boot/dts/renesas/r8a779f4-s4sk.dtb: pcie@e65d0000: clock-names: ['core', 'ref'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rcar-gen4-pci-host.yaml#
arch/arm64/boot/dts/renesas/r8a779f4-s4sk.dtb: pcie@e65d8000: clock-names: ['core', 'ref'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rcar-gen4-pci-host.yaml#
arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dtb: pcie@e65d0000: clock-names: ['core', 'ref'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rcar-gen4-pci-host.yaml#
arch/arm64/boot/dts/renesas/r8a779g3-white-hawk-single.dtb: pcie@e65d0000: clock-names: ['core', 'ref'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rcar-gen4-pci-host.yaml#
arch/arm64/boot/dts/renesas/r8a779g3-white-hawk-single.dtb: pcie@e65d8000: clock-names: ['core', 'ref'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rcar-gen4-pci-host.yaml#
arch/arm64/boot/dts/renesas/r8a779f0-spider.dtb: pcie@e65d0000: clock-names: ['core', 'ref'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rcar-gen4-pci-host.yaml#
arch/arm64/boot/dts/renesas/r8a779f0-spider.dtb: pcie@e65d8000: clock-names: ['core', 'ref'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rcar-gen4-pci-host.yaml#
arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtb: pcie@e65d0000: clock-names: ['core', 'ref'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rcar-gen4-pci-host.yaml#
arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtb: pcie@e65d8000: clock-names: ['core', 'ref'] is too short
	from schema $id: http://devicetree.org/schemas/pci/rcar-gen4-pci-host.yaml#






