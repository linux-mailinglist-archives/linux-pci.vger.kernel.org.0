Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012FA3E8B74
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 10:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbhHKIJM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 04:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbhHKIH2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 04:07:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41191C061798
        for <linux-pci@vger.kernel.org>; Wed, 11 Aug 2021 01:06:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mDjG9-00017p-TR; Wed, 11 Aug 2021 10:06:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mDjG9-0000P3-CS; Wed, 11 Aug 2021 10:06:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mDjG6-0002xp-AQ; Wed, 11 Aug 2021 10:06:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v3 8/8] PCI: Drop duplicated tracking of a pci_dev's bound driver
Date:   Wed, 11 Aug 2021 10:06:37 +0200
Message-Id: <20210811080637.2596434-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210811080637.2596434-1-u.kleine-koenig@pengutronix.de>
References: <20210811080637.2596434-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=yGEodBYjARp1eJPqP9/n/KpfKo6ALJzXr+t0LDtBUZM=; m=JRVTmu6nPliiiBslnXnYAnMTr94GnCwSSGQey1Vdrcw=; p=rv0aVc4k04hVGAp5b4bWm/VdX4YI7e2/eYWOrVGVROU=; g=f3b7d22ed7c914b1939595bea1dcb198b436a8ca
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEThQUACgkQwfwUeK3K7Am3oAgAoMx pMpGM06uIV7Xo2rMowk67L2rW1jPh0AYqtOu3RsEMq91tE9tgxF/mi1THKyWCBvJbS2eQRjxw9yAx z82fz1J+63tT2fE6KMdJqSDIfpCzUqMPoYfcZL+wLb3Y9BvS1Qu5GDeDWdXBUWWqF4FsQc2nP8Bdu 9zshiwoeIivagRO+EDdhccg4thu6TXEzHdpHOSdzBgqPiMVCRTK/zpPA+tOo2VbyHb7ijCmufFeIn WZg2fvaLSnX1VTYxYSM5KuCdRWMUY8BBVlRuQGJz+J27ZLikzhDBvhKff/SqobOMtMBnFtd8LSJPm kwVcwedWCDIf57gSLdktCp2rucHafrA==
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
index e4bab9d0d6d8..cfc4cb6da8c0 100644
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
index 540b377ca8f6..019a8f2e0fdd 100644
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

