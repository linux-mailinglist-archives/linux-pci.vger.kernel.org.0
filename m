Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244004F7185
	for <lists+linux-pci@lfdr.de>; Thu,  7 Apr 2022 03:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiDGBdp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Apr 2022 21:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240706AbiDGBaP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2022 21:30:15 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6699D1AE181;
        Wed,  6 Apr 2022 18:22:50 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 07 Apr 2022 10:22:49 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 413B42058443;
        Thu,  7 Apr 2022 10:22:49 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 7 Apr 2022 10:22:49 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 87A23B62B7;
        Thu,  7 Apr 2022 10:22:48 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 2/3] dt-bindings: PCI: uniphier-ep: Clean up reg, clocks, resets, and their names using compatible string
Date:   Thu,  7 Apr 2022 10:22:32 +0900
Message-Id: <1649294553-17310-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649294553-17310-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1649294553-17310-1-git-send-email-hayashi.kunihiko@socionext.com>
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
 .../pci/socionext,uniphier-pcie-ep.yaml       | 84 ++++++++++++-------
 1 file changed, 56 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
index 437e61618d06..49a5b2ca266c 100644
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
@@ -28,41 +25,19 @@ properties:
     minItems: 4
     maxItems: 5
 
-  reg-names:
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
+  reg-names: true
 
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
@@ -78,6 +53,59 @@ properties:
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
+          minItems: 4
+          maxItems: 4
+        reg-names:
+          items:
+            - const: dbi
+            - const: dbi2
+            - const: link
+            - const: addr_space
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: gio
+            - const: link
+        resets:
+          minItems: 2
+          maxItems: 2
+        reset-names:
+          items:
+            - const: gio
+            - const: link
+    else:
+      properties:
+        reg:
+          minItems: 4
+          maxItems: 5
+        reg-names:
+          items:
+            - const: dbi
+            - const: dbi2
+            - const: link
+            - const: addr_space
+            - const: atu
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

