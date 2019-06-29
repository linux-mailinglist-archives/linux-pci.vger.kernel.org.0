Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 992855AA79
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2019 13:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfF2Leu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Jun 2019 07:34:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34751 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfF2Let (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Jun 2019 07:34:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id s49so15469147edb.1
        for <linux-pci@vger.kernel.org>; Sat, 29 Jun 2019 04:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bOVwKJVcD24JyJ3gwPHu19lm5eeEw58EUJsKySuLKtc=;
        b=fjMe9NK5QCcnScDxY2DRhsMhV16ff351L2Johu74YVGMzQLiwXe2aIZs9ipgso8c1Z
         KKe5OGe5PMMAppWmkj6km4bnuX0qmQ4yDxVqzicMCTQU/kAJXRZwXK6dpZ6dV4BoKDPc
         BMnX+qkFOkp/4WqH5A6rKtiTlaytGB0u7zLJZ8EwkSdTZsrNrBMwXA1jSCbye+OGdrz+
         hf3QHuTe5AgfDsykndvuLeqtwBJz1ENOw8OyjGUisVxtGVulXFkXJtDjPd5WFzlYMQtU
         Y5GaWGhhQZFjL1eegntYe1liXj/UcSfJdpbZmokTaGzF2hItWIC6atbw7qMpLJZgmfIv
         lyrQ==
X-Gm-Message-State: APjAAAWpwnpuCKyq2K1nJsAB+zMsKm9pzrvNmjaxQaQ2XpHYNgUzqEPs
        RNFBK76Daf7sEArnL1zspbacxg==
X-Google-Smtp-Source: APXvYqxAPfMcjNqUpnxVQkI+3WN7lHsXqQ9kgqPzyKlYbM+MO2sBMXGK/SCcixo6G7Rn8btmkGKbBg==
X-Received: by 2002:a50:86dc:: with SMTP id 28mr17140260edu.132.1561808087580;
        Sat, 29 Jun 2019 04:34:47 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id e3sm284872ejl.29.2019.06.29.04.34.46
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 04:34:46 -0700 (PDT)
Subject: Re: [PATCH 4/6] ACPI: LPSS: Fix ->suspend_late callbacks handling
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Robert R. Howell" <RHowell@uwyo.edu>
References: <2318839.0szTqvJMZa@kreacher> <2981101.tKVHzisTAg@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c41b5efe-049c-fc72-8697-b2ec9125a55e@redhat.com>
Date:   Sat, 29 Jun 2019 13:34:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2981101.tKVHzisTAg@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rafael,

On 29-06-19 11:50, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the resume_from_noirq flag is set in dev_desc, the ->suspend_late
> callback provided by the device driver will be invoked at the "noirq"
> stage of system suspend, via acpi_lpss_do_suspend_late(), which is
> incorrect.
> 
> To fix that, drop acpi_lpss_do_suspend_late() and rearrange
> acpi_lpss_suspend_late() to call pm_generic_suspend_late()
> directly, before calling acpi_lpss_suspend(), in analogy with
> acpi_subsys_suspend_late().

Ah now I see the logic in your previous test-patch.

I'm afraid that this is going to break things though, the calling
of the device-driver's suspend-late method at noirq time is
*intentional* !

The resume_from_noirq flag is only set for i2c controllers which
use: drivers/i2c/busses/i2c-designware-platdrv.c as driver.

This driver's suspend late method looks like this:

static int dw_i2c_plat_suspend(struct device *dev)
{
         struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);

         i_dev->suspended = true;

         if (i_dev->shared_with_punit)
                 return 0;

         i_dev->disable(i_dev);
         i2c_dw_prepare_clk(i_dev, false);

         return 0;
}

The i_dev->disable(i_dev) and i2c_dw_prepare_clk(i_dev, false) calls here
will make the i2c controller non functional. But (some of) these i2c
controllers are used by code in the _PS0  / _PS3 methods of some PCI
devices and the PCI core calls _PS0 / _PS3 at *noirq* time, so as explained
in the commit message which introduced acpi_lpss_do_suspend_late():
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=48402cee6889fb3fce58e95fea1471626286dc63

We must not only make sure that the suspending of the i2c controller is
ordered so that it happens after these PCI devices are suspended, we must
also make sure that the i2c controller stays functional until the
i2c-controller is put in the suspend-noirq state.

If you really want to go this route, we must duplicate the resume_from_noirq
flag inside drivers/i2c/busses/i2c-designware-platdrv.c, setting it
only for acpi_lpss enumerated devices (the driver handles a whole lot more
devices) ans then make the driver's suspend_late method a no-op and instead
to the suspend from its suspend_noirq callback.

Since pm_generic_suspend_late() is just a wrapper to call dev->driver->pm->suspend_late
duplicating the resume_from_noirq flag inside i2c-designware-platdrv.c seems
unproductive.

Note that we have the same thing going on in acpi_lpss.c with resume_early vs
resume_noirq, we call the resume_early callback from acpi_lpss_resume_noirq
if the resume_from_noirq flag is set.

TL;DR: the behavior you are trying to fix here is intentional and
IMHO this patch should be dropped.

I guess we could / should do a patch adding a comment that the calling
the drivers' suspend_late / resume_early callback at noirq time is intentional
to avoid this confusing people in the future.

###

Patches 1-3 and 6 look good to me and you may add my:
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
to those.

The comments from this patch also impact patch 5 "ACPI: PM: Introduce "poweroff" callbacks for ACPI PM domain and LPSS"
that should be rewritten to call the device's poweroff_late method at noirq
time if the resume_from_noirq flag is set.

I wonder if patch 5 is necessary though, the acpi_lpss code only deals with a small set
of devices, at least i2c-designware-platdrv.c uses SET_LATE_SYSTEM_SLEEP_PM_OPS so the
poweroff and suspend methods are 1 and the same. If this is true for all involved drivers
(I did not check) then patch 5 is not really necessary.

I guess if fixed to deal with resume_from_noirq the same way the suspend methods
do this patch cannot hurt and if we every add separate power_off methods to the
device drivers later we need this.

Regards,

Hans




> Also notice that acpi_subsys_suspend_late() is not used outside
> of the file where it is defined, so make it static and drop its
> header for the header file containing it.
> 
> Fixes: 48402cee6889 (ACPI / LPSS: Resume BYT/CHT I2C controllers from resume_noirq)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/acpi_lpss.c |   23 ++++++++++-------------
>   drivers/acpi/device_pm.c |    3 +--
>   include/linux/acpi.h     |    2 --
>   3 files changed, 11 insertions(+), 17 deletions(-)
> 
> Index: linux-pm/drivers/acpi/acpi_lpss.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpi_lpss.c
> +++ linux-pm/drivers/acpi/acpi_lpss.c
> @@ -1034,34 +1034,31 @@ static int acpi_lpss_resume(struct devic
>   }
>   
>   #ifdef CONFIG_PM_SLEEP
> -static int acpi_lpss_do_suspend_late(struct device *dev)
> +static int acpi_lpss_suspend_late(struct device *dev)
>   {
> +	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
>   	int ret;
>   
>   	if (dev_pm_smart_suspend_and_suspended(dev))
>   		return 0;
>   
>   	ret = pm_generic_suspend_late(dev);
> -	return ret ? ret : acpi_lpss_suspend(dev, device_may_wakeup(dev));
> -}
> +	if (ret)
> +		return ret;
>   
> -static int acpi_lpss_suspend_late(struct device *dev)
> -{
> -	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
> -
> -	if (pdata->dev_desc->resume_from_noirq)
> -		return 0;
> +	if (!pdata->dev_desc->resume_from_noirq)
> +		return acpi_lpss_suspend(dev, device_may_wakeup(dev));
>   
> -	return acpi_lpss_do_suspend_late(dev);
> +	return 0;
>   }
>   
>   static int acpi_lpss_suspend_noirq(struct device *dev)
>   {
>   	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
> -	int ret;
>   
> -	if (pdata->dev_desc->resume_from_noirq) {
> -		ret = acpi_lpss_do_suspend_late(dev);
> +	if (!dev_pm_smart_suspend_and_suspended(dev) &&
> +	    pdata->dev_desc->resume_from_noirq) {
> +		int ret = acpi_lpss_suspend(dev, device_may_wakeup(dev));
>   		if (ret)
>   			return ret;
>   	}
> Index: linux-pm/drivers/acpi/device_pm.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/device_pm.c
> +++ linux-pm/drivers/acpi/device_pm.c
> @@ -1069,7 +1069,7 @@ EXPORT_SYMBOL_GPL(acpi_subsys_suspend);
>    * Carry out the generic late suspend procedure for @dev and use ACPI to put
>    * it into a low-power state during system transition into a sleep state.
>    */
> -int acpi_subsys_suspend_late(struct device *dev)
> +static int acpi_subsys_suspend_late(struct device *dev)
>   {
>   	int ret;
>   
> @@ -1079,7 +1079,6 @@ int acpi_subsys_suspend_late(struct devi
>   	ret = pm_generic_suspend_late(dev);
>   	return ret ? ret : acpi_dev_suspend(dev, device_may_wakeup(dev));
>   }
> -EXPORT_SYMBOL_GPL(acpi_subsys_suspend_late);
>   
>   /**
>    * acpi_subsys_suspend_noirq - Run the device driver's "noirq" suspend callback.
> Index: linux-pm/include/linux/acpi.h
> ===================================================================
> --- linux-pm.orig/include/linux/acpi.h
> +++ linux-pm/include/linux/acpi.h
> @@ -916,7 +916,6 @@ static inline int acpi_dev_pm_attach(str
>   int acpi_dev_suspend_late(struct device *dev);
>   int acpi_subsys_prepare(struct device *dev);
>   void acpi_subsys_complete(struct device *dev);
> -int acpi_subsys_suspend_late(struct device *dev);
>   int acpi_subsys_suspend_noirq(struct device *dev);
>   int acpi_subsys_suspend(struct device *dev);
>   int acpi_subsys_freeze(struct device *dev);
> @@ -924,7 +923,6 @@ int acpi_subsys_freeze(struct device *de
>   static inline int acpi_dev_resume_early(struct device *dev) { return 0; }
>   static inline int acpi_subsys_prepare(struct device *dev) { return 0; }
>   static inline void acpi_subsys_complete(struct device *dev) {}
> -static inline int acpi_subsys_suspend_late(struct device *dev) { return 0; }
>   static inline int acpi_subsys_suspend_noirq(struct device *dev) { return 0; }
>   static inline int acpi_subsys_suspend(struct device *dev) { return 0; }
>   static inline int acpi_subsys_freeze(struct device *dev) { return 0; }
> 
> 
> 
> 
