Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAB741C10F
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 10:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244934AbhI2Izh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 04:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244921AbhI2Ize (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 04:55:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A369DC06174E
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 01:53:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVVL5-0001il-KW; Wed, 29 Sep 2021 10:53:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVVL3-0004fs-JV; Wed, 29 Sep 2021 10:53:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mVVL3-0000R5-I0; Wed, 29 Sep 2021 10:53:17 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Tomaszx Kowalik <tomaszx.kowalik@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Marco Chiappero <marco.chiappero@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Jack Xu <jack.xu@intel.com>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org
Subject: [PATCH v5 09/11] crypto: qat - simplify adf_enable_aer()
Date:   Wed, 29 Sep 2021 10:53:04 +0200
Message-Id: <20210929085306.2203850-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929085306.2203850-1-u.kleine-koenig@pengutronix.de>
References: <20210929085306.2203850-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=woJ+XG24qLZpRfQYIhuIjBJ10HF9ai4yZDNEgvzBdKs=; m=43Bwh4bgNofseZy3pN98J/xw6T54xBXYb8+EgplqK/c=; p=e0ubWRxaTOxpVVmYaiPGXfH9Fp+aEsg5i7cfFIxLb4w=; g=75d910e3cf936fc2161d0c2f4f099378e2733742
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFUKV8ACgkQwfwUeK3K7AkBLQgAiMf lHjrsvdAs+vA2PbvtByAdocSgqQHHSsMjWUdd7oxcamF2iQ+atjNFDs7o0Qq3GH104ghMSLvgV9n5 igdrQMwiR8MJodQ/40sebxuhVUJK5ucx8xIEg0VdJZawEoAaEmSR5OqHgZJk3wMZw8f4tJiEqoVOL wrlajTg3FjP9s/vyzsebuBBpRptaxBXL/sob3XdZ0GCG2Jrze+kz6xHC/zqNwlkXLdv80ytfnMTYN 4kqc0m7dylgnpAP0dt8ZK05veLL3YVBab8RES5AsNt0EW2Fekq+79Qxm0O76a7C6UwBhLnVXkw6OD vylu5lZjBa1dSkEaocJCvh0OHH8dM7g==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A struct pci_driver is supposed to be constant and assigning .err_handler
once per bound device isn't really sensible. Also as the function returns
zero unconditionally let it return no value instead and simplify the
callers accordingly.

As a side effect this removes one user of struct pci_dev::driver. This
member is planned to be removed.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/crypto/qat/qat_4xxx/adf_drv.c          |  7 ++-----
 drivers/crypto/qat/qat_c3xxx/adf_drv.c         |  7 ++-----
 drivers/crypto/qat/qat_c62x/adf_drv.c          |  7 ++-----
 drivers/crypto/qat/qat_common/adf_aer.c        | 10 +++-------
 drivers/crypto/qat/qat_common/adf_common_drv.h |  3 ++-
 drivers/crypto/qat/qat_dh895xcc/adf_drv.c      |  7 ++-----
 6 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/crypto/qat/qat_4xxx/adf_drv.c b/drivers/crypto/qat/qat_4xxx/adf_drv.c
index 359fb7989dfb..71ef065914b2 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_drv.c
+++ b/drivers/crypto/qat/qat_4xxx/adf_drv.c
@@ -247,11 +247,7 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_master(pdev);
 
-	if (adf_enable_aer(accel_dev)) {
-		dev_err(&pdev->dev, "Failed to enable aer.\n");
-		ret = -EFAULT;
-		goto out_err;
-	}
+	adf_enable_aer(accel_dev);
 
 	if (pci_save_state(pdev)) {
 		dev_err(&pdev->dev, "Failed to save pci state.\n");
@@ -304,6 +300,7 @@ static struct pci_driver adf_driver = {
 	.probe = adf_probe,
 	.remove = adf_remove,
 	.sriov_configure = adf_sriov_configure,
+	.err_handler = &adf_err_handler,
 };
 
 module_pci_driver(adf_driver);
diff --git a/drivers/crypto/qat/qat_c3xxx/adf_drv.c b/drivers/crypto/qat/qat_c3xxx/adf_drv.c
index cc6e75dc60de..2aef0bb791df 100644
--- a/drivers/crypto/qat/qat_c3xxx/adf_drv.c
+++ b/drivers/crypto/qat/qat_c3xxx/adf_drv.c
@@ -33,6 +33,7 @@ static struct pci_driver adf_driver = {
 	.probe = adf_probe,
 	.remove = adf_remove,
 	.sriov_configure = adf_sriov_configure,
+	.err_handler = &adf_err_handler,
 };
 
 static void adf_cleanup_pci_dev(struct adf_accel_dev *accel_dev)
@@ -192,11 +193,7 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	pci_set_master(pdev);
 
-	if (adf_enable_aer(accel_dev)) {
-		dev_err(&pdev->dev, "Failed to enable aer\n");
-		ret = -EFAULT;
-		goto out_err_free_reg;
-	}
+	adf_enable_aer(accel_dev);
 
 	if (pci_save_state(pdev)) {
 		dev_err(&pdev->dev, "Failed to save pci state\n");
diff --git a/drivers/crypto/qat/qat_c62x/adf_drv.c b/drivers/crypto/qat/qat_c62x/adf_drv.c
index bf251dfe74b3..56163083f161 100644
--- a/drivers/crypto/qat/qat_c62x/adf_drv.c
+++ b/drivers/crypto/qat/qat_c62x/adf_drv.c
@@ -33,6 +33,7 @@ static struct pci_driver adf_driver = {
 	.probe = adf_probe,
 	.remove = adf_remove,
 	.sriov_configure = adf_sriov_configure,
+	.err_handler = &adf_err_handler,
 };
 
 static void adf_cleanup_pci_dev(struct adf_accel_dev *accel_dev)
@@ -192,11 +193,7 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	pci_set_master(pdev);
 
-	if (adf_enable_aer(accel_dev)) {
-		dev_err(&pdev->dev, "Failed to enable aer\n");
-		ret = -EFAULT;
-		goto out_err_free_reg;
-	}
+	adf_enable_aer(accel_dev);
 
 	if (pci_save_state(pdev)) {
 		dev_err(&pdev->dev, "Failed to save pci state\n");
diff --git a/drivers/crypto/qat/qat_common/adf_aer.c b/drivers/crypto/qat/qat_common/adf_aer.c
index ed3e40bc56eb..fe9bb2f3536a 100644
--- a/drivers/crypto/qat/qat_common/adf_aer.c
+++ b/drivers/crypto/qat/qat_common/adf_aer.c
@@ -166,11 +166,12 @@ static void adf_resume(struct pci_dev *pdev)
 	dev_info(&pdev->dev, "Device is up and running\n");
 }
 
-static const struct pci_error_handlers adf_err_handler = {
+const struct pci_error_handlers adf_err_handler = {
 	.error_detected = adf_error_detected,
 	.slot_reset = adf_slot_reset,
 	.resume = adf_resume,
 };
+EXPORT_SYMBOL_GPL(adf_err_handler);
 
 /**
  * adf_enable_aer() - Enable Advance Error Reporting for acceleration device
@@ -179,17 +180,12 @@ static const struct pci_error_handlers adf_err_handler = {
  * Function enables PCI Advance Error Reporting for the
  * QAT acceleration device accel_dev.
  * To be used by QAT device specific drivers.
- *
- * Return: 0 on success, error code otherwise.
  */
-int adf_enable_aer(struct adf_accel_dev *accel_dev)
+void adf_enable_aer(struct adf_accel_dev *accel_dev)
 {
 	struct pci_dev *pdev = accel_to_pci_dev(accel_dev);
-	struct pci_driver *pdrv = pdev->driver;
 
-	pdrv->err_handler = &adf_err_handler;
 	pci_enable_pcie_error_reporting(pdev);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(adf_enable_aer);
 
diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index 4261749fae8d..e4c24be212ff 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -95,7 +95,8 @@ void adf_ae_fw_release(struct adf_accel_dev *accel_dev);
 int adf_ae_start(struct adf_accel_dev *accel_dev);
 int adf_ae_stop(struct adf_accel_dev *accel_dev);
 
-int adf_enable_aer(struct adf_accel_dev *accel_dev);
+extern const struct pci_error_handlers adf_err_handler;
+void adf_enable_aer(struct adf_accel_dev *accel_dev);
 void adf_disable_aer(struct adf_accel_dev *accel_dev);
 void adf_reset_sbr(struct adf_accel_dev *accel_dev);
 void adf_reset_flr(struct adf_accel_dev *accel_dev);
diff --git a/drivers/crypto/qat/qat_dh895xcc/adf_drv.c b/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
index 3976a81bd99b..acca56752aa0 100644
--- a/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
+++ b/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
@@ -33,6 +33,7 @@ static struct pci_driver adf_driver = {
 	.probe = adf_probe,
 	.remove = adf_remove,
 	.sriov_configure = adf_sriov_configure,
+	.err_handler = &adf_err_handler,
 };
 
 static void adf_cleanup_pci_dev(struct adf_accel_dev *accel_dev)
@@ -192,11 +193,7 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	pci_set_master(pdev);
 
-	if (adf_enable_aer(accel_dev)) {
-		dev_err(&pdev->dev, "Failed to enable aer\n");
-		ret = -EFAULT;
-		goto out_err_free_reg;
-	}
+	adf_enable_aer(accel_dev);
 
 	if (pci_save_state(pdev)) {
 		dev_err(&pdev->dev, "Failed to save pci state\n");
-- 
2.30.2

