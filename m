Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA287CF7F0
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 14:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbjJSMDG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 08:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345641AbjJSMCt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 08:02:49 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05020D64;
        Thu, 19 Oct 2023 05:02:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VuTwcF3_1697716956;
Received: from 30.240.113.74(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VuTwcF3_1697716956)
          by smtp.aliyun-inc.com;
          Thu, 19 Oct 2023 20:02:38 +0800
Message-ID: <dacd7394-c57a-44ee-a506-3ae0aa9870f9@linux.alibaba.com>
Date:   Thu, 19 Oct 2023 20:02:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-US
To:     Yicong Yang <yangyicong@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     yangyicong@hisilicon.com, chengyou@linux.alibaba.com,
        kaishen@linux.alibaba.com, helgaas@kernel.org, will@kernel.org,
        baolin.wang@linux.alibaba.com, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
References: <20231017013235.27831-1-xueshuai@linux.alibaba.com>
 <20231017013235.27831-4-xueshuai@linux.alibaba.com>
 <20231017103959.00006ec3@Huawei.com>
 <0704f9f6-1e9a-4587-b92f-c799b932b755@linux.alibaba.com>
 <a14fc5c1-522b-ba7b-fabd-55ef8871a3b0@huawei.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <a14fc5c1-522b-ba7b-fabd-55ef8871a3b0@huawei.com>
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



On 2023/10/19 16:05, Yicong Yang wrote:
> On 2023/10/18 11:33, Shuai Xue wrote:
>>
...
>>
>>>
>>>> +		return PTR_ERR(dwc_pcie_pmu_dev);
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static void __exit dwc_pcie_pmu_exit(void)
>>>> +{
>>>> +	platform_device_unregister(dwc_pcie_pmu_dev);
>>>> +	platform_driver_unregister(&dwc_pcie_pmu_driver);
>>>> +	cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
>>>> +
>>>> +	if (dwc_pcie_pmu_notify)
>>>
>>> If you have something unusual like this a driver module_exit() it definitely
>>> deserves a comment on why.  I'm surprised by this as I'd expect the notifier
>>> to be unregistered in the driver remove so not sure why this is here.
>>> I've lost track of earlier discussions so if this was addressed then all
>>> we need is a comment here for the next person to run into it!
>>
>> All replied above, I will unregistered the notifier by devm_add_action_or_reset().
>>
>> I am curious about that what the difference between unregistered in module_exit()
>> and remove()?
>>
> 
> From my understanding, if you register it in probe() then should undo it in remove().
> Otherwise you should register it in module_init(). Just make them coupled to make
> sure cleanup the resources correctly.
> 
> This driver is a bit different since device and driver are created in module_init()
> so will works fine in most cases, because the device/driver removal will happens the
> same time when unloading the module. However if manually unbind the driver and device
> without unloading the module, we'll miss to unregister the notifier in the currently
> implementation.
> 

I see, thank you for your patient explanation.

Thank you.

Best Regards,
Shuai
