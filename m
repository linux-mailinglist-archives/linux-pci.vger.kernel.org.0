Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510A628B324
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 12:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgJLK6H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 06:58:07 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:51256 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbgJLK6H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 06:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1602500287; x=1634036287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=aadQtAn4nhA2xSc8YvCHk7LMH2tQKHVqz2QNecn9/sQ=;
  b=1IujzjCtQzLXuUC2MRl6deMW0QGNojFgAi+fb6fnuv2zIPsObbmL4ZW0
   zJotDRu+1YKMqvig4zp/pYPXK4q/VgDrpWyE5lmTP5mLJCzZe/6o19jev
   BtmJfDVGuzVoTeTKn1qx5M3Uz7HF7UEYolEskHzGoeQYVE88xhLotTgEs
   wqqYMXLrVBMadENxgSvNTg+5YuYizeoqZ5H1UXmWaxLshtNH6JmWluV5w
   VOGLfjaaytZCWGfhEHBwi9jBo/dnSNxiNPguJQxk26B7sKCCvu7he3Ake
   3tcHIEDZZN52GvlxmGEbbqEAQhahYH7glqEK1HEz9acouhYFacR/xYPzb
   A==;
IronPort-SDR: qk9WUVmT5aYUbljdMJ6NGtAd/54fbvHOMsuXKFmNjxJL0CHjzGa7VHcxWev3MQfpStwWFzITO7
 bP00yuLT8MO2BHUgKx2rChaRpG8q7/dziWuHh8Vgd8ZUGboYwIGBOXE0Ou6JiYlkh0kCB7pErZ
 V7B268RQBdNBKS5GRBwHkIXeFNzI4znHnw1IbBpPQeHRgZi/7Dlue6xo5qOWtys8AQRGmdVA1e
 UHsTgEqMwh8rdC0bHnVXrAdXteu8JCE+cVQ6diAoHrgWiojs52c3nzXT77oR9/KcSUXRzEp6st
 PaQ=
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="94247414"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Oct 2020 03:58:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 12 Oct 2020 03:58:06 -0700
Received: from ryzen.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 12 Oct 2020 03:58:04 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <robh@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <david.abdurachmanov@gmail.com>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v16 2/3] dt-bindings: PCI: microchip: Add Microchip PolarFire host binding
Date:   Mon, 12 Oct 2020 11:57:53 +0100
Message-ID: <20201012105754.22596-3-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201012105754.22596-1-daire.mcnamara@microchip.com>
References: <20201012105754.22596-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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

