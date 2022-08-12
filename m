Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8500590A6B
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 04:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbiHLCyn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Aug 2022 22:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiHLCym (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 22:54:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB748A2863
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 19:54:41 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M3p9D0xvCzlW89;
        Fri, 12 Aug 2022 10:51:44 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 10:54:40 +0800
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 10:54:39 +0800
Message-ID: <f8825129-1566-df86-ade3-8d2885ce90b3@huawei.com>
Date:   Fri, 12 Aug 2022 10:54:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [REGRESSION] changes to driver_override parsing broke DPDK script
To:     Dongdong Liu <liudongdong3@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Hemminger <stephen@networkplumber.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <regressions@lists.linux.dev>
References: <20220809192102.GA1331186@bhelgaas>
 <af880c1a-cedd-181f-9b4d-2f1766312fc0@linaro.org>
 <YvNMFR1dgtShQJju@kroah.com> <YvNqnSGDKm0LyJwH@kroah.com>
 <872d304a-3aa0-53a4-c26a-3cb30594274d@huawei.com>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <872d304a-3aa0-53a4-c26a-3cb30594274d@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


在 2022/8/12 9:48, Dongdong Liu 写道:
> cc Huisong who found the issue.
>
> On 2022/8/10 16:21, Greg KH wrote:
>> On Wed, Aug 10, 2022 at 08:11:33AM +0200, Greg KH wrote:
>>> On Wed, Aug 10, 2022 at 08:54:36AM +0300, Krzysztof Kozlowski wrote:
>>>> On 09/08/2022 22:21, Bjorn Helgaas wrote:
>>>>> [+cc regressions list]
>>>>>
>>>>> 23d99baf9d72 appeared in v5.19-rc1.
>>>>>
>>>>> On Tue, Aug 09, 2022 at 11:29:43AM -0700, Stephen Hemminger wrote:
>>>>>> This commit broke the driver override script in DPDK.
>>>>>> This is an API/ABI breakage, please revert or fix the commit.
>>>>>>
>>>>>> Report of problem:
>>>>>> http://mails.dpdk.org/archives/dev/2022-August/247794.html
>>>>
>>>> Thanks for the report. I'll take a look.
>>>>
>>>>>>
>>>>>>
>>>>>> commit 23d99baf9d729ca30b2fb6798a7b403a37bfb800
>>>>>> Author: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>> Date:   Tue Apr 19 13:34:28 2022 +0200
>>>>>>
>>>>>>     PCI: Use driver_set_override() instead of open-coding
>>>>>>
>>>>>>     Use a helper to set driver_override to the reduce amount of 
>>>>>> duplicated
>>>>>>     code.  Make the driver_override field const char, because it 
>>>>>> is not
>>>>>>     modified by the core and it matches other subsystems.
>>>>>>
>>>>>>     Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>>>>>     Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>>>>>     Signed-off-by: Krzysztof Kozlowski 
>>>>>> <krzysztof.kozlowski@linaro.org>
>>>>>>     Link: 
>>>>>> https://lore.kernel.org/r/20220419113435.246203-6-krzysztof.kozlowski@linaro.org
>>>>>>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>>
>>>>>>
>>>>>> The script is sending single nul character to remove override
>>>>>> and that no longer works.
>>>>
>>>> The sysfs API clearly states:
>>>> "and
>>>>  may be cleared with an empty string (echo > driver_override)."
>>>> Documentation/ABI/testing/sysfs-bus-pci
>>>>
>>>> Sending other data and expecting the same result is not conforming to
>>>> API. Therefore we have usual example of some undocumented behavior 
>>>> which
>>>> user-space started relying on and instead using API, user-space expect
>>>> that undocumented behavior to be back.
>>>>
>>>> Yay! I wonder what is the point to even describe the ABI if user-space
>>>> can simply ignore it?
>>>
>>> One can argue that a string of just '\0' is an "empty string" and we
>>> should be able to properly handle this in the kernel.  Heck,
>>> "\0\0\0\0\0\0" is also an "empty string", right?
>>>
>>> I don't have an issue with fixing the kernel up here, it should be able
>>> to handle this.
>>
>> Stephen, does the patch below fix this for you?
>>
>> thanks,
>>
>> greg k-h
>>
>> -----------------
>>
>> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
>> index 15a75afe6b84..676b6275d5b5 100644
>> --- a/drivers/base/driver.c
>> +++ b/drivers/base/driver.c
>> @@ -63,6 +63,12 @@ int driver_set_override(struct device *dev, const 
>> char **override,
>>      if (len >= (PAGE_SIZE - 1))
>>          return -EINVAL;
>>
>> +    /*
>> +     * Compute the real length of the string in case userspace sends 
>> us a
>> +     * bunch of \0 characters like python likes to do.
>> +     */
>> +    len = strlen(s);
>> +
>>      if (!len) {
>>          /* Empty string passed - clear override */
>>          device_lock(dev);
>> .
>>
> This patch looks good,  @huisong, please help to test the patch.
>
> Thanks,
> Dongdong
> .
Tested-by: Huisong Li <lihuisong@huawei.com>
