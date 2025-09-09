Return-Path: <linux-pci+bounces-35709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D00B49E4C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 02:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E2B18928A5
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 00:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2218E1F8BA6;
	Tue,  9 Sep 2025 00:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFvbb6Hn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88081DDC2B;
	Tue,  9 Sep 2025 00:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757378868; cv=none; b=gFX0ZjdTcFeTiB7wJO+FvPa8oPu6i1Qo2KxTeUC7Cz2PB4QF8ZY1omhCeto2fa9uzhirRySXTf9wISzdQurfw3PNf9PAe8xx9eWCwtRx7umqeZzK3cRSKynnwLzMeVCUlM+o/C9x5UGcFcNmfTlOZaSA/EyerePRQc7OXGZhR30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757378868; c=relaxed/simple;
	bh=zy06io68iOVZYCgiZwnvNmFkyT+ulKg9fSvGqjcKcN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJ96WGyGEQks4ygxgIQCo8qyYocopK0WbXMQ/vwMdLZp1F549EWwGxaFEWDxIrhUf5o7WwCy1Nzsn06fsT5vJfRO4/zxNpDOhsNys62Uvwpt5KMEsKRerSDLufFCXuhUt5TTAGTgwQFF4wg3BmxIruB+ec5HrfTpWnEWEfIlriU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFvbb6Hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692AFC4CEF1;
	Tue,  9 Sep 2025 00:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757378867;
	bh=zy06io68iOVZYCgiZwnvNmFkyT+ulKg9fSvGqjcKcN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lFvbb6HnpVHha2QYxeYIX0bkE+3dooJdy12p2Y1WtCqf+8KJ2KHtE8W/upyI42rJq
	 W/bR3/vsaW/Yk6P2f5oIysRasonAGlc4I9+H8t0TDGRUpXjqdhrZIXpv4CAcE9/fDe
	 I/x9x+Sam2B7yFFYLzM0HLaPcTnawzik3KVS05svRPTW26kcYZU1V0zZ414hoytHqW
	 iSKhYPWLpHvp2ZHT/0mlk/0I5lEfE1y5myFH79/klACkDgPJIiyL3Ftb8lm7NRNK1a
	 RRcmX/+pgIEtlIzsfGQOsSfAHeFJ4tdTWzI+rr0N/sV9gnAt1sCOm1i8LQAowH65eA
	 +20GqpgsNGG4w==
Date: Mon, 8 Sep 2025 19:47:46 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>, Simon Xue <xxm@rock-chips.com>,
	linux-rockchip@lists.infradead.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: PCI: dwc: rockchip: Add RK3528 variant
Message-ID: <175737886558.2322312.14140565713141816216.robh@kernel.org>
References: <20250906135246.19398-1-ziyao@disroot.org>
 <20250906135246.19398-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906135246.19398-2-ziyao@disroot.org>


On Sat, 06 Sep 2025 13:52:44 +0000, Yao Zi wrote:
> RK3528 ships a PCIe Gen2x1 controller that operates in RC mode only.
> Since the SoC has no separate MSI controller, the one integrated in the
> DWC PCIe IP must be used, and thus its interrupt scheme is similar to
> variants found in RK3562 and RK3576.
> 
> Older BSP code claimed its integrated MSI controller supports only 8
> MSIs[1], but this has been changed in newer BSP[2] and testing proves
> the controller works correctly with more than 8 MSIs allocated,
> suggesting the controller should be compatible with the RK3568 variant.
> Let's document its compatible string.
> 
> Link: https://github.com/rockchip-linux/kernel/blob/792a7d4273a5/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L1610-L1613 # [1]
> Link: https://github.com/rockchip-linux/kernel/blob/1ba51b059f25/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L904-L906 # [2]
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


