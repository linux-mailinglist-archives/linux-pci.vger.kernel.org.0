Return-Path: <linux-pci+bounces-8446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E78B9001B4
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 13:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8EA2890FF
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 11:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC30918629A;
	Fri,  7 Jun 2024 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlpvPN9b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E9A14F11B;
	Fri,  7 Jun 2024 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758871; cv=none; b=QMwjR7djhncNn0RG1rwNo6sghYeQ3JIYrFw1bAw/BL+PZ8UuVwW6wy0O2mWfLmvF3TYi1CF1UKjqqMGuacWjkwUCVK4jgsskCHOIY5JDfrDbCp4Qr93tW3iYdH/8U9BB5d/9biqhOLjLm6aRNVFHxj/WwbK06bV6w1kfM7qcbNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758871; c=relaxed/simple;
	bh=WhxnKeArialNnwgDswkaZyzrArAH2kwD9tF3d44YTdw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JM4x+7S2jrKPR1hGhbCJHO12B6UGJBUKgzgoKakwQGVylVooe45s1KVK7J5S5G2vcW/JmuyY9QDVf1p5eZClvb5riPBu5MQFj6RgHjzhOLlepJWbs0ZJ4SsIqrqp3Ux6NbJa8KNH+D4SDowE6ysT6FqB9XubAU9sMubY2SCd2sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlpvPN9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC529C2BBFC;
	Fri,  7 Jun 2024 11:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717758870;
	bh=WhxnKeArialNnwgDswkaZyzrArAH2kwD9tF3d44YTdw=;
	h=From:Subject:Date:To:Cc:From;
	b=LlpvPN9bE50QHsIVGieslzxlpxVk2fwPRhopJpVYiBoJ4fmYcNyBLGNdnRvwQ2JCk
	 zUzZEGdyBnRi0/GGcNuFkMsOaQYBmxIe2xVroWotGetKZ57d9syGJvliNkslq9AXdS
	 eTdn4/gCT9xA0MWJBB1ufnrLirLk2r064E5RPcCzMRhjolL8jn7VKBDox0O89V2OKF
	 wrRPQk/vKL6b3Wb/glFW/IL1A64kpAXOg1jMyzi0OwBZfcU/0yD8cC2mpjaaoCGNPu
	 VdA8nU6+SXKvna3oBG/pnFDkXe7vW9FAlrmE7n+nKZlJbAUzhpRwtuU5NvktRs8dQD
	 Cl4mWoLxAOE9w==
From: Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v5 00/13] PCI: dw-rockchip: Add endpoint mode support
Date: Fri, 07 Jun 2024 13:14:20 +0200
Message-Id: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIzrYmYC/33NwYrCMBAG4FeRnI1MJkkTPfkei4c0mdqgtCWVs
 lL67jt6WcUizOUf/vlmFiOVTKM4bGZRaMpj7jsOdrsRsQ3dmWROnAUCGjBoZOnjJbZ5kEPMJGm
 Qk5LeRedrVSWro+DLoVCTf5/qz4lzm8dbX+7PJ5N6bL97PCBrFQBTCqmycLxQ6ei668tZPMAJX
 xAN6wgyEqCxRBicq6sPRP8jFvw6ohlRznjiWg3efCDmBcH9OmIY0SkCNIQqOP+GLMvyB9Jil5O
 GAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10197; i=cassel@kernel.org;
 h=from:subject:message-id; bh=WhxnKeArialNnwgDswkaZyzrArAH2kwD9tF3d44YTdw=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKSXk90z9hvEnY7gCl4k/nTDZ4J9a0L/qw1VGJ5vMROm
 OG5oq1kRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACZy24qR4U2Ecr7AprhzRTeF
 Jl1mN7N0kai1a+ZbdiPga6/97r5kA4a/Ai9Ehd4m104/Nmve5r6ZcubansdVvunPCe9/KvP6aYQ
 gMwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

Hello all,

This series adds PCIe endpoint mode support for the rockchip rk3588 and
rk3568 SoCs.

This series is based on: pci/next
(git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git)

This series can also be found in git:
https://github.com/floatious/linux/commits/rockchip-pcie-ep-v5

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
Changes in v5:
- Picked up tags from Mani, thank you!
- Fixed minor nits in DT binding patch.
- Improved indentation in refactor patch.
- Reordered reg and reg-names after compatible.
- Fix Makefile to build driver if PCIE_ROCKCHIP_DW instead of
  PCIE_ROCKCHIP_DW_HOST (this was a bug).
- Clear the interrupt directly after reading the status, instead
  of at the end of the irq handler.
- Link to v4: https://lore.kernel.org/r/20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org

Changes in v4:
- Rebased on pci/next
- Link to v3: https://lore.kernel.org/r/20240508-rockchip-pcie-ep-v1-v3-0-1748e202b084@kernel.org

Changes in v3:
- Renamed rockchip_pcie_ltssm() to rockchip_pcie_get_ltssm()
- Reworded some commit messages to avoid the term "patches".
- Dropped patch that added explicit rockchip,rk3588-pcie compatible
- Moved !IS_ENABLED(CONFIG_PCIE_ROCKCHIP_DW_HOST) check to proper patch.
- Added comment in front of rk3588 epc_features describing why BAR4 is
  reserved.
- Added another struct epc_features for rk3568 as it does not have the
  ATU regs mapped to BAR4 (like rk3588 does).
- Picked up tags from Rob and Mani. Thank you!
- Link to v2: https://lore.kernel.org/r/20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org

Changes in v2:
- Rebased on v4 of the pci-epf-rework series that we depend on.
- Picked up tags from Rob.
- Split dw-rockchip DT binding in to common, RC and EP parts.
- Added support for rk3568 in DT binding and driver.
- Added a new patch that fixed "combined legacy IRQ description".
- Link to v1: https://lore.kernel.org/r/20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org

---
Niklas Cassel (13):
      dt-bindings: PCI: snps,dw-pcie-ep: Add vendor specific reg-name
      dt-bindings: PCI: snps,dw-pcie-ep: Add vendor specific interrupt-names
      dt-bindings: PCI: snps,dw-pcie-ep: Add tx_int{a,b,c,d} legacy irqs
      dt-bindings: PCI: rockchip-dw-pcie: Prepare for Endpoint mode support
      dt-bindings: PCI: rockchip-dw-pcie: Fix description of legacy irq
      dt-bindings: rockchip: Add DesignWare based PCIe Endpoint controller
      PCI: dw-rockchip: Fix weird indentation
      PCI: dw-rockchip: Add rockchip_pcie_get_ltssm() helper
      PCI: dw-rockchip: Refactor the driver to prepare for EP mode
      PCI: dw-rockchip: Add endpoint mode support
      misc: pci_endpoint_test: Add support for rockchip rk3588
      arm64: dts: rockchip: Add PCIe endpoint mode support
      arm64: dts: rockchip: Add rock5b overlays for PCIe endpoint mode

 .../bindings/pci/rockchip-dw-pcie-common.yaml      | 126 +++++++++
 .../bindings/pci/rockchip-dw-pcie-ep.yaml          |  95 +++++++
 .../devicetree/bindings/pci/rockchip-dw-pcie.yaml  |  93 +------
 .../devicetree/bindings/pci/snps,dw-pcie-ep.yaml   |  13 +-
 arch/arm64/boot/dts/rockchip/Makefile              |   5 +
 .../boot/dts/rockchip/rk3588-rock-5b-pcie-ep.dtso  |  25 ++
 .../dts/rockchip/rk3588-rock-5b-pcie-srns.dtso     |  16 ++
 arch/arm64/boot/dts/rockchip/rk3588.dtsi           |  35 +++
 drivers/misc/pci_endpoint_test.c                   |  11 +
 drivers/pci/controller/dwc/Kconfig                 |  21 +-
 drivers/pci/controller/dwc/Makefile                |   2 +-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c      | 307 +++++++++++++++++++--
 12 files changed, 623 insertions(+), 126 deletions(-)
---
base-commit: 3f7563262863c29368bd17ddeb44e3a95b5195bc
change-id: 20240424-rockchip-pcie-ep-v1-87c78b16d53c

Best regards,
-- 
Niklas Cassel <cassel@kernel.org>


