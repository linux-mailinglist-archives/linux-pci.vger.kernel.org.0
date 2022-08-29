Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286F55A4F8E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Aug 2022 16:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiH2OsC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 10:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiH2OsB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 10:48:01 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70080.outbound.protection.outlook.com [40.107.7.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267BA8D3D8;
        Mon, 29 Aug 2022 07:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZgnvf+af7+I6boHC044C8EN6zpYBPPC1MrK8K5cKxgVAbZY1/j/f0CEOnuMQed1N1Cy/mOjO/NfFFawJKwNZPxY2N2orC1o5kWq275QuQ0Zph97vQ5nlY6wBK/OGPsMJ0c8kSN+ia3eT36pPyypU01ODYcyAIqQJ0+zMQoNlByJUVF86I2SeMHq6l6t7NPBtbmyUuw+WHWU71nwJNDsE0YuI3lEciLuncIlxSYLeh2iz/TSJSR/DvSm0Prr7jqa3i2nIH5731dvdDpAF5ApQfQZa28Gp6ECJq9WWWPdu3fdPt93FIXBpl8ALzD8v9/Jmul9S2MuFYP3pVqVS6PCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nyv0iOmtvxzF1/mBX4FVqqJ6/4IMq+ncaeuUwuEFliA=;
 b=IqrLrflRiR0h2IM7vv8AXHIQyCsw68wkf0HpQNOIEZ0KM7hu+fMguaV3LVtNlCUrdsT8qdVSpzBqpWe6CJIw5NVsmYksTrcTkF8qlbzB9PzAlvfatIu2GcpHPUkYCBtu9QuEkGHcL+9BswT82K7ayogJcwdlXks/E3v9zj9D188TMrHb/td89xLnpmYroWS0fjkCLEnH7NDpDBWITYS/dySmQcyUnqhChm96R7Xyb/cQz06YbdH9TQfIQURrU0vq5ysCnt0FLWi3/GrNO/ba+33YwH2CDpCJHTLb7tv8EbHOY8dgzpE1faFtin8JfLV9vSBaR2SFpxaGB1zyLjdp7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nyv0iOmtvxzF1/mBX4FVqqJ6/4IMq+ncaeuUwuEFliA=;
 b=sadbN0/eVJP/PpOsK3QCzjsg07EA8OEVbwkJ/3QGVquwK2a9QAbyzdBfv0O2mZX41xHF+h4rwE5JoG1v6JJVOWk8ER2TBaPxSVAZ16Z4dELKBeLJvksri8uc0fHWJlvlGUecQoT4cyQDBNvDnrxgIUvz98Hxxi6MHjK6lqFVEag=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DB8PR04MB6923.eurprd04.prod.outlook.com (2603:10a6:10:114::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 14:47:55 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::85cb:614b:9f52:2dba]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::85cb:614b:9f52:2dba%5]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 14:47:55 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>
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
Thread-Index: AQHYtj8hCDDK+8gqVE2zOgMsKNOQwK3AJMoAgAAECGCAAV/WAIAAANrAgAA0JACABEI8MA==
Date:   Mon, 29 Aug 2022 14:47:55 +0000
Message-ID: <PAXPR04MB918622BAC0F686AB51BC505788769@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220822155130.2491006-1-Frank.Li@nxp.com>
        <20220822155130.2491006-4-Frank.Li@nxp.com>
        <20220825212130.GA1705214-robh@kernel.org>
        <PAXPR04MB9186201A03037BA7DC74D52B88729@PAXPR04MB9186.eurprd04.prod.outlook.com>
        <871qt2x38f.wl-maz@kernel.org>
        <PAXPR04MB918607281F6389092924EE6488759@PAXPR04MB9186.eurprd04.prod.outlook.com>
 <87zgfqvfvv.wl-maz@kernel.org>
In-Reply-To: <87zgfqvfvv.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: robh@kernel.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1f95039-61e6-4d7b-8948-08da89cd7579
x-ms-traffictypediagnostic: DB8PR04MB6923:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4gUDz/69oFVdp/VGsd6VervIrpw5zeHegtEgINH07E1hbI/VxczEd2xE3/iuF7vn3SIwy08atKYL9FES9shzzwo/YgVlmQ59XCqId9rSFmmPRSO93OBwUgE2MDkko83spOz9GF9xJzAfJYAKgriujXNS2mz2vsGr+Qf2rKhp1ayPWRM/2R7kgByGgbuTv2Z1F66iErStJ8q5RftZ8ADwWttpuhfBpoI0MRxWlat4peG8ifCuF+lvgY8E96jt7Wtefg0bZyfPj6DtCSpo0Hz1KxiLAT7YP3QgQ/UeuAYiZK8MV1so7jPudAwQkGbjW+B/I4jzpCvritL7Lk7mBchsRc+4ekNztKml9GieGQoeSxAdb3RhW0hU/oAvhKaoehBaKbp8zl2sS8qqc4pfnYJMchg+arkyymy+Og4j7RyPwsxdIRPXTIa7enq9ZO9dTw4XCi9yX3rF263BYGnGpTCXyoXqVwz7veDsQE7UaQGRVecv3BOwqIz81LKNb7qD51AUVs14LtBUttitVDLYETrjzpp9828831iTz0KXcUZMLbdzOC2t59hl7X6BtjtVK1ScfG5bkC6lPEQLF+QxmyE7phqtfgTCrmQOqNIyFJBijKjlR2w6m/kPZQLMR7mbG202ZUYi/M9v4XE7mXHO0B7QHjhKfwv6q07A93BmvI5h933r3eWdmr2o1SowyBJa7jpjew95rI8P1oRLsHwaBfgk05CenxRKH+xW81+zxLUBhGwXRbg4zQDHyZs7zwrc76Zxn6FFErwNwbHpuX7ogxsiPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(7416002)(26005)(41300700001)(478600001)(55236004)(6506007)(7696005)(53546011)(9686003)(71200400001)(83380400001)(186003)(66476007)(8936002)(44832011)(52536014)(5660300002)(2906002)(110136005)(55016003)(316002)(54906003)(4326008)(64756008)(66446008)(66556008)(8676002)(66946007)(76116006)(38070700005)(86362001)(122000001)(33656002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WtROjKW58Bd06oeceaCugIx+uOIvXLVhZDwjaU5hRuVOC58kbGQrb9rsW4LH?=
 =?us-ascii?Q?c+UlUEcq9Y04TG0rJG+52GsO13aiXi8D7b9fBRFgbPqIOMLw3dhnmXbQsUJf?=
 =?us-ascii?Q?ytlZ1JaHZarKJOLp/e5IdzvBd8btAHOZ+aHOBauf+WPStQ6uK4/8FRTiBB17?=
 =?us-ascii?Q?fWT0QDVtOZB2CrdikSSTe9A4N8uRdAshr7K9M2QsM3dId1bmeoy8aJTJvtGZ?=
 =?us-ascii?Q?TZQl+CYW1fPHtE8NQxQYnGzFUpBSDetIbPc1sItQQ7YR6X1qKHYdg4EStY29?=
 =?us-ascii?Q?YuoZ6tEDmyESe6I7Qb8L8bAnoDQ7PtwpUdL0gMO9IHDDiXbLi7xkg1Irefnz?=
 =?us-ascii?Q?Dag+jEfA48TicMPRmFTDe6AidXy2FghQK/XdCliwNyIUw/H+94pVo5JUP5UV?=
 =?us-ascii?Q?Ho2bQ0xQNgI0ZH0DvIPtQyPgFwpg6gt5Cra4R5V1cfNH4ytnxxk4OFk/kU/2?=
 =?us-ascii?Q?zakvWM7lVkz8r+3A9VZc07lS+bcYOnFGahb1x7mN6XZQyyA3E7wYs3LQVTlc?=
 =?us-ascii?Q?ncoaWFDGUbBl6otK1woHoY3wYTNOVM+8rhNAYAVxWWpHJmMiQTIcEFiNk50P?=
 =?us-ascii?Q?so28SjrImSPjKEff1Ikje9iBmsQhh2Cyo3GaPTXpBfv7HA9AbV3Mm2z5fhes?=
 =?us-ascii?Q?UtepBscg74MPvHULA9+1Op9O/LgVmetZLlMwEX0bgVwnTEXODglnwETDSGQ9?=
 =?us-ascii?Q?kQFgfakZ1+lXWLr/05Q+9Q0awsYlOMu31gDNAlKogHeX8uW5Jqq68UUMq2cd?=
 =?us-ascii?Q?KKvXpUXWaE4RzZaRvMMUNQP4kHo08l1NaVlrG02wyiFIuhvcbhIEblEeLIl1?=
 =?us-ascii?Q?9v/ZGETAm7k3itZbe2lX9Slg14xaEf87i9odM1ac1ZxPOd9k86GKSjuADrEi?=
 =?us-ascii?Q?+LhBVQehAdBtsCLsE6ZOU7nRDFkPDqoh/G8lTC60LRvObVtwwLOEsDkKlcLl?=
 =?us-ascii?Q?V6Kf70wgmLZQ9WMI1Y3Jivog0LvwVlUrPhmfvYbHhQ4jlilsSnSWLkB0cjQ7?=
 =?us-ascii?Q?BYv25JllOrv09MCHhuBoyUwyzWTIEAqqwD00kaS/7HPzBA6aUReGd9Tog8/T?=
 =?us-ascii?Q?qfNIHLOPrMLn49FrfAfyNflxkDYIrSBsgTlswRSLwigV5J8/Ctok1FrgJzSo?=
 =?us-ascii?Q?LV6hEDOYGgTcPR69cnKKTl3HoFqED+VtMLwTRsmM66TJmU6N2bnmOOiangXH?=
 =?us-ascii?Q?LOdt54duraFzxm1Y27kStgCLuAuNMnlbPoynUq5BhbpSM+UAP77+Ht4lTmyO?=
 =?us-ascii?Q?vLSObqOaVE04EssYahU8zQHuO2vZOQ8wK4RfmnYMcTQo4N3nGXQ/pVw6Q7bz?=
 =?us-ascii?Q?Mgn2kmz4nzWb2YfoZmgKAEhOi2l+GqHrMILXJNrhFs1r09xKmvjJ0UVA94U3?=
 =?us-ascii?Q?MnDzDwyvVPHjCx9+R7ER2n5wiDNbrmmQVxturg8iOryO9vd8X1BvNKQMs+Vw?=
 =?us-ascii?Q?AcYlJVoR1j857azqlBipTFzJC+na3nk0UC0wxkAwYR5/zbHOIq9IYNOv5kcA?=
 =?us-ascii?Q?Wh3Re6kB9JbQpeciigP03DQZdO3UYp+gzOjLSYADcuyMO/gjRGhwPzQVnFpb?=
 =?us-ascii?Q?Gea4B1px6CAW5oRgvo4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f95039-61e6-4d7b-8948-08da89cd7579
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 14:47:55.7921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E9f6GxEiGltlCrRmvIOGLRqpD+ymScmxO4QeBui/ZdzpgRt8iJSb3bajfiYr7vcTKs4bTB8/hA3/1ciuU8YWTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6923
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
> From: Marc Zyngier <maz@kernel.org>
> Sent: Friday, August 26, 2022 4:45 PM
> To: Frank Li <frank.li@nxp.com>
> Cc: Rob Herring <robh@kernel.org>; tglx@linutronix.de;
> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kw@linux.com; bhelgaas@google.com; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-pci@vger.kernel.org; Peng Fan
> <peng.fan@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> jdmason@kudzu.us; kernel@pengutronix.de; festevam@gmail.com; dl-linux-
> imx <linux-imx@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com;
> ntb@lists.linux.dev; lznuaa@gmail.com
> Subject: Re: [EXT] Re: [PATCH v7 3/4] dt-bindings: irqchip: imx mu work a=
s
> msi controller
>=20
> Caution: EXT Email
>=20
> On Fri, 26 Aug 2022 19:59:44 +0100,
> Frank Li <frank.li@nxp.com> wrote:
> >
> > > And I stand by my initial request. "a" doesn't convey any sort of
> > > useful information. Why not "I" and "II", while we're at it? Or
> > > something even funkier?
> >
> > MU spec use term "a" and "b",  user have to map "I" an "II" to
> > "a" and "b" when read MU spec and code. it is not straightforward.
> >
> > I quote a part of spec.
> > " The MU is connected as a peripheral under the Peripheral bus on both
> sides-on
> > the Processor A-side, the Processor A Peripheral Bus, and on the Proces=
sor
> B side,
> > the Processor B Peripheral Bus."
> >
> > Rob Herring and Marc Zynginer:
> > I can change to any name, which you agree both.
> >
> > Some options:
> > 1. "a", "b"
> > 2. "a-side", "b-side"
> > 3. "a-facing", "b-facing"
> > 4. "I", "II"
>=20
> Use the wording indicated in the spec: "processor-a-side", and
> "processor-b-side". This is what I asked the first place.

@Rob Herring:  Do you agree this name?

[Frank Li]=20

>=20
>         M.
>=20
> --
> Without deviation from the norm, progress is not possible.
