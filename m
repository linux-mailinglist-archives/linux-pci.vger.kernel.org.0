Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA1C3B4E68
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jun 2021 13:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhFZLxd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Jun 2021 07:53:33 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3321 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZLxc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Jun 2021 07:53:32 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GBsL50ykLz6L4sw;
        Sat, 26 Jun 2021 19:37:33 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 26 Jun 2021 13:51:08 +0200
Received: from [10.47.80.199] (10.47.80.199) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 26 Jun
 2021 12:51:07 +0100
Subject: Re: [PATCH v7 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
To:     "liuqi (BA)" <liuqi115@huawei.com>, Linuxarm <linuxarm@huawei.com>,
        <will@kernel.org>, <mark.rutland@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <zhangshaokun@hisilicon.com>
References: <1624532384-43002-1-git-send-email-liuqi115@huawei.com>
 <1624532384-43002-3-git-send-email-liuqi115@huawei.com>
 <485dcb90-01bc-766a-466a-f32563e2076f@huawei.com>
 <95de93f7-1618-5aa6-9a23-6445c5cb3515@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <1b164e4b-b30b-f071-51fa-841cc76ec017@huawei.com>
Date:   Sat, 26 Jun 2021 12:44:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <95de93f7-1618-5aa6-9a23-6445c5cb3515@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.80.199]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 26/06/2021 03:13, liuqi (BA) wrote:
> 
> 
> On 2021/6/25 23:53, John Garry wrote:
>> On 24/06/2021 11:59, Qi Liu wrote:
>>> +
>>> +/*
>>> + * Events with the "dl" suffix in their names count performance in 
>>> DL layer,
>>> + * otherswise, events count performance in TL layer.
>>> + */
>>> +static struct attribute *hisi_pcie_pmu_events_attr[] = {
>>> +    HISI_PCIE_PMU_EVENT_ATTR(bw_rx_mwr, 0x010004),
>>> +    HISI_PCIE_PMU_EVENT_ATTR(bw_rx_mrd, 0x100005),
>>> +    HISI_PCIE_PMU_EVENT_ATTR(bw_tx_mwr, 0x010005),
>>> +    HISI_PCIE_PMU_EVENT_ATTR(bw_tx_mrd, 0x200004),
>>> +    HISI_PCIE_PMU_EVENT_ATTR(lat_rx_mwr, 0x000010),
>>> +    HISI_PCIE_PMU_EVENT_ATTR(lat_rx_mrd, 0x020010),
>>> +    HISI_PCIE_PMU_EVENT_ATTR(lat_tx_mrd, 0x000011),
>>> +    HISI_PCIE_PMU_EVENT_ATTR(bw_rx_dl, 0x010084),
>>> +    HISI_PCIE_PMU_EVENT_ATTR(bw_tx_dl, 0x030084),
>>> +    NULL
>>> +};
>>> +
>>> +static struct attribute_group hisi_pcie_pmu_events_group = {
>>> +    .name = "events",
>>> +    .attrs = hisi_pcie_pmu_events_attr,
>>> +};
>>> +
>>> +static struct attribute *hisi_pcie_pmu_format_attr[] = {
>>> +    HISI_PCIE_PMU_FORMAT_ATTR(event, "config:0-15"),
>>> +    HISI_PCIE_PMU_FORMAT_ATTR(subevent, "config:16-23"),
>>> +    HISI_PCIE_PMU_FORMAT_ATTR(thr_len, "config1:0-3"),
>>> +    HISI_PCIE_PMU_FORMAT_ATTR(thr_mode, "config1:4"),
>>> +    HISI_PCIE_PMU_FORMAT_ATTR(trig_len, "config1:5-8"),
>>> +    HISI_PCIE_PMU_FORMAT_ATTR(trig_mode, "config1:9"),
>>> +    HISI_PCIE_PMU_FORMAT_ATTR(port, "config2:0-15"),
>>> +    HISI_PCIE_PMU_FORMAT_ATTR(bdf, "config2:16-31"),
>>> +    NULL
>>> +};
>>
>> I am just wondering how this now works.
>>
>> So if the user programs the following:
>> ./perf stat -v -e hisi_pcieX/lat_rx_mrd/
>>
>> Then the value (incremented) in HISI_PCIE_CNT (I think that's the 
>> right one) is returned as the event count. But one would expect 
>> bandwidth from that event, while we only return here the delay cycles 
>> - how is the count in HISI_PCIE_CNT_EXT exposed, so userspace can do 
>> the calc for bw?
>>
> 

Hi Qi,

> 
> Hardware counter and ext_counter work together for bandwidth, latency,
> bus utilization and buffer occupancy events. For example, for latency
> events(idx = 0x10), counter counts total delay cycles and ext_counter
> counts PCIe packets number.
> 
> As we don't want PMU driver to process these two data, "delay cycles"
> can be treated as an event(id = 0x10), "packets number" as another event
> (id = 0x10 << 8), and driver could export these data separately.
> 
> if the user want to calculate latency of rx memory read, they should:
> ./perf stat -v -e '{hisi_pcieX/event=0x10, 
> subevent=0x01/,hisi_pcieX/event=0x0400, subevent=0x01/
> 
> and for bandwidth event:
> ./perf stat -v -e '{hisi_pcieX/event=0x4, 
> subevent=0x02/,hisi_pcieX/event=0x1000, subevent=0x02/

I would suggest supporting a perf metric for this then, which would be like:

{
    "BriefDescription": "Latency for inbound traffic...",
    "MetricName": "hisi_pcie_lat_rx_mrd",
    "MetricExpr": "hisi_pcieX@event\\=0x4@subevent\\=0x02 \ 
hisi_pcieX@event\\=0x1000@subevent\\=0x02 \",
    "Unit": "hisi_pci",
    "Compat": "v1"
},

(syntax may be incorrect - illustration only)

> 
> Then the value in HISI_PCIE_CNT and HISI_PCIE_EXT_CNT returned 
> separately, and userspace could do the calculation.

But I am still curious about lat_rx_mrd and the other events which we 
continue to advertise. They don't really provide latency or bandwidth on 
their own, but only half the necessary data. So I doubt their purpose.

Thanks,
John

