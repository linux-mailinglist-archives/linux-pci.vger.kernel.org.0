Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9934654CB5
	for <lists+linux-pci@lfdr.de>; Fri, 23 Dec 2022 08:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiLWHIc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Dec 2022 02:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLWHIb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Dec 2022 02:08:31 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2D16186F8
        for <linux-pci@vger.kernel.org>; Thu, 22 Dec 2022 23:08:29 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 23 Dec 2022 16:07:20 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id B40512059054;
        Fri, 23 Dec 2022 16:07:20 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 23 Dec 2022 16:07:20 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 7D8EA12A5;
        Fri, 23 Dec 2022 16:07:20 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v4 1/1] dt-bindings: PCI: uniphier-ep: Clean up reg, clocks, resets, and their names using compatible string
Date:   Fri, 23 Dec 2022 16:07:13 +0900
Message-Id: <20221223070713.20549-2-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221223070713.20549-1-hayashi.kunihiko@socionext.com>
References: <20221223070713.20549-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of "oneOf:" choices, use "allOf:" and "if:" to define reg, clocks,
resets, and their names that can be taken by the compatible string.

The order of their names doesn't change here.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

