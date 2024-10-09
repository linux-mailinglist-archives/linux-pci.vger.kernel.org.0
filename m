Return-Path: <linux-pci+bounces-14086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134EA9967E2
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 12:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7569CB230C3
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 10:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8DA19066B;
	Wed,  9 Oct 2024 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdGsIKZ9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F15D19049B;
	Wed,  9 Oct 2024 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728471548; cv=none; b=V/o5HhZUfuX4wOu3UbJ4F/MrP5fl5G8g1DN4WyKMnaY0p1fETlnZI4wdgIuSRuD0gEadaPx4PTGy0dJbNsnHHxcr7cRyzqwoE20ufupFzWbSDTMw5LzDWupbws3+ogOWI1/Ws5Rt1WWnvc1h2CIyYt8BRCkrjdiB/TUp736Kwp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728471548; c=relaxed/simple;
	bh=xeAjzDULJnF+69KjJwTqAoX43npj68BsDBynQYrVTjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miZ2PcTAkbdt/VHQKOTfFJ+5VA2RLxC1qcWPzydEZ/yd8h/pf8rM93c++3uFmnrDyrUVg85J5ZiBFDxVbRmuKVj8NQQdgYgE1wkTUEmYnPIFw44ZDrqaIVVcQ6RNQZ3vlm8FkuHfszPW8jVruPDr6HbRCCQF6NnFXnXhKNonoFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdGsIKZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988FBC4CEC5;
	Wed,  9 Oct 2024 10:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728471547;
	bh=xeAjzDULJnF+69KjJwTqAoX43npj68BsDBynQYrVTjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BdGsIKZ9BeXI3qHoiOHlRfowyKiZj8WdV74MVwV3oawwnSt85m5qcg3zMUBkV0w19
	 SPK/bufEcKbJSMsSOrU1EMS3CnTxKE4KIcT6f8KOJwV8g4ebzU4pAz3yYlyvudCNvI
	 v5aLm6/aUs0o/pmIUZQKsmzoWXIyUcM4oRpqXQGVuW4VfWzINDBj62gdvLRajOu79h
	 YoIae6J1tiV0CJ2eUAXjUf5C/EDm6jt0NBWXEtUIeyJ3cw3kk4ZlfruFsQ+5EKkeOX
	 pLTHC9+SYPu6oVFfx5TnDMAjnrlhVJrkX10k/QRgDbhh9ATu9KGnjFtwEwPrTZggzB
	 ufoZ3F9MJW+bQ==
Date: Wed, 9 Oct 2024 11:58:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Steen Hegelund <steen.hegelund@microchip.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>, Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 3/6] reset: mchp: sparx5: Map cpu-syscon locally in
 case of LAN966x
Message-ID: <20241009-walnut-unending-aed5b687454c@spud>
References: <20241003081647.642468-1-herve.codina@bootlin.com>
 <20241003081647.642468-4-herve.codina@bootlin.com>
 <71fb65a929e5d5be86f95ab76591beb77e641c14.camel@microchip.com>
 <CAMuHMdVR8UfZyGUS1c3nZqvPYBNs7oSe5p1GjCA3BYwrz8-bdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cndNbLBuvwOtOy9M"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVR8UfZyGUS1c3nZqvPYBNs7oSe5p1GjCA3BYwrz8-bdQ@mail.gmail.com>


--cndNbLBuvwOtOy9M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 12:20:32PM +0200, Geert Uytterhoeven wrote:
> Hi Steve,
>=20
> On Wed, Oct 9, 2024 at 9:30=E2=80=AFAM Steen Hegelund
> <steen.hegelund@microchip.com> wrote:
> > On Thu, 2024-10-03 at 10:16 +0200, Herve Codina wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > > know the content is safe
>=20
> Hmm, the email I received directly from Herv=C3=A9 did not have the part
> you are quoting, so it looks like you are subject to a MiTM-attack ;-)

Yeah, unfortunately we are subjected to that. This one at least just
adds some text, there's another "MiTM attacker" we have that sometimes
crops up and has a side effect of tab-to-space conversion. The joys of
corporate IT.

--cndNbLBuvwOtOy9M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZwZh8wAKCRB4tDGHoIJi
0lfaAQDEiHS7Rxt7GPKHgI4elepFbJpqoYoimbiJmOxyO003UgD/UVz8BnS0gXHT
d4vnv47DPKzMLjGYw5WnRL1P8t+NmQs=
=nI7S
-----END PGP SIGNATURE-----

--cndNbLBuvwOtOy9M--

