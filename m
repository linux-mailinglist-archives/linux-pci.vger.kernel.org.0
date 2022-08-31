Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072A15A84C7
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 19:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiHaRxw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 13:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiHaRx3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 13:53:29 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1C7E3419;
        Wed, 31 Aug 2022 10:53:17 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id f18so5262308yba.1;
        Wed, 31 Aug 2022 10:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8JthIN/5bciauu41JY33MQMeYzEECeuU52vtcGbReJI=;
        b=4ibZ9IVqb/V1G5Icj11Nnphw9WCuJzBluxP8yXen9xab1mY8wJi/zuZLJW8n0LM0L/
         Ww7eXXBgOSiRqYe4f/QQa9Nl1RibS9u/DaHkh3huUIF0ok4NaoL0M6pYVV0titpgisTz
         I7QbA2H1/dSk43UCADa2iAwRkTekRxvA6NgtIGCzTxAJJyAQuJDWt7PKRRD9XxlnIHRq
         o8sZUa1dGcOxMDHp4FbwbbmP6LesCKJbbSos/U+6/IaJ67mSpusgwXf617tfb9x2RTY1
         EzI+xvDiebiXK1z9z+csAf777Aed4Wio80w/zhAYhE90xtZlkcr293Uq4ii8AUZWWBtr
         oT1g==
X-Gm-Message-State: ACgBeo2ViPFWEPBbyBpF+TYNytexnx4pYxFsLH64ltpafkXkI0jM6S7V
        75xOXYWZT618rb1BRXXg0knekiSqnLaKj3WdBKyRbNw/
X-Google-Smtp-Source: AA6agR6PmTrrv4F2HBGDCeBWys4Ygtq6+HVmTJSdTGgVrZvjYGykF2U5lN4P1bktPjaFat5aa+eC/xJlEsQ5Mjrd8DQ=
X-Received: by 2002:a25:8204:0:b0:69e:3b25:273 with SMTP id
 q4-20020a258204000000b0069e3b250273mr2091266ybk.482.1661968396299; Wed, 31
 Aug 2022 10:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0iHckqia4OywKzSNWFCaq7eOkJcm5yXJdT2_sNdd36gDw@mail.gmail.com>
 <20220830194637.GA118760@bhelgaas>
In-Reply-To: <20220830194637.GA118760@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 31 Aug 2022 19:53:05 +0200
Message-ID: <CAJZ5v0jdFPauNKurpXFdCJBtsXavvLzV9fu02divz61hE_STbQ@mail.gmail.com>
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

On Tue, Aug 30, 2022 at 9:46 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Aug 30, 2022 at 08:03:41PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Aug 30, 2022 at 7:37 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Aug 30, 2022 at 06:58:20PM +0200, Rafael J. Wysocki wrote:
> > > > On Tue, Aug 30, 2022 at 6:25 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Tue, Aug 30, 2022 at 03:49:13AM -0700, Rajvi Jingar wrote:
> > > > > > pci_dev->ptm_enabled needs to be maintained to reflect the current PTM
> > > > > > state of the device. In pci_ptm_disable(), clear ptm_enabled from
> > > > > > 'struct pci_dev' on disabling PTM state for the device.
> > > > > > In pci_restore_ptm_state(), set dev->ptm_enabled based on the restored
> > > > > > PTM state of the device.
> > > > > >
> > > > > > In pci_ptm_disable(), perform ptm_enabled check to avoid config space
> > > > > > access in case if PTM is already disabled for the device. ptm_enabled
> > > > > > won't be set for non-PCIe devices so pci_is_pcie(dev) check is not
> > > > > > needed anymore.
> > > > >
> > > > > This one sounds like it's supposed to fix something, but I'm not clear
> > > > > exactly what.
> > > > >
> > > > > I have a vague memory of config accesses messing up a low power state.
> > > > > But this is still completely magical and unmaintainable since AFAIK
> > > > > there is nothing in the PCIe spec about avoiding config accesses when
> > > > > PTM is disabled.
> > >
> > > I'm remembering this, which seemed like an ancestor of this patch:
> > > https://lore.kernel.org/r/CAJZ5v0gNy6YJA+RNTEyHBdoJK-jqKN60oU_k_LX4=cTuyoO2mg@mail.gmail.com
> > >
> > > This patch is queued up and does something similar (disabling PTM on
> > > all devices before suspend):
> > > https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=d878400c7d98
> > >
> > > Is d878400c7d98 enough to solve the functional issue, and this patch
> > > is basically a cleanup?  I think it's a nice cleanup and worth doing.
> >
> > This patch is independent of d878400c7d98.  We've been working on a
> > d878400c7d98 counterpart on top of this patch.
> >
> > There is a problem with d878400c7d98 that disabling PTM from
> > pci_prepare_to_sleep() is not enough, because that function is not
> > called for some endpoints where we also want to disable PTM on system
> > suspend.
> >
> > IMV the most suitable place to disable PTM (temporarily) on
> > system-wide suspend is in pci_pm_suspend_noirq(, because it is the
> > last piece of generic PCI code running for all PCI devices regardless
> > of what their drivers do.
> >
> > > I'm just trying to figure out the "avoid config space access" in the
> > > commit log.  If avoiding config space access is necessary, it needs
> > > more explanation.
>
> AFAICT, these are great cleanups but neither of these patches is
> really a functional change.  If that's true,

It is true.

> the "avoid config space access" should be removed from the commit log.

Agreed.

> I dropped d878400c7d98 for now and updated my pci/pm branch with just
> these two patches with updates as attached below.

They look good to me.

> Then we can rework d878400c7d98 so it disables PTM unconditionally in
> pci_pm_suspend_noirq() instead of in pci_prepare_to_sleep().

In the meantime, I recalled that nvme wanted to leave the device in D0
and program it into an internal low-power state in some cases which
would be disturbed by disabling PTM later on (a config space write
would kick the device out of the internal low-power state).

So it looks like it would be better to disable PTM as the first thing
in pci_pm_suspend() before calling the driver's suspend callback
(which may be nvme suspend), but then we'd need to save the original
PTM status and restore it during the subsequent resume.  That could be
done as early as in pci_pm_resume_noirq(), but I think the cleanest
way would be to add a new bit to struct pci_device for that.
Alternatively, we can drop the $subject patch, so ptm_enabled still
only means that it has been enabled during enumeration and it can be
used to restore the original PTM status during resume.

> Currently, or with d878400c7d98, we only call pci_prepare_to_sleep()
> when (!skip_bus_pm && !state_saved && pci_power_manageable()), so if a
> driver saves its own state, we won't disable PTM, which seems like a
> problem.

Agreed.

> I assume we also want to move the pci_disable_ptm() from
> pci_finish_runtime_suspend() to pci_pm_runtime_suspend() to keep it
> parallel with pci_pm_suspend_noirq().

I think so.

> Is this making sense?

Yes, it is, modulo the above observations.

> > > > Because ptm_enabled is expected to always reflect the hardware state,
> > > > pci_disable_ptm() needs to be amended to clear it.  Also it is prudent
> > > > to explicitly make it reflect the new hardware state in
> > > > pci_restore_ptm_state().
> > > >
> > > > Then, pci_disable_ptm() can be made bail out if ptm_enabled is clear,
> > > > because it has nothing to do then and the pci_is_pcie() check in there
> > > > is not necessary, because ptm_enabled will never be set for devices
> > > > that are not PCIe.
> > > >
> > > > > At the very least, we would need more details in the commit log and
> > > > > a hint in the code about this.
>
> commit 22b07d9ddd02 ("PCI/PTM: Update pdev->ptm_enabled to track hardware state")
> Author: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> Date:   Tue Aug 30 03:49:13 2022 -0700
>
>     PCI/PTM: Update pdev->ptm_enabled to track hardware state
>
>     Update pdev->ptm_enabled to track hardware state when we disable or restore
>     PTM state.
>
>     No functional change intended, since 'ptm_enabled' was previously only
>     tested during enumeration and pci_disable_ptm() is only used during
>     suspend.
>
>     [bhelgaas: commit log]
>     Link: https://lore.kernel.org/r/20220830104913.1620539-2-rajvi.jingar@linux.intel.com
>     Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 368a254e3124..1ce241d4538f 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -34,7 +34,7 @@ void pci_disable_ptm(struct pci_dev *dev)
>         int ptm;
>         u16 ctrl;
>
> -       if (!pci_is_pcie(dev))
> +       if (!dev->ptm_enabled)
>                 return;
>
>         ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> @@ -44,6 +44,7 @@ void pci_disable_ptm(struct pci_dev *dev)
>         pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
>         ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
>         pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
> +       dev->ptm_enabled = 0;
>  }
>
>  void pci_save_ptm_state(struct pci_dev *dev)
> @@ -83,6 +84,7 @@ void pci_restore_ptm_state(struct pci_dev *dev)
>
>         cap = (u16 *)&save_state->cap.data[0];
>         pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
> +       dev->ptm_enabled = !!(*cap & PCI_PTM_CTRL_ENABLE);
>  }
>
>  void pci_ptm_init(struct pci_dev *dev)
>
> commit 6e594f65471b ("PCI/PM: Simplify pci_pm_suspend_noirq()")
> Author: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> Date:   Tue Aug 30 03:49:12 2022 -0700
>
>     PCI/PM: Simplify pci_pm_suspend_noirq()
>
>     We always want to save the device state unless the driver has already done
>     it.  Rearrange the checking in pci_pm_suspend_noirq() to make this more
>     clear.  No functional change intended.
>
>     [bhelgaas: commit log, rewrap comment]
>     Link: https://lore.kernel.org/r/20220830104913.1620539-1-rajvi.jingar@linux.intel.com
>     Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 49238ddd39ee..2815922ac525 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -867,20 +867,15 @@ static int pci_pm_suspend_noirq(struct device *dev)
>                 }
>         }
>
> -       if (pci_dev->skip_bus_pm) {
> +       if (!pci_dev->state_saved) {
> +               pci_save_state(pci_dev);
> +
>                 /*
> -                * Either the device is a bridge with a child in D0 below it, or
> -                * the function is running for the second time in a row without
> -                * going through full resume, which is possible only during
> -                * suspend-to-idle in a spurious wakeup case.  The device should
> -                * be in D0 at this point, but if it is a bridge, it may be
> -                * necessary to save its state.
> +                * If the device is a bridge with a child in D0 below it,
> +                * it needs to stay in D0, so check skip_bus_pm to avoid
> +                * putting it into a low-power state in that case.
>                  */
> -               if (!pci_dev->state_saved)
> -                       pci_save_state(pci_dev);
> -       } else if (!pci_dev->state_saved) {
> -               pci_save_state(pci_dev);
> -               if (pci_power_manageable(pci_dev))
> +               if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
>                         pci_prepare_to_sleep(pci_dev);
>         }
>
