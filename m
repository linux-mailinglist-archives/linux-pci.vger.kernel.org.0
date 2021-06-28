Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2DF3B5ECA
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 15:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhF1NUM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 09:20:12 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:9286 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbhF1NUK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 09:20:10 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GD7Lf074Yz1BSm5;
        Mon, 28 Jun 2021 21:12:26 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 21:17:43 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 28
 Jun 2021 21:17:42 +0800
Subject: Re: [PATCH v7 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
To:     John Garry <john.garry@huawei.com>, Linuxarm <linuxarm@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhangshaokun <zhangshaokun@hisilicon.com>
References: <1624532384-43002-1-git-send-email-liuqi115@huawei.com>
 <1624532384-43002-3-git-send-email-liuqi115@huawei.com>
 <485dcb90-01bc-766a-466a-f32563e2076f@huawei.com>
 <95de93f7-1618-5aa6-9a23-6445c5cb3515@huawei.com>
 <1b164e4b-b30b-f071-51fa-841cc76ec017@huawei.com>
 <403d09f8-6fe8-c04c-151b-40816c344b55@huawei.com>
 <f2e0ac61-d46d-1245-46e7-aea9bb83c64d@huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <b217d750-7c40-d669-1391-77aa9d7ee6de@huawei.com>
Date:   Mon, 28 Jun 2021 21:17:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f2e0ac61-d46d-1245-46e7-aea9bb83c64d@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021/6/28 20:11, John Garry wrote:
> On 28/06/2021 11:49, liuqi (BA) wrote:
>>>> Hardware counter and ext_counter work together for bandwidth, latency,
>>>> bus utilization and buffer occupancy events. For example, for latency
>>>> events(idx = 0x10), counter counts total delay cycles and ext_counter
>>>> counts PCIe packets number.
>>>>
>>>> As we don't want PMU driver to process these two data, "delay cycles"
>>>> can be treated as an event(id = 0x10), "packets number" as another 
>>>> event
>>>> (id = 0x10 << 8), and driver could export these data separately.
>>>>
>>>> if the user want to calculate latency of rx memory read, they should:
>>>> ./perf stat -v -e '{hisi_pcieX/event=0x10,
>>>> subevent=0x01/,hisi_pcieX/event=0x0400, subevent=0x01/
>>>>
>>>> and for bandwidth event:
>>>> ./perf stat -v -e '{hisi_pcieX/event=0x4,
>>>> subevent=0x02/,hisi_pcieX/event=0x1000, subevent=0x02/
>> Hi John,
>>> I would suggest supporting a perf metric for this then, which would be
>>> like:
>>>
>>> {
>>>      "BriefDescription": "Latency for inbound traffic...",
>>>      "MetricName": "hisi_pcie_lat_rx_mrd",
>>>      "MetricExpr": "hisi_pcieX@event\\=0x4@subevent\\=0x02 \
>>> hisi_pcieX@event\\=0x1000@subevent\\=0x02 \",
>>>      "Unit": "hisi_pci",
>>>      "Compat": "v1"
>>> },
>>>
>>> (syntax may be incorrect - illustration only)
>>>
>> yes, we could add these metrics in json file, thanks.
> 
> The syntax is actually like:
>     "MetricExpr": "hisi_pcieX@event\\=0x4\\,subevent\\=0x2@ / 
> hisi_pcieX@event\\=0x1000\\,subevent\\=0x2@",
> 
>>>> Then the value in HISI_PCIE_CNT and HISI_PCIE_EXT_CNT returned
>>>> separately, and userspace could do the calculation.
>>> But I am still curious about lat_rx_mrd and the other events which we
>>> continue to advertise. They don't really provide latency or bandwidth on
>>> their own, but only half the necessary data. So I doubt their purpose.
>>>
>> So how about changing the event name to show the real purpose of this
>> event, like changing "bw_rx_mrd" to "flux_rx_mrd", and changing
>> "lat_rx_mrd" to "delay_rx_mrd"?
> 
> eh, I suppose you could, but I am not sure of the value. However  > assume that the driver will detect and reject invalid or nonsense
> combinations of events if you did want this.
> 
Hi John,

As content in two counters are registered as two independent different 
events, these events perhaps should be selected without limitation 
(Although it make sense only when using in combination).

So perhaps we don't need to do this rejection if user only get the value 
in HISI_PCIE_CNT or only get HISI_PCIE_EXT_CNT.

Thanks,
Qi
> Thanks,
> John
> .

