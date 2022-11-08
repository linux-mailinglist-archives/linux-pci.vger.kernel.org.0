Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F44A6207E3
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 04:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiKHD5z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 22:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiKHD5y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 22:57:54 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0D0D30541;
        Mon,  7 Nov 2022 19:57:51 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.77])
        by gateway (Coremail) with SMTP id _____8BxGdi+02ljJzgFAA--.15331S3;
        Tue, 08 Nov 2022 11:57:50 +0800 (CST)
Received: from [10.20.42.77] (unknown [10.20.42.77])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxoOK902ljTsQOAA--.40796S3;
        Tue, 08 Nov 2022 11:57:49 +0800 (CST)
Subject: Re: [PATCH v3] PCI: loongson: skip scanning unavailable child device
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221107211525.GA419924@bhelgaas>
From:   Liu Peibao <liupeibao@loongson.cn>
Message-ID: <7f0f3c7c-9adb-2a05-c93c-44eb5e28e786@loongson.cn>
Date:   Tue, 8 Nov 2022 11:57:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221107211525.GA419924@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxoOK902ljTsQOAA--.40796S3
X-CM-SenderInfo: xolx1vpled0qxorr0wxvrqhubq/1tbiAQAECmNo9WQJ3wABsC
X-Coremail-Antispam: 1Uk129KBjvJXoWxXFyxKryUJF18Zw1ftrWrZrb_yoW5AFy7pF
        W5AFW3KF48tr13Cwnaq3y8CF1avF9aga4DJF43Cw17KasIk34xWryxJF4F93sIvr4UWF42
        vF1qgr4rGFs8AFDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
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

On 11/8/22 5:15 AM, Bjorn Helgaas wrote:
> Capitalize subject line to match other commits:
> 
>   930c6074d7dd ("PCI: loongson: Work around LS7A incorrect Interrupt Pin registers")
>   2410e3301fcc ("PCI: loongson: Don't access non-existent devices")
>   cd89edda4002 ("PCI: loongson: Add ACPI init support")
>   dee449aafd48 ("PCI: loongson: Use generic 8/16/32-bit config ops on LS2K/LS7A")
> 

OK, I will do this in the next version patch.

> On Fri, Nov 04, 2022 at 06:53:40PM +0800, Liu Peibao wrote:
>> The PCI Controller of 2k1000 could not mask devices by
>> setting vender id or device id in configuration space header
>> as invalid values. When there are pins shareble between
>> the platform device and PCI device, if the platform device
>> is preferred, we should not scan this PCI device. In the
>> above scene, add `status = "disabled"` property in DT node
>> of this PCI device.
> 
> Rewrap this to fill 75 columns.
> > s/id/ID/
> s/shareble/shareable/
> 

OK, I will take care in the next version patch.

>> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
>> ---
>> V2 -> V3: 1. use list_for_each_entry() for more clearly.
>>           2. fix wrong use of sizeof().
>> V1 -> V2: use existing property "status" instead of adding new property.
>>
>>
>>  drivers/pci/controller/pci-loongson.c | 55 +++++++++++++++++++++++++++
>>  1 file changed, 55 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
>> index 05c50408f13b..c7dd88eac885 100644
>> --- a/drivers/pci/controller/pci-loongson.c
>> +++ b/drivers/pci/controller/pci-loongson.c
>> @@ -40,11 +40,21 @@ struct loongson_pci_data {
>>  	struct pci_ops *ops;
>>  };
>>  
>> +#ifdef CONFIG_OF
>> +struct mask_entry {
>> +	struct list_head entry;
>> +	unsigned int devfn;
>> +};
>> +#endif
>> +
>>  struct loongson_pci {
>>  	void __iomem *cfg0_base;
>>  	void __iomem *cfg1_base;
>>  	struct platform_device *pdev;
>>  	const struct loongson_pci_data *data;
>> +#ifdef CONFIG_OF
>> +	struct list_head masklist;
>> +#endif
>>  };
>>  
>>  /* Fixup wrong class code in PCIe bridges */
>> @@ -194,6 +204,18 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus,
>>  			return NULL;
>>  	}
>>  
>> +#ifdef CONFIG_OF
>> +	/* Don't access devices in masklist */
>> +	if (pci_is_root_bus(bus)) {
>> +		struct mask_entry *entry;
>> +
>> +		list_for_each_entry(entry, &priv->masklist, entry) {
>> +			if (devfn == entry->devfn)
>> +				return NULL;
>> +		}
>> +	}
>> +#endif
> 
> I would probably get rid of the masklist and just search for a disabled
> property when reading config offset 0 (vendor ID).  That's not a
> performance path anyway.  And this seems similar to the
> FLAG_DEV_HIDDEN path where you probably don't need to do it for all
> controllers.
> 

Thanks for your idea! This really helps a lot!
I will follow your idea and rework it.

Yes, this is similar to the FLAG_DEV_HIDDEN path and currently, this path
is only needed by 2K1000 PCI controller.

BR,
Peibao

