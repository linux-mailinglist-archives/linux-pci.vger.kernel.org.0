Return-Path: <linux-pci+bounces-27677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C116AB633A
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 08:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFEE74A15ED
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 06:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1771717799F;
	Wed, 14 May 2025 06:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzdGXUz5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FA6DDD3;
	Wed, 14 May 2025 06:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747204521; cv=none; b=cMcylHFTw4lPP1AtN7jhXisEgBEbcSrATquIqYXa/FMhlcGglFhiSA+8X0X3xAJVpAT13Cy9ZGfxh3nNhZmpx8B3hLhfchGW+WD7HlrL201pk9eOn9LXb++s3+VyOP8q5py6O9xV7VQ7lpCpkkGH8t/jrK3ap1euyTrCm62uj9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747204521; c=relaxed/simple;
	bh=3HYaE0yEblyTc0/tXc2/SMe0XXjeXvoaNBUMDbiP0Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ni30w+ArIIDNghjPn7r2ovDxECTrrsGXujbd6CoYhW1z+NQllHPzreZsWvOTDSpNgH4vsgWxQ1LwGvPNkA7ITiqIvFjIW7U1DMol4xTEnXmdrZMGG7js/g/zyH2zrkkI7nWtxAfJysXXObEtu8vPlzWa+TR9YCHM6UubYq6ZT8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzdGXUz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B39C4CEE9;
	Wed, 14 May 2025 06:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747204520;
	bh=3HYaE0yEblyTc0/tXc2/SMe0XXjeXvoaNBUMDbiP0Ns=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FzdGXUz5sn8pggwimVnoZToZXJduzY7CR1FxsPlY9Wu/tcOwmHm7cCydW7UM189G7
	 53jld+YSdar0VXMUTxRcK3Qg4EyipXAv4hhfSaceZJNzanzBZCIWP8vO/Goe6Hm2KD
	 9A2tVeJPSDwd9IPF0hhZl6V1Dc5X9JbrJthQB5tcwvNLzOxOCkwEaZAAQTcBjkEJ/c
	 vm5bS83d6xSE4f66LzTKcN8EsR1uJ0pnnRvVaUcW8KmFNMktiKLNM0fkdiY8rqnG12
	 H/MczNgATS6XC3UrHY9Hz1uUiHpeIl4Bho72u74MDGGbZwigJo14kszdhkVikvkf+z
	 u15ADghnHSOHQ==
Message-ID: <953f3082-2379-40d6-bc1e-0bc0197d531d@kernel.org>
Date: Wed, 14 May 2025 15:35:10 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] PCI: endpoint: cleanup get_msi() callback
To: Niklas Cassel <cassel@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jingoo Han <jingoohan1@gmail.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>, stable+noautosel@kernel.org,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20250513073055.169486-8-cassel@kernel.org>
 <20250513073055.169486-11-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250513073055.169486-11-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/25 16:30, Niklas Cassel wrote:
> The kdoc for pci_epc_get_msi() says:
> "Invoke to get the number of MSI interrupts allocated by the RC"
> the kdoc for the callback pci_epc_ops->get_msi() says:
> "ops to get the number of MSI interrupts allocated by the RC from
> the MSI capability register"
> 
> pci_epc_ops->get_msi() does however return the number of interrupts
> in the encoding as defined by the MME Multiple Message Enable field.
> 
> Nowhere in the kdoc does it say that the returned number of interrupts
> is in MME encoding.
> 
> Thus, it is very confusing that the wrapper function (pci_epc_get_msi())
> and the callback function (pci_epc_ops->get_msi()) don't return the same
> value.
> 
> Cleanup the API so that the wrapper function and the callback function
> will have the same semantics.

Nit: please mention which semantic this patch changes the API to use, that is,
to follow the kdoc and return the number of interrupts, regardless of the
internal encoding of that value.

Other than that, looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>]

-- 
Damien Le Moal
Western Digital Research

