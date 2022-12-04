Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFD8641C0A
	for <lists+linux-pci@lfdr.de>; Sun,  4 Dec 2022 10:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLDJaP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Dec 2022 04:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiLDJaO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Dec 2022 04:30:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228AE12D0C
        for <linux-pci@vger.kernel.org>; Sun,  4 Dec 2022 01:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670146160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FKzg6vXZ9C5N30cmZGMkFXevDmG/puHgCUnXYbnQxtw=;
        b=LLUd8ow7w1Z2PMGYXausxOeWyAhKSR8lTSf8nd2ofKPq+FULEvWkgDPILf23kJyOHjdnb6
        Er7RML5GR7obXb1IIzPtNZ51MvG3z+lrAPLvTUBOvCqJBaQYx3F5e4WBZK2wJaP2lU5aL2
        m7EC+QLxL4m/eQD3aueyHfi6V+++cjE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-64-MJxmOysuNK6U4CVl4KdXXA-1; Sun, 04 Dec 2022 04:29:18 -0500
X-MC-Unique: MJxmOysuNK6U4CVl4KdXXA-1
Received: by mail-ed1-f71.google.com with SMTP id f17-20020a056402355100b00466481256f6so3988471edd.19
        for <linux-pci@vger.kernel.org>; Sun, 04 Dec 2022 01:29:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKzg6vXZ9C5N30cmZGMkFXevDmG/puHgCUnXYbnQxtw=;
        b=eRcfFN4i0Ia8junyco02lV7cE3I0xwSEE+DDZPk7Gr/8oGValkGoV6zz1IndRqQP6L
         tb/0ZeQdMQDOZ/hlQ1UR/484QgjwyNZmybCamqvoj2pqqirfFUFubDJQk/S97mA6r79l
         MJpANXzFNz+vHeAK0PrAeZ4cdQ7W58ectaYqsmx1VkSHatQdMp6DaVnFHklxJ1+yRppu
         LTPovLzex9o4Xonuel7h4idBGps8iyZUSyyCRFMGrn40gLtyCynbORjVF9T5aLjB4YEP
         IJL+1w+Y72NSWonNODUNaAuVYdO/keqkxa4LMp8xxp0xHDCkjQDa486Sy9SofS0Nw08/
         75ZQ==
X-Gm-Message-State: ANoB5pmjAn+Au/Y7whWH6dApo+LGnqjCVKu+zf1F0eCXL5uu/GdMf7oc
        xluu+k0CbuMqgLwEbhWI2E7CF6+Ozc+aONNv0UlIcLlWS3guQo0CZ1saGWG7eJmpkzcJ7okr7lW
        IaeAalmhWoVkFZmA0HAPy
X-Received: by 2002:a17:906:49c4:b0:7c0:d23c:ead5 with SMTP id w4-20020a17090649c400b007c0d23cead5mr5686042ejv.606.1670146157888;
        Sun, 04 Dec 2022 01:29:17 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4smoqW25qmUG2KNrkGsrSTypZrUKtKaVVMmBLHcucGrDwdD+o9xBeI8qM1Q0IWf3YNrgixPw==
X-Received: by 2002:a17:906:49c4:b0:7c0:d23c:ead5 with SMTP id w4-20020a17090649c400b007c0d23cead5mr5686032ejv.606.1670146157696;
        Sun, 04 Dec 2022 01:29:17 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id cn7-20020a0564020ca700b0045ce419ecffsm4970915edb.58.2022.12.04.01.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 01:29:17 -0800 (PST)
Message-ID: <d7f1408d-ae9f-ad55-5fc9-9d9886384a3d@redhat.com>
Date:   Sun, 4 Dec 2022 10:29:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
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
References: <20221203175743.GA1121812@bhelgaas>
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

So I just got the requested dmesg in BIOS CSM mode from:
https://bugzilla.redhat.com/show_bug.cgi?id=1868899

And it says:

[    0.000000] BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
[    0.316140] pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]

So I'm afraid that I remembered correctly and the CSM adds
the EfiMemoryMappedIO regions to the E820 map as reserved :(

So as you said, this series won't help for people booting in
BIOS compatibility mode. Which means that we should at least keep
the current list of no_e820 quirks to avoid regressing those models
when booted in BIOS compatibility mode.

And maybe still add at least the Clevo model for which I recently
submitted a new no_e820 quirk so that that will work in BIOS CSM
mode too ?

Note I know you did not propose to drop the quirks in this series,
just covering all the bases here.

Regards,

Hans




