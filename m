Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6C92A3DA2
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 08:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgKCH1u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 02:27:50 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7407 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgKCH1u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2020 02:27:50 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CQLwD6rLMz71hY;
        Tue,  3 Nov 2020 15:27:40 +0800 (CST)
Received: from [10.174.177.149] (10.174.177.149) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 15:27:40 +0800
Subject: Re: [PATCH] PCI: v3: fix missing clk_disable_unprepare() on error in
 v3_pci_probe
To:     Rob Herring <robh@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201030013427.54086-1-miaoqinglang@huawei.com>
 <CAL_JsqKRDBMXjkBLrJo1GGo-tM4s3gO0rASsTtXmO5b2_BO+qg@mail.gmail.com>
From:   miaoqinglang <miaoqinglang@huawei.com>
Message-ID: <8f3677d9-6443-e550-553f-d8d61e8e8241@huawei.com>
Date:   Tue, 3 Nov 2020 15:27:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKRDBMXjkBLrJo1GGo-tM4s3gO0rASsTtXmO5b2_BO+qg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2020/11/2 21:48, Rob Herring 写道:
> On Thu, Oct 29, 2020 at 8:28 PM Qinglang Miao <miaoqinglang@huawei.com> wrote:
>>
>> Fix the missing clk_disable_unprepare() before return
>> from v3_pci_probe() in the error handling case.
>>
>> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
>> ---
>>   drivers/pci/controller/pci-v3-semi.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
>> index 154a53986..e24abc5b4 100644
>> --- a/drivers/pci/controller/pci-v3-semi.c
>> +++ b/drivers/pci/controller/pci-v3-semi.c
>> @@ -739,8 +739,10 @@ static int v3_pci_probe(struct platform_device *pdev)
>>
>>          regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>          v3->base = devm_ioremap_resource(dev, regs);
>> -       if (IS_ERR(v3->base))
>> +       if (IS_ERR(v3->base)) {
>> +               clk_disable_unprepare(clk);
> 
> You can reorder things moving the clock enable later (after mapping
> resources, but before devm_request_irq) and avoid some of these. Also
> move this check down:
> 
> if (readl(v3->base + V3_LB_IO_BASE) != (regs->start >> 16))
> 
Hi Rob,

I've sent a new patch which reorder things and cover all error branches.

But I'm not sure why and where should I move this check down:
if (readl(v3->base + V3_LB_IO_BASE) != (regs->start >> 16)).  So I 
didn't move it in current version.

If you think it's still necessary, please let me know.

Thanks.
> 
>>                  return PTR_ERR(v3->base);
>> +       }
>>          /*
>>           * The hardware has a register with the physical base address
>>           * of the V3 controller itself, verify that this is the same
>> @@ -754,17 +756,22 @@ static int v3_pci_probe(struct platform_device *pdev)
>>          regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>          if (resource_size(regs) != SZ_16M) {
>>                  dev_err(dev, "config mem is not 16MB!\n");
>> +               clk_disable_unprepare(clk);
>>                  return -EINVAL;
>>          }
>>          v3->config_mem = regs->start;
>>          v3->config_base = devm_ioremap_resource(dev, regs);
>> -       if (IS_ERR(v3->config_base))
>> +       if (IS_ERR(v3->config_base)) {
>> +               clk_disable_unprepare(clk);
>>                  return PTR_ERR(v3->config_base);
>> +       }
>>
>>          /* Get and request error IRQ resource */
>>          irq = platform_get_irq(pdev, 0);
>> -       if (irq < 0)
>> +       if (irq < 0) {
>> +               clk_disable_unprepare(clk);
>>                  return irq;
>> +       }
>>
>>          ret = devm_request_irq(dev, irq, v3_irq, 0,
>>                          "PCIv3 error", v3);
>> @@ -772,6 +779,7 @@ static int v3_pci_probe(struct platform_device *pdev)
>>                  dev_err(dev,
>>                          "unable to request PCIv3 error IRQ %d (%d)\n",
>>                          irq, ret);
>> +               clk_disable_unprepare(clk);
>>                  return ret;
> 
> You still leave the clock enabled if pci_host_probe() fails.
> 
> Rob
> .
> 
