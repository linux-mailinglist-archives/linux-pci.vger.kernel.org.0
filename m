Return-Path: <linux-pci+bounces-40679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F03C45309
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 08:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC453B1D81
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 07:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3042EA470;
	Mon, 10 Nov 2025 07:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="if9DZ/p3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m155116.qiye.163.com (mail-m155116.qiye.163.com [101.71.155.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D861F239B;
	Mon, 10 Nov 2025 07:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762759091; cv=none; b=MLjR7Ok7kz44hk+vfDYcSsrcBqXJ6YQR0O2uGpn6hPfoXvyEIdoK7NevXlfZccFUeRVxLQJfSywPg8LVeBX3oWWORmueabSH+RNoNcoVI+Xi/d+8UQglPFSiBk+B5dlm+Q0tVj+rjB5xEVWgyWdenJcTJVLTpJ9rP/zXfiPqhwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762759091; c=relaxed/simple;
	bh=9W4ig4UaFgOqC0e6KV1bK/nKNQVRDInxgESq/tIdAH8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D2jT3sFXigIFkRaQzcqjiUO4hy2lPVx3tGimSvKjc7G90vZG5zVmN8JEjTFTx+o8W4g9GrffiRJ/WCpZDB2gli50HHS0sl/K+GQb7f2+MT84zeIpa1XEK/A5Oh4Pzg6yELmI78+49iZmGmP+Aas8TyubNLLuNxmtPkt6Yzpu4Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=if9DZ/p3; arc=none smtp.client-ip=101.71.155.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2901d3153;
	Mon, 10 Nov 2025 15:12:53 +0800 (GMT+08:00)
Message-ID: <363d6b4d-c999-43d4-866e-880ef7d0dec3@rock-chips.com>
Date: Mon, 10 Nov 2025 15:12:52 +0800
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
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, mani@kernel.org
Subject: Re: [RESEND] Re: [PATCH] PCI: dw-rockchip: Skip waiting for link up
To: FUKAUMI Naoki <naoki@radxa.com>, Niklas Cassel <cassel@kernel.org>
References: <20250113-rockchip-no-wait-v1-1-25417f37b92f@kernel.org>
 <1E8E4DB773970CB5+5a52c9e1-01b8-4872-99b7-021099f04031@radxa.com>
 <6e87b611-13ea-4d89-8dbf-85510dd86fa6@rock-chips.com>
 <aQ840q5BxNS1eIai@ryzen> <aQ9FWEuW47L8YOxC@ryzen>
 <55EB0E5F655F3AFC+136b89fd-98d4-42af-a99d-a0bb05cc93f3@radxa.com>
 <aRCI5kG16_1erMME@ryzen>
 <F8B2B6FA2884D69A+b7da13f2-0ffb-4308-b1ba-0549bc461be8@radxa.com>
 <780a4209-f89f-43a9-9364-331d3b77e61e@rock-chips.com>
 <4487DA40249CC821+19232169-a096-4737-bc6a-5cec9592d65f@radxa.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <4487DA40249CC821+19232169-a096-4737-bc6a-5cec9592d65f@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a6c9c4a2409cckunm5c79c74c133238b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxhDSlZMHh1LSRkYShoeHh5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0
	pVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=if9DZ/p3++Jr6yRTb07dgvDbHKki7GHVkPo/5ZcOaASDOTdTph3sVCQW3FUDOEBHv9Ul8Abn/G52m+9/M25Csywt0zhofeaJXGhlTlFf29EIoGJyg2RpEarVPzeDGIttT+OylN+00Mqa39RVJ5/zGuwEkBmOl7EKIyIhq2HCWW4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=kiWH2lU44C6WEirVPugpjbIQoCqUutdsCudYr3+j3M4=;
	h=date:mime-version:subject:message-id:from;


在 2025/11/10 星期一 12:56, FUKAUMI Naoki 写道:
> Hi Shawn,
> 
> On 11/10/25 11:30, Shawn Lin wrote:
>> Hi Fukaumi
>>
>> 在 2025/11/10 星期一 7:26, FUKAUMI Naoki 写道:
>>> (RESEND: fix mani's email address)
>>>
>>> Hi Niklas,
>>>
>>> On 11/9/25 21:28, Niklas Cassel wrote:
>>>> On Sun, Nov 09, 2025 at 01:42:23PM +0900, FUKAUMI Naoki wrote:
>>>>> Hi Niklas,
>>>>>
>>>>> On 11/8/25 22:27, Niklas Cassel wrote:
>>>>> (snip)> (And btw. please test with the latest 6.18-rc, as, from 
>>>>> experience,
>>>>> the
>>>>>> ASPM problems in earlier RCs can result in some weird problems 
>>>>>> that are
>>>>>> not immediately deduced to be caused by the ASPM enablement.)
>>>>>
>>>>> Here is dmesg from v6.18-rc4:
>>>>>   https://gist.github.com/RadxaNaoki/40e1d049bff4f1d2d4773a5ba0ed9dff
>>>>
>>>> Same problem as before:
>>>> [    1.732538] pci_bus 0004:43: busn_res: can not insert [bus 43-41] 
>>>> under [bus 42-41] (conflicts with (null) [bus 42-41])
>>>> [    1.732645] pci_bus 0004:43: busn_res: [bus 43-41] end is updated 
>>>> to 43
>>>> [    1.732651] pci_bus 0004:43: busn_res: can not insert [bus 43] 
>>>> under [bus 42-41] (conflicts with (null) [bus 42-41])
>>>> [    1.732661] pci 0004:42:00.0: devices behind bridge are unusable 
>>>> because [bus 43] cannot be assigned for them
>>>> [    1.732840] pci_bus 0004:44: busn_res: can not insert [bus 44-41] 
>>>> under [bus 42-41] (conflicts with (null) [bus 42-41])
>>>> [    1.732947] pci_bus 0004:44: busn_res: [bus 44-41] end is updated 
>>>> to 44
>>>> [    1.732952] pci_bus 0004:44: busn_res: can not insert [bus 44] 
>>>> under [bus 42-41] (conflicts with (null) [bus 42-41])
>>>> [    1.732962] pci 0004:42:02.0: devices behind bridge are unusable 
>>>> because [bus 44] cannot be assigned for them
>>>> [    1.733134] pci_bus 0004:45: busn_res: can not insert [bus 45-41] 
>>>> under [bus 42-41] (conflicts with (null) [bus 42-41])
>>>> [    1.733246] pci_bus 0004:45: busn_res: [bus 45-41] end is updated 
>>>> to 45
>>>> [    1.733255] pci_bus 0004:45: busn_res: can not insert [bus 45] 
>>>> under [bus 42-41] (conflicts with (null) [bus 42-41])
>>>> [    1.733266] pci 0004:42:06.0: devices behind bridge are unusable 
>>>> because [bus 45] cannot be assigned for them
>>>> [    1.733438] pci_bus 0004:46: busn_res: can not insert [bus 46-41] 
>>>> under [bus 42-41] (conflicts with (null) [bus 42-41])
>>>> [    1.733544] pci_bus 0004:46: busn_res: [bus 46-41] end is updated 
>>>> to 46
>>>> [    1.733550] pci_bus 0004:46: busn_res: can not insert [bus 46] 
>>>> under [bus 42-41] (conflicts with (null) [bus 42-41])
>>>> [    1.733560] pci 0004:42:0e.0: devices behind bridge are unusable 
>>>> because [bus 46] cannot be assigned for them
>>>> [    1.733571] pci_bus 0004:42: busn_res: [bus 42-41] end is updated 
>>>> to 46
>>>> [    1.733575] pci_bus 0004:42: busn_res: can not insert [bus 42-46] 
>>>> under [bus 41] (conflicts with (null) [bus 41])
>>>> [    1.733585] pci 0004:41:00.0: devices behind bridge are unusable 
>>>> because [bus 42-46] cannot be assigned for them
>>>> [    1.733596] pcieport 0004:40:00.0: bridge has subordinate 41 but 
>>>> max busn 46
>>>>
>>>>
>>>> Seems like the ASM2806 switch, for some reason, is not ready.
>>>>
>>>> One change that Diederik pointed out is that in the "good" case,
>>>> the link is always in Gen1 speed.
>>>>
>>>> Perhaps you could build with CONFIG_PCI_QUIRKS=y and try this patch:
>>>>
>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>> index 214ed060ca1b..ac134d95a97f 100644
>>>> --- a/drivers/pci/quirks.c
>>>> +++ b/drivers/pci/quirks.c
>>>> @@ -96,6 +96,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>>>>   {
>>>>       static const struct pci_device_id ids[] = {
>>>>           { PCI_VDEVICE(ASMEDIA, 0x2824) }, /* ASMedia ASM2824 */
>>>> +        { PCI_VDEVICE(ASMEDIA, 0x2806) }, /* ASMedia ASM2806 */
>>>>           {}
>>>>       };
>>>>       u16 lnksta, lnkctl2;
>>>
>>> It doesn't help with either probing behind the bridge or the link speed.
>>>
>>>> If that does not work, perhaps you could try this patch
>>>> (assuming that all Rock 5C:s have a ASM2806 on pcie2x1l2):
>>>
>>> ROCK 5C has a PCIe FPC connector and I'm using Dual 2.5G Router HAT.
>>>   https://radxa.com/products/rock5/5c#techspec
>>>   https://radxa.com/products/accessories/dual-2-5g-router-hat
>>>
>>> Regarding the link speed, I initially suspected the FPC connector 
>>> and/ or cable might be the issue. However, I tried the Dual 2.5G 
>>> Router HAT with the ROCK 5A (which uses a different cable), and I got 
>>> the same result.
>>>
>>> BTW, the link speed varies between 2Gb/s and 4Gb/s depending on the 
>>> reboot. (with or without quirk)
>>
>> Could you please help check this patch?
> 
> I tried your patch on top of vanilla v6.18-rc5.
>   https://gist.github.com/RadxaNaoki/b42252ce3209d9f6bc2d4c90c71956ae
> 
> I got 2 oops,
> 
> - its_msi_teardown+0x120/0x140
>    New with this patch.
> 
> - of_pci_add_properties+0x284/0x4c4
>    It sometimes happen with vanilla v6.18-rcX.
> 
> Nothing behind the bridge is probed.

Hi Fukaumi,

Thanks for testing. I just got a ASM2806 switch as yours and verified it
on vanilla v6.18-rc5. After 30 times of cold boot, two NVMes behind
ASM2806 work as expected. Nothing special happened when I checked
with PA as well. You could help check the log and lspci dump there[1].

[1]https://pastebin.com/sAF1fT0g

> 
> Best regards,
> 
> -- 
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.
> 
>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> @@ -454,6 +454,8 @@ static irqreturn_t 
>> rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
>>          struct dw_pcie *pci = &rockchip->pci;
>>          struct dw_pcie_rp *pp = &pci->pp;
>>          struct device *dev = pci->dev;
>> +       struct pci_bus *child, *root_bus = NULL;
>> +       struct pci_dev *bridge;
>>          u32 reg;
>>
>>          reg = rockchip_pcie_readl_apb(rockchip, 
>> PCIE_CLIENT_INTR_STATUS_MISC);
>> @@ -462,12 +464,21 @@ static irqreturn_t 
>> rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
>>          dev_dbg(dev, "PCIE_CLIENT_INTR_STATUS_MISC: %#x\n", reg);
>>          dev_dbg(dev, "LTSSM_STATUS: %#x\n", 
>> rockchip_pcie_get_ltssm(rockchip));
>>
>> +       list_for_each_entry(child, &pp->bridge->bus->children, node) {
>> +               if (child->parent == pp->bridge->bus) {
>> +                       root_bus = child;
>> +                       bridge = root_bus->self;
>> +                       break;
>> +               }
>> +        }
>> +
>>          if (reg & PCIE_RDLH_LINK_UP_CHGED) {
>>                  if (rockchip_pcie_link_up(pci)) {
>>                          msleep(PCIE_RESET_CONFIG_WAIT_MS);
>>                          dev_dbg(dev, "Received Link up event. 
>> Starting enumeration!\n");
>>                          /* Rescan the bus to enumerate endpoint 
>> devices */
>>                          pci_lock_rescan_remove();
>> +                       pci_stop_and_remove_bus_device(bridge);
>>                          pci_rescan_bus(pp->bridge->bus);
>>                          pci_unlock_rescan_remove();
>>                  }
>>
>>
>>>
>>> Best regards,
>>>
>>> -- 
>>> FUKAUMI Naoki
>>> Radxa Computer (Shenzhen) Co., Ltd.
>>>
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts b/ 
>>>> arch/ arm64/boot/dts/rockchip/rk3588s-rock-5c.dts
>>>> index dd7317bab613..26f8539d934a 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts
>>>> @@ -452,6 +452,7 @@ &pcie2x1l2 {
>>>>       pinctrl-0 = <&pcie20x1_2_perstn_m0>;
>>>>       reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
>>>>       vpcie3v3-supply = <&pcie2x1l2_3v3>;
>>>> +    max-link-speed = <1>;
>>>>       status = "okay";
>>>>   };
>>>>
>>>>
>>>>
>>>> Kind regards,
>>>> Niklas
>>>>
>>>
>>>
>>
>>
> 
> 


