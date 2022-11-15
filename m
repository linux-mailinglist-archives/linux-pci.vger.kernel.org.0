Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE91629CFD
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 16:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiKOPJQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 10:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiKOPJM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 10:09:12 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BE52CCAF
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 07:09:06 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AFF8xAo068924;
        Tue, 15 Nov 2022 09:08:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668524939;
        bh=MUc+7nZalvE3H0qKJUjdx2i72KJIWYh/+IbsOojJpnA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gu7489+HCoxnjR/748dltYbpxXf/dXfGWYwydf/VJbTAgsy2buVjiJJYGP8w3wX7f
         KqNW2MU+BRSE5Zv1jQ9oM+EduScFhLSv22c/cAuMpvDbbPvB3FjWV88wHDJwTFYCEa
         4Ww6Ym77cNoIwKyXUad5OtFbVvyaUHdderBVKZlo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AFF3xKH004322
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Nov 2022 09:03:59 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 15
 Nov 2022 09:03:59 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 15 Nov 2022 09:03:59 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AFF3uF2025683;
        Tue, 15 Nov 2022 09:03:58 -0600
From:   Matt Ranostay <mranostay@ti.com>
To:     <vigneshr@ti.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v6 4/5] dt-bindings: PCI: ti,j721e-pci-*: add j784s4-pci-* compatible strings
Date:   Tue, 15 Nov 2022 07:03:34 -0800
Message-ID: <20221115150335.501502-5-mranostay@ti.com>
X-Mailer: git-send-email 2.38.GIT
In-Reply-To: <20221115150335.501502-1-mranostay@ti.com>
References: <20221115150335.501502-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add definition for j784s4-pci-ep + j784s4-pci-host devices along with
schema checks for num-lanes.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml   | 12 ++++++++++++
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml | 14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
index 1aeea168d3d0..2e6226cbd1d3 100644
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
@@ -87,6 +88,17 @@ allOf:
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
index 8eca0d08303f..e21aa6afeabf 100644
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
@@ -120,6 +121,19 @@ allOf:
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
+
+
 required:
   - compatible
   - reg
-- 
2.38.GIT

