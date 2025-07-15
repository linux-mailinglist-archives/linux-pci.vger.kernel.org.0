Return-Path: <linux-pci+bounces-32107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F36B04F4C
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 05:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8FC560C5B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 03:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9068454F81;
	Tue, 15 Jul 2025 03:43:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7BF2D1F4E;
	Tue, 15 Jul 2025 03:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752551012; cv=none; b=opvtKtHjS8yq2ugagNNDlKOf0kQr3jA94b5EBOBG+Sr0CE160p8XgjbRNklDVuAwRgcvnmwoG27t+0rWIHoFJEQH3r3f6ZWcsczklkk5eOViCvK1zQHyLntb+k1rzwG2gIvFS+rRxVGo6nzGVyLjNrvvsJpWNtG2VRCIsQVbZJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752551012; c=relaxed/simple;
	bh=fdg1A0Kys3/8bLCqJkQ3l70v3ZlIvIrbrKlo1cOBH6U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKMxcOSAMV2CP88CM77eBXxWMNthRWywDMOQc3YCnvXCuZ4pw9PnTSpOzSXOffGSX4ggL6oC3wNiQYQxymUZ6jr2Zx1sGohxvNqECLCVh2Knr1KDkHywcZppoXWU7JgZQiJaZ4q9hC2/9dc3B64D26AR/jOM++6WIeOv6y2ETKE=
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
Subject: [PATCH v2 02/10] dt-bindings: soc: aspeed: Add ASPEED PCIe PHY support
Date: Tue, 15 Jul 2025 11:43:12 +0800
Message-ID: <20250715034320.2553837-3-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715034320.2553837-1-jacky_chou@aspeedtech.com>
References: <20250715034320.2553837-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This PHY is used by many modules. In our design, our
PCIe has RC and EP funcitons. On the different function,
each driver will use configure and get some information
from the PHY interface to do somting that it wants to.
Getting link status, setting syscon credits and so on.
Therefore, define it as syscon for all modules.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 .../bindings/soc/aspeed/aspeed,pcie-phy.yaml  | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/aspeed,pcie-phy.yaml

diff --git a/Documentation/devicetree/bindings/soc/aspeed/aspeed,pcie-phy.yaml b/Documentation/devicetree/bindings/soc/aspeed/aspeed,pcie-phy.yaml
new file mode 100644
index 000000000000..5fa585d63ca6
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/aspeed/aspeed,pcie-phy.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/aspeed/aspeed,pcie-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED PCIe PHY
+
+maintainers:
+  - Jacky Chou <jacky_chou@aspeedtech.com>
+
+description:
+  The ASPEED PCIe PHY provides the physical layer interface for PCIe
+  controllers in the SoC. This node represents the register block for the PCIe
+  PHY, which is typically accessed by PCIe Root Complex or Endpoint drivers
+  via syscon. It is used to configure and get the status of the PCIe PHY
+  hardware, including power management, link training, and other PHY-specific
+  operations.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - aspeed,pcie-phy
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@1e6ed200 {
+      compatible = "aspeed,pcie-phy", "syscon";
+      reg = <0x1e6ed200 0x100>;
+    };
-- 
2.43.0


