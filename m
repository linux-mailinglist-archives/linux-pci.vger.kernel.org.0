Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8C952D57D
	for <lists+linux-pci@lfdr.de>; Thu, 19 May 2022 16:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiESOC7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 10:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiESOCc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 10:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42BCF515A9
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 07:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652968915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E40Kj9+FHA+/ZbiXmA06szwZWIHidl1octzz4AesjSA=;
        b=JkwUOxHsVqr5iBBA6rPUBqwm1DckYwi9J947NlCqTlsPVMAUfnK09LRUH60MLr2b46Cpwq
        88YyRHKBjcdGA/OfSpn7Q0vZkPHiYzlTT9Du/DDOoqWecLG0cVmOIlClw7ELEfjmDKXkGD
        b0IUwu3iQ22UesTnFS39S8gpWF5pBEw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-BqK_P7qpNTSTQxglb2tYHA-1; Thu, 19 May 2022 10:01:54 -0400
X-MC-Unique: BqK_P7qpNTSTQxglb2tYHA-1
Received: by mail-ej1-f70.google.com with SMTP id sh14-20020a1709076e8e00b006f4a5de6888so2608202ejc.8
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 07:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E40Kj9+FHA+/ZbiXmA06szwZWIHidl1octzz4AesjSA=;
        b=SoImqMX+focGgKIWRz2PnVtP13xt4IhUxfWSU8m+7KxfTGvYUQZ5JG34uT80S5PX79
         RE50X8v0k2I4hoqvcMhs+axo4DNDol3otpV4ztMOf1QgKMx8uOYPULvIcnIKevjw+HUN
         v/7NvT0TJxbRpss1mNgP965KTowOuS7U68dtG7g92RMOrU4YR8wrgtZW4PxwETCygE7G
         Vl+O4ApBs+SDPGC5BUZYDQDd5LkQrdJlkFO82o+u34GBmkPfrWLisFYtYMpsYcJjzT6N
         XbzXRfaMMVBr718EDKbWODK24Y9D4w2arnbnVG9ZvKHxCRcZb0xfzt4tmUPiavmnvMfG
         J5nA==
X-Gm-Message-State: AOAM530RryFQOwp+D9dwt4uAN7oSzkBZooW2OjxghK6bdHWEJTJgJioG
        yEZwZmrcyY1oHea2Bz3Gn//T+PIf2nGDQk77ul51NLkByprTYlxGkC+QSu+ESzabQB0wQTiyI03
        YLni8PbvD5SlBpbhE2T+p
X-Received: by 2002:a05:6402:f09:b0:42a:be2f:ceeb with SMTP id i9-20020a0564020f0900b0042abe2fceebmr5575351eda.110.1652968911051;
        Thu, 19 May 2022 07:01:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoLmQpb4dftE0QXBm5H8o6UYriq59cC0k/XVkHzL/xUn1d+Ce/VFnSoH0OKBuE4yCMVcnS5w==
X-Received: by 2002:a05:6402:f09:b0:42a:be2f:ceeb with SMTP id i9-20020a0564020f0900b0042abe2fceebmr5575201eda.110.1652968909762;
        Thu, 19 May 2022 07:01:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id qp24-20020a170907a21800b006f3ef214db8sm2164355ejc.30.2022.05.19.07.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 07:01:49 -0700 (PDT)
Message-ID: <ba9fd954-64e1-189d-9a0e-7c7e329ff81b@redhat.com>
Date:   Thu, 19 May 2022 16:01:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v7 1/1] x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220518220754.GA7911@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220518220754.GA7911@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 5/19/22 00:07, Bjorn Helgaas wrote:
> On Mon, May 09, 2022 at 07:33:27PM +0200, Hans de Goede wrote:
>> On 5/7/22 17:31, Bjorn Helgaas wrote:
>>> On Sat, May 07, 2022 at 12:09:03PM +0200, Hans de Goede wrote:
>>>> On 5/6/22 18:51, Bjorn Helgaas wrote:
>>>>> On Thu, May 05, 2022 at 05:20:16PM +0200, Hans de Goede wrote:
>>>>>> Some BIOS-es contain bugs where they add addresses which are already
>>>>>> used in some other manner to the PCI host bridge window returned by
>>>>>> the ACPI _CRS method. To avoid this Linux by default excludes
>>>>>> E820 reservations when allocating addresses since 2010, see:
>>>>>> commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
>>>>>> space").
>>>>>>
>>>>>> Recently (2019) some systems have shown-up with E820 reservations which
>>>>>> cover the entire _CRS returned PCI bridge memory window, causing all
>>>>>> attempts to assign memory to PCI BARs which have not been setup by the
>>>>>> BIOS to fail. For example here are the relevant dmesg bits from a
>>>>>> Lenovo IdeaPad 3 15IIL 81WE:
>>>>>>
>>>>>>  [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>>>>>>  pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
>>>>>>
>>>>>> The ACPI specifications appear to allow this new behavior:
>>>>>>
>>>>>> The relationship between E820 and ACPI _CRS is not really very clear.
>>>>>> ACPI v6.3, sec 15, table 15-374, says AddressRangeReserved means:
>>>>>>
>>>>>>   This range of addresses is in use or reserved by the system and is
>>>>>>   not to be included in the allocatable memory pool of the operating
>>>>>>   system's memory manager.
>>>>>>
>>>>>> and it may be used when:
>>>>>>
>>>>>>   The address range is in use by a memory-mapped system device.
>>>>>>
>>>>>> Furthermore, sec 15.2 says:
>>>>>>
>>>>>>   Address ranges defined for baseboard memory-mapped I/O devices, such
>>>>>>   as APICs, are returned as reserved.
>>>>>>
>>>>>> A PCI host bridge qualifies as a baseboard memory-mapped I/O device,
>>>>>> and its apertures are in use and certainly should not be included in
>>>>>> the general allocatable pool, so the fact that some BIOS-es reports
>>>>>> the PCI aperture as "reserved" in E820 doesn't seem like a BIOS bug.
>>>>>>
>>>>>> So it seems that the excluding of E820 reserved addresses is a mistake.
>>>>>>
>>>>>> Ideally Linux would fully stop excluding E820 reserved addresses,
>>>>>> but then various old systems will regress.
>>>>>> Instead keep the old behavior for old systems, while ignoring
>>>>>> the E820 reservations for any systems from now on.
>>>>>>
>>>>>> Old systems are defined here as BIOS year < 2018, this was chosen to
>>>>>> make sure that pci_use_e820 will not be set on the currently affected
>>>>>> systems, the oldest known one is from 2019.
>>>>>>
>>>>>> Testing has shown that some newer systems also have a bad _CRS return.
>>>>>> The pci_crs_quirks DMI table is used to keep excluding E820 reservations
>>>>>> from the bridge window on these systems.
>>>>>>
>>>>>> Also add pci=no_e820 and pci=use_e820 options to allow overriding
>>>>>> the BIOS year + DMI matching logic.
>>>>>>
>>>>>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
>>>>>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
>>>>>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
>>>>>> BugLink: https://bugs.launchpad.net/bugs/1878279
>>>>>> BugLink: https://bugs.launchpad.net/bugs/1931715
>>>>>> BugLink: https://bugs.launchpad.net/bugs/1932069
>>>>>> BugLink: https://bugs.launchpad.net/bugs/1921649
>>>>>> Cc: Benoit Grégoire <benoitg@coeus.ca>
>>>>>> Cc: Hui Wang <hui.wang@canonical.com>
>>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>>
>>>>>> +	 * Ideally Linux would fully stop using E820 reservations, but then
>>>>>> +	 * various old systems will regress. Instead keep the old behavior for
>>>>>> +	 * old systems + known to be broken newer systems in pci_crs_quirks.
>>>>>> +	 */
>>>>>> +	if (year >= 0 && year < 2018)
>>>>>> +		pci_use_e820 = true;
>>>>>
>>>>> How did you pick 2018?  Prior to this patch, we used E820 reservations
>>>>> for all machines.  This patch would change that for 2019-2022
>>>>> machines, so there's a risk of breaking some of them.
>>>>
>>>> Correct. I picked 2018 because the first devices where using E820
>>>> reservations are causing issues (i2c controller not getting resources
>>>> leading to non working touchpad / thunderbolt hotplug issues) have
>>>> BIOS dates starting in 2019. I added a year margin, so we could make
>>>> this 2019.
>>>>
>>>>> I'm hesitant about changing the behavior for machines already in the
>>>>> field because if they were tested at all with Linux, it was without
>>>>> this patch.  So I would lean toward preserving the current behavior
>>>>> for BIOS year < 2023.
>>>>
>>>> I see, I presume the idea is to then use DMI to disable E820 clipping
>>>> on current devices where this is known to cause problems ?
>>>>
>>>> So for v8 I would:
>>>>
>>>> 1. Change the cut-off check to < 2023
>>>> 2. Drop the DMI quirks I added for models which are known to need E820
>>>>    clipping hit by the < 2018 check
>>>> 3. Add DMI quirks for models for which it is known that we must _not_
>>>>    do E820 clipping
>>>>
>>>> Is this the direction you want to go / does that sound right?
>>>
>>> Yes, I think that's what we should do.  All the machines in the field
>>> will be unaffected, except that we add quirks for known problems.
>>
>> I've been working on this today. I've mostly been going through
>> the all the existing bugs about this, to make a list of DMI matches
>> for devices on which we should _not_ do e820 clipping to fix th
>> kernel being unable to assign BARs there.
>>
>> I've found an interesting pattern there, all affected devices
>> are Lenovo devices with "IIL" in there device name, e.g. :
>> "IdeaPad 3 15IIL05". I've looked up all Lenovo devices which
>> have "IIL" as part of their DMI_PRODUCT_VERSION string here:
>> https://github.com/linuxhw/DMI/
>>
>> And then looked them up at https://linux-hardware.org/ and checked
>> their dmesg to see if they have the e820 problem other ideapads
>> have. I've gone through approx. half the list now and all
>> except one model seem to have the e820 problem.
>>
>> So it looks like we might be able to match all problem models
>> with a single DMI match.
>>
> 
>> So the problem seems to be limited to one specific device
>> series / range and this is making me have second thoughts
>> about doing a date based cut-off at all. Trying to switch
>> over any models which are new in 2023 is fine, the problem
>> with a DMI BIOS date approach though is that as soon as some
>> new management-engine CVE comes out we will also see BIOS
>> updates with a year of 2023 for many existing models, of
>> up to 3-4 years old at least; and chances are that some of
>> those older models getting BIOS updates will be bitten by
>> this change.
>>
>> So as said I'm having second thoughts about the date based
>> approach. Bjorn, what do you think of just using DMI quirks
>> to disable e820 clipping on known problematic models and
>> otherwise keeping things as is ?
> 
> The current v8 patch [1] adds quirks to disable clipping for Lenovo
> "*IIL*" and Acer Spin 5.  I think we also need to add one for Clevo
> Barebones [2], don't we?

Right looking at the dmesg output that one needs to be added to,
I've done that for the v9 which I'm preparing.

> Here's how I think about the date-based approach.  See if it seems
> sensible to you.
> 
> Without a date check, we'll continue clipping by default:
> 
>   - Future systems like Lenovo *IIL*, Acer Spin, and Clevo Barebones
>     will require new quirks to disable clipping.
> 
>   - The problem here is E820 entries that cover entire _CRS windows
>     that should not be clipped out.
> 
>   - I think these E820 entries are legal per spec, and it would be
>     hard to get BIOS vendors to change them.
> 
>   - We will discover new systems that need clipping disabled piecemeal
>     as they are released.
> 
>   - Future systems like Lenovo X1 Carbon and the Chromebooks (probably
>     anything using coreboot) will just work and we will not notice new
>     ones that rely on the clipping.
> 
>   - BIOS updates will not require new quirks unless they change the
>     DMI model string.
> 
> With a date check that disables clipping, e.g., "no clipping when
> date > 2022":
> 
>   - Future systems like Lenovo *IIL*, Acer Spin, and Clevo Barebones
>     will just work without new quirks.
> 
>   - Future systems like Lenovo X1 Carbon and the Chromebooks will
>     require new quirks to *enable* clipping.
> 
>   - The problem here is that _CRS contains regions that are not usable
>     by PCI devices, and we rely on the E820 kludge to clip them out.
> 
>   - I think this use of E820 is clearly a firmware bug, so we have a
>     fighting chance of getting it changed eventually.
> 
>   - BIOS updates after the cutoff date *will* require quirks, but only
>     for systems like Lenovo X1 Carbon and Chromebooks that we already
>     think have broken firmware.
> 
> Is that a fair summary?

Yes that seems a good summary to me. Actually it is so good I'm going
to steal it for the commit msg of the split out date check patch :)

> If so, it still seems to me like it's better to add quirks for
> firmware that we think is broken than for firmware that seems unusual
> but correct.

Ack.

> But I do think maybe we should split the date check to a separate
> patch.  The rationale for the date check (to put the quirk burden on
> systems with buggy firmware) is a little different from the "disable
> E820 clipping" reason for the quirks.
> 
> I think the "disable clipping" quirks by themselves should fix all the
> known broken systems, shouldn't they?

Yes they should.

> I'd really, really like to get
> these quirks in for v5.18 if possible.

Ok, I'll go and prepare a v9 and I will submit that later today.

> For future reference, I'm attaching below all the bugs I know about
> and the details of what's in E820 and _CRS.
> 
> Bjorn
> 
> [1] https://lore.kernel.org/r/20220512202511.34197-1-hdegoede@redhat.com
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=214259
> 
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=16228       Dell Precision T3500
>   BIOS-e820:                                   0xbfe4dc00-0xc0000000 (reserved)
>   pci_root PNP0A03:00: host bridge window [mem 0xbff00000-0xdfffffff]
>   pci 0000:00:1f.2: BAR 5: assigned [mem 0xbff00000-0xbff007ff]
>   ahci 0000:00:1f.2: controller reset failed (0xffffffff)
>   E820 covers part of _CRS window, 4dc2287c1805 clips that out.
>   Without 4dc2287c1805, doesn't boot because AHCI at
>   [mem 0xbff00000-0xbff007ff] is unusable.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=206459      Lenovo Yoga C940-14IIL
>   DMI: LENOVO 81Q9/LNVNB161216, BIOS AUCN54WW 01/09/2020
>   BIOS-e820:                         [mem 0x4bc50000-0xcfffffff] reserved
>   pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
>   pci 0000:2b:00.0: BAR 14: no space for [mem size 0x0c200000]
>   E820 covers entire _CRS window.  4dc2287c1805 clips it all out.
>   With 4dc2287c1805, Thunderbolt dock hot-add can't allocate MMIO
>   space.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=214259      Clevo X170KM Barebone
>   DMI: TUXEDO TUXEDO Book XUX7 - Gen12/X170KM-G, BIOS 1.07.05RTR1 02/01/2021
>   BIOS-e820:                         [mem 0x6bc00000-0xefffffff] reserved
>   pci_bus 0000:00: root bus resource [mem 0x71000000-0xdfffffff window]
>   BIOS-e820:                         [mem 0x0100000000-0x48effffff] usable
>   pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
>   pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit] # intel-lpss
>   pci 0000:00:15.1: reg 0x10: [mem 0x00000000-0x00000fff 64bit] # intel-lpss
>   pci 0000:00:15.2: reg 0x10: [mem 0x00000000-0x00000fff 64bit] # intel-lpss
>   pci 0000:00:19.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit] # intel-lpss
>   pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]       # intel_spi_pci, no window
>   pci 0000:00:15.0: BAR 0: assigned [mem 0x420210f000-0x420210ffff 64bit]
>   pci 0000:00:15.1: BAR 0: assigned [mem 0x4202111000-0x4202111fff 64bit]
>   pci 0000:00:15.2: BAR 0: assigned [mem 0x4202112000-0x4202112fff 64bit]
>   pci 0000:00:19.0: BAR 0: assigned [mem 0x4202113000-0x4202113fff 64bit]
>   pci 0000:00:1f.5: BAR 0: no space for [mem size 0x00001000]
>   E820 covers entire _CRS window.  4dc2287c1805 clips it all out.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1868899     Lenovo IdeaPad 3 15IIL05
>   DMI: LENOVO 81WE/LNVNB161216, BIOS EMCN44WW 12/23/2020
>   BIOS-e820:                         [mem 0x4bc50000-0xcfffffff] reserved
>   pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
>   pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
>   pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
>   E820 covers entire _CRS window.  4dc2287c1805 clips it all out.
>   With 4dc2287c1805, touchpad broken (BIOS didn't assign, no space to
>   allocate).
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1871793     Lenovo IdeaPad 5 14IIL05
>   DMI: LENOVO 81YH/LNVNB161216, BIOS DSCN22WW(V1.08) 03/06/2020
>   BIOS-e820:                         [mem 0x5bc50000-0xcfffffff] reserved
>   pci_bus 0000:00: root bus resource [mem 0x6d400000-0xbfffffff window]
>   pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
>   pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
>   E820 covers entire _CRS window.  4dc2287c1805 clips it all out.
>   With 4dc2287c1805, touchpad broken (BIOS didn't assign, no space to
>   allocate).
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=2029207     Lenovo X1 Carbon (20A7)
>   DMI: LENOVO 20A7008CUK/20A7008CUK, BIOS GRET63WW (1.40 ) 03/27/2020
>   BIOS-e820:                         [mem 0xdceff000-0xdfa0ffff] reserved
>   pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
>   pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfa00000-0xdfbfffff]
>   E820 covers part of _CRS window, 4dc2287c1805 clips that out.
>   Without 4dc2287c1805, doesn't wake from suspend because
>   [mem 0xdfa00000-0xdfa0ffff] unusable.
> 
> https://bugs.launchpad.net/bugs/1878279 Lenovo IdeaPad 5 14IIL05
>   DMI: LENOVO 81YH/LNVNB161216, BIOS DSCN23WW(V1.09) 03/25/2020
>   BIOS-e820:                         [mem 0x5bc50000-0xcfffffff] reserved
>   pci_bus 0000:00: root bus resource [mem 0x6d400000-0xbfffffff window]
>   pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
>   pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
>   E820 covers entire _CRS window.  4dc2287c1805 clips it all out.
>   With 4dc2287c1805, touchpad broken (BIOS didn't assign, no space to
>   allocate).
> 
> https://bugs.launchpad.net/bugs/1880172 Lenovo IdeaPad 3 14IIL05 Core i3-1005G1 (81WD004MGE)
>   DMI: LENOVO 81WD/LNVNB161216, BIOS EMCN13WW 03/06/2020
>   BIOS-e820:                         [mem 0x6b000000-0xcfffffff] reserved
>   pci_bus 0000:00: root bus resource [mem 0x70400000-0xbfffffff window]
>   pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
>   pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
>   E820 covers entire _CRS window.  4dc2287c1805 clips it all out.
>   With 4dc2287c1805, touchpad broken (BIOS didn't assign, no space to
>   allocate).
> 
> https://bugs.launchpad.net/bugs/1884232 Acer Spin SP513-54N
>   DMI: Acer Spin SP513-54N/Caboom_IL, BIOS V1.00 02/21/2020
>   BIOS-e820:                         [mem 0x39e00000-0xcfffffff] reserved
>   pci_bus 0000:00: root bus resource [mem 0x3f800000-0xbfffffff window]
>   pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
>   pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
>   E820 covers entire _CRS window.  4dc2287c1805 clips it all out.
>   With 4dc2287c1805, touchpad broken (BIOS didn't assign, no space to
>   allocate).
> 
> https://bugs.launchpad.net/bugs/1921649 Lenovo IdeaPad S145 82DJ0000BR
>   DMI: LENOVO 82DJ/LNVNB161216, BIOS DKCN48WW 07/22/2020
>   BIOS-e820:                         [mem 0x6b000000-0xcfffffff] reserved
>   pci_bus 0000:00: root bus resource [mem 0x70400000-0xbfffffff window]
>   pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
>   pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
>   E820 covers entire _CRS window.  4dc2287c1805 clips it all out.
>   With 4dc2287c1805, touchpad broken (BIOS didn't assign, no space to
>   allocate).
> 
> https://bugs.launchpad.net/bugs/1931715 Lenovo IdeaPad S145 82DJ0001BR
>   DMI: LENOVO 82DJ/LNVNB161216, BIOS DKCN51WW 12/23/2020
>   BIOS-e820:                         [mem 0x6b000000-0xcfffffff] reserved
>   pci_bus 0000:00: root bus resource [mem 0x70400000-0xbfffffff window]
>   pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
>   E820 covers entire _CRS window.  4dc2287c1805 clips it all out.
>   With 4dc2287c1805, touchpad broken, no dmesg from broken case.
> 
> https://bugs.launchpad.net/bugs/1932069 Lenovo BS145-15IIL
>   DMI: LENOVO 82HB/LNVNB161216, BIOS DKCN51WW 12/23/2020
>   BIOS-e820:                         [mem 0x4bc50000-0xcfffffff] reserved
>   pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
>   pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
>   pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
>   E820 covers entire _CRS window.  4dc2287c1805 clips it all out.
>   With 4dc2287c1805, touchpad broken (BIOS didn't assign, no space to
>   allocate).
> 
> https://lore.kernel.org/r/4e9fca2f-0af1-3684-6c97-4c35befd5019@redhat.com
> Google internal report b/148759816
>   Chromebook asus-C523NA-A20057-coral
>   BIOS-e820:                         [mem 0x7b000000-0x7fffffff] reserved
>   BIOS-e820:                         [mem 0xd0000000-0xd0ffffff]
>   acpi PNP0A08:00: ... [mem 0x7b800000-0x7fffffff window] ...
>   acpi PNP0A08:00: ... [mem 0x80000000-0xe0000000 window] ...
>   pci_bus 0000:00: root bus resource [mem 0x7b800000-0xe0000000 window]
>   E820 covers [mem 0x7b800000-0x7fffffff] of _CRS window.
>   E820 punches [mem 0xd0000000-0xd0ffffff] hole for hidden device.
>   4dc2287c1805 clips these out.  Without 4dc2287c1805, boot fails.
>   Hidden device is a landmine unless we trim it out.
> 
>   But 4c5e242d3e93 ("x86/PCI: Clip only host bridge windows for E820
>   regions") changes the time at which clipping is done.
> 
>   If clipping preserves resources *completely* covered by E820, and we
>   clip *before* coalescing, [mem 0x7b800000-0x7fffffff window] is
>   preserved and [mem 0xd0000000-0xd0ffffff] is clipped out, resulting
>   in [mem 0x7b800000-0xcfffffff window], where 0x7b800000-0x7fffffff is
>   not usable.
> 
>   If clipping preserves resources *completely* covered by E820, and we
>   clip *after* coalescing, we clip out [mem 0x7b000000-0x7fffffff]
>   and [mem 0xd0000000-0xd0ffffff], resulting in [mem
>   0x80000000-0xcfffffff window], which is usable.
> 
> Chromebook hp-x360-12b-n4000-octopus similar to asus-C523NA-A20057-coral
> 
> Summary:
>   These are broken by 4dc2287c1805:
>     https://bugzilla.kernel.org/show_bug.cgi?id=206459  01/09/2020 LENOVO
>     https://bugzilla.redhat.com/show_bug.cgi?id=1868899 12/23/2020 LENOVO
>     https://bugzilla.redhat.com/show_bug.cgi?id=1871793 03/06/2020 LENOVO
>     https://bugs.launchpad.net/bugs/1878279             03/25/2020 LENOVO
>     https://bugs.launchpad.net/bugs/1880172             03/06/2020 LENOVO
>     https://bugs.launchpad.net/bugs/1884232             02/21/2020 Acer
>     https://bugs.launchpad.net/bugs/1921649             07/22/2020 LENOVO
>     https://bugs.launchpad.net/bugs/1931715             12/23/2020 LENOVO
>     https://bugs.launchpad.net/bugs/1932069             12/23/2020 LENOVO
>       For all of the above, E820 covers entire _CRS window.  Trimming
>       the entire window means we can't assign any MMIO space.
> 
>   These require 4dc2287c1805:
>     https://bugzilla.kernel.org/show_bug.cgi?id=16228   03/09/2009 Dell
>     https://bugzilla.redhat.com/show_bug.cgi?id=2029207 03/27/2020 LENOVO
>     b/148759816 Chromebooks
>       For the above, E820 covers part of _CRS window.  Failure to trim
>       that part means we assign MMIO space that doesn't work.
> 

I believe that this summary is correct, except that the broken by
4dc2287c1805 list needs the TUXEDO / Clevo:

    https://bugzilla.kernel.org/show_bug.cgi?id=214259 02/01/2021 TUXEDO (Clevo)

Regards,

Hans






