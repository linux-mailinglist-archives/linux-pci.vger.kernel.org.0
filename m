Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A08CCDE4AC
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 08:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfJUGji (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 02:39:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:61000 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfJUGji (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 02:39:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 23:39:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,322,1566889200"; 
   d="scan'208";a="209255778"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga002.jf.intel.com with ESMTP; 20 Oct 2019 23:39:32 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, andrew.murray@arm.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v4 1/3] dt-bindings: PCI: intel: Add YAML schemas for the PCIe RC controller
Date:   Mon, 21 Oct 2019 14:39:18 +0800
Message-Id: <710257e49c4b3d07fa98b3e5a829b807f74b54d7.1571638827.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1571638827.git.eswara.kota@linux.intel.com>
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1571638827.git.eswara.kota@linux.intel.com>
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add YAML shcemas for PCIe RC controller on Intel Gateway SoCs
which is Synopsys DesignWare based PCIe core.

changes on v4:
	Add "snps,dw-pcie" compatible.
	Rename phy-names property value to pcie.
	And maximum and minimum values to num-lanes.
	Add ref for reset-assert-ms entry and update the
	 description for easy understanding.
	Remove pcie core interrupt entry.

changes on v3:
        Add the appropriate License-Identifier
        Rename intel,rst-interval to 'reset-assert-us'
        Add additionalProperties: false
        Rename phy-names to 'pciephy'
        Remove the dtsi node split of SoC and board in the example
        Add #interrupt-cells = <1>; or else interrupt parsing will fail
        Name yaml file with compatible name

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
 .../devicetree/bindings/pci/intel-gw-pcie.yaml     | 135 +++++++++++++++++++++
 1 file changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
new file mode 100644
index 000000000000..49dd87ec1e3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
@@ -0,0 +1,135 @@
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
+    description: Ranges for the PCI memory and I/O regions.
+
+  resets:
+    maxItems: 1
+
+  clocks:
+    description: PCIe registers interface clock.
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
+  num-lanes:
+    minimum: 1
+    maximum: 2
+    description: Number of lanes to use for this port.
+
+  linux,pci-domain:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: PCI domain ID.
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
+
+  bus-range:
+    description: Range of bus numbers associated with this controller.
+
+  reset-assert-ms:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Delay after asserting reset to the PCIe device.
+      Some devices need an interval upto 500ms. By default it is 100ms.
+
+required:
+  - compatible
+  - device_type
+  - reg
+  - reg-names
+  - ranges
+  - resets
+  - clocks
+  - phys
+  - phy-names
+  - reset-gpios
+  - num-lanes
+  - linux,pci-domain
+  - interrupt-map
+  - interrupt-map-mask
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie10:pcie@d0e00000 {
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
+      status = "okay";
+      reset-assert-ms = <500>;
+      reset-gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
+      num-lanes = <2>;
+    };
-- 
2.11.0

