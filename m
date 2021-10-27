Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E353943BEFF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 03:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbhJ0Bbu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 21:31:50 -0400
Received: from mail-eopbgr60082.outbound.protection.outlook.com ([40.107.6.82]:39815
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231458AbhJ0Bbu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Oct 2021 21:31:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJa4fuMcWQdSKuGnNQEix1yydsfJpwq7Vaj2EbjBx3hiQJkA3dLOmP6qUXAt7TZqBNBJxGBuYfdIbvBJ68+MO0Fqk9DVeXrg3n+moACheFGsLZy9nDfKvrnDl3KOGuKMAISIiVjRofxaNpc+B8qZDCZ/tUySfLrKv2WCVrtStNPWknXdyOWOvlXFZHV8zYzKzdfjbIJrF/WwYcYkmExoMArlt0oBhoEnQ1AY+/Ky9pzetXsoeHnCWw9N7a4vXALPSn23oIQEFijwQVRPMwuaf8921rBjmNgZnUAeyyizHmGCP8Iv8cj+J/z0tGnOPg4btDH5EidQ7g2EdcrX0AvKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVODrxwJkq82DHQWrow/UaQFWja/29B/c+BG8GNAwhw=;
 b=Ru4MbOTSGj1sjDdVs8263LbBKSLrdb5M/gUMmeb9+7U+yUuXtV30JbkKIZHot3T/HdCFGoI8Q7NkQqDezhcxLqswK/tMR1VKzRkifX9zcoPpP9cvYFB+SHnGKO5+2LHHtEfYOTW5OFA/xYvSnsykv2wl86QTzGzOm75NobrvzIlRPoYc3vGwbMfNBdSdcR0L0Dqqu0bX5XN0A1yDyL/DMnH3qGn2V5HMmQXwclHCls0vwokTQduoS5AwBiLIdRd0hkQAZi4lD3nCzH1iE30vUhTMZYxIhx9oSSaPMEnvelumVoZ7zE4z1hgokYUfk5tAhhXrLZbkCjDYuUKebD7kmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVODrxwJkq82DHQWrow/UaQFWja/29B/c+BG8GNAwhw=;
 b=gvkvlDGXG9LilwPj3LxaITgmngq0rUL5hu6O8AtBAhKsizKV7NedckF9c1R2ML6PceAJGZhECcRAMeNlgMGpM2QW9m/2FVKiBCNAmJeEp7plscoMZ2vBvE6TPukhwX0awVrxeuHDoAYTZh0jHJDWwQWeORCxUdUivJmou1A1UO4=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8962.eurprd04.prod.outlook.com (2603:10a6:20b:42d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 01:29:23 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%5]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 01:29:23 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [RESEND v2 4/5] PCI: imx6: Fix the clock reference handling
 unbalance when link never came up
Thread-Topic: [RESEND v2 4/5] PCI: imx6: Fix the clock reference handling
 unbalance when link never came up
Thread-Index: AQHXwY4ue+QOjCGA8ESB+dHo+5+VOqvUZ7iAgAAAjYCABY9dgIAEuu9QgAbaNACAAJLXMA==
Date:   Wed, 27 Oct 2021 01:29:23 +0000
Message-ID: <AS8PR04MB8676FB7F7B4F8C1E43C79DC58C859@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <AS8PR04MB867697359A6D51903D0098308C809@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20211026163844.GA145569@bhelgaas>
In-Reply-To: <20211026163844.GA145569@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a1df0a0-66e5-48a1-7d86-08d998e93542
x-ms-traffictypediagnostic: AS8PR04MB8962:
x-microsoft-antispam-prvs: <AS8PR04MB8962947287B31DE176345BC18C859@AS8PR04MB8962.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uQmdEJuSfGTwK6h+1CLPc7oHURAcsRJ+NuQGqgB6KluEK1vyUuujgySqcAClK32CqSsq/GEdR2MuS12vMq3MwdO6lV6/xgsHDFRZyQHpTujsrNCp/BXVgbBa9vBp7z42bQgEVWShiY2J4EqXLMABVB/KtXvBO3AxMF83OdW1e+y108C8e5DjZ6vhg77Xp+ECJ1s/M13tIEjZ2YWe4RVGLCLT6wR5SDT+gF3G/CgBTu0f9Hko+bs86eCwrX8n33FRvzt5B0fz4Xcgs1pnZ0m4bL2RsvxNHJucix1lURhvhgZt6cFQBrFU8Z/ER9BNUU9Uy0ZJZcxkuuOALmi8ibxOIj0S4MohAXTmpjkOFk/PUVh2vf8KfcAjZWjlccMIiYQ2eZcBjNYL9Ep9ngAKWU4DSx/R6I+D2Vfyw9G4r6M0bPAC10h0iA/G+JlyrjxcbWWFoh8e1Rph6GcwZfmc9BcMJu5Uf+dToEYtN9QSWzQPj0jpx8799icT8nDmuGmDRo9qQJpYyqk9QndKgyqpzZmO7jTNsT9Wpq6lbornedIRtWV7WxlJmY0K2aGR5z3Hmtxu3OW+AezQTlILWSO8GtpVNFdxir5O3rq64vfPangEq50RazJcnoDkbrlKQB6VcP4FUUmqV9YSzn+gqQgZkHrnU+xMsZV9tbhnfUfagOG6CdbG7FRv+k/TFB+Jc0+jOECXjmL5uwKwMULmx0MjprayrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(316002)(54906003)(83380400001)(71200400001)(86362001)(53546011)(26005)(66446008)(8676002)(5660300002)(52536014)(66476007)(55016002)(66556008)(6916009)(122000001)(64756008)(76116006)(38070700005)(33656002)(66946007)(9686003)(6506007)(38100700002)(186003)(8936002)(7696005)(508600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V2lMRW8BliXv/5dYLJNxxk/Z5enhrHolVUdgTDEQzYoAALiGdkubARHvSdJr?=
 =?us-ascii?Q?k3UDQlBxzhuyhz3ryXgBnjys5js30kTpzTC/aNflDtiQ8E3RmxlJgnPSeEiW?=
 =?us-ascii?Q?/WEPWV87jWy4DHz8a5dRCpEr4jtndE6ZYSvRo3oEhgNf3YA+qWFtJKh5srzh?=
 =?us-ascii?Q?aFiHUCOhEwhbgI/vifivXp3eif/MjS/yYas3/mGn6kH0BmjQ7WZnia24bZfy?=
 =?us-ascii?Q?cq+4rLNKElTkKVoOvyV/K9gfooA1vx3lCy+1dl+K7gFPHXc5GJwCKScrSh/t?=
 =?us-ascii?Q?XOBANIvfbjXlfkH96VxifuN11270UkOMAjVlM2qzHPIXi8Bjfpz2bZSAi0vM?=
 =?us-ascii?Q?BFsmxxa6vO3NzzbD+v/j2eUK/1CxIyzK2hGz7w7j0yEp+wILcqMnu/NTkSlj?=
 =?us-ascii?Q?bLOnqZc0kyJhTkrcpPr/K973bNifE7kevxxbAvrRmYh+NFCdl3Ash20H6zmD?=
 =?us-ascii?Q?EIEdfUITLwxcGoByp+D078RKbtsZrmBVhzxjQQx8aAi5exyN3//tWCTfbH3Z?=
 =?us-ascii?Q?/E/lC3tqejZ/uLwBJ6XRd2LKsFFYgsjJPrwBBsm6h/Z8jU7GKLDhXnILRd06?=
 =?us-ascii?Q?ssplN1MyhWmr1vU8eilMFd7hxJXXcQk1XtVDdqk2pk1JJNfFeM/daxar7V3r?=
 =?us-ascii?Q?5bixP1mrszzP/eInvFTl4hPfK3CuyEnD3XLNI24dLCmVD6A+cGkg1PGSfJG1?=
 =?us-ascii?Q?4iOCUkw61gg6h5/KVbE8AYiIgu8anJvKKfENgNCraYvzVDCJr/R8x5i9QzqZ?=
 =?us-ascii?Q?T06Bd0GS/7Xfjo2GDNzLUa8O/BRHi5EgSq98OWUXN135eSW0VZG/tBUwRHCY?=
 =?us-ascii?Q?ICHpAMm1YUaK2JSpzdo2YoMiBgb4P7YaTI55agm8e5d2zmbDmz08LMS1E0NH?=
 =?us-ascii?Q?JIyKTjO76LMWEivVvsbzQv84faZzJxh5Fzx7noVVy0q9ypW07P/KrSRTn9ac?=
 =?us-ascii?Q?sQeJOoLQM42Rl7cePIPWLRcRRFHvPixKI4WWtLOJh3buOCPp04YIA63qCKQk?=
 =?us-ascii?Q?CNuI6jyzhCo4nZWkNKFUNueK6jCOvr4G4RvWiGwJzx1gDafKDe/Gy5jRIWdc?=
 =?us-ascii?Q?etiQhRz3cjpAHeO2T43hFygx0exb2qnK3g/ku/qJGZKTg5tJsmW/qyjWgNT/?=
 =?us-ascii?Q?rrnBCFXalWUvFDTVD9XBMdlAjqBr48kyo823y2lpy7BiRmJr9sK9nhqg43n7?=
 =?us-ascii?Q?PHuyz8Ugqme+h59jcSply42eYFatxMj1A58cRcDaOuxVLG0csrmdDWU5Xde3?=
 =?us-ascii?Q?4bzgvQbyCIzCUnAfaGzkkR74LKwHUW+Ip/CvskKoO/eYGD1ZpszmcrPo9dfc?=
 =?us-ascii?Q?0MTAWEOW5dPwL3szhJqeXYdXPi8hTEhDGK2SF9+7O1M2x/dOu6fxMcUliklm?=
 =?us-ascii?Q?jFpLFZbBCY2xSMwEfVlKnnnpeQvaeL9n1LzwiUh2IGbxcq4QrrLKOZbvVOAR?=
 =?us-ascii?Q?1pQIooVVmROaxDzlK6h3Vje8QiSfwoiZKxHZBVRsRl+up7ngtyZgTqLDHe48?=
 =?us-ascii?Q?WqgH8rGz5F6idMgTYJCieC6gDjObygbUH+HtoXonX8vslFUaap5C7yoJdgsV?=
 =?us-ascii?Q?hea/iAdhCAZoESFAj5AA/OswiY4nIQU0IyjhxqKSgEyy26Pigyb4uoti0gs4?=
 =?us-ascii?Q?+w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1df0a0-66e5-48a1-7d86-08d998e93542
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 01:29:23.7031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+JpOV6huCuaebOUiVP38QSPXDVgqRdAz3ibmskUNbfPvgDNjXmhsCbXI+9fPH3jedVjdNRp/8Pwh2+JFobmiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8962
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, October 27, 2021 12:39 AM
> To: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: l.stach@pengutronix.de; bhelgaas@google.com;
> lorenzo.pieralisi@arm.com; linux-pci@vger.kernel.org; dl-linux-imx
> <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; kernel@pengutronix.de
> Subject: Re: [RESEND v2 4/5] PCI: imx6: Fix the clock reference handling
> unbalance when link never came up
>=20
> On Fri, Oct 22, 2021 at 08:02:17AM +0000, Richard Zhu wrote:
> > <snipped ...>
> > > >
> > > > > > -static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)=
 -{
> > > > > > -	clk_disable_unprepare(imx6_pcie->pcie);
> > > > > > -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> > > > > > -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> > > > > > -
> > > > > > -	switch (imx6_pcie->drvdata->variant) {
> > > > > > -	case IMX6SX:
> > > > > > -		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> > > > > > -		break;
> > > > > > -	case IMX7D:
> > > > > > -		regmap_update_bits(imx6_pcie->iomuxc_gpr,
> > > IOMUXC_GPR12,
> > > > > > -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> > > > > > -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> > > > > > -		break;
> > > > > > -	case IMX8MQ:
> > > > > > -		clk_disable_unprepare(imx6_pcie->pcie_aux);
> > > > > > -		break;
> > > > > > -	default:
> > > > > > -		break;
> > > >
> > > > While you're at it, this "default: break;" thing is pointless.
> > > > Normally it's better to just *move* something without changing it
> > > > at all, but this is such a simple thing I think you could drop
> > > > this at the same time as the move.
> > > >
> > > [Richard Zhu] Okay, got that. Would remove the "default:break" later.
> Thanks.
> > [Richard Zhu] I figure out that the default:break is required by
> > IMX6Q/IMX6QP.  So I just don't drop them in v3 patch-set.
>=20
> That makes no sense.  The code is:
>=20
>   +static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
>   +{
>   +       clk_disable_unprepare(imx6_pcie->pcie);
>   +       clk_disable_unprepare(imx6_pcie->pcie_phy);
>   +       clk_disable_unprepare(imx6_pcie->pcie_bus);
>   +
>   +       switch (imx6_pcie->drvdata->variant) {
>   +       case IMX6SX:
>   +               clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
>   +               break;
>   +       case IMX7D:
>   +               regmap_update_bits(imx6_pcie->iomuxc_gpr,
> IOMUXC_GPR12,
>   +
> IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
>   +
> IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
>   +               break;
>   +       case IMX8MQ:
>   +               clk_disable_unprepare(imx6_pcie->pcie_aux);
>   +               break;
>   +       default:
>   +               break;
>   +       }
>   +}
>=20
> Why do you think it makes a difference to remove the
> "default: break;"?  There is no executable code after it.
> I don't see how IMX6Q/IMX6QP could depend on the default case.
>=20
> BTW, I feel like a broken record, but your v3 posting still has inconsist=
ent
> subject line capitalization:
>=20
>   PCI: imx6: move the clock disable function to a proper place
>   PCI: dwc: add a new callback host exit function into host ops
>=20
> It would be nice if they were consistent and contained more specific
> information, e.g.,
>=20
>   PCI: imx6: Move imx6_pcie_clk_disable() earlier
>   PCI: dwc: Add dw_pcie_host_ops.host_exit() callback
[Richard Zhu] Got that, would change to be consistent and more specific inf=
ormation. Thanks a lot.

BR
Richard
>=20
> Bjorn
