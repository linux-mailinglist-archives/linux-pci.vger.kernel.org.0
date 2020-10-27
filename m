Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0780429A469
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 07:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506164AbgJ0GCK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 02:02:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:41317 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506160AbgJ0GCJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 02:02:09 -0400
IronPort-SDR: fqJ3Z96Pg9gFtnMhSC8DwoEAh7VA4ZgFSOFgHV8DpUvzXnObwT1Y0snxxF/MZFsUAPTmQsLJnQ
 P/LF3iPzkS8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="155810683"
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="155810683"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 23:01:56 -0700
IronPort-SDR: llP2VBL2rQSj9AYas8HIu0rOQrhI1YjHZdUxeg8lr7GbTNHpT6nFvjdvKv0ym4IKBTBQcOe1hZ
 oOotyDQ6yHsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="303775929"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by fmsmga007.fm.intel.com with ESMTP; 26 Oct 2020 23:01:54 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH 1/2] dt-bindings: PCI: Add Intel Keem Bay PCIe controller
Date:   Tue, 27 Oct 2020 14:00:10 +0800
Message-Id: <20201027060011.25893-2-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027060011.25893-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20201027060011.25893-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document DT bindings for PCIe controller found on Intel Keem Bay SoC.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
---
 .../bindings/pci/intel,keembay-pcie-ep.yaml   |  86 +++++++++++++
 .../bindings/pci/intel,keembay-pcie.yaml      | 120 ++++++++++++++++++
 2 files changed, 206 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
new file mode 100644
index 000000000000..11962c205744
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/pci/intel,keembay-pcie-ep.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel Keem Bay PCIe EP controller
+
+maintainers:
+  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
+
+properties:
+  compatible:
+      const: intel,keembay-pcie-ep
+
+  reg:
+    items:
+      - description: DesignWare PCIe registers
+      - description: PCIe configuration space
+      - description: Keem Bay specific registers
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: addr_space
+      - const: apb
+
+  interrupts:
+    items:
+      - description: PCIe interrupt
+      - description: PCIe event interrupt
+      - description: PCIe error interrupt
+      - description: PCIe memory access interrupt
+
+  interrupt-names:
+    items:
+      - const: intr
+      - const: ev_intr
+      - const: err_intr
+      - const: mem_access_intr
+
+  num-ib-windows:
+    description: Number of inbound address translation windows
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  num-ob-windows:
+    description: Number of outbound address translation windows
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  num-lanes:
+    description: Number of lanes to use.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 1, 2, 4, 8 ]
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - num-ib-windows
+  - num-ob-windows
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+  - |
+    pcie-ep@37000000 {
+          compatible = "intel,keembay-pcie-ep";
+          reg = <0x37000000 0x00800000>,
+                <0x36000000 0x01000000>,
+                <0x37800000 0x00000200>;
+          reg-names = "dbi", "addr_space", "apb";
+          interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 108 IRQ_TYPE_EDGE_RISING>,
+                       <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+          interrupt-names = "intr", "ev_intr", "err_intr",
+                       "mem_access_intr";
+          num-ib-windows = <4>;
+          num-ob-windows = <4>;
+          num-lanes = <2>;
+    };
diff --git a/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml b/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
new file mode 100644
index 000000000000..49e5d3d35bd4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/pci/intel,keembay-pcie.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel Keem Bay PCIe RC controller
+
+maintainers:
+  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+      const: intel,keembay-pcie
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
+  ranges:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  reg:
+    items:
+      - description: DesignWare PCIe registers
+      - description: PCIe configuration space
+      - description: Keem Bay specific registers
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: config
+      - const: apb
+
+  clocks:
+    items:
+      - description: bus clock
+      - description: auxiliary clock
+
+  clock-names:
+    items:
+      - const: master
+      - const: aux
+
+  interrupts:
+    items:
+      - description: PCIe interrupt
+      - description: PCIe event interrupt
+      - description: PCIe error interrupt
+
+  interrupt-names:
+    items:
+      - const: intr
+      - const: ev_intr
+      - const: err_intr
+
+  num-lanes:
+    description: Number of lanes to use.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 1, 2, 4, 8 ]
+
+  num-viewport:
+    description: Number of view ports configured in hardware.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 2
+
+required:
+  - compatible
+  - device_type
+  - "#address-cells"
+  - "#size-cells"
+  - reg
+  - reg-names
+  - ranges
+  - clocks
+  - interrupts
+  - interrupt-names
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #define KEEM_BAY_A53_PCIE
+    #define KEEM_BAY_A53_AUX_PCIE
+    pcie@37000000 {
+          compatible = "intel,keembay-pcie";
+          reg = <0x37000000 0x00800000>,
+                <0x36e00000 0x00200000>,
+                <0x37800000 0x00000200>;
+          reg-names = "dbi", "config", "apb";
+          #address-cells = <3>;
+          #size-cells = <2>;
+          device_type = "pci";
+          ranges = <0x02000000 0 0x36000000 0x36000000 0 0x00e00000>;
+          interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+          interrupt-names = "intr", "ev_intr", "err_intr";
+          clocks = <&scmi_clk KEEM_BAY_A53_PCIE>,
+                   <&scmi_clk KEEM_BAY_A53_AUX_PCIE>;
+          clock-names = "master", "aux";
+          reset-gpios = <&pca2 9 GPIO_ACTIVE_LOW>;
+          num-viewport = <4>;
+          num-lanes = <2>;
+    };
-- 
2.17.1

