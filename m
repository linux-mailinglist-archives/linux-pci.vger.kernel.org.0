Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C0A6C3AA3
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 20:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjCUTds (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 15:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjCUTdq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 15:33:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E850509A8
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 12:32:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiW-0008E7-OW; Tue, 21 Mar 2023 20:32:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiU-005l5s-CD; Tue, 21 Mar 2023 20:32:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiT-006qxl-4T; Tue, 21 Mar 2023 20:32:17 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Joyce Ooi <joyce.ooi@intel.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 02/15] PCI: altera: Convert to platform remove callback returning void
Date:   Tue, 21 Mar 2023 20:31:55 +0100
Message-Id: <20230321193208.366561-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
References: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=KWFcOhq6EP9jwZVqUOVx5o4AR91pWM90HSYZJb7cy1E=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkGgYN4m/40BX2rqBamUoN/vTLW1fwaCxZfsMZi Vgm2xs03x+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBoGDQAKCRCPgPtYfRL+ TjEXB/wO4EYF+qPPztdwUQhQjm9/hbTs8an7EHNTO8htRa8bF6ZzyJQbOGxmb7YfFlkp8rKFInZ jIEuMzngaP7Dc21p+3L9DLBAVd369zOeUkiXnSaST5dMf0FHfqSh+zFC0qfdhylG4T/HfYir4kx L9rbxBUa7pHlSrmXlEnXuU7/DRpXyC8rkXdwgMrDVkF5sWoYhcEvZr9g/V+Q56QhWhEF1Ibtlbr FwbjGEVz9upq6niwRDwgbNAcomiH345NYQoVqM8MmRETTRyU8MmXThfD87hCl8IoL/2pUhWefgR DtriSWcEHPmz+K9yZw+83IquiWSQ1XCNtFOQ3uO6SAvHNNCo
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
 drivers/pci/controller/pcie-altera.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 18b2361d6462..c95a29fff8bf 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -806,7 +806,7 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	return pci_host_probe(bridge);
 }
 
-static int altera_pcie_remove(struct platform_device *pdev)
+static void altera_pcie_remove(struct platform_device *pdev)
 {
 	struct altera_pcie *pcie = platform_get_drvdata(pdev);
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
@@ -814,13 +814,11 @@ static int altera_pcie_remove(struct platform_device *pdev)
 	pci_stop_root_bus(bridge->bus);
 	pci_remove_root_bus(bridge->bus);
 	altera_pcie_irq_teardown(pcie);
-
-	return 0;
 }
 
 static struct platform_driver altera_pcie_driver = {
 	.probe		= altera_pcie_probe,
-	.remove		= altera_pcie_remove,
+	.remove_new	= altera_pcie_remove,
 	.driver = {
 		.name	= "altera-pcie",
 		.of_match_table = altera_pcie_of_match,
-- 
2.39.2

