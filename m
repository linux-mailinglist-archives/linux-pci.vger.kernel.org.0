Return-Path: <linux-pci+bounces-21971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B9CA3EFDF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 10:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46CC37A56E2
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 09:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3915A1FCCE3;
	Fri, 21 Feb 2025 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDFCvYF7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4D91C3F02;
	Fri, 21 Feb 2025 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740129604; cv=none; b=T7qHPW4iQzzrMjKCc42a2JPU7yKi2tnHsWgJQalm/syZ9DGgLTWVGkHlFbUH6fr5a5hDmd19VhNxZMRV9SiJMMOkR/oU2NsGipt8tdFatizysnTyxL57SNEmr61uTcftz0dWUc8DO4Res/1rYcNiSRh4jO+Hd0rQqj7qmC0ASVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740129604; c=relaxed/simple;
	bh=S7u7a+YlaIRiD5gDT6Ek/uMJbGdPwGFC/i5GuTzW1MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOZuCh5ChWkl+Z629guhwp3rxrWgpt/lydRJW1bYHVIjLAu4sTN8CrdM9JV8LBhG3iIVUf70rEZupsUfITHqrwC1DH9J7WtJkDN4fM1fPnxdY1Mm1VYspAT7omSlQW8jiHtVzLeO0htQfCZrtfGgjGQbKuq/tpSGKUMPM0iPDjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDFCvYF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD1CC4CED6;
	Fri, 21 Feb 2025 09:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740129603;
	bh=S7u7a+YlaIRiD5gDT6Ek/uMJbGdPwGFC/i5GuTzW1MU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDFCvYF7oXIAP8YXtkRwlcHSnczi1ouLSAX88JkId7RAAOUIOpLUIY3/OdOZZKVIZ
	 OPynsTSYi/5a0bSXNAU4XsV9Beg7LUshDPS4rbI/kHHsZw+FdVlBen8gR9fEs730e1
	 9S+pYJ4l5w2vkUBdShCSwoeF8Dz1bkAbEy/iQfxfPGDZ9jXykr61ZhemUw09/WNdOy
	 r1NouH3u9XG7xwHQ0qf8Ehx4J0iSE9ZONgPguD0F3NSUSmxkvAfdkOgs8yF16FpXWY
	 22l6htKoxIb1/8qpZuQoZM6BQ87Gq7Q8fanJqH0K0AJPT/vWyjFIAc6Z15EdtTCQbJ
	 AQTDTCiQTrzcw==
Date: Fri, 21 Feb 2025 10:20:01 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Frank Li <Frank.li@nxp.com>, Hui.Ma@airoha.com, upstream@airoha.com
Subject: Re: [PATCH v2 2/2] PCI: mediatek-gen3: Configure PBUS_CSR registers
 for EN7581 SoC
Message-ID: <Z7hFQXIrpMpH_72T@lore-desk>
References: <Z7eIXsupArd8xH7_@lore-desk>
 <20250220235607.GA320302@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xQ/Sp2/8xd3sTCxm"
Content-Disposition: inline
In-Reply-To: <20250220235607.GA320302@bhelgaas>


--xQ/Sp2/8xd3sTCxm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> [+cc Frank, who asked the same question about DT]
>=20
> On Thu, Feb 20, 2025 at 08:54:06PM +0100, Lorenzo Bianconi wrote:
> > On Feb 20, Bjorn Helgaas wrote:
> > > On Sun, Feb 02, 2025 at 08:34:24PM +0100, Lorenzo Bianconi wrote:
> > > > Configure PBus base address and address mask to allow the hw
> > > > to detect if a given address is on PCIE0, PCIE1 or PCIE2.
>=20
> > > > +#define PCIE_EN7581_PBUS_ADDR(_n)	(0x00 + ((_n) << 3))
> > > > +#define PCIE_EN7581_PBUS_ADDR_MASK(_n)	(0x04 + ((_n) << 3))
> > > > +#define PCIE_EN7581_PBUS_BASE_ADDR(_n)	\
> > > > +	((_n) =3D=3D 2 ? 0x28000000 :	\
> > > > +	 (_n) =3D=3D 1 ? 0x24000000 : 0x20000000)
> > >=20
> > > Are these addresses something that should be expressed in devicetree?
> >=20
> > Do you have any example/pointer for it?
> >=20
> > > It seems unusual to encode addresses directly in a driver.
> >=20
> > AFAIK they are fixed for EN7581 SoC.
>=20
> So this is used to detect if a given address is on PCIE0, PCIE1 or
> PCIE2.  What does that mean?  There are no other mentions of PCIE0 etc
> in the driver, but maybe they match up to "pcie0/1/2" in
> arch/arm64/boot/dts/mediatek/mt7988a.dtsi?
>=20
> It looks like you use PCIE_EN7581_PBUS_ADDR(slot), where "slot" came
> from of_get_pci_domain_nr(), which suggests that these might be three
> separate Root Ports?

I was using pci_domain to detect the specific PCIe controller
(something similar to what is done here [0]) but I agree with Frank, it does
not seem completely correct.

[0] https://github.com/torvalds/linux/blob/master/drivers/pci/controller/pc=
ie-mediatek.c#L1048

>=20
> Are we talking about an MMIO address that an endpoint driver uses for
> readw() etc, and this code configures the hardware apertures through
> the host bridge?  Seems like that would be related to the "ranges"
> properties in DT.

I guess so, but I do not have any documentation about pbus-csr (adding Hui =
in
the loop).

As pointed out by Frank, do you agree to add these info in the dts? Somethi=
ng
like:

pcie0: pcie@1fc00000 {
	....
	mediatek,pbus-csr =3D <&pbus_csr 0x0 0x20000000 0x4 0xfc000000>;
	....
};

pcie1: pcie@1fc20000 {
	....
	mediatek,pbus-csr =3D <&pbus_csr 0x8 0x24000000 0xc 0xfc000000>;
	....
};

@Hui: can you please provide a better explanation about pbus-csr usage?

Regards,
Lorenzo

>=20
> Bjorn

--xQ/Sp2/8xd3sTCxm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ7hFQQAKCRA6cBh0uS2t
rMgvAP0cRVYb+GGLw9gCGcDYMXSqkWGyssZSlcc3BpNd32BPpwEA74q7lbggDL1Q
OnXA7DoPO1K0+hSFJkVPfJhFysDHAgI=
=ViXQ
-----END PGP SIGNATURE-----

--xQ/Sp2/8xd3sTCxm--

