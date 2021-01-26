Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F645303573
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 06:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbhAZFmU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 00:42:20 -0500
Received: from regular1.263xmail.com ([211.150.70.200]:47082 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732258AbhAZCkd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jan 2021 21:40:33 -0500
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id 8F5531D84;
        Tue, 26 Jan 2021 10:34:26 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.31.83] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P19895T139773254842112S1611628456710507_;
        Tue, 26 Jan 2021 10:34:25 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f4a2667adf4e7ccc101c1c7abede742c>
X-RL-SENDER: xxm@rock-chips.com
X-SENDER: xxm@rock-chips.com
X-LOGIN-NAME: xxm@rock-chips.com
X-FST-TO: jbx6244@gmail.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH v3 2/2] PCI: rockchip: add DesignWare based PCIe
 controller
To:     Leon Romanovsky <leon@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Johan Jonker <jbx6244@gmail.com>
References: <20210125024824.634583-1-xxm@rock-chips.com>
 <20210125024927.634634-1-xxm@rock-chips.com> <20210125054836.GB579511@unreal>
 <0b65ca38-ff7a-f9cd-5406-1f275fbbecd1@rock-chips.com>
 <20210125090129.GF579511@unreal>
 <e7ed6586-06f3-52e3-b2db-38887a5a37e4@arm.com>
 <20210125184541.GJ579511@unreal>
From:   xxm <xxm@rock-chips.com>
Message-ID: <79885f84-5c89-b21a-b0e1-dcb870736b05@rock-chips.com>
Date:   Tue, 26 Jan 2021 10:34:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125184541.GJ579511@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Leon,

Thanks for your reply.

在 2021/1/26 2:45, Leon Romanovsky 写道:
> On Mon, Jan 25, 2021 at 03:53:38PM +0000, Robin Murphy wrote:
>> On 2021-01-25 09:01, Leon Romanovsky wrote:
>>> On Mon, Jan 25, 2021 at 02:40:10PM +0800, xxm wrote:
>>>> Hi Leon,
>>>>
>>>> Thanks for your reply.
>>>>
>>>> 在 2021/1/25 13:48, Leon Romanovsky 写道:
>>>>> On Mon, Jan 25, 2021 at 10:49:27AM +0800, Simon Xue wrote:
>>>>>> pcie-dw-rockchip is based on DWC IP. But pcie-rockchip-host
>>>>>> is Rockchip designed IP which is only used for RK3399. So all the following
>>>>>> non-RK3399 SoCs should use this driver.
>>>>>>
>>>>>> Signed-off-by: Simon Xue <xxm@rock-chips.com>
>>>>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>>>> ---
>>>>>>     drivers/pci/controller/dwc/Kconfig            |   9 +
>>>>>>     drivers/pci/controller/dwc/Makefile           |   1 +
>>>>>>     drivers/pci/controller/dwc/pcie-dw-rockchip.c | 286 ++++++++++++++++++
>>>>>>     3 files changed, 296 insertions(+)
>>>>>>     create mode 100644 drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>>>>>
>>>>>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>>>>>> index 22c5529e9a65..aee408fe9283 100644
>>>>>> --- a/drivers/pci/controller/dwc/Kconfig
>>>>>> +++ b/drivers/pci/controller/dwc/Kconfig
>>>>>> @@ -214,6 +214,15 @@ config PCIE_ARTPEC6_EP
>>>>>>     	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
>>>>>>     	  endpoint mode. This uses the DesignWare core.
>>>>>>
>>>>>> +config PCIE_ROCKCHIP_DW_HOST
>>>>>> +	bool "Rockchip DesignWare PCIe controller"
>>>>>> +	select PCIE_DW
>>>>>> +	select PCIE_DW_HOST
>>>>>> +	depends on ARCH_ROCKCHIP || COMPILE_TEST
>>>>>> +	depends on OF
>>>>>> +	help
>>>>>> +	  Enables support for the DW PCIe controller in the Rockchip SoC.
>>>>>> +
>>>>>>     config PCIE_INTEL_GW
>>>>>>     	bool "Intel Gateway PCIe host controller support"
>>>>>>     	depends on OF && (X86 || COMPILE_TEST)
>>>>>> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
>>>>>> index a751553fa0db..30eef8e9ee8a 100644
>>>>>> --- a/drivers/pci/controller/dwc/Makefile
>>>>>> +++ b/drivers/pci/controller/dwc/Makefile
>>>>>> @@ -13,6 +13,7 @@ obj-$(CONFIG_PCI_LAYERSCAPE_EP) += pci-layerscape-ep.o
>>>>>>     obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>>>>>>     obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>>>>>>     obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
>>>>>> +obj-$(CONFIG_PCIE_ROCKCHIP_DW_HOST) += pcie-dw-rockchip.o
>>>>>>     obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
>>>>>>     obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
>>>>>>     obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
>>>>>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..07f6d1cd5853
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>>>>> @@ -0,0 +1,286 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>> +/*
>>>>>> + * PCIe host controller driver for Rockchip SoCs
>>>>>> + *
>>>>>> + * Copyright (C) 2021 Rockchip Electronics Co., Ltd.
>>>>>> + *		http://www.rock-chips.com
>>>>>> + *
>>>>>> + * Author: Simon Xue <xxm@rock-chips.com>
>>>>>> + */
>>>>>> +
>>>>>> +#include <linux/clk.h>
>>>>>> +#include <linux/gpio/consumer.h>
>>>>>> +#include <linux/mfd/syscon.h>
>>>>>> +#include <linux/module.h>
>>>>>> +#include <linux/of_device.h>
>>>>>> +#include <linux/phy/phy.h>
>>>>>> +#include <linux/platform_device.h>
>>>>>> +#include <linux/regmap.h>
>>>>>> +#include <linux/reset.h>
>>>>>> +
>>>>>> +#include "pcie-designware.h"
>>>>>> +
>>>>>> +/*
>>>>>> + * The upper 16 bits of PCIE_CLIENT_CONFIG are a write
>>>>>> + * mask for the lower 16 bits.  This allows atomic updates
>>>>>> + * of the register without locking.
>>>>>> + */
>>>>> This is correct only for the variables that naturally aligned, I imagine
>>>>> that this is the case here and in the Linux, but better do not write comments
>>>>> in the code that are not accurate.
>>>> Ok, will remove.
>>>> I wonder what it would be when outside the Linux? Could you share some information?
>>> The C standard says nothing about atomicity, integer assignment maybe atomic,
>>> maybe it isn’t. There is no guarantee, plain integer assignment in C is non-atomic
>>> by definition.
>>>
>>> The atomicity of u32 is very dependent on hardware vendor, memory model and compiler,
>>> for example x86 and ARMs guarantee atomicity for u32. This is why I said that probably
>>> here (Linux) it is ok and you are not alone in expecting lockless write.
>> Huh? What do variables and the abstract machine of the C language
>> environment have to do with the definition of *hardware MMIO registers*? We
>> don't write to registers with plain integer assignment of u32, we use
>> writel() (precisely in order to bypass that abstract C environment).
>>
>> I appreciate that the comment is not universally true if taken completely
>> out of context, but I that's true of pretty much all comments ever. If
>> someone really were trying to learn basic programming principles from random
>> comments in Linux drivers, then it's already a bit late for us to try and
>> save them from themselves.
> So what? Does it mean that new code should have comments that are not
> correct? As you can see from this conversation, even the author didn't
> know what u32 isn’t guaranteed to be atomic, so yes, the comments should
> be correct.

What I do know is writel() will do the right things(like mem barrier, 
atomic...) to update the registers correctly

in "ARM + Linux" platform. But I have no idear if out of  this specific 
platform, so I asked for more information to learn.

Anyway, I will keep the first part of comment to illustrate how to use 
PCIE_CLIENT_REGISTER, and remove the "atomic" part.

> Thanks
>
>


