Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEBB54F5E2
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 12:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382093AbiFQKpq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 06:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382151AbiFQKpk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 06:45:40 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15786B7EE;
        Fri, 17 Jun 2022 03:45:32 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7E82F1A0052;
        Fri, 17 Jun 2022 12:45:31 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 466491A00AC;
        Fri, 17 Jun 2022 12:45:31 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9EB3B180219B;
        Fri, 17 Jun 2022 18:45:29 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v13 15/15] PCI: imx6: Disable clocks in reverse order of enable
Date:   Fri, 17 Jun 2022 18:31:14 +0800
Message-Id: <1655461874-16908-16-git-send-email-hongxing.zhu@nxp.com>
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

From: Bjorn Helgaas <bhelgaas@google.com>

imx6_pcie_clk_enable() enables clocks in the order:

  pcie_phy
  pcie_bus
  pcie
  imx6_pcie_enable_ref_clk

Change imx6_pcie_clk_disable() to disable them in the reverse order.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 363bfc4742cf..94ce77b674a3 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -655,10 +655,10 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 {
+	imx6_pcie_disable_ref_clk(imx6_pcie);
 	clk_disable_unprepare(imx6_pcie->pcie);
-	clk_disable_unprepare(imx6_pcie->pcie_phy);
 	clk_disable_unprepare(imx6_pcie->pcie_bus);
-	imx6_pcie_disable_ref_clk(imx6_pcie);
+	clk_disable_unprepare(imx6_pcie->pcie_phy);
 }
 
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
-- 
2.25.1

