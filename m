Return-Path: <linux-pci+bounces-12938-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D55A3970DCE
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 08:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EC01B2118F
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 06:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6249A17333D;
	Mon,  9 Sep 2024 06:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTCJ1yM1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31307101F7;
	Mon,  9 Sep 2024 06:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725862939; cv=none; b=l3G4qN1XZXMMaPB79rbK6rNoAKSGNVPPc7EZKYohunqWUFvCDZAz8sTO7NrwhgYlNBz3UFL71FmcVshO2smOikeBPnyauM87iOl1mvy34CpsMwwFZR2SD4qgRreRMNzfgZxpZXQQXLFDNFspHnv2Arc8sSOIczLXJcw996FJ5rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725862939; c=relaxed/simple;
	bh=H0cxLZlp/AhNiC00sAhCB8pZwQNhJZIoTa9lRAPcWtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1GTj0Qgv2hR0mjcM9YH+5IgF8DBymgZqDak/mrBofVq7V5UvYS6g4qBRgr3h06HggTCiSrjSebTwN54IhMnuWDBxcmlqN1OGMEPWk1UDg0d2FFKiChn5JmQAIMrQMZskKxo7WXT2yfiTg0ku73j14DEq7PpkXCx//Urwr58HK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTCJ1yM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61167C4CEC5;
	Mon,  9 Sep 2024 06:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725862938;
	bh=H0cxLZlp/AhNiC00sAhCB8pZwQNhJZIoTa9lRAPcWtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTCJ1yM1gaOu3KQDH3P9gRChy7bcYUb9ZI3qQEwZt43+zTGrTT+yTwg+tFVZgIijf
	 5IhXMDfeAiFjzMwH0+nQqK89fbDcC9w4i+5WgwinHF6H6UmAuFhdGfBblKbW4QFn8p
	 dOX6ShOqQMCoKKTxENwhNNEW8gp0J7WkMeMvVy0RXIKLoHFXtK8iediA575PyAQ3Ui
	 aFZ9aZm/V9e2YWStcz1KBaHb5S2/fsVa/DQC6Sl3/5kKVlxNnGXR4smFBzAo9PzYOR
	 K9m9HTbfgKcIsDbKWeBwW1Ooeem30ssgtfx+Y+4oI2M/lNCqRjIE+xN2RVZQDkgB+v
	 FLK4doLm4rXjg==
Date: Mon, 9 Sep 2024 08:22:13 +0200
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
Subject: Re: [PATCH v5 2/7] dt-bindings: PCI: ti,am65: Extend for use with PVU
Message-ID: <n5l36lo6at3yfbexqc5wcxgxop5wwfzldhhm43rwr6qy2epf7a@jq7l6wiyvydc>
References: <cover.1725816753.git.jan.kiszka@siemens.com>
 <33d08f61fe9bd692da0eceab91209832bf16e804.1725816753.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <33d08f61fe9bd692da0eceab91209832bf16e804.1725816753.git.jan.kiszka@siemens.com>

On Sun, Sep 08, 2024 at 07:32:28PM +0200, Jan Kiszka wrote:
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
> registers which are optional unless the PVU shall be used for PCIe.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
> CC: "Krzysztof Wilczy=C5=84ski" <kw@linux.com>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: linux-pci@vger.kernel.org
> ---
>  .../bindings/pci/ti,am65-pci-host.yaml        | 29 +++++++++++++++++--
>  1 file changed, 26 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml =
b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> index 0a9d10532cc8..0c297d12173c 100644
> --- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> @@ -20,14 +20,18 @@ properties:
>        - ti,keystone-pcie
> =20
>    reg:
> -    maxItems: 4
> +    minItems: 4
> +    maxItems: 6
> =20
>    reg-names:
> +    minItems: 4
>      items:
>        - const: app
>        - const: dbics
>        - const: config
>        - const: atu
> +      - const: vmap_lp
> +      - const: vmap_hp
> =20
>    interrupts:
>      maxItems: 1
> @@ -83,13 +87,30 @@ if:
>      compatible:
>        enum:
>          - ti,am654-pcie-rc
> +
>  then:
> +  properties:
> +    memory-region:

I think I said it two times already. You must define properties in
top-level. That's how we expect, that's how dtschema works (even if it
works fine otherwise, it's not always that case), that's how almost all
bindings are written.

> +      maxItems: 1
> +      description: |
> +        phandle to a restricted DMA pool to be used for all devices behi=
nd
> +        this controller. The regions should be defined according to
> +        reserved-memory/shared-dma-pool.yaml.

Best regards,
Krzysztof


