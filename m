Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4F04C0E71
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 09:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238410AbiBWIrZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 03:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbiBWIrY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 03:47:24 -0500
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34159340F7;
        Wed, 23 Feb 2022 00:46:57 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B92941A0CF0;
        Wed, 23 Feb 2022 09:46:55 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8A2951A0CDA;
        Wed, 23 Feb 2022 09:46:55 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1487E183AC96;
        Wed, 23 Feb 2022 16:46:54 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH] PCI: imx6: Override the CLKREQ low in the initialization
Date:   Wed, 23 Feb 2022 16:38:33 +0800
Message-Id: <1645605513-7731-1-git-send-email-hongxing.zhu@nxp.com>
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

On i.MX8MM PCIe, phy_init() would be failed and system boot hang if the
reference clock is not toggled.

Follow with i.MX8MQ PCIe, to make sure the reference clock on, override
the CLKREQ# low during initialization to fix this issue.

Fixes: 178e244cb6e2 ("PCI: imx: Add the imx8mm pcie support")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index d7f0db01f3c3..a334341a1789 100644
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

