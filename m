Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E77DDC2C14
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 04:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfJACx5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 22:53:57 -0400
Received: from mail.loongson.cn ([114.242.206.163]:43163 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbfJACx5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Sep 2019 22:53:57 -0400
Received: from [10.20.41.27] (unknown [10.20.41.27])
        by mail (Coremail) with SMTP id QMiowPDxP2K4v5JdEbcFAA--.183S3;
        Tue, 01 Oct 2019 10:53:44 +0800 (CST)
Subject: Re: [PATCH] PCI: Add Loongson vendor ID and device IDs
To:     Andrew Murray <andrew.murray@arm.com>
References: <279cbe32-a44b-3190-aaf7-a277a1220720@loongson.cn>
 <20190930140217.GB38576@e119886-lin.cambridge.arm.com>
Cc:     bhelgaas@google.com, zenglu@loongson.cn, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d3cde609-7918-6b1c-940d-29ecaf7e5cbb@loongson.cn>
Date:   Tue, 1 Oct 2019 10:53:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20190930140217.GB38576@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: QMiowPDxP2K4v5JdEbcFAA--.183S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4rWr47Cr4ruF43Ww1ftFb_yoW8KF4Dpr
        18ZFW3KFs7trW7Wwn2qwn8Gry3AanayryUuFy3Wr4jqF13Xw1rGr1qvr45ZrW2qrn5X34I
        vF4DC3y5CFsrt37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8ZNVDUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09/30/2019 10:02 PM, Andrew Murray wrote:
> On Mon, Sep 30, 2019 at 12:55:20PM +0800, Tiezhu Yang wrote:
>> Add the Loongson vendor ID and device IDs to pci_ids.h
>> to be used in the future.
>>
>> The Loongson IDs can be found at the following link:
>> https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/tree/pci.ids
>>
>> Co-developed-by: Lu Zeng <zenglu@loongson.cn>
>> Signed-off-by: Lu Zeng <zenglu@loongson.cn>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   include/linux/pci_ids.h | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 21a5724..119639d 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -3111,4 +3111,23 @@
>>
>>   #define PCI_VENDOR_ID_NCUBE            0x10ff
>>
>> +#define PCI_VENDOR_ID_LOONGSON                 0x0014
>> +#define PCI_DEVICE_ID_LOONGSON_HT              0x7a00
>> +#define PCI_DEVICE_ID_LOONGSON_APB             0x7a02
>> +#define PCI_DEVICE_ID_LOONGSON_GMAC            0x7a03
>> +#define PCI_DEVICE_ID_LOONGSON_OTG             0x7a04
>> +#define PCI_DEVICE_ID_LOONGSON_GPU_2K1000      0x7a05
>> +#define PCI_DEVICE_ID_LOONGSON_DC              0x7a06
>> +#define PCI_DEVICE_ID_LOONGSON_HDA             0x7a07
>> +#define PCI_DEVICE_ID_LOONGSON_SATA            0x7a08
>> +#define PCI_DEVICE_ID_LOONGSON_PCIE_X1         0x7a09
>> +#define PCI_DEVICE_ID_LOONGSON_SPI             0x7a0b
>> +#define PCI_DEVICE_ID_LOONGSON_LPC             0x7a0c
>> +#define PCI_DEVICE_ID_LOONGSON_DMA             0x7a0f
>> +#define PCI_DEVICE_ID_LOONGSON_EHCI            0x7a14
>> +#define PCI_DEVICE_ID_LOONGSON_GPU_7A1000      0x7a15
>> +#define PCI_DEVICE_ID_LOONGSON_PCIE_X4         0x7a19
>> +#define PCI_DEVICE_ID_LOONGSON_OHCI            0x7a24
>> +#define PCI_DEVICE_ID_LOONGSON_PCIE_X8         0x7a29
> Hi Tiezhu,
>
> Thanks for the patch - however it is preferred to provide new PCI definitions
> along with the drivers that use them. They don't provide any useful value
> without drivers that use them.

Hi Andrew,

Thanks for your reply. This is the first step of the Loongson kernel team,
we will submit other related individual driver patches step by step in the
near future, these small patches make an easily understood change that can
be verified by reviewers.

Thanks,

Tiezhu Yang

>
> Thanks,
>
> Andrew Murray
>
>> +
>>   #endif /* _LINUX_PCI_IDS_H */
>> -- 
>> 2.1.0
>>
>>

