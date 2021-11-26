Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22BD45E96A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Nov 2021 09:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359569AbhKZIgy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 03:36:54 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43544 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359454AbhKZIex (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 03:34:53 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AQ8VS84027124;
        Fri, 26 Nov 2021 02:31:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637915488;
        bh=6LE8hBzXpp4wq4b9Z3ImFEHagMdc47MSMzKE/9w0Qw4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kVHAZx6nJVKkrqDvP4gV8HG1cmbhaJn26j0fFg3uqx7AezbSdLBuHvmqN22vg3+yS
         S2jaxVqvzXh8SDgBt6i2FuSfGhghED/MFy+gz4x0RhdAsY+kWSfCt0b6ud5Q6pYYla
         kGv0JOJKbES2hNVsaNlFgwEkTWTuPZRJ201d8toc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AQ8VSgr074507
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Nov 2021 02:31:28 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 26
 Nov 2021 02:31:27 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 26 Nov 2021 02:31:28 -0600
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AQ8VKEl127547;
        Fri, 26 Nov 2021 02:31:24 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/5] dt-bindings: PCI: ti,am65: Fix "ti,syscon-pcie-id"/"ti,syscon-pcie-mode" to take argument
Date:   Fri, 26 Nov 2021 14:01:15 +0530
Message-ID: <20211126083119.16570-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211126083119.16570-1-kishon@ti.com>
References: <20211126083119.16570-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix binding documentation of "ti,syscon-pcie-id" and "ti,syscon-pcie-mode"
to take phandle with argument. The argument is the register offset within
"syscon" used to configure PCIe controller. Similar change for j721e is
discussed in [1]

[1] -> http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/pci/ti,am65-pci-ep.yaml  |  8 ++++++--
 .../bindings/pci/ti,am65-pci-host.yaml           | 16 ++++++++++++----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
index 78c217d362a7..98d933b792e7 100644
--- a/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
@@ -32,8 +32,12 @@ properties:
     maxItems: 1
 
   ti,syscon-pcie-mode:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: Phandle to the SYSCON entry
+          - description: pcie_ctrl register offset within SYSCON
     description: Phandle to the SYSCON entry required for configuring PCIe in RC or EP mode.
-    $ref: /schemas/types.yaml#/definitions/phandle
 
   interrupts:
     minItems: 1
@@ -65,7 +69,7 @@ examples:
                <0x5506000 0x1000>;
         reg-names = "app", "dbics", "addr_space", "atu";
         power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
-        ti,syscon-pcie-mode = <&pcie0_mode>;
+        ti,syscon-pcie-mode = <&scm_conf 0x4060>;
         num-ib-windows = <16>;
         num-ob-windows = <16>;
         max-link-speed = <2>;
diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
index 834dc1c1743c..f909e262f593 100644
--- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
@@ -33,12 +33,20 @@ properties:
     maxItems: 1
 
   ti,syscon-pcie-id:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: Phandle to the SYSCON entry
+          - description: pcie_device_id register offset within SYSCON
     description: Phandle to the SYSCON entry required for getting PCIe device/vendor ID
-    $ref: /schemas/types.yaml#/definitions/phandle
 
   ti,syscon-pcie-mode:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: Phandle to the SYSCON entry
+          - description: pcie_ctrl register offset within SYSCON
     description: Phandle to the SYSCON entry required for configuring PCIe in RC or EP mode.
-    $ref: /schemas/types.yaml#/definitions/phandle
 
   msi-map: true
 
@@ -84,8 +92,8 @@ examples:
         #size-cells = <2>;
         ranges = <0x81000000 0 0          0x10020000 0 0x00010000>,
                  <0x82000000 0 0x10030000 0x10030000 0 0x07FD0000>;
-        ti,syscon-pcie-id = <&pcie_devid>;
-        ti,syscon-pcie-mode = <&pcie0_mode>;
+        ti,syscon-pcie-id = <&scm_conf 0x0210>;
+        ti,syscon-pcie-mode = <&scm_conf 0x4060>;
         bus-range = <0x0 0xff>;
         num-viewport = <16>;
         max-link-speed = <2>;
-- 
2.17.1

