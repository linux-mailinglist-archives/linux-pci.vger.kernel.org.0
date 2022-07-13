Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D470E5735C8
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 13:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiGMLs5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 07:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbiGMLs5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 07:48:57 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F8D232EE0
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 04:48:55 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx_9AWsc5iRH0bAA--.18974S3;
        Wed, 13 Jul 2022 19:48:39 +0800 (CST)
Subject: Re: [PATCH V15 3/7] PCI: loongson: Add ACPI init support
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220713033750.GA796301@bhelgaas>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <fc48989a-0375-e8f6-d0a1-ab92c86e4620@loongson.cn>
Date:   Wed, 13 Jul 2022 19:48:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220713033750.GA796301@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dx_9AWsc5iRH0bAA--.18974S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1rZF17uw43Jr1UGryxAFb_yoW5Cr1xpF
        WYvw40kFs5JryUKrWvq3yUZr13Ar98X3s3JrW2k3s8A3s0vw1IgFyFkF1jkF4fCrs5Wa4Y
        vF4fZrn7GFyDta7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBa1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
        GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4
        x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
        1cAE67vIY487MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r
        yrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022/7/13 上午11:37, Bjorn Helgaas wrote:
> On Sat, Jul 02, 2022 at 05:08:04PM +0800, Huacai Chen wrote:
>> Loongson PCH (LS7A chipset) will be used by both MIPS-based and
>> LoongArch-based Loongson processors. MIPS-based Loongson uses FDT
>> while LoongArch-base Loongson uses ACPI, this patch add ACPI init
>> support for the driver in drivers/pci/controller/pci-loongson.c
>> because it is currently FDT-only.
> 
>> +static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
>> +{
>> +	struct pci_config_window *cfg;
>> +
>> +	if (acpi_disabled)
>> +		return (struct loongson_pci *)(bus->sysdata);
>> +	else {
>> +		cfg = bus->sysdata;
>> +		return (struct loongson_pci *)(cfg->priv);
>> +	}
> 
> I rewrote this locally as:
> 
>    if (acpi_disabled)
>      return (struct loongson_pci *)(bus->sysdata);
> 
>    cfg = bus->sysdata;
>    return (struct loongson_pci *)(cfg->priv);
> 
> to avoid the asymmetry of braces/no braces.
> 

Agree, I think we can change it as here in next version.


>> @@ -124,12 +138,14 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
>>   			       int where)
>>   {
>>   	unsigned char busnum = bus->number;
>> -	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
>> -	struct loongson_pci *priv =  pci_host_bridge_priv(bridge);
>> +	struct loongson_pci *priv = pci_bus_to_loongson_pci(bus);
>> +
>> +	if (pci_is_root_bus(bus))
>> +		busnum = 0;
> 
> I asked you about this before [1], but I don't understand the answer.
> 
> Let's say the root bus is 40 and we have this:
> 
>    40:00.0 Root Port to [bus 41]
>    41:00.0 NIC
> 
> When we read the Vendor ID for 40:00.0:
> 
>    pci_loongson_map_bus(bus 40, 00.0, 0)
>      if (pci_is_root_bus(bus))       # true
>        busnum = 0;
>      cfg0_map(priv, 0x00, 00.0, 0);
>        if (bus != 0)                 # false
>          ...
>        addroff |= (0 << 16) | (0 << 8) | 0;
> 
> but for 41:00.0:
> 
>    pci_loongson_map_bus(bus 41, 00.0, 0)
>      if (pci_is_root_bus(bus))       # false
>        ...
>      cfg0_map(priv, 0x41, 00.0, 0);
>        if (bus != 0)                 # true
>          addroff |= BIT(24);
>        addroff |= (0x41 << 16) | (0 << 8) | 0;
> 
> Maybe the point is that for accesses to the root bus (which are always
> Type 0 accesses), you never put "bus << 16" into addroff, no matter
> what the actual root bus number is?
> 

Yes, indeed.


> If that's the case, I think you should instead make cfg0_map() look
> like this:
> 
>    cfg0_map(struct pci_bus *bus, ...)
>    {
>      unsigned long addroff = 0x0;
> 
>      if (!pci_is_root_bus(bus)) {
>        addroff |= BIT(24);
>        addroff |= (bus << 16);
>      }
>      addroff |= (devfn << 8) | where;
>      return priv->cfg0_base + addroff;
>    }
> 
> Then you don't need to do the weird busnum override in
> pci_loongson_map_bus(), and the root bus checking is in one place
> (cfg0_map()) instead of being split between pci_loongson_map_bus() and
> cfg0_map().  Same for cfg1_map(), obviously.
> 

Thanks very much for your suggestion, that looks more reasonable than
before, we'll put pci_is_root_bus in cfg0_map/cfg1_map to check root
bus as your code here.


> [1] https://lore.kernel.org/r/20220531230437.GA793965@bhelgaas
> 

