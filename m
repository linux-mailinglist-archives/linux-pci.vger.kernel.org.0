Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6F4492C03
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jan 2022 18:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243715AbiARRLi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jan 2022 12:11:38 -0500
Received: from mail-qv1-f48.google.com ([209.85.219.48]:43847 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243344AbiARRLi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jan 2022 12:11:38 -0500
Received: by mail-qv1-f48.google.com with SMTP id h16so1403507qvk.10;
        Tue, 18 Jan 2022 09:11:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C6xnYJy9mhQZDkCquf0kbTcXl4VO6EeQotUsqTZCsMI=;
        b=BHeyIDbmrEdXqd8yCW9wCwi233mNg8b+CCBOW7DLzPM23l9z6vNFBCFuVH7N4Gqh1c
         YPndn1kphE/gRoXEi2XcDJmZaIFqKm/jkCJgtIlA5VhBFA+oTOiJUm4SFd6gIanBSz4F
         bRlH4XdaA7kChH/bpGBI+aT0krrHN1uuTE2ee/98BlBMsGK6+2s5lvqJdazfrsurKcXi
         /jkjMDIixzd497/QhryLJk1gY8nB9Wm37rOla+M/B0Vvz5sPyVRsAJO+vhRHmn/4AAFW
         Vu6r9jpIABzLu0ooTR0wwM5vwRh+ToqrXRd2p4I1tGYQ7PnjYKoG0B8F43eub0Wv/345
         Fc7A==
X-Gm-Message-State: AOAM5329V1UNF/cu+BLbBvhBV+QcrxJm5LwaLG7AAztyzg6AE/NGYnOy
        TPkF8GO4jn/1aCaUQ5H25OYBXf+IP0m0QilzmqU=
X-Google-Smtp-Source: ABdhPJw6eEseOUPfOAO+6+DgII3qcf+BPIUpf7nZeQKrJJY3OI39eVF2RvgxTXP/0L127IT8F+RrbLpEkyx+IC1mGl4=
X-Received: by 2002:a05:6214:518e:: with SMTP id kl14mr23480470qvb.130.1642525897282;
 Tue, 18 Jan 2022 09:11:37 -0800 (PST)
MIME-Version: 1.0
References: <cadbd4eb-40bb-1fa8-1e00-dc95dab62295@gmail.com>
 <CAJZ5v0gH3xK3g01S0CLe235QTF6=A0EB+Zwuv50=WaJaRsCT+w@mail.gmail.com> <28e851d8-50cf-ee58-b340-1138a37990f6@gmail.com>
In-Reply-To: <28e851d8-50cf-ee58-b340-1138a37990f6@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Jan 2022 18:11:26 +0100
Message-ID: <CAJZ5v0jKBSxHXf_N8BgtiOYnoxz9UUCZP8UwAHcFt_-6z4TozQ@mail.gmail.com>
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

On Tue, Jan 18, 2022 at 5:57 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 18.01.2022 17:28, Rafael J. Wysocki wrote:
> > On Mon, Jan 17, 2022 at 11:52 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >>
> >> Currently PCI core forbids RPM and requires opt-in from userspace,
> >> apart from few drivers calling pm_runtime_allow(). Reason is that some
> >> early ACPI PM implementations conflict with RPM, see [0].
> >> Note that as of today pm_runtime_forbid() is also called for non-ACPI
> >> systems. Maybe it's time to allow RPM per default for non-ACPI systems
> >> and recent enough ACPI versions. Let's allow RPM from ACPI 5.0 which
> >> was published in 2011.
> >>
> >> [0] https://lkml.org/lkml/2020/11/17/1548
> >>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> ---
> >>  drivers/pci/pci.c | 7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index 428afd459..26e3a500c 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -3101,7 +3101,12 @@ void pci_pm_init(struct pci_dev *dev)
> >>         u16 status;
> >>         u16 pmc;
> >>
> >> -       pm_runtime_forbid(&dev->dev);
> >> +#ifdef CONFIG_ACPI
> >> +       /* Some early ACPI PM implementations conflict with RPM. */
> >> +       if (acpi_gbl_FADT.header.revision > 0 &&
> >> +           acpi_gbl_FADT.header.revision < 5)
> >> +               pm_runtime_forbid(&dev->dev);
> >> +#endif
> >
> > Well, there are two things here.
> >
> > First, there were systems in which ACPI PM was not ready for changing
> > power states in the S0 system state (ie. run-time) and it was assuming
> > that power states would only be changed during transitions to sleep
> > states (S1 - S4) and to S5.  This can be covered by the ACPI revicion
> > check, but I'm not sure if ACPI 5.0 is the right one.  Why ACPI 5 and
> > not ACPI 6, for instance?
> >
> Just based on the assumption that ACPI 5.0 should be recent enough.
> We can also go with ACPI 6.

I know that we can, the question is whether or not we should.

IOW, there needs to be at least some technical grounds on which to
assume that a given ACPI release is safe enough.

> > Second, there were PCI devices without ACPI PM where the PCI standard
> > PM didn't work correctly.  This is not related to ACPI at all and I'm
> > not sure why the ACPI revision check would be sufficient to cover
> > these cases.
> >
> Didn't know that there were such cases. Can you provide any examples or
> links to reports about such misbehaving devices?

Admittedly, I don't have a list of them, so I would need to look them
up and not just in the mailing lists.

> >>         pm_runtime_set_active(&dev->dev);
> >>         pm_runtime_enable(&dev->dev);
> >>         device_enable_async_suspend(&dev->dev);
> >> --

Also note that this change will allow PM-runtime to be used on PCI
devices without drivers by default and that may not be entirely safe
either.  It didn't work really well in the past IIRC, so I'm wondering
what's the reason to believe that it will work just fine this time.
