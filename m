Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63DC6C3A9C
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 20:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjCUTdj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 15:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCUTdi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 15:33:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19ED570BB
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 12:32:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiX-0008Gf-LH; Tue, 21 Mar 2023 20:32:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiW-005l6b-V4; Tue, 21 Mar 2023 20:32:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiW-006qyP-6n; Tue, 21 Mar 2023 20:32:20 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 12/15] PCI: mvebu: Convert to platform remove callback returning void
Date:   Tue, 21 Mar 2023 20:32:05 +0100
Message-Id: <20230321193208.366561-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
References: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1875; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=s0X5jS6+nTnWbE2Dk9p3FoHJJcKJGi4IsaWIYZ59Q1g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkGgYY6yf23C8VzXDT/4rOJJFfQ6NkyWENC99WL /tsrXR9FOaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBoGGAAKCRCPgPtYfRL+ TnCLCACqYRUTp6nMdhZfhXPXumhOHfgBi/T7IOe0kAJ0yRsfWnUCNqR+sR5BLawbQzU3dKrvPhX PFjgfU6JMkJNVZ1yMgmFVT5ZbDOoIPnV56t1Yk+eK6wIYTAQS+S3Ycet+5MLK+KpJrvCmrVCDUj YkGO06e+rYkdTFotAO4CieIhPpHadGyjxSr6HPz5DjESWd/C12Nb5C7ewKfFmHYWa9B29YOCdc8 dC/fysqaP0IXdVa/p6DrFwg+ce2jjw1sk1a3vab8WxsgDOENHoXaD+3kHyfY9KeT6VC6eUPW3vA lOZ4WOHPpMQDScM5QMSGSVVGEbXVqniHmHNXlTeKFELQhWsv
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pci/controller/pci-mvebu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 1dc209f6f53a..c931b1b07b1d 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1649,7 +1649,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	return pci_host_probe(bridge);
 }
 
-static int mvebu_pcie_remove(struct platform_device *pdev)
+static void mvebu_pcie_remove(struct platform_device *pdev)
 {
 	struct mvebu_pcie *pcie = platform_get_drvdata(pdev);
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
@@ -1707,8 +1707,6 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
 		/* Power down card and disable clocks. Must be the last step. */
 		mvebu_pcie_powerdown(port);
 	}
-
-	return 0;
 }
 
 static const struct of_device_id mvebu_pcie_of_match_table[] = {
@@ -1730,7 +1728,7 @@ static struct platform_driver mvebu_pcie_driver = {
 		.pm = &mvebu_pcie_pm_ops,
 	},
 	.probe = mvebu_pcie_probe,
-	.remove = mvebu_pcie_remove,
+	.remove_new = mvebu_pcie_remove,
 };
 module_platform_driver(mvebu_pcie_driver);
 
-- 
2.39.2

