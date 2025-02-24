Return-Path: <linux-pci+bounces-22253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6376A42C14
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 19:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8A4188FF91
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 18:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0932E26658B;
	Mon, 24 Feb 2025 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emIq/Vl3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE8E26657E;
	Mon, 24 Feb 2025 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423298; cv=none; b=uLfHPuJgWiVtr12dWgmIWzsVaSM1ClJnWDrmva+Cf+SrxEJTPGSFCd/rIHJ84F1n4uHp6HzW70V1PLDp4oX3sni0f4IWAr5MgM/QZZLaISPE0ZdIa4gKFAenVc6IHniio0EhRiMlwCMDZ7iTBkbca45ldfeudQa7SnXTBTYnoYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423298; c=relaxed/simple;
	bh=rVPeC5mli/1j43LuHoG3PNlmHNErM72hIXBxgKKPqkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vl340X2E5WUL00xSQJ0iDmCjJSWTfVoXw7krie9u5jhQGnkiEIGtJUQAAVBVTBtqh2WmkpeGojdMsX+GtTWSMxI0L/2o2AG92L3g02w64LnhAtopM9AGvI/P9b1DgR+yh624VSpBeZibp3NS9d6dWQihiFYaI6gCiGxdpjSUmgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emIq/Vl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF4FC4CED6;
	Mon, 24 Feb 2025 18:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740423298;
	bh=rVPeC5mli/1j43LuHoG3PNlmHNErM72hIXBxgKKPqkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=emIq/Vl3E2OwY+6+v4gj+ccn7N7qHNSVsBl7o3EtRKI899Jx8bZ42IS+pnn7I6bXY
	 J4U3eVMBb1M3zMyX22+z84AkQRkRg7yVbwyFer/q24CJfkt4LgxGkBVEBtFWROI7LT
	 VklI4xu4iodLJHllFqkevZnruOhHTwVVcn1iv3LwK6rSPOFBGdXhui6gdzGz8P/b4V
	 Z0JLN+2sDZHL+ECOddLd+flANvQDrVMQj4sxoCT6+dy6o+zyqVCndYM6yU/nR8u2CY
	 bmia8xiDiU8QbNA7QnVRKGo/vUT6FelVkNVNk5J+pWqlXat519L3csa4taJkx5cNIp
	 cjuFHEojP2tzw==
Date: Mon, 24 Feb 2025 18:54:51 +0000
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
Message-ID: <20250224-enable-progress-e3a47fdb625c@spud>
References: <20250221013758.370936-1-inochiama@gmail.com>
 <20250221013758.370936-2-inochiama@gmail.com>
 <20250221-cavalier-cramp-6235d4348013@spud>
 <2egxw3r63cbsygpwqaltp4jjlkuwoh4rkwpgv4haj4sgz5sked@vkotadyk4g6y>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nEmMIcx09OhU3DPI"
Content-Disposition: inline
In-Reply-To: <2egxw3r63cbsygpwqaltp4jjlkuwoh4rkwpgv4haj4sgz5sked@vkotadyk4g6y>


--nEmMIcx09OhU3DPI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 08:34:10AM +0800, Inochi Amaoto wrote:
> On Fri, Feb 21, 2025 at 05:01:41PM +0000, Conor Dooley wrote:
> > On Fri, Feb 21, 2025 at 09:37:55AM +0800, Inochi Amaoto wrote:
> > > The pcie controller on the SG2044 is designware based with
> > > custom app registers.
> > >=20
> > > Add binding document for SG2044 PCIe host controller.
> > >=20
> > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > ---
> > >  .../bindings/pci/sophgo,sg2044-pcie.yaml      | 125 ++++++++++++++++=
++
> > >  1 file changed, 125 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg20=
44-pcie.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie=
=2Eyaml b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> > > new file mode 100644
> > > index 000000000000..040dabe905e0
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
> > > @@ -0,0 +1,125 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pci/sophgo,sg2044-pcie.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: DesignWare based PCIe Root Complex controller on Sophgo SoCs
> > > +
> > > +maintainers:
> > > +  - Inochi Amaoto <inochiama@gmail.com>
> > > +
> > > +description: |+
> > > +  SG2044 SoC PCIe Root Complex controller is based on the Synopsys D=
esignWare
> > > +  PCIe IP and thus inherits all the common properties defined in
> > > +  snps,dw-pcie.yaml.
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: sophgo,sg2044-pcie
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: Data Bus Interface (DBI) registers
> > > +      - description: iATU registers
> > > +      - description: Config registers
> > > +      - description: Sophgo designed configuration registers
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: dbi
> > > +      - const: atu
> > > +      - const: config
> > > +      - const: app
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: core clk
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: core
> > > +
> > > +  dma-coherent: true
> >=20
> > Why's this here? RISC-V is dma-coherent by default, with dma-noncoherent
> > used to indicate systems/devices that are not.
>=20
> The PCIe is dma coherent, but the SoC itself is marked as
> dma-noncoherent.

By "the SoC itself", do you mean that the bus that this device is on is
marked as dma-noncoherent? IMO, that should not be done if there are
devices on it that are coherent.

> So I add dma-coherent to the binding. I
> wonder whether dma-coherent is necessary even in this case?


--nEmMIcx09OhU3DPI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7zAewAKCRB4tDGHoIJi
0tHFAP90UC8I2j/g5PJgPzzQmwCvjacmi9hAbI+pK4XrrteVtAD/c51IWVKh5nvr
YkNyy6zZ/5H8GwW0TxvOKWhT8Q8jXAo=
=qPA6
-----END PGP SIGNATURE-----

--nEmMIcx09OhU3DPI--

