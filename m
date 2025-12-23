Return-Path: <linux-pci+bounces-43601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D10CD9E18
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 16:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 933DE3007946
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 15:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7CB27BF7C;
	Tue, 23 Dec 2025 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeDI8oUb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4D6271440;
	Tue, 23 Dec 2025 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766505562; cv=none; b=XsfET8rFe+MvUpghMxlEH3JqQzfxLtOH/Dij4jYPVyOgIGrmYwBiHVC1oAOgLR0paKr8PWiJWalrC5n5qqKDLrXRGa8gICz+PYdR2ClKyuAmmomiMIAQ58v25Jn4D/yOgRNanhwzXKJyAq9McUy4poxf0MI8GNSwwUJKXVBaBXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766505562; c=relaxed/simple;
	bh=FbWzgepLOv260NOsYwp6cw6dEnGFg6D/tQJ2zegwDW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRsvvhAp/4hb6xJ/95wnt8YL+aIs1EltMh6qAPrQV0Oe6/yI+90uPT2SzaMO3aBfTXgWrc4TyTduMxbb9I6cGxtnbx2lArWfgjLf5ddwte7Ez7vVSJTJaUf84hIK0+vwFtkjwCg3ixZY4Jc3eMxjZaG3BGEjTeRqmK99lNYI5U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeDI8oUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66062C113D0;
	Tue, 23 Dec 2025 15:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766505561;
	bh=FbWzgepLOv260NOsYwp6cw6dEnGFg6D/tQJ2zegwDW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UeDI8oUbunx4UBfNA6d7KG5fyjjI9KmunMraw0Wx9LS4Hp16nLeZZBz8kyIj52oUv
	 9uRuyPnv20E20eYGmaepK4E7hP/ltzOo6PshS9Z0Dh8yZjmxIzUN8d68qs4Y5FB6ge
	 Zo+5vkJwIxesmQ56/duA4lb4JqSm7FFcHyOxdkLNsHjnhAvhYjqFFUeI3bQuTuR9sL
	 6WA8iJPckwmgiYiynonJ8g3Pb8ONVPP5B0L7ezwkZ2UYiOxDuGAfjV+Eec2asCYsSP
	 rlqz5MfZzR8AJHivVawcVr7LwfVLNerplK5SK43XjEeA16sT09SmSdaJFLylwvGwSw
	 +wThtapcDsxgQ==
Date: Tue, 23 Dec 2025 21:29:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v7 7/7] MAINTAINERS: Add ASPEED PCIe RC driver
Message-ID: <kbads4vnfjf2ce6sks7bvjmhpt73fmvdmrikxwp7y6wjw3flse@5yer3aegbfo6>
References: <20251216-upstream_pcie_rc-v7-0-4aeb0f53c4ce@aspeedtech.com>
 <20251216-upstream_pcie_rc-v7-7-4aeb0f53c4ce@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251216-upstream_pcie_rc-v7-7-4aeb0f53c4ce@aspeedtech.com>

On Tue, Dec 16, 2025 at 09:50:06AM +0800, Jacky Chou wrote:
> Add maintainer for ASPEED PCIe RC driver.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aff3e162180d..c327ea375746 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3900,6 +3900,18 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/media/aspeed,video-engine.yaml
>  F:	drivers/media/platform/aspeed/
>  
> +ASPEED PCIE CONTROLLER DRIVER
> +M:	Jacky Chou <jacky_chou@aspeedtech.com>
> +L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
> +L:	linux-pci@vger.kernel.org
> +L:	linux-phy@lists.infradead.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
> +F:	Documentation/devicetree/bindings/phy/aspeed,ast2600-pcie-phy.yaml
> +F:	drivers/pci/controller/pcie-aspeed.c
> +F:	drivers/phy/aspeed/Kconfig
> +F:	drivers/phy/aspeed/pcie-phy-aspeed.c

PHY drivers and binding belong to a separate entry. So I've removed these while
applying.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

