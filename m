Return-Path: <linux-pci+bounces-25056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F4EA777EA
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 11:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2227169301
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 09:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678EE1EEA27;
	Tue,  1 Apr 2025 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="FqAE2REk"
X-Original-To: linux-pci@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAED1EEA4D
	for <linux-pci@vger.kernel.org>; Tue,  1 Apr 2025 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743500459; cv=none; b=OIEsKyC5+G6HAkM4acbwgKcPQiSf9YoxeGLKRk73/fdlSSFZombE2bJo0clLR3Va6lct0sn3NekKlYCZbVoYTeZmnwiCrdI2vPfqH7ch5QJEBasYUIhHPwPyovJ1f4LqA61QbGNXCGgMWWAod002bvqiUCgepEIcFUDDu1eFftA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743500459; c=relaxed/simple;
	bh=gJlB4AeSDCKsRK8ivWcHTRoN7YcHomioN5Bj+ipSUpI=;
	h=Date:Message-Id:From:To:Cc:In-Reply-To:Subject:References; b=tBMNHDgvHn1383hmHHb7P6/SMCcbUYiXrCF5FnWUFT6o1JRwQg3UscdYPfhIbJdVBaGVFwADksitiiWeOan7e9p/U8dOsPBU5tpzZ/EgukzaO1zWeHmmLZPZo53HSVPsXjEpAqwFTE5/FpqbTyV0kYpW7Jczen23jZtn96+IPhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=FqAE2REk; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 645a4459-0edd-11f0-b8e6-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 645a4459-0edd-11f0-b8e6-005056999439;
	Tue, 01 Apr 2025 11:40:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=subject:to:from:message-id:date;
	bh=ey7yoOjV/lc5KcZj4q45sCx1nDoy4AmcmcNqfQe/iX8=;
	b=FqAE2REkFgpO5l2/SNwlAFSrFOx/nu6RzHt2R1+ZsCDtBV69NLrvIrhuJGvE4fTGoK1ZmzxSNirSG
	 ZwHLUY0PHF1CINuzACJAO/SfbfazgI03XZ+WhebvUE+J8i2x+VGt66VoqcEVIgDgnAgtFNOFzKujzs
	 e3XICGWRWyabId09ZjxjE4SXaAKy/UrjoWYCmlGVs8xpAYan/LZSKBXRTbt/aSHuCqD6BmyFx4Yn4N
	 J13gtkyWN7M3vcaqKuYGngCJFovRXrHFS8bvLvcN7tgXgQivboaPq3m4gxtTZaT2Zkx6DSE90Ljgd8
	 rJkmMa+qi1t1I374U1YP5Y5vrb1gUxQ==
X-KPN-MID: 33|Q3Biel+nTqoBd3E8Ejl4/blQ1eotWFPRsXPh84eyXyVG8o/qGN/zkB/xVlQuHaH
 VetITMcREbJ3DnFIWK3u0glWOq0lwEsC5oKzxzT1vxGk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|W0d/KH2Hq4f/I/JXtohD/yi6JDISu5nftVLzXJnFRULuKq3Rc3Vn2VnYtkRYUy+
 oTF6eiBDYAmLq8KY2ELmrXA==
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 617e7e6a-0edd-11f0-97bf-00505699d6e5;
	Tue, 01 Apr 2025 11:40:44 +0200 (CEST)
Date: Tue, 01 Apr 2025 11:40:43 +0200
Message-Id: <87cydwxlr8.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, alyssa@rosenzweig.io, j@jannau.net,
	marcan@marcan.st, sven@svenpeter.dev, bhelgaas@google.com,
	lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org
In-Reply-To: <20250401091713.2765724-3-maz@kernel.org> (message from Marc
	Zyngier on Tue, 1 Apr 2025 10:17:02 +0100)
Subject: Re: [PATCH v3 02/13] dt-bindings: pci: apple,pcie: Add t6020 compatible string
References: <20250401091713.2765724-1-maz@kernel.org> <20250401091713.2765724-3-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Marc Zyngier <maz@kernel.org>
> Date: Tue,  1 Apr 2025 10:17:02 +0100
> 
> From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> 
> t6020 adds some register ranges compared to t8103, so requires
> a new compatible as well as the new PHY registers.
> 
> Thanks to Mark and Rob for their helpful suggestions in updating
> the binding.

Ah, that's how you do it!  Thanks Rob.

This matches the binding already in use for U-Boot and OpenBSD, so:

Reviewed-by: Mark Kettenis <mark.kettenis@xs4all.nl>

> Suggested-by: Mark Kettenis <mark.kettenis@xs4all.nl>
> Suggested-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Tested-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> [maz: added PHY registers, constraints]
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  .../devicetree/bindings/pci/apple,pcie.yaml   | 33 +++++++++++++++----
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> index c8775f9cb0713..c0852be04f6de 100644
> --- a/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> @@ -17,6 +17,10 @@ description: |
>    implements its root ports.  But the ATU found on most DesignWare
>    PCIe host bridges is absent.
>  
> +  On systems derived from T602x, the PHY registers are in a region
> +  separate from the port registers. In that case, there is one PHY
> +  register range per port register range.
> +
>    All root ports share a single ECAM space, but separate GPIOs are
>    used to take the PCI devices on those ports out of reset.  Therefore
>    the standard "reset-gpios" and "max-link-speed" properties appear on
> @@ -30,16 +34,18 @@ description: |
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - apple,t8103-pcie
> -          - apple,t8112-pcie
> -          - apple,t6000-pcie
> -      - const: apple,pcie
> +    oneOf:
> +      - items:
> +          - enum:
> +              - apple,t8103-pcie
> +              - apple,t8112-pcie
> +              - apple,t6000-pcie
> +          - const: apple,pcie
> +      - const: apple,t6020-pcie
>  
>    reg:
>      minItems: 3
> -    maxItems: 6
> +    maxItems: 10
>  
>    reg-names:
>      minItems: 3
> @@ -50,6 +56,10 @@ properties:
>        - const: port1
>        - const: port2
>        - const: port3
> +      - const: phy0
> +      - const: phy1
> +      - const: phy2
> +      - const: phy3
>  
>    ranges:
>      minItems: 2
> @@ -98,6 +108,15 @@ allOf:
>            maxItems: 5
>          interrupts:
>            maxItems: 3
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: apple,t6020-pcie
> +    then:
> +      properties:
> +        reg-names:
> +          minItems: 10
>  
>  examples:
>    - |
> -- 
> 2.39.2
> 
> 
> 

