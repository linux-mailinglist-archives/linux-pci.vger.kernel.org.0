Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FA85F8BC2
	for <lists+linux-pci@lfdr.de>; Sun,  9 Oct 2022 16:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJIOcL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Oct 2022 10:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJIOcK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Oct 2022 10:32:10 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EE022BC3
        for <linux-pci@vger.kernel.org>; Sun,  9 Oct 2022 07:32:08 -0700 (PDT)
Received: (Authenticated sender: x@undead.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 97B77FF803;
        Sun,  9 Oct 2022 14:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=undead.fr; s=gm1;
        t=1665325927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=943ocfJI42pghb52uFgrIbERhro0goFmsfaQz2flXIk=;
        b=Jq66LdEw/6gvouDTTFCFJ2hfv7dvn7Ud4wbE/If3J+EfYXKqIQ2mSyoBwkqxCvRgL5UP4w
        Dk6T+IvkYsXiOD0GlDj5W5U+KikEHpPdpQ9E2ckeSMo7xMSKtOCUYH9ByY9Nv2g21oqZu5
        mBPdoxOIY/cAQ9CNYBmX0S/XrPDv903YL1H9d8E3lr0qp3mn5SPwgMNQhRPE37l+Bq5sHc
        k6L/zxhHiGd0ndgIS/G2xz0YpY+gI6Ogfb4lVrcYgN67Xlbi8aKX7Y/DyEkexhLD7hWXJZ
        H8lpTAXoqymInz9YpqqRpmOob03Do+6NsmrKBYSLtU0VKXVPi1dRpx5Ss4A8Hw==
Message-ID: <cad1e4c6-7994-af6a-987f-e9da89914137@undead.fr>
Date:   Sun, 9 Oct 2022 16:32:05 +0200
MIME-Version: 1.0
Subject: Re: pci=no_e820 required for Clevo laptop
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
References: <5d8ae0a2-1c0c-11ab-a33c-9b57bd087733@undead.fr>
 <Yz2Hm99xHaJmdN6g@rocinante>
 <e779bcf1-f99d-6b3e-1e9b-42b046f0950f@redhat.com>
Content-Language: fr, en-US
From:   linuxkernelml@undead.fr
In-Reply-To: <e779bcf1-f99d-6b3e-1e9b-42b046f0950f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hans/Krzysztof,

Thank you for your answers. Indeed you can forget about the SSD issue, 
it was due to other various kernel parameters so the issue is only 
related to the touchpad.

I have been following discussions about e820 PCI BAR reservation issue 
for months and it seems that my laptop is part of buggy ones that have 
been identified (Clevo, bought in 2020).

I have created https://bugzilla.kernel.org/show_bug.cgi?id=216565 so 
that you can add another quirk.

Regards,

Florent


Le 05/10/2022 à 15:43, Hans de Goede a écrit :
> Hi,
>
> On 10/5/22 15:33, Krzysztof Wilczyński wrote:
>> (+CC Bjorn and Hans directly for visibility)
>>
>> Hi Florent,
>>
>> I am sorry that you are having issues!
>>
>>> As per
>>> https://www.kernel.org/doc/Documentation/admin-guide/kernel-parameters.txt,
>>> I am sending you this email to inform you that I need to set "pci=no_e820"
>>> parameter to get the SSD and touchpad working.
>>>
>>> ---------------------------------------------------------------------
>>>
>>> Dmidecode:
>>>
>>> BIOS Information
>>>      Vendor: INSYDE Corp.
>>>      Version: 1.07.02TPCS
>>>      Release Date: 08/19/2020
>>>
>>>      BIOS Revision: 7.2
>>>      Firmware Revision: 7.2
>>> Handle 0x0001, DMI type 1, 27 bytes
>>> System Information
>>>      Manufacturer: PC Specialist LTD
>>>      Product Name: NL4x_NL5xLU
>>> Base Board Information
>>>      Manufacturer: CLEVO
>>>      Product Name: NL4XLU
>>>
>>> uname -a
>>> Linux topik 5.19.0-2-amd64 #1 SMP PREEMPT_DYNAMIC Debian 5.19.11-1
>>> (2022-09-24) x86_64 GNU/Linux
>> We need a little bit more information, if you have the time, to collect
>> that will be of great help to us with troubleshooting this.
>>
>> Would you be able to collect output from the following:
>>
>>    - lspci -vvv
>>    - dmesg (preferably since the system started)
>>
>> Then, either attach these here as text attachments, or better yet, open
>> a bug report against the PCI driver on Kernel's Bugzilla at
>>
>>    https://bugzilla.kernel.org/
>>
>> and include as much information as possible about your system as you can,
>> plus the details mentioned above.  That would help greatly.
> Yes if you can file a bug in: https://bugzilla.kernel.org/
> with the requested logs attached so that we have those for
> future reference, that would be great.
>
> Note we already have one no_e820 DMI quirk for Clevo models,
> so these models may just need another quirk, but first we
> would like to better understand the problem.
>
> For the existing quirk see: arch/x86/pci/acpi.c around line 180:
>
>          /*
>           * Clevo X170KM-G barebones have the same E820 reservation covering
>           * the entire _CRS 32-bit window issue as the Lenovo *IIL* models.
>           * See https://bugzilla.kernel.org/show_bug.cgi?id=214259
>           */
>          {
>                  .callback = set_no_e820,
>                  .ident = "Clevo X170KM-G Barebone",
>                  .matches = {
>                          DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
>                  },
>          },
>
> I'm a bit surprised this is needed for the SSD too though. Usually it
> is just the touchpad + hotplugged (Thunderbolt) PCI devices which need this.
>
> BTW please also attach the dmidecode.txt file generated by:
>
> sudo dmidecode > dmidecode.txt
>
> to the bug, since we need those strings to add the quirk. Note this will
> also include serial-numbers for your device (if your model uses unique per
> model serial numbers) feel free to edit the file and remove those.
>
> Regards,
>
> Hans
>
>
