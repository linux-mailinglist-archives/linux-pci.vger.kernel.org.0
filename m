Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62953397F64
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 05:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhFBDUE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Jun 2021 23:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhFBDUD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Jun 2021 23:20:03 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFB7C061574;
        Tue,  1 Jun 2021 20:18:21 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id b25so1466172oic.0;
        Tue, 01 Jun 2021 20:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XYltkg0Rl60rTywHm30D8lALw21Jo1Hm0eiM0y/6fLc=;
        b=FgCi/wZmrfRBsfFvJqyOoSCujg3b38U1LBCwLCDf1LaCtPnwph2nHp7OLW0KQUm+19
         cF0fmTezuVi27qbtSCOfqx1VeTh/KFpRA+6PhOFxHnV6nUIIsb0C7UXC8Y+I9PeBhNnl
         KPfsBoF9Yac9FLu5BCWXokkvSBt0gy2bii3EjYMAvP0KckJNPluQWcNJ1Cldv091OiBK
         SU361M6F/ibK4YLe4wA3TjQiTDyxM+5nR75gNnYr0ZXZvKRmtTOkIH8yQvZ2eKKWYiOZ
         1jeDDgC32eO2PsquQQOVksM7QLX16/TXkPeQvli5ohYeQmOCHDp3sNH5/3AP83oQlG4V
         Cr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XYltkg0Rl60rTywHm30D8lALw21Jo1Hm0eiM0y/6fLc=;
        b=uhtMSsfcaJz7PyTeI26p62MdU4QasLfXUYitNfkeMuS8aNhPYeIICw6b21BiU9YSgE
         dVt/yD+Z7MymCG4fhCz706/cNi2ihfTmVCcosYk3kW2Da8lGsnL27RHyEEgEyv1B1jYz
         iY3KV2x9yJOofHPkPjhOy8Fohgl+bApz92dgPCKsiB5Ql96qdcu2SVhxswLEi6uxVs2c
         MjsOzhNZeUaBN2zHzcG0UHcWWtItJgEkUJ7X43pm0VdgxdeU86uXdevoN4TnkCNkQfzQ
         9nZWBypcEC+anC9imWq7QiT9d70omtoIf+Q2+5h1ECQWyT4O4W+9MTmgEAxjGz8ujGJs
         T4zQ==
X-Gm-Message-State: AOAM530SIBWBfQEgSZdJPajxJ26mcKaWflv6/5qOyDYjvRPaGvJfV0HZ
        t8xPI01wfB4WWdzEQ6FHacallYalV6s=
X-Google-Smtp-Source: ABdhPJz3CDH35B6VguWgQci4QsulrX0olCD3AKuuNFdOg8Zq+ogecwA6yFxBsStWOzOP+9piCzQk6Q==
X-Received: by 2002:a05:6808:8cb:: with SMTP id k11mr2186870oij.103.1622603899656;
        Tue, 01 Jun 2021 20:18:19 -0700 (PDT)
Received: from ?IPv6:2603:8081:2802:9dfb:49b3:8e2:3d6d:26c8? (2603-8081-2802-9dfb-49b3-08e2-3d6d-26c8.res6.spectrum.com. [2603:8081:2802:9dfb:49b3:8e2:3d6d:26c8])
        by smtp.gmail.com with ESMTPSA id t39sm3736693ooi.42.2021.06.01.20.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 20:18:19 -0700 (PDT)
Subject: Re: [PATCH v2] Add support for PCIe SSD status LED management
To:     Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, kw@linux.com,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
References: <20210601203820.3647-1-stuart.w.hayes@gmail.com>
 <3d1272b8-4edc-f2b1-85ea-f5cea65b4871@infradead.org>
 <20210601223812.GA5128@amd>
From:   stuart hayes <stuart.w.hayes@gmail.com>
Message-ID: <6ee11975-fad7-1a82-f7f3-279ebd4f67cb@gmail.com>
Date:   Tue, 1 Jun 2021 22:18:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210601223812.GA5128@amd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/1/2021 5:38 PM, Pavel Machek wrote:
> Hi!
> 
>>>   # echo "ok locate" >/sys/class/leds/0000:88:00.0::drive_status/states
>>>   # cat /sys/class/leds/0000:88:00.0::drive_status/states
> 
> This has two problems: ":" already has special meaning in LED name,
> and we'd prefer not to have new "states" interface unless absolutely
> neccessary.
> 

Regarding the ":"s in the LED name: I didn't specify the name 
"0000:88:00.0"--that's just the name of the parent device of the 
led_classdev, so it used that by default.  I'm not really sure what to 
do here.  I could check the device name and replace the ":" with 
something else like "_".  Would it break anything to have extra ":" 
characters in the name?  If so, maybe led_classdev_register() should 
check for ":" in the name and rename it somehow, like it does when it 
finds duplicate names?

As for the "states" interface:  I don't disagree that it isn't ideal to 
have a new "states" interface, but I have struggled to come up with 
anything better.  I guess the only alternative to having a new attribute 
or attributes would be to create up to ten LED classdev devices--one for 
each state supported by the device.  I did seriously consider this, and 
even started to do it that way, but I decided not to for several 
reasons:  (1) it would clutter /sys/class/leds, (2) it would require 
reads and writes to multiple files to change the states, (3) it would be 
more cumbersome for the driver, and (4) it would be a bit slower, 
because, if, say, ledmon wanted to set certain states, it would probably 
just write to the brightness attribute of each of the LEDs, which would 
cause the _DSM would get run for each write, instead of just once.  And 
the _DSM runs IPMI commands, at least on my system, so it is slow...

But, I'm definitely OK rewriting this to register one led_classdev for 
each possible state if that's the better way to do this.


>>>   [ok] [locate] failed rebuild pfa hotspare ica ifa invalid disabled
> 
> So what does this do? Turns the LED on if driver is in "ok" or
> "locate" states?
> 

This would cause the system to somehow show the user that that this 
drive (or drive slot) is the one that it wants a person to be able to 
physically locate (possibly by flashing a blue LED on/near the drive), 
and also that the drive is OK.  It would presumably do that by lighting 
the LEDs on/near the drive with certain colors and/or flashing patterns, 
though it could, in theory, put "OK" in an LCD on the drive slot.  How 
the states are displayed to the user is beyond the scope of the specs.

(The _DSM and NPEM specs provide for a way to control status LEDs on a 
drive or drive slot.  Typically drives will have 2 or 3 LEDs that are 
illuminated in different colors or flashing patterns to indicate various 
states (like those listed in IBPI / SFF-8489), though the _DSM / NPEM 
specs do not specify how the states are displayed.)


>>> +Date:		April 2021
>>> +Contact:	linux-pci@vger.kernel.org
>>> +Description:
>>> +		This attribute indicates the status states supported by a drive
>>> +		or drive slot's LEDs, as defined in the "_DSM additions for PCIe
>>> +		SSD Status LED Management" ECN to the PCI Firmware Specification
>>> +		Revision 3.2, dated 12 February 2020, and in "Native PCIe
>>> +		Enclosure Management", section 6.29 of the PCIe Base Spec 5.0.
>>> +
>>> +		Only supported states will be shown, and the currently active
>>> +		states are shown in brackets.  The active state(s) can be written
>>> +		by echoing a space or comma separated string of states to this
>>> +		attribute.  For example:
>>> +
>>> +		# echo "ok locate" >/sys/class/leds/0000:88:00.0::drive_status/states
>>> +		# cat /sys/class/leds/0000:88:00.0::drive_status/states
>>> +		[ok] [locate] failed rebuild pfa hotspare ica ifa
> 
> This goes against "one value per file", really needs better
> description, and probably needs different interface.
> 

This is very similar to how the available I/O schedulers and currently 
selected I/O scheduler is displayed in (for example) 
/sys/block/sda/queue/scheduler.  The only difference is that more than 
one state can be active on the LEDs, while only a single I/O scheduler 
can be selected at a time.

Both Bjorn Helgaas and Krzysztof Wilczyński had suggested the 
scheduler-type interface, so I went with that.  In an earlier attempt at 
this driver, when Bjorn suggested this, he asked if that would violate 
the "one value per file" rule, and Greg K-H responded "That's a valid 
way of displaying options for a sysfs file that can be specific unique 
values."

(I'm not devoted to this interface, but I can't think of anything 
better.  I initially had this as simply a number, with the states 
defined in the _DSM/NPEM specs, but Bjorn suggested that was a pain to 
interpret, especially because the PCI specs aren't public.  My second 
try, I used a really verbose output copied from acpi's 
"debug_layer"--that still used numbers, but defined them... I didn't 
much like it, nor did several others who responded, which is why I went 
with this interface.)

>>> +config PCIE_SSD_LEDS
>>> +	tristate "PCIe SSD status LED support"
>>> +	depends on ACPI && NEW_LEDS
>>
>> I expect that should be LEDS_CLASS instead of NEW_LEDS.
>> Did you test it with NEW_LEDS=y and LEDS_CLASS not set?
>>
>>
>> [adding Pavel and linux-leds m.l. for other review]
> 
> Thank you!
> 							Pavel
> 							
> 

Thanks!
