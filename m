Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3813B4BF4
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jun 2021 04:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhFZCPZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 22:15:25 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:8323 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhFZCPZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jun 2021 22:15:25 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GBcjw1SRyz72LG;
        Sat, 26 Jun 2021 10:08:52 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 10:13:01 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 26
 Jun 2021 10:13:00 +0800
Subject: Re: [PATCH v7 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
To:     John Garry <john.garry@huawei.com>, Linuxarm <linuxarm@huawei.com>,
        <will@kernel.org>, <mark.rutland@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <zhangshaokun@hisilicon.com>
References: <1624532384-43002-1-git-send-email-liuqi115@huawei.com>
 <1624532384-43002-3-git-send-email-liuqi115@huawei.com>
 <485dcb90-01bc-766a-466a-f32563e2076f@huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <95de93f7-1618-5aa6-9a23-6445c5cb3515@huawei.com>
Date:   Sat, 26 Jun 2021 10:13:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <485dcb90-01bc-766a-466a-f32563e2076f@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021/6/25 23:53, John Garry wrote:
> On 24/06/2021 11:59, Qi Liu wrote:
>> +
>> +/*
>> + * Events with the "dl" suffix in their names count performance in DL 
>> layer,
>> + * otherswise, events count performance in TL layer.
>> + */
>> +static struct attribute *hisi_pcie_pmu_events_attr[] = {
>> +    HISI_PCIE_PMU_EVENT_ATTR(bw_rx_mwr, 0x010004),
>> +    HISI_PCIE_PMU_EVENT_ATTR(bw_rx_mrd, 0x100005),
>> +    HISI_PCIE_PMU_EVENT_ATTR(bw_tx_mwr, 0x010005),
>> +    HISI_PCIE_PMU_EVENT_ATTR(bw_tx_mrd, 0x200004),
>> +    HISI_PCIE_PMU_EVENT_ATTR(lat_rx_mwr, 0x000010),
>> +    HISI_PCIE_PMU_EVENT_ATTR(lat_rx_mrd, 0x020010),
>> +    HISI_PCIE_PMU_EVENT_ATTR(lat_tx_mrd, 0x000011),
>> +    HISI_PCIE_PMU_EVENT_ATTR(bw_rx_dl, 0x010084),
>> +    HISI_PCIE_PMU_EVENT_ATTR(bw_tx_dl, 0x030084),
>> +    NULL
>> +};
>> +
>> +static struct attribute_group hisi_pcie_pmu_events_group = {
>> +    .name = "events",
>> +    .attrs = hisi_pcie_pmu_events_attr,
>> +};
>> +
>> +static struct attribute *hisi_pcie_pmu_format_attr[] = {
>> +    HISI_PCIE_PMU_FORMAT_ATTR(event, "config:0-15"),
>> +    HISI_PCIE_PMU_FORMAT_ATTR(subevent, "config:16-23"),
>> +    HISI_PCIE_PMU_FORMAT_ATTR(thr_len, "config1:0-3"),
>> +    HISI_PCIE_PMU_FORMAT_ATTR(thr_mode, "config1:4"),
>> +    HISI_PCIE_PMU_FORMAT_ATTR(trig_len, "config1:5-8"),
>> +    HISI_PCIE_PMU_FORMAT_ATTR(trig_mode, "config1:9"),
>> +    HISI_PCIE_PMU_FORMAT_ATTR(port, "config2:0-15"),
>> +    HISI_PCIE_PMU_FORMAT_ATTR(bdf, "config2:16-31"),
>> +    NULL
>> +};
> 
> I am just wondering how this now works.
> 
> So if the user programs the following:
> ./perf stat -v -e hisi_pcieX/lat_rx_mrd/
> 
> Then the value (incremented) in HISI_PCIE_CNT (I think that's the right 
> one) is returned as the event count. But one would expect bandwidth from 
> that event, while we only return here the delay cycles - how is the 
> count in HISI_PCIE_CNT_EXT exposed, so userspace can do the calc for bw?
> 

Hi John,

Hardware counter and ext_counter work together for bandwidth, latency,
bus utilization and buffer occupancy events. For example, for latency
events(idx = 0x10), counter counts total delay cycles and ext_counter
counts PCIe packets number.

As we don't want PMU driver to process these two data, "delay cycles"
can be treated as an event(id = 0x10), "packets number" as another event
(id = 0x10 << 8), and driver could export these data separately.

if the user want to calculate latency of rx memory read, they should:
./perf stat -v -e '{hisi_pcieX/event=0x10, 
subevent=0x01/,hisi_pcieX/event=0x0400, subevent=0x01/

and for bandwidth event:
./perf stat -v -e '{hisi_pcieX/event=0x4, 
subevent=0x02/,hisi_pcieX/event=0x1000, subevent=0x02/

Then the value in HISI_PCIE_CNT and HISI_PCIE_EXT_CNT returned 
separately, and userspace could do the calculation.

Thanks,
Qi
> Thanks,
> John
> .

