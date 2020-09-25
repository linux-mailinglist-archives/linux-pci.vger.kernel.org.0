Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F212783D6
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 11:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbgIYJUM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 05:20:12 -0400
Received: from mx.socionext.com ([202.248.49.38]:2721 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgIYJUM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 05:20:12 -0400
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2020 05:20:11 EDT
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 25 Sep 2020 18:10:23 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 3E3E860060;
        Fri, 25 Sep 2020 18:10:23 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 25 Sep 2020 18:10:23 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id B546F1A0508;
        Fri, 25 Sep 2020 18:10:22 +0900 (JST)
Received: from [10.212.5.245] (unknown [10.212.5.245])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 25612120447;
        Fri, 25 Sep 2020 18:10:22 +0900 (JST)
Subject: Re: [PATCH 2/3] PCI: dwc: Add common iATU register support
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <1599814203-14441-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1599814203-14441-3-git-send-email-hayashi.kunihiko@socionext.com>
 <20200923155700.GA820801@bogus>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <aef56eed-3966-cb1b-75f3-4b5dffc710c8@socionext.com>
Date:   Fri, 25 Sep 2020 18:10:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923155700.GA820801@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 2020/09/24 0:57, Rob Herring wrote:
> On Fri, Sep 11, 2020 at 05:50:02PM +0900, Kunihiko Hayashi wrote:
>> This gets iATU register area from reg property that has reg-names "atu".
>> In Synopsys DWC version 4.80 or later, since iATU register area is
>> separated from core register area, this area is necessary to get from
>> DT independently.
>>
>> Cc: Murali Karicheri <m-karicheri2@ti.com>
>> Cc: Jingoo Han <jingoohan1@gmail.com>
>> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> Suggested-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index 4d105ef..4a360bc 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -10,6 +10,7 @@
>>   
>>   #include <linux/delay.h>
>>   #include <linux/of.h>
>> +#include <linux/of_platform.h>
>>   #include <linux/types.h>
>>   
>>   #include "../../pci.h"
>> @@ -526,11 +527,16 @@ void dw_pcie_setup(struct dw_pcie *pci)
>>   	u32 val;
>>   	struct device *dev = pci->dev;
>>   	struct device_node *np = dev->of_node;
>> +	struct platform_device *pdev;
>>   
>>   	if (pci->version >= 0x480A || (!pci->version &&
>>   				       dw_pcie_iatu_unroll_enabled(pci))) {
>>   		pci->iatu_unroll_enabled = true;
>> -		if (!pci->atu_base)
>> +		pdev = of_find_device_by_node(np);
> 
> Use to_platform_device(dev) instead. Put that at the beginning as I'm
> going to move 'dbi' in here too.

Okay, I'll rewrite it with to_platform_device(dev).
Should I refer somewhere to rebase to your change?

Thank you,

---
Best Regards
Kunihiko Hayashi
