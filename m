Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9220B4C2247
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 04:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiBXDPt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 22:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBXDPs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 22:15:48 -0500
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1D4194AA2;
        Wed, 23 Feb 2022 19:15:19 -0800 (PST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 63240200EF7;
        Thu, 24 Feb 2022 04:15:18 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2B058200EE9;
        Thu, 24 Feb 2022 04:15:18 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BD42E183AC97;
        Thu, 24 Feb 2022 11:15:16 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2] PCI: imx6: Assert i.MX8MM CLKREQ# even if no device present
Date:   Thu, 24 Feb 2022 11:06:53 +0800
Message-Id: <1645672013-8949-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The CLKREQ# signal is an open drain, active low signal that is driven
low by the remote Endpoint device. But it might not be driven low if no
Endpoint device is connected.

On i.MX8MM PCIe, phy_init() may fail and system boot may hang if no
Endpoint is connected to assert CLKREQ#.

Handle this as on i.MX8MQ, where we explicitly assert CLKREQ# so the
PHY can be initialized.

Fixes: 178e244cb6e2 ("PCI: imx: Add the imx8mm pcie support")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 78e32a539060..168cb1287ba9 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -447,10 +447,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	case IMX7D:
 		break;
 	case IMX8MM:
-		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
-		if (ret)
-			dev_err(dev, "unable to enable pcie_aux clock\n");
-		break;
 	case IMX8MQ:
 		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
 		if (ret) {
-- 
2.25.1

