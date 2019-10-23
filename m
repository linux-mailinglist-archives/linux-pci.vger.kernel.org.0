Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB36E1413
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 10:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390275AbfJWIYh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Oct 2019 04:24:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4709 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732361AbfJWIYh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 04:24:37 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7545AC6B1BB05781A2B9;
        Wed, 23 Oct 2019 16:24:34 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 16:24:30 +0800
Subject: Re: [PATCH] PCI: Warn about host bridge device when its numa node is
 NO_NODE
To:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhocko@kernel.org>,
        <peterz@infradead.org>, <geert@linux-m68k.org>,
        <gregkh@linuxfoundation.org>, <paul.burton@mips.com>
References: <1571467543-26125-1-git-send-email-linyunsheng@huawei.com>
 <20191019083431.GA26340@infradead.org>
 <96b8737d-5fbf-7942-bf10-7521cf954d6e@huawei.com>
 <e35bd451-bdb7-ec02-d691-aa3720d1e10b@arm.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <26918051-66bb-b27e-2ce1-7339499c5da2@huawei.com>
Date:   Wed, 23 Oct 2019 16:24:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <e35bd451-bdb7-ec02-d691-aa3720d1e10b@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019/10/22 21:55, Robin Murphy wrote:
> On 21/10/2019 05:05, Yunsheng Lin wrote:
>> On 2019/10/19 16:34, Christoph Hellwig wrote:
>>> On Sat, Oct 19, 2019 at 02:45:43PM +0800, Yunsheng Lin wrote:
>>>> +    if (nr_node_ids > 1 && dev_to_node(bus->bridge) == NUMA_NO_NODE)
>>>> +        dev_err(bus->bridge, FW_BUG "No node assigned on NUMA capable HW by BIOS. Please contact your vendor for updates.\n");
>>>> +
>>>
>>> The whole idea of mentioning a BIOS in architeture indepent code doesn't
>>> make sense at all.
> 
> [ Come to think of it, I'm sure an increasing number of x86 firmwares don't even implement a PC BIOS any more... ]
> 
> In all fairness, the server-class Arm-based machines I've come across so far do seem to consistently call their EFI firmware images "BIOS" despite the clear anachronism. At least the absurdity of conflating a system setup program with a semiconductor process seems to have mostly died out ;)
> 
>> Mentioning the BIOS is to tell user what firmware is broken, so that
>> user can report this to their vendor by referring the specific firmware.
>>
>> It seems we can specific the node through different ways(DT, ACPI, etc).
>>
>> Is there a better name for mentioning instead of BIOS, or we should do
>> the checking and warning in the architeture dependent code?
>>
>> Or maybe just remove the BIOS from the above log?
> 
> Even though there may be some degree of historical convention hanging around on ACPI-based systems, that argument almost certainly doesn't hold for OF/FDT/etc. - the "[Firmware Bug]:" prefix is hopefully indicative enough, so I'd say just drop the "by BIOS" part.

Will drop the "by BIOS" part if there is another version.
Tnanks for clarifying.

> 
> Robin.
> 
> .
> 

