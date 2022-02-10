Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7014B07C2
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 09:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbiBJIKC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 03:10:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236959AbiBJIKC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 03:10:02 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8275D275;
        Thu, 10 Feb 2022 00:10:03 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 10 Feb 2022 17:10:02 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id CBB5C205D901;
        Thu, 10 Feb 2022 17:10:02 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 10 Feb 2022 17:10:02 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 3ABCAC1E23;
        Thu, 10 Feb 2022 17:10:02 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 1/3] dt-bindings: PCI: uniphier-ep: Add bindings for NX1 SoC
Date:   Thu, 10 Feb 2022 17:09:54 +0900
Message-Id: <1644480596-20037-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644480596-20037-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1644480596-20037-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update PCI endpoint binding document for UniPhier NX1 SoC. Add a compatible
string, clock and reset lines for the SoC to the document.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/pci/socionext,uniphier-pcie-ep.yaml   | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
index 179ab0858482..437e61618d06 100644
--- a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
@@ -20,7 +20,9 @@ allOf:
 
 properties:
   compatible:
-    const: socionext,uniphier-pro5-pcie-ep
+    enum:
+      - socionext,uniphier-pro5-pcie-ep
+      - socionext,uniphier-nx1-pcie-ep
 
   reg:
     minItems: 4
@@ -41,20 +43,26 @@ properties:
           - const: atu
 
   clocks:
+    minItems: 1
     maxItems: 2
 
   clock-names:
-    items:
-      - const: gio
-      - const: link
+    oneOf:
+      - items:              # for Pro5
+          - const: gio
+          - const: link
+      - const: link         # for NX1
 
   resets:
+    minItems: 1
     maxItems: 2
 
   reset-names:
-    items:
-      - const: gio
-      - const: link
+    oneOf:
+      - items:              # for Pro5
+          - const: gio
+          - const: link
+      - const: link         # for NX1
 
   num-ib-windows:
     const: 16
-- 
2.7.4

