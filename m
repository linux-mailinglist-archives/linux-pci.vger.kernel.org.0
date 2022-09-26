Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346305EAB8D
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 17:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiIZPsB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 11:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiIZPrd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 11:47:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 826A84BA53;
        Mon, 26 Sep 2022 07:32:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E01461042;
        Mon, 26 Sep 2022 07:32:59 -0700 (PDT)
Received: from [10.57.65.170] (unknown [10.57.65.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D5083F73B;
        Mon, 26 Sep 2022 07:32:51 -0700 (PDT)
Message-ID: <ae249149-a17f-7652-729b-262a977080a5@arm.com>
Date:   Mon, 26 Sep 2022 15:32:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 2/3] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-GB
To:     Shuai Xue <xueshuai@linux.alibaba.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, baolin.wang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com, linux-pci@vger.kernel.org
References: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
 <20220917121036.14864-3-xueshuai@linux.alibaba.com>
 <20220922165820.000017b6@huawei.com>
 <d4edc6f4-e56f-4a19-3c34-b65d4903bfc0@linux.alibaba.com>
 <20220923165423.00007dc6@huawei.com>
 <89efd20f-65f2-c082-1eb4-4e308957ff59@linux.alibaba.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <89efd20f-65f2-c082-1eb4-4e308957ff59@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-09-26 14:31, Shuai Xue wrote:
> + Bjorn Helgaas
> 
> 在 2022/9/23 PM11:54, Jonathan Cameron 写道:
>>
>>>
>>>>    
>>>>> +#define RP_NUM_MAX				32 /* 2die * 4RC * 4Ctrol */
>>>>
>>>> This driver is 'almost' generic. So if you an avoid defines based on a particular
>>>> platform that's definitely good!
>>>
>>> Good idea. How about defining RP_NUM_MAX as 64? As fars as I know,
>>> some platfrom use 2 sockets, 2 die per socket.
>>> Then 2 sockets * 2 dies * 4 Root Complex * 4 root port.
>>
>> Setting a reasonable maximum is fine - but make sure the code then fails with
>> a suitable error message if there are more!
> 
> OK, I will add a discovery logic here and count PMU number at runtime.
> 
>>
>>
>>>>> +#define DWC_PCIE_LANE_SHIFT			4
>>>>> +#define DWC_PCIE_LANE_MASK			GENMASK(9, 4)
>>>>> +
>>>>> +#define DWC_PCIE_EVENT_CNT_CTRL			0x8
>>>>> +#define DWC_PCIE__CNT_EVENT_SELECT_SHIFT	16
>>>>
>>>> Why double __?  If point is , then
>>>> naming works better
>>>> DWC_PCIE_EVENT_CNT_CTRL_REG
>>>> DWC_PCIE_EVENT_CNT_CTRL_EV_SELECT_MSK etc
>>>
>>> Yes, I point to use double `__` to indicate it is a field of register,
>>> as CMN and CCN drivers do. I also considered naming with REG explicitly,
>>> but the macro is so long that I often have to wrap code into multilines.
>>> Any way, it's fine to rename if you still suggest to do so.
>>
>> I don't particularly mind.  This convention was new to me.
> 
> Haha, then I will leave the double `__` as CMN and CCN drivers do.

FWIW I'm not sure there's really any convention. CCN seems to use 
double-underscores as distinct separators in a consistent 
CCN_REG_NAME__FIELD_NAME__SUFFIX pattern. Conversely in CMN I used it as 
an indication of the usual CMN_REG_NAME_FIELD_NAME_VALUE pattern being 
abbreviated where it would have been uncomfortably long otherwise (and 
particularly where the field name reflects the register name anyway); it 
just seemed like a good visual cue to imply that something was missing.

Robin.
