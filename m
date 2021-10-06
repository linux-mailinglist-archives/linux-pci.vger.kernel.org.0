Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC274247CD
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 22:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhJFURG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 16:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhJFURF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Oct 2021 16:17:05 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BB9C061753
        for <linux-pci@vger.kernel.org>; Wed,  6 Oct 2021 13:15:13 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id on6so3066101pjb.5
        for <linux-pci@vger.kernel.org>; Wed, 06 Oct 2021 13:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kUt43t1yPQSp6yKRQDKehvuZcdKCNEHHgjdiw55b8yc=;
        b=cXjWrLc7Rkhyj/MVhz1RFZ5h+ELNvbY1BK6K3LeGUME4hi15Z1TImR6ZOKhMhLBhLM
         E4t0PFY+CVhEVq3OsmVhJB4+ewKw3aKS0DIWxaJBu7Yo9+cjMFMzFNfkTU0noXnZeSB1
         o2jgI+YbzOgo2vf/UaOXV+trgJvcoF+5iNnxJf0+ebbh136CpGJ6GxF5qb8axP5ESLFm
         Yu/NmKqRiAI7106QLEo9qL5Dq48zCC8kArYEyw4aMn3+42xnmZFgnGj8E2fBAP1qUJDe
         aoF2RzLVS5np7gE1e9Lpn7vtsgFISzCTMDiOVb96axwozhvVSpYHj11lRwh/kb/hPA12
         y72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kUt43t1yPQSp6yKRQDKehvuZcdKCNEHHgjdiw55b8yc=;
        b=XkPvWgGwuc94N17/sg6Y3QuewTCR2xNrlRVkJiUJzJA51xc1JKJN4v7Woh5JscqYr+
         Dt+/Yr+HIscFUL8JiGWblwDu12WlvhFMGw3NWXLJEmMqcbKuM7JZG+r7r+s6Y9jwhkN9
         VZ1i1fdlscQlOqbT61bNIUtJigJnyiZaWh5F6OeQPOZCJvOm4cCQpCmx6oQbJVIwKRYV
         QBXyO/Nisggc6eQtWR3oFCzVGy5CzutNHQ24GnolqS4w+beUZRzL1BUFsYBfKRPTDpAC
         mBULNu+0pv8do1gjtNWZOsQF8VxYJ7iQ8BpDQOSdzRD53FGvZNhnZ5P3N1tJqHAN3Y14
         YBJw==
X-Gm-Message-State: AOAM5301kJr0TqIwymDOuNUWpvrTfoW/dj0PXs+hi6CzqWQCnMaf5zAF
        wUZzLIAUdsZE4LUc4hiI8ck2weJjY5uyTlECkn9c8g==
X-Google-Smtp-Source: ABdhPJw7+9W6M8JnAg6ylSvm1NfQZYkoMfVdQiaPZ5p1HZnbc0Qebltom0kLeQeaD0GKY8karPCzl14neOP0cZygPTM=
X-Received: by 2002:a17:90b:350f:: with SMTP id ls15mr191398pjb.220.1633551312423;
 Wed, 06 Oct 2021 13:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210813213653.3760-1-stuart.w.hayes@gmail.com>
 <5d1eb958c13553d70e4bee7a7b342febcf1c02ee.camel@intel.com> <4bb26dc0-9b82-21d6-0257-d50ec206a130@gmail.com>
In-Reply-To: <4bb26dc0-9b82-21d6-0257-d50ec206a130@gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 6 Oct 2021 13:15:01 -0700
Message-ID: <CAPcyv4iig5rxCNb7GyGV9akhZKLF+OeGhewSbOeAzzA6pKreRA@mail.gmail.com>
Subject: Re: [PATCH v3] Add support for PCIe SSD status LED management
To:     stuart hayes <stuart.w.hayes@gmail.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "lukas@wunner.de" <lukas@wunner.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        mariusz.tkaczyk@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[ add Mariusz from ledmon tool: https://github.com/intel/ledmon ]

On Tue, Oct 5, 2021 at 7:43 PM stuart hayes <stuart.w.hayes@gmail.com> wrote:
>
>
> On 10/5/2021 12:14 AM, Williams, Dan J wrote:
> > On Fri, 2021-08-13 at 17:36 -0400, Stuart Hayes wrote:
> >> This patch adds support for the PCIe SSD Status LED Management
> >> interface, as described in the "_DSM Additions for PCIe SSD Status LED
> >> Management" ECN to the PCI Firmware Specification revision 3.2.
> >>
> >> It will add (led_classdev) LEDs to each PCIe device that has a supported
> >> _DSM interface (one off/on LED per supported state). Both PCIe storage
> >> devices, and the ports to which they are connected, can support this
> >> interface.
> >
> > Can you describe why this chose the drivers/leds/led-class.c route
> > instead of drivers/misc/enclosure.c? Or, something simple / open-coded
> > like drivers/ata/libata-sata.c? If that was already discussed in a
> > previous posting just point me over there. My initial take away is that
> > this is spending effort on gear matching with the led_classdev
> > interface.
> >
> > The comments that follow are just an initial pass based on being
> > suprised about the led_classdev choice and the desire for NPEM support.
> >
> >
>
> Thank you for the comments, Dan.
>
> I originally did submit something simple that just added a couple of
> sysfs attributes to allow userspace access to the _DSM, but Greg K-H
> said (1) that I shouldn't create new driver-specific sysfs files that do
> things that existing class drivers do, and that if I'm allowing LEDs to
> be controlled by the user, I have to use the LED subsystem, so I went
> with that. (See the end of
> https://patchwork.ozlabs.org/project/linux-pci/patch/20201110153735.58587-1-stuart.w.hayes@gmail.com/)

I agree with the general sentiment to adopt and extend existing ABIs
wherever possible, it's just not clear to me that the LED class driver
is the best fit. The Enclosure class infrastructure, in addition to
having some concept of industry standard LED signalling patterns, also
has the concept of linking back to the controller of the storage
device in question. So my gut feel is that it's a better starting
point. If it has some gaps or mismatches with NPEM concepts then
that's a good reason to extend it versus trying to describe the
storage use case to the generic LED class driver.

> I tried to make my code very similar to drivers/input/input-leds.c,
> where up to 11 LEDs per input device are registered.  Since NPEM/_DSM
> allows any of the states to be independently set or cleared, and any of
> the states may or may not be supported, it seemed very similar to me
> (except, as Pavel points out, the NPEM/_DSM states probably won't have
> one LED per state like the keyboard LEDs typically do).
>
> I will look into drivers/misc/enclosure.c.  I think I didn't go that
> route initially as it appeared to be quite old and not widely used, and
> the states don't completely overlap.  More about it below.

The SCSI SES driver takes full advantage of the ENCLOSURE driver-core,
so I suspect layering NPEM / SSD_LED_DSM on top of ENCLOSURE is a
better fit than layering those same concepts on top of LED. As for
usages beyond SES you can see that ledmon avoided the kernel
altogether for its support via direct userspace configuration cycles,
but that's incompatible with ACPI DSMs that need a kernel driver, and
its incompatible with LOCKDOWN_KERNEL where root is disallowed from
issuing configuration write cycles.

>
> >>
> >> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> >> ---
> >> V2:
> >>          * Simplified interface to a single "states" attribute under the LED
> >>            classdev using only state names
> >>          * Reworked driver to separate _DSM specific code, so support for
> >>            NPEM (or other methods) could be easily be added
> >>          * Use BIT macro
> >> V3:
> >>          * Changed code to use a single LED per supported state
> >>          * Moved to drivers/pci/pcie
> >>          * Changed Kconfig dependency to LEDS_CLASS instead of NEW_LEDS
> >>          * Added PCI device class check before _DSM presence check
> >>          * Other cleanups that don't affect the function
> >>
> >> ---
> >>   drivers/pci/pcie/Kconfig    |  11 +
> >>   drivers/pci/pcie/Makefile   |   1 +
> >>   drivers/pci/pcie/ssd-leds.c | 419 ++++++++++++++++++++++++++++++++++++
> >>   3 files changed, 431 insertions(+)
> >>   create mode 100644 drivers/pci/pcie/ssd-leds.c
> >>
> >> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> >> index 45a2ef702b45..b738d473209f 100644
> >> --- a/drivers/pci/pcie/Kconfig
> >> +++ b/drivers/pci/pcie/Kconfig
> >> @@ -142,3 +142,14 @@ config PCIE_EDR
> >>            the PCI Firmware Specification r3.2.  Enable this if you want to
> >>            support hybrid DPC model which uses both firmware and OS to
> >>            implement DPC.
> >> +
> >> +config PCIE_SSD_LEDS
> >> +       tristate "PCIe SSD status LED support"
> >> +       depends on ACPI && LEDS_CLASS
> >
> > This "depends on ACPI" is awkward when this grows NPEM support. I feel
> > like NPEM is the first class citizen and then ACPI optionally overrides
> > NPEM support if present.
> >
> >
>
> I didn't actually think about NPEM when I originally submitted this...
> and even now, as I submitted it, it only uses the _DSM method, so it is
> useless without ACPI.  The ACPI dependency could go if NPEM support was
> added, for sure.

As far as I can tell from the specification NPEM is the discovery
mechanism for which PCI device to perform the _DSM. Maybe someone who
is more familiar with the intent of the specification can clarify, but
I would expect that the driver for the NPEM for a given storage device
would check it's local NPEM first and then walk up the hierarchy to
find the first NPEM instance enabled by platform firmware, then before
using that instance check if the ACPI _DSM is available for that PCI
device and use that instead. Otherwise, it's not clear to me how
software definitely associates a given control interface to a specific
storage, or memory in the case of CXL, device.

>
> >> +       help
> >> +         Driver for PCIe SSD status LED management as described in a PCI
> >> +         Firmware Specification, Revision 3.2 ECN.
> >
> > The auxiliary bus [1] was recently added as a way for drivers to carve
> > off functionality into sub-device / sub-driver pairs. One benefit from
> > the auxiliary bus organization is that the NPEM driver gets a propoer
> > alias and auto-loading support. As is this driver appears to need to be
> > manually loaded.
> >
> > [1]: Documentation/driver-api/auxiliary_bus.rst
> >
>
> Yes, unfortunately, it would need to be manually loaded.  I flip-flopped
> multiple times on making this just a library that the nvme driver could
> call to register the LEDs (if the _DSM was present).  It would be
> simpler, it wouldn't need a module to be manulaly loaded, it would
> resulted in better LED names (if the _DSM was on the NVMe PCI device),
> and it would mean that the driver that owns the PCI device would also
> own the LEDs.
>
> The only reason I didn't do that, is that the _DSM can be on the PCIe
> port that the NVMe device is connected to, rather than on the NVMe drive
> PCI device.  And I'm not sure how to deal with the latter situation,
> except maybe change the pcie port bus driver to also call in to the
> library to register LEDs somehow.  But maybe it would be worth trying to
> figure that out.

Like I mentioned above, I think it's ok / expected that the client of
this API will kick off a search that starts with the local PCI device
and walks the hierarchy if necessary to the first enabled NPEM
instance.

> I was not aware of the auxiliary bus, thanks for pointing it out.  I
> glanced over it, and I'm not sure how it would help over just having a
> library that nvme, pcie port bus driver, CXL, or whatever could call into.

It helps because it registers a typical device that can autoload the
NPEM driver. So, instead of force loading this module, or adding all
the logic to be called by NVME directly, the NVME driver can simply
register an auxiliary device. The CXL driver can load a similar
auxiliary device. Then the common NPEM driver would be autoloaded in
response to those events, and typical modprobe policy can be used to
filter the driver or apply any other policy upon the arrival of
NPEM-like devices.

> >> +
> >> +         When enabled, LED interfaces will be created for supported drive
> >> +         states for each PCIe device that has the ACPI _DSM method described
> >> +         in the referenced specification.
> >> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> >> index b2980db88cc0..fbcb8c2d1dc1 100644
> >> --- a/drivers/pci/pcie/Makefile
> >> +++ b/drivers/pci/pcie/Makefile
> >> @@ -13,3 +13,4 @@ obj-$(CONFIG_PCIE_PME)                += pme.o
> >>   obj-$(CONFIG_PCIE_DPC)         += dpc.o
> >>   obj-$(CONFIG_PCIE_PTM)         += ptm.o
> >>   obj-$(CONFIG_PCIE_EDR)         += edr.o
> >> +obj-$(CONFIG_PCIE_SSD_LEDS)    += ssd-leds.o
> >> diff --git a/drivers/pci/pcie/ssd-leds.c b/drivers/pci/pcie/ssd-leds.c
> >> new file mode 100644
> >> index 000000000000..cacb77e5da2d
> >> --- /dev/null
> >> +++ b/drivers/pci/pcie/ssd-leds.c
> >> @@ -0,0 +1,419 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Module to provide LED interfaces for PCIe SSD status LED states, as
> >> + * defined in the "_DSM additions for PCIe SSD Status LED Management" ECN
> >> + * to the PCI Firmware Specification Revision 3.2, dated 12 February 2020.
> >> + *
> >> + * The "_DSM..." spec is functionally similar to Native PCIe Enclosure
> >> + * Management, but uses a _DSM ACPI method rather than a PCIe extended
> >> + * capability.
> >> + *
> >> + * Copyright (c) 2021 Dell Inc.
> >> + *
> >> + * TODO: Add NPEM support
> >> + */
> >> +
> >> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >> +
> >> +#include <linux/acpi.h>
> >> +#include <linux/leds.h>
> >> +#include <linux/module.h>
> >> +#include <linux/mutex.h>
> >> +#include <linux/pci.h>
> >> +#include <uapi/linux/uleds.h>
> >> +
> >> +#define DRIVER_NAME    "pcie-ssd-leds"
> >> +#define DRIVER_VERSION "v1.0"
> >> +
> >> +struct led_state {
> >> +       char *name;
> >> +       int bit;
> >> +};
> >> +
> >> +static struct led_state led_states[] = {
> >> +       { .name = "ok",         .bit = 2 },
> >> +       { .name = "locate",     .bit = 3 },
> >> +       { .name = "failed",     .bit = 4 },
> >> +       { .name = "rebuild",    .bit = 5 },
> >> +       { .name = "pfa",        .bit = 6 },
> >> +       { .name = "hotspare",   .bit = 7 },
> >> +       { .name = "ica",        .bit = 8 },
> >> +       { .name = "ifa",        .bit = 9 },
> >> +       { .name = "invalid",    .bit = 10 },
> >> +       { .name = "disabled",   .bit = 11 },
> >> +};
> >
> > include/linux/enclosure.h has common ABI definitions of industry
> > standard enclosure LED settings. The above looks to be open coding the
> > same?
> >
>
> The LED states in inluce/linux/enclosure.h aren't exactly the same...
> there are states defined in NPEM/_DSM that aren't defined in
> enclosure.h.  In addition, while the enclosure driver allows "locate" to
> be controlled independently, it looks like it will only allow a single
> state (unsupported/ok/critical/etc) to be active at a time, while the
> NPEM/_DSM allow all of the state bits to be independently set or
> cleared.  Maybe only one of those states would need to be set at a time,
> I don't know, but that would impose a limitation on what NPEM/_DSM can
> do.  I'll take a closer look at this as an alternative to using
> drivers/leds/led-class.c.

Have a look. Maybe Mariusz can weigh in here with his experience with
ledmon with what capabilities ledmon would need from this driver so we
can decide what if any extensions need to be made to the enclosure
infrastructure?

It's been a while for me [2], but I seem to recall that some of the
enclosure specific functionality can be wrapped by the upper layer
driver like SES.

[2]: https://lore.kernel.org/all/CAPcyv4iaXfgB1PBv5v+dyRrUvQbzAyyFf1Ozsaao0t8K0w9zwg@mail.gmail.com/

[..]
> >> +static void initial_scan_for_leds(void)
> >> +{
> >> +       struct pci_dev *pdev = NULL;
> >> +
> >> +       for_each_pci_dev(pdev)
> >> +               probe_pdev(pdev);
> >
> >
> > This looks odd to me. Why force enable every occurrence these leds, and
> > do so indepdendently of the bind state of the driver for the associated
> > PCI device? I would expect that this support would be a library called
> > by the NVME driver, or the CXL driver. A library just like the
> > led_classdev infrastructure.
> >
>
> I guess I didn't know of any reason why they shouldn't be enabled even
> if the nvme driver wasn't bound, if this driver was stand-alone, since
> the LED function doesn't depend on the nvme driver.  But yes, maybe it
> would be better to make this a library that the nvme driver (or pcie
> port bus driver, or CXL driver) calls to register LEDs.

It's just not clear to me what userspace would do with this randomly
popping up without any clear association to a storage / memory device.
What reason would userpsace have to blink the lights in that
disassociated case?

> Thank you for taking a look at this... I'm very glad for any help to get
> this done.

No worries, thanks for taking this on, happy to help.
