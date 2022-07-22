Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E64057E42F
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 18:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbiGVQMt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 12:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGVQMs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 12:12:48 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694DF61714;
        Fri, 22 Jul 2022 09:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXo5d82sg5OCQ4QLc4YD4lzmeMfUZ1swJ2ULzdM3Nfx0B/QmhNJDQ/Lr5JgGNire1GLt8TtulXQQlkB39PGjvfyqkrhi6C/B3CQPvZKF4Kupdejv0DqVwiTYhwJvO9k2nYgbMkjXCZRjtEgjFxr3prUL68OVWZq1WL+hTPQg12NcPwt80xDudjemfuKS4d7w3JI03SF+wosnf2UYAqoE/B3paVvg1Aq2Ke244McrdfNBbUlt439nWEPON80pVuAECCuNhZxnvgnDq8CIOfq/UDX9KLV1rvynUWSfnM4/AoQn09VMQgs6h371edfO0ynM5jor/8JsN3E6Ka99QWo9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gz2PgsWuNYbE//zu9uY2y6GoiyAhUrWTIJbFBI2Uglg=;
 b=YGiY1OPo+tmD3btCcXUI43/VQopufxGkaMO/APGYrG6i/PrmWqyxH97T2mUB9/EbHDixVgbPOqm7I48EXXn+mA8FPs4Q4kEBt+NGrbYbGsE/Mw8qVYqsW+9ve/0UNsxoqol3U1/osfOaLtW0dd2f0QzsGH6Bh/+SsPPMMmU/Bred+gTvL5EettNXIJINsKnjZIH9IMRt23IxvdWe2ZXQVTbCoK31GddawjdWciK0nf6cvE2xYbkc3q2gqWnRRfVCP00Aamv82QN5gfc7EOE2Jq2mCPlcWUfEMlR2O/qaiA25T0kYEhUA15Gvm7IoaNIdSR7TDw83KdWy70SOQueWKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gz2PgsWuNYbE//zu9uY2y6GoiyAhUrWTIJbFBI2Uglg=;
 b=dpuPEln6ho3rHEWabJO0ff3lPxEzH6n/ThMtdOiUY8djBdACSbZKTUvwb8tgSoLrHXrvuYZ19hodluHVbpym51R+ch+QvjIyyWHf/eWLB7BK/1qIh6nUrtvzCszknCIsTrbjfuvTp80by9jmZ6x3qgMOSkgCs+qyuXfTrMVvogo=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by PA4PR04MB9294.eurprd04.prod.outlook.com (2603:10a6:102:2a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 16:12:44 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab%9]) with mapi id 15.20.5438.023; Fri, 22 Jul 2022
 16:12:44 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v3 2/4] irqchip: imx mu worked as msi controller
Thread-Topic: [EXT] Re: [PATCH v3 2/4] irqchip: imx mu worked as msi
 controller
Thread-Index: AQHYnIAGRldFRqOr4kOZ1c4K3zYfO62IdfUAgAB4j7CAARMagIAAhh1w
Date:   Fri, 22 Jul 2022 16:12:43 +0000
Message-ID: <PAXPR04MB9186346EE6EB9A13CCDBB91C88909@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220720213036.1738628-1-Frank.Li@nxp.com>
        <20220720213036.1738628-3-Frank.Li@nxp.com>     <874jza525l.wl-maz@kernel.org>
        <PAXPR04MB9186A1D283ACE8BD6954039288919@PAXPR04MB9186.eurprd04.prod.outlook.com>
 <87tu79y536.wl-maz@kernel.org>
In-Reply-To: <87tu79y536.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74e5d83a-a400-46a7-5769-08da6bfd027f
x-ms-traffictypediagnostic: PA4PR04MB9294:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1zTsBSHBpyaX19cU45t5NPUepJRqgbDeBSPn5bxIX0XUlT0n6NBYQkMTY8GGijG6Pp0f4zY0UczEo9MDe9yJNovNBno8kpIUl4WavbaH1BP6NukQpuahvWCJiHTKclyG6XtOni0+fAOdfgK9v4pVobng8ASKVS+tfKFssGlNSgTrDNRlTPzfjRwagpFtYM7WX5CiKgr1+vLVABx2e/8570ANEJE4HrkpTn9PzObYGqT5y1lUzSnFnkHy3Q0CDSFaCBoIGgCg8RtEwz9rkM1G2nx4lS2KEi2aXZhixPM1ZwUBZ4SFtA9INs/b7YC/5qEJXA+yaQktEBLaG1gLV1+/7/2U0w/viN9byApWSnaeYbjRombMMDajIgnPlGdtw5wvo+o1fOCd1KOL5/090ktYAvwey0FbbmBS0CZTD5zRPmgTgMCU8nx4mqEti0AjT21xUROOsUo0vOQBOQbdjJktEEhZUl3rM+ljC7qkZZTps5QyVhLHN4OA7LcxZfjJYUtfYPAsOjqEXwFE4wBWVcFhdnmGSPRuL/WfViKbY/s56/R6n37/yrbGiMNwaahJThh9wWWO29k+MpEQsuyHwDGSGH9ujXDGH9Bmno+cSxjd6QiafkfE+DC0Gxxm8EKzjB50cYXT/OAgW1w5YrM4iOxjG3om8FynMUeoZV95A4xY7i/BCLenT15AWUElC5rE5XdxbfTOWvSH+ETfvFRP4pKouPGSWCE7ou5+TXQwd8vmmpRmxXGm7g73pJOH86WipgsJ8WwpXk6SHO+l2/4fOKAW5MrDfkGy8IqK6vHAE1mPxYCjwUBj8cLNKPiVEMJXOJF2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(186003)(8676002)(33656002)(66556008)(4326008)(86362001)(83380400001)(64756008)(76116006)(122000001)(66446008)(38100700002)(38070700005)(66476007)(66946007)(44832011)(2906002)(316002)(7416002)(71200400001)(8936002)(6506007)(55236004)(54906003)(55016003)(5660300002)(7696005)(6916009)(26005)(9686003)(52536014)(478600001)(53546011)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jEeUK2Bb68+hXkY5Y3o46PmuPMx3OHCxtcLp1eP1sAEf3a4MEQ80fYWAlusC?=
 =?us-ascii?Q?SqHlM5p0KkqFBXRV5Swjv6xVjJp/6wJj8J3+qg/y2ZMbHkRTHp/r+RFcrDEC?=
 =?us-ascii?Q?Is8lB7CNrnWhbTIfsK8qZ69z6SvwaCX4IUrAeQeYc0gK78CvgmETHX4LUSag?=
 =?us-ascii?Q?Z4kGOIg4ABdOUoQfldOU9jxgvsP9cIRMcwE8lSgWmip+6tdfk6pvZq6bB4QK?=
 =?us-ascii?Q?DXWoHLPwo/GfGFiuCzQ9s0SOY76zyjrMH6hzbHC/b8IM73Xg+MsPXNFf3hGC?=
 =?us-ascii?Q?KeG4T8w4EDnJezQO6CYRO0W2ZQypszWHe6glZQt505tx4ChpGRgFlBRUqpsS?=
 =?us-ascii?Q?76b6UQkegVgeKsjkr7OjMPv6rU/2/SQ0crDTU5cOkxBtLeIujIItjB7Ygwgd?=
 =?us-ascii?Q?+tEEs0IuZgGCd3cQ7YjmOvuNwL1V3WKsCja5fd/n5xGk1K9EWqIoqQa+rHxz?=
 =?us-ascii?Q?gGxtuTZgli7033EB8DyDaJHMPw6C4PlAEwsg1LkEdsyLETe8IWSsAT0qju4I?=
 =?us-ascii?Q?NkpZ3Ry9zPDMQCjbVCul2zRlanQSxX8227vyLCJG1Niobr2v4hDH0ZAOYU2T?=
 =?us-ascii?Q?aSa4mWrWxjH7ilV31j/FAoQh05chiZjlH0nhwumfbCa9e9Ufba1QTojRR9zd?=
 =?us-ascii?Q?nVeCmyo6X72tgqEMBXmV111Rbcyl9YxJjQ1yjWB/MSTj+zjnSnmFfgiSZhGf?=
 =?us-ascii?Q?UZBf3HVYag9/vJZ0tSiSkbk6GMrfanbqvkvBVQj49BdojZoeydhPR+jMgqeM?=
 =?us-ascii?Q?n3/0SLaUOIOHJ+5NTnCY87Ra+sQT/aYixlcaFmWWLEBLJ+NyC0P2SqRGypD7?=
 =?us-ascii?Q?ExKn/zeUZWmnaAaDqHA/fvfKFPwK9jeQC09kEDS4lUcwyHSXRTX5o5ZQj5A3?=
 =?us-ascii?Q?uLXtRolgKZvAMZrHEKhxbLj4K4qsOESwKJuWiPCHxERaP9QBN9uR8bopsn8G?=
 =?us-ascii?Q?jW+BM+EQAHaaEej6AuU4TUsgtPLoLS++GX953n/BObzk9s8mUlCF2M1WPvCE?=
 =?us-ascii?Q?uKgH47JeACRInsS47sbN3/jhjBeKh0/WZJP2WdZm2j7nDg7+ks5sJcXRH3Dp?=
 =?us-ascii?Q?m44j44OFSDlMkZoZHfWtIl6c8ZUvQYXwgXPF7anYXC9srpTqzXPvGH0xfNXS?=
 =?us-ascii?Q?DxIebvLQLw11ZLHeZ91TSPe3nNW6FB0S9HEslS4AzrBuhCO92T5GJ/KguMe1?=
 =?us-ascii?Q?FVWAsFiTK9EwoW7a9b8nxVKBS5/PQmM95daRDnOWJDyQP2F5JM14159xXUO5?=
 =?us-ascii?Q?7FItIdSPO0ORaL5S49B4oqDTmzh6vstb14Y0c+pqmvit8EJUvuc4T1X5iG36?=
 =?us-ascii?Q?gtgxYhQUAOBIwNq2lwzM1HMqAa91gh0lO5bbHmcmQ0UI5KCrzhu5K7JNZP77?=
 =?us-ascii?Q?ejc4wpuxse/yeaFNYDi4o/mMEDj7GRUyjiq9hJ/VYhgrFsou6ihWWFfYWWwO?=
 =?us-ascii?Q?gb4gtTJS6S6UVqFbE+5H8YYmQtz+2JpwOAxVYRZVpdrex7saWeh2N3G5gK1r?=
 =?us-ascii?Q?kJnX51BWx19ZSaxs4F2MD1DRy7FqJ9nzFue9P7xcnZ13NJJJpDxn6T4p74FP?=
 =?us-ascii?Q?b4yaE2W2jEMoxKdECpU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e5d83a-a400-46a7-5769-08da6bfd027f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 16:12:43.8674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0YQFPhKyvcbIHp+d+4szyA8kFthmuXi4KF+XxExTctUDNhJ/j/YfPbaqZxefkOh29m+Sm+Q5B1ngAJcHygB8Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9294
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: Friday, July 22, 2022 2:33 AM
> To: Frank Li <frank.li@nxp.com>
> Cc: jdmason@kudzu.us; tglx@linutronix.de; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kw@linux.com; bhelgaas@google.com;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> pci@vger.kernel.org; Peng Fan <peng.fan@nxp.com>; Aisheng Dong
> <aisheng.dong@nxp.com>; kernel@pengutronix.de; festevam@gmail.com;
> dl-linux-imx <linux-imx@nxp.com>; kishon@ti.com;
> lorenzo.pieralisi@arm.com; ntb@lists.linux.dev
> Subject: Re: [EXT] Re: [PATCH v3 2/4] irqchip: imx mu worked as msi
> controller
>=20
> Caution: EXT Email
>=20
> On Thu, 21 Jul 2022 16:22:08 +0100,
> Frank Li <frank.li@nxp.com> wrote:
> >
> > > > +     pos =3D find_first_zero_bit(&msi_data->used, IMX_MU_CHANS);
> > > > +     if (pos < IMX_MU_CHANS)
> > > > +             __set_bit(pos, &msi_data->used);
> > > > +     else
> > > > +             err =3D -ENOSPC;
> > > > +     spin_unlock(&msi_data->lock);
> > > > +
> > > > +     if (err)
> > > > +             return err;
> > > > +
> > > > +     err =3D iommu_dma_prepare_msi(info->desc, msi_data->msiir_add=
r
> +
> > > pos * 4);
> > >
> > > Does this HW even have an IOMMU?
> >
> > [Frank Li] we have a platform with iommu.
>=20
> I really wonder whether you are taking me for a ride, or whether you
> are completely misunderstanding what this IOMMU business is about.
>=20
> This is a *CPU* writing to the device to generate an MSI. CPU
> transactions cannot be translated by an IOMMU as they are not
> (surprise!) IO devices. They are in control of their own translation,
> contrary to devices that generate MSIs.

[Frank Li] I think that It is not *CPU* writing to the device to generate a=
n MSI.=20
It is another bus master to write to generate IRQ.  According to my underst=
and,=20
Bus master (such as PCI EP devices) write to an address to trigger irq, OR
DMA setup DMA write descriptor at last one.  Any address should be translat=
e by
IOMMU if it is enabled.  If not,  this is empty function call. =20

>=20
> So what sort of translation do you expect this to setup? What StreamID
> is getting used by the DMA framework? There is no answer to these
> questions because they don't make any sense. None of it makes any
> sense.
>=20
> At best, you are simply copy-pasting things from various drivers
> without understanding what they are all about.
=20
[Frank Li] it is first time to write irq chip driver, so I have to base on =
or reference
Other drivers to start development.  Of course, there are some miss underst=
and
During development.  From functional call name, it make sense although I do=
n't know
All detail behind that. =20

Any bus master access memory need go through IOMMU if enabled. =20

I have not tested it at IOMMU enabled platform yet.  Some maintainer requir=
e
Added similar function call if a feature enabled when I do other upstream w=
ork. =20
So I kept as refer driver did. Maybe refer driver code is too old. =20

If there are problem, I can delete it.  So far, it don't impact my test pla=
tform.=20
I can add fix patch if met problem at IOMMU enabled platform.

> I suggest you stop
> doing that and make use of your time working out the problem rather
> than wasting the reviewers'.

Thank you for your review and great comments.  This driver function worked.=
=20
I know I made some stupid problem, it should be fixed before sent out.

I also want to make sure the overall idea worked firstly.  So far no-one
Use MSI as doorbell from PCIe-EP function drivers yet. =20

>=20
>         M.
>=20
> --
> Without deviation from the norm, progress is not possible.
