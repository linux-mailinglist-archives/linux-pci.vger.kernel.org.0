Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFAA55F271
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 02:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiF2Ade (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 20:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiF2Adc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 20:33:32 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE4C7140F9
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 17:33:30 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxL9fQnbtiaK5iAA--.10601S3;
        Wed, 29 Jun 2022 08:33:20 +0800 (CST)
Subject: Re: [PATCH V14 4/7] PCI: loongson: Don't access non-existant devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220628160402.GA1842175@bhelgaas>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <3d0b6e83-e653-7cab-4a87-02aa00a806a0@loongson.cn>
Date:   Wed, 29 Jun 2022 08:33:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220628160402.GA1842175@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxL9fQnbtiaK5iAA--.10601S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4xKryftr45ZryDCrW3Wrg_yoW5ur1Dpa
        y5XFn2kF4DKr1Iy3s2vw1Fqay5tFW3KayrJr1rJr1kCws0vrySyFsFgr4jk34DJr4kZ3W2
        vayqqFWrKryDAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        ACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
        W5Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022/6/29 上午12:04, Bjorn Helgaas wrote:
> On Tue, Jun 28, 2022 at 09:03:02PM +0800, Jianmin Lv wrote:
>> On 2022/6/28 上午5:38, Bjorn Helgaas wrote:
>>> On Fri, Jun 17, 2022 at 03:43:27PM +0800, Huacai Chen wrote:
>>>> On LS2K/LS7A, some non-existant devices don't return 0xffffffff when
>>>> scanning. This is a hardware flaw but we can only avoid it by software
>>>> now.
>>>
>>> We should say what *does* happen if we do a config read to a device
>>> that doesn't exit.  Machine check, hang, etc?
>>
>> The device is a hidden device(only for debug) that should not be
>> scanned. If scanned in a non-normal way, the machine is hang(one
>> case in ltp pci test can trigger the issue, which is explained
>> below).
> 
> Reading the Vendor ID is the *normal* way to scan for a device.  It
> seems that this hardware just hangs in some cases when the device
> doesn't exist.
> 
>>> Generally speaking we only probe for functions > 0 if .0 is marked as
>>> multi-function, so I guess this means 00:09.0 is marked as a
>>> multi-function device, but config reads to 00:09.1 would fail?
>>
>> Yes, definitely. Actually, the 00:09.0 is a single device, so fun1(09.1)
>> will not be scanned(e.g. the fun1 will be not scanned on pci enumeration
>> during kernel booting).
>>
>> But, there is one situation: when running ltp pci test case on LS7A,
>> the 00:08.2 is a sata controller(a valid device), and the bus number(0)
>> and devfn(0x42) are inputted to kernel api pci_scan_slot(), which has
>> clear note: devfn must have zero function. So, apparently, the inputted
>> devfn's function is not zero, but 2, and then in the pci_scan_slot():
>>
>>          for (fn = next_fn(bus, dev, 0); fn > 0; fn = next_fn(bus, dev, fn))
>> {
>>                  dev = pci_scan_single_device(bus, devfn + fn);
>>                  ...
>>          }
>>
>> 08.2,08.3...and 09.1 will be scanned one by one, so the 09.1(fun1) is
>> scanned.
> 
> Does the "((bus == 0) && (device >= 9 && device <= 20) && (function > 0))"
> test catch *all* devfns where the hang occurs?  I wouldn't want to
> only avoid the ones that LTP happens to use.  If we did that, a future
> LTP change could easily break things again.  But I assume you know
> exactly what devices are present on the root bus.
> 

Yes, as you said, I'm sure that only these hidden functions(fun1 of dev 
9 to 20) on root bus can cause issue, so this fix is enough to address it.

>>>> -	if (priv->data->flags & FLAG_DEV_FIX &&
>>>> -			!pci_is_root_bus(bus) && PCI_SLOT(devfn) > 0)
>>>> +	if ((priv->data->flags & FLAG_DEV_FIX) && bus->self) {
>>>> +		if (!pci_is_root_bus(bus) && (device > 0))
>>>> +			return NULL;
>>>> +	}
>>>> +
>>>> +	/* Don't access non-existant devices */
>>>> +	if (!pdev_is_existant(busnum, device, function))
>>>>    		return NULL;
>>>
>>> Is this a "forever" hardware bug that will never be fixed, or should
>>> there be a flag like FLAG_DEV_FIX so we only do this on the broken
>>> devices?
>>
>> No, the next new version LS7A will correct it, so maybe we can use
>> FLAG_DEV_FIX-like to address it.
> 
> You should add the flag now instead of waiting for the new hardware.
> Otherwise you may not remember or notice the need to make this
> conditional on the hardware version, you'll wonder why the fixed
> hardware doesn't enumerate devices correctly.
> 

Thanks for your suggestion, I agree that, Huacai, WDYT?


> Bjorn
> 

