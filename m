Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7CA6BC6BE
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 08:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCPHO2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 03:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjCPHOQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 03:14:16 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B35AF2B8;
        Thu, 16 Mar 2023 00:13:52 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32G7CkQ3018063;
        Thu, 16 Mar 2023 02:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678950766;
        bh=/KtIEHYVe129q/U6+XWH0X7x8R+UBCCGDZvXUUhmAPA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FvNVnpbTigLo6HFRLt1ywnOKOgEBasJ4FQOdFkQTclbqjEUdBZm4h7WkswfBAmcqR
         GzH+mE1q7HcKl7O1TbyWczfDowGwvBAEKHMKU6dchn08NtMem2T6nLW62naIdUvttl
         yNPEMm/LONZSqbGzZAZ5FOc8jDricXvkRP3TYOmU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32G7Ckkw058096
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Mar 2023 02:12:46 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 16
 Mar 2023 02:12:45 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 16 Mar 2023 02:12:45 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32G7CjlT032375;
        Thu, 16 Mar 2023 02:12:45 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Achal Verma <a-verma1@ti.com>,
        Milind Parab <mparab@cadence.com>,
        <wojciech.jasko-EXT@continental-corporation.com>
Subject: [PATCH v10 4/5] dt-bindings: PCI: ti,j721e-pci-*: add j784s4-pci-* compatible strings
Date:   Thu, 16 Mar 2023 12:42:37 +0530
Message-ID: <20230316071238.200992-5-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316071238.200992-1-a-verma1@ti.com>
References: <20230316071238.200992-1-a-verma1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Matt Ranostay <mranostay@ti.com>

Add definition for j784s4-pci-ep + j784s4-pci-host devices along with
schema checks for num-lanes.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Achal Verma <a-verma1@ti.com>
---
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml     | 12 ++++++++++++
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml   | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
index 32e0c70ed801..d2fbf1f7aa54 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
@@ -14,6 +14,7 @@ properties:
   compatible:
     oneOf:
       - const: ti,j721e-pcie-ep
+      - const: ti,j784s4-pcie-ep
       - description: PCIe EP controller in AM64
         items:
           - const: ti,am64-pcie-ep
@@ -86,6 +87,17 @@ allOf:
           minimum: 1
           maximum: 2
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - ti,j784s4-pcie-ep
+    then:
+      properties:
+        num-lanes:
+          minimum: 1
+          maximum: 4
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index 2547088304e5..e41d6f403493 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -14,6 +14,7 @@ properties:
   compatible:
     oneOf:
       - const: ti,j721e-pcie-host
+      - const: ti,j784s4-pcie-host
       - description: PCIe controller in AM64
         items:
           - const: ti,am64-pcie-host
@@ -115,6 +116,17 @@ allOf:
           minimum: 1
           maximum: 2
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - ti,j784s4-pcie-host
+    then:
+      properties:
+        num-lanes:
+          minimum: 1
+          maximum: 4
+
 required:
   - compatible
   - reg
-- 
2.25.1

