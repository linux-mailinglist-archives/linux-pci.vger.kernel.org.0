Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F39ADFD2F4
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2019 03:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfKOCbB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Nov 2019 21:31:01 -0500
Received: from mga02.intel.com ([134.134.136.20]:45423 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbfKOCbB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Nov 2019 21:31:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 18:30:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,306,1569308400"; 
   d="scan'208";a="355988890"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga004.jf.intel.com with ESMTP; 14 Nov 2019 18:30:56 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, helgaas@kernel.org, jingoohan1@gmail.com,
        robh@kernel.org, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com
Cc:     linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v7 1/3] dt-bindings: PCI: intel: Add YAML schemas for the PCIe RC controller
Date:   Fri, 15 Nov 2019 10:30:42 +0800
Message-Id: <2ac4df004c6cc2fbc47d465bd91002e48eb94484.1573784557.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1573784557.git.eswara.kota@linux.intel.com>
References: <cover.1573784557.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1573784557.git.eswara.kota@linux.intel.com>
References: <cover.1573784557.git.eswara.kota@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add YAML schemas for PCIe RC controller on Intel Gateway SoCs
which is Synopsys DesignWare based PCIe core.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes on v7:
	No change

Changes on v6:
	Add Reviewed-by: Rob Herring <robh@kernel.org>

Changes on v5:
	Add Reviewed-by Andrew Murray.
	Add possible values and default value for max-link-speed.
	Remove $ref and add maximum and default for reset-assert-ms.
	Set true flag for linux,pci-domain.
	Define maxItems for ranges and clock.
	Define maximum for num-lanes.
	Update required list:
	  Add #address-cells, #size-cells, #interrupt-cells.
	  Remove num-lanes and linux,pci-domain.
	Add required header files in example.
	Remove status entry in example.

changes on v4:
	Add "snps,dw-pcie" compatible.
	Rename phy-names property value to pcie.
	And maximum and minimum values to num-lanes.
	Add ref for reset-assert-ms entry and update the
	 description for easy understanding.
	Remove PCIe core interrupt entry.

changes on v3:
        Add the appropriate License-Identifier
        Rename intel,rst-interval to 'reset-assert-us'
        Add additionalProperties: false
        Rename phy-names to 'pciephy'
        Remove the dtsi node split of SoC and board in the example
        Add #interrupt-cells = <1>; or else interrupt parsing will fail
        Name yaml file with compatible name

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

