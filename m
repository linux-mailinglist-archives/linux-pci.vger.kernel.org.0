Return-Path: <linux-pci+bounces-3492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B828562B6
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 13:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B571F24C2E
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 12:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411BB12BEB2;
	Thu, 15 Feb 2024 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6418sY/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1468412AAD0;
	Thu, 15 Feb 2024 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999035; cv=none; b=tAqSpEHxYbnFd6ieK5GJMXzy8QSEDd6qIWH+wzaiJ7by4i4n/y3d2IGiXXM4EF29kQ7ApRflHNRxihaF3ox8KDJ1eyOL1wdMRxJaecygdU9wSKR4O78byzjiFTwnt9lKHgBxZCrnAJ/QhxRPNP6aqiqUcy+hC8g+RpftsIcr0aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999035; c=relaxed/simple;
	bh=X+cpHChC0wGcaQ0N4qOfZYEM60I1r/cY+ZKYxnXTLIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7Om/9q/546Daw1iP2hZ1IXragWzvWHxfOWLQTM3kiEnyll4lWKqjBRpLAxrij8YOQfi48FyHWH+0g4d2qvyEtrSY2PGXukm11QXKam+8aDWYoZ6ZSfcUymOwt+jlpbJBTFnwfJ0S3ZQn+9N6VvY+R8zyBdg8BVbI/2dXIoNoqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6418sY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D007C433F1;
	Thu, 15 Feb 2024 12:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707999034;
	bh=X+cpHChC0wGcaQ0N4qOfZYEM60I1r/cY+ZKYxnXTLIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z6418sY/CB8xHWluKd5CO0ZXsXUNm09RpFOAF9mHwEVr5tQVEJasazIUYFkm5dCWY
	 uEUhI3Y0vofrylUtLZwWzVbE1+wP71k+VYtqulW9BKGAlMJ6kPj0cznABQPpzdP/c9
	 6lXcFapkrcqA9dkqE5bpXzeE5E6tUdHLDvzipDZkFK3FpTslkgY5iUnVlo3zbg+qnG
	 wVwBNwdoV6cM6/scGSbjS4qUx6IqMpOcFfA2wmZYQgqvxp+D9AAQpj0+uEQURLI2oy
	 TppILAPvRx6f62nveMQsH+xJXiJnvOgNJ6sPLPIwFddXaWjdNOylP7yJDjsWrrrl+7
	 39c9uxcTBHEig==
Date: Thu, 15 Feb 2024 06:10:31 -0600
From: Rob Herring <robh@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Nishanth Menon <nm@ti.com>, "Andrew F. Davis" <afd@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>
Subject: Re: [PATCH] dt-bindings: PCI: ti,am65: Fix remaining binding warnings
Message-ID: <20240215121031.GA3671826-robh@kernel.org>
References: <d0f251f4-1c9e-4ed2-b7df-5a7fda28fe4e@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0f251f4-1c9e-4ed2-b7df-5a7fda28fe4e@siemens.com>

On Thu, Feb 15, 2024 at 09:14:47AM +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This adds the missing num-viewport, phys and phy-name properties to the
> schema. Based on driver code, num-viewport is required for the root
> complex, phys are optional. Their number corresponds to the number of
> lanes. The AM65x supports up to 2 lanes.

This is DW controller, right? num-viewport shouldn't be required. The 
number of iATU entries is determined at runtime now. If it stays, it 
should be deprecated.

> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .../bindings/pci/ti,am65-pci-host.yaml        | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> index a20dccbafd94..cdd6834f6a6f 100644
> --- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> @@ -55,6 +55,20 @@ properties:
>  
>    dma-coherent: true
>  
> +  num-viewport:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  phys:
> +    description: per-lane PHYs
> +    minItems: 1
> +    maxItems: 2
> +
> +  phy-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      pattern: '^pcie-phy[0-9]+$'

0-1 only

> +
>  required:
>    - compatible
>    - reg
> @@ -74,6 +88,7 @@ then:
>      - dma-coherent
>      - power-domains
>      - msi-map
> +    - num-viewport
>  
>  unevaluatedProperties: false
>  
> @@ -98,9 +113,13 @@ examples:
>          ti,syscon-pcie-id = <&scm_conf 0x0210>;
>          ti,syscon-pcie-mode = <&scm_conf 0x4060>;
>          bus-range = <0x0 0xff>;
> +        num-viewport = <16>;
>          max-link-speed = <2>;
>          dma-coherent;
>          interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
>          msi-map = <0x0 &gic_its 0x0 0x10000>;
>          device_type = "pci";
> +        num-lanes = <1>;
> +        phys = <&serdes0 PHY_TYPE_PCIE 0>;
> +        phy-names = "pcie-phy0";
>      };
> -- 
> 2.35.3

