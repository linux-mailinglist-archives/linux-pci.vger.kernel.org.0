Return-Path: <linux-pci+bounces-36706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD26DB92625
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 19:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E093A1905B89
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 17:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D17C313531;
	Mon, 22 Sep 2025 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByKyEGTi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483CE313523;
	Mon, 22 Sep 2025 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561494; cv=none; b=DsMdf7xwP7mzuIQn8zLmsP3G5q1eDWPeKdsXSmYtK17FZb4zU67D6F7/L9CZuEJ+zUu1WChntbnkNPHBsELI2EMj3749XFdv71KW4KjXANihMjYjyvdS4cwjJtdTi82VPzt/o5hEZk+dpsTa1qkdUe8WDN2fpzzFtPhuOGgPJaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561494; c=relaxed/simple;
	bh=7n91RXDPAxgH1q840XCue47m4bAyVbyVfAnh6yft++U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HT2qIp8eVzsRd7nm/Rgg4RvQ7h7tbW7N7uNiYIT33YHAo50dvSEFtautIMpG5BxSUnu/BxkCnptTWLbnGwa6iTl6/tXP6DW/wFkTJy224R+iKhwGZIEArLICwd5LpWXz8jcVH2aUljEFeYAyqkODehLX5VtC5LW0lIbG8yUxdvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByKyEGTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC0EC4CEF0;
	Mon, 22 Sep 2025 17:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758561493;
	bh=7n91RXDPAxgH1q840XCue47m4bAyVbyVfAnh6yft++U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ByKyEGTiZjs/nEy3Xzn/QKsdiFqIK/jEadu1pqoZ5vZGLCg+MfsnCiu9gaEf9kl6b
	 sZK68I/axPzRYCujKthTI//IXqGF5PpFZEuTkue+wUWS7MyUtfOJPVLWib01kMEb6G
	 sUETtL4ThYkyvjh2XZDBhW/FO/uzt+xE9Cwv3gZdckKKc2zsT8B4SnvhhY5vcsVY2H
	 dlbMtRcBCAw9g5hGmHTpms6o3QXkH9AaJBTQYzVbQyNZ03UenK6S39/yV6cYQolwnH
	 +4aM0+NuPv074cEDycBfVbVpmYfW4UPWVHTsjflNIECHo9mcqO1d2VP8VkNZ9oTHKc
	 QwuHIUOw2KN7w==
Date: Mon, 22 Sep 2025 12:18:12 -0500
From: Rob Herring <robh@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] dt-bindings: PCI: dwc: Add external reference
 clock input
Message-ID: <20250922171812.GA489088-robh@kernel.org>
References: <20250918032555.3987157-1-hongxing.zhu@nxp.com>
 <20250918032555.3987157-2-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918032555.3987157-2-hongxing.zhu@nxp.com>

On Thu, Sep 18, 2025 at 11:25:53AM +0800, Richard Zhu wrote:
> Add external reference clock input "extref" for a reference clock that
> comes from external crystal oscillator.

Sigh. A different subject on every version throws off my scripts... 
Perhaps slow down your pace of sending new versions.

See my comments on v5.

> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> index 34594972d8db..0134a759185e 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> @@ -105,6 +105,12 @@ properties:
>              define it with this name (for instance pipe, core and aux can
>              be connected to a single source of the periodic signal).
>            const: ref
> +        - description:
> +            Some dwc wrappers (like i.MX95 PCIes) have two reference clock
> +            inputs, one from an internal PLL, the other from an off-chip crystal
> +            oscillator. If present, 'extref' refers to a reference clock from
> +            an external oscillator.
> +          const: extref
>          - description:
>              Clock for the PHY registers interface. Originally this is
>              a PHY-viewport-based interface, but some platform may have
> -- 
> 2.37.1
> 

