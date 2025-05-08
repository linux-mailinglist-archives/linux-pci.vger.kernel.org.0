Return-Path: <linux-pci+bounces-27435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 335AFAAF657
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 11:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2361BC7FE3
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 09:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B0C23E329;
	Thu,  8 May 2025 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="P1AzCW+u"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525C7EAF6;
	Thu,  8 May 2025 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746695333; cv=none; b=nMlRoYAGFU3U4sFtEQ8Ek52epwV9W/ccPnyWSduAacz7lCtq5brmk7aGi1MUC+01r+o+uNuxcAy+CKg0k8F2sRIFOpEoKSwciYucekanbVQSc1ROjTUmaf9dIqdW2/bxZZmlyrn/4V+SlGxtF98R4lCoG5irRRu5OXLSZ1W1fhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746695333; c=relaxed/simple;
	bh=8SkZUgZyYvBe6FFYuWQO+cRb9j2orVXbhXcmpKeqvUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQ1SpRo/RrIVtgrDXpmv0L1/1fISzDyOfzEZteGLg0tM5e+8wtDcCgLlMha/BQK465sdtW596D277HMgbo+euaFb94AF9H5Z1b/mbGxz+5MoN67F6dFZNZ2vAJPQ9NkkJWkHB90mPBbyvOWHNo97NOKHcucVH3FgDr1/L/zQVoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=P1AzCW+u; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1746695327;
	bh=id4tiKZeuAnKN2fZO6welXUYOflEk+8g59ZcxNs4qH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P1AzCW+u4qMYXiIX5/BSQNbnUd39IPimyLd2ADJx/I5yqQIj7pIyQMUb4wRSgSLPz
	 VSNfFer0Q7SoWRzQ9ZF/Q0NcWwf1zdhz5q1uIv65m0knDjVPD0YI0atE4+wqjPJ92j
	 F2TJAePl9VPhw2H6/tPpOhIlOX8dKNrFnLUsirQ+9/Eoqg+ZmJdg4yG7ZAWKwrzR3P
	 MH5Kkd/JJTU6ZduOcTvmmhcZSahBE55wTBb5GQ0qw7L2LdM0Q3OIsysH7B/GWAzq2T
	 vSsiC2jmDbaNeaOxLHVvhd8/ivd+KHHu+2KrXmlP3F/S4jNwygF1mFITVhynGo8VuZ
	 ca75gcqzuS++w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZtRBk5lbmz4x21;
	Thu,  8 May 2025 19:08:46 +1000 (AEST)
Date: Thu, 8 May 2025 19:08:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: [PATCH] PCI/bwctrl: Remove unused pcie_bwctrl_lbms_rwsem
Message-ID: <20250508190845.4cae8b62@canb.auug.org.au>
In-Reply-To: <3840f086-91cf-4fec-8004-b272a21d86cf@paulmck-laptop>
References: <3840f086-91cf-4fec-8004-b272a21d86cf@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1f9.u.3IHguvBWiXX3dmh2T";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/1f9.u.3IHguvBWiXX3dmh2T
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Wed, 7 May 2025 15:04:57 -0700 "Paul E. McKenney" <paulmck@kernel.org> w=
rote:
>
> PCI/bwctrl: Remove unused pcie_bwctrl_lbms_rwsem
>=20
> Builds with CONFIG_PREEMPT_RT=3Dy get the following build error:
>=20
> drivers/pci/pcie/bwctrl.c:56:22: error: =E2=80=98pcie_bwctrl_lbms_rwsem=
=E2=80=99 defined but not used [-Werror=3Dunused-variable]
>=20
> Therefore, remove this unused variable.  Perhaps this should be folded
> into the commit shown below.
>=20
> Fixes: 0238f352a63a ("PCI/bwctrl: Replace lbms_count with PCI_LINK_LBMS_S=
EEN flag")
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: <linux-pci@vger.kernel.org>
>=20
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index fdafa20e4587d..841ab8725aff7 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -53,7 +53,6 @@ struct pcie_bwctrl_data {
>   * (using just one rwsem triggers "possible recursive locking detected"
>   * warning).
>   */
> -static DECLARE_RWSEM(pcie_bwctrl_lbms_rwsem);
>  static DECLARE_RWSEM(pcie_bwctrl_setspeed_rwsem);
> =20
>  static bool pcie_valid_speed(enum pci_bus_speed speed)

I added that to linux-next today and will remove it when it is no
longer needed.

--=20
Cheers,
Stephen Rothwell

--Sig_/1f9.u.3IHguvBWiXX3dmh2T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmgcdJ0ACgkQAVBC80lX
0GwJcQf8CE7RayjNx5JFc7duQEtmFdNwWH6ceqhtR7LbFMfp9hC0R1tw5auPKrfW
rUzR0iZiLbfhOhnPg/oL8jiNLDAqU8ueMLYqW9qVzkgtOa2LN9aFvGxIoJhKxY/6
Gpnyt6oqGJVLBxqMPHYwtDRNWHpEmp63Wr3EkxG3JJk0X8EK+eFhGs8Na9gM/bi1
tHmusQAlIBpPngj7hMX55E9lz0m8/PSIAAFNJiyOCwaOv16dLe7zpDlkBt5MHYxe
SN7zYr7EIBvvDL2DURFB1dPb4kpzCAUyq9bqzHV5eTDkquD9npoSlf2iiuVif8jD
OM1Yah10nyEDCRjgx81qDiMqim/MkA==
=4Bpa
-----END PGP SIGNATURE-----

--Sig_/1f9.u.3IHguvBWiXX3dmh2T--

