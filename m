Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6372F6E572A
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 03:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDRBxk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 21:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjDRBxj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 21:53:39 -0400
Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com [47.90.199.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9ED420F;
        Mon, 17 Apr 2023 18:52:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VgN.twa_1681782660;
Received: from 30.97.48.52(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VgN.twa_1681782660)
          by smtp.aliyun-inc.com;
          Tue, 18 Apr 2023 09:51:01 +0800
Message-ID: <e2397b81-ec19-25e4-ee47-29da29984f9c@linux.alibaba.com>
Date:   Tue, 18 Apr 2023 09:51:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/3] drivers/perf: add DesignWare PCIe PMU driver
To:     Shuai Xue <xueshuai@linux.alibaba.com>, helgaas@kernel.org,
        yangyicong@huawei.com, will@kernel.org, Jonathan.Cameron@huawei.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        robin.murphy@arm.com, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com
References: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
 <20230410031702.68355-3-xueshuai@linux.alibaba.com>
 <713d8162-dd3c-483c-b984-7707ef8aaa36@linux.alibaba.com>
 <ca46be9a-77f2-80ee-62e8-a3ce3eb02097@linux.alibaba.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ca46be9a-77f2-80ee-62e8-a3ce3eb02097@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/17/2023 9:16 AM, Shuai Xue wrote:

[snip]

>>> +
>>> +static void dwc_pcie_pmu_event_update(struct perf_event *event)
>>> +{
>>> +    u64 counter;
>>> +    struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
>>> +    struct dwc_pcie_rp_info *rp_info = pmu_to_pcie_info(event->pmu);
>>> +    struct pci_dev *pdev = rp_info->pdev;
>>> +    u16 ras_des = rp_info->ras_des;
>>> +    struct hw_perf_event *hwc = &event->hw;
>>> +    enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
>>> +    u64 delta, prev, now;
>>> +
>>> +    do {
>>> +        prev = local64_read(&hwc->prev_count);
>>> +
>>> +        if (type == DWC_PCIE_LANE_EVENT)
>>> +            dwc_pcie_pmu_read_event_counter(pdev, ras_des, &counter);
>>> +        else if (type == DWC_PCIE_TIME_BASE_EVENT)
>>> +            dwc_pcie_pmu_read_base_time_counter(pdev, ras_des,
>>> +                                &counter);
>>> +        else
>>> +            dev_err(pcie_pmu->dev, "invalid event type: 0x%x\n", type);
>>> +
>>> +        now = counter;
>>> +    } while (local64_cmpxchg(&hwc->prev_count, prev, now) != prev);
>>> +
>>> +    delta = now - prev;
>>
>> This can be overflow? better to add a mask to avoid possible overflow.
> 
> I think it can not. This Root Complex supports up to PCIe Gen5 (32 GT/s)
> and one root port support up to x16 lanes, with peek bandwidth 64 GB/s.
> On Yitian 710, one root port is x4 lane with peak bandwidth 16 GB/s.
> The counter is 64 bit width with 16 bytes unit.
> 
> 	2^64*16/(64*10^9)/60/60/24/365 = 146 years
> 
> For x16 root port, it will not overflow within 146 yeasr and for yitian 710,
> it will never overflow in my life too.

However the lane event counter is 32bit, so still a maximum counter mask 
is preferable.
