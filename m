Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 713C745CB0
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 14:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfFNMWr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 08:22:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34984 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727362AbfFNMWr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 08:22:47 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 154F19C821EE6C64B89A;
        Fri, 14 Jun 2019 20:22:45 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 14 Jun 2019
 20:22:38 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v4 1/3] lib: logic_pio: Use logical PIO low-level
 accessors for !CONFIG_INDIRECT_PIO
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <1560262374-67875-1-git-send-email-john.garry@huawei.com>
 <1560262374-67875-2-git-send-email-john.garry@huawei.com>
 <20190613023947.GD13533@google.com>
 <8ef228f8-97cb-e40e-ea6b-410b80a845cf@huawei.com>
 <20190613200932.GJ13533@google.com>
 <7495dcab-f293-4b2a-4740-2249f61351f7@huawei.com>
 <20190614115056.GP13533@google.com>
CC:     <rjw@rjwysocki.net>, <wangkefeng.wang@huawei.com>,
        <lorenzo.pieralisi@arm.com>, <arnd@arndb.de>,
        <linux-pci@vger.kernel.org>, <will.deacon@arm.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <catalin.marinas@arm.com>, <andriy.shevchenko@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>
Message-ID: <4c49bf7d-f68e-0b79-f03d-03958dac640e@huawei.com>
Date:   Fri, 14 Jun 2019 13:22:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190614115056.GP13533@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/06/2019 12:50, Bjorn Helgaas wrote:
> On Fri, Jun 14, 2019 at 10:02:52AM +0100, John Garry wrote:
>> On 13/06/2019 21:09, Bjorn Helgaas wrote:
>>> On Thu, Jun 13, 2019 at 10:39:12AM +0100, John Garry wrote:
>>>> On 13/06/2019 03:39, Bjorn Helgaas wrote:
>>>>> I'm not sure it's even safe, because CONFIG_INDIRECT_PIO depends on
>>>>> ARM64,  but PCI_IOBASE is defined on most arches via asm-generic/io.h,
>>>>> so this potentially affects arches other than ARM64.
>>>>
>>>> It would do. It would affect any arch which defines PCI_IOBASE and
>>>> does not have arch-specific definition of inb et all.
>>
>>> What's the reason for testing PCI_IOBASE instead of
>>> CONFIG_INDIRECT_PIO?  If there's a reason it's needed, that's fine,
>>> but it does make this much more complicated to review.
>>
>> For ARM64, we have PCI_IOBASE defined but may not have
>> CONFIG_INDIRECT_PIO defined. Currently CONFIG_INDIRECT_PIO is only
>> selected by CONFIG_HISILICON_LPC.
>>
>> As such, we should make this change also for when
>> CONFIG_INDIRECT_PIO is not defined.

Hi Bjorn,

>
> OK.  This is all very important for the commit log -- we need to
> understand what arches are affected and the reason they need it.

Right, and to repeat, this would affect other archs which define 
PCI_IOBASE and don't have custom IO port accessors definitions.

There are a few remaining even after the recent arch clear out . I have 
it at arm64, microblaze, and unicore32. Arch m68k defines PCI_IOBASE but 
seems to have its own IO port accessors. Same again for some arm machines.

At least I should cc those arch maintainers.

>
> Since the goal of this series is to fix an ARM64-specific issue,

"ARM64" was in the headline banner, but it would apply to other archs, 
as mentioned above. I should have made that clearer.

and
> the typical port I/O model is for each arch to #define its own inb(),
> maybe it would make sense to move the "#define inb logic_inb" from
> linux/logic_pio.h to arm64/include/asm/io.h?
>

CONFIG_INDIRECT_PIO has been indirectly enabled in ARM64 defconfig for 
some time, so I think that it's ok for ARM64 arch Kconfig to select it 
at this stage. From that, we could make the change suggested.

And, in addition to that, we can make the change in this series just for 
CONFIG_INDIRECT_PIO.

But I think that the other archs, above, could benefit from the changes 
in this series, so it would be shame to omit them.

> The "#ifndef inb" arrangement gets pretty complicated when it occurs
> more than one place (asm-generic/io.h and logic_pio.h) and we have to
> start worrying about the ordering of #includes.

I agree on that.

Cheers,
John

>
> Bjorn
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>


