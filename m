Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DBC39C113
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 22:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhFDUPi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 16:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhFDUPh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jun 2021 16:15:37 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF5EC061766;
        Fri,  4 Jun 2021 13:13:50 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id c13so5376780oib.13;
        Fri, 04 Jun 2021 13:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GNIP2E9Y17WX5odCp6pSIWeB8hYte14N21aaHy4aaAM=;
        b=QhdJG8rKHOByonQLCjLvbSpB3b++5s0iLJgu0CgWSvrndw6VmLexNawjivpUbC3M68
         I1ybrM/+zO8mDAQ2EKzVd6bj3coOv1UGSnETMyoIBAEzIzyYOzHG5RGjXQuJWT7B6TAn
         +ZRdDwv4XLVmL+TtDaIxHIxWji1lS5PcogGB04N4VekrIN9ah13BhufCloqWd2oAyhTL
         8sIqZ20XUZz/fBIcjflVFPbmrHZ0s5zFis+/bnQ8ToA3NIcKoxWkk/lRUoc6U8yoVvL8
         1hruqlCw+6UBHzcCJrTTTOAzGZnu4+X+bxuG0rIgoCTE1GEjrIXVYePmSyGsVBGgWKS6
         NZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GNIP2E9Y17WX5odCp6pSIWeB8hYte14N21aaHy4aaAM=;
        b=rYUqoqun2lvJ88fTVuUqBxJU/kQ5tkwkALQyHqmZo9lVpkEEUDUJF1npyVGrZvNWjo
         UZ6Vx+f6lFWR+IMzjmyhNPxFPN0xgsVQ7/kUUpoMyxXhIWM9VjKrFix+i1yhZivQXI0K
         vUteG8CoIDvFTuSesFwcliJ0Z0m7JkJPdcW7H+dLnI5MuKFWB5M2xyx0gBaoMobxXtvB
         3RdOXqm75xClT3K+TrF93oIg835dHiH/IUgFEp04e746qQNKdu7UznHw80o7kXAJGLHf
         1SbxsNQLa7AFSsANhG2cxO1+9fiy7KW21lqtOvB4yKWdHCB23+fsrh8hEvWN5XWP2k/6
         SpoQ==
X-Gm-Message-State: AOAM532X3h18P62MVJBODIlqXFPzWpvRmREAtjShI417Pb1ngYH+OGO/
        OTah1YwutB3tF5D5+P5IbaMTpycKRS8=
X-Google-Smtp-Source: ABdhPJzYjgFgx1LNaK2Z6O01RJx5AU7TltE2+15v2LyKupY/BGEZLFIHfngafZuPSXSdiIJ5j8/maA==
X-Received: by 2002:aca:dfd4:: with SMTP id w203mr4233796oig.47.1622837629312;
        Fri, 04 Jun 2021 13:13:49 -0700 (PDT)
Received: from ?IPv6:2603:8081:2802:9dfb:49b3:8e2:3d6d:26c8? (2603-8081-2802-9dfb-49b3-08e2-3d6d-26c8.res6.spectrum.com. [2603:8081:2802:9dfb:49b3:8e2:3d6d:26c8])
        by smtp.gmail.com with ESMTPSA id x31sm689266ota.24.2021.06.04.13.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 13:13:48 -0700 (PDT)
Subject: Re: [PATCH v2] Add support for PCIe SSD status LED management
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, kw@linux.com,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
References: <20210601203820.3647-1-stuart.w.hayes@gmail.com>
 <3d1272b8-4edc-f2b1-85ea-f5cea65b4871@infradead.org>
 <20210601223812.GA5128@amd> <6ee11975-fad7-1a82-f7f3-279ebd4f67cb@gmail.com>
 <20210602090504.GA10900@amd> <552ca26f-c7ab-3496-743f-f95e80eb578b@gmail.com>
 <20210602224059.GA19673@duo.ucw.cz>
From:   stuart hayes <stuart.w.hayes@gmail.com>
Message-ID: <09f731e7-40c8-9087-adb1-e996e08871a2@gmail.com>
Date:   Fri, 4 Jun 2021 15:13:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602224059.GA19673@duo.ucw.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/2/2021 5:40 PM, Pavel Machek wrote:
> Hi!
> 
>>>> This would cause the system to somehow show the user that that this drive
>>>> (or drive slot) is the one that it wants a person to be able to physically
>>>> locate (possibly by flashing a blue LED on/near the drive), and also that
>>>> the drive is OK.  It would presumably do that by lighting the LEDs on/near
>>>> the drive with certain colors and/or flashing patterns, though it could, in
>>>> theory, put "OK" in an LCD on the drive slot.  How the states are displayed
>>>> to the user is beyond the scope of the specs.
>>>>
>>>> (The _DSM and NPEM specs provide for a way to control status LEDs on a drive
>>>> or drive slot.  Typically drives will have 2 or 3 LEDs that are illuminated
>>>> in different colors or flashing patterns to indicate various states (like
>>>> those listed in IBPI / SFF-8489), though the _DSM / NPEM specs do not
>>>> specify how the states are displayed.)
>>>
>>> Well, LED subsystem expects to know how many LEDs are there and what
>>> the LEDs are, and expects individual control over them.
>>>
>>> "2 or 3 LEDs with unknown patterns", or LCD display is outside of scope
>>> of LED subsystem, so this should be independend.
> 
>>
>> Yes... I had originally submitted this without using the LED subsystem, and
>> Greg K-H said I had to (see
>> https://www.spinics.net/lists/linux-pci/msg102013.html).  Here's the
>> relevant bit.
> 
> ...
> 
>> So I'm not sure what to do.
> 
> Explain to Greg that you don't know how particular system implements
> the indication. It can be small display, 2 LEDs, 3 LEDs, etc... LED
> subsystem expects direct LED control.
> 
> Best regards,
> 								Pavel
> 

Is there any chance you would accept drive status LEDs using the LED 
subsystem, if the driver was rewritten to represent each possible drive 
state as a single led_classdev device, each with no special attributes, 
just brightness of 0 or 1?

The drive states are logically each displaying one bit of information to 
the user, and each could actually be physically represented by a 
physical LED (though probably not).  I only combined them into a single 
led_classdev device with an extra attribute because I thought it made 
more sense to do so, but it sounds like I might have made a bad choice 
in doing so.

In support of using the LED subsystem for this--there are other LEDs in 
linux which aren't necessarily always represented by single physical 
LEDs, such as "caps lock" for keyboards.  Virtual consoles display 
keyboard indicators as text in a window rather than an LED--and someone 
_could_ make a weird keyboard that displays the 3 bits of 
caps/scroll/number lock info as a decimal number on a display.  My point 
is that it seems to me that the LED subsystem is already being used for 
things that logically display a bit of information to the user, which 
may or may not be represented by a single LED.  (Ethernet port LEDs are 
another possible example--they might combine link present, link speed, 
and activity all on one LED, by using different colors and flashing 
patterns.)

