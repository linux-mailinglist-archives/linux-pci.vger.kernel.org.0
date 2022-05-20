Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2716152E91D
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 11:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347860AbiETJmq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 05:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347835AbiETJmn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 05:42:43 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61701498CD;
        Fri, 20 May 2022 02:42:23 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id B1EA41C0010;
        Fri, 20 May 2022 09:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653039742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E+wBIttrMTwzTgAXDWmn71GDy198lvRu0VhpdGU+5b4=;
        b=G5PdQpAu887/K/5/zqHowISzhW2hKkCfg5i1RFUkYyNcz5L/0xkcPBrCQPNsIffVWwzTWM
        6YqbOA8H5g+fFXLmJrdtoOsaJ3L2J8NyaIH2CU472W/xlbQuabiiUmfXFvE4GiajitfMas
        d/lnkZa7oq8igVqkFaHQdrq9oFC20NIpfpyNWJha+OQ9zcs9+ngqJLq9kFvnHOI7bgg/YR
        JC5pKcbAOVEhWp2pJ3+33UvJMbaCV49UP4tvs0c6uXQDE9UCMVk0sT09T/YXSrlOl+xmqD
        UKgWFtF1JgDaev9+wBOJEOYNDGSX8ib8wPxYVQrjZRFsY4JeJ1gsB11b8fuNuw==
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
Subject: [PATCH v6 2/6] dt-bindings: PCI: renesas,pci-rcar-gen2: Add device tree support for r9a06g032
Date:   Fri, 20 May 2022 11:41:51 +0200
Message-Id: <20220520094155.313784-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520094155.313784-1-herve.codina@bootlin.com>
References: <20220520094155.313784-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

The 'resets' property for the RZ/N1 family is not required.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../bindings/pci/renesas,pci-rcar-gen2.yaml   | 50 +++++++++++++++----
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
index 494eb975c146..0f18cceba3d5 100644
--- a/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
+++ b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
@@ -15,9 +15,6 @@ description: |
   AHB. There is one bridge instance per USB port connected to the internal
   OHCI and EHCI controllers.
 
-allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -32,6 +29,10 @@ properties:
               - renesas,pci-r8a7793      # R-Car M2-N
               - renesas,pci-r8a7794      # R-Car E2
           - const: renesas,pci-rcar-gen2 # R-Car Gen2 and RZ/G1
+      - items:
+          - enum:
+              - renesas,pci-r9a06g032     # RZ/N1D
+          - const: renesas,pci-rzn1       # RZ/N1
 
   reg:
     items:
@@ -41,13 +42,9 @@ properties:
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
@@ -106,13 +103,46 @@ required:
   - interrupt-map
   - interrupt-map-mask
   - clocks
-  - resets
   - power-domains
   - bus-range
   - "#address-cells"
   - "#size-cells"
   - "#interrupt-cells"
 
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,pci-rzn1
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Internal bus clock (AHB) for HOST
+            - description: Internal bus clock (AHB) Power Management
+            - description: PCI clock for USB subsystem
+        clock-names:
+          items:
+            - const: hclkh
+            - const: hclkpm
+            - const: pciclk
+      required:
+        - clock-names
+    else:
+      properties:
+        clocks:
+          items:
+            - description: Device clock
+        clock-names:
+          items:
+            - const: pclk
+      required:
+        - resets
+
 unevaluatedProperties: false
 
 examples:
-- 
2.35.1

