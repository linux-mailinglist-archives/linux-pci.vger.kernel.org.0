Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1575590A01
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 03:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbiHLBtB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Aug 2022 21:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiHLBtA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 21:49:00 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECF9A1A61
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 18:48:59 -0700 (PDT)
Received: from kwepemi500017.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M3mj3377pz1M8tF;
        Fri, 12 Aug 2022 09:45:43 +0800 (CST)
Received: from [10.67.103.235] (10.67.103.235) by
 kwepemi500017.china.huawei.com (7.221.188.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 09:48:56 +0800
Subject: Re: [REGRESSION] changes to driver_override parsing broke DPDK script
To:     Greg KH <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Huisong Li <lihuisong@huawei.com>
References: <20220809192102.GA1331186@bhelgaas>
 <af880c1a-cedd-181f-9b4d-2f1766312fc0@linaro.org>
 <YvNMFR1dgtShQJju@kroah.com> <YvNqnSGDKm0LyJwH@kroah.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <regressions@lists.linux.dev>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <872d304a-3aa0-53a4-c26a-3cb30594274d@huawei.com>
Date:   Fri, 12 Aug 2022 09:48:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YvNqnSGDKm0LyJwH@kroah.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.235]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500017.china.huawei.com (7.221.188.110)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

cc Huisong who found the issue.

On 2022/8/10 16:21, Greg KH wrote:
> On Wed, Aug 10, 2022 at 08:11:33AM +0200, Greg KH wrote:
>> On Wed, Aug 10, 2022 at 08:54:36AM +0300, Krzysztof Kozlowski wrote:
>>> On 09/08/2022 22:21, Bjorn Helgaas wrote:
>>>> [+cc regressions list]
>>>>
>>>> 23d99baf9d72 appeared in v5.19-rc1.
>>>>
>>>> On Tue, Aug 09, 2022 at 11:29:43AM -0700, Stephen Hemminger wrote:
>>>>> This commit broke the driver override script in DPDK.
>>>>> This is an API/ABI breakage, please revert or fix the commit.
>>>>>
>>>>> Report of problem:
>>>>> http://mails.dpdk.org/archives/dev/2022-August/247794.html
>>>
>>> Thanks for the report. I'll take a look.
>>>
>>>>>
>>>>>
>>>>> commit 23d99baf9d729ca30b2fb6798a7b403a37bfb800
>>>>> Author: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>> Date:   Tue Apr 19 13:34:28 2022 +0200
>>>>>
>>>>>     PCI: Use driver_set_override() instead of open-coding
>>>>>
>>>>>     Use a helper to set driver_override to the reduce amount of duplicated
>>>>>     code.  Make the driver_override field const char, because it is not
>>>>>     modified by the core and it matches other subsystems.
>>>>>
>>>>>     Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>>>>     Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>>>>     Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>     Link: https://lore.kernel.org/r/20220419113435.246203-6-krzysztof.kozlowski@linaro.org
>>>>>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>
>>>>>
>>>>> The script is sending single nul character to remove override
>>>>> and that no longer works.
>>>
>>> The sysfs API clearly states:
>>> "and
>>>  may be cleared with an empty string (echo > driver_override)."
>>> Documentation/ABI/testing/sysfs-bus-pci
>>>
>>> Sending other data and expecting the same result is not conforming to
>>> API. Therefore we have usual example of some undocumented behavior which
>>> user-space started relying on and instead using API, user-space expect
>>> that undocumented behavior to be back.
>>>
>>> Yay! I wonder what is the point to even describe the ABI if user-space
>>> can simply ignore it?
>>
>> One can argue that a string of just '\0' is an "empty string" and we
>> should be able to properly handle this in the kernel.  Heck,
>> "\0\0\0\0\0\0" is also an "empty string", right?
>>
>> I don't have an issue with fixing the kernel up here, it should be able
>> to handle this.
>
> Stephen, does the patch below fix this for you?
>
> thanks,
>
> greg k-h
>
> -----------------
>
> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> index 15a75afe6b84..676b6275d5b5 100644
> --- a/drivers/base/driver.c
> +++ b/drivers/base/driver.c
> @@ -63,6 +63,12 @@ int driver_set_override(struct device *dev, const char **override,
>  	if (len >= (PAGE_SIZE - 1))
>  		return -EINVAL;
>
> +	/*
> +	 * Compute the real length of the string in case userspace sends us a
> +	 * bunch of \0 characters like python likes to do.
> +	 */
> +	len = strlen(s);
> +
>  	if (!len) {
>  		/* Empty string passed - clear override */
>  		device_lock(dev);
> .
>
This patch looks good,  @huisong, please help to test the patch.

Thanks,
Dongdong
