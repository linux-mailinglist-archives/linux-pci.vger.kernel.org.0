Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A025F504A28
	for <lists+linux-pci@lfdr.de>; Mon, 18 Apr 2022 02:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbiDRAVG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Apr 2022 20:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiDRAVE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Apr 2022 20:21:04 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4E90DECD;
        Sun, 17 Apr 2022 17:18:26 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 18 Apr 2022 09:18:24 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 5AF5A2058B50;
        Mon, 18 Apr 2022 09:18:24 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 18 Apr 2022 09:18:24 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id C41EFB6389;
        Mon, 18 Apr 2022 09:18:23 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 2/2] dt-bindings: PCI: uniphier-ep: Clean up reg, clocks, resets, and their names using compatible string
Date:   Mon, 18 Apr 2022 09:18:20 +0900
Message-Id: <1650241100-3606-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650241100-3606-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1650241100-3606-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of "oneOf:" choices, use "allOf:" and "if:" to define reg, clocks,
resets, and their names that can be taken by the compatible string.

The order of their names doesn't change here.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../pci/socionext,uniphier-pcie-ep.yaml       | 76 ++++++++++++-------
 1 file changed, 49 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
index 437e61618d06..f0d8e486a07d 100644
--- a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
@@ -15,9 +15,6 @@ description: |
 maintainers:
   - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
 
-allOf:
-  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
-
 properties:
   compatible:
     enum:
@@ -29,40 +26,25 @@ properties:
     maxItems: 5
 
   reg-names:
-    oneOf:
-      - items:
-          - const: dbi
-          - const: dbi2
-          - const: link
-          - const: addr_space
-      - items:
-          - const: dbi
-          - const: dbi2
-          - const: link
-          - const: addr_space
-          - const: atu
+    minItems: 4
+    items:
+      - const: dbi
+      - const: dbi2
+      - const: link
+      - const: addr_space
+      - const: atu
 
   clocks:
     minItems: 1
     maxItems: 2
 
-  clock-names:
-    oneOf:
-      - items:              # for Pro5
-          - const: gio
-          - const: link
-      - const: link         # for NX1
+  clock-names: true
 
   resets:
     minItems: 1
     maxItems: 2
 
-  reset-names:
-    oneOf:
-      - items:              # for Pro5
-          - const: gio
-          - const: link
-      - const: link         # for NX1
+  reset-names: true
 
   num-ib-windows:
     const: 16
@@ -78,6 +60,46 @@ properties:
   phy-names:
     const: pcie-phy
 
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: socionext,uniphier-pro5-pcie-ep
+    then:
+      properties:
+        reg:
+          maxItems: 4
+        reg-names:
+          maxItems: 4
+        clocks:
+          minItems: 2
+        clock-names:
+          items:
+            - const: gio
+            - const: link
+        resets:
+          minItems: 2
+        reset-names:
+          items:
+            - const: gio
+            - const: link
+    else:
+      properties:
+        reg:
+          minItems: 5
+        reg-names:
+          minItems: 5
+        clocks:
+          maxItems: 1
+        clock-names:
+          const: link
+        resets:
+          maxItems: 1
+        reset-names:
+          const: link
+
 required:
   - compatible
   - reg
-- 
2.25.1

