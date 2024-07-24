Return-Path: <linux-pci+bounces-10732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5507493B4E9
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 18:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1041F28208D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 16:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71C5158D9C;
	Wed, 24 Jul 2024 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkKFNMpC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C8718E10;
	Wed, 24 Jul 2024 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838235; cv=none; b=CyNeAT+iSZOWzW+JmOXNaIlQdhbZ45dfQQQZAZzVb0ForvlAz7uDPSkIqcgszADXgb+5FjKdHpDNjD+Jw87FpQN1FMay6OBcD7MiDtGISn+v4FJMUWacJVgHl2YDlO4fUC4vdo9VKDzxBmjvZbJ75lX4o7ktRe0Y1D5VL65cK8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838235; c=relaxed/simple;
	bh=BmmCsrEKtkT6QYIrH14E6ieUaFyLJiDeKFWKx3Gt5fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bu+JOGc+odMh4k8sTpKpNR0F4lIvlJcYEzLaUjgsh70WJaM4J9Jew5uyu5Ns5JsfzJ68RSras39qenUhlbeZSGBPYeoFZV4mtV5MJ4b+6p0F1lSwi6XzWaCnA4ZoDjbBVWsTz04d9CDYHEnMKgcDBvrlBDBzwLSNCy6tWLR3Go4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkKFNMpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD62C32781;
	Wed, 24 Jul 2024 16:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721838235;
	bh=BmmCsrEKtkT6QYIrH14E6ieUaFyLJiDeKFWKx3Gt5fE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nkKFNMpCfiWbCFG+Pp1FtO3+vTnuz38B1up8r8fzu7d5Dl6bm23c2H2h8fjMQ4GSh
	 +hEsR0rLfmXoMerAoRvTQbyufA/ReMluaaN3r3cBL3QEStg2UiIrEqZmEMU9xUQvne
	 eVe0Vrm2hv0E5OCV8+m7U86bTebvMZT0aVsT6R/LFKiimOfb89jxuEK9Hf/46Osbz7
	 KNL+ZMRlGr0S6GOAAAdcdTTLQDS3frbcVyxwOOvFQvplmU1lv5rtZuo0MkmLX2LHJn
	 TRS06EDojNbNQinzoQdPt0B5iR4bDUH2lb0SbksHD7ef3fxZA2s67sl9ZD1fqKj6uk
	 ITh+s4US5DuJw==
Date: Wed, 24 Jul 2024 17:23:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v2 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Message-ID: <20240724-among-citric-cb3084658ae5@spud>
References: <1721790236-3966-1-git-send-email-hongxing.zhu@nxp.com>
 <1721790236-3966-2-git-send-email-hongxing.zhu@nxp.com>
 <dbcd776b-172a-4c53-b33a-3215f7dcfe77@kernel.org>
 <AS8PR04MB8676B0F1385BE39D209DFB698CAA2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <c9efb8a4-ca08-4e4a-97c6-de03ecea2955@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q2WNMnQ6djTo/dXQ"
Content-Disposition: inline
In-Reply-To: <c9efb8a4-ca08-4e4a-97c6-de03ecea2955@kernel.org>


--q2WNMnQ6djTo/dXQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 08:32:34AM +0200, Krzysztof Kozlowski wrote:
> On 24/07/2024 08:26, Hongxing Zhu wrote:
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski <krzk@kernel.org>
> >> Sent: 2024=E5=B9=B47=E6=9C=8824=E6=97=A5 14:07
> >> To: Hongxing Zhu <hongxing.zhu@nxp.com>; robh@kernel.org;
> >> krzk+dt@kernel.org; conor+dt@kernel.org; shawnguo@kernel.org;
> >> l.stach@pengutronix.de
> >> Cc: devicetree@vger.kernel.org; linux-pci@vger.kernel.org;
> >> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> >> kernel@pengutronix.de; imx@lists.linux.dev
> >> Subject: Re: [PATCH v2 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi=
2" and
> >> "atu" for i.MX8M PCIe Endpoint
> >>
> >> On 24/07/2024 05:03, Richard Zhu wrote:
> >>> Add reg-name: "dbi2", "atu" for i.MX8M PCIe Endpoint.
> >>
> >> This we see in the diff. What I do not see is why? Hardware changed? H=
ow come?
> >>
> > For i.MX8M PCIe EP, the dbi2 and atu address are pre-defined in the dri=
ver.
> > This method is not good.
> > In commit b7d67c6130ee ("PCI: imx6: Add iMX95 Endpoint (EP) support"),
> > Frank suggests to fetch the dbi2 and atu from DT directly.
> > This series is preparation to do that for i.MX8M PCIe EP.
>=20
> This all must be explained in commit msg.
>=20
> Anyway, this will be an ABI break, so explain exactly why it is OK to
> break the ABI.

And the driver needs to be written in such a way that if only two reg
properties are provided, it falls back to the old method of acquiring
the two new reg regions. I didn't see a driver patch on v1, so I missed
that this is what was actually the plan - I thought that this was just
adding two missing regions.

--q2WNMnQ6djTo/dXQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZqEqlgAKCRB4tDGHoIJi
0mScAQDrCdN9N+hytVE/UlNUGEVVwiDGq1y4l4IPkDsDAQMKVgEA0Z07x7tn8/PX
6RpN5hGJjqrWdBYkWTFj3QNupP3kHQc=
=PRJV
-----END PGP SIGNATURE-----

--q2WNMnQ6djTo/dXQ--

