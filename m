Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CA9375C8A
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 23:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhEFVFr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 17:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhEFVFr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 May 2021 17:05:47 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEF7C061574
        for <linux-pci@vger.kernel.org>; Thu,  6 May 2021 14:04:49 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso6134871otm.4
        for <linux-pci@vger.kernel.org>; Thu, 06 May 2021 14:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r7TvV40KUHm8NNUM7lUs+s+4x/azKf5sp+ALJojB1H0=;
        b=lwf3I/SqPMAsOlmQjp8DrCW/0vXIGJLYcYOGQprReLwtZOAV6YNneCmv2RWkObZ/u9
         X/lOlZWgTVWI+HIbU0mXWJ32fezx5nKE4s+CJkgzyO7vpnhlxJ2Niw5nBA9qf5IghDj0
         t37pLgRx5BAXWHoAOgVhP8/uJRnDxFC6febmPnTedZylygAFBmRJiuDI51K89Nu9dbz7
         5U4/7kJg5xCGpasFN7xJcHxyZcujEYblp98t+uf6icug9yAXJRxaqdIwB48KEcUS6Hxl
         HMeKE9mPRHO3bFl7Kq3UxY+6TiwYo2B+UwjXqtUxP2saVl5etJicd+a1Ibldf0e8qQHW
         zaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r7TvV40KUHm8NNUM7lUs+s+4x/azKf5sp+ALJojB1H0=;
        b=IMkZtn7Z6/TAfoYoXVzN/c7I5PsLUDcE21cKFcml6x37atJVJeDPCwu1CegcpZ+eHi
         Sknd0mHRpHcsHrl+i/A/2M6KsWFcZaade61/vfVZeO7zYMdKPk2/F0R2TO9tIwFrmmwB
         fA4YBF+Qf61fA0cYmGROf7oQooQXKcCaRB7vBVkGhqXDrMxbRP69/exctDfAMNt2kYJh
         P8DVHz4UaviIUkY2JKB7ViBi/CM6V1wOLmcUggWIMEvmWQigYAM/VOzNI2yfIoFY77uA
         hkU/Z9cIitAKv0ZFD/0MymZy0PpL17FncQWS6z8dZwO5G1/q5Nj7iNWWpJOtgoW/aDZE
         2PPQ==
X-Gm-Message-State: AOAM530+/BSoQDu7aK9hMgm+rAhodyuJapW7QCB+KcXdGN4zm0vLExpj
        do/PR1b0sf7RZkOjbsP1Uoc0dCE9VWc=
X-Google-Smtp-Source: ABdhPJyuFz7lY3Rdbxg1fsVHGg4jDumHnBxj8ctMIdw3QWAxpJcf7NX+OAdkStMKUfY+cllj2R8sDw==
X-Received: by 2002:a05:6830:2255:: with SMTP id t21mr5235399otd.271.1620335087719;
        Thu, 06 May 2021 14:04:47 -0700 (PDT)
Received: from ?IPv6:2603:8081:2802:9dfb:49b3:8e2:3d6d:26c8? (2603-8081-2802-9dfb-49b3-08e2-3d6d-26c8.res6.spectrum.com. [2603:8081:2802:9dfb:49b3:8e2:3d6d:26c8])
        by smtp.gmail.com with ESMTPSA id p15sm788236otl.23.2021.05.06.14.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 14:04:47 -0700 (PDT)
Subject: Re: [PATCH] Add support for PCIe SSD status LED management
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Keith Busch <kbusch@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20210416192010.3197-1-stuart.w.hayes@gmail.com>
 <20210506014827.GA175453@rocinante.localdomain>
 <20210506023403.GB1187168@dhcp-10-100-145-180.wdc.com>
 <20210506024624.GA182840@rocinante.localdomain>
From:   stuart hayes <stuart.w.hayes@gmail.com>
Message-ID: <bd7fdd27-e2c9-9a45-918f-a434db2dab69@gmail.com>
Date:   Thu, 6 May 2021 16:04:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20210506024624.GA182840@rocinante.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 5/5/2021 11:12 AM, Keith Busch wrote:
> On Fri, Apr 16, 2021 at 03:20:10PM -0400, Stuart Hayes wrote:
>> This patch adds support for the PCIe SSD Status LED Management
>> interface, as described in the "_DSM Additions for PCIe SSD Status LED
>> Management" ECN to the PCI Firmware Specification revision 3.2.
>>
>> It will add a single (led_classdev) LED for any PCIe device that has the
>> relevant _DSM. The ten possible status states are exposed using
>> attributes current_states and supported_states. Reading current_states
>> (and supported_states) will show the definition and value of each bit:
> 
> There is significant overlap in this ECN with the PCIe native enclosure
> management (NPEM) capability. Would it be possible for the sysfs
> interface to provide an abstraction such that both these implementations
> could subscribe to?
>   

It wouldn't be too hard to check for the NPEM capability here and 
provide access to it as well using the same LED interface, especially 
since the state bits are the same.  The module could just check for NPEM 
capability at the same time it is checking for the _DSM.  I guess that 
could be added on later without too much trouble, too... I don't think 
anything about the interface would have to change to add support for NPEM.

FWIW, it looks like NPEM support is already supported in user space in 
ledmon.  (I only wrote a kernel module for this, because it uses a _DSM 
which can't readily be accessed in user space.)


On 5/5/2021 9:46 PM, Krzysztof Wilczyński wrote:
> Hi Keith,
> 
>>>>> cat /sys/class/leds/0000:88:00.0::pcie_ssd_status/supported_states
>>>> ok                              0x0004 [ ]
>>>> locate                          0x0008 [*]
>>>> fail                            0x0010 [ ]
>>>> rebuild                         0x0020 [ ]
>>>> pfa                             0x0040 [ ]
>>>> hotspare                        0x0080 [ ]
>>>> criticalarray                   0x0100 [ ]
>>>> failedarray                     0x0200 [ ]
>>>> invaliddevice                   0x0400 [ ]
>>>> disabled                        0x0800 [ ]
>>>> --
>>>> supported_states = 0x0008
>>>>
>>>>> cat /sys/class/leds/0000:88:00.0::pcie_ssd_status/current_states
>>>> locate                          0x0008 [ ]
>>>
>>> As per what Keith already noted, this is a very elaborate output as far
>>> as sysfs goes - very human-readable, but it would be complex to parse
>>> should some software would be interested in showing this values in a way
>>> or another.
>>>
>>> I would propose output similar to this one:
>>>
>>>    $ cat /sys/block/sda/queue/scheduler
>>>    mq-deadline-nodefault [bfq] none
>>>
>>> If you prefer to show the end-user a string, rather than a numeric
>>> value.  This approach could support both the supported and current
>>> states (similarly to how it works for the I/O scheduler), thus there
>>> would be no need to duplicate the code between the two attributes.
>>>
>>> What do you think?
>>
>> Some enclosures may support just one blinky state at a time. Other
>> implementations might have multiple LEDs and colors, so you could, for
>> example, "locate" something that is also "failed", with both states
>> visible simultaneously. You could capture the current states with the
>> "scheduler" type display, but setting new states may be more
>> complicated.
> 
> Ah, excellent point.  I didn't think about this - the use-case you
> provided.  This would, indeed, be far more complex to deal with when
> accepting a write.  I can see why Stuart did it the way he did
> currently.
> 
> Krzysztof
> 

I copied the format of this output from acpi_debug_level / 
acpi_debug_layer in drivers/acpi/sysfs.c.  I thought it might be 
reasonably easy enough for a machine to parse this for the number, since 
it is always on the last line and always immediately following the only "=".

I don't object to using just a number, but I submitted an earlier 
version of this some months ago (which didn't use the LED subsystem) 
which only had the number, and Bjorn commented that decoding that was a 
bit of a pain, and that the PCI specs (which contain the bit 
definitions) isn't public.  I guess I could just add the definitions in 
the documentation if this is too verbose for sysfs.
