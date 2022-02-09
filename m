Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7730F4AF168
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 13:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiBIMX1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 07:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbiBIMVr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 07:21:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E54BEC03BFF6
        for <linux-pci@vger.kernel.org>; Wed,  9 Feb 2022 04:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644409094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9aTgWorxmOMZ/GRWx8E/Y5Yeg9z/vdWCDtKaFrhYAk=;
        b=TlRSFt8zPYC2o7RhhpBltEY+Kk05FidzLg1iq2lmt5htCwEazz0r9HKfk8RyAfYmW7TQ52
        O2MFuTUva/xe6OutHYMhlldUnI0H//roY2XPtzkep1J4SOUVGwRgb+laAoumAJrOAk/UqJ
        o8OwqehrY/QhJu6OuHVVDu6cAPhsoNU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-vGy67boHPDSiuzdVscZvVA-1; Wed, 09 Feb 2022 07:18:13 -0500
X-MC-Unique: vGy67boHPDSiuzdVscZvVA-1
Received: by mail-ed1-f71.google.com with SMTP id k5-20020a508ac5000000b00408dec8390aso1235513edk.13
        for <linux-pci@vger.kernel.org>; Wed, 09 Feb 2022 04:18:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x9aTgWorxmOMZ/GRWx8E/Y5Yeg9z/vdWCDtKaFrhYAk=;
        b=z+4fEsGk6GzJJLQZ8fDuhaeUjQptt5XexrjBA8cNpkTBaAjCh7/4zGTfgW8vheNSFP
         lulsoMxp/nVgNEOSybqK4Sk3apsvQWeRmyMyh2aj0kA6qSR3wOutoRJKlKGqAiXQEkXF
         ooa/KuFXWXlcVlDVezKYzhPBfhKuDwKRXDuYDTXm640P0iOzTOfnKC/Wy8b0Vaua1f0o
         ua1tIS/EjQi/z3G7wPnzcdFDODYcdQf+IQ4NDljj/hWmo6iZhbFddxNo9vR7aN3XVFgF
         ibJKH+YVoKuJ8XdN/+tQkfywquw+MyUZG/1iqrCwOuTMkinPvhCSmw5Y9sudFAiS8u4l
         xX/Q==
X-Gm-Message-State: AOAM532JO6stWH2e/ARL8pdWm1G4aO1oPvYiQbyM1Pjv4j93DVmVFQ6O
        klk0deUBBzWREyhExVwG0+R+MJa4x9yF6d+PIs/5pNg8ecSDARM6Noq4oH3KakPWGCbJeMkECys
        X6YamPlHaT8aXJfFOU5zy
X-Received: by 2002:a17:907:6284:: with SMTP id nd4mr1615546ejc.477.1644409092645;
        Wed, 09 Feb 2022 04:18:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5yRGmfkZM7PQbKA6ApH5kjRw/HfFgs4ZlnVfUXlD/QPEsxVvOugzT4Xj40+L4H9rI0tCKrQ==
X-Received: by 2002:a17:907:6284:: with SMTP id nd4mr1615523ejc.477.1644409092423;
        Wed, 09 Feb 2022 04:18:12 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id kw5sm6043359ejc.140.2022.02.09.04.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 04:18:11 -0800 (PST)
Message-ID: <8dfcd932-b029-2bfe-2134-dd0182618cd7@redhat.com>
Date:   Wed, 9 Feb 2022 13:18:11 +0100
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

Hi Mika,

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

Agreed.

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

Oh, I just did some initial digging through the source code and indeed on EFI
there is no actual e820 memory map at all instead it gets faked to be able
to re-use the BIOS boot based e820 code in the kernel by do_add_efi_memmap()
from arch/x86/platform/efi/efi.c .

And that does:

		switch (md->type) {
		...
                default:
                        /*
                         * EFI_RESERVED_TYPE EFI_RUNTIME_SERVICES_CODE
                         * EFI_RUNTIME_SERVICES_DATA EFI_MEMORY_MAPPED_IO
                         * EFI_MEMORY_MAPPED_IO_PORT_SPACE EFI_PAL_CODE
                         */
                        e820_type = E820_TYPE_RESERVED;
                        break;

Which seems to be the root cause of the problems, at least on the Yoga C940,
but I expect on the others too (will try to get that confirmed).

So yes this seems like a very promising solution direction actually.
I will try to see if I can find a test-machine here in my home office
with an EFI memmap entry with a MMIO type and then see if I can come
up with a patch to make arch_remove_reservations() not exclude those
areas.

Regards,

Hans




