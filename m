Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E2E642A5F
	for <lists+linux-pci@lfdr.de>; Mon,  5 Dec 2022 15:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiLEO15 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Dec 2022 09:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiLEO1v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2022 09:27:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846F710A
        for <linux-pci@vger.kernel.org>; Mon,  5 Dec 2022 06:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670250410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H22ZgLtdP401clVrTv9DfGALXleAtANesjpomK6aL5I=;
        b=Jy+CtpGWORfo3/nEAUgX96mts/I1odfP+VgH6N3yYjDpd24pl53QJlcUQWoVeVfL0RUAJ7
        rUgSgTulgd0mMFzx8BI5Qh6QwDzlpz1RD2YR3wNWJk3SV3WZyIDxP6xYEIobGiql6M6LpV
        gAcfZk/3kHLfqiSIwbNKi2gBwgPm8OE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-324-ndCfQItKMdK1UWoqDyEecw-1; Mon, 05 Dec 2022 09:26:49 -0500
X-MC-Unique: ndCfQItKMdK1UWoqDyEecw-1
Received: by mail-ej1-f69.google.com with SMTP id sc5-20020a1709078a0500b007c0ca93c161so4927417ejc.7
        for <linux-pci@vger.kernel.org>; Mon, 05 Dec 2022 06:26:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H22ZgLtdP401clVrTv9DfGALXleAtANesjpomK6aL5I=;
        b=t7P9X280CbfCSDJN53KKp/8lnMKk6/wBoSrPqt8Oy0wW775mq9x0bA5+SEWZmGhozJ
         kR4OuK1beHVqtPHDqEmFL3RoOqdydE3aWgW6Jh9tmjP8CXWo8oYj1TqIzF8mL4KyVjYi
         ea2meVDolsQEe9fdrj1PMm82MOWMf7BWYhLMcA8E5Zmby/uDwlW+ffGkCjenaWWoyeSz
         XAm5fu4meIBxzeMLCNeNp2LUBa3U7p35xNNn3UtlzTX+EXJLbbYJyaMiPoXYsVMpbEXG
         c8OB/vh4YD2lv/4VKuLUk21vaf4JIWIyzJ7frjJpESJaZdd7FqbJZt+f4/3XAvhniiqz
         l3Qg==
X-Gm-Message-State: ANoB5pk5qh6HM4NkXhve5C9AySbdIKoKrb2duTp/hfXAx0qav+eCahpf
        6LT5EBeLc7RpZx3S4o9g17py+kQOpVX0/nR1V7jlBt3RAu96/c0Qn6YTC16A1jPvcvddMpBNYj8
        7Bz3PoSCoGGwbQsVpMw5+
X-Received: by 2002:a17:906:3155:b0:7ad:90db:c241 with SMTP id e21-20020a170906315500b007ad90dbc241mr69699816eje.284.1670250408251;
        Mon, 05 Dec 2022 06:26:48 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7ektOxn96d0n6c++JMdckwZDj0ch2qMmY4BbUvKpdRpgSJIlhA7jyAcR/FYR7KyZrcZ56azw==
X-Received: by 2002:a17:906:3155:b0:7ad:90db:c241 with SMTP id e21-20020a170906315500b007ad90dbc241mr69699797eje.284.1670250407977;
        Mon, 05 Dec 2022 06:26:47 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090631c800b007aed2057eaesm6232717ejf.161.2022.12.05.06.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 06:26:47 -0800 (PST)
Message-ID: <ec78042b-0013-e120-a7fe-16e0a92c6783@redhat.com>
Date:   Mon, 5 Dec 2022 15:26:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/4] PCI: Continue E820 vs host bridge window saga
Content-Language: en-US
To:     Werner Sembach <wse@tuxedocomputers.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Florent DELAHAYE <kernelorg@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20221203175743.GA1121812@bhelgaas>
 <d7f1408d-ae9f-ad55-5fc9-9d9886384a3d@redhat.com>
 <9869d438-a715-fa5e-2877-b58f1bb6fc91@tuxedocomputers.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <9869d438-a715-fa5e-2877-b58f1bb6fc91@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Werner,

On 12/5/22 14:27, Werner Sembach wrote:
> Hi
> 
> Am 04.12.22 um 10:29 schrieb Hans de Goede:
>> Hi Bjorn,
>>
>> On 12/3/22 18:57, Bjorn Helgaas wrote:
>>> On Sat, Dec 03, 2022 at 01:44:10PM +0100, Hans de Goede wrote:
>>>> Hi Bjorn,
>>>>
>>>> On 12/2/22 22:18, Bjorn Helgaas wrote:
>>>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>>>
>>>>> When allocating space for PCI BARs, Linux avoids allocating space mentioned
>>>>> in the E820 map.  This was originally done by 4dc2287c1805 ("x86: avoid
>>>>> E820 regions when allocating address space") to work around BIOS defects
>>>>> that included unusable space in host bridge _CRS.
>>>>>
>>>>> Some recent machines use EfiMemoryMappedIO for PCI MMCONFIG and host bridge
>>>>> apertures, and bootloaders and EFI stubs convert those to E820 regions,
>>>>> which means we can't allocate space for hot-added PCI devices (often a
>>>>> dock) or for devices the BIOS didn't configure (often a touchpad)
>>>>>
>>>>> The current strategy is to add DMI quirks that disable the E820 filtering
>>>>> on these machines and to disable it entirely starting with 2023 BIOSes:
>>>>>
>>>>>    d341838d776a ("x86/PCI: Disable E820 reserved region clipping via quirks")
>>>>>    0ae084d5a674 ("x86/PCI: Disable E820 reserved region clipping starting in 2023")
>>>>>
>>>>> But the quirks are problematic because it's really hard to list all the
>>>>> machines that need them.
>>>>>
>>>>> This series is an attempt at a more generic approach.  I'm told by firmware
>>>>> folks that EfiMemoryMappedIO means "the OS should map this area so EFI
>>>>> runtime services can use it in virtual mode," but does not prevent the OS
>>>>> from using it.
>>>>>
>>>>> The first patch removes any EfiMemoryMappedIO areas from the E820 map.
>>>>> This doesn't affect any virtual mapping of those areas (that would have to
>>>>> be done directly from the EFI memory map) but it means Linux can allocate
>>>>> space for PCI MMIO.
>>>>>
>>>>> The rest are basically cosmetic log message changes.
>>>>
>>>> Thank you for working on this. I'm a bit worried about this series though.
>>>>
>>>> The 2 things which I worry about are:
>>>>
>>>>
>>>> 1. I think this will not help when people boot in BIOS (CSM) mode rather
>>>> then UEFI mode which quite a few Linux users still do because they learned
>>>> to do this years ago when Linux EFI support (and EFI fw itself) was still
>>>> a bit in flux.
>>>>
>>>> IIRC from the last time we looked at this in CSM mode the BIOS itself
>>>> translates the EfiMemoryMappedIO areas to reserved E820 regions. So when
>>>> people use the BIOS CSM mode to boot, then this patch will not help
>>>> since the kernel lacks the info to do the translation.
>>>
>>> Right, if BIOS CSM puts EfiMemoryMappedIO in the E820 map the same way
>>> bootloaders do, and the kernel doesn't have the EFI memory map, this
>>> series won't help.
>>
>> So I just got the requested dmesg in BIOS CSM mode from:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1868899
>>
>> And it says:
>>
>> [    0.000000] BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>> [    0.316140] pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
>>
>> So I'm afraid that I remembered correctly and the CSM adds
>> the EfiMemoryMappedIO regions to the E820 map as reserved :(
>>
>> So as you said, this series won't help for people booting in
>> BIOS compatibility mode. Which means that we should at least keep
>> the current list of no_e820 quirks to avoid regressing those models
>> when booted in BIOS compatibility mode.
>>
>> And maybe still add at least the Clevo model for which I recently
>> submitted a new no_e820 quirk so that that will work in BIOS CSM
>> mode too ?
> Do you mean the X170KM-G? I don't think it has the option to switch to Legacy BIOS mode (At least i didn't found an option in the bios version i have)

I'm talking about this patch:

https://lore.kernel.org/linux-pci/20221010150206.142615-1-hdegoede@redhat.com/

Regards,

Hans

