Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E688B574606
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 09:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbiGNHrM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 03:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237485AbiGNHrH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 03:47:07 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F24139BB2;
        Thu, 14 Jul 2022 00:47:05 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 011B4202182;
        Thu, 14 Jul 2022 09:47:04 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C589C202191;
        Thu, 14 Jul 2022 09:47:03 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1F8B8180222A;
        Thu, 14 Jul 2022 15:47:02 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v15 08/17] PCI: imx6: Disable i.MX6QDL clock when disabling ref clocks
Date:   Thu, 14 Jul 2022 15:31:00 +0800
Message-Id: <1657783869-19194-9-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657783869-19194-1-git-send-email-hongxing.zhu@nxp.com>
References: <1657783869-19194-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When disabling PCIe clocks, disable i.MX6QDL ref clock too.

Link: https://lore.kernel.org/r/1656645935-1370-9-git-send-email-hongxing.zhu@nxp.com
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/controller/dwc/pci-imx6.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 78b839e92620..eaae144db4f3 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -586,6 +586,14 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
 	case IMX6SX:
 		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
 		break;
+	case IMX6QP:
+	case IMX6Q:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_TEST_PD,
+				IMX6Q_GPR1_PCIE_TEST_PD);
+		break;
 	case IMX7D:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
-- 
2.25.1

