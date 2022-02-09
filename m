Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0044AF4D9
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 16:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbiBIPMh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 10:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbiBIPMg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 10:12:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF575C0613C9
        for <linux-pci@vger.kernel.org>; Wed,  9 Feb 2022 07:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644419557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hG7985cd66f/yBsbfoQRS2y5UfKEpYOnUAXcCcaLUn4=;
        b=jWn7DuzUeGDqy4x5rPnVSZXBH5MOgxqZyf1+p9wug+8YbcK5KR7rgfJlOwmaR0Hfxev8OR
        pe6bEbbjzWosNn5FlZNq24ZXh52UZBG3zI0fRyAS2z1IB1AnxfEasK6woD/s4VL4YsKo+M
        QKr9JL6QL791Sn/bYKw3v9m2lnWV5L0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-tQMR1y_7M6qJlR6XfVn9Fw-1; Wed, 09 Feb 2022 10:12:36 -0500
X-MC-Unique: tQMR1y_7M6qJlR6XfVn9Fw-1
Received: by mail-ed1-f72.google.com with SMTP id f6-20020a0564021e8600b0040f662b99ffso1531722edf.7
        for <linux-pci@vger.kernel.org>; Wed, 09 Feb 2022 07:12:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hG7985cd66f/yBsbfoQRS2y5UfKEpYOnUAXcCcaLUn4=;
        b=OLBKnZo6rxJnN03t89MNQlx2XwInfTfj1MqF9sNiJyThZbNsegYJNH8UMv2+sEQM0R
         tn0DiJqx6w6BQcYsgaOVmNjVDJQ/sHRBYaveydPzHtGLVFU4+AY60Dnbwj9ocCFCJ483
         OUd7tNCC2/zrHjuF0wZO0UpLLWil2a5RKv/JwECjtDDuh+T34s8byppmz6LzFBMWXM/c
         V8aZhBkRWJTRUnw4I9ugfoPAIJpc26JUoJwVxBXCLkAk3E8KUtMe/U8PqtbMeQIFjpdc
         hxvtSCggaQ19WK1Z0a6mXBaq3qmRMDs3eDXcdHFjOquqEkFs9JlZFgWlsLuXBKHW/Zut
         Gbpw==
X-Gm-Message-State: AOAM5321CWxvA9/WBOgqocoHCxpJThiQ0AKvIVq//fo28FqeEaTKl3P6
        Snj2eBW3g3wC10YKhhCtW8xqXPPoC05AHpE2gLb0241BuT3XjwSwKDd+XL8tzi76dvJZN5IY+7Q
        B/59071X8l5a3VDpdinhh
X-Received: by 2002:a05:6402:b6a:: with SMTP id cb10mr3029900edb.140.1644419555465;
        Wed, 09 Feb 2022 07:12:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5GY5E0/UNox4aYt6kHhDgIEYgX5ir3OEZNYDEQ0U7seJ0Ir10ZxezCb6JSTay7lpCkPe31A==
X-Received: by 2002:a05:6402:b6a:: with SMTP id cb10mr3029861edb.140.1644419555207;
        Wed, 09 Feb 2022 07:12:35 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id j29sm1033161ejo.202.2022.02.09.07.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 07:12:34 -0800 (PST)
Message-ID: <02994528-aaad-5259-1774-19aeacdd18fc@redhat.com>
Date:   Wed, 9 Feb 2022 16:12:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [5.17 regression] "x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems" breaks suspend/resume
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>
References: <a7ad05fe-c2ab-a6d9-b66e-68e8c5688420@redhat.com>
 <697aaf96-ec60-4e11-b011-0e4151e714d7@redhat.com> <YgKcl9YX4HfjqZxS@lahna>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YgKcl9YX4HfjqZxS@lahna>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2/8/22 17:38, Mika Westerberg wrote:
> Hi Hans,
> 
> On Tue, Feb 08, 2022 at 04:59:13PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 2/8/22 16:25, Hans de Goede wrote:
>>> Hi All,
>>>
>>> Unfortunately I've just learned that commit 7f7b4236f204 ("x86/PCI:
>>> Ignore E820 reservations for bridge windows on newer systems"):
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7f7b4236f2040d19df1ddaf30047128b41e78de7
>>>
>>> breaks suspend/resume on at least one laptop model, the Lenovo ThinkPad
>>> X1 gen 2, see:
>>> https://bugzilla.redhat.com/show_bug.cgi?id=2029207
> 
> :-(
> 
>>> This regression was actually caught be Fedora already carrying this
>>> patch for a while now and as such it has been reproduced with 5.15
>>> with an older version of the patch which still allowed turning the
>>> new behavior of by adding "pci=use_e820". Dmesg output with and
>>> without the option has just been attached to the bug, I've not
>>> analyzed this any further yet.
>>>
>>> I guess that for now this means that we need to revert commit
>>> 7f7b4236f204. Rafael, I'll send you a revert with a commit msg
>>> explaining why this needs to be reverted tomorrow.
>>>
>>> More interesting IMHO is finding out another solution. Both the touchpad
>>> problem which got me looking into this:
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1868899
>>>
>>> As well as the thunderbolt hotplug issue Mika was looking at:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=206459
>>>
>>> both are cases where we fail to find a memory-window for a
>>> BAR which has not been setup yet.
>>>
>>> So I see a couple of options here:
>>>
>>> 1. Detect that the e820 reservations fully cover (one of)
>>> the PCI bridge main 32 bit memory windows and if that happens
>>> ignore them. This actually was my first plan when I started
>>> working on this. In the end I choose the other option
>>> because Bjorn indicated that in hindsight honoring the e820
>>> reservations might have been a mistake and maybe we should
>>> get rid of honoring them all together.
>>>
>>> 2. Have a flag which, when we fail to alloc a 32 bit
>>> (or 64 bit) memory PCI BAR, is set if not already set
>>> and then retry the alloc. And make the e820 reservation
>>> carve-out get skipped in this case.
>>>
>>> 3. When booting with pci=nocrs as a workaround for
>>> the touchpad case a 64 but memory window ends up getting
>>> used. There already is some special handling for some
>>> AMD bridges where if there are no 64 bit memory Windows
>>> in the _CRS for the bridge, one gets added. Maybe we need
>>> to do the same for Intel bridges ?
>>
>> 4. It seems that all devices which have issues with allocating
>> a PCI bar are Ice Lake based; and the model where the ignoring
>> of e820 reservations has been reported to cause issues is somewhat
>> old. It is a Haswell, but still getting BIOS updates causing
>> the BIOS date check to enable the new behavior. So another
>> solution might be to only ignore e820 reservations on machines
>> with Intel Ice Lake (and presumably also Tiger Lake) CPUs.
>>
>>
>> 5. It also seems that the troublesome e820 entry on all devices
>> ends at 0xcfffffff and starts well below 0x8000000 :
>>
>> Yoga C940:
>> [    0.000000] BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>>
>> IdeaPad 3 15IIL05:
>> [    0.000000] BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>>
>> Lenovo IdeaPad 5 14IIL05:
>> [    0.000000] BIOS-e820: [mem 0x000000005bc50000-0x00000000cfffffff] reserved
> 
> I don't remember the details anymore but looking at the commit log of my
> "fix" attempt here:
> 
> https://bugzilla.kernel.org/attachment.cgi?id=287661
> 
> The EFI memory map actually seems to consists of several entries that somehow
> are merged by something (I think this is the EFI stub but not sure). Booting
> with "efi=debug" may help us to understand this further (or not).
> 
> On that Yoga system, this:
> 
>   [Reserved           |   |  |  |  |  |  |  | |   |WB|WT|WC|UC] range=[0x000000002bc50000-0x000000003fffffff] (323MB)
>   [Reserved           |   |  |  |  |  |  |  | |   |WB|  |  |UC] range=[0x0000000040000000-0x0000000040ffffff] (16MB)
>   [Reserved           |   |  |  |  |  |  |  | |   |  |  |  |  ] range=[0x0000000041000000-0x00000000453fffff] (68MB)
>   [Memory Mapped I/O  |RUN|  |  |  |  |  |  | |   |  |  |  |UC] range=[0x0000000045400000-0x00000000cfffffff] (2220MB)
> 
> became this:
> 
>   BIOS-e820: [mem 0x000000002bc50000-0x00000000cfffffff] reserved
> 
> Since the area (0x45400000-0xcfffffff) is marked as MMIO I think maybe we can
> simply skip those areas in arch_remove_reservations() or so?
> 
> I may be missing a lots of details, though. ;-)

So I've been looking at this for a couple of hours now and I've
basically re-invented your original fix from:

https://lkml.org/lkml/2020/6/17/751

So here we are 2 years later and that still looks like the best
fix, so IMHO we should just go with that fix.

An alternative, much more elaborate fix would be to:

1. Add E820_TYPE_MMIO and E820_TYPE_MMIO_PCI_BRIDGE_WINDOW types to
   enum e820_type and modify the 2 places which check for type == reserved
   to treat these both as reserved too, so as to not have any functional
   changes there

2. Modify the code building e820 tables from the EFI memmap to use
   E820_TYPE_MMIO for MMIO EFI memmap entries and make e820_nomerge()
   treat E820_TYPE_MMIO as non mergable to retain these as is

3. Modify pci_acpi_root_prepare_resources() to compare ACPI provided
   bridge mmio windows against E820_TYPE_MMIO e820_Table entries and
   if there is an exact match (as is the case on the Yoga C940)
   then change the e820 type to E820_TYPE_MMIO_PCI_BRIDGE_WINDOW

   This means that we are now very narrowly treating EFI MMIO marked
   regions special, in the special case where they are a 1:1 map
   to an ACPI PCI bridge window resource.

   Note since we treat both E820_TYPE_MMIO and E820_TYPE_MMIO_PCI_BRIDGE_WINDOW
   identical to the old RESERVED everywhere there is no functional change
   here.

4. Modify arch/x86/kernel/resource.c: remove_e820_regions() to skip
   e820 table entries with a type of E820_TYPE_MMIO_PCI_BRIDGE_WINDOW,
   this would actually be a functional change and should fix the
   issues we are trying to fix.

Note an alternative would be to skip having the extra E820_TYPE_MMIO_PCI_BRIDGE_WINDOW
type and to skip step 3. above. That would boil down to doing the same
as your original patch in a somewhat cleaner manner.

Regards,

Hans







