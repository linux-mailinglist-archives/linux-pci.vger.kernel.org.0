Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4FA420F9E
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 15:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbhJDNgf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 09:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237661AbhJDNeo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 09:34:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44742C02B754
        for <linux-pci@vger.kernel.org>; Mon,  4 Oct 2021 05:59:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXNZH-00054h-0t; Mon, 04 Oct 2021 14:59:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXNZF-0000L5-Mc; Mon, 04 Oct 2021 14:59:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXNZF-0000cZ-Lj; Mon, 04 Oct 2021 14:59:41 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     linux-pci@vger.kernel.org, kernel@pengutronix.de,
        linux-wireless@vger.kernel.org
Subject: [PATCH v6 04/11] bcma: simplify reference to the driver's name
Date:   Mon,  4 Oct 2021 14:59:28 +0200
Message-Id: <20211004125935.2300113-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211004125935.2300113-1-u.kleine-koenig@pengutronix.de>
References: <20211004125935.2300113-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=xSP+K0RSyQAwniF6A6kkbjiE0JBr+Cc60dr1a6KF2Cc=; m=9WMNRZUkbhy3cqoI0SdJ4z32UI6gOxRm4XsLfBOiMFc=; p=ynQzBWvQpvfCsznbo0TKCTlX0o4FNuUIlPzqKHsY1yI=; g=7b3a3bd10c36e651f6578f5837b227bfa43b045b
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFa+o8ACgkQwfwUeK3K7AnLewf8Dlz c2/6eRydXEQMGM0rSOh9Fyr9miaBUlNu5AanNfHSYWpPnz/8LfSEN3LEWiFHFi3IHz4ywopnBAxgy 9CSeG1Bt0MjLrywAD0AMje5hqtxD9LXfT8ZeJ+JyWKhkfsnIt46KOFywtD4Vd4oBviqwJUHglRhhA eeOVAeZMeh6WZWMymRQ/Z0E2zp1iBJr9iTdnDyDnRlLW5h3Zm5mM9Rp+8zu99/9Yik/8UokGkHPnS 2P913K6YlytVjhHbbwKJWaHMOEtoAj21nkmMJuNuL2xKLVIAtXoN5SepWwDoJ4rAu8HP5EsI+mLYK XGAgENRcZxksEfj65Ez1JRZ/wYFgftA==
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

