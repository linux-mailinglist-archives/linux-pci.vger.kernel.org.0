Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585D32E25B6
	for <lists+linux-pci@lfdr.de>; Thu, 24 Dec 2020 10:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgLXJq1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Dec 2020 04:46:27 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:34822 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbgLXJq1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Dec 2020 04:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1608803186; x=1640339186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=+ojrhVJ2psYBZBXIIkpQbi76zwcqI90vTQQgygjg1Oo=;
  b=RUh1E+H/J0iCldmvYgu/kP85DVwJ5q6EGGc2fg5J4xJ2achoTw6Jbcct
   8sdRGtyWP/wSPZjcTmwrOChnyDMIPwUR5isCmoCdwG65ex8LEMw+EzRYJ
   4N6h6HVCR6Qb0IHh2I5kLa0l6ssOUOJCks/DpWb/8gPQSlXZ3eKu06eNi
   nXAI3nkcvHrITuFm4bB26/X/tcxi8prJkg/1ormx5DNsIFTf4icCYng/l
   b6jO7gIuq4IjvcCVQAwGL1CuAS/nehlsDKKxqLnM5CI5QS/x815iMOALc
   0me1Aq/msHMVQNEQdMbap1ch6WhjTP0NA5LkBE/aTfVcYK5n9+lLt74Ci
   Q==;
IronPort-SDR: rPbvQkEpvNhwzM/PQsBF2paEja3IFHwHdKlBv1/jYjqBu/so+vHkhRTSASv2Vo+T2UGfm3lBFz
 U9xRUZqEFQVs0X9ZOeGUdIuzI7sXrRxkcxs3tQuK9rCsOYlelDavOJVcxxr9ILvlxjiVpfV3bF
 PXMXVJ+yEidPicj7aazvWLA+SStvdGBogDIlg8TXOC58YpY6sHLPusMUZwas+Qsxj0w3fhIfGp
 SCGH8Ytt86BqnRbak5MQL1rkWGg1iFRHhvCsNWc+hRlg6iCdgEtBHAkAImwGiLI4lVBFNuTZiW
 d2o=
X-IronPort-AV: E=Sophos;i="5.78,444,1599548400"; 
   d="scan'208";a="103376099"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Dec 2020 02:45:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 24 Dec 2020 02:45:11 -0700
Received: from ryzen.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 24 Dec 2020 02:45:09 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>, <cyril.jean@microchip.com>,
        <ben.dooks@codethink.co.uk>,
        Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v19 2/4] dt-bindings: PCI: microchip: Add Microchip PolarFire host binding
Date:   Thu, 24 Dec 2020 09:44:58 +0000
Message-ID: <20201224094500.19149-3-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201224094500.19149-1-daire.mcnamara@microchip.com>
References: <20201224094500.19149-1-daire.mcnamara@microchip.com>
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
index 000000000000..5a56f07a5ceb
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
+                    pcie_intc_0: interrupt-controller {
+                        #address-cells = <0>;
+                        #interrupt-cells = <1>;
+                        interrupt-controller;
+                    };
+            };
+    };
-- 
2.25.1

