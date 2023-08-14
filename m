Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC50F77B15A
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 08:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjHNGSX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 02:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbjHNGRv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 02:17:51 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB9610E5;
        Sun, 13 Aug 2023 23:17:43 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0160E1A1C0E;
        Mon, 14 Aug 2023 08:17:42 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C53B21A0567;
        Mon, 14 Aug 2023 08:17:41 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2C1251802200;
        Mon, 14 Aug 2023 14:17:40 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     frank.li@nxp.com, l.stach@pengutronix.de, shawnguo@kernel.org,
        lpieralisi@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v4 1/9] dt-bindings: PCI: fsl,imx6q: Add i.MX6Q and i.MX6QP PCIe EP compatibles
Date:   Mon, 14 Aug 2023 13:42:39 +0800
Message-Id: <1691991767-15809-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1691991767-15809-1-git-send-email-hongxing.zhu@nxp.com>
References: <1691991767-15809-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add i.MX6Q and i.MX6QP PCIe EP compatibles.
- Make the interrupts property optional, since i.MX6Q/i.MX6QP PCIe
  don't have DMA capability.
- To pass the schema check, specify the clocks property refer to the
  different platforms.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pci/fsl,imx6q-pcie-ep.yaml       | 31 ++++++++++++++++---
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index ee155ed5f181..9b881777c801 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -19,6 +19,8 @@ description: |+
 properties:
   compatible:
     enum:
+      - fsl,imx6q-pcie-ep
+      - fsl,imx6qp-pcie-ep
       - fsl,imx8mm-pcie-ep
       - fsl,imx8mq-pcie-ep
       - fsl,imx8mp-pcie-ep
@@ -46,7 +48,7 @@ properties:
 
   interrupts:
     items:
-      - description: builtin eDMA interrupter.
+      - description: builtin eDMA interrupter (optional).
 
   interrupt-names:
     items:
@@ -56,8 +58,6 @@ required:
   - compatible
   - reg
   - reg-names
-  - interrupts
-  - interrupt-names
 
 allOf:
   - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
@@ -77,7 +77,30 @@ allOf:
             - const: pcie_bus
             - const: pcie_phy
             - const: pcie_aux
-    else:
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx6q-pcie-ep
+            - fsl,imx6qp-pcie-ep
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: pcie
+            - const: pcie_bus
+            - const: pcie_phy
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8mm-pcie-ep
+            - fsl,imx8mp-pcie-ep
+    then:
       properties:
         clocks:
           maxItems: 3
-- 
2.34.1

