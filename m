Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D5C2B4CFE
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 18:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733063AbgKPRcJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 12:32:09 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40266 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733056AbgKPRcJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 12:32:09 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AGHW0In043047;
        Mon, 16 Nov 2020 11:32:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605547920;
        bh=1b057Ybo9I/E/KKizOvqW3tp1N+aVgmJ+djVX4jFDFU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HP2l67plA3VeYSBI6SU2GtXqOOgmZDHSVk2kApk5Q1VufVdvWDRe3VKIYfPG5A8h6
         26EaqU3jjsqk3WTJqct0O2PdmwWRYfKYBTj3Kwtes0cPPYeYxGdpe5KbgA5oAy205S
         4UHdK5HbmpwNycq2OGeVz/PEUEALHRw9zIE1654U=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AGHW0Jm076227
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 11:32:00 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 16
 Nov 2020 11:32:00 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 16 Nov 2020 11:32:00 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AGHVgJG030552;
        Mon, 16 Nov 2020 11:31:56 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-omap@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] dt-bindings: pci: ti,j721e: Fix "ti,syscon-pcie-ctrl" to take argument
Date:   Mon, 16 Nov 2020 23:01:39 +0530
Message-ID: <20201116173141.31873-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116173141.31873-1-kishon@ti.com>
References: <20201116173141.31873-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix binding documentation of "ti,syscon-pcie-ctrl" to take phandle with
argument. The argument is the register offset within "syscon" used to
configure PCIe controller.

Link: Link: http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml     | 12 ++++++++----
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml   | 12 ++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
index 3ae3e1a2d4b0..e9685c0bdc3e 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
@@ -29,9 +29,13 @@ properties:
       - const: mem
 
   ti,syscon-pcie-ctrl:
-    description: Phandle to the SYSCON entry required for configuring PCIe mode
-                 and link speed.
-    $ref: /schemas/types.yaml#/definitions/phandle
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle-array
+      - items:
+          - items:
+            - description: Phandle to the SYSCON entry
+            - description: pcie_ctrl register offset within SYSCON
+    description: Specifier for configuring PCIe mode and link speed.
 
   power-domains:
     maxItems: 1
@@ -80,7 +84,7 @@ examples:
                  <0x00 0x0d000000 0x00 0x00800000>,
                  <0x00 0x10000000 0x00 0x08000000>;
            reg-names = "intd_cfg", "user_cfg", "reg", "mem";
-           ti,syscon-pcie-ctrl = <&pcie0_ctrl>;
+           ti,syscon-pcie-ctrl = <&pcie0_ctrl 0x4070>;
            max-link-speed = <3>;
            num-lanes = <2>;
            power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index ee7a8eade3f6..a3b82992bcfa 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -29,9 +29,13 @@ properties:
       - const: cfg
 
   ti,syscon-pcie-ctrl:
-    description: Phandle to the SYSCON entry required for configuring PCIe mode
-      and link speed.
-    $ref: /schemas/types.yaml#/definitions/phandle
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle-array
+      - items:
+          - items:
+            - description: Phandle to the SYSCON entry
+            - description: pcie_ctrl register offset within SYSCON
+    description: Specifier for configuring PCIe mode and link speed.
 
   power-domains:
     maxItems: 1
@@ -90,7 +94,7 @@ examples:
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

