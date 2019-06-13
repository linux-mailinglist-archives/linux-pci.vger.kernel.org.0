Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C54444EAE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 23:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfFMVrI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 17:47:08 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34138 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfFMVrI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 17:47:08 -0400
Received: by mail-ot1-f65.google.com with SMTP id n5so693747otk.1;
        Thu, 13 Jun 2019 14:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gl6ZZTlBsh27gBYwVHWMD38rM/ZtB9ahsb6olp2KOBE=;
        b=lvVOriiELKs+oXD5zPksdigg7kAoGzFXDpywgqoTRjHjG/Q/XwvsKWZJQMFciimYSx
         OJFVutQxmYixkmmVkQM+LyeTBFpphhBZfUuuj6tdVPCXHapRnp0P9yAz4+5mQo2FeqQ2
         NlY6ncmkMgFg45u7r+Z7oS4mq7BwJcTplTGgqURqszU10gw0G5pVMlKHW2D5D/MScNm3
         GaBfusjEWyeLek1eRjLfTQOkOpRvgpf5LxW68TsRTQHOH3Yq1SJUCbpeG0rxuIgBvlT1
         hCvUgomFl4+lBwYY/cR93DDGk/24cwPMxMWmOKZejle7WjxaHYJDNCmcKzU6AGJphNBB
         aHoA==
X-Gm-Message-State: APjAAAUHFEPw+MYBEiui9bdDA4vRhEtO/w8PV13yACsBS07tI4Aodu+n
        nQ2R9fV2lZyA6RAyvEun0yQYweEMQRrl9Fep4qo=
X-Google-Smtp-Source: APXvYqyf3zKz7EdXWsEdBaJxwdzf898OLwvtezdrZXsMLG6EGXRgCWmYV94mkAIVJk9I1ndgoV5ZFTF9wTBd0bi0Uxs=
X-Received: by 2002:a9d:6959:: with SMTP id p25mr22646198oto.118.1560462427297;
 Thu, 13 Jun 2019 14:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <2513600.jR9RdVMSR0@kreacher> <20190613213823.GM13533@google.com>
In-Reply-To: <20190613213823.GM13533@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Jun 2019 23:46:56 +0200
Message-ID: <CAJZ5v0jD9Ln1+fUJHCRxRu4ZYtnesah3+cohysGr5jbxSwyrXg@mail.gmail.com>
Subject: Re: [PATCH] PCI: PM: Skip devices in D0 for suspend-to-idle
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 11:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Jun 13, 2019 at 12:14:02AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
> > attempted to avoid a problem with devices whose drivers want them to
> > stay in D0 over suspend-to-idle and resume, but it did not go as far
> > as it should with that.
> >
> > Namely, first of all, it is questionable to change the power state
> > of a PCI bridge with a device in D0 under it, but that is not
> > actively prevented from happening during system-wide PM transitions,
> > so use the skip_bus_pm flag introduced by commit d491f2b75237 for
> > that.
>
> I think it's more than questionable.  I think a bridge is *required*
> to be in D0 if any downstream device is in D0.  Based on the PCI PM
> spec r1.2, sec 6, table 6-1, if the bridge is not in D0, there can be
> no PCI transactions on its secondary bus.

Fair enough.

> > Second, the configuration of devices left in D0 (whatever the reason)
> > during suspend-to-idle need not be changed and attempting to put them
> > into D0 again by force may confuse some firmware, so explicitly avoid
> > doing that.
>
> I don't know what to do with "may confuse some firmware"; it doesn't
> say what firmware is affected or why, so it sort of leads to "we can
> never touch this code because we don't know what might break."
>
> But IMO the first reason by itself is more than enough to keep a
> bridge in D0 if any downstream device is in D0.

OK, so I'll replace the phrase "may confuse some firmware" with "is pointless".

> > Fixes: d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
> > Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Tested on Dell XPS13 9360 with no issues.
> >
> > ---
> >  drivers/pci/pci-driver.c |   47 +++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 35 insertions(+), 12 deletions(-)
> >
> > Index: linux-pm/drivers/pci/pci-driver.c
> > ===================================================================
> > --- linux-pm.orig/drivers/pci/pci-driver.c
> > +++ linux-pm/drivers/pci/pci-driver.c
> > @@ -524,7 +524,6 @@ static void pci_pm_default_resume_early(
> >       pci_power_up(pci_dev);
> >       pci_restore_state(pci_dev);
> >       pci_pme_restore(pci_dev);
> > -     pci_fixup_device(pci_fixup_resume_early, pci_dev);
> >  }
> >
> >  /*
> > @@ -842,18 +841,16 @@ static int pci_pm_suspend_noirq(struct d
> >
> >       if (pci_dev->skip_bus_pm) {
> >               /*
> > -              * The function is running for the second time in a row without
> > +              * Either the device is a bridge with a child in D0 below it, or
> > +              * the function is running for the second time in a row without
> >                * going through full resume, which is possible only during
> > -              * suspend-to-idle in a spurious wakeup case.  Moreover, the
> > -              * device was originally left in D0, so its power state should
> > -              * not be changed here and the device register values saved
> > -              * originally should be restored on resume again.
> > +              * suspend-to-idle in a spurious wakeup case.  The device should
> > +              * be in D0 at this point, but if it is a bridge, it may be
> > +              * necessary to save its state.
> >                */
> > -             pci_dev->state_saved = true;
> > -     } else if (pci_dev->state_saved) {
> > -             if (pci_dev->current_state == PCI_D0)
> > -                     pci_dev->skip_bus_pm = true;
> > -     } else {
> > +             if (!pci_dev->state_saved)
> > +                     pci_save_state(pci_dev);
> > +     } else if (!pci_dev->state_saved) {
> >               pci_save_state(pci_dev);
> >               if (pci_power_manageable(pci_dev))
> >                       pci_prepare_to_sleep(pci_dev);
> > @@ -862,6 +859,22 @@ static int pci_pm_suspend_noirq(struct d
> >       dev_dbg(dev, "PCI PM: Suspend power state: %s\n",
> >               pci_power_name(pci_dev->current_state));
> >
> > +     if (pci_dev->current_state == PCI_D0) {
> > +             pci_dev->skip_bus_pm = true;
> > +             /*
> > +              * Changing the power state of a PCI bridge with a device in D0
> > +              * below it is questionable, so avoid doing that by setting the
> > +              * skip_bus_pm flag for the parent bridge.
>
> Maybe "Per PCI PM r1.2, table 6-1, a bridge must be in D0 if any
> downstream device is in D0"?

OK

> > +              */
> > +             if (pci_dev->bus->self)
> > +                     pci_dev->bus->self->skip_bus_pm = true;
> > +     }
> > +
> > +     if (pci_dev->skip_bus_pm && !pm_suspend_via_firmware()) {
> > +             dev_dbg(dev, "PCI PM: Skipped\n");
> > +             goto Fixup;
> > +     }
> > +
> >       pci_pm_set_unknown_state(pci_dev);
> >
> >       /*
> > @@ -909,7 +922,16 @@ static int pci_pm_resume_noirq(struct de
> >       if (dev_pm_smart_suspend_and_suspended(dev))
> >               pm_runtime_set_active(dev);
> >
> > -     pci_pm_default_resume_early(pci_dev);
> > +     /*
> > +      * In the suspend-to-idle case, devices left in D0 during suspend will
> > +      * stay in D0, so it is not necessary to restore or update their
> > +      * configuration here and attempting to put them into D0 again may
> > +      * confuse some firmware, so avoid doing that.
> > +      */
> > +     if (!pci_dev->skip_bus_pm || pm_suspend_via_firmware())
> > +             pci_pm_default_resume_early(pci_dev);
> > +
> > +     pci_fixup_device(pci_fixup_resume_early, pci_dev);
> >
> >       if (pci_has_legacy_pm_support(pci_dev))
> >               return pci_legacy_resume_early(dev);
> > @@ -1200,6 +1222,7 @@ static int pci_pm_restore_noirq(struct d
> >       }
> >
> >       pci_pm_default_resume_early(pci_dev);
> > +     pci_fixup_device(pci_fixup_resume_early, pci_dev);
> >
> >       if (pci_has_legacy_pm_support(pci_dev))
> >               return pci_legacy_resume_early(dev);
> >

I'll send a v2 shortly.
