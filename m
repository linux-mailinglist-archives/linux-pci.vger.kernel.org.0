Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A6758032A
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 18:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbiGYQzf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 12:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbiGYQze (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 12:55:34 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D7B55BB;
        Mon, 25 Jul 2022 09:55:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFM0X3u6Up8ZL5IuS+fqfTSHAy0i5jTyYWv//7Leb/JfYXxv8fXQqwEW8X+Nq6mIGbM0A3JK+UdGqST9hsqyqRH9AtvU6jnAqSelp13GrcHuGQ6qjGsgadhId24RskyqZaCNsLP+hhcQ/Ly0581g1m68tVKlDOjPISuQucZIhNrJZf3B1O0uc77C8YtzEOb/Z12kfhN1yqeM0rBB4IsT0bhtxjnqp0/6dv/KGrLqdBuWsEY1jP4vi7f00Q4QIf4Q/k+LbWz2hjsupQaDfPOBVGzCJ6oIG7KoYfhNXY3fxaISsICgZHQjjj6lBL3e8v1cR4yaVEllJg9E/cDVJKtSew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlMy726xNpGN21q9TGkq1wBU67+CJgmDu4CjcpA8zq0=;
 b=Fh4VJ+Jkuuf5eBCjmJt4LbO1WY8zvBzU75e3exnIkYlT2LQ9Q7LddfrJvoVVLKW6akaf+/3uzUpYjI2XJWgUlRrCpNaMoYulI0DNu3nGLE71oyVWqamMv++y6IrKolzYbejnmjNTzvCZbA5SKw8Bz9nxWWg56m0r5TMzVRYNL9RtpmfAesKulCeDhUUBwgWZ+8tyyUXdickIxhNjnqSQU1SfzsKOu5e2N4hbj1lVW2JGtdK61tODq+jIpgu0KOFc1ntLBuV/QX87mX9RKX3DpTfx40UTaihh/GqrAiWgrEVPnbq6I7BW/qM9sHsDN69CRUCslbSLU9O9PLdS5647wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlMy726xNpGN21q9TGkq1wBU67+CJgmDu4CjcpA8zq0=;
 b=jhIzjWyYCbFo3Mu+ALl54bXdwxuc3oQ/ZP0RPVbne+OY+Yue8S9yChTQi27jJAmiLdQSfurWg3Tc6NSbkhr0QNVaGRGMgrjMD8Ea2wdmQYUqq+fm5/IGo664qYvv/hv+HIlIAMBJf1tN6Iem/xopX5KCsNBr8Z7k6hbgjn1E8UA=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DB8PR04MB6492.eurprd04.prod.outlook.com (2603:10a6:10:109::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 16:55:28 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::1c38:3e39:bb58:8fb5]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::1c38:3e39:bb58:8fb5%8]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 16:55:28 +0000
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
Thread-Index: AQHYnIAJovFS7I01jEmrtDfD99bazK2MUQmAgAL7B1CAAAaZgIAAAHJg
Date:   Mon, 25 Jul 2022 16:55:28 +0000
Message-ID: <PAXPR04MB91860D406AF430B16032EA5488959@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220720213036.1738628-1-Frank.Li@nxp.com>
 <20220720213036.1738628-4-Frank.Li@nxp.com>
 <2c11d0b0-b012-ea24-5c3c-305bbdd231a0@linaro.org>
 <PAXPR04MB9186010F8F364CFB760064DF88959@PAXPR04MB9186.eurprd04.prod.outlook.com>
 <7994d7c7-ae13-a136-f60c-40fd9918565d@linaro.org>
In-Reply-To: <7994d7c7-ae13-a136-f60c-40fd9918565d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ea06b43-0f7d-4280-5687-08da6e5e7a57
x-ms-traffictypediagnostic: DB8PR04MB6492:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YEkdT/MYXPNu1SAJLEoQ9IHux7QSNv1SlUoOtBTA/9LpMra9cy95+2uB4zlrLJeRJtr0mcphhT93fMzD9NffgPKyzblHxf66qrpL6ddWOHVJnHhIThcob2R/bqw+LHNPo22t30OFNJkuAuaksbLIM6BTxu6jguq/iZzcwLVpggjfREYmAkB7V/EzSJjz8rXFd3J5q31CTdKQ3mbrzlu7VIE7kgKTkNM4P2gl64CM1SQWqRjnbLsrIM1OWMRpixl6yp4tqiq/gEOAVQQRF2XjAZIH94fXc/cqw5X8vhET6pPbV+qjPV8WzuaaZHHWNi2dijv7e84hlMdRFLqhkIkw5kvmiGIVh00Hc1/2u3ZD8hDTIt7nlGHT1JBOqJl9HBoCirM4NgxSTVKQLTqf5mGvGxeIDVUqKf3qXvlWhQ/p0HoMTNbTuU9fjKO/wbb6wMVFf2yJSUkblA6gjYz600QcwK/DH50dz6ktBCnYMbsSRgj3davHXVPNbIqnW/Au54hMU3bq8v/TosDlp4R3w4eXdfpNU//VEgHYUCTLojcoEuusr8Q1PWXsCyMOVWtMShDQJeDuPGID2GbkT5vMOB7rFXvDh1ER66/igXI7mFRCK+EsyPalemuMvkuUVrDO9dCYJ2wwfCITa3rUpXosQ2iVeEl4aFBSRsPNseGK55vKe/9o9kSuIW6Rgc+rPogfjY2QHrKF4R2HrITtAMRWv3s4j7j37cocUipeRuHad5qBS4Hmi7RWEWQAXJRRAmDC7xoSH04QGG1/SPKSaEgB3hf2MOmO7591o0u9JBx+e7HMJfN9RFKIfiPaz3WTggJ4s9IitloMvIJfN0sNuK/vU8qStfQ8F4LHOu30qb1/AiFpKIg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(2906002)(38100700002)(86362001)(71200400001)(33656002)(122000001)(53546011)(316002)(41300700001)(55236004)(478600001)(110136005)(186003)(26005)(6506007)(9686003)(45080400002)(44832011)(64756008)(66446008)(5660300002)(76116006)(4326008)(8936002)(66946007)(52536014)(7416002)(966005)(66556008)(83380400001)(38070700005)(8676002)(54906003)(66476007)(921005)(7696005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lQ+7yu5dKWXxEguXjnLzU18QiOPU/Qc//R9HWDuVvGhM0HFJHxTwsjcDFEwZ?=
 =?us-ascii?Q?oXVBakIIZ32yPtlECT+r6oLJnYqRaIiO3NejaIL+NFqGRgm7QTYxihtGRgi5?=
 =?us-ascii?Q?kDJpefJH3dBjv135lH8oEIXu/gyKke7lC6gQU8T/jtmhd+DwVufxDR1tVK18?=
 =?us-ascii?Q?twqvfI97I9hO8r34ODwUGY9/UqPgpiqEUyw8+uMLo/YJPw/p7E3E7L+lidup?=
 =?us-ascii?Q?Py7kApYiCMDVdujkOo2Dn0EhU5GsWaCoicNgbXIIdkEqVgYS24oR06ZoB9nR?=
 =?us-ascii?Q?SIAr0Mx57lEhJ2v9h8LpoPDRZp8uD0bJ44fkuGIHcjZF9DI31vBLAPzcpaDW?=
 =?us-ascii?Q?xZaPDmYh7C2WS6x4juUGEzoJihX5jQC3NgZzBXeOUDG6/XpdFEAhMxsi7amg?=
 =?us-ascii?Q?mgylB0UJ1BNb1uLUDmHGoTY5H9pVmffH2XEMMKIAr/iQd4UDQR7q+2quy2Qb?=
 =?us-ascii?Q?3ygBuQvMp4miYe1rLBHIpCrpBDZ1VmILX00gkhMWDcIsp+2qw3Jh8HqUvIkq?=
 =?us-ascii?Q?dt8q4iyPY9oU0TPq6xKHYV430MnfkPZcIsb+4S6NRxihhQY5nKW3TxnSIy2D?=
 =?us-ascii?Q?vF63vzrUtuwqWxLReovmiRgokvFevh0AQoGLWQ/YFxG7Kpk5f63t3S9LPPv4?=
 =?us-ascii?Q?YLBfUoLrUMtEZAAGR8hWSbWqnV4vg2dgHsKe0c4hmcVj7oJFLYWvMMxGY4K5?=
 =?us-ascii?Q?4AUFbbTdTsN7U3Us2WSaFienDKSkO1Je8bo9JHC1PooTWF9B/bl7M1ywdPc+?=
 =?us-ascii?Q?oktKWyf0sbokyKQn6fBG2VSURq/RBOHmOh3G+herv8sRec+sQ4t5lHsFvIL/?=
 =?us-ascii?Q?U9B2vPJDTMY472Ri4gO3w3JyCVvayhyxeOBcrO+fIQEeu0J4PjMtGdo9xxbE?=
 =?us-ascii?Q?s2MPw/8zoWUuwCyYYafwHS3Tm/33GdkwuWW6AbT32WKcqytQTrGR3Xrh4pSm?=
 =?us-ascii?Q?FoIhy+GRuFvvC1yttvH67gY3uehVLBBWoX+ZfX358Mq2hjjlTtt5cqjUp4ti?=
 =?us-ascii?Q?iudFXgcpGTqPbMhLDVd2AwRcLSsj4z5L21HZyV3xx6Z08hj6SKPfrydbHOgx?=
 =?us-ascii?Q?UL9FTjZWmiPxUz4wOMCYPq/dP75fq4gCO+GGYzyqKTIWA12J4Ks6AvF1ruE0?=
 =?us-ascii?Q?O0QyRuUpebfw28+6TlgSXeWoseI2Wz2LZfma9I1i8b9tyv8Eugl99iqKRudZ?=
 =?us-ascii?Q?GlkjLptHgVBW+cAPbj9MANwdpxRs9xAP0eBecO15hLIJPLemCAU2KqaCJbs7?=
 =?us-ascii?Q?OvQeO/DrmClTdcwdY+O0sYO4guX4JBc5F3vI24OjDDmKjwZNCoZVRuvN1RC3?=
 =?us-ascii?Q?esp5A9oHEMJVNXwvR2pus15NzheOxnqrkv8mC4moCIV/LGv/LB4Z+4IsFE3K?=
 =?us-ascii?Q?PCjg/r1Em/26UxCYJ4R991NpCyCj3unArUfMbVPPg5j7v8miISFudOuW/EIe?=
 =?us-ascii?Q?rkXV6TSVD9VdRlkQGPFBQ/jAAPECEZpr3gVBGYWcugMYn/Gtb6gT1vqVVsNQ?=
 =?us-ascii?Q?+I0OUYyhMHsjm3a060CVIFEcWPPJW9+kDz69LvYzydzNz+tdyh4O779mWyYH?=
 =?us-ascii?Q?rnSPn9b52f0y+o4oqq8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea06b43-0f7d-4280-5687-08da6e5e7a57
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 16:55:28.4559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PHB57CAueWBjTvB+MsIrc5CoAAQc3+WK2iOzOri1NSNokXUmGFuFy7PTrPCg6wVS9q21oo72ogLuebR41SpYlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6492
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
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Monday, July 25, 2022 11:45 AM
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
> Subject: Re: [EXT] Re: [PATCH v3 3/4] dt-bindings: irqchip: imx mu work a=
s
> msi controller
>=20
> Caution: EXT Email
>=20
> On 25/07/2022 18:29, Frank Li wrote:
> >
> >
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> Sent: Saturday, July 23, 2022 1:50 PM
> >> To: Frank Li <frank.li@nxp.com>; jdmason@kudzu.us; maz@kernel.org;
> >> tglx@linutronix.de; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org;
> >> shawnguo@kernel.org; s.hauer@pengutronix.de; kw@linux.com;
> >> bhelgaas@google.com
> >> Cc: kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> >> kernel@lists.infradead.org; linux-pci@vger.kernel.org; Peng Fan
> >> <peng.fan@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> >> kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-
> >> imx@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com;
> >> ntb@lists.linux.dev
> >> Subject: [EXT] Re: [PATCH v3 3/4] dt-bindings: irqchip: imx mu work as=
 msi
> >> controller
> >>
> >> Caution: EXT Email
> >>
> >> On 20/07/2022 23:30, Frank Li wrote:
> >>> imx mu support generate irq by write a register.
> >>> provide msi controller support so other driver
> >>> can use it by standard msi interface.
> >>
> >> Please start sentences with capital letter. Unfortunately I don't
> >> understand the sentences. Please describe shortly the hardware.
> >
> > [Frank Li]  MU have 4 registers and both side A and B.  If write one of
> > Register,  irq will be trigger at the other side.
> >
> > For example,  writle(a side reg1, 0).  Then b side irq will be trigged.
>=20
>=20
>=20
> >
> >>
> >>
> >>>
> >>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >>> ---
> >>>  .../interrupt-controller/fsl,mu-msi.yaml      | 88 +++++++++++++++++=
++
> >>>  1 file changed, 88 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/interrupt-
> >> controller/fsl,mu-msi.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/interrupt-
> controller/fsl,mu-
> >> msi.yaml b/Documentation/devicetree/bindings/interrupt-
> controller/fsl,mu-
> >> msi.yaml
> >>> new file mode 100644
> >>> index 0000000000000..e125294243af3
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-
> >> msi.yaml
> >>> @@ -0,0 +1,88 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id:
> >>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
t
> >> ree.org%2Fschemas%2Finterrupt-controller%2Ffsl%2Cmu-
> >>
> msi.yaml%23&amp;data=3D05%7C01%7CFrank.Li%40nxp.com%7Cfcec12a0731c
> >>
> 454af5c308da6cdc2a0e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> >> %7C637941990101591376%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLj
> >>
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
> >>
> 7C%7C&amp;sdata=3D9h9nKyvsWaghry1hkpa5aaxVGYpx6xZRTxhN0S4uB50%3
> >> D&amp;reserved=3D0
> >>> +$schema:
> >>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
t
> >> ree.org%2Fmeta-
> >>
> schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7CFrank.Li%40nxp.com%7
> >>
> Cfcec12a0731c454af5c308da6cdc2a0e%7C686ea1d3bc2b4c6fa92cd99c5c3016
> >>
> 35%7C0%7C0%7C637941990101591376%7CUnknown%7CTWFpbGZsb3d8eyJ
> >>
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> >>
> 7C3000%7C%7C%7C&amp;sdata=3DwagM3hl8fpJSm%2Bibw6ENl5lNlQ9fVEHzS
> >> OlT%2Bjoridg%3D&amp;reserved=3D0
> >>> +
> >>> +title: NXP i.MX Messaging Unit (MU) work as msi controller
> >>> +
> >>> +maintainers:
> >>> +  - Frank Li <Frank.Li@nxp.com>
> >>> +
> >>> +description: |
> >>> +  The Messaging Unit module enables two processors within the SoC to
> >>> +  communicate and coordinate by passing messages (e.g. data, status
> >>> +  and control) through the MU interface. The MU also provides the
> ability
> >>> +  for one processor to signal the other processor using interrupts.
> >>> +
> >>> +  Because the MU manages the messaging between processors, the MU
> >> uses
> >>> +  different clocks (from each side of the different peripheral buses=
).
> >>> +  Therefore, the MU must synchronize the accesses from one side to t=
he
> >>> +  other. The MU accomplishes synchronization using two sets of
> matching
> >>> +  registers (Processor A-facing, Processor B-facing).
> >>> +
> >>> +  MU can work as msi interrupt controller to do doorbell
> >>> +
> >>> +allOf:
> >>> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - fsl,imx6sx-mu-msi
> >>> +      - fsl,imx7ulp-mu-msi
> >>> +      - fsl,imx8ulp-mu-msi
> >>> +      - fsl,imx8ulp-mu-msi-s4
> >>> +
> >>> +  reg:
> >>> +    minItems: 2
> >>
> >> Not minItems but maxItems in general, but anyway you need to actually
> >> list and describe the items (and then skip min/max)
> > [Frank Li]
> >       I am not sure format.  Any example?
> >
> > Reg:
> >       Items:
> >            - description:  a side register
> >            - description: b side register
>=20
> Yes, but then explain what is A and B in bindings description.

[Frank Li]  How about "A(B) side base register address."
Any other description need? =20

>=20
> Why MU, which sits on A side needs to access other side (B) registers?

[Frank Li] MU work as MSI controller for PCI EP.  So driver need provide
B side register to PCI EP by msi_msg.   PCI EP driver use this address to s=
et
PCI bar<n>.  Then PCI host can write this address to trigger PCIe EP side i=
rq
As doorbell.=20

MU MSI driver also need A side register
To get irq status.  So MU MSI need both side registers.=20

>=20
> >>
> >>> +
> >>> +  reg-names:
> >>> +    items:
> >>> +      - const: a
> >>> +      - const: b
> >>> +
> >>> +  interrupts:
> >>> +    maxItems: 1
> >>> +
> >>> +  clocks:
> >>> +    maxItems: 1
> >>> +
> >>> +  power-domains:
> >>> +    maxItems: 2
> >>
> >> and here you correctly use maxItems, so why min in reg? Anyway, instea=
d
> >> you need to list and describe the items.
> >
> > Does format is similar with reg?
>=20
> Yes.
>=20
> >
> >>
> >> Actually I asked you this last time about interrupts, so you ignored
> >> that comment.
> >
> > Sorry, which one. Is it below one?
> >
> > ---
> >> +  interrupts:
> >> +    minItems: 1
> >> +    maxItems: 2
> >
> > Instead describe the items.
>=20
> Yes.
>=20
>=20
> Best regards,
> Krzysztof
