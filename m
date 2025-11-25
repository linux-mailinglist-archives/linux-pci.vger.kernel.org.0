Return-Path: <linux-pci+bounces-42009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AF872C836B3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 06:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5704E34515D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 05:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D364828507B;
	Tue, 25 Nov 2025 05:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQA9qHjE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0B91E505;
	Tue, 25 Nov 2025 05:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764050087; cv=none; b=DCorGP77MykIfw4XQSIPkMjQ96wFgutC1PaVjRjI9V6ljPdH0WQAngwpzy4eE6eBvk/H+Vh82pBLBBHQtNF7QNV2SxWQ9pc6VuCNg6auEpoELW9spYf8+A47uCj9x2UeLqthQhdvEN5wy50wn9sVYb2/J9Uh7tTebmjH4km3Dc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764050087; c=relaxed/simple;
	bh=F6ewDs6AqKO2B0zcVJZ1WWLu58lpfE9MXIyeMPoFp9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tg/iWlGde28uo4qLGhep4wXBUSBnI9FW33yY2bq5gSZo8wn68oaDH/sLEt5TR/JGhDxa0NnRlPLsRoGFbYFy/Bcs1qfefnu7kp9TOhZavi3X9mUv2xxXEbj+TEF/zX3lLbzXiUVJAh2hB+mceINFrrM+f9reSSa1r3ADDgbrhNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQA9qHjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED81C4CEF1;
	Tue, 25 Nov 2025 05:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764050087;
	bh=F6ewDs6AqKO2B0zcVJZ1WWLu58lpfE9MXIyeMPoFp9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQA9qHjEpfaUhqloUmzr8uFBdzweIHzlZUNaY3Pw26w0/0LnblA7evDqSa8HffXll
	 QHS1kqdaNkSeZR2wk34nTpYy4/jKG4PFl+Yc3V1nXwJcK21K38KqWbe4YOsEmg7G8b
	 H5M9njgXgVklwh9ffpGQZ1cveVjQzuXstszwEmydOAIvZ1GDPcN1sAR1hAwzDSb7rH
	 yKruQXPXxCniZ2/gZE1HqnFfzo78l5I6qg1tOs54LbyatCYxjb5lDRX71GNG6498yX
	 /3xAob0JZptuev+EIr2H5jfnQSH3ZjXV5t7GwMxkRacuicFe6N7f0zSh9NLC5n6UkS
	 blOXCy0RBxKTA==
Date: Tue, 25 Nov 2025 11:24:34 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v8 4/6] arm64: dts: renesas: rzg3s-smarc-som: Add PCIe
 reference clock
Message-ID: <6hvsrtdxpm2ywwk7whaala3ynfdy4lo76epigxvn345ymormqf@bp3au24dwwud>
References: <20251119143523.977085-1-claudiu.beznea.uj@bp.renesas.com>
 <20251119143523.977085-5-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251119143523.977085-5-claudiu.beznea.uj@bp.renesas.com>

On Wed, Nov 19, 2025 at 04:35:21PM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Versa3 clock generator available on RZ/G3S SMARC Module provides the
> reference clock for SoC PCIe interface. Update the device tree to reflect
> this connection.
> 
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
> - collected tags
> 
> Changes in v5:
> - this patch is the result of dropping the updates to dma-ranges for
>   secure area and keeping only the remaining bits
> 
>  arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> index 39845faec894..b196f57fd551 100644
> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> @@ -172,6 +172,11 @@ a0 80 30 30 9c
>  	};
>  };
>  
> +&pcie_port0 {
> +	clocks = <&versa3 5>;
> +	clock-names = "ref";
> +};
> +
>  #if SW_CONFIG2 == SW_ON
>  /* SD0 slot */
>  &sdhi0 {
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

