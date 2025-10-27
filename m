Return-Path: <linux-pci+bounces-39403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5BFC0CDA1
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 11:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B4A406107
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 10:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4802F7446;
	Mon, 27 Oct 2025 09:58:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07D92FB62C;
	Mon, 27 Oct 2025 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559113; cv=none; b=W3iTIDLhA/u63T4DVKIOUp/Q6yowJVbBLHNiIq4Mf0YxIh4mlW14KJWCtpmBMuZ8005uKeB/1dgoBGOPINbjE9nXx+rIKSYusR8yAWz5W4rDy174nUtTzvAot6LRdwQACZ77PLv4fc4Bzi7O0M3GZteaLitvc930XIyhWmfZn4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559113; c=relaxed/simple;
	bh=VV2JPv0jbCg+iZyMlam7QzW0alu+BCazrWCza7qOwZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=boXG+lzFThHWVOg1+6SK2O4H1Z4s/lKbOyWbiC7+xaFfD5qv6k9cqF8KAj8QbP2pVyMyQG2kwY0Wd+qddzDeUBga4WC2o9mSy4762G4Gc6fV6naVzKN9WDMagv4+TWwsZoEpmOqgqEk8JGfXdRrmnfI2DzuLvH02m+0VnLNcstE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 27 Oct
 2025 17:58:25 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 27 Oct 2025 17:58:25 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <linus.walleij@linaro.org>,
	<p.zabel@pengutronix.de>, <linux-aspeed@lists.ozlabs.org>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <openbmc@lists.ozlabs.org>,
	<linux-gpio@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [PATCH v4 2/9] dt-bindings: PCI: Add ASPEED PCIe RC support
Date: Mon, 27 Oct 2025 17:58:18 +0800
Message-ID: <20251027095825.181161-3-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027095825.181161-1-jacky_chou@aspeedtech.com>
References: <20251027095825.181161-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

ASPEED AST2600 provides one PCIe RC for Gen2 and AST2700 provides three
PCIe RC for two Gen4 and one Gen2. All of these RCs have just one root
port to connect to PCIe device. And also have Mem, I/O access, legacy
interrupt and MSI.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 .../bindings/pci/aspeed,ast2600-pcie.yaml     | 168 ++++++++++++++++++
 1 file changed, 168 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml b/Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
new file mode 100644
index 000000000000..d40fe7eb6fa0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
@@ -0,0 +1,168 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/aspeed,ast2600-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED PCIe Root Complex Controller
+
+maintainers:
+  - Jacky Chou <jacky_chou@aspeedtech.com>
+
+description:
+  The ASPEED PCIe Root Complex controller provides PCI Express Root Complex
+  functionality for ASPEED SoCs, such as the AST2600 and AST2700.
+  This controller enables connectivity to PCIe endpoint devices, supporting
+  memory and I/O windows, MSI and legacy interrupts, and integration with
+  the SoC's clock, reset, and pinctrl subsystems. On AST2600, the PCIe Root
+  Port device number is always 8.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-pcie
+      - aspeed,ast2700-pcie
+
+  reg:
+    maxItems: 1
+
+  ranges:
+    minItems: 2
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+    description: IntX and MSI interrupt
+
+  resets:
+    items:
+      - description: PCIe controller reset
+
+  reset-names:
+    items:
+      - const: h2x
+
+  aspeed,ahbc:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the ASPEED AHB Controller (AHBC) syscon node.
+      This reference is used by the PCIe controller to access
+      system-level configuration registers related to the AHB bus.
+      To enable AHB access for the PCIe controller.
+
+  aspeed,pciecfg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the ASPEED PCIe configuration syscon node.
+      This reference allows the PCIe controller to access
+      SoC-specific PCIe configuration registers. There are the others
+      functions such PCIe RC and PCIe EP will use this common register
+      to configure the SoC interfaces.
+
+  legacy-interrupt-controller:
+    description: Interrupt controller node for handling INTx.
+    type: object
+    properties:
+      '#address-cells':
+        const: 0
+      '#interrupt-cells':
+        const: 1
+      interrupt-controller: true
+
+    required:
+      - '#address-cells'
+      - '#interrupt-cells'
+      - interrupt-controller
+
+    additionalProperties: false
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2600-pcie
+    then:
+      required:
+        - aspeed,ahbc
+    else:
+      properties:
+        aspeed,ahbc: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2700-pcie
+    then:
+      required:
+        - aspeed,pciecfg
+    else:
+      properties:
+        aspeed,pciecfg: false
+
+required:
+  - reg
+  - interrupts
+  - bus-range
+  - ranges
+  - resets
+  - reset-names
+  - msi-controller
+  - interrupt-map-mask
+  - interrupt-map
+  - legacy-interrupt-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/ast2600-clock.h>
+
+    pcie0: pcie@1e770000 {
+      compatible = "aspeed,ast2600-pcie";
+      device_type = "pci";
+      reg = <0x1e770000 0x100>;
+      #address-cells = <3>;
+      #size-cells = <2>;
+      interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+      bus-range = <0x00 0xff>;
+
+      ranges = <0x01000000 0x0 0x00018000 0x00018000 0x0 0x00008000
+                0x02000000 0x0 0x60000000 0x60000000 0x0 0x20000000>;
+
+      resets = <&syscon ASPEED_RESET_H2X>;
+      reset-names = "h2x";
+      pinctrl-0 = <&pinctrl_pcierc1_default>;
+      pinctrl-names = "default";
+
+      #interrupt-cells = <1>;
+      msi-controller;
+
+      aspeed,ahbc = <&ahbc>;
+
+      interrupt-map-mask = <0 0 0 7>;
+      interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+                      <0 0 0 2 &pcie_intc0 1>,
+                      <0 0 0 3 &pcie_intc0 2>,
+                      <0 0 0 4 &pcie_intc0 3>;
+      legacy-interrupt-controller {
+        interrupt-controller;
+        #address-cells = <0>;
+        #interrupt-cells = <1>;
+      };
+
+      pcie@8,0 {
+        reg = <0x804000 0 0 0 0>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        resets = <&syscon ASPEED_RESET_PCIE_RC_O>;
+        reset-names = "perst";
+        clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
+        phys = <&pcie_phy1>;
+        ranges;
+      };
+    };
-- 
2.34.1


