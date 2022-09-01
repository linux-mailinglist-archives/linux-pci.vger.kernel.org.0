Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34845A9AA8
	for <lists+linux-pci@lfdr.de>; Thu,  1 Sep 2022 16:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbiIAOjx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Sep 2022 10:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbiIAOjt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2022 10:39:49 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150080.outbound.protection.outlook.com [40.107.15.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C00ED84;
        Thu,  1 Sep 2022 07:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OP4GgsFhHiHHugMerZC5ciIYKgEGIIbb6fqHAoTSDyQJb8KjGSO2+6oe5FZz2upx1Zg4GZW0eKlZgppGtsv0fLVw7gWTbJwiEgKe9PAjwjIpPoCTfWS1psTW2eh8RkZAlgz46sii9rVIpCuglo+351rlI1QgpWLuzRcEAfHI/w06D6FngQY9H+9cmr+ATL/Gk3oRbM4xgnC6QZXd1sve9GxhO+SvUzBbYLXtfm6OPmxfXm3pEYsOkO7lOcAgYoAAB6qr7gNzYk//0AnEepOnI086kvOxde9mvk1tuSv9aJDjuLBMr4c9lHsmiPt/8O4XsmpYP+e94nSuZ989AaSVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCOoG7eglnuBplExhdJGpizQADODEGHd7XmYe93Uvy0=;
 b=CL50eGB9cgpxeJmIdpFoTAMOZOGhFoydHLazB1SxFCzoqcO5twFTSLMkoMxYXOeT30SO15uLCY4T6TogK0euVQQO7FIw/2YguPdCz5vv9ZCYHNhbzw7wimANeK0PrEtYVb68Z5lXm0jhMZ8ba3W9ehVske7anUs9qFxyxVUUGK//yHeLlHScJsyst3dICKjG133Re2hvjt0ay6dvbRcyYGdZJUaIJyg1KKKb3No3sl/+TQ0Nmq76lN8u7qFUb9X+Tfdr7IDgixT5EOQW2cAv2cTXmDjL1xzlLJ1eiGfpNxdNis8ZhTBKzM2XQ1n90uRB1iEUvsCbXxt3phFB7EBfiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCOoG7eglnuBplExhdJGpizQADODEGHd7XmYe93Uvy0=;
 b=Zof8oYIQLmoD3Jg61EaRF/GYscZ8k7e11JHN4WBSzgizz0E8WdME3Etk9RsFRBB/hCRT2PZMIk+ZNiyb4VlE/VYYNRCRcGrPNKeCBYb6lm+yh9uOo7qjd9Wm/CZpB+/2BzUSX5Izfxgp9+xK5skWDEbAalUv992G8nMhY/ee7Vg=
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by DBBPR04MB7834.eurprd04.prod.outlook.com (2603:10a6:10:1ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 1 Sep
 2022 14:39:44 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb%8]) with mapi id 15.20.5588.014; Thu, 1 Sep 2022
 14:39:44 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Frank Li <frank.li@nxp.com>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        "lznuaa@gmail.com" <lznuaa@gmail.com>
Subject: RE: [EXT] Re: [PATCH v7 3/4] dt-bindings: irqchip: imx mu work as msi
 controller
Thread-Topic: [EXT] Re: [PATCH v7 3/4] dt-bindings: irqchip: imx mu work as
 msi controller
Thread-Index: AQHYtj8hCDDK+8gqVE2zOgMsKNOQwK3AJMoAgAAECGCAAV/WAIAAANrAgAA0JACABEI8MIAEtGHw
Date:   Thu, 1 Sep 2022 14:39:44 +0000
Message-ID: <AM9PR04MB87931AC89983976AE1CBBDA4887B9@AM9PR04MB8793.eurprd04.prod.outlook.com>
References: <20220822155130.2491006-1-Frank.Li@nxp.com>
        <20220822155130.2491006-4-Frank.Li@nxp.com>
        <20220825212130.GA1705214-robh@kernel.org>
        <PAXPR04MB9186201A03037BA7DC74D52B88729@PAXPR04MB9186.eurprd04.prod.outlook.com>
        <871qt2x38f.wl-maz@kernel.org>
        <PAXPR04MB918607281F6389092924EE6488759@PAXPR04MB9186.eurprd04.prod.outlook.com>
 <87zgfqvfvv.wl-maz@kernel.org>
 <PAXPR04MB918622BAC0F686AB51BC505788769@PAXPR04MB9186.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB918622BAC0F686AB51BC505788769@PAXPR04MB9186.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: robh@kernel.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f59bfbe9-a1d9-44e4-4ae5-08da8c27cfae
x-ms-traffictypediagnostic: DBBPR04MB7834:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c2GfmxXuZgz1BMUNGMgkwDuwh0q0yqiJ3Jenew7Lu2L1Tyj8eEDSEOaIY5Cxq6vnmJGwFsBE9UjWwEv0DVUivlmpL9ory8Dv83mNN6eS80A2jToygL6S2xTHdYOALluKuPvkGX2+xTfojpSpHG6lm+q23Y2vMAcaI3i5yvE8C9dksAt6ofBdve1y5hrrsCK1USy/lwzqICyFwNRaOTY/xflCOlZORUs8iObwfxlwBRLRyfKXa7E0eHuHfBKGHDZ3Ua7oz+YaqxKoPN01mEOjpKkuAwSIvjvRav7P0NUAM41oDA4yX4D64H6BEe0Csbzx//i5VCSYHg3SwJJJ+aeGdqOdqspv1kEVbd40q2jCTrMLZbImXWL3L+x1QB+GcYYLLIsbu/YyjyZHZ0gTzqeXC5dJXcxpeqIWGZAcEg/kw89i5VWmaAz2en8Ijw4UoERM6WYeDkKOf5X8Ovq5n7Tv2xc1CYVS4sfRpzYhQhh0NNyoatLaNxWfKQDjVHYzUxUDxqJsepksRHwwzqeOTFbNmQG/9NLTPqEIapkay1db4b8hOC42dWmMHPtPRE6jo2TvYD7UtRasePyQlWtmt+Giyr/LJgAqpIkAQ6kW/m/uzhMZ2UM27K7s3oAydNvf9rYl2/ULDW1h7lNI6HIDbLGyTrKQg3rHQMBDxQ5vZKdGWfKbF8Kn4IHk4DOn8iLQyMLkKy3HIJEkCZRNj5+hNjibNzuNUVBWUTMCom6UsyvN1d56Z8q82MtefUUdmR40HIyPzoeSJp0Wag8B6jinfGW+Cg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(38070700005)(41300700001)(8936002)(52536014)(71200400001)(54906003)(86362001)(33656002)(110136005)(316002)(66446008)(478600001)(66476007)(66556008)(8676002)(4326008)(64756008)(66946007)(76116006)(9686003)(186003)(26005)(7696005)(53546011)(55236004)(7416002)(83380400001)(2906002)(6506007)(122000001)(5660300002)(38100700002)(55016003)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U3oagh10TduSHgcshpHb07edlljYqHBK/9lWl+Zj0zKBhqkR/TO7Nzo/2mm/?=
 =?us-ascii?Q?+M5IFXzo4FKOA47WdXU7muGaNNeiAU+loNTXSug//bZxKK9So5TlDuTlKDQZ?=
 =?us-ascii?Q?AIEnQp7wtUrGrb7QGuqfzCARhAsQYrARLz0p+jod9xj6wN/C4B1Yd+kOnRHh?=
 =?us-ascii?Q?B7wl1R9NL+JqqNVolHWr3ofpgx54cQcVkXQPDGaAO26gGfayD4zOZVin/8nd?=
 =?us-ascii?Q?7hD0FGuMtg7i2q3E7FlLKQG8MfaPHJNITd7Njm3LrpEvcp0y6w1Y3+730qXy?=
 =?us-ascii?Q?QJd6IlXh4SnDAsH8+ufTBb5eNJyhJAI/OHLZ0M3XLrfmSzotDcSVdqDeOgi2?=
 =?us-ascii?Q?3dxPFxI9q4E95SZVGy+0HzcnQO8aeE7zM4rhtMjbfPwOW8dXopKeSz3UZ5ot?=
 =?us-ascii?Q?iOinOlbkaQz3Ui5XdJe/Y3I5PtS0ZjFxEeLpxdy3ZssCswzYqLCFU7Cw+Hlh?=
 =?us-ascii?Q?NGxayc07V7rNBFIblDWU3siwQ8ml3LNqnmQNJ1/VqXwbVWFoVPL4Jjacbj0G?=
 =?us-ascii?Q?l33xnXwdx2IZd9865NS2ki+E/pWIDyhMtRKJ4Jtx3ORhHSRKpTbvfBdscA3F?=
 =?us-ascii?Q?f5Syp6bDk6Ve848hxbBloYG18cb8F7GcuGXtnXnf+6SzJZX/CWJLqj4UdEow?=
 =?us-ascii?Q?boSuh3O2Q4n8bfuw2AtVnOhiysOP1SuSgA675sT+rFRG6mxRb/4U4uOIVhvI?=
 =?us-ascii?Q?5lKsTcIwVTzHupz6M5ZZRYHuXLzqXWygcYE7ZRSs4coF3vXvjYtJ0e8cTrMj?=
 =?us-ascii?Q?OVMB7LoWfS0PV7AcVEQQUoDHuVwh9xX2xZWsxYdXTF+INyZZDgtxvPWLpuer?=
 =?us-ascii?Q?vxZHpjFJ5jdkBkQKXYPPBVQu9lnWpWZ9LKEUlanmlfCwwn1GHTEI8DFVCPZ7?=
 =?us-ascii?Q?NpP6PARtnClrHtMTbmiTZHHPmrDkn9fXLmcRAOIWcteL4DY2wtRFK/PKy0GV?=
 =?us-ascii?Q?SoBbwInDHCsoReDQ9MX9CV4xVb/zeIvRpbkSRPC10VwP8LcwHipjzBRgfK7W?=
 =?us-ascii?Q?GHF6Wyg4vuRQJrXTT8+ne7D4IGXew+FoOHiLgUFHMKDr6HhJL0LoszDakG80?=
 =?us-ascii?Q?WpVRPOo+tdpkHbRpWMpswKj9oRMeyxQ7Gp61hTZupm62f4+bWcXTXJ1nNlEW?=
 =?us-ascii?Q?N2Dhs3xvgDb9kFJ6cDdg2Tqemd7s1u1oOZrZk55zBX02IPgCF7nVOGx9BRb5?=
 =?us-ascii?Q?9pvKRmSim5e7MDRt09kY1c4gi+jtYYpWXdZSjf8SKFbZd+tuqg9Tm2z7vQxP?=
 =?us-ascii?Q?MrWmf+XgLsaantm4Co5Ho9nJMl7zqb4OEUXRBliJ+bpcZQ897t8L9CY7i0+O?=
 =?us-ascii?Q?ouzg08M+Go8/8M5n4jc4VnTBsBpMjmGZSGd+U8fqmidozMyiolpUpbgbAniq?=
 =?us-ascii?Q?q8SIKplrKf5qJs8kN3frqiyOj1s0weps/2vP1BcYmWNi+sSkvI+v+xPOmfys?=
 =?us-ascii?Q?79+6V/6USiZiIwu3YVr4ClCXCI2BWIE/p46OzgJO2ZznkyYKKF067Yt1VaXQ?=
 =?us-ascii?Q?DoKAo0eHSMxAXrAf4HG+6d8lRwV7TlpoHm4+Fxn7OHSkYTFLanogM/ZKPrg0?=
 =?us-ascii?Q?BgjlHyuqy4Sdk1j1N0g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f59bfbe9-a1d9-44e4-4ae5-08da8c27cfae
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 14:39:44.1640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/WgZzUmgok2bk2OQzs3Ua811cYYXuY7g63BB3owjwu8zxqwyNWG3SrJgzvHwMcSWNCyHazKgm3FEjFP2naCBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7834
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Monday, August 29, 2022 9:48 AM
> To: Marc Zyngier <maz@kernel.org>; Rob Herring <robh@kernel.org>
> Cc: tglx@linutronix.de; krzysztof.kozlowski+dt@linaro.org;
> shawnguo@kernel.org; s.hauer@pengutronix.de; kw@linux.com;
> bhelgaas@google.com; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> pci@vger.kernel.org; Peng Fan <peng.fan@nxp.com>; Aisheng Dong
> <aisheng.dong@nxp.com>; jdmason@kudzu.us; kernel@pengutronix.de;
> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>; kishon@ti.com;
> lorenzo.pieralisi@arm.com; ntb@lists.linux.dev; lznuaa@gmail.com
> Subject: RE: [EXT] Re: [PATCH v7 3/4] dt-bindings: irqchip: imx mu work a=
s
> msi controller
>=20
> Caution: EXT Email
>=20
> > -----Original Message-----
> > From: Marc Zyngier <maz@kernel.org>
> > Sent: Friday, August 26, 2022 4:45 PM
> > To: Frank Li <frank.li@nxp.com>
> > Cc: Rob Herring <robh@kernel.org>; tglx@linutronix.de;
> > krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kw@linux.com; bhelgaas@google.com; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-pci@vger.kernel.org; Peng Fan
> > <peng.fan@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> > jdmason@kudzu.us; kernel@pengutronix.de; festevam@gmail.com; dl-
> linux-
> > imx <linux-imx@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com;
> > ntb@lists.linux.dev; lznuaa@gmail.com
> > Subject: Re: [EXT] Re: [PATCH v7 3/4] dt-bindings: irqchip: imx mu work=
 as
> > msi controller
> >
> > Caution: EXT Email
> >
> > On Fri, 26 Aug 2022 19:59:44 +0100,
> > Frank Li <frank.li@nxp.com> wrote:
> > >
> > > > And I stand by my initial request. "a" doesn't convey any sort of
> > > > useful information. Why not "I" and "II", while we're at it? Or
> > > > something even funkier?
> > >
> > > MU spec use term "a" and "b",  user have to map "I" an "II" to
> > > "a" and "b" when read MU spec and code. it is not straightforward.
> > >
> > > I quote a part of spec.
> > > " The MU is connected as a peripheral under the Peripheral bus on bot=
h
> > sides-on
> > > the Processor A-side, the Processor A Peripheral Bus, and on the
> Processor
> > B side,
> > > the Processor B Peripheral Bus."
> > >
> > > Rob Herring and Marc Zynginer:
> > > I can change to any name, which you agree both.
> > >
> > > Some options:
> > > 1. "a", "b"
> > > 2. "a-side", "b-side"
> > > 3. "a-facing", "b-facing"
> > > 4. "I", "II"
> >
> > Use the wording indicated in the spec: "processor-a-side", and
> > "processor-b-side". This is what I asked the first place.
>=20
> @Rob Herring:  Do you agree this name?

@Rob Herring:  How about "process-a-side"?=20
If you agree,  I will resin these patches soon.

Best regards
Frank Li

>=20
> [Frank Li]
>=20
> >
> >         M.
> >
> > --
> > Without deviation from the norm, progress is not possible.
