Return-Path: <linux-pci+bounces-14853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A329F9A3D5F
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 13:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51FF1C22C28
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 11:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DDE1D7E3D;
	Fri, 18 Oct 2024 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="KRejIOPX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="qiLznpSu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBD81EE016;
	Fri, 18 Oct 2024 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729251564; cv=none; b=axwyXCro53RcuHJsNhXAEpb2ATmzmFzWyx4UV5gaR5OTwklyAQxddJmPSx/EmhSGxWFK+c2sSHw6wqe2xAMe06ge1peyMWKavnhvek9BlG8nnMZvw83jtpvfwQQoj27EiViy0pSWzgAuRwj0M8hO7LFLS7uTjViKYQ6m00cpuUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729251564; c=relaxed/simple;
	bh=Rwphs5qi5S1XzQ4OWSmFTarZA+fNuWErHOY/vR7cDzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqNZr8H8eM0o3IrhYCIAA4l/aH7nOZrhApn6AFpmGFYRsBhkINNy+pOjiw7Qdm0nZWKM/flyWCRGWB1NPOv7SsxATImwZyoNrg342nRFquRxlknVJFCuxpVejQ3aXZ9xNoN/phTcThZ/9b5Iirbb6oPIFB21PMaC1vfeXwvhyF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=KRejIOPX; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=qiLznpSu reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1729251561; x=1760787561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IIQWDK07jPvUzisRnHdaspHYVQzk9bJrYJb1eqyhans=;
  b=KRejIOPXeH4DESx2QYjYv+PdV6/JExjOTImOiGpOrZtoBFYJFX+cyFai
   tsEoc7h9+QJNxmskx6bwfCG/VVxk6rG2cQhLypu7CH3OsbktzybTpKFCf
   Qj1B3QmgjoylWDvpVQ+0rA/2qLT0Vb8jwILUzNTa33GoRLeQfkccG+Dg4
   s960q2pr+4YtZgD2zJFxE/Xx4LZs5abvCAlqLLLFYbRl9juvuZu1tu0hN
   rria18sAbIc8AW0Z7dBl3GXp+rkPvBoLUYiuXZWbyei7UzNZmZh7nuL7J
   gKdYK7tEiTl+p977TjGgym+7Hq8Ci6BxQbYYlXu3elbl88p+ZTGv7gxvU
   A==;
X-CSE-ConnectionGUID: LfXkwjYRSVuTYfD3twpHWg==
X-CSE-MsgGUID: QTkz3N6uRJKx8nYMqH3iXw==
X-IronPort-AV: E=Sophos;i="6.11,213,1725314400"; 
   d="scan'208";a="39542041"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 18 Oct 2024 13:39:17 +0200
X-CheckPoint: {671248E5-28-21611FC3-DAD22B0C}
X-MAIL-CPID: 9F6785E2A16242C205A18BDDCAE8529D_4
X-Control-Analysis: str=0001.0A682F19.671248E6.0003,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BEDDA16006D;
	Fri, 18 Oct 2024 13:39:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1729251553;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IIQWDK07jPvUzisRnHdaspHYVQzk9bJrYJb1eqyhans=;
	b=qiLznpSuavnpXEaldsfL7ZcfXTgINywoO/R9IVRztdyafx51bURrJCjjgD/IKBaD1yz7bp
	Tkjp8ReZz7u4oxExxp7GASKSqRZIZ+M1HftSk0Ulpzq5GK/i3HgaJejQ5g/SJuJ1KERuKh
	2/anYtLvhu3/neYyVdfTEcfTUMBMgpXn9zbLzzRTZiSYzHNXBv44N/99o5q4+LF5Dcmt4d
	FDLAMJVsoCRLzaF3mtHp/U1OwiAA9hmg5nRNslN5TcVV0bz1Md8FauMVSGFT4lb5iVQXdq
	yM360OCiCRd54g1jTXmFkpPN9L+KNzQrOTl+2HncZHwNWTVCt7uke5z6D3sQvA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Frank Li <frank.li@nxp.com>, Wei Fang <wei.fang@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bhelgaas@google.com" <bhelgaas@google.com>, "horms@kernel.org" <horms@kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 02/13] dt-bindings: net: add i.MX95 ENETC support
Date: Fri, 18 Oct 2024 13:39:10 +0200
Message-ID: <9407049.rMLUfLXkoz@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <PAXPR04MB8510B252A7EDE73B2E1F00BD88402@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241017074637.1265584-1-wei.fang@nxp.com> <3657116.R56niFO833@steina-w> <PAXPR04MB8510B252A7EDE73B2E1F00BD88402@PAXPR04MB8510.eurprd04.prod.outlook.com>
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

Am Freitag, 18. Oktober 2024, 09:50:43 CEST schrieb Wei Fang:
> > -----Original Message-----
> > From: Alexander Stein <alexander.stein@ew.tq-group.com>
> > Sent: 2024=E5=B9=B410=E6=9C=8818=E6=97=A5 14:53
> > To: Frank Li <frank.li@nxp.com>; Wei Fang <wei.fang@nxp.com>
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
> > Hi,
> >=20
> > Am Freitag, 18. Oktober 2024, 03:20:55 CEST schrieb Wei Fang:
> > > > -----Original Message-----
> > > > From: Frank Li <frank.li@nxp.com>
> > > > Sent: 2024=E5=B9=B410=E6=9C=8818=E6=97=A5 0:23
> > > > To: Wei Fang <wei.fang@nxp.com>
> > > > Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > > > pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org;
> > > > conor+dt@kernel.org; Vladimir Oltean <vladimir.oltean@nxp.com>;
> > > > conor+Claudiu
> > > > Manoil <claudiu.manoil@nxp.com>; Clark Wang
> > <xiaoning.wang@nxp.com>;
> > > > christophe.leroy@csgroup.eu; linux@armlinux.org.uk;
> > > > bhelgaas@google.com; horms@kernel.org; imx@lists.linux.dev;
> > > > netdev@vger.kernel.org; devicetree@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org
> > > > Subject: Re: [PATCH v3 net-next 02/13] dt-bindings: net: add i.MX95
> > > > ENETC support
> > > >
> > > > On Thu, Oct 17, 2024 at 03:46:26PM +0800, Wei Fang wrote:
> > > > > The ENETC of i.MX95 has been upgraded to revision 4.1, and the
> > > > > vendor ID and device ID have also changed, so add the new
> > > > > compatible strings for i.MX95 ENETC. In addition, i.MX95 supports
> > > > > configuration of RGMII or RMII reference clock.
> > > > >
> > > > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > > > ---
> > > > > v2: Remove "nxp,imx95-enetc" compatible string.
> > > > > v3:
> > > > > 1. Add restriction to "clcoks" and "clock-names" properties and
> > > > > rename the clock, also remove the items from these two properties.
> > > > > 2. Remove unnecessary items for "pci1131,e101" compatible string.
> > > > > ---
> > > > >  .../devicetree/bindings/net/fsl,enetc.yaml    | 22
> > ++++++++++++++++---
> > > > >  1 file changed, 19 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > > > b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > > > index e152c93998fe..e418c3e6e6b1 100644
> > > > > --- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > > > +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > > > @@ -20,10 +20,13 @@ maintainers:
> > > > >
> > > > >  properties:
> > > > >    compatible:
> > > > > -    items:
> > > > > +    oneOf:
> > > > > +      - items:
> > > > > +          - enum:
> > > > > +              - pci1957,e100
> > > > > +          - const: fsl,enetc
> > > > >        - enum:
> > > > > -          - pci1957,e100
> > > > > -      - const: fsl,enetc
> > > > > +          - pci1131,e101
> > > > >
> > > > >    reg:
> > > > >      maxItems: 1
> > > > > @@ -40,6 +43,19 @@ required:
> > > > >  allOf:
> > > > >    - $ref: /schemas/pci/pci-device.yaml
> > > > >    - $ref: ethernet-controller.yaml
> > > > > +  - if:
> > > > > +      properties:
> > > > > +        compatible:
> > > > > +          contains:
> > > > > +            enum:
> > > > > +              - pci1131,e101
> > > > > +    then:
> > > > > +      properties:
> > > > > +        clocks:
> > > > > +          maxItems: 1
> > > > > +          description: MAC transmit/receiver reference clock
> > > > > +        clock-names:
> > > > > +          const: ref
> > > >
> > > > Did you run CHECK_DTBS for your dts file? clocks\clock-names should
> > > > be under top 'properties" firstly. Then use 'if' restrict it. But I
> > > > am not sure for that. only dt_binding_check is not enough because
> > > > your example have not use clocks and clok-names.
> > > >
> > >
> > > I have run dtbs_check and dt_binding_check in my local env. there were
> > > no warnings and errors.
> >=20
> > Is there already the DT part somewhere? Do you mind sharing it?
> >=20
> I will prepare the DT patch when this series is applied. Below is my local
> patch of imx95.dtsi. FYI.
> > [snip]

Thanks for providing the DT patch. With this I was able to get ethernet
running on my i.MX95 based board.
Please keep me on CC if you send DT patch. Thanks.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/



