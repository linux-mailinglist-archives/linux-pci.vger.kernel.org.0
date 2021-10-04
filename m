Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9DC420FA5
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 15:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbhJDNgm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 09:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237779AbhJDNe5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 09:34:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE74FC02B757
        for <linux-pci@vger.kernel.org>; Mon,  4 Oct 2021 05:59:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXNZH-00054i-0u; Mon, 04 Oct 2021 14:59:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXNZG-0000L8-1K; Mon, 04 Oct 2021 14:59:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXNZG-0000cl-0D; Mon, 04 Oct 2021 14:59:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Michael=20B=C3=BCsch?= <m@bues.ch>
Cc:     linux-pci@vger.kernel.org, kernel@pengutronix.de,
        linux-wireless@vger.kernel.org
Subject: [PATCH v6 06/11] ssb: Simplify determination of driver name
Date:   Mon,  4 Oct 2021 14:59:30 +0200
Message-Id: <20211004125935.2300113-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211004125935.2300113-1-u.kleine-koenig@pengutronix.de>
References: <20211004125935.2300113-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=98LA6DtO6x3YHoo9xrdF6tAQFUIynO6p1dMjF9yjRwA=; m=EiK7a8Op8GQPl3dHtg7E9V4Vg7092+Ak3Ee+tNDA8iU=; p=Pkc23pm1s8AeZXLg9vN/Ugj7OZ/vul9MFPqunUCTCFQ=; g=a63fc551b59edb3ff3251a4c4f7afaada4cebafa
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFa+pYACgkQwfwUeK3K7Akfvgf9FY7 2+JNv8HHXv8Hr9ZkoIjx84PVX7Snb2Ho4mRX6/ivHJuJ6wznEDeGAvyXy8e8WGz5WCOgI5g0McS7N rWQtfyqNERgoZzVqQHcOQs54jNp1A/8tqRC4o1RPS91Dj43LipxunVCwuWK0ujonrBMBAo+JU0B+K uW91LgsHz/UBzn+nAl/NZaPrWumJk9eDwmNK5pr8133twT+OQ+so2Ks7vHBu6pYAhbxjznfCXnPlv ChbnA4usKuakP6XgchG02Pf/a2aL+tdfwo0xzm41nDULLM03YwS/5SYOH0xh+80Qg7dTcRqNFr5xW xbRBbEivsTHMZfiycHa6NilMQ3qBeCQ==
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

Acked-by: Michael Büsch <m@bues.ch>
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

