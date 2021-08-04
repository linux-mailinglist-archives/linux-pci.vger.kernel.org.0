Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767B33DFC13
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 09:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbhHDHaK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 03:30:10 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:12444 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbhHDHaJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 03:30:09 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GfjwF6KckzcklS;
        Wed,  4 Aug 2021 15:26:21 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 4 Aug 2021 15:29:55 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 4 Aug
 2021 15:29:55 +0800
Subject: Re: [PATCH v8 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
To:     Will Deacon <will@kernel.org>, Linuxarm <linuxarm@huawei.com>
CC:     <mark.rutland@arm.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <zhangshaokun@hisilicon.com>
References: <20210728080932.72515-1-liuqi115@huawei.com>
 <20210728080932.72515-3-liuqi115@huawei.com>
 <20210802100343.GA27282@willie-the-truck>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <a56266c4-c434-f078-6027-f30c021bd593@huawei.com>
Date:   Wed, 4 Aug 2021 15:29:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210802100343.GA27282@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi Will,
> Hmm, I was hoping that you would expose all the events as proper perf_events
> and get rid of the subevents entirely.
> 
> Then userspace could do things like:
> 
>    // Count number of RX memory reads
>    $ perf stat -e hisi_pcie0_0/rx_memory_read/
> 
>    // Count delay cycles
>    $ perf stat -e hisi_pcie0_0/latency/
> 
>    // Count both of the above (events must be in the same group)
>    $ perf stat -g -e hisi_pcie0_0/latency/ -e hisi_pcie0_0/rx_memory_read/
> 
> Note that in all three of these cases the hardware will be programmed in
> the same way and both HISI_PCIE_CNT and HISI_PCIE_EXT_CNT are allocated!
> 
> So for example, doing this (i.e. without the '-g'):
> 
>    $ perf stat -e hisi_pcie0_0/latency/ -e hisi_pcie0_0/rx_memory_read/
> 
> would fail because the first event would allocate both of the counters.

I'm confused with this situation when getting rid of subevent:

$ perf stat -e hisi_pcie0_0/latency/ -e hisi_pcie0_0/rx_memory_read/

In this case, driver checks the relationship of "latency" and 
"rx_memory_read" in pmu->add() function and return a -EINVAL, but this 
seems lead to time division multiplexing.

	if (event->pmu->add(event, PERF_EF_START)) {
		perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
		event->oncpu = -1;
		ret = -EAGAIN;
		goto out;
	}
	...
out:
	perf_pmu_enable(event->pmu);

This result doesn't meet our expection, do I miss something here?

How about add an array to record events and check the relationship in 
event_init() function? It seems that perf stat could only failed when 
driver return invalid value in pmu->event_init() function.

Thanks,
Qi
> 
> All you need to do is check the counter scheduling constraints when
> accepting an event group in the driver. No need for subevents at all.
> 
> Does that make sense?
> 
> Will
> .
> 

