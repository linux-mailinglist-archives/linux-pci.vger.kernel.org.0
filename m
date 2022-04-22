Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5646550B6EE
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 14:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447333AbiDVMMB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 08:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447328AbiDVML7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 08:11:59 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84AF5643E;
        Fri, 22 Apr 2022 05:09:05 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id C60DB240006;
        Fri, 22 Apr 2022 12:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650629341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ya/1j72S7VzDx1yZNiE4V0jz32RXuF9hi7EUmtTZxoo=;
        b=KRn0cW7Vp2zvXeBTFz09gRN7V4SUj1whS1/sWTZRpB9WWrYVFr+M9j6Ync0YuVK67A0cK9
        vzYgTMOQSzHjzOfXxYIk1CpfMvhE6pQiiuQulVFA/odYHWFLwKsovfWxmVcl/sENXcQMe2
        weq+Rm+ACi6Y5rg06Nr7Kp+Z5JW4eWkY3Wkj/ixF3ui/Gs7FxFToeu3k+vzkmC9j8jdmj6
        dRc9U/mvh0E+OwlpoQKUU9W5XyUf8X2j0HGYFuyb7UFqUwPXCit2FeEukdFF3bmRUN7Y3K
        hiSpPYv2+idIwrD5K6BbociCC8UhjIhz2rtT/dH3bt3Z3+B3NQi2HFtWMU2Gpg==
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
Subject: [PATCH v3 2/8] dt-bindings: PCI: renesas,pci-rcar-gen2: Add device tree support for r9a06g032
Date:   Fri, 22 Apr 2022 14:08:44 +0200
Message-Id: <20220422120850.769480-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422120850.769480-1-herve.codina@bootlin.com>
References: <20220422120850.769480-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/pci/renesas,pci-rcar-gen2.yaml   | 43 ++++++++++++++++---
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
index 494eb975c146..c29c46533e1b 100644
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
@@ -113,6 +113,37 @@ required:
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
+        - const: hclk_usbh
+        - const: hclk_usbpm
+        - const: clk_pci_usb
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
+
 unevaluatedProperties: false
 
 examples:
-- 
2.35.1

