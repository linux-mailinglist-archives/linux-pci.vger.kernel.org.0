Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B4C3B1FE5
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 19:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhFWRzX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 13:55:23 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:34647 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWRzW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jun 2021 13:55:22 -0400
Received: by mail-oi1-f173.google.com with SMTP id u11so4272040oiv.1;
        Wed, 23 Jun 2021 10:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kKQr82HDDUwFX7W6f2RL9f2u87FR6WdUapSEsXW/DEs=;
        b=KeWdipt25KXMRkrgo4efs0m9yMPVNZbI6kOvMS85qbcJhDraziteoKg5tlEkN8OF5N
         9649HlVKd7zbigK7hKtTXjlaqxEmqmP6XkV647OO4t0zW7zRzRlV5sumEMMTE9Jvw6Y9
         crikD4nj6Q39tW9jUmnU/dutD5Mbz7pJwAwTpwVdLyjl2RCfKog8MuWFF5z2uHRsX9Lp
         R/xtM8Pd/4lCEaoot4OEqBY0sqmnPqn3Q9AQJu52lghn+kzFn736/tf+7wQYuy/ukGGD
         9atzfjU0ayBNS+QrhkKK2vBVETwxhMrhUqLfg8pTfA4m/DWY5/41KTsyP0FQL9K5C0Xh
         p8xA==
X-Gm-Message-State: AOAM5319OsK+tjd0Cd71ioDXsUAvSDyOwzfdgPRsoyokA92Fp/OBg+hc
        zZXtolmgnGKLSnkYZZTgDlmoVgjQzstwdW18LFM=
X-Google-Smtp-Source: ABdhPJwVRzUAEkyf6DGKb9Rgt01zJyb6iZCfhq/4GmCXF95MvMM5PMAMAYEdojbAeYhPmygDFAJ4PoXN1OdcVCwNbew=
X-Received: by 2002:a05:6808:8d9:: with SMTP id k25mr807424oij.69.1624470783298;
 Wed, 23 Jun 2021 10:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <3219454.74lMxhSOWB@kreacher> <YNDoGICcg0V8HhpQ@eldamar.lan>
In-Reply-To: <YNDoGICcg0V8HhpQ@eldamar.lan>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Jun 2021 19:52:52 +0200
Message-ID: <CAJZ5v0hrcRWgre0HiJFw32dkmNUjaRzT=mFH=6WskopMbZsavA@mail.gmail.com>
Subject: Re: [PATCH] PCI: PM: Do not read power state in pci_enable_device_flags()
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 21, 2021 at 9:27 PM Salvatore Bonaccorso <carnil@debian.org> wrote:
>
> Hi,
>
> On Tue, Mar 16, 2021 at 04:51:40PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > It should not be necessary to update the current_state field of
> > struct pci_dev in pci_enable_device_flags() before calling
> > do_pci_enable_device() for the device, because none of the
> > code between that point and the pci_set_power_state() call in
> > do_pci_enable_device() invoked later depends on it.
> >
> > Moreover, doing that is actively harmful in some cases.  For example,
> > if the given PCI device depends on an ACPI power resource whose _STA
> > method initially returns 0 ("off"), but the config space of the PCI
> > device is accessible and the power state retrieved from the
> > PCI_PM_CTRL register is D0, the current_state field in the struct
> > pci_dev representing that device will get out of sync with the
> > power.state of its ACPI companion object and that will lead to
> > power management issues going forward.
> >
> > To avoid such issues it is better to leave the current_state value
> > as is until it is changed to PCI_D0 by do_pci_enable_device() as
> > appropriate.  However, the power state of the device is not changed
> > to PCI_D0 if it is already enabled when pci_enable_device_flags()
> > gets called for it, so update its current_state in that case, but
> > use pci_update_current_state() covering platform PM too for that.
> >
> > Link: https://lore.kernel.org/lkml/20210314000439.3138941-1-luzmaximilian@gmail.com/
> > Reported-by: Maximilian Luz <luzmaximilian@gmail.com>
> > Tested-by: Maximilian Luz <luzmaximilian@gmail.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Max, I've added a T-by from you even though the patch is slightly different
> > from what you have tested, but the difference shouldn't matter for your case.
> >
> > ---
> >  drivers/pci/pci.c |   16 +++-------------
> >  1 file changed, 3 insertions(+), 13 deletions(-)
> >
> > Index: linux-pm/drivers/pci/pci.c
> > ===================================================================
> > --- linux-pm.orig/drivers/pci/pci.c
> > +++ linux-pm/drivers/pci/pci.c
> > @@ -1870,20 +1870,10 @@ static int pci_enable_device_flags(struc
> >       int err;
> >       int i, bars = 0;
> >
> > -     /*
> > -      * Power state could be unknown at this point, either due to a fresh
> > -      * boot or a device removal call.  So get the current power state
> > -      * so that things like MSI message writing will behave as expected
> > -      * (e.g. if the device really is in D0 at enable time).
> > -      */
> > -     if (dev->pm_cap) {
> > -             u16 pmcsr;
> > -             pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > -             dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> > -     }
> > -
> > -     if (atomic_inc_return(&dev->enable_cnt) > 1)
> > +     if (atomic_inc_return(&dev->enable_cnt) > 1) {
> > +             pci_update_current_state(dev, dev->current_state);
> >               return 0;               /* already enabled */
> > +     }
> >
> >       bridge = pci_upstream_bridge(dev);
> >       if (bridge)
>
> A user in Debian reported that this commit caused an issue, cf.
> https://bugs.debian.org/990008#10 with the e1000e driver failing to
> probe the device. It was reported as well to
> https://bugzilla.kernel.org/show_bug.cgi?id=213481
>
> According to the above and
> https://bugzilla.kernel.org/show_bug.cgi?id=213481#c2 reverting
> 4514d991d992 ("PCI: PM: Do not read power state in
> pci_enable_device_flags()") fixes the issue.

This commit has just been reverted.

We will try to address the original issue addressed by it in a different way.

Thanks!
