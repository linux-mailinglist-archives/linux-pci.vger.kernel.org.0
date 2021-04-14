Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4396E35EF72
	for <lists+linux-pci@lfdr.de>; Wed, 14 Apr 2021 10:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349745AbhDNIWQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Apr 2021 04:22:16 -0400
Received: from mx.socionext.com ([202.248.49.38]:53655 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348780AbhDNIWQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Apr 2021 04:22:16 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 14 Apr 2021 17:21:54 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 52740205902A;
        Wed, 14 Apr 2021 17:21:54 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 14 Apr 2021 17:21:54 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by iyokan2.css.socionext.com (Postfix) with ESMTP id 24EDFB1D40;
        Wed, 14 Apr 2021 17:21:54 +0900 (JST)
Received: from [10.212.23.128] (unknown [10.212.23.128])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 4B646623D;
        Wed, 14 Apr 2021 17:21:53 +0900 (JST)
Subject: Re: [PATCH v10 1/3] PCI: portdrv: Add pcie_port_service_get_irq()
 function
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
References: <1617985338-19648-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1617985338-19648-2-git-send-email-hayashi.kunihiko@socionext.com>
 <20210412094219.000031ca@Huawei.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <1001a75f-76fb-5a99-7af2-602aef31b01b@socionext.com>
Date:   Wed, 14 Apr 2021 17:21:52 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210412094219.000031ca@Huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jonathan,

On 2021/04/12 17:42, Jonathan Cameron wrote:
> On Sat, 10 Apr 2021 01:22:16 +0900
> Kunihiko Hayashi <hayashi.kunihiko@socionext.com> wrote:
> 
>> Add pcie_port_service_get_irq() that returns the virtual IRQ number
>> for specified portdrv service.
> 
> Trivial comment inline.
> 
>>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>   drivers/pci/pcie/portdrv.h      |  1 +
>>   drivers/pci/pcie/portdrv_core.c | 16 ++++++++++++++++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
>> index 2ff5724..628a3de 100644
>> --- a/drivers/pci/pcie/portdrv.h
>> +++ b/drivers/pci/pcie/portdrv.h
>> @@ -144,4 +144,5 @@ static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
>>   #endif /* !CONFIG_PCIE_PME */
>>   
>>   struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
>> +int pcie_port_service_get_irq(struct pci_dev *dev, u32 service);
>>   #endif /* _PORTDRV_H_ */
>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
>> index e1fed664..b60f0f3 100644
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -477,7 +477,22 @@ struct device *pcie_port_find_device(struct pci_dev *dev,
>>   }
>>   EXPORT_SYMBOL_GPL(pcie_port_find_device);
>>   
>> +/*
> 
> /**
> 
> this is kernel-doc style, so why not mark it as such?

Thank you for pointing out.
I'll apply the style to this comment.

Thank you,

---
Best Regards
Kunihiko Hayashi
