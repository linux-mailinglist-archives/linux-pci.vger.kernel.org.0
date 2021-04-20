Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749A236523F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Apr 2021 08:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhDTGS1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Apr 2021 02:18:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53814 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230142AbhDTGSZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Apr 2021 02:18:25 -0400
X-UUID: ae2fb29e747f44faa01e729e7984c253-20210420
X-UUID: ae2fb29e747f44faa01e729e7984c253-20210420
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1402890721; Tue, 20 Apr 2021 14:17:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 20 Apr 2021 14:17:40 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Apr 2021 14:17:39 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        <youlin.pei@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <qizhong.cheng@mediatek.com>, <sin_jieyang@mediatek.com>,
        <drinkcat@chromium.org>, <Rex-BC.Chen@mediatek.com>,
        <anson.chuang@mediatek.com>, Krzysztof Wilczyski <kw@linux.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH v10 1/7] dt-bindings: PCI: mediatek-gen3: Add YAML schema
Date:   Tue, 20 Apr 2021 14:17:17 +0800
Message-ID: <20210420061723.989-2-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210420061723.989-1-jianjun.wang@mediatek.com>
References: <20210420061723.989-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7EFF32C5B26547AC7174EEF9D9BCC61A9E7B0B854FB2BC2E676178368908215F2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add YAML schemas documentation for Gen3 PCIe controller on
MediaTek SoCs.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pci/mediatek-pcie-gen3.yaml      | 181 ++++++++++++++++++
 1 file changed, 181 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
new file mode 100644
index 000000000000..e7b1f9892da4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -0,0 +1,181 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/mediatek-pcie-gen3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Gen3 PCIe controller on MediaTek SoCs
+
+maintainers:
+  - Jianjun Wang <jianjun.wang@mediatek.com>
+
+description: |+
+  PCIe Gen3 MAC controller for MediaTek SoCs, it supports Gen3 speed
+  and compatible with Gen2, Gen1 speed.
+
+  This PCIe controller supports up to 256 MSI vectors, the MSI hardware
+  block diagram is as follows:
+
+                    +-----+
+                    | GIC |
+                    +-----+
+                       ^
+                       |
+                   port->irq
+                       |
+               +-+-+-+-+-+-+-+-+
+               |0|1|2|3|4|5|6|7| (PCIe intc)
+               +-+-+-+-+-+-+-+-+
+                ^ ^           ^
+                | |    ...    |
+        +-------+ +------+    +-----------+
+        |                |                |
+  +-+-+---+--+--+  +-+-+---+--+--+  +-+-+---+--+--+
+  |0|1|...|30|31|  |0|1|...|30|31|  |0|1|...|30|31| (MSI sets)
+  +-+-+---+--+--+  +-+-+---+--+--+  +-+-+---+--+--+
+   ^ ^      ^  ^    ^ ^      ^  ^    ^ ^      ^  ^
+   | |      |  |    | |      |  |    | |      |  |  (MSI vectors)
+   | |      |  |    | |      |  |    | |      |  |
+
+    (MSI SET0)       (MSI SET1)  ...   (MSI SET7)
+
+  With 256 MSI vectors supported, the MSI vectors are composed of 8 sets,
+  each set has its own address for MSI message, and supports 32 MSI vectors
+  to generate interrupt.
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    const: mediatek,mt8192-pcie
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    items:
+      - const: pcie-mac
+
+  interrupts:
+    maxItems: 1
+
+  ranges:
+    minItems: 1
+    maxItems: 8
+
+  resets:
+    minItems: 1
+    maxItems: 2
+
+  reset-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: phy
+      - const: mac
+
+  clocks:
+    maxItems: 6
+
+  clock-names:
+    items:
+      - const: pl_250m
+      - const: tl_26m
+      - const: tl_96m
+      - const: tl_32k
+      - const: peri_26m
+      - const: top_133m
+
+  assigned-clocks:
+    maxItems: 1
+
+  assigned-clock-parents:
+    maxItems: 1
+
+  phys:
+    maxItems: 1
+
+  '#interrupt-cells':
+    const: 1
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
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - ranges
+  - clocks
+  - '#interrupt-cells'
+  - interrupt-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie: pcie@11230000 {
+            compatible = "mediatek,mt8192-pcie";
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            reg = <0x00 0x11230000 0x00 0x4000>;
+            reg-names = "pcie-mac";
+            interrupts = <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH 0>;
+            bus-range = <0x00 0xff>;
+            ranges = <0x82000000 0x00 0x12000000 0x00
+                      0x12000000 0x00 0x1000000>;
+            clocks = <&infracfg 44>,
+                     <&infracfg 40>,
+                     <&infracfg 43>,
+                     <&infracfg 97>,
+                     <&infracfg 99>,
+                     <&infracfg 111>;
+            clock-names = "pl_250m", "tl_26m", "tl_96m",
+                          "tl_32k", "peri_26m", "top_133m";
+            assigned-clocks = <&topckgen 50>;
+            assigned-clock-parents = <&topckgen 91>;
+
+            phys = <&pciephy>;
+            phy-names = "pcie-phy";
+
+            resets = <&infracfg_rst 2>,
+                     <&infracfg_rst 3>;
+            reset-names = "phy", "mac";
+
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &pcie_intc 0>,
+                            <0 0 0 2 &pcie_intc 1>,
+                            <0 0 0 3 &pcie_intc 2>,
+                            <0 0 0 4 &pcie_intc 3>;
+            pcie_intc: interrupt-controller {
+                      #address-cells = <0>;
+                      #interrupt-cells = <1>;
+                      interrupt-controller;
+            };
+        };
+    };
-- 
2.25.1

