Return-Path: <linux-pci+bounces-29775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A54FAD9627
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 22:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD623A9E68
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 20:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EB324DCE0;
	Fri, 13 Jun 2025 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKTWHR0P"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D249924C08D;
	Fri, 13 Jun 2025 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749846057; cv=none; b=JYL4hrABbX9vglFvUHWF/a8Aust3EmnvKXqOcTFxruaD+dfH30ms5yQ613x8TpZkp4tOSAIMH9mkdgFnbOWrbQDImtc4hobFZLBlxrV6d30GbQ58gInJAmc8PAkhtNz9x5GsAlTXzjokzBaLQls4rG3RjIVoEGh94qDA0q+fKPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749846057; c=relaxed/simple;
	bh=6KUd6SjVInqm4qHBGUp3HKQszrrAseaeXFamTSXmz2g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fe8jei8pxPC26EVwWi5txY9DJlKxEo/nxotsx6GkCrkXcJKKXAXi2q0elyErwwrwgN5G5+tTm3Pz0VRCICIBEHSFTN0I9415SKfiQIHfDXOJMAfIeHAk1VMQmvYz9cpoJ9VuVnL/ODycNCTpupi5G1djMnqSSyp4cFxvqrZUmsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKTWHR0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD5CC4CEF0;
	Fri, 13 Jun 2025 20:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749846057;
	bh=6KUd6SjVInqm4qHBGUp3HKQszrrAseaeXFamTSXmz2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aKTWHR0Pj5XwixyMybSxmRXMXqFopnZeQjwxw+eWNwNhtratX2Fbax6AgWr98Ilrq
	 Xk25jE2ldYwGCX/BaWf5e9/O0gSF/CZsF2be3nn1/N7IXDm7jmuu/Y/Deeh3cTZ7Te
	 xId65s512KOKFMjtHi9+pPsqL69FSZxPwXzScQg3T036KXeg7F5TUOPFiKIYM93gKk
	 XEMmDsqzwNLIrzAd5QNY7NboalW/wi6L4juJS7b4pcjZoJ/VjGz0K3e2Tc55Vn+NRL
	 irccNfeU7j54nmkZrGByvaETg7hex3mXJIzu73WxXyqY4fS7nJz90A0bPuJLbDuKMq
	 liK0r/XgoPa0g==
Date: Fri, 13 Jun 2025 15:20:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v4 5/5] phy: rockchip-pcie: Adjust read mask
 and write
Message-ID: <20250613202056.GA974155@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b32c8e4e0e36c03ae72bff13926d8bdd9131c838.1749827015.git.geraldogabriel@gmail.com>

On Fri, Jun 13, 2025 at 12:06:28PM -0300, Geraldo Nascimento wrote:
> Section 17.6.10 of the RK3399 TRM "PCIe PIPE PHY registers Description"
> defines asynchronous strobe TEST_WRITE which should be enabled then
> disabled and seems to have been copy-pasted as of current. Adjust it.
> While at it, adjust read mask which should be the same as write mask.

Not a PCI patch, but "adjust" doesn't tell us what's happening.

From reading the patch, I assume that since PHY_CFG_WR_ENABLE and
PHY_CFG_WR_DISABLE were both defined to be 1, this code:

        regmap_write(rk_phy->reg_base, rk_phy->phy_data->pcie_conf,
                     HIWORD_UPDATE(PHY_CFG_WR_DISABLE,
                                   PHY_CFG_WR_MASK,
                                   PHY_CFG_WR_SHIFT));

actually left something *enabled* when it meant to disable it.

Maybe the subject/commit log could say something about actually
disabling whatever this is instead of leaving it enabled?

PHY_CFG_RD_MASK appears unused, so maybe it should be just removed.

> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-pcie.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
> index 48bcc7d2b33b..35d2523ee776 100644
> --- a/drivers/phy/rockchip/phy-rockchip-pcie.c
> +++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
> @@ -30,9 +30,9 @@
>  #define PHY_CFG_ADDR_SHIFT    1
>  #define PHY_CFG_DATA_MASK     0xf
>  #define PHY_CFG_ADDR_MASK     0x3f
> -#define PHY_CFG_RD_MASK       0x3ff
> +#define PHY_CFG_RD_MASK       0x3f
>  #define PHY_CFG_WR_ENABLE     1
> -#define PHY_CFG_WR_DISABLE    1
> +#define PHY_CFG_WR_DISABLE    0
>  #define PHY_CFG_WR_SHIFT      0
>  #define PHY_CFG_WR_MASK       1
>  #define PHY_CFG_PLL_LOCK      0x10
> -- 
> 2.49.0
> 

