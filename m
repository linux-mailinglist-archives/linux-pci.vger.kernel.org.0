Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1270E5A8C9C
	for <lists+linux-pci@lfdr.de>; Thu,  1 Sep 2022 06:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbiIAEaM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Sep 2022 00:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiIAE3u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2022 00:29:50 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB52A8F970;
        Wed, 31 Aug 2022 21:20:26 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 625321A4384;
        Thu,  1 Sep 2022 06:20:25 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2BD521A4387;
        Thu,  1 Sep 2022 06:20:25 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 00F711820F56;
        Thu,  1 Sep 2022 12:20:22 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     p.zabel@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, vkoul@kernel.org,
        alexander.stein@ew.tq-group.com, marex@denx.de,
        richard.leitner@linux.dev
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v6 1/7] dt-binding: phy: Add iMX8MP PCIe PHY binding
Date:   Thu,  1 Sep 2022 12:02:34 +0800
Message-Id: <1662004960-14071-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1662004960-14071-1-git-send-email-hongxing.zhu@nxp.com>
References: <1662004960-14071-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add i.MX8MP PCIe PHY binding.
On iMX8MM, the initialized default value of PERST bit(BIT3) of
SRC_PCIEPHY_RCR is 1b'1.
But i.MX8MP has one inversed default value 1b'0 of PERST bit.

And the PERST bit should be kept 1b'1 after power and clocks are stable.
So add one more PERST explicitly for i.MX8MP PCIe PHY.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Tested-by: Marek Vasut <marex@denx.de>
Tested-by: Richard Leitner <richard.leitner@skidata.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../bindings/phy/fsl,imx8-pcie-phy.yaml          | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
index b6421eedece3..692783c7fd69 100644
--- a/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     enum:
       - fsl,imx8mm-pcie-phy
+      - fsl,imx8mp-pcie-phy
 
   reg:
     maxItems: 1
@@ -28,11 +29,16 @@ properties:
       - const: ref
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   reset-names:
-    items:
-      - const: pciephy
+    oneOf:
+      - items:          # for iMX8MM
+          - const: pciephy
+      - items:          # for IMX8MP
+          - const: pciephy
+          - const: perst
 
   fsl,refclk-pad-mode:
     description: |
@@ -60,6 +66,10 @@ properties:
     description: A boolean property indicating the CLKREQ# signal is
       not supported in the board design (optional)
 
+  power-domains:
+    description: PCIe PHY  power domain (optional).
+    maxItems: 1
+
 required:
   - "#phy-cells"
   - compatible
-- 
2.25.1

