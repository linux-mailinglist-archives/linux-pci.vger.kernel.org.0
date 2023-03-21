Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1D36C3A95
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 20:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjCUTd2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 15:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjCUTd0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 15:33:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC705574CC
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 12:32:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiW-0008EI-51; Tue, 21 Mar 2023 20:32:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiV-005l6B-EU; Tue, 21 Mar 2023 20:32:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiU-006qy4-Kj; Tue, 21 Mar 2023 20:32:18 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 07/15] PCI: hisi-error: Convert to platform remove callback returning void
Date:   Tue, 21 Mar 2023 20:32:00 +0100
Message-Id: <20230321193208.366561-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
References: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1814; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=XkpnH/kbDaHO1EaJu7KN7gb9ENXxhQlNB1M/OyfX/Zs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkGgYTlwAV96pDfSpyHKEAA9SVmUZ0exsHEbtR/ 2OG8sJbT0eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBoGEwAKCRCPgPtYfRL+ TlhDCACnAcdXu5GgzGEp1wHI5qUm+Y4y8crsCtKY1B+lHUtvVXj445YtJUb6QtKyw5Exaff2ilQ 6pwKLOjkfmDQHUCmiVe41zo3ZaQkKPtymqsumR1pK6z9GDcpVfKmbRr95Zb/ZC3Bbjr4GSfGC7P s4hUw/7jMo3scnHCYdk2wJDYws3YfuGyBsE/jAD/Exadj9UqyxvJ2c9kMBehiCYi9ZxKSOpuBJT L2PCdIe64ZZZzRAuzTWG1DYrcyQjBeY7oPgZc0G/14Wblsdb4TWLj+CUYsVDqZq3mwaGP3VmUl0 R2khj6BjpMb3xXwi8de/3y8opmGu6hsKsXXm2xWhONlu/Z3r
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
 drivers/pci/controller/pcie-hisi-error.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-hisi-error.c b/drivers/pci/controller/pcie-hisi-error.c
index 7d88eb696b06..ad9d5ffcd9e3 100644
--- a/drivers/pci/controller/pcie-hisi-error.c
+++ b/drivers/pci/controller/pcie-hisi-error.c
@@ -299,13 +299,11 @@ static int hisi_pcie_error_handler_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int hisi_pcie_error_handler_remove(struct platform_device *pdev)
+static void hisi_pcie_error_handler_remove(struct platform_device *pdev)
 {
 	struct hisi_pcie_error_private *priv = platform_get_drvdata(pdev);
 
 	ghes_unregister_vendor_record_notifier(&priv->nb);
-
-	return 0;
 }
 
 static const struct acpi_device_id hisi_pcie_acpi_match[] = {
@@ -319,7 +317,7 @@ static struct platform_driver hisi_pcie_error_handler_driver = {
 		.acpi_match_table = hisi_pcie_acpi_match,
 	},
 	.probe		= hisi_pcie_error_handler_probe,
-	.remove		= hisi_pcie_error_handler_remove,
+	.remove_new	= hisi_pcie_error_handler_remove,
 };
 module_platform_driver(hisi_pcie_error_handler_driver);
 
-- 
2.39.2

