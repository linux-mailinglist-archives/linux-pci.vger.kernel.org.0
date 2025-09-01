Return-Path: <linux-pci+bounces-35224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9714DB3D926
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 07:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B75937A92B6
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 05:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56B8239E8A;
	Mon,  1 Sep 2025 05:59:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A8E145355;
	Mon,  1 Sep 2025 05:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706366; cv=none; b=irK087UNhP+xKGalfw1NJajF5su4l06AQYl5mMN4WeR0xbbWOWr7PUDT5odSjrz35rYYOTv9/n8AJWBF7fdiS09lt379yOEWKBHUi4aKzpYhwcgodpwQDjW6ToXDuCrDpqzct6tEAOzIeTCYUSOE3eX19QCkvyGuMFloZjn3tdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706366; c=relaxed/simple;
	bh=wLiM9nosk3p2z406tp4z8uPFX5uJmOynNM4NmY2fO7g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nwqQmSAvT+Qsx7Lo02VN7MQZ+jp5xoxnpSZSny9fGwDL/JbBttCwwxzdaNbOHTDRvlUIdDnNTMHns3irqQLEDHkJpM52WQhS8AdWLoilz/qIsbp/6TRefkjC0CqYDBWsJzNXseGozsL/z3sVn+R2XiMO8NRkB+cVQXxe/iijxHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 1 Sep
 2025 13:59:22 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 1 Sep 2025 13:59:22 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <vkoul@kernel.org>,
	<kishon@kernel.org>, <linus.walleij@linaro.org>, <p.zabel@pengutronix.de>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-phy@lists.infradead.org>, <openbmc@lists.ozlabs.org>,
	<linux-gpio@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [PATCH v3 00/10] Add ASPEED PCIe Root Complex support
Date: Mon, 1 Sep 2025 13:59:12 +0800
Message-ID: <20250901055922.1553550-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

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

Jacky Chou (10):
  dt-bindings: soc: aspeed: Add ASPEED PCIe Config
  dt-bindings: phy: aspeed: Add ASPEED PCIe PHY
  dt-bindings: PCI: Add ASPEED PCIe RC support
  dt-bindings: pinctrl: aspeed,ast2600-pinctrl: Add PCIe RC PERST# group
  ARM: dts: aspeed-g6: Add AST2600 PCIe RC PERST#
  ARM: dts: aspeed-g6: Add PCIe RC and PCIe PHY node
  PHY: aspeed: Add ASPEED PCIe PHY driver
  PCI: Add FMT and TYPE definition for TLP header
  PCI: aspeed: Add ASPEED PCIe RC driver
  MAINTAINERS: Add ASPEED PCIe RC driver

 .../bindings/pci/aspeed,ast2600-pcie.yaml     |  179 +++
 .../bindings/phy/aspeed,ast2600-pcie-phy.yaml |   42 +
 .../pinctrl/aspeed,ast2600-pinctrl.yaml       |    2 +
 .../soc/aspeed/aspeed,ast2700-pcie-cfg.yaml   |   46 +
 MAINTAINERS                                   |   11 +
 .../boot/dts/aspeed/aspeed-g6-pinctrl.dtsi    |    5 +
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |   56 +
 drivers/pci/controller/Kconfig                |   16 +
 drivers/pci/controller/Makefile               |    1 +
 drivers/pci/controller/pcie-aspeed.c          | 1137 +++++++++++++++++
 drivers/pci/pci.h                             |   12 +
 drivers/phy/Kconfig                           |    1 +
 drivers/phy/Makefile                          |    1 +
 drivers/phy/aspeed/Kconfig                    |   15 +
 drivers/phy/aspeed/Makefile                   |    2 +
 drivers/phy/aspeed/phy-aspeed-pcie.c          |  209 +++
 16 files changed, 1735 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/aspeed,ast2600-pcie-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/aspeed,ast2700-pcie-cfg.yaml
 create mode 100644 drivers/pci/controller/pcie-aspeed.c
 create mode 100644 drivers/phy/aspeed/Kconfig
 create mode 100644 drivers/phy/aspeed/Makefile
 create mode 100644 drivers/phy/aspeed/phy-aspeed-pcie.c

---
v3:
 - Add ASPEED PCIe PHY driver
 - Remove the aspeed,pciecfg property from AST2600 RC node, merged into RC node
 - Update the binding doc for aspeed,ast2700-pcie-cfg to reflect the changes
 - Update the binding doc for aspeed,ast2600-pcie to reflect the changes
 - Update the binding doc for aspeed,ast2600-pinctrl to reflect the changes
 - Update the device tree source to reflect the changes
 - Adjusted the use of mutex in RC drivers to use GRAND
 - Updated from reviewer comments

v2:
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
---

-- 
2.43.0


