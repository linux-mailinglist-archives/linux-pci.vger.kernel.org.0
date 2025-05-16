Return-Path: <linux-pci+bounces-27867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E07EAAB9E0D
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 15:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5861B644CB
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 13:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249A2132111;
	Fri, 16 May 2025 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRxZMWQR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF4B200A3;
	Fri, 16 May 2025 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747403825; cv=none; b=RfLEIY7ibOtzUB9/bhemivS14tNZwLBaxjUEULJuZpNrfU6QuhpB0l8B2dbKrEWJ5rIiVqVDmQkipjlsDEbIGgS5G8DdhCCtkKBszt9XPRWpuLrWfzuBPrsMiFl1UWZQHRoJqMZvBr5FKjgAnvIqcFJcFzyIlTWhLHoB00Rt/JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747403825; c=relaxed/simple;
	bh=opHjacfTqHep/g5AemKpA/gLp+hKeJDPhfb7AxFAjk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+dRkbsusjJiiPJf5B7pu3GQcjwDI15V7/vThD3v40XsUe2gERASJLU+W/HYMmsujom+FPo3YOsWaAYDhDPrHCg3FPnJPRfOuWrge9Rs0kNHJLFRp/NFKLV2GI4Z06/0BEWjl47r5MMGbkhuwM8bTcwotH1jyOIPxMGk1CsWjm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRxZMWQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AA4C4CEE4;
	Fri, 16 May 2025 13:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747403824;
	bh=opHjacfTqHep/g5AemKpA/gLp+hKeJDPhfb7AxFAjk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NRxZMWQRDYnisU86gqiiEFLlNPpInW3q/hFfmN373ShBt4x+3vRDGsx3jhFyA+tPH
	 FWDRAGvT6yWHLw7jzPzUyRp6pt2S4WTBVObaN4iuPlDulqN9j2Wyhx8A8GpZqcw+9w
	 EiQ2k39tUnWXLsVFklilzCqy31gho5lUXpGs3YsZz3i0hrHpuEiy/CR9NGwlXrFajE
	 uY8rrQhYAcMnv8bNf3jkKlL0kPnMNRLNceTFyexMMfLA/bJT8X0y9T+9P/CTrcm4tD
	 LwhuosOgpwmjEewHuzlsUbPWld9KktIITg+DpI46XWmBLMh9af4+RNO9/icBH9ZOT2
	 HbAePxBTB5Y4A==
Date: Fri, 16 May 2025 14:56:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-pci@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: PCI: microchip,pcie-host: fix dma
 coherency property
Message-ID: <20250516-freely-squabble-a2162b60f9c1@spud>
References: <20250516-datebook-senator-ff7a1c30cbd5@spud>
 <20250516130659.GA2084811@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m6QYV8gsGIBd0Ejt"
Content-Disposition: inline
In-Reply-To: <20250516130659.GA2084811@rocinante>


--m6QYV8gsGIBd0Ejt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 10:06:59PM +0900, Krzysztof Wilczy=C5=84ski wrote:
> Hello,
>=20
> > PolarFire SoC may be configured in a way that requires non-coherent DMA
> > handling. On RISC-V, buses are coherent by default & the dma-noncoherent
> > property is required to denote buses or devices that are non-coherent.
> > For some reason, instead of adding dma-noncoherent to the binding
> > the pointless, NOP, property dma-coherent was. Swap dma-coherent for
> > dma-noncoherent.
>=20
> I have favour to ask.  Can you capitalise (so-called "title case") the
> subject when submitting patches that are PCI-specific DT bindings?

Sure, I can add that to my list of things I try to remember while
submitting for PCI.

>=20
> This is the preferred style for PCI, at least at the moment.
>=20
> Also, it would save us the need to do it every time. :)
>=20
> Thank you!
>=20
> 	Krzysztof

--m6QYV8gsGIBd0Ejt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCdEKwAKCRB4tDGHoIJi
0hTMAQDAZQzK1N2h2CxLKFwPFQOEG/6Q/hMHQQx5O3STBCg2owD/atVvB8y/e5C/
Qx0eMK5xtmsDax/lNuuqRfnkFgbqQAs=
=yelw
-----END PGP SIGNATURE-----

--m6QYV8gsGIBd0Ejt--

