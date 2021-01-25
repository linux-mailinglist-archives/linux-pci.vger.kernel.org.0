Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524633027E9
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jan 2021 17:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbhAYQcg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jan 2021 11:32:36 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:49469 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730749AbhAYQcc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jan 2021 11:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611592352; x=1643128352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=DQL2Ra74x0xb0P3WleJ9hVYbtCvbdvs0044RgnpVkos=;
  b=cKqnA8Q575Cy/AqLOLfP8cnSXVnuy8NUl0Dqmttc0wEDQnL1ZjyT3HHK
   QGAlcqbv9MtaxuWJ8RyBPfJWdlzAWH62Qo9gad3Kzgxr9A88LcXwwmbpm
   fmJ1t5IYy0+k63SKiPfMfUqM/W48P3IDV8diNnYN16DfnI7rx5cFEZ5zL
   Ec7duQbzZnHpFeJ7TWjXfdZnxui8UpxLplRR4JNoymPmB84NbQb8E5D+r
   anf9EoJcjVMPh6doEh+IcGLY2t3DpcS3HM3aK38Su9Gp0oEhQLONd2CkV
   mUu/A++5TcKc3A5ql7OP8QKMObvYTc2zqKNUHKLfa+eonI4JT3TrfhSo8
   A==;
IronPort-SDR: LPS6ybs6fiDixa3vC3e0DXqhXkTqlzwJPDAInejBvJ4DVZQFbiPWctqiPw8UucGOGkZ6Wi016G
 Pzcjfho2T6DSZwOgxjJreOOH8iCI35C9K2YuesQtqalB/YejiMP6K/tmWNVCdAlyl/lCFDGbUs
 1UjWr7WAfwZyFjCXH3yoSghvLHGvDUrsV5T2RBS0tod8W6mbOaDFOtVuAAj/247isLFLA1pTRV
 vQwcU8w82s7PoUF4uKamFJc/5cpZrzF08LYZd7/xsTdqRoIWOAPnig2tiU9adnHrB5UqUipeix
 hTA=
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="101330577"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jan 2021 09:29:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 25 Jan 2021 09:29:44 -0700
Received: from ryzen.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 25 Jan 2021 09:29:42 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>, <cyril.jean@microchip.com>,
        "Daire McNamara" <daire.mcnamara@microchip.com>
Subject: [PATCH v21 2/4] dt-bindings: PCI: microchip: Add Microchip PolarFire host binding
Date:   Mon, 25 Jan 2021 16:29:32 +0000
Message-ID: <20210125162934.5335-3-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210125162934.5335-1-daire.mcnamara@microchip.com>
References: <20210125162934.5335-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

Add device tree bindings for the Microchip PolarFire PCIe controller
when configured in host (Root Complex) mode.

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pci/microchip,pcie-host.yaml     | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
new file mode 100644
index 000000000000..04251d71f56b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/microchip,pcie-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PCIe Root Port Bridge Controller Device Tree Bindings
+
+maintainers:
+  - Daire McNamara <daire.mcnamara@microchip.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    const: microchip,pcie-host-1.0 # PolarFire
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: cfg
+      - const: apb
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: PCIe host controller
+      - description: builtin MSI controller
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: pcie
+      - const: msi
+
+  ranges:
+    maxItems: 1
+
+  msi-controller:
+    description: Identifies the node as an MSI controller.
+
+  msi-parent:
+    description: MSI controller the device is capable of using.
+
+required:
+  - reg
+  - reg-names
+  - "#interrupt-cells"
+  - interrupts
+  - interrupt-map-mask
+  - interrupt-map
+  - msi-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    soc {
+            #address-cells = <2>;
+            #size-cells = <2>;
+            pcie0: pcie@2030000000 {
+                    compatible = "microchip,pcie-host-1.0";
+                    reg = <0x0 0x70000000 0x0 0x08000000>,
+                          <0x0 0x43000000 0x0 0x00010000>;
+                    reg-names = "cfg", "apb";
+                    device_type = "pci";
+                    #address-cells = <3>;
+                    #size-cells = <2>;
+                    #interrupt-cells = <1>;
+                    interrupts = <119>;
+                    interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+                    interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+                                    <0 0 0 2 &pcie_intc0 1>,
+                                    <0 0 0 3 &pcie_intc0 2>,
+                                    <0 0 0 4 &pcie_intc0 3>;
+                    interrupt-parent = <&plic0>;
+                    msi-parent = <&pcie0>;
+                    msi-controller;
+                    bus-range = <0x00 0x7f>;
+                    ranges = <0x03000000 0x0 0x78000000 0x0 0x78000000 0x0 0x04000000>;
+                    pcie_intc0: interrupt-controller {
+                        #address-cells = <0>;
+                        #interrupt-cells = <1>;
+                        interrupt-controller;
+                    };
+            };
+    };
-- 
2.25.1

