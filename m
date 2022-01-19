Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2A2494105
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jan 2022 20:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242226AbiASTiU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jan 2022 14:38:20 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]:46762 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbiASTiU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jan 2022 14:38:20 -0500
Received: by mail-qt1-f169.google.com with SMTP id v7so3074622qtw.13;
        Wed, 19 Jan 2022 11:38:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kubu8IvDNwwME1j4zVCQMiONGCZPxPM8rnY5h07fCRo=;
        b=54aHOnyGU2YTScI5iPeiZGhLjGbxM7uiNmcCOWFvMHUZy1WhF7AIw9s1sxc5HmLEVD
         yhxAIjnZsmCYbeHW7wA/Dg8+MoFuny7l96vcrzJ/FTZZ7lxUQ9MZwLGz5uZRqCPzldtO
         sfpzX666SzP72pUBZ+9w2szAKbXCivgYzYQkwaGNSmEeatgSCKa5TtZPLd7b3KTJydwh
         ylGve/gw2BLU0oFqUnz1lx7iY//Wqq+W2dI7oPxUUICNZONENjS/8uhi8mM+T4TK84CT
         4l/QBYILW/OWqINMcL41Pzx7Ipp2DT9Jq/Kujyr3y5Hv8tLDOvPsjh0UIJ6fdh9vmFUQ
         3USA==
X-Gm-Message-State: AOAM5323r8Y64kDMYtZeSYiA6Fh+vKROuOn4j7pGVyDeVljjglg9bcdV
        CtiyvUyK5yXui6VduRf2+W8Jn14NGF8Or+H46ZQ5XNMOV2w=
X-Google-Smtp-Source: ABdhPJww649KQAvU5MHy9ei2oMvkYYYf3yQmYqCCV4BNCnFgjZZF+6JFo7HalQlVXdTB1xMaPlTG7mymsomqoM+lOI8=
X-Received: by 2002:a05:622a:293:: with SMTP id z19mr377959qtw.302.1642621099179;
 Wed, 19 Jan 2022 11:38:19 -0800 (PST)
MIME-Version: 1.0
References: <cadbd4eb-40bb-1fa8-1e00-dc95dab62295@gmail.com>
 <CAJZ5v0gH3xK3g01S0CLe235QTF6=A0EB+Zwuv50=WaJaRsCT+w@mail.gmail.com>
 <28e851d8-50cf-ee58-b340-1138a37990f6@gmail.com> <CAJZ5v0jKBSxHXf_N8BgtiOYnoxz9UUCZP8UwAHcFt_-6z4TozQ@mail.gmail.com>
 <46bbb2e4-4d51-990b-1ca4-f7fdfda9489d@gmail.com>
In-Reply-To: <46bbb2e4-4d51-990b-1ca4-f7fdfda9489d@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Jan 2022 20:38:08 +0100
Message-ID: <CAJZ5v0jc5kBzz3Rmf3e2QOsC9jwfk-vGQ4kkXWBjYJgHBXAynQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Forbid RPM on ACPI systems before 5.0 only
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 18, 2022 at 6:42 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 18.01.2022 18:11, Rafael J. Wysocki wrote:
> > On Tue, Jan 18, 2022 at 5:57 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >>
> >> On 18.01.2022 17:28, Rafael J. Wysocki wrote:
> >>> On Mon, Jan 17, 2022 at 11:52 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >>>>
> >>>> Currently PCI core forbids RPM and requires opt-in from userspace,
> >>>> apart from few drivers calling pm_runtime_allow(). Reason is that some
> >>>> early ACPI PM implementations conflict with RPM, see [0].
> >>>> Note that as of today pm_runtime_forbid() is also called for non-ACPI
> >>>> systems. Maybe it's time to allow RPM per default for non-ACPI systems
> >>>> and recent enough ACPI versions. Let's allow RPM from ACPI 5.0 which
> >>>> was published in 2011.
> >>>>
> >>>> [0] https://lkml.org/lkml/2020/11/17/1548
> >>>>
> >>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >>>> ---
> >>>>  drivers/pci/pci.c | 7 ++++++-
> >>>>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >>>> index 428afd459..26e3a500c 100644
> >>>> --- a/drivers/pci/pci.c
> >>>> +++ b/drivers/pci/pci.c
> >>>> @@ -3101,7 +3101,12 @@ void pci_pm_init(struct pci_dev *dev)
> >>>>         u16 status;
> >>>>         u16 pmc;
> >>>>
> >>>> -       pm_runtime_forbid(&dev->dev);
> >>>> +#ifdef CONFIG_ACPI
> >>>> +       /* Some early ACPI PM implementations conflict with RPM. */
> >>>> +       if (acpi_gbl_FADT.header.revision > 0 &&
> >>>> +           acpi_gbl_FADT.header.revision < 5)
> >>>> +               pm_runtime_forbid(&dev->dev);
> >>>> +#endif
> >>>
> >>> Well, there are two things here.
> >>>
> >>> First, there were systems in which ACPI PM was not ready for changing
> >>> power states in the S0 system state (ie. run-time) and it was assuming
> >>> that power states would only be changed during transitions to sleep
> >>> states (S1 - S4) and to S5.  This can be covered by the ACPI revicion
> >>> check, but I'm not sure if ACPI 5.0 is the right one.  Why ACPI 5 and
> >>> not ACPI 6, for instance?
> >>>
> >> Just based on the assumption that ACPI 5.0 should be recent enough.
> >> We can also go with ACPI 6.
> >
> > I know that we can, the question is whether or not we should.
> >
> > IOW, there needs to be at least some technical grounds on which to
> > assume that a given ACPI release is safe enough.
> >
> When ACPI 5 was published the workaround to disable RPM in general
> was in place already. I'd assume that the majority of users does not
> opt in for RPM, therefore it may be hard to find out whether any
> system with ACPI 5 or ACPI 6 suffers from the same problem as the
> affected old systems.

Which kind of demonstrates the problem with the proposed approach
which is based on speculation.

> >>> Second, there were PCI devices without ACPI PM where the PCI standard
> >>> PM didn't work correctly.  This is not related to ACPI at all and I'm
> >>> not sure why the ACPI revision check would be sufficient to cover
> >>> these cases.
> >>>
> >> Didn't know that there were such cases. Can you provide any examples or
> >> links to reports about such misbehaving devices?
> >
> > Admittedly, I don't have a list of them, so I would need to look them
> > up and not just in the mailing lists.
> >
> >>>>         pm_runtime_set_active(&dev->dev);
> >>>>         pm_runtime_enable(&dev->dev);
> >>>>         device_enable_async_suspend(&dev->dev);
> >>>> --
> >
> > Also note that this change will allow PM-runtime to be used on PCI
> > devices without drivers by default and that may not be entirely safe
> > either.  It didn't work really well in the past IIRC, so I'm wondering
> > what's the reason to believe that it will work just fine this time.
>
> >From "Documentation/power/pci.rst":
> If a PCI driver implements the runtime PM callbacks and intends to use the
> runtime PM framework provided by the PM core and the PCI subsystem, it needs
> to decrement the device's runtime PM usage counter in its probe callback
> function.  If it doesn't do that, the counter will always be different from
> zero for the device and it will never be runtime-suspended.

I'm not sure how this is related to what I said above.

> Having said that I don't see how there can be a RPM-related problem w/o
> the driver calling one of the RPM put functions. Maybe some of the problems
> in the past were caused by PCI core bugs that have long been fixed.
>
> To reduce the risk we could enable RPM for a certain subset of PCI devices
> only in a first step, e.g. for PCIe devices.

I'm still not sure if runtime-suspending them when they have no
drivers is a good idea.

It might be better to somehow do the pm_runtime_allow() automatically
in local_pci_probe() if the usage counter is 1 and power.runtime_auto
is false after running the driver's ->probe() callback.
