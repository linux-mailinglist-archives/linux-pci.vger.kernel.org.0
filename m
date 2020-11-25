Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADAF2C3D7D
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 11:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgKYKNq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 05:13:46 -0500
Received: from mga18.intel.com ([134.134.136.126]:62024 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgKYKNq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 05:13:46 -0500
IronPort-SDR: NyinMyB20jqSuBEY6605D3bgQjFnxBkGAtbaoH0RRDkjOT7hTe/2PK0JJ8bxxUwsd/r7NQxfnK
 iPBIRP/ppkTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="159873326"
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="159873326"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 02:13:45 -0800
IronPort-SDR: v46J+Ai9c82zF4CdexfAdMNhbIKQVcDq13Q/4v7mk8UhXI6OfEgL/l9PNtUWbV6rN1S1A0L6PM
 uXxgEUsgmkxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="547216338"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga005.jf.intel.com with ESMTP; 25 Nov 2020 02:13:42 -0800
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v2 1/2] dt-bindings: PCI: Add Intel Keem Bay PCIe controller
Date:   Wed, 25 Nov 2020 18:11:51 +0800
Message-Id: <20201125101152.5326-2-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201125101152.5326-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20201125101152.5326-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document DT bindings for PCIe controller found on Intel Keem Bay SoC.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
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

