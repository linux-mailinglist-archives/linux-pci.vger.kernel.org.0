Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78247A0DB3
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 21:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240880AbjINTBY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 15:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241331AbjINTBL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 15:01:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF4F2D5E;
        Thu, 14 Sep 2023 11:42:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16EBC433B9;
        Thu, 14 Sep 2023 18:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694716971;
        bh=08e3rjzF0krBhajpQnyBqQbdi7QA3Cyqf3TN7meiMuc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=e5jxyRyHOP/DjRJuPsyiFh1vt7vtwAZuZ7nmLxwXXZ34KlomrBCw1HjQvcicHQcfu
         563tqna9nWQLTE2sPMxhAwDxEUICpNfyRjBWooir/u1+ZkTcm6MyRneNkG6dnqpFwf
         VZAVbzNE6C+n+VKMXiEbLTf8bjiWU/BSlqQ6lYcU7M1I03H6BpP8xCxoZ8eA+SRBwm
         7qsXxLr34whdGlGLz1JGQSmoG5k1x5Jibze8tNsk+LGU2/MAsQnjpmXbLmxvy5PmXb
         RzIawaUEnSOV1IbQuFIH9E/VEd7Qd81olGd87UmFmLGkZf0nzkvdGHpxjWVMVz/ONk
         HcY4lK9El8IgA==
Date:   Thu, 14 Sep 2023 13:42:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     srinivas.pandruvada@linux.intel.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-pm@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Jian Hui Lee <jianhui.lee@canonical.com>,
        Even Xu <even.xu@intel.com>, Zhang Lixu <lixu.zhang@intel.com>,
        Najumon Ba <najumon.ba@intel.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
Message-ID: <20230914184249.GA74069@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914041806.816741-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 14, 2023 at 12:18:05PM +0800, Kai-Heng Feng wrote:
> System cannot suspend more than 255 times because the driver doesn't
> have corresponding acpi_disable_gpe() for acpi_enable_gpe(), so the GPE
> refcount overflows.

How can a user know they are seeing this problem?  Is there a public
bug report for it?

> Since PCI core and ACPI core already handles PCI PME wake and GPE wake
> when the device has wakeup capability, use device_init_wakeup() to let
> them do the wakeup setting work.
> 
> Also add a shutdown callback which uses pci_prepare_to_sleep() to let
> PCI and ACPI set OOB wakeup for S5.

Is this logically required to be part of this patch, or could it be a
separate patch?

> Fixes: 2e23a70edabe ("HID: intel-ish-hid: ipc: finish power flow for EHL OOB")
> Cc: Jian Hui Lee <jianhui.lee@canonical.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 59 +++++++------------------
>  1 file changed, 15 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> index 55cb25038e63..65e7eeb2fa64 100644
> --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> @@ -119,42 +119,6 @@ static inline bool ish_should_leave_d0i3(struct pci_dev *pdev)
>  	return !pm_resume_via_firmware() || pdev->device == CHV_DEVICE_ID;
>  }
>  
> -static int enable_gpe(struct device *dev)
> -{
> -#ifdef CONFIG_ACPI
> -	acpi_status acpi_sts;
> -	struct acpi_device *adev;
> -	struct acpi_device_wakeup *wakeup;
> -
> -	adev = ACPI_COMPANION(dev);
> -	if (!adev) {
> -		dev_err(dev, "get acpi handle failed\n");
> -		return -ENODEV;
> -	}
> -	wakeup = &adev->wakeup;
> -
> -	acpi_sts = acpi_enable_gpe(wakeup->gpe_device, wakeup->gpe_number);
> -	if (ACPI_FAILURE(acpi_sts)) {
> -		dev_err(dev, "enable ose_gpe failed\n");
> -		return -EIO;
> -	}
> -
> -	return 0;
> -#else
> -	return -ENODEV;
> -#endif
> -}
> -
> -static void enable_pme_wake(struct pci_dev *pdev)
> -{
> -	if ((pci_pme_capable(pdev, PCI_D0) ||
> -	     pci_pme_capable(pdev, PCI_D3hot) ||
> -	     pci_pme_capable(pdev, PCI_D3cold)) && !enable_gpe(&pdev->dev)) {
> -		pci_pme_active(pdev, true);
> -		dev_dbg(&pdev->dev, "ish ipc driver pme wake enabled\n");
> -	}
> -}

I LOVE the removal of all this code.  Thanks for doing it!

>  /**
>   * ish_probe() - PCI driver probe callback
>   * @pdev:	pci device
> @@ -225,7 +189,7 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	/* Enable PME for EHL */
>  	if (pdev->device == EHL_Ax_DEVICE_ID)
> -		enable_pme_wake(pdev);
> +		device_init_wakeup(dev, true);
>  
>  	ret = ish_init(ishtp);
>  	if (ret)
> @@ -248,6 +212,19 @@ static void ish_remove(struct pci_dev *pdev)
>  	ish_device_disable(ishtp_dev);
>  }
>  
> +
> +/**
> + * ish_shutdown() - PCI driver shutdown callback
> + * @pdev:	pci device
> + *
> + * This function sets up wakeup for S5
> + */
> +static void ish_shutdown(struct pci_dev *pdev)
> +{
> +	if (pdev->device == EHL_Ax_DEVICE_ID)
> +		pci_prepare_to_sleep(pdev);

There are only five drivers that use pci_prepare_to_sleep(), so I have
to ask what is special about this device that makes it necessary here?

It doesn't seem to match any of the scenarios mentioned in
Documentation/power/pci.rst for using pci_prepare_to_sleep().

Previously EHL_Ax_DEVICE_ID was used only in ish_probe(),
ish_resume(), and _dma_no_cache_snooping().  None of those look like
this, so this *looks* like new functionality that could/should be in a
separate patch.

> +}
> +
>  static struct device __maybe_unused *ish_resume_device;
>  
>  /* 50ms to get resume response */
> @@ -370,13 +347,6 @@ static int __maybe_unused ish_resume(struct device *device)
>  	struct pci_dev *pdev = to_pci_dev(device);
>  	struct ishtp_device *dev = pci_get_drvdata(pdev);
>  
> -	/* add this to finish power flow for EHL */
> -	if (dev->pdev->device == EHL_Ax_DEVICE_ID) {
> -		pci_set_power_state(pdev, PCI_D0);
> -		enable_pme_wake(pdev);
> -		dev_dbg(dev->devc, "set power state to D0 for ehl\n");
> -	}
> -
>  	ish_resume_device = device;
>  	dev->resume_flag = 1;
>  
> @@ -392,6 +362,7 @@ static struct pci_driver ish_driver = {
>  	.id_table = ish_pci_tbl,
>  	.probe = ish_probe,
>  	.remove = ish_remove,
> +	.shutdown = ish_shutdown,
>  	.driver.pm = &ish_pm_ops,
>  };
>  
> -- 
> 2.34.1
> 
