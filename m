Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D881389BE1
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 05:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhETDdD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 23:33:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4762 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhETDdD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 23:33:03 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FlwDV5pbDzqV76;
        Thu, 20 May 2021 11:28:10 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 11:31:41 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 20
 May 2021 11:31:40 +0800
Subject: Re: [PATCH v4 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
To:     John Garry <john.garry@huawei.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
References: <1621417741-5229-1-git-send-email-liuqi115@huawei.com>
 <1621417741-5229-3-git-send-email-liuqi115@huawei.com>
 <4c0f623b-fd0f-e13d-452a-7d72719ecaf8@huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <f48736a1-a81f-9506-2169-a0f879928270@huawei.com>
Date:   Thu, 20 May 2021 11:31:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4c0f623b-fd0f-e13d-452a-7d72719ecaf8@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021/5/19 19:40, John Garry wrote:
> On 19/05/2021 10:49, Qi Liu wrote:
>> PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported
>> to sample bandwidth, latency, buffer occupation etc.
>>
>> Each PMU RCiEP device monitors multiple Root Ports, and each RCiEP is
>> registered as a PMU in /sys/bus/event_source/devices, so users can
>> select target PMU, and use filter to do further sets.
>>
>> Filtering options contains:
>> event        - select the event.
>> subevent     - select the subevent.
>> port         - select target Root Ports. Information of Root Ports
>>                 are shown under sysfs.
>> bdf          - select requester_id of target EP device.
>> trig_len     - set trigger condition for starting event statistics.
>> trigger_mode - set trigger mode. 0 means starting to statistic when
>>                 bigger than trigger condition, and 1 means smaller.
>> thr_len      - set threshold for statistics.
>> thr_mode     - set threshold mode. 0 means count when bigger than
>>                 threshold, and 1 means smaller.
>>
>> Reviewed-by: John Garry <john.garry@huawei.com>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> 
> JFYI, In light of this following series:
> https://lore.kernel.org/linux-arm-kernel/87v97fccq9.ffs@nanos.tec.linutronix.de/ 
> 
> 
> At some stage the irq_set_affinity_hint() calls need to be fixed up here 
> as well.
Hi John,

Seems irq_set_affinity_hint() need to be replaced by irq_set_affinity(). 
I'll fix this and send a new version latter.

Thanks,
Qi
> 
> Thanks,
> John
> 
> .

