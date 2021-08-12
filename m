Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB3F3EA6B5
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 16:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbhHLOnp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 10:43:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:47366 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233079AbhHLOno (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Aug 2021 10:43:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="237399845"
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="237399845"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 07:43:19 -0700
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="517479659"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.51])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 07:43:15 -0700
Date:   Thu, 12 Aug 2021 15:43:09 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Fiona Trahe <fiona.trahe@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marco Chiappero <marco.chiappero@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        qat-linux@intel.com, Bjorn Helgaas <helgaas@kernel.org>,
        linux-crypto@vger.kernel.org, kernel@pengutronix.de,
        linux-pci@vger.kernel.org, Jack Xu <jack.xu@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Tomaszx Kowalik <tomaszx.kowalik@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 6/8] crypto: qat - simplify adf_enable_aer()
Message-ID: <YRUzfQCLOtRmXyCr@silpixa00400314>
References: <20210811080637.2596434-1-u.kleine-koenig@pengutronix.de>
 <20210811080637.2596434-7-u.kleine-koenig@pengutronix.de>
 <YRO69xL+F/6Paj+I@silpixa00400314>
 <20210811213405.avihazo33irdjxic@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210811213405.avihazo33irdjxic@pengutronix.de>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 11, 2021 at 11:34:05PM +0200, Uwe Kleine-König wrote:
> On Wed, Aug 11, 2021 at 12:56:39PM +0100, Giovanni Cabiddu wrote:
> > On Wed, Aug 11, 2021 at 10:06:35AM +0200, Uwe Kleine-König wrote:
> > > A struct pci_driver is supposed to be constant and assigning .err_handler
> > > once per bound device isn't really sensible. Also as the function returns
> > > zero unconditionally let it return no value instead and simplify the
> > > callers accordingly.
> > > 
> > > As a side effect this removes one user of struct pci_dev::driver. This
> > > member is planned to be removed.
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Thanks Uwe for the rework.
> > 
> > > ---
> > >  drivers/crypto/qat/qat_4xxx/adf_drv.c          |  7 ++-----
> > >  drivers/crypto/qat/qat_c3xxx/adf_drv.c         |  7 ++-----
> > >  drivers/crypto/qat/qat_c62x/adf_drv.c          |  7 ++-----
> > >  drivers/crypto/qat/qat_common/adf_aer.c        | 10 +++-------
> > >  drivers/crypto/qat/qat_common/adf_common_drv.h |  2 +-
> > >  drivers/crypto/qat/qat_dh895xcc/adf_drv.c      |  7 ++-----
> > >  6 files changed, 12 insertions(+), 28 deletions(-)
> > > 
> > > diff --git a/drivers/crypto/qat/qat_4xxx/adf_drv.c b/drivers/crypto/qat/qat_4xxx/adf_drv.c
> > > index a8805c815d16..1620281a9ed8 100644
> > > --- a/drivers/crypto/qat/qat_4xxx/adf_drv.c
> > > +++ b/drivers/crypto/qat/qat_4xxx/adf_drv.c
> > > @@ -253,11 +253,7 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> > >  
> > >  	pci_set_master(pdev);
> > >  
> > > -	if (adf_enable_aer(accel_dev)) {
> > > -		dev_err(&pdev->dev, "Failed to enable aer.\n");
> > > -		ret = -EFAULT;
> > > -		goto out_err;
> > > -	}
> > > +	adf_enable_aer(accel_dev);
> > After seeing your patch, I'm thinking to get rid of both adf_enable_aer()
> > (and adf_disable_aer()) and call directly pci_enable_pcie_error_reporting()
> > here.
I'm going to rework this in a subsequent patchset.

> > There is another patch around this area that I reworked (but not sent
> > yet - https://patchwork.kernel.org/project/linux-crypto/patch/a19132d07a65dbef5e818f84b2bc971f26cc3805.1625983602.git.christophe.jaillet@wanadoo.fr/).
> > Would you mind if your patch goes through Herbert's tree?
> > If you want I can also send a reworked version.
> 
> As patch #8 of my series depends on this one I think the best option is
> to create a tag and pull that into both, the pci and the crypto tree?!
Probably there is no need for that.
Your patch applies cleanly on top of this series:
https://patchwork.kernel.org/project/linux-crypto/list/?series=530407

> 
> @Bjorn: Would you agree to this procedure? There has to be a v4, if it
> helps I can provide a signed tag for pulling?! Just tell me what would
> be helpful here.
> 
> > >  	if (pci_save_state(pdev)) {
> > >  		dev_err(&pdev->dev, "Failed to save pci state.\n");
> > > @@ -310,6 +306,7 @@ static struct pci_driver adf_driver = {
> > >  	.probe = adf_probe,
> > >  	.remove = adf_remove,
> > >  	.sriov_configure = adf_sriov_configure,
> > > +	.err_handler = adf_err_handler,
> > Compilation fails here:
> >     drivers/crypto/qat/qat_4xxx/adf_drv.c:309:24: error: ‘adf_err_handler’ undeclared here (not in a function)
> >       309 |         .err_handler = adf_err_handler,
> >           |                        ^~~~~~~~~~~~~~~
> > 
> > Were you thinking to change it this way?
> > 
> > 	--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
> > 	+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
> > 	@@ -95,8 +95,11 @@ void adf_ae_fw_release(struct adf_accel_dev *accel_dev);
> > 	 int adf_ae_start(struct adf_accel_dev *accel_dev);
> > 	 int adf_ae_stop(struct adf_accel_dev *accel_dev);
> > 
> > 	+extern const struct pci_error_handlers adf_err_handler;
> > 
> > 	--- a/drivers/crypto/qat/qat_4xxx/adf_drv.c
> > 	+++ b/drivers/crypto/qat/qat_4xxx/adf_drv.c
> > 	@@ -306,7 +306,7 @@ static struct pci_driver adf_driver = {
> > 		.probe = adf_probe,
> > 		.remove = adf_remove,
> > 		.sriov_configure = adf_sriov_configure,
> > 	-       .err_handler = adf_err_handler,
> > 	+       .err_handler = &adf_err_handler,
> > 	 };
> 
> Yeah, the other three drivers need an adaption, too. I will send a v4 in
> the next few days. The current state is available at
> 
> 	https://git.pengutronix.de/git/ukl/linux pci-dedup
I fixed that and tested on c62x. Here is an updated patch:

----8<----
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Wed, 11 Aug 2021 10:06:35 +0200
Subject: [PATCH] crypto: qat - simplify adf_enable_aer()

A struct pci_driver is supposed to be constant and assigning .err_handler
once per bound device isn't really sensible. Also as the function returns
zero unconditionally let it return no value instead and simplify the
callers accordingly.

As a side effect this removes one user of struct pci_dev::driver. This
member is planned to be removed.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Co-developed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/qat/qat_4xxx/adf_drv.c          |  7 ++-----
 drivers/crypto/qat/qat_c3xxx/adf_drv.c         |  7 ++-----
 drivers/crypto/qat/qat_c62x/adf_drv.c          |  7 ++-----
 drivers/crypto/qat/qat_common/adf_aer.c        | 10 +++-------
 drivers/crypto/qat/qat_common/adf_common_drv.h |  5 ++++-
 drivers/crypto/qat/qat_dh895xcc/adf_drv.c      |  7 ++-----
 6 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/drivers/crypto/qat/qat_4xxx/adf_drv.c b/drivers/crypto/qat/qat_4xxx/adf_drv.c
index a8805c815d16..e863f7ac9c44 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_drv.c
+++ b/drivers/crypto/qat/qat_4xxx/adf_drv.c
@@ -253,11 +253,7 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_master(pdev);
 
-	if (adf_enable_aer(accel_dev)) {
-		dev_err(&pdev->dev, "Failed to enable aer.\n");
-		ret = -EFAULT;
-		goto out_err;
-	}
+	adf_enable_aer(accel_dev);
 
 	if (pci_save_state(pdev)) {
 		dev_err(&pdev->dev, "Failed to save pci state.\n");
@@ -310,6 +306,7 @@ static struct pci_driver adf_driver = {
 	.probe = adf_probe,
 	.remove = adf_remove,
 	.sriov_configure = adf_sriov_configure,
+	.err_handler = &adf_err_handler,
 };
 
 module_pci_driver(adf_driver);
diff --git a/drivers/crypto/qat/qat_c3xxx/adf_drv.c b/drivers/crypto/qat/qat_c3xxx/adf_drv.c
index 7fb3343ae8b0..c62330357e63 100644
--- a/drivers/crypto/qat/qat_c3xxx/adf_drv.c
+++ b/drivers/crypto/qat/qat_c3xxx/adf_drv.c
@@ -33,6 +33,7 @@ static struct pci_driver adf_driver = {
 	.probe = adf_probe,
 	.remove = adf_remove,
 	.sriov_configure = adf_sriov_configure,
+	.err_handler = &adf_err_handler,
 };
 
 static void adf_cleanup_pci_dev(struct adf_accel_dev *accel_dev)
@@ -199,11 +200,7 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
index 1f5de442e1e6..ad9f18a9eb1d 100644
--- a/drivers/crypto/qat/qat_c62x/adf_drv.c
+++ b/drivers/crypto/qat/qat_c62x/adf_drv.c
@@ -33,6 +33,7 @@ static struct pci_driver adf_driver = {
 	.probe = adf_probe,
 	.remove = adf_remove,
 	.sriov_configure = adf_sriov_configure,
+	.err_handler = &adf_err_handler,
 };
 
 static void adf_cleanup_pci_dev(struct adf_accel_dev *accel_dev)
@@ -199,11 +200,7 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
index d2ae293d0df6..9284d09e3af8 100644
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
index c61476553728..3d7fb9715cf8 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -95,8 +95,11 @@ void adf_ae_fw_release(struct adf_accel_dev *accel_dev);
 int adf_ae_start(struct adf_accel_dev *accel_dev);
 int adf_ae_stop(struct adf_accel_dev *accel_dev);
 
-int adf_enable_aer(struct adf_accel_dev *accel_dev);
+extern const struct pci_error_handlers adf_err_handler;
+
+void adf_enable_aer(struct adf_accel_dev *accel_dev);
 void adf_disable_aer(struct adf_accel_dev *accel_dev);
+
 void adf_reset_sbr(struct adf_accel_dev *accel_dev);
 void adf_reset_flr(struct adf_accel_dev *accel_dev);
 void adf_dev_restore(struct adf_accel_dev *accel_dev);
diff --git a/drivers/crypto/qat/qat_dh895xcc/adf_drv.c b/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
index a9ec4357144c..9e9d495271b5 100644
--- a/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
+++ b/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
@@ -33,6 +33,7 @@ static struct pci_driver adf_driver = {
 	.probe = adf_probe,
 	.remove = adf_remove,
 	.sriov_configure = adf_sriov_configure,
+	.err_handler = &adf_err_handler,
 };
 
 static void adf_cleanup_pci_dev(struct adf_accel_dev *accel_dev)
@@ -199,11 +200,7 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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


