Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316CF38F359
	for <lists+linux-pci@lfdr.de>; Mon, 24 May 2021 20:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhEXS6K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 14:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbhEXS6K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 May 2021 14:58:10 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E2BC061574
        for <linux-pci@vger.kernel.org>; Mon, 24 May 2021 11:56:41 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id u11so27965043oiv.1
        for <linux-pci@vger.kernel.org>; Mon, 24 May 2021 11:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aDD62k/rknLh3GG3vsjBiYh3bOE3f8mcAWe4r5l2RDM=;
        b=F7iiz/WxGUP1vJ7oFzCzQdPW8mpCz1eINAlFhhEDwdKpk18Fl8dLdGB7hkL3iu6v+4
         wd9N4wYvyrKn696TCcEzPJrf5YKMfQxxcqrNX0prVa/6PX0u+IrD8T3kHD0cqguPZvEg
         uzbRW97W2cXt0ZsJhNZmGZUzVsrEVaxAWkgejx1cWHv9qyJGNj4n4hRVQA06oFEE1G6n
         33D9rGJEvJNwy0ygwAchxMIgJ99O8CyRxq/chBYUXSpv1+AyXqitOyGkzxnnOZ4Ga+wo
         qTIe+MRHTvkJBz1fMEFvGi4hjVqCFKzl02TKObUUEkPA+IsnjzD513CHSfZR6j5sGvyM
         MuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aDD62k/rknLh3GG3vsjBiYh3bOE3f8mcAWe4r5l2RDM=;
        b=dsuUnPLd+N/xh07aPA3GiWEPNXyFtqkBtxzQTn9oVakrSwhOkBhXm57e/gL/HCuh9W
         kEnBMcYZH0REF2wK0+ju28r1KGdMk6BmUG0ia47TfFhSMsr1GSvs+AbtZ7h1YUPPkOSn
         O+kX0PrXzLtnZZgIkuhmUS/vKZ6tv5StT7Ln7enh2Y8SsiKecNj36O1Eib2dl22hEJGt
         aCDTAD0hLnmF/MFdm+ozACIqkjl9B9VT97YXMAlxKQ63CKNpdVVRWShox+xgXN7nyvWX
         CTScanNB5NYsv7yh39mAn5+bHrE5KC7Qd7QNY/t2FpXun3uuYcfuGfe7bwubO3x9NiVd
         y0YQ==
X-Gm-Message-State: AOAM530BygsIV10J+/t1YZhQaJhmIpUnXvkMagi8LbscQhW9ugdmvu5V
        wW4W/PsGGFp+bU/2+4jB4mH3y8uEBQE=
X-Google-Smtp-Source: ABdhPJzVEL0ueLb7b8e3Zlmg4mIn8pD2fSnozNptd2uo9BvW2iRIp8FCFM224RC9E47yyZ4uPjgG4w==
X-Received: by 2002:a54:400a:: with SMTP id x10mr387363oie.158.1621882600168;
        Mon, 24 May 2021 11:56:40 -0700 (PDT)
Received: from ?IPv6:2603:8081:2802:9dfb:49b3:8e2:3d6d:26c8? (2603-8081-2802-9dfb-49b3-08e2-3d6d-26c8.res6.spectrum.com. [2603:8081:2802:9dfb:49b3:8e2:3d6d:26c8])
        by smtp.gmail.com with ESMTPSA id s24sm3020275ooh.28.2021.05.24.11.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 11:56:39 -0700 (PDT)
Subject: Re: [PATCH] Add support for PCIe SSD status LED management
From:   stuart hayes <stuart.w.hayes@gmail.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20210416192010.3197-1-stuart.w.hayes@gmail.com>
 <20210505161228.GC912679@dhcp-10-100-145-180.wdc.com>
 <CAL5oW00Pmnhqi1KZ9-jqFwLXQWBO0ddCyv+dr6qkry7iqZNQsw@mail.gmail.com>
Message-ID: <6df225c1-0641-87f3-cca7-63cbeeb191ed@gmail.com>
Date:   Mon, 24 May 2021 13:56:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAL5oW00Pmnhqi1KZ9-jqFwLXQWBO0ddCyv+dr6qkry7iqZNQsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/17/2021 3:01 PM, Stuart Hayes wrote:
> 
> 
> On 5/5/2021 11:12 AM, Keith Busch wrote:
>> On Fri, Apr 16, 2021 at 03:20:10PM -0400, Stuart Hayes wrote:
>>> This patch adds support for the PCIe SSD Status LED Management
>>> interface, as described in the "_DSM Additions for PCIe SSD Status LED
>>> Management" ECN to the PCI Firmware Specification revision 3.2.
>>>
>>> It will add a single (led_classdev) LED for any PCIe device that has the
>>> relevant _DSM. The ten possible status states are exposed using
>>> attributes current_states and supported_states. Reading current_states
>>> (and supported_states) will show the definition and value of each bit:
>>
>> There is significant overlap in this ECN with the PCIe native enclosure
>> management (NPEM) capability. Would it be possible for the sysfs
>> interface to provide an abstraction such that both these implementations
>> could subscribe to?
>>   
> 
> It wouldn't be too hard to check for the NPEM capability here and
> provide access to it as well (or it could be added on later without too
> much trouble), but it looks like NPEM support is already implemented in
> user space (in ledmon).  (I only wrote a kernel module for this, because
> it uses a _DSM which can't readily be accessed in user space.)
> 
> 

I've reworked the driver a bit, so it would be very easy to separate it 
into two parts:

  * a generic drive status LED driver/module (in drivers/leds??) that 
would handle creating the struct led_classdev and sysfs interface to it

  * a PCIe drive status LED driver/module that checks PCI devices for 
_DSM or NPEM support, and calls the generic drive status LED 
driver/module to create an LED when it finds a device that supports it.

My code only supports _DSM, as I don't have any hardware to test NPEM 
on, but it would be very simple to add NPEM support (much more so than 
in the patch I sent in this thread).

I'm not sure if it is worth splitting the code into two pieces, 
though... I don't know if anything other than NPEM or the _DSM would 
bother to use this, and I think those make more sense in a single module 
because they are so similar (the _DSM method was created as a way to do 
the same thing as NPEM but without hardware support, and they need the 
same code for scanning and detecting added/removed devices).

Maybe I should just leave this all in one file for now, and it could be 
split later if anyone wanted to add support for SES or some other method 
in the future?


>>>> cat /sys/class/leds/0000:88:00.0::pcie_ssd_status/supported_states
>>> ok                              0x0004 [ ]
>>> locate                          0x0008 [*]
>>> fail                            0x0010 [ ]
>>> rebuild                         0x0020 [ ]
>>> pfa                             0x0040 [ ]
>>> hotspare                        0x0080 [ ]
>>> criticalarray                   0x0100 [ ]
>>> failedarray                     0x0200 [ ]
>>> invaliddevice                   0x0400 [ ]
>>> disabled                        0x0800 [ ]
>>> --
>>> supported_states = 0x0008
>>
>> This is quite verbose for a sysfs property. The common trend for new
>> properties is that they're consumed by programs as well as humans, so
>> just ouputing a raw number should be sufficient if the values have a
>> well defined meaning.
>>

I was able to rework this so it uses a scheduler type of output and 
eliminate the numbers, since the PCI specs are not public (and methods 
other than NPEM/_DSM might use different numbers).  It only needs a 
single attribute "states", which shows all supported states, and has 
brackets on the ones that are active.. for example:

[ok] [locate] fail rebuid ica ifa

To set multiple states, just echo the states separated by spaces or commas:

echo "locate ica" > states

(I renamed criticalarray and failedarray to ica and ifa to match 
ledmon's state names).

Does this seem better?


Thanks!
