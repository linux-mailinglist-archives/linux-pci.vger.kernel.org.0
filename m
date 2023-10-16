Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30047C9D91
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 05:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjJPDA0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Oct 2023 23:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjJPDAZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Oct 2023 23:00:25 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3A2E5;
        Sun, 15 Oct 2023 20:00:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Vu9JM3x_1697425214;
Received: from 30.240.113.74(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vu9JM3x_1697425214)
          by smtp.aliyun-inc.com;
          Mon, 16 Oct 2023 11:00:15 +0800
Message-ID: <4147832a-1f24-5993-dfb6-59f420a17481@linux.alibaba.com>
Date:   Mon, 16 Oct 2023 11:00:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v7 3/4] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, renyu.zj@linux.alibaba.com
References: <20231013163025.GA1116248@bhelgaas>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20231013163025.GA1116248@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/10/14 00:30, Bjorn Helgaas wrote:
> On Fri, Oct 13, 2023 at 11:46:44AM +0800, Shuai Xue wrote:
>>
>>
>> On 2023/10/13 00:25, Bjorn Helgaas wrote:
>>> On Thu, Oct 12, 2023 at 11:28:55AM +0800, Shuai Xue wrote:
>>>> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
>>>> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
>>>> Core controller IP which provides statistics feature. The PMU is not a PCIe
>>>> Root Complex integrated End Point(RCiEP) device but only register counters
>>>> provided by each PCIe Root Port.
> 
> IIUC, the PMU is directly integrated into the Root Port: it's
> discovered and operated via the Root Port config space.  If so, I
> wouldn't bother mentioning RCiEP because there's no need to list all
> the things it's *not*.

I see, will not mention RCiEP next version.

> 
>>>> To facilitate collection of statistics the controller provides the
>>>> following two features for each Root Port:
>>>>
>>>> - Time Based Analysis (RX/TX data throughput and time spent in each
>>>>   low-power LTSSM state)
>>>> - Event counters (Error and Non-Error for lanes)
>>>>
>>>> Note, only one counter for each type and does not overflow interrupt.
>>>
>>> Not sure what "does not overflow interrupt" means.  Does it mean
>>> there's no interrupt generated when the counter overflows?
>>
>> Yes, exactly. The rootport does NOT generate interrupt when the
>> couter overflows.  I think the assumption hidden in this design is
>> 64-bit counter will not overflow within observable time.
>>
>> PCIe 5.0 slots can now reach anywhere between ~4GB/sec for a x1 slot
>> up to ~64GB/sec for a x16 slot. The unit of counter is 16 byte.
>>
>> 	2^64/(64/16*10^9)/60/60/24/365=146 years
>>
>> so, the counter will not overflow within 146 years.
> 
> Certainly a reasonable assumption :)
> 
> But I'm confused about how many counters there are.  Clearly there are
> two features ((1) time-based analysis and (2) event counters).
> 
> "One counter for each type" suggests there's one counter for
> time-based analysis and a second counter for event counting, 

You are right, two counters, TIME_BASED_ANAL_DATA_REG for time-based
analysis and EVENT_COUNTER_DATA_REG for event counting. And both of them
do not support generate interrupt when the counter overflows.

> but from
> dwc_pcie_pmu_event_add(), it looks like each Root Port might have a
> single counter, and you can decide whether that counter is used for
> time-based analysis or event counting, but you can't do both at the
> same time? 

dwc_pcie_pmu_event_add() now limit the PMU usage to stat event for either
time-based analysis or event counting.

I will extend to support stat them at the same time.

@@ -447,10 +447,10 @@ static int dwc_pcie_pmu_event_add(struct perf_event *event, int flags)
 	u32 ctrl;

 	/* Only one counter and it is in use */
-	if (pcie_pmu->event)
+	if (pcie_pmu->event[type])
 		return -ENOSPC;

-	pcie_pmu->event = event;
+	pcie_pmu->event[type] = event;
 	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;

 	if (type == DWC_PCIE_LANE_EVENT) {
@@ -486,10 +486,11 @@ static int dwc_pcie_pmu_event_add(struct perf_event *event, int flags)
 static void dwc_pcie_pmu_event_del(struct perf_event *event, int flags)
 {
 	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
+	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);

 	dwc_pcie_pmu_event_stop(event, flags | PERF_EF_UPDATE);
 	perf_event_update_userpage(event);
-	pcie_pmu->event = NULL;
+	pcie_pmu->event[type] = NULL;
 }

> And the event counting is for a single lane, not for the
> link as a whole?

Yes.

> 
> If so, I might word this as:
> 
>   Each Root Port contains one counter that can be used for either:
> 
>     - Time-Based Analysis (RX/TX data throughput and time spent in
>       each low-power LTSSM state) or
> 
>     - Event counting (error and non-error events for a specified lane)
> 
>   There is no interrupt for counter overflow.

Based on above, I change the word to:

	To facilitate collection of statistics the controller provides the
	following two features for each Root Port:

	- one 64-bit counter for Time Based Analysis (RX/TX data throughput and
	  time spent in each low-power LTSSM state) and
	- one 32-bit counter for Event counting (error and non-error events for
	  a specified lane)

	Note: There is no interrupt for counter overflow.


> 
>>>> +	  Enable perf support for Synopsys DesignWare PCIe PMU Performance
>>>> +	  monitoring event on platform including the Yitian 710.
>>>
>>> Should this mention Alibaba or T-Head?  I don't know how
>>> Alibaba/T-Head/Yitian are all related.
>>
>> The server chips, named Yitian 710, are custom-built by Alibaba Group's chip
>> development business, T-Head.
>>
>> 	  Enable perf support for Synopsys DesignWare PCIe PMU Performance
>> 	  monitoring event on platform including the Alibaba Yitian 710.
>>
>> Is this okay?
> 
> Perfect :)


Thank you for valuable comments.

Best Regards,
Shuai
