Return-Path: <linux-pci+bounces-32105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F702B04F44
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 05:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50EF44A1BB0
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 03:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993602D0C97;
	Tue, 15 Jul 2025 03:43:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A690265630;
	Tue, 15 Jul 2025 03:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752551006; cv=none; b=W1d1Ze+VPf1m6ddJl1xSBYC5L0b3MlJOPK9cAEzJ1rtuiJo4Kfnc+Ln4dRYSvTgJruLHqhgkYuk5xRhRW6djI8rGGOT1IQSpVpGrsL4kg9se/keaKhmyUvfHpYzJ+ds4M0g8oVDVajM305IKHoJJ4J3j+HDay1PdF/2QntBf5io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752551006; c=relaxed/simple;
	bh=SP8c/mgGuNWxheHkmYdyncNkkcQ/e4t6SbVXS3CmcT0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ex8aUghb6tKkeUc5TMisrMzIFCmEQoxHXOfABMmK0nyZQb8QGmEE7qE+d05wyTPmbuMp6We4B37kxEbJqL1bAzi9pdNcoOGWdovKtPNbLHnEhbLKEx+CcohQJrvb/H8FdBnQdffbvFmDxBdvoBqfU0iwbMkjAu83DoIqTfAXpQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 15 Jul
 2025 11:43:20 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 15 Jul 2025 11:43:20 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<linux-aspeed@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
	<linus.walleij@linaro.org>, <p.zabel@pengutronix.de>, <BMC-SW@aspeedtech.com>
Subject: [PATCH v2 00/10] Add ASPEED PCIe Root Complex support
Date: Tue, 15 Jul 2025 11:43:10 +0800
Message-ID: <20250715034320.2553837-1-jacky_chou@aspeedtech.com>
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
- Add PCIe RC PERST pin group to aspeed-g6 pinctrl
- Implement ASPEED PCIe Root Complex host controller driver

This series has been tested on AST2600/AST2700 platforms and enables PCIe device
enumeration and operation.

Jacky Chou (10):
  dt-bindings: soc: aspeed: Add ASPEED PCIe Config support
  dt-bindings: soc: aspeed: Add ASPEED PCIe PHY support
  dt-bindings: PCI: Add ASPEED PCIe RC support
  dt-bindings: pinctrl: aspeed,ast2600-pinctrl: Add PCIe RC PERST# group
  ARM: dts: aspeed-g6: Add AST2600 PCIe RC PERST#
  ARM: dts: aspeed-g6: Add PCIe RC node
  pinctrl: aspeed-g6: Add PCIe RC PERST pin group
  PCI: Add FMT and TYPE definition for TLP header
  PCI: aspeed: Add ASPEED PCIe RC driver
  MAINTAINERS: Add ASPEED PCIe RC driver

 .../bindings/pci/aspeed,ast2600-pcie.yaml     |  198 +++
 .../pinctrl/aspeed,ast2600-pinctrl.yaml       |    2 +
 .../bindings/soc/aspeed/aspeed,pcie-cfg.yaml  |   41 +
 .../bindings/soc/aspeed/aspeed,pcie-phy.yaml  |   44 +
 MAINTAINERS                                   |   10 +
 .../boot/dts/aspeed/aspeed-g6-pinctrl.dtsi    |    5 +
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |   61 +
 drivers/pci/controller/Kconfig                |   13 +
 drivers/pci/controller/Makefile               |    1 +
 drivers/pci/controller/pcie-aspeed.c          | 1137 +++++++++++++++++
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c    |   12 +-
 include/uapi/linux/pci_regs.h                 |   32 +
 12 files changed, 1555 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/aspeed,pcie-cfg.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/aspeed,pcie-phy.yaml
 create mode 100644 drivers/pci/controller/pcie-aspeed.c

---
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


