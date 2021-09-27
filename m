Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37433419557
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 15:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhI0Nsa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 09:48:30 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:40519 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbhI0Ns3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Sep 2021 09:48:29 -0400
Received: by mail-oo1-f49.google.com with SMTP id j11-20020a4a92cb000000b002902ae8cb10so6010016ooh.7;
        Mon, 27 Sep 2021 06:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/2hi+Adp/K+NIix+31/wj/XzGdZQ/IRbdOwvcbW6PuQ=;
        b=YeUa31kYCpcEpm3zumBYpq9Eb8PDqjrCWHeOIWxtXnRskUclg1QVfROTsxP/udSPk2
         eeufimTIDE5Pft5vSLRfmCGbJlVlJLafKTNRd5mxCmEvLCAoo3YY5U9eX1gpkmPBVYJt
         qNYRly0Eb7ludpdf3SJ9X9ClkJ9oslAOe6OuoHsSjXmj05N8i/TlqJ3k1JGmWLeCHl2X
         xhN+7nKrMoK2qLO5tyIImBX0EaeWSQ1D4qWPgkhkPRnZQUhSB3lPyL5meIL0k1xaWa3E
         67KkGhhcbmoH6+Ebh8jlQOVhFVqOye+FunVjMD8krEZgxqGssQkGZbnOiavlKae93pDc
         ZQrQ==
X-Gm-Message-State: AOAM531KMeDcUbitt6ep66yswYHDsgdXxe66Lo+Hj3wsTNYctnZYefYH
        /dufgJ3q2AGTLf0twaAKfIN3XSpFIRvwUhmz1QI=
X-Google-Smtp-Source: ABdhPJzZZ/aHiUC2kDwz55TfVq12Dyd1x2Mtmc3YutiuwNYlSv0ADKYAvDDqHRpDUxn0pBwNB2mHE2Ml+RrCFiIpB1c=
X-Received: by 2002:a4a:df0b:: with SMTP id i11mr27767oou.30.1632750411428;
 Mon, 27 Sep 2021 06:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <1800633.tdWV9SEqCh@kreacher> <8879480.rMLUfLXkoz@kreacher>
 <069444f7-d623-fae2-5cd0-83cbbc919aff@gmail.com> <CAJZ5v0gpodPPXTagy5gFFf6mp_jCAdc864CE_giaue72ke7UyQ@mail.gmail.com>
 <ab803fb5-045d-98dd-2754-688a916f8944@gmail.com> <d151c91c-cb65-2830-2453-a02057137400@gmail.com>
 <CAJZ5v0howP_PudCf-43_HqgW48ydc29SeFVRC-wCm_RNKPBMtA@mail.gmail.com> <24c2c653-4087-fba1-5745-a62a8ae715c6@gmail.com>
In-Reply-To: <24c2c653-4087-fba1-5745-a62a8ae715c6@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Sep 2021 15:46:40 +0200
Message-ID: <CAJZ5v0gE5qagoiKWR1hAxLdSJepiCvT4GHaZu4M4pKR8v83zmA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] PCI: ACPI: PM: Do not use pci_platform_pm_ops for ACPI
To:     Ferry Toth <fntoth@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 24, 2021 at 11:17 PM Ferry Toth <fntoth@gmail.com> wrote:
>
> Hi
>
> Op 24-09-2021 om 14:02 schreef Rafael J. Wysocki:
> > On Thu, Sep 23, 2021 at 10:32 PM Ferry Toth <fntoth@gmail.com> wrote:
> >> Hi
> >>
> >> Op 23-09-2021 om 15:51 schreef Ferry Toth:
> >>> Repost (with formatting removed, sorry for the noise)
> >>> Op 23-09-2021 om 13:30 schreef Rafael J. Wysocki:
> >>>> On Wed, Sep 22, 2021 at 11:31 PM Ferry Toth<fntoth@gmail.com>  wrote:
> >>>>> Hi,
> >>>>> Op 20-09-2021 om 21:17 schreef Rafael J. Wysocki:
> >>>>>> From: Rafael J. Wysocki<rafael.j.wysocki@intel.com>
> >>>>>>
> >>>>>> Using struct pci_platform_pm_ops for ACPI adds unnecessary
> >>>>>> indirection to the interactions between the PCI core and ACPI PM,
> >>>>>> which is also subject to retpolines.
> >>>>>>
> >>>>>> Moreover, it is not particularly clear from the current code that,
> >>>>>> as far as PCI PM is concerned, "platform" really means just ACPI
> >>>>>> except for the special casess when Intel MID PCI PM is used or when
> >>>>>> ACPI support is disabled (through the kernel config or command line,
> >>>>>> or because there are no usable ACPI tables on the system).
> >>>>>>
> >>>>>> To address the above, rework the PCI PM code to invoke ACPI PM
> >>>>>> functions directly as needed and drop the acpi_pci_platform_pm
> >>>>>> object that is not necessary any more.
> >>>>>>
> >>>>>> Accordingly, update some of the ACPI PM functions in question to do
> >>>>>> extra checks in case the ACPI support is disabled (which previously
> >>>>>> was taken care of by avoiding to set the pci_platform_ops pointer
> >>>>>> in those cases).
> >>>>>>
> >>>>>> Signed-off-by: Rafael J. Wysocki<rafael.j.wysocki@intel.com>
> >>>>>> ---
> >>>>>>
> >>>>>> v1 -> v2:
> >>>>>>        * Rebase on top of the new [1/7] and move dropping struct
> >>>>>>          pci_platform_pm_ops to a separate patch.
> >>>>> I wanted to test this series on 5.15-rc2 but this patch 2/7 doesn't
> >>>>> apply (after 1/7 applied). Should I apply this on another tree?
> >>>> This is on top of
> >>>> https://patchwork.kernel.org/project/linux-acpi/patch/2793105.e9J7NaK4W3@kreacher/
> >>>>
> >>>> which is not yet in any tree.
> >>>>
> >>>> Sorry for the confusion.
> >>> No problem at all. If I can I will try to report back tonight. Else,
> >>> will be delayed 2 due to a short break.
> >> With those 3 extra patches followed by 7 from this series it builds. But
> >> on boot I get:
> >> dwc3 dwc3.0.auto: this is not a DesignWare USB3 DRD Core
> >> Then after this it reboots. Nothing in the logs. Nothing else on
> >> console, I guess something goes wrong early.
> > It appears so.
> >
> > Can you please try just the 3 extra patches this series is on top of?
> > The problem is more likely to be located in one of them.
> Boots fine with just the 3 so up to and including "ACPI: glue: Look for
> ACPI bus type only if ACPI companion is not known". From the log I get:
>
>
> Intel MID platform detected, using MID PCI ops
> PCI: Using configuration type 1 for base access
> ..
> PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs"
> and report a bug
> ..
> PCI: Probing PCI hardware
> PCI: root bus 00: using default resources
> PCI: Probing PCI hardware (bus 00)
> PCI: pci_cache_line_size set to 64 bytes
> ..
> pnp: PnP ACPI init
> ..
> pnp: PnP ACPI: found 2 devices
> ..
> xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
> xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 1
> xhci-hcd xhci-hcd.1.auto: hcc params 0x0220f06c hci version 0x100 quirks
> 0x0000000002010010
> xhci-hcd xhci-hcd.1.auto: irq 14, io mem 0xf9100000
> usb usb1: New USB device found, idVendor=1d6b, idProduct=0002,
> bcdDevice= 5.15
> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: Product: xHCI Host Controller
> usb usb1: Manufacturer: Linux 5.15.0-rc2-edison-acpi-standard xhci-hcd
> usb usb1: SerialNumber: xhci-hcd.1.auto
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 1 port detected
>
> I continued up to "PCI: ACPI: PM: Do not use pci_platform_pm_ops for
> ACPI", still boots.
>
> In the logs I still see "Intel MID platform detected, using MID PCI ops".
>
> Unfortunately no more time today, and tomorrow short holiday starts. I
> will continue after returning next Sat.

Thanks for the testing and feedback, much appreciated!

I'm going to queue up the patches that you have tested with a
Tested-by tag from you if that's not an issue.

Also patches [3/7] ("PCI: PM: Drop struct pci_platform_pm_ops") and
[7/7] ("PCI: PM: Simplify acpi_pci_power_manageable()") are not likely
to introduce functional issue, because the former removes unused code
and the latter simply rearranges some computations, so I'm going to
queue up these two as well.

Patches [4-5/7] change behavior, if only slightly, so they need to be
double checked.

In turn, patch [6/7[ contains a bug - it makes
pci_platform_power_transition() call acpi_pci_set_power_state()
instead of platform_pci_set_power_state() which is probably why you
see the problem (nobody with an ACPI platform of any platform other
then MID would see it).  Sorry about that.

After queuing up the patches that are not problematic I'll prepare a
new 3-patch series to test on top of them.

Thanks!
