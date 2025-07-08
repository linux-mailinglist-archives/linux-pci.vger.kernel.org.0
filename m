Return-Path: <linux-pci+bounces-31697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E14AAFD394
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 18:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBA9170A19
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 16:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C1F2E49AF;
	Tue,  8 Jul 2025 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHpaHR0f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D1F1DB127;
	Tue,  8 Jul 2025 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993742; cv=none; b=XLHh0/bOcl3mGj8rU5bbe1nvB7Xdb+PorOy5gjEbhmS+FYk/TvtAkUzFPpLui1V9m59ytX/HN63MeW0DxO1U915lCA86aRtqJfPjaIVGfVQB1x74q2zqC4Fv84V77Yd8DFsRDbDmVbzoQ/idMv96SnEybD7Ow2yWHDoZ41PwCOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993742; c=relaxed/simple;
	bh=9SPb1rRg+3+y0YQTrg9m/lWRcSKvEJxMR3VbM/EFUUA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Prx+5ljX6Nsuim3epN7Jz/2bfr7TQFefNlr1/KqSbaS/pGoAxzyUSdgyOlOhbGkHBw3vqghTCdoBPizpxynNY5ZvA6nJ25e6u8aU8d9KmWhL+L7O4KP5ph/hEUOwHjZrt7uZKkdUSq5jTqeyssyeyxD7f7kkIbti4oYcDLD5+x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHpaHR0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB01BC4CEF0;
	Tue,  8 Jul 2025 16:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751993741;
	bh=9SPb1rRg+3+y0YQTrg9m/lWRcSKvEJxMR3VbM/EFUUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EHpaHR0ffbOEJLvutnq6EJZxTb4B+wsgE0ku2vZ6OGZue52AHZyXy4ClSNQErDb1A
	 e7wui51WfrOD1y6A/38rkoxGDfxsj3KGtcUIrWFw4rT54xVXMd0v6lBBxslKek1GyN
	 erhDuARC7u3/perdrZ31s7mVo0aRRtDORWHdjZlz0WzMWQdzaGGBoEORy61nJZxM15
	 H/hdHI+IikZEqweykpUhM393xWfSLHwKd/fLxdCxfEu6onms3cKXezc0x4pChK3OT0
	 iPaMKXcN0jjSwn+w/lhOPOEWidhO26xgsz6AzqZ2pfBY8BYZrkjJMyOYQzbCrw2n4u
	 36fkHlc7ThUQg==
Date: Tue, 8 Jul 2025 11:55:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
	catalin.marinas@arm.com, will@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de, lizhi.hou@amd.com,
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v3 7/9] arm64: dts: renesas: rzg3s-smarc-som: Update
 dma-ranges for PCIe
Message-ID: <20250708165540.GA2148533@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704161410.3931884-8-claudiu.beznea.uj@bp.renesas.com>

On Fri, Jul 04, 2025 at 07:14:07PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The first 128MB of memory is reserved on this board for secure area.
> Update the PCIe dma-ranges property to reflect this.

Can we include a sentence or two about what the "secure area" means?
I don't know how to connect this with anything in the driver.

> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v3:
> - collected tags
> 
> Changes in v2:
> - none, this patch is new
> 
>  arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> index 39845faec894..1b03820a6f02 100644
> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> @@ -214,6 +214,11 @@ &sdhi2 {
>  };
>  #endif
>  
> +&pcie {
> +	/* First 128MB is reserved for secure area. */
> +	dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;
> +};
> +
>  &pinctrl {
>  #if SW_CONFIG3 == SW_ON
>  	eth0-phy-irq-hog {
> -- 
> 2.43.0
> 

