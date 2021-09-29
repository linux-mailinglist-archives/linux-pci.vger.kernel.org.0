Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24B441C105
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 10:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244862AbhI2IzF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 04:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244827AbhI2IzE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 04:55:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20051C06161C
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 01:53:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVVL3-0001ij-UZ; Wed, 29 Sep 2021 10:53:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVVL2-0004fm-29; Wed, 29 Sep 2021 10:53:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVVL2-0000QY-1D; Wed, 29 Sep 2021 10:53:16 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-wireless@vger.kernel.org,
        linux-pci@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v5 04/11] bcma: simplify reference to the driver's name
Date:   Wed, 29 Sep 2021 10:52:59 +0200
Message-Id: <20210929085306.2203850-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929085306.2203850-1-u.kleine-koenig@pengutronix.de>
References: <20210929085306.2203850-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=xSP+K0RSyQAwniF6A6kkbjiE0JBr+Cc60dr1a6KF2Cc=; m=9WMNRZUkbhy3cqoI0SdJ4z32UI6gOxRm4XsLfBOiMFc=; p=ynQzBWvQpvfCsznbo0TKCTlX0o4FNuUIlPzqKHsY1yI=; g=7b3a3bd10c36e651f6578f5837b227bfa43b045b
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFUKU8ACgkQwfwUeK3K7AknUQgAiQt SkGCMuUSrkXaWwv4U1KDXF6ToUdxFNFwRm+117LCkNWt7iA5uIc8i9w1xgYH47FmmrFMqN/1gw0W6 4aJVjhPyXJwyXN82mzglOrjgAmCKVaBaj49a6DsqmnaJ/N1luZDNnPxZ0Hw8La8Ebbu+DSfghkIa+ oF1nBJYICTyRfUrf1Xdobx3ltswnYY7Y//CEmcvH8PauADymFdGZ5sZi5jvdtLhjkk8+XtQ++VJZR 3QL15cjM2tRAAfTYtxVgmk2LoraoQJjSMZILP6GBjqdjcyL9f/CYpZqK56k6pn5zQ1XVWEI1yC7Gt pOSn/dq630lDFkv4S+W2UZm2XggSwCw==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When bcma_host_pci_probe() is called the pci driver core already
assigned the device's driver in local_pci_probe(). So dev->driver is
always true and here it points to bcma_pci_bridge_driver which has .name
set to "bcma-pci-bridge". Simplify accordingly.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/bcma/host_pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/bcma/host_pci.c b/drivers/bcma/host_pci.c
index 69c10a7b7c61..960632197b05 100644
--- a/drivers/bcma/host_pci.c
+++ b/drivers/bcma/host_pci.c
@@ -162,7 +162,6 @@ static int bcma_host_pci_probe(struct pci_dev *dev,
 {
 	struct bcma_bus *bus;
 	int err = -ENOMEM;
-	const char *name;
 	u32 val;
 
 	/* Alloc */
@@ -175,10 +174,7 @@ static int bcma_host_pci_probe(struct pci_dev *dev,
 	if (err)
 		goto err_kfree_bus;
 
-	name = dev_name(&dev->dev);
-	if (dev->driver && dev->driver->name)
-		name = dev->driver->name;
-	err = pci_request_regions(dev, name);
+	err = pci_request_regions(dev, "bcma-pci-bridge");
 	if (err)
 		goto err_pci_disable;
 	pci_set_master(dev);
-- 
2.30.2

