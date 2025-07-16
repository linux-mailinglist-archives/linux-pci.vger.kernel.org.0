Return-Path: <linux-pci+bounces-32249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2974DB0707D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 10:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F10503097
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 08:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FE62EAB7B;
	Wed, 16 Jul 2025 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAsqApLd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E4F2EA470;
	Wed, 16 Jul 2025 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654479; cv=none; b=ILGuMJFrwcN5+uR2I2XEzdMYu6KG1hgiWilPbGNGxru8gIzN2uEeZafxYkbN+7x0Q7jzz2R4i+tLG+veWrTfCexM4saaZohvDZdOXGNSRJEFqSixWC3j5BJcYL4IaVcWlFyxh1m4k1aodU23t5o2rXncFg01L0VEvKweqOwb9t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654479; c=relaxed/simple;
	bh=AuNQsZ23rKXcpc01jPxb/MFPAjRIiFTOghWtUQwr16M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTwwTa3R7c9VTHtb0rV/sZE44E4QnG0H/bGBxFWpsN2W6q8D1lQ7Mj/lZC+fpWR31yjeVj0odDS6EX9U8LnSuFGIfp21NNKN5MfyGf5yy4q3r4UTvX1KhJdyxFmO+DPXy4NTyKDugzJVUpNU+2LXSuMDiVwrnm/N1e0Gvag9u/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAsqApLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C2CC4CEF6;
	Wed, 16 Jul 2025 08:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752654479;
	bh=AuNQsZ23rKXcpc01jPxb/MFPAjRIiFTOghWtUQwr16M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hAsqApLd7YMtfpyh7q9HBWLtpv59a+BdExG5ZbkY1W4xOPV2fgVn9Nnwmnh4o7VCh
	 wPurbQEYAmtPOoq/q0MzcifYKKUL4O7GC5HGXwSOrxAL66QQtsdM2iFdT2LB067sO3
	 jXO5zitGSt+jlv9t61SLlmqTGIbjQGjBMYdkLRhiR77iHuawbsKrRIOyCB2h4HwtnJ
	 C971yf7A03FuFngrET2q6LV/rG+uJ3AIBeoVsXtEgu73cdDexNVsl45vsyvY1cm1Cx
	 1hOETZh0jp4qnoKgGPnhlDVHT0yKDI8YTB3aqvLXIe1ULwV8jeygwnLlEB3PRFLDg2
	 adhk41lQTL0VQ==
Date: Wed, 16 Jul 2025 10:27:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org, p.zabel@pengutronix.de, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v2 04/10] dt-bindings: pinctrl: aspeed,ast2600-pinctrl:
 Add PCIe RC PERST# group
Message-ID: <20250716-provocative-worm-of-gallantry-3797f8@krzk-bin>
References: <20250715034320.2553837-1-jacky_chou@aspeedtech.com>
 <20250715034320.2553837-5-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250715034320.2553837-5-jacky_chou@aspeedtech.com>

On Tue, Jul 15, 2025 at 11:43:14AM +0800, Jacky Chou wrote:
> Add PCIe PERST# group to support for PCIe RC.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml     | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
> index 80974c46f3ef..5d7fbb1c72b7 100644
> --- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
> @@ -254,6 +254,7 @@ additionalProperties:
>          - WDTRST2
>          - WDTRST3
>          - WDTRST4
> +        - PCIERC1

What feedback Aspeed received about ordering lists? More than once?

Best regards,
Krzysztof


