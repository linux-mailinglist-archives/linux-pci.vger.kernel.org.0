Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8062D95B35
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 11:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfHTJkf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 05:40:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:25400 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729651AbfHTJkf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Aug 2019 05:40:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 02:40:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="329655996"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga004.jf.intel.com with ESMTP; 20 Aug 2019 02:40:31 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v2 2/3] dt-bindings: PCI: intel: Add YAML schemas for the PCIe RC controller
Date:   Tue, 20 Aug 2019 17:39:36 +0800
Message-Id: <5e6ee1245ee53a7726103a8de7c11a37ad99fbd6.1566208109.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1566208109.git.eswara.kota@linux.intel.com>
References: <cover.1566208109.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1566208109.git.eswara.kota@linux.intel.com>
References: <cover.1566208109.git.eswara.kota@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Intel PCIe RC controller is Synopsys Designware
based PCIe core. Add YAML schemas for PCIe in RC mode
present in Intel Universal Gateway soc.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
 .../devicetree/bindings/pci/intel-pcie.yaml        | 133 +++++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/intel-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/intel-pcie.yaml b/Documentation/devicetree/bindings/pci/intel-pcie.yaml
new file mode 100644
index 000000000000..80caaaba5e2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/intel-pcie.yaml
@@ -0,0 +1,133 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/intel-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel AXI bus based PCI express root complex
+
+maintainers:
+  - Dilip Kota <eswara.kota@linux.intel.com>
+
+properties:
+  compatible:
+    const: intel,lgm-pcie
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
+    const: phy
+
+  reset-gpios:
+    maxItems: 1
+
+  num-lanes:
+    description: Number of lanes to use for this port.
+
+  linux,pci-domain:
+    description: PCI domain ID.
+
+  interrupts:
+    description: PCIe core integrated miscellaneous interrupt.
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
+  intel,rst-interval:
+    description: |
+      Device reset interval in ms. Some devices need an interval upto 500ms.
+      By default it is 100ms.
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
+  - interrupts
+  - interrupt-map
+  - interrupt-map-mask
+
+examples:
+  - |
+    pcie10:pcie@d0e00000 {
+      compatible = "intel,lgm-pcie";
+      device_type = "pci";
+      #address-cells = <3>;
+      #size-cells = <2>;
+      reg = <
+            0xd0e00000 0x1000
+            0xd2000000 0x800000
+            0xd0a41000 0x1000
+            >;
+      reg-names = "dbi", "config", "app";
+      linux,pci-domain = <0>;
+      max-link-speed = <4>;
+      bus-range = <0x00 0x08>;
+      interrupt-parent = <&ioapic1>;
+      interrupts = <67 1>;
+      interrupt-map-mask = <0 0 0 0x7>;
+      interrupt-map = <0 0 0 1 &ioapic1 27 1>,
+                      <0 0 0 2 &ioapic1 28 1>,
+                      <0 0 0 3 &ioapic1 29 1>,
+                      <0 0 0 4 &ioapic1 30 1>;
+      ranges = <0x02000000 0 0xd4000000 0xd4000000 0 0x04000000>;
+      resets = <&rcu0 0x50 0>;
+      clocks = <&cgu0 LGM_GCLK_PCIE10>;
+      phys = <&cb0phy0>;
+      phy-names = "phy";
+    };
+
+    &pcie10 {
+      status = "okay";
+      intel,rst-interval = <100>;
+      reset-gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
+      num-lanes = <2>;
+    };
-- 
2.11.0

