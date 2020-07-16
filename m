Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A598A221A29
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 04:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgGPChk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 22:37:40 -0400
Received: from mail.loongson.cn ([114.242.206.163]:40816 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726998AbgGPChk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jul 2020 22:37:40 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9CxINdevQ9fumYFAA--.6663S3;
        Thu, 16 Jul 2020 10:37:19 +0800 (CST)
Subject: Re: [PATCH v3] PCI: loongson: Use DECLARE_PCI_FIXUP_EARLY for
 bridge_class_quirk()
To:     Huacai Chen <chenhc@lemote.com>
References: <1594865946-15188-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H7_J6oJOYujJqQqm-bpKH-ZKOy3y2yX0TFWzs5ywh=z_g@mail.gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <86b3d3bb-afd0-85a7-ffc3-959248ec450c@loongson.cn>
Date:   Thu, 16 Jul 2020 10:37:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7_J6oJOYujJqQqm-bpKH-ZKOy3y2yX0TFWzs5ywh=z_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9CxINdevQ9fumYFAA--.6663S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyxAr17ur47XF15tr4Utwb_yoW7Jr1DpF
        W5Xa17KF4FqrW5CwnFqa1Dua4avF9xAFykC395W3ZF9asxua45WrW7KFyFvF45Jr4kXF4j
        q3ZrC3WxGa15ur7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
        6cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUyxRDUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 07/16/2020 10:21 AM, Huacai Chen wrote:
> Hi, Tiezhu,
>
> You don't need to use the lower case in the title, "Loongson" is just
> fine (and is recommended).

Hi Huacai,

Thanks for your reply.

In the first version of this patch, I received the following reply by Bjorn:

[Subject line:

   PCI: loongson: Use DECLARE_PCI_FIXUP_EARLY for bridge_class_quirk()

(Driver names are conventionally lower case.)

Lorenzo will probably silently fix this when applying, so this is
mostly just a reminder in case you need to revise this or for future
patches.]

https://lore.kernel.org/patchwork/patch/1254407/

I also checked the git log of drivers/pci/controller:

[yangtiezhu@linux linux.git]$ git log --oneline drivers/pci/controller | 
grep "PCI:" | head
8d7e33d PCI: uniphier: Add Socionext UniPhier Pro5 PCIe endpoint 
controller driver
fcee90c PCI: tegra: Fix runtime PM imbalance on error
3e5095e PCI: vmd: Filter resource type bits from shadow register
1c1dbb2 PCI: tegra194: Fix runtime PM imbalance on error
d0684fd0 PCI: hv: Use struct_size() helper
1f58cca PCI: Add Loongson PCI Controller support
03f8c1b3 PCI: dwc: Use private data pointer of "struct irq_domain" to 
get pcie_port
87dccf0 PCI: amlogic: meson: Don't use FAST_LINK_MODE to set up link
0414b93 PCI: dwc: Fix inner MSI IRQ domain registration
c8a1197 PCI: dwc: pci-dra7xx: Use devm_platform_ioremap_resource_byname()

So use lower case "loongson" may be proper here.

Thanks,
Tiezhu

>
> On Thu, Jul 16, 2020 at 10:19 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>> According to the datasheet of Loongson LS7A bridge chip, the old version
>> of Loongson LS7A PCIE port has a hardware bug about PCI class. As far as
>> I know, the latest version has already fixed this bug.
>>
>> In order to maintain downward compatibility, use DECLARE_PCI_FIXUP_EARLY
>> instead of DECLARE_PCI_FIXUP_HEADER for bridge_class_quirk() to fix it as
>> early as possible.
>>
>> Otherwise, in the function pci_setup_device(), the related code about
>> "dev->class" such as "class = dev->class >> 8;" and "dev->transparent
>> = ((dev->class & 0xff) == 1);" maybe get wrong value due to without
>> EARLY fixup.
>>
>> By the way, we can see that the PCI class fixup of other controllers are
>> all EARLY fixups:
>>
>> [root@linux linux.git]# grep -rn -A 3 "PCI_CLASS_BRIDGE_PCI << 8" drivers/pci/controller/ | grep EARLY
>> drivers/pci/controller/pcie-tango.c-327-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIGMA, 0x0024, tango_fixup_class);
>> drivers/pci/controller/pcie-tango.c-328-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIGMA, 0x0028, tango_fixup_class);
>> drivers/pci/controller/pci-tegra.c-775-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf0, tegra_pcie_fixup_class);
>> drivers/pci/controller/pci-tegra.c-776-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_fixup_class);
>> drivers/pci/controller/dwc/pcie-qcom.c-1442-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0101, qcom_fixup_class);
>> drivers/pci/controller/dwc/pcie-qcom.c-1443-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0104, qcom_fixup_class);
>> drivers/pci/controller/pcie-iproc-bcma.c-23-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x8011, bcma_pcie2_fixup_class);
>> drivers/pci/controller/pcie-iproc-bcma.c-24-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x8012, bcma_pcie2_fixup_class);
>>
>> Fixes: 1f58cca5cf2b ("PCI: Add Loongson PCI Controller support")
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>
>> v2: Modify the patch subject used with lower case "loongson"
>>
>> v3: Update the commit message
>>
>>   drivers/pci/controller/pci-loongson.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
>> index 459009c..58b862a 100644
>> --- a/drivers/pci/controller/pci-loongson.c
>> +++ b/drivers/pci/controller/pci-loongson.c
>> @@ -37,11 +37,11 @@ static void bridge_class_quirk(struct pci_dev *dev)
>>   {
>>          dev->class = PCI_CLASS_BRIDGE_PCI << 8;
>>   }
>> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>                          DEV_PCIE_PORT_0, bridge_class_quirk);
>> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>                          DEV_PCIE_PORT_1, bridge_class_quirk);
>> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>                          DEV_PCIE_PORT_2, bridge_class_quirk);
>>
>>   static void system_bus_quirk(struct pci_dev *pdev)
>> --
>> 2.1.0
>>

