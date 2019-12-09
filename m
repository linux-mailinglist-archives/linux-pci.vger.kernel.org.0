Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37A2711654E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 04:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfLIDUT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Dec 2019 22:20:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:56768 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfLIDUT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 8 Dec 2019 22:20:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Dec 2019 19:20:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,294,1571727600"; 
   d="scan'208";a="224635926"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga002.jf.intel.com with ESMTP; 08 Dec 2019 19:20:14 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        andrew.murray@arm.com, robh@kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v11 1/3] dt-bindings: PCI: intel: Add YAML schemas for the PCIe RC controller
Date:   Mon,  9 Dec 2019 11:20:04 +0800
Message-Id: <a276c1107d40917901a4265d4d8622dee060e4f5.1575860791.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1575860791.git.eswara.kota@linux.intel.com>
References: <cover.1575860791.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1575860791.git.eswara.kota@linux.intel.com>
References: <cover.1575860791.git.eswara.kota@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add YAML schemas for PCIe RC controller on Intel Gateway SoCs
which is Synopsys DesignWare based PCIe core.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/intel-gw-pcie.yaml     | 138 +++++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
new file mode 100644
index 000000000000..db605d8a387d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/intel-gw-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PCIe RC controller on Intel Gateway SoCs
+
+maintainers:
+  - Dilip Kota <eswara.kota@linux.intel.com>
+
+properties:
+  compatible:
+    items:
+      - const: intel,lgm-pcie
+      - const: snps,dw-pcie
+
+  device_type:
+    const: pci
+
+  "#address-cells":
+    const: 3
+
+  "#size-cells":
+    const: 2
+
+  reg:
+    items:
+      - description: Controller control and status registers.
+      - description: PCIe configuration registers.
+      - description: Controller application registers.
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: config
+      - const: app
+
+  ranges:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: pcie
+
+  reset-gpios:
+    maxItems: 1
+
+  linux,pci-domain: true
+
+  num-lanes:
+    maximum: 2
+    description: Number of lanes to use for this port.
+
+  '#interrupt-cells':
+    const: 1
+
+  interrupt-map-mask:
+    description: Standard PCI IRQ mapping properties.
+
+  interrupt-map:
+    description: Standard PCI IRQ mapping properties.
+
+  max-link-speed:
+    description: Specify PCI Gen for link capability.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [ 1, 2, 3, 4 ]
+      - default: 1
+
+  bus-range:
+    description: Range of bus numbers associated with this controller.
+
+  reset-assert-ms:
+    description: |
+      Delay after asserting reset to the PCIe device.
+    maximum: 500
+    default: 100
+
+required:
+  - compatible
+  - device_type
+  - "#address-cells"
+  - "#size-cells"
+  - reg
+  - reg-names
+  - ranges
+  - resets
+  - clocks
+  - phys
+  - phy-names
+  - reset-gpios
+  - '#interrupt-cells'
+  - interrupt-map
+  - interrupt-map-mask
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/clock/intel,lgm-clk.h>
+    pcie10: pcie@d0e00000 {
+      compatible = "intel,lgm-pcie", "snps,dw-pcie";
+      device_type = "pci";
+      #address-cells = <3>;
+      #size-cells = <2>;
+      reg = <0xd0e00000 0x1000>,
+            <0xd2000000 0x800000>,
+            <0xd0a41000 0x1000>;
+      reg-names = "dbi", "config", "app";
+      linux,pci-domain = <0>;
+      max-link-speed = <4>;
+      bus-range = <0x00 0x08>;
+      interrupt-parent = <&ioapic1>;
+      #interrupt-cells = <1>;
+      interrupt-map-mask = <0 0 0 0x7>;
+      interrupt-map = <0 0 0 1 &ioapic1 27 1>,
+                      <0 0 0 2 &ioapic1 28 1>,
+                      <0 0 0 3 &ioapic1 29 1>,
+                      <0 0 0 4 &ioapic1 30 1>;
+      ranges = <0x02000000 0 0xd4000000 0xd4000000 0 0x04000000>;
+      resets = <&rcu0 0x50 0>;
+      clocks = <&cgu0 LGM_GCLK_PCIE10>;
+      phys = <&cb0phy0>;
+      phy-names = "pcie";
+      reset-assert-ms = <500>;
+      reset-gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
+      num-lanes = <2>;
+    };
-- 
2.11.0

