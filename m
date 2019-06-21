Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2BAE4EA4E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 16:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfFUOMl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 10:12:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36208 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbfFUOMk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 10:12:40 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0630A528127AE37879EE;
        Fri, 21 Jun 2019 22:12:36 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 21 Jun 2019
 22:12:29 +0800
Subject: Re: [PATCH 1/5] lib: logic_pio: Fix RCU usage
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <1561026716-140537-1-git-send-email-john.garry@huawei.com>
 <1561026716-140537-2-git-send-email-john.garry@huawei.com>
 <20190621134332.GC82584@google.com>
CC:     <xuwei5@huawei.com>, <linuxarm@huawei.com>, <arm@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <joe@perches.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <885f3c01-82b9-5978-5e7f-1130021bde57@huawei.com>
Date:   Fri, 21 Jun 2019 15:12:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190621134332.GC82584@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/06/2019 14:43, Bjorn Helgaas wrote:
> On Thu, Jun 20, 2019 at 06:31:52PM +0800, John Garry wrote:

Hi Bjorn,

>> The traversing of io_range_list with list_for_each_entry_rcu()
>> is not properly protected by rcu_read_lock(), so add it.
>>

Functions rcu_read_lock() and rcu_read_unlock() mark the critical 
section scope where the list is protected for the reader, it cannot be 
"reclaimed". Any updater - in this case, the logical PIO registration or 
unregistration functions - cannot update the list until the reader exits 
this critical section.

>> In addition, the list traversing used in logic_pio_register_range()
>> does not need to use the rcu variant.

We don't need rcu variant as we're already using the mutex to guarantee 
mutual exclusion from mutating the list.

>
> Not being an RCU expert myself, a few words here about why one path
> needs protection but the other doesn't would be helpful.  This
> basically restates what the patch *does*, which is obvious from the
> diff, but not *why*.

OK, I can add what I mentioned above.

Thanks again,
John

>
>> Fixes: 031e3601869c ("lib: Add generic PIO mapping method")
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>  lib/logic_pio.c | 49 +++++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 35 insertions(+), 14 deletions(-)
>>
>> diff --git a/lib/logic_pio.c b/lib/logic_pio.c
>> index feea48fd1a0d..761296376fbc 100644
>> --- a/lib/logic_pio.c
>> +++ b/lib/logic_pio.c
>> @@ -46,7 +46,7 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
>>  	end = new_range->hw_start + new_range->size;
>>
>>  	mutex_lock(&io_range_mutex);
>> -	list_for_each_entry_rcu(range, &io_range_list, list) {
>> +	list_for_each_entry(range, &io_range_list, list) {
>>  		if (range->fwnode == new_range->fwnode) {
>>  			/* range already there */
>>  			goto end_register;
>> @@ -108,26 +108,38 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
>>   */
>>  struct logic_pio_hwaddr *find_io_range_by_fwnode(struct fwnode_handle *fwnode)
>>  {
>> -	struct logic_pio_hwaddr *range;
>> +	struct logic_pio_hwaddr *range, *found_range = NULL;
>>
>> +	rcu_read_lock();
>>  	list_for_each_entry_rcu(range, &io_range_list, list) {
>> -		if (range->fwnode == fwnode)
>> -			return range;
>> +		if (range->fwnode == fwnode) {
>> +			found_range = range;
>> +			break;
>> +		}
>>  	}
>> -	return NULL;
>> +	rcu_read_unlock();
>> +
>> +	return found_range;
>>  }
>>
>>  /* Return a registered range given an input PIO token */
>>  static struct logic_pio_hwaddr *find_io_range(unsigned long pio)
>>  {
>> -	struct logic_pio_hwaddr *range;
>> +	struct logic_pio_hwaddr *range, *found_range = NULL;
>>
>> +	rcu_read_lock();
>>  	list_for_each_entry_rcu(range, &io_range_list, list) {
>> -		if (in_range(pio, range->io_start, range->size))
>> -			return range;
>> +		if (in_range(pio, range->io_start, range->size)) {
>> +			found_range = range;
>> +			break;
>> +		}
>>  	}
>> -	pr_err("PIO entry token %lx invalid\n", pio);
>> -	return NULL;
>> +	rcu_read_unlock();
>> +
>> +	if (!found_range)
>> +		pr_err("PIO entry token 0x%lx invalid\n", pio);
>> +
>> +	return found_range;
>>  }
>>
>>  /**
>> @@ -180,14 +192,23 @@ unsigned long logic_pio_trans_cpuaddr(resource_size_t addr)
>>  {
>>  	struct logic_pio_hwaddr *range;
>>
>> +	rcu_read_lock();
>>  	list_for_each_entry_rcu(range, &io_range_list, list) {
>>  		if (range->flags != LOGIC_PIO_CPU_MMIO)
>>  			continue;
>> -		if (in_range(addr, range->hw_start, range->size))
>> -			return addr - range->hw_start + range->io_start;
>> +		if (in_range(addr, range->hw_start, range->size)) {
>> +			unsigned long cpuaddr;
>> +
>> +			cpuaddr = addr - range->hw_start + range->io_start;
>> +
>> +			rcu_read_unlock();
>> +			return cpuaddr;
>> +		}
>>  	}
>> -	pr_err("addr %llx not registered in io_range_list\n",
>> -	       (unsigned long long) addr);
>> +	rcu_read_unlock();
>> +
>> +	pr_err("addr %pa not registered in io_range_list\n", &addr);
>> +
>>  	return ~0UL;
>>  }
>>
>> --
>> 2.17.1
>>
>
> .
>


