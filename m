Return-Path: <linux-pci+bounces-40315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0065FC34100
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 07:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A537E4E4782
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 06:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCBE26A1AF;
	Wed,  5 Nov 2025 06:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="OMV8z0tr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49219.qiye.163.com (mail-m49219.qiye.163.com [45.254.49.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D1927462;
	Wed,  5 Nov 2025 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762324541; cv=none; b=fxmbxHQvc86ihZ8pRxcA69zdSmyr97bZ8MnBGiouRz2AHGVqNZIZ5EAEriXzlIHGH9wVWZoxjAWm1AIFyz88O1IaNHjEacB/j1wEU3GCaLuGUv8wghuDIAFi+vsV7VF9LubRTxB4VHWpQYqIx3Mu48SrA60+s06IUeCRBY/FaZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762324541; c=relaxed/simple;
	bh=+WSDh17Zv85nz4BHwvp/umpSXDxSRKSSoXtXj2T9uyA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QbmRl5xwcCizEHnauOaUjIwX74xms5f1nmWfXS8YnJMwPkBj8MyoACDfXZlCVdVEAdUrl/+pCftME4gaAUb/qSq5Y5h/jfzQd4YKhVxuSZLDzgTImnGZ0ATZN5rbYqERRZXTOHOkEpgsFABGSOhslD1DCAb/ckSfDCziTaMf5k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=OMV8z0tr; arc=none smtp.client-ip=45.254.49.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 28738ad08;
	Wed, 5 Nov 2025 14:35:29 +0800 (GMT+08:00)
Message-ID: <ba120577-42da-424d-8102-9d085c1494c8@rock-chips.com>
Date: Wed, 5 Nov 2025 14:35:28 +0800
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
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <4b5ffcccfef2a61838aa563521672a171acb27b2.1762321976.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a52ba413509cckunmc2aaee18cb0988
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk9CSVYaTENLQx8YT0gYQ0xWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=OMV8z0tr5MTsd4IVw0FOfwUChjbcdL35pQsXtIjZ5ru+eWExEIhbd2fGG14g2NLimccEK4Hdkh+ROPo2UcnU+xSjp2L831Arzc99lmfLqETzC8isZ2mtWUL5kNS1US4NePVDmO5r/aLHP/3MJvGfiVOVyH3VN1uh0hc5r0MUSAE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=w3jBEw7Jy/T28wSQc6c2W5ztuhx1BYHAtBcKXgni9Oc=;
	h=date:mime-version:subject:message-id:from;

Hi Geraldo,

在 2025/11/05 星期三 13:55, Geraldo Nascimento 写道:
> The PERST# side-band signal is defined by PCIe spec as an open-drain

I couldn't find any clue that says PERST# is an open-drain signal. Could
you quote it from PCI Express Card Electromechanical Specification?

> active-low signal that depends on a pull-up resistor to keep the
> signal high when deasserted. Align bindings to the spec.

This is not true from my POV. An open-drain PCIe side-band  signal
is used for both of EP and RC to achieve some special work-flow, like
CLKREQ# for L1ss, etc. Since both ends could control it. But PERST# is a
fundamental reset signal driven by RC which should be in sure state,
high or low, has nothing to do with open-drain.

> 
> Note that the relevant driver hacks the active-low signal as
> active-high and switches the normal polarity of PERST#
> assertion/deassertion, 1 and 0 in that order, and instead uses
> 0 to signal low (assertion) and 1 to signal deassertion.
> 
> Incidentally, this change makes hardware that refused to work
> with the Rockchip-IP PCIe core working for me, which was the
> object of many fool's errands.
> 
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> index aa70776e898a..8dcb03708145 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> @@ -383,9 +383,9 @@ &pcie_phy {
>   };
>   
>   &pcie0 {
> -	ep-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
> +	ep-gpios = <&gpio0 RK_PB4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;

So my biggest guess is we don't need this change at all.
gpio0b4 is used as gpio function, the problem you faced is that it
didn't set gpio0b4 as pull-up, because the defaut state is pull-down.

Maybe the drive current of this IO is too weak, making it unable to 
fully drive high in the pull-down state? If that's the case, can you see 
a half-level signal on the oscilloscope?

>   	num-lanes = <4>;
> -	pinctrl-0 = <&pcie_clkreqnb_cpm>;
> +	pinctrl-0 = <&pcie_clkreqnb_cpm>, <&pcie_perst>;
>   	pinctrl-names = "default";
>   	vpcie0v9-supply = <&vcca_0v9>;	/* VCC_0V9_S0 */
>   	vpcie1v8-supply = <&vcca_1v8>;	/* VCC_1V8_S0 */
> @@ -408,6 +408,10 @@ pcie {
>   		pcie_pwr: pcie-pwr {
>   			rockchip,pins = <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
>   		};
> +		pcie_perst: pcie-perst {
> +			rockchip,pins = <0 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
>   	};
>   
>   	pmic {


