Return-Path: <linux-pci+bounces-25288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 630C7A7BA19
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 11:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98E71896B5D
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 09:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52831ACED9;
	Fri,  4 Apr 2025 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="rM36v9Pe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090FE1A23BC;
	Fri,  4 Apr 2025 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743759707; cv=none; b=h2FbJflPeNoohx1M0jgIAs/x0xKXLlasMbs+AjAgKTxwhl6kNS41Oh+xSAF/8Z1U24hSAeQBVjhM7XlasKqvILMMPSTSku6Z0yzYMAoyakfYF0zfEGenGVsJ7NWF+tgd3ovgpOs0qh5zRB3IIBz2YeKKkG05714Rev/nJ3QBoD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743759707; c=relaxed/simple;
	bh=g7W1dzfH6j/cA6crUWTfS8ZlKF2LjHCdHL+zKUojDQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtOsvNgzKyxFJYA7a6v+/SZftFt+4UHGEU8u3ftX0EHmr4NGqB2w8h1YHwCE3JJwCdTfe8tiK/3fmFYjTpwln9kIjHq4RO+bxtvCyhPAvzOCk9SfEUQt6VB3C8n+6zslN/sOHMZufjkCMfIS2ZajQ4d7pwZAQER1AopjOwUiiiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=rM36v9Pe; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 95D6D1F99A;
	Fri,  4 Apr 2025 11:41:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1743759695;
	bh=UkGhpRwbzS0VPnH1TZfEQLwmTd3JyghrN/O4RuEAQws=; h=From:To:Subject;
	b=rM36v9PegNSof5+k1AZosOO95S82pCG12s5H1kAQn3tvMp8p/k7+sdFmwvoIcpEaS
	 1EbZnOU2ZfcaZqcfLtZBw8uKWB7YMw5CxqhqkjwD/e7B7W2cZVnHNtYcUxBN/yEDXT
	 ZjK/wtatzssOVL3fNZiKn77aGX2jMRlVaBkDwFVpWd89csspEl8XuhjNxTbItmC4bN
	 XnNLLOci4o3SmrFY7wT53qthCWduaaSpyRrnXwyXRROOkoX9MUkAd6fKmQpiQI3wuy
	 czMP+IxxwbcgvQug+9IkreCSFe5iEU2j/cuPijpfjnhHE2xC07eRT2V1qybBr+9paj
	 Kk3OTqjOrMhrA==
Date: Fri, 4 Apr 2025 11:41:30 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/4] dt-bindings: imx6q-pcie: Add wake-gpios property
Message-ID: <20250404094130.GA35433@francesco-nb>
References: <20231213092850.1706042-1-sherry.sun@nxp.com>
 <20231213092850.1706042-3-sherry.sun@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213092850.1706042-3-sherry.sun@nxp.com>

Hello

On Wed, Dec 13, 2023 at 05:28:48PM +0800, Sherry Sun wrote:
> Add wake-gpios property that can be used to wakeup the host
> processor.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 81bbb8728f0f..fba757d937e1 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -72,6 +72,12 @@ properties:
>        L=operation state) (optional required).
>      type: boolean
>  
> +  wake-gpios:
> +    description: If present this property specifies WAKE# sideband signaling
> +      to implement wakeup functionality. This is an input GPIO pin for the Root
> +      Port mode here. Host drivers will wakeup the host using the IRQ
> +      corresponding to the passed GPIO.
> +

From what I know it is possible to share the same WAKE# signal for
multiple root ports. Is this going to work fine with this binding? Same
question on the driver.

We do have design exactly like that, so it's not a theoretical question.

Francesco



