Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFB5420F9D
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 15:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbhJDNgf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 09:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbhJDNem (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 09:34:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDB1C02B752
        for <linux-pci@vger.kernel.org>; Mon,  4 Oct 2021 05:59:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXNZH-00054f-0u; Mon, 04 Oct 2021 14:59:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXNZF-0000Kz-Ay; Mon, 04 Oct 2021 14:59:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXNZF-0000cE-AE; Mon, 04 Oct 2021 14:59:41 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, kernel@pengutronix.de,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 02/11] PCI: Drop useless check from pci_device_probe()
Date:   Mon,  4 Oct 2021 14:59:26 +0200
Message-Id: <20211004125935.2300113-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211004125935.2300113-1-u.kleine-koenig@pengutronix.de>
References: <20211004125935.2300113-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=DxD2f+xPNtLjHiGujpupqv/4IuiZwGoM96HIM+GP4wQ=; m=brxsOJEmtbcToFhdbpQjJIJkUf3JUm4RRkRbChGXUkY=; p=mHFEUbsSOr1Fwea+VtNTtvy2knf9bNjYTh9sfkoxZLA=; g=4751c79fba41d79e9c1c5a83a7197e81fb2ff22e
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFa+oQACgkQwfwUeK3K7AlnfQf5ATx oht8EnKwvAkY5xfhyk77k/n/C2e1mA0Exso8SW5its2RzZULsKqfSaaEPK6XAcEmVWHFUMjrOrP0w RaKA3EuVPdKx5yU5gtErILfcAZTJ/OSyHgnIErbR+yuEeXBsXVEV+lzvz2bgmlSH5N0G3VeO2/QWQ PrHxQAEutgRdvjZtdxCXUG7oxPWXjIUENjoa8s5J6s2C29+QHKfxi/QBX78HwyoqpBPnWlu13uC8e E15Bnwo+h5BFLYMgJMzbXn7W9GK9SyzbSgA/90zHGCn/jdZhLSI/zQL5EjJ/Fqt1Pz9rjJ4GxNImC h5kaZ6qaL3DSRazhm4WFd2YbbfjVT+g==
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

