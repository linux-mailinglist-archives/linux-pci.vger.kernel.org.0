Return-Path: <linux-pci+bounces-31309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977C2AF6333
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 22:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652B73A62DC
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 20:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A744B2DE6EB;
	Wed,  2 Jul 2025 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYu+6qs6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E732DE6E0;
	Wed,  2 Jul 2025 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751487500; cv=none; b=Lc2uf/r5wtW9HhSk597VOVLNspqyTQ4QxEufcZkTki5v7gwLCuC4yZK+NcZyZkHYiDE63Ens1Nf5W+Z/CShixZvg96O9daFHwtCPmU9aVVOBSf0yN2kAmUFZgs3wjfvFhwRN+UBBtauz1J7BhjxMPBtQlcOjN06LgF/K6jwaY7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751487500; c=relaxed/simple;
	bh=NcF5Lgsozi3TFSSbY4XniUHjQlhATuSDYxxjEZOfZVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgkYUFScg24UkYIGCGYYlAQkyPPaMepuTDqxeXiF64w95V9vGKorgZbabSuZdg+8ao7SwpwhmL4Dz3pSNFqC3m8UVQFltAmLOMd3xKa+xQlvjj0C+g6hTT/ciRiHa3JPHPBDApzanXUf7mOBh/bHNoe5tsaPhNuGoPF7Dwwgby0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYu+6qs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA60AC4CEE7;
	Wed,  2 Jul 2025 20:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751487500;
	bh=NcF5Lgsozi3TFSSbY4XniUHjQlhATuSDYxxjEZOfZVY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YYu+6qs6aYB9p0c253YPNEopymUMpYODORctEmyvnn4d1xFDqP3hIrV+VFnyPEReD
	 65QDpjzVtHGOZKtl9l0ICaXyUqGetDtpTWa649hp3VFwulZgzb5KjAq6FDcsaOCbpj
	 kx6Io6Cy3aaEU6HO+goGDeES/mRzApt2Wb1meRCabDzlt9SUPXJDVfBdrIsE1YFxed
	 GLONaEor2TxsJRdF9X6GwBT4WKfnW1Hh4wWWgGkDymtuU4NP05M+MnRqSMpWKiI+vp
	 qRl0uwHqvvRpXbPRAjlzdV8iuGvOX5u1v4ZBaVccqEaz+ffJ9uC1Fp1iPgAmcRiBSM
	 d+FC6QGjSOzaw==
Message-ID: <5ea33054-8a08-4bb3-81e7-d832c53979dc@kernel.org>
Date: Wed, 2 Jul 2025 22:18:10 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] dt-bindings: phy: Add PHY bindings support for
 FSD SoC
To: Shradha Todi <shradha.t@samsung.com>, 'Rob Herring' <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-fsd@tesla.com, mani@kernel.org, lpieralisi@kernel.org, kw@linux.com,
 bhelgaas@google.com, jingoohan1@gmail.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, alim.akhtar@samsung.com, vkoul@kernel.org,
 kishon@kernel.org, arnd@arndb.de, m.szyprowski@samsung.com,
 jh80.chung@samsung.com, pankaj.dubey@samsung.com
References: <20250625165229.3458-1-shradha.t@samsung.com>
 <CGME20250625165319epcas5p3721c19f6e6b482438c62dd1ef784de03@epcas5p3.samsung.com>
 <20250625165229.3458-8-shradha.t@samsung.com>
 <20250627211721.GA153863-robh@kernel.org>
 <02af01dbea78$24f01310$6ed03930$@samsung.com>
 <f877b3d7-d770-4424-9813-da748775f456@kernel.org>
 <02bf01dbea8c$fc835cb0$f58a1610$@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <02bf01dbea8c$fc835cb0$f58a1610$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/07/2025 15:35, Shradha Todi wrote:
>>> does not support auto adaptation so we need to tune the PHYs
>>> according to the use case (considering channel loss, etc). This is why we
>>
>> So not same? Decide. Either it is same or not, cannot be both.
>>
>> If you mean that some wiring is different on the board, then how does it
>> differ in soc thus how it is per-soc property? If these are use-cases,
>> then how is even suitable for DT?
>>
>> I use your Tesla FSD differently and then I exchange DTSI and compatibles?
>>
>> You are no describing real problem and both binding and your
>> explanations are vague and imprecise. Binding tells nothing about it, so
>> it is example of skipping important decisions.
>>
>>> have 2 different SW PHY initialization sequence depending on the instance
>>> number. Do you think having different compatible (something like
>>> tesla,fsd-pcie-phy0 and tesla,fsd-pcie-phy1) and having phy ID as platform data
>>> is okay in this case? I actually took reference from files like:
>>
>> And in different use case on same soc you are going to reverse
>> compatibles or instance IDs?
>>
> 
> Even though both the PHYs are exactly identical in terms of hardware,
> they need to be programmed/initialized/configured differently.
> 
> Sorry for my misuse of the word "use-case". To clarify, these configurations
> will always remain the same for FSD SoC even if you use it differently.
> 
> I will use different compatibles for them as I understand that it is the best
> option.

I still do not see the difference in hardware explained.

Best regards,
Krzysztof

