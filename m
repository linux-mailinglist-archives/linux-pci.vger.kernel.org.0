Return-Path: <linux-pci+bounces-10729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD00A93B455
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 17:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D111285362
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 15:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D6D15B116;
	Wed, 24 Jul 2024 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BffLe/L1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F841D699;
	Wed, 24 Jul 2024 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836492; cv=none; b=LSFBPBpHeW/3DgkYm9Ozgp1Zkfb0N4vXrsYCqxJ1L+UfeDZrBA3UBDNz4n8yeI4BW13t7NtZFEHZuYkEI73TYgVHk3dRxC2aZIhwiGZdTyzRAFyte3XvEz2v3wdzoqWlXPfQN2rHcD2JbAqrOtJNRGJp2uYhjU/MMGnEKF90Xcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836492; c=relaxed/simple;
	bh=Gq95TCDqVaj7aNPzZtv9xbK1Uj/gt0DHW+RYTvdUq+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSFMZx1eFGZ+EfoB8MBK59y2kR1ErNxEij3HWCSHbqffIwGTYyKokWCzM+Qv4ii9DGK+nvS5bRtknVnmYqnNDg2ZmF+RTbAgC7Sy6oTj2PZHy5dOZrZhzBJL75WLiYlbvrNqKhlcmrQ7Hl/lVauvwFMJXW08xZjkcg4u0YqHATY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BffLe/L1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2A7C32781;
	Wed, 24 Jul 2024 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721836491;
	bh=Gq95TCDqVaj7aNPzZtv9xbK1Uj/gt0DHW+RYTvdUq+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BffLe/L1Julily6ef/X5cPeA/ylQJJhUw960ffi9+HT4LDMFC8W7r1oezG4ZK5NJS
	 4niBvlVoPRzLPFAhtsxq/ghTt42K37RhX9jfDE5Zk10ymTem9YlBMCRPArDtLrNJjn
	 vWVawirZR23N5X9IMOia27RVZTjMdSnCB4nv3zTXYekFO4ASqygi9R9Fe5x2rJQqSS
	 U4kNePaHGHBUoH/q1TtbfLWzba0RusSCtlE6Z1AcPqEQW4JNhQQ8uvQmi8TRoT+Jgv
	 goJruXRmvr4ecKcx9UiSIbZStwA0vbw42p1CA6ZJcemb5NNYUVfY3dkaDV81ohF9wm
	 /p1f28biGIZHQ==
Date: Wed, 24 Jul 2024 16:54:47 +0100
From: Conor Dooley <conor@kernel.org>
To: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
Cc: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: xilinx-xdma: Add schemas for
 Xilinx QDMA PCIe Root Port Bridge
Message-ID: <20240724-result-twig-3789d7f0bcd5@spud>
References: <20240722062558.1578744-1-thippesw@amd.com>
 <20240722062558.1578744-2-thippesw@amd.com>
 <20240722-wham-molasses-ec515cc554a0@spud>
 <SN7PR12MB7201729CCCF2953D9AC1A04F8BAA2@SN7PR12MB7201.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="92K84z8ZDtaxn7PF"
Content-Disposition: inline
In-Reply-To: <SN7PR12MB7201729CCCF2953D9AC1A04F8BAA2@SN7PR12MB7201.namprd12.prod.outlook.com>


--92K84z8ZDtaxn7PF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 09:30:21AM +0000, Havalige, Thippeswamy wrote:
> Hi Conor Dooley,
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Monday, July 22, 2024 10:15 PM
> > To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> > Cc: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > bhelgaas@google.com; krzk+dt@kernel.org; conor+dt@kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > pci@vger.kernel.org; Havalige, Thippeswamy
> > <thippeswamy.havalige@amd.com>; linux-arm-kernel@lists.infradead.org;
> > Simek, Michal <michal.simek@amd.com>
> > Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: xilinx-xdma: Add schemas =
for
> > Xilinx QDMA PCIe Root Port Bridge
> >=20
> > On Mon, Jul 22, 2024 at 11:55:57AM +0530, Thippeswamy Havalige wrote:
> > > Add YAML devicetree schemas for Xilinx QDMA Soft IP PCIe Root Port
> > Bridge.
> > >
> > > Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
> > > ---
> > >  .../bindings/pci/xlnx,xdma-host.yaml          | 41 +++++++++++++++++=
+-
> > >  1 file changed, 39 insertions(+), 2 deletions(-)
> > > ---
> > > changes in v2
> > > - update dt node label with pcie.
> > > ---
> > > diff --git a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> > b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> > > index 2f59b3a73dd2..28d9350a7fb4 100644
> > > --- a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> > > @@ -14,10 +14,21 @@ allOf:
> > >
> > >  properties:
> > >    compatible:
> > > -    const: xlnx,xdma-host-3.00
> > > +    enum:
> > > +      - xlnx,xdma-host-3.00
> > > +      - xlnx,qdma-host-3.00
> > >
> > >    reg:
> > > -    maxItems: 1
> > > +    items:
> > > +      - description: configuration region and XDMA bridge register.
> > > +      - description: QDMA bridge register.
> >=20
> > Please constrain the new entry to only the new compatible.
> - Thanks, I ll resend patch with required changes.

Weird quoting btw, the - isn't needed.

> > > +    minItems: 1
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: cfg
> > > +      - const: breg
> > > +    minItems: 1
> > >
> > >    ranges:
> > >      maxItems: 2
> > > @@ -111,4 +122,30 @@ examples:
> > >                  interrupt-controller;
> > >              };
> > >          };
> > > +
> > > +        pcie@80000000 {
> >=20
> > tbh, don't see the point of a new example for this.
> - For this in both examples ranges properties are different. So, here I w=
anted to make sure that our example device tree bindings work straight forw=
ard when our reference designs are used.

Different ranges properties doesn't justify a new example. They don't
exist to be copy-pasted, but rather to demonstrate usage of properties
and validate the binding.

--92K84z8ZDtaxn7PF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZqEjxgAKCRB4tDGHoIJi
0mHhAQCrh5YO1/JZ7IECO37RiQw1DnB5qf7QtbOsQnjjs+GAgAD9GlzOI5vOVD7B
0bjbgj3+TO8fke9IHYGrN1Sdk+aDfAQ=
=Ftu/
-----END PGP SIGNATURE-----

--92K84z8ZDtaxn7PF--

