Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5546D81F1
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 23:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfJOVT5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 17:19:57 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39208 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfJOVT5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 17:19:57 -0400
Received: by mail-ot1-f67.google.com with SMTP id s22so18257509otr.6;
        Tue, 15 Oct 2019 14:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwSWuftbUgGHTdFPApJuvKNyN7XsdaW8Fit8ZchKBoY=;
        b=f9mdMu/W313556x+fpQGwusdUAWLKUf7ag+Le16N/FkC3BX8AQPFPgX3N2TAffD3Cz
         b9hV1rBClNFOyieg8joIOQZZLNoJyH+PXNOSehLgVvyN0bM2TzBwujtdybgR5cEBbWt7
         OsKoHYmYjufEkMoTuTIjhztta5SVGTkflPr+iJ9KJ7s6flyDzNRLLmApOAgiw4MG5tXg
         FOCiiYJoRt0STgmk0pebJmiad+PMq+KktxF2YodtOkOr2sEsa49i3SxVRawze6cv/qJD
         ZNqj+YyunKDyiXltSUu8aBtN6bTJB4RVukspFsPRFQh6VyJCGFQ003MOJZYWkurBMUjE
         u4Kg==
X-Gm-Message-State: APjAAAVsUsUukcI1A0kYrL8uZl731GHquztMi/NW4SaDC9pqLxoIXb3K
        QBY2KbC3tBwecvAShRGcdLdZFSUzWRMYgDLD+LOTJK4x
X-Google-Smtp-Source: APXvYqyLsJtoxGgofhwR5hK08b0Hi0cbUYi2KdDemnuwKHLLcBnxJN18buv98ShZJEGWZ/HnpNdz0w6c/YNNOgjXIs4=
X-Received: by 2002:a9d:5a0f:: with SMTP id v15mr31684717oth.266.1571174396197;
 Tue, 15 Oct 2019 14:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <5720276.eiOaOx1Qyb@kreacher> <20191015192013.GA115182@google.com>
In-Reply-To: <20191015192013.GA115182@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Oct 2019 23:19:44 +0200
Message-ID: <CAJZ5v0jFSML6cf5Z6ot2vZs9b3QomYLM3SaDMvooTmngeSCcBQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: PM: Fix pci_power_up()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 15, 2019 at 9:20 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Oct 14, 2019 at 01:25:00PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > There is an arbitrary difference between the system resume and
> > runtime resume code paths for PCI devices regarding the delay to
> > apply when switching the devices from D3cold to D0.
> >
> > Namely, pci_restore_standard_config() used in the runtime resume
> > code path calls pci_set_power_state() which in turn invokes
> > __pci_start_power_transition() to power up the device through the
> > platform firmware and that function applies the transition delay
> > (as per PCI Express Base Specification Revision 2.0, Section 6.6.1).
> > However, pci_pm_default_resume_early() used in the system resume
> > code path calls pci_power_up() which doesn't apply the delay at
> > all and that causes issues to occur during resume from
> > suspend-to-idle on some systems where the delay is required.
> >
> > Since there is no reason for that difference to exist, modify
> > pci_power_up() to follow pci_set_power_state() more closely and
> > invoke __pci_start_power_transition() from there to call the
> > platform firmware to power up the device (in case that's necessary).
> >
> > Fixes: db288c9c5f9d ("PCI / PM: restore the original behavior of pci_set_power_state()")
> > Reported-by: Daniel Drake <drake@endlessm.com>
> > Link: https://lore.kernel.org/linux-pm/CAD8Lp44TYxrMgPLkHCqF9hv6smEurMXvmmvmtyFhZ6Q4SE+dig@mail.gmail.com/T/#m21be74af263c6a34f36e0fc5c77c5449d9406925
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Daniel, please test this one.
> >
> > ---
> >  drivers/pci/pci.c |   24 +++++++++++-------------
> >  1 file changed, 11 insertions(+), 13 deletions(-)
> >
> > Index: linux-pm/drivers/pci/pci.c
> > ===================================================================
> > --- linux-pm.orig/drivers/pci/pci.c
> > +++ linux-pm/drivers/pci/pci.c
> > @@ -959,19 +959,6 @@ void pci_refresh_power_state(struct pci_
> >  }
> >
> >  /**
> > - * pci_power_up - Put the given device into D0 forcibly
> > - * @dev: PCI device to power up
> > - */
> > -void pci_power_up(struct pci_dev *dev)
> > -{
> > -     if (platform_pci_power_manageable(dev))
> > -             platform_pci_set_power_state(dev, PCI_D0);
> > -
> > -     pci_raw_set_power_state(dev, PCI_D0);
> > -     pci_update_current_state(dev, PCI_D0);
> > -}
> > -
> > -/**
> >   * pci_platform_power_transition - Use platform to change device power state
> >   * @dev: PCI device to handle.
> >   * @state: State to put the device into.
> > @@ -1154,6 +1141,17 @@ int pci_set_power_state(struct pci_dev *
> >  EXPORT_SYMBOL(pci_set_power_state);
> >
> >  /**
> > + * pci_power_up - Put the given device into D0 forcibly
>
> Not specifically for this patch, but what does "forcibly" mean?
>
> > + * @dev: PCI device to power up
> > + */
> > +void pci_power_up(struct pci_dev *dev)
> > +{
> > +     __pci_start_power_transition(dev, PCI_D0);
> > +     pci_raw_set_power_state(dev, PCI_D0);
> > +     pci_update_current_state(dev, PCI_D0);
>
> There's not very much difference between:
>
>   pci_power_up(dev);
>
> and
>
>   pci_set_power_state(dev, PCI_D0);
>
> It looks like the main difference is that pci_set_power_state() calls
> __pci_complete_power_transition(), which ultimately calls
> acpi_pci_set_power_state() (for ACPI systems).

Yes, it does, for power states deeper than D0, which is not the case here.

The main difference is the dev->current_state == state check in
pci_set_power_state(), but in the resume case specifically
dev->current_state == PCI_D0 doesn't matter, because the real power
state of the device may be different.

> So maybe "forcibly" means something like "ignoring any platform power
> management methods"?

It means "go into D0 no matter what the current cached value is".

>  It's not obvious to me when we should skip the
> platform stuff or whether the skipping should be done at the high
> level (like calling either pci_power_up() or pci_set_power_state()) or
> at a lower level (e.g., if everybody called pci_set_power_state() and
> it could internally tell whether we're skipping the platform part).

For transitions into D0 __pci_start_power_transition() is the platform
stuff, so we don't skip it and the other things that are present in
pci_set_power_state() and are not there in pci_power_up() are simply
unnecessary for transitions to D0.

> If we could unify the paths as much as possible, that would be nice,
> but if it's not feasible, it's not feasible.

It kind of is, but I'd prefer to do it on top of this patch.

First, the pci_update_current_state() in pci_power_up() can be moved
to pci_pm_default_resume_early() which is the only caller of
pci_power_up(). [The role of that pci_update_current_state() is to
change the current_state value to D3cold if the device is not
accessible (or the platform firmware says that it is D3cold, which may
be the case after a failing attempt to use it to switch the device
over to D0).]  Next, if pci_power_up() is modified to return the
return value of pci_raw_set_power_state(), pci_set_power_state() can
be implemented (roughly) as

sanitize the state argument

if (dev->current_state == state)
        return 0;

if (state == PCI_D0)
        return pci_power_up();

carry out a transition into a deeper power state.

And so pci_power_up() will be used by pci_set_power_state(), for
transitions into D0, and (directly) by pci_pm_default_resume_early().

How does that sound?

> If you'd like me to push this for v5.4, let me know, otherwise you
> can apply my:
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I will, thanks!
