Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222533F7499
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 13:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhHYLw6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 07:52:58 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8928 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239257AbhHYLw5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Aug 2021 07:52:57 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GvkkT2Drsz8v8M;
        Wed, 25 Aug 2021 19:48:01 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 19:52:10 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 25
 Aug 2021 19:52:09 +0800
Subject: Re: [PATCH v9 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
To:     Will Deacon <will@kernel.org>, Linuxarm <linuxarm@huawei.com>
CC:     <mark.rutland@arm.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <zhangshaokun@hisilicon.com>
References: <20210818051246.29545-1-liuqi115@huawei.com>
 <20210818051246.29545-3-liuqi115@huawei.com>
 <20210824143137.GA23146@willie-the-truck>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <4050af8b-f9a7-6666-4a9d-d1c8f2b212e1@huawei.com>
Date:   Wed, 25 Aug 2021 19:52:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210824143137.GA23146@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi, Will
On 2021/8/24 22:31, Will Deacon wrote:
> Hi,
> 
> On Wed, Aug 18, 2021 at 01:12:46PM +0800, Qi Liu wrote:
>> PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported
>> to sample bandwidth, latency, buffer occupation etc.
>>
>> Each PMU RCiEP device monitors multiple Root Ports, and each RCiEP is
>> registered as a PMU in /sys/bus/event_source/devices, so users can
>> select target PMU, and use filter to do further sets.
>>
>> Filtering options contains:
>> event     - select the event.
>> port      - select target Root Ports. Information of Root Ports are
>>              shown under sysfs.
>> bdf       - select requester_id of target EP device.
>> trig_len  - set trigger condition for starting event statistics.
>> trig_mode - set trigger mode. 0 means starting to statistic when bigger
>>              than trigger condition, and 1 means smaller.
>> thr_len   - set threshold for statistics.
>> thr_mode  - set threshold mode. 0 means count when bigger than threshold,
>>              and 1 means smaller.
> 
> I think this is getting there now, thanks for sticking with it. Just a
> couple of comments below..
> 
>> +static bool hisi_pcie_pmu_validate_event_group(struct perf_event *event)
>> +{
>> +	struct perf_event *sibling, *leader = event->group_leader;
>> +	int counters = 1;
>> +
>> +	if (!is_software_event(leader)) {
>> +		if (leader->pmu != event->pmu)
>> +			return false;
>> +
>> +		if (leader != event)
>> +			counters++;
>> +	}
>> +
>> +	for_each_sibling_event(sibling, event->group_leader) {
>> +		if (is_software_event(sibling))
>> +			continue;
>> +
>> +		if (sibling->pmu != event->pmu)
>> +			return false;
>> +
>> +		counters++;
>> +	}
>> +
>> +	return counters <= HISI_PCIE_MAX_COUNTERS;
>> +}
> 
> Given that this function doesn't look at the event numbers, doesn't this
> over-provision the counter registers? For example, if I create a group
> containing 4 of the same event, then we'll allocate four counters but only
> use one. Similarly, if I create a group containing two events, one for the
> normal counter and one for the extended counter, then we'll again allocate
> two counters instead of one.
> 

Yes, we should add some check in hisi_pcie_pmu_validate_event_group() 
function to avoid over-provision. I'll use a array to record events and 
do this check.

Thanks for your review, I'll fix this.

> Have I misunderstood?
> 
>> +static int hisi_pcie_pmu_event_init(struct perf_event *event)
>> +{
>> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
>> +	struct hw_perf_event *hwc = &event->hw;
>> +
>> +	event->cpu = pcie_pmu->on_cpu;
>> +
>> +	if (EXT_COUNTER_IS_USED(hisi_pcie_get_event(event)))
>> +		hwc->event_base = HISI_PCIE_EXT_CNT;
>> +	else
>> +		hwc->event_base = HISI_PCIE_CNT;
>> +
>> +	if (event->attr.type != event->pmu->type)
>> +		return -ENOENT;
>> +
>> +	/* Sampling is not supported. */
>> +	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (!hisi_pcie_pmu_valid_filter(event, pcie_pmu)) {
>> +		pci_err(pcie_pmu->pdev, "Invalid filter!\n");
> 
> Please remove this message, as it's triggerable from userspace.
> 
got it, will remove this.

Thanks,
Qi
> Will
> .
> 

