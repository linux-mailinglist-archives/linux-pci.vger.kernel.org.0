Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 561EE10693A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 10:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKVJtK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 04:49:10 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42673 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKVJtK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 04:49:10 -0500
Received: by mail-oi1-f193.google.com with SMTP id o12so5946924oic.9;
        Fri, 22 Nov 2019 01:49:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PNbKiV+6k7+b+wykrIzmPoYnrmgC3vrubjDeVmiZRhs=;
        b=XVwQ1JiT8RvoGDu6e3WlZSPZQ1J7NdIWQIaGus3zxJIVIypCw0Ic0lk291mn+yQE6F
         4Q+Z81c3ouXtf4+91aWSBDBwd6oIV9gIriXjrjLrO+P+gitHTg+tAlXBfJoCRO3vIMzQ
         1vddng4qFMIRFy8B28HPJ9oJeWCIIa04jwQmlO4ImdF/1MMXM5igXWq342gpm8LHJFZw
         beb5CJaRfzcqJWeEqoPMK9aI3qvxdCSCFzMsIjKkuAILw/dReH3fyoW7otUepos75bzW
         Rx0ZJHheULjuu+bf+MMX8R0g7Wsi2FGtUEwe2ZLK/UxT+LewQnplrBqHpChUP79irAtu
         jnkg==
X-Gm-Message-State: APjAAAXuYdqg9N2LgjcqbKe4/lzZ6ewkS7SDY7ytkMs1uHAj691Btz5G
        fO8cJaOAMp79Nv8xr7/Cl0bFzpv0kGuG3mJ2GAM=
X-Google-Smtp-Source: APXvYqyRz9VSwWJoLGs/NoQ6wjkEvXxseNEUmAP7gSrfGLs4z0zd9AhvIvV7ufYDVH/BFs1mbB0V7W9AesqEmnZco8s=
X-Received: by 2002:a05:6808:901:: with SMTP id w1mr11871220oih.57.1574416148960;
 Fri, 22 Nov 2019 01:49:08 -0800 (PST)
MIME-Version: 1.0
References: <20191122002159.4159-1-kherbst@redhat.com>
In-Reply-To: <20191122002159.4159-1-kherbst@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Nov 2019 10:48:57 +0100
Message-ID: <CAJZ5v0iQttGB4m5TbzCtjp2C1j5qEkUhqhpWb++LhSk3mbW=Lw@mail.gmail.com>
Subject: Re: [PATCH v5] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
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

On Fri, Nov 22, 2019 at 1:22 AM Karol Herbst <kherbst@redhat.com> wrote:
>
> Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher device
> states.
>
> v2: convert to pci_dev quirk
>     put a proper technical explanation of the issue as a in-code comment
> v3: disable it only for certain combinations of intel and nvidia hardware
> v4: simplify quirk by setting flag on the GPU itself
> v5: restructure quirk to make it easier to add new IDs
>     fix whitespace issues
>     fix potential NULL pointer access
>     update the quirk documentation
>
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Mika Westerberg <mika.westerberg@intel.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205623
> ---
>  drivers/pci/pci.c    |  7 ++++++
>  drivers/pci/quirks.c | 51 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h  |  1 +
>  3 files changed, 59 insertions(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 57f15a7e6f0b..e08db2daa924 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -850,6 +850,13 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>            || (state == PCI_D2 && !dev->d2_support))
>                 return -EIO;
>
> +       /*
> +        * Check if we have a bad combination of bridge controller and nvidia
> +        * GPU, see quirk_broken_nv_runpm for more info
> +        */
> +       if (state != PCI_D0 && dev->broken_nv_runpm)
> +               return 0;

The result of this change in the suspend-to-idle path will be leaving
the device and its PCIe port in D0 while suspended, unless the device
itself has power management methods in the ACPI tables (according to
Mika that is not the case).

I don't think that this is desirable.

> +
>         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>
>         /*
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 44c4ae1abd00..24e3f247d291 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5268,3 +5268,54 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
>                               PCI_CLASS_DISPLAY_VGA, 8,
>                               quirk_reset_lenovo_thinkpad_p50_nvgpu);
> +
> +/*
> + * Some Intel PCIe bridge controllers cause devices to not reappear doing a
> + * D0 -> D3hot -> D3cold -> D0 sequence.

This is inaccurate and not entirely fair AFAICS.

First off, what is a "PCIe bridge controller"?  A PCIe root complex?

Second, I don't think that you really can blame hardware here, because
the problem is related to AML (forcing a different code path in AML
makes it go away, so the same hardware with different AML would work).

More precisely, the behavior of the kernel is not what is expected by
AML associated with the PCIe port holding the device.

> Skipping the intermediate D3hot step
> + * seems to make it work again.

Yes, but the change would need to cover both the PM-runtime and
suspend-to-idle code paths.

Also it may be driver-induced rather than quirk-based.

> + *
> + * This leads to various manifestations of this issue:
> + *  - AIML code execution hits an infinite loop (as the coe waits on device

Typo: coe -> code

> + *    memory to change).

Which AML code is this, the power-off part or power-on part?  Is this
AML code associated with the GPU or with the PCIe port holding it (I
guess the latter from what Mika said)?

Also IIRC ACPICA has a mechanism to break infinite loops in AML by
aborting the looping method after a timeout.

> + *  - kernel crashes, as all PCI reads return -1, which most code isn't able
> + *    to handle well enough.
> + *  - sudden shutdowns, as the kernel identified an unrecoverable error after
> + *    userspace tries to access the GPU.

IMO it would be enough to say that the GPU is not accessible after an
attempt to remove power from it.

> + *
> + * In all cases dmesg will contain at least one line like this:
> + * 'nouveau 0000:01:00.0: Refused to change power state, currently in D3'
> + * followed by a lot of nouveau timeouts.
> + *
> + * ACPI code

Which ACPI code?

> writes bit 0x80 to the not documented PCI register 0x248 of the

0x248 relative to what?  A PCI bar (if so then which one) or the PCI
config space (and which part of it if so)?

> + * Intel PCIe bridge controller (0x1901) in order to power down the GPU.

This doesn't seem accurate.  It rather writes to this register to
change the state of the PCIe link between the GPU and the PCIe port
holding it, which is not the same as powering off.

> + * Nonetheless, there are other code paths inside the ACPI firmware which use
> + * other registers, which seem to work fine:

The meaning of the above is unclear.

Does "other" mean "alternative"?

> + *  - 0xbc bit 0x20 (publicly available documentation claims 'reserved')

A pointer to that documentation, please (yes, it should be included in
the comment).

> + *  - 0xb0 bit 0x10 (link disable)
> + * Changing the conditions inside the firmware by poking into the relevant
> + * addresses does resolve the issue,

What does this mean, precisely?

> but it seemed to be ACPI private memory
> + * and not any device accessible memory at all, so there is no portable way of
> + * changing the conditions.
> + *
> + * The only systems where this behavior can be seen are hybrid graphics laptops
> + * with a secondary Nvidia Maxwell, Pascal or Turing GPU. It cannot be ruled
> + * out that this issue only occurs in combination with listed Intel PCIe
> + * bridge controllers and the mentioned GPUs or if it's only a hw bug in the
> + * bridge controller.
> + */

So again, this is AML-related, so talking about hardware bugs at this
point is premature at best.

> +
> +static void quirk_broken_nv_runpm(struct pci_dev *dev)
> +{
> +       struct pci_dev *bridge = pci_upstream_bridge(dev);
> +
> +       if (!bridge || bridge->vendor != PCI_VENDOR_ID_INTEL)
> +               return;
> +
> +       switch (bridge->device) {
> +       case 0x1901:
> +               dev->broken_nv_runpm = 1;
> +       }
> +}
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> +                             PCI_BASE_CLASS_DISPLAY, 16,
> +                             quirk_broken_nv_runpm);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index ac8a6c4e1792..903a0b3a39ec 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -416,6 +416,7 @@ struct pci_dev {
>         unsigned int    __aer_firmware_first_valid:1;
>         unsigned int    __aer_firmware_first:1;
>         unsigned int    broken_intx_masking:1;  /* INTx masking can't be used */
> +       unsigned int    broken_nv_runpm:1;      /* some combinations of intel bridge controller and nvidia GPUs break rtd3 */
>         unsigned int    io_window_1k:1;         /* Intel bridge 1K I/O windows */
>         unsigned int    irq_managed:1;
>         unsigned int    has_secondary_link:1;
> --

Based of what has been uncovered so far, I would propose the following
way to address this issue:

(1) Introduce a "parent_d3cold" PCI device flag that would indicate to
the PCI layer to leave the given device in D0 during suspend (both
system-wide and runtime) and power-manage the parent instead as long
as the parent PCIe port can be put into D3cold via ACPI (and as long
as the downstream device itself has no ACPI PM).
(2) Set this new flag for the GPUs in question from the nouveau driver.

So what about this?
