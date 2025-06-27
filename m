Return-Path: <linux-pci+bounces-30975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 677CAAEC1C7
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 23:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641791C43D4D
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 21:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2549F25D209;
	Fri, 27 Jun 2025 21:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNaU10tM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E7525CC57;
	Fri, 27 Jun 2025 21:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751059043; cv=none; b=SfEkNOGsf0d912pYAFhjL1A/JdWlNbzyQq1WyLDua1iCSXXviERuQ8gjdQKrF/HaDEv6EUHKZnATRVLgz14y5OEHbNxas3ySdVk/TbLKyz4++mP6QrOMXmt/TMbkTdIpWqHtaBLutnINzAcG1XBDnZwIpM7MJ4cqb4m4+xFtFO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751059043; c=relaxed/simple;
	bh=+EQCIEgsXVvxKsrT0WsXUC8n/w8gjOICwEyTeNeHuEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6O8n/iYXTpX2qUYMJaXflwmVowZ538bkM6nvAMcUYOb457SiisWXmH+DnuOdx8RwLZQn5uWaoxN4q15/fANlWt4aigYbflE+XSI8zLg7v4PSptV99uY50FkEyFFWQ2NfvUvoWKyeqDVsjZBW8re05ZxALnDNO2wERqtUIZPshg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNaU10tM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DC6C4CEE3;
	Fri, 27 Jun 2025 21:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751059042;
	bh=+EQCIEgsXVvxKsrT0WsXUC8n/w8gjOICwEyTeNeHuEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hNaU10tMhAYo5UGed+PugNq2z2uaOfR4n1dTptlDOnYNO+dZPouJG4Yi7JMSza6/s
	 5D2HmCiksnZI3k3NKS68X0f5iat0pazkWRJnz8gf1+Rcp7/UAm6I5KQTZOlSTS84xH
	 OjVKx7cbnQkX6Pgb5ZUZ4iOIJHfR39ZGpkfpqHuRiUoNFcYcIQmZA9iXzolCFVimNF
	 LGAuVl93HL2WhaFtdwepQfKOkkKVzCyrnCVBYlAlIaZfwwm0LHIpxcNaZHFw7iA0pG
	 A3iY4sGQpWrYP1xzEFUo2NUEIOTmjxZNoa5tFG8DLBTiJCm+yipFuAXaxh4k2MRtrC
	 iMob9UwH57Utg==
Date: Fri, 27 Jun 2025 16:17:21 -0500
From: Rob Herring <robh@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-fsd@tesla.com,
	manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org,
	kw@linux.com, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com,
	pankaj.dubey@samsung.com
Subject: Re: [PATCH v2 07/10] dt-bindings: phy: Add PHY bindings support for
 FSD SoC
Message-ID: <20250627211721.GA153863-robh@kernel.org>
References: <20250625165229.3458-1-shradha.t@samsung.com>
 <CGME20250625165319epcas5p3721c19f6e6b482438c62dd1ef784de03@epcas5p3.samsung.com>
 <20250625165229.3458-8-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625165229.3458-8-shradha.t@samsung.com>

On Wed, Jun 25, 2025 at 10:22:26PM +0530, Shradha Todi wrote:
> Document PHY device tree bindings for Tesla FSD SoCs.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  .../bindings/phy/samsung,exynos-pcie-phy.yaml | 25 +++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
> index 41df8bb08ff7..4dc20156cdde 100644
> --- a/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
> @@ -15,10 +15,13 @@ properties:
>      const: 0
>  
>    compatible:
> -    const: samsung,exynos5433-pcie-phy
> +    enum:
> +      - samsung,exynos5433-pcie-phy
> +      - tesla,fsd-pcie-phy
>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>  
>    samsung,pmu-syscon:
>      $ref: /schemas/types.yaml#/definitions/phandle
> @@ -30,6 +33,24 @@ properties:
>      description: phandle for FSYS sysreg interface, used to control
>                   sysreg registers bits for PCIe PHY
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - tesla,fsd-pcie-phy
> +    then:
> +      description:
> +        The PHY controller nodes are represented in the aliases node
> +        using the following format 'pciephy{n}'. Depending on whether
> +        n is 0 or 1, the phy init sequence is chosen.

What? Don't make up your own aliases.

If the PHY instances are different, then maybe you need a different 
compatible. If this is just selecting the PHY mode, you can do that in 
PHY cells as the mode depends on the consumer.


> +      properties:
> +        reg:
> +          items:
> +            - description: PHY
> +            - description: PCS

else:
  properties:
    reg:
      maxItems: 1

> +
>  required:
>    - "#phy-cells"
>    - compatible
> -- 
> 2.49.0
> 

