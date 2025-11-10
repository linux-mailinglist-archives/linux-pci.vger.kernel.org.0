Return-Path: <linux-pci+bounces-40668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9113C44EF8
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 05:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7299B188B016
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 04:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4BE257852;
	Mon, 10 Nov 2025 04:56:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A23192D8A;
	Mon, 10 Nov 2025 04:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762750606; cv=none; b=QDPJk7uD/1Jlk3FNRKd+Pi4pXIa7/aDN/X7CoggT9z0ITFrNEEUR6bgQV151PppjS/RQdCzAygvZKFENAxyCrA+nrFW2OSUdH1ab8Qj58YYqv6VANkGBqPl6dnB17fjEapDKdS0KyTQkX2FY7sU0qfe/WUJkQoahhuR2pY99b7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762750606; c=relaxed/simple;
	bh=vuSSJ5lVhs5/D7bBHlZMp7Fcz7SC7zsqdWca8T7O4lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UdatXtNev3oA/8K49LxmUVpOqak7OyW28hvdyvlsqObEF5eYYa4gbBc50UUWchgoQBhbq391V16idb/41dfI2DAcA+Ft47iAVy7wKI0NQA8MdeWaekAcr09O7JeEp+AgZBc5PPUgKoW4Ca8S0ZQor+Vv1Kx3n+Gol6Q+bvth14A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1762750567t2c0a3873
X-QQ-Originating-IP: sCbPGXNSp3rCGfP8X/uqriZf4cuAEpZXSbbY2NF4pvY=
Received: from [IPV6:240f:10b:7440:1:64e0:6ba: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 10 Nov 2025 12:56:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10838902812744037431
Message-ID: <4487DA40249CC821+19232169-a096-4737-bc6a-5cec9592d65f@radxa.com>
Date: Mon, 10 Nov 2025 13:56:03 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] Re: [PATCH] PCI: dw-rockchip: Skip waiting for link up
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Anand Moon <linux.amoon@gmail.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Dragan Simic <dsimic@manjaro.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 mani@kernel.org, Niklas Cassel <cassel@kernel.org>
References: <20250113-rockchip-no-wait-v1-1-25417f37b92f@kernel.org>
 <1E8E4DB773970CB5+5a52c9e1-01b8-4872-99b7-021099f04031@radxa.com>
 <6e87b611-13ea-4d89-8dbf-85510dd86fa6@rock-chips.com>
 <aQ840q5BxNS1eIai@ryzen> <aQ9FWEuW47L8YOxC@ryzen>
 <55EB0E5F655F3AFC+136b89fd-98d4-42af-a99d-a0bb05cc93f3@radxa.com>
 <aRCI5kG16_1erMME@ryzen>
 <F8B2B6FA2884D69A+b7da13f2-0ffb-4308-b1ba-0549bc461be8@radxa.com>
 <780a4209-f89f-43a9-9364-331d3b77e61e@rock-chips.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <780a4209-f89f-43a9-9364-331d3b77e61e@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MjQ00mYXMHtuiaHRtmsnbZ5BomsDZD/7KjQ+SmXa+8PPMbWf/5Vy3NiV
	yjDfRVlCBeTp6RhYwxFqTPealz0GgCvNTn2iFqUMQ10bpiQK3MU0/qNMLrebT2iQRjFiCDz
	Nx+kd32xYn7H+xAlGHDIOQ/NWDvEhO/YLPPhaAGmU5BYC9+qoAgn/5cpveytyfezIpOf4a2
	F9PT0I4iXO96Vx9LQ0ALGjSEcheJZIvTDQ4MY8UkBRDy+RExsPJ65kEWrhEwETSChH5XWfV
	yipO1C3xPh8aCpI8DYhRftPZKwyKZzgN+ppdNZ5IMLaB4EksrCOufHLrGwsHdGcf6rgOn4v
	GkuXQhiGAwruMhoWUaXIKVofszI8D6rwqM11J4Ha2Cj8ActK++3HCVIp3PzE/2xaHiPFsRZ
	AUQxy/7OlH4IeIXnSAv49Fg905I3UHfMX0QveKiAGyjvvs82VtE3hwFoAd3/ajotPlmqAmn
	hN2XqkGSpzxkBaFbUa48I+2M2+FXDNWGwIu8l4i4EUJMT/lhWC6oqpJ3ftdUhVzzwVipXPH
	VIKi31mz6S/XfIfecg1JTgZwYXW4CPcEN8ZgP0x+pDKQV09g9Sups3R11LUnnuS3y+KE4SU
	xoqHVOYeyRAcDwdconRMOtDDLPpjQJL3tIMj8sk028yiRhXpF4rBOQO9Mlq5jwCDegj4QR6
	xth15El+zNHlI7lmWGxlUXGpLT8m4r1LhER89jL3Jf7yWwaOTIn8t+PjwXSYYs+vyJvzDGO
	Nfh+JWdZrMeQM33DsJ6Dz3HARoFDJkBK2YSUpoObqetstCMwdNyRrwahpBKW6LeUXWYJr/p
	uhyBPCrfDkE0mdFMiwvkoTc1jeislQv/TjbHVXi1f+zFBGUZ4/+Utqk0R01+7dYZPltXuAZ
	KVwI0ZgW+XHO8bmeJOYZzIK8Bt9jPVofAJsZtqE3/ltepivX1X3nSiKBZA+FI8sO5F/l/E+
	pEjx/9sipDyRUcNVxJAHuSG9WEXpFZyMLnbu4lRzhQ6sGf8qswy+HlejwL2bFcHUi/aA=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Hi Shawn,

On 11/10/25 11:30, Shawn Lin wrote:
> Hi Fukaumi
> 
> 在 2025/11/10 星期一 7:26, FUKAUMI Naoki 写道:
>> (RESEND: fix mani's email address)
>>
>> Hi Niklas,
>>
>> On 11/9/25 21:28, Niklas Cassel wrote:
>>> On Sun, Nov 09, 2025 at 01:42:23PM +0900, FUKAUMI Naoki wrote:
>>>> Hi Niklas,
>>>>
>>>> On 11/8/25 22:27, Niklas Cassel wrote:
>>>> (snip)> (And btw. please test with the latest 6.18-rc, as, from 
>>>> experience,
>>>> the
>>>>> ASPM problems in earlier RCs can result in some weird problems that 
>>>>> are
>>>>> not immediately deduced to be caused by the ASPM enablement.)
>>>>
>>>> Here is dmesg from v6.18-rc4:
>>>>   https://gist.github.com/RadxaNaoki/40e1d049bff4f1d2d4773a5ba0ed9dff
>>>
>>> Same problem as before:
>>> [    1.732538] pci_bus 0004:43: busn_res: can not insert [bus 43-41] 
>>> under [bus 42-41] (conflicts with (null) [bus 42-41])
>>> [    1.732645] pci_bus 0004:43: busn_res: [bus 43-41] end is updated 
>>> to 43
>>> [    1.732651] pci_bus 0004:43: busn_res: can not insert [bus 43] 
>>> under [bus 42-41] (conflicts with (null) [bus 42-41])
>>> [    1.732661] pci 0004:42:00.0: devices behind bridge are unusable 
>>> because [bus 43] cannot be assigned for them
>>> [    1.732840] pci_bus 0004:44: busn_res: can not insert [bus 44-41] 
>>> under [bus 42-41] (conflicts with (null) [bus 42-41])
>>> [    1.732947] pci_bus 0004:44: busn_res: [bus 44-41] end is updated 
>>> to 44
>>> [    1.732952] pci_bus 0004:44: busn_res: can not insert [bus 44] 
>>> under [bus 42-41] (conflicts with (null) [bus 42-41])
>>> [    1.732962] pci 0004:42:02.0: devices behind bridge are unusable 
>>> because [bus 44] cannot be assigned for them
>>> [    1.733134] pci_bus 0004:45: busn_res: can not insert [bus 45-41] 
>>> under [bus 42-41] (conflicts with (null) [bus 42-41])
>>> [    1.733246] pci_bus 0004:45: busn_res: [bus 45-41] end is updated 
>>> to 45
>>> [    1.733255] pci_bus 0004:45: busn_res: can not insert [bus 45] 
>>> under [bus 42-41] (conflicts with (null) [bus 42-41])
>>> [    1.733266] pci 0004:42:06.0: devices behind bridge are unusable 
>>> because [bus 45] cannot be assigned for them
>>> [    1.733438] pci_bus 0004:46: busn_res: can not insert [bus 46-41] 
>>> under [bus 42-41] (conflicts with (null) [bus 42-41])
>>> [    1.733544] pci_bus 0004:46: busn_res: [bus 46-41] end is updated 
>>> to 46
>>> [    1.733550] pci_bus 0004:46: busn_res: can not insert [bus 46] 
>>> under [bus 42-41] (conflicts with (null) [bus 42-41])
>>> [    1.733560] pci 0004:42:0e.0: devices behind bridge are unusable 
>>> because [bus 46] cannot be assigned for them
>>> [    1.733571] pci_bus 0004:42: busn_res: [bus 42-41] end is updated 
>>> to 46
>>> [    1.733575] pci_bus 0004:42: busn_res: can not insert [bus 42-46] 
>>> under [bus 41] (conflicts with (null) [bus 41])
>>> [    1.733585] pci 0004:41:00.0: devices behind bridge are unusable 
>>> because [bus 42-46] cannot be assigned for them
>>> [    1.733596] pcieport 0004:40:00.0: bridge has subordinate 41 but 
>>> max busn 46
>>>
>>>
>>> Seems like the ASM2806 switch, for some reason, is not ready.
>>>
>>> One change that Diederik pointed out is that in the "good" case,
>>> the link is always in Gen1 speed.
>>>
>>> Perhaps you could build with CONFIG_PCI_QUIRKS=y and try this patch:
>>>
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index 214ed060ca1b..ac134d95a97f 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -96,6 +96,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>>>   {
>>>       static const struct pci_device_id ids[] = {
>>>           { PCI_VDEVICE(ASMEDIA, 0x2824) }, /* ASMedia ASM2824 */
>>> +        { PCI_VDEVICE(ASMEDIA, 0x2806) }, /* ASMedia ASM2806 */
>>>           {}
>>>       };
>>>       u16 lnksta, lnkctl2;
>>
>> It doesn't help with either probing behind the bridge or the link speed.
>>
>>> If that does not work, perhaps you could try this patch
>>> (assuming that all Rock 5C:s have a ASM2806 on pcie2x1l2):
>>
>> ROCK 5C has a PCIe FPC connector and I'm using Dual 2.5G Router HAT.
>>   https://radxa.com/products/rock5/5c#techspec
>>   https://radxa.com/products/accessories/dual-2-5g-router-hat
>>
>> Regarding the link speed, I initially suspected the FPC connector and/ 
>> or cable might be the issue. However, I tried the Dual 2.5G Router HAT 
>> with the ROCK 5A (which uses a different cable), and I got the same 
>> result.
>>
>> BTW, the link speed varies between 2Gb/s and 4Gb/s depending on the 
>> reboot. (with or without quirk)
> 
> Could you please help check this patch?

I tried your patch on top of vanilla v6.18-rc5.
  https://gist.github.com/RadxaNaoki/b42252ce3209d9f6bc2d4c90c71956ae

I got 2 oops,

- its_msi_teardown+0x120/0x140
   New with this patch.

- of_pci_add_properties+0x284/0x4c4
   It sometimes happen with vanilla v6.18-rcX.

Nothing behind the bridge is probed.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -454,6 +454,8 @@ static irqreturn_t 
> rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
>          struct dw_pcie *pci = &rockchip->pci;
>          struct dw_pcie_rp *pp = &pci->pp;
>          struct device *dev = pci->dev;
> +       struct pci_bus *child, *root_bus = NULL;
> +       struct pci_dev *bridge;
>          u32 reg;
> 
>          reg = rockchip_pcie_readl_apb(rockchip, 
> PCIE_CLIENT_INTR_STATUS_MISC);
> @@ -462,12 +464,21 @@ static irqreturn_t 
> rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
>          dev_dbg(dev, "PCIE_CLIENT_INTR_STATUS_MISC: %#x\n", reg);
>          dev_dbg(dev, "LTSSM_STATUS: %#x\n", 
> rockchip_pcie_get_ltssm(rockchip));
> 
> +       list_for_each_entry(child, &pp->bridge->bus->children, node) {
> +               if (child->parent == pp->bridge->bus) {
> +                       root_bus = child;
> +                       bridge = root_bus->self;
> +                       break;
> +               }
> +        }
> +
>          if (reg & PCIE_RDLH_LINK_UP_CHGED) {
>                  if (rockchip_pcie_link_up(pci)) {
>                          msleep(PCIE_RESET_CONFIG_WAIT_MS);
>                          dev_dbg(dev, "Received Link up event. Starting 
> enumeration!\n");
>                          /* Rescan the bus to enumerate endpoint devices */
>                          pci_lock_rescan_remove();
> +                       pci_stop_and_remove_bus_device(bridge);
>                          pci_rescan_bus(pp->bridge->bus);
>                          pci_unlock_rescan_remove();
>                  }
> 
> 
>>
>> Best regards,
>>
>> -- 
>> FUKAUMI Naoki
>> Radxa Computer (Shenzhen) Co., Ltd.
>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts b/arch/ 
>>> arm64/boot/dts/rockchip/rk3588s-rock-5c.dts
>>> index dd7317bab613..26f8539d934a 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts
>>> @@ -452,6 +452,7 @@ &pcie2x1l2 {
>>>       pinctrl-0 = <&pcie20x1_2_perstn_m0>;
>>>       reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
>>>       vpcie3v3-supply = <&pcie2x1l2_3v3>;
>>> +    max-link-speed = <1>;
>>>       status = "okay";
>>>   };
>>>
>>>
>>>
>>> Kind regards,
>>> Niklas
>>>
>>
>>
> 
> 


