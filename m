Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0FF671DD9
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 14:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjARNdZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 08:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjARNc6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 08:32:58 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C5358964;
        Wed, 18 Jan 2023 04:59:57 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30ICxd5C042737;
        Wed, 18 Jan 2023 06:59:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674046780;
        bh=OmDhyxusumxXEVyuH5Sjllr2iDvvrq2e6vgSiOeP5YM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KmOBihnfjfv9Qu0r/HhsNxQdion004LK+Ke+onUX4sHSZ0Nur7mzbw2I5dNMSmW8F
         WmiAmxlj8tyqcvBaVkzooqQMAnxJ7MvEs+qFNU+CFE1QKp72QdjddHLu8DDrksD4e8
         aWaxFQF9wSIC9lQSeUlhJRAzrg8MsitgrmGfABzc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30ICxdQD010085
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Jan 2023 06:59:39 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 18
 Jan 2023 06:59:39 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 18 Jan 2023 06:59:39 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30ICxc2V016777;
        Wed, 18 Jan 2023 06:59:39 -0600
From:   Achal Verma <a-verma1@ti.com>
To:     <mranostay@ti.com>, <rogerq@kernel.org>, <lpieralisi@kernel.org>,
        <robh@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <krzysztof.kozlowski@linaro.org>, <vigneshr@ti.com>,
        <tjoseph@cadence.com>, <sergio.paracuellos@gmail.com>,
        <pthombar@cadence.com>, <linux-pci@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 1/5] dt-bindings: PCI: ti,j721e-pci-*: add checks for num-lanes
Date:   Wed, 18 Jan 2023 18:29:32 +0530
Message-ID: <20230118125936.3456716-2-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230118125936.3456716-1-a-verma1@ti.com>
References: <20230118125936.3456716-1-a-verma1@ti.com>
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

Add num-lanes schema checks based on compatible string on available lanes
for that platform.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
Signed-off-by: Achal Verma <a-verma1@ti.com>
---
 .../bindings/pci/ti,j721e-pci-ep.yaml         | 28 +++++++++++++++++--
 .../bindings/pci/ti,j721e-pci-host.yaml       | 28 +++++++++++++++++--
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
index 10e6eabdff53..403cd3ef1177 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
@@ -10,9 +10,6 @@ title: TI J721E PCI EP (PCIe Wrapper)
 maintainers:
   - Kishon Vijay Abraham I <kishon@ti.com>
 
-allOf:
-  - $ref: "cdns-pcie-ep.yaml#"
-
 properties:
   compatible:
     oneOf:
@@ -65,6 +62,31 @@ properties:
     items:
       - const: link_state
 
+allOf:
+  - $ref: cdns-pcie-ep.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - ti,am64-pcie-ep
+    then:
+      properties:
+        num-lanes:
+          minimum: 1
+          maximum: 1
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - ti,j7200-pcie-ep
+            - ti,j721e-pcie-ep
+    then:
+      properties:
+        num-lanes:
+          minimum: 1
+          maximum: 2
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index b0513b197d08..7bd78cfca845 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -10,9 +10,6 @@ title: TI J721E PCI Host (PCIe Wrapper)
 maintainers:
   - Kishon Vijay Abraham I <kishon@ti.com>
 
-allOf:
-  - $ref: "cdns-pcie-host.yaml#"
-
 properties:
   compatible:
     oneOf:
@@ -98,6 +95,31 @@ properties:
       interrupts:
         maxItems: 1
 
+allOf:
+  - $ref: cdns-pcie-host.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - ti,am64-pcie-host
+    then:
+      properties:
+        num-lanes:
+          minimum: 1
+          maximum: 1
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - ti,j7200-pcie-host
+            - ti,j721e-pcie-host
+    then:
+      properties:
+        num-lanes:
+          minimum: 1
+          maximum: 2
+
 required:
   - compatible
   - reg
-- 
2.25.1

