Return-Path: <linux-pci+bounces-14845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6049A362A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 08:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2740A1F25034
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 06:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E45C17C21B;
	Fri, 18 Oct 2024 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="WbUjGBPN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="dDDvIocM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85FB175D5F;
	Fri, 18 Oct 2024 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234389; cv=none; b=ScuHE5uvHG1y6n1Qsk5jIjpqaQoD/mGKzi1Tf7rQaK4bEWeqeedNwOaMVESx3RuRqbTm1DjH1uODKWsYOg5ACdFVmnvSmcdz9GWZyENadiL55i+rRePDDmA+d/k6+2f4Gp5z5UOZ0GoJGNmkvJLuylLzFhTGkbrnZEdffo7RFvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234389; c=relaxed/simple;
	bh=dd79JXjqD2Inpu0DT31fpEk2eIY2MmSwqg8qI66yzgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEEwUIda5b+0byuAjwS+ej8YLYQ7oANH6zMHv43So2s9zqx9VZTd+OxFYnSC1SThUQ1baVol8s1LyNg09flNCebio5oM8q46dkPrnvp4HP2W4kphFLZVVXGc9/10mY9/m8Qm0nV/UoLgsn2b+Amq9NWmO+YxfKpB8K6NSkW0PD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=WbUjGBPN; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=dDDvIocM reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1729234386; x=1760770386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AOulUfPRBlXnZ1KIBNZoiOR6DzCBisOIaMADQx53Pk8=;
  b=WbUjGBPN6EY1UmqisPrmo2wQHdtWWLjMOmSd+kzOWx0y9JjVgku+7CaZ
   SNDqWRnhkO0TpznFlAk3e3eg2NKJUUoFw/PleNOdHKOTu6A3ahaSm+HRX
   98jH7tKNlS79/IxMfQneEM4C/+NKBuhRlAbfOAg3W+ZLFR11x/fFkctGu
   q3c6RjlZ8M5pluzmcOwvo8mYt7h+HfGrQoKWRewLZpc5zGdPgyHKa9xmN
   8HXOtuXCO+IwmE2G2x7eJEkJIaCUPm5ZRTIiqyobYHV6Xq1zloIqk2oYf
   GlRhcLz/c+VsREWbhV1KoWWkPcaAHaubYKBYKm7hlT/ogNFWy2P/5ykXl
   Q==;
X-CSE-ConnectionGUID: R/jNJlE+S46o+UEHtedAiQ==
X-CSE-MsgGUID: kAkKmz8cSJmj4GNr4Mj4qA==
X-IronPort-AV: E=Sophos;i="6.11,212,1725314400"; 
   d="scan'208";a="39533507"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 18 Oct 2024 08:53:03 +0200
X-CheckPoint: {671205CF-B-69FF9A8E-EE9CEDAF}
X-MAIL-CPID: B5F18021BCC74157624FFD4DB3589D2D_0
X-Control-Analysis: str=0001.0A682F1B.671205CF.0082,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3588816A505;
	Fri, 18 Oct 2024 08:52:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1729234378;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AOulUfPRBlXnZ1KIBNZoiOR6DzCBisOIaMADQx53Pk8=;
	b=dDDvIocMcwuq7gjz2SZ8X4aCFesIG/2l7z2zp0RNsE3xB87lvFsvG363AIiMYJJzmEAFex
	l9Toa6J/9fwbyrZsIjz6hhD9ll1QCvrAKQcmonbRljTZ6gZTbqqkK8IQ0+rm7QYqqs3DIl
	OjCOtN445vhYDrr3A1qMwE8nU84x7ISVMKI79KJFmBPIoMQikjFwXQQxs7KFtdr7k/PjET
	T7ghFp32zR0NBuiLqqm7MCUpq1rROCOD8XXF0Us+DFNbwQpEx/6hll48p45Hq2vjh+gxyF
	pE96m4L/HVFVrGSDrOqbIShZkWG23RWTOgWlNkK91HlNE084TQZmIhQWNCumEw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Frank Li <frank.li@nxp.com>, Wei Fang <wei.fang@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bhelgaas@google.com" <bhelgaas@google.com>, "horms@kernel.org" <horms@kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 02/13] dt-bindings: net: add i.MX95 ENETC support
Date: Fri, 18 Oct 2024 08:52:55 +0200
Message-ID: <3657116.R56niFO833@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <PAXPR04MB851058F40F264FA9D20F385888402@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241017074637.1265584-1-wei.fang@nxp.com> <ZxE56eMyN791RsgK@lizhi-Precision-Tower-5810> <PAXPR04MB851058F40F264FA9D20F385888402@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Freitag, 18. Oktober 2024, 03:20:55 CEST schrieb Wei Fang:
> > -----Original Message-----
> > From: Frank Li <frank.li@nxp.com>
> > Sent: 2024=E5=B9=B410=E6=9C=8818=E6=97=A5 0:23
> > To: Wei Fang <wei.fang@nxp.com>
> > Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org;
> > conor+dt@kernel.org; Vladimir Oltean <vladimir.oltean@nxp.com>; Claudiu
> > Manoil <claudiu.manoil@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>;
> > christophe.leroy@csgroup.eu; linux@armlinux.org.uk; bhelgaas@google.com;
> > horms@kernel.org; imx@lists.linux.dev; netdev@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-pci@vger.kernel.org
> > Subject: Re: [PATCH v3 net-next 02/13] dt-bindings: net: add i.MX95 ENE=
TC
> > support
> >=20
> > On Thu, Oct 17, 2024 at 03:46:26PM +0800, Wei Fang wrote:
> > > The ENETC of i.MX95 has been upgraded to revision 4.1, and the vendor
> > > ID and device ID have also changed, so add the new compatible strings
> > > for i.MX95 ENETC. In addition, i.MX95 supports configuration of RGMII
> > > or RMII reference clock.
> > >
> > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > ---
> > > v2: Remove "nxp,imx95-enetc" compatible string.
> > > v3:
> > > 1. Add restriction to "clcoks" and "clock-names" properties and rename
> > > the clock, also remove the items from these two properties.
> > > 2. Remove unnecessary items for "pci1131,e101" compatible string.
> > > ---
> > >  .../devicetree/bindings/net/fsl,enetc.yaml    | 22 ++++++++++++++++-=
=2D-
> > >  1 file changed, 19 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > index e152c93998fe..e418c3e6e6b1 100644
> > > --- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > @@ -20,10 +20,13 @@ maintainers:
> > >
> > >  properties:
> > >    compatible:
> > > -    items:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - pci1957,e100
> > > +          - const: fsl,enetc
> > >        - enum:
> > > -          - pci1957,e100
> > > -      - const: fsl,enetc
> > > +          - pci1131,e101
> > >
> > >    reg:
> > >      maxItems: 1
> > > @@ -40,6 +43,19 @@ required:
> > >  allOf:
> > >    - $ref: /schemas/pci/pci-device.yaml
> > >    - $ref: ethernet-controller.yaml
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - pci1131,e101
> > > +    then:
> > > +      properties:
> > > +        clocks:
> > > +          maxItems: 1
> > > +          description: MAC transmit/receiver reference clock
> > > +        clock-names:
> > > +          const: ref
> >=20
> > Did you run CHECK_DTBS for your dts file? clocks\clock-names should be =
under
> > top 'properties" firstly. Then use 'if' restrict it. But I am not sure =
for that. only
> > dt_binding_check is not enough because your example have not use clocks=
 and
> > clok-names.
> >=20
>=20
> I have run dtbs_check and dt_binding_check in my local env. there were no
> warnings and errors.

Is there already the DT part somewhere? Do you mind sharing it?

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/



