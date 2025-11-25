Return-Path: <linux-pci+bounces-42010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 799F5C836BD
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 06:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389713AC5D3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 05:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F072853F2;
	Tue, 25 Nov 2025 05:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fbd5tE9i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FE71E505;
	Tue, 25 Nov 2025 05:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764050116; cv=none; b=Y8Im1fkfSeZTSFFJyhFrMDpS1xqT8+TLOeKZsxXmGDo+PYiu3PsK5+Az9/zWpfx7ja7eEBk5R1tKyGI1lEsDgtsBcCHxJQZ2we4gYGZ+RVoyRxuJFsgt0WnnkBBstAwt08P45/TXuCQslCIis+nPdcdWQLTd75n5shJdrT43d6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764050116; c=relaxed/simple;
	bh=rA9BHtL3nqhfc287zBfkO4xgdFj0p+s9iU73udPzvYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4YnEGXc/ppeT8r/d71Yn6o/+yx8iiIOLIyyWURDsBapLEKLoxL8grDWzbt+bffi0pjYELmSabs/xijdqtwdIve9iASA/zhrzVtHzaGPJ/ra2dcoT85Wx45YbQJPZTMIUbyMt829TqnYzpk7pdlomsRh0fcicpnsqbgH7OFLBPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fbd5tE9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743C4C4CEF1;
	Tue, 25 Nov 2025 05:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764050116;
	bh=rA9BHtL3nqhfc287zBfkO4xgdFj0p+s9iU73udPzvYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fbd5tE9iwStrG5mxJ1X1J0CCpCIUruggcB4YM1R38hFp33Z5WuSo0Aa6C8tnmKU7r
	 mRGIlya0E0WZl1EGKnjkH5Jsb6GancljzJKkl3MozuWTzgsPm+Lh4ggIdHG+JLUHHQ
	 tnEt/pH6bEofv+edhc6nEZr3ULMKaI5iYXCK5b6Ldk33h14qSNENMwIlKxrrqnMsDm
	 CPXyxTgq7T3q7d3pGO56ukaM4xySGni9zToqWN80hBhGDO+uI5MyGMgowqdiNHJOwZ
	 s5Eth/MKZCPfL6iTMAK0ij7/iwGTrjfZziI5EcDX+ogcxD9v2flR2jWW3KT88QnZyZ
	 HVWmEvQWhVxCA==
Date: Tue, 25 Nov 2025 11:25:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v8 5/6] arm64: dts: renesas: rzg3s-smarc: Enable PCIe
Message-ID: <vrtz6pumfpjyis5sez7iia37yyruizl2wz3vb4ojafww5hrjev@pmy5uiknetre>
References: <20251119143523.977085-1-claudiu.beznea.uj@bp.renesas.com>
 <20251119143523.977085-6-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251119143523.977085-6-claudiu.beznea.uj@bp.renesas.com>

On Wed, Nov 19, 2025 at 04:35:22PM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The RZ Smarc Carrier-II board has PCIe headers mounted on it. Enable PCIe
> support.
> 
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> 
> Changes in v8:
> - none
> 
> Changes in v7:
> - none
> 
> Changes in v6:
> - none
> 
> Changes in v5:
> - collected tags
> 
> Changes in v4:
> - none
> 
> Changes in v3:
> - collected tags
> 
> Changes in v2:
> - none
> 
>  arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
> index 5e044a4d0234..6e9e78aca0b0 100644
> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
> @@ -132,6 +132,12 @@ power-monitor@44 {
>  	};
>  };
>  
> +&pcie {
> +	pinctrl-0 = <&pcie_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
>  &pinctrl {
>  	audio_clock_pins: audio-clock {
>  		pins = "AUDIO_CLK1", "AUDIO_CLK2";
> @@ -159,6 +165,11 @@ key-3-gpio-hog {
>  		line-name = "key-3-gpio-irq";
>  	};
>  
> +	pcie_pins: pcie {
> +		pinmux = <RZG2L_PORT_PINMUX(13, 2, 2)>, /* PCIE_RST_OUT_B */
> +			 <RZG2L_PORT_PINMUX(13, 3, 2)>; /* PCIE_CLKREQ_B */
> +	};
> +
>  	scif0_pins: scif0 {
>  		pinmux = <RZG2L_PORT_PINMUX(6, 3, 1)>, /* RXD */
>  			 <RZG2L_PORT_PINMUX(6, 4, 1)>; /* TXD */
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

