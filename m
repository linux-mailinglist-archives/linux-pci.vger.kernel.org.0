Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421DD4D1B00
	for <lists+linux-pci@lfdr.de>; Tue,  8 Mar 2022 15:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347638AbiCHOxt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 8 Mar 2022 09:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiCHOxs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Mar 2022 09:53:48 -0500
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC66813E1C;
        Tue,  8 Mar 2022 06:52:50 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2dbd8777564so204433997b3.0;
        Tue, 08 Mar 2022 06:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8S8n3jqmVQAhg7JhP4kfIscVU/+tWnS42PrwxSwOWlU=;
        b=13gFSZnm0L6G1oTnjHo+duZC8oftPzJZNgd2fJyYhxpD6CgLTVQqZv6pb3j90Nu/ad
         1/vx1IhycF2uGSMFDFVioRBDnCL6NUEEq04QHCcaeiVaLqSfi8S3YljljT6OxKK0cgQI
         0VVihbSZszWV1yi/X4g7Q2qMBHqHihHxPIraxUASziXV0zFyOcaYAFxXAZSJcRotRkzS
         Qq/CW80FndWrQgcfVwplaqPhZFsgAPRw/fM4Pd1dcKPrNk8rH/Q4kZLkzL4Hgwv7c9Ob
         TU1WDsbnfiOB+78tF5YKcYOTMJuGYNvCTKtmd0h7IDMGEWRrJsti23ZnQ+CxxRahoI4A
         cOdQ==
X-Gm-Message-State: AOAM533k/g07Dihc9g9sAYq5m46vChxLSgR3WRcMj5hhUkUhs82x5sVJ
        W6Q7lhJ3+CivbkzxdrdFopZP2Orkw6Bk+jm10XE=
X-Google-Smtp-Source: ABdhPJwOY6qdU7sZjvDZb5ul+OEQ7/gecwEqMArSqLKuRdKgHahZ8w06l0La1zCyovq4utZ7cWUuK+KYt0MduNXUkHo=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr12453242ywb.326.1646751170147; Tue, 08
 Mar 2022 06:52:50 -0800 (PST)
MIME-Version: 1.0
References: <20220304153245.GA1030861@bhelgaas> <86b17447-b285-f6ce-99d8-f2cad01405d5@redhat.com>
 <bfdb214d-b6e7-f0e7-60de-f30204b0aa90@redhat.com> <f431fddb-8d19-4b57-5f34-a40c925a74bf@redhat.com>
In-Reply-To: <f431fddb-8d19-4b57-5f34-a40c925a74bf@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Mar 2022 15:52:39 +0100
Message-ID: <CAJZ5v0jVLxBYQ9qdH+Vj8qpEN9m3oRLgJGFrqWhzW+ohqHZWVQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/PCI: Preserve host bridge windows completely
 covered by E820
To:     Hans de Goede <hdegoede@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        =?UTF-8?Q?Benoit_Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, wse@tuxedocomputers.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 7, 2022 at 11:33 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Bjorn, Rafael,
>
> On 3/5/22 11:37, Hans de Goede wrote:
> > Hi,
> >
> > On 3/4/22 16:46, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 3/4/22 16:32, Bjorn Helgaas wrote:
> >>> On Fri, Mar 04, 2022 at 03:16:42PM +0100, Hans de Goede wrote:
> >>>> Hi Bjorn,
> >>>>
> >>>> On 3/4/22 04:51, Bjorn Helgaas wrote:
> >>>>> From: Bjorn Helgaas <bhelgaas@google.com>
> >>>>>
> >>>>> Many folks have reported PCI devices not working.  It could affect any
> >>>>> device, but most reports are for Thunderbolt controllers on Lenovo Yoga and
> >>>>> Clevo Barebone laptops and the touchpad on Lenovo IdeaPads.
> >>>>>
> >>>>> In every report, a region in the E820 table entirely encloses a PCI host
> >>>>> bridge window from _CRS, and because of 4dc2287c1805 ("x86: avoid E820
> >>>>> regions when allocating address space"), we ignore the entire window,
> >>>>> preventing us from assigning space to PCI devices.
> >>>>>
> >>>>> For example, the dmesg log [2] from bug report [1] shows:
> >>>>>
> >>>>>   BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
> >>>>>   pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
> >>>>>   pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
> >>>>>
> >>>>> The efi=debug dmesg log [3] from the same report shows the EFI memory map
> >>>>> entries that created the E820 map:
> >>>>>
> >>>>>   efi: mem47: [Reserved |   |WB|WT|WC|UC] range=[0x4bc50000-0x5fffffff]
> >>>>>   efi: mem48: [Reserved |   |WB|  |  |UC] range=[0x60000000-0x60ffffff]
> >>>>>   efi: mem49: [Reserved |   |  |  |  |  ] range=[0x61000000-0x653fffff]
> >>>>>   efi: mem50: [MMIO     |RUN|  |  |  |UC] range=[0x65400000-0xcfffffff]
> >>>>>
> >>>>> 4dc2287c1805 ("x86: avoid E820 regions when allocating address space")
> >>>>> works around issues where _CRS contains non-window address space that can't
> >>>>> be used for PCI devices.  It does this by removing E820 regions from host
> >>>>> bridge windows.  But in these reports, the E820 region covers the entire
> >>>>> window, so 4dc2287c1805 makes it completely unusable.
> >>>>>
> >>>>> Per UEFI v2.8, sec 7.2, the EfiMemoryMappedIO type means:
> >>>>>
> >>>>>   Used by system firmware to request that a memory-mapped IO region be
> >>>>>   mapped by the OS to a virtual address so it can be accessed by EFI
> >>>>>   runtime services.
> >>>>>
> >>>>> A host bridge window is definitely a memory-mapped IO region, and EFI
> >>>>> runtime services may need to access it, so I don't think we can argue that
> >>>>> this is a firmware defect.
> >>>>>
> >>>>> Instead, change the 4dc2287c1805 strategy so it only removes E820 regions
> >>>>> when they overlap *part* of a host bridge window on the assumption that a
> >>>>> partial overlap is really register space, not part of the window proper.
> >>>>>
> >>>>> If an E820 region covers the entire window from _CRS, assume the _CRS
> >>>>> window is correct and do nothing.
> >>>>>
> >>>>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> >>>>> [2] https://bugzilla.redhat.com/attachment.cgi?id=1711424
> >>>>> [3] https://bugzilla.redhat.com/attachment.cgi?id=1861407
> >>>>>
> >>>>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
> >>>>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214259
> >>>>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> >>>>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
> >>>>> BugLink: https://bugs.launchpad.net/bugs/1878279
> >>>>> BugLink: https://bugs.launchpad.net/bugs/1931715
> >>>>> BugLink: https://bugs.launchpad.net/bugs/1932069
> >>>>> BugLink: https://bugs.launchpad.net/bugs/1921649
> >>>>> Fixes: 4dc2287c1805 ("x86: avoid E820 regions when allocating address space")
> >>>>> Link: https://lore.kernel.org/r/20220228105259.230903-1-hdegoede@redhat.com
> >>>>> Based-on-patch-by: Hans de Goede <hdegoede@redhat.com>
> >>>>> Reported-by: Benoit Grégoire <benoitg@coeus.ca>   # BZ 206459
> >>>>> Reported-by: wse@tuxedocomputers.com              # BZ 214259
> >>>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >>>>> ---
> >>>>>  arch/x86/kernel/resource.c | 11 +++++++++++
> >>>>>  1 file changed, 11 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
> >>>>> index 7378ea146976..405f0af53e3d 100644
> >>>>> --- a/arch/x86/kernel/resource.c
> >>>>> +++ b/arch/x86/kernel/resource.c
> >>>>> @@ -39,6 +39,17 @@ void remove_e820_regions(struct device *dev, struct resource *avail)
> >>>>>           e820_start = entry->addr;
> >>>>>           e820_end = entry->addr + entry->size - 1;
> >>>>>
> >>>>> +         /*
> >>>>> +          * If an E820 entry covers just part of the resource, we
> >>>>> +          * assume E820 is telling us about something like host
> >>>>> +          * bridge register space that is unavailable for PCI
> >>>>> +          * devices.  But if it covers the *entire* resource, it's
> >>>>> +          * more likely just telling us that this is MMIO space, and
> >>>>> +          * that doesn't need to be removed.
> >>>>> +          */
> >>>>> +         if (e820_start <= avail->start && avail->end <= e820_end)
> >>>>> +                 continue;
> >>>>> +
> >>>>
> >>>> IMHO it would be good to add some logging here, since hitting this is
> >>>> somewhat of a special case. For the Fedora test kernels I did I changed
> >>>> this to:
> >>>>
> >>>>            if (e820_start <= avail->start && avail->end <= e820_end) {
> >>>>                    dev_info(dev, "resource %pR fully covered by e820 entry [mem %#010Lx-%#010Lx]\n",
> >>>>                             avail, e820_start, e820_end);
> >>>>                    continue;
> >>>>            }
> >>>>
> >>>> And I expect/hope to see this new info message on the ideapad with the
> >>>> touchpad issue.
> >>>
> >>> Right, I would expect the same.
> >>>
> >>> We could add something like this.  But both the e820 entry and the
> >>> host bridge window are already in the dmesg log, so it doesn't really
> >>> add new information
> >>
> >> Well it adds the information that the workaround (to the workaround)
> >> which we added for this case is working as expected and it allows
> >> seeing that is the case in a single glance.
> >
> > So I just got the first report back from the Fedora test 5.16.12 kernel
> > with this series added. Good news on the ideapad this wotks fine to
> > fix the touchpad issue (as expected).
> >
> > What is interesting is that the above dev_info message which I added
> > triggers *twice*:
> >
> > [    0.327837] acpi PNP0A08:00: resource [mem 0x000a0000-0x000bffff window] fully covered by e820 entry [mem 0x0009f000-0x000fffff]
> > [    0.327843] acpi PNP0A08:00: resource [mem 0x65400000-0xbfffffff window] fully covered by e820 entry [mem 0x4bc50000-0xcfffffff]
> >
> > Notice that it also stops from the mem-window for ISA io getting fully
> > clipped, which I did not realize also was a potential issue.
> >
> > I hope this also shows that having the dev_info here is good,
> > at least IMHO this confirms that having the dev_info for this
> > is a good thing.
> >
> > I'm still waiting for testing results on the X1C2 which had the
> > suspend/resume regressions with my bios-date based approach.
>
> I have heard back from the X1C2 user, he does not have access to
> the machine atm he will get back to me in a couple of days.
>
> I don't really expect any surprises there though, so given where
> we are in the kernel-cycle and that we already have confirmation
> that it fixes the ideapad touchpad issues I think we should move
> forward with this patch-set now.
>
> Rafael, can you drop my variant of this patch?  (this series is
> a cleaner implementation of basically the same method to fix
> things)

Done.

> Bjorn, I assume you will merge this series through your tree?

Same here, and please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to all of the patches in this series.

Thanks!
