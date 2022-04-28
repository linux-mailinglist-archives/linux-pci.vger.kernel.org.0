Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E0B5137FB
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 17:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348951AbiD1PUB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 11:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348943AbiD1PUA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 11:20:00 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A3BAFB12;
        Thu, 28 Apr 2022 08:16:43 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id CFBF5E000E;
        Thu, 28 Apr 2022 15:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651159002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06TMdTJYHqBbnJ4uCL9uIfbfmJMh8P3o+sNzkdRLVYU=;
        b=VaJz3r5dZprrzxiGSNZRwiDaUqn6tx0m3l9IZx8hsDEg9aB1QkSj5lu6ZAjyrYaT09RtfU
        W/826eRcGh+HuObgGsAnvAEcAOhNCKBa9M5CsVlkp1LL2xhJcXnHBqyvg9DPe9R+gR5ukf
        984g/4Qty8bQNNDUG8jOWkRr+hpGfZeg7vLZ+vawIzuXT+yfI2YQFsU21HFiDBDWrOVQA9
        IRdjy75J6A6wt8n0C4HLhGhCGRFHsJbq55x07UaSSoMy2zPmGbimmXjo0hdBGagj7FvpuF
        5ydJ5M03uK/V+46sPXKrJ9R6CKzYGhB8YhoRGCAlNyBr3Yik9VCzzNq9Somb2A==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v4 2/6] dt-bindings: PCI: renesas,pci-rcar-gen2: Add device tree support for r9a06g032
Date:   Thu, 28 Apr 2022 17:16:26 +0200
Message-Id: <20220428151630.586009-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428151630.586009-1-herve.codina@bootlin.com>
References: <20220428151630.586009-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add internal PCI bridge support for the r9a06g032 SOC. The Renesas
RZ/N1D (R9A06G032) internal PCI bridge is compatible with the one
present in the R-Car Gen2 family.
Compared to the R-Car Gen2 family, it needs three clocks instead of
one.

The 'resets' property for the RZ/N1 family is not required since
there is no reset-controller support yet for the RZ/N1 family.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/pci/renesas,pci-rcar-gen2.yaml   | 46 ++++++++++++++++---
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
index 494eb975c146..90b42d44c582 100644
--- a/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
+++ b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
@@ -32,6 +32,10 @@ properties:
               - renesas,pci-r8a7793      # R-Car M2-N
               - renesas,pci-r8a7794      # R-Car E2
           - const: renesas,pci-rcar-gen2 # R-Car Gen2 and RZ/G1
+      - items:
+          - enum:
+              - renesas,pci-r9a06g032     # RZ/N1D
+          - const: renesas,pci-rzn1       # RZ/N1
 
   reg:
     items:
@@ -41,13 +45,9 @@ properties:
   interrupts:
     maxItems: 1
 
-  clocks:
-    items:
-      - description: Device clock
+  clocks: true
 
-  clock-names:
-    items:
-      - const: pclk
+  clock-names: true
 
   resets:
     maxItems: 1
@@ -106,13 +106,45 @@ required:
   - interrupt-map
   - interrupt-map-mask
   - clocks
-  - resets
   - power-domains
   - bus-range
   - "#address-cells"
   - "#size-cells"
   - "#interrupt-cells"
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - renesas,pci-rzn1
+
+then:
+  properties:
+    clocks:
+      items:
+        - description: Internal bus clock (AHB) for HOST
+        - description: Internal bus clock (AHB) Power Management
+        - description: PCI clock for USB subsystem
+    clock-names:
+      items:
+        - const: usb_hclkh
+        - const: usb_hclkpm
+        - const: usb_pciclk
+  required:
+    - clock-names
+
+else:
+  properties:
+    clocks:
+      items:
+        - description: Device clock
+    clock-names:
+      items:
+        - const: pclk
+  required:
+    - resets
+
 unevaluatedProperties: false
 
 examples:
-- 
2.35.1

