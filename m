Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F094668C7
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 18:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359813AbhLBRFY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 12:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347861AbhLBRFX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 12:05:23 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FDEC06174A;
        Thu,  2 Dec 2021 09:02:01 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id bj13so431386oib.4;
        Thu, 02 Dec 2021 09:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=00/E42FjoqEqAzMF9xc1DVwSebesIQL9IMmpKLjE84c=;
        b=gfJVq4GwgkeDrP+HqL4heNSY666jU+P5mBcshHCGxHx2R+fyuHoLS/oy80rH2k/Nmp
         s0kJZ5HT5WhWPZr5DzdDeUeMoJPCDtsD1fSFqVdXL0aLFilYWO4jzLxeFyzlY5XAvF1N
         ZjBUpo9hcPPoRd0T5cHS6efYKTNpMn8t1D4C0iL6r9DEG1qX9QQfxds/J8diiqdpCYtU
         KngHJD4eNLEBAsI5wW6ST7b0KBUFv3TRBwDlRl/2nLix7o52z/U3j2ElsNbjgq/Pr4Ee
         67fadfazvHpHxjnAIHtcL0iIhn7fDCdd9+yqLdIG3dtrhwOuCUgZNIjmIIKL5iIaTyFQ
         1sGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=00/E42FjoqEqAzMF9xc1DVwSebesIQL9IMmpKLjE84c=;
        b=DuWTiN62q2Y/Vou0GREpF33nuMrP0hZuII9e4Ar58AB4fFEmq8hXbLL7wLKIoaDLtO
         PAQwbpGm9yTh5pAhctNqhqdQgtMsyMt6iwYxMdm4C7Gx+6F0PF8MDXQCkQYLXgEIPhMt
         oWIbIK+gV6B2dQVpAOsS+xKePCDEzaG1L/qS4o6883cofS0zaA3LL3OrbPQZcZG5ZBop
         6Q8AZZV+brsif9UvYBcFtKF26bz0/y/G/tyybbPqtPmIo7B3+aIj2A+yJ9u11j/3OE4O
         +Wlz8Af9dGUVV/B5HD/GkXvlcOQqT3ERw2H0Cdy+U/tSSXd/qEWJVSdgD+UuTnzsTxeJ
         pVFA==
X-Gm-Message-State: AOAM531h31BfQjPM54BX4vfHNCmjHolze5Tjv2GANZ7CVcbPZd5zbG3S
        PzbjW4v34NvUJSDg8aH0O112eVBxVTQ=
X-Google-Smtp-Source: ABdhPJyhCaV/BceC8DU6uzkJq3wZ2XFPKuCodlaG1Y9Z0h1ebjhFspN3yW/iNgJwkBp4KrpUD+8nfQ==
X-Received: by 2002:a05:6808:8c9:: with SMTP id k9mr5357601oij.147.1638464519988;
        Thu, 02 Dec 2021 09:01:59 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i3sm92967ooq.39.2021.12.02.09.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 09:01:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
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
 <9401e88b-de5a-dd2a-7e82-f3657ea86e8f@roeck-us.net>
 <CAMhs-H8vw48RkpFz+rqvoPqDPpkaHdn60j6SdbDJHTNTTp7Fcg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/5] MIPS: ralink: implement
 'pcibios_root_bridge_prepare()'
Message-ID: <c70584d5-8efd-6b3e-aab5-c8161f39931b@roeck-us.net>
Date:   Thu, 2 Dec 2021 09:01:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAMhs-H8vw48RkpFz+rqvoPqDPpkaHdn60j6SdbDJHTNTTp7Fcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/2/21 7:50 AM, Sergio Paracuellos wrote:
> Hi Guenter,
> 
> On Thu, Dec 2, 2021 at 4:06 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 12/2/21 12:29 AM, Sergio Paracuellos wrote:
>>> Hi Guenter,
>>>
>>> On Wed, Dec 1, 2021 at 11:17 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On 12/1/21 1:51 PM, Sergio Paracuellos wrote:
>>>>> PCI core code call 'pcibios_root_bridge_prepare()' function inside function
>>>>> 'pci_register_host_bridge()'. This point is very good way to properly enter
>>>>> into this MIPS ralink specific code to properly setup I/O coherency units
>>>>> with PCI memory addresses.
>>>>>
>>>>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>>>>> ---
>>>>>     arch/mips/ralink/mt7621.c | 30 ++++++++++++++++++++++++++++++
>>>>>     1 file changed, 30 insertions(+)
>>>>>
>>>>> diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
>>>>> index bd71f5b14238..7649416c1cd7 100644
>>>>> --- a/arch/mips/ralink/mt7621.c
>>>>> +++ b/arch/mips/ralink/mt7621.c
>>>>> @@ -10,6 +10,7 @@
>>>>>     #include <linux/slab.h>
>>>>>     #include <linux/sys_soc.h>
>>>>>     #include <linux/memblock.h>
>>>>> +#include <linux/pci.h>
>>>>>
>>>>>     #include <asm/bootinfo.h>
>>>>>     #include <asm/mipsregs.h>
>>>>> @@ -22,6 +23,35 @@
>>>>>
>>>>>     static void *detect_magic __initdata = detect_memory_region;
>>>>>
>>>>> +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>>>>> +{
>>>>> +     struct resource_entry *entry;
>>>>> +     resource_size_t mask;
>>>>> +
>>>>> +     entry = resource_list_first_type(&bridge->windows, IORESOURCE_MEM);
>>>>> +     if (!entry) {
>>>>> +             pr_err("Cannot get memory resource\n");
>>>>> +             return -EINVAL;
>>>>> +     }
>>>>> +
>>>>> +     if (mips_cps_numiocu(0)) {
>>>>> +             /*
>>>>> +              * FIXME: hardware doesn't accept mask values with 1s after
>>>>> +              * 0s (e.g. 0xffef), so it would be great to warn if that's
>>>>> +              * about to happen
>>>>> +              */ > +         mask = ~(entry->res->end - entry->res->start);
>>>>> +
>>>>
>>>> Try something like this:
>>>>                   WARN_ON((mask != ~0UL && BIT(ffz(mask)) - 1 != mask);
>>>
>>> Thanks for the tip. The following works for me:
>>>
>>>                     WARN_ON(mask != ~0UL && ~(BIT(__ffs(mask)) - 1) != mask);
>>
>> Are you sure ? __ffs() returns the first bit set, which isn't useful
>> for this test.
> 
> My mask is calculated as follows:
>   mask = ~(entry->res->end - entry->res->start);
> 
> Where for normal memory resource:
>   - entry->res->end = 0x6fffffff;
>   - entry->res->start = 0x60000000;
> 
> So I end up with a mask: 0xf0000000.
> 
> So applying ~(BIT(__ffs(mask)) - 1) I get a good '0xf0000000' for this
> particular case which looks correct.
> 
> Suppose an invalid case with the mask being 0xffef0000.
> 
> Applying ~(BIT(__ffs(mask)) - 1) will be 0xffff0000 which will trigger
> the WARN_ON since 0xffff0000 != 0xffef0000
> 
> So I think this is correct... Am I missing something?
> 

Your description says "hardware doesn't accept mask values with 1s after 0s
(e.g. 0xffef)". 0xf0000000 has 1s after 0s.

Your version works (I think) as long as the upper mask bits are all 1s.
It will fail, for example, if the mask value is 0xf000000 and
sizeof(long) == 8. Your test is the equivalent of "no mask value
with 0s after 1s", assuming that sizeof(resource_size_t) == sizeof(long).
As far as I can see with test code, it fails if sizeof(resource_size_t)
!= sizeof(long). Also, it returns an error if mask == 0. I guess that is
a corner case, but it would be interesting to know if it is theoretically
valid.

I _think_ the following works even if sizeof(resource_size_t) != sizeof(long).

	WARN_ON(mask && BIT(ffz(~mask)) - 1 != ~mask);

or, alternatively, something like

	mask2 = entry->res->end - entry->res->start;
	mask = ~mask2;
	WARN_ON(mask && BIT(ffz(mask2)) - 1 != mask2);

though that looks a bit weird.

Thanks,
Guenter

> Thanks,
>      Sergio Paracuellos
>>
>> Guenter
>>
>>>
>>> I will send this as a different patch, though.
>>>
>>> Best regards,
>>>       Sergio Paracuellos
>>>
>>>>
>>>>> +             write_gcr_reg1_base(entry->res->start);
>>>>> +             write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
>>>>> +             pr_info("PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
>>>>> +                     (unsigned long long)read_gcr_reg1_base(),
>>>>> +                     (unsigned long long)read_gcr_reg1_mask());
>>>>> +     }
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>>     phys_addr_t mips_cpc_default_phys_base(void)
>>>>>     {
>>>>>         panic("Cannot detect cpc address");
>>>>>
>>>>
>>

