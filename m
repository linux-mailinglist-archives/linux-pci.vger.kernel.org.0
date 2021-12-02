Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D321465E00
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 06:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355510AbhLBGA4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 01:00:56 -0500
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:54325
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233170AbhLBGAz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Dec 2021 01:00:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/1WpijpGJNhgxTGV9rRU9my86NJvqC/Qa2FrmAubM0t+X3B0deiV9NhvQwiIEhZuORmlp8Al9z1Qar/7nb8aQT8MyJ1LCuLYtAhJOgHfmUY3eGzKQ9DrqD4LEaj3t1BRhCk8dTCy8c/jS4h89EIPRdqg2U+svtacV3ZjQwgvh52e2YWLeIpYEatplQOd3XH/ZO6mxOI3PQMIK5R2e5D4yt7aAevxqAgndINuBrPqq9yxexZzZaftZpHJlO1lfu6bxnuFYOaQLPgbcIOrfmqiPnUa+TPVexRqk4Mq766SqB9+OGzh5ShPIDQO1ZVsUxEEs0cjXuCTqfepH2uP6IZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9mMu4dMTkX3knDe97Z3SBsKCUyOW7/Un6FmJ5JT1mw=;
 b=Cpc2xhoJZ2l8tMIiowWo/e21yJfu548nLyPKs+USI1PhgyiuDw0mMXjKAfC/jYgWFl3bVzGhNYhyh1l4VRmGCvYEMpQjFoKZL93WL0KNv1ZgRAHX+AH7AwLEhIu/TlRACFHJI5mxjcN7vuxiNAj1pAdFPQ983bW6/i83W0ccvN58KSauo/TnCwGEN6ccEsS+77z43xz0d1W60a3sk9s6570tsKAxy4eWjsNwHJe72hOWv+/7T0slaNnCwi/qkcLzXbCcm8VqlogwgYszjH/DHWPxd25uSVm4Xhdr5c+fiDAtdutmdd3swyLi4N41N6HKnnSyDmbNC6JmYymAu05A7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9mMu4dMTkX3knDe97Z3SBsKCUyOW7/Un6FmJ5JT1mw=;
 b=hlG/SVvkjwsLpC90vXc2ob1R8t8AgqXyq19D8vVpoaAXmyU+vAVb/MP3UxmjfftsNA+792E9IWQBz+43ld02Byb+bFCLioLylPyHr3g79MkGWh6abeeB7hETi7/mixrEMH7/1hLv+Kct9Nf6ffy6Tv2LpN6y6vemxB3CzfZa020=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 05:57:31 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%5]) with mapi id 15.20.4734.028; Thu, 2 Dec 2021
 05:57:31 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v6 5/8] phy: freescale: pcie: Initialize the imx8 pcie
 standalone phy driver
Thread-Topic: [PATCH v6 5/8] phy: freescale: pcie: Initialize the imx8 pcie
 standalone phy driver
Thread-Index: AQHX3CMKzvYWuy+ZGkC4Y11LciKTAaweslKAgAAUjtA=
Date:   Thu, 2 Dec 2021 05:57:30 +0000
Message-ID: <AS8PR04MB86761C166EB0A6555252C4178C699@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1637200489-11855-1-git-send-email-hongxing.zhu@nxp.com>
 <1637200489-11855-6-git-send-email-hongxing.zhu@nxp.com>
 <YahL1TMkt8S0RNX5@matsya>
In-Reply-To: <YahL1TMkt8S0RNX5@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66aa293d-2c0f-4285-a087-08d9b558a0f0
x-ms-traffictypediagnostic: AS8PR04MB8644:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AS8PR04MB86442E8E5D6CC6C04CC9E66E8C699@AS8PR04MB8644.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cYUsZ3ggC7xFynzuIWd5kUu0RBWXXDAMdXv+vMaBfHWoY7b5J2JD+nYWeM8LSAOiGeHd8aGbrBnB9bnXz5qsoSMo0T4Ob/Q8QMWYtfN15tR9kKmMtG5rIaDEeTJo+VlzrGONe1nH6e0eHDJaDH3d3/qAH8Cct/Dpt+RBmKtbIa3wEBVTnjJHwjuCCOxbZFmSScSRlXOorzjTVzjNakWsYWqKTJEMnYsofLTyS/V0uT1e9CbApaLklziLHQM5DVe4UZtcmtBs1l9Zl6Ky8rkgcLxhiD/xjX070iKSzjSTZFyqslG7pIwFm8t5yhK5+BSB7IjxqeIAp8+Q9ymlnJxgpEmumJU3Vh51jfyC8KM4DcOSAXbBh+Jl8LMvenCdknhsOtaw37xeLQhCq6cFdbhwZILUrdxkLMI0ufy2Sa3rc3LdJrp8iAgjqvzejwQcBXPQgpXNqpB2oPf4qdYFnU7prVud95VhugLdNRgspKsEJXjQu4ajVu1Js1j4vEXrrq5b+ZNHQ70J0SROZHxmghUM3mTJy9lID/lS2lVoyPztycBY5QGli1VpwEAzXQoQLsetiN1TEIUm6YFR5i/lQmgou4ucu/+DqGaCq59KkhdxZxYl4TgSXwAKP6iMWeFCAyu7+CLX1dHX/NaQAujuUEnT2oOVn71xKK1d9tScYaKyYNil6KUcbr7QeiULx+1hR0T4yfMX086Y59QixFHIBjCLaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(55016003)(8676002)(71200400001)(33656002)(316002)(38070700005)(4326008)(508600001)(38100700002)(6916009)(83380400001)(186003)(122000001)(66476007)(66556008)(76116006)(66446008)(64756008)(26005)(52536014)(53546011)(5660300002)(7696005)(2906002)(86362001)(9686003)(54906003)(66946007)(7416002)(6506007)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jLpHn1muFLgeEHFQYrtLLrK2fQ6nbZNxXWcdpBocxFrB0NcEtnp8KjpOG+4t?=
 =?us-ascii?Q?t5HtKv8yrwuJ3y4j32ddKHKOw/fWcwO9p4bi70iPfgIPSoNtMxh/oQHse2KQ?=
 =?us-ascii?Q?WNpEs1g2wePi0u+3v8DT06UpzYMPv0+Udtn1n6OkHRkqU1zU3/i2bmWS5hXo?=
 =?us-ascii?Q?e9/WieBGdfsoOu6PDIgvX4YIlykzhy5ZjrFELs1pPzBjDPj9ilnd2evFYHsw?=
 =?us-ascii?Q?qfDtHH+g3kgfUi+EmIRIRbpxwRxB5vYQxU9Jx0lh2hnhnGamLUpDSTAyZ3gi?=
 =?us-ascii?Q?kZZMSuY6akY/FVm2Rl/IG0Ay8j8qn80i/lAmLlTrUWHmTNU8ib6qmTZboEzj?=
 =?us-ascii?Q?UeTzVH7a7shgFGCR+jnhjfSduWbOnXnQms6x1wy4WYNY+jMfLFVfRjVWzX4v?=
 =?us-ascii?Q?ox41KpobHR3mvOzV7gdYIWJB8Ne7eu/o40FuY9zGbbHDyP9FxQ0kUZu8BAPM?=
 =?us-ascii?Q?sX8iSdn+i39VNcOtLRj+qfEfu3EYoIqJLptZHEFpVMGFxOtCmsyO5fqQ7Txy?=
 =?us-ascii?Q?kdWxnMgjLGVp13P2d/hoNWG6Un+73JlX6UoSCEeIQihzdtFaVWw4SGIfCP05?=
 =?us-ascii?Q?MmjJYh1wuEVKDmHgn31AZ7T3eO5ti5jUdTKAnd4JDEuG6Dii55cb83Kzdlwy?=
 =?us-ascii?Q?4Uy99SiWxkwUdqfVeE29JrnY23f8zdSjjgh97bwSGNpiu3+JXmkosU7qfxAc?=
 =?us-ascii?Q?cVbd67hY/ngAOfJvBzcrIgMIH7zpoUnrC6wYn/r4kb48VOm39VYMvjqzl1g4?=
 =?us-ascii?Q?0wKomf+X+1jxpJ9kGyaFzCSz5E7sMgXROndc5SJFdyk24sjkuy4M8NuG91jb?=
 =?us-ascii?Q?E5DMhBbEeMg7ZHwc2BoUG8NSTi7I1/ZoFsRR8RxaEALTyyrrXHJ6jZR3YaZK?=
 =?us-ascii?Q?eEdh2E0J89jEos6FbF8bEVTIAxC4kAc68T7s0XC8XYe5aBReWXfBJM7MDDT/?=
 =?us-ascii?Q?xNN3K4L1xu1exyfSmR12v6E+85VsvPp5f8oq7DDO+6F5A4AgH/v7ySogc7Fk?=
 =?us-ascii?Q?ORQHX5w785KIRMOJBAfly60wwsizo11I/9xHPCe1Rx+SiuL0u/ftXV07nxBL?=
 =?us-ascii?Q?78v4BTjiDAbJUp9tyzfkHllTYpyobj7L3YVTiXYM0Dzjypv7jxY+Aa2t4y4L?=
 =?us-ascii?Q?Et92HMaXvkPH2IR1ckOhtPvSWdkzTS/q1f6PxaMtbkBCcYxT+oR4XbIWfVDb?=
 =?us-ascii?Q?ebrXsYNgH3B/tVdIt5J38EaKcwIie7cVd6iJWCsX8pVcnGJS9bX0Q7Wo92xD?=
 =?us-ascii?Q?Yyza0fUhaIeyougpuzK3R/XDbjDAFy1IWK5mt/ooEnkl2GB7GTeFUIqStkjJ?=
 =?us-ascii?Q?sDrg8JAaxsZGbwjtVoXaMNYtuotbkvWuU/gPBoMFxl4ClwZz1XLcZ1eEAvJu?=
 =?us-ascii?Q?LhWCBmgrre6PO1ieFFSfNVeqWOMS3HRHk0BQG1j9NKxaEA2sidccIY/44/R6?=
 =?us-ascii?Q?n97KgRxmm3B7FHpfQ+nV0/VBswq+fhUbEKZQArtwTz9zfWq0yWjh8egl6QJQ?=
 =?us-ascii?Q?V0HSzINbZfxmGUM3vZRiyKStZF+zNJg8vWDbRxj1WVeYQP/2jcGVjdKOjt+Z?=
 =?us-ascii?Q?6aM39RnrOkhGyMgFDrVRs0WIfPOT9lZmUNKRmwFvEf24Mj9mAT/YElEZnd2S?=
 =?us-ascii?Q?8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66aa293d-2c0f-4285-a087-08d9b558a0f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 05:57:30.9986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CWckKSaWI/XUdhCM/VBqtMWvFX8cqRFipyI3v3lDfgri3qydQ+bl7OEx03aPewz3Ahgsncxhcgao2AllU8cASA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8644
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Thursday, December 2, 2021 12:30 PM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>
> Cc: l.stach@pengutronix.de; bhelgaas@google.com;
> lorenzo.pieralisi@arm.com; Marcel Ziswiler
> <marcel.ziswiler@toradex.com>; tharvey@gateworks.com;
> kishon@ti.com; robh@kernel.org; galak@kernel.crashing.org;
> shawnguo@kernel.org; linux-phy@lists.infradead.org;
> devicetree@vger.kernel.org; linux-pci@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH v6 5/8] phy: freescale: pcie: Initialize the imx8 pci=
e
> standalone phy driver
>=20
> On 18-11-21, 09:54, Richard Zhu wrote:
> > Add the standalone i.MX8 PCIe PHY driver.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > Reviewed-by: Tim Harvey <tharvey@gateworks.com>
> > Tested-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  drivers/phy/freescale/Kconfig              |   9 +
> >  drivers/phy/freescale/Makefile             |   1 +
> >  drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 237
> > +++++++++++++++++++++
> >  3 files changed, 247 insertions(+)
> >  create mode 100644 drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> >
> > diff --git a/drivers/phy/freescale/Kconfig
> > b/drivers/phy/freescale/Kconfig index 320630ffe3cd..e821498b1f7f
> > 100644
> > --- a/drivers/phy/freescale/Kconfig
> > +++ b/drivers/phy/freescale/Kconfig
> > @@ -14,3 +14,12 @@ config PHY_MIXEL_MIPI_DPHY
> >  	help
> >  	  Enable this to add support for the Mixel DSI PHY as found
> >  	  on NXP's i.MX8 family of SOCs.
> > +
> > +config PHY_FSL_IMX8M_PCIE
> > +	tristate "Freescale i.MX8M PCIE PHY"
> > +	depends on OF && HAS_IOMEM
> > +	select GENERIC_PHY
> > +	default ARCH_MXC && ARM64
>=20
> Why should this be default ? We dont do that for new drivers.. You may
> add this to respective config file though...
>=20
[Richard Zhu] First of all, thanks a lot for your review comments.
I see, and would remove the default in the kconfig.

> > +static int imx8_pcie_phy_init(struct phy *phy) {
> > +	int ret;
> > +	u32 val, pad_mode;
> > +	struct imx8_pcie_phy *imx8_phy =3D phy_get_drvdata(phy);
> > +
> > +	reset_control_assert(imx8_phy->reset);
> > +
> > +	pad_mode =3D imx8_phy->refclk_pad_mode;
> > +	/* Set AUX_EN_OVERRIDE 1'b0, when the CLKREQ# isn't hooked */
> > +	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> > +			   IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE,
> > +			   imx8_phy->clkreq_unused ?
> > +			   0 : IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE);
> > +	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> > +			   IMX8MM_GPR_PCIE_AUX_EN,
> > +			   IMX8MM_GPR_PCIE_AUX_EN);
> > +	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> > +			   IMX8MM_GPR_PCIE_POWER_OFF, 0);
> > +	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> > +			   IMX8MM_GPR_PCIE_SSC_EN, 0);
> > +
> > +	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> > +			   IMX8MM_GPR_PCIE_REF_CLK_SEL,
> > +			   pad_mode =3D=3D IMX8_PCIE_REFCLK_PAD_INPUT ?
> > +			   IMX8MM_GPR_PCIE_REF_CLK_EXT :
> > +			   IMX8MM_GPR_PCIE_REF_CLK_PLL);
> > +	usleep_range(100, 200);
> > +
> > +	/* Do the PHY common block reset */
> > +	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> > +			   IMX8MM_GPR_PCIE_CMN_RST,
> > +			   IMX8MM_GPR_PCIE_CMN_RST);
> > +	usleep_range(200, 500);
> > +
> > +
>=20
> No multi blank line please
[Richard Zhu] Ok, got that.
>=20
> > +static struct platform_driver imx8_pcie_phy_driver =3D {
> > +	.probe	=3D imx8_pcie_phy_probe,
> > +	.driver =3D {
> > +		.name	=3D "imx8-pcie-phy",
> > +		.of_match_table	=3D imx8_pcie_phy_of_match,
> > +	}
> > +};
> > +module_platform_driver(imx8_pcie_phy_driver);
> > +
> > +MODULE_DESCRIPTION("FSL IMX8 PCIE PHY driver");
> > +MODULE_LICENSE("GPL");
>=20
> This does not match the SPDX tag you have given
[Richard Zhu] Should the "GPL v2" correct one?
If yes, I would change it this way later.
Thanks.

Best Regards
Richard
>=20
> --
> ~Vinod
