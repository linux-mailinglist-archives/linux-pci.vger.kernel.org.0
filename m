Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9682CD53B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 13:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbgLCMLz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 07:11:55 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:35408 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgLCMLz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2020 07:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606997514; x=1638533514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=9yh+e1aZL5LavHpBl3EV5nnoEqITMcVHhGEoDABV6L8=;
  b=c96a6Vn+BDidrX8HJpHMOKizHd9PqFiES1uMiaVAdppO8/mocAqnekFI
   aLrtXPgyX0CLr1gj76d8ohmkvNy1nDguERVPKayqjUu8s3ECwWU5LdZ3p
   J2CWH+eMOn4pwIPRB4VrEDwk29WqHGc5HDXV7ogNnplaUrXPch0+KASW7
   jGCnPehwiUlHPuIAJA4nrNBHzdrfSg6gBY51rSyyk4xYgP8xiIke3f/KC
   53ri1T1VP+xS5RMLoLI9HA4NTrgohgomdNULs6F4rqavDlgj87pHXLGUk
   HNfh8IGTNu0Yq2di1e1LMaA1XV0TFUE2cgTYbitP1GVRQgG7/2KS+OtGi
   A==;
IronPort-SDR: UPEOK3cLl3w7X26WlSKmg3Q0pEvZf4iHjA2MPBNMBnxpzvFXTRB0D+z8gZESoYAVVBjS4PZGLj
 kiuZlyHbcgfvYoL8JJYbJqcZD2lGnHz07HPjzmlZDj30dmeW0TiKVn/oathEqfiK2c8m3FFcPw
 uezem8VLFI/kwrNz2djXALY+NlCN4Mtp/3IuEvQ1yIioJ7ufsfBjxMR3Fg8TY4WuUOpwA12XY3
 tsHQe9LVIsNTUV2plJNNOoo7lmShX5lAg+ElAFYntUcp+Ce3PvRTPsCPL3uRygy0jspSi6JQgo
 Shk=
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="95700024"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Dec 2020 05:10:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 05:10:48 -0700
Received: from ryzen.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 3 Dec 2020 05:10:47 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>, <cyril.jean@microchip.com>,
        <ben.dooks@codethink.co.uk>,
        Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v18 2/4] dt-bindings: PCI: microchip: Add Microchip PolarFire host binding
Date:   Thu, 3 Dec 2020 12:10:16 +0000
Message-ID: <20201203121018.16432-3-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201203121018.16432-1-daire.mcnamara@microchip.com>
References: <20201203121018.16432-1-daire.mcnamara@microchip.com>
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

