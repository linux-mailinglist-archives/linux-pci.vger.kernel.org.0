Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B400E57AF8A
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 05:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbiGTDlz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 23:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbiGTDly (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 23:41:54 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777BE68718;
        Tue, 19 Jul 2022 20:41:53 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 11C3F201508;
        Wed, 20 Jul 2022 05:41:52 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BC8F8201501;
        Wed, 20 Jul 2022 05:41:51 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1FEF61820F58;
        Wed, 20 Jul 2022 11:41:50 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, tharvey@gateworks.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v2] PCI: imx6: Support more than Gen2 speed link mode
Date:   Wed, 20 Jul 2022 11:26:16 +0800
Message-Id: <1658287576-26908-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Support more than Gen2 speed link mode, since i.MX8MP PCIe supports up to
Gen3 link speed.

Link: https://lore.kernel.org/r/1652866528-13220-2-git-send-email-hongxing.zhu@nxp.com
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
Changes from v1:
- The Supported Link Speeds of the PCI_EXP_LNKCAP should be re-configured too.
- When only Gen1 is enabled, refine the dev_info accordingly.

---
 drivers/pci/controller/dwc/pci-imx6.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e1ba11dabaa8..b66876f7efe0 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -844,12 +844,12 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 	if (ret)
 		goto err_reset_phy;
 
-	if (pci->link_gen == 2) {
-		/* Allow Gen2 mode after the link is up. */
+	if (pci->link_gen > 1) {
+		/* Allow faster modes after the link is up */
 		dw_pcie_dbi_ro_wr_en(pci);
 		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 		tmp &= ~PCI_EXP_LNKCAP_SLS;
-		tmp |= PCI_EXP_LNKCAP_SLS_5_0GB;
+		tmp |= pci->link_gen;
 		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
 
 		/*
@@ -884,7 +884,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 		if (ret)
 			goto err_reset_phy;
 	} else {
-		dev_info(dev, "Link: Gen2 disabled\n");
+		dev_info(dev, "Link: Only Gen1 is enabled\n");
 	}
 
 	imx6_pcie->link_is_up = true;
-- 
2.25.1

