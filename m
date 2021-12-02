Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FCD466621
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 16:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358319AbhLBPJf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 10:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358364AbhLBPJ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 10:09:27 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF1CC06174A;
        Thu,  2 Dec 2021 07:06:04 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id u74so56045741oie.8;
        Thu, 02 Dec 2021 07:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/KJOrDnCC+kHBjtq7zn+PftjJ5oCAHSVzOTKwMQDzxE=;
        b=StRgm9w2iPF+Gld+9pF9bXGXu9cOdk1yegIi6JHUauEHS2cJx4O2A3fQY3mfBEYgpa
         rV2UB8NLpWe1XohKnQqZp60aL3xkP1RSyDVhICi5OnRI5L0hi3Orfq6MWRrmpNSmZwHG
         PrnkYa6tau0zxgG9blfy1nzKCofjfW2jmKHYzl4kDJcm8JON90E+tcXwPSM8TPieWTus
         v/dg7orsdCSMBeJkWSav8YNLg7iFnv+wcVOPgREevM3hhTCkgry5xnMQDSB87zwagYXb
         DG2PafZeRN3K8iFns7URFmOlqqnQmvA86rIqWb6VyUMw8Jo87gev3fz3XJ4VmfsuKdBC
         3D7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/KJOrDnCC+kHBjtq7zn+PftjJ5oCAHSVzOTKwMQDzxE=;
        b=pCZJC9SHZU0qZMpnLwmheW7Tk8WMvXdLTsA8VercqrmDuNHN/wGVo70dbA8qLv0S4k
         tvkjPSZmv55AzWhrXRUJZkH5LFsQuawZCJ+VDI9pyGhJhGeirfx5CVoSXBkg1g8izlsn
         Y+u2K6PFzwHBwWqzTwrOGhcQfKtclAIXdF2qz9VUT16sil34ivxVAczKfsBFjRhAipZd
         L2SKN3MGinc6XlE56pTXmVIQQBWFCy6CumlL97zqBIsEDynZjSLSSFBj841/X8DXjLZ8
         q5lqbK1ANjzmOBM4Yph0Sc+U7GeHvOht5ARqNTPnXkbWl81LWDnwfA8awhj1kSklzXg2
         LIjw==
X-Gm-Message-State: AOAM533O6i/G/znXzRGbkZ3oKk0dfbpqPH3N/GylM2OqMX9BnQWd1q5S
        DW/0wQMXcViONCIJQFgj5wZHUYI125Y=
X-Google-Smtp-Source: ABdhPJyJbsD+RVqZdag3Gf8Q5WmdmdBWTJuC6nLpZq1ctc68wcebdBbJK9cQD+N21Wr9E926xc2ivQ==
X-Received: by 2002:a05:6808:14e:: with SMTP id h14mr4862068oie.28.1638457563704;
        Thu, 02 Dec 2021 07:06:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bg38sm68612oib.40.2021.12.02.07.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 07:06:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 2/5] MIPS: ralink: implement
 'pcibios_root_bridge_prepare()'
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20211201215127.23550-1-sergio.paracuellos@gmail.com>
 <20211201215127.23550-3-sergio.paracuellos@gmail.com>
 <d243a90d-25b2-a65f-b69d-af7497db8742@roeck-us.net>
 <CAMhs-H_i7aFeqf4EBtzdL0SKgKrseZGpVU-ytvangpeCMVTmFw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9401e88b-de5a-dd2a-7e82-f3657ea86e8f@roeck-us.net>
Date:   Thu, 2 Dec 2021 07:06:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAMhs-H_i7aFeqf4EBtzdL0SKgKrseZGpVU-ytvangpeCMVTmFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/2/21 12:29 AM, Sergio Paracuellos wrote:
> Hi Guenter,
> 
> On Wed, Dec 1, 2021 at 11:17 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 12/1/21 1:51 PM, Sergio Paracuellos wrote:
>>> PCI core code call 'pcibios_root_bridge_prepare()' function inside function
>>> 'pci_register_host_bridge()'. This point is very good way to properly enter
>>> into this MIPS ralink specific code to properly setup I/O coherency units
>>> with PCI memory addresses.
>>>
>>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>>> ---
>>>    arch/mips/ralink/mt7621.c | 30 ++++++++++++++++++++++++++++++
>>>    1 file changed, 30 insertions(+)
>>>
>>> diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
>>> index bd71f5b14238..7649416c1cd7 100644
>>> --- a/arch/mips/ralink/mt7621.c
>>> +++ b/arch/mips/ralink/mt7621.c
>>> @@ -10,6 +10,7 @@
>>>    #include <linux/slab.h>
>>>    #include <linux/sys_soc.h>
>>>    #include <linux/memblock.h>
>>> +#include <linux/pci.h>
>>>
>>>    #include <asm/bootinfo.h>
>>>    #include <asm/mipsregs.h>
>>> @@ -22,6 +23,35 @@
>>>
>>>    static void *detect_magic __initdata = detect_memory_region;
>>>
>>> +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>>> +{
>>> +     struct resource_entry *entry;
>>> +     resource_size_t mask;
>>> +
>>> +     entry = resource_list_first_type(&bridge->windows, IORESOURCE_MEM);
>>> +     if (!entry) {
>>> +             pr_err("Cannot get memory resource\n");
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     if (mips_cps_numiocu(0)) {
>>> +             /*
>>> +              * FIXME: hardware doesn't accept mask values with 1s after
>>> +              * 0s (e.g. 0xffef), so it would be great to warn if that's
>>> +              * about to happen
>>> +              */ > +         mask = ~(entry->res->end - entry->res->start);
>>> +
>>
>> Try something like this:
>>                  WARN_ON((mask != ~0UL && BIT(ffz(mask)) - 1 != mask);
> 
> Thanks for the tip. The following works for me:
> 
>                    WARN_ON(mask != ~0UL && ~(BIT(__ffs(mask)) - 1) != mask);

Are you sure ? __ffs() returns the first bit set, which isn't useful
for this test.

Guenter

> 
> I will send this as a different patch, though.
> 
> Best regards,
>      Sergio Paracuellos
> 
>>
>>> +             write_gcr_reg1_base(entry->res->start);
>>> +             write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
>>> +             pr_info("PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
>>> +                     (unsigned long long)read_gcr_reg1_base(),
>>> +                     (unsigned long long)read_gcr_reg1_mask());
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>>    phys_addr_t mips_cpc_default_phys_base(void)
>>>    {
>>>        panic("Cannot detect cpc address");
>>>
>>

