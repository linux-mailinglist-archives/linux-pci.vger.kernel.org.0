Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34A02E2B1C
	for <lists+linux-pci@lfdr.de>; Fri, 25 Dec 2020 11:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgLYKED (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Dec 2020 05:04:03 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:38111 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726198AbgLYKED (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Dec 2020 05:04:03 -0500
X-UUID: 16d21f46fb6d4d278499bf11eeb463d5-20201225
X-UUID: 16d21f46fb6d4d278499bf11eeb463d5-20201225
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 564906571; Fri, 25 Dec 2020 18:03:12 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Dec 2020 18:03:10 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Dec 2020 18:03:08 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sj Huang <sj.huang@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        <youlin.pei@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <qizhong.cheng@mediatek.com>, <sin_jieyang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <drinkcat@chromium.org>
Subject: [v6,1/4] dt-bindings: PCI: mediatek: Add YAML schema
Date:   Fri, 25 Dec 2020 18:03:05 +0800
Message-ID: <20201225100308.27052-2-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201225100308.27052-1-jianjun.wang@mediatek.com>
References: <20201225100308.27052-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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
 .../bindings/pci/mediatek-pcie-gen3.yaml      | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
new file mode 100644
index 000000000000..e2aecbb56e57
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -0,0 +1,135 @@
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
+    anyOf:
+      - const: mac
+      - const: phy
+
+  clocks:
+    maxItems: 5
+
+  clock-names:
+    items:
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
+            clocks = <&infracfg 40>,
+                     <&infracfg 43>,
+                     <&infracfg 97>,
+                     <&infracfg 99>,
+                     <&infracfg 111>;
+            clock-names = "tl_26m", "tl_96m", "tl_32k", "peri_26m", "top_133m";
+            assigned-clocks = <&topckgen 50>;
+            assigned-clock-parents = <&topckgen 91>;
+
+            phys = <&pciephy>;
+            phy-names = "pcie-phy";
+            resets = <&infracfg_rst 0>;
+            reset-names = "phy";
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

