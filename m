Return-Path: <linux-pci+bounces-42337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DB482C95CD7
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 07:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 522DA342C9B
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 06:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA83279DCA;
	Mon,  1 Dec 2025 06:29:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC4278753;
	Mon,  1 Dec 2025 06:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764570567; cv=none; b=Pv9ypTcLF5PvEyAmncG2yLitpR29aXfk8LMb0uaNfgzyW3gJvibM2E66IoTy4oax4yoLpN/cRX6NtVs8WpqUZ4tI7xdB/G+L0nnTY9RaGw+ZIG13AkkSwkVZ7AJdi/Uww6lYK4cBIHlvUeT6qf1NF+z7GYV1e+QJIfBCemIK9LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764570567; c=relaxed/simple;
	bh=PYc7RKtTrKYB/n8rcchUdu0GnArVjz+/Dm3h2uX0+i4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=iN5v8bIADbmI83A/hqqqifHfTxr4ynh7aClFgyO52PxMCXr7dJ+acx4arwN5Pp7TNLk2fN2kaXj02boHUSIRh0i8ks6wWJPHoU/Gz+Msn5h1qnbVni9DprJhGknAXmbjo7+0Uh2mNzt2neWfMg4eL51vXZh+InstkgOcP+LGgfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 1 Dec
 2025 14:29:16 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 1 Dec 2025 14:29:16 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Subject: [PATCH v6 0/7] Add ASPEED PCIe Root Complex support
Date: Mon, 1 Dec 2025 14:29:10 +0800
Message-ID: <20251201-upstream_pcie_rc-v6-0-8c8800c56b16@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALY1LWkC/43QQW7DIBCF4atErIs1wzAGd9V7VJVFMKlpldgCx
 0oU+e4hXtSLLNLlQ/r+kbiJHFIMWbzvbiKFOeY4nMqo33bC9+70HWTsyhYKFCMCyfOYpxTcsR1
 9DG3y0mrNhptub5FEYWMKh3hZk59fZfcxT0O6rhdmfLyuMaiRgAgAK0KmmoxE+eP877X1/XD+c
 HkMoZuC7ys/HMWjNKtNG2QgTQoqxUz2P5o23QACc6NUhUUzw2ut/zSCMtCwVVyhRazxNeYNI5r
 nP5xZgtxrh41lUzt/eKosy3IHIntzS6wBAAA=
X-Change-ID: 20251103-upstream_pcie_rc-8445759db813
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan
 Sadhasivam" <mani@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-aspeed@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Andrew Jeffery <andrew@aj.id.au>, <openbmc@lists.ozlabs.org>,
	<linux-gpio@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764570556; l=5149;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=PYc7RKtTrKYB/n8rcchUdu0GnArVjz+/Dm3h2uX0+i4=;
 b=uRcfSGhjD7whqD1XeVr1g7UGZxa8lZrhPpg7xE+9FtUCo3zPezpdK44JKgXLgYdm4src5LK7n
 7jPU9tj2zLeA2+GBEcaLc98QK4VQHAHgoWLG2rNUGxVqMuryWvziy7y
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

This patch series adds support for the ASPEED PCIe Root Complex,
including device tree bindings, pinctrl support, and the PCIe host controller
driver. The patches introduce the necessary device tree nodes, pinmux groups,
and driver implementation to enable PCIe functionality on ASPEED platforms.
Currently, the ASPEED PCIe Root Complex only supports a single port.

Summary of changes:
- Add device tree binding documents for ASPEED PCIe PHY, PCIe Config, and PCIe RC
- Update MAINTAINERS for new bindings and driver
- Add PCIe RC node and PERST control pin to aspeed-g6 device tree
- Implement ASPEED PCIe PHY driver
- Implement ASPEED PCIe Root Complex host controller driver

This series has been tested on AST2600/AST2700 platforms and enables PCIe device
enumeration and operation.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
Changes in v6:
- Refer to pci-cpi-bridge.yaml to update aspeed,ast2600-pcie.yaml and
  the pcie node of aspeed-g6.dtsi.
- 'dt-bindings: pinctrl: aspeed,ast2600-pinctrl: Add PCIe RC PERST#
  group' have applied, remove it from this version.
- Adjust the defnitions in pci.h. 
- Link to v5: https://lore.kernel.org/r/20251117-upstream_pcie_rc-v5-0-b4a198576acf@aspeedtech.com

Changes in v5:
- Remove legacy-interrupt-controller and the INTx points to pcie node itself.
- Correct bar mapping description and implementation to PCIe address
  configuration in pcie-aspeed.c driver.
- Link to v4: https://lore.kernel.org/r/20251027095825.181161-1-jacky_chou@aspeedtech.com/

Changes in v4:
- Remove aspeed,ast2700-pcie-cfg.yaml
- Add more descriptions for AST2600 PCIe RC in aspeed,ast2600-pcie.yaml
- Change interrupt-controller to legacy-interrupt-controller in yaml
  and dtsi
- Remove msi-parent property in yaml and dtsi
- Modify the bus range to starting from 0x00 in aspeed-g6.dtsi
- Fixed the typo on MODULE_DEVICE_TABLE() in phy-aspeed-pcie.c
- Add PCIE_CPL_STS_SUCCESS definition in pci/pci.h
- Add prefix ASPEED_ for register definition in RC driver
- Add a flag to indicate clear msi status twice for AST2700 workaround
- Remove getting domain number
- Remove scanning AST2600 HOST bridge on device number 0
- Remove all codes about CONFIG_PCI_MSI
- Get root but number from resouce list by IORESOURCE_BUS
- Change module_platform_driver to builtin_platform_driver
- Link to v3: https://lore.kernel.org/r/20250901055922.1553550-1-jacky_chou@aspeedtech.com/

Changes in v3:
- Add ASPEED PCIe PHY driver
- Remove the aspeed,pciecfg property from AST2600 RC node, merged into RC node
- Update the binding doc for aspeed,ast2700-pcie-cfg to reflect the changes
- Update the binding doc for aspeed,ast2600-pcie to reflect the changes
- Update the binding doc for aspeed,ast2600-pinctrl to reflect the changes
- Update the device tree source to reflect the changes
- Adjusted the use of mutex in RC drivers to use GRAND
- Updated from reviewer comments
- Link to v2: https://lore.kernel.org/r/20250715034320.2553837-1-jacky_chou@aspeedtech.com/

Changes in v2:
- Moved ASPEED PCIe PHY yaml binding to `soc/aspeed` directory and
  changed it as syscon
- Added `MAINTAINERS` entry for the new PCIe RC driver
- Updated device tree bindings to reflect the new structure
- Refactored configuration read and write functions to main bus and
  child bus ops
- Refactored initialization to implement multiple ports support
- Added PCIe FMT and TYPE definitions for TLP header in
  `include/uapi/linux/pci_regs.h`
- Updated from reviewer comments
- Link to v1: https://lore.kernel.org/r/20250613033001.3153637-1-jacky_chou@aspeedtech.com/

---
Jacky Chou (7):
      dt-bindings: phy: aspeed: Add ASPEED PCIe PHY
      dt-bindings: PCI: Add ASPEED PCIe RC support
      ARM: dts: aspeed-g6: Add PCIe RC and PCIe PHY node
      PHY: aspeed: Add ASPEED PCIe PHY driver
      PCI: Add FMT, TYPE and CPL status definition for TLP header
      PCI: aspeed: Add ASPEED PCIe RC driver
      MAINTAINERS: Add ASPEED PCIe RC driver

 .../bindings/pci/aspeed,ast2600-pcie.yaml          |  150 +++
 .../bindings/phy/aspeed,ast2600-pcie-phy.yaml      |   42 +
 MAINTAINERS                                        |   12 +
 arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi    |    5 +
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |   51 +
 drivers/pci/controller/Kconfig                     |   16 +
 drivers/pci/controller/Makefile                    |    1 +
 drivers/pci/controller/pcie-aspeed.c               | 1117 ++++++++++++++++++++
 drivers/pci/pci.h                                  |   15 +
 drivers/phy/Kconfig                                |    1 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/aspeed/Kconfig                         |   15 +
 drivers/phy/aspeed/Makefile                        |    2 +
 drivers/phy/aspeed/phy-aspeed-pcie.c               |  209 ++++
 14 files changed, 1637 insertions(+)
---
base-commit: e1afacb68573c3cd0a3785c6b0508876cd3423bc
change-id: 20251103-upstream_pcie_rc-8445759db813

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>


