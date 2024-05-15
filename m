Return-Path: <linux-pci+bounces-7537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4098C6DB8
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 23:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DFB11C20E8E
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 21:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE23D15B134;
	Wed, 15 May 2024 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7BbqReV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F6D155A57;
	Wed, 15 May 2024 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715808020; cv=none; b=UKJrhZx579UbMMdYSiNStCT6gPsWsYTPLCUVyVHJmeDjXj1ZTaUvcOTdBLAB6TxVhXmxqXlI01rAdXE24ElduDn1yJKgfVKco/odnyxiLmERHBXmOCzolb6+KWMMEpk4/p/njWcxzUTkSy07sR9aZ5bz7TF6FVBeZ2v2Vc799bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715808020; c=relaxed/simple;
	bh=+w6I/P+muVDYXfQbK+kBqVwASkHll/MFUWl8Em9lRxE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BZrhohj0gs/n3nSaC5RaQEk6q/YHU80oIIUz/fKlqKN/2ii6kjPnystVnMd3k8aCkC++odYo+pBRWGwmYiq+NMTArwA97mPR1zs8ZVPo51CKYrcGHoyXMneRxY7CDHMtkmVbu3fPZu4xmxCGDfDZFZMCMaUq6dS7o/IZtqi5trU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7BbqReV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F152EC116B1;
	Wed, 15 May 2024 21:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715808020;
	bh=+w6I/P+muVDYXfQbK+kBqVwASkHll/MFUWl8Em9lRxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=k7BbqReVQQVt2+DmLKbfcvG4vOMV5iilxTf+u44yEfidk2q1agziHZ6BB8dhuCKZz
	 SnPqxKbKY0U5K85Kqg4MHKYDZ3VvmIf1e2j4Ga6clTVERATEuxN9IvvfFZi8bJAzqt
	 1wdCZle+NJMEmOHJTL6YXmuMw5hNLoUwxDvG3uIH9yrhIfig4b+exAFMpECJfmBMTq
	 9ichqUlY5KwA1tf68hq84i4X0DAfiTRnVn9WoioOKXIjmp13SUKOOayqxH/wkgKehG
	 Su+UIWUkpIWQrFscCcJhut84tQDXv1F7Y+agwEONPDBx5vibHgkXLnQwKataAGW4mg
	 piBVJAHKt61jA==
Date: Wed, 15 May 2024 16:20:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Simon Xue <xxm@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	stable@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3] PCI: dw-rockchip: Fix initial PERST# GPIO value
Message-ID: <20240515212018.GA2139324@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417164227.398901-1-cassel@kernel.org>

On Wed, Apr 17, 2024 at 06:42:26PM +0200, Niklas Cassel wrote:
> PERST# is active low according to the PCIe specification.
> 
> However, the existing pcie-dw-rockchip.c driver does:
> gpiod_set_value(..., 0); msleep(100); gpiod_set_value(..., 1);
> When asserting + deasserting PERST#.
> 
> This is of course wrong, but because all the device trees for this
> compatible string have also incorrectly marked this GPIO as ACTIVE_HIGH:
> $ git grep -B 10 reset-gpios arch/arm64/boot/dts/rockchip/rk3568*
> $ git grep -B 10 reset-gpios arch/arm64/boot/dts/rockchip/rk3588*
> 
> The actual toggling of PERST# is correct.
> (And we cannot change it anyway, since that would break device tree
> compatibility.)
> 
> However, this driver does request the GPIO to be initialized as
> GPIOD_OUT_HIGH, which does cause a silly sequence where PERST# gets
> toggled back and forth for no good reason.
> 
> Fix this by requesting the GPIO to be initialized as GPIOD_OUT_LOW
> (which for this driver means PERST# asserted).
> 
> This will avoid an unnecessary signal change where PERST# gets deasserted
> (by devm_gpiod_get_optional()) and then gets asserted
> (by rockchip_pcie_start_link()) just a few instructions later.
> 
> Before patch, debug prints on EP side, when booting RC:
> [  845.606810] pci: PERST# asserted by host!
> [  852.483985] pci: PERST# de-asserted by host!
> [  852.503041] pci: PERST# asserted by host!
> [  852.610318] pci: PERST# de-asserted by host!
> 
> After patch, debug prints on EP side, when booting RC:
> [  125.107921] pci: PERST# asserted by host!
> [  132.111429] pci: PERST# de-asserted by host!
> 
> This extra, very short, PERST# assertion + deassertion has been reported
> to cause issues with certain WLAN controllers, e.g. RTL8822CE.
> 
> Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
> Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: stable@vger.kernel.org	# 5.15+

Applied by Krzysztof to pci/controller/rockchip.  His outgoing mail
queue was stuck, but I'm trying to squeeze this into v6.10.

> ---
> Changes since v2:
> -Picked up tag from Heiko.
> -Change subject (Bjorn).
> -s/PERST/PERST#/ (Bjorn).
> 
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index d6842141d384..a909e42b4273 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -240,7 +240,7 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
>  		return PTR_ERR(rockchip->apb_base);
>  
>  	rockchip->rst_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
> -						     GPIOD_OUT_HIGH);
> +						     GPIOD_OUT_LOW);
>  	if (IS_ERR(rockchip->rst_gpio))
>  		return PTR_ERR(rockchip->rst_gpio);
>  
> -- 
> 2.44.0
> 

