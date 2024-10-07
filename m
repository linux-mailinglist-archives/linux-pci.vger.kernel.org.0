Return-Path: <linux-pci+bounces-13936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3500992531
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 08:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D067281A3A
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638F515B130;
	Mon,  7 Oct 2024 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGc8wvZk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A57B1531CC;
	Mon,  7 Oct 2024 06:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728284313; cv=none; b=jpCFTFmcn92lmLwaQwGOAASl1k6SBr4IZEKA66ae9V2BD0HUBdx4Rnf15xfvxalaq8Cryr+K0zLLLaXwEx8XqGlMy27VnkalkHuiOMtNa4O7QeyrDzl4+4JEpreZXwirJoZvNgFhZSuq99PEIaYxeeU4agGyFYbfokDfn/vdoAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728284313; c=relaxed/simple;
	bh=NH3P73rjlFT8QcjybEaXWlE7Olev3U86b+yiuYZctFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXY+NUGGIDuypyXsr+KlddAKWW5ups/eTLu8hk3BfReioYc77GqChkZj4W5MyLnL2BwbvmqbL8KFefdK2m7M9RI5Mjeqat1wEfFhLlsOuR8K9KswfIoffCA8Z7X6oQfQ7vxrw1m8EaPVj5opk+BL1JYX6e48LgPn4QdQfANEH8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGc8wvZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F94C4CEC6;
	Mon,  7 Oct 2024 06:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728284312;
	bh=NH3P73rjlFT8QcjybEaXWlE7Olev3U86b+yiuYZctFE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CGc8wvZkwdBBic/nMnCro8IFmP8y3Ys3xGkfBlj3FfTr8gp9mI3klDSsD00z7toYw
	 zxyd9VknaL9p8bc1+Y8NCorWRGfXujh09PsA6Pa0tuGixa9+gSqsJ4llT/HGAA3ySu
	 9YQoMcd6/umgr36zS75qFlinfbFuIUiXyLsjLmgYXqVnMe2wOEKaZN9cBXOyaiE/vo
	 dxz9EDk7LwgF9isKQW2u3z4F/eKSvclx9ImagKPBuQmOdS0UaEKQ0knfn/bzEbZMVy
	 2vj/cxsDVTLB/qQAdT0rYiC4BLPN9IjMZVqSwfELAARz6hxLmwuCJfHOzpO6udXdc/
	 9QyVs/DgBhcIg==
Message-ID: <ec728ac4-ef63-47a2-9058-5c038003418e@kernel.org>
Date: Mon, 7 Oct 2024 15:58:29 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] dt-bindings: pci: rockchip,rk3399-pcie-ep: Add
 ep-gpios property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, Niklas Cassel <cassel@kernel.org>
References: <20241007041218.157516-1-dlemoal@kernel.org>
 <20241007041218.157516-12-dlemoal@kernel.org>
 <o42ki5dwipmldcpnthpfoaltpmu7ffheq627ersrvjj73xkm6x@vkqjomiznstg>
 <179ed297-1d06-480d-8095-7212cbde2ab1@kernel.org>
 <64421c0c-1d48-421d-8841-859695b5046d@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <64421c0c-1d48-421d-8841-859695b5046d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 15:54, Krzysztof Kozlowski wrote:
> On 07/10/2024 08:50, Damien Le Moal wrote:
>> On 10/7/24 15:12, Krzysztof Kozlowski wrote:
>>> On Mon, Oct 07, 2024 at 01:12:17PM +0900, Damien Le Moal wrote:
>>>> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>>>>
>>>> Describe the `ep-gpios` property which is used to map the PERST# input
>>>> signal for endpoint mode.
>>>
>>> Why "ep" for PERST signal? Looks totally unrelated name. There is
>>> already reset-gpios exactly for PERST, so you are duplicating it. Why?
>>
>> Because the host side controller already has the same "ep-gpios" property.
>>
>> Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
> 
> If host has it, then it is a common property so goes to common schema
> for these devices.

Ah. OK. I will move it to
Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-common.yaml then.

>> So naming that property the same allows common code to initialize that gpio in
>> rockchip_pcie_parse_dt().
>>
>> Also, I do not see reset-gpios being defined/used by this driver (host and ep
>> sides).
> 
> I am talking about bindings, not driver.

I do not see reset-gpios being defined in the bindings (common, host and ep).
resets and reset-names are defined though but these have nothing to do with
#PERST control.

-- 
Damien Le Moal
Western Digital Research

