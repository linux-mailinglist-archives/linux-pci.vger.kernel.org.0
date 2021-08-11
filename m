Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DD53E8FE9
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 13:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbhHKL5Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 07:57:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:47942 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231893AbhHKL5Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Aug 2021 07:57:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="278854321"
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="278854321"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 04:56:52 -0700
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="526908984"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.51])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 04:56:46 -0700
Date:   Wed, 11 Aug 2021 12:56:39 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, kernel@pengutronix.de,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Tomaszx Kowalik <tomaszx.kowalik@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Marco Chiappero <marco.chiappero@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Jack Xu <jack.xu@intel.com>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3 6/8] crypto: qat - simplify adf_enable_aer()
Message-ID: <YRO69xL+F/6Paj+I@silpixa00400314>
References: <20210811080637.2596434-1-u.kleine-koenig@pengutronix.de>
 <20210811080637.2596434-7-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210811080637.2596434-7-u.kleine-koenig@pengutronix.de>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 11, 2021 at 10:06:35AM +0200, Uwe Kleine-König wrote:
> A struct pci_driver is supposed to be constant and assigning .err_handler
> once per bound device isn't really sensible. Also as the function returns
> zero unconditionally let it return no value instead and simplify the
> callers accordingly.
> 
> As a side effect this removes one user of struct pci_dev::driver. This
> member is planned to be removed.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Thanks Uwe for the rework.

> ---
>  drivers/crypto/qat/qat_4xxx/adf_drv.c          |  7 ++-----
>  drivers/crypto/qat/qat_c3xxx/adf_drv.c         |  7 ++-----
>  drivers/crypto/qat/qat_c62x/adf_drv.c          |  7 ++-----
>  drivers/crypto/qat/qat_common/adf_aer.c        | 10 +++-------
>  drivers/crypto/qat/qat_common/adf_common_drv.h |  2 +-
>  drivers/crypto/qat/qat_dh895xcc/adf_drv.c      |  7 ++-----
>  6 files changed, 12 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/crypto/qat/qat_4xxx/adf_drv.c b/drivers/crypto/qat/qat_4xxx/adf_drv.c
> index a8805c815d16..1620281a9ed8 100644
> --- a/drivers/crypto/qat/qat_4xxx/adf_drv.c
> +++ b/drivers/crypto/qat/qat_4xxx/adf_drv.c
> @@ -253,11 +253,7 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	pci_set_master(pdev);
>  
> -	if (adf_enable_aer(accel_dev)) {
> -		dev_err(&pdev->dev, "Failed to enable aer.\n");
> -		ret = -EFAULT;
> -		goto out_err;
> -	}
> +	adf_enable_aer(accel_dev);
After seeing your patch, I'm thinking to get rid of both adf_enable_aer()
(and adf_disable_aer()) and call directly pci_enable_pcie_error_reporting()
here.

There is another patch around this area that I reworked (but not sent
yet - https://patchwork.kernel.org/project/linux-crypto/patch/a19132d07a65dbef5e818f84b2bc971f26cc3805.1625983602.git.christophe.jaillet@wanadoo.fr/).
Would you mind if your patch goes through Herbert's tree?
If you want I can also send a reworked version.

>  	if (pci_save_state(pdev)) {
>  		dev_err(&pdev->dev, "Failed to save pci state.\n");
> @@ -310,6 +306,7 @@ static struct pci_driver adf_driver = {
>  	.probe = adf_probe,
>  	.remove = adf_remove,
>  	.sriov_configure = adf_sriov_configure,
> +	.err_handler = adf_err_handler,
Compilation fails here:
    drivers/crypto/qat/qat_4xxx/adf_drv.c:309:24: error: ‘adf_err_handler’ undeclared here (not in a function)
      309 |         .err_handler = adf_err_handler,
          |                        ^~~~~~~~~~~~~~~

Were you thinking to change it this way?

	--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
	+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
	@@ -95,8 +95,11 @@ void adf_ae_fw_release(struct adf_accel_dev *accel_dev);
	 int adf_ae_start(struct adf_accel_dev *accel_dev);
	 int adf_ae_stop(struct adf_accel_dev *accel_dev);

	+extern const struct pci_error_handlers adf_err_handler;

	--- a/drivers/crypto/qat/qat_4xxx/adf_drv.c
	+++ b/drivers/crypto/qat/qat_4xxx/adf_drv.c
	@@ -306,7 +306,7 @@ static struct pci_driver adf_driver = {
		.probe = adf_probe,
		.remove = adf_remove,
		.sriov_configure = adf_sriov_configure,
	-       .err_handler = adf_err_handler,
	+       .err_handler = &adf_err_handler,
	 };

I think the main reason why the driver was dereferencing the pci_driver
in adf_enable_aer() was to avoid that extern struct in adf_common_drv.h.
I am ok with that. Any objections from others?

Regards,

-- 
Giovanni
