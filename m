Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC0F5482B7
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 11:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240500AbiFMJJg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 05:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240145AbiFMJJd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 05:09:33 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E96EE01;
        Mon, 13 Jun 2022 02:09:33 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E893B201D9B;
        Mon, 13 Jun 2022 11:09:31 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9F978201D6D;
        Mon, 13 Jun 2022 11:09:31 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id CCEC61802205;
        Mon, 13 Jun 2022 17:09:29 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v10 6/7] PCI: imx6: Mark the link down as none fatal error
Date:   Mon, 13 Jun 2022 16:55:37 +0800
Message-Id: <1655110538-10914-7-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655110538-10914-1-git-send-email-hongxing.zhu@nxp.com>
References: <1655110538-10914-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

let the driver probe successfully, return zero in imx6_pcie_start_link()
when PCIe link is down.

Because i.MX PCIe doesn't support hot-plug feature.
In this link down scenario, only start the PCIe link training in resume
when the link is up before system suspend to avoid the long latency in
the link training period.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c02748393aac..ac6ec2d691a0 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -67,6 +67,7 @@ struct imx6_pcie {
 	struct dw_pcie		*pci;
 	int			reset_gpio;
 	bool			gpio_active_high;
+	bool			link_is_up;
 	struct clk		*pcie_bus;
 	struct clk		*pcie_phy;
 	struct clk		*pcie_inbound_axi;
@@ -845,7 +846,9 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 	/* Start LTSSM. */
 	imx6_pcie_ltssm_enable(dev);
 
-	dw_pcie_wait_for_link(pci);
+	ret = dw_pcie_wait_for_link(pci);
+	if (ret)
+		goto err_reset_phy;
 
 	if (pci->link_gen == 2) {
 		/* Allow Gen2 mode after the link is up. */
@@ -881,11 +884,14 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 		}
 
 		/* Make sure link training is finished as well! */
-		dw_pcie_wait_for_link(pci);
+		ret = dw_pcie_wait_for_link(pci);
+		if (ret)
+			goto err_reset_phy;
 	} else {
 		dev_info(dev, "Link: Gen2 disabled\n");
 	}
 
+	imx6_pcie->link_is_up = true;
 	tmp = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
 	dev_info(dev, "Link up, Gen%i\n", tmp & PCI_EXP_LNKSTA_CLS);
 	return 0;
@@ -895,7 +901,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
 	imx6_pcie_reset_phy(imx6_pcie);
-	return ret;
+	return 0;
 }
 
 static int imx6_pcie_host_init(struct pcie_port *pp)
@@ -1022,10 +1028,8 @@ static int imx6_pcie_resume_noirq(struct device *dev)
 	imx6_pcie_init_phy(imx6_pcie);
 	imx6_pcie_deassert_core_reset(imx6_pcie);
 	dw_pcie_setup_rc(pp);
-
-	ret = imx6_pcie_start_link(imx6_pcie->pci);
-	if (ret < 0)
-		dev_info(dev, "pcie link is down after resume.\n");
+	if (imx6_pcie->link_is_up)
+		imx6_pcie_start_link(imx6_pcie->pci);
 
 	return 0;
 }
-- 
2.25.1

