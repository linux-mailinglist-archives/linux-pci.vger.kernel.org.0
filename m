Return-Path: <linux-pci+bounces-16348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2D19C22DA
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 18:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D461F22C0C
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 17:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB632198A17;
	Fri,  8 Nov 2024 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBD6MBtK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A697F1E260C
	for <linux-pci@vger.kernel.org>; Fri,  8 Nov 2024 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731086634; cv=none; b=mJsu+MzGM7lhr5sQ//OZXIFn5FKPogMTpUWrVJalcIQITlKJJ306HGcw8ZET+Lx1mUNrEOyHsXl7DyGpZtrarwP9OLPWc61ubTOW7x5NuC8/Qux7Hs+0tYxFbSJoJFwFKvwnxCczh8bvIoF5I7mYRPUZlqzN6/Y43OmqGKSFk90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731086634; c=relaxed/simple;
	bh=6zKQlRn0Es/TKeDFmAQ35oAz8kwkdvS9qyL+rTAPFhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epZsJi7p+EM/wr+qb4rL9NuXscqWGfS8dw7q6ZIBkpykTIhuOTNZzPNJIMJhfinG06Quih9aIUwxxox0IFQ2aEvErlP8m0IlAkBNJAV8ikGNIOqK4RVVxQ3jCzmZFbQ2vXVoBEipu7hwWC7GXRjSp4uKRu6bPKfWiaND08DWI74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBD6MBtK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54ABC4CECD;
	Fri,  8 Nov 2024 17:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731086634;
	bh=6zKQlRn0Es/TKeDFmAQ35oAz8kwkdvS9qyL+rTAPFhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QBD6MBtKY3GZVRw49enM8QsMZfEiWtuHqSv4AceulD2+HrEJLAnsaI9WMrCl3EB3V
	 6CR+wE51/iuWuBHlFdhnnyOZDRdI4zbh/CW7FNXbAA50ThB+C/CYb2Oaq3VlnawrTK
	 xmrSF2ubuhPAGd7Ks6FgMe2cwTE4r+DJu3FKwrPR8k/oNqfIFUnqMCz+z8k1T1cXzn
	 /IdBdqr6c4JFV+dsm9YywGm64fpJJmb5po6XeRBwYZeRoQhadf9bDuxoEdQm5Bc6CY
	 lXSLehNuVh5RhS/9E136m6EZZJxzMBBlDL2azR48I/LCxgc7OTY2+TZXsQCy+WkvGZ
	 GAiFiZ88dKNSQ==
Date: Fri, 8 Nov 2024 18:23:50 +0100
From: "lorenzo@kernel.org" <lorenzo@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jianjun Wang =?utf-8?B?KOeOi+W7uuWGmyk=?= <Jianjun.Wang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	Ryder Lee <Ryder.Lee@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI: mediatek-gen3: Move reset/assert callbacks in
 .power_up()
Message-ID: <Zy5JJuAsxPqEos4I@lore-desk>
References: <Zy5EjY_oQaRbb5MY@lore-desk>
 <20241108171710.GA1667022@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mpRtWSJTYmJLObDx"
Content-Disposition: inline
In-Reply-To: <20241108171710.GA1667022@bhelgaas>


--mpRtWSJTYmJLObDx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 08, Bjorn Helgaas wrote:
> On Fri, Nov 08, 2024 at 06:04:13PM +0100, lorenzo@kernel.org wrote:
> > > On Fri, Nov 08, 2024 at 09:39:41AM +0100, lorenzo@kernel.org wrote:
> > > > > On Thu, 2024-11-07 at 17:08 +0100, Lorenzo Bianconi wrote:
> > > > > > > On Thu, Nov 07, 2024 at 02:50:55PM +0100, Lorenzo Bianconi wr=
ote:
> > > > > > > > In order to make the code more readable, move phy and mac
> > > > > > > > reset lines assert/de-assert configuration in .power_up
> > > > > > > > callback (mtk_pcie_en7581_power_up/mtk_pcie_power_up).
> > >=20
> > > > > > > > +	/*
> > > > > > > > +	 * The controller may have been left out of reset by the
> > > > > > > > bootloader
> > > > > > > > +	 * so make sure that we get a clean start by asserting re=
sets
> > > > > > > > here.
> > > > > > > > +	 */
> > > > > > > > +	reset_control_bulk_assert(pcie->soc->phy_resets.num_reset=
s,
> > > > > > > > +				  pcie->phy_resets);
> > > > > > > > +	reset_control_assert(pcie->mac_reset);
> > > > > > > > +	usleep_range(10, 20);
> > > > > > >=20
> > > > > > > Unrelated to this patch, but since you're moving it, do you
> > > > > > > know what this delay is for?  Can we add a #define and a spec
> > > > > > > citation for it?
> > > > > >=20
> > > > > > I am not sure about it, this was already there.  @Jianjun Wang:
> > > > > > any input on it?
> > > > >=20
> > > > > This delay is used to ensure the reset is effective. A delay of
> > > > > 10us should be sufficient in this scenario.
> > > >=20
> > > > ack, so we can introduce a marco like:
> > > >=20
> > > > #define PCIE_RESET_TIME_US	10
> > > > ...
> > > >=20
> > > > usleep_range(PCIE_RESET_TIME_US, 2 * PCIE_RESET_TIME_US);
> > >=20
> > > Unless this corresponds to a value specified by the PCIe base spec
> > > or CEM spec, this macro should be internal to
> > > pcie-mediatek-gen3.c.
> >=20
> > My plan is to add it in pcie-mediatek-gen3.c. Do you think
> > PCIE_RESET_TIME_US is too generic?
>=20
> It's generic, but so are most of the other #defines in
> pcie-mediatek-gen3.c, so I'd follow suit.
>=20
> Connect it to language in the MediaTek spec if possible, i.e., if the
> spec names this parameter, try to use the same name.

unfortunately I do not have any mediatek spec documentation available.

@Jianjun Wang: is PCIE_RESET_TIME_US fine for you or according to the avail=
able
documentation?

Regards,
Lorenzo

--mpRtWSJTYmJLObDx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZy5JJgAKCRA6cBh0uS2t
rJXaAQC/Sv0ltwvrKgZw6OyUcbyAk4/sBfF7IaiTfIisVDVn7gD8DwX7b6kQV/DZ
fdWM8kWpF/9QWlKmCpHxYbkyemdxqw4=
=M7P9
-----END PGP SIGNATURE-----

--mpRtWSJTYmJLObDx--

