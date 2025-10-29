Return-Path: <linux-pci+bounces-39598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 046FDC18634
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 07:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0D924E1BAB
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 06:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694ED28850E;
	Wed, 29 Oct 2025 06:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="EnhdmNK7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49205.qiye.163.com (mail-m49205.qiye.163.com [45.254.49.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A31A1F4606;
	Wed, 29 Oct 2025 06:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761718270; cv=none; b=boI0q0Fl/Z5UVykcxw7X5jhlOtZgw3oOzREWtnA8fItTzglODBrCJur/eJA6ow1Yz9o8BF8cuIfQsqHagqa8mbQIZpp4c4Gm1Cj05b3YNTvrXNVtp1owOmighcoI2CvULlliFYOPkGoowZpR2jpZ4Wg9LtEd+8DWJK/Ro5B53b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761718270; c=relaxed/simple;
	bh=AXxcj1V8QdcEZ6+NUQdvhEijUxhQu5p79+OdzWF+vJs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZZHZ+GXAo6f5BCjpY5QvPJ4CA4UAYurwEz7Y4UL56qmne0oLCMDifDaNGIAYJKMQZvYBegzDbC1Zs4deEJw0EBpBdut9HqABVMcEN5gvUmYh/WR4FFTWZ4RwxPo0xnxQSrNdhMgUJ3G6vYP3XB+KzFIGaAE02I061O1tKsQauK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=EnhdmNK7; arc=none smtp.client-ip=45.254.49.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 278abcfb1;
	Wed, 29 Oct 2025 08:28:13 +0800 (GMT+08:00)
Message-ID: <3fcd5562-a367-41e9-8bff-51e5990145e2@rock-chips.com>
Date: Wed, 29 Oct 2025 08:28:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Niklas Cassel <cassel@kernel.org>, Hans Zhang <18255117159@163.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>,
 "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] PCI: dw-rockchip: Add remove callback for resource
 cleanup
To: Anand Moon <linux.amoon@gmail.com>
References: <20251027145602.199154-1-linux.amoon@gmail.com>
 <20251027145602.199154-2-linux.amoon@gmail.com>
 <4fe0ccf9-8866-443a-8083-4a2af7035ee6@rock-chips.com>
 <CANAwSgRXcg4tO00SNu77EKdp6Ay6X7+_f-ZoHxgkv1himxdi0Q@mail.gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CANAwSgRXcg4tO00SNu77EKdp6Ay6X7+_f-ZoHxgkv1himxdi0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a2d5d7fa609cckunm42001d6025423a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUJKGlYdHRlOTRlIQ0MYQkxWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=EnhdmNK7UPDdSC1XgqbfxEnNOjTCjGjaaUnxh2iZtaj5IhIedJTIvIhcCv8kSzJCibxayqMndZwLbtjWAa0MSChiyaL9qn1PrpBiqijpLzyLMPj9MTV4tpwSc+SzHZbhlLbls67xsUtwKxdbSWyM9FPC6TLvQ0aYkJ2sb7BHuXI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=VXeB1XRi1t4+hav00/PO85fUCGM4DHZek+mbIiPUEtA=;
	h=date:mime-version:subject:message-id:from;


在 2025/10/28 星期二 17:34, Anand Moon 写道:
> Hi Shawn,
> 
> Thanks for your review comments.
> 
> On Tue, 28 Oct 2025 at 05:56, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> 在 2025/10/27 星期一 22:55, Anand Moon 写道:
>>> Introduce a .remove() callback to the Rockchip DesignWare PCIe
>>> controller driver to ensure proper resource deinitialization during
>>> device removal. This includes disabling clocks and deinitializing the
>>> PCIe PHY.
>>>
>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>> ---
>>>    drivers/pci/controller/dwc/pcie-dw-rockchip.c | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>> index 87dd2dd188b4..b878ae8e2b3e 100644
>>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>> @@ -717,6 +717,16 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>>>        return ret;
>>>    }
>>>
>>> +static void rockchip_pcie_remove(struct platform_device *pdev)
>>> +{
>>> +     struct device *dev = &pdev->dev;
>>> +     struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
>>> +
>>> +     /* Perform other cleanups as necessary */
>>> +     clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
>>> +     rockchip_pcie_phy_deinit(rockchip);
>>> +}
>>
>> Thanks for the patch.
>>
>> Dou you need to call dw_pcie_host_deinit()?
> I feel the rockchip_pcie_phy_deinit will power off the phy
>> And I think you should also try to mask PCIE_CLIENT_INTR_MASK_MISC and
>> remove the irq domain as well.
>>
>> if (rockchip->irq_domain) {
>>          int virq, j;
>>          for (j = 0; j < PCI_NUM_INTX; j++) {
>>                  virq = irq_find_mapping(rockchip->irq_domain, j);
>>                  if (virq > 0)
>>                          irq_dispose_mapping(virq);
>>           }
>>          irq_set_chained_handler_and_data(rockchip->irq, NULL, NULL);
>>          irq_domain_remove(rockchip->irq_domain);
>> }
>>
> I have implemented resource cleanup in rockchip_pcie_remove,
> which is invoked when the system is shutting down.
> Your feedback on the updated code is welcome.
> 
> static void rockchip_pcie_remove(struct platform_device *pdev)
> {
>          struct device *dev = &pdev->dev;
>          struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
>          int irq;
> 
>          irq = of_irq_get_byname(dev->of_node, "legacy");
>          if (irq < 0)
>                  return;
> 
>          /* Perform other cleanups as necessary */
>          /* clear up INTR staatus register */
>          rockchip_pcie_writel_apb(rockchip, 0xffffffff,
>                                   PCIE_CLIENT_INTR_STATUS_MISC);
>          if (rockchip->irq_domain) {
>                  int virq, j;
>                  for (j = 0; j < PCI_NUM_INTX; j++) {
>                          virq = irq_find_mapping(rockchip->irq_domain, j);
>                          if (virq > 0)
>                                  irq_dispose_mapping(virq);
>                  }
>                  irq_set_chained_handler_and_data(irq, NULL, NULL);
>                  irq_domain_remove(rockchip->irq_domain);
>          }
> 
>          clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
>          /* poweroff the phy */
>          rockchip_pcie_phy_deinit(rockchip);
>          /* release the reset */

release? Or "reset the controller"?

>          reset_control_assert(rockchip->rst);
>          pm_runtime_put_sync(dev);
>          pm_runtime_disable(dev);
>          pm_runtime_no_callbacks(dev);
> }
> 
>> Another thin I noticed is should we call pm_runtime_* here for hope that
>> genpd could be powered donw once removed?
>>
> I could not find 'genpd' (power domain) used in the PCIe driver
> If we have an example to use genpd I will update this.
 > > I am also looking into adding NOIRQ_SYSTEM_SLEEP_PM_OPS

That sounds good, you can pick up my patch[1] if you'd like to continue
addressing the comments that I haven't had time to think more.

[1] https://www.spinics.net/lists/linux-pci/msg171846.html

> 
> Thanks
> -Anand
> 


