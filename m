Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD647CB795
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 02:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjJQAs0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Oct 2023 20:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjJQAs0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2023 20:48:26 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7785492;
        Mon, 16 Oct 2023 17:48:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VuKn2PK_1697503699;
Received: from 30.240.113.74(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VuKn2PK_1697503699)
          by smtp.aliyun-inc.com;
          Tue, 17 Oct 2023 08:48:20 +0800
Message-ID: <83e7bb45-7776-4cfa-a3ed-050faaa1e72c@linux.alibaba.com>
Date:   Tue, 17 Oct 2023 08:48:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
References: <20231016143805.GA1207929@bhelgaas>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20231016143805.GA1207929@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/10/16 22:38, Bjorn Helgaas wrote:
> On Mon, Oct 16, 2023 at 11:00:13AM +0800, Shuai Xue wrote:
>> On 2023/10/14 00:30, Bjorn Helgaas wrote:
>>> On Fri, Oct 13, 2023 at 11:46:44AM +0800, Shuai Xue wrote:
>>>> On 2023/10/13 00:25, Bjorn Helgaas wrote:
>>>>> On Thu, Oct 12, 2023 at 11:28:55AM +0800, Shuai Xue wrote:
>>>>>> This commit adds the PCIe Performance Monitoring Unit (PMU)
>>>>>> driver support for T-Head Yitian SoC chip. Yitian is based on
>>>>>> the Synopsys PCI Express Core controller IP which provides
>>>>>> statistics feature. The PMU is not a PCIe Root Complex
>>>>>> integrated End Point(RCiEP) device but only register counters
>>>>>> provided by each PCIe Root Port.
> 
>> @@ -447,10 +447,10 @@ static int dwc_pcie_pmu_event_add(struct perf_event *event, int flags)
>>  	u32 ctrl;
>>
>>  	/* Only one counter and it is in use */
>> -	if (pcie_pmu->event)
>> +	if (pcie_pmu->event[type])
>>  		return -ENOSPC;
>>
>> -	pcie_pmu->event = event;
>> +	pcie_pmu->event[type] = event;
> 
> OK, makes good sense (probably update the comment also, e.g., "one
> counter of each type").

Yes, will do that.

> 
>>  }
>>> If so, I might word this as:
>>>
>>>   Each Root Port contains one counter that can be used for either:
>>>
>>>     - Time-Based Analysis (RX/TX data throughput and time spent in
>>>       each low-power LTSSM state) or
>>>
>>>     - Event counting (error and non-error events for a specified lane)
>>>
>>>   There is no interrupt for counter overflow.
>>
>> Based on above, I change the word to:
>>
>> 	To facilitate collection of statistics the controller provides the
>> 	following two features for each Root Port:
>>
>> 	- one 64-bit counter for Time Based Analysis (RX/TX data throughput and
>> 	  time spent in each low-power LTSSM state) and
>> 	- one 32-bit counter for Event counting (error and non-error events for
>> 	  a specified lane)
>>
>> 	Note: There is no interrupt for counter overflow.
> 
> Beautiful, that's very clear.
> 

Thank you for quick feedback. I will send a new version latter.

Best Regards.
Shuai
