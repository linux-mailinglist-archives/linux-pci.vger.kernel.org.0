Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EEA5B6850
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 09:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiIMHB5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 03:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiIMHB4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 03:01:56 -0400
X-Greylist: delayed 183 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Sep 2022 00:01:55 PDT
Received: from cmccmta3.chinamobile.com (cmccmta3.chinamobile.com [221.176.66.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1BA714D10
        for <linux-pci@vger.kernel.org>; Tue, 13 Sep 2022 00:01:55 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11])
        by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee963202a2ad70-36aec;
        Tue, 13 Sep 2022 14:58:50 +0800 (CST)
X-RM-TRANSID: 2ee963202a2ad70-36aec
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.108.79.98])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee663202a27ec8-50ddd;
        Tue, 13 Sep 2022 14:58:50 +0800 (CST)
X-RM-TRANSID: 2ee663202a27ec8-50ddd
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        shawnguo@kernel.org, bhelgaas@google.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] PCI: imx6: Fix wrong check in imx6_pcie_attach_pd()
Date:   Tue, 13 Sep 2022 14:59:10 +0800
Message-Id: <20220913065910.15348-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the function imx6_pcie_attach_pd(),
dev_pm_domain_attach_by_name() may return NULL in some cases,
so IS_ERR() doesn't meet the requirements. Thus fix it.

Fixes: 3f7cceeab895 ("PCI: imx: Add multi-pd support")
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 6619e3caf..65d6ebbba 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -337,8 +337,8 @@ static int imx6_pcie_attach_pd(struct device *dev)
 		return 0;
 
 	imx6_pcie->pd_pcie = dev_pm_domain_attach_by_name(dev, "pcie");
-	if (IS_ERR(imx6_pcie->pd_pcie))
-		return PTR_ERR(imx6_pcie->pd_pcie);
+	if (IS_ERR_OR_NULL(imx6_pcie->pd_pcie))
+		return PTR_ERR(imx6_pcie->pd_pcie) ? : -ENODATA;
 	/* Do nothing when power domain missing */
 	if (!imx6_pcie->pd_pcie)
 		return 0;
@@ -352,8 +352,8 @@ static int imx6_pcie_attach_pd(struct device *dev)
 	}
 
 	imx6_pcie->pd_pcie_phy = dev_pm_domain_attach_by_name(dev, "pcie_phy");
-	if (IS_ERR(imx6_pcie->pd_pcie_phy))
-		return PTR_ERR(imx6_pcie->pd_pcie_phy);
+	if (IS_ERR_OR_NULL(imx6_pcie->pd_pcie_phy))
+		return PTR_ERR(imx6_pcie->pd_pcie_phy) ? : -ENODATA;
 
 	link = device_link_add(dev, imx6_pcie->pd_pcie_phy,
 			DL_FLAG_STATELESS |
-- 
2.20.1.windows.1



