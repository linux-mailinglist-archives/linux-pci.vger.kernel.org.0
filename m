Return-Path: <linux-pci+bounces-13032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E63975473
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 15:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30131C21EE0
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 13:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58529137750;
	Wed, 11 Sep 2024 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qN1c6w+6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299CB2F860;
	Wed, 11 Sep 2024 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062607; cv=none; b=iBBAI/2aK3Hk6byWkIBu0wSX5L+nwNRhrN3Jb3yl8O+waz2iF1RnfOsuwKFba/FnmV9YAyn9GtDTQ6GFfVVZHMLjzWb8iDsLi4qpzT2ovkZwryk495VBM/2zt27k+LW8+GthY96zaqRMoFKjArLRAq1MegWdPi6w4LnrFdfkaes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062607; c=relaxed/simple;
	bh=QocAosqKnmkPLqtvpXWONpcmXFjowZ3ECi7H4X+j2oE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=AHdh/28eGdYNXrr+GhBWg3v2OD7tBM+Xov1wNm8HtUuwRtgMu9sG6ehCp3sixa/6FjETHYZtE7FRYtBrqN5eQwagam8BFWnGtft9NX37Qg6nIU6iB4aH7anhrSlfB05zIpRhBOm6/tNr3RN5qoiEb4hZ8D5hBSf78NRdEDPv0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qN1c6w+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8347CC4CEC0;
	Wed, 11 Sep 2024 13:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726062606;
	bh=QocAosqKnmkPLqtvpXWONpcmXFjowZ3ECi7H4X+j2oE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=qN1c6w+6LSrhU0Qcz5h0tDXZ4qVm20XUSbvnG15YiOJjuOBX/NgfBRtZILRZ4Tp0J
	 2PdmOcMchraPgsend/Mpf8ZAPThX5oLMN8Z35DQ0qxMwxHRijwQWGHB3kcYQPeIydi
	 KIRo8cr4RqYmrubz9WpBMrCzxAxlENwTFilyq6Q9ChY1xiIs7Psot7pkVVgR6GIOjM
	 l/7shRlPjvy2tVtcJGqaxnL9t35BEHXm0XGdf//PPa1qzcWDgwYJqsM3ZWn0TkNCK7
	 jEe0OcD2TyEAnLHz1GQteOVpULqgQ5DFKI2eH0JXX0nKmiJ4lGqf5WgTTa12FIrdWy
	 G+9WLeATP0eZQ==
Date: Wed, 11 Sep 2024 08:50:05 -0500
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
Cc: linux-rpi-kernel@lists.infradead.org, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-kernel@vger.kernel.org, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Jonathan Bell <jonathan@raspberrypi.com>, 
 Nicolas Saenz Julienne <nsaenz@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Conor Dooley <conor+dt@kernel.org>, 
 Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org, 
 Phil Elwell <phil@raspberrypi.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 kw@linux.com, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Andrea della Porta <andrea.porta@suse.com>
In-Reply-To: <20240910151845.17308-1-svarbanov@suse.de>
References: <20240910151845.17308-1-svarbanov@suse.de>
Message-Id: <172606223862.90488.9381766906097869924.robh@kernel.org>
Subject: Re: [PATCH v2 -next 00/11] Add PCIe support for bcm2712


On Tue, 10 Sep 2024 18:18:34 +0300, Stanimir Varbanov wrote:
> Hello,
> 
> Here is a v2 of adding PCIe support for bcm2712 (RPi5), the fisrt
> version can be found at [1].
> 
> v2 is based on linux-next plus latest changes in pcie-brcmstb driver
> [2]. The changes recently made by Jim leaded to a simplified patchset
> for bcm2712 enablement coparing with previous version of this series.
> 
> Noticeable changes are:
> 
>  - Use of msi-range property in the MIP MSI-X controller and DT which
>  make possible to avoid few private DT properties. The other noticeable
>  change is moving of msi-pci-addr private property to a second 'reg'
>  region. I'll appreciate comments on this.
> 
>  - Now the PCIe DT nodes are on separate axi{} simple-bus because adding
>  it on soc{} adds too much churn in the node (Florian).
> 
>  - Added 'quirks' field in pcie_cfg_data to work around an issue (hw bug?)
>  with bridge_reset on bcm2712 SoC.
> 
> regards,
> ~Stan
> 
> [1] https://patchwork.kernel.org/project/linux-pci/cover/20240626104544.14233-1-svarbanov@suse.de/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/brcmstb
> 
> Stanimir Varbanov (11):
>   dt-bindings: interrupt-controller: Add bcm2712 MSI-X DT bindings
>   dt-bindings: PCI: brcmstb: Update bindings for PCIe on bcm2712
>   irqchip: mip: Add Broadcom bcm2712 MSI-X interrupt controller
>   PCI: brcmstb: Expand inbound size calculation helper
>   PCI: brcmstb: Restore CRS in RootCtl after prstn_n
>   PCI: brcmstb: Enable external MSI-X if available
>   PCI: brcmstb: Avoid turn off of bridge reset
>   PCI: brcmstb: Add bcm2712 support
>   PCI: brcmstb: Reuse config structure
>   arm64: dts: broadcom: bcm2712: Add PCIe DT nodes
>   arm64: dts: broadcom: bcm2712-rpi-5-b: Enable PCIe DT nodes
> 
>  .../brcm,bcm2712-msix.yaml                    |  69 ++++
>  .../bindings/pci/brcm,stb-pcie.yaml           |   5 +-
>  .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |   8 +
>  arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 166 ++++++++++
>  drivers/irqchip/Kconfig                       |  12 +
>  drivers/irqchip/Makefile                      |   1 +
>  drivers/irqchip/irq-bcm2712-mip.c             | 310 ++++++++++++++++++
>  drivers/pci/controller/pcie-brcmstb.c         | 172 +++++++---
>  8 files changed, 694 insertions(+), 49 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
>  create mode 100644 drivers/irqchip/irq-bcm2712-mip.c
> 
> --
> 2.35.3
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


New warnings running 'make CHECK_DTBS=y broadcom/bcm2712-rpi-5-b.dtb' for 20240910151845.17308-1-svarbanov@suse.de:

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






