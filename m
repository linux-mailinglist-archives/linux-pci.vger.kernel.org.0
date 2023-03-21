Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A754B6C3A9D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 20:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjCUTdn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 15:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjCUTdl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 15:33:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13CD57084
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 12:32:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiW-0008E5-OP; Tue, 21 Mar 2023 20:32:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiU-005l5r-Au; Tue, 21 Mar 2023 20:32:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiT-006qxo-Fo; Tue, 21 Mar 2023 20:32:17 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Joyce Ooi <joyce.ooi@intel.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 03/15] PCI: altera-msi: Convert to platform remove callback returning void
Date:   Tue, 21 Mar 2023 20:31:56 +0100
Message-Id: <20230321193208.366561-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
References: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1799; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bsOnGmVhY5onmjq3HHwcyzHaLGTFso8LPsM4lOrN+Cw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkGgYOparFpdSYG7UkOoJbSr0sBRFH1MDTwTcss 9K7fbl+aHaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBoGDgAKCRCPgPtYfRL+ Tn32CACQNQhWCkDDdv9vWIwttPnRC9v/JCMb8IEl6TrF+Mworrt2Dr3e1KObO4rVy9E3AaAeazr UUy/Xkp/1//dFbtScAAgqVDoVfD1ffPknFCC0KMOkQ4h2BSk9yyOMrhr0b84hiyzMQXUA12fS0L vqMUjtKP6H/l9wdb3zllLDoPBhhm6d/mC6JdUx/96oV2j1XaIOhyH5VbUoW9/XTvlhabrJb9EOU 66ehuR7Ah3suANS2pO3BhM1mQXlbYErZycrcu5pUhDV0m1V4exh+6e5fNq7w2lR4eJd5VyFZ7H3 +L872blJ6dfX6Tcl8azxi8RV8CpB35Qy0HaG3B60vwGX7omu
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
 drivers/pci/controller/pcie-altera-msi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
index 65e8a20cc442..6ad5427490b5 100644
--- a/drivers/pci/controller/pcie-altera-msi.c
+++ b/drivers/pci/controller/pcie-altera-msi.c
@@ -197,7 +197,7 @@ static void altera_free_domains(struct altera_msi *msi)
 	irq_domain_remove(msi->inner_domain);
 }
 
-static int altera_msi_remove(struct platform_device *pdev)
+static void altera_msi_remove(struct platform_device *pdev)
 {
 	struct altera_msi *msi = platform_get_drvdata(pdev);
 
@@ -207,7 +207,6 @@ static int altera_msi_remove(struct platform_device *pdev)
 	altera_free_domains(msi);
 
 	platform_set_drvdata(pdev, NULL);
-	return 0;
 }
 
 static int altera_msi_probe(struct platform_device *pdev)
@@ -275,7 +274,7 @@ static struct platform_driver altera_msi_driver = {
 		.of_match_table = altera_msi_of_match,
 	},
 	.probe = altera_msi_probe,
-	.remove = altera_msi_remove,
+	.remove_new = altera_msi_remove,
 };
 
 static int __init altera_msi_init(void)
-- 
2.39.2

