Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB2341A05C
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 22:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbhI0Upd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 16:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbhI0Upd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Sep 2021 16:45:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E90C061575
        for <linux-pci@vger.kernel.org>; Mon, 27 Sep 2021 13:43:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mUxTc-0001kl-VU; Mon, 27 Sep 2021 22:43:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mUxTc-0001ZM-C4; Mon, 27 Sep 2021 22:43:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mUxTZ-0001OK-Am; Mon, 27 Sep 2021 22:43:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v4 8/8] PCI: Drop duplicated tracking of a pci_dev's bound driver
Date:   Mon, 27 Sep 2021 22:43:26 +0200
Message-Id: <20210927204326.612555-9-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210927204326.612555-1-uwe@kleine-koenig.org>
References: <20210927204326.612555-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=yGEodBYjARp1eJPqP9/n/KpfKo6ALJzXr+t0LDtBUZM=; m=JRVTmu6nPliiiBslnXnYAnMTr94GnCwSSGQey1Vdrcw=; p=9+/PFAXEYW2hem5edV2imyuahCWyj6ieFC0M508CIVc=; g=f3b7d22ed7c914b1939595bea1dcb198b436a8ca
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFSLOUACgkQwfwUeK3K7AmR9wgAnQ8 ljk2w7Ez7n4O2q5CPU/hh+MO2IRhH4mA4YVeKzV7Yu36VsXLqDcNenZjBzdLjGE3XJ5irxPf/S2n1 ZrM1SCYykvMFZZWd1E4t/jq0+CUpC4XFvQORTPEN+L2hsiSen1LOsj2ePl9g+Q1d51FB7OdNUuVyw 9P+n+palg0A6yIkWPdF480dSiPVnF0IBfISg5e/rMNLhWwuhkujVC+fPFKbSnrk+BOyrV6QpJmB8Y 3OgnFKLD7hp/SNdPxBwn/unDMY87fMxxteAY3Pgrw9fEZA/a3pSf/u9QwfWX2aA8Tx+eV7ynSYIBD 3LJeikGs17Qi4mRzQjeAOnH5z4AkGcw==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

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

