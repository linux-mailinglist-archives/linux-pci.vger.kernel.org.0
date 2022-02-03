Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0630B4A7DF7
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 03:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiBCCgy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 21:36:54 -0500
Received: from mx.socionext.com ([202.248.49.38]:23386 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348594AbiBCCgy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Feb 2022 21:36:54 -0500
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 03 Feb 2022 11:36:53 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id C8C5E2077461;
        Thu,  3 Feb 2022 11:36:53 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 3 Feb 2022 11:36:53 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 5F3D9C1E22;
        Thu,  3 Feb 2022 11:36:53 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/3] dt-bindings: PCI: uniphier-ep: Add bindings for NX1 SoC
Date:   Thu,  3 Feb 2022 11:36:24 +0900
Message-Id: <1643855786-23186-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643855786-23186-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1643855786-23186-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update PCI endpoint binding document for UniPhier NX1 SoC. Add a compatible
string, clock and reset lines for the SoC to the document.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/pci/socionext,uniphier-pcie-ep.yaml   | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
index 179ab0858482..639bbeb8fa9d 100644
--- a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
@@ -20,7 +20,9 @@ allOf:
 
 properties:
   compatible:
-    const: socionext,uniphier-pro5-pcie-ep
+    enum:
+      -  socionext,uniphier-pro5-pcie-ep
+      -  socionext,uniphier-nx1-pcie-ep
 
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

