Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2AC4FB8C6
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 11:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344964AbiDKKAK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 06:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344952AbiDKKAB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 06:00:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 885774132F
        for <linux-pci@vger.kernel.org>; Mon, 11 Apr 2022 02:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649671065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dp34Ygcwz6e40FNYa/ckS6qT159QlZzvjGX+yru8/FE=;
        b=cDXEz5yn5UtZeOIEikBhPj6BVq873Q1tRV3KD6pQlpDKQWuG9BuWGR8Mx+Ha6BuIl6sLoE
        rWLrVqXnOOT6lIaBZw0DLSGhVsfp6yCqPfhpKdigaFvnPyagtNu9a8g3k/DXIif6wtgicT
        uyLfOMAs0ug9w4UMvtKy0Vo7ZWIjNQU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-8OUC0yB_NFuHDRPfWGhSIg-1; Mon, 11 Apr 2022 05:57:44 -0400
X-MC-Unique: 8OUC0yB_NFuHDRPfWGhSIg-1
Received: by mail-ed1-f72.google.com with SMTP id o20-20020aa7dd54000000b00413bc19ad08so8693489edw.7
        for <linux-pci@vger.kernel.org>; Mon, 11 Apr 2022 02:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=dp34Ygcwz6e40FNYa/ckS6qT159QlZzvjGX+yru8/FE=;
        b=gWujW0XVAjKwiGn3YqbeCPr/KkGK+EmLVKpFAIOXflyV9zh8kJzyHGc1/zcwuqPOlV
         lZcVpDyVg6IHu2Ei8BiQ3+9ABOKisa5dkjcLGAx5ENqxqQAnMeTkH26YLjFzizeWptV9
         vIA2UE6TPIfsjT8EEZc8yUNka1wbvxQ4LeR0KXRHDfmPR4aBYOiIg0FIOX36l/zDSBak
         WZoHZ+frB0zEEiHgJQHsPfTkmK/C0vRCHqb2PFw1L9NuDwK7/yIWkEwQA/h9wOGKJ8/o
         Acqn7+Jax81pS9Vq0q7GlR7JWJPMSJt8EhPZUJpdjGlWoiqlO/NNW62Znri5uIdgdLLc
         BU8g==
X-Gm-Message-State: AOAM5306ZySNaFAFOPbUNsCD3dCSrpKeadcIOX2bv/hhVxqPGgn+cNfu
        +heMVCLy001bDHsWCabyC/XkN/9rPJ0p78l3weMSTFyjt6o7kMM8OpVd3Hx3u/E3eSuaR4+MbA9
        bk5JlGyXGgwRdwWir9z8J
X-Received: by 2002:a17:907:8688:b0:6d2:c19:e1a0 with SMTP id qa8-20020a170907868800b006d20c19e1a0mr28063090ejc.249.1649671063139;
        Mon, 11 Apr 2022 02:57:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJldKIDZwaPOWeg5LbGWvxngw44oQWcZxyqw2oA8dpvKKR101zgpVYCyBH7Loq8gEy4LnKjg==
X-Received: by 2002:a17:907:8688:b0:6d2:c19:e1a0 with SMTP id qa8-20020a170907868800b006d20c19e1a0mr28063065ejc.249.1649671062717;
        Mon, 11 Apr 2022 02:57:42 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906284b00b006e108693850sm11709186ejc.28.2022.04.11.02.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 02:57:42 -0700 (PDT)
Message-ID: <d749f615-90da-4cce-323e-2840512babf3@redhat.com>
Date:   Mon, 11 Apr 2022 11:57:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: next/master bisection: baseline.login on asus-C523NA-A20057-coral
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-pci@vger.kernel.org
References: <20220406001942.GA74862@bhelgaas>
 <4cd5fd18-e0a0-649e-6714-eea8e137d2bc@redhat.com>
In-Reply-To: <4cd5fd18-e0a0-649e-6714-eea8e137d2bc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 4/11/22 11:54, Hans de Goede wrote:
> Hi Bjorn,
> 
> On 4/6/22 02:19, Bjorn Helgaas wrote:
>> On Mon, Apr 04, 2022 at 10:45:10AM +0200, Hans de Goede wrote:
>>> On 3/30/22 13:35, Bjorn Helgaas wrote:
>>>> On Mon, Mar 28, 2022 at 02:54:42PM +0200, Hans de Goede wrote:
>>
>>>>> Ok, Guillaume, can you try a kernel with commit 5949965ec9340cfc0e65f7d8a576b660b26e2535
>>>>> ("x86/PCI: Preserve host bridge windows completely covered by E820") + the 
>>>>> attached patch added on top a try on the asus-C523NA-A20057-coral machine please
>>>>> and see if that makes it boot again ?
>>
>>>>> From b8080a6d2d889847900e1408f71d0c01c73f5c94 Mon Sep 17 00:00:00 2001
>>>>> From: Hans de Goede <hdegoede@redhat.com>
>>>>> Date: Mon, 28 Mar 2022 14:47:41 +0200
>>>>> Subject: [PATCH] x86/PCI: Limit "e820 entry fully covers window" check to non
>>>>>  ISA MMIO addresses
>>>>>
>>>>> Commit FIXME ("x86/PCI: Preserve host bridge windows completely
>>>>> covered by E820") added a check to skip e820 table entries which
>>>>> fully cover a PCI bride's memory window when clipping PCI bridge
>>>>> memory windows.
>>>>>
>>>>> This check also caused ISA MMIO windows to not get clipped when
>>>>> fully covered, which is causing some coreboot based Chromebooks
>>>>> to not boot.
>>>>>
>>>>> Modify the fully covered check to not apply to ISA MMIO windows.
>>
>>>>> Fixes: FIXME ("x86/PCI: Preserve host bridge windows completely covered by E820")
>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>> ---
>>>>>  arch/x86/kernel/resource.c | 6 +++++-
>>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
>>>>> index 6be82e16e5f4..d9ec913619c3 100644
>>>>> --- a/arch/x86/kernel/resource.c
>>>>> +++ b/arch/x86/kernel/resource.c
>>>>> @@ -46,8 +46,12 @@ void remove_e820_regions(struct device *dev, struct resource *avail)
>>>>>  		 * devices.  But if it covers the *entire* resource, it's
>>>>>  		 * more likely just telling us that this is MMIO space, and
>>>>>  		 * that doesn't need to be removed.
>>>>> +		 * Note this *entire* resource covering check is only
>>>>> +		 * intended for 32 bit memory resources for the 16 bit
>>>>> +		 * isa window we always apply the e820 entries.
>>>>>  		 */
>>>>> -		if (e820_start <= avail->start && avail->end <= e820_end) {
>>>>> +		if (avail->start >= ISA_END_ADDRESS &&
>>>>
>>>> What is the justification for needing to check ISA_END_ADDRESS here?
>>>> The commit log basically says "this makes it work", which isn't very
>>>> satisfying.
>>>
>>> I did not have a log with the:
>>>
>>>>   acpi PNP0A08:00: clipped [mem 0x000a0000-0x000bffff window] to [mem 0x00100000-0x000bffff window] for e820 entry [mem 0x000a0000-0x000fffff]
>>>>   acpi PNP0A08:00: clipped [mem 0x7b800000-0x7fffffff window] to [mem 0x80000000-0x7fffffff window] for e820 entry [mem 0x7b000000-0x7fffffff]
>>>>   acpi PNP0A08:00: clipped [mem 0x80000000-0xe0000000 window] to [mem 0x80000000-0xcfffffff window] for e820 entry [mem 0xd0000000-0xd0ffffff]
>>>
>>> messages. Instead I was looking at this log:
>>>
>>> https://storage.kernelci.org/next/master/next-20220310/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
>>>
>>> With the following messages (as I quoted higher up in the email-thread):
>>>
>>> """
>>>  1839 17:54:41.406548  <6>[    0.000000] BIOS-provided physical RAM map:
>>>  1840 17:54:41.413121  <6>[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] type 16
>>>  1841 17:54:41.419712  <6>[    0.000000] BIOS-e820: [mem 0x0000000000001000-0x000000000009ffff] usable
>>>  1842 17:54:41.430192  <6>[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
>>>  1843 17:54:41.436207  <6>[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000000fffffff] usable
>>>  1844 17:54:41.446353  <6>[    0.000000] BIOS-e820: [mem 0x0000000010000000-0x0000000012150fff] reserved
>>>  1845 17:54:41.453290  <6>[    0.000000] BIOS-e820: [mem 0x0000000012151000-0x000000007a9fcfff] usable
>>>  1846 17:54:41.459966  <6>[    0.000000] BIOS-e820: [mem 0x000000007a9fd000-0x000000007affffff] type 16
>>>  1847 17:54:41.469549  <6>[    0.000000] BIOS-e820: [mem 0x000000007b000000-0x000000007fffffff] reserved
>>>  1848 17:54:41.476685  <6>[    0.000000] BIOS-e820: [mem 0x00000000d0000000-0x00000000d0ffffff] reserved
>>>  1849 17:54:41.486439  <6>[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
>>>  1850 17:54:41.492994  <6>[    0.000000] BIOS-e820: [mem 0x00000000fed10000-0x00000000fed17fff] reserved
>>>  1851 17:54:41.503008  <6>[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000017fffffff] usable
>>> ...
>>>  2030 17:54:42.809183  <6>[    0.313771] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
>>>  2031 17:54:42.819092  <6>[    0.314424] pci_bus 0000:00: root bus resource [mem 0x7b800000-0xe0000000 window]
>>> """
>>>
>>> ###
>>>
>>> What I find weird here is that this boot with a somewhat earlier kernel has:
>>>
>>>  2030 17:54:42.809183  <6>[    0.313771] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
>>>  2031 17:54:42.819092  <6>[    0.314424] pci_bus 0000:00: root bus resource [mem 0x7b800000-0xe0000000 window]
>>>
>>> Where as the boot with the clipped messages has:
>>>
>>> <6>[    0.313705] acpi PNP0A08:00: ignoring host bridge window [mem 0x00100000-0x000bffff window] (conflicts with PCI mem [mem 0x00000000-0x7fffffffff])
>>> <6>[    0.314702] acpi PNP0A08:00: ignoring host bridge window [mem 0x80000000-0x7fffffff window] (conflicts with PCI mem [mem 0x00000000-0x7fffffffff])
>>> <6>[    0.315747] PCI host bridge to bus 0000:00
>>> <6>[    0.316118] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
>>> <6>[    0.316703] pci_bus 0000:00: root bus resource [io  0x1000-0xffff window]
>>> <6>[    0.317298] pci_bus 0000:00: root bus resource [mem 0x80000000-0xcfffffff window]
>>> <6>[    0.317703] pci_bus 0000:00: root bus resource [bus 00-ff]
>>>
>>> So in the boot with the clipped messages we are getting 3 windows from _CRS
>>> where as before we were getting only 2?  I know that we are now applying
>>> the clipping directly when we are parsing the resources. So I guess that
>>> before we somehow also merged the 2 resources which are back to back together
>>> before the "root bus resource" messages get printed. This caused me to just
>>> see the "root bus resource [mem 0x7b800000-0xe0000000 window]" which is
>>> not fully covered which is why I focused on the ISA MMIO window.
>>
>> Yes, we do merge adjacent windows together.  See 7c3855c423b1 ("PCI:
>> Coalesce host bridge contiguous apertures") [1].  This is because our
>> BAR assignment isn't smart enough to assign space from two ajacent
>> resources to one BAR.
>>
>> We have (at least) three apertures, and the latter two would be merged
>> together:
>>
>>   acpi PNP0A08:00: ... [mem 0x000a0000-0x000bffff window] ...
>>   acpi PNP0A08:00: ... [mem 0x7b800000-0x7fffffff window] ...
>>   acpi PNP0A08:00: ... [mem 0x80000000-0xe0000000 window] ...
>>
>> The boot at [2] was with 5.17.0-rc7-next-20220310, which includes
>> 7f7b4236f204 ("x86/PCI: Ignore E820 reservations for bridge windows on
>> newer systems") [3], so we ignored E820 completely and we found two
>> windows (the VGA framebuffer and the big merged window):
>>
>>   Linux version 5.17.0-rc7-next-20220310 (KernelCI@build-j608383-x86-64-gcc-10-x86-64-defconfig-x86-chromebooc26pc) (gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1 SMP PREEMPT Fri Mar 11 17:23:28 UTC 2022
>>   pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
>>   pci_bus 0000:00: root bus resource [mem 0x7b800000-0xe0000000 window]
>>
>> The boot at [4] was with d13f73e9108a ("x86/PCI: Log host bridge
>> window clipping for E820 regions") [5].  In addition to logging,
>> d13f73e9108a also does the clipping *before* the merging:
>>
>>   Linux version 5.17.0-rc7 (KernelCI@0bd4b548bde7) (gcc (Debian 10.2.1-6) 
>>   acpi PNP0A08:00: clipped [mem 0x000a0000-0x000bffff window] to [mem 0x00100000-0x000bffff window] for e820 entry [mem 0x000a0000-0x000fffff]
>>   acpi PNP0A08:00: clipped [mem 0x7b800000-0x7fffffff window] to [mem 0x80000000-0x7fffffff window] for e820 entry [mem 0x7b000000-0x7fffffff]
>>   acpi PNP0A08:00: clipped [mem 0x80000000-0xe0000000 window] to [mem 0x80000000-0xcfffffff window] for e820 entry [mem 0xd0000000-0xd0ffffff]
>>   pci_bus 0000:00: root bus resource [mem 0x80000000-0xcfffffff window]
>>
>> Here we clipped the VGA framebuffer and [mem 0x7b800000-0x7fffffff]
>> completely out, so we ignored them, and we clipped the big window to
>> avoid [mem 0xd0000000-0xd0ffffff], so all we have left is
>> [mem 0x80000000-0xcfffffff].
>>
>>>> The Asus log of the last good commit shows:
>>>>
>>>>   PCI: 00:0d.0 [8086/5a92] enabled
>>>>   constrain_resources: PCI: 00:0d.0 10 base d0000000 limit d0ffffff mem (fixed)
>>>>   ...
>>>>   BIOS-e820: [mem 0x000000007b000000-0x000000007fffffff] reserved
>>>>   BIOS-e820: [mem 0x00000000d0000000-0x00000000d0ffffff] reserved
>>>>   BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
>>>>   ...
>>>>   acpi PNP0A08:00: clipped [mem 0x000a0000-0x000bffff window] to [mem 0x00100000-0x000bffff window] for e820 entry [mem 0x000a0000-0x000fffff]
>>>>   acpi PNP0A08:00: clipped [mem 0x7b800000-0x7fffffff window] to [mem 0x80000000-0x7fffffff window] for e820 entry [mem 0x7b000000-0x7fffffff]
>>>>   acpi PNP0A08:00: clipped [mem 0x80000000-0xe0000000 window] to [mem 0x80000000-0xcfffffff window] for e820 entry [mem 0xd0000000-0xd0ffffff]
>>>>   acpi PNP0A08:00: ignoring host bridge window [mem 0x00100000-0x000bffff window] (conflicts with PCI mem [mem 0x00000000-0x7fffffffff])
>>>>   acpi PNP0A08:00: ignoring host bridge window [mem 0x80000000-0x7fffffff window] (conflicts with PCI mem [mem 0x00000000-0x7fffffffff])
>>
>>>> From the firmware part of the log, it looks like 00:0d.0 is a hidden
>>>> device that consumes [mem d0000000-0xd0ffffff].  Linux doesn't
>>>> enumerate 00:0d.0, so firmware should have carved that out of the [mem
>>>> 0x80000000-0xe0000000 window] in _CRS.
>>>>
>>>> We don't have a log with 5949965ec934 ("x86/PCI: Preserve host bridge
>>>> windows completely covered by E820") applied, but I think it would
>>>> show this:
>>>>
>>>>   acpi PNP0A08:00: resource [mem 0x000a0000-0x000bffff window] fully covered by e820 entry [mem 0x000a0000-0x000fffff]
>>>>   acpi PNP0A08:00: resource [mem 0x7b800000-0x7fffffff window] fully covered by e820 entry [mem 0x7b000000-0x7fffffff]
>>>>
>>>> instead of clipping those windows.  But none of the devices we
>>>> enumerate appears to be using either of those windows.
>>>
>>> Not with a working kernel no, because they are clipped of, but
>>> with the don't clip fully-covered _CRS windows change, the 
>>> [mem 0x7b000000-0x7fffffff] all of a sudden becomes fair game
>>> to assign BARs to.
>>>
>>> I agree that we will get a fully-covered msg for that one with
>>> the patch, which would change:
>>>
>>> [    0.317298] pci_bus 0000:00: root bus resource [mem 0x80000000-0xcfffffff window]
>>>
>>> to:
>>>
>>> [    0.317298] pci_bus 0000:00: root bus resource [mem 0x7b800000-0xcfffffff window]
>>>
>>> and I believe that likely is our culprit.
>>
>> I think you're probably right.  We started with this:
>>
>>   BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
>>   BIOS-e820: [mem 0x000000007b000000-0x000000007fffffff] reserved
>>   BIOS-e820: [mem 0x00000000d0000000-0x00000000d0ffffff] reserved
>>   BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
>>   acpi PNP0A08:00: ... [mem 0x000a0000-0x000bffff window] ...
>>   acpi PNP0A08:00: ... [mem 0x7b800000-0x7fffffff window] ...
>>   acpi PNP0A08:00: ... [mem 0x80000000-0xe0000000 window] ...
>>
>> After 5949965ec934, clipping will give us this:
>>
>>   pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
>>   pci_bus 0000:00: root bus resource [mem 0x7b800000-0x7fffffff window]
>>   pci_bus 0000:00: root bus resource [mem 0x80000000-0xcfffffff window]
>>
>> and merging will give us this:
>>
>>   pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
>>   pci_bus 0000:00: root bus resource [mem 0x7b800000-0xcfffffff window]
>>
>> BIOS left a 00:18.2 BAR here [6]:
>>
>>   pci 0000:00:18.2: reg 0x10: [mem 0xde000000-0xde000fff 64bit]
>>
>> That BAR is outside the windows we know about, so we'll move it,
>> probably to 0x7b800000 and maybe it doesn't work there.
>>
>>> So to fix this I guess that we first need to merge back-to-back
>>> windows coming from _CRS into a single window, before calling
>>> remove_e820_regions()
>>>
>>> That would pass [mem 0x7b800000-0xe0000000 window] to
>>> remove_e820_regions() in a single call (as I expected from the
>>> logs), which should result in both the top and the bottom still
>>> getting clipped as before.
>>
>> So I think the progression is:
>>
>>   1) Remove anything mentioned in E820 from _CRS (4dc2287c1805 [7]).
>>      This worked around some issues on Dell systems.
>>
>>   2) Remove things mentioned in E820 unless they cover the entire
>>      window (5949965ec934 [8])
>>
>>   3) Coalesce adjacent _CRS windows, *then* remove things mentioned in
>>      E820 unless they cover the entire (coalesced) window (current
>>      proposal)
>>
>> Even 3) leaves us with the 00:18.2 BAR above that will be moved when
>> it doesn't need to be.
> 
> Right, but we currently already move it right, so this would not
> be a regression?
> 
>> That could lead us to something like this:
>>
>>   4) Coalesce adjacent _CRS windows, *then* remove things mentioned in
>>      E820 unless they cover the entire (coalesced) window (current
>>      proposal), but punch holes instead of lopping entire sections, so 
>>      we would end up with these windows:
>>
>>       pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
>>       pci_bus 0000:00: root bus resource [mem 0x7b800000-0xcfffffff window]
>>       pci_bus 0000:00: root bus resource [mem 0xd0100000-0xdfffffff window]
>>
>> But I don't think this is leading to a maintainable result.  We
>> shouldn't be using E820 at all in an ACPI system (and again, the fact
>> that we *do* use it is my fault, and I'll take my beatings).  We need
>> to *reduce* or at least contain that E820 usage instead of expanding
>> it.
> 
> The problem is that as both the Lenovo X1 carbon 3th gen (IIRC)
> regression as well as this regression shows, that not taking the
> E820 reservations into account at all leads to regressions left
> and right.
> 
> So it seems that not removing them is not really an option.
> 
> Also note that:
> 
>>   2) Remove things mentioned in E820 unless they cover the entire
>>      window (5949965ec934 [8])
>>
> 
> and:
> 
>>   3) Coalesce adjacent _CRS windows, *then* remove things mentioned in
>>      E820 unless they cover the entire (coalesced) window (current
>>      proposal)
> 
> Makes use use the E820 reservations less, since we now skip them in
> the cover entire window case. So this does follow your reduce
> E820 usage direction, but in a fine-grained manner so as to not
> cause regressions.

p.s.

Another option would be to go back to one of my initial patches for
this where we completely disable clipping _CRS windows based on
the E820 reservations on select models based on DMI matching the
models. This would at least allow us to finally fix the touchpad /
thunderbolt hotplug issues plaguing various Lenovo laptops, without
risking regressions elsewhere.

I'm starting to think that going the DMI quirk route here is not
such a bad idea after all...

Regards,

Hans

 

