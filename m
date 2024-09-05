Return-Path: <linux-pci+bounces-12805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB0696CF4D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 08:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA7B1C228CA
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 06:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272561714A8;
	Thu,  5 Sep 2024 06:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHNm/R6k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F073E8172D;
	Thu,  5 Sep 2024 06:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725517939; cv=none; b=lqnO9heRgIgRiwOAk9rr9I88DOg6xuCMxhf8Rhd8v3ibvxg8eLlmOkxlEPsuIPQZ1iMnTjSV2Poh/w4jIQfezjO0XMH7duxOYGgdk1ijZ95odqZq8v+vwXEt9DIKHcutDiPsmaP1okgE74WX6qdAJIh+TW8Pm4p+l1VyqVMgG3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725517939; c=relaxed/simple;
	bh=bswJI0INa4QP0cOD6yGYJrJgq5RpJomBx8ZpD0WO+jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYADfIWwpttqljLh2axk+wqF3KYuwT4DB0u6mCRBsGKAtmxtCDSlLYrBIc4hjI5yPtGgdBm84moMtie0+Br5WkqfEub5jw7bS1Wt7xa6Lk3o1mEDfpl7Ij4Sh+FbAMlxtqEy7a6UYtNrY+nIKKY6T1HWJQ9uQzeQkQc6HnhvDTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHNm/R6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5D6C4CEC4;
	Thu,  5 Sep 2024 06:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725517938;
	bh=bswJI0INa4QP0cOD6yGYJrJgq5RpJomBx8ZpD0WO+jM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VHNm/R6keVImrgjyT9SHPou0b3eQrjzYQusCfft71QGcv+qSAinstwpUt5SGRo8BG
	 IDNdwSeIeJ/PepplDf/vM1IcwkVZzwQtPtcyhACryyKG7KJnQGYBJ1XmevukMm++Al
	 YXKdL4xv235AXFXwJk7g3Gm1KJFPVH7gU12AG2JupDQSo/ghdc/SRo8hv+xvtHqADd
	 IIpVEYDnWttxbS8hffQS7IG38wOMBRm7OBYKT4WhfCWYfGCiKV/szzGS//G3+yOPAQ
	 BVYWFKyO8tdVhFiozKPIbrJt97QL8K14feyHnG2oajiAzjz43I4TV9W2uKzfImxKxv
	 ns30VYLjN/VUg==
Date: Thu, 5 Sep 2024 08:32:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Bao Cheng Su <baocheng.su@siemens.com>, 
	Hua Qian Li <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: PCI: ti,am65: Extend for use with PVU
Message-ID: <t2mqfu62xx5uztlintofp4pquv6jalzace6w5jpymyyarb2wmn@vvo23e4cmu57>
References: <cover.1725444016.git.jan.kiszka@siemens.com>
 <28d31a14fe9cc1867f023ebaddd6074459d15e40.1725444016.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <28d31a14fe9cc1867f023ebaddd6074459d15e40.1725444016.git.jan.kiszka@siemens.com>

On Wed, Sep 04, 2024 at 12:00:11PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> The PVU on the AM65 SoC is capable of restricting DMA from PCIe devices
> to specific regions of host memory. Add the optional property
> "memory-regions" to point to such regions of memory when PVU is used.
>=20
> Since the PVU deals with system physical addresses, utilizing the PVU
> with PCIe devices also requires setting up the VMAP registers to map the
> Requester ID of the PCIe device to the CBA Virtual ID, which in turn is
> mapped to the system physical address. Hence, describe the VMAP
> registers which are optionally unless the PVU shall used for PCIe.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
> CC: "Krzysztof Wilczy=C5=84ski" <kw@linux.com>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: linux-pci@vger.kernel.org
> ---
>  .../bindings/pci/ti,am65-pci-host.yaml        | 52 ++++++++++++++-----
>  1 file changed, 40 insertions(+), 12 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml =
b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> index 0a9d10532cc8..d8182bad92de 100644
> --- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> @@ -19,16 +19,6 @@ properties:
>        - ti,am654-pcie-rc
>        - ti,keystone-pcie
> =20
> -  reg:
> -    maxItems: 4
> -
> -  reg-names:
> -    items:
> -      - const: app
> -      - const: dbics
> -      - const: config
> -      - const: atu


Nothing improved here.

> -
>    interrupts:
>      maxItems: 1
> =20
> @@ -84,12 +74,48 @@ if:
>        enum:
>          - ti,am654-pcie-rc
>  then:
> +  properties:
> +    reg:
> +      minItems: 4
> +      maxItems: 6
> +
> +    reg-names:
> +      minItems: 4
> +      items:
> +        - const: app
> +        - const: dbics
> +        - const: config
> +        - const: atu
> +        - const: vmap_lp
> +        - const: vmap_hp
> +
> +    memory-region:
> +      minItems: 1

Missing maxItems

> +      description: |
> +        phandle to one or more restricted DMA pools to be used for all d=
evices
> +        behind this controller. The regions should be defined according =
to
> +        reserved-memory/shared-dma-pool.yaml.
> +      items:
> +        maxItems: 1

And this feels redundant.

Best regards,
Krzysztof


