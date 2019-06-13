Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C48143A88
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 17:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388395AbfFMPVz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 11:21:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47402 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731992AbfFMPVz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 11:21:55 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5B032930F6C48A56E290;
        Thu, 13 Jun 2019 23:21:51 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Jun 2019
 23:21:42 +0800
Subject: Re: [PATCH v4 1/3] lib: logic_pio: Use logical PIO low-level
 accessors for !CONFIG_INDIRECT_PIO
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <1560262374-67875-1-git-send-email-john.garry@huawei.com>
 <1560262374-67875-2-git-send-email-john.garry@huawei.com>
 <20190613135825.GG13533@google.com>
CC:     <lorenzo.pieralisi@arm.com>, <arnd@arndb.de>,
        <linux-pci@vger.kernel.org>, <rjw@rjwysocki.net>,
        <linux-arm-kernel@lists.infradead.org>, <will.deacon@arm.com>,
        <wangkefeng.wang@huawei.com>, <linuxarm@huawei.com>,
        <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <catalin.marinas@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5b03c093-26fb-0e01-6104-5f92eef7956e@huawei.com>
Date:   Thu, 13 Jun 2019 16:21:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190613135825.GG13533@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13/06/2019 14:58, Bjorn Helgaas wrote:
> On Tue, Jun 11, 2019 at 10:12:52PM +0800, John Garry wrote:
> Another thought here:
>
>>  	if (addr < MMIO_UPPER_LIMIT) {					\
>>  		ret = read##bw(PCI_IOBASE + addr);			\
>>  	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) { \
>> -		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
>> +		struct logic_pio_hwaddr *range = find_io_range(addr);	\
>> +		size_t sz = sizeof(type);				\
>>  									\
>> -		if (entry && entry->ops)				\
>> -			ret = entry->ops->in(entry->hostdata,		\
>> -					addr, sizeof(type));		\
>> +		if (range && range->ops)				\
>> +			ret = range->ops->in(range->hostdata, addr, sz);\
>>  		else							\
>>  			WARN_ON_ONCE(1);

Hi Bjorn,
				\
>
> Could this be simplified a little by requiring callers to set
> range->ops for LOGIC_PIO_INDIRECT ranges *before* calling
> logic_pio_register_range()?  E.g.,
>
>   hisi_lpc_probe(...)
>   {
>     range = devm_kzalloc(...);
>     range->flags = LOGIC_PIO_INDIRECT;
>     range->ops = &hisi_lpc_ops;
>     logic_pio_register_range(range);
>     ...
>
> and
>
>   logic_pio_register_range(struct logic_pio_hwaddr *new_range)
>   {
>     if (new_range->flags == LOGIC_PIO_INDIRECT && !new_range->ops)
>       return -EINVAL;
>     ...
>
> Then maybe you wouldn't need to check range->ops in the accessors.
>

I think I know the reason why it was done this way.

So currently there is no method to unregister a logical PIO region (the 
old code leaked ranges as well). As such, if hisi_lpc_probe() fails 
after we register the logical PIO range, there would be a range 
registered but no actual host backing it. So we set the ops at the point 
at which the probe cannot fail to avoid a potential problem.

And now I realise that there is a bug in the code - range is allocated 
with devm_kzalloc and is passed to logic_pio_register_range(). As such, 
if the hisi_lpc_probe() goes on to fail, then this memory would be 
free'd and we have an issue.

PCI code should be ok as it uses kzalloc().

The simplest solution is to not change the logical PIO API to allocate 
this memory itself, but rather make hisi_lpc_probe() use kzalloc(). And, 
if we go this way, we can use your idea to set the ops.

I'll spin a separate patch for this.

Thanks,
John

> Bjorn
>
> .
>


