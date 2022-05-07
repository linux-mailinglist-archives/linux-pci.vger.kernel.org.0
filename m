Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BBE51E65F
	for <lists+linux-pci@lfdr.de>; Sat,  7 May 2022 12:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiEGKM4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 May 2022 06:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbiEGKM4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 May 2022 06:12:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82DAB37BCD
        for <linux-pci@vger.kernel.org>; Sat,  7 May 2022 03:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651918148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ugyhJHOyJRb+Ii6eaPgL20qr8QTMbWmypOsqDi+kA7I=;
        b=Vl4+UFb0HRYMD/B7GQA45pgLFkRScRXLAzQH+CNdRFWdqaEbEm7LYeQCUT2elD6LpIHYL9
        o86m3BTaxVo9k9JIbpqaeThCyaZ1nHk6KWl7B059OV2ytAZk74OY+c2Y8gpbpu5yzfO5rH
        N+cXmgTCDPhdh1vPmi4PfXv+59vW6ZM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-iTWv23wrOc6MgyQw0ExNnQ-1; Sat, 07 May 2022 06:09:07 -0400
X-MC-Unique: iTWv23wrOc6MgyQw0ExNnQ-1
Received: by mail-ej1-f69.google.com with SMTP id re25-20020a170906d8d900b006f50701fbefso3091697ejb.23
        for <linux-pci@vger.kernel.org>; Sat, 07 May 2022 03:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ugyhJHOyJRb+Ii6eaPgL20qr8QTMbWmypOsqDi+kA7I=;
        b=fsXQPzAM+Ry3vxskHXU//+huQ093DVAEVCp8OYUh+yF1RbMbnwi5vMJlDkflZTenJy
         17016ONQ83FY1vw+cZPOTr8zmVctZWkPX411V3UlT9W1AaCCAIMoQlSFC1zd54IR0/+Y
         FUSdO4PCuqaUwFDcVKq82qUAY0xC2ThlmQJ81qiT5mG3iAOLP0pMXdm64l1P1MH7uaWm
         1VZjy22XeQfqiQNm7ZYD+ZPOwrkR1afRjErgJs/q+yHVxC7QjcIwAHO1dZgQsiONdOfI
         B5pPAHSeVLYlYDObciZT325fwtj0FXaHIW7WcYDdhl0ORV+XHdMAMTkbiYblhVki+CnD
         2lEg==
X-Gm-Message-State: AOAM5320xH03XMdNI2jQCDwYs9AHVHOBWfI8Gy7/1d+HmTavz83R/ABG
        Dzu4Ml9rAcgb/l9CHTWnlRIGFw4KnNgVu4guGs3gWR1titWqorfmSP0ccGwGE6EebYfauDZElD+
        TYDMCWcQ3iYplCbtGUSfd
X-Received: by 2002:a17:907:94cd:b0:6f4:da4d:6ec2 with SMTP id dn13-20020a17090794cd00b006f4da4d6ec2mr6576362ejc.702.1651918145707;
        Sat, 07 May 2022 03:09:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZ4nAdow9Qwp9gKwTAcqGLkTqXlfn0VuBxIqMJjGNO1GJsCm5V203TV3mn+eU6485JZcWvpw==
X-Received: by 2002:a17:907:94cd:b0:6f4:da4d:6ec2 with SMTP id dn13-20020a17090794cd00b006f4da4d6ec2mr6576344ejc.702.1651918145470;
        Sat, 07 May 2022 03:09:05 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id u10-20020aa7d88a000000b0042617ba638csm3365565edq.22.2022.05.07.03.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 03:09:04 -0700 (PDT)
Message-ID: <94238be8-023e-a70a-45c8-a7096149e752@redhat.com>
Date:   Sat, 7 May 2022 12:09:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v7 1/1] x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220506165110.GA509329@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220506165110.GA509329@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 5/6/22 18:51, Bjorn Helgaas wrote:
> On Thu, May 05, 2022 at 05:20:16PM +0200, Hans de Goede wrote:
>> Some BIOS-es contain bugs where they add addresses which are already
>> used in some other manner to the PCI host bridge window returned by
>> the ACPI _CRS method. To avoid this Linux by default excludes
>> E820 reservations when allocating addresses since 2010, see:
>> commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
>> space").
>>
>> Recently (2019) some systems have shown-up with E820 reservations which
>> cover the entire _CRS returned PCI bridge memory window, causing all
>> attempts to assign memory to PCI BARs which have not been setup by the
>> BIOS to fail. For example here are the relevant dmesg bits from a
>> Lenovo IdeaPad 3 15IIL 81WE:
>>
>>  [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>>  pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
>>
>> The ACPI specifications appear to allow this new behavior:
>>
>> The relationship between E820 and ACPI _CRS is not really very clear.
>> ACPI v6.3, sec 15, table 15-374, says AddressRangeReserved means:
>>
>>   This range of addresses is in use or reserved by the system and is
>>   not to be included in the allocatable memory pool of the operating
>>   system's memory manager.
>>
>> and it may be used when:
>>
>>   The address range is in use by a memory-mapped system device.
>>
>> Furthermore, sec 15.2 says:
>>
>>   Address ranges defined for baseboard memory-mapped I/O devices, such
>>   as APICs, are returned as reserved.
>>
>> A PCI host bridge qualifies as a baseboard memory-mapped I/O device,
>> and its apertures are in use and certainly should not be included in
>> the general allocatable pool, so the fact that some BIOS-es reports
>> the PCI aperture as "reserved" in E820 doesn't seem like a BIOS bug.
>>
>> So it seems that the excluding of E820 reserved addresses is a mistake.
>>
>> Ideally Linux would fully stop excluding E820 reserved addresses,
>> but then various old systems will regress.
>> Instead keep the old behavior for old systems, while ignoring
>> the E820 reservations for any systems from now on.
>>
>> Old systems are defined here as BIOS year < 2018, this was chosen to
>> make sure that pci_use_e820 will not be set on the currently affected
>> systems, the oldest known one is from 2019.
>>
>> Testing has shown that some newer systems also have a bad _CRS return.
>> The pci_crs_quirks DMI table is used to keep excluding E820 reservations
>> from the bridge window on these systems.
>>
>> Also add pci=no_e820 and pci=use_e820 options to allow overriding
>> the BIOS year + DMI matching logic.
>>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
>> BugLink: https://bugs.launchpad.net/bugs/1878279
>> BugLink: https://bugs.launchpad.net/bugs/1931715
>> BugLink: https://bugs.launchpad.net/bugs/1932069
>> BugLink: https://bugs.launchpad.net/bugs/1921649
>> Cc: Benoit Grégoire <benoitg@coeus.ca>
>> Cc: Hui Wang <hui.wang@canonical.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
>> +	 * Ideally Linux would fully stop using E820 reservations, but then
>> +	 * various old systems will regress. Instead keep the old behavior for
>> +	 * old systems + known to be broken newer systems in pci_crs_quirks.
>> +	 */
>> +	if (year >= 0 && year < 2018)
>> +		pci_use_e820 = true;
> 
> How did you pick 2018?  Prior to this patch, we used E820 reservations
> for all machines.  This patch would change that for 2019-2022
> machines, so there's a risk of breaking some of them.

Correct. I picked 2018 because the first devices where using E820
reservations are causing issues (i2c controller not getting resources
leading to non working touchpad / thunderbolt hotplug issues) have
BIOS dates starting in 2019. I added a year margin, so we could make
this 2019.

> I'm hesitant about changing the behavior for machines already in the
> field because if they were tested at all with Linux, it was without
> this patch.  So I would lean toward preserving the current behavior
> for BIOS year < 2023.

I see, I presume the idea is to then use DMI to disable E820 clipping
on current devices where this is known to cause problems ?

So for v8 I would:

1. Change the cut-off check to < 2023
2. Drop the DMI quirks I added for models which are known to need E820
   clipping hit by the < 2018 check
3. Add DMI quirks for models for which it is known that we must _not_
   do E820 clipping

Is this the direction you want to go / does that sound right?

Note the DMI list for 3. will initially very likely be incomplete, but
I can ask around for testing once we have settled on this approach
and do one or more follow up patches to extend the list.


>> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
>> index 9e1e6b8d8876..7e6f79aab6a8 100644
>> --- a/arch/x86/pci/common.c
>> +++ b/arch/x86/pci/common.c
>> @@ -595,6 +595,12 @@ char *__init pcibios_setup(char *str)
>>  	} else if (!strcmp(str, "nocrs")) {
>>  		pci_probe |= PCI_ROOT_NO_CRS;
>>  		return NULL;
>> +	} else if (!strcmp(str, "use_e820")) {
>> +		pci_probe |= PCI_USE_E820;
> 
> I think we should add_taint(TAINT_FIRMWARE_WORKAROUND) for both these
> cases.

Ok, I'll add this for v8.

> 
> We probably should do it for *all* the parameters here, but that would
> be a separate discussion.
> 
>> +		return NULL;
>> +	} else if (!strcmp(str, "no_e820")) {
>> +		pci_probe |= PCI_NO_E820;
>> +		return NULL;
>>  #ifdef CONFIG_PHYS_ADDR_T_64BIT
>>  	} else if (!strcmp(str, "big_root_window")) {
>>  		pci_probe |= PCI_BIG_ROOT_WINDOW;
>> -- 
>> 2.36.0
>>
> 


Regards,

Hans


