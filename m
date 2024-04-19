Return-Path: <linux-pci+bounces-6487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA548AB297
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 17:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA91E1F23555
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446791304B6;
	Fri, 19 Apr 2024 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB10FGA3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1490512F59B;
	Fri, 19 Apr 2024 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713542272; cv=none; b=pwhcw6Q/uiJCa8EQv4tLae7NMHpeiNpFQBeHiogzNuqJBOdvE5A2ega80WwgTsDIm+Flz8TxjzS+1p4rlGiXuCVm0EJz9QcXi2BAfh5YhMjFBSZ28N+7h780E1Vaj11yCIIbcsoiToSW/0ipDAf+imQej+MHhdwQA1uptvM60HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713542272; c=relaxed/simple;
	bh=8QEDQjOppN6rgrkwPLW/8KvmAUWYG8et7RnU5mOglu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzbg2gh7wJp2wxIBoMVef6n92HK66nvWzgA/GQz4jw8akbaJnE/fL5qBfQE2CU5GScvlSyDB8yafZ+5miSm77l/oqsiMoq3CsLOQIDB5XfKEy9fJ4Rof/FlMsP+iqeM+MiEm5W00Q3dzpUt+0TxjkM20z2B5T6EhcnPhE+MoYXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB10FGA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5B9C072AA;
	Fri, 19 Apr 2024 15:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713542271;
	bh=8QEDQjOppN6rgrkwPLW/8KvmAUWYG8et7RnU5mOglu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NB10FGA3HUo4FWUdWzr/7uRQFBe3lrvgTHD57CEE1hkQsdk2PFT0iRvsT6WlBsryH
	 R9ECS0tIP+q2ePoWG3IXYHRwrC4ZbdKbm2b6WKVRbsH6kivseIWcvWn1YLLFFCjqnJ
	 +WEiNG9+K6yDDCcarItZTLBsG6w0laG+wVvCVK6NBCvHmYuMpUV1H6260C2irK8N3s
	 N1ICOKTf3K1upQySIskCOkv9FNsFnP6fBdzQmAOw3+O15/uvuu1Td3Jr7hm0nIo9ij
	 ShYAEPNvj7I0A5Guge7e3pn+aQC+rO7on5RMuT9Gg8vururtjFLBW040ID3hA375Zi
	 S69jOsJC2LEcw==
Date: Fri, 19 Apr 2024 16:57:40 +0100
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Jamie Gibbons <jamie.gibbons@microchip.com>,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 4/5] dt-bindings: PCI: microchip: increase number of
 items in ranges property
Message-ID: <20240419-batboy-mutt-4da787cffd3d@spud>
References: <20240327-parkway-dodgy-f0fe1fa20892@spud>
 <20240327-debunk-perky-f5514ca332be@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P5gNKGuon3/meze+"
Content-Disposition: inline
In-Reply-To: <20240327-debunk-perky-f5514ca332be@spud>


--P5gNKGuon3/meze+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

PCI maintainers, could you please either apply this (preferred!) or give
me an ack to take it with the dts?

Thanks,
Conor.

On Wed, Mar 27, 2024 at 12:24:39PM +0000, Conor Dooley wrote:
> From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
>=20
> Increase the number of items in the ranges property to allow up to 3
> ranges. For example a prefetchable range, a non-prefetchable range
> and an IO range, depending on configuration.
>=20
> Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.c=
om>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.ya=
ml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> index f7a3c2636355..e8212a05b7b1 100644
> --- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> @@ -65,7 +65,8 @@ properties:
>        - const: msi
> =20
>    ranges:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 3
> =20
>    dma-ranges:
>      minItems: 1
> --=20
> 2.43.0
>=20

--P5gNKGuon3/meze+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiKUdAAKCRB4tDGHoIJi
0uRiAP0V/vBz26onjgXgloeZ0gVi8i6q/SLsKfs59S/dQBZHkwEAjywPdUJikVo/
2Y4XvNpmuSZqJZbzHcMQXcsxriJmdgQ=
=nmUD
-----END PGP SIGNATURE-----

--P5gNKGuon3/meze+--

