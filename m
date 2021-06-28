Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263D73B5DDA
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 14:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhF1MUr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 08:20:47 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3326 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhF1MUr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 08:20:47 -0400
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GD5zN25B8z6FBQq;
        Mon, 28 Jun 2021 20:10:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 14:18:19 +0200
Received: from [10.47.83.88] (10.47.83.88) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 28 Jun
 2021 13:18:19 +0100
Subject: Re: [PATCH v7 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
To:     "liuqi (BA)" <liuqi115@huawei.com>, Linuxarm <linuxarm@huawei.com>,
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
From:   John Garry <john.garry@huawei.com>
Message-ID: <f2e0ac61-d46d-1245-46e7-aea9bb83c64d@huawei.com>
Date:   Mon, 28 Jun 2021 13:11:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <403d09f8-6fe8-c04c-151b-40816c344b55@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.83.88]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/06/2021 11:49, liuqi (BA) wrote:
>>> Hardware counter and ext_counter work together for bandwidth, latency,
>>> bus utilization and buffer occupancy events. For example, for latency
>>> events(idx = 0x10), counter counts total delay cycles and ext_counter
>>> counts PCIe packets number.
>>>
>>> As we don't want PMU driver to process these two data, "delay cycles"
>>> can be treated as an event(id = 0x10), "packets number" as another event
>>> (id = 0x10 << 8), and driver could export these data separately.
>>>
>>> if the user want to calculate latency of rx memory read, they should:
>>> ./perf stat -v -e '{hisi_pcieX/event=0x10,
>>> subevent=0x01/,hisi_pcieX/event=0x0400, subevent=0x01/
>>>
>>> and for bandwidth event:
>>> ./perf stat -v -e '{hisi_pcieX/event=0x4,
>>> subevent=0x02/,hisi_pcieX/event=0x1000, subevent=0x02/
> Hi John,
>> I would suggest supporting a perf metric for this then, which would be
>> like:
>>
>> {
>>      "BriefDescription": "Latency for inbound traffic...",
>>      "MetricName": "hisi_pcie_lat_rx_mrd",
>>      "MetricExpr": "hisi_pcieX@event\\=0x4@subevent\\=0x02 \
>> hisi_pcieX@event\\=0x1000@subevent\\=0x02 \",
>>      "Unit": "hisi_pci",
>>      "Compat": "v1"
>> },
>>
>> (syntax may be incorrect - illustration only)
>>
> yes, we could add these metrics in json file, thanks.

The syntax is actually like:
    "MetricExpr": "hisi_pcieX@event\\=0x4\\,subevent\\=0x2@ / 
hisi_pcieX@event\\=0x1000\\,subevent\\=0x2@",

>>> Then the value in HISI_PCIE_CNT and HISI_PCIE_EXT_CNT returned
>>> separately, and userspace could do the calculation.
>> But I am still curious about lat_rx_mrd and the other events which we
>> continue to advertise. They don't really provide latency or bandwidth on
>> their own, but only half the necessary data. So I doubt their purpose.
>>
> So how about changing the event name to show the real purpose of this
> event, like changing "bw_rx_mrd" to "flux_rx_mrd", and changing
> "lat_rx_mrd" to "delay_rx_mrd"?

eh, I suppose you could, but I am not sure of the value. However I 
assume that the driver will detect and reject invalid or nonsense 
combinations of events if you did want this.

Thanks,
John
