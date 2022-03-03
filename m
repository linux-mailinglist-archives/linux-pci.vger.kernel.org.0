Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBC34CBD18
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 12:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiCCLtY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 06:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiCCLtW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 06:49:22 -0500
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C60C4B60;
        Thu,  3 Mar 2022 03:48:36 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2d07ae0b1c4so52079717b3.11;
        Thu, 03 Mar 2022 03:48:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hYl/mNf+w5fPQx4NW4yDU1ca51yy0LEnu1TE2GKOtJQ=;
        b=74O0gYQV5QgA2LpKEbAxu6NIpRvvUsGaY7gVP5lTggXFZiP3yCRzn2Mi1EqXMi9tRa
         7K+XOogKB+KWJUNCfgkTUghp01cST4DJ/Bir6eqYrf07kV6W4T5HPEL044v4O46GQDQo
         FiM/eyb6MPkvxhv+cYy4NzMhO7+LT6K9evp5Wt1w5rmw7ZmSf1IDrBIe/vKbvmbZeq46
         rjYB4tbrCiUSag/WPjv9a0OHEsqME0KdiG+2ITu5PfKRmpN5WyYtkDdMSOZ7u4HG3Qb7
         oXnFtzrUFO8QlzC264y8exU0u1af/dWJkTOEOfY2P+PVsXW4bjwOHKiGGJp6HaiYI+/B
         osIQ==
X-Gm-Message-State: AOAM53117xrY/42FV5qlJupG9CpMkKDZFqh/LoUnxUld2Jd8cA8bNOnr
        JxR5XnTh5fkWEiqy8onkbadAmhFZJRmw0qRMThA=
X-Google-Smtp-Source: ABdhPJzUu+VrIeTC4i61kXqLHB5KJNa5hkcJuzhvLhKW30WmAONe7VQ86Py1AQ0vvVbpEUihjiQOraVrrT7M8RMge7o=
X-Received: by 2002:a81:f008:0:b0:2d0:cd72:74e5 with SMTP id
 p8-20020a81f008000000b002d0cd7274e5mr35729505ywm.301.1646308115481; Thu, 03
 Mar 2022 03:48:35 -0800 (PST)
MIME-Version: 1.0
References: <CGME20220303094334epcas1p256f56793abe1984803caf11ef76bfc0f@epcas1p2.samsung.com>
 <20220303093907.515129-1-yj84.jang@samsung.com>
In-Reply-To: <20220303093907.515129-1-yj84.jang@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Mar 2022 12:48:24 +0100
Message-ID: <CAJZ5v0gYyarNWiERd_yf0DxmtukbsBCxX62h2TcUu5bPTn6SyA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: Add device name to suspend_report_result()
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
        <linux-usb@vger.kernel.org>, js07.lee@samsung.com,
        Todd Brandt <todd.e.brandt@linux.intel.com>
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

+Todd

On Thu, Mar 3, 2022 at 10:43 AM Youngjin Jang <yj84.jang@samsung.com> wrote:
>
> From: "Youngjin Jang" <yj84.jang@samsung.com>
>
> currently, suspend_report_result() prints only function information.
> If any driver uses common pm function, nobody knows who called
> failed function exactly.
>
> So, device is needed to recognize specific wrong driver.
>
> e.g.)
> PM: dpm_run_callback(): pm_generic_suspend+0x0/0x48 returns 0
> PM: dpm_run_callback(): platform_pm_suspend+0x0/0x68 returns 0
> after patch,
> amba 1740000.etm: dpm_run_callback(): pm_generic_suspend+0x0/0x48
> returns 0
> armv7-pmu soc:pmu: dpm_run_callback(): platform_pm_suspend+0x0/0x68
> returns 0

The PM prefix would still be useful IMO.

@Todd: Would this change affect pm-graph in any way?

>
> Signed-off-by: Youngjin Jang <yj84.jang@samsung.com>
> ---
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
> index 588588cfda48..415f7664b010 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -596,7 +596,7 @@ static int pci_legacy_suspend(struct device *dev, pm_message_t state)
>                 int error;
>
>                 error = drv->suspend(pci_dev, state);
> -               suspend_report_result(drv->suspend, error);
> +               suspend_report_result(dev, drv->suspend, error);
>                 if (error)
>                         return error;
>
> @@ -775,7 +775,7 @@ static int pci_pm_suspend(struct device *dev)
>                 int error;
>
>                 error = pm->suspend(dev);
> -               suspend_report_result(pm->suspend, error);
> +               suspend_report_result(dev, pm->suspend, error);
>                 if (error)
>                         return error;
>
> @@ -821,7 +821,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
>                 int error;
>
>                 error = pm->suspend_noirq(dev);
> -               suspend_report_result(pm->suspend_noirq, error);
> +               suspend_report_result(dev, pm->suspend_noirq, error);
>                 if (error)
>                         return error;
>
> @@ -1010,7 +1010,7 @@ static int pci_pm_freeze(struct device *dev)
>                 int error;
>
>                 error = pm->freeze(dev);
> -               suspend_report_result(pm->freeze, error);
> +               suspend_report_result(dev, pm->freeze, error);
>                 if (error)
>                         return error;
>         }
> @@ -1030,7 +1030,7 @@ static int pci_pm_freeze_noirq(struct device *dev)
>                 int error;
>
>                 error = pm->freeze_noirq(dev);
> -               suspend_report_result(pm->freeze_noirq, error);
> +               suspend_report_result(dev, pm->freeze_noirq, error);
>                 if (error)
>                         return error;
>         }
> @@ -1116,7 +1116,7 @@ static int pci_pm_poweroff(struct device *dev)
>                 int error;
>
>                 error = pm->poweroff(dev);
> -               suspend_report_result(pm->poweroff, error);
> +               suspend_report_result(dev, pm->poweroff, error);
>                 if (error)
>                         return error;
>         }
> @@ -1154,7 +1154,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
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
> index d630cccd2e6e..dd44e37a454a 100644
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
> index e1e9402180b9..cdccbb9cef2c 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -745,11 +745,11 @@ extern int dpm_suspend_late(pm_message_t state);
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
> @@ -789,7 +789,7 @@ static inline int dpm_suspend_start(pm_message_t state)
>         return 0;
>  }
>
> -#define suspend_report_result(fn, ret)         do {} while (0)
> +#define suspend_report_result(dev, fn, ret)    do {} while (0)
>
>  static inline int device_pm_wait_for_dev(struct device *a, struct device *b)
>  {
> --
> 2.25.1
>
