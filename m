Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBC45FD322
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 04:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiJMCG4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Oct 2022 22:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJMCGz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Oct 2022 22:06:55 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B932122BED;
        Wed, 12 Oct 2022 19:06:53 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 270D12229FB;
        Thu, 13 Oct 2022 04:06:52 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EB8DD21103D;
        Thu, 13 Oct 2022 04:06:51 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E68C91802205;
        Thu, 13 Oct 2022 10:06:49 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     vkoul@kernel.org, a.fatoum@pengutronix.de, p.zabel@pengutronix.de,
        l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, shawnguo@kernel.org,
        alexander.stein@ew.tq-group.com, marex@denx.de,
        richard.leitner@linux.dev
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [RESEND v12 1/4] dt-binding: phy: Add i.MX8MP PCIe PHY binding
Date:   Thu, 13 Oct 2022 09:46:59 +0800
Message-Id: <1665625622-20551-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1665625622-20551-1-git-send-email-hongxing.zhu@nxp.com>
References: <1665625622-20551-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add i.MX8MP PCIe PHY binding.
On i.MX8MM, the initialized default value of PERST bit(BIT3) of
SRC_PCIEPHY_RCR is 1b'1.
But i.MX8MP has one inversed default value 1b'0 of PERST bit.

And the PERST bit should be kept 1b'1 after power and clocks are stable.
So add one more PERST explicitly for i.MX8MP PCIe PHY.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Tested-by: Marek Vasut <marex@denx.de>
Tested-by: Richard Leitner <richard.leitner@skidata.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Rob Herring <robh@kernel.org>
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

