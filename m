Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642596C3A9B
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 20:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCUTdg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 15:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjCUTde (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 15:33:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAB5567BD
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 12:32:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiZ-0008JI-8m; Tue, 21 Mar 2023 20:32:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiY-005l6r-HO; Tue, 21 Mar 2023 20:32:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiW-006qya-WD; Tue, 21 Mar 2023 20:32:21 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 15/15] PCI: xgene-msi: Convert to platform remove callback returning void
Date:   Tue, 21 Mar 2023 20:32:08 +0100
Message-Id: <20230321193208.366561-16-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
References: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1764; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=g4mawOD/hBAIs+EkcP3CuSa/TPVhhAT1rILcKdZNAkA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkGgYcWPE7Y/ad4xZdZSWD/ZWyuqJ5nsaeZwjS+ N3udKv7GH2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBoGHAAKCRCPgPtYfRL+ TnbIB/wNJy4Gp6R+qf4fCOZwbT+ibDo1HK35x46t90OiBBVxs0xPFsvTfQpgvhITYlEFwd9z3a2 huu5z5R4GkLuGXBVgUds2KrFNAnUAXj2UbLxGmCfsVwxT2hbRpJlM2H1kVDYfk09uu9D6C/bTSD +rrnqLnqW2quPlXQ0iv/kVRrlquHIeFJYXzmr660UODMYf3nNMFcLhP9WgF2S+YwHvuA7+lzpS3 mKbWSK5SoMgJWjXjXdykc4PeO9y5Voh7cBK+Rk6qwqd4WInaFPG0pJqAOwAbK8rvT6ibpckUUMI /m/Tt65Rr6g8h7mxdoUrw3luStocaElGrUnEVZ9woZqPLElJ
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
 drivers/pci/controller/pci-xgene-msi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index d7987b281f79..0234e528b9a5 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -348,7 +348,7 @@ static void xgene_msi_isr(struct irq_desc *desc)
 
 static enum cpuhp_state pci_xgene_online;
 
-static int xgene_msi_remove(struct platform_device *pdev)
+static void xgene_msi_remove(struct platform_device *pdev)
 {
 	struct xgene_msi *msi = platform_get_drvdata(pdev);
 
@@ -362,8 +362,6 @@ static int xgene_msi_remove(struct platform_device *pdev)
 	msi->bitmap = NULL;
 
 	xgene_free_domains(msi);
-
-	return 0;
 }
 
 static int xgene_msi_hwirq_alloc(unsigned int cpu)
@@ -521,7 +519,7 @@ static struct platform_driver xgene_msi_driver = {
 		.of_match_table = xgene_msi_match_table,
 	},
 	.probe = xgene_msi_probe,
-	.remove = xgene_msi_remove,
+	.remove_new = xgene_msi_remove,
 };
 
 static int __init xgene_pcie_msi_init(void)
-- 
2.39.2

