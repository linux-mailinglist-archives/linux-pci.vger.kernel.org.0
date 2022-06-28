Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A3655E3FD
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346068AbiF1NDl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 09:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346419AbiF1NDV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 09:03:21 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3101C25C46
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 06:03:19 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx_08G_LpisKthAA--.7678S3;
        Tue, 28 Jun 2022 21:03:02 +0800 (CST)
Subject: Re: [PATCH V14 4/7] PCI: loongson: Don't access non-existant devices
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220627213847.GA1777956@bhelgaas>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <4dbddb05-a0b4-047e-8784-c89279221f20@loongson.cn>
Date:   Tue, 28 Jun 2022 21:03:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220627213847.GA1777956@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dx_08G_LpisKthAA--.7678S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1xWr4UAr17Ary7tFyxXwb_yoWrAFy7pa
        y5Ja4SyF45tr12v3s2vF18W34aqFs3J3s5Jr4ay34q9r90yryFqrWDtFyYy347Jrs5WF1Y
        va9FqF1fGFWDAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBa1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
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



On 2022/6/28 上午5:38, Bjorn Helgaas wrote:
> On Fri, Jun 17, 2022 at 03:43:27PM +0800, Huacai Chen wrote:
>> On LS2K/LS7A, some non-existant devices don't return 0xffffffff when
>> scanning. This is a hardware flaw but we can only avoid it by software
>> now.
> 
> We should say what *does* happen if we do a config read to a device
> that doesn't exit.  Machine check, hang, etc?
> 

The device is a hidden device(only for debug) that should not be 
scanned. If scanned in a non-normal way, the machine is hang(one case in 
ltp pci test can trigger the issue, which is explained blow).


>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>   drivers/pci/controller/pci-loongson.c | 19 +++++++++++++++++--
>>   1 file changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
>> index a1222fc15454..e22142f75d97 100644
>> --- a/drivers/pci/controller/pci-loongson.c
>> +++ b/drivers/pci/controller/pci-loongson.c
>> @@ -134,10 +134,20 @@ static void __iomem *cfg0_map(struct loongson_pci *priv, int bus,
>>   	return priv->cfg0_base + addroff;
>>   }
>>   
>> +static bool pdev_is_existant(unsigned char bus, unsigned int device, unsigned int function)
>> +{
>> +	if ((bus == 0) && (device >= 9 && device <= 20) && (function > 0))
>> +		return false;
> 
> Why do you test pci_is_root_bus() below and "bus == 0" here?  I think
> you intend them both to test the same thing.  If so, I think you
> should test for "if (pci_is_root_bus(bus) ..." here.
> 

I agree, I think we can only use pci_is_root_bus to do the work.


> Generally speaking we only probe for functions > 0 if .0 is marked as
> multi-function, so I guess this means 00:09.0 is marked as a
> multi-function device, but config reads to 00:09.1 would fail?
> 

Yes, definitely. Actually, the 00:09.0 is a single device, so fun1(09.1)
will not be scanned(e.g. the fun1 will be not scanned on pci enumeration
during kernel booting).

But, there is one situation: when running ltp pci test case on LS7A,
the 00:08.2 is a sata controller(a valid device), and the bus number(0)
and devfn(0x42) are inputted to kernel api pci_scan_slot(), which has
clear note: devfn must have zero function. So, apparently, the inputted
devfn's function is not zero, but 2, and then in the pci_scan_slot():


         for (fn = next_fn(bus, dev, 0); fn > 0; fn = next_fn(bus, dev, 
fn)) {
                 dev = pci_scan_single_device(bus, devfn + fn);
                 ...
         }


08.2,08.3...and 09.1 will be scanned one by one, so the 09.1(fun1) is
scanned.

>> +	return true;
> 
> Returning "true" here means "the device *may* exist," not "this device
> *does* exist," right?  If so, the function name probably should be
> "pdev_may_exist()".
> 

Yes, I think pdev_may_exist maybe better.

> I guess that when we do a config read to a non-root bus device that
> doesn't exist, e.g., "01:00.0", that read terminates with an
> Unsupported Request error, the config read gets the ~0 data we expect?
> 

Yes, I think so.

>> +}
>> +
>>   static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devfn,
>>   			       int where)
>>   {
>>   	unsigned char busnum = bus->number;
>> +	unsigned int device = PCI_SLOT(devfn);
>> +	unsigned int function = PCI_FUNC(devfn);
>>   	struct loongson_pci *priv = pci_bus_to_loongson_pci(bus);
>>   
>>   	if (pci_is_root_bus(bus))
>> @@ -147,8 +157,13 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
>>   	 * Do not read more than one device on the bus other than
>>   	 * the host bus.
>>   	 */
>> -	if (priv->data->flags & FLAG_DEV_FIX &&
>> -			!pci_is_root_bus(bus) && PCI_SLOT(devfn) > 0)
>> +	if ((priv->data->flags & FLAG_DEV_FIX) && bus->self) {
>> +		if (!pci_is_root_bus(bus) && (device > 0))
>> +			return NULL;
>> +	}
>> +
>> +	/* Don't access non-existant devices */
>> +	if (!pdev_is_existant(busnum, device, function))
>>   		return NULL;
> 
> Is this a "forever" hardware bug that will never be fixed, or should
> there be a flag like FLAG_DEV_FIX so we only do this on the broken
> devices?
> 

No, the next new version LS7A will correct it, so maybe we can use 
FLAG_DEV_FIX-like to address it.

>>   	/* CFG0 can only access standard space */
>> -- 
>> 2.27.0
>>

