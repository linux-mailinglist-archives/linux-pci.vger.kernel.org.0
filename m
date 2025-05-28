Return-Path: <linux-pci+bounces-28497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C64DAC62DA
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 09:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBB816B128
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 07:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA99243969;
	Wed, 28 May 2025 07:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEaHx6s/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41291367;
	Wed, 28 May 2025 07:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748416893; cv=none; b=hwE1FpcnQRzLugnTe75mCq6FcipfsDBZzPZUDQvTPpoYyvH4udyPH2fpMFSlMCjITCJaCIYogJ34A03JvH+XwnsKgo5NgE3Ttbs620mklWSQOXedURY7f4YJGxRSYtmIhe4EX0X81uyT4UDFrtg4eZAB/6JCqYadITpXy108mw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748416893; c=relaxed/simple;
	bh=SkRP/MS8cvO2FVA3kFfTyM8+otz9fEhJJqVQBSgvjeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdfutxzS26ywlBiI1RIBPNHCqKZl/kP9K/GkNpix0wxnK6gJWIVUEIdAv9COSdiI2UWEkayl1aei9QHJzACjJgC5JpJfB2LAPJj2p92KpK8NyNDPkZGNFyhrqaBNg9ty9ZXsU62rBxaiA0SFyRJHGtEpt78v61THExsRksDdrKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEaHx6s/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2716FC4CEE7;
	Wed, 28 May 2025 07:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748416893;
	bh=SkRP/MS8cvO2FVA3kFfTyM8+otz9fEhJJqVQBSgvjeY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eEaHx6s/f96D84HDtDZITR8TwrnXkMxwpSnlxiLsDEo8zSv1CR2wePfzDROHKmm7V
	 Ep6fohXmQIa79YjWIDuSqy+5rLhjKE2SScaDusjuMJZGE2iLoKt/k/KvW9nO6r9oGX
	 Gbh8mwEDFQm7EQqXjgJYOlzj9lyNtRkmBjXc9e3Dzftyz6xl4rnJbY9NlVvM/I+ine
	 yXnu3PlLu69naPHBhHw+veayI/cVDoFMHtUts6bsWTMnJIR0MUGY1OWxcJd7B8DZSb
	 /0XjJyv33d6rnMWoFwJ8P7R6JTrDpGS4oaVOONUFsOvWpRDvNelLvmD2IxM+rgiyJk
	 Fgrb2DSraMv2g==
Message-ID: <a42f7c93-4c26-489e-a680-ad20a8b8a0a6@kernel.org>
Date: Wed, 28 May 2025 09:21:27 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] phy: exynos: Add PCIe PHY support for FSD SoC
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.or,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
 vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
 m.szyprowski@samsung.com, jh80.chung@samsung.com
References: <20250518193152.63476-1-shradha.t@samsung.com>
 <CGME20250518193256epcas5p442e9549fd8fd810522f960df74c22e34@epcas5p4.samsung.com>
 <20250518193152.63476-9-shradha.t@samsung.com>
 <20250521-certain-quoll-from-vega-11885b@kuoka>
 <0e2701dbcef4$6f5f24d0$4e1d6e70$@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <0e2701dbcef4$6f5f24d0$4e1d6e70$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/05/2025 12:45, Shradha Todi wrote:
>>>
>>> -	generic_phy = devm_phy_create(dev, dev->of_node, &exynos5433_phy_ops);
>>> +	generic_phy = devm_phy_create(dev, dev->of_node, drv_data->phy_ops);
>>>  	if (IS_ERR(generic_phy)) {
>>>  		dev_err(dev, "failed to create PHY\n");
>>>  		return PTR_ERR(generic_phy);
>>>  	}
>>>
>>> +	exynos_phy->pcs_base = devm_platform_ioremap_resource(pdev, 1);
>>> +	exynos_phy->phy_id = of_alias_get_id(dev->of_node, "pciephy");
>>
>> Where did you document aliases?
>>
> 
> Will add it to dt bindings.
> 
>> Anyway, all this looks because you have completely buggy way of handling MMIO via syscon. That's a no-go. Use proper address
>> ranges assigned to ddevices. If you ever need to use syscon, you should pass the offset as argument - just like other devices are
>> doing.
>>
> 
> Alias is used for 2 reasons.

So if on my board the PCI slots are named differently and I use
different alias, everything will stop working, right? Usually aliases
for exposable buses are matching what is physically labeled on the
exposed interface.

> 1. Each of the 2 PHYs in FSD have different initializing sequence due to channel length, etc. We need the alias to select the init sequence accordingly

So devices are different? What is channel length? Number of lanes?


> 2. The syscon offset can be passed via DT but the bit field also varies according to instance. (common reset is bit 8 in PHY0 and bit 1 in PHY1).

You did not address the main problem here: you use MMIO but do not
define any MMIO. Syscon is not a replacement for MMIO.


Best regards,
Krzysztof

