Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128931EB7EB
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 11:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgFBJHq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 05:07:46 -0400
Received: from mx.socionext.com ([202.248.49.38]:5666 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgFBJHq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jun 2020 05:07:46 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 02 Jun 2020 18:07:43 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id BB527180B46;
        Tue,  2 Jun 2020 18:07:43 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 2 Jun 2020 18:07:43 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 673931A0E67;
        Tue,  2 Jun 2020 18:07:43 +0900 (JST)
Received: from [10.213.31.100] (unknown [10.213.31.100])
        by yuzu.css.socionext.com (Postfix) with ESMTP id BC777120136;
        Tue,  2 Jun 2020 18:07:42 +0900 (JST)
Subject: Re: [PATCH v2 4/5] PCI: uniphier: Add iATU register support
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1589536743-6684-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1589536743-6684-5-git-send-email-hayashi.kunihiko@socionext.com>
 <20200601213215.GA1521885@bogus>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <e6e7de73-6a89-b0e9-a9b0-de353c4e3218@socionext.com>
Date:   Tue, 2 Jun 2020 18:07:42 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200601213215.GA1521885@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 2020/06/02 6:32, Rob Herring wrote:
> On Fri, May 15, 2020 at 06:59:02PM +0900, Kunihiko Hayashi wrote:
>> This gets iATU register area from reg property. In Synopsis DWC version
>> 4.80 or later, since iATU register area is separated from core register
>> area, this area is necessary to get from DT independently.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-uniphier.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
>> index a8dda39..493f105 100644
>> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
>> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
>> @@ -447,6 +447,13 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
>>   	if (IS_ERR(priv->pci.dbi_base))
>>   		return PTR_ERR(priv->pci.dbi_base);
>>   
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
>> +	if (res) {
>> +		priv->pci.atu_base = devm_pci_remap_cfg_resource(dev, res);
> 
> This isn't config space, so this function shouldn't be used.
> 
> Use devm_platform_ioremap_resource_byname().

Indeed. I'll replace with it.

>> +		if (IS_ERR(priv->pci.atu_base))
>> +			priv->pci.atu_base = NULL;
>> +	}
>> +
>>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "link");
>>   	priv->base = devm_ioremap_resource(dev, res);
> 
> Feel free to convert this one too.

This should be replaced as well.

Thank you,
  
---
Best Regards
Kunihiko Hayashi
