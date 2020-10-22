Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC13295FDF
	for <lists+linux-pci@lfdr.de>; Thu, 22 Oct 2020 15:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507417AbgJVNWh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 09:22:37 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:22266 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507167AbgJVNWg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Oct 2020 09:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1603372956; x=1634908956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=/nmevcmTggs/V2C84tdJw1RHRNhwdqwCc6w8l04Xe+s=;
  b=jsJ6kMzJ+CPcEUr5m+/ujmzrb8uic0UCuOj1AbpiveH2KOXSgAbkq06E
   D4dStT98SS+sVoD8TJhb7wIXHZFpJrOnw0KDfKVb4d0BjnFK0porSEsKh
   H7KGwesUn1rZbJGfMPBpK+znWbne8f16wtDMLZ8H6M3rIl9ru/F4UX2TY
   im7ddNZkRziAuUPd9N1bwAh0WP2llw8wIDb5uCkZ9jlYvAQvjMrX/un1Z
   lS3ug26HLfhU8xrrGVWhwT3elxgsnJ3wmTXF2K4mWLlPt95FDo4UDQ+b+
   +yZNcmw6ZsVLUcbJKyKGxHqZMhPciwVLNzpca4ZgLvcYTt/kEXaK83ufY
   Q==;
IronPort-SDR: x7dGBC8oAnGxBetyC2TDG4Ymf535j21POleDndD14pTyQqwCIyEPLVqxlivMeFd+RZj22PPwhe
 qw3DZv1mfy42FxJ92xI6upcihUdiLHHgT6xjS/g13X2GUUei4EC876wYqDZo7dPXGQLcoVx66K
 Ev77/jlv1TE1RLywHt+W2iWIjLc2EBa8nr2xz/y9EcMoJXzlhdgkkXwhBeiugqeQXDdvONJSbb
 bcSZJivU2MEiKfIxTCxScwXlhmbSAIFARSfHS/rkAEBqOpWfCasbDZqMaetUlUxGXlLwqRQSYY
 Wfs=
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="91058341"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Oct 2020 06:22:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 22 Oct 2020 06:22:34 -0700
Received: from ryzen.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 22 Oct 2020 06:22:32 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <robh@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <david.abdurachmanov@gmail.com>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v17 2/3] dt-bindings: PCI: microchip: Add Microchip PolarFire host binding
Date:   Thu, 22 Oct 2020 14:22:22 +0100
Message-ID: <20201022132223.17789-3-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022132223.17789-1-daire.mcnamara@microchip.com>
References: <20201022132223.17789-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

Add device tree bindings for the Microchip PolarFire PCIe controller
when configured in host (Root Complex) mode.

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
---
 .../bindings/pci/microchip,pcie-host.yaml     | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
new file mode 100644
index 000000000000..b55941826b44
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -0,0 +1,93 @@
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
+  dma-ranges:
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
+  - dma-ranges
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
+                    reg = <0x20 0x30000000 0x0 0x4000000>,
+                          <0x20 0x0 0x0 0x100000>;
+                    reg-names = "cfg", "apb";
+                    device_type = "pci";
+                    #address-cells = <3>;
+                    #size-cells = <2>;
+                    #interrupt-cells = <1>;
+                    interrupts = <32>;
+                    interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+                    interrupt-map = <0 0 0 1 &pcie0 0>,
+                                    <0 0 0 2 &pcie0 1>,
+                                    <0 0 0 3 &pcie0 2>,
+                                    <0 0 0 4 &pcie0 3>;
+                    interrupt-parent = <&plic0>;
+                    interrupt-controller;
+                    msi-parent = <&pcie0>;
+                    msi-controller;
+                    bus-range = <0x00 0x7f>;
+                    ranges = <0x03000000 0x0 0x40000000 0x0 0x40000000 0x0 0x20000000>;
+                    dma-ranges = <0x02000000 0x0 0x00000000 0x0 0x00000000 0x1 0x00000000>;
+            };
+    };
-- 
2.25.1

