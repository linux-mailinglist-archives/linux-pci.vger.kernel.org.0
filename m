Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BA241A059
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 22:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbhI0Upc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 16:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbhI0Upc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Sep 2021 16:45:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3226C061604
        for <linux-pci@vger.kernel.org>; Mon, 27 Sep 2021 13:43:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mUxTa-0001jn-U0; Mon, 27 Sep 2021 22:43:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mUxTY-0001YR-5F; Mon, 27 Sep 2021 22:43:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mUxTY-0001N0-4R; Mon, 27 Sep 2021 22:43:48 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 2/8] PCI: Drop useless check from pci_device_probe()
Date:   Mon, 27 Sep 2021 22:43:20 +0200
Message-Id: <20210927204326.612555-3-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210927204326.612555-1-uwe@kleine-koenig.org>
References: <20210927204326.612555-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=DxD2f+xPNtLjHiGujpupqv/4IuiZwGoM96HIM+GP4wQ=; m=brxsOJEmtbcToFhdbpQjJIJkUf3JUm4RRkRbChGXUkY=; p=mHFEUbsSOr1Fwea+VtNTtvy2knf9bNjYTh9sfkoxZLA=; g=4751c79fba41d79e9c1c5a83a7197e81fb2ff22e
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFSLMYACgkQwfwUeK3K7AnyCwf/f9X eiboeFJ3gwqJTXO9kLPOH5e3L5MY6HYEK1aaFJKuTlu7qvNjPNHVMHIcF4l6OKCU3pcN8hi/Qg2I+ 655sTwrX35eHH1C35fl74UlOMNsMJbcUywcR07yI8MaUbDAm6N7iz31BLPKxB6yvcisq1ri96jCph Tza6Qy/+apA7CleHZHmTcRYEKiT6iiLrlLkylnMUbFdkwSmi0jVKsw5avekjToiJvsHUs6P8JWBNG uASqps5rNp+l7fR1PBgiJY+CkinL7r5Brrp/Q2SgK7zdaO01N2p8cCQn/irWYWVxK5C1Qu2vzkKM6 +PovpEo4kUn+0lGu64unsPJwkGWbkZw==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

When the device core calls the probe callback for a device the device is
never bound and so !pci_dev->driver is always true.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pci/pci-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 8fb6418c93e8..50449ec622a3 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -397,7 +397,7 @@ static int __pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
 	const struct pci_device_id *id;
 	int error = 0;
 
-	if (!pci_dev->driver && drv->probe) {
+	if (drv->probe) {
 		error = -ENODEV;
 
 		id = pci_match_device(drv, pci_dev);
-- 
2.30.2

