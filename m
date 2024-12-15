Return-Path: <linux-pci+bounces-18464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B4D9F262A
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 22:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB86188180B
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 21:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429D2190679;
	Sun, 15 Dec 2024 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcrTA7/Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA601865FA
	for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2024 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734296605; cv=none; b=clRQi969Bsmc4xHNkSCIG8eLKlywAbooXyzRyWGZ4LuQqLPJfXBX//Mm+pFqxZ+qrA0DQgUKi0al3KroYRYXcDkBVOJsYhufXCokDsKg8j8QDFHfjcifg2a6slvh7BgM5Yd9bVrwxK1SO+xmLjvj/y3qaCroloNAbUKaodLDsJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734296605; c=relaxed/simple;
	bh=AYKPAs1VyfvidYvPSRDxv+7honNLez+mCPqJvjpb6Wg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sammAbH83xFm1HgGPxYBeDQHQ9QZ/7MIBz9c1Q70ToSEb8GRShSqJeqzveK41URYLFNrkGm6SmNKoCDCZyYscAGezDDL0p9LjAC4JpAEQVAohfm+735NsG4B0jZm6Pjw/TOFndFFblGlAY3peZQgyjzQt7sof1nZehh/Ov8hVNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcrTA7/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE6FC4CECE;
	Sun, 15 Dec 2024 21:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734296604;
	bh=AYKPAs1VyfvidYvPSRDxv+7honNLez+mCPqJvjpb6Wg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XcrTA7/YnniPRsGjmJPKMtS0sp8+kcJNLll+USmNCYM84VDuw0Qbld4TXHZJ6AbUr
	 O0xpRJXToKtsLzwll2POmqqpZK4Cgew/GEq+RS3Ryz0p+wWd7hTOeaniWCcAJjOXm/
	 gsDhPdzUaiTfzfOp2I3xXG+rCFChRNafKM30yNnQSdbp8UqRUKxXAo5/uyBykFuSPD
	 /YWV8DJcm2MTFg06YE6OgQEU54vRewc8lv2rwKkh+hZlF8kmwdIm7pQiDNCmCG2aNF
	 j/R01kljjBLXNtSzniZudRcy6VaGFqfux55ZSKBWb1guLhTa9eKuhNW9a6kWpZh5hN
	 nUq1inNsJ8m/g==
Message-ID: <db9b708991eb9bfdb358bbcd460c70715593c0a4.camel@kernel.org>
Subject: Re: [PATCH for-linus v2 3/3] PCI/bwctrl: Enable only if more than
 one speed is supported
From: Niklas Schnelle <niks@kernel.org>
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Ilpo Jarvinen
 <ilpo.jarvinen@linux.intel.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Mario Limonciello <mario.limonciello@amd.com>
Date: Sun, 15 Dec 2024 22:03:21 +0100
In-Reply-To: <2292e75dcf26f1c6d7c1f715edfe0e49f079149d.1734257330.git.lukas@wunner.de>
References: <cover.1734257330.git.lukas@wunner.de>
	 <2292e75dcf26f1c6d7c1f715edfe0e49f079149d.1734257330.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-12-15 at 11:20 +0100, Lukas Wunner wrote:
> If a PCIe port only supports a single speed, enabling bandwidth control
> is pointless:  There's no need to monitor autonomous speed changes, nor
> can the speed be changed.
>=20
> Not enabling it saves a small amount of memory and compute resources,
> but also fixes a boot hang reported by Niklas:  It occurs when enabling
> bandwidth control on Downstream Ports of Intel JHL7540 "Titan Ridge 2018"
> Thunderbolt controllers.  The ports only support 2.5 GT/s in accordance
> with USB4 v2 sec 11.2.1, so the present commit works around the issue.
>=20
> PCIe r6.2 sec 8.2.1 prescribes that:
>=20
>    "A device must support 2.5 GT/s and is not permitted to skip support
>     for any data rates between 2.5 GT/s and the highest supported rate."
>=20
> Consequently, bandwidth control is currently only disabled if a port
> doesn't support higher speeds than 2.5 GT/s.  However the Implementation
> Note in PCIe r6.2 sec 7.5.3.18 cautions:
>=20
>    "It is strongly encouraged that software primarily utilize the
>     Supported Link Speeds Vector instead of the Max Link Speed field,
>     so that software can determine the exact set of supported speeds on
>     current and future hardware.  This can avoid software being confused
>     if a future specification defines Links that do not require support
>     for all slower speeds."
>=20
> In other words, future revisions of the PCIe Base Spec may allow gaps
> in the Supported Link Speeds Vector.  To be future-proof, don't just
> check whether speeds above 2.5 GT/s are supported, but rather check
> whether *more than one* speed is supported.
>=20
> Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe =
BW controller")
> Reported-by: Niklas Schnelle <niks@kernel.org>
> Closes: https://lore.kernel.org/r/db8e457fcd155436449b035e8791a8241b0df40=
0.camel@kernel.org/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/pcie/portdrv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 5e10306b6308..02e73099bad0 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -265,12 +265,14 @@ static int get_port_device_capability(struct pci_de=
v *dev)
>  	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
>  		services |=3D PCIE_PORT_SERVICE_DPC;
> =20
> +	/* Enable bandwidth control if more than one speed is supported. */
>  	if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM ||
>  	    pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT) {
>  		u32 linkcap;
> =20
>  		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
> -		if (linkcap & PCI_EXP_LNKCAP_LBNC)
> +		if (linkcap & PCI_EXP_LNKCAP_LBNC &&
> +		    hweight8(dev->supported_speeds) > 1)
>  			services |=3D PCIE_PORT_SERVICE_BWCTRL;
>  	}
> =20

I can confirm that this in combination with the two other patches fixes
my problem. I'm still a little unsure if we want to go with a more
minimal patch for v6.13-rc to take more time to figure out the correct
handling in patch 1, but I think medium term this is the right overall
approach.

Either way, feel free to add:

Tested-by: Niklas Schnelle <niks@kernel.org>

