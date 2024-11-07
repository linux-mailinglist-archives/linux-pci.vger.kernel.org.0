Return-Path: <linux-pci+bounces-16264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CC19C0B8D
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 17:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D101C22DA7
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 16:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAE1216A00;
	Thu,  7 Nov 2024 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsmT28NG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DD3216447;
	Thu,  7 Nov 2024 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996508; cv=none; b=OAwfzbMg+ID1B2VDCh3aRvysT7b3Lzp0bcng+3MUjqOxEgk9RUBF+bsax7TnT4agUiDpfrib4kGAZD+T9TkTd59ZbhixXyP5jEE1bLrlhVNsQUrlWXprVphGYXnWHK3ocReBo41tcb7IqJpgMkZndahKLKJ0pQcrGZgearIa46I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996508; c=relaxed/simple;
	bh=WdSOCcZ7hgr8Ov0l08oA3H3gpfSe8mQRm7rvPaPDzK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXkQGvkI2mILwjt7M+yheweq9i5efuvW2YXahOaMHC3kSJjisSUcPAwSuEJUBCpkdNeUou+hM6Y5yGbkCXEMsbHC7k/X2gmd51kCrzNJoWAHgweojF6gaH+JsElz2kZhjmUgVj+VDkpctJt+NWuqojTGG+K44aaG7C/s7g09Sag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsmT28NG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D53C4CECC;
	Thu,  7 Nov 2024 16:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730996507;
	bh=WdSOCcZ7hgr8Ov0l08oA3H3gpfSe8mQRm7rvPaPDzK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UsmT28NG1BwTx4bRDzle6jmLJxgmbGfrtsKIcsOlz+6VRRF2pB3qXQR3nAkPf7K4s
	 qyV26ewJsuzUWqJX4uO1VRpN5op43k61S9tiXqPOZiYB/GCRX0rSOZIOt9AU3IKAfV
	 wj0Yjooh/AUVEr85ggT7zrwfUT3uBbnwNSK9ZWnnUMplptDiGpQ8BNhmjjMOgmuNtb
	 omIFZgYPnDzinq/yjf/PWKTpGLgR1IJDcPjeLK1ero2wEWnu4QZuu6/m7sX62UQs5J
	 Y35X2zuQTs9+Ytkql4V47B1yORciN/d58WmPjSkqceeTi6b6yZlxpIRAe7HYDsfTkY
	 wH+fYUNn6JMUg==
Date: Thu, 7 Nov 2024 17:21:45 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com,
	linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v4 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
Message-ID: <ZyzpGSyAVe6bz9H2@lore-desk>
References: <Zyxuv-2SPuEXiL5R@lore-desk>
 <20241107151701.GA1614390@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sizbHdv8GL2Glr4d"
Content-Disposition: inline
In-Reply-To: <20241107151701.GA1614390@bhelgaas>


--sizbHdv8GL2Glr4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 07, Bjorn Helgaas wrote:
> On Thu, Nov 07, 2024 at 08:39:43AM +0100, Lorenzo Bianconi wrote:
> > > On Wed, Nov 06, 2024 at 11:40:28PM +0100, Lorenzo Bianconi wrote:
> > > > > On Wed, Jul 03, 2024 at 06:12:44PM +0200, Lorenzo Bianconi wrote:
> > > > > > Introduce support for Airoha EN7581 PCIe controller to mediatek=
-gen3
> > > > > > PCIe controller driver.
> > > > > > ...
>=20
> > > > > Is this where PERST# is asserted?  If so, a comment to that effect
> > > > > would be helpful.  Where is PERST# deasserted?  Where are the req=
uired
> > > > > delays before deassert done?
> > > >=20
> > > > I can add a comment in en7581_pci_enable() describing the PERST iss=
ue for
> > > > EN7581. Please note we have a 250ms delay in en7581_pci_enable() af=
ter
> > > > configuring REG_PCI_CONTROL register.
> > > >=20
> > > > https://github.com/torvalds/linux/blob/master/drivers/clk/clk-en752=
3.c#L396
> > >=20
> > > Does that 250ms delay correspond to a PCIe mandatory delay, e.g.,
> > > something like PCIE_T_PVPERL_MS?  I think it would be nice to have the
> > > required PCI delays in this driver if possible so it's easy to verify
> > > that they are all covered.
> >=20
> > IIRC I just used the delay value used in the vendor sdk. I do not
> > have a strong opinion about it but I guess if we move it in the
> > pcie-mediatek-gen3 driver, we will need to add it in each driver
> > where this clock is used. What do you think?
>=20
> I don't know what the 250ms delay is for.  If it is for a required PCI
> delay, we should use the relevant standard #define for it, and it
> should be in the PCI controller driver.  Otherwise it's impossible to
> verify that all the drivers are doing the correct delays.

ack, fine to me. Do you prefer to keep 250ms after clk_bulk_prepare_enable()
in mtk_pcie_en7581_power_up() or just use PCIE_T_PVPERL_MS (100)?
I can check if 100ms works properly.

Regards,
Lorenzo

>=20
> I don't know what other drivers are using that clock.  Are you
> suggesting that it may be used in non-PCI situations where the
> required delay might be different?  If another user requires 250ms,
> but PCI requires only 100ms, I think it would be worth having separate
> delays in each user so PCI wouldn't have to pay that extra 150ms.
>=20
> Bjorn

--sizbHdv8GL2Glr4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZyzpGQAKCRA6cBh0uS2t
rLMxAQCPfP+w6J4Kwd4N78DkOQxd0DpJ0kTcwQR8/ri2jd+7sAEAmdTAx8UAnpLy
col3r/ywsAj/LfxbDgtGoSkgIYBSzAA=
=Llow
-----END PGP SIGNATURE-----

--sizbHdv8GL2Glr4d--

