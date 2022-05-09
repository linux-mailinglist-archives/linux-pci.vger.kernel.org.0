Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9D552055F
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 21:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbiEITke (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 15:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240607AbiEITkd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 15:40:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EF111030F;
        Mon,  9 May 2022 12:36:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F670616AF;
        Mon,  9 May 2022 19:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D0CC385B2;
        Mon,  9 May 2022 19:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652124995;
        bh=zDrex4gIoFmOHyW3Y8EAsMyoEft22o0cUOX0OhmSURY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nLwDVk4DYkKjwMHRhzuthbTbFK0fEBeumeENFzl2ZCSi9Kfpb7n5yViRssP4NF76h
         pdUu6vkaN26oyEPt/HDjZy6N6YhC10jntYbmC6hihhta2803BsYbqX85yasYWcGDx7
         PxCGoqbp/axHKCJoNCp3zL4XFzykLFrCbFQJCogdGGtH8bcLqwTmN1boAUb0abrlIi
         AopL79rC/GjY47i87M4KZ8yRHRB9OhWlNUI7jSDNh8vjJE+tYEAlCPDpdo0ssCvZwR
         RcJfv9gl9GSYnYszChPzeXmmdYimfHHehWsgfR8GsuC9/VCL0fHwz7D2nH+PtGam3Q
         TVQnh+7ayTgZw==
Date:   Mon, 9 May 2022 14:36:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/1] x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems
Message-ID: <20220509193629.GA611897@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e92c4b6-8976-2bd4-ebe2-465990eb66d2@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 09, 2022 at 07:33:27PM +0200, Hans de Goede wrote:
> Hi Bjorn,
> 
> On 5/7/22 17:31, Bjorn Helgaas wrote:
> > On Sat, May 07, 2022 at 12:09:03PM +0200, Hans de Goede wrote:
> >> Hi Bjorn,
> >>
> >> On 5/6/22 18:51, Bjorn Helgaas wrote:
> >>> On Thu, May 05, 2022 at 05:20:16PM +0200, Hans de Goede wrote:
> >>>> Some BIOS-es contain bugs where they add addresses which are already
> >>>> used in some other manner to the PCI host bridge window returned by
> >>>> the ACPI _CRS method. To avoid this Linux by default excludes
> >>>> E820 reservations when allocating addresses since 2010, see:
> >>>> commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
> >>>> space").
> >>>>
> >>>> Recently (2019) some systems have shown-up with E820 reservations which
> >>>> cover the entire _CRS returned PCI bridge memory window, causing all
> >>>> attempts to assign memory to PCI BARs which have not been setup by the
> >>>> BIOS to fail. For example here are the relevant dmesg bits from a
> >>>> Lenovo IdeaPad 3 15IIL 81WE:
> >>>>
> >>>>  [mem 0x000000004bc50000-0x00000000cfffffff] reserved
> >>>>  pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
> >>>>
> >>>> The ACPI specifications appear to allow this new behavior:
> >>>>
> >>>> The relationship between E820 and ACPI _CRS is not really very clear.
> >>>> ACPI v6.3, sec 15, table 15-374, says AddressRangeReserved means:
> >>>>
> >>>>   This range of addresses is in use or reserved by the system and is
> >>>>   not to be included in the allocatable memory pool of the operating
> >>>>   system's memory manager.
> >>>>
> >>>> and it may be used when:
> >>>>
> >>>>   The address range is in use by a memory-mapped system device.
> >>>>
> >>>> Furthermore, sec 15.2 says:
> >>>>
> >>>>   Address ranges defined for baseboard memory-mapped I/O devices, such
> >>>>   as APICs, are returned as reserved.
> >>>>
> >>>> A PCI host bridge qualifies as a baseboard memory-mapped I/O device,
> >>>> and its apertures are in use and certainly should not be included in
> >>>> the general allocatable pool, so the fact that some BIOS-es reports
> >>>> the PCI aperture as "reserved" in E820 doesn't seem like a BIOS bug.
> >>>>
> >>>> So it seems that the excluding of E820 reserved addresses is a mistake.
> >>>>
> >>>> Ideally Linux would fully stop excluding E820 reserved addresses,
> >>>> but then various old systems will regress.
> >>>> Instead keep the old behavior for old systems, while ignoring
> >>>> the E820 reservations for any systems from now on.
> >>>>
> >>>> Old systems are defined here as BIOS year < 2018, this was chosen to
> >>>> make sure that pci_use_e820 will not be set on the currently affected
> >>>> systems, the oldest known one is from 2019.
> >>>>
> >>>> Testing has shown that some newer systems also have a bad _CRS return.
> >>>> The pci_crs_quirks DMI table is used to keep excluding E820 reservations
> >>>> from the bridge window on these systems.
> >>>>
> >>>> Also add pci=no_e820 and pci=use_e820 options to allow overriding
> >>>> the BIOS year + DMI matching logic.
> >>>>
> >>>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
> >>>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> >>>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
> >>>> BugLink: https://bugs.launchpad.net/bugs/1878279
> >>>> BugLink: https://bugs.launchpad.net/bugs/1931715
> >>>> BugLink: https://bugs.launchpad.net/bugs/1932069
> >>>> BugLink: https://bugs.launchpad.net/bugs/1921649
> >>>> Cc: Benoit Grégoire <benoitg@coeus.ca>
> >>>> Cc: Hui Wang <hui.wang@canonical.com>
> >>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>>
> >>>> +	 * Ideally Linux would fully stop using E820 reservations, but then
> >>>> +	 * various old systems will regress. Instead keep the old behavior for
> >>>> +	 * old systems + known to be broken newer systems in pci_crs_quirks.
> >>>> +	 */
> >>>> +	if (year >= 0 && year < 2018)
> >>>> +		pci_use_e820 = true;
> >>>
> >>> How did you pick 2018?  Prior to this patch, we used E820 reservations
> >>> for all machines.  This patch would change that for 2019-2022
> >>> machines, so there's a risk of breaking some of them.
> >>
> >> Correct. I picked 2018 because the first devices where using E820
> >> reservations are causing issues (i2c controller not getting resources
> >> leading to non working touchpad / thunderbolt hotplug issues) have
> >> BIOS dates starting in 2019. I added a year margin, so we could make
> >> this 2019.
> >>
> >>> I'm hesitant about changing the behavior for machines already in the
> >>> field because if they were tested at all with Linux, it was without
> >>> this patch.  So I would lean toward preserving the current behavior
> >>> for BIOS year < 2023.
> >>
> >> I see, I presume the idea is to then use DMI to disable E820 clipping
> >> on current devices where this is known to cause problems ?
> >>
> >> So for v8 I would:
> >>
> >> 1. Change the cut-off check to < 2023
> >> 2. Drop the DMI quirks I added for models which are known to need E820
> >>    clipping hit by the < 2018 check
> >> 3. Add DMI quirks for models for which it is known that we must _not_
> >>    do E820 clipping
> >>
> >> Is this the direction you want to go / does that sound right?
> > 
> > Yes, I think that's what we should do.  All the machines in the field
> > will be unaffected, except that we add quirks for known problems.
> 
> I've been working on this today. I've mostly been going through
> the all the existing bugs about this, to make a list of DMI matches
> for devices on which we should _not_ do e820 clipping to fix th
> kernel being unable to assign BARs there.
> 
> I've found an interesting pattern there, all affected devices
> are Lenovo devices with "IIL" in there device name, e.g. :
> "IdeaPad 3 15IIL05". I've looked up all Lenovo devices which
> have "IIL" as part of their DMI_PRODUCT_VERSION string here:
> https://github.com/linuxhw/DMI/
> 
> And then looked them up at https://linux-hardware.org/ and checked
> their dmesg to see if they have the e820 problem other ideapads
> have. I've gone through approx. half the list now and all
> except one model seem to have the e820 problem.
> 
> So it looks like we might be able to match all problem models
> with a single DMI match.

That sounds reasonable.  I assume that if we skip the clipping for
every platform that matches "IIL", we can also add exceptions for the
inevitable "IIL" platforms that do need the clip?  E.g., specific
entries at the end of the list that override the previous generic
match?

> So the problem seems to be limited to one specific device
> series / range and this is making me have second thoughts
> about doing a date based cut-off at all. Trying to switch
> over any models which are new in 2023 is fine, the problem
> with a DMI BIOS date approach though is that as soon as some
> new management-engine CVE comes out we will also see BIOS
> updates with a year of 2023 for many existing models, of
> up to 3-4 years old at least; and chances are that some of
> those older models getting BIOS updates will be bitten by
> this change.

That's a good point and sounds fairly painful when that happens,
but I don't see a nice way out of this.

> So as said I'm having second thoughts about the date based
> approach. Bjorn, what do you think of just using DMI quirks
> to disable e820 clipping on known problematic models and
> otherwise keeping things as is ?

I think we need a long-term strategy that can be clearly expressed 
in a sentence or two and is consistent with the ACPI and PCI specs,
and I don't think the current strategy is it.  Clipping with E820
regions happened to work for some machines, but there's no reason to
think it will work in general.

> Note I'm also fine with going with the 2023 date based
> approach, I'm just wondering if that will be a good idea
> and not something which we might regret later.
> 
> Regards,
> 
> Hans
> 
> 
> p.s.
> 
> I've seen your email about the Acer laptop; I'll take
> a look at that coming Wednesday.
> 
