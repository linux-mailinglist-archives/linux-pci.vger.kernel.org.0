Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1FF43AEE1
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 11:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbhJZJVG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 05:21:06 -0400
Received: from mail-eopbgr10083.outbound.protection.outlook.com ([40.107.1.83]:8363
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232091AbhJZJVF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Oct 2021 05:21:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8HbGa2ebxlayaFHZ6KubX0YdJ5503dh6FEeJu+CZccFSSqpRoTuOQMTnXkNxi0Ba79H0gsNgX/iGEmegl7dj1hIj/zdK5Azkt0s1XXowiXIhqEZciMmG0dLcxj9xdFZdVcUCmKV/NT2I9rn6BCImVBmAeAf7uKL7aPJCHzWjx+/FgkkboYoERTxuXxrP14pzNwF0sxhMa8nFRbeIV9gesY8Ok/nRyzFrSQKWB1ZLkBGtQG1D1flDzPC/Tvkpj13Srb0cvjC7//76coJ8/qE0tRFWaBUTCB6L/R2B1TDA3K6Yy8tur7YpHj2XDiQmzeYYX2UJBL7j7rEYYKrUFK1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjrBRpAiYtVfqGmwLEsCp5FhG/WqvnLrFLFN9wk54wU=;
 b=AlK53ojT6kwQsuNUhtoDfq5g0HPe0d3HIUwSsPnKXEEnazr68dGY6BjN95QYChVH3GFzJMc+aXXi8TfgEPw+8UyGiiERgZM+vCdDhwvjWjkHfsBYx6MuCUkXFuoN7w7Q9C1hWRjHImKVsuTTGKV3ERo3i/WWXrHbVGDcmecwA2ISScnXD/jfIJILFY0XjirDvNiHxHVZO/YC9ixq7Ay6U2qjc7fgjFOGhQyRsWpnX4YEfCkcuhkR1KomXHbGdtRwG0r5ywhuS2ir+LOz3hLPbczSNpG5fEKOFSdV7V67FPDQnA7v+46AZOtQeNb27ciEAd27a5624/+USvcWPZ7Xpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjrBRpAiYtVfqGmwLEsCp5FhG/WqvnLrFLFN9wk54wU=;
 b=nf8FJvCDteZ/0dtn64eKFQAOqcNzElA2v1MX1OxZxAh36sM48hNQjESdrwNkNux46xrNzjeJPG62m5mgRzXjzeKv2pok3trIK67xkRMS4wdq/Zu2Ezk8ygkS7vf30umwQUSpe/9J8ZLkC/8iPamQD1xi5SPvt+1iI9S10Kpdd3A=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8753.eurprd04.prod.outlook.com (2603:10a6:20b:42c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 09:18:39 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 09:18:39 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
CC:     Mark Brown <broonie@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link never
 came up
Thread-Topic: [PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link never
 came up
Thread-Index: AQHXxxe5hpSrQkcPqkWGr8lEYEKQh6vjlGkAgAAC9gCAAPQyAIAAc9KAgAABivCAAAPIgIAAANdA
Date:   Tue, 26 Oct 2021 09:18:39 +0000
Message-ID: <AS8PR04MB8676A2D17A859730230CFBAA8C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
 <1634886750-13861-4-git-send-email-hongxing.zhu@nxp.com>
 <20211025111312.GA31419@francesco-nb.int.toradex.com>
 <YXaTxDJjhpcj5XBV@sirena.org.uk>
 <AS8PR04MB8676A0F3DA3248C6A27801148C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20211026085221.GA87230@francesco-nb.int.toradex.com>
 <AS8PR04MB867692D946818A84575F71AA8C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20211026091123.GB87230@francesco-nb.int.toradex.com>
In-Reply-To: <20211026091123.GB87230@francesco-nb.int.toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd2a73c5-1811-40ee-79b1-08d998619902
x-ms-traffictypediagnostic: AS8PR04MB8753:
x-microsoft-antispam-prvs: <AS8PR04MB875366662FB9F7C5FC2950C38C849@AS8PR04MB8753.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h03EwwzceEEw9Kj+m3oaSG4nGhexHyY5Jjx9BmVYCYiAyiXAlR+UbkmTAIRLoU+9DXgMeClG/8dnhjJD9/hTiA2PMvB56O6T13Xnam7Oq+DCX4CKkDIPWwnQnt6EfLzO5NcWgaoQv8nf4GDg44LareJzck+nJGHjx12stN3TjD4/KmB7IVo80pXtoymO5emWX4y4iHdiC5oCU0/W0sToCVDJKUxOftScbBuiRBaDyhfMA71ImOYMtVXWW6dE0teRwln3+6hnM1cRx6WxIEgXaC83UboLZStxhdw7MrMz1eoIY4GbfX0xRip0SA2R1Ov+kkOjNIJxDREg77zBED8twWAri13UdmDhBy4JfsdnsKotyXiD7Fdv+DodqUvjAjqFggTJvP8/yk8lrHlYPMhZ7BL9n7D9HAewmbuq+3PtNGuM8qsevY+12siHACcXxk2jsMOKw2J93ohg9+1+RLzjlGyjai+YHajVi6jy8EwMAX6oc6ZHfG8bmtRSd1w8nkFpOivXGrAwjI9wpXZJU94HB1cNLUUnjwSupw4abb57A4XZteM/ZkMu4kTf3lQjzappoziNt3WiqjSlCPfBaurEC0uU8/vSEUWXAf7F8eRwltWizGwBABuDqHLui3UO1WFoXuB5uPzbQBvN135C3M/z2qpR8jgn8Pwb37XycT9kpgbVxLnXpev1Bwc95KoZr58ZHERzw9QSrDHQh+I/w0vFOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(38100700002)(7696005)(122000001)(52536014)(508600001)(55016002)(6506007)(9686003)(54906003)(4326008)(2906002)(71200400001)(86362001)(66946007)(8676002)(64756008)(5660300002)(186003)(66556008)(66476007)(6916009)(7416002)(33656002)(76116006)(26005)(8936002)(38070700005)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wccQBrtd25WB+2Ls2t1Fc7Vti/3fXG336iPCPttgbv++spvqEI2G1KqohFLx?=
 =?us-ascii?Q?ZrMppNyQvIXZQ7lvW63lB1Gwbzh35M1Fn3FHWmMQ9nPBxbLybwdA8koBEtXA?=
 =?us-ascii?Q?gz/3eMBaiY6e+aQVpIX2vAY2ZQfBnI/daAou8c6uUwR4hpmuOIwqj3j2pyH8?=
 =?us-ascii?Q?zmb6AG04NThy1ASK8Y0+Z41mBPp1BbsMVyLJWcujnSGhZSGLzwRZZVLbuey8?=
 =?us-ascii?Q?5AgQ/S+TcZCzPzuysd8+6YMhabAtDw5b0iAOCyA3I7/AXBxExv8E/wBUh0Wt?=
 =?us-ascii?Q?g4ynbYJ6s8VyQl7IAdhjsheX65Kn4xS2pZ8/tr6/mAWbVlMdOCeN/uDYPhs5?=
 =?us-ascii?Q?UiTBZggO0fdpCThzeIwDwW1EbyED/Y96PeeaPbsaQNsO6dgDulHgYq3jLOHQ?=
 =?us-ascii?Q?jEKnPFN6VSTGYTubztbaGqjCOPGl/Wafdq7YfpWTxaJbnoVq46zGNx3IGGJR?=
 =?us-ascii?Q?EJXafDTSH8sq+b2KABUrYAFnja2apbNPTE9V/drz7+S3x2VO1fiXwwrGbksA?=
 =?us-ascii?Q?GHDIRMsA7h+f8ChpArWmMPi29d77sE6xNwKN1RhxZ2jceuaye2rXUTbc+hPH?=
 =?us-ascii?Q?RBTyQvAEZ3LOmsjWOflkJaDE8Fk1Kf1XVAIIzFy/43NKMHx7V2iQPNzt1fkE?=
 =?us-ascii?Q?XC4NCyBZVqH3fjHPafgAytn3ljiNxM7ec2tC/n4r+K2gWaBOhU+y6FWyQ4qH?=
 =?us-ascii?Q?R4V6V0IQt7odWMF/alHCV+qlEsrIbJm+8cESJ1db83wvhH2b0dXgyucOiMuZ?=
 =?us-ascii?Q?/XYB/aPMZ7UMx6SBXxOjLFdW5xVEDP/AK5W97Zy220v1NJae2ZPG/Lfm9El9?=
 =?us-ascii?Q?VRM7UHb5dqeNG1YIPDzIKKYEsi2XuMM9xZkszqjy80KZSfv0Ln8fYyf5SyhO?=
 =?us-ascii?Q?fbFJbVkWvVRo0A0b2tLvZrHf7w5P4qF4v2v4enDlhOwH2fmRlBoJSfVj809L?=
 =?us-ascii?Q?IUZE2KZT9uMf4ZMiSjAyipDEiXcdtJ2gDxvXJdrSVs65PJWrIkX9I1UMHn+4?=
 =?us-ascii?Q?FD7X/yeO8cvka/CxVNk+zwvhkHq/H1Y3zj0q4dBbY37Ay1435wja+pSd1iIX?=
 =?us-ascii?Q?T0XsCXomFPvZ0pEO+rmKYztdKBZgC1T45nXRYThzitwy/3/IT8ZEra+Ufpw9?=
 =?us-ascii?Q?uReoZl3ZiI3mHi9qDPboQJ/ZIBrc2QmPiNlG2oFp75PYgvUdlVVSp1amPGtp?=
 =?us-ascii?Q?zFL0iaPS6Vzip/0HeEVPWvf53hzPF8JLvZfhncjG4td6zzZ6mwWlGjtYMTGd?=
 =?us-ascii?Q?JB5bQ9f2SgCehFTCduu6xX8pgv93GePrKjXlyilI5otZt7WqgpDG0u4WfYFG?=
 =?us-ascii?Q?Dtfdoeu3NMuj4LSaymdpB7gjeqF6S+00tPjkTnoZt+cO2dg5VbHFvpuMB1NN?=
 =?us-ascii?Q?IFFZla9Tk/Sa7xG7LqflqOP+Upq04uQINJoOavdYIwClH1+Zz8WUL080GM2j?=
 =?us-ascii?Q?gKpAEuQujq9wcuWP1Yo7MjIZ2zoVpg6LcQcWZjiFxskUyM3ojCe3QVEPvkAD?=
 =?us-ascii?Q?amHGoUNHyRVmCei4YO7KM0dC7Q+yS+8bJsfWBhKDve0i32lVNjnveF8l+mga?=
 =?us-ascii?Q?4jvMHNX4Hdb5CCUOX3D48msC6wk4QXk6sITfew0QXQgmr7x0g/BMTQZXEgCb?=
 =?us-ascii?Q?BQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2a73c5-1811-40ee-79b1-08d998619902
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 09:18:39.5264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8ZwQ4xhEH4CRDaAatVJPGhDGbODF4/o6ztT7HomXtX52luHQ6BkpPgHfsfK/4eQSuR3S7oibg7a8CofWg3k0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8753
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Snipped...

> > >
> > > Hello Richard,
> > > I have one curiosity on this topic. Does this works well in case the
> > > regulator is shared? I just want to be sure that if the regulator is
> > > shared everything is working fine even if the PCI-E link is not used =
or not
> coming up for any reason.
> > >
> > [Richard Zhu] Hi Francesco:
> > Actually, this regulator used by i.MX PCIe controller driver is one fix=
ed gpio
> regulator.
> > Refer to my understand, this regulator is not shared by different devic=
es.
> >
> > Up to now, it works fine to power up the PCIe slot populated on the HW
> board.
>=20
> Isn't this something that depend on the actual board design? From the dri=
ver
> point of view you should not silently enforce such design requirement on =
the
> board.
> Am I missing something here? Would be glad to you if you can clarify in c=
ase.
>=20
[Richard Zhu] Yes, it is relied on the actual HW board design.
This regulator is one optional, not mandatory required for all the board de=
signs.
So, there is one _enabled or not check before manipulate this regulator.

BR
Richard

> Francesco
>=20

