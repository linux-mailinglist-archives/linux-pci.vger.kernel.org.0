Return-Path: <linux-pci+bounces-20620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB57A248F0
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 13:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2FF163539
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 12:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D75192D7E;
	Sat,  1 Feb 2025 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGTpMXaT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9DD10E0;
	Sat,  1 Feb 2025 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738412215; cv=none; b=DEvlu9d0IYQuJZMnDUGqo67kZSshNqxDepTtFhhqcGtOZaVaRhSLi3M6xTR9MvTv6V4vZ1N1LSyVXd+alNUtFHZJc7Ex5GddpzZe4rpu9UFzkAPP8wuGXOiJxZ7fLVN9c9tNuLu7lCacB6UTWZ5XbEPg/eBG1lfx4PHZJuefcJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738412215; c=relaxed/simple;
	bh=QnYD3OHN1APboHaaBk2QkON9NMRe/FRmrahjz9mSLTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VW0UoY9xQrSopVPyG++w1ZZtD9SvoK+jY06BZ+mUeqol9AKNs1gtJVMgUBucX/H7Y4FZNdQpSiLy3YUhjZZStSkpF1DWJUvhKx0WTDyLGklg7Lz6+1OpgyXs+zq4oYasKPnMZZRqud2thApDM//iwCCU5l2M9sVG5T8qXbjjw4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGTpMXaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD52C4CED3;
	Sat,  1 Feb 2025 12:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738412215;
	bh=QnYD3OHN1APboHaaBk2QkON9NMRe/FRmrahjz9mSLTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qGTpMXaTPcE/N7GIot4YmqlRszV2+5nmFPfqmymkvCZCzVRFuFJeXNatfK3a7oelY
	 4LsqG7Xpf+ohyRG7DalllgjrJqg+l348HCzaDLx9Rgoq/WL0V3n0C9rDffEDaGD0RO
	 DLuU/vKZOq3Fn/NR28SDO79vLUqaafy+N+10rAemlh9nllJBNuU1Zg8ePq6odrN1pi
	 PSmYadC9ZMFXGf9v0+nW7Nlqtq/JcFBFFr0sDkygJRhNMbjLrvIhjD3sXAn0E754mk
	 GmyKrbuyE5fRat6M5G7zwU2jGTXAsKHFSmA0ELvHXDWDZZTVGv7GdU3unfa/vGjmO3
	 nX00SLuhl4Hbg==
Date: Sat, 1 Feb 2025 13:16:52 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: airoha: Add the pbus-csr node for
 EN7581 SoC
Message-ID: <Z54QtFIpX6a1eBm0@lore-desk>
References: <20250115-en7581-pcie-pbus-csr-v1-0-40d8fcb9360f@kernel.org>
 <20250115-en7581-pcie-pbus-csr-v1-1-40d8fcb9360f@kernel.org>
 <20250118-sturgeon-of-incredible-endeavor-73a815@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xdV9V4QeKacnl1fi"
Content-Disposition: inline
In-Reply-To: <20250118-sturgeon-of-incredible-endeavor-73a815@krzk-bin>


--xdV9V4QeKacnl1fi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Jan 15, 2025 at 06:32:30PM +0100, Lorenzo Bianconi wrote:
> > This patch adds the pbus-csr document bindings for EN7581 SoC.
>=20
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/sub=
mitting-patches.rst#L95

ack, I will fix it in v2

>=20
> > The airoha pbus-csr block provides a configuration interface for the
> > PBUS controller used to detect if a given address is on PCIE0, PCIE1 or
> > PCIE2.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../bindings/arm/airoha,en7581-pbus-csr.yaml       | 41 ++++++++++++++=
++++++++
> >  1 file changed, 41 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/airoha,en7581-pbus-c=
sr.yaml b/Documentation/devicetree/bindings/arm/airoha,en7581-pbus-csr.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..80b237e195cd3607645efe3=
fda1eb6152134481c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/airoha,en7581-pbus-csr.yaml
> > @@ -0,0 +1,41 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/airoha,en7581-pbus-csr.yaml#
>=20
> arm is only top level bindings and ARM stuff. This is soc.

in this case we should create an airoha folder in
'Documentation/devicetree/bindings/soc', correct?

>=20
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Airoha Pbus CSR Controller for EN7581 SoC
> > +
> > +maintainers:
> > +  - Lorenzo Bianconi <lorenzo@kernel.org>
> > +
> > +description:
> > +  The airoha pbus-csr block provides a configuration interface for the=
 PBUS
> > +  controller used to detect if a given address is on PCIE0, PCIE1 or P=
CIE2.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - airoha,en7581-pbus-csr
>=20
> Does not fit standard syscon bindings?

I think standard syscon is fine. In this case we could drop this patch. Agr=
ee?

Regards,
Lorenzo

>=20
> Best regards,
> Krzysztof
>=20

--xdV9V4QeKacnl1fi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ54QtAAKCRA6cBh0uS2t
rGPKAP9AV9aNELAnQMAvN6T3ATp+1UdQqYNuozqYanheocrXTQEA3ANKLoaql0H9
KBX3Imbz0GhzL2vi2MiGUzicgh24HwU=
=Cqhn
-----END PGP SIGNATURE-----

--xdV9V4QeKacnl1fi--

