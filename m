Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4262CE8D8
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 08:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgLDHxM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 02:53:12 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45244 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgLDHxM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Dec 2020 02:53:12 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B47qBFU068550;
        Fri, 4 Dec 2020 01:52:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607068331;
        bh=yzdzLYP32qo3w6V1OyjfV6SOJjwyiFbBdJ/Xu1to+A8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=e/MWBtaaMatWOOg7HEJU31XwJf7BDNOqXMQAygxVOWg/bbu6XnflUlume+5XVfs9O
         LkyAbN1xdUh+PT2SaeaExFPCFvdmZClRN0Dvl9iwnhIgmJ2nQnlwYv7HQ9ZjaTE22a
         /nAV1sh+VJkaZHN5icf8sr33pOcrGAuvdFU2u4ZY=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B47qBF5090865
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Dec 2020 01:52:11 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 4 Dec
 2020 01:52:10 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 4 Dec 2020 01:52:10 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B47pL6t031834;
        Fri, 4 Dec 2020 01:51:57 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: pci: ti,j721e: Fix "ti,syscon-pcie-ctrl" to take argument
Date:   Fri, 4 Dec 2020 13:21:15 +0530
Message-ID: <20201204075117.10430-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201204075117.10430-1-kishon@ti.com>
References: <20201204075117.10430-1-kishon@ti.com>
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

