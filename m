Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A3C23EB41
	for <lists+linux-pci@lfdr.de>; Fri,  7 Aug 2020 12:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgHGKMP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Aug 2020 06:12:15 -0400
Received: from mx.socionext.com ([202.248.49.38]:31411 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgHGKMP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Aug 2020 06:12:15 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 07 Aug 2020 19:12:13 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 9FA22180BB5;
        Fri,  7 Aug 2020 19:12:13 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 7 Aug 2020 19:12:13 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 2AAB04033C;
        Fri,  7 Aug 2020 19:12:13 +0900 (JST)
Received: from [10.212.5.35] (unknown [10.212.5.35])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 66107120138;
        Fri,  7 Aug 2020 19:12:12 +0900 (JST)
Subject: Re: [PATCH v5 2/6] PCI: uniphier: Add misc interrupt handler to
 invoke PME and AER
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Marc Zyngier <maz@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1592469493-1549-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1592469493-1549-3-git-send-email-hayashi.kunihiko@socionext.com>
 <20200714132727.GA13061@e121166-lin.cambridge.arm.com>
 <293ed6fe-6e73-f664-c26e-0aef744ce933@socionext.com>
Message-ID: <50936df1-313c-aa9b-14b5-975f5e4330df@socionext.com>
Date:   Fri, 7 Aug 2020 19:12:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <293ed6fe-6e73-f664-c26e-0aef744ce933@socionext.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/07/15 19:04, Kunihiko Hayashi wrote:
> Hi Lorenzo,
> 
> On 2020/07/14 22:27, Lorenzo Pieralisi wrote:
>> On Thu, Jun 18, 2020 at 05:38:09PM +0900, Kunihiko Hayashi wrote:
>>> The misc interrupts consisting of PME, AER, and Link event, is handled
>>> by INTx handler, however, these interrupts should be also handled by
>>> MSI handler.
>>
>> Define what you mean please.

[snip]

>> I think this is wrong. pp->irq_domain is the DWC MSI domain, how do
>> you know that hwirq 0 *is* the AER/PME interrupt ?
> 
> When AER/PME drivers are probed, AER/PME interrupts are registered
> as MSI-0.
> 
> The pcie_message_numbers() function refers the following fields of
> PCI registers,
> 
>     - PCI_EXP_FLAGS_IRQ (for PME)
>     - PCI_ERR_ROOT_AER_IRQ (for AER)
> 
> and decides AER/PME interrupts numbers in MSI domain.
> Initial values of both fields are 0, so these interrupts are set to MSI-0.
> 
> However, pcie_uniphier driver doesn't know that these interrupts are MSI-0.
> Surely using 0 here is wrong.
> I think that the method to get virq for AER/PME from pcieport is needed.

To avoid using hard-coded MSI-0, I'll add new function to get a virq number
corresponding to each service (AER/PME) to portdrv.

I'll update the series in v6.

Thank you,
---
Best Regards
Kunihiko Hayashi
