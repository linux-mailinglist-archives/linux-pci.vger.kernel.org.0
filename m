Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7944CD83D
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 16:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240517AbiCDPrG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Mar 2022 10:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240511AbiCDPrF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Mar 2022 10:47:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A23F91C60D1
        for <linux-pci@vger.kernel.org>; Fri,  4 Mar 2022 07:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646408775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ok6cNz0L/QjOdBEAo/Kw/BVtmghrFVnwMQ+pQ2B0wKo=;
        b=EnDrUYmcfySRZmHHNqoklBTizma25AipNvGHjTlArgNMnQhZzvfj6ONfAr82DfVtkI8lVW
        XMN8U58VYkifYikLodX2EIdJxs8/SRvpxh13U6nmfk5tnRlhLPvShQGUFw44122Vlu0+Et
        HlQtQLTzvtChZ51c+BbZbgjwf3M1RRc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-8dystgzROzSkaOV8UCr1_w-1; Fri, 04 Mar 2022 10:46:14 -0500
X-MC-Unique: 8dystgzROzSkaOV8UCr1_w-1
Received: by mail-ed1-f72.google.com with SMTP id cm27-20020a0564020c9b00b004137effc24bso4805437edb.10
        for <linux-pci@vger.kernel.org>; Fri, 04 Mar 2022 07:46:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ok6cNz0L/QjOdBEAo/Kw/BVtmghrFVnwMQ+pQ2B0wKo=;
        b=J+uNm6dj0TwXacWPrx8sxuvjO7oMCuVPB++tBy3a5Pcx0aBWhXhYP3DC7YXAWhIFOc
         BDls7qvgEHeV2OQcNa+B229s4JgilotgCtfAvBABv2lXyEv5VQIQeo08HgxRgGSfKaxJ
         58ukrFTQIY/JEyJ3BMIHxFUKDv735Zzfh08R4dmYge5BMQTxKyx1tmV4eRSt/cVfd0qf
         GUGpw3Dah+20JFtH9Znv+y85Obp2MrJPH0tM8cDQCsVamOqSjrvi9vZbpzlx1Nhu509/
         /5wqj03UzUMHS1f25f+MoWzqRP7C91+Qb8PrcJxH+d6RzFiEE30pwqBDvVpRrCDDWVNy
         9+HQ==
X-Gm-Message-State: AOAM533WQt+IHi+Xz14qw/EIALVSDd8INVi7excraImCZ8rQLKwgWfLQ
        OVlS6o2zgkDTaBIQzCUzj8kHLbGPK0wCQkasG1qZzEN3a6xmFAXoGF72EC9Cc+oFMjJP4TSpycF
        hlQkd0B4dkHXF19E6MTKZ
X-Received: by 2002:a05:6402:68e:b0:415:d29e:dfe8 with SMTP id f14-20020a056402068e00b00415d29edfe8mr9513533edy.351.1646408773397;
        Fri, 04 Mar 2022 07:46:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6o75E/1/tsegfm/oEwV5fky/dZ+AnQDmKlOjjCm9Cao5lR4I+WqrwrgJuVfnlduIoiFyrLg==
X-Received: by 2002:a05:6402:68e:b0:415:d29e:dfe8 with SMTP id f14-20020a056402068e00b00415d29edfe8mr9513506edy.351.1646408773150;
        Fri, 04 Mar 2022 07:46:13 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id s15-20020a056402520f00b00415e50f8ce1sm1996430edd.54.2022.03.04.07.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 07:46:12 -0800 (PST)
Message-ID: <86b17447-b285-f6ce-99d8-f2cad01405d5@redhat.com>
Date:   Fri, 4 Mar 2022 16:46:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/3] x86/PCI: Preserve host bridge windows completely
 covered by E820
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, wse@tuxedocomputers.com
References: <20220304153245.GA1030861@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220304153245.GA1030861@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 3/4/22 16:32, Bjorn Helgaas wrote:
> On Fri, Mar 04, 2022 at 03:16:42PM +0100, Hans de Goede wrote:
>> Hi Bjorn,
>>
>> On 3/4/22 04:51, Bjorn Helgaas wrote:
>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> Many folks have reported PCI devices not working.  It could affect any
>>> device, but most reports are for Thunderbolt controllers on Lenovo Yoga and
>>> Clevo Barebone laptops and the touchpad on Lenovo IdeaPads.
>>>
>>> In every report, a region in the E820 table entirely encloses a PCI host
>>> bridge window from _CRS, and because of 4dc2287c1805 ("x86: avoid E820
>>> regions when allocating address space"), we ignore the entire window,
>>> preventing us from assigning space to PCI devices.
>>>
>>> For example, the dmesg log [2] from bug report [1] shows:
>>>
>>>   BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>>>   pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
>>>   pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
>>>
>>> The efi=debug dmesg log [3] from the same report shows the EFI memory map
>>> entries that created the E820 map:
>>>
>>>   efi: mem47: [Reserved |   |WB|WT|WC|UC] range=[0x4bc50000-0x5fffffff]
>>>   efi: mem48: [Reserved |   |WB|  |  |UC] range=[0x60000000-0x60ffffff]
>>>   efi: mem49: [Reserved |   |  |  |  |  ] range=[0x61000000-0x653fffff]
>>>   efi: mem50: [MMIO     |RUN|  |  |  |UC] range=[0x65400000-0xcfffffff]
>>>
>>> 4dc2287c1805 ("x86: avoid E820 regions when allocating address space")
>>> works around issues where _CRS contains non-window address space that can't
>>> be used for PCI devices.  It does this by removing E820 regions from host
>>> bridge windows.  But in these reports, the E820 region covers the entire
>>> window, so 4dc2287c1805 makes it completely unusable.
>>>
>>> Per UEFI v2.8, sec 7.2, the EfiMemoryMappedIO type means:
>>>
>>>   Used by system firmware to request that a memory-mapped IO region be
>>>   mapped by the OS to a virtual address so it can be accessed by EFI
>>>   runtime services.
>>>
>>> A host bridge window is definitely a memory-mapped IO region, and EFI
>>> runtime services may need to access it, so I don't think we can argue that
>>> this is a firmware defect.
>>>
>>> Instead, change the 4dc2287c1805 strategy so it only removes E820 regions
>>> when they overlap *part* of a host bridge window on the assumption that a
>>> partial overlap is really register space, not part of the window proper.
>>>
>>> If an E820 region covers the entire window from _CRS, assume the _CRS
>>> window is correct and do nothing.
>>>
>>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1868899
>>> [2] https://bugzilla.redhat.com/attachment.cgi?id=1711424
>>> [3] https://bugzilla.redhat.com/attachment.cgi?id=1861407
>>>
>>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
>>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214259
>>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
>>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
>>> BugLink: https://bugs.launchpad.net/bugs/1878279
>>> BugLink: https://bugs.launchpad.net/bugs/1931715
>>> BugLink: https://bugs.launchpad.net/bugs/1932069
>>> BugLink: https://bugs.launchpad.net/bugs/1921649
>>> Fixes: 4dc2287c1805 ("x86: avoid E820 regions when allocating address space")
>>> Link: https://lore.kernel.org/r/20220228105259.230903-1-hdegoede@redhat.com
>>> Based-on-patch-by: Hans de Goede <hdegoede@redhat.com>
>>> Reported-by: Benoit Grégoire <benoitg@coeus.ca>   # BZ 206459
>>> Reported-by: wse@tuxedocomputers.com              # BZ 214259
>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>> ---
>>>  arch/x86/kernel/resource.c | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
>>> index 7378ea146976..405f0af53e3d 100644
>>> --- a/arch/x86/kernel/resource.c
>>> +++ b/arch/x86/kernel/resource.c
>>> @@ -39,6 +39,17 @@ void remove_e820_regions(struct device *dev, struct resource *avail)
>>>  		e820_start = entry->addr;
>>>  		e820_end = entry->addr + entry->size - 1;
>>>  
>>> +		/*
>>> +		 * If an E820 entry covers just part of the resource, we
>>> +		 * assume E820 is telling us about something like host
>>> +		 * bridge register space that is unavailable for PCI
>>> +		 * devices.  But if it covers the *entire* resource, it's
>>> +		 * more likely just telling us that this is MMIO space, and
>>> +		 * that doesn't need to be removed.
>>> +		 */
>>> +		if (e820_start <= avail->start && avail->end <= e820_end)
>>> +			continue;
>>> +
>>
>> IMHO it would be good to add some logging here, since hitting this is
>> somewhat of a special case. For the Fedora test kernels I did I changed
>> this to:
>>
>> 		if (e820_start <= avail->start && avail->end <= e820_end) {
>> 			dev_info(dev, "resource %pR fully covered by e820 entry [mem %#010Lx-%#010Lx]\n",
>> 				 avail, e820_start, e820_end);
>> 			continue;
>> 		}
>>
>> And I expect/hope to see this new info message on the ideapad with the
>> touchpad issue.
> 
> Right, I would expect the same.
> 
> We could add something like this.  But both the e820 entry and the
> host bridge window are already in the dmesg log, so it doesn't really
> add new information

Well it adds the information that the workaround (to the workaround)
which we added for this case is working as expected and it allows
seeing that is the case in a single glance.

Yes we can derive this is happening from the other logs, but it won't
"stand out" unless you are specifically looking for it. Having
a separate line which stands-out (a bit) might be helpful to spot
this when debugging something else which seems unrelated, but
possibly is actually related.

Anyways, I'll leave what to do here up to you.

>, and I don't think there's anything *wrong* with
> this situation (per the UEFI text above),

Right, which is why I suggest using dev_info and not dev_warn.

> so I don't think we need to
> call attention to it.
> 
> I think what might add useful information would be to always log the
> EFI "RUN" entries.  IIUC, currently the "efi: mem47: ..." lines are
> only emitted when booting with "efi=debug"?
> 
> I think the "RUN" lines indicate regions that must be virtually mapped
> so EFI runtime services can use them, and it seems like it might be
> more generally useful to always mention them.

I'm not sure about always logging the EFI memmap I agree it might
be useful sometimes, but it is easy to enable then and the initial
boot code of the kernel already is pretty "chatty".

Regards,

Hans


