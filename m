Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896D53D42B0
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jul 2021 00:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhGWVeR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 17:34:17 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:57722 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhGWVeR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jul 2021 17:34:17 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 16NMEQZs013440; Sat, 24 Jul 2021 07:14:26 +0900
X-Iguazu-Qid: 34trLrrEEXLS5yN6bB
X-Iguazu-QSIG: v=2; s=0; t=1627078466; q=34trLrrEEXLS5yN6bB; m=bNWxWgrHrTFBgqjwNoiKZStcocEVJE06dpcFifL5NZo=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1510) id 16NMEOX3037286
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 24 Jul 2021 07:14:25 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id A7B721000EA;
        Sat, 24 Jul 2021 07:14:24 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 16NMEOSN030480;
        Sat, 24 Jul 2021 07:14:24 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v5 1/3] dt-bindings: pci: Add DT binding for Toshiba Visconti PCIe controller
Date:   Sat, 24 Jul 2021 07:14:19 +0900
X-TSB-HOP: ON
Message-Id: <20210723221421.113575-2-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723221421.113575-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210723221421.113575-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This commit adds the Device Tree binding documentation that allows
to describe the PCIe controller found in Toshiba Visconti SoCs.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .../bindings/pci/toshiba,visconti-pcie.yaml   | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
new file mode 100644
index 000000000000..60ec424cd07c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/toshiba,visconti-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba Visconti5 SoC PCIe Host Controller Device Tree Bindings
+
+maintainers:
+  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+
+description:
+  Toshiba Visconti5 SoC PCIe host controller is based on the Synopsys DesignWare PCIe IP.
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    const: toshiba,visconti-pcie
+
+  reg:
+    items:
+      - description: Data Bus Interface (DBI) registers.
+      - description: PCIe configuration space region.
+      - description: Visconti specific additional registers.
+      - description: Visconti specific SMU registers
+      - description: Visconti specific memory protection unit registers (MPU)
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: config
+      - const: ulreg
+      - const: smu
+      - const: mpu
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: PCIe reference clock
+      - description: PCIe system clock
+      - description: Auxiliary clock
+
+  clock-names:
+    items:
+      - const: ref
+      - const: core
+      - const: aux
+
+  num-lanes:
+    const: 2
+
+required:
+  - reg
+  - reg-names
+  - interrupts
+  - "#interrupt-cells"
+  - interrupt-map
+  - interrupt-map-mask
+  - num-lanes
+  - clocks
+  - clock-names
+  - max-link-speed
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie: pcie@28400000 {
+            compatible = "toshiba,visconti-pcie";
+            reg = <0x0 0x28400000 0x0 0x00400000>,
+                  <0x0 0x70000000 0x0 0x10000000>,
+                  <0x0 0x28050000 0x0 0x00010000>,
+                  <0x0 0x24200000 0x0 0x00002000>,
+                  <0x0 0x24162000 0x0 0x00001000>;
+            reg-names  = "dbi", "config", "ulreg", "smu", "mpu";
+            device_type = "pci";
+            bus-range = <0x00 0xff>;
+            num-lanes = <2>;
+            num-viewport = <8>;
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+            #interrupt-cells = <1>;
+            ranges = <0x81000000 0 0x40000000 0 0x40000000 0 0x00010000>,
+                     <0x82000000 0 0x50000000 0 0x50000000 0 0x20000000>;
+            interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "intr";
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map =
+                <0 0 0 1 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
+                 0 0 0 2 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
+                 0 0 0 3 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
+                 0 0 0 4 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&extclk100mhz>, <&clk600mhz>, <&clk25mhz>;
+            clock-names = "ref", "core", "aux";
+            max-link-speed = <2>;
+        };
+    };
+...
-- 
2.32.0


