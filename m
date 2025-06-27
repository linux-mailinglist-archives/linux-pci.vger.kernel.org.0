Return-Path: <linux-pci+bounces-30972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CC9AEC0B3
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 22:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF8C27B455D
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 20:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05A02EBDE5;
	Fri, 27 Jun 2025 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oS8WYC9x"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E8F20B80B;
	Fri, 27 Jun 2025 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751055115; cv=none; b=eq3Vian8Tb95FmUQpHmRo/RwVWsBVAZ68MS8Eo0cDAOvMudmZbXQntdUR+JXIHgT3Y6g+1ljOVRh7QIWDgFRztvjaiw1s0h8+qmj7vYFozrWh9SO/lJGyRNdcxzMPyzySiYsX79dai0V89stl70GH1s7tqEhMHOb33eCm4zaEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751055115; c=relaxed/simple;
	bh=j480d8kCKmPEv/s1I085hF2TgeZLCw2SbopKfGFaiCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/bdynyJeJ/xjEnN47WrIz8vPZZaXFT5KUL3+6dFPvi5OpamcOluC+ecQvLi1GetFCAo+txBvKAQfuECGy56e1swocyS90U3VebQKMP6MMMDL9J0Q3DOOgYTZrQ/lUk7lrjNNQ9Yp9E0opgd0V7/eD2t6J+4E/0kzZuoAeJclSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oS8WYC9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E32C4CEE3;
	Fri, 27 Jun 2025 20:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751055113;
	bh=j480d8kCKmPEv/s1I085hF2TgeZLCw2SbopKfGFaiCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oS8WYC9x/7XhB5hLSlEiIiX+fhE4IFlUON6lQtVaHwQKQqTI/neox5yvPgnmoHIDU
	 BPZjNf6mASLzwlTkMLu6Q+3K0TNkeeUQyp1/CbH5aJ1IVNGg1QbgXvOZRRHua9FewX
	 p5vzDP4GoiK6VczT2MuY8ldfpKNb1ZuS5zDqLmHM0wkJn0NkM9tNyapWTy7L9b7DRF
	 DgnPmwybwvVD39nIvbfjS3sh/80OkM0A9fOx9v2rJnP41n0h3ScdbwNvV8NM3W0BKn
	 FqaLVTTGyNm4FQVl9a1R4Ndt8w8qG+91ijqc2TYb9wsuXkpRrOUmDJIalXECE+d4QP
	 bTJoZ7iqO6ykA==
Date: Fri, 27 Jun 2025 15:11:52 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jianjun.wang@mediatek.com, ryder.lee@mediatek.com, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org,
	manivannan.sadhasivam@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v1 2/3] dt-bindings: PCI: mediatek-gen3: Add support for
 MT6991/MT8196
Message-ID: <20250627201152.GA4114099-robh@kernel.org>
References: <20250623120058.109036-1-angelogioacchino.delregno@collabora.com>
 <20250623120058.109036-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623120058.109036-3-angelogioacchino.delregno@collabora.com>

On Mon, Jun 23, 2025 at 02:00:57PM +0200, AngeloGioacchino Del Regno wrote:
> Add compatible strings for MT8196 and MT6991 (which are fully
> compatible between each other) and clock definitions.
> 
> These new SoCs don't have tl_96m and tl_32k clocks, but need
> an AHB to APB bus clock and a low power clock.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml      | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 162406e0691a..02cddf0246ce 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -52,7 +52,12 @@ properties:
>                - mediatek,mt8188-pcie
>                - mediatek,mt8195-pcie
>            - const: mediatek,mt8192-pcie
> +      - items:
> +          - enum:
> +              - mediatek,mt6991-pcie
> +          - const: mediatek,mt8196-pcie
>        - const: mediatek,mt8192-pcie
> +      - const: mediatek,mt8196-pcie
>        - const: airoha,en7581-pcie
>  
>    reg:
> @@ -212,6 +217,36 @@ allOf:
>  
>          mediatek,pbus-csr: false
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8196-pcie
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 6
> +
> +        clock-names:
> +          items:
> +            - const: pl_250m
> +            - const: tl_26m
> +            - const: bus
> +            - const: low_power
> +            - const: peri_26m
> +            - const: peri_mem
> +
> +        resets:
> +          minItems: 1

The min is already 1.

> +          maxItems: 2
> +
> +        reset-names:
> +          minItems: 1
> +          maxItems: 2

It would be good to define what the names are. I assume they are fixed 
and not just any of the allowed ones.

> +
> +        mediatek,pbus-csr: false
> +
>    - if:
>        properties:
>          compatible:
> -- 
> 2.49.0
> 

