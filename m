Return-Path: <linux-pci+bounces-43466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB04CD2A5A
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 09:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 145503018D60
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 08:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F672F5498;
	Sat, 20 Dec 2025 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="dGAsYOyw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6462F6920
	for <linux-pci@vger.kernel.org>; Sat, 20 Dec 2025 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766219078; cv=none; b=X5ENyf0SgxHy4wxmup7LgCWbGkAt9F9EwZQQJngoVEZIM4JYZvegjhdY76pOfxIzdvcjCx3Z5ek1sorPSHGkxdsrmcFqHHuRDd1p6g5Tz6RgejjvcbnfuQmbpfWu/r5onqZ5mlWbRfDEdE8DfdQgsRHlbVWUu/GBKS+npUNJS4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766219078; c=relaxed/simple;
	bh=iG1jcE6qfNDLs4GAZzWD+9GDWLgHOOnYN+sNdvLbCJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZuhhbU4bpcVp0sgNqYatVbVQBpZQ84YEVNqy/85siYMjqaU2TIKU21CRdb7YdPcDlBY/n01x3qOWp62YvCYgFV3rdMkgr3/0/xtlDa/ceycyPQ7U7qzlkBrJ6bYpmx/oO3Y40+zddToHPNSqF8bmp+5x7HOecgvOVMEydComvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=dGAsYOyw; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=iG1j
	cE6qfNDLs4GAZzWD+9GDWLgHOOnYN+sNdvLbCJ4=; b=dGAsYOyw+bodFDqat3VW
	mEHasllOHtivGc5kBOWsElCvoP5i7DRuyVU7KQP+L4ETKPzrvP1pNh3/Z7i8d4co
	mnAx4vvTJIL6ZG9zY23WzpQNnI6Us+/RIPMgL+5qG1uKcY3n44lmBHH2KF7uUbGf
	ZaaJl0lwDDR+7yi/+B5XdTnWp3hkRwyZAKrnMv69bWPGMFSOQqqy1Kjv9tplvXWo
	APWRSvp/R5Ts+c0FL98tpJoEAyZYplT5KVuNe64v7XsgVTmNduZcIIDzb9ihJgEF
	SP99n3wg/hD43p6eFIgt5iW3k6+O+zWIB937viUmMnC7jdhDEaTlRUo7aEmFCKYm
	aQ==
Received: (qmail 3031979 invoked from network); 20 Dec 2025 09:24:34 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Dec 2025 09:24:34 +0100
X-UD-Smtp-Session: l3s3148p1@WYGF7F1GluggAwDPXwGNABSvzf//pZhn
Date: Sat, 20 Dec 2025 09:24:33 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2 2/2] PCI: rzg3s-host: Drop the lock on RZG3S_PCI_MSIRS
 and RZG3S_PCI_PINTRCVIS
Message-ID: <aUZdQdXNDdZka-JU@shikoro>
References: <20251217111510.138848-1-claudiu.beznea.uj@bp.renesas.com>
 <20251217111510.138848-3-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2WdXUDGOzbmf4s40"
Content-Disposition: inline
In-Reply-To: <20251217111510.138848-3-claudiu.beznea.uj@bp.renesas.com>


--2WdXUDGOzbmf4s40
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 01:15:10PM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The RZG3S_PCI_MSIRS and RZG3S_PCI_PINTRCVIS registers are of the R/W1C
> type. According to the RZ/G3S HW Manual, Rev. 1.10, chapter 34.2.1
> Register Type, R/W1C register bits are cleared to 0b by writing 1b, while
> writing 0b has no effect. Therefore, there is no need to take a lock
> around writes to these registers.
>=20
> Drop the locking.
>=20
> Along with this, add a note about the R/W1C register type to the register
> offset definitions.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--2WdXUDGOzbmf4s40
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmlGXUEACgkQFA3kzBSg
Kba5Hw/6Amw/o1dacj0BBfAk1oRfxilEfriFjqIu+fjFZKo0OUAIrQfak8+ksK/2
IPC1e9uJWgpss071mm9pk8HXzzSXcxiL0zsWhnbX5rFAUTnYm2v3h+vrckEIQzKl
2u0nkgjDuKJD1Fnf8DMYpRkC7Jmwngmd2qI7uIlVDmbnm7PPVfZBCqWCwjsdPk/f
UNBx5XLCVddOykpzekKkR4v/K58FHFTIUX3eTG33q6AXhoJ3XAisfDY4D+IRWpW5
/wZ8wfC9xm4D8oF/APzQA7e4a+luaEzwMaJlJA1cbe8hLnNgtpjQPKXzfxPQZZd3
zOl8rQUnmOnmz5imPw9Y/ovoNjXR/Iod51Xzbm8bAB5ACSqI5DvoxDQaoBbod3uQ
b2gBPqBJSVkubwBjQOeSar6sj6wDD4oDJ+olD6ocUOAoc8M7GMndYnPLC506PyJE
VekAui8jVlEn6WAqJkr5gTSvrlE1BwlxuFsRIoEs7tdW8EFrMOj9lD9hiBFc3wuY
GUCwPHKj/KC7B4zzaDz/N1B+LQL5XBrNKtsUtbqKdO+IyLp1kEZe5K8SAJD4T0vO
vYeshaRzhssavDqweahEQGmh5NcNrSK6JXuaozpWnFZBMKqAaQG2mc2dkC40g9JW
4eJ23Qsv0owWEp2fwPXg5avgK7SwKSPA4Z4rKGT4v/KGlwWChvw=
=ccj9
-----END PGP SIGNATURE-----

--2WdXUDGOzbmf4s40--

