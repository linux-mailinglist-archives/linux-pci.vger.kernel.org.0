Return-Path: <linux-pci+bounces-15939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5277A9BB334
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 12:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D601C212A5
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 11:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1A71C07C9;
	Mon,  4 Nov 2024 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhPiOPq/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DA01B2197;
	Mon,  4 Nov 2024 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719129; cv=none; b=rGvNyuGwZGdChZRTum+7zxI1nT3wxJ78qyj8tgpg/amzVjWD1rol4g7YjytvxQfqWMwQ+Qw3f63p3baqqale20JF903abuKb0c243B0ZWYy2WK+JpD1E+k/4OoTYJ/ea+TOW/ufWL3BikGHrHEoxmOzWsNlA75qGG679eiyVOFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719129; c=relaxed/simple;
	bh=dPYBbaZDduNI0r2YV+lknaETuYjrZTPFY+763BUwGkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIaQ++59JuputfPxKNkoCb6x9FqwDB/IjbBaVYSpm/8mAYIByjkrHsUdWBJUvxSXS56BJDiR2jVJCQKP9T2hjea8BQVCOiNmKZYS8Anp8cVUw4lWCSnUMp9Cg4H4Iwo4FBDJfdFvRmnvlB0cGe5UsFAkd0iu5jTSF5NIpRSmNrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhPiOPq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB53EC4CECE;
	Mon,  4 Nov 2024 11:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730719128;
	bh=dPYBbaZDduNI0r2YV+lknaETuYjrZTPFY+763BUwGkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NhPiOPq/MAF8Mgv5z5c4nAv+K8Ik4BEZpQjtnrhmvqQyuNX8cCKcOpodWGW9nZzbC
	 5Lw4uqvaC40QVKSsifKjEPR4EsQyGDK3gdJ8DaBu+XYeoOYQoJ7SeeCNa5il9fl8ye
	 hy181fS9Ea1zvX4xW46q/Bt91sREIC9jqvgmDyDym8foGP7bw2AtT7zGNuFeCM2IlS
	 DhPlhYXwwmw/Fad6wM73qKYUnYAEPTVyutMMoUs6wUW4gF3lFff+4yChlZqU5fnEKb
	 DMQ//FpswkWeAG29nUamJDziZhp06JmCNLCFdE7ljDVjOj2jrVYJk6GrMF361g9A/u
	 PsRz7WQzSF9tA==
Date: Mon, 4 Nov 2024 11:18:43 +0000
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
Subject: Re: [PATCH v5 2/2] PCI: microchip: rework reg region handing to
 support using either instance 1 or 2
Message-ID: <20241104-stabilize-friday-94705c3dc244@spud>
References: <20240814-outmost-untainted-cedd4adcd551@spud>
 <20241101195129.GA1318063@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TfnHo0vXNK+c6Gwh"
Content-Disposition: inline
In-Reply-To: <20241101195129.GA1318063@bhelgaas>


--TfnHo0vXNK+c6Gwh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2024 at 02:51:29PM -0500, Bjorn Helgaas wrote:
> On Wed, Aug 14, 2024 at 09:08:42AM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > The PCI host controller on PolarFire SoC has multiple "instances", each
> > with their own bridge and ctrl address spaces. The original binding has
> > an "apb" register region, and it is expected to be set to the base
> > address of the host controllers register space. Defines in the driver
> > were used to compute the addresses of the bridge and ctrl address ranges
> > corresponding to instance1. Some customers want to use instance0 however
> > and that requires changing the defines in the driver, which is clearly
> > not a portable solution.
>=20
> The subject mentions "instance 1 or 2".
>=20
> This paragraph implies adding support for "instance0" ("customers want
> to use instance0").
>=20
> The DT patch suggests that we're adding support for "instance2"
> ("customers want to use instance2").
>=20
> Both patches suggest that the existing support is for "instance 1".
>=20
> Maybe what's being added is "instance 2", and this commit log should
> s/instance0/instance 2/ ?  And probably s/instance1/instance 1/ so the
> style is consistent?

Hmm no, it would be s/instance1/instance 2/ & s/instance0/instance 1/.
The indices are 1-based, not 0-based.

> Is this a "pick one or the other but not both" situation, or does this
> device support two independent PCIe controllers?
>=20
> I first thought this driver supported a single PCIe controller, and
> you were adding support for a second independent controller.
>=20

I don't know if they are fully independent (Daire would have to confirm)
but as far as the driver in linux is concerned they are. As far as I
know, you could operate both instances at the same time, but I've not
heard of any customer that is actually doing that nor tested it myself.
Operating both instances would require another node in the devicetree,
which should work fine given the private data structs are allocated at
runtime. I think the config space is shared.

> But the fact that you say "the [singular] host controller on
> PolarFire", and you're not changing mc_host_probe() to call
> pci_host_common_probe() more than once makes me think there is only a
> single PCIe controller, and for some reason you can choose to operate
> it using either register set 1 or register set 2.

The wording I've used mostly stems from conversations with Daire. We've
kinda been saying that there's a single controller with two root port
instances. Each root port instance is connected to different IOs,
they're more than just different registers for accessing the same thing.

--TfnHo0vXNK+c6Gwh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyitkwAKCRB4tDGHoIJi
0tNQAP9ldG40/6k9HNbXDTXUEnTF1pjijRt/gdkaj938jXDjRgD/cJ24UOeT9ncp
xClPvRUyDFamEevdesGEqLyarnTIzg0=
=TAA0
-----END PGP SIGNATURE-----

--TfnHo0vXNK+c6Gwh--

