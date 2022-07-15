Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07359576783
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 21:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiGOTfL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 15:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGOTfK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 15:35:10 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EDF57E30;
        Fri, 15 Jul 2022 12:35:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFU0xMdR398zMxbHj2cxXh26UpNigA64s+aXs1Ux59RMoxTbiKc7vPdzsyqjKCOHPY+nVhAd/A5eQ2ixcm3XSmS9zeGDRBFaL0kZ9WeEBF2xhkf+Eom9b70qHoQhaAlNDkbGRLryH6RJBs1sfy+XyqgUDQMw8kr0Ub6GgJaAa/CTtvh1sonOMuRYvalBU0K0x2KaFJPF6b5WyyJ+89XAs4vSvWV5Kc9mOsZb2s47ZZvtVpWCK9KdlAV0nw4ge+12aFDwBBU6ecg4aEuHFIrbTeoYAA/oat5gL2Ask2Fappe2Ihhcwiiv0naUXnH9Mst48/j2f9fwZZfwyO2mYEKR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yfr0IUqP304R3fEFxNamqFo73YFVKGgj6cNko3U+8jI=;
 b=JDpAcAW5F1btP+V7K7YDVTVEdIETieC9qsd6lKNMnSoxDzO5G0igBZwvhdxFw3Ki6OxYC9O53aTW9xEwES9sN291m9XM0Jh9ngPBniR8kl4eYZGHxPghg92g/QBx7dqDqdIp3skqCYN9U46YdgFghtIIhG430kA30KLv3z2xCWUl/rJjoLg1op31yn3jAbe4hivFYdG5QEEWd3SYspNE4lrjbH2NIeiX3YKGlfOKb603HyjYt5tnjXlHkM1YkbnCMEXfcaIIdVYxBrpUwgqS550ZSawuMiBOGIIOg0cfCE4dcx5SSRKM5rhHNT0l3xMgn4JiyU2ssMfzP69SPSvxyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yfr0IUqP304R3fEFxNamqFo73YFVKGgj6cNko3U+8jI=;
 b=nZ3I2XIjEinkSJERh6lex/BdI3GggYBM6c1XCDPz/RX4Mt5Yq9+g3pLI4VZRmPQMIT5p+wIO+A397hEjyxpTsznquTpdhBR7Mk1AJUHvaG8lw468bCIFb/XomR+QfpkEK9FZTieGHm1FwZIvkgIO2aBy7o2m/U2fAjvQQYVvsPo=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR04MB6286.eurprd04.prod.outlook.com (2603:10a6:803:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Fri, 15 Jul
 2022 19:35:01 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab%7]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 19:35:01 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
        "jdmason@kudzu.us" <jdmason@kudzu.us>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH 2/3] dt-bindings: irqchip: imx mu work as msi
 controller
Thread-Topic: [EXT] Re: [PATCH 2/3] dt-bindings: irqchip: imx mu work as msi
 controller
Thread-Index: AQHYkkT5PXP93DvL0kWawtePqB8DYa16jv4AgAVOK9A=
Date:   Fri, 15 Jul 2022 19:35:01 +0000
Message-ID: <PAXPR04MB918635C33C44CDB15F394153888B9@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220707210238.917477-1-Frank.Li@nxp.com>
 <20220707210238.917477-2-Frank.Li@nxp.com>
 <d28ea0ac-ff1b-5394-4c76-1561353ab7ce@linaro.org>
In-Reply-To: <d28ea0ac-ff1b-5394-4c76-1561353ab7ce@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29a40f4a-1d82-43df-9a96-08da66991c2b
x-ms-traffictypediagnostic: VI1PR04MB6286:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EDzuyomWdSMe1+FOVSOAi1TBsbDrQHvQZO6NLJ6xbGOLhqYffBLD9J8pmO5eFh4nDm2LGk5dDrMlJvvBfEREESjMGmOSQVJ30nrLZAtCEdqBWtiPMLnoC93jWF+FAA3O1M+omLIdGAyKX8PU2g3EAR2WIaN8wVVSmZnB3cJbFIOObzUaaqsGJSPZi0o0m8uVKwFafFOos55MiFTzbmhQG0tkTrKCl3FQfCfNibiaDvh3yfUDMRECe4uDvjYn3MbOETbv3y3aZk41GbFji+YZblbmL+qW3zUtKCXvsPK3Zfj2xgtdgL3W2NMykF44lqxboqVuHxOjHuaszHjhV1HVnBGsRo9c8flVyvcTlCog5AVNHzJGTILQU4EBMh4JIYXCd9lOpgLhjgex3go4zIuTlHdoJJcRBSTpQlIeV1FymIzAkNkE+MXNfiebaX9jTNalhTCJEZc181dSCyIt1yw55zUlSSIdQn8aPRf8sC/2zSc7yLwFMcvxHzJhvd89Sd8cHODdNEQI1aSY39u9TFqkrzKFB6b3YNJVTupghXCVj3ycxpb84Lw073MxlWZUNoHGQUhTH/2i3PE0Yv/wB0LH44ss/Nfvpj94pZ78/SELl5kaab0xOM5PY5CMi07N9oFrjjprkYqrmZQMd0trzJZK/BdTwR154iyCZ0fHxfkQz+1QkTXG8TJKxKVTLtoQYrUauf65lTsoDa3r9HRxlIMBl3hfj+4oYd6xAkFAtWmhbDM+d2MF2t1qwPfKXN6J9BbD+o6v8xDFHn5NtZ62QHkWJxUb4OGsxdZS3dQ6z54fMEUJt1i56hPh1iGwm2PVs4IfvhAo4bMR/kCXR9SQ2AyVq6L2GvuDAECOu7t4/j1It4Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(8936002)(44832011)(316002)(66446008)(66946007)(45080400002)(41300700001)(52536014)(7416002)(71200400001)(66556008)(8676002)(478600001)(54906003)(66476007)(4326008)(76116006)(966005)(64756008)(5660300002)(6506007)(7696005)(2906002)(9686003)(33656002)(110136005)(26005)(186003)(55236004)(53546011)(38070700005)(921005)(55016003)(83380400001)(122000001)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+y6eMMjPhkNjOilDzzaN2l6IkP+vdWECUgziVaPZg1CVeViEWNGxtiMIXg8b?=
 =?us-ascii?Q?7z4Xb3fwRY8GsxGz1v14c7PiYjzkqklQVcGjZDGpphAUHjD8Bs2gL8Nri1mw?=
 =?us-ascii?Q?ht11eoy3juDSwaWQEQZJV/MGoTgaSHgTp8JU1jGMm7h3b2Z28xYulYtsNlMA?=
 =?us-ascii?Q?9FTr+i8KBBG/o5Vy/b+DrfHvqfhjEdnDQLpf7MfAorRpsEoJFhWoCryCFhfn?=
 =?us-ascii?Q?cjuOC2JyXNn/DR2/1A9TCSv+yd6gT0hddD2uRWna9ee2K8sWzoDqAFlR1gB3?=
 =?us-ascii?Q?vj8gxEcM8meR83G6kDrHFyi5uiTw+oXlYS7Fbmj+IOM2Q6wBwankzrU6uGu6?=
 =?us-ascii?Q?YnsRaHwV20qM+1Q0ixS1I9bONyCromiym6lzx3B0r2bHVP4KWmlPQzwOFBNL?=
 =?us-ascii?Q?gSTc9Sv/Qp5Uhgt+HP1G8twLBJ3TAj2Ben7ExOmUfeVTBD5tMsjVkLEBgorJ?=
 =?us-ascii?Q?50LYxCC1933sIBwV7YWnFX0JWvsiU3v93KePUpaEh6UgdOGGsEaGmHIkkug4?=
 =?us-ascii?Q?Fp+4ueB4zOH6BlmncNwNmRoZ5A1+7i5hI4rHdHg2//47aScnbDq175N+sCHs?=
 =?us-ascii?Q?1/FF6k1UmCoFe8uDjeqyP1qEuWx0fh2SVtlFYn8CQ8ZmtZvbntPv7ox42FrU?=
 =?us-ascii?Q?9a9NtTrd9em+0LPSrbwWI5E/RCOPv4CnIKZngwWL6AzoKl59GzMrEUdJM9Gl?=
 =?us-ascii?Q?4NcLMwlK3mKbjUoIF47O7WZbXFys+96AKibEjM3sb8pNq4NEWKkghIoCPXOm?=
 =?us-ascii?Q?jOeDvcXYHQ3kNz5GXdrT73zA2prxBRhekp+ih79c78qMCTHvhokFjH6sM0H1?=
 =?us-ascii?Q?qlmPd3mUhJtudmEeu9DHKubivtVEoAAkVEbbXRLIRg7medyMUZyTUSyvOq9r?=
 =?us-ascii?Q?Muq2L06/LCoUcGgVja9WfLX2QMFEKZiSjuh3O3m/M6R6DOrXFmXcsIikrGC8?=
 =?us-ascii?Q?GcEMC+FkOJvx5sq74mlLsquc3jgERhRUHmLkNj56wlbBAtlR2p9x5j76Lpkf?=
 =?us-ascii?Q?faIMUguYK1GETuhpiLxgDbHBxGCwLUUldgrqBtGe3f7THvqB2gx+EWhZpXzL?=
 =?us-ascii?Q?V2QoYU9M7nmzJHNIBUnoGgJ1fgSll5X4j0ME+NpAiJPN/sZoOQp8piwUWDtj?=
 =?us-ascii?Q?OhwdJCz74R+H9GTiLsv4apIz/WeD34Q4SOseLsnKW2/0w6lcp3hiFsRCHkZ0?=
 =?us-ascii?Q?WQq3VI/9Fq94gQ6VYNu0YECxXdbMr09Degdsc3vrJJu6mdtjWd62KpNyWwAD?=
 =?us-ascii?Q?uISAF0eF/bjhBja4qi2TkfeKCyvMrXuxP39LjOCAbPP67eHbJ4Z7EvsZW8p0?=
 =?us-ascii?Q?g7ho3mwFyLvZphX2SC0fZqF9RPrshXwMqfhoWPN6WPpOxDIovU3EksUNug5m?=
 =?us-ascii?Q?KYciJYbZ+0RasAEsk1l4iGxgiQcyKanCfd3nSK4fMH3+XTLQY1rbmzqKw0T5?=
 =?us-ascii?Q?OIH+BXxTrQMSU9GQqphaxmQB/09/8ldcn2MDRmH03XTQVW/9AbB+kR7FNTo9?=
 =?us-ascii?Q?XRSBNuGngmCOKyURMnTNdekVKWMGcoqjY6ktTSJbWwYhSxLlQ4/BN+L9kIvn?=
 =?us-ascii?Q?ZVZZ5kEiNxMKTgVz2aM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a40f4a-1d82-43df-9a96-08da66991c2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 19:35:01.4839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EMGCZ7EVmJBK4jFKQE0GdrFBxbFp4REpISqaBVn7bm0glSE+nYKJChvKmSiIiXQ4cQQy8j7/MV39SgtnobWfhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6286
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
> Sent: Tuesday, July 12, 2022 5:26 AM
> To: Frank Li <frank.li@nxp.com>; tglx@linutronix.de; maz@kernel.org;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> shawnguo@kernel.org; s.hauer@pengutronix.de; kw@linux.com;
> bhelgaas@google.com; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> pci@vger.kernel.org; Peng Fan <peng.fan@nxp.com>; Aisheng Dong
> <aisheng.dong@nxp.com>; jdmason@kudzu.us
> Cc: kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-
> imx@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com;
> ntb@lists.linux.dev
> Subject: [EXT] Re: [PATCH 2/3] dt-bindings: irqchip: imx mu work as msi
> controller
>=20
> Caution: EXT Email
>=20
> On 07/07/2022 23:02, Frank Li wrote:
> > imx mu support generate irq by write a register.
> > provide msi controller support so other driver
> > can use it by standard msi interface.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../interrupt-controller/fsl,mu-msi.yaml      | 94 +++++++++++++++++++
> >  1 file changed, 94 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-
> controller/fsl,mu-msi.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl=
,mu-
> msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-
> msi.yaml
> > new file mode 100644
> > index 0000000000000..b4ac583f60227
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-
> msi.yaml
> > @@ -0,0 +1,94 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
t
> ree.org%2Fschemas%2Finterrupt-controller%2Ffsl%2Cmu-
> msi.yaml%23&amp;data=3D05%7C01%7CFrank.Li%40nxp.com%7C1f7d0921308
> 74d4a52d808da63f0e9db%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> 0%7C637932183637319092%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL
> jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
> 7C%7C&amp;sdata=3DeA4wrkb39C4NFpLcpvMdFfqEBxcikyTOGaBthf61tjI%3D&
> amp;reserved=3D0
> > +$schema:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
t
> ree.org%2Fmeta-
> schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7CFrank.Li%40nxp.com%7
> C1f7d092130874d4a52d808da63f0e9db%7C686ea1d3bc2b4c6fa92cd99c5c30
> 1635%7C0%7C0%7C637932183637319092%7CUnknown%7CTWFpbGZsb3d8e
> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C3000%7C%7C%7C&amp;sdata=3Dke6K1nzmgNXh%2FkyEh6UP%2F0VZ4C17
> GuhnqZTX4WeB4kY%3D&amp;reserved=3D0
> > +
> > +title: NXP i.MX Messaging Unit (MU)
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
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: fsl,imx6sx-mu-msi
> > +      - const: fsl,imx7ulp-mu-msi
> > +      - const: fsl,imx8ulp-mu-msi
> > +      - const: fsl,imx8-mu-msi
> > +      - const: fsl,imx8ulp-mu-msi-s4
>=20
> Use enum
>=20
> > +      - items:
> > +          - const: fsl,imx8ulp-mu-msi
>=20
> Single item... why?
>=20
> > +      - items:
> > +          - enum:
> > +              - fsl,imx7s-mu-msi
> > +              - fsl,imx8mq-mu-msi
> > +              - fsl,imx8mm-mu-msi
> > +              - fsl,imx8mn-mu-msi
> > +              - fsl,imx8mp-mu-msi
> > +              - fsl,imx8qm-mu-msi
>=20
> Why qm is here not compatible with qxp? It's already mentioned in
> section below.
>=20
> > +              - fsl,imx8qxp-mu-msi
> > +          - const: fsl,imx6sx-mu-msi
> > +      - description: MU work as msi controller
> > +        items:
> > +          - enum:
> > +              - fsl,imx8qm-mu-msi
> > +              - fsl,imx8qxp-mu-msi
> > +          - const: fsl,imx6sx-mu-msi
> > +  reg:
> > +    maxItems: 2
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 2
>=20
> Instead describe the items.
>=20
> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    items:
> > +      - const: tx
> > +      - const: rx
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - msi-controller
>=20
> How this end up here?
>=20
> Aren't you missing allOf with a reference to msi-controller?
>=20
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    lsio_mu12: msi@5d270000 {
> > +               compatible =3D "fsl,imx6sx-mu-msi-db";
>=20
> ???
>=20
> > +               msi-controller;
> > +               interrupt-controller;
>=20
> ??? How this appeared here
>=20
> Also fix your indentation like in example-schema.
>=20
> > +               reg =3D <0x5d270000 0x10000>,     /* A side */
> > +                     <0x5d300000 0x10000>;     /* B side */
> > +               reg-names =3D "a", "b";
> > +               interrupts =3D <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
> > +               power-domains =3D <&pd IMX_SC_R_MU_12A>,
> > +                               <&pd IMX_SC_R_MU_12B>;
>=20
> Please do not send untested bindings. It's a waste of our time.
>=20
> Really two items here? You just said only one is allowed.
>=20
> > +               power-domain-names =3D "a", "b";
>=20
> Sorry, this patch looks really poor. a/b is not a descriptive name and

[Frank Li] MU spec said it is A-side and B-side.  So I think "a" "b" is goo=
d
Enough here.  I fixed most problem at v2.=20

PCI EP using MSI as door bell is quite new.  I want check if the overall id=
ea is good
Enough to go further.=20

> they are not allowed by your own bindings. Please perform some internal
> reviews...
>=20
> > +    };
>=20
>=20
> Best regards,
> Krzysztof
