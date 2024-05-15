Return-Path: <linux-pci+bounces-7485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8EC8C634D
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 11:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEEB8B22ED6
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 09:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF905BAC3;
	Wed, 15 May 2024 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="cGqTzRya"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B165F860
	for <linux-pci@vger.kernel.org>; Wed, 15 May 2024 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715763588; cv=none; b=F8eX7oFB9KZUgbVf/YxvdNyo1SJw7kBRBpwRK5PzxW9Qh4ToBswPfVgbOO4TiHqW/mxj9B41a41qVSNleuXutw748lhXv5RP09sOtn+CeiBoKZ2ciFos42zvNqDHKhp0n55zm2Y9YFFDOGRjPmbO11qIHxTPlBDTojFdusojZQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715763588; c=relaxed/simple;
	bh=D6GhC0YwDKVPvW1bVjTDGYlZXc/nCX9uJrXH9PR08RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMvjDARgPc9zm50Y9tV6S85lQkS7HI59Nhji5oZk/M+da9MemJcRGWioWiWsAxnfMPfmr/SEANuABifeAuOI1NfeUGhyPDPuKuvp28SepRqZJqF4it2EElTo/c0RWQmdM/0sIgO8ILktx3sqecx75m2xTsh6TRcJLFq6fqhvF50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=cGqTzRya; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=D6Gh
	C0YwDKVPvW1bVjTDGYlZXc/nCX9uJrXH9PR08RU=; b=cGqTzRya/lQ6D3wep+Vc
	NAmScBZ1RR1+gs1RClXRyJZuRnptCyxA+yzl25pAYdHZPEXYLOShMDmx5yddaGR+
	nt4B10fFGBACwYRQ65dU/HSuuRIhfUYR2FGV8deRxbkk8/sJkhoAKuh7cFxSBCH3
	1WFbtVHId2H7fJn4zz6JGT/Wh8jyu7nl8Y2q1kn2OJLnsTZWe99ApUQ8Kx7XGPsl
	Vs8ZE+e+pB5Vfo/NRHYylgdTPnjUWb+pThnxotUgGhsWLn3dVw3MrsoVE+BWaYDZ
	HZwuhbdiZC6yQ0gZef95y8pT1WQ5i019Q//wZg1X88Rwqe+gVdrLTqplTeh7xXCT
	Tg==
Received: (qmail 2768330 invoked from network); 15 May 2024 10:59:40 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 May 2024 10:59:40 +0200
X-UD-Smtp-Session: l3s3148p1@C+awVnoY6NRehhtP
Date: Wed, 15 May 2024 10:59:39 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, 
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v7 6/7] PCI: rcar-gen4: Add support for r8a779g0
Message-ID: <l62l4ksr2rkxxi7kwatd3pfwmwv4ytfumhwkthjsurgla2prno@felahg5h5g7o>
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
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gknpxbotva3zyy2v"
Content-Disposition: inline
In-Reply-To: <20240515075954.GB4488@thinkpad>


--gknpxbotva3zyy2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > This is because that Renesas is not able to distribute the firmware fre=
ely.
> >=20
>=20
> Seriously? Are you saying that the user has to sign NDA to get this firmw=
are?

No, the user has to buy the SoC and will get the firmware with the
documentation. Renesas is not allowed to distribute the firmware to
non-users of the SoC. So, linux-firmware cannot be used, sadly. We all
wish it would be different.


--gknpxbotva3zyy2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZEeXcACgkQFA3kzBSg
KbY28g//fAiWwVXCIY0HZwM+kpVsJcyN2UfFcXhsZrMr1WG0+fFgI/40zx170hEd
BMw4YylIudWqWb+SmiU9gdJ5LDYAq2WWcQxo7+kVPCXjwTqlvIKoKOoXX55XKnGK
HZtaDZguzprFDB0Yn8DU/l+iZwdFcqoQmLfUODzSyHekpu1tr/ZY5cPlGM+5Ih4a
uZ8Xg3ydcZ4w9q+ZcSYtAsdQJZqk6gFQTdOqXrzRsMK/sad2iIB//8YbgeyUzBi3
zBd5lg+DD1QmxlsGMoLZ8rICO++yoxci06zjl3jj/q9IFocINKcq7c0R8jP5sMKv
4n3eFd9kVQO1EUpXlqmlw3Y9IvKFNlshmkb9zFNIXKhSJwXsw/cr27o9A5vi1B+x
e7gKKM2NYGeTWZ10ZZ6k7EU7crO3i6yyZWCBIwQd0PI0tnLpYhnAHJz77NY/HiKt
xBNh8fZBrGBC9tiRb2RziLr3KDFKwVQCZH8zk0319wC1xj0HDH9l5Oibo1H3Mc7A
w03NbuRJSYGAJAGa6I4gfU1MPgL2E7/uxdBqxWLL1yNLkTUD7Pq5jKwPg0kQUJTI
b3GMZKj7ecBfJgR7pxFhZZ8dpkiGojRIx2THcQmD7Qu/vddJvDrKVgoeutzcSKkZ
9ULoUFK0ck8DG+J41BPlyt0IC/2shadpziSGJOoYW5rUzixhCzE=
=dwLH
-----END PGP SIGNATURE-----

--gknpxbotva3zyy2v--

