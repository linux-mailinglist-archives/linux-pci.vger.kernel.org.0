Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A51941ADA2
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 13:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240290AbhI1LNm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 07:13:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:27585 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239068AbhI1LNl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Sep 2021 07:13:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="222782093"
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="222782093"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 04:11:49 -0700
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="478659708"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.51])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 04:11:45 -0700
Date:   Tue, 28 Sep 2021 12:11:38 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de, Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Tomaszx Kowalik <tomaszx.kowalik@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Marco Chiappero <marco.chiappero@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Jack Xu <jack.xu@intel.com>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v4 6/8] crypto: qat - simplify adf_enable_aer()
Message-ID: <YVL4aoKjUT2kvHip@silpixa00400314>
References: <20210927204326.612555-1-uwe@kleine-koenig.org>
 <20210927204326.612555-7-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210927204326.612555-7-uwe@kleine-koenig.org>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Uwe,

On Mon, Sep 27, 2021 at 10:43:24PM +0200, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> A struct pci_driver is supposed to be constant and assigning .err_handler
> once per bound device isn't really sensible. Also as the function returns
> zero unconditionally let it return no value instead and simplify the
> callers accordingly.
> 
> As a side effect this removes one user of struct pci_dev::driver. This
> member is planned to be removed.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---

this patch does not build.

drivers/crypto/qat/qat_c3xxx/adf_drv.c:36:24: error: ‘adf_err_handler’ undeclared here (not in a function)
   36 |         .err_handler = adf_err_handler,
      |                        ^~~~~~~~~~~~~~~
drivers/crypto/qat/qat_4xxx/adf_drv.c:303:24: error: ‘adf_err_handler’ undeclared here (not in a function)
  303 |         .err_handler = adf_err_handler,
      |                        ^~~~~~~~~~~~~~~
drivers/crypto/qat/qat_c62x/adf_drv.c:36:24: error: ‘adf_err_handler’ undeclared here (not in a function)
   36 |         .err_handler = adf_err_handler,
      |                        ^~~~~~~~~~~~~~~
drivers/crypto/qat/qat_dh895xcc/adf_drv.c:36:24: error: ‘adf_err_handler’ undeclared here (not in a function)
   36 |         .err_handler = adf_err_handler,
      |                        ^~~~~~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:277: drivers/crypto/qat/qat_c3xxx/adf_drv.o] Error 1

Below is an updated version of your patch that fixes the issues.

After fixing the patch you can add:
    Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

Regards,

GC

----8<----
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Mon, 27 Sep 2021 22:43:24 +0200
Subject: [PATCH] crypto: qat - simplify adf_enable_aer()

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
 drivers/crypto/qat/qat_common/adf_common_drv.h |  4 +++-
 drivers/crypto/qat/qat_dh895xcc/adf_drv.c      |  7 ++-----
 6 files changed, 14 insertions(+), 28 deletions(-)

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
index 4261749fae8d..2141e0b22315 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -95,7 +95,9 @@ void adf_ae_fw_release(struct adf_accel_dev *accel_dev);
 int adf_ae_start(struct adf_accel_dev *accel_dev);
 int adf_ae_stop(struct adf_accel_dev *accel_dev);
 
-int adf_enable_aer(struct adf_accel_dev *accel_dev);
+extern const struct pci_error_handlers adf_err_handler;
+
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
2.31.1

