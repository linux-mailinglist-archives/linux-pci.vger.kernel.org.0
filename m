Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39EC641BFC
	for <lists+linux-pci@lfdr.de>; Sun,  4 Dec 2022 10:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiLDJOE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Dec 2022 04:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiLDJOD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Dec 2022 04:14:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EB612AEE
        for <linux-pci@vger.kernel.org>; Sun,  4 Dec 2022 01:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670145189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKQI6sfDZHdRhMlTOunJHHcDomefCCRqPPQZcvnAYVk=;
        b=a5bzyaOFw3CLCLcKGSKtHC7aJPN+pEc+4EoFw6kmeP6OJtUneuQt3aOhUqhRPMOGzhLH7f
        4CdjXPshm5pla4k+9FHKzRZqOm6ThuLItctYGxVA458Ok93WYDaDRWAc+mwlLNvrYs1YoB
        sPyJfaTf5N9qA30u8+HOsXUlwjMlD1s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-13-W5oR2efTOzW43eGBtDbtvQ-1; Sun, 04 Dec 2022 04:13:08 -0500
X-MC-Unique: W5oR2efTOzW43eGBtDbtvQ-1
Received: by mail-ed1-f69.google.com with SMTP id g14-20020a056402090e00b0046790cd9082so4019737edz.21
        for <linux-pci@vger.kernel.org>; Sun, 04 Dec 2022 01:13:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKQI6sfDZHdRhMlTOunJHHcDomefCCRqPPQZcvnAYVk=;
        b=Ol+6MbB6zVVMxxnQpDKJuQna5TahIKYdrLgrboVRAcGasyRA/ACTK88rNIfTa9X3g4
         0idnGdyaeKDygYbX5fOEQu9faZIwvFNrUQirlI8TB2y2NVDjumQbvxnq6Z7nqUik4b2R
         c7RjlWSo6eH+BPOhTYpgzFCSqsm17v4bDzRNuvVkI/PPgOkANQPjFcgzVSRDYG6orhgS
         4X5NQYrIZTfKnWeGfynsTSbab70UGHp7tNLXqz/wjgEXOhB4ip5CUb1s8yc+t5lpRUpJ
         yy+X5rKfk5jEnmob/wWpx7tu0UDaGwOJYq8lDI+QA5X99oK32VRmL6Muel8oYvJGMmUx
         SsMQ==
X-Gm-Message-State: ANoB5pmLYanHYXayYqmS7Eo0oK+mPZPcdlfI/KUTW0kl0xFbP8yZoSTa
        DyQDjJ2Oo6hL0UikwZD4xB+AJYLXH7vaCLzG2BbMaDwRaAbSJwSM2ENDtAy/nIueD5MsRG+5eOJ
        S+qoIy5yaMkLKwYmsn3iH
X-Received: by 2002:aa7:c585:0:b0:46b:635a:ed8f with SMTP id g5-20020aa7c585000000b0046b635aed8fmr22848975edq.406.1670145186870;
        Sun, 04 Dec 2022 01:13:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf41T/1LsLvXLqNgWyRuGzDPYMBDJqBffFanrN4f0co5THBtjmmCfohHt9hq01EWQfEJEUXAFw==
X-Received: by 2002:aa7:c585:0:b0:46b:635a:ed8f with SMTP id g5-20020aa7c585000000b0046b635aed8fmr22848954edq.406.1670145186624;
        Sun, 04 Dec 2022 01:13:06 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id u19-20020aa7d0d3000000b00461bacee867sm4941353edo.25.2022.12.04.01.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 01:13:06 -0800 (PST)
Message-ID: <15fe50bb-bd11-677b-3cbd-645a267b7026@redhat.com>
Date:   Sun, 4 Dec 2022 10:13:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/4] PCI: Continue E820 vs host bridge window saga
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Florent DELAHAYE <kernelorg@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20221203175743.GA1121812@bhelgaas>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221203175743.GA1121812@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 12/3/22 18:57, Bjorn Helgaas wrote:
> On Sat, Dec 03, 2022 at 01:44:10PM +0100, Hans de Goede wrote:
>> Hi Bjorn,
>>
>> On 12/2/22 22:18, Bjorn Helgaas wrote:
>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> When allocating space for PCI BARs, Linux avoids allocating space mentioned
>>> in the E820 map.  This was originally done by 4dc2287c1805 ("x86: avoid
>>> E820 regions when allocating address space") to work around BIOS defects
>>> that included unusable space in host bridge _CRS.
>>>
>>> Some recent machines use EfiMemoryMappedIO for PCI MMCONFIG and host bridge
>>> apertures, and bootloaders and EFI stubs convert those to E820 regions,
>>> which means we can't allocate space for hot-added PCI devices (often a
>>> dock) or for devices the BIOS didn't configure (often a touchpad)
>>>
>>> The current strategy is to add DMI quirks that disable the E820 filtering
>>> on these machines and to disable it entirely starting with 2023 BIOSes:
>>>
>>>   d341838d776a ("x86/PCI: Disable E820 reserved region clipping via quirks")
>>>   0ae084d5a674 ("x86/PCI: Disable E820 reserved region clipping starting in 2023")
>>>
>>> But the quirks are problematic because it's really hard to list all the
>>> machines that need them.
>>>
>>> This series is an attempt at a more generic approach.  I'm told by firmware
>>> folks that EfiMemoryMappedIO means "the OS should map this area so EFI
>>> runtime services can use it in virtual mode," but does not prevent the OS
>>> from using it.
>>>
>>> The first patch removes any EfiMemoryMappedIO areas from the E820 map.
>>> This doesn't affect any virtual mapping of those areas (that would have to
>>> be done directly from the EFI memory map) but it means Linux can allocate
>>> space for PCI MMIO.
>>>
>>> The rest are basically cosmetic log message changes.
>>
>> Thank you for working on this. I'm a bit worried about this series though.
>>
>> The 2 things which I worry about are:
>>
>>
>> 1. I think this will not help when people boot in BIOS (CSM) mode rather
>> then UEFI mode which quite a few Linux users still do because they learned
>> to do this years ago when Linux EFI support (and EFI fw itself) was still
>> a bit in flux.
>>
>> IIRC from the last time we looked at this in CSM mode the BIOS itself
>> translates the EfiMemoryMappedIO areas to reserved E820 regions. So when
>> people use the BIOS CSM mode to boot, then this patch will not help
>> since the kernel lacks the info to do the translation.
> 
> Right, if BIOS CSM puts EfiMemoryMappedIO in the E820 map the same way
> bootloaders do, and the kernel doesn't have the EFI memory map, this
> series won't help.
> 
>> We may also hit the same case when the bootloader has done the
>> translation which I believe is what upstream grub does. Fedora grub
>> has been patched to use the kernel EFI stub when booting a kernel
>> on EFI, so just an EFI equivalent of "exec" on the kernel EFI binary.
>>
>> Where as upstream grub does a more BIOS like boot, where it skips the
>> EFI stub and instead does a whole bunch of stuff itself and then
>> jumps to the kernel's start vector. So this might also not work with
>> upstream grub, which is what I believe Ubuntu and Debian use.
>>
>> Although I case in this case we will still have access to the EFI
>> memory map and I see that your patch removes the entries stemming
>> from the EfiMemoryMappedIO areas from the E820 map, rather then
>> never adding them. So I guess this will also work in the case
>> when the bootloader has done the translation (leaving just
>> the BIOS CSM case as an issue)?
>>
>> This won't cause regressions, but it does mean that e.g. the
>> touchpad i2c-controller / hotplugged PCI devices will still not
>> work when booted in BIOS (CSM) mode / through upstream grub.
> 
> Yes, I agree CSM could still be broken if BIOS puts EfiMemoryMappedIO
> in the E820 map.
> 
> I'm not clear on the grub cases.  Do some grub versions hide the EFI
> memory map from the kernel?  If they do, they could be broken the same
> way as CSM.

I don't think grub hides the EFI memory map, I started writing
the bit about grub because I believe that grub creates its own
emulated E820 map, rather then relying on the kernel's EFI stub
creating an emulated E820 map. But since you take the emulated
map and then remove the EfiMemoryMappedIO entries afterwards
I think this should be fine.

(versus how patching the stub to never add the EfiMemoryMappedIO
entries would _not_ be fine because the emulated E820 map does not
always come from the EFI stub).

>> 2. I am afraid that now allowing PCI MMIO space to be allocated
>> in regions marked as EfiMemoryMappedIO will cause regressions
>> on some systems. Specifically when I tried something similar
>> the last time I looked at this (using the BIOS date cut-off
>> approach IIRC) there was a suspend/resume regression on
>> a Lenovo ThinkPad X1 carbon (20A7) model:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=2029207
>>
>> Back then I came to the conclusion that the problem is that not
>> avoiding the EfiMemoryMappedIO regions caused PCI MMIO space to
>> be allocated in the 0xdfa00000 - 0xdfa10000 range which is
>> listed in the EFI memmap as:
>>
>> [    0.000000] efi: mem46: [MMIO        |RUN|  |  |  |  |  |  |  |  |   |  |  |  |  ] range=[0x00000000dfa00000-0x00000000dfa0ffff] (0MB)
>>
>> And with current kernels with the extra logging added for this
>> the following is logged related to this:
>>
>> [    0.326504] acpi PNP0A08:00: clipped [mem 0xdfa00000-0xfebfffff window] to [mem 0xdfa10000-0xfebfffff window] for e820 entry [mem 0xdceff000-0xdfa0ffff]
>>
>> I believe patch 1/4 of this set will make this clipping go away,
>> re-introducing the suspend/resume problem.
> 
> Yes, I'm afraid you're right.  Comparing the logs at comment #31
> (fails) and comment #38 (works):
> 
>   pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
>   pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfa00000-0xdfbfffff] fails
>   pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfb00000-0xdfcfffff] works
> 
> Since 0xdfa00000 is included in the host bridge _CRS, but isn't
> usable, my guess is this is a _CRS bug.

Ack.

So I was thinking to maybe limit the removal of EfiMemoryMappedIO
regions from the E820 map if they are big enough to cause troubles?

Looking at the EFI map MMIO regions on this Lenovo ThinkPad X1 carbon
(20A7) model, they are tiny. Where as the ones which we know cause
problems are huge. So maybe add a bit of heuristics to patch 1/4 based
on the EfiMemoryMappedIO region size and only remove the big ones
from the E820 map ?

I know that adding heuristics like this always feels a bit wrong,
because you end up putting a somewhat arbitrary cut off point in
the code on which to toggle behavior on/off, but I think that in
this case it should work nicely given how huge the EfiMemoryMappedIO
regions which are actually causing problems are.

> Or maybe BIOS is using the producer/consumer bit in _CRS to identify
> this as register space as opposed to a window?  I thought we couldn't
> rely on that bit, but it's been a long time since I looked at it.  An
> acpidump might have a clue.

Regards,

Hans



