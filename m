Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E720752B6E0
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 12:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbiERJsG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 05:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiERJsF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 05:48:05 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300C920BD7;
        Wed, 18 May 2022 02:48:00 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C348A1A0D8B;
        Wed, 18 May 2022 11:47:58 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7D2DA1A0D87;
        Wed, 18 May 2022 11:47:58 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D76A5180031E;
        Wed, 18 May 2022 17:47:56 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, festevam@gmail.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [RFC 2/2] PCI: imx6: Support more than Gen2 speed link mode
Date:   Wed, 18 May 2022 17:35:28 +0800
Message-Id: <1652866528-13220-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652866528-13220-1-git-send-email-hongxing.zhu@nxp.com>
References: <1652866528-13220-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Support more than Gen2 speed link mode, since i.MX8MP PCIe supports up
to Gen3 link speed.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 30641d2dda14..37012f9a33a0 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -809,8 +809,8 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 
 	dw_pcie_wait_for_link(pci);
 
-	if (pci->link_gen == 2) {
-		/* Allow Gen2 mode after the link is up. */
+	if (pci->link_gen > 1) {
+		/* Allow faster modes after the link is up. */
 		dw_pcie_dbi_ro_wr_en(pci);
 		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 		tmp &= ~PCI_EXP_LNKCAP_SLS;
-- 
2.25.1

