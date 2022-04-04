Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D43C4F1124
	for <lists+linux-pci@lfdr.de>; Mon,  4 Apr 2022 10:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiDDIrN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Apr 2022 04:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbiDDIrL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Apr 2022 04:47:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A028C15FE3
        for <linux-pci@vger.kernel.org>; Mon,  4 Apr 2022 01:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649061914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n/Ts5fJReuhpZGYD+CsYHS5c53jBKIODpIAVaNkw9Ys=;
        b=GzuWXtsXPdfe6ALShROASEOJqmjxzL/3Yz7q/sBgc2MWm335ickVryYyVMFJEGuj6smWEq
        8CHN3Q05NqOr71HyGkVGaPQBiPpu2rhJLtdMWj+eCSMSa2C6MDG0sOfr+TfQrxPYmB9wH+
        rieIKEgMVtGO2K6TRKb1M3mZutuxYmA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-gTIYYgaONnmHZ4xdkAeuVg-1; Mon, 04 Apr 2022 04:45:12 -0400
X-MC-Unique: gTIYYgaONnmHZ4xdkAeuVg-1
Received: by mail-ed1-f72.google.com with SMTP id b24-20020a50e798000000b0041631767675so5063547edn.23
        for <linux-pci@vger.kernel.org>; Mon, 04 Apr 2022 01:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n/Ts5fJReuhpZGYD+CsYHS5c53jBKIODpIAVaNkw9Ys=;
        b=VXdsXmetrZkIDXJlRirz6zRikYviWv9L5EznKGjeUnOh/MD3UDNpQtMdr+ylCI9QXI
         7LU3FdNqHnwjB9+YmGCqWd96txeqha4Yt9zR7n0rRty/X5vRUWoaMZtLiR3hMze2OAOo
         RPAXCMiLdSXEaf+GHOVVZjQMA7Xk2McBfrnrxqqzt8BsZvw4hEEYs24coq8QXqbEQ5sI
         FjVR+vvBILwC5eyKIcwmWAaz4F94p3teLGXPUWX8Vh2QwB8ARUO3ukxeqK0L3ytyfDT/
         j7r+a0wH7pO/YCYNAOWi7RTaARhZL81f+37JnezsyqDqc/9kFKih+iVRnHv4egxxlTss
         3CHw==
X-Gm-Message-State: AOAM533qzd+ko/rqFPVA0XaI0PihTGfKLjWa5qQkhh1jwHwHqz217M4z
        jjFW0CA7u5v8YEOyF+RqQWFRvJ0QgOok3wOkhaGoo68oXSx39zFMNfYR0UDV0S7ufkUe2cqrebo
        1WwmbL0FU7SpR6g0FoADG
X-Received: by 2002:a17:907:6e89:b0:6df:d819:dc9c with SMTP id sh9-20020a1709076e8900b006dfd819dc9cmr10403118ejc.158.1649061911474;
        Mon, 04 Apr 2022 01:45:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6Ho5lEAVY4UVDgMgIwjyI2+kIxNhsRMNYXg9RCruR0kajmmWwqLJsuFmUIReofjCE8L/Nvw==
X-Received: by 2002:a17:907:6e89:b0:6df:d819:dc9c with SMTP id sh9-20020a1709076e8900b006dfd819dc9cmr10403108ejc.158.1649061911242;
        Mon, 04 Apr 2022 01:45:11 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id kx5-20020a170907774500b006e1382b8192sm4131374ejc.147.2022.04.04.01.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 01:45:10 -0700 (PDT)
Message-ID: <76c5de03-a3a4-8444-d7f6-496fa119d830@redhat.com>
Date:   Mon, 4 Apr 2022 10:45:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: next/master bisection: baseline.login on asus-C523NA-A20057-coral
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-pci@vger.kernel.org
References: <20220330113550.GA1638045@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220330113550.GA1638045@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 3/30/22 13:35, Bjorn Helgaas wrote:
> On Mon, Mar 28, 2022 at 02:54:42PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 3/24/22 23:19, Mark Brown wrote:
>>> On Thu, Mar 24, 2022 at 09:34:30PM +0100, Hans de Goede wrote:
>>>
>>>> Mark, if one of use writes a test patch, can you get that Asus machine to boot a
>>>> kernel build from next + the test patch ?
>>>
>>> I can't directly unfortunately as the board is in Collabora's lab but
>>> Guillaume (who's already CCed) ought to be able to, and I can generally
>>> prod and try to get that done.
>>
>> Ok, Guillaume, can you try a kernel with commit 5949965ec9340cfc0e65f7d8a576b660b26e2535
>> ("x86/PCI: Preserve host bridge windows completely covered by E820") + the 
>> attached patch added on top a try on the asus-C523NA-A20057-coral machine please
>> and see if that makes it boot again ?
>>
>> Regards,
>>
>> Hans
> 
>> From b8080a6d2d889847900e1408f71d0c01c73f5c94 Mon Sep 17 00:00:00 2001
>> From: Hans de Goede <hdegoede@redhat.com>
>> Date: Mon, 28 Mar 2022 14:47:41 +0200
>> Subject: [PATCH] x86/PCI: Limit "e820 entry fully covers window" check to non
>>  ISA MMIO addresses
>>
>> Commit FIXME ("x86/PCI: Preserve host bridge windows completely
>> covered by E820") added a check to skip e820 table entries which
>> fully cover a PCI bride's memory window when clipping PCI bridge
>> memory windows.
>>
>> This check also caused ISA MMIO windows to not get clipped when
>> fully covered, which is causing some coreboot based Chromebooks
>> to not boot.
>>
>> Modify the fully covered check to not apply to ISA MMIO windows.
> 
> I'd like to include URLs to the kernelci results unless they are
> ephemeral.  There's a lot of valuable information in these:
> 
>   Asus C523NA-A20057-coral with the last good commit:
>   https://lava.collabora.co.uk/scheduler/job/5937945
> 
>   https://storage.kernelci.org/next/master/next-20220310/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
>   https://storage.kernelci.org/next/master/next-20220310/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-n4000-octopus.html

Ok, I'll include this in any future patches for this.

> 
>> Fixes: FIXME ("x86/PCI: Preserve host bridge windows completely covered by E820")
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  arch/x86/kernel/resource.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
>> index 6be82e16e5f4..d9ec913619c3 100644
>> --- a/arch/x86/kernel/resource.c
>> +++ b/arch/x86/kernel/resource.c
>> @@ -46,8 +46,12 @@ void remove_e820_regions(struct device *dev, struct resource *avail)
>>  		 * devices.  But if it covers the *entire* resource, it's
>>  		 * more likely just telling us that this is MMIO space, and
>>  		 * that doesn't need to be removed.
>> +		 * Note this *entire* resource covering check is only
>> +		 * intended for 32 bit memory resources for the 16 bit
>> +		 * isa window we always apply the e820 entries.
>>  		 */
>> -		if (e820_start <= avail->start && avail->end <= e820_end) {
>> +		if (avail->start >= ISA_END_ADDRESS &&
> 
> What is the justification for needing to check ISA_END_ADDRESS here?
> The commit log basically says "this makes it work", which isn't very
> satisfying.

I did not have a log with the:

>   acpi PNP0A08:00: clipped [mem 0x000a0000-0x000bffff window] to [mem 0x00100000-0x000bffff window] for e820 entry [mem 0x000a0000-0x000fffff]
>   acpi PNP0A08:00: clipped [mem 0x7b800000-0x7fffffff window] to [mem 0x80000000-0x7fffffff window] for e820 entry [mem 0x7b000000-0x7fffffff]
>   acpi PNP0A08:00: clipped [mem 0x80000000-0xe0000000 window] to [mem 0x80000000-0xcfffffff window] for e820 entry [mem 0xd0000000-0xd0ffffff]

messages. Instead I was looking at this log:

https://storage.kernelci.org/next/master/next-20220310/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html

With the following messages (as I quoted higher up in the email-thread):

"""
 1839 17:54:41.406548  <6>[    0.000000] BIOS-provided physical RAM map:
 1840 17:54:41.413121  <6>[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] type 16
 1841 17:54:41.419712  <6>[    0.000000] BIOS-e820: [mem 0x0000000000001000-0x000000000009ffff] usable
 1842 17:54:41.430192  <6>[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
 1843 17:54:41.436207  <6>[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000000fffffff] usable
 1844 17:54:41.446353  <6>[    0.000000] BIOS-e820: [mem 0x0000000010000000-0x0000000012150fff] reserved
 1845 17:54:41.453290  <6>[    0.000000] BIOS-e820: [mem 0x0000000012151000-0x000000007a9fcfff] usable
 1846 17:54:41.459966  <6>[    0.000000] BIOS-e820: [mem 0x000000007a9fd000-0x000000007affffff] type 16
 1847 17:54:41.469549  <6>[    0.000000] BIOS-e820: [mem 0x000000007b000000-0x000000007fffffff] reserved
 1848 17:54:41.476685  <6>[    0.000000] BIOS-e820: [mem 0x00000000d0000000-0x00000000d0ffffff] reserved
 1849 17:54:41.486439  <6>[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
 1850 17:54:41.492994  <6>[    0.000000] BIOS-e820: [mem 0x00000000fed10000-0x00000000fed17fff] reserved
 1851 17:54:41.503008  <6>[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000017fffffff] usable
...
 2030 17:54:42.809183  <6>[    0.313771] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
 2031 17:54:42.819092  <6>[    0.314424] pci_bus 0000:00: root bus resource [mem 0x7b800000-0xe0000000 window]
"""

###

What I find weird here is that this boot with a somewhat earlier kernel has:

 2030 17:54:42.809183  <6>[    0.313771] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
 2031 17:54:42.819092  <6>[    0.314424] pci_bus 0000:00: root bus resource [mem 0x7b800000-0xe0000000 window]

Where as the boot with the clipped messages has:

<6>[    0.313705] acpi PNP0A08:00: ignoring host bridge window [mem 0x00100000-0x000bffff window] (conflicts with PCI mem [mem 0x00000000-0x7fffffffff])
<6>[    0.314702] acpi PNP0A08:00: ignoring host bridge window [mem 0x80000000-0x7fffffff window] (conflicts with PCI mem [mem 0x00000000-0x7fffffffff])
<6>[    0.315747] PCI host bridge to bus 0000:00
<6>[    0.316118] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
<6>[    0.316703] pci_bus 0000:00: root bus resource [io  0x1000-0xffff window]
<6>[    0.317298] pci_bus 0000:00: root bus resource [mem 0x80000000-0xcfffffff window]
<6>[    0.317703] pci_bus 0000:00: root bus resource [bus 00-ff]

So in the boot with the clipped messages we are getting 3 windows from _CRS
where as before we were getting only 2?  I know that we are now applying
the clipping directly when we are parsing the resources. So I guess that
before we somehow also merged the 2 resources which are back to back together
before the "root bus resource" messages get printed. This caused me to just
see the "root bus resource [mem 0x7b800000-0xe0000000 window]" which is
not fully covered which is why I focused on the ISA MMIO window.

> The Asus log of the last good commit shows:
> 
>   PCI: 00:0d.0 [8086/5a92] enabled
>   constrain_resources: PCI: 00:0d.0 10 base d0000000 limit d0ffffff mem (fixed)
>   ...
>   BIOS-e820: [mem 0x000000007b000000-0x000000007fffffff] reserved
>   BIOS-e820: [mem 0x00000000d0000000-0x00000000d0ffffff] reserved
>   BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
>   ...
>   acpi PNP0A08:00: clipped [mem 0x000a0000-0x000bffff window] to [mem 0x00100000-0x000bffff window] for e820 entry [mem 0x000a0000-0x000fffff]
>   acpi PNP0A08:00: clipped [mem 0x7b800000-0x7fffffff window] to [mem 0x80000000-0x7fffffff window] for e820 entry [mem 0x7b000000-0x7fffffff]
>   acpi PNP0A08:00: clipped [mem 0x80000000-0xe0000000 window] to [mem 0x80000000-0xcfffffff window] for e820 entry [mem 0xd0000000-0xd0ffffff]
>   acpi PNP0A08:00: ignoring host bridge window [mem 0x00100000-0x000bffff window] (conflicts with PCI mem [mem 0x00000000-0x7fffffffff])
>   acpi PNP0A08:00: ignoring host bridge window [mem 0x80000000-0x7fffffff window] (conflicts with PCI mem [mem 0x00000000-0x7fffffffff])
> 
> It looks like _CRS gave us [mem 0x80000000-0xe0000000 window], which
> is one byte too big (it should end at 0xdfffffff).

Yeah but that gets clipped off anyways, so that should not matter.

s> 
> From the firmware part of the log, it looks like 00:0d.0 is a hidden
> device that consumes [mem d0000000-0xd0ffffff].  Linux doesn't
> enumerate 00:0d.0, so firmware should have carved that out of the [mem
> 0x80000000-0xe0000000 window] in _CRS.
> 
> We don't have a log with 5949965ec934 ("x86/PCI: Preserve host bridge
> windows completely covered by E820") applied, but I think it would
> show this:
> 
>   acpi PNP0A08:00: resource [mem 0x000a0000-0x000bffff window] fully covered by e820 entry [mem 0x000a0000-0x000fffff]
>   acpi PNP0A08:00: resource [mem 0x7b800000-0x7fffffff window] fully covered by e820 entry [mem 0x7b000000-0x7fffffff]
> 
> instead of clipping those windows.  But none of the devices we
> enumerate appears to be using either of those windows.

Not with a working kernel no, because they are clipped of, but
with the don't clip fully-covered _CRS windows change, the 
[mem 0x7b000000-0x7fffffff] all of a sudden becomes fair game
to assign BARs to.

I agree that we will get a fully-covered msg for that one with
the patch, which would change:

[    0.317298] pci_bus 0000:00: root bus resource [mem 0x80000000-0xcfffffff window]

to:

[    0.317298] pci_bus 0000:00: root bus resource [mem 0x7b800000-0xcfffffff window]

and I believe that likely is our culprit.

So to fix this I guess that we first need to merge back-to-back
windows coming from _CRS into a single window, before calling
remove_e820_regions()

That would pass [mem 0x7b800000-0xe0000000 window] to remove_e820_regions()
in a single call (as I expected from the logs), which should result in
both the top and the bottom still getting clipped as before.

I've been looking around in the code a but I could not quickly find
a helper to do the back-to-back resource merging before calling
remove_e820_regions(), any suggestions for this?

Regards,

Hans







> 
> We do have this:
> 
>   pci 0000:00:18.2: reg 0x10: [mem 0xde000000-0xde000fff 64bit]
>   pci 0000:00:18.2: reg 0x18: [mem 0xc2b31000-0xc2b31fff 64bit]
>   pci 0000:00:18.2: can't claim BAR 0 [mem 0xde000000-0xde000fff 64bit]: no compatible bridge window
>   pci 0000:00:18.2: BAR 0: assigned [mem 0x80000000-0x80000fff 64bit]
> 
> Where the original [mem 0xde000000-0xde000fff 64bit] assignment was
> perfectly legal, but we clipped [mem 0x80000000-0xe0000000 window] to
> [mem 0x80000000-0xcfffffff window] instead of just punching a hole for
> the 00:0d.0 carve-out.
> 
> Maybe 5949965ec934 puts 00:18.2 BAR 0 somewhere that doesn't work,
> or maybe the clipping to [mem 0x00100000-0x000bffff window] or
> [mem 0x80000000-0x7fffffff window] doesn't work as expected?
> They are supposed to be interpreted as "empty", but certainly
> resource_size([0x00100000-0x000bffff]) is != 0.
> 
>> +		    e820_start <= avail->start && avail->end <= e820_end) {
>>  			dev_info(dev, "resource %pR fully covered by e820 entry [mem %#010Lx-%#010Lx]\n",
>>  				 avail, e820_start, e820_end);
>>  			continue;
>> -- 
>> 2.35.1
>>
> 

