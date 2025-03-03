Return-Path: <linux-pci+bounces-22770-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBABA4C956
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 18:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A777717692C
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 17:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E88C2288F9;
	Mon,  3 Mar 2025 17:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfihcvk/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F62226527;
	Mon,  3 Mar 2025 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021475; cv=none; b=ZOFLUz43dKYP26YNXp5XQcErcYxjbacZfTnDnvCRX4nQlCHDYoE/3aiDoAHyOzp5xjXWHznLyQe02saIi0r2fvERN2jaQkD4sJE+fxaxcizZkgEuwdRjOAwjuqtBWeKQaQpmtH4mbdLS95t+jiKTwEUKjwhUg7Z4ioZszD6ayHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021475; c=relaxed/simple;
	bh=1PbP9JweNnhfY323ds2ckVbVYshiUaX4U6QLjLl33Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cafVwTj4QZsEbrrjRCcAbHF2Sltj+IC7Dd9PQfV3jxmR9iJ1uIkavSdm/Cu23CPmi2lZ6eKAC1+pwycxv5WHUBKj8YtCl01pxZL3jfbleg2v3O4cdVSqd6hO/7sGzaHlEXg8+KN0t5mbntxtqYtrGZ8U5esGDLG0bWajknoH+IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfihcvk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79619C4CED6;
	Mon,  3 Mar 2025 17:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741021474;
	bh=1PbP9JweNnhfY323ds2ckVbVYshiUaX4U6QLjLl33Yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sfihcvk/eEVOMebl2S4GJlQP/B1tYig4rr4JHdfBBNkvCXsWL1/OORGhVnAmXLWGV
	 1UTJPSKDNzhyOOH1eHnKTrvff/ZHNokoDNNyJhBynUiBqeDU6nuRf7c2OQKEGoK2VJ
	 +HZ9etlplxwbUskdChu0SWU/WqcIoaqSED47Colvr4pQXuWHWXza/7BBXyY2gcl/dk
	 IBf0gVwkfhlVzvGkeEbhX9AR4YO7eBYZYfttPiTVM2xpTSe9/U6RxbXsw71HaZ2nNx
	 83RyGxQ5w4JFtwAkrYFQA60bkuXoAIvPMfmctCA49wTh+Qh45gqVoow2JGBnWezY3p
	 Vp79ivh97R9/g==
Date: Mon, 3 Mar 2025 17:04:28 +0000
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Niklas Cassel <cassel@kernel.org>,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pci: Add Sophgo SG2044 PCIe host
Message-ID: <20250303-aground-snitch-40d6dfe95238@spud>
References: <20250221013758.370936-1-inochiama@gmail.com>
 <20250221013758.370936-2-inochiama@gmail.com>
 <20250221-cavalier-cramp-6235d4348013@spud>
 <2egxw3r63cbsygpwqaltp4jjlkuwoh4rkwpgv4haj4sgz5sked@vkotadyk4g6y>
 <20250224-enable-progress-e3a47fdb625c@spud>
 <7ht3djv7zgrbkcvmdg6tp62nmxytlxzhaprsuvyeshyojhochn@ignvymxb3vfa>
 <20250225-lapel-unhappy-9e7978e270e4@spud>
 <ynefy5x672dlhctjzyhkitxoihuucxxki3xqvpimwpcedpfl2u@lmklah5egof4>
 <pbj22qvat76t74nppabekvyncc4ptt6wede4q6wfygbrzcj3ag@ruvt26eqiybu>
 <je4falvfemkemlvdfzdmgc7jx2gz6grpbmo6hwtpedjm7xi2gk@jr4frv3tn3l5>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iy8VECc0OPgXD57M"
Content-Disposition: inline
In-Reply-To: <je4falvfemkemlvdfzdmgc7jx2gz6grpbmo6hwtpedjm7xi2gk@jr4frv3tn3l5>


--iy8VECc0OPgXD57M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 05:20:28PM +0800, Inochi Amaoto wrote:
> On Fri, Feb 28, 2025 at 04:46:22PM +0800, Inochi Amaoto wrote:
> > On Fri, Feb 28, 2025 at 02:34:00PM +0800, Inochi Amaoto wrote:
> > > On Tue, Feb 25, 2025 at 11:35:23PM +0000, Conor Dooley wrote:
> > > > On Tue, Feb 25, 2025 at 07:48:59AM +0800, Inochi Amaoto wrote:
> > > > > On Mon, Feb 24, 2025 at 06:54:51PM +0000, Conor Dooley wrote:
> > > > > > On Sat, Feb 22, 2025 at 08:34:10AM +0800, Inochi Amaoto wrote:
> > > > > > > On Fri, Feb 21, 2025 at 05:01:41PM +0000, Conor Dooley wrote:
> > > > > > > > On Fri, Feb 21, 2025 at 09:37:55AM +0800, Inochi Amaoto wro=
te:
> > > > > > > > > The pcie controller on the SG2044 is designware based with
> > > > > > > > > custom app registers.
> > > > > > > > >=20
> > > > > > > > > Add binding document for SG2044 PCIe host controller.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > > > > > > > ---
> > > > > > > > >  .../bindings/pci/sophgo,sg2044-pcie.yaml      | 125 ++++=
++++++++++++++
> > > > > > > > >  1 file changed, 125 insertions(+)
> > > > > > > > >  create mode 100644 Documentation/devicetree/bindings/pci=
/sophgo,sg2044-pcie.yaml
> > > > > > > > >=20
> > > > > > > > > diff --git a/Documentation/devicetree/bindings/pci/sophgo=
,sg2044-pcie.yaml b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pci=
e.yaml
> > > > > > > > > new file mode 100644
> > > > > > > > > index 000000000000..040dabe905e0
> > > > > > > > > --- /dev/null
> > > > > > > > > +++ b/Documentation/devicetree/bindings/pci/sophgo,sg2044=
-pcie.yaml
> > > > > > > > > @@ -0,0 +1,125 @@
> > > > > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > > > > +%YAML 1.2
> > > > > > > > > +---
> > > > > > > > > +$id: http://devicetree.org/schemas/pci/sophgo,sg2044-pci=
e.yaml#
> > > > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > > > +
> > > > > > > > > +title: DesignWare based PCIe Root Complex controller on =
Sophgo SoCs
> > > > > > > > > +
> > > > > > > > > +maintainers:
> > > > > > > > > +  - Inochi Amaoto <inochiama@gmail.com>
> > > > > > > > > +
> > > > > > > > > +description: |+
> > > > > > > > > +  SG2044 SoC PCIe Root Complex controller is based on th=
e Synopsys DesignWare
> > > > > > > > > +  PCIe IP and thus inherits all the common properties de=
fined in
> > > > > > > > > +  snps,dw-pcie.yaml.
> > > > > > > > > +
> > > > > > > > > +allOf:
> > > > > > > > > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > > > > > > > > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > > > > > > > > +
> > > > > > > > > +properties:
> > > > > > > > > +  compatible:
> > > > > > > > > +    const: sophgo,sg2044-pcie
> > > > > > > > > +
> > > > > > > > > +  reg:
> > > > > > > > > +    items:
> > > > > > > > > +      - description: Data Bus Interface (DBI) registers
> > > > > > > > > +      - description: iATU registers
> > > > > > > > > +      - description: Config registers
> > > > > > > > > +      - description: Sophgo designed configuration regis=
ters
> > > > > > > > > +
> > > > > > > > > +  reg-names:
> > > > > > > > > +    items:
> > > > > > > > > +      - const: dbi
> > > > > > > > > +      - const: atu
> > > > > > > > > +      - const: config
> > > > > > > > > +      - const: app
> > > > > > > > > +
> > > > > > > > > +  clocks:
> > > > > > > > > +    items:
> > > > > > > > > +      - description: core clk
> > > > > > > > > +
> > > > > > > > > +  clock-names:
> > > > > > > > > +    items:
> > > > > > > > > +      - const: core
> > > > > > > > > +
> > > > > > > > > +  dma-coherent: true
> > > > > > > >=20
> > > > > > > > Why's this here? RISC-V is dma-coherent by default, with dm=
a-noncoherent
> > > > > > > > used to indicate systems/devices that are not.
> > > > > > >=20
> > > > > > > The PCIe is dma coherent, but the SoC itself is marked as
> > > > > > > dma-noncoherent.
> > > > > >=20
> > > > > > By "the SoC itself", do you mean that the bus that this device =
is on is
> > > > > > marked as dma-noncoherent?=20
> > > > >=20
> > > > > Yeah, I was told only PCIe device on SG2044 is dma coherent.
> > > > > The others are not.
> > > > >=20
> > > > > > IMO, that should not be done if there are devices on it that ar=
e coherent.
> > > > > >=20
> > > > >=20
> > > > > It is OK for me. But I wonder how to handle the non coherent devi=
ce
> > > > > in DT? Just Mark the bus coherent and mark all devices except the
> > > > > PCIe device non coherent?
> > > >=20
> > > > Don't mark the bus anything (default is coherent) and mark the devi=
ces.
> > >=20
> > > I think this is OK for me.
> > >=20
> >=20
> > In technical, I wonder a better way to "handle dma-noncoherent".
> > In the binding check, all devices with this property complains=20
> >=20
> > "Unevaluated properties are not allowed ('dma-noncoherent' was unexpect=
ed)"
> >=20
>=20
> > It is a pain as at least 10 devices' binding need to be modified.
> > So I wonder whether there is a way to simplify this.
> >=20
>=20
> Ignore this, I misunderstood the dma device. it seems like=20
> only dmac and eth needs it.

Nah, not gonna ignore it ;) You do make a valid point about it being
painful, but given you mention a different master for the pci device,
having two different soc@<foo> nodes sounds like it might make sense.
One marked dma-noncoherent w/ the existing devices and one that is
unmarked (since that's default) to represent the master than pci is on?

--iy8VECc0OPgXD57M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8XhHAAKCRB4tDGHoIJi
0iEOAQDHZ4vcXR1XFxlZa5wZOaYlkyWg7C1a+pAsr9m1gQmy7wD/RXNdGcCfafWf
/S3g0f02l1q/FIz0KqPemwNYalIihwg=
=Dt3i
-----END PGP SIGNATURE-----

--iy8VECc0OPgXD57M--

