Return-Path: <linux-pci+bounces-41396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7527C64265
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 13:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 540C44F19F2
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 12:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320A032ED27;
	Mon, 17 Nov 2025 12:39:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687BF33122A;
	Mon, 17 Nov 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763383142; cv=none; b=gAkTXqO8FQde35DJirsSGcej6sfjZEorEXbXQ4ofFZpx8kj7knF/+B3C9EYhtxGGCmJ7QUKPNmjaNS8lbYIurkczO4+VhUdVspfD3evOQQLxcTXZX0edUUbfolnyfv0I4GW4W0HtE0DIbH9QKnsuDHdCX7/7VSsXpQpOkX8Oe3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763383142; c=relaxed/simple;
	bh=YzEcxd0xslxFtGHOgJh0VIQ/MoHabFtQMpzgbMmdshk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZDp1hcOjVtBPt0i/mrzUnCJQWKTHl8tVe/S1rsK8nJoLMf1n+5ut3uEwZsXtiKL8x4uduQrd4TczEAz/pjLA0KoU9g52nFkd5QJ0Fj2Y9IKipXlpjEOZwfvsumclI1vnf/9S2Rcc4LCc8F06F5BTt00svIdLw9Q6adIaRbP30Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 17 Nov
 2025 20:38:52 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 17 Nov 2025 20:38:52 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 17 Nov 2025 20:37:49 +0800
Subject: [PATCH v5 2/8] dt-bindings: PCI: Add ASPEED PCIe RC support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251117-upstream_pcie_rc-v5-2-b4a198576acf@aspeedtech.com>
References: <20251117-upstream_pcie_rc-v5-0-b4a198576acf@aspeedtech.com>
In-Reply-To: <20251117-upstream_pcie_rc-v5-0-b4a198576acf@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763383131; l=4893;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=YzEcxd0xslxFtGHOgJh0VIQ/MoHabFtQMpzgbMmdshk=;
 b=PzChNXuL5RKnqRt0FI/Z0k/0JDT0xkvCtf7x21udABEBoAzN4TWhRlXx9mppqBj+AtE/6nvfU
 hmkgUqVuc6MD0s7siFNIJ86Wf3UnGjOMBmsyO98uU0y0g69cjJ2dizB
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

ASPEED AST2600 provides one PCIe RC for Gen2 and AST2700 provides three
PCIe RC for two Gen4 and one Gen2. All of these RCs have just one root
port to connect to PCIe device. And also have Mem, I/O access, legacy
interrupt and MSI.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 .../bindings/pci/aspeed,ast2600-pcie.yaml          | 149 +++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml b/Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
new file mode 100644
index 000000000000..459b5c49657a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
@@ -0,0 +1,149 @@
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
+  memory and I/O windows, MSI and INTx interrupts, and integration with
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
+    description: INTx and MSI interrupt
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
+  interrupt-controller: true
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
+  - interrupt-controller
+  - interrupt-map-mask
+  - interrupt-map
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
+
+      #interrupt-cells = <1>;
+      msi-controller;
+
+      aspeed,ahbc = <&ahbc>;
+
+      interrupt-controller;
+      interrupt-map-mask = <0 0 0 7>;
+      interrupt-map = <0 0 0 1 &pcie0 0>,
+                      <0 0 0 2 &pcie0 1>,
+                      <0 0 0 3 &pcie0 2>,
+                      <0 0 0 4 &pcie0 3>;
+
+      pcie@8,0 {
+        reg = <0x804000 0 0 0 0>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        resets = <&syscon ASPEED_RESET_PCIE_RC_O>;
+        reset-names = "perst";
+        clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_pcierc1_default>;
+        phys = <&pcie_phy1>;
+        ranges;
+      };
+    };

-- 
2.34.1


