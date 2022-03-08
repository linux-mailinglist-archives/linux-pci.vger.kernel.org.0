Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A25C4D20D4
	for <lists+linux-pci@lfdr.de>; Tue,  8 Mar 2022 20:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344847AbiCHTB6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Mar 2022 14:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245656AbiCHTB6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Mar 2022 14:01:58 -0500
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93311C92A;
        Tue,  8 Mar 2022 11:01:00 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id u61so39675397ybi.11;
        Tue, 08 Mar 2022 11:01:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0oaRF+2jtSH5e366hIY41lYOEykMsMYfwzxuymEf7WI=;
        b=GDskdiJeoR800Db8KFcVnDZEICBRyNDJZMncV8Hl4YZayTTqmkHZY4zliAyS+GU3pU
         Q0GNiHST5ivOieiekef9FmByGW6EJzmyZjYpSATf/KImgDqCzGPGNBKW9ZC8OEN+w2eV
         FvFHX5xcwqnVn4LH8jLAPODyFWxru/8Lv6spUw3xCXuIDoHqp1H2iYL5OUjUA8CNjmAD
         Z0Ogc0GrgcWkIInfnbrZCW2TSbS8cQTITNtWeyUM49mQ9A7VzJbMItuYAZj/jL8w+f93
         slXEM316eHm087ryqhXhWJt0MiRqIeHg8M2yyFUd6oVRpLHKz0AS54h4F+sBRFCcPDIu
         kh8g==
X-Gm-Message-State: AOAM531AKJJsfDshxU7gR6rVGtlVon3ruKV1y6e4SOtNuqRNBYHw5MkA
        FKTblUTSQxrW2Yy5rhbWDtloo8/TI3Prtq8x15U=
X-Google-Smtp-Source: ABdhPJwqUjHyO1CqvKF5O4a8CsMYw7VMzDiXPK9Roc8x+67VaP3fclGs2XQAWtlYxXLKfQqp2SwlCUmz0MRIJI1mR4w=
X-Received: by 2002:a25:fe10:0:b0:625:262f:e792 with SMTP id
 k16-20020a25fe10000000b00625262fe792mr12845747ybe.365.1646766060001; Tue, 08
 Mar 2022 11:01:00 -0800 (PST)
MIME-Version: 1.0
References: <CGME20220308104013epcas1p4c096ed0065700f2f1f8b5ea1ae4ed994@epcas1p4.samsung.com>
 <20220307190739.659955-1-yj84.jang@samsung.com>
In-Reply-To: <20220307190739.659955-1-yj84.jang@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Mar 2022 20:00:48 +0100
Message-ID: <CAJZ5v0jtSHyqR9HFcKxi_Ze-0UD9X_nkFy6xJiZfgqieZmTRbQ@mail.gmail.com>
Subject: Re: [PATCH v3] PM: Add device name to suspend_report_result()
To:     Youngjin Jang <yj84.jang@samsung.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        js07.lee@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 8, 2022 at 11:40 AM Youngjin Jang <yj84.jang@samsung.com> wrote:
>
> currently, suspend_report_result() prints only function information.
> If any driver uses common pm function, nobody knows who called
> failed function exactly.
>
> So, device is needed to recognize specific wrong driver.
>
> e.g.)
> PM: dpm_run_callback(): pnp_bus_suspend+0x0/0x10 returns 0
> PM: dpm_run_callback(): pci_pm_suspend+0x0/0x150 returns 0
> after patch,
> serial 00:05: PM: dpm_run_callback(): pnp_bus_suspend+0x0/0x10 returns 0
> pci 0000:00:01.3: PM: dpm_run_callback(): pci_pm_suspend+0x0/0x150 returns 0
>
> Signed-off-by: Youngjin Jang <yj84.jang@samsung.com>
> ---
> Changes since v2:
>  - Update commit message, example logs
> Changes since v1:
>  - Use dev_err() to print out device name
>  - Use real name on email sender
>
>  drivers/base/power/main.c  | 10 +++++-----
>  drivers/pci/pci-driver.c   | 14 +++++++-------
>  drivers/pnp/driver.c       |  2 +-
>  drivers/usb/core/hcd-pci.c |  4 ++--
>  include/linux/pm.h         |  8 ++++----
>  5 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 04ea92cbd9cf..41e17b8c2c20 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -485,7 +485,7 @@ static int dpm_run_callback(pm_callback_t cb, struct device *dev,
>         trace_device_pm_callback_start(dev, info, state.event);
>         error = cb(dev);
>         trace_device_pm_callback_end(dev, error);
> -       suspend_report_result(cb, error);
> +       suspend_report_result(dev, cb, error);
>
>         initcall_debug_report(dev, calltime, cb, error);
>
> @@ -1568,7 +1568,7 @@ static int legacy_suspend(struct device *dev, pm_message_t state,
>         trace_device_pm_callback_start(dev, info, state.event);
>         error = cb(dev, state);
>         trace_device_pm_callback_end(dev, error);
> -       suspend_report_result(cb, error);
> +       suspend_report_result(dev, cb, error);
>
>         initcall_debug_report(dev, calltime, cb, error);
>
> @@ -1855,7 +1855,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
>         device_unlock(dev);
>
>         if (ret < 0) {
> -               suspend_report_result(callback, ret);
> +               suspend_report_result(dev, callback, ret);
>                 pm_runtime_put(dev);
>                 return ret;
>         }
> @@ -1960,10 +1960,10 @@ int dpm_suspend_start(pm_message_t state)
>  }
>  EXPORT_SYMBOL_GPL(dpm_suspend_start);
>
> -void __suspend_report_result(const char *function, void *fn, int ret)
> +void __suspend_report_result(const char *function, struct device *dev, void *fn, int ret)
>  {
>         if (ret)
> -               pr_err("%s(): %pS returns %d\n", function, fn, ret);
> +               dev_err(dev, "%s(): %pS returns %d\n", function, fn, ret);
>  }
>  EXPORT_SYMBOL_GPL(__suspend_report_result);
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f61c40a47891..4ceeb75fc899 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -607,7 +607,7 @@ static int pci_legacy_suspend(struct device *dev, pm_message_t state)
>                 int error;
>
>                 error = drv->suspend(pci_dev, state);
> -               suspend_report_result(drv->suspend, error);
> +               suspend_report_result(dev, drv->suspend, error);
>                 if (error)
>                         return error;
>
> @@ -786,7 +786,7 @@ static int pci_pm_suspend(struct device *dev)
>                 int error;
>
>                 error = pm->suspend(dev);
> -               suspend_report_result(pm->suspend, error);
> +               suspend_report_result(dev, pm->suspend, error);
>                 if (error)
>                         return error;
>
> @@ -832,7 +832,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
>                 int error;
>
>                 error = pm->suspend_noirq(dev);
> -               suspend_report_result(pm->suspend_noirq, error);
> +               suspend_report_result(dev, pm->suspend_noirq, error);
>                 if (error)
>                         return error;
>
> @@ -1021,7 +1021,7 @@ static int pci_pm_freeze(struct device *dev)
>                 int error;
>
>                 error = pm->freeze(dev);
> -               suspend_report_result(pm->freeze, error);
> +               suspend_report_result(dev, pm->freeze, error);
>                 if (error)
>                         return error;
>         }
> @@ -1041,7 +1041,7 @@ static int pci_pm_freeze_noirq(struct device *dev)
>                 int error;
>
>                 error = pm->freeze_noirq(dev);
> -               suspend_report_result(pm->freeze_noirq, error);
> +               suspend_report_result(dev, pm->freeze_noirq, error);
>                 if (error)
>                         return error;
>         }
> @@ -1127,7 +1127,7 @@ static int pci_pm_poweroff(struct device *dev)
>                 int error;
>
>                 error = pm->poweroff(dev);
> -               suspend_report_result(pm->poweroff, error);
> +               suspend_report_result(dev, pm->poweroff, error);
>                 if (error)
>                         return error;
>         }
> @@ -1165,7 +1165,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
>                 int error;
>
>                 error = pm->poweroff_noirq(dev);
> -               suspend_report_result(pm->poweroff_noirq, error);
> +               suspend_report_result(dev, pm->poweroff_noirq, error);
>                 if (error)
>                         return error;
>         }
> diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
> index cc6757dfa3f1..c02e7bf643a6 100644
> --- a/drivers/pnp/driver.c
> +++ b/drivers/pnp/driver.c
> @@ -171,7 +171,7 @@ static int __pnp_bus_suspend(struct device *dev, pm_message_t state)
>
>         if (pnp_drv->driver.pm && pnp_drv->driver.pm->suspend) {
>                 error = pnp_drv->driver.pm->suspend(dev);
> -               suspend_report_result(pnp_drv->driver.pm->suspend, error);
> +               suspend_report_result(dev, pnp_drv->driver.pm->suspend, error);
>                 if (error)
>                         return error;
>         }
> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
> index 784466117c92..8176bc81a635 100644
> --- a/drivers/usb/core/hcd-pci.c
> +++ b/drivers/usb/core/hcd-pci.c
> @@ -446,7 +446,7 @@ static int suspend_common(struct device *dev, bool do_wakeup)
>                                 HCD_WAKEUP_PENDING(hcd->shared_hcd))
>                         return -EBUSY;
>                 retval = hcd->driver->pci_suspend(hcd, do_wakeup);
> -               suspend_report_result(hcd->driver->pci_suspend, retval);
> +               suspend_report_result(dev, hcd->driver->pci_suspend, retval);
>
>                 /* Check again in case wakeup raced with pci_suspend */
>                 if ((retval == 0 && do_wakeup && HCD_WAKEUP_PENDING(hcd)) ||
> @@ -556,7 +556,7 @@ static int hcd_pci_suspend_noirq(struct device *dev)
>                 dev_dbg(dev, "--> PCI %s\n",
>                                 pci_power_name(pci_dev->current_state));
>         } else {
> -               suspend_report_result(pci_prepare_to_sleep, retval);
> +               suspend_report_result(dev, pci_prepare_to_sleep, retval);
>                 return retval;
>         }
>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index f7d2be686359..e65b3ab28377 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -770,11 +770,11 @@ extern int dpm_suspend_late(pm_message_t state);
>  extern int dpm_suspend(pm_message_t state);
>  extern int dpm_prepare(pm_message_t state);
>
> -extern void __suspend_report_result(const char *function, void *fn, int ret);
> +extern void __suspend_report_result(const char *function, struct device *dev, void *fn, int ret);
>
> -#define suspend_report_result(fn, ret)                                 \
> +#define suspend_report_result(dev, fn, ret)                            \
>         do {                                                            \
> -               __suspend_report_result(__func__, fn, ret);             \
> +               __suspend_report_result(__func__, dev, fn, ret);        \
>         } while (0)
>
>  extern int device_pm_wait_for_dev(struct device *sub, struct device *dev);
> @@ -814,7 +814,7 @@ static inline int dpm_suspend_start(pm_message_t state)
>         return 0;
>  }
>
> -#define suspend_report_result(fn, ret)         do {} while (0)
> +#define suspend_report_result(dev, fn, ret)    do {} while (0)
>
>  static inline int device_pm_wait_for_dev(struct device *a, struct device *b)
>  {
> --

Applied as 5.18 material, thanks!
