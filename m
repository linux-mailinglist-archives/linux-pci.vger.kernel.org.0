Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7764F347CDF
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 16:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbhCXPn5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 11:43:57 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:40489 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236704AbhCXPn0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Mar 2021 11:43:26 -0400
Received: by mail-ot1-f53.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so23147728otb.7;
        Wed, 24 Mar 2021 08:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2LlnlKXH3YzdwPwZvOCp+nvzSAq22UqWfFbrRfMlBJc=;
        b=eZ9uKHrR5WrnJOBBzqa1m1UU/gUVA9ls3rbI7C3VL1xRgTAShPfML7QdfufX38OBFC
         IkZqA4ZTD6pRnDfgoxFR8XtGy1hKfmB7pQ2oBFvRxYlInoV3gOCOCovZn1aPJbRO7gI/
         3KK6KSd3I7Qp7BCbhlydgzyj7EgIC6AlLi8epvb+x8StkUsnKX43dVG9EBuhJIESuM/Z
         uNrAGUfG6dQO7u0dsKOs6lok+OXd81kWm8N5YjvowrIiiWYmzsiQLtJFMTZBKLSnATkl
         pdcjHmXU61CVF2TVJQ5n0fvfeu9YrEIpVx7diKR4ODLKIJ/hphCogmvuvDOyO/+ONI1q
         /IBw==
X-Gm-Message-State: AOAM5328Ee+d0cOEt7JMSGU5uOpOIy4iSb4wcexX/ccZ0sH9ehDknwmk
        lxa6ODqilxB7vkJgJxg52PII1JE1AvosJr1ZjNI=
X-Google-Smtp-Source: ABdhPJxNMKZPyOtlHWS9CFGr1m+5WKdkr7FCUdWw3lktEmn/S/Ih+XgaUBMc39h6BnJOQ1THP81t3kXd4HWkbwC8oLk=
X-Received: by 2002:a05:6830:20d2:: with SMTP id z18mr3673941otq.260.1616600605781;
 Wed, 24 Mar 2021 08:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <3219454.74lMxhSOWB@kreacher> <CAJZ5v0gkhfRRGLpqLN555O7RG3jmScfxTTAzz6AgFrOoh42e=g@mail.gmail.com>
In-Reply-To: <CAJZ5v0gkhfRRGLpqLN555O7RG3jmScfxTTAzz6AgFrOoh42e=g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Mar 2021 16:43:14 +0100
Message-ID: <CAJZ5v0hu+UTZm+SaZtnaer7XZ-BQhOR_AAzdZwB0mBdYLYpFKQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: PM: Do not read power state in pci_enable_device_flags()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 22, 2021 at 3:32 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Mar 16, 2021 at 4:52 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
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
>
> Bjorn, can I take this, or do you want to take care of it yourself?

I'm taking the silence as consent, so the patch has been applied as
5.13 material with the R-by from Mika.

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
> >         int err;
> >         int i, bars = 0;
> >
> > -       /*
> > -        * Power state could be unknown at this point, either due to a fresh
> > -        * boot or a device removal call.  So get the current power state
> > -        * so that things like MSI message writing will behave as expected
> > -        * (e.g. if the device really is in D0 at enable time).
> > -        */
> > -       if (dev->pm_cap) {
> > -               u16 pmcsr;
> > -               pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > -               dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> > -       }
> > -
> > -       if (atomic_inc_return(&dev->enable_cnt) > 1)
> > +       if (atomic_inc_return(&dev->enable_cnt) > 1) {
> > +               pci_update_current_state(dev, dev->current_state);
> >                 return 0;               /* already enabled */
> > +       }
> >
> >         bridge = pci_upstream_bridge(dev);
> >         if (bridge)
> >
> >
> >
