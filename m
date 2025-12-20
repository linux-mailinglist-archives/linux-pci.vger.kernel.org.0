Return-Path: <linux-pci+bounces-43464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A19CD2A4B
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 09:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 116933016183
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 08:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CAA2F691C;
	Sat, 20 Dec 2025 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Dz5hbKlA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C1D2F691B
	for <linux-pci@vger.kernel.org>; Sat, 20 Dec 2025 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766219053; cv=none; b=hrRSoYqcAz11Oy6e18h2enEUGujKpdF0Y0JDmCpMZduFXffBMHgICN4Ri6/9fG0DMYBeS0G1TBF+b8jfkLVsn3LsrjWJsqopMAehRkF80d3+kHyZ6JIIhKrl2n568OtI+6N0hYMTwuFZkPEFXrTMRDFfVsnmGBo2VabyMIxXSqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766219053; c=relaxed/simple;
	bh=3UJys974ca/L78A/l2am0ajSl9xwcmkjU42S62UT2wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyvMbETXM3TbxDJPFFVeLNNBmatsXt3vVRtCHVNIn63+X4Y7HJKrExuvQ+DOQPzY0PyjRh4uBkhs/OchaXVO8V5upt3sNm5Vv/Jm5KUmOamhDuwzpovoawv+HaEDfarS7TPGGzPvtpho57c1TeXh9LPjsr+dzj+/XTqwQQmDrNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Dz5hbKlA; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=3UJy
	s974ca/L78A/l2am0ajSl9xwcmkjU42S62UT2wA=; b=Dz5hbKlANwajKmrn0NiN
	D9j2+qcpsE3Yk6Re74B2WLX/rEEkxDDKqI/rZukYdGbzAM18XF7WfkpJG3PjwMgD
	FqnSxDCKiLg26Foxodhs84v57EGrMszMtkEGuMu+KrcwycQHpNoSKtstHM7x8ec+
	ghXmboZ9XWB7Fzy6fJGAwLnoZNyUo5+AyzOTCNqlGIx5DPghg3ChhvQIaaE1VIre
	I2xfDIVR7ldEvOnTXBfYPePSe2t/JJE6S1b8so48xfkxkLcBLdWpHz/IRfxzkDmX
	2B5xkd2esOdnPj1WuRVJ53UC47zE3SphZdV03nGN+aRbuNIXqFXwzqg7h3gyuomR
	FA==
Received: (qmail 3031764 invoked from network); 20 Dec 2025 09:24:06 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Dec 2025 09:24:06 +0100
X-UD-Smtp-Session: l3s3148p1@0a3T6l1GBuIgAwDPXwGNABSvzf//pZhn
Date: Sat, 20 Dec 2025 09:24:04 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2 0/2] PCI: rzg3s-host: Cleanups
Message-ID: <aUZdJAu_ANUGxp02@shikoro>
References: <20251217111510.138848-1-claudiu.beznea.uj@bp.renesas.com>
 <aUU6J5anuzNgSeBr@shikoro>
 <d1a9a430-ac14-4d19-879b-57287b434cc6@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7gf4iU54egmNSpgO"
Content-Disposition: inline
In-Reply-To: <d1a9a430-ac14-4d19-879b-57287b434cc6@tuxon.dev>


--7gf4iU54egmNSpgO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Claudiu,

> I pushed it here:
> https://github.com/claudiubeznea/linux/commits/claudiu/pcie/follow-up-v2/

Thank you! Needed two tries because the VC3 driver got disabled in my
current config, but now it works with a PCI-USB card and attached USB
devices.


--7gf4iU54egmNSpgO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmlGXSAACgkQFA3kzBSg
KbbvkA/9GopLG6PWwaLVcXJQb460uNA1+UC1HzxI9lgWuHJzMBcmUb3xBnI+UNbl
2Jrp7TuTmTuF8zlNB2Johm+f7AMDBCaJUwMsQ23CrF93NCq+LeeMT8hAeFQ2sGN9
Kg8vxbB6KrxoqNlu2rWerlBCtLkWYs7b06SJq/S3hVIF9vaQXxrDQbf4bMpFlW+4
8dSjmBCAF2sItxDFIoWGX67QUAh3YScZ19Dngd3H4xXCDrGF3sfDJmqbcmCvWomK
iIGBX7j9ebHlFt07drm1NhvjNz/M6ceuzOnAJeaaSEYaSlFbs/j56p/nyZ6JtlQG
7vT4yyTFQeO2+CBzJzxykJVOz1aN6WoDhhHYE/AmRjioDbdc+Vwa/H3wn/p4XUI5
8cd4PSG4hzEwgu7DrIcJtPt8T1ub0wdi5krjBUqAiG+u8WojItk0/ezobkGtPfcD
Iq3p/JZiEjXgwAfIWwJL/o2Ddr8Kf3PoefjVgnTiss2sAI2uAbXyS1Q4z3DC3h5+
OiG4pQ6XLLaUFT+7uvkCItBNIdufiS4666i99QHhDQczWiEThJNgEPCNZZAQepS9
s8/D82PZftmzQddEydG8b+13/QHOqT15b1S1KggBQFbsvI8XPayoevFMLMDH0k71
tWOtrnc2JnmF19M/Ck4QgVU5Ea/h2BAfidgBA8AmGnvELtS3oiw=
=vr6J
-----END PGP SIGNATURE-----

--7gf4iU54egmNSpgO--

