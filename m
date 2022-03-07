Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02504CF1C3
	for <lists+linux-pci@lfdr.de>; Mon,  7 Mar 2022 07:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbiCGGYd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Mar 2022 01:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiCGGYd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2022 01:24:33 -0500
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C76B33368;
        Sun,  6 Mar 2022 22:23:36 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B2FE81A057E;
        Mon,  7 Mar 2022 07:23:34 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 699221A0612;
        Mon,  7 Mar 2022 07:23:34 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0F13E183AC96;
        Mon,  7 Mar 2022 14:23:32 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     p.zabel@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [RFC 2/7] dt-binding: phy: Add iMX8MP PCIe PHY binding
Date:   Mon,  7 Mar 2022 14:14:31 +0800
Message-Id: <1646633676-23535-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646633676-23535-1-git-send-email-hongxing.zhu@nxp.com>
References: <1646633676-23535-1-git-send-email-hongxing.zhu@nxp.com>
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

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
index b6421eedece3..3646b3ed4375 100644
--- a/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     enum:
       - fsl,imx8mm-pcie-phy
+      - fsl,imx8mp-pcie-phy
 
   reg:
     maxItems: 1
@@ -28,11 +29,12 @@ properties:
       - const: ref
 
   resets:
-    maxItems: 1
+    maxItems: 2
 
   reset-names:
     items:
       - const: pciephy
+      - const: perst
 
   fsl,refclk-pad-mode:
     description: |
-- 
2.25.1

