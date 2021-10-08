Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD29342627A
	for <lists+linux-pci@lfdr.de>; Fri,  8 Oct 2021 04:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhJHCnm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 22:43:42 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28894 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJHCnl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Oct 2021 22:43:41 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HQXQn542Xzbn4W;
        Fri,  8 Oct 2021 10:37:21 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 10:41:45 +0800
Received: from [10.67.102.185] (10.67.102.185) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 8 Oct 2021 10:41:44 +0800
Subject: Re: [PATCH v10 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>, <will@kernel.org>
CC:     <mark.rutland@arm.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
References: <20210915074524.18040-1-liuqi115@huawei.com>
 <20210915074524.18040-3-liuqi115@huawei.com>
 <20211006150628.00007cbf@Huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <1cfb14bb-82a2-1923-d02f-892041f01ad5@huawei.com>
Date:   Fri, 8 Oct 2021 10:41:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20211006150628.00007cbf@Huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/10/6 22:06, Jonathan Cameron wrote:
> On Wed, 15 Sep 2021 15:45:24 +0800
> Qi Liu <liuqi115@huawei.com> wrote:
> 
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
>>
>> Reviewed-by: John Garry <john.garry@huawei.com>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> ---
> Hi Qi,
> 
> One trivial thing I just noticed below that can be easily fixed up by a follow up
> patch if that makes sense.
> 
> Thanks,
> 
> Jonathan
> 
>> +/*
>> + * Events with the "dl" suffix in their names count performance in DL layer,
>> + * otherswise, events count performance in TL layer.
> 
> This comment looks to be out of date..
> 
Hi all,

Yes, this comment should be deleted, and I'll drop it in next version, 
thanks.

@Will, do you have any comments about this patchset?

Thanks,
Qi

>> + */
>> +static struct attribute *hisi_pcie_pmu_events_attr[] = {
>> +	HISI_PCIE_PMU_EVENT_ATTR(rx_mwr_latency, 0x0010),
>> +	HISI_PCIE_PMU_EVENT_ATTR(rx_mwr_cnt, 0x10010),
>> +	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_latency, 0x0210),
>> +	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_cnt, 0x10210),
>> +	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_latency, 0x0011),
>> +	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_cnt, 0x10011),
>> +	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_flux, 0x1005),
>> +	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_time, 0x11005),
>> +	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_flux, 0x2004),
>> +	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_time, 0x12004),
>> +	NULL
>> +};
> .
> 
