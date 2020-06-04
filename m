Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA1F1EE19D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jun 2020 11:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgFDJnR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jun 2020 05:43:17 -0400
Received: from mx.socionext.com ([202.248.49.38]:32538 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgFDJnR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Jun 2020 05:43:17 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 04 Jun 2020 18:43:14 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 4CA2318009F;
        Thu,  4 Jun 2020 18:43:14 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 4 Jun 2020 18:43:14 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id E9F061A01BB;
        Thu,  4 Jun 2020 18:43:12 +0900 (JST)
Received: from [10.213.31.56] (unknown [10.213.31.56])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 3637F12041F;
        Thu,  4 Jun 2020 18:43:12 +0900 (JST)
Subject: Re: [PATCH v3 1/6] PCI: dwc: Add msi_host_isr() callback
To:     Marc Zyngier <maz@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1591174481-13975-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1591174481-13975-2-git-send-email-hayashi.kunihiko@socionext.com>
 <95bb3ffbfab4923854e20266c6b0b098@kernel.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <6926b2da-5d00-b582-7d25-a8a0d7014570@socionext.com>
Date:   Thu, 4 Jun 2020 18:43:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <95bb3ffbfab4923854e20266c6b0b098@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On 2020/06/03 20:15, Marc Zyngier wrote:
> On 2020-06-03 09:54, Kunihiko Hayashi wrote:
>> This adds msi_host_isr() callback function support to describe
>> SoC-dependent service triggered by MSI.
>>
>> For example, when AER interrupt is triggered by MSI, the callback function
>> reads SoC-dependent registers and detects that the interrupt is from AER,
>> and invoke AER interrupts related to MSI.
>>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Jingoo Han <jingoohan1@gmail.com>
>> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>  drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++----
>>  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>>  2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
>> b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 0a4a5aa..9b628a2 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -112,13 +112,13 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>>  static void dw_chained_msi_isr(struct irq_desc *desc)
>>  {
>>      struct irq_chip *chip = irq_desc_get_chip(desc);
>> -    struct pcie_port *pp;
>> +    struct pcie_port *pp = irq_desc_get_handler_data(desc);
>>
>> -    chained_irq_enter(chip, desc);
>> +    if (pp->ops->msi_host_isr)
>> +        pp->ops->msi_host_isr(pp);
> 
> Why is this call outside of the enter/exit guards?
> Do you still need to execute the standard handler?

I assume that the msi_host_isr() contains chained interrupts in
the second patch and no need to treat as the standard handler,
so this should be called in the guards.
I'll move this call to the top of dw_chained_msi_isr().

Thank you,

---
Best Regards
Kunihiko Hayashi
