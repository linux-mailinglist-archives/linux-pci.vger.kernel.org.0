Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D11C116923
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 10:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfLIJVZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 04:21:25 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54462 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbfLIJVY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2019 04:21:24 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB99LHTi100989;
        Mon, 9 Dec 2019 03:21:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575883277;
        bh=TuZ57XKo41i7btprk/EutM6dRU+uO6XJ5X6yFXEDUbE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=AkG+v2UbtWswA0hBjZjeJyZbpKQrEUMIYDSv9q75fzjjFsu1YgDmHDxmt7l42lEn4
         9sigJahY3daiYmLUTwszZRlMP+QQd0gmFV4mJ3tOC77dCY8X18nUOlk0YUaTTzshiU
         tGNnwhCo/kamfCld4nFbqNMZOUozub3Ws2fDioAI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB99LHWH127889;
        Mon, 9 Dec 2019 03:21:17 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 03:21:15 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 03:21:15 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB99Kcd8087697;
        Mon, 9 Dec 2019 03:21:12 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 10/13] dt-bindings: PCI: Add EP mode dt-bindings for TI's J721E SoC
Date:   Mon, 9 Dec 2019 14:51:44 +0530
Message-ID: <20191209092147.22901-11-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209092147.22901-1-kishon@ti.com>
References: <20191209092147.22901-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe EP mode dt-bindings for TI's J721E SoC.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/pci/ti,j721e-pci-ep.yaml         | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
new file mode 100644
index 000000000000..4e2af4733998
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/pci/ti,j721e-pci-ep.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TI J721E PCI EP (PCIe Wrapper)
+
+maintainers:
+  - Kishon Vijay Abraham I <kishon@ti.com>
+
+properties:
+  compatible:
+      enum:
+          - ti,j721e-pcie-ep
+
+  reg:
+    maxItems: 4
+
+  reg-names:
+    items:
+      - const: intd_cfg
+      - const: user_cfg
+      - const: reg
+      - const: mem
+
+  ti,syscon-pcie-ctrl:
+    description: Phandle to the SYSCON entry required for configuring PCIe mode
+                 and link speed.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle
+
+  max-link-speed:
+    minimum: 1
+    maximum: 3
+
+  num-lanes:
+    minimum: 1
+    maximum: 2
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: clock-specifier to represent input to the PCIe
+
+  clock-names:
+    items:
+      - const: fck
+
+  cdns,max-outbound-regions:
+    description: As defined in
+                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/int32
+      - enum: [16]
+
+  max-functions:
+    minimum: 1
+    maximum: 6
+
+  dma-coherent:
+    description: Indicates that the PCIe IP block can ensure the coherency
+
+  phys:
+    description: As defined in
+                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
+
+  phy-names:
+    description: As defined in
+                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - ti,syscon-pcie-ctrl
+  - max-link-speed
+  - num-lanes
+  - power-domains
+  - clocks
+  - clock-names
+  - cdns,max-outbound-regions
+  - dma-coherent
+  - max-functions
+  - phys
+  - phy-names
+
+examples:
+  - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+     pcie0_ep: pcie-ep@d000000 {
+            compatible = "ti,j721e-pcie-ep";
+            reg = <0x00 0x02900000 0x00 0x1000>,
+                  <0x00 0x02907000 0x00 0x400>,
+                  <0x00 0x0d000000 0x00 0x00800000>,
+                  <0x00 0x10000000 0x00 0x08000000>;
+            reg-names = "intd_cfg", "user_cfg", "reg", "mem";
+            ti,syscon-pcie-ctrl = <&pcie0_ctrl>;
+            max-link-speed = <3>;
+            num-lanes = <2>;
+            power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
+            clocks = <&k3_clks 239 1>;
+            clock-names = "fck";
+            cdns,max-outbound-regions = <16>;
+            max-functions = /bits/ 8 <6>;
+            dma-coherent;
+            phys = <&serdes0_pcie_link>;
+            phy-names = "pcie_phy";
+    };
-- 
2.17.1

