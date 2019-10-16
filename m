Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F154FD9DAE
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 23:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394683AbfJPVsg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 17:48:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394663AbfJPVsg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Oct 2019 17:48:36 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC378C028358
        for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2019 21:48:35 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id m20so216034qtq.16
        for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2019 14:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QborS368Ajr5BbVEVEpxWdvLBweeVUiSSgjGJk+rcJ8=;
        b=A2AUK9nUyhjFTlCOpe2ak+XIWxESrOyvv/4FJlhWbLzX15ddN1BBSDU7NJOuThN6W1
         bM6peeK4fFuqfKH3sAQWTkCXGI1woPrL62iC/dIqyls/eRJDW3jJSayDrXnMUGxtJ+Qi
         WcAwq4WQDej7gj9bvr/rgMVnEw1KwJ+mkgVX86FOdpuZTJWm6qeoivgyGdgKoJ2w9C9p
         tGpVr4Uabj0e+BirIJXJ/iwfR2v/mWkOAD96KBBDfnf3YqyXNTDiow6jAe80pAcAL2mr
         dJzQBBDtbKMvAb9NkGna7bqwECK3WhVivkNWCRhWW4FltbsKPjMx0A8Z/GU0z00bP2hh
         WQgA==
X-Gm-Message-State: APjAAAVSnoEBQ3nR25RC34EH8sS8k7klsarTV9xB2KGRO3NRs1zbZVpj
        VjhGf8169SDlMQSvG7rZoSdofQr0Ztww2A9o65RC5MJ4EZMOhRmAKtEd6S7pj7uBxicgyItE525
        e0JlEd8cIV7tPPcfNVvnGklmX8s9/2Gz50Kfh
X-Received: by 2002:a05:620a:718:: with SMTP id 24mr87455qkc.157.1571262514808;
        Wed, 16 Oct 2019 14:48:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzVAXETPoHb1C+3a9i2Ionj1YmrL2Oz6IWFpXhjfCSWTuUZ1T1NFQTTKzGbexXPoe0TiIBXqpKiqboNgzd7Ymo=
X-Received: by 2002:a05:620a:718:: with SMTP id 24mr87423qkc.157.1571262514349;
 Wed, 16 Oct 2019 14:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <CACO55ttOJaXKWmKQQbMAQRJHLXF-VtNn58n4BZhFKYmAdfiJjA@mail.gmail.com>
 <20191016213722.GA72810@google.com>
In-Reply-To: <20191016213722.GA72810@google.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 16 Oct 2019 23:48:22 +0200
Message-ID: <CACO55tuXck7vqGVLmMBGFg6A2pr3h8koRuvvWHLNDH8XvBVxew@mail.gmail.com>
Subject: Re: [PATCH v3] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        Mika Westerberg <mika.westerberg@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 16, 2019 at 11:37 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc linux-acpi]
>
> On Wed, Oct 16, 2019 at 09:18:32PM +0200, Karol Herbst wrote:
> > but setting the PCI_DEV_FLAGS_NO_D3 flag does prevent using the
> > platform means of putting the device into D3cold, right? That's
> > actually what should still happen, just the D3hot step should be
> > skipped.
>
> If I understand correctly, when we put a device in D3cold on an ACPI
> system, we do something like this:
>
>   pci_set_power_state(D3cold)
>     if (PCI_DEV_FLAGS_NO_D3)
>       return 0                                   <-- nothing at all if quirked
>     pci_raw_set_power_state
>       pci_write_config_word(PCI_PM_CTRL, D3hot)  <-- set to D3hot
>     __pci_complete_power_transition(D3cold)
>       pci_platform_power_transition(D3cold)
>         platform_pci_set_power_state(D3cold)
>           acpi_pci_set_power_state(D3cold)
>             acpi_device_set_power(ACPI_STATE_D3_COLD)
>               ...
>                 acpi_evaluate_object("_OFF")     <-- set to D3cold
>
> I did not understand the connection with platform (ACPI) power
> management from your patch.  It sounds like you want this entire path
> except that you want to skip the PCI_PM_CTRL write?
>

exactly. I am running with this workaround for a while now and never
had any fails with it anymore. The GPU gets turned off correctly and I
see the same power savings, just that the GPU can be powered on again.

> That seems like something Rafael should weigh in on.  I don't know
> why we set the device to D3hot with PCI_PM_CTRL before using the ACPI
> methods, and I don't know what the effect of skipping that is.  It
> seems a little messy to slice out this tiny piece from the middle, but
> maybe it makes sense.
>

afaik when I was talking with others in the past about it, Windows is
doing that before using ACPI calls, but maybe they have some similar
workarounds for certain intel bridges as well? I am sure it affects
more than the one I am blacklisting here, but I rather want to check
each device before blacklisting all kabylake and sky lake bridges (as
those are the ones were this issue can be observed).

Sadly we had no luck getting any information about such workaround out
of Nvidia or Intel.

> > On Wed, Oct 16, 2019 at 9:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Wed, Oct 16, 2019 at 04:44:49PM +0200, Karol Herbst wrote:
> > > > Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher device
> > > > states.
> > > >
> > > > v2: convert to pci_dev quirk
> > > >     put a proper technical explanation of the issue as a in-code comment
> > > > v3: disable it only for certain combinations of intel and nvidia hardware
> > > >
> > > > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > Cc: Lyude Paul <lyude@redhat.com>
> > > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > > Cc: Mika Westerberg <mika.westerberg@intel.com>
> > > > Cc: linux-pci@vger.kernel.org
> > > > Cc: linux-pm@vger.kernel.org
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Cc: nouveau@lists.freedesktop.org
> > > > ---
> > > >  drivers/pci/pci.c    | 11 ++++++++++
> > > >  drivers/pci/quirks.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/pci.h  |  1 +
> > > >  3 files changed, 64 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index b97d9e10c9cc..8e056eb7e6ff 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -805,6 +805,13 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
> > > >       return pci_platform_pm ? pci_platform_pm->bridge_d3(dev) : false;
> > > >  }
> > > >
> > > > +static inline bool parent_broken_child_pm(struct pci_dev *dev)
> > > > +{
> > > > +     if (!dev->bus || !dev->bus->self)
> > > > +             return false;
> > > > +     return dev->bus->self->broken_nv_runpm && dev->broken_nv_runpm;
> > > > +}
> > > > +
> > > >  /**
> > > >   * pci_raw_set_power_state - Use PCI PM registers to set the power state of
> > > >   *                        given PCI device
> > > > @@ -850,6 +857,10 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
> > > >          || (state == PCI_D2 && !dev->d2_support))
> > > >               return -EIO;
> > > >
> > > > +     /* check if the bus controller causes issues */
> > > > +     if (state != PCI_D0 && parent_broken_child_pm(dev))
> > > > +             return 0;
> > > > +
> > > >       pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > > >
> > > >       /*
> > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > index 44c4ae1abd00..c2f20b745dd4 100644
> > > > --- a/drivers/pci/quirks.c
> > > > +++ b/drivers/pci/quirks.c
> > > > @@ -5268,3 +5268,55 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
> > > >  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
> > > >                             PCI_CLASS_DISPLAY_VGA, 8,
> > > >                             quirk_reset_lenovo_thinkpad_p50_nvgpu);
> > > > +
> > > > +/*
> > > > + * Some Intel PCIe bridges cause devices to disappear from the PCIe bus after
> > > > + * those were put into D3cold state if they were put into a non D0 PCI PM
> > > > + * device state before doing so.
> > > > + *
> > > > + * This leads to various issue different issues which all manifest differently,
> > > > + * but have the same root cause:
> > > > + *  - AIML code execution hits an infinite loop (as the coe waits on device
> > > > + *    memory to change).
> > > > + *  - kernel crashes, as all pci reads return -1, which most code isn't able
> > > > + *    to handle well enough.
> > > > + *  - sudden shutdowns, as the kernel identified an unrecoverable error after
> > > > + *    userspace tries to access the GPU.
> > > > + *
> > > > + * In all cases dmesg will contain at least one line like this:
> > > > + * 'nouveau 0000:01:00.0: Refused to change power state, currently in D3'
> > > > + * followed by a lot of nouveau timeouts.
> > > > + *
> > > > + * ACPI code writes bit 0x80 to the not documented PCI register 0x248 of the
> > > > + * PCIe bridge controller in order to power down the GPU.
> > > > + * Nonetheless, there are other code paths inside the ACPI firmware which use
> > > > + * other registers, which seem to work fine:
> > > > + *  - 0xbc bit 0x20 (publicly available documentation claims 'reserved')
> > > > + *  - 0xb0 bit 0x10 (link disable)
> > > > + * Changing the conditions inside the firmware by poking into the relevant
> > > > + * addresses does resolve the issue, but it seemed to be ACPI private memory
> > > > + * and not any device accessible memory at all, so there is no portable way of
> > > > + * changing the conditions.
> > > > + *
> > > > + * The only systems where this behavior can be seen are hybrid graphics laptops
> > > > + * with a secondary Nvidia Pascal GPU. It cannot be ruled out that this issue
> > > > + * only occurs in combination with listed Intel PCIe bridge controllers and
> > > > + * the mentioned GPUs or if it's only a hw bug in the bridge controller.
> > > > + *
> > > > + * But because this issue was NOT seen on laptops with an Nvidia Pascal GPU
> > > > + * and an Intel Coffee Lake SoC, there is a higher chance of there being a bug
> > > > + * in the bridge controller rather than in the GPU.
> > > > + *
> > > > + * This issue was not able to be reproduced on non laptop systems.
> > > > + */
> > > > +
> > > > +static void quirk_broken_nv_runpm(struct pci_dev *dev)
> > > > +{
> > > > +     dev->broken_nv_runpm = 1;
> > >
> > > Can you use the existing PCI_DEV_FLAGS_NO_D3 flag for this instead of
> > > adding a new flag?
> > >
> > > I would put the parent_broken_child_pm() logic here, if possible,
> > > e.g., something like:
> > >
> > >   struct pci_dev *bridge = pci_upstream_bridge(dev);
> > >
> > >   if (bridge &&
> > >       bridge->vendor == PCI_VENDOR_ID_INTEL && bridge->device == 0x1901)
> > >         dev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
> > >
> > > > +}
> > > > +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> > > > +                           PCI_BASE_CLASS_DISPLAY, 16,
> > > > +                           quirk_broken_nv_runpm);
> > > > +/* kaby lake */
> > > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1901,
> > > > +                     quirk_broken_nv_runpm);
> > > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > > index ac8a6c4e1792..903a0b3a39ec 100644
> > > > --- a/include/linux/pci.h
> > > > +++ b/include/linux/pci.h
> > > > @@ -416,6 +416,7 @@ struct pci_dev {
> > > >       unsigned int    __aer_firmware_first_valid:1;
> > > >       unsigned int    __aer_firmware_first:1;
> > > >       unsigned int    broken_intx_masking:1;  /* INTx masking can't be used */
> > > > +     unsigned int    broken_nv_runpm:1;      /* some combinations of intel bridge controller and nvidia GPUs break rtd3 */
> > > >       unsigned int    io_window_1k:1;         /* Intel bridge 1K I/O windows */
> > > >       unsigned int    irq_managed:1;
> > > >       unsigned int    has_secondary_link:1;
> > > > --
> > > > 2.21.0
> > > >
