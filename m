Return-Path: <linux-pci+bounces-39902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D657C23D6E
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 09:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1BC3B1525
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 08:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D678F2E1758;
	Fri, 31 Oct 2025 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DB+REZMg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA578DF59;
	Fri, 31 Oct 2025 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899777; cv=none; b=CDYXhPEAC3ttoRfTbq9LowYP69FOYXsm2PV6fTwJoKjnOCoLlU3f//X6ipCb0dDLmCQWY8LGaipD7DjfXSq4AuxvHAj7GZctmrnyekHB1UTNEEjiQoU5UF/VA7sMIqXN59hCy9ZyQszwFRkc948F/tbNk1KzxcmGQzB4Gj1ilw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899777; c=relaxed/simple;
	bh=Nx7zVNS1vjKGvEyYcqY9qSwj4mu6QiBOxd85u7jmiQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6LmA3Q+HX8IWql9p9zjGLxq3vpJZUakxtjzxuXSYw16w+YkZfrCeYrM36MfWnNwEkJkDoWVo5EezhBBP7A0fj6JQGb2h8zJNY/AEQBlgcYeGGgjsvuhLPIUDZYqFa2uefBM/FRIFgqj05l6c/NP9PC1HVfnMHm8nP9IqffGqWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DB+REZMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1566C4CEF8;
	Fri, 31 Oct 2025 08:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761899777;
	bh=Nx7zVNS1vjKGvEyYcqY9qSwj4mu6QiBOxd85u7jmiQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DB+REZMguC0RGfpKJBoX+sOgdcIi5yciIlZIxO5NxQ2mVNyBQW9mXbO1v7xcjyfm/
	 w8Bg2yVAzmmOEbt+/hkBBkl4ZurTPtxBiqblO+JZoh7dunXkUEpnG/3MQ6BVEDoyTS
	 PIfxNd0NLxnmLH6IG0YnjgRLCBYbkXlIw9C6bV28AQ8o13ULg0unlpsJOmdlUU72dD
	 7TTIF/yUIJt1sb628+EWRPk5KwytqYverSAvRnke86/lZPBok1k1Mi4oTgXV/Rxjnc
	 3QFS9RncRXyshpnHTskdxE6OFbLzimD+B/SshEmJDRd9YD0BzGvdV3QrZhW1iLSQPK
	 2H2LSV8a7jbrg==
Date: Fri, 31 Oct 2025 14:06:05 +0530
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
Subject: Re: [PATCH v1 1/2] PCI: dw-rockchip: Add remove callback for
 resource cleanup
Message-ID: <b2micr4atfax2sgolsublmjk4kwvbmdnqjlk2lb7cflzeycm5i@bi62lg75ilo6>
References: <20251027145602.199154-1-linux.amoon@gmail.com>
 <20251027145602.199154-2-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251027145602.199154-2-linux.amoon@gmail.com>

On Mon, Oct 27, 2025 at 08:25:29PM +0530, Anand Moon wrote:
> Introduce a .remove() callback to the Rockchip DesignWare PCIe
> controller driver to ensure proper resource deinitialization during
> device removal. This includes disabling clocks and deinitializing the
> PCIe PHY.
> 

How can you remove a driver that is only built-in? You are just sending some
pointless patches that were not tested and does not make sense at all.

Please stop wasting others time.

- Mani

> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 87dd2dd188b4..b878ae8e2b3e 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -717,6 +717,16 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static void rockchip_pcie_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
> +
> +	/* Perform other cleanups as necessary */
> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> +	rockchip_pcie_phy_deinit(rockchip);
> +}
> +
>  static const struct rockchip_pcie_of_data rockchip_pcie_rc_of_data_rk3568 = {
>  	.mode = DW_PCIE_RC_TYPE,
>  };
> @@ -754,5 +764,6 @@ static struct platform_driver rockchip_pcie_driver = {
>  		.suppress_bind_attrs = true,
>  	},
>  	.probe = rockchip_pcie_probe,
> +	.remove = rockchip_pcie_remove,
>  };
>  builtin_platform_driver(rockchip_pcie_driver);
> -- 
> 2.50.1
> 

-- 
மணிவண்ணன் சதாசிவம்

