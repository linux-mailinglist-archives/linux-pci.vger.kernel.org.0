Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7A33E8B78
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 10:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbhHKIJQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 04:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbhHKIHd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 04:07:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683A3C0613D3
        for <linux-pci@vger.kernel.org>; Wed, 11 Aug 2021 01:06:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mDjG6-0000zg-7t; Wed, 11 Aug 2021 10:06:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mDjG4-0000O8-Uw; Wed, 11 Aug 2021 10:06:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mDjG4-0002wZ-UG; Wed, 11 Aug 2021 10:06:40 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v3 2/8] PCI: Drop useless check from pci_device_probe()
Date:   Wed, 11 Aug 2021 10:06:31 +0200
Message-Id: <20210811080637.2596434-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210811080637.2596434-1-u.kleine-koenig@pengutronix.de>
References: <20210811080637.2596434-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=DxD2f+xPNtLjHiGujpupqv/4IuiZwGoM96HIM+GP4wQ=; m=8Ai/yMthXF16CTAuD/pw3nAJZok0QXil2jJFkcBbwys=; p=oAB78UBBdbcpWvK14ZiunzGqiixuYor3x/t79yxAEGI=; g=4751c79fba41d79e9c1c5a83a7197e81fb2ff22e
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEThNsACgkQwfwUeK3K7An87Af/Rp0 ORApMpMQnptc4YAUrgOvlPPrhukMa87ZoU84o5dnvNOfAWKiFPDrjKAYNVAgfW7bsHp8jGtrU7Ym0 p/cmzm0eqUCQNKePAYfjf9Mw2u2gSqOOluioCJCZ4GtRx4i+UPPnMQedO0idTqa06iyFETeOrRjTl 2MUiy0U+qFJgRco2hr3UMNZAk5F/1yGcOekrPz6ajYsRI6qyQLuv7O+ZrPtTen6uB0mq1iXwodt0b rOSRnFW4Lr9cL2HQPr1Eefi0v6SmybX2UjLGZHV6LcbDpzjrFMC+F8JDf0spXROjIbFMUTH6RIt1M TlawVSZI2dGaXZ3v564jt3LTJQZe9Dg==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the device core calls the probe callback for a device the device is
never bound and so !pci_dev->driver is always true.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pci/pci-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 5808fc6f258e..7dff574bb2fa 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -383,7 +383,7 @@ static int __pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
 	const struct pci_device_id *id;
 	int error = 0;
 
-	if (!pci_dev->driver && drv->probe) {
+	if (drv->probe) {
 		error = -ENODEV;
 
 		id = pci_match_device(drv, pci_dev);
-- 
2.30.2

