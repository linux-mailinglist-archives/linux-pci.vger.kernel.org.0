Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3723E8B71
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 10:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbhHKIJB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 04:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbhHKIH2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 04:07:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC7DC061799
        for <linux-pci@vger.kernel.org>; Wed, 11 Aug 2021 01:06:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mDjG9-000161-Uk; Wed, 11 Aug 2021 10:06:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mDjG8-0000Ok-K4; Wed, 11 Aug 2021 10:06:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mDjG5-0002xQ-I8; Wed, 11 Aug 2021 10:06:41 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, kernel@pengutronix.de,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH v3 5/8] scsi: message: fusion: Remove unused parameter of mpt_pci driver's probe()
Date:   Wed, 11 Aug 2021 10:06:34 +0200
Message-Id: <20210811080637.2596434-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210811080637.2596434-1-u.kleine-koenig@pengutronix.de>
References: <20210811080637.2596434-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=Qw3P/Tfw3H2aE9nuVn1p4NHDqaHGErEmfJmO6L2HF80=; m=FydmVf3EHrOfk/Erk3jkwyQcrbBSqB9qg6qvIrOZYWc=; p=swgwO0gHobGOw9bvcebWnvhUeGHl0wdD920V7Jm9gyE=; g=2a2dbd5e6a461e2ef057dc0c5df0fe68c3d03bd6
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEThPAACgkQwfwUeK3K7An6AQf9HbB AWMOP2HMDlnih7eHXcXdJtSx6gTmG1dHIjZmnFWItgP26RdvnX62x8rIvIYjYw2RmjiqbG7zaeHc5 2uS/EZPYcswtt7b9MHXONx4XxFXjfETgxDVmQTKE94r51OU4oYTRqhEw1bJl2PhMZVWmiYqlPV8ea yEW6fWZEXsZG4OyL19XX0gyKsKpKvV7Cdt69drzVkU3iye/Rrzgu0XBORdQohcSbeSVlNvN1ag/AS /vDB+UoTm463yoTsdfacXoZHbKLtrbt86WMYr0+TBYCM/0hj1UmSCaOX8qIyUR7IWRIIkiFsR3REY +Fkh6XUXXyDGFHkpVI21a/oLbHVWNXw==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The only two drivers don't make use of the id parameter, so drop it.

This removes a usage of struct pci_dev::driver which is planned to be
removed as it tracks duplicate data.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/message/fusion/mptbase.c | 7 ++-----
 drivers/message/fusion/mptbase.h | 2 +-
 drivers/message/fusion/mptctl.c  | 4 ++--
 drivers/message/fusion/mptlan.c  | 2 +-
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 7f7abc9069f7..b94d5e4fdc23 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -829,7 +829,6 @@ int
 mpt_device_driver_register(struct mpt_pci_driver * dd_cbfunc, u8 cb_idx)
 {
 	MPT_ADAPTER	*ioc;
-	const struct pci_device_id *id;
 
 	if (!cb_idx || cb_idx >= MPT_MAX_PROTOCOL_DRIVERS)
 		return -EINVAL;
@@ -838,10 +837,8 @@ mpt_device_driver_register(struct mpt_pci_driver * dd_cbfunc, u8 cb_idx)
 
 	/* call per pci device probe entry point */
 	list_for_each_entry(ioc, &ioc_list, list) {
-		id = ioc->pcidev->driver ?
-		    ioc->pcidev->driver->id_table : NULL;
 		if (dd_cbfunc->probe)
-			dd_cbfunc->probe(ioc->pcidev, id);
+			dd_cbfunc->probe(ioc->pcidev);
 	 }
 
 	return 0;
@@ -2032,7 +2029,7 @@ mpt_attach(struct pci_dev *pdev, const struct pci_device_id *id)
 	for(cb_idx = 0; cb_idx < MPT_MAX_PROTOCOL_DRIVERS; cb_idx++) {
 		if(MptDeviceDriverHandlers[cb_idx] &&
 		  MptDeviceDriverHandlers[cb_idx]->probe) {
-			MptDeviceDriverHandlers[cb_idx]->probe(pdev,id);
+			MptDeviceDriverHandlers[cb_idx]->probe(pdev);
 		}
 	}
 
diff --git a/drivers/message/fusion/mptbase.h b/drivers/message/fusion/mptbase.h
index b9e0376be723..4bd0682c65d3 100644
--- a/drivers/message/fusion/mptbase.h
+++ b/drivers/message/fusion/mptbase.h
@@ -257,7 +257,7 @@ typedef enum {
 } MPT_DRIVER_CLASS;
 
 struct mpt_pci_driver{
-	int  (*probe) (struct pci_dev *dev, const struct pci_device_id *id);
+	int  (*probe) (struct pci_dev *dev);
 	void (*remove) (struct pci_dev *dev);
 };
 
diff --git a/drivers/message/fusion/mptctl.c b/drivers/message/fusion/mptctl.c
index 72025996cd70..ae433c150b37 100644
--- a/drivers/message/fusion/mptctl.c
+++ b/drivers/message/fusion/mptctl.c
@@ -114,7 +114,7 @@ static int mptctl_do_reset(MPT_ADAPTER *iocp, unsigned long arg);
 static int mptctl_hp_hostinfo(MPT_ADAPTER *iocp, unsigned long arg, unsigned int cmd);
 static int mptctl_hp_targetinfo(MPT_ADAPTER *iocp, unsigned long arg);
 
-static int  mptctl_probe(struct pci_dev *, const struct pci_device_id *);
+static int  mptctl_probe(struct pci_dev *);
 static void mptctl_remove(struct pci_dev *);
 
 #ifdef CONFIG_COMPAT
@@ -2838,7 +2838,7 @@ static long compat_mpctl_ioctl(struct file *f, unsigned int cmd, unsigned long a
  */
 
 static int
-mptctl_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+mptctl_probe(struct pci_dev *pdev)
 {
 	MPT_ADAPTER *ioc = pci_get_drvdata(pdev);
 
diff --git a/drivers/message/fusion/mptlan.c b/drivers/message/fusion/mptlan.c
index 3261cac762de..7c1af5e6eb0b 100644
--- a/drivers/message/fusion/mptlan.c
+++ b/drivers/message/fusion/mptlan.c
@@ -1377,7 +1377,7 @@ mpt_register_lan_device (MPT_ADAPTER *mpt_dev, int pnum)
 }
 
 static int
-mptlan_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+mptlan_probe(struct pci_dev *pdev)
 {
 	MPT_ADAPTER 		*ioc = pci_get_drvdata(pdev);
 	struct net_device	*dev;
-- 
2.30.2

