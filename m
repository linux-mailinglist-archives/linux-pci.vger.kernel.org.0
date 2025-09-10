Return-Path: <linux-pci+bounces-35859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68939B52377
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 23:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18021467226
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 21:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC8A30FF28;
	Wed, 10 Sep 2025 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="CYbGwQML"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F322624C068
	for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2025 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757539763; cv=none; b=MuVOP0Gfv4fmZMuiFeAMaycK/o4umwsgmHP6S5ezULeCdGTlKMVAIKUun1l0R+9r3WugZLqqcEy/TQb0OiFoYKcq6Gv1kTkZFlWPBoKdyMH5efffSucE/FeASFPo9GGXAHTdobwQ7T8bFta0zDvTSqoHBy/UB9N+iCl7H6tMSiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757539763; c=relaxed/simple;
	bh=aCgUYgywrm/2h1KX190TpAXxadjFS7iwP5A6Tamnbcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/MOcyllYv64Dbt1anF7bcE41/U0koKFMBvnwa2wV8yn6cdd2oWSVuyOvoRvi35i2BOH5rSxDsuRmzbVN583UP3X879eNfHXjhyGP33xGcWbhEcbYutx4JE6qUaVr4mDw4wnIeyO/vB0FGSKZzcRtQ35F2Wo1F5Mb97wV/gl20A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=CYbGwQML; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1757539755;
 bh=Z1MeHN/FAuAOkxz9iJEKMCLiQPrMJjTHwVbwSN9mvp8=;
 b=CYbGwQMLTFunSmaFklc2ZRemAoFT5+vyEMyJ9zhM0U1np/MVRgis6FEqG+zEyR1BkffozC41M
 J66h7cmCVzR0E9/1gVGxH5f7zLEzEYm28RVG21O1WBUfi5qE7LJfgTg28rNbLtsc1grgzVBwVWF
 QfGxYqCnZ4hPYOiTmlHXdHoPT+mrsICQSU2fKie3tjFwkDIk7ewfkkNeLeif6N61lSubK7qVIRa
 cvahGADbXqe65TwllzKynoStcmupkIHATU0AD7ShRPoZRNZDcuaZGeNJXaZorCBUO1bTMVc80Vt
 qsyhIc77L2QvphVXP8CgziSMm31YcFbDit7NLgiEyFBw==
X-Forward-Email-ID: 68c1eda3343e597491a9aa4c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.2.14
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <38e80b6d-1dc9-47a8-8b23-e875c2848e6e@kwiboo.se>
Date: Wed, 10 Sep 2025 23:29:00 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Add PCIe Gen2x1 controller for
 RK3528
To: Yao Zi <ziyao@disroot.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Shawn Lin <shawn.lin@rock-chips.com>, Simon Xue <xxm@rock-chips.com>,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Chukun Pan <amadeus@jmu.edu.cn>
References: <20250906135246.19398-1-ziyao@disroot.org>
 <20250906135246.19398-3-ziyao@disroot.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250906135246.19398-3-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yao Zi,

On 9/6/2025 3:52 PM, Yao Zi wrote:
> Describes the PCIe Gen2x1 controller integrated in RK3528 SoC. The SoC
> doesn't provide a separate MSI controller, thus the one integrated in
> designware PCIe IP must be used.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 56 +++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> index db5dbcac7756..2d2af467e5ab 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/pinctrl/rockchip.h>
>  #include <dt-bindings/clock/rockchip,rk3528-cru.h>
>  #include <dt-bindings/power/rockchip,rk3528-power.h>
> @@ -239,7 +240,7 @@ gmac0_clk: clock-gmac50m {
>  
>  	soc {
>  		compatible = "simple-bus";
> -		ranges = <0x0 0xfe000000 0x0 0xfe000000 0x0 0x2000000>;
> +		ranges = <0x0 0xfc000000 0x0 0xfc000000 0x0 0x44400000>;

We should use the dbi reg area in the 32-bit address space, please use:

  ranges = <0x0 0xfc000000 0x0 0xfc000000 0x0 0x4000000>;

>  		#address-cells = <2>;
>  		#size-cells = <2>;
>  
> @@ -1133,6 +1134,59 @@ combphy: phy@ffdc0000 {
>  			rockchip,pipe-phy-grf = <&pipe_phy_grf>;
>  			status = "disabled";
>  		};
> +
> +		pcie: pcie@fe4f0000 {

With the dbi reg area changed below, please update the node name and
move this node to top of the soc node.

  pcie@fe000000

> +			compatible = "rockchip,rk3528-pcie",
> +				     "rockchip,rk3568-pcie";
> +			reg = <0x1 0x40000000 0x0 0x400000>,

We should use the dbi reg area in the 32-bit address space, please use:

  reg = <0x0 0xfe000000 0x0 0x400000>,

> +			      <0x0 0xfe4f0000 0x0 0x10000>,
> +			      <0x0 0xfc000000 0x0 0x100000>;
> +			reg-names = "dbi", "apb", "config";
> +			bus-range = <0x0 0xff>;
> +			clocks = <&cru ACLK_PCIE>, <&cru HCLK_PCIE_SLV>,
> +				 <&cru HCLK_PCIE_DBI>, <&cru PCLK_PCIE>,
> +				 <&cru CLK_PCIE_AUX>, <&cru PCLK_PCIE_PHY>;
> +			clock-names = "aclk_mst", "aclk_slv",
> +				      "aclk_dbi", "pclk",
> +				      "aux", "pipe";

In my U-Boot test I did not have the pipe/phy clock here, do we need it?

With above fixed this more or less matches my U-Boot testing, and is:

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> +			device_type = "pci";
> +			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "sys", "pmc", "msg", "legacy", "err",
> +					  "msi";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0 0 0 1 &pcie_intc 0>,
> +					<0 0 0 2 &pcie_intc 1>,
> +					<0 0 0 3 &pcie_intc 2>,
> +					<0 0 0 4 &pcie_intc 3>;
> +			linux,pci-domain = <0>;
> +			max-link-speed = <2>;
> +			num-lanes = <1>;
> +			phys = <&combphy PHY_TYPE_PCIE>;
> +			phy-names = "pcie-phy";
> +			power-domains = <&power RK3528_PD_VPU>;
> +			ranges = <0x01000000 0x0 0xfc100000 0x0 0xfc100000 0x0 0x100000>,
> +				 <0x02000000 0x0 0xfc200000 0x0 0xfc200000 0x0 0x1e00000>,
> +				 <0x03000000 0x1 0x00000000 0x1 0x00000000 0x0 0x40000000>;
> +			resets = <&cru SRST_PCIE_POWER_UP>, <&cru SRST_P_PCIE>;
> +			reset-names = "pwr", "pipe";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			status = "disabled";
> +
> +			pcie_intc: legacy-interrupt-controller {
> +				interrupt-controller;
> +				interrupt-parent = <&gic>;
> +				interrupts = <GIC_SPI 155 IRQ_TYPE_EDGE_RISING>;
> +				#address-cells = <0>;
> +				#interrupt-cells = <1>;
> +			};
> +		};
>  	};
>  };
>  


