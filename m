Return-Path: <linux-pci+bounces-16271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4909C0C07
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 17:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40BE31C21CE5
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 16:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426D5215F4D;
	Thu,  7 Nov 2024 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRcUnqks"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152201DF273;
	Thu,  7 Nov 2024 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998501; cv=none; b=QqTfYYxIrvSpZbKB53bLorCJlpPdD9+3hhyfecehWTOqNZV564zAGDbHK5tAIo/RUmwCHC13Ai4/U4oqp88VLtK94TJYmLV4BDQ0IpchDr4BOVB2eJucM3mOC7ioQRtMEXkC7U9wYTY6xTtuT5dQ5k/V+ZHARaYny3Tf/R2VIE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998501; c=relaxed/simple;
	bh=9bVTUTo6hUtl0dlQL9IxRNnDbOUzfDaASJK3yyh/JI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUA3HGkTxsFiq7t7+hMM+Xf+27i2fgLXnsuBCc87lzoB2zlsXM/rVwQ20iJ1GI8J3VyUlFKYQR/bUDtMPB1EOg9X9bXWpgOSk4iIxXeEUfN7gSXkhQaPwIPNKceuZZzhOOQdURRr4imfFDdOpINcS4IdibbnYbuuuIJCrScR7qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRcUnqks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA10C4CECC;
	Thu,  7 Nov 2024 16:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730998500;
	bh=9bVTUTo6hUtl0dlQL9IxRNnDbOUzfDaASJK3yyh/JI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hRcUnqksED2hZ2drRPZJtktHOyttKgZOZASoLIiB0GIfk7ac4XWExOpJ3cvC7cNbg
	 M9LaiPKrtNy2TNDAEhQfAkQXK53kj16bIjdufe4QbDk1IuGYmWMGDygokA6xLxr6OQ
	 QPatfQK1hqCpJVQyGPjQxhvVAmmpX/gTDUSEK8QK8gQWtqHD2c7UjkUFMBi1hL3AoD
	 93gMtNyfOXRGsrcLOstQVCRb36RjORGii/4J7hv05ATCA5UOpcIldSrsThVVeUt0aI
	 QKTO3v0q7NrlU8/WguLe8eYf/PSA9agPT7b81Qrsu6EUKNhrgPzClQyyZ9cfPZYC5/
	 4hDjPLTKz5Fjg==
Date: Thu, 7 Nov 2024 16:54:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 0/2] PCI: microchip: support using either instance 1
 or 2
Message-ID: <20241107-applied-landscape-18094319130e@spud>
References: <20241107-aqueduct-petroleum-c002480ba291@spud>
 <20241107145715.GA1613568@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FRuOnas6CTShxO8U"
Content-Disposition: inline
In-Reply-To: <20241107145715.GA1613568@bhelgaas>


--FRuOnas6CTShxO8U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2024 at 08:57:15AM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 07, 2024 at 10:59:33AM +0000, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > The current driver and binding for PolarFire SoC's PCI controller assume
> > that the root port instance in use is instance 1. The second reg
> > property constitutes the region encompassing both "control" and "bridge"
> > registers for both instances. In the driver, a fixed offset is applied =
to
> > find the base addresses for instance 1's "control" and "bridge"
> > registers. The BeagleV Fire uses root port instance 2, so something must
> > be done so that software can differentiate. This series splits the
> > second reg property in two, with dedicated "control" and "bridge"
> > entries so that either instance can be used.
> >=20
> > Cheers,
> > Conor.
> >=20
> > v6:
> > - rework commit messages to use Bjorn's preferred "root port" and "root
> >   complex" wording
> >=20
> > v5:
> > - rebase on top of 6.11-rc1, which brought about a lot of driver change
> >   due to the plda common driver creation - although little actually
> >   changed in terms of the lines edited in this patch.
> >=20
> > v4:
> > - fix a cocci warning reported off list about an inconsistent variable
> >   used between IS_ERR() and PTR_ERR() calls.
> >=20
> > v3:
> > - rename a variable in probe s/axi/apb/
> >=20
> > v2:
> > - try the new reg format before the old one to avoid warnings in the
> >   good case
> > - reword $subject for 2/2
> >=20
> > CC: Daire McNamara <daire.mcnamara@microchip.com>
> > CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > CC: Krzysztof Wilczy=C5=84ski <kw@linux.com>
> > CC: Rob Herring <robh@kernel.org>
> > CC: Bjorn Helgaas <bhelgaas@google.com>
> > CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > CC: Conor Dooley <conor+dt@kernel.org>
> > CC: linux-pci@vger.kernel.org
> > CC: devicetree@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > CC: linux-riscv@lists.infradead.org
> >=20
> > Conor Dooley (2):
> >   dt-bindings: PCI: microchip,pcie-host: fix reg properties
> >   PCI: microchip: rework reg region handing to support using either root
> >     port 1 or 2
> >=20
> >  .../bindings/pci/microchip,pcie-host.yaml     |  11 +-
> >  .../pci/plda,xpressrich3-axi-common.yaml      |  14 ++-
> >  .../bindings/pci/starfive,jh7110-pcie.yaml    |   7 ++
> >  .../pci/controller/plda/pcie-microchip-host.c | 116 +++++++++---------
> >  4 files changed, 87 insertions(+), 61 deletions(-)
>=20
> Thanks!  The patches themselves are unchanged between v5 and v6.  I
> replaced the v5 patches on pci/controller/microchip with these.
>=20
> I also capitalized "Root Port" and "Root Complex" to give a hint that
> they are proper nouns defined by the PCIe spec.

Cool, thanks for doing that.

--FRuOnas6CTShxO8U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyzw3wAKCRB4tDGHoIJi
0hKaAP0eI4OJu6eAnIhYs5EB0myLZemCviOCG5VvSEEUOr6DIAD/Ze/bWXtn4dWz
D4SL/qEAL9/a0aBYc3Cb92DSBvIHMQU=
=ZkCM
-----END PGP SIGNATURE-----

--FRuOnas6CTShxO8U--

