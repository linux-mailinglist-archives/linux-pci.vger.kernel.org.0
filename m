Return-Path: <linux-pci+bounces-35886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4B2B52C08
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 10:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 556BE7A9DD0
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 08:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C89D2E424F;
	Thu, 11 Sep 2025 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="UMVoGXhH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702FA23372C
	for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757580273; cv=none; b=oQKGD9afmdhibXopVLw29Tr3NLLBG8f6njqpjaM3LfEy+kGqgmlxPi30k8I3PJ6xOF8A0PKnjx1+NMEkmhoh8YbeNt8yi1iBDHN3SI7Jq3oCw+62/zwofF5APZXgx1xQbsd1UdYHT82xqRrZjyF57O6awrg0OMjoWHzOuRg3bYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757580273; c=relaxed/simple;
	bh=iD0m5qHzlc7V64bQ971FKQ/OWd0ILTt+45PnPJ40xhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVpyLSxL6RH1iUqla0CHON89oQJSNPSTO7noJ7orTxQ+TLdaTZ5VaPskqbyqEi90o7nuwCyIKhiiRSkeS/fnlBrLYnN04NnHysveeg/xhtUl1b81RhfK5e4fLE8rlzMWS0Y4PJZ5gB28dUk+klij0l7n5kgYqANGKZVIl3yBKU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=UMVoGXhH; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1757580271;
 bh=71L95gSKTmlkjoVh2fs/9dex/A1y0fWYRyHyjXcBq4g=;
 b=UMVoGXhHSXrrjAeHJOS1OP8kk+Tucxxh5xNvANoP1G9VKRPMoUuLRz6ai4sHA7DC7BAcjjE/S
 vgenOi6Nfk3bGZZHPCI7M/dzDjo7SobtNT783saaWogWelrbOdIMdLK1sBN5qdrrV5Iczpscccd
 XL8BGJWV1IVY/4mMEe+gpdGVRzKeRUDdusjREEAQc1omaCLQ/6dcibOlwLyuU6u8Ku86+1/m3qC
 XVaFPhQuYxgxeF2nC1d+NEqknMQzy6x4dKZy0IXOZs/vRA+DN1iVNPjPLa+w3uQVSGS1aDG+1yr
 TExJaCqSo9mraACfA3BpsJ/uhUnOxVH4lPUsYaP8kklw==
X-Forward-Email-ID: 68c28be303561882c9813720
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.2.14
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <59cff81f-4be2-45e7-bc41-60fb52bfc6ca@kwiboo.se>
Date: Thu, 11 Sep 2025 10:44:11 +0200
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
 <38e80b6d-1dc9-47a8-8b23-e875c2848e6e@kwiboo.se> <aMKAvCglcaC6-00k@pie>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <aMKAvCglcaC6-00k@pie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/2025 9:56 AM, Yao Zi wrote:
> On Wed, Sep 10, 2025 at 11:29:00PM +0200, Jonas Karlman wrote:
>> Hi Yao Zi,
>>
>> On 9/6/2025 3:52 PM, Yao Zi wrote:
>>> Describes the PCIe Gen2x1 controller integrated in RK3528 SoC. The SoC
>>> doesn't provide a separate MSI controller, thus the one integrated in
>>> designware PCIe IP must be used.
>>>
>>> Signed-off-by: Yao Zi <ziyao@disroot.org>
>>> ---
>>>  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 56 +++++++++++++++++++++++-
>>>  1 file changed, 55 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>>> index db5dbcac7756..2d2af467e5ab 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>>> @@ -7,6 +7,7 @@
>>>  #include <dt-bindings/gpio/gpio.h>
>>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>  #include <dt-bindings/interrupt-controller/irq.h>
>>> +#include <dt-bindings/phy/phy.h>
>>>  #include <dt-bindings/pinctrl/rockchip.h>
>>>  #include <dt-bindings/clock/rockchip,rk3528-cru.h>
>>>  #include <dt-bindings/power/rockchip,rk3528-power.h>
>>> @@ -239,7 +240,7 @@ gmac0_clk: clock-gmac50m {
>>>  
>>>  	soc {
>>>  		compatible = "simple-bus";
>>> -		ranges = <0x0 0xfe000000 0x0 0xfe000000 0x0 0x2000000>;
>>> +		ranges = <0x0 0xfc000000 0x0 0xfc000000 0x0 0x44400000>;
>>
>> We should use the dbi reg area in the 32-bit address space, please use:
>>
>>   ranges = <0x0 0xfc000000 0x0 0xfc000000 0x0 0x4000000>;
> 
> This seems strange to me. I read through TRMs for RK3562 and RK3576, and
> found it's common for Rockchip SoCs to map DBI regions of PCIe
> controllers to two separate MMIO regions, but am still not sure why it's
> necessary to use the mapping in the 32-bit address space.

I prefer the use of the 32-bit address range to ensure better
compatibility with bootloaders and possible other OS that may have
issues with regs in 64-bit address range.

E.g. U-Boot have had issues with accessing >32-bit addressable range in
the past, use of the 32-bit dbi range ensure we can use pcie in
U-Boot without having to possible patch DT in a <soc>-u-boot.dtsi file.

Regards,
Jonas

> 
> However, I'm willing to follow the vendor's decision here in order to
> avoid unexpected problems. Will adapt this in v2.
> 
>>>  		#address-cells = <2>;
>>>  		#size-cells = <2>;
>>>  
>>> @@ -1133,6 +1134,59 @@ combphy: phy@ffdc0000 {
>>>  			rockchip,pipe-phy-grf = <&pipe_phy_grf>;
>>>  			status = "disabled";
>>>  		};
>>> +
>>> +		pcie: pcie@fe4f0000 {
>>
>> With the dbi reg area changed below, please update the node name and
>> move this node to top of the soc node.
>>
>>   pcie@fe000000
>>
>>> +			compatible = "rockchip,rk3528-pcie",
>>> +				     "rockchip,rk3568-pcie";
>>> +			reg = <0x1 0x40000000 0x0 0x400000>,
>>
>> We should use the dbi reg area in the 32-bit address space, please use:
>>
>>   reg = <0x0 0xfe000000 0x0 0x400000>,
>>
>>> +			      <0x0 0xfe4f0000 0x0 0x10000>,
>>> +			      <0x0 0xfc000000 0x0 0x100000>;
>>> +			reg-names = "dbi", "apb", "config";
>>> +			bus-range = <0x0 0xff>;
>>> +			clocks = <&cru ACLK_PCIE>, <&cru HCLK_PCIE_SLV>,
>>> +				 <&cru HCLK_PCIE_DBI>, <&cru PCLK_PCIE>,
>>> +				 <&cru CLK_PCIE_AUX>, <&cru PCLK_PCIE_PHY>;
>>> +			clock-names = "aclk_mst", "aclk_slv",
>>> +				      "aclk_dbi", "pclk",
>>> +				      "aux", "pipe";
>>
>> In my U-Boot test I did not have the pipe/phy clock here, do we need it?
> 
> Just as mentioned by Chukun, the clock should indeed be managed by phy
> instead of the PCIe controller. Will fix it as well.
> 
>> With above fixed this more or less matches my U-Boot testing, and is:
>>
>> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
> 
> Much thanks.
> 
>> Regards,
>> Jonas
> 
> Best regards,
> Yao Zi


