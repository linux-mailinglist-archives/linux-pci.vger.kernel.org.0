Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF9D356208
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 05:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbhDGDld (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 23:41:33 -0400
Received: from mo-csw-fb1116.securemx.jp ([210.130.202.175]:40930 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbhDGDld (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 23:41:33 -0400
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1116) id 1373JEiB008257; Wed, 7 Apr 2021 12:19:14 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 1373IlRr032587; Wed, 7 Apr 2021 12:18:47 +0900
X-Iguazu-Qid: 2wGr7AjrkuzVuw0n9p
X-Iguazu-QSIG: v=2; s=0; t=1617765526; q=2wGr7AjrkuzVuw0n9p; m=IjLJdmPDKoaEPAm/jIhtzxpIl6NMSsuJVv7S+bEH5bo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1113) id 1373IjKO017955
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 7 Apr 2021 12:18:46 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 6B3AA1000C6;
        Wed,  7 Apr 2021 12:18:45 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 1373IiMe001362;
        Wed, 7 Apr 2021 12:18:45 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 1/3] dt-bindings: pci: Add DT binding for Toshiba Visconti PCIe controller
Date:   Wed,  7 Apr 2021 12:18:37 +0900
X-TSB-HOP: ON
Message-Id: <20210407031839.386088-2-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.30.0.rc2
In-Reply-To: <20210407031839.386088-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210407031839.386088-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This commit adds the Device Tree binding documentation that allows
to describe the PCIe controller found in Toshiba Visconti SoCs.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .../bindings/pci/toshiba,visconti-pcie.yaml   | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
new file mode 100644
index 000000000000..8ab60c235007
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
@@ -0,0 +1,121 @@
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
+description: |+
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
+      - const: pcie_refclk
+      - const: sysclk
+      - const: auxclk
+
+  num-lanes:
+    const: 2
+
+  num-viewport:
+    const: 8
+
+required:
+  - reg
+  - reg-names
+  - interrupts
+  - "#address-cells"
+  - "#size-cells"
+  - "#interrupt-cells"
+  - interrupt-map
+  - interrupt-map-mask
+  - ranges
+  - bus-range
+  - device_type
+  - num-lanes
+  - num-viewport
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
+            clock-names = "pcie_refclk", "sysclk", "auxclk";
+            max-link-speed = <2>;
+
+            status = "disabled";
+        };
+    };
+...
-- 
2.30.0.rc2

