Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E8C4AF609
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 17:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbiBIQGy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 11:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbiBIQGx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 11:06:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54792C0613C9
        for <linux-pci@vger.kernel.org>; Wed,  9 Feb 2022 08:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644422815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t8neabqG5GWOFdIKt02xM6tumI0PLURQV6iqtIP49fc=;
        b=N8JM6RkyHgNzDUIMQhV2fodfOSRZkLjwIOw6TEjweOlh7jwR6JJBlSHQIpHCDuZmaSK1S2
        BHlk8rfsKJt5gAhp1Bw471idUcyXks3Uy92LdgHguVGnkliDPQqiIGU43wlbBEBrfVa2KR
        q7GWQZ+hzvSAy7hNyp8umdzTtFH1XSs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-Ttxg4UJxNNGcDMy9EJ6oGQ-1; Wed, 09 Feb 2022 11:06:52 -0500
X-MC-Unique: Ttxg4UJxNNGcDMy9EJ6oGQ-1
Received: by mail-ed1-f71.google.com with SMTP id 30-20020a508e5e000000b0040f6642e814so1587502edx.19
        for <linux-pci@vger.kernel.org>; Wed, 09 Feb 2022 08:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=t8neabqG5GWOFdIKt02xM6tumI0PLURQV6iqtIP49fc=;
        b=O2ZBPZtGRGZQsH49k2u5Dv2m31HngNOkDOkpLSVVsfLL5ky9vGRe8GkbJbS/3/8ZND
         8khgIOGnG7tpO4mFsk2fGzTDFZmGkgBWPaP7MxaOQPHK71zC7AXqVOF+Iu+/kbMBKDlT
         0A5hmhrI5mYFegoKVAw9duOIQbd8T5CtE+tbudKABCNUcEWTlbczMJYFrmz6XApvrToZ
         oHcOL3XuRvo+SuuL/phgzdKVeYYJiogpx0MkLqVnwXvHS27on3U/t488iScALncGRtvk
         MSXS4y+XEuqDDuLksdYmLbTOYDgaabJVC/Ts3X8WXGBxFp/vHDvDzF6WumQ5Np70oHNi
         n/2g==
X-Gm-Message-State: AOAM531p7cPAGNCC0w8PRWtoWtCtmF16+h61+/cZPfRwgpAcK/YgLhRQ
        vZ140y8BdSbX85ewRKP9s0mbXwaBLiPn8gCT0qxWdpcnDO/1/sOnyAmWbjME7YIFnfwW11LFK+8
        bSohFw7H9V9GoX6suuA+N
X-Received: by 2002:a50:d55d:: with SMTP id f29mr3301501edj.45.1644422810878;
        Wed, 09 Feb 2022 08:06:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9xnEF08mPqp0wLEqWHEd5RHLKJyrQ/+Z1l+uXVaDn4CIx7SMsmWhlL85XzZdNKnicxv6v2A==
X-Received: by 2002:a50:d55d:: with SMTP id f29mr3301468edj.45.1644422810651;
        Wed, 09 Feb 2022 08:06:50 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id z6sm6134214ejd.35.2022.02.09.08.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 08:06:50 -0800 (PST)
Message-ID: <eb8c2911-172e-fb86-2a09-90bcd8f8cece@redhat.com>
Date:   Wed, 9 Feb 2022 17:06:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [5.17 regression] "x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems" breaks suspend/resume
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
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
 <02994528-aaad-5259-1774-19aeacdd18fc@redhat.com>
In-Reply-To: <02994528-aaad-5259-1774-19aeacdd18fc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2/9/22 16:12, Hans de Goede wrote:
> Hi,
> 
> On 2/8/22 17:38, Mika Westerberg wrote:
>> Hi Hans,
>>
>> On Tue, Feb 08, 2022 at 04:59:13PM +0100, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 2/8/22 16:25, Hans de Goede wrote:
>>>> Hi All,
>>>>
>>>> Unfortunately I've just learned that commit 7f7b4236f204 ("x86/PCI:
>>>> Ignore E820 reservations for bridge windows on newer systems"):
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7f7b4236f2040d19df1ddaf30047128b41e78de7
>>>>
>>>> breaks suspend/resume on at least one laptop model, the Lenovo ThinkPad
>>>> X1 gen 2, see:
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=2029207
>>
>> :-(
>>
>>>> This regression was actually caught be Fedora already carrying this
>>>> patch for a while now and as such it has been reproduced with 5.15
>>>> with an older version of the patch which still allowed turning the
>>>> new behavior of by adding "pci=use_e820". Dmesg output with and
>>>> without the option has just been attached to the bug, I've not
>>>> analyzed this any further yet.
>>>>
>>>> I guess that for now this means that we need to revert commit
>>>> 7f7b4236f204. Rafael, I'll send you a revert with a commit msg
>>>> explaining why this needs to be reverted tomorrow.
>>>>
>>>> More interesting IMHO is finding out another solution. Both the touchpad
>>>> problem which got me looking into this:
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1868899
>>>>
>>>> As well as the thunderbolt hotplug issue Mika was looking at:
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=206459
>>>>
>>>> both are cases where we fail to find a memory-window for a
>>>> BAR which has not been setup yet.
>>>>
>>>> So I see a couple of options here:
>>>>
>>>> 1. Detect that the e820 reservations fully cover (one of)
>>>> the PCI bridge main 32 bit memory windows and if that happens
>>>> ignore them. This actually was my first plan when I started
>>>> working on this. In the end I choose the other option
>>>> because Bjorn indicated that in hindsight honoring the e820
>>>> reservations might have been a mistake and maybe we should
>>>> get rid of honoring them all together.
>>>>
>>>> 2. Have a flag which, when we fail to alloc a 32 bit
>>>> (or 64 bit) memory PCI BAR, is set if not already set
>>>> and then retry the alloc. And make the e820 reservation
>>>> carve-out get skipped in this case.
>>>>
>>>> 3. When booting with pci=nocrs as a workaround for
>>>> the touchpad case a 64 but memory window ends up getting
>>>> used. There already is some special handling for some
>>>> AMD bridges where if there are no 64 bit memory Windows
>>>> in the _CRS for the bridge, one gets added. Maybe we need
>>>> to do the same for Intel bridges ?
>>>
>>> 4. It seems that all devices which have issues with allocating
>>> a PCI bar are Ice Lake based; and the model where the ignoring
>>> of e820 reservations has been reported to cause issues is somewhat
>>> old. It is a Haswell, but still getting BIOS updates causing
>>> the BIOS date check to enable the new behavior. So another
>>> solution might be to only ignore e820 reservations on machines
>>> with Intel Ice Lake (and presumably also Tiger Lake) CPUs.
>>>
>>>
>>> 5. It also seems that the troublesome e820 entry on all devices
>>> ends at 0xcfffffff and starts well below 0x8000000 :
>>>
>>> Yoga C940:
>>> [    0.000000] BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>>>
>>> IdeaPad 3 15IIL05:
>>> [    0.000000] BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>>>
>>> Lenovo IdeaPad 5 14IIL05:
>>> [    0.000000] BIOS-e820: [mem 0x000000005bc50000-0x00000000cfffffff] reserved
>>
>> I don't remember the details anymore but looking at the commit log of my
>> "fix" attempt here:
>>
>> https://bugzilla.kernel.org/attachment.cgi?id=287661
>>
>> The EFI memory map actually seems to consists of several entries that somehow
>> are merged by something (I think this is the EFI stub but not sure). Booting
>> with "efi=debug" may help us to understand this further (or not).
>>
>> On that Yoga system, this:
>>
>>   [Reserved           |   |  |  |  |  |  |  | |   |WB|WT|WC|UC] range=[0x000000002bc50000-0x000000003fffffff] (323MB)
>>   [Reserved           |   |  |  |  |  |  |  | |   |WB|  |  |UC] range=[0x0000000040000000-0x0000000040ffffff] (16MB)
>>   [Reserved           |   |  |  |  |  |  |  | |   |  |  |  |  ] range=[0x0000000041000000-0x00000000453fffff] (68MB)
>>   [Memory Mapped I/O  |RUN|  |  |  |  |  |  | |   |  |  |  |UC] range=[0x0000000045400000-0x00000000cfffffff] (2220MB)
>>
>> became this:
>>
>>   BIOS-e820: [mem 0x000000002bc50000-0x00000000cfffffff] reserved
>>
>> Since the area (0x45400000-0xcfffffff) is marked as MMIO I think maybe we can
>> simply skip those areas in arch_remove_reservations() or so?
>>
>> I may be missing a lots of details, though. ;-)
> 
> So I've been looking at this for a couple of hours now and I've
> basically re-invented your original fix from:
> 
> https://lkml.org/lkml/2020/6/17/751
> 
> So here we are 2 years later and that still looks like the best
> fix, so IMHO we should just go with that fix.
> 
> An alternative, much more elaborate fix would be to:
> 
> 1. Add E820_TYPE_MMIO and E820_TYPE_MMIO_PCI_BRIDGE_WINDOW types to
>    enum e820_type and modify the 2 places which check for type == reserved
>    to treat these both as reserved too, so as to not have any functional
>    changes there
> 
> 2. Modify the code building e820 tables from the EFI memmap to use
>    E820_TYPE_MMIO for MMIO EFI memmap entries and make e820_nomerge()
>    treat E820_TYPE_MMIO as non mergable to retain these as is
> 
> 3. Modify pci_acpi_root_prepare_resources() to compare ACPI provided
>    bridge mmio windows against E820_TYPE_MMIO e820_Table entries and
>    if there is an exact match (as is the case on the Yoga C940)
>    then change the e820 type to E820_TYPE_MMIO_PCI_BRIDGE_WINDOW
> 
>    This means that we are now very narrowly treating EFI MMIO marked
>    regions special, in the special case where they are a 1:1 map
>    to an ACPI PCI bridge window resource.
> 
>    Note since we treat both E820_TYPE_MMIO and E820_TYPE_MMIO_PCI_BRIDGE_WINDOW
>    identical to the old RESERVED everywhere there is no functional change
>    here.
> 
> 4. Modify arch/x86/kernel/resource.c: remove_e820_regions() to skip
>    e820 table entries with a type of E820_TYPE_MMIO_PCI_BRIDGE_WINDOW,
>    this would actually be a functional change and should fix the
>    issues we are trying to fix.
> 
> Note an alternative would be to skip having the extra E820_TYPE_MMIO_PCI_BRIDGE_WINDOW
> type and to skip step 3. above. That would boil down to doing the same
> as your original patch in a somewhat cleaner manner.

So I just went outside for a stroll and realized that:

1. The touchpad and thunderbolt hotplug issues are all happening on
devices booting in EFI mode.

2. The X1 carbon gen 2 from the regression is booting in classic BIOS mode

3. The old devices for which the remove_e820_regions() was originally added
to resolve an issue where there was overlap between the PCI bridge mmio
window and RAM are so old that they only supports classic BIOS boot

4. The problem which we are seeing is coming from the EFI memmap to
e820 reservation table which is only done when booting in EFI mode.

So I believe that there actually is a pretty simple and straight forward
fix for this:

diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
index 9b9fb7882c20..18656f823764 100644
--- a/arch/x86/kernel/resource.c
+++ b/arch/x86/kernel/resource.c
@@ -28,6 +28,10 @@ static void remove_e820_regions(struct resource *avail)
 	int i;
 	struct e820_entry *entry;
 
+	/* Only remove E820 reservations on classic BIOS boot */
+	if (efi_enabled(EFI_MEMMAP))
+		return;
+
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		entry = &e820_table->entries[i];
 
I'll go and ask the reporters of both the regression as well as of the
original touchpad issue to test this.

Regards,

Hans


