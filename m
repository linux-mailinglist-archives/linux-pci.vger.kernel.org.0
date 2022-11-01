Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBFD614750
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 10:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiKAJ5k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 05:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiKAJ5i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 05:57:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682EA193D9
        for <linux-pci@vger.kernel.org>; Tue,  1 Nov 2022 02:57:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1opo1X-0001zj-NH; Tue, 01 Nov 2022 10:57:35 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1opo1X-001eHO-JE; Tue, 01 Nov 2022 10:57:34 +0100
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1opo1V-001qVr-W2; Tue, 01 Nov 2022 10:57:33 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-pci@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2] PCI: imx6: Initialize PHY before deasserting core reset
Date:   Tue,  1 Nov 2022 10:57:14 +0100
Message-Id: <20221101095714.440001-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the PHY is the reference clock provider then it must be initialized
and powered on before the reset on the client is deasserted, otherwise
the link will never come up. The order was changed in cf236e0c0d59.
Restore the correct order to make the driver work again on boards where
the PHY provides the reference clock. This also changes the order for
boards where the Soc is the PHY reference clock divider, but this
shouldn't do any harm.

Fixes: cf236e0c0d59 ("PCI: imx6: Do not hide PHY driver callbacks and refine the error handling")
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

Notes:
    Changes since v1:
    - Change subject
    - s/phy/PHY/
    - Add explanation that the order is also changed for boards where the
      SoC is the PHY reference clock provider

 drivers/pci/controller/dwc/pci-imx6.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 2616585ca5f8a..1dde5c579edc8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -952,12 +952,6 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
-	ret = imx6_pcie_deassert_core_reset(imx6_pcie);
-	if (ret < 0) {
-		dev_err(dev, "pcie deassert core reset failed: %d\n", ret);
-		goto err_phy_off;
-	}
-
 	if (imx6_pcie->phy) {
 		ret = phy_power_on(imx6_pcie->phy);
 		if (ret) {
@@ -965,6 +959,13 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_phy_off;
 		}
 	}
+
+	ret = imx6_pcie_deassert_core_reset(imx6_pcie);
+	if (ret < 0) {
+		dev_err(dev, "pcie deassert core reset failed: %d\n", ret);
+		goto err_phy_off;
+	}
+
 	imx6_setup_phy_mpll(imx6_pcie);
 
 	return 0;
-- 
2.30.2

