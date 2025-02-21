Return-Path: <linux-pci+bounces-22019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7916A3FE62
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 19:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32228420709
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 18:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE33250C15;
	Fri, 21 Feb 2025 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3iEDAtA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CFD250BFC;
	Fri, 21 Feb 2025 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161373; cv=none; b=TCvCbui/9zCNoyqEHRFJi+fxZ7lnkP9prLTxmaFL5SAhTPX0GUkThBoImJtKY7N/m8fzBF1Zna308fjAIbdZqwUd1OyWHtV91vg6q1lv0g1aGAcLtnv7Kejm6ctDFqkQ7+XPAPrCBRunHpVXM6Y2BZo88GfWPV7n7jWqa5pHw5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161373; c=relaxed/simple;
	bh=aVbsiWoZIxApCz2+QDbMVPPTpsz8VI9s1WvBplvWgnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPwhA3ugt5/UYlOaQ+flg6DIk5P8QNsdqSMzT5Md7yL+h5GM6nTH60A7qQxqoixwPgbLF9dDqjRFfvRlXu/Ro53rNn9oYEQSPR485eKs/5c56waXmW64v55PlSAgRJpwhG2dh2O7I1MNBr3A8/RAI4mDIeGNZUXqNPPy79lZ3ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3iEDAtA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53646C4CED6;
	Fri, 21 Feb 2025 18:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740161373;
	bh=aVbsiWoZIxApCz2+QDbMVPPTpsz8VI9s1WvBplvWgnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i3iEDAtAb3sWgbFkRzw96L67Iy7ScCx9rrNiXjqM+kl7dui2AxBQK1D8jJbcqp2BJ
	 Msy21ZxDF47a7kXRcIMrl5FLUx8l+0iJ6zkZ5zIvjHQ7bC//lzYKvl8dwrFsYgqS6a
	 gG1lsP0GqJwR4WCnDDg1zHtz0sfAJbO9K3NW6aLjJrE4u4l2CgjMbrc77LCgw+4wcq
	 CC5wtXQG0JaUjjcZr0SVfK27iWMVpFesAUAD1Vun2i2pXphUs/shbORkFMaYyrVYBF
	 j+FbQY6EmwJxTTLCTzrqffQMngRENy64bvxpA4JT+De3KmmibK+HEQoH+1weKxb7g5
	 VXa9EpXJI+vjA==
Date: Fri, 21 Feb 2025 12:09:30 -0600
From: Rob Herring <robh@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org,
	Simon Xue <xxm@rock-chips.com>, Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v6 1/2] dt-bindings: PCI: dw: rockchip: Add rk3576
 support
Message-ID: <20250221180930.GA3486559-robh@kernel.org>
References: <20250221104357.1514128-1-kever.yang@rock-chips.com>
 <20250221104357.1514128-2-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221104357.1514128-2-kever.yang@rock-chips.com>

On Fri, Feb 21, 2025 at 06:43:56PM +0800, Kever Yang wrote:
> rk3576 is using dwc controller, with msi interrupt directly to gic instead
> of to gic its, so
> - no its support is required and the 'msi-map' is not need anymore,
> - a new 'msi' interrupt is needed.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v6:
> - Fix make dt_binding_check and make CHECK_DTBS=y
> 
> Changes in v5:
> - Add constraints per device for interrupt-names due to the interrupt is
> different from rk3588.
> 
> Changes in v4:
> - Fix wrong indentation in dt_binding_check report by Rob
> 
> Changes in v3:
> - Fix dtb check broken on rk3588
> - Update commit message
> 
> Changes in v2:
> - remove required 'msi-map'
> - add interrupt name 'msi'
> 
>  .../bindings/pci/rockchip-dw-pcie-common.yaml | 59 +++++++++++++++----
>  .../bindings/pci/rockchip-dw-pcie.yaml        |  4 +-
>  2 files changed, 50 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> index cc9adfc7611c..069eb267c0bb 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> @@ -64,6 +64,10 @@ properties:
>            interrupts - aer_rc_err, aer_rc_err_msi, rx_cpl_timeout,
>            tx_cpl_timeout, cor_err_sent, nf_err_sent, f_err_sent, cor_err_rx,
>            nf_err_rx, f_err_rx, radm_qoverflow
> +      - description:
> +          Combinded MSI line interrupt, which is to support MSI interrupts
> +          output to GIC controller via GIC SPI interrupt instead of GIC its
> +          interrupt.
>        - description:
>            eDMA write channel 0 interrupt
>        - description:
> @@ -75,16 +79,6 @@ properties:
>  
>    interrupt-names:
>      minItems: 5
> -    items:

You just made the max 5 by dropping this.

> -      - const: sys
> -      - const: pmc
> -      - const: msg
> -      - const: legacy
> -      - const: err
> -      - const: dma0

Make this 'enum: [ dma0, msi ]'

Yeah, that would allow the wrong one to be used, but I prefer that over 
duplicating the names.

> -      - const: dma1
> -      - const: dma2
> -      - const: dma3
>  
>    num-lanes: true
>  
> @@ -123,4 +117,49 @@ required:
>  
>  additionalProperties: true
>  
> +anyOf:

allOf

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,rk3568-pcie
> +              - rockchip,rk3588-pcie
> +              - rockchip,rk3588-pcie-ep
> +    then:
> +      properties:
> +        interrupt-names:
> +          minItems: 5

That's already the min.

> +          type: array

Don't need type. Do you see any schema use 'type: array' outside of the 
core? 

> +          items:
> +            - const: sys
> +            - const: pmc
> +            - const: msg
> +            - const: legacy
> +            - const: err
> +            - const: dma0
> +            - const: dma1
> +            - const: dma2
> +            - const: dma3

The whole if/then can be dropped.

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,rk3576-pcie
> +    then:
> +      properties:
> +        interrupt-names:
> +          type: array
> +          items:
> +            - const: sys
> +            - const: pmc
> +            - const: msg
> +            - const: legacy
> +            - const: err
> +            - const: msi

Don't need type or items. Just this is enough to ensure 'msi' is used:

contains:
  const: msi

> +          minItems: 6
> +          maxItems: 6

This part is correct.

> +
>  ...
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> index 550d8a684af3..9a464731fa4a 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> @@ -26,6 +26,7 @@ properties:
>        - const: rockchip,rk3568-pcie
>        - items:
>            - enum:
> +              - rockchip,rk3576-pcie
>                - rockchip,rk3588-pcie
>            - const: rockchip,rk3568-pcie
>  
> @@ -71,9 +72,6 @@ properties:
>  
>    vpcie3v3-supply: true
>  
> -required:
> -  - msi-map

This should be moved to an if/then schema, not just dropped. Unless it 
was wrong for the existing users. If so, then that's a separate patch.

> -
>  unevaluatedProperties: false
>  
>  examples:
> -- 
> 2.25.1
> 

