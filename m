Return-Path: <linux-pci+bounces-13934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63125992516
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 08:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17EC31F21203
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D9B158861;
	Mon,  7 Oct 2024 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bh1Gj+08"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C990800;
	Mon,  7 Oct 2024 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728283846; cv=none; b=hqLB2utZR4rw48BnaFDFWryS9piux8WrhHi2zOMtcVhlLsBomrSWJQmPqO+ndFWLtuP7oEa/R8XiD1LR+siVCUTGj08MzhEaYK1hxKHkebT3CBCJXDkxXhqSB03RBvq7dJ46KItwAT0//4pH/pX2pF7sEG1u27DBNOe/UW+Qu/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728283846; c=relaxed/simple;
	bh=qDAe+BSsiioIiqPoJ/5NRfo8zrnpHg4n7A+8Ga+ENNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PzeIXY2ZX6tC11YSeqgVwtYTR0a+NQ3FFtG2BDhUWlE/cUG5eKnWKGfM0+2uL+YTNyj/Fi6BB+72MVymCPML2XZofV1IHclhbinaXLfKQHYkYoU8If2uIho0gAhVZEbXL1P54p3nAnhQjDXce6a3Jc9EbNb5/0q1at7Ytox27bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bh1Gj+08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF8AC4CEC6;
	Mon,  7 Oct 2024 06:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728283846;
	bh=qDAe+BSsiioIiqPoJ/5NRfo8zrnpHg4n7A+8Ga+ENNM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bh1Gj+08iRC+C3z5nBaRa5b/Ksjm3Br88Fy+L/QInt5azyQa5B35WqUJRql5KqhZf
	 tSP1XYcW/6TNTwJo7hwQ9BbdzMzx9y2/WaE/howuOgJQ6V0PsDM4g3t1qhOr1xh0RD
	 1DlL9ZQTf9UL34mILyj+kU3HVqZQOAibDEGqEIlSCnx0Ul+j2SDblkIeMneswpb5DI
	 wOrX3Xi6R8sVtxmuD4KFcxpUn0KEkowlHnu1f+BGhRI7r26/LI5D8z+rL7m3PORa+T
	 +gophihNGK3kch2Je6TCR9Fr7Y0q6QZoAlpQezft7R74Fmp3D47n2gZ5XNdDLw5Zx8
	 ZCtXwhJVTjkNg==
Message-ID: <179ed297-1d06-480d-8095-7212cbde2ab1@kernel.org>
Date: Mon, 7 Oct 2024 15:50:43 +0900
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
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <o42ki5dwipmldcpnthpfoaltpmu7ffheq627ersrvjj73xkm6x@vkqjomiznstg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 15:12, Krzysztof Kozlowski wrote:
> On Mon, Oct 07, 2024 at 01:12:17PM +0900, Damien Le Moal wrote:
>> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>>
>> Describe the `ep-gpios` property which is used to map the PERST# input
>> signal for endpoint mode.
> 
> Why "ep" for PERST signal? Looks totally unrelated name. There is
> already reset-gpios exactly for PERST, so you are duplicating it. Why?

Because the host side controller already has the same "ep-gpios" property.

Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml

So naming that property the same allows common code to initialize that gpio in
rockchip_pcie_parse_dt().

Also, I do not see reset-gpios being defined/used by this driver (host and ep
sides).

-- 
Damien Le Moal
Western Digital Research

