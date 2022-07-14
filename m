Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC41D5744F4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 08:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiGNGNe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 02:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbiGNGNU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 02:13:20 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6DF927B09
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 23:13:18 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxP9Lys89i1XEdAA--.21760S3;
        Thu, 14 Jul 2022 14:13:06 +0800 (CST)
Subject: Re: [PATCH V15 5/7] PCI: loongson: Improve the MRRS quirk for LS7A
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220713174256.GA838193@bhelgaas>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <073638a7-ae68-2847-ac3d-29e5e760d6af@loongson.cn>
Date:   Thu, 14 Jul 2022 14:13:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220713174256.GA838193@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxP9Lys89i1XEdAA--.21760S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AF18JryrKr1fCF47Aw4rAFb_yoW7ur47pF
        WrJa1jyFWFqF90vw1qvw4kur1rZFn3C3y8CFW3Gw1IyFnrC3Z0gFyYgF1Yva13AFWkWFy0
        vFWDGw4rCFs8KFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        ACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
        W5Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022/7/14 上午1:42, Bjorn Helgaas wrote:
> On Sat, Jul 02, 2022 at 05:08:06PM +0800, Huacai Chen wrote:
>> In new revision of LS7A, some PCIe ports support larger value than 256,
>> but their maximum supported MRRS values are not detectable. Moreover,
>> the current loongson_mrrs_quirk() cannot avoid devices increasing its
>> MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
>> will actually set a big value in its driver. So the only possible way
>> is configure MRRS of all devices in BIOS, and add a pci host bridge bit
>> flag (i.e., no_inc_mrrs) to stop the increasing MRRS operations.
>>
>> However, according to PCIe Spec, it is legal for an OS to program any
>> value for MRRS, and it is also legal for an endpoint to generate a Read
>> Request with any size up to its MRRS. As the hardware engineers say, the
>> root cause here is LS7A doesn't break up large read requests. In detail,
>> LS7A PCIe port reports CA (Completer Abort) if it receives a Memory Read
>> request with a size that's "too big" ("too big" means larger than the
>> PCIe ports can handle, which means 256 for some ports and 4096 for the
>> others, and of course this is a problem in the LS7A's hardware design).
> 
> How does this work for hot-added devices?  For native pciehp, there's
> no firmware involved, and MRRS powers up as 010b (512 bytes).  So
> this prevents us from increasing MRRS to anything larger than 512, but
> it sounds like some parts may not even be able to handle 512.
> 

Frankly, it doesn't any work for pciehp. Fortunately, pciehp is not 
supported on current Loongson 7A chipset revisions. But we have plan to 
support pciehp on newer revisions of 7A in future. And before that, the 
MRRS issue will be addressed first. So the bug fix in this patch will be 
only used for current 7A revisions which have no pciehp feature.


>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>   drivers/pci/controller/pci-loongson.c | 44 +++++++++------------------
>>   drivers/pci/pci.c                     |  6 ++++
>>   include/linux/pci.h                   |  1 +
>>   3 files changed, 22 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
>> index de5be6d9bcbc..c9479e52acf1 100644
>> --- a/drivers/pci/controller/pci-loongson.c
>> +++ b/drivers/pci/controller/pci-loongson.c
>> @@ -68,37 +68,23 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>   			DEV_LS7A_LPC, system_bus_quirk);
>>   
>> -static void loongson_mrrs_quirk(struct pci_dev *dev)
>> +static void loongson_mrrs_quirk(struct pci_dev *pdev)
>>   {
>> -	struct pci_bus *bus = dev->bus;
>> -	struct pci_dev *bridge;
>> -	static const struct pci_device_id bridge_devids[] = {
>> -		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
>> -		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
>> -		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
>> -		{ 0, },
>> -	};
>> -
>> -	/* look for the matching bridge */
>> -	while (!pci_is_root_bus(bus)) {
>> -		bridge = bus->self;
>> -		bus = bus->parent;
>> -		/*
>> -		 * Some Loongson PCIe ports have a h/w limitation of
>> -		 * 256 bytes maximum read request size. They can't handle
>> -		 * anything larger than this. So force this limit on
>> -		 * any devices attached under these ports.
>> -		 */
>> -		if (pci_match_id(bridge_devids, bridge)) {
>> -			if (pcie_get_readrq(dev) > 256) {
>> -				pci_info(dev, "limiting MRRS to 256\n");
>> -				pcie_set_readrq(dev, 256);
>> -			}
>> -			break;
>> -		}
>> -	}
>> +	/*
>> +	 * Some Loongson PCIe ports have h/w limitations of maximum read
>> +	 * request size. They can't handle anything larger than this. So
>> +	 * force this limit on any devices attached under these ports.
>> +	 */
>> +	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
>> +
>> +	bridge->no_inc_mrrs = 1;
>>   }
>> -DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>> +			DEV_PCIE_PORT_0, loongson_mrrs_quirk);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>> +			DEV_PCIE_PORT_1, loongson_mrrs_quirk);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>> +			DEV_PCIE_PORT_2, loongson_mrrs_quirk);
>>   
>>   static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
>>   {
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index cfaf40a540a8..79157cbad835 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -6052,6 +6052,7 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>>   {
>>   	u16 v;
>>   	int ret;
>> +	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
>>   
>>   	if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
>>   		return -EINVAL;
>> @@ -6070,6 +6071,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>>   
>>   	v = (ffs(rq) - 8) << 12;
>>   
>> +	if (bridge->no_inc_mrrs) {
>> +		if (rq > pcie_get_readrq(dev))
>> +			return -EINVAL;
>> +	}
>> +
>>   	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
>>   						  PCI_EXP_DEVCTL_READRQ, v);
>>   
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 81a57b498f22..a9211074add6 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -569,6 +569,7 @@ struct pci_host_bridge {
>>   	void		*release_data;
>>   	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>>   	unsigned int	no_ext_tags:1;		/* No Extended Tags */
>> +	unsigned int	no_inc_mrrs:1;		/* No Increase MRRS */
>>   	unsigned int	native_aer:1;		/* OS may use PCIe AER */
>>   	unsigned int	native_pcie_hotplug:1;	/* OS may use PCIe hotplug */
>>   	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
>> -- 
>> 2.27.0
>>

