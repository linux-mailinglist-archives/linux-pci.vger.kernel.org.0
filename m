Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A9D2D5AE1
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 13:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733239AbgLJMun (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 07:50:43 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46754 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732831AbgLJMua (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2020 07:50:30 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BACnU1i047474;
        Thu, 10 Dec 2020 06:49:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607604570;
        bh=Dtt2z35S/y3LA+4MvOenkJyQyKKN9WQT4N5VF53o60w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HAL9jNYaxJm5Fi6cYcACaIkKzmwXftMXFML/j+42tAMNKAkg+llzOAdTfXjKpX+UU
         Uz0GdS6QHUH2PE6UdJatoGDoyUPffQhP0Erp3TnJrDtHbOfjA2V9Sd+4adDPARl2S0
         lmNdI2xZHg7BYhwph/G4nqnEMKaYp+RDDQTtei0w=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BACnUjb108594
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 06:49:30 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 10
 Dec 2020 06:49:30 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 10 Dec 2020 06:49:30 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BACnKJM112244;
        Thu, 10 Dec 2020 06:49:24 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RESEND PATCH 1/4] dt-bindings: pci: ti,j721e: Fix "ti,syscon-pcie-ctrl" to take argument
Date:   Thu, 10 Dec 2020 18:19:14 +0530
Message-ID: <20201210124917.24185-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201210124917.24185-1-kishon@ti.com>
References: <20201210124917.24185-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix binding documentation of "ti,syscon-pcie-ctrl" to take phandle with
argument. The argument is the register offset within "syscon" used to
configure PCIe controller. This change is as discussed in [1]

[1] -> http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com

Fixes: 431b53b81cdc ("dt-bindings: PCI: Add host mode dt-bindings for TI's J721E SoC")
Fixes: 45b39e928966 ("dt-bindings: PCI: Add EP mode dt-bindings for TI's J721E SoC")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml      | 11 +++++++----
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml    | 11 +++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
index 3ae3e1a2d4b0..3766565cf258 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
@@ -29,9 +29,12 @@ properties:
       - const: mem
 
   ti,syscon-pcie-ctrl:
-    description: Phandle to the SYSCON entry required for configuring PCIe mode
-                 and link speed.
-    $ref: /schemas/types.yaml#/definitions/phandle
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: Phandle to the SYSCON entry
+          - description: pcie_ctrl register offset within SYSCON
+    description: Specifier for configuring PCIe mode and link speed.
 
   power-domains:
     maxItems: 1
@@ -80,7 +83,7 @@ examples:
                  <0x00 0x0d000000 0x00 0x00800000>,
                  <0x00 0x10000000 0x00 0x08000000>;
            reg-names = "intd_cfg", "user_cfg", "reg", "mem";
-           ti,syscon-pcie-ctrl = <&pcie0_ctrl>;
+           ti,syscon-pcie-ctrl = <&pcie0_ctrl 0x4070>;
            max-link-speed = <3>;
            num-lanes = <2>;
            power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index ee7a8eade3f6..2b6a1a5eaf7a 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -29,9 +29,12 @@ properties:
       - const: cfg
 
   ti,syscon-pcie-ctrl:
-    description: Phandle to the SYSCON entry required for configuring PCIe mode
-      and link speed.
-    $ref: /schemas/types.yaml#/definitions/phandle
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: Phandle to the SYSCON entry
+          - description: pcie_ctrl register offset within SYSCON
+    description: Specifier for configuring PCIe mode and link speed.
 
   power-domains:
     maxItems: 1
@@ -90,7 +93,7 @@ examples:
                   <0x00 0x0d000000 0x00 0x00800000>,
                   <0x00 0x10000000 0x00 0x00001000>;
             reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
-            ti,syscon-pcie-ctrl = <&pcie0_ctrl>;
+            ti,syscon-pcie-ctrl = <&pcie0_ctrl 0x4070>;
             max-link-speed = <3>;
             num-lanes = <2>;
             power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
-- 
2.17.1

