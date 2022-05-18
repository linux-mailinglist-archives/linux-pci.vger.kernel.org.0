Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ED952B732
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 12:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbiERJsG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 05:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbiERJsD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 05:48:03 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B1C10FC1;
        Wed, 18 May 2022 02:47:59 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C8AC9200D9E;
        Wed, 18 May 2022 11:47:57 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 82D08200D7D;
        Wed, 18 May 2022 11:47:57 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E6A8E180031D;
        Wed, 18 May 2022 17:47:55 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, festevam@gmail.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [RFC 1/2] PCI: imx6: Make sure the DBI register can be changed
Date:   Wed, 18 May 2022 17:35:27 +0800
Message-Id: <1652866528-13220-1-git-send-email-hongxing.zhu@nxp.com>
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

The PCIE_DBI_RO_WR_EN bit should be set when write some DBI registers.
To make sure that the DBI registers are writable, set the
PCIE_DBI_RO_WR_EN properly when touch the DBI registers.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 6619e3caffe2..30641d2dda14 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -797,10 +797,12 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 	 * started in Gen2 mode, there is a possibility the devices on the
 	 * bus will not be detected at all.  This happens with PCIe switches.
 	 */
+	dw_pcie_dbi_ro_wr_en(pci);
 	tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 	tmp &= ~PCI_EXP_LNKCAP_SLS;
 	tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
 	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
+	dw_pcie_dbi_ro_wr_dis(pci);
 
 	/* Start LTSSM. */
 	imx6_pcie_ltssm_enable(dev);
@@ -809,6 +811,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 
 	if (pci->link_gen == 2) {
 		/* Allow Gen2 mode after the link is up. */
+		dw_pcie_dbi_ro_wr_en(pci);
 		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 		tmp &= ~PCI_EXP_LNKCAP_SLS;
 		tmp |= PCI_EXP_LNKCAP_SLS_5_0GB;
@@ -821,6 +824,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 		tmp = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
 		tmp |= PORT_LOGIC_SPEED_CHANGE;
 		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
+		dw_pcie_dbi_ro_wr_dis(pci);
 
 		if (imx6_pcie->drvdata->flags &
 		    IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE) {
-- 
2.25.1

