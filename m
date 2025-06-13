Return-Path: <linux-pci+bounces-29630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E16AD81A3
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 05:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC4B1897356
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 03:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B68124E4A8;
	Fri, 13 Jun 2025 03:30:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25187248888;
	Fri, 13 Jun 2025 03:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749785410; cv=none; b=pmJ0830wc/5Vm0RcH5Lebk3OYAgTf0jWg8533vxbq8NHkKd6cvKS/LPutKhHrnIQ9RLRhlYFWQMADG8OYILQ8fNA4fQefeBKMTPZEdKOUbhaODqutYtFj+Qxv1PbzCit0rc9eVHau47HnM7zU8+e2Gy8Fh039B4iRKHXDoQV1Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749785410; c=relaxed/simple;
	bh=tpGwzkf2J4ClnT4RAe4JBh7EZPpns6IOg5edUYYB0is=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDVH93Mi19iDVn5j6FMCxQJab199OVcwJjKyU0Zhkg83hzOI+KGa7MHUDwyTIFZ36jZORhMP9Xg9fKvfYCWAAoIn1Z/IWMBJ7VYqCi3yEghryEiDZIiF46Dx0QHBPs2u6GTIg3GKdjnR9erFrVc8JhDaZ+FNSU9/qwMiKSv6aL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 13 Jun
 2025 11:30:02 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Jun 2025 11:30:02 +0800
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
Subject: [PATCH 1/7] dt-bindings: phy: Add document for ASPEED PCIe PHY
Date: Fri, 13 Jun 2025 11:29:55 +0800
Message-ID: <20250613033001.3153637-2-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250613033001.3153637-1-jacky_chou@aspeedtech.com>
References: <20250613033001.3153637-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add device tree binding YAML documentation for the ASPEED PCIe PHY.
This schema describes the required properties for the PCIe PHY node,
including compatible strings and register space, and provides an
example for reference.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 .../bindings/phy/aspeed-pcie-phy.yaml         | 38 +++++++++++++++++++
 MAINTAINERS                                   | 10 +++++
 2 files changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/aspeed-pcie-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/aspeed-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/aspeed-pcie-phy.yaml
new file mode 100644
index 000000000000..762bf7b0aedc
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/aspeed-pcie-phy.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/aspeed-pcie-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED PCIe PHY
+
+maintainers:
+  - Jacky Chou <jacky_chou@aspeedtech.com>
+
+description: |
+  The ASPEED PCIe PHY provides the physical layer interface for PCIe
+  controllers in the SoC. This node represents the register block for the PCIe
+  PHY, which is typically accessed by PCIe Root Complex or Endpoint drivers
+  via syscon.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-pcie-phy
+      - aspeed,ast2700-pcie-phy
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie-phy@1e6ed200 {
+      compatible = "aspeed,ast2600-pcie-phy";
+      reg = <0x1e6ed200 0x100>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index a5a650812c16..68115443607d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3696,6 +3696,16 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/aspeed,video-engine.yaml
 F:	drivers/media/platform/aspeed/
 
+ASPEED PCIE CONTROLLER DRIVER
+M:	Jacky Chou <jacky_chou@aspeedtech.com>
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/aspeed-pcie-cfg.yaml
+F:	Documentation/devicetree/bindings/pci/aspeed-pcie.yaml
+F:	Documentation/devicetree/bindings/phy/aspeed-pcie-phy.yaml
+F:	drivers/pci/controller/pcie-aspeed.c
+
 ASUS EC HARDWARE MONITOR DRIVER
 M:	Eugene Shalygin <eugene.shalygin@gmail.com>
 L:	linux-hwmon@vger.kernel.org
-- 
2.43.0


