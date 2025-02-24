Return-Path: <linux-pci+bounces-22179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6B7A4193B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 10:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 346227A1242
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 09:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB711D90DF;
	Mon, 24 Feb 2025 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNHwsTSP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C244A1946B8;
	Mon, 24 Feb 2025 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740389313; cv=none; b=kvm7C3p5Anuna9occdmYLYoMPFvGAWE9TEpRveAd94xglrd4KbNHRh9gYk1VCr77SMMC7cA/whMEDR8NCl3NVIwAkm4GbVjV84Z0cUv9ujTdWgrsUzsdaATCZm8bw11UMX1cp2pkiudvuq/TiYzxdM7mJ5g2UFdYa1jpBbB5Czs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740389313; c=relaxed/simple;
	bh=aMQo00Bw8GVTaJOzwAkgnTY3DGHFCoHqKBTGnM3Nqnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B76ORFoxr9YP6dsLJe+ZR8yc7ugOjeVqZ4BzhwMaOiRnS8Dpu6ooceC5Zl7kKZGz74yPV/YHfNWXDYuAJ0xLmOCap4SPMTOxuKUVqWfOlTdSAKQ+WnDSDYuPrqTCxchJJtqCUBS+BA068jgEGBDiE467ampblJ+vdmWFpdpCMRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNHwsTSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86498C4CEE8;
	Mon, 24 Feb 2025 09:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740389313;
	bh=aMQo00Bw8GVTaJOzwAkgnTY3DGHFCoHqKBTGnM3Nqnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CNHwsTSPhRtUDIeanKBFmigKrR5ixtkJusf+tCsGrZTe19jvOEoe84JN8S1/8fv3C
	 iJKe7W9jzNmFkxPTNsI1jVfDf3VbJdq2jBwv3pxAnceNsfAyKd4/V59kj8ZiCYGGWK
	 D9Mgiyul9Zh4ziIlA9fPHwiRWIUb4omZZZgNqOEoVFkir2hUY67DuQCIjlCdTtHuBZ
	 vu8ZkTW49WbzoL37HIJUcvwwcFa2W3biZPhK4vJK3f8+xdfd3AXOC5bEF1Yb7F64Gr
	 9ij553I2lVVnIPczGWTx60+lWuTiJLDWxach7DVHbU81ZMcxB7FRZo9xUdu124A9G1
	 dbxh8GMGFuKIQ==
Date: Mon, 24 Feb 2025 10:28:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Simon Xue <xxm@rock-chips.com>, 
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/2] dt-bindings: PCI: dw: rockchip: Add rk3576 support
Message-ID: <20250224-gifted-piculet-of-amplitude-a91ecd@krzk-bin>
References: <20250224074928.2005744-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224074928.2005744-1-kever.yang@rock-chips.com>

On Mon, Feb 24, 2025 at 03:49:27PM +0800, Kever Yang wrote:
> rk3576 is using DWC PCIe controller, with msi interrupt directly to GIC
> instead of using GIC ITS, so
> - no ITS support is required and the 'msi-map' is not required,
> - a new 'msi' interrupt is needed.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
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
>  .../bindings/pci/rockchip-dw-pcie-common.yaml | 41 ++++++++++++++++++-
>  .../bindings/pci/rockchip-dw-pcie.yaml        | 19 ++++++---
>  2 files changed, 52 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> index cc9adfc7611c..e1ca8e2f35fe 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> @@ -65,7 +65,11 @@ properties:
>            tx_cpl_timeout, cor_err_sent, nf_err_sent, f_err_sent, cor_err_rx,
>            nf_err_rx, f_err_rx, radm_qoverflow
>        - description:
> -          eDMA write channel 0 interrupt
> +          If the matching interrupt name is "msi", then this is the combinded
> +          MSI line interrupt, which is to support MSI interrupts output to GIC
> +          controller via GIC SPI interrupt instead of GIC its interrupt.
> +          If the matching interrupt name is "dma0", then this is the eDMA write
> +          channel 0 interrupt.
>        - description:
>            eDMA write channel 1 interrupt
>        - description:
> @@ -81,7 +85,9 @@ properties:
>        - const: msg
>        - const: legacy
>        - const: err
> -      - const: dma0
> +      - enum:
> +          - msi
> +          - dma0
>        - const: dma1
>        - const: dma2
>        - const: dma3
> @@ -123,4 +129,35 @@ required:
>  
>  additionalProperties: true
>  
> +anyOf:

There is never syntax like that. Where did you find it (so we can fix
it)?

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3576-pcie

This does not belong to common schema, but to device specific. I don't
see this compatible in this common schema at all.


> +    then:
> +      properties:

interrupts:
  minItems: 6
  maxItems: 6

> +        interrupt-names:
> +          items:
> +            - const: sys
> +            - const: pmc
> +            - const: msg
> +            - const: legacy
> +            - const: err

Best regards,
Krzysztof


