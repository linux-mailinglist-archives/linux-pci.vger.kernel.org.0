Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD3E7CF7A9
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 13:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjJSL4o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 07:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjJSL4n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 07:56:43 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9E213A;
        Thu, 19 Oct 2023 04:56:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VuTv4zZ_1697716594;
Received: from 30.240.113.74(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VuTv4zZ_1697716594)
          by smtp.aliyun-inc.com;
          Thu, 19 Oct 2023 19:56:36 +0800
Message-ID: <2edced57-5b9b-43e7-81a2-d8bf522c2b74@linux.alibaba.com>
Date:   Thu, 19 Oct 2023 19:56:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] docs: perf: Add description for Synopsys
 DesignWare PCIe PMU driver
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org,
        baolin.wang@linux.alibaba.com, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
References: <20231017013235.27831-1-xueshuai@linux.alibaba.com>
 <20231017013235.27831-2-xueshuai@linux.alibaba.com>
 <20231017101624.00003231@Huawei.com>
 <af03c8cf-2254-46f6-9b7e-790b255c8a1b@linux.alibaba.com>
 <20231019120647.00007589@Huawei.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20231019120647.00007589@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/10/19 19:06, Jonathan Cameron wrote:

...

>>>> +
>>>> +The DWC PCIe PMU driver registers a perf PMU driver, which provides
>>>> +description of available events and configuration options in sysfs, see
>>>> +/sys/bus/event_source/devices/dwc_rootport_{bdf}.
>>>> +
>>>> +The "format" directory describes format of the config fields of the
>>>> +perf_event_attr structure. The "events" directory provides configuration
>>>> +templates for all documented events.  For example,
>>>> +"Rx_PCIe_TLP_Data_Payload" is an equivalent of "eventid=0x22,type=0x1".
>>>> +
>>>> +The "perf list" command shall list the available events from sysfs, e.g.::
>>>> +
>>>> +    $# perf list | grep dwc_rootport
>>>> +    <...>
>>>> +    dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/        [Kernel PMU event]
>>>> +    <...>
>>>> +    dwc_rootport_3018/rx_memory_read,lane=?/               [Kernel PMU event]
>>>> +
>>>> +Time Based Analysis Event Usage
>>>> +-------------------------------
>>>> +
>>>> +Example usage of counting PCIe RX TLP data payload (Units of 16 bytes)::
>>>> +
>>>> +    $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/
>>>> +
>>>> +The average RX/TX bandwidth can be calculated using the following formula:
>>>> +
>>>> +    PCIe RX Bandwidth = PCIE_RX_DATA * 16B / Measure_Time_Window
>>>> +    PCIe TX Bandwidth = PCIE_TX_DATA * 16B / Measure_Time_Window  
>>>
>>> Silly question (sorry I didn't raise it earlier) but can we make the interface
>>> more intuitive by just multiplying the counter value at point of read by 16?  
>>
>> Really a good suggestion, and it is very convenient for end perf users.
>> But the unit of 16 is only applied to group#1 as described in Time Based Analysis
>> section.
> 
> How hard would it be to just apply it to those events?
> Userspace doesn't care what the hardware does underneath - it just wants to get
> moderately intuitive data back. Having the end user deal with this oddity + even
> the need to document it seems to me to be unnecessary burden given how simple it
> is (I assume) to remove the oddity.

Ok. Talked me into it :)
I will multiply the counter value at point of read by 16 for group#1 events.

Thank you.

Best Regards,
Shuai
