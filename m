Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201883DADC3
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 22:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhG2Uhx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 16:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbhG2Uhv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 16:37:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63934C0613D3
        for <linux-pci@vger.kernel.org>; Thu, 29 Jul 2021 13:37:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Cmn-0000FM-DY; Thu, 29 Jul 2021 22:37:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Cmm-0003dL-Sg; Thu, 29 Jul 2021 22:37:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Cmm-0004KS-Rx; Thu, 29 Jul 2021 22:37:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>, kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH v1 5/5] PCI: Drop duplicated tracking of a pci_dev's bound driver
Date:   Thu, 29 Jul 2021 22:37:40 +0200
Message-Id: <20210729203740.1377045-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729203740.1377045-1-u.kleine-koenig@pengutronix.de>
References: <20210729203740.1377045-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=yGEodBYjARp1eJPqP9/n/KpfKo6ALJzXr+t0LDtBUZM=; m=PY2QmD3kzLJpPzlT7o2WfepF2RSh6d1mWZ9rCD7A6MU=; p=VXwrm6IwhM33tInq/RiiFiTf7eEJSweS+vvs0hZjA4Y=; g=dfdf1d247df87fe752d1cd93dee47b352d54b9dc
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEDEYwACgkQwfwUeK3K7AmkoQf/arl lZGywW/Sq5yb9i5jshREii6cSaPrkQcAxf0vHbEII5+HRxc29Z+HpfH0FLJtlI7fOfY39gbnmn+GT Ye09aNkDRdp/jfIVtdxbYc12MekjRrDRy+nm6n+4f8dnM6UvZfyoU9ijcxf5Fh3GWUu6E/Ordenlm 6EMEbrlbiEMRRNwyTLBaJiLMlZc/rVdOgq5iNCSf2JKhIb1XjE1SOuuNwrIktxEKcn9gRuoH0Ca5m SB5Fbbx6dVqIl+l60HlqC/kfFZB5VAvN5TqCE3l08+O44rC3jjivFblPM3uh7cqetcktl6GMBegYW iXez4f1Ks0IYNfN0HXIWU9qwoGyMSiw==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pci/pci-driver.c | 4 ----
 include/linux/pci.h      | 3 +--
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 740d5bf5d411..5d950eb476e2 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -305,12 +305,10 @@ static long local_pci_probe(void *_ddi)
 	 * its remove routine.
 	 */
 	pm_runtime_get_sync(dev);
-	pci_dev->driver = pci_drv;
 	rc = pci_drv->probe(pci_dev, ddi->id);
 	if (!rc)
 		return rc;
 	if (rc < 0) {
-		pci_dev->driver = NULL;
 		pm_runtime_put_sync(dev);
 		return rc;
 	}
@@ -376,7 +374,6 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
  * @pci_dev: PCI device being probed
  *
  * returns 0 on success, else error.
- * side-effect: pci_dev->driver is set to drv when drv claims pci_dev.
  */
 static int __pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
 {
@@ -451,7 +448,6 @@ static int pci_device_remove(struct device *dev)
 		pm_runtime_put_noidle(dev);
 	}
 	pcibios_free_irq(pci_dev);
-	pci_dev->driver = NULL;
 	pci_iov_remove(pci_dev);
 
 	/* Undo the runtime PM settings in local_pci_probe() */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 778f3b5e6f23..f44ab76e216f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -342,7 +342,6 @@ struct pci_dev {
 	u16		pcie_flags_reg;	/* Cached PCIe Capabilities Register */
 	unsigned long	*dma_alias_mask;/* Mask of enabled devfn aliases */
 
-	struct pci_driver *driver;	/* Driver bound to this device */
 	u64		dma_mask;	/* Mask of the bits of bus address this
 					   device implements.  Normally this is
 					   0xffffffff.  You only need to change
@@ -887,7 +886,7 @@ struct pci_driver {
 };
 
 #define	to_pci_driver(drv) container_of(drv, struct pci_driver, driver)
-#define pci_driver_of_dev(pdev) ((pdev)->driver)
+#define pci_driver_of_dev(pdev) ((pdev)->dev.driver ? to_pci_driver((pdev)->dev.driver) : NULL)
 
 /**
  * PCI_DEVICE - macro used to describe a specific PCI device
-- 
2.30.2

