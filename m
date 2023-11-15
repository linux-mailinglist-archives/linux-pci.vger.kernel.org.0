Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBE37EC175
	for <lists+linux-pci@lfdr.de>; Wed, 15 Nov 2023 12:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343628AbjKOLtd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 06:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343602AbjKOLt3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 06:49:29 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8053E122;
        Wed, 15 Nov 2023 03:49:25 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 0AEB57FD6;
        Wed, 15 Nov 2023 19:49:24 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Nov
 2023 19:49:16 +0800
Received: from ubuntu.localdomain (183.27.97.246) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Nov
 2023 19:49:14 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Daire McNamara" <daire.mcnamara@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
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
Subject: [PATCH v11 01/20] dt-bindings: PCI: Add PLDA XpressRICH PCIe host common properties
Date:   Wed, 15 Nov 2023 19:48:53 +0800
Message-ID: <20231115114912.71448-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231115114912.71448-1-minda.chen@starfivetech.com>
References: <20231115114912.71448-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.246]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PLDA XpressRICH PCIe host common properties dt-binding doc.
PolarFire PCIe host using PLDA IP. Move common properties from Microchip
PolarFire PCIe host to PLDA files.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: John Clark <inindev@gmail.com>
---
 .../bindings/pci/microchip,pcie-host.yaml     | 55 +-------------
 .../pci/plda,xpressrich3-axi-common.yaml      | 75 +++++++++++++++++++
 2 files changed, 76 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml

diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
index f7a3c2636355..7c2d51221f65 100644
--- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -10,21 +10,13 @@ maintainers:
   - Daire McNamara <daire.mcnamara@microchip.com>
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: plda,xpressrich3-axi-common.yaml#
   - $ref: /schemas/interrupt-controller/msi-controller.yaml#
 
 properties:
   compatible:
     const: microchip,pcie-host-1.0 # PolarFire
 
-  reg:
-    maxItems: 2
-
-  reg-names:
-    items:
-      - const: cfg
-      - const: apb
-
   clocks:
     description:
       Fabric Interface Controllers, FICs, are the interface between the FPGA
@@ -52,18 +44,6 @@ properties:
     items:
       pattern: '^fic[0-3]$'
 
-  interrupts:
-    minItems: 1
-    items:
-      - description: PCIe host controller
-      - description: builtin MSI controller
-
-  interrupt-names:
-    minItems: 1
-    items:
-      - const: pcie
-      - const: msi
-
   ranges:
     maxItems: 1
 
@@ -71,39 +51,6 @@ properties:
     minItems: 1
     maxItems: 6
 
-  msi-controller:
-    description: Identifies the node as an MSI controller.
-
-  msi-parent:
-    description: MSI controller the device is capable of using.
-
-  interrupt-controller:
-    type: object
-    properties:
-      '#address-cells':
-        const: 0
-
-      '#interrupt-cells':
-        const: 1
-
-      interrupt-controller: true
-
-    required:
-      - '#address-cells'
-      - '#interrupt-cells'
-      - interrupt-controller
-
-    additionalProperties: false
-
-required:
-  - reg
-  - reg-names
-  - "#interrupt-cells"
-  - interrupts
-  - interrupt-map-mask
-  - interrupt-map
-  - msi-controller
-
 unevaluatedProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml b/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
new file mode 100644
index 000000000000..31bb17b11e58
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/plda,xpressrich3-axi-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PLDA XpressRICH PCIe host common properties
+
+maintainers:
+  - Daire McNamara <daire.mcnamara@microchip.com>
+  - Kevin Xie <kevin.xie@starfivetech.com>
+
+description:
+  Generic PLDA XpressRICH PCIe host common properties.
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: cfg
+      - const: apb
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: PCIe host controller
+      - description: builtin MSI controller
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: pcie
+      - const: msi
+
+  msi-controller:
+    description: Identifies the node as an MSI controller.
+
+  msi-parent:
+    description: MSI controller the device is capable of using.
+
+  interrupt-controller:
+    type: object
+    properties:
+      '#address-cells':
+        const: 0
+
+      '#interrupt-cells':
+        const: 1
+
+      interrupt-controller: true
+
+    required:
+      - '#address-cells'
+      - '#interrupt-cells'
+      - interrupt-controller
+
+    additionalProperties: false
+
+required:
+  - reg
+  - reg-names
+  - interrupts
+  - msi-controller
+  - "#interrupt-cells"
+  - interrupt-map-mask
+  - interrupt-map
+
+additionalProperties: true
+
+...
-- 
2.17.1

