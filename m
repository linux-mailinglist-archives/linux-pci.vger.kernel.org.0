Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3C3322786
	for <lists+linux-pci@lfdr.de>; Tue, 23 Feb 2021 10:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhBWJJt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Feb 2021 04:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhBWJI7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Feb 2021 04:08:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BD8C06174A
        for <linux-pci@vger.kernel.org>; Tue, 23 Feb 2021 01:08:14 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lETfr-0007Zf-JA; Tue, 23 Feb 2021 10:08:07 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lETfo-0006X1-IT; Tue, 23 Feb 2021 10:08:04 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] PCI: endpoint: Make struct pci_epf_driver::remove return void
Date:   Tue, 23 Feb 2021 10:07:57 +0100
Message-Id: <20210223090757.57604-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
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

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pci/endpoint/pci-epf-core.c | 5 ++---
 include/linux/pci-epf.h             | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 7646c8660d42..a19c375f9ec9 100644
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
index 6833e2160ef1..f8a17b6b1d31 100644
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
2.30.0

