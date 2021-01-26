Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC57303F43
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 14:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404933AbhAZNtb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 08:49:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32473 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404929AbhAZNnp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jan 2021 08:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611668540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ee5AivrSRLItWFPV05HPSH2q5yS6lb/pyR0EaqqWQbk=;
        b=GGalh2mDWJBmwg1wuX4oo0oeDvMINECU3Il8mugJyPP8gAL1S3UxtDAtQs0AlFbAuFPz7G
        7Wkx9dr0iXdp4PzDzOWoUarBkOK+jI6cwhJ4D/iM/Dmd/L3jiqNq+HsiPdHliotShN88p1
        /RX9gE050kJU1vmRAGmXoXMYOES9LLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-W_QBnZ1EP7Chpe_JIb1Kjw-1; Tue, 26 Jan 2021 08:42:16 -0500
X-MC-Unique: W_QBnZ1EP7Chpe_JIb1Kjw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C627D8018AB;
        Tue, 26 Jan 2021 13:42:13 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B72B01880F;
        Tue, 26 Jan 2021 13:42:12 +0000 (UTC)
Subject: Re: [PATCH] pci-driver: Add driver load messages
To:     Leon Romanovsky <leon@kernel.org>
Cc:     bhelgaas@google.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org, mstowe@redhat.com
References: <20210126063935.GC1053290@unreal>
 <20210126125446.1118325-1-prarit@redhat.com>
 <20210126131441.GG1053290@unreal>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <616eb9a3-b855-316b-5091-8b8230208455@redhat.com>
Date:   Tue, 26 Jan 2021 08:42:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210126131441.GG1053290@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/26/21 8:14 AM, Leon Romanovsky wrote:
> On Tue, Jan 26, 2021 at 07:54:46AM -0500, Prarit Bhargava wrote:
>>   Leon Romanovsky <leon@kernel.org> wrote:
>>> On Mon, Jan 25, 2021 at 02:41:38PM -0500, Prarit Bhargava wrote:
>>>> There are two situations where driver load messages are helpful.
>>>>
>>>> 1) Some drivers silently load on devices and debugging driver or system
>>>> failures in these cases is difficult.  While some drivers (networking
>>>> for example) may not completely initialize when the PCI driver probe() function
>>>> has returned, it is still useful to have some idea of driver completion.
>>>
>>> Sorry, probably it is me, but I don't understand this use case.
>>> Are you adding global to whole kernel command line boot argument to debug
>>> what and when?
>>>
>>> During boot:
>>> If device success, you will see it in /sys/bus/pci/[drivers|devices]/*.
>>> If device fails, you should get an error from that device (fix the
>>> device to return an error), or something immediately won't work and
>>> you won't see it in sysfs.
>>>
>>
>> What if there is a panic during boot?  There's no way to get to sysfs.
>> That's the case where this is helpful.
> 
> How? If you have kernel panic, it means you have much more worse problem
> than not-supported device. If kernel panic was caused by the driver, you
> will see call trace related to it. If kernel panic was caused by
> something else, supported/not supported won't help here.

I still have no idea *WHICH* device it was that the panic occurred on.
> 
>>
>>> During run:
>>> We have many other solutions to get debug prints during run, for example
>>> tracing, which is possible to toggle dynamically.
>>>
>>> Right now, my laptop will print 34 prints on boot and endless amount during
>>> day-to-day usage.
>>>
>>> ➜  kernel git:(rdma-next) ✗ lspci |wc -l
>>> 34
>>>
>>>>
>>>> 2) Storage and Network device vendors have relatively short lives for
>>>> some of their hardware.  Some devices may continue to function but are
>>>> problematic due to out-of-date firmware or other issues.  Maintaining
>>>> a database of the hardware is out-of-the-question in the kernel as it would
>>>> require constant updating.  Outputting a message in the log would allow
>>>> different OSes to determine if the problem hardware was truly supported or not.
>>>
>>> And rely on some dmesg output as a true source of supported/not supported and
>>> making this ABI which needs knob in command line. ?
>>
>> Yes.  The console log being saved would work as a true source of load
>> messages to be interpreted by an OS tool.  But I see your point about the
>> knob below...
> 
> You will need much more stronger claim than the above if you want to proceed
> ABI path through dmesg prints.
> 

See my answer below.  I agree with you on the ABI statement.

>>
>>>
>>>>
>>>> Add optional driver load messages from the PCI core that indicates which
>>>> driver was loaded, on which slot, and on which device.
>>>
>>> Why don't you add simple pr_debug(..) without any knob? You will be able
>>> to enable/disable it through dynamic prints facility.
>>
>> Good point.  I'll wait for more feedback and submit a v2 with pr_debug.
> 
> Just to be clear, none of this can be ABI and any kernel print can
> be changed or removed any minute without any announcement.

Yes, that's absolutely the case and I agree with you that nothing can guarantee
ABI of those pr_debug() statements.  They are *debug* after all.

P.

> 
> Thanks
> 
>>
>> P.
>>
>>>
>>> Thanks
>>
> 

