Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBD36C3A9F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 20:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCUTdp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 15:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCUTdl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 15:33:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A584F5708C
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 12:32:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiX-0008Eh-Q0; Tue, 21 Mar 2023 20:32:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiV-005l6I-VP; Tue, 21 Mar 2023 20:32:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiV-006qyG-Bc; Tue, 21 Mar 2023 20:32:19 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/15] PCI: mediatek-gen3: Convert to platform remove callback returning void
Date:   Tue, 21 Mar 2023 20:32:03 +0100
Message-Id: <20230321193208.366561-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
References: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1877; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=dm2KOnBfcDXLhSk/3xfJfQ1wwRbtFrvgg8+uKO1zBcs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkGgYWaKJghlqrsHyZT29xkKwu5zIx0+OO7x5E4 Jnn5kss8P2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBoGFgAKCRCPgPtYfRL+ TsNqB/987bxfqmj7a9c2abs3SkeXq+XtDfRUVuHxPvwMkSuSd/L5R8raZ5Qwd25L6AVnXn1cdqT 9L/QmSLfi7wK/eVuJxJFNVhCHSEyD7dYVJCAdGm8QYpo3tT9LSm5tJ5mAPRqvxadkoK90gZMdwl z1Bq7byTiMSc98ZluH7ldc9JonWrZMZUTN7+fGGNN1GmoxYVNQA4QTs8WuiKPKybnYpFf+njpVf Ixzogqb6bouEnMo0Gy6bRWXD037BvLtzIOffHXfPuJgzuM5UZgME8a57yIWZWJWv77o2MxmyfqU doKcPSh7m05FaFjPwGCzyP0MGNlIspbVvHx/NfgYAcmPMOIU
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
 drivers/pci/controller/pcie-mediatek-gen3.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index b8612ce5f4d0..e0e27645fdf4 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -943,7 +943,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mtk_pcie_remove(struct platform_device *pdev)
+static void mtk_pcie_remove(struct platform_device *pdev)
 {
 	struct mtk_gen3_pcie *pcie = platform_get_drvdata(pdev);
 	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
@@ -955,8 +955,6 @@ static int mtk_pcie_remove(struct platform_device *pdev)
 
 	mtk_pcie_irq_teardown(pcie);
 	mtk_pcie_power_down(pcie);
-
-	return 0;
 }
 
 static void mtk_pcie_irq_save(struct mtk_gen3_pcie *pcie)
@@ -1069,7 +1067,7 @@ MODULE_DEVICE_TABLE(of, mtk_pcie_of_match);
 
 static struct platform_driver mtk_pcie_driver = {
 	.probe = mtk_pcie_probe,
-	.remove = mtk_pcie_remove,
+	.remove_new = mtk_pcie_remove,
 	.driver = {
 		.name = "mtk-pcie-gen3",
 		.of_match_table = mtk_pcie_of_match,
-- 
2.39.2

