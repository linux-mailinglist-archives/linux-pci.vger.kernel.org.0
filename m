Return-Path: <linux-pci+bounces-6358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DD28A875B
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 17:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54B8EB2388D
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 15:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94F613959C;
	Wed, 17 Apr 2024 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKNyUK2Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23E31422BE;
	Wed, 17 Apr 2024 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367219; cv=none; b=akspibmNO84DdbFrDHnCuy94Okq5iVhVKOATYHTixyHAQkAUR3u0BflACBawW5JAFWZQziYXR6+NOuEfIBw4/amylmi34eAOih/p5/t57T9E1pzAHcOjb2HjeVToyyXwT9K0QzCoyTD5E8Q0j+skQV7M7c7emwFZasbziWTFqqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367219; c=relaxed/simple;
	bh=bjG0OvVci60DYDmOstQK1av/d1jsvMQvEpItMyw5WyA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XvwhALXalC/CVldGEQCuA+6bQdYdYCIeEb7zHNY9hAke/3tkQquoT+3HIN7CzmxvMrO0jTSbHYUcC0ee1gb6U6WdK+V70bujSiEyo+RMQ0deUGNjOhlePr5vciw/SQ7zqxosjLIZCkShaDR8edBKzckFBP+kPt62Me3j/C0PZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKNyUK2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C669C072AA;
	Wed, 17 Apr 2024 15:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713367219;
	bh=bjG0OvVci60DYDmOstQK1av/d1jsvMQvEpItMyw5WyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oKNyUK2YWHX8izA/mUulk3F0nlFtMEadilpVR2vygtEwK0vfii3BK7XbujV5Lbozd
	 XSVXsrp79Ixbx/KQ17UpMtNKQDneMeCzlrh7itYCXyXqfIFtN75zTX9Gg5Ncd+lDju
	 BgaqIuEWgp7SPxmvmuyMun17Am84fsKkKDIQjxfZtcU+uCWxrMy3cM06DvHYwIptb7
	 cSw8QKj8TKldn0hNb9VetsJJ+96WCK4fum3C2ndFKKtJE63pJAgSF5dHhL8KqWRmCH
	 wd9WGvW1957MkjPjp4dcbmIr6bE7m26xwIcsXzUXdgSYud0y60mvZiNjMZIrc9r9kd
	 qOlxNve/9WPjw==
Date: Wed, 17 Apr 2024 10:20:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Simon Xue <xxm@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	stable@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Fix GPIO initialization flag
Message-ID: <20240417152017.GA202515@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416121522.269972-1-cassel@kernel.org>

On Tue, Apr 16, 2024 at 02:15:22PM +0200, Niklas Cassel wrote:
> PERST is active low according to the PCIe specification.

Maybe update the subject to mention that this is about PERST# and
avoiding an unnecessary toggle.

Also maybe worth using "PERST#" here in the commit log to match the
spec and connect with the explicit GPIO levels.

> However, the existing pcie-dw-rockchip.c driver does:
> gpiod_set_value(..., 0); msleep(100); gpiod_set_value(..., 1);
> When asserting + deasserting PERST.
> 
> This is of course wrong, but because all the device trees for this
> compatible string have also incorrectly marked this GPIO as ACTIVE_HIGH:
> $ git grep -B 10 reset-gpios arch/arm64/boot/dts/rockchip/rk3568*
> $ git grep -B 10 reset-gpios arch/arm64/boot/dts/rockchip/rk3588*
> 
> The actual toggling of PERST is correct.
> (And we cannot change it anyway, since that would break device tree
> compatibility.)
> 
> However, this driver does request the GPIO to be initialized as
> GPIOD_OUT_HIGH, which does cause a silly sequence where PERST gets
> toggled back and forth for no good reason.
> 
> Fix this by requesting the GPIO to be initialized as GPIOD_OUT_LOW
> (which for this driver means PERST asserted).
> 
> This will avoid an unnecessary signal change where PERST gets deasserted
> (by devm_gpiod_get_optional()) and then gets asserted
> (by rockchip_pcie_start_link()) just a few instructions later.
> 
> Before patch, debug prints on EP side, when booting RC:
> [  845.606810] pci: PERST asserted by host!
> [  852.483985] pci: PERST de-asserted by host!
> [  852.503041] pci: PERST asserted by host!
> [  852.610318] pci: PERST de-asserted by host!
> 
> After patch, debug prints on EP side, when booting RC:
> [  125.107921] pci: PERST asserted by host!
> [  132.111429] pci: PERST de-asserted by host!
> 
> This extra, very short, PERST assertion + deassertion has been reported
> to cause issues with certain WLAN controllers, e.g. RTL8822CE.
> 
> Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
> Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: stable@vger.kernel.org	# 5.15+
> ---
> Changes since V1:
> -Picked up tags.
> -CC stable.
> -Clarified commit message.
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

