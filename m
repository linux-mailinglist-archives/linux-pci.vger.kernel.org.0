Return-Path: <linux-pci+bounces-30365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F744AE3DE9
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 13:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEA9167A3C
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 11:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3582023D2A3;
	Mon, 23 Jun 2025 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqSFoUy6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E15423817F;
	Mon, 23 Jun 2025 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750678189; cv=none; b=WKbtJlzrKqb6IZsaKcU75FDPIXzYTk9S3nbdv2oa5zxWBgjO7EGL186ylWeIXDVBr8W3Kg7y+ty2t/715G3ptLDIwxL9aeWkddLTnl6ww6qPHwW4Zk+HObZIT/JunmHIxEDncfZKKdyej4voTALA2+J36QruD/raklOn9Xmk7FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750678189; c=relaxed/simple;
	bh=w6AaO6fgK2fNbORRzUvx6Qa3WCSt0XSFElEO927wLeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESwvF4vgSMdZHVKseIkLoC9XMpcxbi5gHjWXHo7ZZ9xWnvdqx1k4JTOPxoDeuOlJpjWJ2+QYozRUmPBOUek7PFKoBjQ/5s7g6etmKGfnYCR2/U1tZKMNeRptY2Vlj//h2Tui2VskZOFpn24t3NA1dwY+x6zz9M6pLmp6Ws6ctA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqSFoUy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE97C4CEF7;
	Mon, 23 Jun 2025 11:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750678188;
	bh=w6AaO6fgK2fNbORRzUvx6Qa3WCSt0XSFElEO927wLeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rqSFoUy60QVVLtbY4efKUq1P1PcXwr3lo6+JMXseUEvm9py7YL7hax6kFOSdZwdym
	 pTpZJh8spMc7wsGJXNvqY21TZArnFf5DV4hBRq0OxOzUd6GwDcmYQdd4J1eKvLEtlD
	 AJLG+YlZNMWC/1H2uMoN+rbrbbLrP7vqX5C67lAzhbSZB1GV9XWz00+6wGx6F6eWto
	 L5XtZS/rW+goRAs5AX+JNetLMNKAYTyAjsJNR3mC5ZmjWGu+Kf7eoiL4Y8L0r0BrEu
	 z9R8efYMX4mKAU89Yf/gBmIuL5DVZafBAb1zVfMSVph/EPQeOAufP4yXBkhCx1AyTS
	 Pcn2e2Bnp0C2g==
Date: Mon, 23 Jun 2025 05:29:46 -0600
From: Manivannan Sadhasivam <mani@kernel.org>
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: linux-rockchip@lists.infradead.org, 
	Hugh Cole-Baker <sigmaris@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/3] PCI: rockchip-host: Retry link training on
 failure without PERST#
Message-ID: <zuiq3b2rsixymtjr3xzrb26clikvlja62wgj65umnse4kuk75c@x5qan73ispxe>
References: <cover.1749582046.git.geraldogabriel@gmail.com>
 <b7c09279b4a7dbdba92543db9b9af169776bd90c.1749582046.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7c09279b4a7dbdba92543db9b9af169776bd90c.1749582046.git.geraldogabriel@gmail.com>

On Tue, Jun 10, 2025 at 04:05:40PM -0300, Geraldo Nascimento wrote:
> After almost 30 days of battling with RK3399 buggy PCIe on my Rock Pi
> N10 through trial-and-error debugging, I finally got positive results
> with enumeration on the PCI bus for both a Realtek 8111E NIC and a
> Samsung PM981a SSD.
> 
> The NIC was connected to a M.2->PCIe x4 riser card and it would get
> stuck on Polling.Compliance, without breaking electrical idle on the
> Host RX side. The Samsung PM981a SSD is directly connected to M.2
> connector and that SSD is known to be quirky (OEM... no support)
> and non-functional on the RK3399 platform.
> 
> The Samsung SSD was even worse than the NIC - it would get stuck on
> Detect.Active like a bricked card, even though it was fully functional
> via USB adapter.
> 
> It seems both devices benefit from retrying Link Training if - big if
> here - PERST# is not toggled during retry.
> 
> For retry to work, flow must be exactly as handled by present patch,
> that is, we must cut power, disable the clocks, then re-enable
> both clocks and power regulators and go through initialization
> without touching PERST#. Then quirky devices are able to sucessfully
> enumerate.
> 

This sounds weird. PERST# is just an indication to the device that the power and
refclk are applied or going to be removed. The devices uses PERST# to prepare
for the power removal during assert and start functioning after deassert.

It looks like the PERST# polarity is inverted in your case. Could you please
change the 'ep-gpios' polarity to GPIO_ACTIVE_LOW and see if it fixes the issue
without this patch?

If that didn't work, could you please drop the 'ep-gpios' property and check?

> No functional change intended for already working devices.
> 
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 47 ++++++++++++++++++---
>  1 file changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index 2a1071cd3241..67b3b379d277 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -338,11 +338,14 @@ static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
>  static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  {
>  	struct device *dev = rockchip->dev;
> -	int err, i = MAX_LANE_NUM;
> +	int err, i = MAX_LANE_NUM, is_reinit = 0;
>  	u32 status;
>  
> -	gpiod_set_value_cansleep(rockchip->perst_gpio, 0);
> +	if (!is_reinit) {
> +		gpiod_set_value_cansleep(rockchip->perst_gpio, 0);
> +	}
>  
> +reinit:

So this reinit part only skips the PERST# assert, but calls
rockchip_pcie_init_port() which resets the Root Port including PHY. I don't
think it is safe to do it if PERST# is wired.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

