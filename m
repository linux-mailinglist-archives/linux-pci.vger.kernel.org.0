Return-Path: <linux-pci+bounces-39452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4EBC0F85E
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 18:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9543019A6FEA
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 17:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD4F3126A2;
	Mon, 27 Oct 2025 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hte+cO7N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3A12D23B9;
	Mon, 27 Oct 2025 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584778; cv=none; b=uEYeWcS8OcbcH78vZEG+lD0jyVSYqflfiLWOkQXtFSSVnsTTWoG0T/pROtnltjTI4O7iQv+iWRAdaoNqdhv/EDWHDW5fzFTf+0MShQWEe3qfOxIDfUv8bpomUPY2jUv9X9q6aRG2mdaVlXRg6mmHZWc44V6pOAO4kc8nTLxblgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584778; c=relaxed/simple;
	bh=s/IT6TeCl+sjf5XvyVpD9Mw0igDSnNsMN5YXPmOt6ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSqenoTcnSS9Q9hs4EI0SLuR5FjTdj37iFumKwyFWzoQ+WKf919hgqXJj2RAUi6EuEhCz/1k9XNM2Zs1p4Cdh8WX1Ro+KVI8qjFpvAlFIWrQpT+LhZ/+1tXMeQeAuWFrxNmzueMSuL7KjzK91HR3iDmI3qNTMvWlbr7LiTKa3u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hte+cO7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9FDC113D0;
	Mon, 27 Oct 2025 17:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761584777;
	bh=s/IT6TeCl+sjf5XvyVpD9Mw0igDSnNsMN5YXPmOt6ZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hte+cO7NPhaVJDDIfAVKI1hV2qvWp/BZOrVn4nCx8EITZsHbJfvwFspfHqo9MUAjL
	 ytrWPOsN3g7xsVML/nD92R9CWhzUz8wwNy5UeBt9BbcFAtYlYyY1UBVN1hGoU2YzS5
	 FXPIPG0iuPbf9Lg5l6i2TPd2IICLwxtQ4K33iiMfIyb3QYCZ0IMTfnhI1eQuV+JFSA
	 X261Gjluf2siziuhSfJhIaHZr0JQinCWu7N7yTXW9R3F9jUlnZ/ofVIDrhHflH/q83
	 iSTC6EyUvWK3SThUgxgKsa+wpjqxi16zzTaWqeTrp/m+GUXXQiQHhzXiCnyG7rNznG
	 sjuEa2T47zbYg==
Date: Mon, 27 Oct 2025 17:06:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Frank Li <frank.li@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 2/3] dt-bindings: PCI: pci-imx6: Add external
 reference clock input
Message-ID: <20251027-marbles-tarot-92533cb36e1b@spud>
References: <20251024024013.775836-1-hongxing.zhu@nxp.com>
 <20251024024013.775836-3-hongxing.zhu@nxp.com>
 <20251024-unburned-lip-6f142d83ed76@spud>
 <AS8PR04MB8833DEEA9CB4CE4968B2B5F18CFCA@AS8PR04MB8833.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EsVnFdp8eh5fFMn5"
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8833DEEA9CB4CE4968B2B5F18CFCA@AS8PR04MB8833.eurprd04.prod.outlook.com>


--EsVnFdp8eh5fFMn5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 06:36:32AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: 2025=E5=B9=B410=E6=9C=8825=E6=97=A5 1:07
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > bhelgaas@google.com; Frank Li <frank.li@nxp.com>; l.stach@pengutronix.d=
e;
> > lpieralisi@kernel.org; kwilczynski@kernel.org; mani@kernel.org;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > imx@lists.linux.dev; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v8 2/3] dt-bindings: PCI: pci-imx6: Add external re=
ference
> > clock input
> >=20
> > On Fri, Oct 24, 2025 at 10:40:12AM +0800, Richard Zhu wrote:
> > > i.MX95 PCIes have two reference clock inputs: one from internal PLL,
> > > the other from off chip crystal oscillator. The "extref" clock refers
> > > to a reference clock from an external crystal oscillator.
> > >
> > > Add external reference clock input for i.MX95 PCIes.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > index ca5f2970f217c..b4c40d0573dce 100644
> > > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > @@ -212,14 +212,17 @@ allOf:
> > >      then:
> > >        properties:
> > >          clocks:
> > > +          minItems: 4
> > >            maxItems: 5
> > >          clock-names:
> > > +          minItems: 4
> > >            items:
> > >              - const: pcie
> >=20
> > 1
> >=20
> > >              - const: pcie_bus
> >=20
> > 2
> >=20
> > >              - const: pcie_phy
> >=20
> > 3
> >=20
> > >              - const: pcie_aux
> >=20
> > 4
> >=20
> > >              - const: ref
> >=20
> > 5
> >=20
> > > +            - const: extref  # Optional
> >=20
> > 6
> >=20
> > There are 6 clocks here, but clocks and clock-names in this binding do =
not
> > permit 6:
> > |  clocks:
> > |    minItems: 3
> > |    items:
> > |      - description: PCIe bridge clock.
> > |      - description: PCIe bus clock.
> > |      - description: PCIe PHY clock.
> > |      - description: Additional required clock entry for imx6sx-pcie,
> > |           imx6sx-pcie-ep, imx8mq-pcie, imx8mq-pcie-ep.
> > |      - description: PCIe reference clock.
> > |
> > |  clock-names:
> > |    minItems: 3
> > |    maxItems: 5
> >=20
> > AFAICT, what this patch actually did is make "ref" an optional clock, b=
ut the
> > claim in the patch is that extref is optional. With this patch applied,=
 you can
> > have a) no reference clocks or b) only "ref". "extref"
> > is never allowed.=20
> Hi Conor:
> Thanks for your review comments.
> Just same to "extref", the "ref" should be marked as optional clock too.

Right, your commit message should then mention that.

> > Is it supposed to be possible to have "ref" and "extref"?
> > Or "extref" without "ref"?
> > Neither "ref" or "extref"?
> "ref" and "extref" have an exclusive relationship of choosing one of the =
two,
>  and they cannot all exist simultaneously.

Right, please go test what you've produced, because extref is never
permitted by this binding.

> > I don't know the answer to that question because you're doing things th=
at
> > are contradictory in your patch and the commit message isn't clear.
> >=20
> Sorry for causing you confusion.


--EsVnFdp8eh5fFMn5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaP+mgwAKCRB4tDGHoIJi
0vsPAP4/9G1yr5mqtW4MMNEsBBmPhvBRbfc5pGtMSd6csOWCmQD+NIs3jfUzO2eC
odBrXrqWr/VCwksII7RTlqmdC42I+QM=
=+M2s
-----END PGP SIGNATURE-----

--EsVnFdp8eh5fFMn5--

