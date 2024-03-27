Return-Path: <linux-pci+bounces-5214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA9488D5B2
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 06:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FBA72A85C7
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 05:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFC446AF;
	Wed, 27 Mar 2024 05:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="moSFhoI0"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2091.outbound.protection.outlook.com [40.107.114.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7311736F;
	Wed, 27 Mar 2024 05:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711515982; cv=fail; b=gjAaNgkQZFzaRTjEFaNREAOjdX4F9HwrZ8z1yJGupK2s0ipLf+FJzzt9p/A0KnF666VACde2W9vClDlSeNw/Zdk0qmKvvd16rq2/K3DtCi9o8ElLs2IZIzu+lxLIULvM1s8gyoNbqCR21hugzMLPyM7WvCogZS3imLICEN8UX5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711515982; c=relaxed/simple;
	bh=NTKQUKDzDHTpNy8zE0ot2hwCvepa75i3Y1+HSa0VnIc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CvL/XmD4yF4Vfj+8eU4wG3a1Br5YQYMvZ1SUIki6rj9/T19MV5uk5SAJF6Jqmy8WL9W09NWZT9RNv4SjZeBWJU9rWqBnJmyMWUaTFS0m8k6EMGINEzSCkAnvIqhern7GBL+HDBfVFRqL9IP+ETi8l8Uvn9027+0jI0kJbUToLP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=moSFhoI0; arc=fail smtp.client-ip=40.107.114.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYxcKsC2wlLdsK/pzTz2soX9AS04LyPaOwSRm0wacHPjdc4NfImHlC0jRoPQIwn95wizFLFHEQD55ns2OlKCxFixt9ugd1rv93w5Tfp0AzMUk+GfiKriBYx9srw+hSd1QpJrch0cT1k53Sjlq+UqToYIKbVLpkWSDmxwPxzx5l4mz/J71Kec1KC2j+SZOa9Uv4Ra9LqAjai7iCqi635LDe6wegXnaial/bHXHfpDCpZIFr8IqRXTPFmrAkkTQedBQIYI9q9haceXmqC2ZSj3RzH7Qj25yN3KonX+OWKDfTyJEs4perQ5NBVBmmCW12/oduz8sYSq3yzEX8zWjdWwIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbmEo4xu3l4YHKaewNqVOpLogKHOAfp1iklVR565EVg=;
 b=XxNU5R7v83xr02/C1o1GsThKwZjtzQVobCMDZai7Vi9yGhhK2KJ40eObKfgy8rSpUjJi4/xC/QKqOPQwT5/5vP0x9EBXsjWt+8KLFAI+ZSf5M805FjCnOySmVVOpZBstmuB0wv9sqnnMw1DTbjioqU9lgvpQjVa0rfV2GUxjy4+gYUnufkivYVyvVCOFS5EbgYPrg18ghLoEx90f858JAbRRqniHAp4v5lTFNaW7tyCocg218XTcywJL1Kkg1Zg01XWdP5iAkga2LeDEe2seUZ1P5MvgVVXJ3uPDRNW7AKMVUHk1yAKAZIs/TpEhhY2sAsPFBR5NgDui+yME5QQcZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbmEo4xu3l4YHKaewNqVOpLogKHOAfp1iklVR565EVg=;
 b=moSFhoI0BeulnR2iAqCwc4HPSt9pah2TQrv8HFyTGlcbLcXr6J6IMAnF6nXIGnUA/fFmH5mgsUolgPLL8X7kcqo9M8Wrocy/kF4S2CcZjjEHRvJdLI4Pt7k1XHWNvljbyRavdmi5iLy8QdaeKJQskeqKTyHMvmp9WS9vbuAgrvI=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by OS0PR01MB6178.jpnprd01.prod.outlook.com (2603:1096:604:cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 05:06:17 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::f9d2:106:9dc3:224f]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::f9d2:106:9dc3:224f%3]) with mapi id 15.20.7386.023; Wed, 27 Mar 2024
 05:06:17 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"mani@kernel.org" <mani@kernel.org>, "marek.vasut+renesas@gmail.com"
	<marek.vasut+renesas@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 4/6] PCI: dwc: rcar-gen4: Add a new function pointer
 for other SoC support
Thread-Topic: [PATCH v2 4/6] PCI: dwc: rcar-gen4: Add a new function pointer
 for other SoC support
Thread-Index: AQHafye/LRWh8FYa3E2pWLMymaVFNbFKd/8AgACPmmA=
Date: Wed, 27 Mar 2024 05:06:17 +0000
Message-ID:
 <TYCPR01MB11040C9899CAD067A7266C5CDD8342@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240326024540.2336155-5-yoshihiro.shimoda.uh@renesas.com>
 <20240326202116.GA1492492@bhelgaas>
In-Reply-To: <20240326202116.GA1492492@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|OS0PR01MB6178:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uQCR0ywxdvf3AFuDFGSzE7WY/mUvh5ac10W5tiLgD5rnHXMRbr4/6xcq2Vetnbj0c21DmEx//L2blvTyWD4zXaaqMDVjQ+xva8k1lEkqQqi4rXMz1mD5uigViLeEq3osgq1CHkTXib12uNlATVdEuAHrge6//5Iodklja1HgLl5+4/OW5MLiXTPPTDJGC3Q7xcaJWTSINBxwZyKahJ1+WOsqTSnTWi98lL5eM57yQ/k9mQAkcL/2NMAw+gpF/JdzNqJqUhwoZWCjJjDkdL8q0KagvBX/FekuSHMJ7ZgsZtwIFOxzhhhcsShznLKiOkWfc0xfEsF2GMOJAwp7WHacz0G3db6JoDBtR6f1JD5n/pzWBQ9hKmK4nIZPY1D7rY736akycrHfM1TI9omlkFUHDwvytUeLoKfvpUXRIeQ4wZgYUfeh06JCTakbhfdLQ+nF3ai1Lk//LmhK0mHigsT4PcwgSzSnHdQf/HZQDQyNyYc8PwsxRGbw4yPcKtayY/p3+PDoYy7IDQSj8x8AENmv7jVeYBLKqIAsgeAKC5kDqS/8SiQ0FuN/gPaWoGYNI4K1CMkhNa0GJz41p3ovnG+yO5EA6zcqqyGI7cubG/Cpcu0CiKEX/pdvm92XeSpZXJy2rJbFucca8Psi20GFAFtuF+qy+uT4wNblbYi6YSOKM6k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vrk8eK+0/MTn0pbu7s35pBFnl4Kg4YlywUyIIOXrHBxj5M1rZ9iKYfOthk5B?=
 =?us-ascii?Q?IIz7rQ1rhX/kK9up9WZnaWiSr2kBYU06Qv96XFjSBUYQmWhef8sFtmezbiPY?=
 =?us-ascii?Q?AEuUfwKOBhQNd52TuII8LsGb9RntUEi60BtsMZ6CvVXiT3ag6vsSJKYJzWBD?=
 =?us-ascii?Q?oTiZNi7Op6Jb2s6HBjXjOC9y1PBllfDwuvFcHsVtPNWyi2UtA3JXSK+LFR45?=
 =?us-ascii?Q?iG4LUCDa2RSrYFQ8pyEkpUxZ+HKdG7pOwUbNr4RLJhQg7GdnToqmVCFTgYW6?=
 =?us-ascii?Q?R9isNKtsdYAxMKetKjksz6tgmF7GInYXftqBwSZrGFXrM2Vy1MaOoGfRlYKW?=
 =?us-ascii?Q?WY2jiQwyLYQYpECfXc59s+waGapsnejSK+rd8KRS+k+TupQ/0RgXssYtRcKp?=
 =?us-ascii?Q?frjsrLpJyyMh0y7r788ZWEBnl4EgyGmLyfnXtEmYJFLfFtQ7cRrPusjZYzT9?=
 =?us-ascii?Q?Jvlwuohg08pjGANJm2kYqhDJwTsS7BQu2fJHmUU9l9zpXeIyibdnMdFg7nCi?=
 =?us-ascii?Q?ZRiY6OyHR16DOPxOPI+3KHsDY+fCir79VZt/a1PCL+xBZhR+nUrwghNGx0wg?=
 =?us-ascii?Q?WSZX0OkIWLXD+tyGpj0VMSY6M6pGRy1RqRrC99G8aeZERVMQhQ/uphrOR+QU?=
 =?us-ascii?Q?PmOkvkAGJlFlHnpjjuC2tc6cNp2PQtuYDPitLzeWKkWzXFFyHwNjvzZ+qqAY?=
 =?us-ascii?Q?RuXDHd+464AkdSLE9BD2sQlAyQV7g/Zg1Z4nu9mvELfLqdModq8Y8rCf3YhI?=
 =?us-ascii?Q?nf+WDrdKWRLvRJ2OaaKs7cj7ilbvZH2Car/9EApEqbj+oUD3tZzeTdvoBlVj?=
 =?us-ascii?Q?pkk7BtOnwg+r2SkQM+zC61DycicwfE7ZgbYyUclThLyxVfq2SFq2g8fpUbbH?=
 =?us-ascii?Q?e55c3gn+D/Y+8yYd8K5uG36xScMjMooTZ9G99l9wSgkLUpiKBFWLcGFHPPZH?=
 =?us-ascii?Q?x7XYXKROcyxRDD63t7kGKx6zHKOqtHiidSGg6Ues72Gwq5JXSX0cAD9e9FID?=
 =?us-ascii?Q?5Q//G9p1A5JVZ4SQL371jEX+J+TtV2D9V2PFDbQqnL0r6zCZbOAL2yeuWNg5?=
 =?us-ascii?Q?BhA7ZzQufwgskLY2lti7hItq0Fiw2jueayuP59pbal4vGHIrDRmvBiBh363m?=
 =?us-ascii?Q?6dKAyAcQ7kX6mCXRzrLjNshcVEOn4DNYOSTqRrHolVqenXrEzv2pfneG4/Lp?=
 =?us-ascii?Q?lBZAMZ00prtg1PMQ/rfCbfjkphGMMKkdCbGvTm21t4uVgkzJ9kaI4eunDo9s?=
 =?us-ascii?Q?25kNbaWvYbYkmlG8wQ8kLCgdr0dIpHevojDXQL5x5d97qdZYG+GQeyH2cAuB?=
 =?us-ascii?Q?yEgRJBYAN2Ram/DhscWhVuE8RFZ02rUebS8UWxx9FAtx6tMEho6rCWeIisEX?=
 =?us-ascii?Q?cvX1+X5KSeNKBrZQg5WZSxM8vO/rVv5E37BZzEOEilPoeU12CoIoAJpmJZ9m?=
 =?us-ascii?Q?9oDhV4eSc9xodMcoIVItSbiYzfWdSQLY1+cfED0MEExTuHVejLKOjL0kIyC2?=
 =?us-ascii?Q?+js7yd2FZUrgs6hDIDwaV2rc71yNqj9s2JEDAmbfBU1LuIiHVZN/vE1gJeBA?=
 =?us-ascii?Q?kCKdas7bi+zilt0IjJrcdXmM5O5pw/dKKOuHLlqpDbBXcVfgOpzC6tcL4VDL?=
 =?us-ascii?Q?Hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11040.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13175fb9-2b12-4e3a-2581-08dc4e1ba292
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 05:06:17.8209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6NkYeF4G6GBvKBpQZjQSJSS5zeSoBEjSK4ahLRVVQJzLc0ljGjsbGiK6r/gg1bDlJPKxJySFJkNHgBxmTlbbQBmHsbi+kpNQq+HUh5mfsSxWuJO/TOyLHnMpeWi0Wys1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6178

Hi Bjorn,

> From: Bjorn Helgaas, Sent: Wednesday, March 27, 2024 5:21 AM
>=20
> Include the function pointer name in the subject so it's a little more
> specific.

I got it. I'll change the subject.

> On Tue, Mar 26, 2024 at 11:45:38AM +0900, Yoshihiro Shimoda wrote:
> > This driver can reuse other R-Car Gen4 SoC support. However, some
> > initializing settings differs between r8a779f0 and others. So, add
> > a new function pointer start_link_enable() to support other R-Car
> > Gen4 SoC in the future. No behavior changes.
>=20
> Make it clear here what the new SoC is.  I think it's r8a779f0, but
> you have to read the patch and look for the new .compatible string to
> figure that out.

I got it. The new SoC is r8a779g0. So, I should add such description here.

> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 57 +++++++++++++++++++--
> >  1 file changed, 52 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/=
controller/dwc/pcie-rcar-gen4.c
> > index 0be760ed420b..a37613dd9ff4 100644
> > --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > @@ -53,9 +53,16 @@ struct rcar_gen4_pcie {
> >  	void __iomem *base;
> >  	struct platform_device *pdev;
> >  	enum dw_pcie_device_mode mode;
> > +
> > +	int (*start_link_enable)(struct rcar_gen4_pcie *rcar);
> >  };
> >  #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie=
, dw)
> >
> > +struct rcar_gen4_pcie_platdata {
> > +	enum dw_pcie_device_mode mode;
> > +	int (*start_link_enable)(struct rcar_gen4_pcie *rcar);
>=20
> I think it's confusing to repeat "mode" and "start_link_enable" in
> both rcar_gen4_pcie and rcar_gen4_pcie_platdata.  I know several other
> drivers use this pattern, but I think it is simpler overall to just
> save the pointer directly, e.g.,
>=20
>   imx6_pcie_probe
>     imx6_pcie->drvdata =3D of_device_get_match_data(dev);
>=20
>   ls_pcie_probe
>     pcie->drvdata =3D of_device_get_match_data(dev);
>=20
>   tegra_pcie_dw_probe
>     data =3D of_device_get_match_data(dev);
>     pcie->of_data =3D (struct tegra_pcie_dw_of_data *)data;
>=20
> So I think the best thing would be to add struct
> rcar_gen4_pcie_platdata, *move* rcar_gen4_pcie.mode there, and save a
> pointer to the rcar_gen4_pcie_platdata in struct rcar_gen4_pcie.

I got it. I'll modify the patch.

> That could be its own separate patch, which is nice on its own because
> it gets rid of the (void *) casts in rcar_gen4_pcie_of_match[].
>=20
> Then add .start_link_enable() (or .ltssm_enable(), see below) and the
> r8a779f0 bits in another patch.

I got it. I'll make such a patch at first.

> > +};
> > +
> >  /* Common */
> >  static void rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar,
> >  					bool enable)
> > @@ -123,9 +130,13 @@ static int rcar_gen4_pcie_speed_change(struct dw_p=
cie *dw)
> >  static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> >  {
> >  	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > -	int i, changes;
> > +	int i, changes, ret;
> >
> > -	rcar_gen4_pcie_ltssm_enable(rcar, true);
> > +	if (rcar->start_link_enable) {
> > +		ret =3D rcar->start_link_enable(rcar);
>=20
> This looks basically like what qcom does:
>=20
>   qcom_pcie_start_link
>     if (pcie->cfg->ops->ltssm_enable)
>       pcie->cfg->ops->ltssm_enable(pcie)
>=20
> Can you copy that and use the same name for the pointer and function
> name (.ltssm_enable, .*_ltssm_enable())?

Yes, I can. I'll rename the pointer and function.

> > +		if (ret)
> > +			return ret;
> > +	}
> >
> >  	/*
> >  	 * Require direct speed change with retrying here if the link_gen is
> > @@ -437,7 +448,10 @@ static void rcar_gen4_remove_dw_pcie_ep(struct rca=
r_gen4_pcie *rcar)
> >  /* Common */
> >  static int rcar_gen4_add_dw_pcie(struct rcar_gen4_pcie *rcar)
> >  {
> > -	rcar->mode =3D (uintptr_t)of_device_get_match_data(&rcar->pdev->dev);
> > +	const struct rcar_gen4_pcie_platdata *pd =3D of_device_get_match_data=
(&rcar->pdev->dev);
> > +
> > +	rcar->mode =3D pd->mode;
> > +	rcar->start_link_enable =3D pd->start_link_enable;
> >
> >  	switch (rcar->mode) {
> >  	case DW_PCIE_RC_TYPE:
> > @@ -500,14 +514,47 @@ static void rcar_gen4_pcie_remove(struct platform=
_device *pdev)
> >  	rcar_gen4_pcie_unprepare(rcar);
> >  }
> >
> > +static int r8a779f0_pcie_start_link_enable(struct rcar_gen4_pcie *rcar=
)
> > +{
> > +	rcar_gen4_pcie_ltssm_enable(rcar, true);
>=20
> Previously we called rcar_gen4_pcie_ltssm_enable() for
> "renesas,rcar-gen4-pcie" and "renesas,rcar-gen4-pcie-ep".  But after
> this patch, it looks like we only call it for "renesas,r8a779f0-pcie"
> and "renesas,r8a779f0-pcie-ep"?

Yes.

Best regards,
Yoshihiro Shimoda

> > +
> > +	return 0;
> > +}
> > +
> > +static struct rcar_gen4_pcie_platdata platdata_r8a779f0_pcie =3D {
> > +	.mode =3D DW_PCIE_RC_TYPE,
> > +	.start_link_enable =3D r8a779f0_pcie_start_link_enable,
> > +};
> > +
> > +static struct rcar_gen4_pcie_platdata platdata_r8a779f0_pcie_ep =3D {
> > +	.mode =3D DW_PCIE_EP_TYPE,
> > +	.start_link_enable =3D r8a779f0_pcie_start_link_enable,
> > +};
> > +
> > +static struct rcar_gen4_pcie_platdata platdata_rcar_gen4_pcie =3D {
> > +	.mode =3D DW_PCIE_RC_TYPE,
> > +};
> > +
> > +static struct rcar_gen4_pcie_platdata platdata_rcar_gen4_pcie_ep =3D {
> > +	.mode =3D DW_PCIE_EP_TYPE,
> > +};
> > +
> >  static const struct of_device_id rcar_gen4_pcie_of_match[] =3D {
> > +	{
> > +		.compatible =3D "renesas,r8a779f0-pcie",
> > +		.data =3D &platdata_r8a779f0_pcie,
> > +	},
> > +	{
> > +		.compatible =3D "renesas,r8a779f0-pcie-ep",
> > +		.data =3D &platdata_r8a779f0_pcie_ep,
> > +	},
> >  	{
> >  		.compatible =3D "renesas,rcar-gen4-pcie",
> > -		.data =3D (void *)DW_PCIE_RC_TYPE,
> > +		.data =3D &platdata_rcar_gen4_pcie,
> >  	},
> >  	{
> >  		.compatible =3D "renesas,rcar-gen4-pcie-ep",
> > -		.data =3D (void *)DW_PCIE_EP_TYPE,
> > +		.data =3D &platdata_rcar_gen4_pcie_ep,
> >  	},
> >  	{},
> >  };
> > --
> > 2.25.1
> >

