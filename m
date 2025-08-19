Return-Path: <linux-pci+bounces-34243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561EAB2B982
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 08:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFD3682F3A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 06:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4C226B973;
	Tue, 19 Aug 2025 06:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GczAaAHj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D26825FA1D;
	Tue, 19 Aug 2025 06:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585251; cv=none; b=YGmCRnLPLsJVMVjoSMFgbEfP9kpo+serHZLjktxx2JdahIxynt/yeHmz4+WT6AOGKpTdDn/44mjMP4ZUpr89+aDg3DUpQ2Qj8Pj17T3SxvS6z+r+desu8a+79N3kOWeOE7fukTfzlygS2w9iDf7qUIlcIoecAyNi+fASyiYO0Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585251; c=relaxed/simple;
	bh=9tBtgRf5Ie1dj/J4hFT2ndZIaef60tq+Owe/LAehexU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GCEMTynGqEjthL3pwPXLjjGI/wmWIMr+oK4OwjAExjAfNixxPIlrcojGFiwGsylLx19h5btdx5tMoYJrpadX+w6meX6ZPJMtpTz9cRO+srE0JZgVaqHIHLVJZ3spDxMLJrPynrzefmhvFEsWkJwWcYx75Z+dZFs6r3pn9VO2xdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GczAaAHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D55C116B1;
	Tue, 19 Aug 2025 06:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755585250;
	bh=9tBtgRf5Ie1dj/J4hFT2ndZIaef60tq+Owe/LAehexU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GczAaAHjBVx6HLhTco4kfP0yl4ZiUi3jKTMyOyDiuvawN2LTAlAbSGcVtVl7lFIlS
	 qXl1HrIaMJmGFjkbwWMhlXvchMOa+B0m/6H/ueQiGcIdRZsGUHyyqahoQqspEtV01Q
	 tBBZlimZ9jaAMsQlvbLiMrqNEcl3noirrFrAoAxmB+W//mBbYGmb1Hrs1OSX+IR228
	 fFC4wInW/v4NINrHOPwNkdZ1CcdGWb3rP0iez8tsLDsDebzpFzSUiY2OTaGpD1qDfC
	 YkAvUEozp4FyTUIuR5Wrpil4CBCajqCwDOBRXfeJceLBFo6OgKPkK/FklJct/GR4So
	 O50QrKtX6oQkQ==
Message-ID: <29287880-9436-4acd-b3f9-b4d9eb726896@kernel.org>
Date: Tue, 19 Aug 2025 08:34:03 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] PCI: exynos: Add support for Tesla FSD SoC
To: Bjorn Helgaas <helgaas@kernel.org>, Shradha Todi <shradha.t@samsung.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
 robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
 vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
 m.szyprowski@samsung.com, jh80.chung@samsung.com, pankaj.dubey@samsung.com
References: <20250818182544.GA534647@bhelgaas>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250818182544.GA534647@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/08/2025 20:25, Bjorn Helgaas wrote:
> [+to Krzysztof]
> 
> On Mon, Aug 18, 2025 at 03:00:00PM +0530, Shradha Todi wrote:
>>> On Mon, Aug 11, 2025 at 09:16:37PM +0530, Shradha Todi wrote:
>>>> Add host and endpoint controller driver support for FSD SoC.
> 
>>> It's kind of unfortunate that the driver uses "ep" everywhere for
>>> struct exynos_pcie pointers.  It's going to be confusing because "ep"
>>> is also commonly used for endpoint-related things, e.g., struct
>>> dw_pcie_ep pointers.  Maybe it's not worth changing; I dunno.
>>
>> I did try to rename the structure and the pointers 
>> (https://lore.kernel.org/all/20230214121333.1837-9-shradha.t@samsung.com/)
>> But the intention was different back then and so the idea was rejected.
>> I could add a patch to only rename the pointers to something less
>> confusing like "exy_pci"
> 
> The patch you mention did several renames:
> 
>   s/to_exynos_pcie/to_samsung_pcie/
>   s/struct exynos_pcie/struct samsung_pcie/
>   s/struct exynos_pcie *ep/struct samsung_pcie *sp/
> 
> I'm only concerned about the confusion of "ep" being used both for
> "struct exynos_pcie *" and for "struct dw_pcie_ep *".
> 
> It would still be sort of an annoying patch to do something like this:
> 
>   s/struct exynos_pcie *ep/struct exynos_pcie *pcie/
> 
> But 'git grep "struct .*_pcie \*.*=" drivers/pci/controller/' says
> using "pcie" in this way is quite common, so maybe it would be worth
> doing.
> 
> What do you think, Krzysztof?

I think you want other Krzysztof, but nevertheless, the reasoning there
"Changing it to samsung_pcie for making it
generic."
is wrong. The naming of these structures do not matter, they are not
less generic. This is rather churn, which will affect backporting for
ZERO readability increase. Why zero? Because calling all this "exynos"
is the same as calling all this "samsung". It just does not matter.

However s/ep/pcie/ in variable name makes sense if that's more common.


Best regards,
Krzysztof

