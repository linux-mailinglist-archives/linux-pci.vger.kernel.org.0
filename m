Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887DD41C106
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 10:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244916AbhI2IzG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 04:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244875AbhI2IzG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 04:55:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70047C06161C
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 01:53:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVVL7-0001qw-Mz; Wed, 29 Sep 2021 10:53:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVVL7-0004hb-3X; Wed, 29 Sep 2021 10:53:21 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVVL4-0000RR-28; Wed, 29 Sep 2021 10:53:18 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v5 11/11] PCI: Drop duplicated tracking of a pci_dev's bound driver
Date:   Wed, 29 Sep 2021 10:53:06 +0200
Message-Id: <20210929085306.2203850-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929085306.2203850-1-u.kleine-koenig@pengutronix.de>
References: <20210929085306.2203850-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=yGEodBYjARp1eJPqP9/n/KpfKo6ALJzXr+t0LDtBUZM=; m=JRVTmu6nPliiiBslnXnYAnMTr94GnCwSSGQey1Vdrcw=; p=9+/PFAXEYW2hem5edV2imyuahCWyj6ieFC0M508CIVc=; g=f3b7d22ed7c914b1939595bea1dcb198b436a8ca
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFUKWYACgkQwfwUeK3K7AnEnQf/eKV 6f3DLXesICzbTluOsr+hIQIv3xH7ikjn6tSQPAc5zUbbA9eRSxen1piBz9Up1nJOZ2hWE5/bUAJiF 3gQzl3GSsHPXueWHQkWIcV7/3w36qUfPXza32MaqROUHnhMDpMIwUHIKIlwUQpgHdxJJU2LEcdZiH LcJOcWMsv1yHPgBcsP2cCML8XDGLnJRloez+CwQ5+9AxNibqAO++GcSUUjKg6MoewPLwAxGJnwr+e tKNFePKSeWZBR8rdBHBwXEW3OnNQxRs+GjI8Gqj/lJvox0cfsoelKodYl/gTzWTepQoWAH7hJBVJY JG8Fmf/1xFkXjLnVK02CuB2R6vqku1Q==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently it's tracked twice which driver is bound to a given pci
device. Now that all users of the pci specific one (struct
pci_dev::driver) are updated to use an access macro
(pci_driver_of_dev()), change the macro to use the information from the
driver core and remove the driver member from struct pci_dev.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pci/pci-driver.c | 4 ----
 include/linux/pci.h      | 1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 4d20022b8631..e70cd432de06 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -319,12 +319,10 @@ static long local_pci_probe(void *_ddi)
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
@@ -390,7 +388,6 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
  * @pci_dev: PCI device being probed
  *
  * returns 0 on success, else error.
- * side-effect: pci_dev->driver is set to drv when drv claims pci_dev.
  */
 static int __pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
 {
@@ -465,7 +462,6 @@ static void pci_device_remove(struct device *dev)
 		pm_runtime_put_noidle(dev);
 	}
 	pcibios_free_irq(pci_dev);
-	pci_dev->driver = NULL;
 	pci_iov_remove(pci_dev);
 
 	/* Undo the runtime PM settings in local_pci_probe() */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cd8aa6fce204..7c1ceb39035c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -342,7 +342,6 @@ struct pci_dev {
 	u16		pcie_flags_reg;	/* Cached PCIe Capabilities Register */
 	unsigned long	*dma_alias_mask;/* Mask of enabled devfn aliases */
 
-	struct pci_driver *driver;	/* Driver bound to this device */
 	u64		dma_mask;	/* Mask of the bits of bus address this
 					   device implements.  Normally this is
 					   0xffffffff.  You only need to change
-- 
2.30.2

