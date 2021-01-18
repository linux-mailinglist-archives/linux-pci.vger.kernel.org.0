Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE572F9AEC
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jan 2021 09:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733275AbhARIBy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jan 2021 03:01:54 -0500
Received: from halon.esss.lu.se ([194.47.240.54]:51669 "EHLO halon.esss.lu.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387454AbhARIBX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Jan 2021 03:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ess.eu; s=dec2019;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:from;
        bh=/X+4LJFqCFMNci3R18Nz3EMSoC4YxZYZwWhpCgzuMMc=;
        b=G8IRjwhr9ZdlAtS/Xcs7VfwBm3jH/0QpzI2dkpMQnnEFW4cKhprkIW0orvKmJb1ImUQxlfC57L3DN
         Ezrp8l5g12EwDysPdg7IGhNp7pwHzP5kdabHoqRcBWJcQuvf/0eIKbZ03f4K0yE79R7mGkzUWCDLIZ
         oPZCcnsBq8Mr8xa2+rhxuW8IfloRh5nzdglJwMaGq1L0mbnzSWcobhOxLoXuWq1J5eDVQXpLGDKw20
         kisXNjRH7NB8235I/hf++uUwH/FeLVT15t2fs/c2oQwoUw2U2q8L8ndIIV0a5ery1D+4NMvd/ZxiXK
         YC6NaGSM9A/kYvfddgl7GxODIkZdWeA==
Received: from mail.esss.lu.se (it-exch16-4.esss.lu.se [10.0.42.134])
        by halon.esss.lu.se (Halon) with ESMTPS
        id 3d3f66c2-5963-11eb-93c8-005056a66d10;
        Mon, 18 Jan 2021 09:00:32 +0100 (CET)
Received: from [192.168.0.6] (194.47.241.248) by it-exch16-4.esss.lu.se
 (10.0.42.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 18 Jan
 2021 09:00:34 +0100
Subject: Re: [PATCHv2 0/5] aer handling fixups
To:     Keith Busch <kbusch@kernel.org>
CC:     "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <B31F8CA9-D62B-4488-B4C1-EB31E9117203@intel.com>
 <20210107214236.GA1284006@dhcp-10-100-145-180.wdc.com>
 <70f2288d-2d1e-df82-d107-e977e1f50dca@ess.eu>
 <c3117c51-144f-ae59-ad68-bdc5532d12cb@ess.eu>
 <20210111163708.GA1458209@dhcp-10-100-145-180.wdc.com>
 <6783d09d-1431-15fd-961e-3820b14e001e@ess.eu>
 <20210111220951.GA1472929@dhcp-10-100-145-180.wdc.com>
 <ed8256dd-d70d-b8dc-fdc0-a78b9aa3bbd9@ess.eu>
 <20210112192758.GB1472929@dhcp-10-100-145-180.wdc.com>
 <8650281b-4430-1938-5d45-53f09010497b@ess.eu>
 <20210112231744.GB1508433@dhcp-10-100-145-180.wdc.com>
From:   Hinko Kocevar <hinko.kocevar@ess.eu>
Message-ID: <008a7051-dbad-abd2-6cf8-52433f453b42@ess.eu>
Date:   Mon, 18 Jan 2021 09:00:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210112231744.GB1508433@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [194.47.241.248]
X-ClientProxiedBy: it-exch16-3.esss.lu.se (10.0.42.133) To
 it-exch16-4.esss.lu.se (10.0.42.134)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/13/21 12:17 AM, Keith Busch wrote:
> On Tue, Jan 12, 2021 at 11:19:37PM +0100, Hinko Kocevar wrote:
>> I feel inclined to provide a little bit more info about the system I'm
>> running this on as it is not a regular PC/server/laptop. It is a modular
>> micro TCA system with a single CPU and MCH. MCH and CPU are separate cards,
>> as are the other processing cards (AMCs) that link up to CPU through the MCH
>> PEX8748 switch. I can power each card individually, or perform complete
>> system power cycle. The normal power up sequence is: MCH, AMCs, CPU. The CPU
>> is powered 30 sec after all other cards so that their PCIe links are up and
>> ready for Linux.
>>
>> All buses below CPU side 02:01.0 are on MCH PEX8748 switch:
>>
>> [dev@bd-cpu18 ~]$ sudo /usr/local/bin/pcicrawler -t
>> 00:01.0 root_port, "J6B2", slot 1, device present, speed 8GT/s, width x8
>>   ├─01:00.0 upstream_port, PLX Technology, Inc. (10b5), device 8725
>>   │  ├─02:01.0 downstream_port, slot 1, device present, power: Off, speed 8GT/s, width x4
>>   │  │  └─03:00.0 upstream_port, PLX Technology, Inc. (10b5) PEX 8748 48-Lane, 12-Port PCI Express Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (8748)
>>   │  │     ├─04:01.0 downstream_port, slot 4, power: Off
>>   │  │     ├─04:03.0 downstream_port, slot 3, power: Off
>>   │  │     ├─04:08.0 downstream_port, slot 5, power: Off
>>   │  │     ├─04:0a.0 downstream_port, slot 6, device present, power: Off, speed 8GT/s, width x4
>>   │  │     │  └─08:00.0 endpoint, Xilinx Corporation (10ee), device 8034
>>   │  │     └─04:12.0 downstream_port, slot 1, power: Off
>>   │  ├─02:02.0 downstream_port, slot 2
>>   │  ├─02:08.0 downstream_port, slot 8
>>   │  ├─02:09.0 downstream_port, slot 9, power: Off
>>   │  └─02:0a.0 downstream_port, slot 10
>>   ├─01:00.1 endpoint, PLX Technology, Inc. (10b5), device 87d0
>>   ├─01:00.2 endpoint, PLX Technology, Inc. (10b5), device 87d0
>>   ├─01:00.3 endpoint, PLX Technology, Inc. (10b5), device 87d0
>>   └─01:00.4 endpoint, PLX Technology, Inc. (10b5), device 87d0
>>
>>
>> The lockups most frequently appear after the cold boot of the system. If I
>> restart the CPU card only, and leave the MCH (where the PEX8748 switch
>> resides) powered, the lockups do *not* happen. I'm injecting the same error
>> into the root port and the system card configuration/location/count is
>> always the same.
>>
>> Nevertheless, in rare occasions while booting the same kernel image after
>> complete system power cycle, no lockup is observed.
>>
>> So far I observed that the lockups seem to always happen when recovery is
>> dealing with the 02:01.0 device/bus.
>>
>> If the system recovers from a first injected error, I can repeat the
>> injection and the system recovers always. If the first recovery fails I have
>> to either reboot the CPU or power cycle the complete system.
>>
>> To me it looks like this behavior is somehow related to the system/setup I
>> have, and for some reason is triggered by VC restoration (VC is not is use
>> by my system at all, AFAIK).
>   
>> Are you able to tell which part of the code the CPU is actually spinning in
>> when the lockup is detected? I added many printk()s in the
>> pci_restore_vc_state(), in the AER IRQ handler, and around to see something
>> being continuously printed, but nothing appeared..
> 
> It sounds like your setup is having difficulting completing config
> cycles timely after a secondary bus reset. I don't see right now how
> anything I've provided in this series is causing that.
> 
> All the stack traces you've provided so far are all within virtual
> channel restoration. Subsequent stack traces are never the same though,
> so it does not appear to be permanently stuck; it's just incredibly
> slow. This particular capability restoration happens to require more
> config cycles than most other capabilities, so I'm guessing it happens
> to show up in your observation because of that rather than anything
> specific about VC.
> 
> The long delays seem like a CTO should have kicked in, but maybe your
> hardware isn't doing it right. Your lspci says Completion Timeout
> configuration is not supported, so it should default to 50msec maximum,
> but since it's taking long enough to trigger a stuck CPU watchdog, and
> you appear to be getting valid data back, it doesn't look like CTO is
> happening.
> 

Some very good new (and some little less good).

The good news is that after recompiling the latest PCI GIT kernel 
source, with heavily stripped down config (without any extras and 
modules), I do *not* see the lockups any more. Up to now I've been using 
CentOS7 bloated stock config from stock kernel to compile git sources.

The not so good news is that I'm not sure what exactly solved the issue 
for me; it seems to be config related. I've also been touching some 
other system settings, outside the Linux. Otherwise my HW configuration 
has not changed. I performed the same test steps that previously 
resulted in lockups and none were seen so far. I'm looking into what 
exactly might have been causing the issues.

With that being said, I believe that this patch series is working for my 
system and the issues reported were related to my system mis-configuration.


Thank you again!

