Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626BA64C17A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Dec 2022 01:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiLNAtU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 19:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236514AbiLNAtS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 19:49:18 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2054.outbound.protection.outlook.com [40.107.13.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF15755BF;
        Tue, 13 Dec 2022 16:49:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N13uYs7T+CDYIiVT9do+yyuELOWsOGaWCht2n2SaxL21IPX81Xsu/E4lNRJQ1lcYuwDN+4JgqfuuH+GEJX3lzl02sDFrIKlxREfundLssIN7H8YluEu8OQz2zklpC72nVhjuzcg5H/dgy7P1wfybLAj0mK0RuZDn6el2puimAJk13uHyRqbcwiVrV4w/C0VKx2/S5pf/EenwJC/Mytsykg2LietvNZOBufOaXIIBf7/RPBj1i4PiA/ED6OESt6WWD85IHj+WSuqmj9Nm21PRIw3m0Lp6p/Dnqj9bglpgnbvhDS4zo7JBdzyBLQqOBOeK+/SgkStI97vCaYu0xhcjgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXfFuKc96in6n1JNo7W0mEi8Q6NtFsyTzh4fdlqp18Y=;
 b=K8+hrCXu9Um2Reu44LUanO7xg2xSkguRekZkcBAtu4+IOtctdY9jJ+nX3igBsriHnrlxNT+XdifWc1YFwM5AQc2HVxt37glF//wFFJuVPNVhijHca67La7vh80y/SPXpt55ZY/+oHDX4bWhu3sHevENgPxUMOaku2S3tMSGLtN1DRHftJZ98jr/Iz7Kg/jpYp3/9Sm/23469iKsuZZbeMHh0TfvW+O/ToawHkIIe2yoogxzGKNSzZtLreRedWEB/3oYLLG5v+jY0NkRs5M/S7fbnQes2/BncItIiSTAUKfJpNRVodMR07iUV7WiQm1TmbmQyg0nd5Ea6uo+2LWpWSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXfFuKc96in6n1JNo7W0mEi8Q6NtFsyTzh4fdlqp18Y=;
 b=Mhb81PK0BcNYoBfoDu9aYjYEUeL3gBsY4+pLGg0tPUxBmjm2xMFPz5hl4yUZX74lgDW83D44mLaZoM3GufYq5Zgy8SoFTu5x3sDVplZWYLtx19zdxH4VZ+5p/0/z41BK6DOLTBaNDTUUulX75e9JhF6bnIu4x99b8j33DmYCMHE=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AM0PR04MB6803.eurprd04.prod.outlook.com (2603:10a6:208:187::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 14 Dec
 2022 00:49:15 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663%12]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 00:49:15 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "mani@kernel.org" <mani@kernel.org>,
        "allenbh@gmail.com" <allenbh@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kw@linux.com" <kw@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v16 7/7] PCI: endpoint: pci-epf-vntb: fix sparse
 build warning at ntb->reg
Thread-Topic: [EXT] Re: [PATCH v16 7/7] PCI: endpoint: pci-epf-vntb: fix
 sparse build warning at ntb->reg
Thread-Index: AQHY7sTvWWy/9/FSxESkmjmsd2hT965sx/AAgAAFv1A=
Date:   Wed, 14 Dec 2022 00:49:15 +0000
Message-ID: <HE1PR0401MB2331E04D41F5EF9F6F1E326288E09@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20221102141014.1025893-8-Frank.Li@nxp.com>
 <20221214002642.GA216337@bhelgaas>
In-Reply-To: <20221214002642.GA216337@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|AM0PR04MB6803:EE_
x-ms-office365-filtering-correlation-id: 0c89292e-e596-487e-0d1c-08dadd6d062b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z4R6M9U1LI/lUarkODKpuBLEDkDilfyApj0Nb167gdApE+f730/jZlOzk6EdOOKzE5qe1tGuto6FpvKo6/LuNrrklgxJ/0XlNXeRa3XK+ZV3snPNSKmSnFP9D2HIaUDfeA8cK4bAlhIVEo9HOS+nXZZ9RK6zi4zr9QaMlNx2HWq6nhGLn7x99b9AT4Q+fIQO7QPFwONR7B854CR7BjAhwT2e/VDJpOQImLdbXtUYCvVTVasC0d3cslp2zk8x5W0fvbkUJ0Tkc4lqUcm5Bej2Zicq/vUTg7FPQWS0nijMrsJ4Myo5mTiWiHlufrLM2dNp9i5P9uaBIE3nveXPDAtlAqwxzSCWzHpIZfLlc/sUfnEfuWtmRKE5p5YTC76wfMdtl79OwI1uNc9KuXyfBXZ/VgtlllQxR2mEYpux7PIsjGiMSlwzd9QU4xO2RE6xfcwutkus7xF/o/dIfKzfqou5sTX6n8j9oSA7/EWhQpQqCwquj0x8aER3unAJVbebLg4sBR2ktbM1OI6eoPvNWVThwmkm/yYvyCZjAB+3OGFEk3x4NRRVQUd8uyNjdmoVxLmCvcXK5Jy9+PRmtFBKzTayr7rMOf+U/JEXNW7/LvUYRG5mofhpLYuKdh1paeNsAVAmyDOqz49n/OBIZP/1HCXPkMAd6oKhrJ1UPtYLyGwlfKVwvBPOaH8pOAmMoxD79clp+XeBpWQzzWJ8KQ+ylDEnNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199015)(8676002)(41300700001)(4326008)(8936002)(316002)(66946007)(6916009)(86362001)(7696005)(52536014)(26005)(55236004)(64756008)(76116006)(66476007)(478600001)(66446008)(66556008)(83380400001)(122000001)(38070700005)(55016003)(71200400001)(186003)(6506007)(38100700002)(33656002)(9686003)(54906003)(2906002)(7416002)(5660300002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LP06a8504KctKoviBAwDfnfWJDSHsOVIA/Pi5CUZiTXGwcrlAYqAkvp+mZCf?=
 =?us-ascii?Q?7+hOOThoDcKIpaACQQzMyA36K+BNy2oWkprYh8asa6fDeWM5hM4WyS9V3z4X?=
 =?us-ascii?Q?4zEkZkobwpDhALyTZKth42IrhdRskPTVWWiDeLs2gvkEF/EoXKo0k+H24l1s?=
 =?us-ascii?Q?Z+IGFHnSctv+fsPMNZ+lugV4s3YBmztvWnq82jpXMyQ2tPquqZUvvG3rlT/H?=
 =?us-ascii?Q?XbzS8AsSUa6j+kQzaXR+PMSM2reJ2yzeiZuXsLdKStbK6q7s99PsILrD0TeQ?=
 =?us-ascii?Q?kMN30/7vGMHSdvI+ttfLGo6QW5TIq/Gg1bvygfHXZmj6HjiMzNURzeN48lhU?=
 =?us-ascii?Q?OTjEI/yUq8+Tfzu7RSf31pHSDL6V+VXHpxHgnHYe/eJur2GCs7rSppc3qDhq?=
 =?us-ascii?Q?y7VWc3QMmfCloT3ae5F7O17VAjWI8FPl1Y5mUI0fE5oakyIFsd2kKs0soaC0?=
 =?us-ascii?Q?TUucBPWuHB+Wxm+Q4jYy3kKtgSNIqpjgF7FbJkPCk3A83WmCmVT4rDYocxAP?=
 =?us-ascii?Q?mGMSWSV3swqmYpC2aQ38txC8UTHy91NvoVMCwQLAGYO5o3dWxHVNpXEguhhN?=
 =?us-ascii?Q?VDl5sfBGHIQ0LvAE1idduhvn28yv43FsA8NwhIqEeA6gXIxcdC4gyAhB0y2G?=
 =?us-ascii?Q?Y2nJGta9MUh0tE2uAekDoSQd+VEJOJXPGccZoRCyNGU2JqWwNuWrOTC8NcVU?=
 =?us-ascii?Q?spwOYG6hhYhaxhg8F06+9bSJ030aWTczdlQup/cLgNFXoZPC8WQniEpEAwQH?=
 =?us-ascii?Q?1evk42U7neh7cZDDEGnnDrKRpefDkQHLwSwCUIJtUXTTve1Y4JfH7WMSKRqC?=
 =?us-ascii?Q?4epzxxrsUj1CS6IxPX8fvf3aolvoIIKjYkwgUKXTGGq2MW6jTJqlITMv4Nun?=
 =?us-ascii?Q?XhkYfqugS8xDLDLo053y8JqClr1I2uHWti4ANtE3/3x+k1eSmAlNeIJItsc6?=
 =?us-ascii?Q?NeSFKbYJq4RBKOb+t605ogS0M7G84Jl4GQp2kPJo+VEkL0Cwg1LvFKtCEBJj?=
 =?us-ascii?Q?0CvuPGDP0nH4ujh09hSuY4duQJgBV5vtd3YKr5IDbil5YP34kpj50OwMa5+E?=
 =?us-ascii?Q?qV2yzsAfrrF/75ZGK27uh2BPiOLJA1rohdrJ0HOBD3J3X59SD53W7tK4JSs4?=
 =?us-ascii?Q?msYcHCVcgDOcWSDPC87rXYJ/UXkmnXY6D3Q3KUCwzZCTBVgHq8otCLC1YyUU?=
 =?us-ascii?Q?xJJMWXaY5XtZkuOVeDk9k+n3UeMMmKKEoXkIqURbPdaZDyyZKMIuqtl3SSaw?=
 =?us-ascii?Q?BWGL3Entdyp+x/RaOshl8HXyG/j+vIbw44uOhgYekNzwIFiFejLW3cal7dte?=
 =?us-ascii?Q?W34T2XuYwnYyuaOXyg9tnDq3CUAaPUDXDzCSjorCRcX57MFPOajo/j5OWRBS?=
 =?us-ascii?Q?Zf+8LSoBnSKXHg/4ZIgvw0SwfkNHB68IJudTrDV2zcR/QenoR5O4p6oT1BDH?=
 =?us-ascii?Q?vjH9pqV6f45m+peyMwZQC23z1gbiu9UjO2qY6MZFufc1GVXcL0nyG4/1Wat6?=
 =?us-ascii?Q?mXoIOerlR85tsZpZqgUAZYKI1zDbxdJpvLC8NGGGlXd0xerZnChHgI40eMzB?=
 =?us-ascii?Q?/u3ghmr4pV2Zgt/1zu4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c89292e-e596-487e-0d1c-08dadd6d062b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 00:49:15.0536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/NyrScgAl3e+b+CBw3RrVGdh3MunMWxgpsHaJB6dPF2Ffw7mvd1EPrsJXSkTgXI+be/C8J+nHHbHPPdiZvB2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6803
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>=20
> On Wed, Nov 02, 2022 at 10:10:14AM -0400, Frank Li wrote:
> > From: Frank Li <frank.li@nxp.com>
> >
> >   pci-epf-vntb.c:1128:33: sparse:     expected void [noderef] __iomem
> *base
> >   pci-epf-vntb.c:1128:33: sparse:     got struct epf_ntb_ctrl *reg
> >
> > Add __iomem type convert in vntb_epf_peer_spad_read() and
> > vntb_epf_peer_spad_write().
>=20
> I don't understand all the bits and pieces here, but I'm a little
> dubious about adding all these "(void __iomem *)"casts.  There are
> very few of them in drivers/pci/, and I doubt this driver is so unique
> that it needs them.

sparse compiler report warning without cast.  I write it at commit message.

Best regards
Frank Li=20

>=20
> > @@ -1121,7 +1121,7 @@ static u32 vntb_epf_spad_read(struct ntb_dev
> *ndev, int idx)
> >       struct epf_ntb *ntb =3D ntb_ndev(ndev);
> >       int off =3D ntb->reg->spad_offset, ct =3D ntb->reg->spad_count *
> sizeof(u32);
> >       u32 val;
> > -     void __iomem *base =3D ntb->reg;
> > +     void __iomem *base =3D (void __iomem *)ntb->reg;
> >
> >       val =3D readl(base + off + ct + idx * sizeof(u32));
> >       return val;
> > @@ -1132,7 +1132,7 @@ static int vntb_epf_spad_write(struct ntb_dev
> *ndev, int idx, u32 val)
> >       struct epf_ntb *ntb =3D ntb_ndev(ndev);
> >       struct epf_ntb_ctrl *ctrl =3D ntb->reg;
> >       int off =3D ctrl->spad_offset, ct =3D ctrl->spad_count * sizeof(u=
32);
> > -     void __iomem *base =3D ntb->reg;
> > +     void __iomem *base =3D (void __iomem *)ntb->reg;
> >
> >       writel(val, base + off + ct + idx * sizeof(u32));
>=20
> These things look gratuitously different to begin with:
>=20
>   int off =3D ntb->reg->spad_offset, ct =3D ntb->reg->spad_count * sizeof=
(u32);
>   int off =3D ctrl->spad_offset, ct =3D ctrl->spad_count * sizeof(u32);
>=20
> They're doing the same thing, and they should do it the same way.
>=20
> Since db_data[] and db_offset[] are never referenced except to be
> initialized to zero, I'm guessing the point of vntb_epf_spad_read()
> and vntb_epf_spad_write() is to read/write things in those arrays?
>=20
> You access other things in ntb->reg directly by dereferencing a
> pointer, e.g.,
>=20
>   ntb->reg->link_status |=3D LINK_STATUS_UP;
>   addr =3D ntb->reg->addr;
>   ctrl->command_status =3D COMMAND_STATUS_OK;
>=20
> Why don't you just compute the appropriate *index* and access the
> array directly instead of using readl() and writel()?
>=20
> Bjorn
