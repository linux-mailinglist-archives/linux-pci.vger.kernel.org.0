Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664003C770E
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 21:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbhGMTiZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 15:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbhGMTiY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jul 2021 15:38:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA76C0613DD
        for <linux-pci@vger.kernel.org>; Tue, 13 Jul 2021 12:35:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3OBj-0001GX-UC; Tue, 13 Jul 2021 21:35:27 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3OBi-0006pC-9J; Tue, 13 Jul 2021 21:35:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3OBi-0002dA-8L; Tue, 13 Jul 2021 21:35:26 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@pengutronix.de, Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v4 1/5] PCI: endpoint: Make struct pci_epf_driver::remove return void
Date:   Tue, 13 Jul 2021 21:35:18 +0200
Message-Id: <20210713193522.1770306-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713193522.1770306-1-u.kleine-koenig@pengutronix.de>
References: <20210713193522.1770306-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=9dRuqNo/F0QuUsC0gOJNJtkYBeA+dIcgMdqc7T89QOM=; m=snXqztb6LzIi8DAPeqNx+9PxnuQ34OAUQf7w5ELTVEo=; p=mQYpkE+33DGoHOLv2dnUwlNBxobIypWigLJdWjDllyE=; g=e5c7b97ea399fddc2695e8cf5d0c02d14175abac
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDt6sYACgkQwfwUeK3K7AkK6Af7B6T ql8oxdYh0O3IErVVz0t0YciQNR0KZ1CJMcU9N6WcaHI/tmLUZbP9PUpXpJmuN9viRBNbuvjWstz/N RjULK0LgMIupkxNTCeskTgT7wukyRLdBRoHTbx5D5EhZ9mK6YiWIq5UlQgboikntuYDe0xRYyKZv2 vJrVkHRPK4VhAy7MABwUvWQPItN0lRYd33ENupaCKS0CAjYAd77+Jm2xTFg2AOfgClZYUGYinv1zI ykA/CcYC8Ro/V+97473Z06BdC8cP7eERjJpR3JYwxDEvg1/hK+/Crqgy0I2yKhakJbORcwKb5bZ3C vIvn4hr8OOQEFKRcWpPotMHfCuZjg2A==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The driver core ignores the return value of pci_epf_device_remove()
(because there is only little it can do when a device disappears) and
there are no pci_epf_drivers with a remove callback.

So make it impossible for future drivers to return an unused error code
by changing the remove prototype to return void.

The real motivation for this change is the quest to make struct
bus_type::remove return void, too.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pci/endpoint/pci-epf-core.c | 5 ++---
 include/linux/pci-epf.h             | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index e9289d10f822..4b9ad96bf1b2 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -389,15 +389,14 @@ static int pci_epf_device_probe(struct device *dev)
 
 static int pci_epf_device_remove(struct device *dev)
 {
-	int ret = 0;
 	struct pci_epf *epf = to_pci_epf(dev);
 	struct pci_epf_driver *driver = to_pci_epf_driver(dev->driver);
 
 	if (driver->remove)
-		ret = driver->remove(epf);
+		driver->remove(epf);
 	epf->driver = NULL;
 
-	return ret;
+	return 0;
 }
 
 static struct bus_type pci_epf_bus_type = {
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 2debc27ba95e..8292420426f3 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -85,7 +85,7 @@ struct pci_epf_ops {
  */
 struct pci_epf_driver {
 	int	(*probe)(struct pci_epf *epf);
-	int	(*remove)(struct pci_epf *epf);
+	void	(*remove)(struct pci_epf *epf);
 
 	struct device_driver	driver;
 	struct pci_epf_ops	*ops;
-- 
2.30.2

