Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851217592B7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 12:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjGSKVQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 06:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjGSKVL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 06:21:11 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA6C1FC4;
        Wed, 19 Jul 2023 03:21:07 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 5210781BB;
        Wed, 19 Jul 2023 18:21:06 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Jul
 2023 18:21:06 +0800
Received: from ubuntu.localdomain (113.72.147.86) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Jul
 2023 18:21:05 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v1 7/9] dt-bindings: PCI: Add StarFive JH7110 PCIe controller
Date:   Wed, 19 Jul 2023 18:20:55 +0800
Message-ID: <20230719102057.22329-8-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230719102057.22329-1-minda.chen@starfivetech.com>
References: <20230719102057.22329-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.147.86]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add StarFive JH7110 SoC PCIe controller dt-bindings.
JH7110 using PLDA XpressRICH PCIe host controller IP.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../bindings/pci/starfive,jh7110-pcie.yaml    | 138 ++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
new file mode 100644
index 000000000000..467286df557d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/starfive,jh7110-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 PCIe host controller
+
+maintainers:
+  - Minda Chen <minda.chen@starfivetech.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: plda,xpressrich-pcie-common.yaml#
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
+  - $ref: /schemas/gpio/gpio-consumer-common.yaml#
+
+properties:
+  compatible:
+    const: starfive,jh7110-pcie
+
+  clocks:
+    items:
+      - description: NOC bus clock
+      - description: Transport layer clock
+      - description: AXI MST0 clock
+      - description: APB clock
+
+  clock-names:
+    items:
+      - const: noc
+      - const: tl
+      - const: axi_mst0
+      - const: apb
+
+  resets:
+    items:
+      - description: AXI MST0 reset
+      - description: AXI SLAVE reset
+      - description: AXI SLAVE0 reset
+      - description: PCIE BRIDGE reset
+      - description: PCIE CORE reset
+      - description: PCIE APB reset
+
+  reset-names:
+    items:
+      - const: mst0
+      - const: slv0
+      - const: slv
+      - const: brg
+      - const: core
+      - const: apb
+
+  starfive,stg-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to System Register Controller stg_syscon node.
+          - description: register0 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
+          - description: register1 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
+          - description: register2 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
+          - description: register3 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
+    description:
+      The phandle to System Register Controller syscon node and the offset
+      of STG_SYSCONSAIF__SYSCFG register for PCIe. Total 4 regsisters offset
+      for PCIe.
+
+  phys:
+    description:
+      Specified PHY is attached to PCIe controller.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#interrupt-cells"
+  - interrupts
+  - interrupt-map-mask
+  - interrupt-map
+  - clocks
+  - resets
+  - starfive,stg-syscon
+  - msi-controller
+  - reset-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie0: pcie@2b000000 {
+            compatible = "starfive,jh7110-pcie";
+            reg = <0x0 0x2b000000 0x0 0x1000000>,
+                  <0x9 0x40000000 0x0 0x10000000>;
+            reg-names = "host", "cfg";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            #interrupt-cells = <1>;
+            device_type = "pci";
+            ranges = <0x82000000  0x0 0x30000000  0x0 0x30000000 0x0 0x08000000>,
+                     <0xc3000000  0x9 0x00000000  0x9 0x00000000 0x0 0x40000000>;
+            starfive,stg-syscon = <&stg_syscon 0xc0 0xc4 0x130 0x1b8>;
+            bus-range = <0x0 0xff>;
+            interrupt-parent = <&plic>;
+            interrupts = <56>;
+            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+            interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc0 0x1>,
+                            <0x0 0x0 0x0 0x2 &pcie_intc0 0x2>,
+                            <0x0 0x0 0x0 0x3 &pcie_intc0 0x3>,
+                            <0x0 0x0 0x0 0x4 &pcie_intc0 0x4>;
+            msi-parent = <&pcie0>;
+            msi-controller;
+            clocks = <&syscrg 86>,
+                     <&stgcrg 10>,
+                     <&stgcrg 8>,
+                     <&stgcrg 9>;
+            clock-names = "noc", "tl", "axi_mst0", "apb";
+            resets = <&stgcrg 11>,
+                     <&stgcrg 12>,
+                     <&stgcrg 13>,
+                     <&stgcrg 14>,
+                     <&stgcrg 15>,
+                     <&stgcrg 16>;
+            reset-gpios = <&gpios 26 GPIO_ACTIVE_LOW>;
+            phys = <&pciephy0>;
+
+            pcie_intc0: interrupt-controller {
+                #address-cells = <0>;
+                #interrupt-cells = <1>;
+                interrupt-controller;
+            };
+        };
+    };
-- 
2.17.1

