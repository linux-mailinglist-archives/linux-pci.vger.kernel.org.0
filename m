Return-Path: <linux-pci+bounces-35227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14346B3D937
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 08:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEEBC17967D
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 06:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8852586EA;
	Mon,  1 Sep 2025 05:59:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E0F256C9B;
	Mon,  1 Sep 2025 05:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706372; cv=none; b=OGYnLGdP2/8I3ZsPXVtxBkuH0043K10o5Oj3U41MZdXg8CLvPUz6t0NKDX2iYbX1LOTuYbvG9g0SGNq4Mz0TzpgfYXOlvY37NsVEbDb2Ky5ZKuIlZ87sb0nGau0Lyv/XF/klNaWW6vM4ZNkK2SncU0TAE2rGwezaNxUGyEHr2FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706372; c=relaxed/simple;
	bh=fBsPQpxu7BJliCcFpme/pPYd0JCFxCOc+zzmRVPjRGs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2jSn0OTurj16LMN8b63R9DKnhwTFU4ExoIWhYprBXt1Vz709Ohek6rF0FHrSmiZRUnUfVprfRCRbz5f1IcUtlJR7NtzioA7FLVTwuK6cz+ZT/AT40Xm2MvKDc5ROLOhCiXEpGOgLAIs0YfEmVOCqc8UOUvTjsDAbh5Zwkw9VaY=
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
Subject: [PATCH v3 03/10] dt-bindings: PCI: Add ASPEED PCIe RC support
Date: Mon, 1 Sep 2025 13:59:15 +0800
Message-ID: <20250901055922.1553550-4-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901055922.1553550-1-jacky_chou@aspeedtech.com>
References: <20250901055922.1553550-1-jacky_chou@aspeedtech.com>
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
 .../bindings/pci/aspeed,ast2600-pcie.yaml     | 179 ++++++++++++++++++
 1 file changed, 179 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml b/Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
new file mode 100644
index 000000000000..fe75bf2961c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
@@ -0,0 +1,179 @@
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
+  the SoC's clock, reset, and pinctrl subsystems.
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
+  msi-parent: true
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
+  interrupt-controller:
+    description: Interrupt controller node for handling legacy PCI interrupts.
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
+  - msi-parent
+  - msi-controller
+  - interrupt-map-mask
+  - interrupt-map
+  - interrupt-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/ast2600-clock.h>
+
+    apb {
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      pcie0: pcie@1e770000 {
+        compatible = "aspeed,ast2600-pcie";
+        device_type = "pci";
+        reg = <0x1e770000 0x100>;
+        linux,pci-domain = <0>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+        bus-range = <0x80 0xff>;
+
+        ranges = <0x01000000 0x0 0x00018000 0x00018000 0x0 0x00008000
+            0x02000000 0x0 0x70000000 0x70000000 0x0 0x10000000>;
+
+        status = "disabled";
+
+        resets = <&syscon ASPEED_RESET_H2X>;
+        reset-names = "h2x";
+
+        #interrupt-cells = <1>;
+        msi-parent = <&pcie0>;
+        msi-controller;
+
+        aspeed,ahbc = <&ahbc>;
+
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+                        <0 0 0 2 &pcie_intc0 1>,
+                        <0 0 0 3 &pcie_intc0 2>,
+                        <0 0 0 4 &pcie_intc0 3>;
+        pcie_intc0: interrupt-controller {
+          interrupt-controller;
+          #address-cells = <0>;
+          #interrupt-cells = <1>;
+        };
+
+        pcie@8,0 {
+          reg = <0x804000 0 0 0 0>;
+          #address-cells = <3>;
+          #size-cells = <2>;
+          device_type = "pci";
+          resets = <&syscon ASPEED_RESET_PCIE_RC_O>;
+          reset-names = "perst";
+          clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
+          pinctrl-names = "default";
+          pinctrl-0 = <&pinctrl_pcierc1_default>;
+          phys = <&pcie_phy1>;
+          ranges;
+        };
+      };
+    };
-- 
2.43.0


