Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F826194B7
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 11:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiKDKni (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Nov 2022 06:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKDKnh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Nov 2022 06:43:37 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2361F2654F;
        Fri,  4 Nov 2022 03:43:34 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.77])
        by gateway (Coremail) with SMTP id _____8CxrrfV7GRjXn0EAA--.10538S3;
        Fri, 04 Nov 2022 18:43:33 +0800 (CST)
Received: from [10.20.42.77] (unknown [10.20.42.77])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxj+DV7GRjqmgNAA--.37553S3;
        Fri, 04 Nov 2022 18:43:33 +0800 (CST)
Subject: Re: [PATCH v2 1/1] PCI: loongson: skip scanning unavailable child
 device
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221104072730.14631-1-liupeibao@loongson.cn>
 <d2f7deb7-ebe0-d880-1c4b-a210d65c6223@wanadoo.fr>
From:   Liu Peibao <liupeibao@loongson.cn>
Message-ID: <ea68d96d-a77e-aa68-0850-31bc232d4946@loongson.cn>
Date:   Fri, 4 Nov 2022 18:43:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d2f7deb7-ebe0-d880-1c4b-a210d65c6223@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxj+DV7GRjqmgNAA--.37553S3
X-CM-SenderInfo: xolx1vpled0qxorr0wxvrqhubq/1tbiAQAACmNjr2MbmQAAsF
X-Coremail-Antispam: 1Uk129KBjvJXoW7Aw4xury3AF4fuw4DKF4xCrg_yoW8Zw4UpF
        n5JFWUGrW8Jrn5Jr18tryUJFy5Zr1DJ3Z8Jr18uF1Utr47Ar10gr1UXr1q9ryUJr48Gr1U
        Jr1UXrnrZr17JrDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCa
        FVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0b6pPUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/4/22 4:43 PM, Christophe JAILLET wrote:
> Le 04/11/2022 à 08:27, Liu Peibao a écrit :
>>   +#ifdef CONFIG_OF
>> +    /* Don't access devices in masklist */
>> +    if (pci_is_root_bus(bus)) {
>> +        struct list_head *list;
>> +        struct mask_entry *entry;
>> +
>> +        list_for_each(list, &priv->masklist) {
>> +            entry = list_entry(list, struct mask_entry, entry);
> 
> Hi,
> 
> list_for_each_entry() is slighly less verbose.
> 

OK, I will update the patch with list_for_each_entry().

>> +            if (devfn == entry->devfn)
>> +                return NULL;
>> +        }
>> +    }
>> +#endif
>> +
>>       /* CFG0 can only access standard space */
>>       if (where < PCI_CFG_SPACE_SIZE && priv->cfg0_base)
>>           return cfg0_map(priv, bus, devfn, where);
>> @@ -206,6 +230,36 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus,
>>   }
>>     #ifdef CONFIG_OF
>> +static int setup_masklist(struct loongson_pci *priv)
>> +{
>> +    struct device *dev = &priv->pdev->dev;
>> +    struct device_node *dn, *parent = dev->of_node;
>> +    struct mask_entry *entry;
>> +    int devfn;
>> +
>> +    INIT_LIST_HEAD(&priv->masklist);
>> +
>> +    for_each_child_of_node(parent, dn) {
>> +        /*
>> +         * if device is not available, add this to masklist
>> +         * to avoid scanning it.
>> +         */
>> +        if (!of_device_is_available(dn)) {
>> +            devfn = of_pci_get_devfn(dn);
>> +            if (devfn < 0)
>> +                continue;
>> +
>> +            entry = devm_kzalloc(dev, sizeof(entry), GFP_KERNEL);
> 
> sizeof(*entry)?
>

That really is a bug, thanks!

BR,
Peibao
 
>> +            if (!entry)
>> +                return -ENOMEM;
>> +

