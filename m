Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEE7627526
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 05:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbiKNEDc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Nov 2022 23:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbiKNED3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2022 23:03:29 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07169185;
        Sun, 13 Nov 2022 20:03:24 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.77])
        by gateway (Coremail) with SMTP id _____8DxOdgLvnFjbcsGAA--.18764S3;
        Mon, 14 Nov 2022 12:03:23 +0800 (CST)
Received: from [10.20.42.77] (unknown [10.20.42.77])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axf+AJvnFjX0ISAA--.49417S3;
        Mon, 14 Nov 2022 12:03:21 +0800 (CST)
Subject: Re: [PATCH V4] PCI: loongson: Skip scanning unavailable child devices
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20221110231351.GA681551@bhelgaas>
 <dfd408ed-5c2c-c73a-b901-6641ae7aae5f@flygoat.com>
From:   Liu Peibao <liupeibao@loongson.cn>
Message-ID: <855be31e-d3fe-bd7f-3abf-f07413973bd5@loongson.cn>
Date:   Mon, 14 Nov 2022 12:03:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <dfd408ed-5c2c-c73a-b901-6641ae7aae5f@flygoat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axf+AJvnFjX0ISAA--.49417S3
X-CM-SenderInfo: xolx1vpled0qxorr0wxvrqhubq/1tbiAQAKCmNw3mQJaAAAsJ
X-Coremail-Antispam: 1Uk129KBjvJXoWxZw45tr18JFyDZw1UZrW7twb_yoWrXF45pF
        95JFWakFZ5Kr18Kw1qqw18ZFy2yr4kJayDXrn5GF12krnIvr1jgry0vF1q9ry3Jr4kJF1j
        vF1jga47ZF45ZaUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

On 11/12/22 12:06 AM, Jiaxun Yang wrote:
> 
> 
> 在 2022/11/10 23:13, Bjorn Helgaas 写道:
>> On Thu, Nov 10, 2022 at 11:00:45PM +0000, Jiaxun Yang wrote:
>>> 在2022年11月10日十一月 下午9:07，Bjorn Helgaas写道：
>>>> On Tue, Nov 08, 2022 at 02:42:40PM +0800, Liu Peibao wrote:
>>>>> The PCI Controller of 2k1000 could not mask devices by setting vender ID or
>>>>> device ID in configuration space header as invalid values. When there are
>>>>> pins shareable between the platform device and PCI device, if the platform
>>>>> device is preferred, we should not scan this PCI device. In the above
>>>>> scene, add `status = "disabled"` property in DT node of this PCI device.
>>>>>
>>>>> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
>>>>> ---
>>>>> V3 -> V4: 1. get rid of the masklist and search the status property
>>>>>       directly.
>>>>>            2. check the status property only when accessing the vendor ID.
>>>>> V2 -> V3: 1. use list_for_each_entry() for more clearly.
>>>>>            2. fix wrong use of sizeof().
>>>>> V1 -> V2: use existing property "status" instead of adding new property.
>>>>>
>>>>>   drivers/pci/controller/pci-loongson.c | 11 +++++++++++
>>>>>   1 file changed, 11 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
>>>>> index 05c50408f13b..efca0b3b5a29 100644
>>>>> --- a/drivers/pci/controller/pci-loongson.c
>>>>> +++ b/drivers/pci/controller/pci-loongson.c
>>>>> @@ -194,6 +194,17 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus,
>>>>>               return NULL;
>>>>>       }
>>>>>   +#ifdef CONFIG_OF
>>>>> +    /* Don't access disabled devices. */
>>>>> +    if (pci_is_root_bus(bus) && where == PCI_VENDOR_ID) {
>>>>> +        struct device_node *dn;
>>>>> +
>>>>> +        dn = of_pci_find_child_device(bus->dev.of_node, devfn);
>>>>> +        if (dn && !of_device_is_available(dn))
>>>>> +            return NULL;
>>>>> +    }
>>>>> +#endif
>>>> Looks nice and simple, thanks for trying this out.
>>> Should we make this into common PCI code?
>>> I guess Loongson won’t be the last platform having such problem.
>> I think we should wait until somebody else has this problem.
>>
>> It's not a completely trivial situation because if the device uses PCI
>> memory or I/O space, we have to worry about how that space is handled.
>> Does the BIOS assign that space?  Is it included in the host bridge
>> _CRS or "ranges" properties?  If the device is below any PCI bridges
>> (I don't think that's the case in your situation), how does the space
>> it requires get routed through the bridges?
> 
> I believe in this case the address is assigned by BIOS and they are out of ranges
> properties of host bridge. Those are all on chip devices so there won't be any
> bridges.
> 
> @Peibao, can you please confirm this? I was never able to boot mainline kernel
> on my LS2K board.
> 
> Thanks.
> - Jiaxun
> 

@Jiaxun,

Yes, the same as you said totally.

Did you notice the following patch? The liointc of LS2K can't work after
commit b2c4c3969fd7 ("irqchip/loongson-liointc: irqchip add 2.0 version"),
which may cause the booting failure. 
https://lore.kernel.org/all/20221104110712.23300-1-liupeibao@loongson.cn/

In fact, I am developing this on the LoongArch compatible board LS2K1000LA.
I boot the mainline kernel basing my FDT supporting patch set for LoongArch
and the BIOS following current LoongArch booting protocol :).

BR,
Peibao

> 
>>
>> It would be nice to say something in this commit log about whether
>> these are issues on your platform.
>>

@Bjorn,

Thanks!

I will update commit log in the next patch to clear the issue on our platform,
which is absolutely what Jiaxun has described above.

BR,
Peibao

