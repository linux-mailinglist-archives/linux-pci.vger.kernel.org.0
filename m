Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA023308C9F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jan 2021 19:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhA2Sjj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jan 2021 13:39:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49443 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231897AbhA2Sji (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jan 2021 13:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611945491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o6RgsnGWqDbRx7FOfKlaMYyztEsq7mThGPYbon8eyBE=;
        b=gWLZlXGMxJRgaRnQ+23B0+qqFEZVT6X71yDjvM1tFZmw/QCaGKxYtOUWdnXDaskKc2KODd
        WkPFRTauKO7POXZSfM1AMxky7YF0aMXtjkssoNkLPZcnWuhd+dD8Yfne76abedR76MdYwL
        PrhrV9JeHvRNnbODQ/ytheJk94uD000=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-FnU8NuaCP02giqCI5tvXtQ-1; Fri, 29 Jan 2021 13:38:09 -0500
X-MC-Unique: FnU8NuaCP02giqCI5tvXtQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FC3581CBF3;
        Fri, 29 Jan 2021 18:38:07 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93A875D984;
        Fri, 29 Jan 2021 18:38:05 +0000 (UTC)
Subject: Re: [PATCH] pci-driver: Add driver load messages
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Leon Romanovsky <leon@kernel.org>, bhelgaas@google.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org, mstowe@redhat.com
References: <20210126151259.GA2886142@bjorn-Precision-5520>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <e2dfcabb-c62b-2823-b2a7-7d54799be183@redhat.com>
Date:   Fri, 29 Jan 2021 13:38:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210126151259.GA2886142@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/26/21 10:12 AM, Bjorn Helgaas wrote:
> Hi Prarit,
>
> On Tue, Jan 26, 2021 at 09:05:23AM -0500, Prarit Bhargava wrote:
>> On 1/26/21 8:53 AM, Leon Romanovsky wrote:
>>> On Tue, Jan 26, 2021 at 08:42:12AM -0500, Prarit Bhargava wrote:
>>>> On 1/26/21 8:14 AM, Leon Romanovsky wrote:
>>>>> On Tue, Jan 26, 2021 at 07:54:46AM -0500, Prarit Bhargava wrote:
>>>>>>   Leon Romanovsky <leon@kernel.org> wrote:
>>>>>>> On Mon, Jan 25, 2021 at 02:41:38PM -0500, Prarit Bhargava wrote:
>>>>>>>> There are two situations where driver load messages are helpful.
>>>>>>>>
>>>>>>>> 1) Some drivers silently load on devices and debugging driver or system
>>>>>>>> failures in these cases is difficult.  While some drivers (networking
>>>>>>>> for example) may not completely initialize when the PCI driver probe()
function
>>>>>>>> has returned, it is still useful to have some idea of driver completion.
>>>>>>>
>>>>>>> Sorry, probably it is me, but I don't understand this use case.
>>>>>>> Are you adding global to whole kernel command line boot argument to debug
>>>>>>> what and when?
>>>>>>>
>>>>>>> During boot:
>>>>>>> If device success, you will see it in /sys/bus/pci/[drivers|devices]/*.
>>>>>>> If device fails, you should get an error from that device (fix the
>>>>>>> device to return an error), or something immediately won't work and
>>>>>>> you won't see it in sysfs.
>>>>>>
>>>>>> What if there is a panic during boot?  There's no way to get to sysfs.
>>>>>> That's the case where this is helpful.
>>>>>
>>>>> How? If you have kernel panic, it means you have much more worse problem
>>>>> than not-supported device. If kernel panic was caused by the driver, you
>>>>> will see call trace related to it. If kernel panic was caused by
>>>>> something else, supported/not supported won't help here.
>>>>
>>>> I still have no idea *WHICH* device it was that the panic occurred on.
>>>
>>> The kernel panic is printed from the driver. There is one driver loaded
>>> for all same PCI devices which are probed without relation to their
>>> number.>
>>> If you have host with ten same cards, you will see one driver and this
>>> is where the problem and not in supported/not-supported device.
>>
>> That's true, but you can also have different cards loading the same driver.
>> See, for example, any PCI_IDs list in a driver.
>>
>> For example,
>>
>> 10:00.0 RAID bus controller: Broadcom / LSI MegaRAID SAS-3 3008 [Fury] (rev 02)
>> 20:00.0 RAID bus controller: Broadcom / LSI MegaRAID SAS-3 3108 [Invader]
(rev 02)
>>
>> Both load the megaraid driver and have different profiles within the
>> driver.  I have no idea which one actually panicked until removing
>> one card.
>>
>> It's MUCH worse when debugging new hardware and getting a panic
>> from, for example, the uncore code which binds to a PCI mapped
>> device.  One device might work and the next one doesn't.  And then
>> you can multiply that by seeing *many* panics at once and trying to
>> determine if the problem was on one specific socket, die, or core.
>
> Would a dev_panic() interface that identified the device and driver
> help with this?

It would but,

>
> For driver_load_messages, it doesn't seem necessarily PCI-specific.
> If we want a message like that, maybe it could be in
> driver_probe_device() or similar?  There are already a few pr_debug()
> calls in that path.  There are some enabled by initcall_debug that
> include the return value from the probe; would those be close to what
> you're looking for?

I think this drivers/base/dd.c:727 might suffice.  Let me try some tests
with that and get back to you.

Thanks for the pointers,

P.
>
> Bjorn
>

