Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1549517EE9E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Mar 2020 03:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCJCcm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 22:32:42 -0400
Received: from mail.loongson.cn ([114.242.206.163]:55576 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726450AbgCJCcm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Mar 2020 22:32:42 -0400
Received: from [10.130.0.70] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxJuoc_GZe9QYZAA--.37S3;
        Tue, 10 Mar 2020 10:32:04 +0800 (CST)
Subject: =?UTF-8?Q?Re:_=e5=9b=9e=e5=a4=8d:[PATCH_1/6]_PCI:_Add_Loongson_vend?=
 =?UTF-8?Q?or_ID_and_7A1000_device_IDs?=
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn>
 <1583742206-29163-2-git-send-email-yangtiezhu@loongson.cn>
 <170be7ca00e.133ea84fa2305.7803335422925759322@flygoat.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-mips <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-ide <linux-ide@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <2ba6de2e-7880-d322-a0f6-5cea2647ea50@loongson.cn>
Date:   Tue, 10 Mar 2020 10:31:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <170be7ca00e.133ea84fa2305.7803335422925759322@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxJuoc_GZe9QYZAA--.37S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF18Cw45KrWrZFW5WFyrCrg_yoW8uF4Dpr
        10vFs3KFs7trWfZ3Z2qrn8GrZ3JFs8tw1UuFya9r45JFn3Xw18GrnFyr45CrW2qrsxX3yx
        Zr1qk3y3CwnxtwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
        6cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUF3kuDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03/09/2020 04:50 PM, Jiaxun Yang wrote:
>   ---- 在 星期一, 2020-03-09 16:23:21 Tiezhu Yang <yangtiezhu@loongson.cn> 撰写 ----
>   > Add the Loongson vendor ID and 7A1000 device IDs to pci_ids.h
>   > to be used by the controller driver in the future.
>   >
>   > The Loongson IDs can be found at the following link:
>   > https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/tree/pci.ids
>   >
>   > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>   > ---
>   >  include/linux/pci_ids.h | 18 ++++++++++++++++++
>   >  1 file changed, 18 insertions(+)
>   >
>   > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>   > index 352c0d7..0125ab4 100644
>   > --- a/include/linux/pci_ids.h
>   > +++ b/include/linux/pci_ids.h
>   > @@ -3113,4 +3113,22 @@
>   >
>   >  #define PCI_VENDOR_ID_NCUBE        0x10ff
>   >
>   > +#define PCI_VENDOR_ID_LOONGSON            0x0014
>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_HT    0x7a00
>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_APB    0x7a02
>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_GMAC    0x7a03
>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_OTG    0x7a04
>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_DC    0x7a06
>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_HDA    0x7a07
>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_SATA    0x7a08
>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_PCIE_X1    0x7a09
>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_SPI    0x7a0b
>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_LPC    0x7a0c
>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_DMA    0x7a0f
>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_EHCI    0x7a14
>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_GPU    0x7a15
>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_PCIE_X4    0x7a19
>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_OHCI    0x7a24
>   > +#define PCI_DEVICE_ID_LOONGSON_7A1000_PCIE_X8    0x7a29
>
> Devices IDs are unlikely to be reused by mutiple subsystems, so probably we don't need
> to add them here?

Hi Jiaxun,

I think it is better to define the device IDs in pci_ids.h,
otherwise it seems a little disorganized.

Thanks,

Tiezhu Yang

>   
>> +
>   >  #endif /* _LINUX_PCI_IDS_H */
>   > --
>   > 2.1.0
>   >
>   >

