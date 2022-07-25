Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86695802AC
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 18:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbiGYQ3P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 12:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiGYQ3O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 12:29:14 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0F11C93D;
        Mon, 25 Jul 2022 09:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EY+U3zvVecMJzmGuK6PUC8lAa3DDhCVkM3w16HdCC0gsscuRpSCD6BSOH364KMSph7UduET/yfZaoAM4GTSLcNBowprSWGgoDwPirQBkeqD+oLU0kmxXMBGG9FhbLo1fIcXpCV+JGHw8dmUJapSwJfupI4D/HOqVxFOSkKT0Yyr4nbXKfWT4bR3IsZb9XVSph/M9Uljpq+W8/ojf9CQor97wYXiSw/W2dcQHrNkrfd65ClhLbYDO3cdfwcWQBfTpwr+iRFr8Wvb9DY54gTa55i6A2WZxOwh97rrzvT8TZsX2tqA0kA7/FZXBUKsB9/meLLA9yScdObpAbJgrFGRIfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6PHXOXh3KNrwaYQ1wdqKlCGrZSKTMo05oubFGRwrWE=;
 b=bOWef/RImyjxV0WoOf8f+IKnposx8kTVkqoSPLOk75TLXrobVhpJtFqohH7mJ9iKiwbiYS1g+Ad5Gi7Z7p+jVK6MSlUjWxjKUfuSkyDqxv2Wbs0Q5Pm9MgAWISEur0dHGzTPjIClFSYs5uR1s4c+FJ2pyWRuN7O+4rmCFet4Zp80r5T1MKOQ7eDgY1XdZNRbGx4hJFHIcLUy218BSB6ut3dz4nfoFDQIFrvXySDMnth4xbZqaOj5FU8lKrXH9vJDAjx2dih/mj10gNEeiaa9mFqtXWDOjVfpC0WH9S59Ixc/D2lrSm23NbwEvwatrLS1C3xt440bYeYxy0KkoFk7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6PHXOXh3KNrwaYQ1wdqKlCGrZSKTMo05oubFGRwrWE=;
 b=TMb4GZRTH1REmOwLFtO+M4Z3fJmmv7Eoac4oUhh+rrk5YoWDs2yZLv7sEf+bYIihsfs/9TocGFf56+aF16/VVADxffXpAhEentSw7AsEXTTfYYApktXsA4U+SMkGTYjRTnJGVL+jVrldc0TiWzd51ZcY/MdrrZVd8vWziOHwZ1U=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DU0PR04MB9395.eurprd04.prod.outlook.com (2603:10a6:10:35a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21; Mon, 25 Jul
 2022 16:29:10 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::1c38:3e39:bb58:8fb5]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::1c38:3e39:bb58:8fb5%8]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 16:29:10 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "maz@kernel.org" <maz@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "kernel@vger.kernel.org" <kernel@vger.kernel.org>,
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
Subject: RE: [EXT] Re: [PATCH v3 3/4] dt-bindings: irqchip: imx mu work as msi
 controller
Thread-Topic: [EXT] Re: [PATCH v3 3/4] dt-bindings: irqchip: imx mu work as
 msi controller
Thread-Index: AQHYnIAJovFS7I01jEmrtDfD99bazK2MUQmAgAL7B1A=
Date:   Mon, 25 Jul 2022 16:29:10 +0000
Message-ID: <PAXPR04MB9186010F8F364CFB760064DF88959@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220720213036.1738628-1-Frank.Li@nxp.com>
 <20220720213036.1738628-4-Frank.Li@nxp.com>
 <2c11d0b0-b012-ea24-5c3c-305bbdd231a0@linaro.org>
In-Reply-To: <2c11d0b0-b012-ea24-5c3c-305bbdd231a0@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a95b4e4f-9147-4a0a-ff75-08da6e5acddd
x-ms-traffictypediagnostic: DU0PR04MB9395:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P699gMRmIDeS5I9/DeH8br1VrYIJmbn5vDyBFSSGQJ/znNlpUXnYWMAnmhxFfnqGoyX9sMAdgUhNr68CHzF4hQiMy9V+LpS8vEE3BulYBaC3NXkgX4upAgEEqvuSQgIcs5Iyr9YCT8Qe3wEDjtwLY8nP1mRXvEtx6U5ozCQTDybLrkApWMXcU78hbcqFSZ3V6ocHshc6v3AeBCmlucyONfKj9ymcpRxfo4HjZE6OJKF2dV2JgdcWz5R2Fo/LJgYUPKthjkUoUnqDV+78ADF+AVdpPv70ImBd90QKt4coh/ZL5wLoeef/Gsbs9t7NN96GRCXJx2F5oFxVAiYXy1usHfNwvU2ECDvS2UautyzxmdUFgJsNdQmcY3oaFg6zRQoRQEGtgNUHQ/i4Vd9LGt+QjKYLkp4/z+xPIZzXdbXHL0hwvVnxQ8vlobgLOfiBemsMOM4/hf3EUYZwaNOlwsyLp2tsnSg6uzpqT0AiTpacAgNJRESeUGpxEvCIXyVSQn9QM4SS3FBkpDsCuNaxH6ZfdjMTqbcUpX9+u6CZEscb0+Wggdvl8DX7TpyV5DhhDzzo4Q1S6PiHc2nPL13J3Zc2KFL9YVkKKx2qSK6kFOPkI2Eb9H3pKuTeUn1Q6+eIveKysPECRlVBeENNgusNcZ4z2kjsTFftipA2dHq+mXqDKLWxIc3Qa81sbqIF6dOQQ4NBAcZpABSZQdtqYT9IDUZuyaU4uVy4xENU9GON2d/vzkPtSK9qsYymep8peBMUFEzTmsXvHa0cqjLSCmESR/oI/BtBkGzDNbkEp9erIHd0cJqonBH/phOVld7siWtL1103GxrHT/2jpV+gHZoJF6vIy7apbPySscnebJpGTB6t4X8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(52536014)(8936002)(6506007)(316002)(76116006)(45080400002)(71200400001)(478600001)(55016003)(7696005)(66556008)(54906003)(66946007)(8676002)(66446008)(66476007)(83380400001)(4326008)(33656002)(64756008)(86362001)(921005)(44832011)(7416002)(2906002)(122000001)(41300700001)(9686003)(55236004)(966005)(53546011)(186003)(5660300002)(38100700002)(26005)(38070700005)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cg6ZqfHpt4aaU3fcJ5v7IXTfX8GVmKe/Uj4smlYU5+l0N6suC/ck0SZ9AKuq?=
 =?us-ascii?Q?rXtSyJ0h6gTTiwaqOkfw98gj3T+p4xmNiF65kWF7zstDZOrasIImmy3trXx2?=
 =?us-ascii?Q?feJbmB4JAS+Q8fXcRjdTTjVxT0wMDVvIlwGPsEWsiFQGe3y8tAyfONK/4sTn?=
 =?us-ascii?Q?0K/PvUmeYk6iUKT1tu0jpIu89coXwSxFql78Ci7iIMNjtkZBXA5BrWo1Xc0j?=
 =?us-ascii?Q?Ulgy9DZlzPtFL3s4xH3G3KXV8P3S5tu1diJCxsR6qJfx/VEtKWdV/fxRDPIc?=
 =?us-ascii?Q?GtYF7IicA87nKG38D+vidzLpL1VhKtZMb1TxVbUcrU4QyHsZB9mOzPPGRQBg?=
 =?us-ascii?Q?wuXaBz//5/Jk6k9yQLF5r7qox0RDMUjTiRE5QVkmeakzQvzk8QiJqEHLXZDX?=
 =?us-ascii?Q?q1UtuSbzHVpM5/Q9lgz7dgEJZEG5r8NzR/MnfCwE4T235x/eD7jS+mk6b1cG?=
 =?us-ascii?Q?KiEQEWgSx4/69fitOTJPC7h71J1YFIVl3Dj9ZF3N9gUaxFIolVC5NVIHhDZy?=
 =?us-ascii?Q?Y/irTgWT1SoqpiDJcl90q6KC1+jiqKL7zmt3zybM8bgJVSoCF3FVuADUpxh8?=
 =?us-ascii?Q?han70Mj+1qYFcVpheJthMIuih1dgXWg5kJH+E+99FMcRYdb1aT8fIOL77k8d?=
 =?us-ascii?Q?IzmKTpiVZMMzEylMAzDv/tsBy078rYAlBctJ9HP1Gc2Ta/vctHyYBav5J9RF?=
 =?us-ascii?Q?mJUqRpjQF9HF2Gjtxy8nAM5s5M8nxGLx4M0dRu20Arv5r3wOYbzbzP0JDLQM?=
 =?us-ascii?Q?LAtkeewBi5PiowACiqG7OAkIil3BQu4ECy1elPK3tWXqSTnw31UWB0F9qI7Q?=
 =?us-ascii?Q?dJHh2QX7og/1ZVV9S/T3A7ym8pNFp3mbBIAtSTulnAvzSUjf6gnLtMojH7ZG?=
 =?us-ascii?Q?VeVeMGOCMKa06v1iJWyFDrS7sBBBCZoD8Htdg+ULyTC2Ii72BuT2Hr0/f66C?=
 =?us-ascii?Q?RGOlG7bOVo/ZzDH4SG/GsNI2Zw+Jd4RNzgaeX9zqy2nc6JeKjwNICwwcTap1?=
 =?us-ascii?Q?ERfQuG/sZ7nlf7hsBCL3XhU2obhHPupn5uSP3A8yqn8GusfCX7cjljBaBiXX?=
 =?us-ascii?Q?859K9q0QVLInr9yusYxi3z14UKpSSGq+COUtO3LNhaRNOTXDMlJ43Df5Pa8F?=
 =?us-ascii?Q?HnqbEACoTi1WupadvxNHY6MopnX2vCGtLJYDxg/vgPt5v33w9zawWUscp8DK?=
 =?us-ascii?Q?mQL0v2uenJXk+Bv2ZBBEezmYRohvzmS6OjPOQE49PxakABxJWcqhAL18OxZB?=
 =?us-ascii?Q?EWLwbJ7coksFzVJoT0lo1LPPIOH/QWBEzeOoKfkt8IhQXHPPHYhEQFvLrQYg?=
 =?us-ascii?Q?cxjRL7IHMb2H62zD1bLRC1NEsXjs88PoOhyIEE+/fASnYXdJL9svdqBYQ+JC?=
 =?us-ascii?Q?vORDMB3MSUddYxJhx/asnywH+BZECJbWuqtMLi5KtbgvbX/PO4gxByiQr6QK?=
 =?us-ascii?Q?/Puj738J2RZEDrg7tRZI8F4JKrb8NKP1OCOS4Sxy8/6h5bhX+fCjtii45K4A?=
 =?us-ascii?Q?BsrkXVivk7+LtjTHFZgH/SvENXhYvfLA9NNfvQ4qzZdF2hKlBxRiTcanj3K0?=
 =?us-ascii?Q?mp8f9T9DQl+4lSd3WX8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95b4e4f-9147-4a0a-ff75-08da6e5acddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 16:29:10.5867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5zUoHzxevLY5Cn/rwBi6gjxq4BQtUkAkJa/FsVdgjxuAYF0JhKFBH0OwWr4Yk/mIamlshrSAZR/5C8+YpSC9Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9395
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Saturday, July 23, 2022 1:50 PM
> To: Frank Li <frank.li@nxp.com>; jdmason@kudzu.us; maz@kernel.org;
> tglx@linutronix.de; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org=
;
> shawnguo@kernel.org; s.hauer@pengutronix.de; kw@linux.com;
> bhelgaas@google.com
> Cc: kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-pci@vger.kernel.org; Peng Fan
> <peng.fan@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-
> imx@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com;
> ntb@lists.linux.dev
> Subject: [EXT] Re: [PATCH v3 3/4] dt-bindings: irqchip: imx mu work as ms=
i
> controller
>=20
> Caution: EXT Email
>=20
> On 20/07/2022 23:30, Frank Li wrote:
> > imx mu support generate irq by write a register.
> > provide msi controller support so other driver
> > can use it by standard msi interface.
>=20
> Please start sentences with capital letter. Unfortunately I don't
> understand the sentences. Please describe shortly the hardware.

[Frank Li]  MU have 4 registers and both side A and B.  If write one of
Register,  irq will be trigger at the other side.=20

For example,  writle(a side reg1, 0).  Then b side irq will be trigged.=20

>=20
>=20
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../interrupt-controller/fsl,mu-msi.yaml      | 88 +++++++++++++++++++
> >  1 file changed, 88 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-
> controller/fsl,mu-msi.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl=
,mu-
> msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-
> msi.yaml
> > new file mode 100644
> > index 0000000000000..e125294243af3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-
> msi.yaml
> > @@ -0,0 +1,88 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
t
> ree.org%2Fschemas%2Finterrupt-controller%2Ffsl%2Cmu-
> msi.yaml%23&amp;data=3D05%7C01%7CFrank.Li%40nxp.com%7Cfcec12a0731c
> 454af5c308da6cdc2a0e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C637941990101591376%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
> 7C%7C&amp;sdata=3D9h9nKyvsWaghry1hkpa5aaxVGYpx6xZRTxhN0S4uB50%3
> D&amp;reserved=3D0
> > +$schema:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
t
> ree.org%2Fmeta-
> schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7CFrank.Li%40nxp.com%7
> Cfcec12a0731c454af5c308da6cdc2a0e%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C637941990101591376%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C3000%7C%7C%7C&amp;sdata=3DwagM3hl8fpJSm%2Bibw6ENl5lNlQ9fVEHzS
> OlT%2Bjoridg%3D&amp;reserved=3D0
> > +
> > +title: NXP i.MX Messaging Unit (MU) work as msi controller
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +description: |
> > +  The Messaging Unit module enables two processors within the SoC to
> > +  communicate and coordinate by passing messages (e.g. data, status
> > +  and control) through the MU interface. The MU also provides the abil=
ity
> > +  for one processor to signal the other processor using interrupts.
> > +
> > +  Because the MU manages the messaging between processors, the MU
> uses
> > +  different clocks (from each side of the different peripheral buses).
> > +  Therefore, the MU must synchronize the accesses from one side to the
> > +  other. The MU accomplishes synchronization using two sets of matchin=
g
> > +  registers (Processor A-facing, Processor B-facing).
> > +
> > +  MU can work as msi interrupt controller to do doorbell
> > +
> > +allOf:
> > +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx6sx-mu-msi
> > +      - fsl,imx7ulp-mu-msi
> > +      - fsl,imx8ulp-mu-msi
> > +      - fsl,imx8ulp-mu-msi-s4
> > +
> > +  reg:
> > +    minItems: 2
>=20
> Not minItems but maxItems in general, but anyway you need to actually
> list and describe the items (and then skip min/max)
[Frank Li]=20
	I am not sure format.  Any example?

Reg:
      Items:
           - description:  a side register
           - description: b side register
>=20
> > +
> > +  reg-names:
> > +    items:
> > +      - const: a
> > +      - const: b
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    maxItems: 2
>=20
> and here you correctly use maxItems, so why min in reg? Anyway, instead
> you need to list and describe the items.
=20
Does format is similar with reg?
=09
>=20
> Actually I asked you this last time about interrupts, so you ignored
> that comment.

Sorry, which one. Is it below one? =20

---
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2

Instead describe the items.
---

>=20
> > +
> > +  power-domain-names:
> > +    items:
> > +      - const: a
> > +      - const: b
> > +
> > +  interrupt-controller: true
> > +
> > +  msi-controller: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - msi-controller
> > +  - interrupt-controller
>=20
> Why different order than used in properties?
>=20
>=20
>=20
> Best regards,
> Krzysztof
