Return-Path: <linux-pci+bounces-43371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE50ECCF9EF
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 12:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB6623037896
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 11:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EABB319859;
	Fri, 19 Dec 2025 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="beP+Wksi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DEF3191D9
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766144563; cv=none; b=lNAZ/G8WD67Ihje4YfUkcFwRK5uMCa15q55gUOBtWHFA1G2V6TQnnAB8IHqVry0lseKwjhkLQy3tQK7S7XqhNvjTn3Vw6JAXs+5wMCAN72WMQrN+SBkNo5nJtSqg+gFB4bETAhisoHqLpdceGgKG/Iz8K81fxGWEpzslvxYbMF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766144563; c=relaxed/simple;
	bh=zL7engRo/banfwY1Stk7lMH1O0yQqknOwp1bbZ1W0ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAgwUqsaWfJNQFqKunDbFVxtaTgvkDZFtTcejIDWuzBMziXHpaJCWW/cpXxLJIHENqm3b5vcnSwbsvKf/PXHNrC7DEQBCY5TtTFgRiqgH2m9YZNjJmA/bZOmw8OYgssUXmUaMnHiWuiq5lW+pUIOA4D21ghFOvi/jL4GEhmjLhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=beP+Wksi; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=L+kA
	onvA8tGcUoDKK87s10mLv/ur/3acBHO3TZ1Z7nU=; b=beP+Wksil3anlgKe81W9
	1qsYpv+5sG86lFGVKB+3vG1X0OV1xS/5AaeQsJ9brphm427grxwswKudPmCFPtpL
	l6U225tVOiHtgU0wbwEFyzccTVuzr5cko2Z1VjRmaTzZac3pUOzFfGtaLR341KHx
	NNE2OEeJyygn16EdMCFvWB/iuoX+poG5IEv6KpfOm/tx4twOpjvLrdACP++tnpN9
	ps2xsk+7gG+xrebesWDc1ng0oegxa3anKFKtDS5KrM7RbNyE1qO7/IYCdy/sjbcw
	X23jZQRc4eBGA2f9VEuiPtZYIpDN6LCHpYB5F6KIXun9uIWRyyqDm0vU21uAIzmG
	Rw==
Received: (qmail 2652176 invoked from network); 19 Dec 2025 12:42:32 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Dec 2025 12:42:32 +0100
X-UD-Smtp-Session: l3s3148p1@iVOmkkxG4OsgAwDPXwGNABSvzf//pZhn
Date: Fri, 19 Dec 2025 12:42:31 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2 0/2] PCI: rzg3s-host: Cleanups
Message-ID: <aUU6J5anuzNgSeBr@shikoro>
References: <20251217111510.138848-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sKvJ0JMY7IDu9Fs8"
Content-Disposition: inline
In-Reply-To: <20251217111510.138848-1-claudiu.beznea.uj@bp.renesas.com>


--sKvJ0JMY7IDu9Fs8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Claudiu,

> Series adds cleanups for the Renesas RZ/G3S host controller driver
> as discussed in [1].

Is there a branch for testing somewhere? DT parts seem to be not
upstream yet and I don't know all the dependencies probably.

Happy hacking,

   Wolfram


--sKvJ0JMY7IDu9Fs8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmlFOicACgkQFA3kzBSg
KbaSWA//WpD+/mHi4lGxi/XijN8bD9DEdn+cL8wgoUefsTrvxVq2cidlj3bl3CDq
fsGtmMYNc13mOn5ziIJR5wqvegQ+dtbyxuNTjPIwkzb5b5w0K8422J+qwRsUdhkV
8ry7g+HsFMuxTN6FXOVM70XTKkhzprnP/P78NsNnOGJL3l+jyDxs3mrjnUF4Z8bg
ZasmtiXj1bZ9NIWOub7XYcq8dkK/fKTN8/FSpO9gnC/e6e+mMOleG7B4fAui5Sb6
tzhDPZpr8Bm9AOykwWZzD+AnslA9wIhs9JidKlnFKHTM6khx7eRXFSKF/HtKPbXF
nvPiXIyzG9hU1Fi8DAizuVm3ncikBbs05kCuImIaT44YXz3pc1ymbgdED9nzkJ+/
kPn2l+nOb9cfgQ92/Hbha017MrFoI+Dea8xSJLK4n04hrkLp2KYTLwMCLJIVAARJ
e/1QyCKH/H5avl6YMRwR08/ss2tR0SXPNGtuDJ69KW0NoUt4BvES2QH+j6k2jnll
HJxU4HnPskuN7scgkwu+pIvXcVSpbWljFSLFmaxYeeZGOzTOEegZoqM3pLi38ROf
+nA0dg2d2d6yyQYN/of/kmh3wdpYxXj9z6ojFJrtguH/SKbjKoin2N5Frz4+R4cf
zIxJX097Olet1AbWhQA2dKzWKJ758ZYakEjpYHL1fSZs1ZLvaoI=
=Kgt+
-----END PGP SIGNATURE-----

--sKvJ0JMY7IDu9Fs8--

