Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171732E33EC
	for <lists+linux-pci@lfdr.de>; Mon, 28 Dec 2020 04:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgL1Def (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Dec 2020 22:34:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:24497 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgL1Def (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Dec 2020 22:34:35 -0500
IronPort-SDR: hsl1f1FOqyapERpDIoHFGMPy1QPy8yFvd+M2ABp8/pS2gIBAb/rhrRqyk9gkWHX+z+llPDiAJz
 befoICORCsRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9847"; a="261087142"
X-IronPort-AV: E=Sophos;i="5.78,454,1599548400"; 
   d="scan'208";a="261087142"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2020 19:33:54 -0800
IronPort-SDR: ud+AsV0P/ZKumdGbd4nrp/NpGQePyKsIJiDngdynmgb5csZafRNi5I2bDonGsRhJ4yBREFBXr+
 a6/1oRhiWcLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,454,1599548400"; 
   d="scan'208";a="340742935"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by fmsmga007.fm.intel.com with ESMTP; 27 Dec 2020 19:33:52 -0800
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v5 1/2] dt-bindings: PCI: Add Intel Keem Bay PCIe controller
Date:   Mon, 28 Dec 2020 11:31:58 +0800
Message-Id: <20201228033159.15369-2-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201228033159.15369-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20201228033159.15369-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document DT bindings for PCIe controller found on Intel Keem Bay SoC.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pci/intel,keembay-pcie-ep.yaml   | 68 +++++++++++++
 .../bindings/pci/intel,keembay-pcie.yaml      | 96 +++++++++++++++++++
 2 files changed, 164 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
new file mode 100644
index 000000000000..8cf72b80cfb6
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/pci/intel,keembay-pcie-ep.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel Keem Bay PCIe controller endpoint mode
+
+maintainers:
+  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
+
+properties:
+  compatible:
+    const: intel,keembay-pcie-ep
+
+  reg:
+    maxItems: 5
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: dbi2
+      - const: atu
+      - const: addr_space
+      - const: apb
+
+  interrupts:
+    maxItems: 4
+
+  interrupt-names:
+    items:
+      - const: pcie
+      - const: pcie_ev
+      - const: pcie_err
+      - const: pcie_mem_access
+
+  num-lanes:
+    description: Number of lanes to use.
+    enum: [ 1, 2 ]
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pcie-ep@37000000 {
+          compatible = "intel,keembay-pcie-ep";
+          reg = <0x37000000 0x00001000>,
+                <0x37100000 0x00001000>,
+                <0x37300000 0x00001000>,
+                <0x36000000 0x01000000>,
+                <0x37800000 0x00000200>;
+          reg-names = "dbi", "dbi2", "atu", "addr_space", "apb";
+          interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 108 IRQ_TYPE_EDGE_RISING>,
+                       <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+          interrupt-names = "pcie", "pcie_ev", "pcie_err", "pcie_mem_access";
+          num-lanes = <2>;
+    };
diff --git a/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml b/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
new file mode 100644
index 000000000000..d9c72783ab05
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/pci/intel,keembay-pcie.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel Keem Bay PCIe controller root complex mode
+
+maintainers:
+  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    const: intel,keembay-pcie
+
+  ranges:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  reg:
+    maxItems: 4
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: atu
+      - const: config
+      - const: apb
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: master
+      - const: aux
+
+  interrupts:
+    maxItems: 3
+
+  interrupt-names:
+    items:
+      - const: pcie
+      - const: pcie_ev
+      - const: pcie_err
+
+  num-lanes:
+    description: Number of lanes to use.
+    enum: [ 1, 2 ]
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - ranges
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - reset-gpios
+
+unevaluatedProperties: false
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
+          reg = <0x37000000 0x00001000>,
+                <0x37300000 0x00001000>,
+                <0x36e00000 0x00200000>,
+                <0x37800000 0x00000200>;
+          reg-names = "dbi", "atu", "config", "apb";
+          #address-cells = <3>;
+          #size-cells = <2>;
+          device_type = "pci";
+          ranges = <0x02000000 0 0x36000000 0x36000000 0 0x00e00000>;
+          interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+          interrupt-names = "pcie", "pcie_ev", "pcie_err";
+          clocks = <&scmi_clk KEEM_BAY_A53_PCIE>,
+                   <&scmi_clk KEEM_BAY_A53_AUX_PCIE>;
+          clock-names = "master", "aux";
+          reset-gpios = <&pca2 9 GPIO_ACTIVE_LOW>;
+          num-lanes = <2>;
+    };
-- 
2.17.1

