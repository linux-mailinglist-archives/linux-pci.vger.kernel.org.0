Return-Path: <linux-pci+bounces-22391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F25A450F4
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 00:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E4816A00C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 23:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F5923370D;
	Tue, 25 Feb 2025 23:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEWgs9l5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55621212FAA;
	Tue, 25 Feb 2025 23:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740526530; cv=none; b=AO6zHwZS+nihDpsqzyAQv27rdsPWNIwwvD4EFfOj4wQrBBmWcsWm8Q2Hmu+52AhL/F9aD/eEJj3Cq7PbPkvuNo994om13AV1VKvriZjd9qtib4Dl4YswnnpS9TyVZOnvxH1xlPGLEeECCBWhYxA/QCCiRLzU9/Bh4oMXsiOtGdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740526530; c=relaxed/simple;
	bh=+2NYmz6wq+9xFRZJ3oOmlUmkWUf7V8cF/u0f/KBIynQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPuenVUEKWIg7vekFZt9S8Q+5xsjhu8FqBdPZ1v1pWKms+vR958KCs1SCFJV4XO7nAfITuVudlKD59Bfzexmb7NmcioL4ZMNIPSBep4EnhdNgKJ6LnYGqrnwJRMvmdji7OFoqX7/0qtW5HkZtqYwXthUIeFj4jKfRg459HCYXQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEWgs9l5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1664C4CEDD;
	Tue, 25 Feb 2025 23:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740526529;
	bh=+2NYmz6wq+9xFRZJ3oOmlUmkWUf7V8cF/u0f/KBIynQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BEWgs9l5FkXsNlrogatqzsZ8Z8CJZpLbZyawLLJ5wEV+jIAZtMEkfjsGTI2a50M26
	 DDW7GB5t1tQGmtch9rVgwKTeXsGDMdt1arc33OSMw/sdemiO2IluewJ6p5BMbo3k1n
	 ujgK7SrBaO/elqJnMg1sH6wuMFXLIu+32qfYXVYu5SHO54oMDLmUWcrfvM3uG5Xi7d
	 b1UrUFnQ8SVIn2hsntuBScMhm50qu2/OqZqRT98r6D/0yF4YctnsyunnbpK+zfMzIB
	 CWW3+Vm0YHEbpTFayq6ODjOkMqoU9tC1qnQdl23cM4h1IHmE/wVWyT0begK904lv/2
	 IMPWKYhXpAucw==
Date: Tue, 25 Feb 2025 23:35:23 +0000
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
Message-ID: <20250225-lapel-unhappy-9e7978e270e4@spud>
References: <20250221013758.370936-1-inochiama@gmail.com>
 <20250221013758.370936-2-inochiama@gmail.com>
 <20250221-cavalier-cramp-6235d4348013@spud>
 <2egxw3r63cbsygpwqaltp4jjlkuwoh4rkwpgv4haj4sgz5sked@vkotadyk4g6y>
 <20250224-enable-progress-e3a47fdb625c@spud>
 <7ht3djv7zgrbkcvmdg6tp62nmxytlxzhaprsuvyeshyojhochn@ignvymxb3vfa>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q40QP/7e2VWxOAX5"
Content-Disposition: inline
In-Reply-To: <7ht3djv7zgrbkcvmdg6tp62nmxytlxzhaprsuvyeshyojhochn@ignvymxb3vfa>


--q40QP/7e2VWxOAX5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 07:48:59AM +0800, Inochi Amaoto wrote:
> On Mon, Feb 24, 2025 at 06:54:51PM +0000, Conor Dooley wrote:
> > On Sat, Feb 22, 2025 at 08:34:10AM +0800, Inochi Amaoto wrote:
> > > On Fri, Feb 21, 2025 at 05:01:41PM +0000, Conor Dooley wrote:
> > > > On Fri, Feb 21, 2025 at 09:37:55AM +0800, Inochi Amaoto wrote:
> > > > > The pcie controller on the SG2044 is designware based with
> > > > > custom app registers.
> > > > >=20
> > > > > Add binding document for SG2044 PCIe host controller.
> > > > >=20
> > > > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > > > ---
> > > > >  .../bindings/pci/sophgo,sg2044-pcie.yaml      | 125 ++++++++++++=
++++++
> > > > >  1 file changed, 125 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/pci/sophgo,=
sg2044-pcie.yaml
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2044-=
pcie.yaml b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..040dabe905e0
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.ya=
ml
> > > > > @@ -0,0 +1,125 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/pci/sophgo,sg2044-pcie.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: DesignWare based PCIe Root Complex controller on Sophgo S=
oCs
> > > > > +
> > > > > +maintainers:
> > > > > +  - Inochi Amaoto <inochiama@gmail.com>
> > > > > +
> > > > > +description: |+
> > > > > +  SG2044 SoC PCIe Root Complex controller is based on the Synops=
ys DesignWare
> > > > > +  PCIe IP and thus inherits all the common properties defined in
> > > > > +  snps,dw-pcie.yaml.
> > > > > +
> > > > > +allOf:
> > > > > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > > > > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: sophgo,sg2044-pcie
> > > > > +
> > > > > +  reg:
> > > > > +    items:
> > > > > +      - description: Data Bus Interface (DBI) registers
> > > > > +      - description: iATU registers
> > > > > +      - description: Config registers
> > > > > +      - description: Sophgo designed configuration registers
> > > > > +
> > > > > +  reg-names:
> > > > > +    items:
> > > > > +      - const: dbi
> > > > > +      - const: atu
> > > > > +      - const: config
> > > > > +      - const: app
> > > > > +
> > > > > +  clocks:
> > > > > +    items:
> > > > > +      - description: core clk
> > > > > +
> > > > > +  clock-names:
> > > > > +    items:
> > > > > +      - const: core
> > > > > +
> > > > > +  dma-coherent: true
> > > >=20
> > > > Why's this here? RISC-V is dma-coherent by default, with dma-noncoh=
erent
> > > > used to indicate systems/devices that are not.
> > >=20
> > > The PCIe is dma coherent, but the SoC itself is marked as
> > > dma-noncoherent.
> >=20
> > By "the SoC itself", do you mean that the bus that this device is on is
> > marked as dma-noncoherent?=20
>=20
> Yeah, I was told only PCIe device on SG2044 is dma coherent.
> The others are not.
>=20
> > IMO, that should not be done if there are devices on it that are cohere=
nt.
> >=20
>=20
> It is OK for me. But I wonder how to handle the non coherent device
> in DT? Just Mark the bus coherent and mark all devices except the
> PCIe device non coherent?

Don't mark the bus anything (default is coherent) and mark the devices.
That said, Is the PCIe controller actually on the same bus as the other
devices? (Not talking about the same DT node, the actual bus in the
device)

--q40QP/7e2VWxOAX5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ75TuwAKCRB4tDGHoIJi
0uQKAPoDnoB9fEauVGg2Fkr7nkk5+Fd1CxrPtMhTqMf8B8++pwEA7ORP3BTeQP9f
c/lqF8KRYkIdwrCZhZJ9jrcCKUo+RQk=
=HkuG
-----END PGP SIGNATURE-----

--q40QP/7e2VWxOAX5--

