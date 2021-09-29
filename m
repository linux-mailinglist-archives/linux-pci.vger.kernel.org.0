Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFEA41C104
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 10:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244827AbhI2IzF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 04:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244875AbhI2IzF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 04:55:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B492C06174E
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 01:53:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVVL6-0001nC-Fk; Wed, 29 Sep 2021 10:53:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVVL5-0004gh-Su; Wed, 29 Sep 2021 10:53:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVVL2-0000Qw-R7; Wed, 29 Sep 2021 10:53:16 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>, Michael Buesch <m@bues.ch>
Cc:     Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de, linux-wireless@vger.kernel.org
Subject: [PATCH v5 06/11] ssb: Simplify determination of driver name
Date:   Wed, 29 Sep 2021 10:53:01 +0200
Message-Id: <20210929085306.2203850-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929085306.2203850-1-u.kleine-koenig@pengutronix.de>
References: <20210929085306.2203850-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=98LA6DtO6x3YHoo9xrdF6tAQFUIynO6p1dMjF9yjRwA=; m=mHJAli6xdY7uFbp6iELfW4sNedbhs2KUAXIov4fr+Ac=; p=Pkc23pm1s8AeZXLg9vN/Ugj7OZ/vul9MFPqunUCTCFQ=; g=a63fc551b59edb3ff3251a4c4f7afaada4cebafa
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFUKVYACgkQwfwUeK3K7Am8SwgAnFm 8idVPWDFDmSLPZApFB/vIZzKwC+hgEIT4TxV5iSWIQ4CvQJfJ91xoygxlYqpuCc/KEzd4TDGkI2jw Y3WpkA4JNC8weZTJxkEdP3SdUugm7HziSF66CQXRyx2hwImI5O4vAqS7mZyMkBMCqkN7XWKKxtB4S ctbBsceZsBO1d1ra/fCU8+qVwLg3FAEbr2B+dV1v/S++1CrZiVFRaC5ozeGBVV+sRF0o152LXynUs CmEF/dU3ivEvjreraxMsC5h9SVt+90fJeZkrDwB1nuAP8Yfnk+QVWEdE7Q1vM0QcKSn0m3jxlwsoC XoALB+6CUXbDlTxH2VA8LuEtkJTodbg==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For all drivers that make use of ssb_pcihost_probe() (i.e.
b43_pci_bridge_driver and b44_pci_driver) the driver name is set.
As at the time for the function is called __pci_register_driver() already
assigned drv->driver.name to hold the same value, use
dev_driver_string() with the same result.

This has the upside of not requiring the driver member of struct pci_dev
which is about to be removed and being simpler.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/ssb/pcihost_wrapper.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/ssb/pcihost_wrapper.c b/drivers/ssb/pcihost_wrapper.c
index 410215c16920..dd70fd41c77d 100644
--- a/drivers/ssb/pcihost_wrapper.c
+++ b/drivers/ssb/pcihost_wrapper.c
@@ -69,7 +69,6 @@ static int ssb_pcihost_probe(struct pci_dev *dev,
 {
 	struct ssb_bus *ssb;
 	int err = -ENOMEM;
-	const char *name;
 	u32 val;
 
 	ssb = kzalloc(sizeof(*ssb), GFP_KERNEL);
@@ -78,10 +77,7 @@ static int ssb_pcihost_probe(struct pci_dev *dev,
 	err = pci_enable_device(dev);
 	if (err)
 		goto err_kfree_ssb;
-	name = dev_name(&dev->dev);
-	if (dev->driver && dev->driver->name)
-		name = dev->driver->name;
-	err = pci_request_regions(dev, name);
+	err = pci_request_regions(dev, dev_driver_string(&dev->dev));
 	if (err)
 		goto err_pci_disable;
 	pci_set_master(dev);
-- 
2.30.2

