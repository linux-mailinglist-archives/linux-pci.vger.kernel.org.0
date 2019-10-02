Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD7EC452D
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2019 02:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfJBAyB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 20:54:01 -0400
Received: from mail.loongson.cn ([114.242.206.163]:55873 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfJBAyA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Oct 2019 20:54:00 -0400
Received: from [10.20.41.27] (unknown [10.20.41.27])
        by mail (Coremail) with SMTP id QMiowPDxL18P9ZNdkUgGAA--.132S3;
        Wed, 02 Oct 2019 08:53:54 +0800 (CST)
Subject: Re: [PATCH] PCI: Add Loongson vendor ID and device IDs
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20191001125010.GA38575@google.com>
Cc:     Andrew Murray <andrew.murray@arm.com>, zenglu@loongson.cn,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <af586d51-3080-3667-b277-65a8338fbf6f@loongson.cn>
Date:   Wed, 2 Oct 2019 08:53:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20191001125010.GA38575@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: QMiowPDxL18P9ZNdkUgGAA--.132S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4DKw4DuFyxur18urWkCrg_yoW5KFW3pr
        15ZFWayFs7ArW7Jwn2q3s8JFZayanIyFyUuF1agr47JFnIqw1xGryYvF45urZFqrn5X342
        vr4Duws8uFnFy37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkSb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUgg_TUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/01/2019 08:50 PM, Bjorn Helgaas wrote:
> On Tue, Oct 01, 2019 at 10:53:44AM +0800, Tiezhu Yang wrote:
>> On 09/30/2019 10:02 PM, Andrew Murray wrote:
>>> On Mon, Sep 30, 2019 at 12:55:20PM +0800, Tiezhu Yang wrote:
>>>> Add the Loongson vendor ID and device IDs to pci_ids.h
>>>> to be used in the future.
>>>>
>>>> The Loongson IDs can be found at the following link:
>>>> https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/tree/pci.ids
>>>>
>>>> Co-developed-by: Lu Zeng <zenglu@loongson.cn>
>>>> Signed-off-by: Lu Zeng <zenglu@loongson.cn>
>>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>>> ---
>>>>    include/linux/pci_ids.h | 19 +++++++++++++++++++
>>>>    1 file changed, 19 insertions(+)
>>>>
>>>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>>>> index 21a5724..119639d 100644
>>>> --- a/include/linux/pci_ids.h
>>>> +++ b/include/linux/pci_ids.h
>>>> @@ -3111,4 +3111,23 @@
>>>>
>>>>    #define PCI_VENDOR_ID_NCUBE            0x10ff
>>>>
>>>> +#define PCI_VENDOR_ID_LOONGSON                 0x0014
>>>> +#define PCI_DEVICE_ID_LOONGSON_HT              0x7a00
>>>> +#define PCI_DEVICE_ID_LOONGSON_APB             0x7a02
>>>> +#define PCI_DEVICE_ID_LOONGSON_GMAC            0x7a03
>>>> +#define PCI_DEVICE_ID_LOONGSON_OTG             0x7a04
>>>> +#define PCI_DEVICE_ID_LOONGSON_GPU_2K1000      0x7a05
>>>> +#define PCI_DEVICE_ID_LOONGSON_DC              0x7a06
>>>> +#define PCI_DEVICE_ID_LOONGSON_HDA             0x7a07
>>>> +#define PCI_DEVICE_ID_LOONGSON_SATA            0x7a08
>>>> +#define PCI_DEVICE_ID_LOONGSON_PCIE_X1         0x7a09
>>>> +#define PCI_DEVICE_ID_LOONGSON_SPI             0x7a0b
>>>> +#define PCI_DEVICE_ID_LOONGSON_LPC             0x7a0c
>>>> +#define PCI_DEVICE_ID_LOONGSON_DMA             0x7a0f
>>>> +#define PCI_DEVICE_ID_LOONGSON_EHCI            0x7a14
>>>> +#define PCI_DEVICE_ID_LOONGSON_GPU_7A1000      0x7a15
>>>> +#define PCI_DEVICE_ID_LOONGSON_PCIE_X4         0x7a19
>>>> +#define PCI_DEVICE_ID_LOONGSON_OHCI            0x7a24
>>>> +#define PCI_DEVICE_ID_LOONGSON_PCIE_X8         0x7a29
>>> Hi Tiezhu,
>>>
>>> Thanks for the patch - however it is preferred to provide new PCI
>>> definitions along with the drivers that use them. They don't
>>> provide any useful value without drivers that use them.
>> Thanks for your reply. This is the first step of the Loongson kernel
>> team, we will submit other related individual driver patches step by
>> step in the near future, these small patches make an easily
>> understood change that can be verified by reviewers.
> There are two opposing goals here:
>
>    1) The "publish early, publish often" idea that posting small things
>    early helps get useful feedback.
>
>    2) The idea of waiting until things can be published in logical
>    units so readers can see context and how things fit together.
>
> I think Andrew's point (which I agree with) is that an individual
> trivial patch like this is not enough to give meaningful feedback.  I
> think you'll get better feedback if you wait and collect things until
> you can post a series that actually fixes a bug or adds a small
> feature.  It also makes it easier for me to track patches if I can
> deal with a whole series at once instead of trying to figure out which
> individual patches are related.
>
> So I'd encourage you to think in terms of a series of 3-10 patches
> that are all related and together produce something useful.  That's
> easier for readers to digest than the same patches posted
> incrementally over several days or weeks.

Hi Bjorn,

Thanks for your valuable suggestion, it is very useful. In the next work,
I will submit a series of patches as soon as possible.

Thanks,

Tiezhu Yang

>
> Bjorn

