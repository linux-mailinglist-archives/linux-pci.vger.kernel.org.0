Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B0954F5D5
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 12:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382165AbiFQKpm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 06:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382105AbiFQKpf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 06:45:35 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2486B67E;
        Fri, 17 Jun 2022 03:45:26 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A83BD1A00BC;
        Fri, 17 Jun 2022 12:45:24 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 707F31A00AF;
        Fri, 17 Jun 2022 12:45:24 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E62D11802183;
        Fri, 17 Jun 2022 18:45:21 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v13 09/15] PCI: imx6: Call host init function directly in resume
Date:   Fri, 17 Jun 2022 18:31:08 +0800
Message-Id: <1655461874-16908-10-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655461874-16908-1-git-send-email-hongxing.zhu@nxp.com>
References: <1655461874-16908-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Call imx6_pcie_host_init() instead of duplicating codes in resume.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index eaae144db4f3..2b42c37f1617 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1034,9 +1034,9 @@ static int imx6_pcie_resume_noirq(struct device *dev)
 	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
-	imx6_pcie_assert_core_reset(imx6_pcie);
-	imx6_pcie_init_phy(imx6_pcie);
-	imx6_pcie_deassert_core_reset(imx6_pcie);
+	ret = imx6_pcie_host_init(pp);
+	if (ret)
+		return ret;
 	dw_pcie_setup_rc(pp);
 
 	ret = imx6_pcie_start_link(imx6_pcie->pci);
-- 
2.25.1

