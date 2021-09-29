Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2792241C10C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 10:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244915AbhI2Iz2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 04:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244924AbhI2IzX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 04:55:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9991C06161C
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 01:53:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVVLB-0001rk-5x; Wed, 29 Sep 2021 10:53:25 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVVLA-0004is-JY; Wed, 29 Sep 2021 10:53:24 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVVL3-0000R2-AD; Wed, 29 Sep 2021 10:53:17 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v5 08/11] scsi: message: fusion: Remove unused parameter of mpt_pci driver's probe()
Date:   Wed, 29 Sep 2021 10:53:03 +0200
Message-Id: <20210929085306.2203850-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929085306.2203850-1-u.kleine-koenig@pengutronix.de>
References: <20210929085306.2203850-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=Qw3P/Tfw3H2aE9nuVn1p4NHDqaHGErEmfJmO6L2HF80=; m=oP54miBWrkCU6D5dir8+ZifQgR+cn/3uLfRD8ejXKkU=; p=swgwO0gHobGOw9bvcebWnvhUeGHl0wdD920V7Jm9gyE=; g=2a2dbd5e6a461e2ef057dc0c5df0fe68c3d03bd6
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFUKVwACgkQwfwUeK3K7Am9gwf9Gpn lLhfSq1jGyYeF+mK+yCWs6FD/T9xQH95tqisKqDO6k0KFZI8gBzNsMZEqpK7ikhlkygZt5fBQkML7 zeTep7tfvapb8IdXOrSh/2F8NmoduNjVL7FNZFC7rLIQQS2lATRXLSAFw/UVyDDgOroh/5wZDiTxb p5W2a6Mg4wWXbG0f6SilKifssD8YA2ysVJ+ZMfYPOCGttMgLElF5OuNfbMiUFeXmRsxo8DfI9MsXg tlahGSGw2RvZMznalf2dZDR3C03GzA2xNQaZxdsum+yz9JHBJ16WL40BSkGYUqP2zLQ8J303PG5d5 5zQzWjQT5ytHW2D67gQBe0h9ZAHNKIw==
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

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

