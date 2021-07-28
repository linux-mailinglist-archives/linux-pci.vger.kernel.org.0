Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160B53D8727
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 07:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhG1F3V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 01:29:21 -0400
Received: from mx.socionext.com ([202.248.49.38]:6815 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229752AbhG1F3U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 01:29:20 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 28 Jul 2021 14:29:17 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 50848205902A;
        Wed, 28 Jul 2021 14:29:17 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 28 Jul 2021 14:29:17 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by iyokan2.css.socionext.com (Postfix) with ESMTP id C9FB3B6392;
        Wed, 28 Jul 2021 14:29:16 +0900 (JST)
Received: from [10.212.30.196] (unknown [10.212.30.196])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 07942B1D52;
        Wed, 28 Jul 2021 14:29:15 +0900 (JST)
Subject: Re: [PATCH v8 3/3] PCI: uniphier: Add misc interrupt handler to
 invoke PME and AER
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-arm-kernel@lists.infradead.org
References: <1603848703-21099-4-git-send-email-hayashi.kunihiko@socionext.com>
 <20201124232037.GA595463@bjorn-Precision-5520>
 <20201125102328.GA31700@e121166-lin.cambridge.arm.com>
 <f49a236d-c5f8-c445-f74e-7aa4eea70c3a@socionext.com>
 <20210718005109.6xwe3z7gxhuop5xc@pali>
 <2dfa5ec9-2a33-ae72-3904-999d8b8a2f71@socionext.com>
 <20210722172627.i4n65lrz3j7pduiz@pali>
 <17c6eeee-692f-2e9a-5827-34f6939a21a6@socionext.com>
 <20210723083702.nvhurkgbzbvrrmv3@pali>
 <660e8597-bb7a-b5a0-e3d4-f108a211ae76@socionext.com>
Message-ID: <d96880c4-75ab-50b5-3ecf-0dfd2aa3b8f3@socionext.com>
Date:   Wed, 28 Jul 2021 14:29:15 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <660e8597-bb7a-b5a0-e3d4-f108a211ae76@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo, Pali,

On 2021/07/23 18:36, Kunihiko Hayashi wrote:
> Hi Pali,

[snip]

>> Just you need to specify that new/private IRQ domain into
>> irq_find_mapping() call.
> 
> I'll try to replace the events with new IRQ domain.
According to Pali's suggestion, the bridge handles INTX and it isn't difficult
to change IRQ's map for Root Port like the example.
It seems that it can't be applied to MSI.

On the other hand, according to Lorenzo's suggestion,

 >>>>>>> IMO this should be modelled with a separate IRQ domain and chip for
 >>>>>>> the root port (yes this implies describing the root port in the dts
 >>>>>>> file with a separate msi-parent).

Interrupts for PME/AER event is assigned to number 0 of MSI IRQ domain.
(pcie_port_enable_irq_vec() in portdrv_core.c)
This expects MSI status bit 0 to be set when the event occurs.

However, in the uniphier PCIe controller, MSI status bit 0 is not set, but
the PME/AER status bit in the glue logic is set.

I think that it's hard to associate the new domain and "MSI-IRQ 0" event
if the new IRQ domain and chip is modelled.
So, I have no idea to handle both new IRQ domain and cascaded MSI event.
Is there any example for that?

Thank you,

---
Best Regards
Kunihiko Hayashi
