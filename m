Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E96348C10
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 10:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhCYJBI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 05:01:08 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38290 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhCYJAu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 05:00:50 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12P90eNS101329;
        Thu, 25 Mar 2021 04:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616662840;
        bh=5v/9COS7STv0Pp1b/RvH5GIPWWy1VQ/hFRswDe7GXZw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RDW6z0wWjaJIa+KkFEnsAqIRweNP0lOHtQ5YCHxai1fyyuTSLVcCevGW1y+vdiszq
         BtsrK6mnpxeLxnPKKRHCNcVBnKDSwyD544o0+1MtKWNtOyXjqHc+OrvlOpZcaTxnEy
         eXFkt1L/6ys5bdwzwdD0LtjeUntxhve5yCob1268=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12P90eVO124244
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Mar 2021 04:00:40 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 25
 Mar 2021 04:00:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 25 Mar 2021 04:00:40 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12P90Rk9115556;
        Thu, 25 Mar 2021 04:00:36 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 2/6] dt-bindings: PCI: ti,am65: Add PCIe endpoint mode dt-bindings for TI's AM65 SoC
Date:   Thu, 25 Mar 2021 14:30:22 +0530
Message-ID: <20210325090026.8843-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210325090026.8843-1-kishon@ti.com>
References: <20210325090026.8843-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe endpoint mode dt-bindings for TI's AM65 SoC.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/pci/ti,am65-pci-ep.yaml          | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml

diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
new file mode 100644
index 000000000000..f0a5518e6331
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/pci/ti,am65-pci-ep.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TI AM65 PCI Endpoint
+
+maintainers:
+  - Kishon Vijay Abraham I <kishon@ti.com>
+
+allOf:
+  - $ref: "pci-ep.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - ti,am654-pcie-ep
+
+  reg:
+    maxItems: 4
+
+  reg-names:
+    items:
+      - const: app
+      - const: dbics
+      - const: addr_space
+      - const: atu
+
+  power-domains:
+    maxItems: 1
+
+  ti,syscon-pcie-mode:
+    description: Phandle to the SYSCON entry required for configuring PCIe in RC or EP mode.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  interrupts:
+    minItems: 1
+
+  dma-coherent: true
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - max-link-speed
+  - num-lanes
+  - power-domains
+  - ti,syscon-pcie-mode
+  - phys
+  - phy-names
+  - dma-coherent
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie0_ep: pcie-ep@5500000 {
+                compatible = "ti,am654-pcie-ep";
+                reg =  <0x0 0x5500000 0x0 0x1000>,
+                       <0x0 0x5501000 0x0 0x1000>,
+                       <0x0 0x10000000 0x0 0x8000000>,
+                       <0x0 0x5506000 0x0 0x1000>;
+                reg-names = "app", "dbics", "addr_space", "atu";
+                power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
+                ti,syscon-pcie-mode = <&pcie0_mode>;
+                num-ib-windows = <16>;
+                num-ob-windows = <16>;
+                max-link-speed = <2>;
+                dma-coherent;
+                interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
+        };
-- 
2.17.1

