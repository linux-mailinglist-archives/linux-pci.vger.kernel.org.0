Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFD55ABFF3
	for <lists+linux-pci@lfdr.de>; Sat,  3 Sep 2022 19:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiICREC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Sep 2022 13:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiICREB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Sep 2022 13:04:01 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79624DF2A;
        Sat,  3 Sep 2022 10:03:59 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-33dc31f25f9so40302177b3.11;
        Sat, 03 Sep 2022 10:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JgSQJQrFl0rSiXz9IMqGp2Wpf0/dqAi3JjYTCVyHmUQ=;
        b=sj5tupm/U2K99MCeNnIpLxU9a5HruEzY8WAKBoshlC3iMN28aFKBu0sN1+deCyMrBl
         BYDMjWaOgIg39kBHtn0O0mDKqS/oI2ryAgybsPaKwYSVhDDygr9qKrDLedAo9zEnVTQ+
         Jn2nYFdcEgIPqeZHmq+JzSL77Q+jTAaCWwTeBmR7T51hJ6kb4At9YIH5GeK5Xdrfs6ny
         DlOmIYLD61OackXFq6iKdxhL4NAASoM2x0Od0lqNsT5lZblhifpkf4AepZfG8x+0xtA7
         af6UG1YH4ZoGyCXj3AuBP9z+CF4ppbpqN4Vd+eBVNcY/3c8xOvD/d4VDXakaQtCb+ETG
         kLhg==
X-Gm-Message-State: ACgBeo1EWqtwEx5lt8UgVv8JkKS79sC3BXV4fHjZRQ1hpoq6L1SmrnCu
        ZIhwpBopaXOWaKQm04qFzZoTCeZlNe1SstYs0EY=
X-Google-Smtp-Source: AA6agR7EXLzv1zu3fvIr/maPTZ5i4xfOjZGbNLwkQPzIqRxev0XP+/UekAGp3HKPSula8b7kHPuD7iacZmS+s9KdZs4=
X-Received: by 2002:a0d:df92:0:b0:340:b90d:fb75 with SMTP id
 i140-20020a0ddf92000000b00340b90dfb75mr31334425ywe.149.1662224638934; Sat, 03
 Sep 2022 10:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0jdFPauNKurpXFdCJBtsXavvLzV9fu02divz61hE_STbQ@mail.gmail.com>
 <20220901212631.GA250789@bhelgaas>
In-Reply-To: <20220901212631.GA250789@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 3 Sep 2022 19:03:47 +0200
Message-ID: <CAJZ5v0guiJ7JzN1gzhuBQxxELHUPyNaHUmTpE99yCqSRgE1gqg@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 2/2] PCI/PTM: fix to maintain pci_dev->ptm_enabled
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Box <david.e.box@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
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

On Thu, Sep 1, 2022 at 11:26 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Aug 31, 2022 at 07:53:05PM +0200, Rafael J. Wysocki wrote:
> > ...
>
> > In the meantime, I recalled that nvme wanted to leave the device in D0
> > and program it into an internal low-power state in some cases which
> > would be disturbed by disabling PTM later on (a config space write
> > would kick the device out of the internal low-power state).
> >
> > So it looks like it would be better to disable PTM as the first thing
> > in pci_pm_suspend() before calling the driver's suspend callback
> > (which may be nvme suspend),
>
> Yes, I was thinking the same thing.  There's no reason we need to wait
> until interrupts are disabled to disable PTM.
>
> > but then we'd need to save the original PTM status and restore it
> > during the subsequent resume.  That could be done as early as in
> > pci_pm_resume_noirq(), but I think the cleanest way would be to add
> > a new bit to struct pci_device for that.
>
> > Alternatively, we can drop the $subject patch, so ptm_enabled still
> > only means that it has been enabled during enumeration and it can be
> > used to restore the original PTM status during resume.
>
> I like this second idea of dropping this "PCI/PTM: fix to maintain
> pci_dev->ptm_enabled" patch and using "dev->ptm_enabled" to set the
> PTM Enable bit on restore, as in the patches below.  Then we don't
> need to do anything explicit to re-enable PTM.
>
> If this makes sense, I'll add a few cleanups on top and post as a
> formal series.

It does to me.

Thanks for taking care of this!

> commit 73690aa361a7 ("PCI/PM: Always disable PTM for all devices during suspend")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu Sep 1 16:14:45 2022 -0500
>
>     PCI/PM: Always disable PTM for all devices during suspend
>
>     We want to disable PTM on Root Ports because that allows some chips, e.g.,
>     Intel mobile chips since Coffee Lake, to enter a lower-power PM state.
>
>     That means we also have to disable PTM on downstream devices because PCIe
>     r6.0, sec 2.2.8, strongly recommends that functions support generation of
>     messages in non-D0 states, so we assume Switch Upstream Ports or Endpoints
>     may send PTM Requests while in D1, D2, and D3hot.  A PTM message received
>     by a Downstream Port (including a Root Port) with PTM disabled must be
>     treated as an Unsupported Request (sec 6.21.3).
>
>     PTM was previously disabled only for Root Ports, and it was disabled in
>     pci_prepare_to_sleep(), which is not called at all if a driver supports
>     legacy PM or does its own state saving.
>
>     Instead, disable PTM early in pci_pm_suspend() and pci_pm_runtime_suspend()
>     so we do it in all cases.
>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 2815922ac525..f07399a94807 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -772,6 +772,12 @@ static int pci_pm_suspend(struct device *dev)
>         struct pci_dev *pci_dev = to_pci_dev(dev);
>         const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>
> +       /*
> +        * Disabling PTM allows some systems, e.g., Intel mobile chips
> +        * since Coffee Lake, to enter a lower-power PM state.
> +        */
> +       pci_disable_ptm(pci_dev);
> +
>         pci_dev->skip_bus_pm = false;
>
>         if (pci_has_legacy_pm_support(pci_dev))
> @@ -1269,6 +1275,8 @@ static int pci_pm_runtime_suspend(struct device *dev)
>         pci_power_t prev = pci_dev->current_state;
>         int error;
>
> +       pci_disable_ptm(pci_dev);
> +
>         /*
>          * If pci_dev->driver is not set (unbound), we leave the device in D0,
>          * but it may go to D3cold when the bridge above it runtime suspends.
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 95bc329e74c0..b0e2968c8cca 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2706,16 +2706,6 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
>         if (target_state == PCI_POWER_ERROR)
>                 return -EIO;
>
> -       /*
> -        * There are systems (for example, Intel mobile chips since Coffee
> -        * Lake) where the power drawn while suspended can be significantly
> -        * reduced by disabling PTM on PCIe root ports as this allows the
> -        * port to enter a lower-power PM state and the SoC to reach a
> -        * lower-power idle state as a whole.
> -        */
> -       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> -               pci_disable_ptm(dev);
> -
>         pci_enable_wake(dev, target_state, wakeup);
>
>         error = pci_set_power_state(dev, target_state);
> @@ -2764,16 +2754,6 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
>         if (target_state == PCI_POWER_ERROR)
>                 return -EIO;
>
> -       /*
> -        * There are systems (for example, Intel mobile chips since Coffee
> -        * Lake) where the power drawn while suspended can be significantly
> -        * reduced by disabling PTM on PCIe root ports as this allows the
> -        * port to enter a lower-power PM state and the SoC to reach a
> -        * lower-power idle state as a whole.
> -        */
> -       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> -               pci_disable_ptm(dev);
> -
>         __pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
>
>         error = pci_set_power_state(dev, target_state);
>
> commit f84a7e954e37 ("PCI/PTM: Enable PTM when restoring state")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu Sep 1 15:51:23 2022 -0500
>
>     PCI/PTM: Enable PTM when restoring state
>
>     The suspend path may disable PTM before saving config state, which means
>     the PCI_PTM_CTRL_ENABLE bit in the saved state may be cleared even though
>     we want PTM to be enabled when resuming.
>
>     If "dev->ptm_enabled" is set, it means PTM should be enabled, so make sure
>     PCI_PTM_CTRL_ENABLE is set when restoring the PTM state.
>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index b6a417247ce3..3115601a85ef 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -82,6 +82,14 @@ void pci_restore_ptm_state(struct pci_dev *dev)
>                 return;
>
>         cap = (u16 *)&save_state->cap.data[0];
> +
> +       /*
> +        * The suspend path may disable PTM before saving config state.
> +        * Make sure PCI_PTM_CTRL_ENABLE is set if PTM should be enabled.
> +        */
> +       if (dev->ptm_enabled)
> +               *cap |= PCI_PTM_CTRL_ENABLE;
> +
>         pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
>  }
>
>
> commit 1d7d32a35df0 ("PCI/PTM: Preserve PTM Root Select")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu Sep 1 15:54:15 2022 -0500
>
>     PCI/PTM: Preserve PTM Root Select
>
>     When disabling PTM, there's no need to clear the Root Select bit.  We
>     disable PTM during suspend, and we want to re-enable it during resume.
>     Clearing Root Select here makes re-enabling more complicated.
>
>     Per PCIe r6.0, sec 7.9.15.3, "When set, if the PTM Enable bit is also Set,
>     this Time Source is the PTM Root," so if PTM Enable is cleared, the value
>     of Root Select should be irrelevant.
>
>     Preserve Root Select to simplify re-enabling PTM.
>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Cc: David E. Box <david.e.box@linux.intel.com>
>
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 368a254e3124..b6a417247ce3 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -42,7 +42,7 @@ void pci_disable_ptm(struct pci_dev *dev)
>                 return;
>
>         pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
> -       ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
> +       ctrl &= ~PCI_PTM_CTRL_ENABLE;
>         pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
>  }
>
