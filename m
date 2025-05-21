Return-Path: <linux-pci+bounces-28184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DACABEFF6
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 11:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6BD4E3AC4
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 09:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700982472B1;
	Wed, 21 May 2025 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="limWBBwd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4104F24167F;
	Wed, 21 May 2025 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820007; cv=none; b=EkpF2TZaEKIyNkGeTUJaSzXY2q1Mxga1DONBRQRmdvoMu1uNbVwpqqLHnZTGAOeT0E4AbpnXcO95FuUpGETvO9of3GCk3ZnRJCsNDHxT4ruNrM/SZ1Sq6jcj3UXOEBFLTn6gxADM1ScHU78tQYz2AJh+UxUHJSZhncaXQ6HUkOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820007; c=relaxed/simple;
	bh=LO1Ga9BqywoKA5/tkG4lU/4FfpBVnRF8ud6CdXRAeEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VW7trVLW7aKYfQ7ovNOskcxd40DC8KtCmcGdcpeC/LZh2qAGDlyTPzY69aCIl+XT1vu3FtChyxvbQmWWbwDMJLvSMOZ+/kVHViVerhbBwSs49uyt2wG7e3C1u4SLqnIDq+RaK0z25Jz+7Z+3mGjJfM79ulI7+AexZUj/uJuKsSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=limWBBwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16532C4CEE4;
	Wed, 21 May 2025 09:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747820006;
	bh=LO1Ga9BqywoKA5/tkG4lU/4FfpBVnRF8ud6CdXRAeEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=limWBBwdIVKd11QilI9brElBRTvN1t8GNaQ/k6R8ky+uF0CoAvdxsuzcB3K1+yTVE
	 ZPZMhNiJ5QtsNy9lKxOQG3PsD26LeEFNG1KIDtFASu9YVtEcvjmy37Armt85fk+gBR
	 TOjBfvjURC0z9iZytH1o7eBmzEZpJ9CD+JKwfXmRjvRk5NK/+QH0Y9UHH0107SKQZR
	 bczqbsEAM95KOPNVf9iWMQbGp29Gyu3Pxhky9or877ayyRY4S3Yb45xoynnGP+BqMN
	 EcA28eLeGe0cB4fbCmJPNkV6lxOwCq/hYZss64SKRHeYD2HrY70hpBueE+OlTU30lp
	 KeLTNdYHSfqJQ==
Date: Wed, 21 May 2025 11:33:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.or, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com, 
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com, vkoul@kernel.org, 
	kishon@kernel.org, arnd@arndb.de, m.szyprowski@samsung.com, jh80.chung@samsung.com
Subject: Re: [PATCH 07/10] dt-bindings: phy: Add PHY bindings support for FSD
 SoC
Message-ID: <20250521-quirky-tanuki-of-tact-a79b86@kuoka>
References: <20250518193152.63476-1-shradha.t@samsung.com>
 <CGME20250518193252epcas5p3e4d1d329f1e5616e842801ceb26728b6@epcas5p3.samsung.com>
 <20250518193152.63476-8-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250518193152.63476-8-shradha.t@samsung.com>

On Mon, May 19, 2025 at 01:01:49AM GMT, Shradha Todi wrote:
> Document PHY device tree bindings for Tesla FSD SoCs.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  .../devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml  | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
> index 41df8bb08ff7..3a5bff0fb82d 100644
> --- a/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
> @@ -15,10 +15,14 @@ properties:
>      const: 0
>  
>    compatible:
> -    const: samsung,exynos5433-pcie-phy
> +    oneOf:

Drop, that's just enumm unless you already add here more?

> +      - enum:
> +          - samsung,exynos5433-pcie-phy
> +          - tesla,fsd-pcie-phy
>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2

You need to list the items and constrain existing variants. I do not get
why exynos5433 gets now two MMIO ranges.

Best regards,
Krzysztof


