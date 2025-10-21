Return-Path: <linux-pci+bounces-38854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 282C8BF4D88
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 09:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44953BF7B1
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 07:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39D32749E4;
	Tue, 21 Oct 2025 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Xos0oDM9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49194.qiye.163.com (mail-m49194.qiye.163.com [45.254.49.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB261CAA79;
	Tue, 21 Oct 2025 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030623; cv=none; b=m7EDN8mIoe12ErnQcipb1lTld+o0c+NLq9XnLtj3EGcbipv7kIJtP9x+xAHhYzfPSOvv0GE8v7XYWlxNiW/nmyhy2Cttuci979hVOZ2aSpvg7x1bk3x2wpXSZ9Lm3h0eYxQyFMjlzNVKcGjW4g2FiaVpKUCB7+Gi5iGd8DtdigI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030623; c=relaxed/simple;
	bh=0MrkHmknRf9JrFvfo52AyrGTJ4OnsKy/bcpUsw0zSIg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qCu9m1J5tBxcV+WxP+misiXFnp87xlhwFhVagcw0stdj3tRvhAyvAZHM+NviDB3s2gdEjrEx1ummCH/rL8bqiuibg3MAA0aBt/j/47/81SSkxYi6sVyuEV/155BytV0ZMnxdY1KxW9pywD4fc3LYuHJr0Nhn3Cd9UQVdV2TXgo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Xos0oDM9; arc=none smtp.client-ip=45.254.49.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26a04dd28;
	Tue, 21 Oct 2025 15:10:15 +0800 (GMT+08:00)
Message-ID: <6e87b611-13ea-4d89-8dbf-85510dd86fa6@rock-chips.com>
Date: Tue, 21 Oct 2025 15:10:13 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Damien Le Moal <dlemoal@kernel.org>,
 Anand Moon <linux.amoon@gmail.com>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Dragan Simic <dsimic@manjaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] PCI: dw-rockchip: Skip waiting for link up
To: FUKAUMI Naoki <naoki@radxa.com>, Niklas Cassel <cassel@kernel.org>
References: <20250113-rockchip-no-wait-v1-1-25417f37b92f@kernel.org>
 <1E8E4DB773970CB5+5a52c9e1-01b8-4872-99b7-021099f04031@radxa.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <1E8E4DB773970CB5+5a52c9e1-01b8-4872-99b7-021099f04031@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a059ab03d09cckunm368fe7546378e8
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRlMHlZMGEkdT0oYHUhDQx5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Xos0oDM9U+/0NylMEL8BB6RuBd69z3lnV+GumxjkBut/AP4cPRzd/vEwQFu9Y0yZl9ylfTifD4WYmtQLfDFSTfDUOm6IrlAU9x4wRdv7I2pZ6NGG00jyiBi+qLpg8afql3x9baCOQsYhc1URYAHef4Q4vfCHixVaDZf/eS4A/cQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=FqKFwJTtAHqh86lEqRIcwq3CBA+ub4FQsb9uC2nRB3g=;
	h=date:mime-version:subject:message-id:from;

在 2025/10/21 星期二 12:26, FUKAUMI Naoki 写道:
> Hi Niklas, Bjorn,
> 
> I noticed an issue on the Rockchip RK3588S SoC using the ASMedia ASM2806 
> PCIe bridge where devices behind the bridge fail to probe since v6.14.
> Specifically, this started happening after commit 
> 647d69605c70368d54fc012fce8a43e8e5955b04.
> dmesg logs from before and after this commit are available at:
>   https://gist.github.com/RadxaNaoki/fca2bfca2ee80fefee7b00c7967d2e3d
> 
> I have confirmed that reverting the following commits fixes the issue:
>   commit ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we 
> can detect Link Up")
>   commit 0e0b45ab5d77 ("PCI: dw-rockchip: Enumerate endpoints based on 
> dll_link_up IRQ")
> 

Then these two commits would like to reply on link up irq instead of
fixed delay in dwc framework. Here is a not very precise timeline
description.

time(ms) |  dw_pcie_wait_for_link（）     | sys irq_thread() | Hot reset
-------------------------------------------------------------------------
0:       |  dw_pcie_link_up return false  |  link up irq     |
1x       |  Physical link up happend      |                  |
90:      |  dw_pcie_link_up return true   |                  |
100:     |                                |  msleep(100) done|
10x:     |                                |  pci_rescan_bus  |
1xx:     |                                |                  | <==occur
190:     |  msleep(90) done               |                  |
19x:     |  pci_host_probe                |                  |

What if the hot reset happens when pci_rescan_bus() starts. I think
scan devices possible fail when seeing 0xffffffff from cfg read. But
a 90ms delay perfectly avoids this event in dw_pcie_wait_for_link(), and 
by the time the 90ms delay is completed, the link is actually in an
accessible state.

> On v6.18-rc2, the cold boot behavior has changed somewhat, and I have 
> observed the following three behaviors so far:
> 
> - Probe succeeds
> - Probe fails
> - Kernel oops
> 
> There seems to be no pattern to these three behaviors. During a warm 
> boot, a successful probe does not seem to occur.
> 
> If commit ec9fd499b9c6 is reverted on v6.18-rc2, I have observed the 
> following two behaviors so far:
> 
> - Probe succeeds
> - Kernel oops
> 
> "Probe fails" has not been observed so far.
> 
> The dmesg for the kernel oops is available at:
>   https://gist.github.com/RadxaNaoki/4b2dcd5e41b09004eda2fdeb80ae5e15
> 
> Can you please help me with this issue?
> 
> Best regards,
> 
> -- 
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.
> 
> On 1/13/25 19:59, Niklas Cassel wrote:
>> The Root Complex specific device tree binding for pcie-dw-rockchip has 
>> the
>> 'sys' interrupt marked as required.
>>
>> The driver requests the 'sys' IRQ unconditionally, and errors out if not
>> provided.
>>
>> Thus, we can unconditionally set use_linkup_irq before calling
>> dw_pcie_host_init().
>>
>> This will skip the wait for link up (since the bus will be enumerated 
>> once
>> the link up IRQ is triggered), which reduces the bootup time.
>>
>> Signed-off-by: Niklas Cassel <cassel@kernel.org>
>> ---
>>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>>
>> ---
>> base-commit: 2adda4102931b152f35d054055497631ed97fe73
>> change-id: 20250113-rockchip-no-wait-403ffbc42313
>>
>> Best regards,
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/ 
>> pci/controller/dwc/pcie-dw-rockchip.c
>> index 
>> 1170e1107508bd793b610949b0afe98516c177a4..62034affb95fbb965aad3cebc613a83e31c90aee 100644
>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> @@ -435,6 +435,7 @@ static int rockchip_pcie_configure_rc(struct 
>> rockchip_pcie *rockchip)
>>       pp = &rockchip->pci.pp;
>>       pp->ops = &rockchip_pcie_host_ops;
>> +    pp->use_linkup_irq = true;
>>       return dw_pcie_host_init(pp);
>>   }
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 


