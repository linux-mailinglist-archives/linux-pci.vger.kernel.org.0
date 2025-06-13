Return-Path: <linux-pci+bounces-29629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADC8AD819E
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 05:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEEBD7AA7C4
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 03:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F133D21765E;
	Fri, 13 Jun 2025 03:30:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFAB246791;
	Fri, 13 Jun 2025 03:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749785406; cv=none; b=QjGAGA/JuPHdn/ZEO/TH7SHHCZiG/bP7nhM6khQ+BbeUkcvljsqHyahjsfO7/aHSDet/QGI2SZrTk9m5z6K1s3Pd2kPr1640Pw8KyfM1gXnWPjolFpeA+uCDQTETZc0ixt/SWdzGuKbAVBa3gqwcMlqA0rJ96xT1FhQSxEpz22I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749785406; c=relaxed/simple;
	bh=au/m1NAEX1zIiTs2rnxuBj0gzG9egat9fu3VofqSb5E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=URjQT1oy0x6KnluMBjQXvGWBxN1yD0zZWc5bBOVZ8vwD+oUKF9/gxfqOOA11ZNARTdvpb+GW6i6NAvsgJzvm6R8Gw2CJY/lju2AJkJzi0RJZalJhKLA7z07TcIZpt71XWf98Y5tdzssL1sIP5CE0WfFvsRUFm4DlTWwBgaPWJZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 13 Jun
 2025 11:30:01 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Jun 2025 11:30:01 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <linus.walleij@linaro.org>,
	<p.zabel@pengutronix.de>, <linux-aspeed@lists.ozlabs.org>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <openbmc@lists.ozlabs.org>,
	<linux-gpio@vger.kernel.org>
CC: <elbadrym@google.com>, <romlem@google.com>, <anhphan@google.com>,
	<wak@google.com>, <yuxiaozhang@google.com>, <BMC-SW@aspeedtech.com>
Subject: [PATCH 0/7] Add ASPEED PCIe Root Complex support
Date: Fri, 13 Jun 2025 11:29:54 +0800
Message-ID: <20250613033001.3153637-1-jacky_chou@aspeedtech.com>
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

Summary of changes:
- Add device tree binding documents for ASPEED PCIe PHY, PCIe Config, and PCIe RC
- Update MAINTAINERS for new bindings and driver
- Add PCIe RC node and PERST control pin to aspeed-g6 device tree
- Add PCIe RC PERST pin group to aspeed-g6 pinctrl
- Implement ASPEED PCIe Root Complex host controller driver

This series has been tested on AST2600/AST2700 platforms and enables PCIe device
enumeration and operation.

Feedback and review are welcome.

Jacky Chou (7):
  dt-bindings: phy: Add document for ASPEED PCIe PHY
  dt-bindings: pci: Add document for ASPEED PCIe Config
  dt-bindings: pci: Add document for ASPEED PCIe RC
  ARM: dts: aspeed-g6: Add AST2600 PCIe RC PERST ctrl pin
  ARM: dts: aspeed-g6: Add PCIe RC node
  pinctrl: aspeed-g6: Add PCIe RC PERST pin group
  pci: aspeed: Add ASPEED PCIe host controller driver

 .../bindings/pci/aspeed-pcie-cfg.yaml         |   41 +
 .../devicetree/bindings/pci/aspeed-pcie.yaml  |  159 +++
 .../bindings/phy/aspeed-pcie-phy.yaml         |   38 +
 MAINTAINERS                                   |   10 +
 .../boot/dts/aspeed/aspeed-g6-pinctrl.dtsi    |    5 +
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |   53 +
 drivers/pci/controller/Kconfig                |   13 +
 drivers/pci/controller/Makefile               |    1 +
 drivers/pci/controller/pcie-aspeed.c          | 1039 +++++++++++++++++
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c    |   12 +-
 10 files changed, 1370 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/aspeed-pcie-cfg.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/aspeed-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/aspeed-pcie-phy.yaml
 create mode 100644 drivers/pci/controller/pcie-aspeed.c

-- 
2.43.0


