Return-Path: <linux-pci+bounces-43260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B32FCCAC52
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 09:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B50B3015D17
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 08:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6CC2EA173;
	Thu, 18 Dec 2025 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhcrn/0v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34312459ED;
	Thu, 18 Dec 2025 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045152; cv=none; b=SBRLtgHLX4iKQgNZt+qXrr5Wxm+P7ee73+Ywx/PzJqPhbxgqYrrGNrj6C3jXrgyXmAJzJ+2gP+tzT+MdomM9jTVTqxs3tmnuhyqSVH0bPAscypy1KPLzlc908C88i725D/r/XrJFE/OCFXRA0boU7Fwc1dAwYV5GBYQXwESod/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045152; c=relaxed/simple;
	bh=vELv4ehStK9743Z/oJRveuR6s774Sgk9sYDjlKQxYHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuFYsA2nTaqvz2suG7muwqtswWbnd4gyqoPN0qAD/Y7JZZPMH2vPHtJxwEVLPx7uCHRZMuDQ9869SpMeycP0rUMqW//AdXxgQ7+hmc+HyFd/21S0A/WGzkDgMQBrhhqdxe5h6zNFZ81RLE6CbahO2FGmSAAPUfh5tws8qfgFXpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhcrn/0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E393C4CEFB;
	Thu, 18 Dec 2025 08:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766045152;
	bh=vELv4ehStK9743Z/oJRveuR6s774Sgk9sYDjlKQxYHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dhcrn/0v8iolfLj1jxR1g5oRubuNyBWt96mwHJuW+kMJiY/qBzLvc86ldzkuiXcmm
	 x7jz5j8FIP3qVNfyczt+6/44EuK/H8UF3AIcHQFc/cm/5C5oyqN3yOtZTe6I3KxGpQ
	 yhdejaMoESOBd3WpOZIcd0qFj+pF9d7aAvclak0iQWTeG8i03Fbvfn1fs0TvPxWwaH
	 maePQ1k2KE2UTYaNbtbzfE5BRVynKnAbGLm44r15PkBh9a8gzr/wmqS9dc0L2ATLjc
	 JT4jkX2Eee1DRPEFhPiQqv6yYq/QU08kAAtfYMXVAD/4NmVdILXSU5kR5YrttQkEg7
	 N3p54RER5gAgg==
Date: Thu, 18 Dec 2025 13:35:37 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Johan Jonker <jbx6244@gmail.com>, 
	Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] PCI: rockchip: limit RK3399 to 2.5 GT/s to
 prevent damage
Message-ID: <qncj72c3owrw7rvnj6jit2sbn4ojyr3kztcjailfxtdboan6sy@ddh5g7v4fcvt>
References: <cover.1763415705.git.geraldogabriel@gmail.com>
 <eaa9c75ca02a53f8bcc293b8bc73d013e26ec253.1763415706.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eaa9c75ca02a53f8bcc293b8bc73d013e26ec253.1763415706.git.geraldogabriel@gmail.com>

On Mon, Nov 17, 2025 at 06:47:05PM -0300, Geraldo Nascimento wrote:
> Shawn Lin from Rockchip has reiterated that there may be danger in using
> their PCIe with 5.0 GT/s speeds. Warn the user if they make a DT change
> from the default and drive at 2.5 GT/s only, even if the DT
> max-link-speed property is invalid or inexistent.
> 
> This change is corroborated by RK3399 official datasheet [1], which
> says maximum link speed for this platform is 2.5 GT/s.
> 
> [1] https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf
> 
> Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC driver")
> Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
> Cc: stable@vger.kernel.org
> Reported-by: Dragan Simic <dsimic@manjaro.org>
> Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index 0f88da378805..992ccf4b139e 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -66,8 +66,14 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  	}
>  
>  	rockchip->link_gen = of_pci_get_max_link_speed(node);
> -	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
> -		rockchip->link_gen = 2;
> +	if (rockchip->link_gen < 0 || rockchip->link_gen > 2) {
> +		rockchip->link_gen = 1;
> +		dev_warn(dev, "invalid max-link-speed, set to 2.5 GT/s\n");
> +	}
> +	else if (rockchip->link_gen == 2) {
> +		rockchip->link_gen = 1;
> +		dev_warn(dev, "5.0 GT/s is dangerous, set to 2.5 GT/s\n");

What does 'danger' really mean here? Link instability or something else?

Error messages should be precise and not fearmongering.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

