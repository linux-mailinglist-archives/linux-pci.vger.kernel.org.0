Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A4A514ADB
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 15:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376323AbiD2NpX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 09:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376336AbiD2NpW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 09:45:22 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C814C8BD9;
        Fri, 29 Apr 2022 06:41:59 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 8F9B31BF203;
        Fri, 29 Apr 2022 13:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651239718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZvWaj7kw5MGb8QyOny/MnqwKXJHfwAIyTe4kVHOxwB8=;
        b=PgHKF5zj6j6859PuLYJADYu1bqsXQdL2qjUfEcjX6W1fON/MijLx5/eqhmoq1wb11gYcOk
        TtJjlP+9H4jFnqJ6fR4yyWvGWfwnLYUEp4gvSWnhlucs1JAQJjs91kPFuu9sVcUts/GeT2
        A0xEYNlaRQEMp1QiIyY0eotEiZ4re9HTnDC2QY0UexiDQrdsj9D14SVhOA8gKbmfWeJ9Sk
        yN4YY5Pg+CyiGLUcOc9MHp/esWO9/Ha75iMcR5tzAeTcqq+kWRyRnDSOOt00Hi/aatyPLf
        fU/A5s+Osg6LEtbkGiOXXgzjR8n8I6x1R2IiKagjm51m0un84yP3twsBdjl5cQ==
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
Subject: [PATCH v5 2/6] dt-bindings: PCI: renesas,pci-rcar-gen2: Add device tree support for r9a06g032
Date:   Fri, 29 Apr 2022 15:41:39 +0200
Message-Id: <20220429134143.628428-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429134143.628428-1-herve.codina@bootlin.com>
References: <20220429134143.628428-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../bindings/pci/renesas,pci-rcar-gen2.yaml   | 46 ++++++++++++++++---
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
index 494eb975c146..a9f806794f12 100644
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
+        - const: hclkh
+        - const: hclkpm
+        - const: pciclk
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

