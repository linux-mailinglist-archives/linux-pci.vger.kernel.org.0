Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0CE7177458
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 11:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgCCKfP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 05:35:15 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17390 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgCCKfP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 05:35:15 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e5e32ba0000>; Tue, 03 Mar 2020 02:34:34 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 03 Mar 2020 02:35:14 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 03 Mar 2020 02:35:14 -0800
Received: from [10.25.75.175] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Mar
 2020 10:35:09 +0000
Subject: Re: [PATCH V3 5/5] PCI: tegra: Add support for PCIe endpoint mode in
 Tegra194
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <andrew.murray@arm.com>, <kishon@ti.com>,
        <gustavo.pimentel@synopsys.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20200113181411.32743-1-vidyas@nvidia.com>
 <20200113181411.32743-6-vidyas@nvidia.com>
 <20200227114816.GA11443@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <8a7edc61-48bf-704f-8d3f-7cf2c390517e@nvidia.com>
Date:   Tue, 3 Mar 2020 16:05:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227114816.GA11443@e121166-lin.cambridge.arm.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583231674; bh=ek4DSuMZku9rZzSkXPTOxyHMpIhIJu7DYX4wErCmPqc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GrSBi/jSUgozuR6As5RRTMgXYiV3n6MeudoPBJYjfUJL3AOS8dzmafd+0C++HRT7s
         lVcIbpqMg4gfv1okFkvImr8yvbJWXUP8yRLD00yhMmmusUAp9P+FVnUyM4JQDSM8m1
         /CPBTq9StHUS6IMDYrvDHsc67PwHFdKP3YZdj+LCEO5plSyqHddg8b4SMgM42MYENi
         eOYPlnDiEUjR0/Z9sPsWcC3PUAyxjx5qfu9uO5OI2AeEXGUcR0VzJEpYDQ6N4biMk7
         T9R6fNTudloSCJH56O6ciJcyfMrjF4Y0zuVVMFvvXZeGJtPlZuuCr97AMEo0Ht0g3W
         W3xL0yHo9DFJA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/27/2020 5:18 PM, Lorenzo Pieralisi wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Jan 13, 2020 at 11:44:11PM +0530, Vidya Sagar wrote:
>> Add support for the endpoint mode of Synopsys DesignWare core based
>> dual mode PCIe controllers present in Tegra194 SoC.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> V3:
>> * Addressed Thierry's review comments
> 
> I need his ACK to merge this series.
> 
> [...]
> 
>> +static int tegra_pcie_ep_work_thread(void *p)
>> +{
>> +     struct tegra_pcie_dw *pcie = (struct tegra_pcie_dw *)p;
>> +     u32 event;
>> +
>> +     while (true) {
>> +             wait_event_interruptible(pcie->wq,
>> +                                      !kfifo_is_empty(&pcie->event_fifo));
>> +
>> +             if (kthread_should_stop())
>> +                     break;
>> +
>> +             if (!kfifo_get(&pcie->event_fifo, &event)) {
>> +                     dev_warn(pcie->dev, "EVENT FIFO is empty\n");
>> +                     continue;
>> +             }
>> +
>> +             switch (event) {
>> +             case EP_PEX_RST_DEASSERT:
>> +                     dev_info(pcie->dev, "EVENT: EP_PEX_RST_DEASSERT\n");
>> +                     pex_ep_event_pex_rst_deassert(pcie);
>> +                     break;
>> +
>> +             case EP_PEX_RST_ASSERT:
>> +                     dev_info(pcie->dev, "EVENT: EP_PEX_RST_ASSERT\n");
>> +                     pex_ep_event_pex_rst_assert(pcie);
>> +                     break;
>> +
>> +             case EP_HOT_RST_DONE:
>> +                     dev_info(pcie->dev, "EVENT: EP_HOT_RST_DONE\n");
>> +                     pex_ep_event_hot_rst_done(pcie);
>> +                     break;
>> +
>> +             case EP_BME_CHANGE:
>> +                     dev_info(pcie->dev, "EVENT: EP_BME_CHANGE\n");
>> +                     pex_ep_event_bme_change(pcie);
>> +                     break;
>> +
>> +             case EP_EVENT_EXIT:
>> +                     dev_info(pcie->dev, "EVENT: EP_EVENT_EXIT\n");
>> +                     return 0;
>> +
>> +             default:
>> +                     dev_warn(pcie->dev, "Invalid PCIe EP event: %u\n",
>> +                              event);
>> +                     break;
>> +             }
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static irqreturn_t tegra_pcie_ep_pex_rst_irq(int irq, void *arg)
>> +{
>> +     struct tegra_pcie_dw *pcie = arg;
>> +
>> +     if (gpiod_get_value(pcie->pex_rst_gpiod)) {
>> +             if (!kfifo_put(&pcie->event_fifo, EP_PEX_RST_ASSERT)) {
>> +                     dev_err(pcie->dev, "EVENT FIFO is full\n");
>> +                     return IRQ_HANDLED;
>> +             }
>> +     } else {
>> +             if (!kfifo_put(&pcie->event_fifo, EP_PEX_RST_DEASSERT)) {
>> +                     dev_err(pcie->dev, "EVENT FIFO is full\n");
>> +                     return IRQ_HANDLED;
>> +             }
>> +     }
>> +
>> +     wake_up(&pcie->wq);
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
> 
> [...]
> 
>> +static int tegra_pcie_config_ep(struct tegra_pcie_dw *pcie,
>> +                             struct platform_device *pdev)
>> +{
>> +     struct dw_pcie *pci = &pcie->pci;
>> +     struct device *dev = pcie->dev;
>> +     struct dw_pcie_ep *ep;
>> +     struct resource *res;
>> +     char *name;
>> +     int ret;
>> +
>> +     ep = &pci->ep;
>> +     ep->ops = &pcie_ep_ops;
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
>> +     if (!res)
>> +             return -EINVAL;
>> +
>> +     ep->phys_base = res->start;
>> +     ep->addr_size = resource_size(res);
>> +     ep->page_size = SZ_64K;
>> +
>> +     ret = gpiod_set_debounce(pcie->pex_rst_gpiod, PERST_DEBOUNCE_TIME);
>> +     if (ret < 0) {
>> +             dev_err(dev, "Failed to set PERST GPIO debounce time: %d\n",
>> +                     ret);
>> +             return ret;
>> +     }
>> +
>> +     ret = gpiod_to_irq(pcie->pex_rst_gpiod);
>> +     if (ret < 0) {
>> +             dev_err(dev, "Failed to get IRQ for PERST GPIO: %d\n", ret);
>> +             return ret;
>> +     }
>> +     pcie->pex_rst_irq = (unsigned int)ret;
>> +
>> +     name = devm_kasprintf(dev, GFP_KERNEL, "tegra_pcie_%u_pex_rst_irq",
>> +                           pcie->cid);
>> +     if (!name) {
>> +             dev_err(dev, "Failed to create PERST IRQ string\n");
>> +             return -ENOMEM;
>> +     }
>> +
>> +     irq_set_status_flags(pcie->pex_rst_irq, IRQ_NOAUTOEN);
>> +
>> +     ret = devm_request_irq(dev, pcie->pex_rst_irq,
>> +                            tegra_pcie_ep_pex_rst_irq,
>> +                            IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>> +                            name, (void *)pcie);
> 
> I have the impression that a threaded IRQ is what you need, which
> will also remove some boilerplate in the process. Any reason why
> you can't use a threaded IRQ instead of a standalone kthread ?
No reason specifically. We started with kthreads and continued with 
that. I'll post a new series with threaded IRQ. It should be doable.

Thanks,
Vidya Sagar
> 
> Thanks,
> Lorenzo
> 
