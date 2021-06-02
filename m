Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F6B398ECA
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 17:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhFBPjB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 11:39:01 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:46736 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhFBPjA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jun 2021 11:39:00 -0400
Received: by mail-oi1-f177.google.com with SMTP id x15so3008674oic.13;
        Wed, 02 Jun 2021 08:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=68R+ehJgXKzqJ7OzIbC2SHlnI77KJNDQXR3Dvaq0F1k=;
        b=vSz5oD1ZyrXmzCQJrK3b3s2O5UlwBXiLrM5czkzMLhmTxvkftzwd80695vteiNOVJL
         V8xuHs6w/7NtOzeQvQ6MWM7AvRxuZX6MmxN9Tj5DQEA/kE0vQOajuNPb3qSNz9eYUilB
         e/EXlPO4KKTnjAJl5o12KcxL6egLABE+V/fYz4plhMpzA9KtLB/H1JB0DP3822TM8dkN
         IrjrqjixMdW+OhXx3hy9YFRrvD6JTgL73ypWuCmqbOaJohfEdNfV+m9phVHO9vdrKkyB
         CzUyj7YC1l/6Co5EBI1OkL+FccgMwOqiTsloVaJRtcJLyDc8kKutsdBCBXGD4s3mZNyw
         V9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=68R+ehJgXKzqJ7OzIbC2SHlnI77KJNDQXR3Dvaq0F1k=;
        b=SP83m6Kc5CkQ5+QlJwGPuOfyHKG9Dws+DEdIjYrc+LMLflUKddupBmc7QBoZfrD8Jm
         pAD0y4TPh4vW4zqxTRuvSVOex3lS2/Pgy+5NTbUVttQ169RgxCGNx5YcFnOnlhb/1Nu3
         XNqXQ1x3yHxsJejt5xEbJfjOfAUb/zXE3ZWuLo2EVREQx/wrWyavQOeBgWKQ0nbW5W07
         3IyDq8tLt1BR9r0OvLwpZO0eKhKoXCzN2cWgnwiIbAQ9LTt7hKu6ds+KRpoBzEdWRcGj
         hXZwnFpnUdC00t2IjeWB0DOiV/rtAw7ihuI6PJBGn9w9ha3hKJzhuoOYDzJ6qjrmCAy6
         80Vw==
X-Gm-Message-State: AOAM530jo6oQD5sGjBctaPfRavPgH09clkLm2G/H5ZJAxqq3iVWOfugF
        IAWAuEc3MxERaE8KmhMW6/wWPme86OQ=
X-Google-Smtp-Source: ABdhPJy5iALY5yx+nz/Iit4M+LymtcuDQc/K/yPhluot8U0NTHTfZcn8gijWfLyai4UV9xIA6Z7z3Q==
X-Received: by 2002:a05:6808:1448:: with SMTP id x8mr21955364oiv.148.1622648166456;
        Wed, 02 Jun 2021 08:36:06 -0700 (PDT)
Received: from ?IPv6:2603:8081:2802:9dfb:49b3:8e2:3d6d:26c8? (2603-8081-2802-9dfb-49b3-08e2-3d6d-26c8.res6.spectrum.com. [2603:8081:2802:9dfb:49b3:8e2:3d6d:26c8])
        by smtp.gmail.com with ESMTPSA id w7sm41820oih.42.2021.06.02.08.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 08:36:05 -0700 (PDT)
Subject: Re: [PATCH v2] Add support for PCIe SSD status LED management
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, kw@linux.com,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
References: <20210601203820.3647-1-stuart.w.hayes@gmail.com>
 <3d1272b8-4edc-f2b1-85ea-f5cea65b4871@infradead.org>
 <20210601223812.GA5128@amd> <6ee11975-fad7-1a82-f7f3-279ebd4f67cb@gmail.com>
 <20210602090504.GA10900@amd>
From:   stuart hayes <stuart.w.hayes@gmail.com>
Message-ID: <552ca26f-c7ab-3496-743f-f95e80eb578b@gmail.com>
Date:   Wed, 2 Jun 2021 10:36:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602090504.GA10900@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/2/2021 4:05 AM, Pavel Machek wrote:
> Hi!
> 
>>>>>   [ok] [locate] failed rebuild pfa hotspare ica ifa invalid disabled
>>>
>>> So what does this do? Turns the LED on if driver is in "ok" or
>>> "locate" states?
>>>
>>
>> This would cause the system to somehow show the user that that this drive
>> (or drive slot) is the one that it wants a person to be able to physically
>> locate (possibly by flashing a blue LED on/near the drive), and also that
>> the drive is OK.  It would presumably do that by lighting the LEDs on/near
>> the drive with certain colors and/or flashing patterns, though it could, in
>> theory, put "OK" in an LCD on the drive slot.  How the states are displayed
>> to the user is beyond the scope of the specs.
>>
>> (The _DSM and NPEM specs provide for a way to control status LEDs on a drive
>> or drive slot.  Typically drives will have 2 or 3 LEDs that are illuminated
>> in different colors or flashing patterns to indicate various states (like
>> those listed in IBPI / SFF-8489), though the _DSM / NPEM specs do not
>> specify how the states are displayed.)
> 
> Well, LED subsystem expects to know how many LEDs are there and what
> the LEDs are, and expects individual control over them.
> 
> "2 or 3 LEDs with unknown patterns", or LCD display is outside of scope
> of LED subsystem, so this should be independend.
> 
> Best regards,
> 								Pavel
> 

Yes... I had originally submitted this without using the LED subsystem, 
and Greg K-H said I had to (see 
https://www.spinics.net/lists/linux-pci/msg102013.html).  Here's the 
relevant bit.

(Greg K-H:)
>> > And why isn't this code using the existing LED subsystem?  Don't create
>> > random new driver-specific sysfs files that do things the existing class
>> > drivers do please.
>> >
>> 
(Me:)
>> I did consider the LED subsystem, but I don't think it is a great match.
>> >> In spite of the name, this _DSM doesn't directly control individual 
LEDs--it
>> sets the state(s) of the PCI port to which an SSD may be connected, so that
>> it may be conveyed to the user... a processor (or at least some logic) will
>> decide how to show which states are active, probably by setting combinations
>> of LEDs to certain colors or blink patterns, or possibly on some other type
>> of display.
(Greg K-H:)
> If you are allowing LEDs to be controlled by the user, then yes, you
> have to use the LED subsystem as you should never try to create a brand
> new driver-specific user/kernel API just for your tiny driver right?
> Please work with the subsystems we have, they are unified for a reason.

So I'm not sure what to do.
