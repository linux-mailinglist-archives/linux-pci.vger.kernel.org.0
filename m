Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48E954C323
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 10:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239593AbiFOIKs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 04:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbiFOIKr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 04:10:47 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2095.outbound.protection.outlook.com [40.107.114.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D08C1BEB9;
        Wed, 15 Jun 2022 01:10:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9fxxMG+WGfiVWu9DREB3CA8FYacOf3ox7kIYCgRp1wI3bPvHdIeeuNFprFKfeUzkN6jajLjCDkmegiDTFNZxgJS9h7xS1x3osrsvHpFbrgF3zwDu4oGwbqRScWNwb1l2JMtAqE9U8N9GzhiWZYYBpwH+ivPGFYEGYc9ak0BI5qiKCvApKV8ptsKhM4ZRiXN1pz3ygr1XC5uFA6BOecX8YWwlid87bVVtDBjdBagL5qP5fxqum+lG4uIzapRSua5yED5lF9ggWZlw3FPNMO5dANoJ4PM+jk7MRyEfLxV9oUbb0GXl1Vz04wsjxg5AnAwM7thkIirUcZrTw4RsCXY4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8HVTZT1CelOjtzgVzBMH7nOCDfENaEM3uQyUXw8LxU=;
 b=NZhSZkJZcdqknE6n0hbtW1YLzo/0cvLbpxmd4bGBk2hhymDSnmUuTXzbC0ZjjJT4MvgtE078bhMa9CJVAHw9pxWrZzRQ53vkWm9jP/AvphmUGY58RaiHgKSLHXB6bHFVK0WuDERudEIzRm0w7jQnr+06wHlY8MVDSo81bPyKKusOpOKwTDZ6AMtCCT9rDUAvF3W4Q5fniCw4cLjXSjSX+gTpRGfLq6UQ+Kmrg7x96s+iMZUhLzj+rZwjPPCwjBwWcQ83Krt9zZ3tzgAC//05epKHEtJefPcbtflr99S41HTFmCskGwd59oaDFppw8rete0el3CokjZXANpCYHbS07A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8HVTZT1CelOjtzgVzBMH7nOCDfENaEM3uQyUXw8LxU=;
 b=okUDwZXflJs42ruhw9B/4VJ4TLyO4LNivgifSNk3QhOaQEbrYGFOnba/4Bk1R/wCpHiWEd+jB4eWSfRfbCd0hkGlfCMDZyhGjvb2mOgwFIMfhuBnkp0bKQpgTLAtQH+sZF6ITdP3UvbmUefSbJBNrTkKrcynX6knotyDFauL8kI=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB7727.jpnprd01.prod.outlook.com
 (2603:1096:400:180::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Wed, 15 Jun
 2022 08:10:42 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d%6]) with mapi id 15.20.5353.013; Wed, 15 Jun 2022
 08:10:41 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 4/7] PCI: renesas: Add R-Car Gen4 PCIe Endpoint support
Thread-Topic: [PATCH 4/7] PCI: renesas: Add R-Car Gen4 PCIe Endpoint support
Thread-Index: AQHYfxy+kAG60IrpCEyuzD/Dk9T4Fa1N4QiAgADjo1CAAIq+AIAAzvyw
Date:   Wed, 15 Jun 2022 08:10:41 +0000
Message-ID: <TYBPR01MB53419A943086159AB91565CCD8AD9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220613115712.2831386-1-yoshihiro.shimoda.uh@renesas.com>
 <20220613115712.2831386-5-yoshihiro.shimoda.uh@renesas.com>
 <20220613215043.GB87830-robh@kernel.org>
 <TYBPR01MB5341FFE04E29E43772683A90D8AA9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20220614194202.GA2209956-robh@kernel.org>
In-Reply-To: <20220614194202.GA2209956-robh@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d271e63b-e48c-4da2-4f4a-08da4ea68a63
x-ms-traffictypediagnostic: TYCPR01MB7727:EE_
x-microsoft-antispam-prvs: <TYCPR01MB77272F60CB59693E8A5C6B22D8AD9@TYCPR01MB7727.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kxbxfJnCh2VNZKQaa2LrdVyJ1upCIY73g0RZccLW7D7ulKUyB/1gusT0CAI1lfIrueu+ivTgXBsAzQus2Ikryon0/E2ln4XPPwJLVk/7BvB8GRcFsKL5Cdfid3T4vUXt6Zpl/J7YqIekQDfjtQobZNbhcziV+EYWGI/5yW76IoR9h1h7R+1Z+1LJ0syzan0d0x1EGlt4a3YAeusEcMt0XvJPw3Zy359TFzLkW2mTlKVKbMozRbJePsHkjDmW3m8CCE9FXSYXx4yxFprdztNOkxXgZGL51K3nWRMls51ZA8Xtyr+CUe0lRCRU4zVvojB0tp+g4+pHDROk5q/02T5x0QitWbxe/IRo/48bjPe4Luhl1g1zCelQLzQE0rb+vLzDHf8yQkb5jQfbnPxSWrSCWK98H5L5m9LHw0R3rZyQq+MD7j8V3sypcFKS2IYQHC491BYZhmpHuYFrssVHGmTwV3qSyrfhyFiN3JiWZO5GLzJQjewc+sFFklSuWVwkzV/5ibAA+7zMCYNLN09TpMoJWbCgqd6FdhEzUngzH4OOrY8ifmWnmIGM3+VTF6YYIeW+Zk0QrHuUq7dv7EnvgBZDfdJp71lg/tMhffZkXfZ1AC+xgZ61WUUgRQP3ID/52ejg6m2DvXlryiycti/SCiGszX4nYKQZggZOZJKp9vlbjDBS3x5TzebxJbLuXkP0duOc4sXLhmRrxsarl+8TyJzocQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(66556008)(8676002)(4326008)(66476007)(316002)(38070700005)(6916009)(66946007)(9686003)(71200400001)(2906002)(64756008)(76116006)(54906003)(55016003)(33656002)(5660300002)(186003)(66446008)(8936002)(508600001)(7416002)(122000001)(38100700002)(52536014)(86362001)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VuvFowTFZMrsedghAZ+2WFZwNGbvwPyWZ02ukhWEFurTxZfhz6wIhtuEl6Oi?=
 =?us-ascii?Q?pj0FH4VGjVgONITUHM48V3lvoCGo3hx5fyWuZEaDhf3dEPJBdj01Qo2MzkDc?=
 =?us-ascii?Q?iNN1W3heHIfoyE2tlr41P71Qn3iPwz2k4nnBXOeZ7TKrx2GP6WghbhHPRO8e?=
 =?us-ascii?Q?RWvA37fmlfOCOqhX33oghUhQAcGJeUFGVbHkSq266lqxKphli/F5GtaLqPAt?=
 =?us-ascii?Q?Cix3jt+xH+ir1sTYgAE70pW1Uyuny4ETaD9SG1LrqxtAi+cwWBvg56CC+jWS?=
 =?us-ascii?Q?vq8lehvmv1JLv8PgkJDWjBlSvYGrnsGffRNKffRQm8N4xCCI79EibTmUtcZF?=
 =?us-ascii?Q?kmUiAFb2XTff4YB5QhkN+p2KhqtLVBI/Rj9ixck8u1cnS07FGnc89JjqNu9p?=
 =?us-ascii?Q?H1InPhQBZ9V7XJ5bpBKbOFfa6gjeJP1S9xXFfchgK+u+b5MHyq0DM7/Zx1nM?=
 =?us-ascii?Q?zHRkJ2sGVmrfffNatJMZUbDNVcZXwKfXiMz+ysBfpSZk9zNSlENP/GIlS6Ez?=
 =?us-ascii?Q?AFlnXQXJuyupy+7o4QYwPqDHpaFzlHRmF8At80bDO54uIfBUc4yj6E80VMgx?=
 =?us-ascii?Q?d0VBgkMvyqRmSmKNPmweNhk7qal83qLX2j432n0ljhtj/fvEbQnbaU1qobh1?=
 =?us-ascii?Q?UWeybhPk6qUeh3OrVNMNLR+lM/Plx/iqUVcBfTj7mLn1JZyuS3FB7nyTQ4QM?=
 =?us-ascii?Q?t4+uP8RIA5zw4y6eMMdnOd3+KnZ3+pt3RCryupdaYf9eEl4qWnc6Kj6tUK4S?=
 =?us-ascii?Q?qny70L0J1D2LMUNDY+g/zPaoGj4u3thW16y38O/qzpL740/1+8s5i51k/4hQ?=
 =?us-ascii?Q?0xMAHtxtlIixXjfTubpTCEwfNbVvgsLxs8/YST5QM9gl43ybmpikQnzSbkCH?=
 =?us-ascii?Q?hsFvP3E80+obNRALaCF45/YJotStUjCEfXbQpBrUfyj9qmWF3xkmlbFY6dBk?=
 =?us-ascii?Q?UfSwX9pVOpx8roI30EjebARNehYgO40ZC+SUSH/77wcFVDdjzfyWcivYoYDb?=
 =?us-ascii?Q?mdMmhvfuI/N33AQI34vD8k2SDHo/SPeoMRONP8Ugv30Kv9YZNA4bmjKJeaqr?=
 =?us-ascii?Q?M3RrdcQ6805AUVP/scYiVoJ0Wi/8/B5zMrGSgaHplLKj115+AEO7sSZ8L0oO?=
 =?us-ascii?Q?NjMSYLbgM+vTd6xLxLy0FSTCd3RwSMvtCQ1618k8dvT7zbLdy/mx80W2JikH?=
 =?us-ascii?Q?YlWAfC0lEOWRk2kUPZM9oArsnrGEH7JVE4SShINI436/6lVJN6P75xR+m6zE?=
 =?us-ascii?Q?wUyXk0RAPlO/TF9kYT6sqwLdWjYHcw0yVG83j+MprWdgBQT5trUjEuw28eWR?=
 =?us-ascii?Q?kM3oVChQ/jJx6BiqPufesmA/6GI1SYeSB5ig9pI5V2g5WFZyYDDrc6FmSaNX?=
 =?us-ascii?Q?flQZJaPbkQKHWf1ro5XrTmD/Rv4ASn8OCcd36N0Z5Nf3MFCjsJpZhH6jmFIw?=
 =?us-ascii?Q?Dv9JkT8FMLuOeaS6wJF+xuePHI9tMpN8G7VpklKIuNdGoMjWvJGi+vSh/Qd/?=
 =?us-ascii?Q?J/gk4q1rwsn8H25UDF7qlab2au9NknGgV3/mkwkNwpRJN2e28UKS4jO1Sh5o?=
 =?us-ascii?Q?QhLLswFe1nhwrSUCjSa80x1FMi0eV94HU4R7ISHRABU0bKRgQZBOtTUeWVtx?=
 =?us-ascii?Q?gBgSgonqxk+Ofs1UcaM1gtpCM34pvbvvNfdWyp6hduRe7zacqSgezU3F29ij?=
 =?us-ascii?Q?a85b0M4+SpL3hJrpWbS4X8pCHfo36Es/zMSuA8rRXE3pfPfS+YVnEL6qS7qy?=
 =?us-ascii?Q?r2ZTnRodlXfaVPYkwOeIs0xBK+syWuK4gH/8Jf1Iy+3aCphu5Q6RvTVrEiZp?=
x-ms-exchange-antispam-messagedata-1: QnCcYt/Ic86GjIKKisHx4CD9j2qb5UVJt2Q=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d271e63b-e48c-4da2-4f4a-08da4ea68a63
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 08:10:41.9492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3M6qlrEyTUhNmWECJhG9IplXeZMY3Bf5lTkCZLTBHRTqVxrgCj3TUzNs4FHhjL/r2qmNtGqaPdLmwzpM2HdSj8U3nox2BCSuLHIj+l87wkJVEYFbE/CbfJZLfnPusT7H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7727
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

> From: Rob Herring, Sent: Wednesday, June 15, 2022 4:42 AM
>=20
> On Tue, Jun 14, 2022 at 11:58:46AM +0000, Yoshihiro Shimoda wrote:
> > Hi Rob,
> >
> > Thank you for your review!
> >
> > > From: Rob Herring, Sent: Tuesday, June 14, 2022 6:51 AM
> > >
> > > On Mon, Jun 13, 2022 at 08:57:09PM +0900, Yoshihiro Shimoda wrote:
> > > > Add R-Car Gen4 PCIe Endpoint support. This controller is based on
> > > > Synopsys Designware PCIe.
> > > >
> > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > ---
>=20
> [...]
>=20
> > > > +	u32			num_lanes;
> > >
> > > What's wrong with dw_pcie.num_lanes?
> >
> > The dw_pcie.num_lanes is set after dw_pcie_ep_init() succeeded.
> > However, this driver would like to refer the num_lanes before dw_pcie_e=
p_init()
> > to initialize vendor-specific registers. In other words, this value is =
only
> > needed at that timing. So, we can remove this from struct rcar_gen4_pci=
e_ep,
> > and just get the num_lanes as a local variable.
>=20
> AFAICT, you are just using it to set PCI_EXP_LNKCAP_MLW. That's a common
> register, so it should be able to set in the common code.

I see.
So, I'll add such a code into the DWC common code because dw_pcie_dbi_ro_wr=
_en()
is required to set PCI_EXP_LNKCAP_MLW.

> [...]
>=20
> > > > +static struct platform_driver rcar_gen4_pcie_ep_driver =3D {
> > > > +	.driver =3D {
> > > > +		.name =3D "pcie-rcar-gen4-ep",
> > > > +		.of_match_table =3D rcar_gen4_pcie_of_match,
> > > > +	},
> > > > +	.probe =3D rcar_gen4_pcie_ep_probe,
> > > > +	.remove =3D rcar_gen4_pcie_ep_remove,
> > > > +};
> > > > +builtin_platform_driver(rcar_gen4_pcie_ep_driver);
> > >
> > > Not a module or...
> > >
> > > > +
> > > > +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe endpoint controller dr=
iver");
> > > > +MODULE_LICENSE("GPL v2");
> > >
> > > A module? Should be a module if possible.
> >
> > Oops. I'll drop these MODULE_*.
>=20
> No, is there some reason it can't be a module?

Thank you. Now I understood your comment.
I think it's possible to be a module.
So, I'll use module_platform_driver() instead if possible.

Best regards,
Yoshihiro Shimoda

> Rob

