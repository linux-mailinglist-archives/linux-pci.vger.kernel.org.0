Return-Path: <linux-pci+bounces-40659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DB8C44A26
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 00:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38465188C266
	for <lists+linux-pci@lfdr.de>; Sun,  9 Nov 2025 23:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BE121858D;
	Sun,  9 Nov 2025 23:27:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBA7221540;
	Sun,  9 Nov 2025 23:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762730847; cv=none; b=UG3IZrKrznovuZv7/ABhm2Smqej2IJA7hW96x0YdKNl26JwuGRj9Q5UpMUOPUw7v5KzS9inbuRw0WWp7NWUMl8+f07hF0lgw4jio/khRWN/NU/sOYQAezKsPBcJsVqZkfwYO4HFq8ehlkujm7axiJqyEc2T0JDNt9UkXwOhfwv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762730847; c=relaxed/simple;
	bh=8SrTwbMflVcat3ahnfwwZTWOIz8pK42Ml9bkc01KNZ0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qi9YtsxjTz/d2tIWb4oLT1P+Pg2MVL3G4kxOwOySMwbpxYCldMw9gSMwutKyajwgyd8X/aQ3aly/Q7hjuholaob/fQSbWnlycBPPwhWijLEUAMPD97z6Ix+ix/7gVLqazYrfUW/OTN07g0FKsmbRa8KyEDDJSaRaSpb3o3iK08Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip3t1762730819tde5730c0
X-QQ-Originating-IP: /NgVUa1Hm4yKathG8PIGfyt70MVAaoYNOhhfCI6iCDE=
Received: from [IPV6:240f:10b:7440:1:64e0:6ba: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 10 Nov 2025 07:26:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12146803779019856956
Message-ID: <F8B2B6FA2884D69A+b7da13f2-0ffb-4308-b1ba-0549bc461be8@radxa.com>
Date: Mon, 10 Nov 2025 08:26:56 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: FUKAUMI Naoki <naoki@radxa.com>
Subject: [RESEND] Re: [PATCH] PCI: dw-rockchip: Skip waiting for link up
To: Niklas Cassel <cassel@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Damien Le Moal
 <dlemoal@kernel.org>, Anand Moon <linux.amoon@gmail.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Dragan Simic <dsimic@manjaro.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 mani@kernel.org
References: <20250113-rockchip-no-wait-v1-1-25417f37b92f@kernel.org>
 <1E8E4DB773970CB5+5a52c9e1-01b8-4872-99b7-021099f04031@radxa.com>
 <6e87b611-13ea-4d89-8dbf-85510dd86fa6@rock-chips.com>
 <aQ840q5BxNS1eIai@ryzen> <aQ9FWEuW47L8YOxC@ryzen>
 <55EB0E5F655F3AFC+136b89fd-98d4-42af-a99d-a0bb05cc93f3@radxa.com>
 <aRCI5kG16_1erMME@ryzen>
Content-Language: en-US
In-Reply-To: <aRCI5kG16_1erMME@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NChuY+V9daHbIcYr8tY7r7zqouRYG8/sElpemvh2s9b5D1MjX83g9Uf1
	17ER4LvNvH8uEfuhqbdKDNhoi4bdUzM81o1FX+/v+Ko50Ws05zW/bb5KIdu79L/+DGHEnv5
	c4kRMMpuCZKATQnEGryieZDtIXY4nvzWpoXpn4L28/v+UYHm66wcejwm+hjn2Qw20vjNsgs
	SNQiyIOMYoleqlhdZasIbP8UbVSz//vLNUrOdxZ6hHeDe0SdHtaa1KqpeeSbvBCh2w5fn6b
	luhCeEVmIp6LeT1d6IXwDcJ2u6uwUIMFAwvxCND1Toas8ZrLr3gJbYvF2jowndIjKftLcNV
	j9PF2sjOfSuRnurGI18gSPOjhs6oBlN2LTUH6TDtW41/jhu+JBXkr8MjWllWjjp4ZbTYVpP
	ChN64WaLo/ezWV7UAW+r4V/XY+P2J/lX8grj9zrJQDn7ok+Npfqvzx9U24jCzk5Qil4wvfU
	jzcdkCIhU4pDgOB1y0bKzdUOBpxxPg9bNoYbZAgNgFH0Wyujb/szExW54ZR2Z/e7EhzNVV/
	kTarvFbhtfNustB3pUboTNcgbonfIwIvFgpJ7XEfU91LFECeGVMA8SIJwOLK4Y1i0y7/ybf
	G5+rD+TPwok3hwMo9uPTE95BSYaaUw7VhYKUySgRjVCdcxpwutgrzBB/zkrW2Ev41m6r2wD
	WBMoMEGLGXUe3xFPWGRdOWPM3MYbZahddctktC2ycHp6CzsxeghRFr3Kz7zfYsTbS+StgoM
	Cs5l8/X5O0Kldmzom0lEzJx2t9M+wGbQ2m4iBugM5k+Q+ugNoTUDJZcz9yj4X+mwf5a8Z7N
	qAcIyyRYSnwE9H8xEUkCPzuTAO7GzdCJFXcGU7orNWXRaFbYP4FNI4aN6oKLzNmYGBFimUq
	DkMPUoFFnMLcdzLkUxdSK3HcpRfjWCOyotkqDe4/FaArbr12Rnbq1mHwNx8VLWttnB9ra/m
	fcuRR+6A3VcPb5mSgfw51CYoCjTA3o9e17//GcHSxFuUW+IdZLSN4VBPjxtUEVQrpq0F6aZ
	6JBKL23JEWOhHdi0nU/aqPwr312MESJ1o9/QG2UI7dg8lfM3I9
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

(RESEND: fix mani's email address)

Hi Niklas,

On 11/9/25 21:28, Niklas Cassel wrote:
> On Sun, Nov 09, 2025 at 01:42:23PM +0900, FUKAUMI Naoki wrote:
>> Hi Niklas,
>>
>> On 11/8/25 22:27, Niklas Cassel wrote:
>> (snip)> (And btw. please test with the latest 6.18-rc, as, from experience,
>> the
>>> ASPM problems in earlier RCs can result in some weird problems that are
>>> not immediately deduced to be caused by the ASPM enablement.)
>>
>> Here is dmesg from v6.18-rc4:
>>   https://gist.github.com/RadxaNaoki/40e1d049bff4f1d2d4773a5ba0ed9dff
> 
> Same problem as before:
> [    1.732538] pci_bus 0004:43: busn_res: can not insert [bus 43-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> [    1.732645] pci_bus 0004:43: busn_res: [bus 43-41] end is updated to 43
> [    1.732651] pci_bus 0004:43: busn_res: can not insert [bus 43] under [bus 42-41] (conflicts with (null) [bus 42-41])
> [    1.732661] pci 0004:42:00.0: devices behind bridge are unusable because [bus 43] cannot be assigned for them
> [    1.732840] pci_bus 0004:44: busn_res: can not insert [bus 44-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> [    1.732947] pci_bus 0004:44: busn_res: [bus 44-41] end is updated to 44
> [    1.732952] pci_bus 0004:44: busn_res: can not insert [bus 44] under [bus 42-41] (conflicts with (null) [bus 42-41])
> [    1.732962] pci 0004:42:02.0: devices behind bridge are unusable because [bus 44] cannot be assigned for them
> [    1.733134] pci_bus 0004:45: busn_res: can not insert [bus 45-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> [    1.733246] pci_bus 0004:45: busn_res: [bus 45-41] end is updated to 45
> [    1.733255] pci_bus 0004:45: busn_res: can not insert [bus 45] under [bus 42-41] (conflicts with (null) [bus 42-41])
> [    1.733266] pci 0004:42:06.0: devices behind bridge are unusable because [bus 45] cannot be assigned for them
> [    1.733438] pci_bus 0004:46: busn_res: can not insert [bus 46-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> [    1.733544] pci_bus 0004:46: busn_res: [bus 46-41] end is updated to 46
> [    1.733550] pci_bus 0004:46: busn_res: can not insert [bus 46] under [bus 42-41] (conflicts with (null) [bus 42-41])
> [    1.733560] pci 0004:42:0e.0: devices behind bridge are unusable because [bus 46] cannot be assigned for them
> [    1.733571] pci_bus 0004:42: busn_res: [bus 42-41] end is updated to 46
> [    1.733575] pci_bus 0004:42: busn_res: can not insert [bus 42-46] under [bus 41] (conflicts with (null) [bus 41])
> [    1.733585] pci 0004:41:00.0: devices behind bridge are unusable because [bus 42-46] cannot be assigned for them
> [    1.733596] pcieport 0004:40:00.0: bridge has subordinate 41 but max busn 46
> 
> 
> Seems like the ASM2806 switch, for some reason, is not ready.
> 
> One change that Diederik pointed out is that in the "good" case,
> the link is always in Gen1 speed.
> 
> Perhaps you could build with CONFIG_PCI_QUIRKS=y and try this patch:
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 214ed060ca1b..ac134d95a97f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -96,6 +96,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>   {
>   	static const struct pci_device_id ids[] = {
>   		{ PCI_VDEVICE(ASMEDIA, 0x2824) }, /* ASMedia ASM2824 */
> +		{ PCI_VDEVICE(ASMEDIA, 0x2806) }, /* ASMedia ASM2806 */
>   		{}
>   	};
>   	u16 lnksta, lnkctl2;

It doesn't help with either probing behind the bridge or the link speed.

> If that does not work, perhaps you could try this patch
> (assuming that all Rock 5C:s have a ASM2806 on pcie2x1l2):

ROCK 5C has a PCIe FPC connector and I'm using Dual 2.5G Router HAT.
  https://radxa.com/products/rock5/5c#techspec
  https://radxa.com/products/accessories/dual-2-5g-router-hat

Regarding the link speed, I initially suspected the FPC connector and/or 
cable might be the issue. However, I tried the Dual 2.5G Router HAT with 
the ROCK 5A (which uses a different cable), and I got the same result.

BTW, the link speed varies between 2Gb/s and 4Gb/s depending on the 
reboot. (with or without quirk)

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts
> index dd7317bab613..26f8539d934a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts
> @@ -452,6 +452,7 @@ &pcie2x1l2 {
>   	pinctrl-0 = <&pcie20x1_2_perstn_m0>;
>   	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
>   	vpcie3v3-supply = <&pcie2x1l2_3v3>;
> +	max-link-speed = <1>;
>   	status = "okay";
>   };
> 
> 
> 
> Kind regards,
> Niklas
> 


