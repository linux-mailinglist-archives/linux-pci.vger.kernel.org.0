Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46ACB645DB0
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 16:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiLGPcN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 10:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLGPcM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 10:32:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98616151E
        for <linux-pci@vger.kernel.org>; Wed,  7 Dec 2022 07:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670427076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=spqVUzHXWNLSZYhZDfeeglZTADpFbTErHQ4qDoLdhdo=;
        b=GnPjWsNnMvbhvA0WmSHpaJzRFi79MIrf3e15+Ip1l/0qi1x4Aw9euk6Fr5vsCbhhyow/O/
        GaRAdSlHGnXFZYKHsUsDwiz//2P17lEU5IJza07wq3xKdvEwNtqCLRN3+5hI4ksCIjMzMq
        2P04ChiA9P76yEdyCdvH6yl8VBLZpAw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-644-TBQXqkFVMKysUglG4Qt4-g-1; Wed, 07 Dec 2022 10:31:15 -0500
X-MC-Unique: TBQXqkFVMKysUglG4Qt4-g-1
Received: by mail-ed1-f70.google.com with SMTP id r12-20020a05640251cc00b00463699c95aeso10240892edd.18
        for <linux-pci@vger.kernel.org>; Wed, 07 Dec 2022 07:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spqVUzHXWNLSZYhZDfeeglZTADpFbTErHQ4qDoLdhdo=;
        b=lBdwK7/iyYE5NcPNDj9LWF05ru+NEDPKr/q36zaw3FvT+pcKXcrBn9SB6MR2TmKh2B
         5qX31zytSizMZ8cCasJ2T3wcfq5OcL4JEgs2DVomi82Xto0wSk9b/ElyYOBdg/JefupS
         GFbIZhUDLtllJFdc0NRrZ/3x4HFby4H3BoSrOG4bm7jATkO9F1Bw+WQwL3Fq/y6mV5OK
         BlPfDfenjB786NJrqUnzm2MBpayPxQ0lmuaAdaZi1AM02P9DNgle0uZWBSU9L4ZUOWAD
         DQ/ATg1GTqCJad8lzIDGMGnzwjTMuDIq+GSd9/iQe9WbXYSFGqlTeotqROOPbTlun99I
         pyVg==
X-Gm-Message-State: ANoB5pneBL5o53xHWefsksRX/+1xNRUmHGdlUB5c6THyBbGFNml++srg
        Sf3Zo9L98VSt6hf1X7iOl1s8H59w/TrokvJpnU4Dz7hk7UASJMtB2LhF2TCIM7VKWi6JGWHqqHz
        BOLZYRZnnehFOFHDE8yFb
X-Received: by 2002:a05:6402:68f:b0:46c:53ea:4a64 with SMTP id f15-20020a056402068f00b0046c53ea4a64mr17681012edy.413.1670427074550;
        Wed, 07 Dec 2022 07:31:14 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6i5qYo9TfwBSckVoMgUSUBn1du5AQ60jaguE9Qpm/GQl/Jd7GLGQoKcUPwWl3+f5Mkz7bxOA==
X-Received: by 2002:a05:6402:68f:b0:46c:53ea:4a64 with SMTP id f15-20020a056402068f00b0046c53ea4a64mr17680995edy.413.1670427074313;
        Wed, 07 Dec 2022 07:31:14 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id tz4-20020a170907c78400b007c0b530f3cfsm7303602ejc.72.2022.12.07.07.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 07:31:13 -0800 (PST)
Message-ID: <6da2287f-a2a9-8419-39a5-a3971e4d5499@redhat.com>
Date:   Wed, 7 Dec 2022 16:31:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/4] PCI: Continue E820 vs host bridge window saga
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
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
 <15fe50bb-bd11-677b-3cbd-645a267b7026@redhat.com>
In-Reply-To: <15fe50bb-bd11-677b-3cbd-645a267b7026@redhat.com>
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

On 12/4/22 10:13, Hans de Goede wrote:

<snip>

>>> 2. I am afraid that now allowing PCI MMIO space to be allocated
>>> in regions marked as EfiMemoryMappedIO will cause regressions
>>> on some systems. Specifically when I tried something similar
>>> the last time I looked at this (using the BIOS date cut-off
>>> approach IIRC) there was a suspend/resume regression on
>>> a Lenovo ThinkPad X1 carbon (20A7) model:
>>>
>>> https://bugzilla.redhat.com/show_bug.cgi?id=2029207
>>>
>>> Back then I came to the conclusion that the problem is that not
>>> avoiding the EfiMemoryMappedIO regions caused PCI MMIO space to
>>> be allocated in the 0xdfa00000 - 0xdfa10000 range which is
>>> listed in the EFI memmap as:
>>>
>>> [    0.000000] efi: mem46: [MMIO        |RUN|  |  |  |  |  |  |  |  |   |  |  |  |  ] range=[0x00000000dfa00000-0x00000000dfa0ffff] (0MB)
>>>
>>> And with current kernels with the extra logging added for this
>>> the following is logged related to this:
>>>
>>> [    0.326504] acpi PNP0A08:00: clipped [mem 0xdfa00000-0xfebfffff window] to [mem 0xdfa10000-0xfebfffff window] for e820 entry [mem 0xdceff000-0xdfa0ffff]
>>>
>>> I believe patch 1/4 of this set will make this clipping go away,
>>> re-introducing the suspend/resume problem.
>>
>> Yes, I'm afraid you're right.  Comparing the logs at comment #31
>> (fails) and comment #38 (works):
>>
>>   pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
>>   pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfa00000-0xdfbfffff] fails
>>   pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfb00000-0xdfcfffff] works
>>
>> Since 0xdfa00000 is included in the host bridge _CRS, but isn't
>> usable, my guess is this is a _CRS bug.
> 
> Ack.
> 
> So I was thinking to maybe limit the removal of EfiMemoryMappedIO
> regions from the E820 map if they are big enough to cause troubles?
> 
> Looking at the EFI map MMIO regions on this Lenovo ThinkPad X1 carbon
> (20A7) model, they are tiny. Where as the ones which we know cause
> problems are huge. So maybe add a bit of heuristics to patch 1/4 based
> on the EfiMemoryMappedIO region size and only remove the big ones
> from the E820 map ?
> 
> I know that adding heuristics like this always feels a bit wrong,
> because you end up putting a somewhat arbitrary cut off point in
> the code on which to toggle behavior on/off, but I think that in
> this case it should work nicely given how huge the EfiMemoryMappedIO
> regions which are actually causing problems are.

One of the original reporters of the suspend/resume problem has gotten
back to me in:

https://bugzilla.redhat.com/show_bug.cgi?id=2029207

And they are willing to run some more tests. I could give them
a 6.0 kernel with the 4 patches from this series added to test,
but I think we both agree that it is very likely that the suspend/resume
problem will resurface, so I'm not sure how useful that would be ?

>> Or maybe BIOS is using the producer/consumer bit in _CRS to identify
>> this as register space as opposed to a window?  I thought we couldn't
>> rely on that bit, but it's been a long time since I looked at it.  An
>> acpidump might have a clue.

I have asked the reporter of;

https://bugzilla.redhat.com/show_bug.cgi?id=2029207

To grab any acpidump.

Regards,

Hans




p.s.

Looking at the efi=debug output from:

https://bugzilla-attachments.redhat.com/attachment.cgi?id=1861035

The small MMIO regions which we most honor as reserved do
have the "RUN" (runtime) flag set in the EFI mmap.

But I'm afraid that the same applies to the troublesome
MMIO EFI regions which cause the failures to assign
PCI regions for devices not setup by the firmware:

https://bugzilla-attachments.redhat.com/attachment.cgi?id=1861407

So that "RUN" flag is of no use.


