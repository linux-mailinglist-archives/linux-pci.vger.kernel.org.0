Return-Path: <linux-pci+bounces-7486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FEC8C6367
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 11:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4ADF1F211FE
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 09:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D41A56B76;
	Wed, 15 May 2024 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="U1bF4n+h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B022554903
	for <linux-pci@vger.kernel.org>; Wed, 15 May 2024 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715764148; cv=none; b=UlTlBKvu8oiCHerDXuirFUpv+2YRE9tcDbVQkUOT1G3JVguDKcBCVQiFs2k48WWojdwR34DzheKApvfHo/oarJeYqa4ZQQUoG3Xyxk/7v0UscHuePHb8pNv3upqXi5qgD9bBG2/pLA18BGl3upzSheI9VgOEpNyXH1fGB5d3RFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715764148; c=relaxed/simple;
	bh=zv16F37AidPawEoWnbMIbBxeozEKI5aIumtzE/9F23o=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRTaiycdz4l/pwZ2Zzfz6MuJpZkbCLcjjm/Fabt/jy0zJbwROyebNoSEwVrpqVtfUAe6Q9a2pZ5Y20ObO6soGx9OBuqettZH6FJTg6zKVljAdRiTAvQcod/YUsInG09I81D41LYqaJ51w5S4c9EWc5Fou0XTSRTLsMsS1SMOiyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=U1bF4n+h; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=zv16
	F37AidPawEoWnbMIbBxeozEKI5aIumtzE/9F23o=; b=U1bF4n+hlIJBMCFyOODj
	IY2TWisQSeNdd0EdnxLokEMVhX2Kg7bYRSr2RXFwlOX5wH6oyyWbcxD09ELke30I
	M3BLXTKqLf589e0JAbolgDLpoPJXfKP1HVcZ0fxbh3rcH1Zm34IBReB+dRMbatjD
	o4bZVgFFAR4Tt8/VKuQMM+/0Bvn8wPuoUnQN+//o+uziyTeXw6LY7tZWBirUBH7U
	iv7cBHeYsVUvxy84m3Yi40hoKww/Fna+FcxQEmbETM/GYTvO5vtU8j4mdIM8n+Qi
	MxphY01fqU7+Tj4Aawkar094fEmLAkPw9EDWtLVfGAPZ18uzS3Edkwrcu7HheBz+
	hQ==
Received: (qmail 2771315 invoked from network); 15 May 2024 11:09:04 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 May 2024 11:09:04 +0200
X-UD-Smtp-Session: l3s3148p1@NhdVeHoYcMZehhtP
Date: Wed, 15 May 2024 11:09:04 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v7 6/7] PCI: rcar-gen4: Add support for r8a779g0
Message-ID: <ttyjo2w5bkjbmlrw6oxwuyfshxi5ohwhudj5oexhecqorqnt3t@umjxxcj6iu4k>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, 
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
References: <20240415081135.3814373-1-yoshihiro.shimoda.uh@renesas.com>
 <20240415081135.3814373-7-yoshihiro.shimoda.uh@renesas.com>
 <20240511080257.GF6672@thinkpad>
 <TYCPR01MB110409C8FC92A7C466627E0A2D8E32@TYCPR01MB11040.jpnprd01.prod.outlook.com>
 <20240515075954.GB4488@thinkpad>
 <l62l4ksr2rkxxi7kwatd3pfwmwv4ytfumhwkthjsurgla2prno@felahg5h5g7o>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nljzks2p6utui7p4"
Content-Disposition: inline
In-Reply-To: <l62l4ksr2rkxxi7kwatd3pfwmwv4ytfumhwkthjsurgla2prno@felahg5h5g7o>


--nljzks2p6utui7p4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> No, the user has to buy the SoC and will get the firmware with the
> documentation. Renesas is not allowed to distribute the firmware to
> non-users of the SoC. So, linux-firmware cannot be used, sadly. We all
> wish it would be different.

I am not a lawyer and all this. But this is how I, as a contractor
working for Renesas, understand the situation.


--nljzks2p6utui7p4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZEe68ACgkQFA3kzBSg
KbYjhw//fCcWz0aJmWDSQyDmeYSVa3c6JvQZB3tXFPn5fNUpPUohNGrUIpov2oaK
YccbjSDyhXfrC8w9sE6Mbs731k3UU/y+Hc+W1QP6qvALxZLHNVd9tx48Mpy6oLbu
/3kieqGVcRoD0MNb4cFJEehjg1XcD77otRfV34L3HvPGZzaJ4Hjv4CAGNgJe+x/d
z6/FwL9NC+5rRXWvSV3OsXfiR0oMurhx+/QCPupIvtfWsQQpp2QhZ0wpqscBshFu
CW4pmHJDZcC8o4hgKsg/7HvxzqTr6wlCTud+5QZxSLJKrzAsIznFw5vkzjWXWbLm
Y/xb6thL/Ospf3RcTx9SpNsiQz0cAg6vYu1uTVY5XxEnuUldVrIeLskwVkLkEAxJ
d/tjH9OToZPLi0zlXN73Bpn7EvY2HJw9Zmu1gKOGZh8vCi48jcLCKJy5+F6Ohflk
Z1mbW9dp398aYZt+ox0w7bWYOm4XXL8JJ6btPGKI/5Wo+h9chHuHAumjH6trU83D
LhxYxMERY3ikAlcb6NbCg7rYjNCX4HBTtvjjgdscQ8jN0ZES2TGMfOm5KLv8iEHC
OK4cUNXiT/rePsAqZQHmSpgSeEG372GBy05swuZ91CX7YwK3iN0OYEN773yQnsY1
MH4sVZf0yWBGSCNR20pCIRryv8ZosKkbKTRzj8Ndxpkcrf+dbRE=
=p4IJ
-----END PGP SIGNATURE-----

--nljzks2p6utui7p4--

