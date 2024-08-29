Return-Path: <linux-pci+bounces-12408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E372963B1A
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 08:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F202B22BE9
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 06:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5671A14B96F;
	Thu, 29 Aug 2024 06:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7Sf0Ecx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CCE14B94F;
	Thu, 29 Aug 2024 06:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912102; cv=none; b=HKUi3HxJhFDMyvlbPg3W8iQhpKWk6/m8UNui99YHuuZYdWA0lPkEqDvIyTFA0HIyHn3RY/vtKCWPk1IyVVDocKaQOOSNgXNJWw257TMlbpj5TdaWXLpo1qipRj9dW3SDCptQQWi01zYYqSfkDyqtzDj00MpwrUpHvWZaN4+kpo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912102; c=relaxed/simple;
	bh=CYhvJTzMnUvSO6kqmCCSLSZZi2DwPcCuH0MXtqEy9dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ace8GrV1/EAxME+9gSTOg+X8JRHt3qf2pfbTn/szELIn4BrPEipFcaYyVlUE6x+Z4Xdx1pbtHlk+VwTV4lyBKc7pmvV1cFl7xPuSJk6LwD8IPRxnUmMMNn5ZhWrlgV6Frqky/2+5XU7jhkgEjWnePbnHQ8L1Dmwmk1WnmDk+NyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7Sf0Ecx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDDBC4CEC2;
	Thu, 29 Aug 2024 06:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724912101;
	bh=CYhvJTzMnUvSO6kqmCCSLSZZi2DwPcCuH0MXtqEy9dI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n7Sf0EcxIZtYDzoiK9o10w2CB9vJwmaavVk0LqtMeOMjMRPYhNost6WU35oMAdXi7
	 NVgNf5SgDEzo6GlCM33IwxfPpOncXFuZPJeu0az4EFFslk+J2HwFWtbJSwLnQIy25q
	 /rJ/yzEHqqFbkUumaqkZHZtTgPyVwoJefmWppnIqf3m8IEjPb9HpZ7bXCSEoKqKiGs
	 yQv1IDZqv97pfEHCwL18MVz/InUnRQ9OToqkEoF5nMpHX8z3vKDtyDB4UzukpUOni5
	 ORi3ug7SZP0RVbbRewznpS7cRm7qpGzaWI+ZnqEitTPLpoQrzhQ2wDNNUtk+HyDJuY
	 8eSi9DQhGEXig==
Date: Thu, 29 Aug 2024 08:14:58 +0200
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
Subject: Re: [PATCH v3 2/7] dt-bindings: PCI: ti,am65: Extend for use with PVU
Message-ID: <2tc4eistthjifxsedwux3x7c52xlhkt5d3h2pcbe3glzzga6pg@bvbbsghc57zu>
References: <cover.1724868080.git.jan.kiszka@siemens.com>
 <752fb193661bb5e60e5aae6f87704784cbad145d.1724868080.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <752fb193661bb5e60e5aae6f87704784cbad145d.1724868080.git.jan.kiszka@siemens.com>

On Wed, Aug 28, 2024 at 08:01:15PM +0200, Jan Kiszka wrote:
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
> -

Properties must be defined in top-level.

https://elixir.bootlin.com/linux/v6.8/source/Documentation/devicetree/bindi=
ngs/ufs/qcom,ufs.yaml

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

This as well goes to the top.

> +
> +    memory-region:
> +      minItems: 1

Missing maxItems and this must be defined in top-level.

Best regards,
Krzysztof


