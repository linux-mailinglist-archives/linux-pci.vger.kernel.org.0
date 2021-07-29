Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E583DADC0
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 22:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbhG2Uhw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 16:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbhG2Uhv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 16:37:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40876C0613C1
        for <linux-pci@vger.kernel.org>; Thu, 29 Jul 2021 13:37:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Cmn-0000F9-6A; Thu, 29 Jul 2021 22:37:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Cml-0003d9-Tv; Thu, 29 Jul 2021 22:37:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Cml-0004Hw-T4; Thu, 29 Jul 2021 22:37:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>, kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH v1 1/5] PCI: Simplify pci_device_remove()
Date:   Thu, 29 Jul 2021 22:37:36 +0200
Message-Id: <20210729203740.1377045-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729203740.1377045-1-u.kleine-koenig@pengutronix.de>
References: <20210729203740.1377045-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=hj/Mv0oBl1Lf1uSz5IdbQVlj1aJs3W94rdH7QDuEpg8=; m=mQWlE8Tg2mh7E+Q+22eBxOhHlWsLT4H4I+AP5A7AvGw=; p=HoTFY6m7sxvoSped1oW3AeYPWtsce2TQp/gdGZFFGJo=; g=17cd0bf2a324e8b42bc1759f29e7dd1d484c24ad
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEDEW8ACgkQwfwUeK3K7AlBqwf+Nhd u60ycnUWoaTpcyWOuW1KRoDv6Zd1rjDVFGKc5iFHgMPCn3zjmebVX1hvWW0dNMFfOLZub2XX9uFsm UFb96rSqV0I75I9RwTzS2WVdXWHy6qx9URtEaYd/tWwCacr+D3SQ87zkNoJVHSTHnQ0GQFe5+EOyu t6vQeRUhJUcwXyuO7iz62bz/Yp1rAJKJ6feazkbHcgxUGIWnjawxthRQWW1Qx219CkAfZ1we25LoP 3u6dTKrXnZTBZn6mBAyDPtlpo0oBqWbvxGGCT2PimZ3smhXo/z6HXn5NbYdWEtuYlbZyu/DLGZyom ddSPasvH5BhaxvdyREVrzitMPanBAEg==
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

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pci/pci-driver.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 3a72352aa5cf..5808fc6f258e 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -445,16 +445,14 @@ static int pci_device_remove(struct device *dev)
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

