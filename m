Return-Path: <linux-pci+bounces-5213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD9288D5A6
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 06:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D961C23939
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 05:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454E046AF;
	Wed, 27 Mar 2024 05:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="hhs8qYvM"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2109.outbound.protection.outlook.com [40.107.114.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E760C142;
	Wed, 27 Mar 2024 05:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711515739; cv=fail; b=diieo+5p+NR8bExi9P3+0wBvYE2ySAQsF1HYy0kCVNyk0uXq9luN0BaR8l0EkDjv/92NNZ2Gw6suEsIpWxjGNcFy7I0rxybrbnv8b5H1Uf7KE8yMhWsaJex6jAC1IrZKYExk9OIuMHL8KbnyNpZj+7oE2Wns/HBizugosnn0VX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711515739; c=relaxed/simple;
	bh=L+ElGWhvb3PPevCyFJpbD7h+O45QfBwOx7Q1syeAErE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q3IhhtcNwYQxxbx4kP1CQE2Mx9Jf9zsFawkSv0vTgRXWcbwJr32J4jgy+USB1sLr1Z9MOLdPgYyWFypgMXHd+ewTaT/vainEMtdGTopPXtw141CGtOsj9Lg2AvEPAOAf/bUzes/Sm7LdE7S7t9Tyw0E+VXSNaP1ciIYtwaB1qIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=hhs8qYvM; arc=fail smtp.client-ip=40.107.114.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJiDX3OnPCdDqzWSqIBjlkv62x3otfdFebyF+fFCD9D9x7E2jxNYODzzt3e76nU6QUzZIGaio1/lLn2QpqgzLpyRqDysu5pyWTwWpdi8ysAjUwR9hTXido0wmJVsmGENYqC6+5OOhG9ZzDNA6b8KZgtHqSjD/OSY6mkhsYO2Q5fthf8iybb3atEiAHqpJJIGJS9vUl1mHB1E0oEcL/uU1hWEH2zwC9dr1k1fwrQ1fNuh2PSCoOjfw6UDotqDsMNsbP538o3PVGb/QSVyZOGh2zLF8rKnvg5fOhB7T+AZTgICEgABelxDJ61gEVHtKmPeE3SFOf7HcA83Qtvud+rrLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFK7GJmoUMRSWjgWbbQ4v5r/X5jBGNeVBLTUeOssGrA=;
 b=JkVr/UgWrhsfrdW1O6g9LKr2MxKlYopJo/omj+GRupGjUnrz6TBoZ+Zj3BW8ZjMEaUxvAGjmu9ls0U+cmpVf5hjOFRdomMGMCJzuWtBpux6QkFqi/W8sR8xrceivZRbfIoDZfK1/LrJWYfAQz5OQA4aSwjS+dov9l3a0Dj0iJceLpM749iwjAPypT2q0O1/v5suk2htqSTE4qQTlnsMrOcgLfPMXmkUodWWspW6p4MjU0IgbdPW1ja0YFr0/JjuvJiAvj/OvnieI/Zl+SkKueIstUp6clsysPGTH56oALPR11ozbQ2ITDMP1101KukISevZoGnya3Qr9iNyo4ko7lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFK7GJmoUMRSWjgWbbQ4v5r/X5jBGNeVBLTUeOssGrA=;
 b=hhs8qYvMgF8sPz6a1MTvn6bgap9zHVM9Z8YEnczAXJW9LmPWTcBb9QelvzhI5fy+jX+O18n/sef8MU/hHezrYPjHcmDqQG5AMjwatofDZEwYxDEoGTJfPJpT/ROqMTqMYzQRx7hKHN8EsiC2gQ+lXiVmAncSkxJKNEwqRunSDDY=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by OS0PR01MB6178.jpnprd01.prod.outlook.com (2603:1096:604:cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 05:02:12 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::f9d2:106:9dc3:224f]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::f9d2:106:9dc3:224f%3]) with mapi id 15.20.7386.023; Wed, 27 Mar 2024
 05:02:12 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Frank Li <Frank.li@nxp.com>
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
	<linux-renesas-soc@vger.kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>
Subject: RE: [PATCH v2 6/6] misc: pci_endpoint_test: Add Device ID for R-Car
 V4H PCIe controller
Thread-Topic: [PATCH v2 6/6] misc: pci_endpoint_test: Add Device ID for R-Car
 V4H PCIe controller
Thread-Index: AQHafye97ZlAwgf9kU+dZUE2YnHEwrFJWvUAgAAmxiCAAI4qAIAA9/nQ
Date: Wed, 27 Mar 2024 05:02:12 +0000
Message-ID:
 <TYCPR01MB110404C21043F7CF7E2939252D8342@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240326024540.2336155-1-yoshihiro.shimoda.uh@renesas.com>
 <20240326024540.2336155-7-yoshihiro.shimoda.uh@renesas.com>
 <ZgI/IGe2L0rJ8SSF@lizhi-Precision-Tower-5810>
 <TYCPR01MB1104072DA4D6B3DF120A10D0AD8352@TYCPR01MB11040.jpnprd01.prod.outlook.com>
 <ZgLW6CGYfUW6Uskz@lizhi-Precision-Tower-5810>
In-Reply-To: <ZgLW6CGYfUW6Uskz@lizhi-Precision-Tower-5810>
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
 Ci4BFl36ZCaiizBfp0h/3QH3RzJxKC0BBzeG58XXQYhMZK3SYivRDtCXgHwOaApejGpz5oF02gyeYL3ws+b5tyRjbS0O/897DGSC38ZS0dciTr/yp9kMX/YzZ94A1j6ueZ+BAqbAEG+hXfWjXpN1l87Ze+JoU5p3e5cf+2bwR9DA+rwSK/Ni8CvKnptCSXewjMRZ7YLY2rUbihISgACFwpjpGpJKeODsEPUnNKl/Cz/chRld6yBzGp3ebIhQY7ZhJNl/8hRCtfzqkklf9a6bUEzpbzWrc9hSVAYjShO5hvcEOlWj439kHdUMroItjzHmgGKjjcuuRiM9qalJAwLfijnv4j0Hd3Y4t6G8rg5qQBjkn7wzRfhwWZ4peXyx7Zmenf4kYsp0tmmdTtn6fb72/mIcZV3rEcNteI7vNdWmExxOUWF6nBrbwToWxP6MEa9XjR4hjixx1U9i8yNTQ4xacB6OtSC094Y5kMMeRJ0AcofzXpu5TrWbjnFkYk1wbtz0PMOqq2hbcA6b3EGzRgUjuV6cGbGX26+d6AwDviPspvjTyUOIPAURHkzjzWzxQ/U8v4B7zVOpHoAwo64Zxjzrr/loK6HjiSYnm4lwgNBNmtkdblMZ6T14UNzn+AzvzTO6HaD7m3zocV1+sN8XE8gHRXutrHn7H3PK81gdJth9qxQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WFjk7x+yQ+i9yOo8zPf1MUiONSP2g03ljtM1IGwQK7QjmJYcoM0ERJD4NTua?=
 =?us-ascii?Q?x+Y8Y1fhgOo9EICfWm/RsqcZjk/MTxd1elCvJdksVaeOMjfiBFSmYXZ3CdDp?=
 =?us-ascii?Q?divjtDjTXb/GtGr/i3KCcR7cQO2Pa7wiq8zfnX5HlrXydS1P5r89sUCuKDfZ?=
 =?us-ascii?Q?Np4tChqCUnz61vCbE4eTlDjvXIYgrDFbJRcWXOWyxJspayP7/3V/iENl48GB?=
 =?us-ascii?Q?6Neb6Evl/IebzY0kSePrsYAHA7jsYkiLfQtUIi0CQiETp72/cjbNPQ/9ItEz?=
 =?us-ascii?Q?98DtWzio4UCaSEoWgM28Od2CuC9zuGzcmQoQ7EXm12b3RXa2pjF00PksmsFK?=
 =?us-ascii?Q?y78JZryqZxZlnax9vKPfEOaA/f7kjoFpAlb7KGvwn2BbOlEYyzyIKXWqlm8G?=
 =?us-ascii?Q?12mu0OROql6tEG/n2Ya6DnBe6DrkY0JyW1aYOu3iF3YijxtaAoA1Otsu49Sq?=
 =?us-ascii?Q?B1t+wm5tM7TpAj/9ZwZNMk6SquLJAxMD++avx3n10T/GVZK3O74Mm1iiM4Oa?=
 =?us-ascii?Q?JQ2Q2UeTGsoSZlDrxdmXA9u6FYg4wXhbV+xEpStwlgjDsIdGMEEP2FRc8edh?=
 =?us-ascii?Q?FkTnfZJRWhfFmsZwg7KYKyvf5+lr/arSHzlS9C2Pd10ld04maN8LawJE28ya?=
 =?us-ascii?Q?nistOoj0YVQXoM2ntWdrTNCx5XpHd5TuWHc8zSqFvUim42N+1XQ3ZNt+hxxj?=
 =?us-ascii?Q?qnfEvxlE/myGqYoAxM5o3sL1m/gBjIEqO1OQygnTBGJ2r/5SGEIWTCibzpbX?=
 =?us-ascii?Q?y7oDbkOw5Ut7hKXJA1BRgGzoTmFagQEPmSavm6J45TjKpXBUwzYIUXQrcYIZ?=
 =?us-ascii?Q?wkw1yNd9dzHCf3iMro41gdrZ8zZ4Evo4x85OCyOe4zf12BuCQyqsAdPv8KX+?=
 =?us-ascii?Q?n+sPemAuzDCWn+1aGwSo8G1YyzSjciAd4GGjvUeotjdOX9FkyjwyL5ONmzdh?=
 =?us-ascii?Q?4hsVwlXFrmFIf2bBdxTccFQbNKn7AQqlrYv80mJN9iIT4EE68P/S8xaLFCbn?=
 =?us-ascii?Q?n8dkfSEizmyaMZKqXdI/yV2QY69+NZYmyvWrsUt3bwb0aA6RCD5eMkk/kTCA?=
 =?us-ascii?Q?ONc6TFqgFB7xSf3QqKncHFWrHjl0y1FnMP4hFIg0cWow7HYQV0VTFJLo2o+K?=
 =?us-ascii?Q?l2ix3ej+xycSUmIFfQ74yWeeSlCiBu9PQhgLu3Wfi1YWgYP9y/rpcHsOO/6m?=
 =?us-ascii?Q?xwPZzNrZPhc40Azh7Vt297+YGkUb9KKpMdR5QSmwplDwx2v7AeRkVIzKU/fN?=
 =?us-ascii?Q?EQGkPnThnx1C+CeYVj+F/LO1WEXCQzWhdt3tYsyR3NCj4mSL+dlpcclpkXYP?=
 =?us-ascii?Q?cyqWaETybnqpCBY9IJS2fPMkx+RvzMyTxSom9rQvvFBY6NZnRbMcQrv0AP6F?=
 =?us-ascii?Q?PPfG7dlO8htioELaveGWDorwnfLsF0H5SIQBsgQmVmX6H0WdrBxao15IlTTd?=
 =?us-ascii?Q?LBlwGRk8YFC9XbyFopwPy0VbSWwJcoWZtJw/604cxYEpI8c1DUMQ2JId0hWF?=
 =?us-ascii?Q?nYAphU09nPezkNZ5qXwCf3KrDQN2aqA15R5JA6ASI135ym4TYa3Fjp0Q+ZEJ?=
 =?us-ascii?Q?AKgOTIgT+ozM0QiSFJa9TtVki+Y6UfeqE6CsdjwjPw19HAdO3MVPhjQyCh2b?=
 =?us-ascii?Q?bA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbec26d-8413-488b-0037-08dc4e1b1022
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 05:02:12.1468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7GsfeBPTTrKvNTBKKGR1PxVaPTMQQs1Ev8onGYEyHV6IG1MLvrz975LnqQ7xY20LK0SjNt12k98BTjdeShP953wCOa870sdwQoFLK0ysI6JKgSPrT82SVxACq3GvfU/a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6178

Hi Frank,

> From: Frank Li, Sent: Tuesday, March 26, 2024 11:09 PM
>=20
> On Tue, Mar 26, 2024 at 05:47:23AM +0000, Yoshihiro Shimoda wrote:
> > Hi Frank,
> >
> > > From: Frank Li, Sent: Tuesday, March 26, 2024 12:21 PM
> >
> > > On Tue, Mar 26, 2024 at 11:45:40AM +0900, Yoshihiro Shimoda wrote:
> > > > Add Renesas R8A779G0 in pci_device_id table so that pci-epf-test
> > > > can be used for testing PCIe EP on R-Car V4H.
> > > >
> > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > ---
> > > >  drivers/misc/pci_endpoint_test.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_en=
dpoint_test.c
> > > > index c38a6083f0a7..2fa3c6473c7d 100644
> > > > --- a/drivers/misc/pci_endpoint_test.c
> > > > +++ b/drivers/misc/pci_endpoint_test.c
> > > > @@ -83,6 +83,7 @@
> > > >  #define PCI_DEVICE_ID_RENESAS_R8A774C0		0x002d
> > > >  #define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
> > > >  #define PCI_DEVICE_ID_RENESAS_R8A779F0		0x0031
> > > > +#define PCI_DEVICE_ID_RENESAS_R8A779G0		0x0030
> > > >
> > > >  static DEFINE_IDA(pci_endpoint_test_ida);
> > > >
> > > > @@ -1005,6 +1006,9 @@ static const struct pci_device_id pci_endpoin=
t_test_tbl[] =3D {
> > > >  	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A779F=
0),
> > > >  	  .driver_data =3D (kernel_ulong_t)&default_data,
> > > >  	},
> > > > +	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A779G=
0),
> > > > +	  .driver_data =3D (kernel_ulong_t)&default_data,
> > > > +	},
> > >
> > > You use default_data, why need new device_id? I think you can use 0x0=
031
> > > to do test.
> >
> > I thought we can add a new device_id freely like other devices.
> > Since the PCIe controller's endpoint mode can configure the device id,
> > I can use 0x0031 to do test though.
> >
> > If such a reusable entry exists, is adding a new device id into the dri=
ver prohibited?
>=20
> I just think it is not necessary. This list will become longer and longer=
.
> And difference device id can't help us at all.

I agreed. To record it, I'll make a patch to add such description in the pc=
i_endpoint_test.c.

> We should use difference production as difference functions, or differenc=
e
> configuration.  Such as usb gadget product id, we use 0x4545 for all mass
> storage.

I see.

> Using difference devices id for difference function, such as 0x31 for
> ep_test 0x30 for virtual net, 0x29 for virtual console ...
>=20
> Or using difference devices id indicate some features. For example, use
> 0x30 means support write to EP MSI ITS to trigger irq.
>=20
> Donate a device_id to more valuable things.

I think so.

Best regards,
Yoshihiro Shimoda

> Frank
>=20
> >
> > Best regards,
> > Yoshihiro Shimoda
> >
> > > Frank
> > >
> > > >  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
> > > >  	  .driver_data =3D (kernel_ulong_t)&j721e_data,
> > > >  	},
> > > > --
> > > > 2.25.1
> > > >

