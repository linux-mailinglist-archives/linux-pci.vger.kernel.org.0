Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2163D75BF
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jul 2021 15:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhG0NS2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 09:18:28 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:40838 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236666AbhG0NS1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jul 2021 09:18:27 -0400
Received: by mail-oi1-f177.google.com with SMTP id q6so15032902oiw.7;
        Tue, 27 Jul 2021 06:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ExJ0LotWxubbVajAcl3wn20A9whrV9bAX/MLYMrbYEY=;
        b=Z3BA/FsBiYydtwiti9poWiSpsPjUD0gaePeMdVJFo39x/kMvK3YaHIoXIOgWeujmF8
         Gi4jz2KvPcQArWw2axxDVKJm97vgJMBGwM1GZaScHOYCj2XoVjVjBR8g3sHIMDI1llnn
         MJ7r5MoZdEzDjch2o7iryKSpA6n4xsv5YvSLMSqNi0I1DpRh9+VsRoDnXa9jTtfQgVIl
         tV4BjmZQLmIMFjMKvJnwgPS7MQL8HIteSA6nWBKnKkDjkDDykzcDF6++YISwIF6H4sXI
         26BmnHsqokDgO5YgUUuAsvC1WkyK/IRbBM4IbtLykzurYNDk1D6PH9Y2BtmbO+lLVQiz
         tlBw==
X-Gm-Message-State: AOAM531mABr6LY8C+HhFsJPrgh2RJPj8FwnfVdxV9xzsOz7OKmXQPUQM
        l1aZJuuAFYVz/NsKFZppkDOdnWfS8Hawy+vyfM8=
X-Google-Smtp-Source: ABdhPJxE8sKaO2HwcBrn71zWq3IU3UGLmu2YNIssb+e4f4lsapoxT2OBK4hKrWgUvtOOepvu5el4eoBG2jZgPLZuKu4=
X-Received: by 2002:aca:4f57:: with SMTP id d84mr15104627oib.71.1627391906449;
 Tue, 27 Jul 2021 06:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <5475468.DvuYhMxLoT@kreacher> <YP/mN6kSwMPWW+Mn@lahna>
In-Reply-To: <YP/mN6kSwMPWW+Mn@lahna>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Jul 2021 15:18:15 +0200
Message-ID: <CAJZ5v0iFiax87oWaz+SjZdcaL4fPAH-4Du=eXx-kWTH6RK2DbQ@mail.gmail.com>
Subject: Re: [RFT][PATCH] PCI: PM: Add special case handling for PCIe device wakeup
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 27, 2021 at 12:56 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Mon, Jul 12, 2021 at 07:06:47PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Some PCIe devices only support PME (Power Management Event) from
> > D3cold.  One example is the ASMedia xHCI controller:
> >
> >  11:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller (prog-if 30 [XHCI])
> >    ...
> >    Capabilities: [78] Power Management version 3
> >            Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> >            Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> >
> > In those cases, if the device is expected to generate wakeup events
> > from its final power state, pci_target_state() returns D0, which
> > prevents the PCIe port the device is connected to from entering any
> > low-power states too.  However, if the device were allowed to go into
> > D3hot, its parent PCIe port would also be able to go into D3 and if
> > it goes into D3cold, it would cause the endpoint device to end up in
> > D3cold too (as per the PCI PM spec v1.2, Table 6-1), in which case
> > the endpoint would be able to signal PME.  This means that the system
> > could be put into a lower-power configuration without sacrificing the
> > the given device's ability to generate PME.
> >
> > In order to avoid missing that opportunity, extend pci_pme_capable()
> > to check the device's parent in the special case when the target
> > state is D3hot and the device can only signal PME from D3cold and
> > update pci_target_state() to return the current target state if
> > pci_pme_capable() returns 'true' for it.
>
> Thanks a lot for this!
>
> I tried the patch and unfortunately it does not solve the issue but I
> think I know what the problem is, see below.

OK, it's good that you can access a system having this issue.

> > Link: https://lore.kernel.org/linux-pm/20210617123653.58640-1-mika.westerberg@linux.intel.com
> > Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
> > Reported-by: Koba Ko <koba.ko@canonical.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Hi,
> >
> > Anyone who can reproduce the problem described in the changelog,
> > please test the patch and let me know the result.
> >
> > Thanks!
> >
> > ---
> >  drivers/pci/pci.c |   38 ++++++++++++++++++++++++++------------
> >  1 file changed, 26 insertions(+), 12 deletions(-)
> >
> > Index: linux-pm/drivers/pci/pci.c
> > ===================================================================
> > --- linux-pm.orig/drivers/pci/pci.c
> > +++ linux-pm/drivers/pci/pci.c
> > @@ -2298,10 +2298,29 @@ void pci_pme_wakeup_bus(struct pci_bus *
> >   */
> >  bool pci_pme_capable(struct pci_dev *dev, pci_power_t state)
> >  {
> > +     struct pci_dev *parent;
> > +
> >       if (!dev->pm_cap)
> >               return false;
> >
> > -     return !!(dev->pme_support & (1 << state));
> > +     if (dev->pme_support & (1 << state))
> > +             return true;
> > +
> > +     /*
> > +      * Special case: The target state is D3hot and the device only supports
> > +      * signaling PME from D3cold, but it is a PCIe device whose parent port
> > +      * can go into D3cold.  In that case, if the device is allowed to go
> > +      * into D3hot, the parent port can go into D3cold which will cause the
> > +      * device to end up in D3cold, so it will be able to signal PME from the
> > +      * final state.
> > +      */
> > +     if (state != PCI_D3hot || !(dev->pme_support & (1 << PCI_D3cold)))
> > +             return false;
> > +
> > +     parent = dev->bus->self;
> > +     return pci_bridge_d3_possible(parent) &&
> > +             platform_pci_power_manageable(parent) &&
>
> Here. We cannot assume that the parent has ACPI node either.

I see.  Obviously, I assumed that this was the case.

> For instance when PCIe is tunneled over TBT/USB4 there can be several PCIe
> switches between the problem endpoint and the root port (which has the
> ACPI node of course). I think the safe assumption is to check for the
> root port and whether platform_pci_power_manageable() returns true for
> it but I may be missing something.

Well, if any of the ports on the path between the target endpoint and
the root complex can be put into D3cold via ACPI, the endpoint will
end up in D3cold effectively, so I think that all of them need to be
checked.

Let me change the patch to do that.

> > +             platform_pci_choose_state(parent) == PCI_D3cold;
> >  }
> >  EXPORT_SYMBOL(pci_pme_capable);
> >
> > @@ -2595,17 +2614,12 @@ static pci_power_t pci_target_state(stru
> >       if (dev->current_state == PCI_D3cold)
> >               target_state = PCI_D3cold;
> >
> > -     if (wakeup) {
> > -             /*
> > -              * Find the deepest state from which the device can generate
> > -              * PME#.
> > -              */
> > -             if (dev->pme_support) {
> > -                     while (target_state
> > -                           && !(dev->pme_support & (1 << target_state)))
> > -                             target_state--;
> > -             }
> > -     }
> > +     if (!wakeup || !dev->pme_support || pci_pme_capable(dev, target_state))
> > +             return target_state;
> > +
> > +     /* Find the deepest state from which the device can generate PME#. */
> > +     while (target_state && !(dev->pme_support & (1 << target_state)))
> > +             target_state--;
> >
> >       return target_state;
> >  }
> >
> >
