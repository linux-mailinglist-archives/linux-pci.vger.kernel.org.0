Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC2A27A4F7
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 02:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgI1Azy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 20:55:54 -0400
Received: from mx.socionext.com ([202.248.49.38]:27379 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgI1Azy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 20:55:54 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 28 Sep 2020 09:55:52 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 7A036180BE1;
        Mon, 28 Sep 2020 09:55:52 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 28 Sep 2020 09:55:52 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 47B9B4035E;
        Mon, 28 Sep 2020 09:55:52 +0900 (JST)
Received: from [10.212.1.203] (unknown [10.212.1.203])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 9345C120B9F;
        Mon, 28 Sep 2020 09:55:51 +0900 (JST)
Subject: Re: [PATCH 2/3] PCI: dwc: Add common iATU register support
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-kernel@vger.kernel.org,
        Murali Karicheri <m-karicheri2@ti.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-arm-kernel@lists.infradead.org
References: <1599814203-14441-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1599814203-14441-3-git-send-email-hayashi.kunihiko@socionext.com>
 <20200923155700.GA820801@bogus>
 <aef56eed-3966-cb1b-75f3-4b5dffc710c8@socionext.com>
Message-ID: <a7cbceee-aaee-e770-85a8-99ee2eab0466@socionext.com>
Date:   Mon, 28 Sep 2020 09:55:51 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <aef56eed-3966-cb1b-75f3-4b5dffc710c8@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/09/25 18:10, Kunihiko Hayashi wrote:
> Hi Rob,
> 
> On 2020/09/24 0:57, Rob Herring wrote:
>> On Fri, Sep 11, 2020 at 05:50:02PM +0900, Kunihiko Hayashi wrote:
>>> This gets iATU register area from reg property that has reg-names "atu".
>>> In Synopsys DWC version 4.80 or later, since iATU register area is
>>> separated from core register area, this area is necessary to get from
>>> DT independently.
>>>
>>> Cc: Murali Karicheri <m-karicheri2@ti.com>
>>> Cc: Jingoo Han <jingoohan1@gmail.com>
>>> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>> Suggested-by: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>> ---
>>>   drivers/pci/controller/dwc/pcie-designware.c | 8 +++++++-
>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>>> index 4d105ef..4a360bc 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>>> @@ -10,6 +10,7 @@
>>>   #include <linux/delay.h>
>>>   #include <linux/of.h>
>>> +#include <linux/of_platform.h>
>>>   #include <linux/types.h>
>>>   #include "../../pci.h"
>>> @@ -526,11 +527,16 @@ void dw_pcie_setup(struct dw_pcie *pci)
>>>       u32 val;
>>>       struct device *dev = pci->dev;
>>>       struct device_node *np = dev->of_node;
>>> +    struct platform_device *pdev;
>>>       if (pci->version >= 0x480A || (!pci->version &&
>>>                          dw_pcie_iatu_unroll_enabled(pci))) {
>>>           pci->iatu_unroll_enabled = true;
>>> -        if (!pci->atu_base)
>>> +        pdev = of_find_device_by_node(np);
>>
>> Use to_platform_device(dev) instead. Put that at the beginning as I'm
>> going to move 'dbi' in here too.
> 
> Okay, I'll rewrite it with to_platform_device(dev).
> Should I refer somewhere to rebase to your change?
It seems there is no dbi patch yet, so I'm going to send v2 in advance
for now. I can rebase it if necessary.

Thank you,

---
Best Regards
Kunihiko Hayashi
