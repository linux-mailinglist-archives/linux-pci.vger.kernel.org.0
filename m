Return-Path: <linux-pci+bounces-37904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3338CBD3E73
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 17:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA3664F6F8C
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 14:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2487274B55;
	Mon, 13 Oct 2025 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNBnyf5m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B24D265CAD;
	Mon, 13 Oct 2025 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367111; cv=none; b=pTlwv2//0vg9AikVzkDjKEVKt6qMdlFgYjjBo6hVfOY+Wu7T91WjvAcKbIpNg3rIrJoeQprJHsqMlOP00bBRHSwKRbR+QFoehZvtjk0T7NgY66u5M6Z1vtvr8XRN0JV91JT8nT9QMQTMrT33x6g7cTsCcSjZzy1AMRs19HmpvOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367111; c=relaxed/simple;
	bh=1f1R3hSRZT6UvLUu06F4HKhifFVAYk2MH31zzCMuaMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KETWBHSmre68VZZGYnK39ThiY4Peyv2eCuiHcNswdDZ6QSqp2aCJp6XW/bc1iTcg5f8HUaC6jRoM3Chs45jKaaoztKvsKyDbQ6TP1l0X6r3Ws78CSVuV/HC7zNOSki9G2OKUA90XmZhrdC8LDj9mQNR5xdmnsYQo/npoSKfPjE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNBnyf5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5808C113D0;
	Mon, 13 Oct 2025 14:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760367111;
	bh=1f1R3hSRZT6UvLUu06F4HKhifFVAYk2MH31zzCMuaMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SNBnyf5mQqInO6AKrseYPWAQUKjA7FwKTh0ngKwlfHCCDImzvVtQ7ZAKxefQkTBSq
	 URAZHR47cIBC5F6FdoA++rPOEkvhrcqNSBdGwoPELMt23JLCayZaOaH7rtZ1uDjyUE
	 IHbEIY+Z5g0jjr3s1g4LCK/kPDV+Vw5NCpoXMb8m4FoCjCANLcFaTXEp1xpBIu1bDi
	 RNZYnDkvwNS5ZDuFmfbkbnXJDjVVVyCHTKfZ7KLRWT+6ME1i6KBa6lcojyTv1ayF6+
	 VyRI57IJLFZjA5dZz1byAoXBK1YsA7WqEUP9Fhw+IEFoQoI3sjGxV69TqVpgfdn4+O
	 fZWWUoxKrtT8Q==
Date: Mon, 13 Oct 2025 15:51:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Ron Economos <re@w6rz.net>, bhelgaas@google.comk,
	rishna.chundru@oss.qualcomm.com, mani@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: SiFive FU740 PCI driver fails on 6.18-rc1
Message-ID: <20251013-blatancy-husband-ed9872a46e25@spud>
References: <eac81c57-1164-4d74-a1b4-6f353c577731@w6rz.net>
 <bc7f397c-1739-465e-b195-e1a41c34504d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Uueo13zjvdFAPZts"
Content-Disposition: inline
In-Reply-To: <bc7f397c-1739-465e-b195-e1a41c34504d@oss.qualcomm.com>


--Uueo13zjvdFAPZts
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 01:49:39PM +0530, Krishna Chaitanya Chundru wrote:
>=20
>=20
> On 10/13/2025 12:44 PM, Ron Economos wrote:
> > The SiFive FU740 PCI driver fails on the HiFive Unmatched board with
> > Linux 6.18-rc1. The error message is:
> >=20
> > [=A0=A0=A0 3.166624] fu740-pcie e00000000.pcie: host bridge
> > /soc/pcie@e00000000 ranges:
> > [=A0=A0=A0 3.166706] fu740-pcie e00000000.pcie:=A0=A0=A0=A0=A0=A0 IO
> > 0x0060080000..0x006008ffff -> 0x0060080000
> > [=A0=A0=A0 3.166767] fu740-pcie e00000000.pcie:=A0=A0=A0=A0=A0 MEM
> > 0x0060090000..0x007fffffff -> 0x0060090000
> > [=A0=A0=A0 3.166805] fu740-pcie e00000000.pcie:=A0=A0=A0=A0=A0 MEM
> > 0x2000000000..0x3fffffffff -> 0x2000000000
> > [=A0=A0=A0 3.166950] fu740-pcie e00000000.pcie: ECAM at [mem
> > 0xdf0000000-0xdffffffff] for [bus 00-ff]
> > [=A0=A0=A0 3.579500] fu740-pcie e00000000.pcie: No iATU regions found
> > [=A0=A0=A0 3.579552] fu740-pcie e00000000.pcie: Failed to configure iAT=
U in
> > ECAM mode
> > [=A0=A0=A0 3.579655] fu740-pcie e00000000.pcie: probe with driver fu740=
-pcie
> > failed with error -22
> >=20
> > The normal message (on Linux 6.17.2) is:
> >=20
> > [=A0=A0=A0 3.381487] fu740-pcie e00000000.pcie: host bridge
> > /soc/pcie@e00000000 ranges:
> > [=A0=A0=A0 3.381584] fu740-pcie e00000000.pcie:=A0=A0=A0=A0=A0=A0 IO
> > 0x0060080000..0x006008ffff -> 0x0060080000
> > [=A0=A0=A0 3.381682] fu740-pcie e00000000.pcie:=A0=A0=A0=A0=A0 MEM
> > 0x0060090000..0x007fffffff -> 0x0060090000
> > [=A0=A0=A0 3.381724] fu740-pcie e00000000.pcie:=A0=A0=A0=A0=A0 MEM
> > 0x2000000000..0x3fffffffff -> 0x2000000000
> > [=A0=A0=A0 3.484809] fu740-pcie e00000000.pcie: iATU: unroll T, 8 ob, 8=
 ib,
> > align 4K, limit 4096G
> > [=A0=A0=A0 3.683678] fu740-pcie e00000000.pcie: PCIe Gen.1 x8 link up
> > [=A0=A0=A0 3.883674] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
> > [=A0=A0=A0 3.987678] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
> > [=A0=A0=A0 3.988164] fu740-pcie e00000000.pcie: PCI host bridge to bus =
0000:00
> >=20
> > Reverting the following commits solves the issue.
> >=20
> > 0da48c5b2fa731b21bc523c82d927399a1e508b0 PCI: dwc: Support ECAM
> > mechanism by enabling iATU 'CFG Shift Feature'
> >=20
> > 4660e50cf81800f82eeecf743ad1e3e97ab72190 PCI: qcom: Prepare for the DWC
> > ECAM enablement
> >=20
> > f6fd357f7afbeb34a633e5688a23b9d7eb49d558 PCI: dwc: Prepare the driver
> > for enabling ECAM mechanism using iATU 'CFG Shift Feature'
> >=20
> Hi Ron,
>=20
> can you try with this change.
> Looks like fu740-pcie driver has 256MB space of config space so dwc
> driver is trying to enable ecam and seeing failures while enabling.
>=20
> you can try two options 1 is to enable ecam if your hardware supports
> it and other is to use native method like below.

> If you want to enable
> ecam your config space should start with dbi address and should have
> 256Mb aligned 256Mb memory of config space. Uf you want to enable ecam
> and had this memory requirement fulfilled, try to change your devicetree
> by starting config space with dbi start address and give it a try.

If it worked before your changes, but now does not, I am not going to
accept a dts change to make it work again FYI.

>=20
> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c
> b/drivers/pci/controller/dwc/pcie-fu740.c
> index 66367252032b..b5e0f016a580 100644
> --- a/drivers/pci/controller/dwc/pcie-fu740.c
> +++ b/drivers/pci/controller/dwc/pcie-fu740.c
> @@ -328,6 +328,8 @@ static int fu740_pcie_probe(struct platform_device
> *pdev)
>=20
>         platform_set_drvdata(pdev, afp);
>=20
> +       pci->pp.native_ecam =3D true;
> +
>         return dw_pcie_host_init(&pci->pp);
>  }
>=20
> - Krishna Chaitanya.
> >=20

--Uueo13zjvdFAPZts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaO0SAwAKCRB4tDGHoIJi
0tgOAP9RGYYbZuhXkwHit4qJoD31YDcFt5XTMP7JPekrluQ8+QD+PyxF3Fa/gUrf
kXHMSjfsVuDMxC4EupjKVUMjGexKmA0=
=nnJc
-----END PGP SIGNATURE-----

--Uueo13zjvdFAPZts--

