Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464BB41A05A
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 22:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbhI0Upd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 16:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236582AbhI0Upc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Sep 2021 16:45:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29BCC061575
        for <linux-pci@vger.kernel.org>; Mon, 27 Sep 2021 13:43:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mUxTa-0001jm-U1; Mon, 27 Sep 2021 22:43:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mUxTY-0001YN-07; Mon, 27 Sep 2021 22:43:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mUxTX-0001Ll-VS; Mon, 27 Sep 2021 22:43:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 1/8] PCI: Simplify pci_device_remove()
Date:   Mon, 27 Sep 2021 22:43:19 +0200
Message-Id: <20210927204326.612555-2-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210927204326.612555-1-uwe@kleine-koenig.org>
References: <20210927204326.612555-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=hj/Mv0oBl1Lf1uSz5IdbQVlj1aJs3W94rdH7QDuEpg8=; m=3MjO1JqLy12b20qOWv/Fp9tjcaX0qdsgbDBjSqzg3lQ=; p=u/IlHXlFxyd9VYnelQTUuUgSTqRFKk2si+oT8j90cMA=; g=17cd0bf2a324e8b42bc1759f29e7dd1d484c24ad
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFSLL0ACgkQwfwUeK3K7Al2OAf/ZG6 uyy07Rocp5D3GoKLUObGWTyaOQrFM1VjVKsDrNVVtGqIKzASCfVNukVk9sE0m96dhAbYUJhqrGS0p 1/sprxzWgAQqq+PPsXCGPVvn7ZPxDhDM4NYKedtcneIRRhM+Uc5ZNUqT5cGjUu2LAZF5HxW7dLyC3 3jDZvMWku3gdWtFQE6esht1XMlyo6wlS0ALxfi62p9+ou0DaEA6EXvmiBLOJCsuqqgYVgMAzS2dGR 1X9voQQMTZ4zao69y0z2atTRjgeG17GuuA68A/utYHeZ2dRpPUpP1x7kqECpoQYjWrVNGw7C6fkdI J5GmImpEnpAxVXrGM0pyaC+yofD+BQw==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

When the driver core calls pci_device_remove() there is a driver that bound
the device and so pci_dev->driver is never NULL.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pci/pci-driver.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 2761ab86490d..8fb6418c93e8 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -459,16 +459,14 @@ static void pci_device_remove(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
-	if (drv) {
-		if (drv->remove) {
-			pm_runtime_get_sync(dev);
-			drv->remove(pci_dev);
-			pm_runtime_put_noidle(dev);
-		}
-		pcibios_free_irq(pci_dev);
-		pci_dev->driver = NULL;
-		pci_iov_remove(pci_dev);
+	if (drv->remove) {
+		pm_runtime_get_sync(dev);
+		drv->remove(pci_dev);
+		pm_runtime_put_noidle(dev);
 	}
+	pcibios_free_irq(pci_dev);
+	pci_dev->driver = NULL;
+	pci_iov_remove(pci_dev);
 
 	/* Undo the runtime PM settings in local_pci_probe() */
 	pm_runtime_put_sync(dev);
-- 
2.30.2

