Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9511B768ED3
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 09:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjGaHcB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 03:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjGaHbf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 03:31:35 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D474EDC;
        Mon, 31 Jul 2023 00:30:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VoaPEop_1690788632;
Received: from 30.240.113.95(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VoaPEop_1690788632)
          by smtp.aliyun-inc.com;
          Mon, 31 Jul 2023 15:30:34 +0800
Message-ID: <375a0706-b76e-e8a8-cdac-ed628af6643c@linux.alibaba.com>
Date:   Mon, 31 Jul 2023 15:30:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.1
Subject: Re: [PATCH v6 0/4] drivers/perf: add Synopsys DesignWare PCIe PMU
 driver support
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        yangyicong@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com
References: <20230725205955.GA665326@bhelgaas>
 <634f4762-cf2e-4535-f369-4032d65093f0@linux.alibaba.com>
 <20230728133926.GC21394@willie-the-truck>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20230728133926.GC21394@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/7/28 21:39, Will Deacon wrote:
> On Thu, Jul 27, 2023 at 11:45:22AM +0800, Shuai Xue wrote:
>>
>>
>> On 2023/7/26 04:59, Bjorn Helgaas wrote:
>>> On Mon, Jul 24, 2023 at 10:18:07AM +0100, Jonathan Cameron wrote:
>>>> On Mon, 24 Jul 2023 10:34:08 +0800
>>>> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>>>> On 2023/7/10 20:04, Shuai Xue wrote:
>>>>>> On 2023/6/16 16:39, Shuai Xue wrote:  
>>>>>>> On 2023/6/6 15:49, Shuai Xue wrote:  
>>>
>>>>>>>> This patchset adds the PCIe Performance Monitoring Unit (PMU) driver support
>>>>>>>> for T-Head Yitian 710 SoC chip. Yitian 710 is based on the Synopsys PCI Express
>>>>>>>> Core controller IP which provides statistics feature.
>>>
>>>> ...
>>>> Really a question for Bjorn I think, but here is my 2 cents...
>>>>
>>>> The problem here is that we need to do that fundamental redesign of the
>>>> way the PCI ports drivers work.  I'm not sure there is a path to merging
>>>> this until that is done.  The bigger problem is that I'm not sure anyone
>>>> is actively looking at that yet.  I'd like to look at this (as I have
>>>> the same problem for some other drivers), but it is behind various
>>>> other things on my todo list.
>>>>
>>>> Bjorn might be persuaded on a temporary solution, but that would come
>>>> with some maintenance problems, particularly when we try to do it
>>>> 'right' in the future.  Maybe adding another service driver would be
>>>> a stop gap as long as we know we won't keep doing so for ever. Not sure.
>>>
>>> I think the question here is around the for_each_pci_dev() in
>>> __dwc_pcie_pmu_probe()?  I don't *like* that because of the
>>> assumptions it breaks (autoload doesn't work, hotplug doesn't work),
>>> but:
>>>
>>>   - There are several other drivers that also do this,
>>>   - I don't have a better suggest for any of them,
>>>   - It's not a drivers/pci thing, so not really up to me anyway,
>>>
>>> so I don't have any problem with this being merged as-is, as long as
>>> you can live with the limitations.
>>>
>>> I don't think this series does anything to work around those
>>> limitations, i.e., it doesn't make up fake device IDs for module
>>> loading or fake events for hotplug, so it seems like we could improve
>>> the implementation later if we ever have a way to do it.
>>>
>>> Bjorn
>>
>> + Will
>>
>> Ok, thank you for confirmation, Bjorn. Then it comes to perf driver parts and
>> it is really a question for @Will I think.
>>
>> What's your opinion about merging this patch set, @Will?
> 
> No fundamental objection from me, but I'll have a closer look when you
> post a version addressing the feedback from Jonathan and Yicong.

Thanks for your input! I appreciate that you don't have any fundamental objections
to merging the patch set. I'll definitely take into account the feedback from Jonathan
and Yicong before posting a revised version.


Best Regards,
Cheers.
Shuai
