Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D1F56A7DA
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 18:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbiGGQRm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 12:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbiGGQRh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 12:17:37 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FD6DF99;
        Thu,  7 Jul 2022 09:17:36 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id i14so13614406yba.1;
        Thu, 07 Jul 2022 09:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iNDoYSvd59pYkJGvoaN7Bi5VVVz7oaHmh9uahP1lZbs=;
        b=WTdDqLqR4yKXGEOn0lKhqA5dCV37Dked7ph+ahPUZZjYw509Ww3uKBfZo6dFiqgm4P
         2Bu5O6OaNlvBHNdYXuMTbsWV0bleZaYFcWPsh5zOKMjBsz3lA/O/TswiF+WGJKcfe4fm
         bZEz2XqpK3kYfasWKmiiWNTyfArwLc5G9Wdda4fKFL9sHfDLVesqW+Xm3brJos6KRaTq
         Kxva3eRkoz9fhVjHx+olfyy8bjDy1CLQgAijPYA3PaB1YmQhn5PKHDWfHneWgjIsTlq4
         UshuQWjXqeJT6CKSQE6C86+F+It8gM3BHYRn0i/0uKN59nMmTcJbjmmgh6w8wZKP+SE1
         5EIw==
X-Gm-Message-State: AJIora+S0AT6ps13fj0bPwp2MjeaHQrWzpIPJPl/DY1FWiu3wh00iTrm
        +VGljI4qcGEYYbx+UL0RlF0Z/jwwcoAq+iniP8uM5zcQwAw=
X-Google-Smtp-Source: AGRyM1sJBdf8dhWPDByV7+nX2eW11WjDWRTtyepwM+BYWgdffzeCzS6VoWlpRrMLbiSQ9ICB7AlVoDQlWuH8yKnU3c4=
X-Received: by 2002:a25:a2ca:0:b0:66e:719e:279 with SMTP id
 c10-20020a25a2ca000000b0066e719e0279mr15032108ybn.622.1657210655174; Thu, 07
 Jul 2022 09:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220609001007.533242-2-rajvi.jingar@linux.intel.com> <20220611001217.GA639674@bhelgaas>
In-Reply-To: <20220611001217.GA639674@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Jul 2022 18:17:24 +0200
Message-ID: <CAJZ5v0gNy6YJA+RNTEyHBdoJK-jqKN60oU_k_LX4=cTuyoO2mg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] PCI/PM: Disable PTM on all devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Box <david.e.box@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
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

Sorry for the delay here.

On Sat, Jun 11, 2022 at 2:12 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jun 08, 2022 at 05:10:07PM -0700, Rajvi Jingar wrote:
> > On receiving a PTM Request from a downstream device, if PTM is disabled
> > on the root port, as per PCIe specification, such request would cause
> > an Unsupported Request error. So disable PTM for any downstream devices.
> > PTM state needs to be saved before disabling it to be restored later.
> >
> > Set ptm_enabled from 'struct pci_dev' to 0 in pci_ptm_disable() and
> > it is used in pci_save_state() before saving PTM state to avoid
> > double save.
> >
> > Fixes: a697f072f5da ("PCI: Disable PTM during suspend to save power")
> > Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> > Suggested-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> >  v1 -> v2: add Fixes tag in commit message
> >  v2 -> v3: move changelog after "---" marker
> >  v3 -> v4: add "---" marker after changelog
> >  v4 -> v5: move pci_disable_ptm() out of the pci_dev->state_saved check.
> >          disable PTM for all devices, not just root ports.
> >  v5 -> v6: move pci_disable_ptm() to pci_pm_suspend()
> >          set pci_dev->ptm_enabled to 0 in pci_ptm_disable() and it is
> >          used in pci_save_state() before saving PTM state to avoid
> >          double save.
> >  v6 -> v7: add #ifdef CONFIG_PCIE_PTM in pci_save_state() before saving
> >          PTM state
> > ---
> >  drivers/pci/pci-driver.c | 21 ++++++++++++++++++++-
> >  drivers/pci/pci.c        | 28 +++++++++++++---------------
> >  drivers/pci/pcie/ptm.c   |  1 +
> >  3 files changed, 34 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 1f64de3e5280..db4d7835d7ae 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -803,14 +803,33 @@ static int pci_pm_suspend(struct device *dev)
> >               pci_dev_adjust_pme(pci_dev);
> >       }
> >
> > +     /*
> > +      * If a PTM Requester is put in a low-power state, a PTM Responder
> > +      * upstream from it may also be put in a low-power state. Putting a
> > +      * Port in D1, D2, or D3hot does not prohibit it from sending or
> > +      * responding to PTM Requests. We want to disable PTM on Responders
> > +      * when they are in a low-power state. Per 6.21.3, a PTM Requester
> > +      * must not be enabled when the upstream PTM Responder is disabled.
> > +      * Therefore, we must disable all PTM on all downstream PTM
> > +      * Requesters before disabling it on the PTM Responder, e.g., a Root
> > +      * Port.
> > +      *
> > +      * Also, to restore the PTM state, it needs to be saved before
> > +      * disabling it for all devices.
> > +      */
> > +     pci_save_ptm_state(pci_dev);
> > +     pci_disable_ptm(pci_dev);
>
> I think this is a little bit too magical.  The PTM disable doesn't
> really fit here in pci_pm_suspend().  It's more like the wakeup
> configuration done by pci_pm_suspend_noirq() in
> pci_prepare_to_sleep().
>
> IIUC, the reason it's here in pci_pm_suspend() is because of the weird
> nvme thing where nvme_suspend() puts the device in a device-specific
> low-power flavor of D0 and subsequent config accesses take it out of
> that low-power situation [1].
>
> I don't think this is a maintainable situation because there's nothing
> about this pci_disable_ptm() that says "this cannot be done after
> pm->suspend()".  That's a completely nvme-specific thing that we can't
> deduce from the code and are likely to break in the future.

Well, I'm not sure it is nvme-specific really.

Pretty much the same goes for any driver that wants to do their own
power management (whatever it is) in the ->suspend() callback and
indicate that by calling pci_save_state() by itself.

> We *do* have the rule that if the driver sets pdev->state_saved
> (normally by calling pci_save_state()), it means the driver is
> responsible for *all* the device state, even the standard config space
> that the PCI core would normally handle.
>
> When the driver does set pdev->state_saved, I don't think
> pci_pm_suspend_noirq() actually touches the device itself, and I'm a
> little more comfortable relying on that assumption.

It can be relied on right now which is also why the $subject patch
cannot put the PTM disabling in there and do it regardless of the
state_saved value.

> If this nvme weirdness plays a part here, I think the commit log and
> probably a comment really should mention what's going on because it's
> just feels fragile.

Totally agree on that one.

> [1] https://lore.kernel.org/r/CAJZ5v0iNaAd=yP3DgDVVpffKU6kt+nSpPeqxWJyRddaX5K4FRA@mail.gmail.com
>
> >       if (pm->suspend) {
> >               pci_power_t prev = pci_dev->current_state;
> >               int error;
> >
> >               error = pm->suspend(dev);
> >               suspend_report_result(dev, pm->suspend, error);
> > -             if (error)
> > +             if (error) {
> > +                     pci_restore_ptm_state(pci_dev);
> >                       return error;
> > +             }
> >
> >               if (!pci_dev->state_saved && pci_dev->current_state != PCI_D0
> >                   && pci_dev->current_state != PCI_UNKNOWN) {
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index cfaf40a540a8..3e9dcb1bbffa 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1669,7 +1669,15 @@ int pci_save_state(struct pci_dev *dev)
> >       pci_save_ltr_state(dev);
> >       pci_save_dpc_state(dev);
> >       pci_save_aer_state(dev);
> > -     pci_save_ptm_state(dev);
> > +#ifdef CONFIG_PCIE_PTM
> > +     /*
> > +      * PCI PM core disables PTM during suspend and saves PTM state before
> > +      * that to be able to restore the ptm state restored later. So PCI core
> > +      * needs this check to avoid double save.
> > +      */
> > +     if (dev->ptm_enabled)
> > +             pci_save_ptm_state(dev);
> > +#endif
>
> This ptm_enabled check doesn't fit with the rest of the function and
> the semantics are fairly complicated.
>
> >       return pci_save_vc_state(dev);
> >  }
> >  EXPORT_SYMBOL(pci_save_state);
> > @@ -2710,24 +2718,12 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
> >       if (target_state == PCI_POWER_ERROR)
> >               return -EIO;
> >
> > -     /*
> > -      * There are systems (for example, Intel mobile chips since Coffee
> > -      * Lake) where the power drawn while suspended can be significantly
> > -      * reduced by disabling PTM on PCIe root ports as this allows the
> > -      * port to enter a lower-power PM state and the SoC to reach a
> > -      * lower-power idle state as a whole.
> > -      */
> > -     if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> > -             pci_disable_ptm(dev);
> > -
> >       pci_enable_wake(dev, target_state, wakeup);
> >
> >       error = pci_set_power_state(dev, target_state);
> >
> > -     if (error) {
> > +     if (error)
> >               pci_enable_wake(dev, target_state, false);
> > -             pci_restore_ptm_state(dev);
> > -     }
> >
> >       return error;
> >  }
> > @@ -2775,8 +2771,10 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
> >        * port to enter a lower-power PM state and the SoC to reach a
> >        * lower-power idle state as a whole.
> >        */
> > -     if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> > +     if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
> > +             pci_save_ptm_state(dev);
> >               pci_disable_ptm(dev);
> > +     }
> >
> >       __pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
> >
> > diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> > index 368a254e3124..746e29779c27 100644
> > --- a/drivers/pci/pcie/ptm.c
> > +++ b/drivers/pci/pcie/ptm.c
> > @@ -44,6 +44,7 @@ void pci_disable_ptm(struct pci_dev *dev)
> >       pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
> >       ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
> >       pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
> > +     dev->ptm_enabled = 0;
>
> This looks like a bug fix that could be in a separate patch.
>
> >  }
> >
> >  void pci_save_ptm_state(struct pci_dev *dev)
>
>
> I think something like the sketch below would fit better in the power
> management framework.  PTM disable is closely related to device power
> states, so I tried to put it as close as possible to the power state
> transitions.  I'm sure there are things missing and things I'm
> overlooking:

There are PCI devices that pci_prepare_to_sleep() is not called for,
so disabling PTM in there may not work in general.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index cfaf40a540a8..4dcd0c7381b9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2705,28 +2705,21 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
>  {
>         bool wakeup = device_may_wakeup(&dev->dev);
>         pci_power_t target_state = pci_target_state(dev, wakeup);
> +       bool ptm = pcie_ptm_enabled(dev);
>         int error;
>
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
> +       pci_disable_ptm(dev);
>         pci_enable_wake(dev, target_state, wakeup);
>
>         error = pci_set_power_state(dev, target_state);
>
>         if (error) {
>                 pci_enable_wake(dev, target_state, false);
> -               pci_restore_ptm_state(dev);
> +               if (ptm)
> +                       pci_enable_ptm(dev);
>         }
>
>         return error;
> @@ -2762,6 +2755,7 @@ EXPORT_SYMBOL(pci_back_from_sleep);
>  int pci_finish_runtime_suspend(struct pci_dev *dev)
>  {
>         pci_power_t target_state;
> +       bool ptm = pcie_ptm_enabled(dev);
>         int error;
>
>         target_state = pci_target_state(dev, device_can_wakeup(&dev->dev));
> @@ -2778,13 +2772,15 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
>         if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
>                 pci_disable_ptm(dev);
>
> +       pci_disable_ptm(dev);
>         __pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
>
>         error = pci_set_power_state(dev, target_state);
>
>         if (error) {
>                 pci_enable_wake(dev, target_state, false);
> -               pci_restore_ptm_state(dev);
> +               if (ptm)
> +                       pci_enable_ptm(dev);
>         }
>
>         return error;
