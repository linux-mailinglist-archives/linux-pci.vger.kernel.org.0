Return-Path: <linux-pci+bounces-30999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE67AAEC724
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 14:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 112087A9E6E
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 12:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9842472AC;
	Sat, 28 Jun 2025 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQes4/p/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CE72F1FF1;
	Sat, 28 Jun 2025 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751114115; cv=none; b=ZKzLV8VdtEpR6Snp3zXPuZqFW8FcOk1ym9olWrCkQEFTl+bLk3TlC2gT5XsC4c9+kVdlCig/O4STQ/gpBCDP702c/AvXr6DMaoX37PLKGfmqJ3iZziTl9vDYd3SeP0mPaIKOjKLdj6AsK+o8IQM22/NF5jkSU5Uz052wcJRq/Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751114115; c=relaxed/simple;
	bh=CYSbec/13UMVZGeQLR3wotXbDDONkq50TGJNSWT436k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJkEbugklefdOPBizF9ifsvqSf9CbcbMz/mXrJNKcfOTW3V7kJEybaU9HDBE/Fh6eIBbYfRKEALzOzQok+bkPNbcZYKmOZo3+LflSajNao0hokR3IGUEmlacQWRtd71mTPDbN6FyOjbuD0/LIIj7trsNt9q4M6NiY9z5ZWSFUP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQes4/p/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B29C4CEEE;
	Sat, 28 Jun 2025 12:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751114114;
	bh=CYSbec/13UMVZGeQLR3wotXbDDONkq50TGJNSWT436k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQes4/p/zWhLH1vIXHJ6EYJpbnSlJLSKX/W5m/64aItzRchj+bmijLd8dzlHdxROI
	 RGK5yGDmHq+IAmK6Oalnz8tYvI6CIRQeta5xo201Osm0+0mbxn53f+l21VwneM+yHB
	 W2KBhvWhByAAh+gkbh9b3VQKzKngPYghy0Mma6VyvC3sT/SILYwaecpgpAtl6KRnP3
	 aT7zBPJlt8DjgOyxPPqzTWDV4P5Rarqb01+/jGIqVrJGYifcnazIAU5uZ2eRZlYkbM
	 gNyKySFC97O/+GwCOeID70B19CoifUoz9c8BvOrpI+2e2LlSUJcz8UAM1w5a5cVAEs
	 WXjgvbHj6jo+A==
Date: Sat, 28 Jun 2025 14:35:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-binding: pci-imx6: Add external reference
 clock mode support
Message-ID: <20250628-petite-fabulous-firefly-80a6f4@krzk-bin>
References: <20250626073804.3113757-1-hongxing.zhu@nxp.com>
 <20250626073804.3113757-3-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250626073804.3113757-3-hongxing.zhu@nxp.com>

On Thu, Jun 26, 2025 at 03:38:03PM +0800, Richard Zhu wrote:
> On i.MX, the PCIe reference clock might come from either internal
> system PLL or external clock source.
> Add the external reference clock source for reference clock.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index ca5f2970f217..a45876aba4da 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -219,7 +219,12 @@ allOf:
>              - const: pcie_bus
>              - const: pcie_phy
>              - const: pcie_aux
> -            - const: ref
> +            - description: PCIe reference clock.
> +              oneOf:
> +                - description: The controller might be configured clocking
> +                    coming in from either an internal system PLL or an
> +                    external clock source.
> +                  enum: [ref, extref]

NAK

As explained in other thread this is the same input and you just
call it differently.

Best regards,
Krzysztof


