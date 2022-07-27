Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23362583341
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jul 2022 21:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbiG0TNz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jul 2022 15:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbiG0TNe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jul 2022 15:13:34 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322A1DB4;
        Wed, 27 Jul 2022 11:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlIam+IMKPfUP5u6F3lrEE1dv87ursLnriRp0WcEZWNihFIIJpPsFC2WOZpKhEgvNcvUSL9x91pr6f1OKQXcnQL3RO5zjU6Xy0ifEbvCMyhd+owRygoZgq0YMBcaA1IiC1f1MayoTNPSUCHnJ8Syy4W7CnYxtSt/rHlOGG2WrQYI//XeSa96pcNT9NW0UTB2DaaXU3oUPXNGTV/SCMVRFOtoM/G5lVn/apncwTw4vnn4S6Z2O9rYzf8UZ+hDHgftJtdPL/JHSnM7ka7+iSC8DOPAEr1mpyt635uhxwjZH0WZx6UTH8bn4xgKy5zj0iFQje4DZT5VZ6M7O2NKm0Od3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVnXxIDKCgSmEuEwLOHtUShWjhAtz9I3bfft6t0PjTE=;
 b=GKY0xvijXciV+wMHMfevh7u8+3X+5YoBZfpl0wkXP610cgHDP6GArCu0w2Hz8aL6h0fQ+BrZec5y2KLPtqzcPGwHgqBbEVdfHuIrHkyVD/X/mTV1TfpMelWfSHyiWmb0SwqAa9+Yb6GQLwmxV1xRttVn5lLT8IVPcyds5q1TtAr88JTf4P7yl9G0nPAkPy46PsKtuwGcMDTQ7QsTJxwpfSQzB1uSTKXc0K1tFvWJ+26n++Cefj82YumPVfxvihYZTizCEPvzdZKKt1oE/Ix5SaGsSSJwnugEC/gE98R7tbhXtE9nYmpCXyuhLKP1LqZ9FM6VtmD/ug3ygYOrVa9Cbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVnXxIDKCgSmEuEwLOHtUShWjhAtz9I3bfft6t0PjTE=;
 b=Z1k24I9Mv78lGhFaGht1i6ulKctEPCaot90Vhqx60x8Q7c42DEQHjPDveqs7s+8At9Chjuva3kekjBai9GuJ11RupbQAbTazdz2WNtcbJWGlWTzTybxKY7wclzElTFMEfacBES2jUJhUAH0QO98e9TUqU3YUgbsqXndqJbik3Wg=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM5PR0402MB2914.eurprd04.prod.outlook.com (2603:10a6:203:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Wed, 27 Jul
 2022 18:58:33 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::1c38:3e39:bb58:8fb5]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::1c38:3e39:bb58:8fb5%8]) with mapi id 15.20.5458.024; Wed, 27 Jul 2022
 18:58:33 +0000
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
        "kernel@vger.kernel.org" <kernel@vger.kernel.org>,
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
Thread-Index: AQHYnIAGRldFRqOr4kOZ1c4K3zYfO62IdfUAgAB4j7CAAAWJAIAIQw5AgACuYoCAAHgmoIAABhyAgAAvExCAAAjNkA==
Date:   Wed, 27 Jul 2022 18:58:33 +0000
Message-ID: <PAXPR04MB9186E4A88E884C81D10D4F2188979@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220720213036.1738628-1-Frank.Li@nxp.com>
        <20220720213036.1738628-3-Frank.Li@nxp.com>     <874jza525l.wl-maz@kernel.org>
        <PAXPR04MB9186A1D283ACE8BD6954039288919@PAXPR04MB9186.eurprd04.prod.outlook.com>
        <87wnc6xz6r.wl-maz@kernel.org>
        <PAXPR04MB918621013E6276D37B56C48488949@PAXPR04MB9186.eurprd04.prod.outlook.com>
        <877d3zx9su.wl-maz@kernel.org>
        <PAXPR04MB91861BF0BA341211C442B20988979@PAXPR04MB9186.eurprd04.prod.outlook.com>
 <871qu6y3g4.wl-maz@kernel.org>
 <PAXPR04MB918619B0E33DE2F3992FEDD288979@PAXPR04MB9186.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB918619B0E33DE2F3992FEDD288979@PAXPR04MB9186.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 726d47a8-e8ba-4e3b-647a-08da700200fe
x-ms-traffictypediagnostic: AM5PR0402MB2914:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2LEv2+IV0rlEY2ACsF2/HzTTL79T76qS6djdv2TBV/DpxkGqsKGx/JF24He6CZnVcJAO61BsB2UazotYyhud64xFTmCRuShq4GkGxRR1KCFkbNwCn8gCGNBI0zoDgqM3zrY5Hgkty8ADO6rdkJVr6gXy32yrI1MVQ6BaljDTD/guNRT1NJgP/nz8VGfIGxPF4jdhduTt33i+oHpkXJmJ7fHIRe08RcOk2AkwvGkYbdeK5hT8oD5d099EdPKl4iu5wdXcGom9HkhTQqDn8zw2/8l+GusKvQou9/gJn4ep0W2vNi2XZyaYSy8W2yRUjIxAoCyLCVHXoee4sB8qYlwGc5kfm16++ay4NpRvnUO2xFuZMPL9cWcmee9PX6y1JdlUJ3LlD/NHlVmoqqucTBGDiIN/73kztxcxgOhXzyBxajpL0Uc6hE/EPXYs3OmyfG605C+PMcIOzEaQ1B9u7IQh2D7nY2kes4R5R4qNy/sPdwJTVYh7EQ0avZxJzW+NQNgpd+aPREIeIvPDwGLxREVyKwjL28qnikublxVOMMhNxEUujYpFOr5n97/FUMrJlsHCap2ShPEGuEHmwS2eYMoE73GClH0DxaO5ENf6WXDHpBVB7n2Bw//iW2fc9dmBjC9PCQMaMY75A4xE+yCWgOQktUHHumt956rc73qhq+1+2NjROef6I4ImbYUFzU13dIQcxxn2Tn3n+XI1A2nlhBUL5isiH4Ae1G+TTnu0G5kn77abdEvXrj0NRBE5dmFnnvYxhxPlxFRXsJE1HEKc+WIQbHuiVHxNqTF1E68w69K42VyXzYjG2E4PRD/7hJyPbufK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(186003)(71200400001)(66476007)(8676002)(66556008)(76116006)(83380400001)(66946007)(2906002)(41300700001)(7696005)(55236004)(66446008)(64756008)(6916009)(6506007)(54906003)(53546011)(4326008)(26005)(2940100002)(86362001)(38070700005)(52536014)(33656002)(9686003)(122000001)(55016003)(5660300002)(478600001)(38100700002)(7416002)(44832011)(316002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tqxGUZzinISdJZSRDpq0nMw550QEIh6sDsdQhNR068BomiTfAWINfQCH9T63?=
 =?us-ascii?Q?Uo531NiUOM3rEr7qD9EQ6rEH7SueCa68TvN7Y7DEBkvApg9cn1ndbJCwOMrh?=
 =?us-ascii?Q?dgRld+xX1GvvMGNoYbgDVEDCouh2biLhFQl0ZjvwyOpq0V/Fo0qps7MJQKFt?=
 =?us-ascii?Q?HoyRtmAowgT8eXe8gpFK3wXmfoSmHCznq1Qcet3T9nls4EUKd0QJiv/9UFcZ?=
 =?us-ascii?Q?qt6bv9AwEVrL5BS1ukVnnb1AkiVZ+j6yhtb/u71uZoOM8NUDwRZIphZ/Sv/D?=
 =?us-ascii?Q?FHDJ9Iwqzsrp+P/1BHjWws1/eVJSjX5H5XpDVks/lSXGi7dr54ucBNvxpy37?=
 =?us-ascii?Q?xJMZNsvVMuqIwd8pn9vqEHYhKm3KFdbbNKpELPP5YHv9DI2WdpBeqMT5EP8j?=
 =?us-ascii?Q?EG+1GN383gLU5OM2Dsck3ftBZ/u7zfHJMaFKv8K7p0A/bK30/Es9P2ugBRfU?=
 =?us-ascii?Q?PwCE83eL+gG3zkZwZnCQhN+Hm46CEgjFUN3yVvR/eUStY2JXHlvQuJeaxRPB?=
 =?us-ascii?Q?EvxkLzK6TyD6P+sTarAlUJ0zbs0BSOCkJEiqwMxlndeJi6vCllL8GkdsnBbq?=
 =?us-ascii?Q?XrgzF3sAME8P04sxKmsvS8pvKrJHTIhEoMTYraLHFg5DPlCeLYHfFORePy9n?=
 =?us-ascii?Q?ZVuFQKNHYn8hwDMTy5BMmjAFHrYctvZ1Q2RFaMBwOhpuNSIHhiP06ABcI3Zh?=
 =?us-ascii?Q?7xnTjN1U091SGFgXqR81W5xXQZL9biOel5+9P/+hnxoz2Y4TDUuckIGQ11ZH?=
 =?us-ascii?Q?jkcYZXIMO7S1p7DwG0pHAYx+glb8scyBkz8dDElvLuOu88HwRPZnyc0lUabj?=
 =?us-ascii?Q?hHLbDOWu1OEdAg50FxUvQ/WidVnAdPCPZuGcgf+tdx7tQwiGjNB+20jo0v0u?=
 =?us-ascii?Q?tvQppvPqi8NvxBtA5xTuCr5/sYaeqwYvg1fQwpUXLetGookwrqBk3unyjwQY?=
 =?us-ascii?Q?5v5SjIubhDYvD6J3u1VuEWeJ+0R5OlZTIF7sFbin9EMUbFil5ubRDgBbODY1?=
 =?us-ascii?Q?NP+RvV2RUz5syqneSZKLQSIgIe70KnfGQ4kBCViweoKXR9Ubi26kk9SVJyQz?=
 =?us-ascii?Q?zaIJn1epC0t5cuaLYCyb4m1tKeR6vYqgEbJc/AB73BhWuR//MPzCqS3lGANX?=
 =?us-ascii?Q?lv0gXKTv6sctB3FG474umCqnUcbxKqzyIHLLabQXJqOUg+6dlK8fyO4pvIgZ?=
 =?us-ascii?Q?PAE35NAj3CaGNmGD8W37bbG0Sd06TfxlXB0ZH6HQ4VgURt3gioy+wzuoKJkk?=
 =?us-ascii?Q?oksjl//7s4/tsIfR9GIRPtgoWtDm3YdyYktyhJsa/sht+YiFX1iDzpMeDopk?=
 =?us-ascii?Q?1M+LM886qcIGHBop9RrLBd6JlfOxo+R41lDme3BsKCFd9wNme/09OqvSzQcw?=
 =?us-ascii?Q?pEQ2jjAl6h235MH6NtuTCWEFHCRDKd5DW4067txLSi9vd0LNVocW+numpPFV?=
 =?us-ascii?Q?ib76v2n57XztKBpmGgSQAe8d6LG7AI8H8gKSxw2RT20KGIAZOc8lFziWQUIr?=
 =?us-ascii?Q?7bVJ/ZZLgmgyZ9jWA7z8fujatylxyVEwfbGr7E0l4MqoW7hIFa0t4Z8sBtuN?=
 =?us-ascii?Q?63aLsuVey2EzhS6BobmQS3ZdxyV7UJ3lFuNGVei2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726d47a8-e8ba-4e3b-647a-08da700200fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 18:58:33.4638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 48xf9/ahiEDU2cI0VlAN5CzYVGlcGSCb9iy7n6Re+A4ULZwgPgG7eQqasrwp3y8XEQpfn3Mnkw9jSjss7MqxNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2914
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
> From: Frank Li
> Sent: Wednesday, July 27, 2022 1:30 PM
> To: Marc Zyngier <maz@kernel.org>
> Cc: jdmason@kudzu.us; tglx@linutronix.de; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kw@linux.com; bhelgaas@google.com;
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-pci@vger.kernel.org; Peng Fan
> <peng.fan@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-
> imx@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com;
> ntb@lists.linux.dev
> Subject: RE: [EXT] Re: [PATCH v3 2/4] irqchip: imx mu worked as msi
> controller
>=20
>=20
>=20
> > -----Original Message-----
> > From: Marc Zyngier <maz@kernel.org>
> > Sent: Wednesday, July 27, 2022 10:35 AM
> > To: Frank Li <frank.li@nxp.com>
> > Cc: jdmason@kudzu.us; tglx@linutronix.de; robh+dt@kernel.org;
> > krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kw@linux.com; bhelgaas@google.com;
> > kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-pci@vger.kernel.org; Peng Fan
> > <peng.fan@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> > kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-
> > imx@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com;
> > ntb@lists.linux.dev
> > Subject: Re: [EXT] Re: [PATCH v3 2/4] irqchip: imx mu worked as msi
> > controller
> >
> > Caution: EXT Email
> >
> > On Wed, 27 Jul 2022 16:23:26 +0100,
> > Frank Li <frank.li@nxp.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Marc Zyngier <maz@kernel.org>
> > > > Sent: Wednesday, July 27, 2022 3:03 AM
> > > > To: Frank Li <frank.li@nxp.com>
> > > > Cc: jdmason@kudzu.us; tglx@linutronix.de; robh+dt@kernel.org;
> > > > krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> > > > s.hauer@pengutronix.de; kw@linux.com; bhelgaas@google.com;
> > > > kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> > > > kernel@lists.infradead.org; linux-pci@vger.kernel.org; Peng Fan
> > > > <peng.fan@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> > > > kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-
> > > > imx@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com;
> > > > ntb@lists.linux.dev
> > > > Subject: Re: [EXT] Re: [PATCH v3 2/4] irqchip: imx mu worked as msi
> > > > controller
> > > >
> > > > Caution: EXT Email
> > > >
> > > > On Tue, 26 Jul 2022 22:48:32 +0100,
> > > > Frank Li <frank.li@nxp.com> wrote:
> > > > >
> > > > > > > > > +static void imx_mu_msi_irq_handler(struct irq_desc *desc=
)
> > > > > > > > > +{
> > > > > > > > > +     struct imx_mu_msi *msi_data =3D
> > > > irq_desc_get_handler_data(desc);
> > > > > > > > > +     u32 status;
> > > > > > > > > +     int i;
> > > > > > > > > +
> > > > > > > > > +     status =3D imx_mu_read(msi_data, msi_data->cfg-
> > > > > > >xSR[IMX_MU_RSR]);
> > > > > > > > > +
> > > > > > > > > +     chained_irq_enter(irq_desc_get_chip(desc), desc);
> > > > > > > > > +     for (i =3D 0; i < IMX_MU_CHANS; i++) {
> > > > > > > > > +             if (status & IMX_MU_xSR_RFn(msi_data->cfg->=
type, i))
> {
> > > > > > > > > +                     imx_mu_read(msi_data, msi_data->cfg=
->xRR + i *
> 4);
> > > > > > > > > +                     generic_handle_domain_irq(msi_data-=
>parent, i);
> > > > > > > >
> > > > > > > > Why the parent? You must start at the top of the hierarchy.
> > > > >
> > > > > [Frank Li] Do you means that should be msi_data->msi_domain
> instead
> > > > > of msi_data->parent?
> > > >
> > > > Indeed. you must *not* bypass the hierarchy, and the top level of t=
he
> > > > hierarchy has to implement whatever is required by the interrupt fl=
ow.
> > > >
> > >
> > > [Frank Li] I see, just want to confirm msi_data->msi_domain should
> > > be correct here?  It should be leaf of irq hierarchy tree.
> >
> > Yes.
> >
> > >
> > > > >
> > > > > > > >
> > > > > > > > > +             }
> > > > > > > > > +     }
> > > > > > > > > +     chained_irq_exit(irq_desc_get_chip(desc), desc);
> > > > > > > >
> > > > > > > > If your MSIs are a chained interrupt, why do you even provi=
de an
> > > > > > > > affinity setting callback?
> > > > > > >
> > > > > > > [Frank Li]  it will be crash if no affinity setting callback.
> > > > > >
> > > > > > Then you have to fix your driver.
> > > > >
> > > > > [Frank Li] After debug,  msi_domain_set_affinity() have not did n=
ull
> > check
> > > > for (parent->chip->irq_set_affinity).
> > > > > I think impact by using dummy set_affinity is minimized.
> > > > >
> > > > > int msi_domain_set_affinity(struct irq_data *irq_data,
> > > > >                           const struct cpumask *mask, bool force)
> > > > > {
> > > > >       struct irq_data *parent =3D irq_data->parent_data;
> > > > >       struct msi_msg msg[2] =3D { [1] =3D { }, };
> > > > >       int ret;
> > > > >
> > > > >       ret =3D parent->chip->irq_set_affinity(parent, mask, force)=
;
> > > > >       if (ret >=3D 0 && ret !=3D IRQ_SET_MASK_OK_DONE) {
> > > > >               BUG_ON(irq_chip_compose_msi_msg(irq_data, msg));
> > > > >               msi_check_level(irq_data->domain, msg);
> > > > >               irq_chip_write_msi_msg(irq_data, msg);
> > > > >       }
> > > > >
> > > > >       return ret;
> > > > > }
> > > >
> > > > No. Changing the affinity of an interrupt must not affect the affin=
ity
> > > > of another. Given that this is a chained handler, you *cannot* sati=
sfy
> > > > this requirement. So you can't change the affinity at all.
> > > >
> > >
> > > [Frank Li] I understand affinity can't be changed.
> > > But system use set affinity to write msi msg.
> > >
> > > The call stack as
> > > [   25.508229]  epf_ntb_write_msi_msg+0x78/0x90
> > > [   25.512512]  platform_msi_write_msg+0x2c/0x38
> > > [   25.516882]  msi_domain_set_affinity+0xb0/0xc0
> > > [   25.521330]  irq_do_set_affinity+0x174/0x220
> > > [   25.525604]  irq_setup_affinity+0xe0/0x188
> > > [   25.529713]  irq_startup+0x88/0x160
> > > [   25.533214]  __setup_irq+0x6c8/0x768
> > >
> > > I have not found good place to hook a function to write msi msg.
> >
> > It is called at MSI activation time (msi_domain_activate).
>=20
> Another issue:   platform_msi_write_msg() is static function at platform-=
msi.c.
> It access a local structure struct platform_msi_priv_data.
>=20
> If I use MSI_FLAG_USE_DEF_CHIP_OPS flags,  both msi_domain_set_affinity
> and msi_domain_set_affinity.
> will be set at chip. So it will NULL point error happen if I don't set af=
finity
> function.
>=20

[Frank Li] look like imx_mu_msi_irq_chip.irq_set_affinity =3D NULL; after c=
all
platform_msi_create_irq_domain() can resolve this problem.=20

But it looks hack method.  I think imx_mu_msi_irq_chip should keep unchange=
d
after call create platform_msi_create_irq_domain().=20

Do you have better solution or this way should be fine?=09

> >
> >         M.
> >
> > --
> > Without deviation from the norm, progress is not possible.
