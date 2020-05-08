Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027DF1CAE27
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 15:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgEHNHK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 09:07:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48458 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgEHNHH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 May 2020 09:07:07 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 048D6rJs088052;
        Fri, 8 May 2020 08:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588943213;
        bh=92Ee+tMLcURU8mNv/W9fRnCJAHuvD9EdOs9ASqzvK88=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hjY4J2jGmYErx/clt3GNJdUEEKwfEszWnG2t/mJcvS8/8F2ikQIsSSmLGIrXGkBH0
         muYhrHuUnpulIom79b3xNftzB/iI2wlJodZi2VXtpdKkbx0wfYTkOmex/O6Ch+KJoX
         wRI1E8uEypLW+rOaraKD2DsBTGRIW3LF7heL0yVk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 048D6rlq103723
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 May 2020 08:06:53 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 May
 2020 08:06:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 8 May 2020 08:06:53 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 048D6kYl018673;
        Fri, 8 May 2020 08:06:50 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tom Joseph <tjoseph@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kishon@ti.com>
Subject: [PATCH v3 1/4] dt-bindings: PCI: cadence: Deprecate inbound/outbound specific bindings
Date:   Fri, 8 May 2020 18:36:43 +0530
Message-ID: <20200508130646.23939-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508130646.23939-1-kishon@ti.com>
References: <20200508130646.23939-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Deprecate cdns,max-outbound-regions and cdns,no-bar-match-nbits for
host mode as both these could be derived from "ranges" and "dma-ranges"
property. "cdns,max-outbound-regions" property would still be required
for EP mode.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Tom Joseph <tjoseph@cadence.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/pci/cdns,cdns-pcie-ep.yaml       |  2 +-
 .../bindings/pci/cdns,cdns-pcie-host.yaml     |  3 +--
 .../devicetree/bindings/pci/cdns-pcie-ep.yaml | 25 +++++++++++++++++++
 .../bindings/pci/cdns-pcie-host.yaml          | 10 ++++++++
 .../devicetree/bindings/pci/cdns-pcie.yaml    |  8 ------
 5 files changed, 37 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
index 2996f8d4777c..50ce5d79d2c7 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Tom Joseph <tjoseph@cadence.com>
 
 allOf:
-  - $ref: "cdns-pcie.yaml#"
+  - $ref: "cdns-pcie-ep.yaml#"
   - $ref: "pci-ep.yaml#"
 
 properties:
diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
index cabbe46ff578..84a8f095d031 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
@@ -45,8 +45,6 @@ examples:
             #size-cells = <2>;
             bus-range = <0x0 0xff>;
             linux,pci-domain = <0>;
-            cdns,max-outbound-regions = <16>;
-            cdns,no-bar-match-nbits = <32>;
             vendor-id = <0x17cd>;
             device-id = <0x0200>;
 
@@ -57,6 +55,7 @@ examples:
 
             ranges = <0x02000000 0x0 0x42000000  0x0 0x42000000  0x0 0x1000000>,
                      <0x01000000 0x0 0x43000000  0x0 0x43000000  0x0 0x0010000>;
+            dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x1 0x00000000>;
 
             #interrupt-cells = <0x1>;
 
diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
new file mode 100644
index 000000000000..6150a7a7bdbf
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/pci/cdns-pcie-ep.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Cadence PCIe Device
+
+maintainers:
+  - Tom Joseph <tjoseph@cadence.com>
+
+allOf:
+  - $ref: "cdns-pcie.yaml#"
+
+properties:
+  cdns,max-outbound-regions:
+    description: maximum number of outbound regions
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 32
+    default: 32
+
+required:
+  - cdns,max-outbound-regions
diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
index ab6e43b636ec..3d64f85aeb39 100644
--- a/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
@@ -14,6 +14,15 @@ allOf:
   - $ref: "cdns-pcie.yaml#"
 
 properties:
+  cdns,max-outbound-regions:
+    description: maximum number of outbound regions
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 32
+    default: 32
+    deprecated: true
+
   cdns,no-bar-match-nbits:
     description:
       Set into the no BAR match register to configure the number of least
@@ -23,5 +32,6 @@ properties:
     minimum: 0
     maximum: 64
     default: 32
+    deprecated: true
 
   msi-parent: true
diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie.yaml
index 6887ccc339cc..02553d5e6c51 100644
--- a/Documentation/devicetree/bindings/pci/cdns-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie.yaml
@@ -10,14 +10,6 @@ maintainers:
   - Tom Joseph <tjoseph@cadence.com>
 
 properties:
-  cdns,max-outbound-regions:
-    description: maximum number of outbound regions
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-    minimum: 1
-    maximum: 32
-    default: 32
-
   phys:
     description:
       One per lane if more than one in the list. If only one PHY listed it must
-- 
2.17.1

