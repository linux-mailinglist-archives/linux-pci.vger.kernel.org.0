Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE64647721
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 21:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiLHUUd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 15:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiLHUU2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 15:20:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C65A2B1B4
        for <linux-pci@vger.kernel.org>; Thu,  8 Dec 2022 12:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670530769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKHzWNJ7JSA7UPpo6qNq0rP4CnM5zYPQGSntpfKSPk8=;
        b=c0A8gl1K9SZLyvmyHOjsy3gK/ls+viXcADKk1aTr4x3Kz9/I0HT0f/pdK0c8lMOFA+9pt5
        j9PjOLrL2ecg0m8U+MqQUlJcsasEsQAUbr7HBt7W8cnNIWozRY6CdyrK2U1cN3IdRy2m6T
        Qrw3IjQcW7uqaqOcJKOfjKerR8dW9qA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-487-trJQUQt7NEGlTFtj4avSSg-1; Thu, 08 Dec 2022 15:19:28 -0500
X-MC-Unique: trJQUQt7NEGlTFtj4avSSg-1
Received: by mail-ed1-f71.google.com with SMTP id g14-20020a056402090e00b0046790cd9082so121530edz.21
        for <linux-pci@vger.kernel.org>; Thu, 08 Dec 2022 12:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKHzWNJ7JSA7UPpo6qNq0rP4CnM5zYPQGSntpfKSPk8=;
        b=FzM1Ww3z6IJl/ub2vYhsSkwI3WWzhtfBBOZ7X01a17k0C2CyvxQd2jtEvewu7ps3pV
         kLMX5oBgwDMi08YRswEmpukJqbRyoYRzp8ZF12Wel8e5HdXF9Mwh8U1riYmZEYXH0TDJ
         MJrbxwTeE0gI2wKIdRZKJFv/sbefDJpsUbAsnCuFQjIVE4acNYLhS7VKbuIOJHpxHRU8
         f1+6NsINH1vaJyWhXwGUjXv3jJt9vSsIP9zBxfXXM3C/F1aC5I9sbbtiLX7rRCl2qXZ4
         tHhBSG2/eqJHwEbtm66y80sXNTDLz44UjY+ykPPf3CSdKeKfAtZ8xb4AgkX9rVguhGRj
         x7LQ==
X-Gm-Message-State: ANoB5pnEoooiGoFkFKvjzAii7BmCjQy0YMLdOL8sJt9Qei8eyEVGWU/6
        rYTnArpZavI6J9yPKHA2fUe/qRxedJoLJt6fTzwEW0h2/nyADDfnjQs2uB5Nkyd+UrDbffk/oVX
        VmYiGXVXqrGPVUZKKKWAs
X-Received: by 2002:a17:906:9f23:b0:7c1:1ad9:e5b0 with SMTP id fy35-20020a1709069f2300b007c11ad9e5b0mr2612490ejc.33.1670530767035;
        Thu, 08 Dec 2022 12:19:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5qLAF0gLqrx/eRPyh21FaHB793/ueuMNyqAZ8hP4ElQDFnheRxg+heDR/LvRlqLubJyHLjjg==
X-Received: by 2002:a17:906:9f23:b0:7c1:1ad9:e5b0 with SMTP id fy35-20020a1709069f2300b007c11ad9e5b0mr2612478ejc.33.1670530766853;
        Thu, 08 Dec 2022 12:19:26 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b0073dc5bb7c32sm10061712eja.64.2022.12.08.12.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 12:19:26 -0800 (PST)
Message-ID: <33a65ae8-784d-920f-8542-3762916e070c@redhat.com>
Date:   Thu, 8 Dec 2022 21:19:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
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
References: <20221208200654.GA1562951@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221208200654.GA1562951@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 12/8/22 21:06, Bjorn Helgaas wrote:
> On Thu, Dec 08, 2022 at 08:16:31PM +0100, Hans de Goede wrote:
>> Hi Bjorn,
>>
>> On 12/8/22 19:57, Bjorn Helgaas wrote:
>>> On Wed, Dec 07, 2022 at 04:31:12PM +0100, Hans de Goede wrote:
>>>> On 12/4/22 10:13, Hans de Goede wrote:
>>>>
>>>> <snip>
>>>>
>>>>>>> 2. I am afraid that now allowing PCI MMIO space to be allocated
>>>>>>> in regions marked as EfiMemoryMappedIO will cause regressions
>>>>>>> on some systems. Specifically when I tried something similar
>>>>>>> the last time I looked at this (using the BIOS date cut-off
>>>>>>> approach IIRC) there was a suspend/resume regression on
>>>>>>> a Lenovo ThinkPad X1 carbon (20A7) model:
>>>>>>>
>>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=2029207
>>>>>>>
>>>>>>> Back then I came to the conclusion that the problem is that not
>>>>>>> avoiding the EfiMemoryMappedIO regions caused PCI MMIO space to
>>>>>>> be allocated in the 0xdfa00000 - 0xdfa10000 range which is
>>>>>>> listed in the EFI memmap as:
>>>>>>>
>>>>>>> [    0.000000] efi: mem46: [MMIO        |RUN|  |  |  |  |  |  |  |  |   |  |  |  |  ] range=[0x00000000dfa00000-0x00000000dfa0ffff] (0MB)
>>>>>>>
>>>>>>> And with current kernels with the extra logging added for this
>>>>>>> the following is logged related to this:
>>>>>>>
>>>>>>> [    0.326504] acpi PNP0A08:00: clipped [mem 0xdfa00000-0xfebfffff window] to [mem 0xdfa10000-0xfebfffff window] for e820 entry [mem 0xdceff000-0xdfa0ffff]
>>>>>>>
>>>>>>> I believe patch 1/4 of this set will make this clipping go away,
>>>>>>> re-introducing the suspend/resume problem.
>>>>>>
>>>>>> Yes, I'm afraid you're right.  Comparing the logs at comment #31
>>>>>> (fails) and comment #38 (works):
>>>>>>
>>>>>>   pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
>>>>>>   pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfa00000-0xdfbfffff] fails
>>>>>>   pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfb00000-0xdfcfffff] works
>>>>>>
>>>>>> Since 0xdfa00000 is included in the host bridge _CRS, but isn't
>>>>>> usable, my guess is this is a _CRS bug.
>>>>>
>>>>> Ack.
>>>>>
>>>>> So I was thinking to maybe limit the removal of EfiMemoryMappedIO
>>>>> regions from the E820 map if they are big enough to cause troubles?
>>>>>
>>>>> Looking at the EFI map MMIO regions on this Lenovo ThinkPad X1 carbon
>>>>> (20A7) model, they are tiny. Where as the ones which we know cause
>>>>> problems are huge. So maybe add a bit of heuristics to patch 1/4 based
>>>>> on the EfiMemoryMappedIO region size and only remove the big ones
>>>>> from the E820 map ?
>>>>>
>>>>> I know that adding heuristics like this always feels a bit wrong,
>>>>> because you end up putting a somewhat arbitrary cut off point in
>>>>> the code on which to toggle behavior on/off, but I think that in
>>>>> this case it should work nicely given how huge the EfiMemoryMappedIO
>>>>> regions which are actually causing problems are.
>>>
>>> I'll post a v2 that removes only regions 256KB or larger in a minute.
>>
>> Ok, may I ask why 256KB?
>>
>> I see that that rules out then troublesome MMIO regions from the X1 carbon from:
>> https://bugzilla.redhat.com/show_bug.cgi?id=2029207 :
>> efi: mem46: [MMIO|RUN|  ] range=[0xdfa00000-0xdfa0ffff] (0MB) [64K]
>> which we know we need to avoid / keep reserved.
>>
>> But OTOH the reservations which are causing the problems with assigning
>> resources to PCI devices by Linux look like this:
>> efi: mem50: [MMIO        |RUN|  |  |  |  |  |  |  |  |   |  |  |  |UC] range=[0x0000000065400000-0x00000000cfffffff] (1708MB)
>> which is significantly larger then 256KB.
>>
>> So we could e.g. also put the cut-off point at 16MB and still
>> remove the above troublesome reservation from the E820 table.
>> Note just thinking out loud here. I have no idea if 16MB
>> would be better...
> 
> No good reason for 256KB.  We know it needs to be at least 64KB for
> the X1 Carbon.  I picked 4x bigger just for headroom, since I assume
> the 64KB is platform-specific host bridge registers or something.  Do
> you think a bigger number would be better, i.e., we would retain more
> MMIO things in E820?
> 
> ECAM areas would be 1MB per bus, so between 1MB and 256MB.  Those areas
> *should* be reserved by PNP0C02 _CRS, but IIRC the early MMCONFIG code
> checks E820, and the late code checks for _CRS.  I guess one could
> argue that ignoring those, e.g., by retaining anything 256MB or
> smaller in E820, would reduce the amount of change.  

Right, reducing how much we change what the E820 map looks like after
this would be the main reason to make the cut of point bigger then
256KB.

> But if the host bridge _CRS includes 256MB of legitimate window that
> EFI says is MMIO and is hence included in E820, that seems like kind
> of a lot of usable window space to give up.

Ack, I guess we can just go with 256KB for now and then see how things go.

Regards,

Hans



