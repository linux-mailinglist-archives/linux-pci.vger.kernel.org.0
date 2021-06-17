Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E5D3AB1CF
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 13:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhFQLCh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 07:02:37 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:8257 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhFQLCg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jun 2021 07:02:36 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G5Jqd2R89z1BNWY;
        Thu, 17 Jun 2021 18:55:25 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 19:00:27 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 17
 Jun 2021 19:00:27 +0800
Subject: Re: [PATCH v6 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
To:     Will Deacon <will@kernel.org>, Linuxarm <linuxarm@huawei.com>
CC:     <mark.rutland@arm.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <zhangshaokun@hisilicon.com>
References: <1622467951-32114-1-git-send-email-liuqi115@huawei.com>
 <1622467951-32114-3-git-send-email-liuqi115@huawei.com>
 <20210611162347.GA16284@willie-the-truck>
 <a299d053-b45f-e941-7a2e-c853079b8cdd@huawei.com>
 <20210615093519.GB19878@willie-the-truck>
 <8e15e8d6-cfe8-0926-0ca1-b162302e52a5@huawei.com>
 <20210616134257.GA22905@willie-the-truck>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <678f7d55-9408-f323-da53-b5afe2595271@huawei.com>
Date:   Thu, 17 Jun 2021 19:00:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210616134257.GA22905@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021/6/16 21:42, Will Deacon wrote:
> Hi,
> 
> On Wed, Jun 16, 2021 at 09:54:23AM +0800, liuqi (BA) wrote:
>> On 2021/6/15 17:35, Will Deacon wrote:
>>> On Tue, Jun 15, 2021 at 04:57:09PM +0800, liuqi (BA) wrote:
>>>> On 2021/6/12 0:23, Will Deacon wrote:
>>>>> On Mon, May 31, 2021 at 09:32:31PM +0800, Qi Liu wrote:
>>>>>> +	/* Process data to set unit of latency as "us". */
>>>>>> +	if (is_latency_event(idx))
>>>>>> +		return div64_u64(data * us_per_cycle, data_ext);
>>>>>> +
>>>>>> +	if (is_bus_util_event(idx))
>>>>>> +		return div64_u64(data * us_per_cycle, data_ext);
>>>>>> +
>>>>>> +	if (is_buf_util_event(idx))
>>>>>> +		return div64_u64(data, data_ext * us_per_cycle);
>>>>>
>>>>> Why do we need to do all this division in the kernel? Can't we just expose
>>>>> the underlying values and let userspace figure out what it wants to do with
>>>>> the numbers?
>>>>>
>>>> Our PMU hardware support 8 sets of counters to count bandwidth, latency and
>>>> utilization events.
>>>>
>>>> For example, when users set latency event, common counter will count delay
>>>> cycles, and extern counter count number of PCIe packets automaticly. And we
>>>> do not have a event number for counting number of PCIe packets.
>>>>
>>>> So this division cannot move to userspace tool.
>>>
>>> Why can't you expose the packet counter as an extra event to userspace?
>>>
>> Maybe I didn’t express it clearly.
>>
>> As there is no hardware event number for PCIe packets counting, extern
>> counter count packets *automaticly* when latency events is selected by
>> users.
>>
>> This means users cannot set "config=0xXX" to start packets counting event.
>> So we can only get the value of counter and extern counter in driver and do
>> the division, then pass the result to userspace.
> 
> I still think it would be ideal if we could expose both values to userspace
> rather than combine them somehow. Hmm. Anyway...
> 
> I struggled to figure out exactly what's being counted from the
> documentation patch (please update that). Please can you explain exactly
> what appears in the HISI_PCIE_CNT and HISI_PCIE_EXT_CNT registers for the
> different modes of operation? Without that, the ratios you've chosen to
> report seem rather arbitrary.
> 

Hi Will,

PCIe PMU events can be devided into 2 types: one type is counted by 
HISI_PCIE_CNT, the other type is counted by HISI_PCIE_EXT_CNT and 
HISI_PCIE_CNT, including bandwidth events, latency events, buffer 
utilization and bus utilization.

if user sets "event=0x10, subevent=0x02", this means "latency of RX 
memory read" is selected. HISI_PCIE_CNT counts total delay cycles and 
HISI_PCIE_EXT_CNT counts PCIe packets number at the same time. So PMU 
driver could obtain average latency by caculating: HISI_PCIE_CNT / 
HISI_PCIE_EXT_CNT.

if users sets "event=0x04, subevent=0x01", this means bandwidth of RX 
memory read is selected. HISI_PCIE_CNT counts total packet data volume 
and HISI_PCIE_EXT_CNT counts cycles, so PMU driver could obtain average 
bandwidth by caculating: HISI_PCIE_CNT / HISI_PCIE_EXT_CNT.

The same logic is used when calculating bus utilization and buffer 
utilization. Seems I should add this part in Document patch,I 'll do 
this in next version, thanks.

> I also couldn't figure out how the latency event works. For example, I was
> assuming it would be a filter (a bit like the length), so you could say
> things like "I'm only interested in packets with a latency higher than x"
> but it doesn't look like it works that way.
> 
> Thanks,
> 
latency is not a filter, PCIe PMU has a group of lactency events, their 
event number are within the latency_events_list, and the above explains 
how latency events work.

PMU drivers have TLP length filter for bandwidth events, users could set 
like "I only interested in bandwidth of packets with TLP length bigger 
than x".

Thanks,
Qi

> Will
> .
> 

