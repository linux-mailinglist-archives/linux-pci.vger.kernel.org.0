Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF143872DA
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 09:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346309AbhERHIg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 03:08:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:58403 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241306AbhERHIf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 May 2021 03:08:35 -0400
IronPort-SDR: ai8gimFacMFZbYre98hNR4b/PzHCeB/PvICY79uDzE1GRshLZQfPRVBGIhFNWli/CQPjKCOe72
 vpIBTEHOW2iw==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="221695506"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="221695506"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 00:07:18 -0700
IronPort-SDR: 4OuLGY6teze2n07ywUg5185kCKz+ue12VJgkYGsPuT+uPkJJEEWOS2PMkwbj3+6dwy1rWdLDoI
 wOTwqw/ksJDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="626966830"
Received: from intel-z390-ud.iind.intel.com ([10.106.46.146])
  by fmsmga006.fm.intel.com with ESMTP; 18 May 2021 00:07:15 -0700
From:   srikanth.thokala@intel.com
To:     robh+dt@kernel.org, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com, kw@linux.com,
        srikanth.thokala@intel.com
Subject: [PATCH v9 1/2] dt-bindings: PCI: Add Intel Keem Bay PCIe controller
Date:   Tue, 18 May 2021 20:30:49 +0530
Message-Id: <20210518150050.7427-2-srikanth.thokala@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210518150050.7427-1-srikanth.thokala@intel.com>
References: <20210518150050.7427-1-srikanth.thokala@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Srikanth Thokala <srikanth.thokala@intel.com>

Document DT bindings for PCIe controller found on Intel Keem Bay SoC.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
---
 .../bindings/pci/intel,keembay-pcie-ep.yaml   | 69 +++++++++++++
 .../bindings/pci/intel,keembay-pcie.yaml      | 97 +++++++++++++++++++
 2 files changed, 166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
new file mode 100644
index 000000000000..e87ff27526ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/pci/intel,keembay-pcie-ep.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel Keem Bay PCIe controller Endpoint mode
+
+maintainers:
+  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
+  - Srikanth Thokala <srikanth.thokala@intel.com>
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
index 000000000000..ed4400c9ac09
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/pci/intel,keembay-pcie.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel Keem Bay PCIe controller Root Complex mode
+
+maintainers:
+  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
+  - Srikanth Thokala <srikanth.thokala@intel.com>
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

