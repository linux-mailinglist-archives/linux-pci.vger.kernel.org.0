Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14506650817
	for <lists+linux-pci@lfdr.de>; Mon, 19 Dec 2022 08:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiLSHfd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Dec 2022 02:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiLSHfb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2022 02:35:31 -0500
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EA926F2;
        Sun, 18 Dec 2022 23:35:31 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A5B4C1A1612;
        Mon, 19 Dec 2022 08:35:29 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6A10C1A05C8;
        Mon, 19 Dec 2022 08:35:29 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D61911820F59;
        Mon, 19 Dec 2022 15:35:27 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     vkoul@kernel.org, marex@denx.de, alexander.stein@ew.tq-group.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH] phy: freescale: imx8m-pcie: Add one missing error return
Date:   Mon, 19 Dec 2022 15:12:21 +0800
Message-Id: <1671433941-2037-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There should be one error return when fail to fetch the perst reset.
Add the missing error return.

Fixes: dce9edff16ee ("phy: freescale: imx8m-pcie: Add i.MX8MP PCIe PHY support")

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index 7585e8080b77..afc63552ecaf 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -255,7 +255,7 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
 		imx8_phy->perst =
 			devm_reset_control_get_exclusive(dev, "perst");
 		if (IS_ERR(imx8_phy->perst))
-			dev_err_probe(dev, PTR_ERR(imx8_phy->perst),
+			return dev_err_probe(dev, PTR_ERR(imx8_phy->perst),
 				      "Failed to get PCIE PHY PERST control\n");
 	}
 
-- 
2.25.1

