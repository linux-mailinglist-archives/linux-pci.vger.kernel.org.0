Return-Path: <linux-pci+bounces-8576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B16903776
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 11:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0322C287413
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 09:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A51017622E;
	Tue, 11 Jun 2024 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="dVygd0CA"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2059.outbound.protection.outlook.com [40.107.113.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC3B79C8;
	Tue, 11 Jun 2024 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096884; cv=fail; b=LFYL8uSR46M/619ukjlPlmFbRrwlZKTt3dVlpxxNds2rtJu9eE/d1ZOZCR1DlQkAHiK5ejuz53RlMxt1sojbQXCPYcu1ksHqfvMd55o5KftjABNmImr715deXQ3aIs+FFECwpU/awCSkC0TN6S8oQol2LqfSloSStLpkl9a/PRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096884; c=relaxed/simple;
	bh=xhXsitQEwsRVDgAi7+PT1Qto5EY6Y1lbban6OzJ+ifo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PDiz5f+/XLF842cU6JwXj+tMV5aOvsHWo6QUumjBU5RGYDK60altcrG7Zl500YfCwJY925NrWo1DD20nUkOW2iLeZkDYqq0CNCZSoApHztu0iakzrUbi+n3gi8VhWQpglCTwSmFbwCjTdYScHsQCt6Z7P9b9C6QKjTlZy6BXQY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=dVygd0CA; arc=fail smtp.client-ip=40.107.113.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UD+kxKN8KHBF9/NyG06/7ahkNDAGqMJ64xmQL38E4iyaEwS7dY4Y6IjHnP5DEiPx9AqdGrz96DjuDrLMLNcifaHf/PfgwRsmJ4KYe1g9TR921rXCBnbDwDECMUfNhJF9xbx+el/erYZbtYblgYrgjwgvSGrAbaBgOuflt2/8PE6gwEtA93HhzKwVAedXUTwuMkdiJXHxwuBy3eV5qNHe0qGKxSnIdgYiD98rb+WI42eBtjlwHNBwqD+jUb7ru2K09y65TEXT1GHxEX96ESpFRYe+CFzjJEtBa0H1ifjGKN0ETGzVjXSNRG8m/pFbRxkD7GWjlhyv4iryWyMfQ55iyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fxt5YTh26YhSU6rfkRwwNi5zyI2cyIY/HHLNY4Ybtck=;
 b=KEFKkreSY+Hk+N6Pc6kgSuu9kvqJgpEs5RcZy7xpni/3fT2G0bSmH4U7F9N06defkx434Haxa8k/6ewvKdCT6cx0HhLXCoMS0jNoQ+CCS+yXbNHDRaab0dP8kmjamyukttKC0MGNg3h0zNSRB0EqTMwxkoauEC3DjElogxO8In3+/Rouxx0UKL4JaNLMAnoUvFig+AS6CIE9XERf19VIdR+aZnBMV5rszHHOrLrX65KNePBcO3D7QDjSJyZ9pakaoBwBvp60qtgM3aX+5WpL7JtilShg7K6kIFQgIhHb15RQnSCVMIedIdYTEFb1IE4+49iQS4fdiuxqsLVUmvFGNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fxt5YTh26YhSU6rfkRwwNi5zyI2cyIY/HHLNY4Ybtck=;
 b=dVygd0CAoSG5+Ny9UBc6MOU+KxFWwlIDxo+gV6JXsEhgPBfGhFMlq6yHUPTsAXHQkEF6LDnN4cy1JjncuG0SMrdhAZvrSfnT+RRj+Pwkw9dITCwGhoqh9jvN5+yeGEKBKYfqYkZIRbi98SalaKTmo0hsVLk/J605SCw2RG34RbY=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by TYCPR01MB11787.jpnprd01.prod.outlook.com (2603:1096:400:38c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 09:07:59 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::b183:a30f:c95f:a155]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::b183:a30f:c95f:a155%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 09:07:59 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"mani@kernel.org" <mani@kernel.org>, "marek.vasut+renesas@gmail.com"
	<marek.vasut+renesas@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v8 3/5] PCI: rcar-gen4: Add .ltssm_control() for other SoC
 support
Thread-Topic: [PATCH v8 3/5] PCI: rcar-gen4: Add .ltssm_control() for other
 SoC support
Thread-Index: AQHaqolaZJN7yqdefUqofjJpUVNnwrG5hrOAgAjhipA=
Date: Tue, 11 Jun 2024 09:07:59 +0000
Message-ID:
 <TYCPR01MB110409511B70B1092B5D27F31D8C72@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240520074300.125969-4-yoshihiro.shimoda.uh@renesas.com>
 <20240605172915.GA767034@bhelgaas>
In-Reply-To: <20240605172915.GA767034@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|TYCPR01MB11787:EE_
x-ms-office365-filtering-correlation-id: 386ba05d-f0db-4477-e34c-08dc89f5fd76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mtXlyDuJ9ZwfzFikk1tiFvrX9rqUCTPHbw/fRlaBfXi9iqG/16fZgvny+NPn?=
 =?us-ascii?Q?V4/1Odxn0GYRxlOPCLHhlSpYPAeFNZatqhAUfR/eft3H0e+ZAQ51M+VK4uI0?=
 =?us-ascii?Q?yj5OPcoY1DXpq+F5Ptg3jLfg5L4auWFOJkLyazp8GvMOe4WxbQ+4cf+/T9oY?=
 =?us-ascii?Q?PFd7XBsVcjGn/H6Dy7CatsAVpWeyAcAyhvnUneAQSrxhLCxie3liwtxD9blr?=
 =?us-ascii?Q?ihmloOpH3V7TiWm1A2LirVC/NAfJJ5l7KUyDpTz1ygLJblxOu9ciSpQTDC2Q?=
 =?us-ascii?Q?SYvrXtAaBsdD08aksGbAkpnNqXNeqAkmedaO93NpQgoevr8OiYVE7e8UeFX9?=
 =?us-ascii?Q?JsUNAgmioO0W0QsuNqwWLJKyN3BQDLqK4fO8BQzYaRXeDvk2e+MEt4xURq6v?=
 =?us-ascii?Q?sPL0w1h9nYoG7sDNw7IZzU/JAs+7xsOcetGQIwDXwQO/Zzauuu4wYguNAh6n?=
 =?us-ascii?Q?0b+y/CZj+pQ9H7Q6HihjZWtdcdJO5fMPqb3JG5nBetp2TNNpjEUzv0ffxt4F?=
 =?us-ascii?Q?GRYuYMIMsoiG80LB+n8PF5UYS4F1u4Cjc5LCM8fVH9vDh4fhjkJFs33nl9i/?=
 =?us-ascii?Q?UL0rp6anAnMTf6+dsxN8yE3rk7AcQHG8hO1aci6zvYysDGIT2hWiD2d3eHte?=
 =?us-ascii?Q?H2FIFVBAKENGFQLfMRvh9adql398N+YpekeYgZ2eP29HSwrYepcsyNJMbbP/?=
 =?us-ascii?Q?OlOG4B8xzY5Gx5z9WqDAUgGI8EJdPZtqKSUwduFtQlcfAxJ0g3XKfuo0cKkf?=
 =?us-ascii?Q?nMzmqoA7ih1+JVldSTLWRb6NzYQXb0r6qJ+sDASC9TQDPIywBX0MMASGQE/X?=
 =?us-ascii?Q?VCKoX5bwJcZctaT5KOrtzZvYVVOv2RIxpayhpalyyTRRXJtlaFj6X72Lr4Yx?=
 =?us-ascii?Q?3Wi5VJSodNWJLHhKRsS5Fl2yYzfEKrwsn681vkUfV8xn11B0jKv0olJj53Xk?=
 =?us-ascii?Q?LWgOTadCQkyU6TjihOuobJc5T3S8UUN8RbjkSX0jQZTkijZh6A42aSXB/oE7?=
 =?us-ascii?Q?GvYugQBBIfuQVjlJPh3ZkuxwDOqZBSLcbZB5XQ5lCCr2eglxdBTJaA31/xNH?=
 =?us-ascii?Q?touI+l3HYuodzv3lurkUvqzWCu3FJcSscf1lZ5D/W9pm+NbhwRQ+lRv66206?=
 =?us-ascii?Q?Cm73H1Qw+psB3ECMXiQGUnHbN9JnjUv5SHF6V6EZ8nwV2/9XAGFvdZEfgi9J?=
 =?us-ascii?Q?3M0jkvCv/Aem4DktFaXIqhXbJAjaLMtJT76/dTF3YyvY8LW/DTSgTD6dPdiZ?=
 =?us-ascii?Q?Dfx08oPnit+l7FtBbxplmosllSilHfc8BTUhfiKYmZkjOrpUO+0jICD8tsR3?=
 =?us-ascii?Q?vaewHVQ51n8UdGzyOSqPBEcGwtJsNWgIKc5aHgRa4c4k2NEow/VJwaMXtH2/?=
 =?us-ascii?Q?sEbTU64=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3ZcRqItp66ZM8r0Jql4mUkYeilbmVPdNaDr18Wh175JnSs8sBP8UV3A/52Vg?=
 =?us-ascii?Q?ncmcVViF4dheuwL2xShIg6gl9i+9leneopRLwwxwTg3a63lSpW3ErXQ4P28F?=
 =?us-ascii?Q?El7wj+s0fwssBTVgDiIWuOBEdxftgVQxbom9CMR94iTNydnqPzM5K1iwTz2X?=
 =?us-ascii?Q?mDUAaHqLqCNAGzf0BbldlSCT6HpyAFB7sRlsSrWLJRfXgdhiA0jB4CUUwfsw?=
 =?us-ascii?Q?pt9fnwQrEn9/rKAzQKPA6xsUsdWon9VKio2N4AytrCutUCtpJf2lL7atsUH3?=
 =?us-ascii?Q?4kXsi/ypD8r2v9HHR11R/TaFslybBS6AnSCxdbcDKX8PtHX9Y0ldrCsuIFXn?=
 =?us-ascii?Q?WkzL1NQT77gD7g7b/flRFLGndTLwxCyK3UcFK3Q1ZJMpzObpe5GWlbr9FYNP?=
 =?us-ascii?Q?nQOkSxU6cuP/wGsQg+qrZvdlgJzMJrDP3bXzduwpZ5miPnQ83anz4DvfQwar?=
 =?us-ascii?Q?srdGLEWZbJRD8e2Kl78fl/Mql0kyP2hv9nJQmiUxgryreTHsng2FOIrfvJ78?=
 =?us-ascii?Q?b9WYOHcZmvjniUHAB8UjezZYAjpDOkauaRV6KTtX1mOAqQSjOFqWJJGPGz7f?=
 =?us-ascii?Q?Ln+eDSCXoPyl0fwIDnu5zW9Cn3BASes/aaSJvFVK84+PIENBngRf+hCWD31D?=
 =?us-ascii?Q?rQzbPVwQa/iLAG4/Qi59aFKIMBnigLJSzYsz6Def08BI7Zi4dMhkzHJX2akn?=
 =?us-ascii?Q?RfH1dCmyqZLcBJiu3wnOdQ8rlwVMp0DHaSwW/pvHbXbCZpERwGhjNlKcQluS?=
 =?us-ascii?Q?u1tREzBz8tK4Z42wts7GCSc/0SyBANEbklq0KwLfdi4pBAXpgHG/UqfOpYW2?=
 =?us-ascii?Q?apF7EGZpek4mrb3+oIgHQOEg0rm9QWaVlUMYYfm5kuuLFZJpVk/rPZWifEEw?=
 =?us-ascii?Q?KPMnx0PquigHDDO+uWl7SHFJaK8U3b5MeyG0PXbpLpeUJ8tLxxArREuea15B?=
 =?us-ascii?Q?M79NUcPkGgtiic1Qg1iQISqsX/ijWfWsr+1/iPM0IH0/GNHn8e/2LbECBbz3?=
 =?us-ascii?Q?ZPqCy39xHgeVi2MA/oD7qG/kOGEEgE7G8qSC7eRWgf/23igkEDWYduEyujVf?=
 =?us-ascii?Q?HJBsnuJiWyUjYFHTRv5F14TKRxwAhLpR8tnj3HlG3HHvIJLZcHJ5rQ6WnmnM?=
 =?us-ascii?Q?SpWIuAw7LKBfkARK2a1dVGDekUPn+aLXmaAC7i3tVB7CFjIfgCvRcKwF1WKv?=
 =?us-ascii?Q?A6h46tNY2whKjOIF//W+PlKedW9OCLRqEIXUZHOHxXzjwJi16yivZvb9sq/O?=
 =?us-ascii?Q?ruS1OoPfsFe2jlhfETgbsgnLUW/rr5cErOXboYsN+9ZIVX3aN3HF74d99SiX?=
 =?us-ascii?Q?zEKquWKSWcEyHDmzTomNUgqCuJRVzCC7P++y/VYqXt0yWz/TVQYl5i4aHWTc?=
 =?us-ascii?Q?Sqnc41ta+UWVyJCkh/ZQ4cd3rcu1cfbWphQ+kr82mCjFkwbwVBzR3xGqnRx1?=
 =?us-ascii?Q?YpknXlPiKefRJv3+ifUKivSIv8AmFm7H7ajkiZJ8cdWKUfxXmDLZNcbcnXDt?=
 =?us-ascii?Q?g4GVXDjWOBI5ymg7DW/9CsW6IUyUhOSQ90pCtlT8gqlS0elDdgeTgyhTFCrY?=
 =?us-ascii?Q?65SH88DaQyzDrZM6bp+jM+flOcpbTcS8nmyZYzamdenVsCjk9G2oOgaL+zo6?=
 =?us-ascii?Q?gzo7DnwKbdLz2eWwdyU+kkB1RPttynkhx81KKHrd801bzFv7yxUHHV99Av1+?=
 =?us-ascii?Q?Dpf39g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 386ba05d-f0db-4477-e34c-08dc89f5fd76
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 09:07:59.1790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pDqy3FTgf6kHSrafjUBL2fzWeYqQkwo5oHregiXO4lqCYcCOKiWHa2HssiPpvTWWtyIAzmQrd4ze27lerBd9gdSxZdAmJy5YX28pbjtK8Wfy/AwdrvvbaKlMvDzrYm+G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11787

Hi Bjorn,

> From: Bjorn Helgaas, Sent: Thursday, June 6, 2024 2:29 AM
>=20
> On Mon, May 20, 2024 at 04:42:58PM +0900, Yoshihiro Shimoda wrote:
> > Sequence for controlling the LTSSM state machine is going to change
> > for SoCs like r8a779f0. So let's move the LTSSM code to a new callback
> > ltssm_control() and populate it for each SoCs.
>=20
> s/So let's move/Move/
>=20
> No need to repost for this, whoever applies it can tweak it.

I need to post v9 patches for Manivannan's feedback, so I'll fix the descri=
ption on v9.

Best regards,
Yoshihiro Shimoda

> > This also warrants the addition of new compatibles for r8a779g0 and
> > r8a779h0. But since they are already part of the DT binding, it won't
> > make any difference.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 74 ++++++++++++++-------
> >  1 file changed, 50 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/=
controller/dwc/pcie-rcar-gen4.c
> > index b11e09505b0b..bcbf0a52890d 100644
> > --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > @@ -48,7 +48,9 @@
> >  #define RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET	0x1000
> >  #define RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET	0x800
> >
> > +struct rcar_gen4_pcie;
> >  struct rcar_gen4_pcie_drvdata {
> > +	int (*ltssm_control)(struct rcar_gen4_pcie *rcar, bool enable);
> >  	enum dw_pcie_device_mode mode;
> >  };
> >
> > @@ -61,27 +63,6 @@ struct rcar_gen4_pcie {
> >  #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie=
, dw)
> >
> >  /* Common */
> > -static void rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar,
> > -					bool enable)
> > -{
> > -	u32 val;
> > -
> > -	val =3D readl(rcar->base + PCIERSTCTRL1);
> > -	if (enable) {
> > -		val |=3D APP_LTSSM_ENABLE;
> > -		val &=3D ~APP_HOLD_PHY_RST;
> > -	} else {
> > -		/*
> > -		 * Since the datasheet of R-Car doesn't mention how to assert
> > -		 * the APP_HOLD_PHY_RST, don't assert it again. Otherwise,
> > -		 * hang-up issue happened in the dw_edma_core_off() when
> > -		 * the controller didn't detect a PCI device.
> > -		 */
> > -		val &=3D ~APP_LTSSM_ENABLE;
> > -	}
> > -	writel(val, rcar->base + PCIERSTCTRL1);
> > -}
> > -
> >  static int rcar_gen4_pcie_link_up(struct dw_pcie *dw)
> >  {
> >  	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > @@ -127,9 +108,13 @@ static int rcar_gen4_pcie_speed_change(struct dw_p=
cie *dw)
> >  static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> >  {
> >  	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > -	int i, changes;
> > +	int i, changes, ret;
> >
> > -	rcar_gen4_pcie_ltssm_enable(rcar, true);
> > +	if (rcar->drvdata->ltssm_control) {
> > +		ret =3D rcar->drvdata->ltssm_control(rcar, true);
> > +		if (ret)
> > +			return ret;
> > +	}
> >
> >  	/*
> >  	 * Require direct speed change with retrying here if the link_gen is
> > @@ -157,7 +142,8 @@ static void rcar_gen4_pcie_stop_link(struct dw_pcie=
 *dw)
> >  {
> >  	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> >
> > -	rcar_gen4_pcie_ltssm_enable(rcar, false);
> > +	if (rcar->drvdata->ltssm_control)
> > +		rcar->drvdata->ltssm_control(rcar, false);
> >  }
> >
> >  static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
> > @@ -506,6 +492,38 @@ static void rcar_gen4_pcie_remove(struct platform_=
device *pdev)
> >  	rcar_gen4_pcie_unprepare(rcar);
> >  }
> >
> > +static int r8a779f0_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bo=
ol enable)
> > +{
> > +	u32 val;
> > +
> > +	val =3D readl(rcar->base + PCIERSTCTRL1);
> > +	if (enable) {
> > +		val |=3D APP_LTSSM_ENABLE;
> > +		val &=3D ~APP_HOLD_PHY_RST;
> > +	} else {
> > +		/*
> > +		 * Since the datasheet of R-Car doesn't mention how to assert
> > +		 * the APP_HOLD_PHY_RST, don't assert it again. Otherwise,
> > +		 * hang-up issue happened in the dw_edma_core_off() when
> > +		 * the controller didn't detect a PCI device.
> > +		 */
> > +		val &=3D ~APP_LTSSM_ENABLE;
> > +	}
> > +	writel(val, rcar->base + PCIERSTCTRL1);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie =3D {
> > +	.ltssm_control =3D r8a779f0_pcie_ltssm_control,
> > +	.mode =3D DW_PCIE_RC_TYPE,
> > +};
> > +
> > +static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie_ep =3D {
> > +	.ltssm_control =3D r8a779f0_pcie_ltssm_control,
> > +	.mode =3D DW_PCIE_EP_TYPE,
> > +};
> > +
> >  static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie =3D {
> >  	.mode =3D DW_PCIE_RC_TYPE,
> >  };
> > @@ -515,6 +533,14 @@ static struct rcar_gen4_pcie_drvdata drvdata_rcar_=
gen4_pcie_ep =3D {
> >  };
> >
> >  static const struct of_device_id rcar_gen4_pcie_of_match[] =3D {
> > +	{
> > +		.compatible =3D "renesas,r8a779f0-pcie",
> > +		.data =3D &drvdata_r8a779f0_pcie,
> > +	},
> > +	{
> > +		.compatible =3D "renesas,r8a779f0-pcie-ep",
> > +		.data =3D &drvdata_r8a779f0_pcie_ep,
> > +	},
> >  	{
> >  		.compatible =3D "renesas,rcar-gen4-pcie",
> >  		.data =3D &drvdata_rcar_gen4_pcie,
> > --
> > 2.25.1
> >

