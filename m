Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CDE647609
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 20:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiLHTRc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 14:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLHTRb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 14:17:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A115A99539
        for <linux-pci@vger.kernel.org>; Thu,  8 Dec 2022 11:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670526995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MTmFSSsz+iEuRFF+TLjAXGnA587Ei6XR2PcJ8paquCk=;
        b=iSfAnjJw1pQHFvNYlxW0b/oddMJwWGGakBp26c/gZUti6b7J1uczTKhwWbgoMnYSwmTN8n
        ji8dGZ7Vg1U3uK5EhlMUjSp1Bh/zRlXsmfSh2FzQ6lWhvhaluAQI/McZsqIsSC2h/iHJc/
        TC3a7tULs5xyY6eh41dFDdAtjxKhvto=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-552-vvLxN4dJOaieWMgzpYZvrw-1; Thu, 08 Dec 2022 14:16:33 -0500
X-MC-Unique: vvLxN4dJOaieWMgzpYZvrw-1
Received: by mail-ed1-f70.google.com with SMTP id c9-20020a05640227c900b00463de74bc15so52838ede.13
        for <linux-pci@vger.kernel.org>; Thu, 08 Dec 2022 11:16:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTmFSSsz+iEuRFF+TLjAXGnA587Ei6XR2PcJ8paquCk=;
        b=3ekeR/X/4cPf7OCR2MYS/aKcFwxqadtdIeH6FaKjuirPiwlXr9CUXJwRDdy4U8Uzg6
         Hgxc4p5TbazJ9l/DjojX9+LKzyB/NltRQ5ei+3ea5Aopwf7D82ig3LTxmrkaLhzLWQci
         9zYN+azEyA/QO1ujwdDAM0vqNMiHPIxlXxrFC9qOlwVK3FE/Ai9Ds3UTFDbOWmwL9Sra
         yaJiDjsuElOUN2dksY2wDZAzdDBNnSDUUQe5XQQWES1gIM98F2fDC1gCZOvvpjH9nE1e
         LQSxBqzcc51Xo9VyTn5QknVAjQ+GA10rBcRMMLJ7ZAIIofrH5fKMM74y29vv8sJXlz61
         qFyA==
X-Gm-Message-State: ANoB5pmcK0eJ+CWObWdVA/RoNyViTFMThG006PfdtzaubUP+QmZIu/1c
        8lKOWH+w/qTHE6JesSzpN1SM4/oHGhUeN6v154VlItzMf/xUXTqoZ3BXi/mMmm6SZWKsPhjpcXS
        GQIwZ7xAG8WsWlof4Pv4o
X-Received: by 2002:a05:6402:298d:b0:461:f201:2d98 with SMTP id eq13-20020a056402298d00b00461f2012d98mr2826954edb.3.1670526992741;
        Thu, 08 Dec 2022 11:16:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7wl1P7mGcEUEOyQk271yeJILGTDdVupDVfcZTUXj5dftT3etqO2s8iD3iBioXEJZKJGWVPIQ==
X-Received: by 2002:a05:6402:298d:b0:461:f201:2d98 with SMTP id eq13-20020a056402298d00b00461f2012d98mr2826943edb.3.1670526992535;
        Thu, 08 Dec 2022 11:16:32 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090631c800b007aed2057eaesm9952618ejf.161.2022.12.08.11.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 11:16:32 -0800 (PST)
Message-ID: <92359eca-b651-8a1e-6de6-3107d87ac088@redhat.com>
Date:   Thu, 8 Dec 2022 20:16:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/4] PCI: Continue E820 vs host bridge window saga
Content-Language: en-US, nl
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
References: <20221208185758.GA1478771@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221208185758.GA1478771@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 12/8/22 19:57, Bjorn Helgaas wrote:
> On Wed, Dec 07, 2022 at 04:31:12PM +0100, Hans de Goede wrote:
>> On 12/4/22 10:13, Hans de Goede wrote:
>>
>> <snip>
>>
>>>>> 2. I am afraid that now allowing PCI MMIO space to be allocated
>>>>> in regions marked as EfiMemoryMappedIO will cause regressions
>>>>> on some systems. Specifically when I tried something similar
>>>>> the last time I looked at this (using the BIOS date cut-off
>>>>> approach IIRC) there was a suspend/resume regression on
>>>>> a Lenovo ThinkPad X1 carbon (20A7) model:
>>>>>
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=2029207
>>>>>
>>>>> Back then I came to the conclusion that the problem is that not
>>>>> avoiding the EfiMemoryMappedIO regions caused PCI MMIO space to
>>>>> be allocated in the 0xdfa00000 - 0xdfa10000 range which is
>>>>> listed in the EFI memmap as:
>>>>>
>>>>> [    0.000000] efi: mem46: [MMIO        |RUN|  |  |  |  |  |  |  |  |   |  |  |  |  ] range=[0x00000000dfa00000-0x00000000dfa0ffff] (0MB)
>>>>>
>>>>> And with current kernels with the extra logging added for this
>>>>> the following is logged related to this:
>>>>>
>>>>> [    0.326504] acpi PNP0A08:00: clipped [mem 0xdfa00000-0xfebfffff window] to [mem 0xdfa10000-0xfebfffff window] for e820 entry [mem 0xdceff000-0xdfa0ffff]
>>>>>
>>>>> I believe patch 1/4 of this set will make this clipping go away,
>>>>> re-introducing the suspend/resume problem.
>>>>
>>>> Yes, I'm afraid you're right.  Comparing the logs at comment #31
>>>> (fails) and comment #38 (works):
>>>>
>>>>   pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
>>>>   pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfa00000-0xdfbfffff] fails
>>>>   pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfb00000-0xdfcfffff] works
>>>>
>>>> Since 0xdfa00000 is included in the host bridge _CRS, but isn't
>>>> usable, my guess is this is a _CRS bug.
>>>
>>> Ack.
>>>
>>> So I was thinking to maybe limit the removal of EfiMemoryMappedIO
>>> regions from the E820 map if they are big enough to cause troubles?
>>>
>>> Looking at the EFI map MMIO regions on this Lenovo ThinkPad X1 carbon
>>> (20A7) model, they are tiny. Where as the ones which we know cause
>>> problems are huge. So maybe add a bit of heuristics to patch 1/4 based
>>> on the EfiMemoryMappedIO region size and only remove the big ones
>>> from the E820 map ?
>>>
>>> I know that adding heuristics like this always feels a bit wrong,
>>> because you end up putting a somewhat arbitrary cut off point in
>>> the code on which to toggle behavior on/off, but I think that in
>>> this case it should work nicely given how huge the EfiMemoryMappedIO
>>> regions which are actually causing problems are.
> 
> I'll post a v2 that removes only regions 256KB or larger in a minute.

Ok, may I ask why 256KB?

I see that that rules out then troublesome MMIO regions from the X1 carbon from:
https://bugzilla.redhat.com/show_bug.cgi?id=2029207 :
efi: mem46: [MMIO|RUN|  ] range=[0xdfa00000-0xdfa0ffff] (0MB) [64K]
which we know we need to avoid / keep reserved.

But OTOH the reservations which are causing the problems with assigning
resources to PCI devices by Linux look like this:
efi: mem50: [MMIO        |RUN|  |  |  |  |  |  |  |  |   |  |  |  |UC] range=[0x0000000065400000-0x00000000cfffffff] (1708MB)
which is significantly larger then 256KB.

So we could e.g. also put the cut-off point at 16MB and still
remove the above troublesome reservation from the E820 table.
Note just thinking out loud here. I have no idea if 16MB
would be better...


> 
>> Looking at the efi=debug output from:
>>
>> https://bugzilla-attachments.redhat.com/attachment.cgi?id=1861035
>>
>> The small MMIO regions which we most honor as reserved do
>> have the "RUN" (runtime) flag set in the EFI mmap.
> 
> Just trying to follow along here, so not sure any of the following is
> relevant ...
> 
> This attachment is from
> https://bugzilla.redhat.com/show_bug.cgi?id=2029207, and it shows:
> 
>   efi: mem46: [MMIO|RUN|  ] range=[0xdfa00000-0xdfa0ffff] (0MB) [64K]
>   efi: mem47: [MMIO|RUN|UC] range=[0xf80f8000-0xf80f8fff] (0MB)  [4K]
>   pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
>   pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed4bfff window]
> 
> mem46 is included in the PNP0A08 _CRS, and Ivan has verified
> experimentally that we have to avoid it.

Ack.

> mem47 is also included in the _CRS, but I don't have a clue what it
> is.  Maybe some hidden device used by BIOS but not visible to us?

Could be, there is at least one hidden device called the P2SB on
most Intel systems.

>> But I'm afraid that the same applies to the troublesome
>> MMIO EFI regions which cause the failures to assign
>> PCI regions for devices not setup by the firmware:
>>
>> https://bugzilla-attachments.redhat.com/attachment.cgi?id=1861407
>>
>> So that "RUN" flag is of no use.
> 
> I don't know what bug this attachment is from.

It is from https://bugzilla.redhat.com/show_bug.cgi?id=1868899
which is the ideapad slim 3 with the touchpad issue caused by the:
efi: mem50: [MMIO        |RUN|  |  |  |  |  |  |  |  |   |  |  |  |UC] range=[0x0000000065400000-0x00000000cfffffff] (1708MB)
reservation getting in the way of assigning resources to
the i2c-controller.

> Is the point here that you considered doing the E820 removal based on
> the EFI_MEMORY_RUNTIME memory *attribute* instead of the
> EFI_MEMORY_MAPPED_IO memory *type*?
> 
> I don't really know the details of EFI_MEMORY_MAPPED_IO vs
> EFI_MEMORY_RUNTIME, but it looks like EFI_MEMORY_RUNTIME can be
> applied to things like EFI_RUNTIME_SERVICES_CODE (not MMIO space) that
> should stay in E820.

Sorry for the confusion. What I was trying to say is that I was interested
in seeing if we could use the "RUN" flag to differentiate between:

1. The big MMIO region which we want to remove from the e820 map:
   efi: mem50: [MMIO        |RUN|  |  |  |  |  |  |  |  |   |  |  |  |UC] range=[0x0000000065400000-0x00000000cfffffff] (1708MB)

2. The small MMIO region which we want to keep to avoid the reported suspend/resume issue:
   efi: mem46: [MMIO|RUN|  ] range=[0xdfa00000-0xdfa0ffff] (0MB) [64K]

But unfortunately both have the RUN flag set so the RUN flag is
of no use to us.

Regards,

Hans


