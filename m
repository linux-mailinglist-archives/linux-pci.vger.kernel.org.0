Return-Path: <linux-pci+bounces-44108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2B3CF8903
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 14:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC5C730281B2
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 13:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839EE33AD85;
	Tue,  6 Jan 2026 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUU36bGs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A36533A9FD;
	Tue,  6 Jan 2026 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706592; cv=none; b=Pq8upx5zI8qMG44tcU7/RfVlA+tEKn814VBzEOM3UdsVF41o0ukEt9Lg12oMiK6vJHjfYUDsVvJVW8+dMbnhQEr6Ugmib3l2BUvq5JEFDVeNNOSTTmcw4kf2MhvptmF0I1+OLRdY3oJqqWB0/LOEbfy7kmZT9csi2zp5ZCQhcds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706592; c=relaxed/simple;
	bh=nHXV1LgeY+ybeHMb4BYaUT8tHK4MVM5/lrtO7MTBwbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJZXI8RIdTZiGCHRFxSJXJVJZwcVUzwICFWVFg3yh1i0m/d9ioJJ1c5tUBhWnOdtQxPq46bxWHx1HKxNQnfDiFEzMdgOZ31lLfm1a2zXNjeHpv2J4kKrIHl/liMdZ77nF+l25nDvOquEQt7eXU/dr3o8QhP+D06zYYT4MPWIyzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUU36bGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C11FC116C6;
	Tue,  6 Jan 2026 13:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767706591;
	bh=nHXV1LgeY+ybeHMb4BYaUT8tHK4MVM5/lrtO7MTBwbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cUU36bGsPCyB1zwaKXyEiDn53MGc9yjEYD31Zip37sFZB+brbZTX3m7w0iwNuq7IH
	 72DGfxFCWXCqiLsY8+XmppJV3vMyl9utdvjSkRq4eYLLSYIxHwaePttTnNwgJVlV9S
	 yo4OGgL8HqK5QEzBbTHIUQC4kFeLA0b8Ol0AtOWXs0KtFEoU3Kjbr7zzDHj1vEEqOA
	 ov6owVdvvRQ5jTCgEpuO01wIavR0tftMBH+dag9ZJibe6vjy4rKacjtHL2kj3xUkrs
	 g9d2b3AVkqj0I5VyiGRhfDCra2bWPRZaB1lLEZUpFGWN2tyIU4i+LW4259Dd9oCvO7
	 fpddhn/lQs+Kg==
Date: Tue, 6 Jan 2026 19:06:23 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Hans Zhang <18255117159@163.com>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: dw-rockchip: Add runtime PM support to Rockchip
 PCIe
Message-ID: <ald3sxdzggbhqvpc7ra7x5nkf36xoamgwfumz5r4jwgirdzyes@nwvka2h256f6>
References: <20260102131819.123745-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260102131819.123745-1-linux.amoon@gmail.com>

On Fri, Jan 02, 2026 at 06:47:50PM +0530, Anand Moon wrote:
> Add runtime powwe manageement functionality into the Rockchip DesignWare
> PCIe controller driver. Calling devm_pm_runtime_enable() during device
> probing allows the controller to report its runtime PM status, enabling
> power management controls to be applied consistently across the entire
> connected PCIe hierarchy.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v2:
>    improve the commit message
>    Drop the .remove patch
>    Drop the disable_pm_runtime
> v1:
>  https://lore.kernel.org/all/20251027145602.199154-3-linux.amoon@gmail.com/
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index f8605fe61a415..2498ff5146a5a 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -20,6 +20,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
>  
> @@ -709,6 +710,20 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto deinit_phy;
>  
> +	ret = pm_runtime_set_suspended(dev);
> +	if (ret)
> +		goto deinit_clk;

Seriously? Why do you need this? Default PM status is 'suspended'.

> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret) {
> +		ret = dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
> +		goto deinit_clk;
> +	}
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		goto deinit_clk;
> +
>  	switch (data->mode) {
>  	case DW_PCIE_RC_TYPE:
>  		ret = rockchip_pcie_configure_rc(pdev, rockchip);
> @@ -730,6 +745,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  
>  deinit_clk:
>  	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> +	pm_runtime_disable(dev);

You used devm_ for enable.

> +	pm_runtime_no_callbacks(dev);

Why? Where is pm_runtime_put()? Please read Documentation/power/runtime_pm.rst.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

