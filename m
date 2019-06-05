Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBE2235C31
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2019 14:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfFEMCE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jun 2019 08:02:04 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33642 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFEMCE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jun 2019 08:02:04 -0400
Received: by mail-oi1-f195.google.com with SMTP id q186so17995960oia.0;
        Wed, 05 Jun 2019 05:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdLoeXvGK64UnKYqEfACEboUnaTqdKxgDmgaDBJkjwc=;
        b=t50Oeu1dzVTMaZbpSeWeBkXcPZwasR7boersmNNro65BoQEG1urFZWdL2sx1W/QDkJ
         GzrFdI36giqjIvOgOwJ7+jcZ5eeA1nI6aBLxEK0zuDefR0VbCz/WEOGhFsy1Uhn/xPWZ
         YQE7W1zNK8+5vSwzIA5w3oDcyypFNE+Z+Z2Jsqw478oZC1qberB1UMZeiQtN6SSDoFKI
         0Kzps9fIjb4f90xJOsXIoexI8KBmofCEDmWZWGQoZaFDmVnJpUNJ6tGEo3ktEbBkjxTg
         w3Qscjv4O6iY7xEL/UQsggw6x+zBIY7ySUUZZ+bgbP+TbBfd1zmUcBAU7OgPszX0XIKi
         q3LA==
X-Gm-Message-State: APjAAAXYzDYqQ8DyAOQpYOKBPG0Zsb1qtgxZTtvFJyB3FC/c2822o1NM
        b+sKlllKOCZhGQslNWC+uAZLY5syrwfY5/aCHX2F0Q==
X-Google-Smtp-Source: APXvYqxC3+yS1W3DjhMQWqlDnjo2YLFj0GHQ5scS5vsj+eQyAOThBzuJKuI7PKmnjzcMRqD+2qD413si+w9d0hvOjGw=
X-Received: by 2002:aca:3256:: with SMTP id y83mr8361607oiy.110.1559736123091;
 Wed, 05 Jun 2019 05:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <4561083.VtDMOnK5Me@kreacher> <20190531211648.GB58810@google.com>
 <1855172.0PEGphScmv@kreacher> <20190605113635.GD84290@google.com>
In-Reply-To: <20190605113635.GD84290@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 5 Jun 2019 14:01:52 +0200
Message-ID: <CAJZ5v0gmisuuzEJYxzMZpr-swSaCByRak1UQV8ttQh9wMXMOZA@mail.gmail.com>
Subject: Re: [PATCH] PCI: PM: Avoid resuming devices in D3hot during system suspend
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 5, 2019 at 1:36 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Jun 03, 2019 at 12:10:28PM +0200, Rafael J. Wysocki wrote:
> > On Friday, May 31, 2019 11:16:48 PM CEST Bjorn Helgaas wrote:
> > > On Fri, May 31, 2019 at 11:49:30AM +0200, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > The current code resumes devices in D3hot during system suspend if
> > > > the target power state for them is D3cold, but that is not necessary
> > > > in general.  It only is necessary to do that if the platform firmware
> > > > requires the device to be resumed, but that should be covered by
> > > > the platform_pci_need_resume() check anyway, so rework
> > > > pci_dev_keep_suspended() to avoid returning 'false' for devices
> > > > in D3hot which need not be resumed due to platform firmware
> > > > requirements.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/pci/pci.c |   15 ++++++++++++---
> > > >  1 file changed, 12 insertions(+), 3 deletions(-)
> > > >
> > > > Index: linux-pm/drivers/pci/pci.c
> > > > ===================================================================
> > > > --- linux-pm.orig/drivers/pci/pci.c
> > > > +++ linux-pm/drivers/pci/pci.c
> > > > @@ -2474,10 +2474,19 @@ bool pci_dev_keep_suspended(struct pci_d
> > > >  {
> > > >   struct device *dev = &pci_dev->dev;
> > > >   bool wakeup = device_may_wakeup(dev);
> > > > + pci_power_t target_state;
> > > >
> > > > - if (!pm_runtime_suspended(dev)
> > > > -     || pci_target_state(pci_dev, wakeup) != pci_dev->current_state
> > > > -     || platform_pci_need_resume(pci_dev))
> > > > + if (!pm_runtime_suspended(dev) || platform_pci_need_resume(pci_dev))
> > > > +         return false;
> > > > +
> > > > + target_state = pci_target_state(pci_dev, wakeup);
> > >
> > > Nit, add a blank line here.
> >
> > OK
> >
> > > > + /*
> > > > +  * If the earlier platform check has not triggered, D3cold is just power
> > > > +  * removal on top of D3hot, so no need to resume the device in that
> > > > +  * case.
> > > > +  */
> > > > + if (target_state != pci_dev->current_state &&
> > > > +     target_state != PCI_D3cold && pci_dev->current_state != PCI_D3hot)
> > > >           return false;
> > >
> > > This is more a comment on the existing code than on this particular
> > > patch, but I find this whole function hard to understand, and I think
> > > one reason is that there are a lot of negative conditions, both in
> > > this function and in its callers.  This "target_state != ... &&
> > > target_state != ...  && current_state != ..." is one example.  Another
> > > is the function name itself.  It might be easier to read as something
> > > like this:
> > >
> > >   bool pci_dev_need_resume(...)
> > >   {
> > >     if (!pm_runtime_suspended(...))
> > >       return true;
> > >
> > >     if (platform_pci_need_resume(...))
> > >       return true;
> > >
> > >     if (target_state != current_state)
> > >       return true;
> >
> > Please see the appended (untested) patch on top of the $subject one.
>
> I like it a lot, thanks!  I think it makes it a lot more readable.
>
> > > Another reason I think it's hard to read is that
> > > "pci_dev_keep_suspended" suggests that this is a pure boolean function
> > > without side-effects, but in fact it also fiddles with the PME state
> > > in some cases.  I don't have any ideas for that part.
> >
> > Well, I can only propose to put the PME adjustment part into a separate function like
> > in the patch below.
> >
> > ---
> >  drivers/pci/pci-driver.c |   21 ++++++++++++++++---
> >  drivers/pci/pci.c        |   50 ++++++++++++++++++++++++-----------------------
> >  drivers/pci/pci.h        |    3 +-
> >  3 files changed, 46 insertions(+), 28 deletions(-)
> >
> > Index: linux-pm/drivers/pci/pci.c
> > ===================================================================
> > --- linux-pm.orig/drivers/pci/pci.c
> > +++ linux-pm/drivers/pci/pci.c
> > @@ -2459,54 +2459,56 @@ bool pci_dev_run_wake(struct pci_dev *de
> >  EXPORT_SYMBOL_GPL(pci_dev_run_wake);
> >
> >  /**
> > - * pci_dev_keep_suspended - Check if the device can stay in the suspended state.
> > + * pci_dev_need_resume - Check if the device can stay in the suspended state.
> >   * @pci_dev: Device to check.
> >   *
> > - * Return 'true' if the device is runtime-suspended, it doesn't have to be
> > + * Return 'false' if the device is runtime-suspended, it doesn't have to be
> >   * reconfigured due to wakeup settings difference between system and runtime
> >   * suspend and the current power state of it is suitable for the upcoming
> >   * (system) transition.
> > - *
> > - * If the device is not configured for system wakeup, disable PME for it before
> > - * returning 'true' to prevent it from waking up the system unnecessarily.
> >   */
> > -bool pci_dev_keep_suspended(struct pci_dev *pci_dev)
> > +bool pci_dev_need_resume(struct pci_dev *pci_dev)
> >  {
> >       struct device *dev = &pci_dev->dev;
> > -     bool wakeup = device_may_wakeup(dev);
> >       pci_power_t target_state;
> >
> >       if (!pm_runtime_suspended(dev) || platform_pci_need_resume(pci_dev))
> > -             return false;
> > +             return true;
> >
> > -     target_state = pci_target_state(pci_dev, wakeup);
> > +     target_state = pci_target_state(pci_dev, device_may_wakeup(dev));
> >       /*
> >        * If the earlier platform check has not triggered, D3cold is just power
> >        * removal on top of D3hot, so no need to resume the device in that
> >        * case.
> >        */
> > -     if (target_state != pci_dev->current_state &&
> > -         target_state != PCI_D3cold && pci_dev->current_state != PCI_D3hot)
> > -             return false;
> > +     return target_state != pci_dev->current_state &&
> > +             target_state != PCI_D3cold &&
> > +             pci_dev->current_state != PCI_D3hot;
> > +}
> > +
> > +/**
> > + * pci_dev_adjust_pme - Adjust PME setting for a suspended device.
> > + * @pci_dev: Device to check.
> > + *
> > + * If the device is not configured for system wakeup, disable PME for it to
> > + * prevent it from waking up the system unnecessarily.
> > + */
> > +void pci_dev_adjust_pme(struct pci_dev *pci_dev)
> > +{
> > +     struct device *dev = &pci_dev->dev;
> >
> > -     /*
> > -      * At this point the device is good to go unless it's been configured
> > -      * to generate PME at the runtime suspend time, but it is not supposed
> > -      * to wake up the system.  In that case, simply disable PME for it
> > -      * (it will have to be re-enabled on exit from system resume).
> > -      *
> > -      * If the device's power state is D3cold and the platform check above
> > -      * hasn't triggered, the device's configuration is suitable and we don't
> > -      * need to manipulate it at all.
> > -      */
> >       spin_lock_irq(&dev->power.lock);
> >
> > +     /*
> > +      * If the device's power state is D3cold and the platform check in
> > +      * pci_dev_need_resume() hasn't triggered, the device's configuration is
> > +      * suitable and it need not be touched.
>
> I guess "it need not be touched" == "we don't need to disable PME"?

That's correct.

I'll try to improve the wording in the final version of the patch.

> > +      */
> >       if (pm_runtime_suspended(dev) && pci_dev->current_state < PCI_D3cold &&
> > -         !wakeup)
> > +         !device_may_wakeup(dev))
> >               __pci_pme_active(pci_dev, false);
> >
> >       spin_unlock_irq(&dev->power.lock);
> > -     return true;
> >  }
> >
> >  /**
