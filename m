Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4C855460
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 18:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfFYQX6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 12:23:58 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34545 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfFYQX6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2019 12:23:58 -0400
Received: by mail-ot1-f68.google.com with SMTP id n5so17900452otk.1;
        Tue, 25 Jun 2019 09:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uSdP7UKm4WLYMLtVhLBpxY7TViBn/YrfzYDpWCwidcM=;
        b=OdxwhvVfCoFbWlhpErwJ6LSoeICrOtJDh2BwBvXnXQ6ym/4LJjiA1qZIea5W9Ocr68
         +BxTfPRrtakB3Tv3PxX1hn+j+5YVofz3HqXwaQDcPj9zw1bg0SHlsKkNS8GV4kow+H+k
         IlnqekOg9pnuUlaOjcL2W8aE/nj5zjxONN164S+Qr7o+52lKBAOYYLFgitMYkZu0aQPr
         6XGN/dVr5x/ZmrTtHWnqCNylNe0RPGD+oVEFPqKl81fJSZubupoTH9/xoGb1VmUq4ukQ
         LA9s1wT7l/vQ671RcQObMZlUrJsbaNMW97GNIl1z/8sSLOlyvU3Y3zQmlengrzaLsOzy
         w7PQ==
X-Gm-Message-State: APjAAAULED1QGrGgh+URAy6uDokucNmUovjg3g0O+KrI9hz0LyqM4QwU
        X3Jgas6JNFMJ1MlBaHEke+2jAYUwTqe4RvNbkI8=
X-Google-Smtp-Source: APXvYqwwUsY5xStaihgCfS3kxVuGmJgr1opwxgHBqNXcDzYTr9GEsLR5kWCakYY4KXAsFNz25LejwnwxCvkAc/7My14=
X-Received: by 2002:a05:6830:8a:: with SMTP id a10mr5881905oto.167.1561479837395;
 Tue, 25 Jun 2019 09:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <1668247.RaJIPSxJUN@kreacher> <CAJZ5v0hdtXqoK84DpYtyMSCnkR9zOHFiUPAzWZDtkFmEjyWD1g@mail.gmail.com>
 <CAJZ5v0gGdXmgc_9r2rbiadq4e31hngpjYQ40QoC6C0z19da_hQ@mail.gmail.com> <2287147.DxjcvLeq6l@kreacher>
In-Reply-To: <2287147.DxjcvLeq6l@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Jun 2019 18:23:46 +0200
Message-ID: <CAJZ5v0gU9OedmZBNDGefG3GjS7FHRmgQ67eOcr2vXRrAg3zZbg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: PM: Skip devices in D0 for suspend-to-idle
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 25, 2019 at 1:09 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, June 25, 2019 12:20:26 AM CEST Rafael J. Wysocki wrote:
> > On Mon, Jun 24, 2019 at 11:37 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Mon, Jun 24, 2019 at 2:43 PM Jon Hunter <jonathanh@nvidia.com> wrote:
> > > >
> > > > Hi Rafael,
> > > >
> > > > On 13/06/2019 22:59, Rafael J. Wysocki wrote:
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > Commit d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
> > > > > attempted to avoid a problem with devices whose drivers want them to
> > > > > stay in D0 over suspend-to-idle and resume, but it did not go as far
> > > > > as it should with that.
> > > > >
> > > > > Namely, first of all, the power state of a PCI bridge with a
> > > > > downstream device in D0 must be D0 (based on the PCI PM spec r1.2,
> > > > > sec 6, table 6-1, if the bridge is not in D0, there can be no PCI
> > > > > transactions on its secondary bus), but that is not actively enforced
> > > > > during system-wide PM transitions, so use the skip_bus_pm flag
> > > > > introduced by commit d491f2b75237 for that.
> > > > >
> > > > > Second, the configuration of devices left in D0 (whatever the reason)
> > > > > during suspend-to-idle need not be changed and attempting to put them
> > > > > into D0 again by force is pointless, so explicitly avoid doing that.
> > > > >
> > > > > Fixes: d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
> > > > > Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > >
> > > > I have noticed a regression in both the mainline and -next branches on
> > > > one of our boards when testing suspend. The bisect is point to this
> > > > commit and reverting on top of mainline does fix the problem. So far I
> > > > have not looked at this in close detail but kernel log is showing ...
> > >
> > > Can you please collect a log like that, but with dynamic debug in
> > > pci-driver.c enabled?
> > >
> > > Note that reverting this commit is rather out of the question, so we
> > > need to get to the bottom of the failure.
> >
> > I suspect that there is a problem with the pm_suspend_via_firmware()
> > check which returns 'false' on the affected board, but the platform
> > actually removes power from devices left in D0 during suspend.
> >
> > I guess it would be more appropriate to check something like
> > pm_suspend_no_platform() which would return 'true' in the
> > suspend-to-idle patch w/ ACPI.
>
> So I wonder if the patch below makes any difference?

Mika, can you please test this one in combination with the other
changes we've been working on?

I really don't expect to see problems, but just to be sure ...

> ---
>  drivers/pci/pci-driver.c |    8 ++++----
>  include/linux/suspend.h  |   26 ++++++++++++++++++++++++--
>  kernel/power/suspend.c   |    3 +++
>  3 files changed, 31 insertions(+), 6 deletions(-)
>
> Index: linux-pm/include/linux/suspend.h
> ===================================================================
> --- linux-pm.orig/include/linux/suspend.h
> +++ linux-pm/include/linux/suspend.h
> @@ -209,8 +209,9 @@ extern int suspend_valid_only_mem(suspen
>
>  extern unsigned int pm_suspend_global_flags;
>
> -#define PM_SUSPEND_FLAG_FW_SUSPEND     (1 << 0)
> -#define PM_SUSPEND_FLAG_FW_RESUME      (1 << 1)
> +#define PM_SUSPEND_FLAG_FW_SUSPEND     BIT(0)
> +#define PM_SUSPEND_FLAG_FW_RESUME      BIT(1)
> +#define PM_SUSPEND_FLAG_NO_PLATFORM    BIT(2)
>
>  static inline void pm_suspend_clear_flags(void)
>  {
> @@ -227,6 +228,11 @@ static inline void pm_set_resume_via_fir
>         pm_suspend_global_flags |= PM_SUSPEND_FLAG_FW_RESUME;
>  }
>
> +static inline void pm_set_suspend_no_platform(void)
> +{
> +       pm_suspend_global_flags |= PM_SUSPEND_FLAG_NO_PLATFORM;
> +}
> +
>  /**
>   * pm_suspend_via_firmware - Check if platform firmware will suspend the system.
>   *
> @@ -268,6 +274,22 @@ static inline bool pm_resume_via_firmwar
>         return !!(pm_suspend_global_flags & PM_SUSPEND_FLAG_FW_RESUME);
>  }
>
> +/**
> + * pm_suspend_no_platform - Check if platform may change device power states.
> + *
> + * To be called during system-wide power management transitions to sleep states
> + * or during the subsequent system-wide transitions back to the working state.
> + *
> + * Return 'true' if the power states of devices remain under full control of the
> + * kernel throughout the system-wide suspend and resume cycle in progress (that
> + * is, if a device is put into a certain power state during suspend, it can be
> + * expected to remain in that state during resume).
> + */
> +static inline bool pm_suspend_no_platform(void)
> +{
> +       return !!(pm_suspend_global_flags & PM_SUSPEND_FLAG_NO_PLATFORM);
> +}
> +
>  /* Suspend-to-idle state machnine. */
>  enum s2idle_states {
>         S2IDLE_STATE_NONE,      /* Not suspended/suspending. */
> Index: linux-pm/kernel/power/suspend.c
> ===================================================================
> --- linux-pm.orig/kernel/power/suspend.c
> +++ linux-pm/kernel/power/suspend.c
> @@ -493,6 +493,9 @@ int suspend_devices_and_enter(suspend_st
>
>         pm_suspend_target_state = state;
>
> +       if (state == PM_SUSPEND_TO_IDLE)
> +               pm_set_suspend_no_platform();
> +
>         error = platform_suspend_begin(state);
>         if (error)
>                 goto Close;
> Index: linux-pm/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-driver.c
> +++ linux-pm/drivers/pci/pci-driver.c
> @@ -870,7 +870,7 @@ static int pci_pm_suspend_noirq(struct d
>                         pci_dev->bus->self->skip_bus_pm = true;
>         }
>
> -       if (pci_dev->skip_bus_pm && !pm_suspend_via_firmware()) {
> +       if (pci_dev->skip_bus_pm && pm_suspend_no_platform()) {
>                 dev_dbg(dev, "PCI PM: Skipped\n");
>                 goto Fixup;
>         }
> @@ -925,10 +925,10 @@ static int pci_pm_resume_noirq(struct de
>         /*
>          * In the suspend-to-idle case, devices left in D0 during suspend will
>          * stay in D0, so it is not necessary to restore or update their
> -        * configuration here and attempting to put them into D0 again may
> -        * confuse some firmware, so avoid doing that.
> +        * configuration here and attempting to put them into D0 again is
> +        * pointless, so avoid doing that.
>          */
> -       if (!pci_dev->skip_bus_pm || pm_suspend_via_firmware())
> +       if (!(pci_dev->skip_bus_pm && pm_suspend_no_platform()))
>                 pci_pm_default_resume_early(pci_dev);
>
>         pci_fixup_device(pci_fixup_resume_early, pci_dev);
>
>
>
