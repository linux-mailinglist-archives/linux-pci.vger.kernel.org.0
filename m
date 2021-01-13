Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D7D2F5499
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 22:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbhAMV3s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jan 2021 16:29:48 -0500
Received: from halon.esss.lu.se ([194.47.240.54]:12561 "EHLO halon.esss.lu.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729131AbhAMV2t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Jan 2021 16:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ess.eu; s=dec2019;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:to:subject:from;
        bh=O1B7NYN3uJwWqPKw2mE7UxrsEioPERPl3yB6ASaVYVw=;
        b=tkAQt+zBUqx058cmBBjs6dUZWg4hqUMyZ3twmPzU/Hdl4BDpDGgA8gl7UUIF5mWQJ4I4mAsljMTql
         p4L5MWrbDYMzDv7vi2IFREfqKGGr0VGNcUpahlPqOd6Ghz7U6x253EWQLNRMIo88nYXFRQowe0qfg4
         YsPJrEIzy+xdQdQBDxRS9by7hJHbs/tBoGXxiAZlRl7RlFUJ3WGMULKawjgEhGw36WeLHg+95bm3ek
         sDyIFoM2MiaSXK2X4lC8UDIsFaq1//GPSyBA/YJKPH8OF+VmhWGRscUq3KVBCzdn1aHRU7CLCEjZ4u
         KU5solBnMzudhaxTbQhsUDAQNACzcyg==
Received: from mail.esss.lu.se (it-exch16-4.esss.lu.se [10.0.42.134])
        by halon.esss.lu.se (Halon) with ESMTPS
        id 21631d44-55e6-11eb-93c8-005056a66d10;
        Wed, 13 Jan 2021 22:27:25 +0100 (CET)
Received: from [192.168.0.6] (194.47.241.248) by it-exch16-4.esss.lu.se
 (10.0.42.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 13 Jan
 2021 22:27:30 +0100
Subject: Re: /proc/iomem and /proc/ioports show 0 for address range
To:     Randy Dunlap <rdunlap@infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>
References: <375ef4e6-b9a1-d4f2-81b6-582f2152820d@ess.eu>
 <ae1da3a0-11d3-b1dd-601c-3169e783fcb4@infradead.org>
From:   Hinko Kocevar <hinko.kocevar@ess.eu>
Message-ID: <a1a5dcd9-de5f-46ea-10fe-b81693277ed5@ess.eu>
Date:   Wed, 13 Jan 2021 22:27:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <ae1da3a0-11d3-b1dd-601c-3169e783fcb4@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [194.47.241.248]
X-ClientProxiedBy: it-exch16-4.esss.lu.se (10.0.42.134) To
 it-exch16-4.esss.lu.se (10.0.42.134)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/13/21 7:45 PM, Randy Dunlap wrote:
> On 1/13/21 2:29 AM, Hinko Kocevar wrote:
>> [I noticed this while working on PCI devices; not sure which kernel list would be best for this, though]
>>
>> I noticed that my system shows address range for iomem and ioports as all 0. Sometimes (after a power cycle) the addresses are proper, albeit I have not been able to see that in a while now, after performing numerous reboots in the last coupe of days.
>>
>> FWIW, I think the list of devices (names, count) looks the same in both cases. The system seems to work in both cases; at least I have not seen any complaints in kernel logs, OTOH, not sure what the error message would be.
>>
>> What may be the reason for not getting the proper addresses listed?
> 
> config STRICT_DEVMEM
> 	bool "Filter access to /dev/mem"
> 
> and
> 
> config IO_STRICT_DEVMEM
> 	bool "Filter I/O access to /dev/mem"
> 
> so what are your CONFIG_STRICT_DEVMEM and CONFIG_IO_STRICT_DEVMEM set to?

Yeah, they're set. Did not notice that since I'm using some CentOS stock 
config.

> 
> What do you see in /proc/iomem and /proc/ioports if you are admin/root?
> That should be non-zero values.

You are right. Using sudo shows the values.

Thanks!

> 
>> This likely poses any issues for userspace tools that would look at those /proc files, OTOH, I wonder if would kernel suffer in any way as well?
> 
> Yes, it could affect userspace.
> 
>> Kernel version is 5.10.0 (pci git tree).
>>
>> [dev@bd-cpu18 ~]$ cat /proc/iomem
>> 00000000-00000000 : Reserved
>> 00000000-00000000 : System RAM
>> 00000000-00000000 : Reserved
>> 00000000-00000000 : PCI Bus 0000:00
>> 00000000-00000000 : Video ROM
>> 00000000-00000000 : Reserved
>>    00000000-00000000 : System ROM
>> 00000000-00000000 : System RAM
>>    00000000-00000000 : Kernel code
>>    00000000-00000000 : Kernel rodata
>>    00000000-00000000 : Kernel data
>>    00000000-00000000 : Kernel bss
> 
> 
