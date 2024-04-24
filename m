Return-Path: <linux-pci+bounces-6632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6F98B0DBF
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 17:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3A42844C4
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 15:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0A615EFD5;
	Wed, 24 Apr 2024 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gw8k1OCd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D6015EFCF;
	Wed, 24 Apr 2024 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971799; cv=none; b=uXR2HsPnEc41lu/UVWiqyBewPeuCpL8zeSTt2WuIdEvTqJJneh4zdZnadLZbIPhr/mJeIrWmynGB3fx190zMona9sPeCg725eWzQO/FgE6Ea+fahfB8CdbIyJO81EARC4cd2bGra3BxrUGFD0wySVT5uN3Q55KwHYI0cSKk8yVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971799; c=relaxed/simple;
	bh=J8FRUfoAx93F64x1FLvK1xeePpXLlisfpihv//NVh/E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bKuLN4nU3FQGig9q5YnXExQAJ7ZrGLmpKru4X5OZr4sCJGE7j6O2v+kV5DLgxH3jJORAi55rgVwu0Tmc/R92ftNk56KWOelQMvnkreLwNMDx4z5ZUXB/K2Ioh8cLMV4sXaG3wdTy8TBqwCPsZcpeA8jSQG9jK8vpQFWE/l5QtGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gw8k1OCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29955C113CD;
	Wed, 24 Apr 2024 15:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713971798;
	bh=J8FRUfoAx93F64x1FLvK1xeePpXLlisfpihv//NVh/E=;
	h=From:Subject:Date:To:Cc:From;
	b=gw8k1OCdPd8uoCy3OSrMCyYydbqzYpVgYwUxrGUn1EVVOJV+KT+8DFFLl3tytznpK
	 02nbVIOYSGtXDlOxa7fgKJI3+mSrtWzJtytbGgKywenR8IWe0olFG7+awqWufyi3fc
	 sqvIxVf90Bbnfm3bY6a3rMDQcsy9oX7p9NV9IJQFqUsJTxJlON9B3GyZE95/lwtgrT
	 +5e8vYRzkEqMBkSQirmZbdlgiRSCmujb7HtXze4ikkjeTyvGKrpNJGzwkUtPFyRBw/
	 9DoT0nfbI5U/Zb3bTmzd3D3rDJ6SmpLd7up19Gu4h3L+QybjBP30K96DiaOo7a2IHp
	 97XCfaCIR5zDA==
From: Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 00/12] PCI: dw-rockchip: Add endpoint mode support
Date: Wed, 24 Apr 2024 17:16:18 +0200
Message-Id: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEIiKWYC/x3MTQqAIBBA4avErBtQsx+6SrSoccohKFGIILx70
 vJbvPdC4iicYKxeiHxLkuss0HUF5JdzZxRXDEYZq6yxGC86yEvAQMLIAW+NQ0/9sOrOtQ1BKUP
 kTZ7/Os05fwhkb4VlAAAA
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Niklas Cassel <cassel@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Damien Le Moal <dlemoal@kernel.org>, Jon Lin <jon.lin@rock-chips.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Simon Xue <xxm@rock-chips.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9122; i=cassel@kernel.org;
 h=from:subject:message-id; bh=J8FRUfoAx93F64x1FLvK1xeePpXLlisfpihv//NVh/E=;
 b=kA0DAAoWyWQxo5nGTXIByyZiAGYpIk3IYJ91XE+6V7WXux9KcYV2X76My91+maBs181h1fwFn
 4h1BAAWCgAdFiEETfhEv3OLR5THIdw8yWQxo5nGTXIFAmYpIk0ACgkQyWQxo5nGTXIAHgEA4n15
 CPY9ddjPMQUZVL6gzqYgKQnqfsnT1DBP0IA0Jc8A/2gosUiMyWySP1F4qq9B3HycWaFvjpMR3o4
 l69pclO4O
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

Hello all,

This series adds PCIe endpoint mode support for the rockchip rk3588 SoC.

This series is based on: pci/next
(git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git)

This series has the following dependencies:
1) https://lore.kernel.org/linux-pci/20240418-pci-epf-rework-v3-0-222a5d1ed2e5@linaro.org/
The series in 1) has not been merged to pci/next yet.

2) https://lore.kernel.org/linux-phy/20240412125818.17052-1-cassel@kernel.org/
The series in 2) has already been merged to phy/next.

Even though this series (the series in $subject) has a runtime dependency
on the changes that are currently queued in the PHY tree, there is no need
to coordinate between the PCI tree and the PHY tree (i.e. this series can
be merged via the PCI tree even for the coming merge window (v6.10-rc1)).

This is because there is no compile time dependency between the changes in
the PHY tree and this series. Likewise, the device tree overlays in this
series passes "make CHECK_DTBS=y" even without the changes in the PHY tree.

This series (including dependencies) can also be found in git:
https://github.com/floatious/linux/commits/rockchip-pcie-ep-v1

Testing done:
This series has been tested with two rock5b:s, one running in RC mode and
one running in EP mode. This series has also been tested with an Intel x86
host and rock5b running in EP mode.

BAR4 exposes the ATU Port Logic Structure and the DMA Port Logic Structure
to the host. The EPC controller driver thus disables this BAR as init time,
because if it doesn't, when the host writes the test pattern to this BAR,
all the iATU settings will get wiped, resulting in all further BAR accesses
being non-functional.

Running pcitest.sh (modified to also perform the READ and WRITE tests with
the -d option, i.e. with DMA enabled) results in the following:

$ /usr/bin/pcitest.sh
BAR tests

BAR0:           OKAY
BAR1:           OKAY
BAR2:           OKAY
BAR3:           OKAY
BAR4:           NOT OKAY
BAR5:           OKAY

Interrupt tests

SET IRQ TYPE TO LEGACY:         OKAY
LEGACY IRQ:     NOT OKAY
SET IRQ TYPE TO MSI:            OKAY
MSI1:           OKAY
MSI2:           OKAY
MSI3:           OKAY
MSI4:           OKAY
MSI5:           OKAY
MSI6:           OKAY
MSI7:           OKAY
MSI8:           OKAY
MSI9:           OKAY
MSI10:          OKAY
MSI11:          OKAY
MSI12:          OKAY
MSI13:          OKAY
MSI14:          OKAY
MSI15:          OKAY
MSI16:          OKAY
MSI17:          OKAY
MSI18:          OKAY
MSI19:          OKAY
MSI20:          OKAY
MSI21:          OKAY
MSI22:          OKAY
MSI23:          OKAY
MSI24:          OKAY
MSI25:          OKAY
MSI26:          OKAY
MSI27:          OKAY
MSI28:          OKAY
MSI29:          OKAY
MSI30:          OKAY
MSI31:          OKAY
MSI32:          OKAY

SET IRQ TYPE TO MSI-X:          OKAY
MSI-X1:         OKAY
MSI-X2:         OKAY
MSI-X3:         OKAY
MSI-X4:         OKAY
MSI-X5:         OKAY
MSI-X6:         OKAY
MSI-X7:         OKAY
MSI-X8:         OKAY
MSI-X9:         OKAY
MSI-X10:                OKAY
MSI-X11:                OKAY
MSI-X12:                OKAY
MSI-X13:                OKAY
MSI-X14:                OKAY
MSI-X15:                OKAY
MSI-X16:                OKAY
MSI-X17:                OKAY
MSI-X18:                OKAY
MSI-X19:                OKAY
MSI-X20:                OKAY
MSI-X21:                OKAY
MSI-X22:                OKAY
MSI-X23:                OKAY
MSI-X24:                OKAY
MSI-X25:                OKAY
MSI-X26:                OKAY
MSI-X27:                OKAY
MSI-X28:                OKAY
MSI-X29:                OKAY
MSI-X30:                OKAY
MSI-X31:                OKAY
MSI-X32:                OKAY

Read Tests

SET IRQ TYPE TO MSI:            OKAY
READ (      1 bytes):           OKAY
READ (   1024 bytes):           OKAY
READ (   1025 bytes):           OKAY
READ (1024000 bytes):           OKAY
READ (1024001 bytes):           OKAY

Write Tests

WRITE (      1 bytes):          OKAY
WRITE (   1024 bytes):          OKAY
WRITE (   1025 bytes):          OKAY
WRITE (1024000 bytes):          OKAY
WRITE (1024001 bytes):          OKAY

Copy Tests

COPY (      1 bytes):           OKAY
COPY (   1024 bytes):           OKAY
COPY (   1025 bytes):           OKAY
COPY (1024000 bytes):           OKAY
COPY (1024001 bytes):           OKAY

Read Tests DMA

READ (      1 bytes):           OKAY
READ (   1024 bytes):           OKAY
READ (   1025 bytes):           OKAY
READ (1024000 bytes):           OKAY
READ (1024001 bytes):           OKAY

Write Tests DMA

WRITE (      1 bytes):          OKAY
WRITE (   1024 bytes):          OKAY
WRITE (   1025 bytes):          OKAY
WRITE (1024000 bytes):          OKAY
WRITE (1024001 bytes):          OKAY

Corresponding output on the EP side:
rockchip-dw-pcie a40000000.pcie-ep: EP cannot raise INTX IRQs
pci_epf_test pci_epf_test.0: WRITE => Size: 1 B, DMA: NO, Time: 0.000000292 s, Rate: 3424 KB/s
pci_epf_test pci_epf_test.0: WRITE => Size: 1024 B, DMA: NO, Time: 0.000007583 s, Rate: 135038 KB/s
pci_epf_test pci_epf_test.0: WRITE => Size: 1025 B, DMA: NO, Time: 0.000007584 s, Rate: 135152 KB/s
pci_epf_test pci_epf_test.0: WRITE => Size: 1024000 B, DMA: NO, Time: 0.009164167 s, Rate: 111739 KB/s
pci_epf_test pci_epf_test.0: WRITE => Size: 1024001 B, DMA: NO, Time: 0.009164458 s, Rate: 111736 KB/s
pci_epf_test pci_epf_test.0: READ => Size: 1 B, DMA: NO, Time: 0.000001750 s, Rate: 571 KB/s
pci_epf_test pci_epf_test.0: READ => Size: 1024 B, DMA: NO, Time: 0.000147875 s, Rate: 6924 KB/s
pci_epf_test pci_epf_test.0: READ => Size: 1025 B, DMA: NO, Time: 0.000149041 s, Rate: 6877 KB/s
pci_epf_test pci_epf_test.0: READ => Size: 1024000 B, DMA: NO, Time: 0.147537833 s, Rate: 6940 KB/s
pci_epf_test pci_epf_test.0: READ => Size: 1024001 B, DMA: NO, Time: 0.147533750 s, Rate: 6940 KB/s
pci_epf_test pci_epf_test.0: COPY => Size: 1 B, DMA: NO, Time: 0.000003208 s, Rate: 311 KB/s
pci_epf_test pci_epf_test.0: COPY => Size: 1024 B, DMA: NO, Time: 0.000156625 s, Rate: 6537 KB/s
pci_epf_test pci_epf_test.0: COPY => Size: 1025 B, DMA: NO, Time: 0.000158375 s, Rate: 6471 KB/s
pci_epf_test pci_epf_test.0: COPY => Size: 1024000 B, DMA: NO, Time: 0.156902666 s, Rate: 6526 KB/s
pci_epf_test pci_epf_test.0: COPY => Size: 1024001 B, DMA: NO, Time: 0.156847833 s, Rate: 6528 KB/s
pci_epf_test pci_epf_test.0: WRITE => Size: 1 B, DMA: YES, Time: 0.000185500 s, Rate: 5 KB/s
pci_epf_test pci_epf_test.0: WRITE => Size: 1024 B, DMA: YES, Time: 0.000177334 s, Rate: 5774 KB/s
pci_epf_test pci_epf_test.0: WRITE => Size: 1025 B, DMA: YES, Time: 0.000178792 s, Rate: 5732 KB/s
pci_epf_test pci_epf_test.0: WRITE => Size: 1024000 B, DMA: YES, Time: 0.000486209 s, Rate: 2106090 KB/s
pci_epf_test pci_epf_test.0: WRITE => Size: 1024001 B, DMA: YES, Time: 0.000486791 s, Rate: 2103574 KB/s
pci_epf_test pci_epf_test.0: READ => Size: 1 B, DMA: YES, Time: 0.000177333 s, Rate: 5 KB/s
pci_epf_test pci_epf_test.0: READ => Size: 1024 B, DMA: YES, Time: 0.000177625 s, Rate: 5764 KB/s
pci_epf_test pci_epf_test.0: READ => Size: 1025 B, DMA: YES, Time: 0.000171208 s, Rate: 5986 KB/s
pci_epf_test pci_epf_test.0: READ => Size: 1024000 B, DMA: YES, Time: 0.000701167 s, Rate: 1460422 KB/s
pci_epf_test pci_epf_test.0: READ => Size: 1024001 B, DMA: YES, Time: 0.000702625 s, Rate: 1457393 KB/s

Kind regards,
Niklas

---
Niklas Cassel (12):
      dt-bindings: PCI: snps,dw-pcie-ep: Add vendor specific reg-name
      dt-bindings: PCI: snps,dw-pcie-ep: Add vendor specific interrupt-names
      dt-bindings: PCI: snps,dw-pcie-ep: Add tx_int{a,b,c,d} legacy irqs
      dt-bindings: rockchip: Add DesignWare based PCIe Endpoint controller
      PCI: dw-rockchip: Fix weird indentation
      PCI: dw-rockchip: Add rockchip_pcie_ltssm() helper
      PCI: dw-rockchip: Refactor the driver to prepare for EP mode
      PCI: dw-rockchip: Add explicit rockchip,rk3588-pcie compatible
      PCI: dw-rockchip: Add endpoint mode support
      misc: pci_endpoint_test: Add support for rockchip rk3588
      arm64: dts: rockchip: Add PCIe endpoint mode support
      arm64: dts: rockchip: Add rock5b overlays for PCIe endpoint mode

 .../bindings/pci/rockchip-dw-pcie-ep.yaml          | 192 +++++++++++++++
 .../devicetree/bindings/pci/snps,dw-pcie-ep.yaml   |  13 +-
 arch/arm64/boot/dts/rockchip/Makefile              |   5 +
 .../boot/dts/rockchip/rk3588-rock-5b-pcie-ep.dtso  |  25 ++
 .../dts/rockchip/rk3588-rock-5b-pcie-srns.dtso     |  16 ++
 arch/arm64/boot/dts/rockchip/rk3588.dtsi           |  35 +++
 drivers/misc/pci_endpoint_test.c                   |  11 +
 drivers/pci/controller/dwc/Kconfig                 |  17 +-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c      | 263 +++++++++++++++++++--
 9 files changed, 552 insertions(+), 25 deletions(-)
---
base-commit: b88f21dc523c39db93b1d3e29c4ede34ac8cdc3c
change-id: 20240424-rockchip-pcie-ep-v1-87c78b16d53c

Best regards,
-- 
Niklas Cassel <cassel@kernel.org>


