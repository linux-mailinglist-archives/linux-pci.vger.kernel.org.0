Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975AE420F9B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 15:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbhJDNge (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 09:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbhJDNek (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 09:34:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD43FC02B751
        for <linux-pci@vger.kernel.org>; Mon,  4 Oct 2021 05:59:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXNZH-00054d-0u; Mon, 04 Oct 2021 14:59:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXNZF-0000Kv-5T; Mon, 04 Oct 2021 14:59:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXNZF-0000b1-4g; Mon, 04 Oct 2021 14:59:41 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, kernel@pengutronix.de,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 01/11] PCI: Simplify pci_device_remove()
Date:   Mon,  4 Oct 2021 14:59:25 +0200
Message-Id: <20211004125935.2300113-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211004125935.2300113-1-u.kleine-koenig@pengutronix.de>
References: <20211004125935.2300113-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=hj/Mv0oBl1Lf1uSz5IdbQVlj1aJs3W94rdH7QDuEpg8=; m=3MjO1JqLy12b20qOWv/Fp9tjcaX0qdsgbDBjSqzg3lQ=; p=u/IlHXlFxyd9VYnelQTUuUgSTqRFKk2si+oT8j90cMA=; g=17cd0bf2a324e8b42bc1759f29e7dd1d484c24ad
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFa+n0ACgkQwfwUeK3K7Ana9gf+OfV qUrWXfk6u7XxukdAGMkhlCImiETp7WbAaJtx4ucc9Eqi14ECyf//4VLm6chZkV/FCt3hk2NLuS9+g Ow40dXPPTMeapRfZE8F/rCwW4c5oRnLA1JJ3lHn/PzFBhFuAQCmHiW72yGhRa8mIywBse5aPOHhjK qGufI36txI/o/G9mBWL/NX9kXwN4aURNNJDpMV0KqpXkDInx3cwx0WNdZbQ/IuvIM+GbsrimXCUtu 2+TE+K96WwPk3tOUHsShIu2h4VgYMPHQa/BYSn0wTtmawkBpngcndm6EIzrzlk4o9l3RhVWM+whAd Pomcid8gom4pevc6FkV3xHpQv0tH1eQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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

