Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BB82A8D58
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 04:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgKFDIM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 22:08:12 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7060 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFDIM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 22:08:12 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CS51L4xQQzhfb3;
        Fri,  6 Nov 2020 11:08:06 +0800 (CST)
Received: from [10.174.177.149] (10.174.177.149) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 6 Nov 2020 11:08:05 +0800
Subject: Re: [PATCH v2] PCI: v3: fix missing clk_disable_unprepare() on error
 in v3_pci_probe
To:     Rob Herring <robh@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201103073338.144465-1-miaoqinglang@huawei.com>
 <CAL_JsqLy5B+4NVX1DXS9yjgEssLSn2d2Qg8n+YQ9E1G_05=i0A@mail.gmail.com>
From:   Qinglang Miao <miaoqinglang@huawei.com>
Message-ID: <a72ce501-10b1-bdaa-97dc-d93456826a51@huawei.com>
Date:   Fri, 6 Nov 2020 11:08:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLy5B+4NVX1DXS9yjgEssLSn2d2Qg8n+YQ9E1G_05=i0A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2020/11/3 22:16, Rob Herring 写道:
> On Tue, Nov 3, 2020 at 1:28 AM Qinglang Miao <miaoqinglang@huawei.com> wrote:
>>
>> Fix the missing clk_disable_unprepare() before return
>> from v3_pci_probe() in the error handling case.
>>
>> Moving the clock enable later to avoid some fixes.
>>
>> Fixes: 6e0832fa432e (" PCI: Collect all native drivers under drivers/pci/controller/")
> 
> I don't think this commit caused the problem.
> 
>> Suggested-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
>> ---
>>   drivers/pci/controller/pci-v3-semi.c | 40 ++++++++++++++++------------
>>   1 file changed, 23 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
>> index 154a53986..90520555b 100644
>> --- a/drivers/pci/controller/pci-v3-semi.c
>> +++ b/drivers/pci/controller/pci-v3-semi.c
>> @@ -725,18 +725,6 @@ static int v3_pci_probe(struct platform_device *pdev)
>>          host->sysdata = v3;
>>          v3->dev = dev;
>>
>> -       /* Get and enable host clock */
>> -       clk = devm_clk_get(dev, NULL);
>> -       if (IS_ERR(clk)) {
>> -               dev_err(dev, "clock not found\n");
>> -               return PTR_ERR(clk);
>> -       }
>> -       ret = clk_prepare_enable(clk);
>> -       if (ret) {
>> -               dev_err(dev, "unable to enable clock\n");
>> -               return ret;
>> -       }
>> -
>>          regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>          v3->base = devm_ioremap_resource(dev, regs);
>>          if (IS_ERR(v3->base))
>> @@ -761,17 +749,31 @@ static int v3_pci_probe(struct platform_device *pdev)
>>          if (IS_ERR(v3->config_base))
>>                  return PTR_ERR(v3->config_base);
>>
>> +       /* Get and enable host clock */
>> +       clk = devm_clk_get(dev, NULL);
>> +       if (IS_ERR(clk)) {
>> +               dev_err(dev, "clock not found\n");
>> +               return PTR_ERR(clk);
>> +       }
>> +       ret = clk_prepare_enable(clk);
>> +       if (ret) {
>> +               dev_err(dev, "unable to enable clock\n");
>> +               return ret;
>> +       }
>> +
>>          /* Get and request error IRQ resource */
>>          irq = platform_get_irq(pdev, 0);
>> -       if (irq < 0)
>> +       if (irq < 0) {
>> +               clk_disable_unprepare(clk);
>>                  return irq;
>> -
>> +       }
>>          ret = devm_request_irq(dev, irq, v3_irq, 0,
>>                          "PCIv3 error", v3);
>>          if (ret < 0) {
>>                  dev_err(dev,
>>                          "unable to request PCIv3 error IRQ %d (%d)\n",
>>                          irq, ret);
>> +               clk_disable_unprepare(clk);
>>                  return ret;
>>          }
>>
>> @@ -814,13 +816,15 @@ static int v3_pci_probe(struct platform_device *pdev)
>>                  ret = v3_pci_setup_resource(v3, host, win);
>>                  if (ret) {
>>                          dev_err(dev, "error setting up resources\n");
>> +                       clk_disable_unprepare(clk);
>>                          return ret;
>>                  }
>>          }
>>          ret = v3_pci_parse_map_dma_ranges(v3, np);
>> -       if (ret)
>> +       if (ret) {
>> +               clk_disable_unprepare(clk);
>>                  return ret;
>> -
>> +       }
>>          /*
>>           * Disable PCI to host IO cycles, enable I/O buffers @3.3V,
>>           * set AD_LOW0 to 1 if one of the LB_MAP registers choose
>> @@ -862,8 +866,10 @@ static int v3_pci_probe(struct platform_device *pdev)
>>          /* Special Integrator initialization */
>>          if (of_device_is_compatible(np, "arm,integrator-ap-pci")) {
>>                  ret = v3_integrator_init(v3);
>> -               if (ret)
>> +               if (ret) {
>> +                       clk_disable_unprepare(clk);
> 
> You should make all these a goto and just have one clk_disable_unprepare() call.
> 
> You are still missing error handling after pci_host_probe().
Hi Rob,

I've sent a v3 patch towards this bug.

Thanks a lot for your advice.
> 
>>                          return ret;
>> +               }
>>          }
>>
>>          /* Post-init: enable PCI memory and invalidate (master already on) */
>> --
>> 2.23.0
>>
> .
> 
