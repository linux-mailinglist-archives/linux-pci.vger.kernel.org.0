Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B38E43AE86
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 11:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhJZJJX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 05:09:23 -0400
Received: from mail-eopbgr20049.outbound.protection.outlook.com ([40.107.2.49]:13097
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230420AbhJZJJW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Oct 2021 05:09:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRK1eCwNoWLqdmWWLJwfzK7gTYg2labM9KL51/qyXjAkV5OXQirIMY1wwMmZ87ybXyMhDktD9niGCQ+qMIrYzbMBnPpVxy0skXca2/pzMwhwugPI3WhoVY8Pas2r1JXwMA9PERqebCjX1Td65gXgL80OuL/mTB/TUo+8/iAmqeLBUai80jmSzjYGI4eYvnAMCRNIzxfCM1pU899nHvpBD2vRldsJr/Ev1zc39jm+RXgEYMiinIC9zpNn+tTBo1IxYnkgYOwsv+j+VDv+UDHlv11NbGBGXjebEgKLBAnjp8UVqdlpLvYMRnLpogvziS9T9rA1z90ITUNMyy341zmXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAqw4QqmdFMvyTIv6zlHfpLhgirI8DhUm5iQIZ/ztZ4=;
 b=Psz3L6v6u8zXvZOmTG2bFZv3SvyDGwZeiuF41hCwzu/zEWHZbNuQQ+JgWzCiGUPzLd70xyY9aSg3m+IDskIDV8EWHnlvoVll688RuIio0QnH62hb+YYQ4AaQSOzQIiVx5hzBPa4nMUa5/hl8priPEJVRmCMjRsqpCEb+AP4m9ND38y3wv7O9n+V/vbDHj/YPOGyUVu8SOe4H1Mnj2hqy1ttO2MLwKQgBBCYjvrm3BM66gahTeKvuLULaM3LGpd3W3Cni+P9hM1n9lrUPZtgf8MdI6kWnV4u3O0tZOvlnNyFSObLAqj6Wdr1ypECY+stex+IKe8+0EoknfhxNmob+jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAqw4QqmdFMvyTIv6zlHfpLhgirI8DhUm5iQIZ/ztZ4=;
 b=de8tI9MF+HJCUI5NbYW7035lospSfd6P/bTVrmTJDHY6QDLHiE8k49xAUso+ngNqxOcsgDMqXK/5lK9gr4hBdDboFAhEh0goQakmvqH7FzZx+mcOUc6QoeV7gnsDOkvmqLk5bgDVS2rGbxgDk2o3yp/1/dTadcFX6DspV9eh1GM=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Tue, 26 Oct
 2021 09:06:56 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 09:06:56 +0000
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
Thread-Index: AQHXxxe5hpSrQkcPqkWGr8lEYEKQh6vjlGkAgAAC9gCAAPQyAIAAc9KAgAABivA=
Date:   Tue, 26 Oct 2021 09:06:56 +0000
Message-ID: <AS8PR04MB867692D946818A84575F71AA8C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
 <1634886750-13861-4-git-send-email-hongxing.zhu@nxp.com>
 <20211025111312.GA31419@francesco-nb.int.toradex.com>
 <YXaTxDJjhpcj5XBV@sirena.org.uk>
 <AS8PR04MB8676A0F3DA3248C6A27801148C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20211026085221.GA87230@francesco-nb.int.toradex.com>
In-Reply-To: <20211026085221.GA87230@francesco-nb.int.toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18652afe-c9b3-431a-2945-08d9985ff5e1
x-ms-traffictypediagnostic: AS8PR04MB8898:
x-microsoft-antispam-prvs: <AS8PR04MB8898EEEEE7F69E521A68A6588C849@AS8PR04MB8898.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tcvMFrQvubAw1o0/yCLSy16xSFAzftIa+JWzL73OUPO9LPKoR8xgIJyeuFpBduRHwrBN3EjTPvBh7caPLBdElzTrxL2f0bHuf3Fwe52xEKZUQf8Ox5f7DNJSH+7pcXdC9CK9YRmHNN/S33qir4MQeUvFkN7Pyy8zu9eqLfKNrRySFpwiqCK4T9ibTUl3pFsFL7fwFdWcVJMoaixLuJzOHwxb30hB/rUG1/GPSf8aDQoRbPdBFBkmDy7stpk9Hj7FiX2214UPqay2nZUDWM1gEJtmtv4LzWpc+IWhBkqlTO8PM1tgOnNcnm0TdJRfGaMmnFRpkmlnSs+oqYJwDlZtn2tSNNkV6OIeL4FCzQyomAXbmThcU2qvPKSWlZ2vFKsMDubS9VmF7J4EFFF5LtUK8U1/25JijLZRBH5YUZsnal2DeCfh4u8Gzshlnn5R7a1mU1uIIam2Wg80jC2Ui/m2myO9ME6vvrbytsXO3SHdWHfZ44uC+JMIx9MJhOL5VdfCaPRt1IC+vKPeMapny5AGdaNfYPwbrwRNhLNDkorTBAFhOUN1ryOgZclTe14MEYO9J08NIYr9wQABI5ws1cC72AFDQFXzJjqOAWm7SXDwbgforlyD8Ichl3JhzEMy3+bhql3Qd0qyubF8BzRCwgtY9+L21OtMDuqyZmkQW6dFW7Larv/UKqMaJXFEJCVTXa7BvYaFU0BVs6OhO6NCB7l/ew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(38100700002)(316002)(54906003)(4326008)(38070700005)(6916009)(122000001)(6506007)(8936002)(7416002)(2906002)(26005)(33656002)(7696005)(9686003)(186003)(66476007)(83380400001)(71200400001)(76116006)(55016002)(66556008)(53546011)(52536014)(508600001)(66946007)(64756008)(66446008)(86362001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6mflYwimG8iDTugQuqQSl4UFmpx7BhxD6t1kMxiwcLirLzVaMX81GQxVfaWR?=
 =?us-ascii?Q?9Ti34qnUqp5bvAMDLQhWG1hJGuxcFEX6K++vsSBR8EDO3EOKa2VpwZLtNeT/?=
 =?us-ascii?Q?4EDxi06OXQpk4qT0C5pWgOEFgtrUSnivgq86a2le15F+VyaG1MnYmUWfV8qb?=
 =?us-ascii?Q?MZ1ntCPrCEh2wBwiwHLGnR3OSfhPoYScTZLSu2ygZXI8DRa+Dew+VSweBk+s?=
 =?us-ascii?Q?i8MgzYvbvt9GfuAcmqixO5/QF5gNEqyfCF+LZoQnPqzaUrEUvYEyxBYjy8ra?=
 =?us-ascii?Q?EzMh//LOk+iXmYLdFpeiLZW/Vh6UEFeaQnIkYhhScDcURCOOhl+vdNoWulfj?=
 =?us-ascii?Q?YuvdCxBetJ8V0/e+z8/5I2rw6ZkqpWZk0gppIWBFRg4+6TrPTJO7JcaHECkI?=
 =?us-ascii?Q?xvqbatWC9TMmKvA7auxuTrxrvm6/64VpWojDXkNXjhUtonYVlp3PdFFbTB72?=
 =?us-ascii?Q?KAQtpKe7+rKwaN+vKfNleE7pmFsNslMNPZNxoz1NOqNY/fq6k7bOTTAG3hmk?=
 =?us-ascii?Q?KjxWeg/fRMf7oABNUk6n8AS8y7PuJbV8bWpuzfbz75mZXtpEvwFxJ9as3I6X?=
 =?us-ascii?Q?b1SxQh1x1rU65h/XCwN37lvUGoZDSMZeI22Xk+0WQ8aej44bXoCKtlUeS23d?=
 =?us-ascii?Q?guIusYWxm6T8i4EySLagy6xdnpCYPmcYpArCa4lMv2yINMFiduxi8ge/8PIY?=
 =?us-ascii?Q?BBjO9A1npEnhruynG1R6ibqEP9ipR1f2TBInr68AcAl0d7GxTnq/Pb/M9vRh?=
 =?us-ascii?Q?hBMcwpGccQoBxbY3C/DK9T9sCFbnB7NDre7pLzibs48KlVELJMH5PtrbR/oH?=
 =?us-ascii?Q?HqR8KlxwUd0bhpi7roQpjBC0PeTYe1bkcjFQVMgmcgu5RNL5ZFN2oO512nxb?=
 =?us-ascii?Q?DQ42ZpJbgP/plCqyn12OpBBLdAcwOLdomem1nj0r2R21Xf+Z1rhEWjlRnUai?=
 =?us-ascii?Q?XCiv2aeGC5zn15NRr7KpxMAWi6AKHIBxWJgUE7SRUCIJK+kUmBDla6gvdXZf?=
 =?us-ascii?Q?aVaxDB3KzawMJinbSMO1in1fI5d36A5v4LmgcHt3fdDF7glOTvLA25wpGul6?=
 =?us-ascii?Q?45C2vAK90dy1CRBWhL286zCnwnevE81Vu6zMmha+FoOjhH8jCBZBFlLSb8WJ?=
 =?us-ascii?Q?XT1tKGNksTv5RCP0C89dVqXpH34Smg/IMtISdSX21RkjqvyNFIYn7DI2IMnd?=
 =?us-ascii?Q?3W6LSzTxeupAjdKeTZBfKDF/tHaIz5A0/yzqmeUKTZ/GHnSTJaPPNOdzm795?=
 =?us-ascii?Q?iNtvtIVakdEcfvZpUG2P0G2FuYKdWdh37kkFHqB5LafAr3niNev/bh5U4KGl?=
 =?us-ascii?Q?UNF9Jt97mSI9fHeyRdkykzl7GZgNFiOWY/ZU305y77xF8aLVIX96qsImSuD4?=
 =?us-ascii?Q?bWk9EW8CkzAmwKC9c97kpXan6iZcmDcpXb1Px29xeS+ZudMocIEIpIAL4gOW?=
 =?us-ascii?Q?9D+5TxZFEXPDp4HD6cSv+0bWBWlmy1SbMf6ueMxL+bVNKTE6xZX9iK9vt/Lh?=
 =?us-ascii?Q?svxxNqDxS7ymWQ/oYPtpjW6GHjQ5ZlLZsnQPN+WCZ9AExnEqBZ5fm0rStW7R?=
 =?us-ascii?Q?Lt+GeYVtlvfsyn3QGnKtAQT8tC885/kDozV/Pg0x9aRXrp5eUu/U5zoy4i+u?=
 =?us-ascii?Q?KQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18652afe-c9b3-431a-2945-08d9985ff5e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 09:06:56.2860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hyYKsf9udVkgBUgQpU4WQtlEL+0xtjVO+08PlwuT0wE9SkhpvGrjYLraVWw2cmWTeIwbpP9Jx72hEt6DXP2GOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8898
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> Sent: Tuesday, October 26, 2021 4:52 PM
> To: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Mark Brown <broonie@kernel.org>; Francesco Dolcini
> <francesco.dolcini@toradex.com>; l.stach@pengutronix.de;
> bhelgaas@google.com; lorenzo.pieralisi@arm.com; jingoohan1@gmail.com;
> linux-pci@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> kernel@pengutronix.de
> Subject: Re: [PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link n=
ever
> came up
>=20
> On Tue, Oct 26, 2021 at 02:18:18AM +0000, Richard Zhu wrote:
> > The _enabled check is used because that this regulator is optional in t=
he HW
> design.
> > To make the codes clean and aligned on different HW boards, the _enable=
d
> check is added.
> >
> > The root cause is that the error return is not handled properly by the
> controller driver.
> > I.MX PCIe controller doesn't support the Hot-Plug, and it would return
> > -110 error when PCIe link never came up. Thus, the _probe would be fail=
ed
> in the end.
> > The clocks/regulator usage balance should be considered by i.MX PCIe
> controller, that's all.
> > It's not a general case, and the problem is not caused by the regulator
> support.
>=20
> Hello Richard,
> I have one curiosity on this topic. Does this works well in case the regu=
lator is
> shared? I just want to be sure that if the regulator is shared everything=
 is
> working fine even if the PCI-E link is not used or not coming up for any =
reason.
>=20
[Richard Zhu] Hi Francesco:
Actually, this regulator used by i.MX PCIe controller driver is one fixed g=
pio regulator.
Refer to my understand, this regulator is not shared by different devices.

Up to now, it works fine to power up the PCIe slot populated on the HW boar=
d.

BR
Richard

> Francesco

