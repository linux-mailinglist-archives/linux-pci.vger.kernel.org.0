Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3076D3023
	for <lists+linux-pci@lfdr.de>; Sat,  1 Apr 2023 13:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjDAL12 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Apr 2023 07:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDAL10 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Apr 2023 07:27:26 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E93A23B51;
        Sat,  1 Apr 2023 04:27:01 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 331BQerD094930;
        Sat, 1 Apr 2023 06:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680348400;
        bh=/KtIEHYVe129q/U6+XWH0X7x8R+UBCCGDZvXUUhmAPA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GqIlX3cBjB3o03gIe7lcA9c2nmcGz1LG4xUHBgfFVYWHjUxXxMhE/6P/e5LyWJesy
         A+V05U68QjL2/9eCOdmago4ip6mqG3qoVHGI2p7AtrTGQg6VsKsPCz+z4bMxYz/wHG
         Azj5IeB25gMUb/XSjA0xW+ytS1LpCHgNZh7ddUyc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 331BQeKi032259
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 1 Apr 2023 06:26:40 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sat, 1
 Apr 2023 06:26:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sat, 1 Apr 2023 06:26:40 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 331BQdAb005581;
        Sat, 1 Apr 2023 06:26:40 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dhananjay Vilasrao Kangude <dkangude@cadence.com>,
        Anindita Das <dasa@cadence.com>,
        Yuan Zhao <yuanzhao@cadence.com>,
        Milind Parab <mparab@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Achal Verma <a-verma1@ti.com>
Subject: [PATCH v12 4/5] dt-bindings: PCI: ti,j721e-pci-*: add j784s4-pci-* compatible strings
Date:   Sat, 1 Apr 2023 16:56:32 +0530
Message-ID: <20230401112633.2406604-5-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230401112633.2406604-1-a-verma1@ti.com>
References: <20230401112633.2406604-1-a-verma1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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

