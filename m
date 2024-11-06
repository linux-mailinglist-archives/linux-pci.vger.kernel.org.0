Return-Path: <linux-pci+bounces-16150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032EF9BF32E
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 17:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 897ADB24F81
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E47820492C;
	Wed,  6 Nov 2024 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVgvAAkq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506912022EE;
	Wed,  6 Nov 2024 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730910367; cv=none; b=uELXKpurLOSaCAcmkTQOTpUbmQq2K5G1neSY08haU5utNMjJw//FUHWbouRp+vDkgTC3Waa0xu63n/MXCRA8W1UwTNf8deN/4wOQuVWfnCyspaWy9IE9VLlbmw5EUyJ4c+l/yUHJ+x4WY2mYl3dQvGwOwHmmo5saDEtdZ1hD3sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730910367; c=relaxed/simple;
	bh=SEV9bd+GX/2qf2FHLXeJIP4QQb00PuGWxAb2OJDbHH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzGOUxm3XjXtqIKVcdfhOgCQSGVAnQyi2N4elnsevO+cHQgqVmLXMQ566G2yMofC0vEE23CRzFuvzwHjYMc21+cwR9xoCmAMG3onIHEeLAZz83h/KI2KykZwqnnv+hiSj3+9zqb0UX/jXNcjLxHFXmL9GQq/5g7gB/kDSAtwI0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVgvAAkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8D1C4CEC6;
	Wed,  6 Nov 2024 16:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730910366;
	bh=SEV9bd+GX/2qf2FHLXeJIP4QQb00PuGWxAb2OJDbHH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SVgvAAkqitwp3CRjcYwtzVTYcZps3/+UsLrpka7Kuzuwj0PL6LVYtp/VKr3YSx5b6
	 W9uV5xvoZG8glsIw7QD7pVmQ+m5Jg7Dy8zkNIwLLbhpwUfqBlIzo5FR0UW9+zdC3HZ
	 8ryHGTmawTKI37MqbBxPTWh4wVV0Wv6Lr/t8YXm1Y5l+0U3PCIRE0QdQUIxZoimvpu
	 oCoIoDeo1bu4GSvQ+pYmFukpPYsGPMR9ulXkbxjP2dVOfDV28AYWLeAexY8MTuYCh9
	 w/XMkqn7EdAT2u28KwDOWLfdrzjz9yThyRcyp1XraJo6d5RDmpiQHjLWtwuleyozIQ
	 7OKq0beIoHrNA==
Date: Wed, 6 Nov 2024 16:26:02 +0000
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
Message-ID: <20241106-eats-anthology-657e2238e271@spud>
References: <20241104-stabilize-friday-94705c3dc244@spud>
 <20241105171828.GA1474726@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="00d4RwnxQ06JtKcq"
Content-Disposition: inline
In-Reply-To: <20241105171828.GA1474726@bhelgaas>


--00d4RwnxQ06JtKcq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 11:18:28AM -0600, Bjorn Helgaas wrote:
> On Mon, Nov 04, 2024 at 11:18:43AM +0000, Conor Dooley wrote:
> > On Fri, Nov 01, 2024 at 02:51:29PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Aug 14, 2024 at 09:08:42AM +0100, Conor Dooley wrote:
> > > > From: Conor Dooley <conor.dooley@microchip.com>
> > > >=20
> > > > The PCI host controller on PolarFire SoC has multiple "instances", =
each
> > > > with their own bridge and ctrl address spaces. The original binding=
 has
> > > > an "apb" register region, and it is expected to be set to the base
> > > > address of the host controllers register space. Defines in the driv=
er
> > > > were used to compute the addresses of the bridge and ctrl address r=
anges
> > > > corresponding to instance1. Some customers want to use instance0 ho=
wever
> > > > and that requires changing the defines in the driver, which is clea=
rly
> > > > not a portable solution.
> > >=20
> > > The subject mentions "instance 1 or 2".
> > >=20
> > > This paragraph implies adding support for "instance0" ("customers want
> > > to use instance0").
> > >=20
> > > The DT patch suggests that we're adding support for "instance2"
> > > ("customers want to use instance2").
> > >=20
> > > Both patches suggest that the existing support is for "instance 1".
> > >=20
> > > Maybe what's being added is "instance 2", and this commit log should
> > > s/instance0/instance 2/ ?  And probably s/instance1/instance 1/ so the
> > > style is consistent?
> >=20
> > Hmm no, it would be s/instance1/instance 2/ & s/instance0/instance 1/.
> > The indices are 1-based, not 0-based.
> >=20
> > > Is this a "pick one or the other but not both" situation, or does this
> > > device support two independent PCIe controllers?
> > >=20
> > > I first thought this driver supported a single PCIe controller, and
> > > you were adding support for a second independent controller.
> >=20
> > I don't know if they are fully independent (Daire would have to confirm)
> > but as far as the driver in linux is concerned they are. As far as I
> > know, you could operate both instances at the same time, but I've not
> > heard of any customer that is actually doing that nor tested it myself.
> > Operating both instances would require another node in the devicetree,
> > which should work fine given the private data structs are allocated at
> > runtime. I think the config space is shared.
> >=20
> > > But the fact that you say "the [singular] host controller on
> > > PolarFire", and you're not changing mc_host_probe() to call
> > > pci_host_common_probe() more than once makes me think there is only a
> > > single PCIe controller, and for some reason you can choose to operate
> > > it using either register set 1 or register set 2.
> >=20
> > The wording I've used mostly stems from conversations with Daire. We've
> > kinda been saying that there's a single controller with two root port
> > instances.=20
>=20
> If these are two separate Root Ports, can we call them "Root Ports"
> instead of "instances"?  Common terminology makes for common
> understanding.

Sure.

> > Each root port instance is connected to different IOs,
> > they're more than just different registers for accessing the same thing.
>=20
> Sounds like some customers use Root Port 1 and others use Root Port 2,
> maybe based on things like which pins are more convenient to route.

Aye, the user that motivated the patchset uses a very small package and
was not able to use root port 1 for that reason.

> I would very much like to reword these commit logs using as much
> standard PCIe terminology as possible.  Most of these native PCIe
> controller drivers have Root Complex and Root Port concepts all mixed
> together, and anything we can do to standardize them will be a
> benefit.

I can do that tomorrow.

--00d4RwnxQ06JtKcq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyuYmgAKCRB4tDGHoIJi
0s4TAP9ih6PFRzTbgox+CHVwQgWCULG9sxCQ63YThXWRx/E+oAD/UR0qA0IMkUcN
5OWxK/mfq+PpID6qtsDwHr1Wd0qMogE=
=zqeK
-----END PGP SIGNATURE-----

--00d4RwnxQ06JtKcq--

