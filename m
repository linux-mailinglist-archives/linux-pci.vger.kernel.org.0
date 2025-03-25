Return-Path: <linux-pci+bounces-24666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5F0A7023D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 14:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD77A19A2682
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 13:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247C2265618;
	Tue, 25 Mar 2025 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKWM5ZD7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF49264F91;
	Tue, 25 Mar 2025 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909132; cv=none; b=JE5+2azZmUbm5IhDhVl49n2en/sU0BpASEuIRF2T0McXuRcGJ/PpFCQhftvg5mxTRuxAtKt6hrpxq8mzjgiaLMsm4gijaFHshkUMwS8F8Qhi5bIwcPEQupfJy3Pl4aGkJoMwU3VzrAJJe8XH+g6d99xZ1j4UXGjxDXch8b/uzoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909132; c=relaxed/simple;
	bh=dr/I/9nNgrTKDQbi1FOfdC3fHsEg+MgYpU5p3SIxKFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWXyyuyQy10KjQrf4SpgPD/6xs/AxdO3RSCQ60eFuNpZXl1VOBo5ezQ0rkaK8AlR1M82QSDRm0gSNSZr1dU5OtcLfXd9xD3AQFmd1o46f5G/vxp3vWfgRVPzhWRPW7ZIPgxb3RG1lMXUflZhvrVCylNFW3Uc2WfggX1dyJ4pabE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKWM5ZD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D50C4CEED;
	Tue, 25 Mar 2025 13:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742909132;
	bh=dr/I/9nNgrTKDQbi1FOfdC3fHsEg+MgYpU5p3SIxKFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mKWM5ZD7jugXW5b5BRsr96+Cfdtb5zImy9KHAmlaWtdOeYduPQKFXMoUrn79QBKoK
	 hlrLoh9b4kBVcBAYPyq72peGkYoERUrgG1eKnzpkDi9Add/E/sKRGqdvylh45TOD96
	 yJtlrk1oHu5JcDQvI5aoO+0fo3Tjz715zakPyooFuXqgZ5aflbqHGo8QiXtfxemt+z
	 1AUe7moQmSFX3wpUfvx0WaNRJMW/aqZ3qMv1hBrR+tpj7ITd28dooL0hl46lgKFmwY
	 Pnl5T9mt3bBUuL6mW8IExIctbXQGxK07xtOvSvQReadebYzipdP5jfJy3IOWzGwBps
	 KP4qV1lCag4GQ==
Date: Tue, 25 Mar 2025 08:25:31 -0500
From: Rob Herring <robh@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 08/13] PCI: apple: Set only available ports up
Message-ID: <20250325132531.GA1717731-robh@kernel.org>
References: <20250325102610.2073863-1-maz@kernel.org>
 <20250325102610.2073863-9-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325102610.2073863-9-maz@kernel.org>

On Tue, Mar 25, 2025 at 10:26:05AM +0000, Marc Zyngier wrote:
> From: Janne Grunau <j@jannau.net>
> 
> Iterating over disabled ports results in of_irq_parse_raw() parsing
> the wrong "interrupt-map" entries, as it takes the status of the node
> into account.
> 
> Switching from for_each_child_of_node() to for_each_available_child_of_node()
> solves this issue.

I really wish "available" was the default iterator...

> 
> This became apparent after disabling unused PCIe ports in the Apple
> Silicon device trees instead of deleting them.
> 
> Link: https://lore.kernel.org/asahi/20230214-apple_dts_pcie_disable_unused-v1-0-5ea0d3ddcde3@jannau.net/
> Link: https://lore.kernel.org/asahi/1ea2107a-bb86-8c22-0bbc-82c453ab08ce@linaro.org/
> Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
> Cc: stable@vger.kernel.org

Fixes especially for stable should go first in the series.

> Signed-off-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/pci/controller/pcie-apple.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index 6271533f1b042..23d9f62bd2ad4 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -747,7 +747,7 @@ static int apple_pcie_init(struct pci_config_window *cfg)
>  	struct device_node *of_port;
>  	int ret;
>  
> -	for_each_child_of_node(dev->of_node, of_port) {
> +	for_each_available_child_of_node(dev->of_node, of_port) {
>  		ret = apple_pcie_setup_port(pcie, of_port);
>  		if (ret) {
>  			dev_err(dev, "Port %pOF setup fail: %d\n", of_port, ret);
> -- 
> 2.39.2
> 

