Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70C7CD99D9
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 21:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbfJPTSr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 15:18:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbfJPTSq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Oct 2019 15:18:46 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1267C81F11
        for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2019 19:18:46 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id d25so24702170qkk.17
        for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2019 12:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/80yb/oOmyIBcoEfrbikH3HGafwnqok36b0yp7q1QSw=;
        b=n9r3llND+bIYsbOWNt5oywpJdYwlzzb/OLtM4EaPp2RQllqVbJyxE+iAS3ZCDwhJmP
         PUil5OPtfCrmUipyfsZWr7sMB8P/ZAmTZZLpvzyPjuXk+VXaeqpBPlKIgqSjyeW6hH83
         NGfbIcQk3EtHq/9umm6e2+30ihc5RkkZkn+5ADvCzRWFL/7ZOAtYYzVwyJ2ZZZZKogV3
         Twiq7z9bknaN3UEsjCZMEygVi42Vlsx7rjcshyVcNJj29/CyJeAmKZ3KMY1M+jFCvPNP
         mAhI5HDFHYBgz411THhXBsSZRcJdr1v4jtn+s+XJmlD20ZMHN5b9Bbef4vpYhTrpIyJr
         tLDA==
X-Gm-Message-State: APjAAAVG6iXcdtUxUvJJnM50CULzMVxPlL1lpuMVO6vEi1GH4LM1XqQb
        SOstYJ5fzguJgeC8huKeRyZD5p55PrlyjUQJKJJR6bYNZ2FAIY+m4Yt1KbpesAJO4ddEgsvxGGI
        qjuU1tVTHP0l0UuT5dwT9/XBHJcCH77E02tuQ
X-Received: by 2002:ac8:2fe5:: with SMTP id m34mr45948269qta.254.1571253525364;
        Wed, 16 Oct 2019 12:18:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw/3HiT7nhi/MzRf4Tbd+P+DknuXiO46xBf/PXguJN8MQOF7K/dZdL2WHTaARMthMC+YIiwVL37F9mvrRVS8PQ=
X-Received: by 2002:ac8:2fe5:: with SMTP id m34mr45948248qta.254.1571253525032;
 Wed, 16 Oct 2019 12:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191016144449.24646-1-kherbst@redhat.com> <20191016191424.GA59381@google.com>
In-Reply-To: <20191016191424.GA59381@google.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 16 Oct 2019 21:18:32 +0200
Message-ID: <CACO55ttOJaXKWmKQQbMAQRJHLXF-VtNn58n4BZhFKYmAdfiJjA@mail.gmail.com>
Subject: Re: [PATCH v3] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

but setting the PCI_DEV_FLAGS_NO_D3 flag does prevent using the
platform means of putting the device into D3cold, right? That's
actually what should still happen, just the D3hot step should be
skipped.

On Wed, Oct 16, 2019 at 9:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Oct 16, 2019 at 04:44:49PM +0200, Karol Herbst wrote:
> > Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher device
> > states.
> >
> > v2: convert to pci_dev quirk
> >     put a proper technical explanation of the issue as a in-code comment
> > v3: disable it only for certain combinations of intel and nvidia hardware
> >
> > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Mika Westerberg <mika.westerberg@intel.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: nouveau@lists.freedesktop.org
> > ---
> >  drivers/pci/pci.c    | 11 ++++++++++
> >  drivers/pci/quirks.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci.h  |  1 +
> >  3 files changed, 64 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index b97d9e10c9cc..8e056eb7e6ff 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -805,6 +805,13 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
> >       return pci_platform_pm ? pci_platform_pm->bridge_d3(dev) : false;
> >  }
> >
> > +static inline bool parent_broken_child_pm(struct pci_dev *dev)
> > +{
> > +     if (!dev->bus || !dev->bus->self)
> > +             return false;
> > +     return dev->bus->self->broken_nv_runpm && dev->broken_nv_runpm;
> > +}
> > +
> >  /**
> >   * pci_raw_set_power_state - Use PCI PM registers to set the power state of
> >   *                        given PCI device
> > @@ -850,6 +857,10 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
> >          || (state == PCI_D2 && !dev->d2_support))
> >               return -EIO;
> >
> > +     /* check if the bus controller causes issues */
> > +     if (state != PCI_D0 && parent_broken_child_pm(dev))
> > +             return 0;
> > +
> >       pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> >
> >       /*
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 44c4ae1abd00..c2f20b745dd4 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5268,3 +5268,55 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
> >  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
> >                             PCI_CLASS_DISPLAY_VGA, 8,
> >                             quirk_reset_lenovo_thinkpad_p50_nvgpu);
> > +
> > +/*
> > + * Some Intel PCIe bridges cause devices to disappear from the PCIe bus after
> > + * those were put into D3cold state if they were put into a non D0 PCI PM
> > + * device state before doing so.
> > + *
> > + * This leads to various issue different issues which all manifest differently,
> > + * but have the same root cause:
> > + *  - AIML code execution hits an infinite loop (as the coe waits on device
> > + *    memory to change).
> > + *  - kernel crashes, as all pci reads return -1, which most code isn't able
> > + *    to handle well enough.
> > + *  - sudden shutdowns, as the kernel identified an unrecoverable error after
> > + *    userspace tries to access the GPU.
> > + *
> > + * In all cases dmesg will contain at least one line like this:
> > + * 'nouveau 0000:01:00.0: Refused to change power state, currently in D3'
> > + * followed by a lot of nouveau timeouts.
> > + *
> > + * ACPI code writes bit 0x80 to the not documented PCI register 0x248 of the
> > + * PCIe bridge controller in order to power down the GPU.
> > + * Nonetheless, there are other code paths inside the ACPI firmware which use
> > + * other registers, which seem to work fine:
> > + *  - 0xbc bit 0x20 (publicly available documentation claims 'reserved')
> > + *  - 0xb0 bit 0x10 (link disable)
> > + * Changing the conditions inside the firmware by poking into the relevant
> > + * addresses does resolve the issue, but it seemed to be ACPI private memory
> > + * and not any device accessible memory at all, so there is no portable way of
> > + * changing the conditions.
> > + *
> > + * The only systems where this behavior can be seen are hybrid graphics laptops
> > + * with a secondary Nvidia Pascal GPU. It cannot be ruled out that this issue
> > + * only occurs in combination with listed Intel PCIe bridge controllers and
> > + * the mentioned GPUs or if it's only a hw bug in the bridge controller.
> > + *
> > + * But because this issue was NOT seen on laptops with an Nvidia Pascal GPU
> > + * and an Intel Coffee Lake SoC, there is a higher chance of there being a bug
> > + * in the bridge controller rather than in the GPU.
> > + *
> > + * This issue was not able to be reproduced on non laptop systems.
> > + */
> > +
> > +static void quirk_broken_nv_runpm(struct pci_dev *dev)
> > +{
> > +     dev->broken_nv_runpm = 1;
>
> Can you use the existing PCI_DEV_FLAGS_NO_D3 flag for this instead of
> adding a new flag?
>
> I would put the parent_broken_child_pm() logic here, if possible,
> e.g., something like:
>
>   struct pci_dev *bridge = pci_upstream_bridge(dev);
>
>   if (bridge &&
>       bridge->vendor == PCI_VENDOR_ID_INTEL && bridge->device == 0x1901)
>         dev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
>
> > +}
> > +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> > +                           PCI_BASE_CLASS_DISPLAY, 16,
> > +                           quirk_broken_nv_runpm);
> > +/* kaby lake */
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1901,
> > +                     quirk_broken_nv_runpm);
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index ac8a6c4e1792..903a0b3a39ec 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -416,6 +416,7 @@ struct pci_dev {
> >       unsigned int    __aer_firmware_first_valid:1;
> >       unsigned int    __aer_firmware_first:1;
> >       unsigned int    broken_intx_masking:1;  /* INTx masking can't be used */
> > +     unsigned int    broken_nv_runpm:1;      /* some combinations of intel bridge controller and nvidia GPUs break rtd3 */
> >       unsigned int    io_window_1k:1;         /* Intel bridge 1K I/O windows */
> >       unsigned int    irq_managed:1;
> >       unsigned int    has_secondary_link:1;
> > --
> > 2.21.0
> >
