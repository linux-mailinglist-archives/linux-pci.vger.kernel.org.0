Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE2062D0F0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 03:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiKQCFF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 21:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiKQCFE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 21:05:04 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 711187678;
        Wed, 16 Nov 2022 18:05:02 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.77])
        by gateway (Coremail) with SMTP id _____8BxLtvNlnVj2SEIAA--.23346S3;
        Thu, 17 Nov 2022 10:05:01 +0800 (CST)
Received: from [10.20.42.77] (unknown [10.20.42.77])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxqFfMlnVjspAVAA--.38831S3;
        Thu, 17 Nov 2022 10:05:00 +0800 (CST)
Subject: Re: [PATCH V5] PCI: loongson: Skip scanning unavailable child devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        wanghongliang <wanghongliang@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221116181446.GA1126453@bhelgaas>
From:   Liu Peibao <liupeibao@loongson.cn>
Message-ID: <50ca749f-beb1-4a52-d0c5-cc503cbd3563@loongson.cn>
Date:   Thu, 17 Nov 2022 10:05:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221116181446.GA1126453@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxqFfMlnVjspAVAA--.38831S3
X-CM-SenderInfo: xolx1vpled0qxorr0wxvrqhubq/1tbiAQANCmN00uUg2AAAse
X-Coremail-Antispam: 1Uk129KBjvJXoW7uF1xCr1fur1DZF43JFy3CFg_yoW8CrWDpF
        W3WFWrtF4DKr129rnrXw45ur98Aw47C3yrGF1kJF1akan8WryfGa4xGa15Xa13XryxWayS
        vFWjqrW0vF4jvaUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8HKZJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/17/22 2:14 AM, Bjorn Helgaas wrote:
> On Wed, Nov 16, 2022 at 05:57:46PM +0800, Liu Peibao wrote:
>> On 11/15/22 1:11 AM, Bjorn Helgaas wrote:
>>> On Mon, Nov 14, 2022 at 03:43:46PM +0800, Liu Peibao wrote:
> 
>>> I assume there's a single device in the hardware, and both the
>>> "platform device" and the PCI device" refer to that single device?
>>>
>>> And there's some reason you prefer to use the platform device
>>> interface to enumerate that device?
>>
>> No, they are not the same device. For example, GMAC1(on chip PCI device) and
>> GPIO(platform device, not PCI device) 14 use the same pin. The function for
>> this pin can be configured by one bit in general register, eg, 0 for GPIO 14,
>> 1 for GMAC1. Sometimes, GPIO 14 is preferred, so configure the pin with
>> function GPIO 14 and disable GMAC1.
> 
> Ah, I see, so there's some circuit that can be driven by either the
> platform (GPIO) device or the PCI (GMAC1) device.
> 

That is really the point. Sorry for my poor description and English :).

>> Overall, how about the following refactored commit log:
>>
>> "This patch adds a mechanism to disable on chip PCI devices by DT. Typically,
>> when there are pins shareable between the platform device and the on chip PCI
>> device, if the PCI device is not preferred, add `status = "disabled"` property
>> to this PCI device DT node.
>>
>> For example, on LS2K1000, GMAC1(on chip PCI device) and GPIO(platform device,
>> not PCI device) 14 share the same pin. If GMAC1 is not preferred, add
>> `status = "disabled"` property in GMAC1 DT node."
> 
>   Add a mechanism ...
> 
> (Instead of "This patch adds ..."; no need to say "this patch" because
> it's obvious that the commit log applies to *this patch*)
> 
> Add spaces before "(", e.g., "GMAC1 (on-chip PCI device)".
> 
> Looks good!
> 
> Bjorn
> 

I will modify these and send the next version patch.

Thanks a lot!

BR,
Peibao

