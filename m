Return-Path: <linux-pci+bounces-14478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6114599CC39
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 16:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800AA1C210BE
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 14:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82E91AC8A6;
	Mon, 14 Oct 2024 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wb+SUd2f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80CC1AC885;
	Mon, 14 Oct 2024 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914732; cv=none; b=lqjoMm94KgBw1+vfuMCyA6nNiplgwgJ32bGhzYQonX6SQtr8zxoQzt7KJImPFagazok5AC18Ze+JA41xSZieAMoKhO+ahSY7EUkvZn+qevTSOHw85fpsngHEJgMkWkhJ6tWHCbqOSvU+Eq8jar6C7qnhUxY5KfrrDR/bkmTKy9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914732; c=relaxed/simple;
	bh=eiBz2oCRNLu1LEWaYxV3JYICGOhv3PmcLnzaYHKoTsA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=EHvJSzjajOs1aAvVhBFr+bWLrkk/owgyywZJ8PkTdJsoQrIuB9EpKLuR8kiy4x7DkAlcVT+rEvh0eRWrRKlSs4LiNF9RdR77aYvShTVMaExXBPPfPJEflqz1oSn55zV6xyQX7XwWsMU1j+KD3aFttKkE+QarqNTYJUAAMub/UWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wb+SUd2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CE1C4CEC3;
	Mon, 14 Oct 2024 14:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728914732;
	bh=eiBz2oCRNLu1LEWaYxV3JYICGOhv3PmcLnzaYHKoTsA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Wb+SUd2fDKIJr+msk5x3l2yLqY3VO+INwsSJZKHSEkiDTZ0pA/0xbALhBAIUW3X3Z
	 uGQ4DA23I85earVnDxoSQJKCvKvKJRm3TwT73BRBuav6bNkGZWOGEjr4dWXJCWbo8R
	 PylLhpjo6N27F3LAIJmrBPF7caftb4eex5+yyHRVO5JHtoLmmNnVdgmDtQQeyhwCic
	 bXG4ZY8FkKX8rY5sb1oTTfKNIJxGAdEmDwO/w1NzyeidGcctrTTt5sr8FGxwOfy3Rd
	 3DpBPhx2/dwAHagI8M+BxueQwEYvVD4TaFZLKeBAuTuLUBnc8JthOL1uMUVOlLwjoI
	 nai7lYSRZy8lA==
Date: Mon, 14 Oct 2024 09:05:31 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 Jonathan Bell <jonathan@raspberrypi.com>, 
 Jim Quinlan <jim2101024@gmail.com>, linux-rpi-kernel@lists.infradead.org, 
 kw@linux.com, Andrea della Porta <andrea.porta@suse.com>, 
 devicetree@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Nicolas Saenz Julienne <nsaenz@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20241014130710.413-1-svarbanov@suse.de>
References: <20241014130710.413-1-svarbanov@suse.de>
Message-Id: <172891445648.1127418.3673645217921706886.robh@kernel.org>
Subject: Re: [PATCH v3 00/11] Add PCIe support for bcm2712


On Mon, 14 Oct 2024 16:06:59 +0300, Stanimir Varbanov wrote:
> Hello,
> 
> Here is v3 the series to add support for PCIe on bcm2712 SoC
> used by RPi5. Previous v2 can be found at [1].
> 
> v2 -> v3 changes include:
>  - Added Reviewed-by/Acked-by tags.
>  - MIP MSI-X driver has been converted to MSI parent.
>  - Added a new patch for PHY PLL adjustment need to succesfully
>    enumerate PCIe endpoints on extension connector (tested with
>    Pineboards AI Bundle + NVME SSD adapter card).
>  - Re-introduced brcm,msi-offset DT private property for MIP
>    interrupt-controller (without it I'm anable to use the interrupts
>    of adapter cards on PCIe enxtension connector).
> 
> For more info check patches.
> 
> [1] https://patchwork.kernel.org/project/linux-pci/cover/20240910151845.17308-1-svarbanov@suse.de/
> 
> Stanimir Varbanov (11):
>   dt-bindings: interrupt-controller: Add bcm2712 MSI-X DT bindings
>   dt-bindings: PCI: brcmstb: Update bindings for PCIe on bcm2712
>   irqchip: mip: Add Broadcom bcm2712 MSI-X interrupt controller
>   PCI: brcmstb: Expand inbound size calculation helper
>   PCI: brcmstb: Enable external MSI-X if available
>   PCI: brcmstb: Avoid turn off of bridge reset
>   PCI: brcmstb: Add bcm2712 support
>   PCI: brcmstb: Reuse config structure
>   PCI: brcmstb: Adjust PHY PLL setup to use a 54MHz input refclk
>   arm64: dts: broadcom: bcm2712: Add PCIe DT nodes
>   arm64: dts: broadcom: bcm2712-rpi-5-b: Enable PCIe DT nodes
> 
>  .../brcm,bcm2712-msix.yaml                    |  60 ++++
>  .../bindings/pci/brcm,stb-pcie.yaml           |   5 +-
>  .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |   8 +
>  arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 160 +++++++++
>  drivers/irqchip/Kconfig                       |  16 +
>  drivers/irqchip/Makefile                      |   1 +
>  drivers/irqchip/irq-bcm2712-mip.c             | 308 ++++++++++++++++++
>  drivers/pci/controller/pcie-brcmstb.c         | 197 ++++++++---
>  8 files changed, 707 insertions(+), 48 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
>  create mode 100644 drivers/irqchip/irq-bcm2712-mip.c
> 
> --
> 2.43.0
> 
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


New warnings running 'make CHECK_DTBS=y broadcom/bcm2712-rpi-5-b.dtb' for 20241014130710.413-1-svarbanov@suse.de:

arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@100000: resets: [[12, 42], [13]] is too short
	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@100000: reset-names:0: 'rescal' was expected
	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@100000: reset-names:1: 'bridge' was expected
	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@100000: reset-names: ['bridge', 'rescal'] is too short
	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@110000: 'msi-controller' is a required property
	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@110000: resets: [[12, 43], [13]] is too short
	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@110000: reset-names:0: 'rescal' was expected
	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@110000: reset-names:1: 'bridge' was expected
	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@110000: reset-names: ['bridge', 'rescal'] is too short
	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@120000: 'msi-controller' is a required property
	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@120000: resets: [[12, 44], [13]] is too short
	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@120000: reset-names:0: 'rescal' was expected
	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@120000: reset-names:1: 'bridge' was expected
	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@120000: reset-names: ['bridge', 'rescal'] is too short
	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#






