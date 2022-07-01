Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7311F5629B6
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 05:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbiGADki (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 23:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbiGADke (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 23:40:34 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EF664D41;
        Thu, 30 Jun 2022 20:40:34 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D77C2201153;
        Fri,  1 Jul 2022 05:40:32 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A03422035BC;
        Fri,  1 Jul 2022 05:40:32 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 065611802204;
        Fri,  1 Jul 2022 11:40:30 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v14 15/17] PCI: imx6: Disable clocks in reverse order of enable
Date:   Fri,  1 Jul 2022 11:25:33 +0800
Message-Id: <1656645935-1370-16-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656645935-1370-1-git-send-email-hongxing.zhu@nxp.com>
References: <1656645935-1370-1-git-send-email-hongxing.zhu@nxp.com>
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
index 0b2a5256fb0d..79a05e190016 100644
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

