Return-Path: <linux-pci+bounces-40326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FA6C34B63
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 10:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614811882DC6
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 09:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572B91922F5;
	Wed,  5 Nov 2025 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="TtlfyECi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3294.qiye.163.com (mail-m3294.qiye.163.com [220.197.32.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F42E2F7AB4;
	Wed,  5 Nov 2025 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333930; cv=none; b=eAVjKfwvVwaPFWHZ9bETL3rvUfPBCYKhFEgu6uTJ7SohEjhnXrVN8++wcuDyDw5J0HOuTA9wUnsmK791MpHf+BnKp5TlaLaopOkE+WXGVcpTLs35TwAMhGouIQYQ3UW3awiNjpjNFQZc9kaX124VdzHZmScqzenaoC5+9LCEY/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333930; c=relaxed/simple;
	bh=0i+uoQvcddlDfWvyR5yGQnnkzSaSeW45XPci/cVl/vA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j1V7US0DpDcvHqbUvItxNbJguzrth4fQWE3eXxiCIzhBNWzlv0YJ2gDn+/fuNAK1WDqGCSSFSz8g/1y3+xHPE1LsgmJwCKfLGpzE7NsuEQwAzs1VvzWj9wqaPG+NYINw1orJKR5WcmzBVPgCXNbYJk/yBU7limSzPoIjYlUscTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=TtlfyECi; arc=none smtp.client-ip=220.197.32.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2879b25b7;
	Wed, 5 Nov 2025 16:56:37 +0800 (GMT+08:00)
Message-ID: <67b605b0-7046-448a-bc9b-d3ac56333809@rock-chips.com>
Date: Wed, 5 Nov 2025 16:56:36 +0800
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
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: align bindings to PCIe spec
To: Geraldo Nascimento <geraldogabriel@gmail.com>
References: <4b5ffcccfef2a61838aa563521672a171acb27b2.1762321976.git.geraldogabriel@gmail.com>
 <ba120577-42da-424d-8102-9d085c1494c8@rock-chips.com>
 <aQsIXcQzeYop6a0B@geday>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aQsIXcQzeYop6a0B@geday>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a533b783109cckunmc8d35d74ceaecc
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx9ITVYeTElJGBkZTklCTB5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=TtlfyECiKclZk4FcAtw4aOhBtS/6otJUxxK+rAlXHPyEBcTD1Hd+1B6FhZ5RcW1dRr8TZ7OS/MXNgEhhSBtlHTYmY7dJpqJ/fBNYu1jEWRl5T8x236EefqlPHoh1GsqivMeI8Y4gCRslOhyb2IGJqfYP5GIf3hccAsYL8uh4Yjg=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=CS//WAipPfjSfjlGPO7nyoViLe54hOkmqQ/3rPaesvk=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/05 星期三 16:18, Geraldo Nascimento 写道:
> On Wed, Nov 05, 2025 at 02:35:28PM +0800, Shawn Lin wrote:
>> Hi Geraldo,
>>
>> 在 2025/11/05 星期三 13:55, Geraldo Nascimento 写道:
>>> The PERST# side-band signal is defined by PCIe spec as an open-drain
>>
>> I couldn't find any clue that says PERST# is an open-drain signal. Could
>> you quote it from PCI Express Card Electromechanical Specification?
>>
>>> active-low signal that depends on a pull-up resistor to keep the
>>> signal high when deasserted. Align bindings to the spec.
>>
>> This is not true from my POV. An open-drain PCIe side-band  signal
>> is used for both of EP and RC to achieve some special work-flow, like
>> CLKREQ# for L1ss, etc. Since both ends could control it. But PERST# is a
>> fundamental reset signal driven by RC which should be in sure state,
>> high or low, has nothing to do with open-drain.
>>
>>>
>>> Note that the relevant driver hacks the active-low signal as
>>> active-high and switches the normal polarity of PERST#
>>> assertion/deassertion, 1 and 0 in that order, and instead uses
>>> 0 to signal low (assertion) and 1 to signal deassertion.
>>>
>>> Incidentally, this change makes hardware that refused to work
>>> with the Rockchip-IP PCIe core working for me, which was the
>>> object of many fool's errands.
>>>
>>> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
>>> ---
>>>    arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi | 8 ++++++--
>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
>>> index aa70776e898a..8dcb03708145 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
>>> @@ -383,9 +383,9 @@ &pcie_phy {
>>>    };
>>>    
>>>    &pcie0 {
>>> -	ep-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
>>> +	ep-gpios = <&gpio0 RK_PB4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>>
>> So my biggest guess is we don't need this change at all.
>> gpio0b4 is used as gpio function, the problem you faced is that it
>> didn't set gpio0b4 as pull-up, because the defaut state is pull-down.
>>
>> Maybe the drive current of this IO is too weak, making it unable to
>> fully drive high in the pull-down state? If that's the case, can you see
>> a half-level signal on the oscilloscope?
>>
>>>    	num-lanes = <4>;
>>> -	pinctrl-0 = <&pcie_clkreqnb_cpm>;
>>> +	pinctrl-0 = <&pcie_clkreqnb_cpm>, <&pcie_perst>;
>>>    	pinctrl-names = "default";
>>>    	vpcie0v9-supply = <&vcca_0v9>;	/* VCC_0V9_S0 */
>>>    	vpcie1v8-supply = <&vcca_1v8>;	/* VCC_1V8_S0 */
>>> @@ -408,6 +408,10 @@ pcie {
>>>    		pcie_pwr: pcie-pwr {
>>>    			rockchip,pins = <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
>>>    		};
>>> +		pcie_perst: pcie-perst {
>>> +			rockchip,pins = <0 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
>>> +		};
>>> +
>>>    	};
>>>    
>>>    	pmic {
>>
> 
> Hi Shawn, glad to hear from you.
> 
> Perhaps the following change is better? It resolves the issue
> without the added complication of open drain. After you questioned
> if open drain is actually part of the spec, I remembered that
> GPIO_OPEN_DRAIN is actually (GPIO_SINGLE_ENDED | GPIO_LINE_OPEN_DRAIN)
> so I decided to test with just GPIO_SINGLE_ENDED and it works.


Does that work for you too?

&pcie0 {
	ep-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
  	num-lanes = <4>;
-	pinctrl-0 = <&pcie_clkreqnb_cpm>;
+	pinctrl-0 = <&pcie_clkreqnb_cpm>, <&pcie_perst>;
  	pinctrl-names = "default";
  	vpcie0v9-supply = <&vcca_0v9>;	/* VCC_0V9_S0 */
  	vpcie1v8-supply = <&vcca_1v8>;	/* VCC_1V8_S0 */
@@ -408,6 +408,10 @@ pcie {
  		pcie_pwr: pcie-pwr {
  			rockchip,pins = <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
  		};
+		pcie_perst: pcie-perst {
+			rockchip,pins = <0 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
  	};

> 
> Thanks,
> Geraldo Nascimento
> 
> ---
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> index aa70776e898a..b3d19dce539f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> @@ -383,7 +383,7 @@ &pcie_phy {
>   };
>   
>   &pcie0 {
> -	ep-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
> +	ep-gpios = <&gpio0 RK_PB4 (GPIO_ACTIVE_HIGH | GPIO_SINGLE_ENDED)>;
>   	num-lanes = <4>;
>   	pinctrl-0 = <&pcie_clkreqnb_cpm>;
>   	pinctrl-names = "default";
> 


