Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C32E5A1B56
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 23:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbiHYVmo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 17:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiHYVmn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 17:42:43 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60057.outbound.protection.outlook.com [40.107.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F0AC3F;
        Thu, 25 Aug 2022 14:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Krq77M5Sw1wDb1/2AZdKOaOoWTVzYOTf2Ib+f5UFr3gWzVGsj035cpH424lJG6I1vYJHeiH3iY5dI8Y0PyyG+BQ+Ckr5mKUQ/a392X/ypzRINYlDehr1TACLbTlcyaCCFNt6tixyVFdm4k9gJAwf9vorWmaP0JTRW2eQUtT3dFELgpjNQ6XWIURTK3po0bkr2MN0jDagKgMny4e7EqOgmzIiL7ihtAROA6lAvYccDEQmVwtqD2iuR93mSuLKfjQ3WlrOnCpNrlzxNyyOQLBNrzsN7nhqKdXyfgfztyWbDwOLE/5NpxOclfk2GZRjSny4kdZ+v1U+VuDphVXM/AdbJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAIdBKxY9Ma/vYVHjow9PCyhhxuc90zfP4QAGyNS/5w=;
 b=NTP2ZR21+QeANhAYjGG3vVeYXxJ0GklWugp4260flCinbX0fkkB6MwGqcM7+Wbt35KOLYxmGccuOAsQ1UKJs2gHGicbvf1bjTVY2Vn2UxUWEFYhBtYA6mX29zq0dG0MgfF+WEZ/Z5Vry/5XdRF7+H8sA3neW8nMdpdiM0Q31bZy475iu6zIOEgd/SINeYl0hcfQza6Q61ONE6TRRQWd1Ls833D3DLY+u8k3n63a6XWJ7DJ/tDEyuge6k0TJj5XLsFpTBaU1iQhyVnkRakS9qBt/as9veJyBa10QGfWbhdeJLPj18dqTx7TuAFyOKIRurocLrbNW/47zRizXarYDyHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAIdBKxY9Ma/vYVHjow9PCyhhxuc90zfP4QAGyNS/5w=;
 b=M1cL+SZam4z9lIV94uK5IJPgfzCVxF0sqoOPEXXR61Gw0od9QYzIssN1nO2ezvXVaFlEpvPmSH3ir9Np6mODMG00L572a76GRD3rNObX/IEOcGVxkLLW8WeF5i51qJR0/LpFsFcocK+bVSdISV/1PVBgKqnZhx7bHVkCTGUsFdY=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by PA4PR04MB9221.eurprd04.prod.outlook.com (2603:10a6:102:2a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 21:42:38 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::85cb:614b:9f52:2dba]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::85cb:614b:9f52:2dba%6]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 21:42:38 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "maz@kernel.org" <maz@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
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
Thread-Index: AQHYtj8hCDDK+8gqVE2zOgMsKNOQwK3AJMoAgAAECGA=
Date:   Thu, 25 Aug 2022 21:42:38 +0000
Message-ID: <PAXPR04MB9186201A03037BA7DC74D52B88729@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220822155130.2491006-1-Frank.Li@nxp.com>
 <20220822155130.2491006-4-Frank.Li@nxp.com>
 <20220825212130.GA1705214-robh@kernel.org>
In-Reply-To: <20220825212130.GA1705214-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fdc53d8-e26a-4869-d3d0-08da86e2bb08
x-ms-traffictypediagnostic: PA4PR04MB9221:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hcDkaSR7ZnpP1B6ehi3ESdId5Pd4OGSYBMSKVLHzXD3Ec4kkfsjw/rdNJ+sIz+QroAGiiroDBr17nb6rdpXdt7yYQuUelfdeLcdq2SfBtEnm0IQ2M1SzxJ+x0/kMWoQr3yH5LZbAdW6XF9flL+olDyi9e7mM+skvdaBXO7RLC2TFJIlm93bPqRqEDYGEyZgw7vyuvdFiiF4+Ez0WzZ0QJbTNF2l6UQSjqFUtA2H7DJN48Vq9U4I1d0cUPjCINbr5UvheWZoCFnNcsLSIBfsM1wTcCtDPtcPtkVYII37u0lNMKxps8yloOOiJf1gZ+Q+6veA80w26b5zdnHWx/mHdY9oGoC9vaVD+7kDaTaFwmx3K+9YomibKTLuWd1jcnnTY8vzutDeAQIkRyQDxSCr0bEwgGjcJ+kJ49jyCDJWiprsEtp0tupObwM20vBeeLTeAD1AY7vXsNomfK1zed6sLwRe/8NBbJ0C/PkNEPGnlVRWxYAkdpe5MWxU8IcmTi2Ev0tt/YW807JN8SYybYo0+lN+uRWHcqe5VJQqxrUMgr5zFxFTbUXO54/m+xdZw0Z8K5D+aPPrz+h3d49UmGSo6SzVV/ov6YFjG0S2nyEXN4gaiwDbQgp0ScYHW/ItIv2oVBZGVFou1oPNEXdm/+bntzEU/fxJImCYUUWG5EUqsEhAxkYiwx3eHOiqGp7+Go81kDmqAOq2z43AnWJXnQb527co1jhcUK9HeiwxyJGZIebLoej8THoW59sui+OvOw6/0Jd8vrJe/ydcGFceej0o4u3LExxX7R6rlsAmXsDHcwJg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(4326008)(53546011)(52536014)(86362001)(66946007)(9686003)(66556008)(55236004)(66446008)(76116006)(66476007)(7416002)(26005)(5660300002)(33656002)(38100700002)(478600001)(64756008)(7696005)(6506007)(55016003)(44832011)(8936002)(966005)(2906002)(8676002)(41300700001)(45080400002)(122000001)(186003)(6916009)(71200400001)(83380400001)(38070700005)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n8CAXA3tmRCZWI2mM59vyDtFwI6JZ4E6E70r1KdqmfZ7BFDZMLINFBzsjv1Z?=
 =?us-ascii?Q?2KAp0grqtlD75PespqChUvGNKth/fYetz3q98OSWeZhuKKUvWglbQjT1nrTu?=
 =?us-ascii?Q?e4M2xNFeQWtZDB+5zY1kORjUEeIxrCzIcxEMKGiagCeRztDSlWxdOIUmCd3b?=
 =?us-ascii?Q?83Lu84AOwoVXNu4fjFJoGryhFf6tp5h/zTmUoCV0qsRXqO1piSIAVRohcUAc?=
 =?us-ascii?Q?UfTI6ERMu8SkT1lcD+Mkc4sZDQ5lGWpRSQYfiWSmPlEF+/F3gxI8Ht/y1Hk5?=
 =?us-ascii?Q?nW0iYbWqxj64o+K10UORq90Jrf7VgLxTV+xIAJwFHt8Y6+ERtibUivJuU8/B?=
 =?us-ascii?Q?uDQPUQsDQece3FkK/r7eQsJBE+w+V9dJRwiWO11GDZ7lFTBUq8aqXz6++iR8?=
 =?us-ascii?Q?TTgDZoEhOsLv4qDJvmPjGd1aZJ/Zp7qH6UNEi+ZGO7snbYDsvKgpVdrngrwU?=
 =?us-ascii?Q?z2WtjNHR0mUap/h0OrmRoIyG1MitYXzFbTGGhoqU+CVXWlm3M3mVnEINDzbe?=
 =?us-ascii?Q?4oEAbVdQq2yoLxx+udKE0JA/Gbub99ZTFCwPWCDWp3MvjLbZuvPJ7Pk6tyg4?=
 =?us-ascii?Q?VrcD1eV2pCzbRvFfK5Z46MSZX44TqRaA+6z6C9J/09092VgdYD/WLyPTgaZe?=
 =?us-ascii?Q?tMMufC6176JFT1HLbL3P2Ms3csrCfzHZPQbfycVTT+X/ZjNY68H6glxcI67q?=
 =?us-ascii?Q?y3Vc3xTfWK2B1C2N8CITuySz34Gi12YITm1188HUHxT/O1cc4VpuaVbc8t8O?=
 =?us-ascii?Q?jORYVDOekpB4YiWTTLvb/W68FyhDj+fLL/GJFGlK/LSGaK1iA4XOsSIqB2cK?=
 =?us-ascii?Q?NIGTJ6KMc89prNNH30wOyyQr5yxDg1GLuklNEwI00Lm7Xdg772lgtqDZ+og7?=
 =?us-ascii?Q?IzlhLwCmH9nZzTacA5amW+FytzmrDUTr5pNZhy+IQtVteK40t0Luem45qqGP?=
 =?us-ascii?Q?urIbzkKDLG/6bxCzKY6W2j8AedDIOMIvTZFwcdLwcKBnavHSpdtYzbwEI1DO?=
 =?us-ascii?Q?AIVt1EJLCH6+BZHVOJVotV8Gpfyu6oKcP2T3q1W9ua2ZUEr4cgf0xb0Wu757?=
 =?us-ascii?Q?rUGbp3kWjKEXUCjqZs2/YhCT6X8z/EuGB2ase1OHy+uwPJjwzJUMTOlXRyan?=
 =?us-ascii?Q?40Kb/DvpUkei62WcPZUCrKBR6eCMpS4OnqRljv+6dsadANCGu8iK+MM3QzUy?=
 =?us-ascii?Q?SSLFFJ0pgja1+4PBRfQ4SegiugYFDhwHDWRPOr2YPWoHZoWIjDpU26d0Uz76?=
 =?us-ascii?Q?zwM3YPEcOm4TMNGI0IRZ/6Zctg50wWnYasYdsPApF8Vna/ZoD63dH5lrpx0d?=
 =?us-ascii?Q?r2ETWqZBbkIEAXjfQvPHkMrruaeszfjLn2t7csPd/v9/486h9J2Qau0gjxZM?=
 =?us-ascii?Q?+xStwxZV4K7F8wAC29wTleQwXZ2sRvgHrWrfO+tgpvCqUkGHvP0NtSySVAl/?=
 =?us-ascii?Q?b4PPsXP8d2wnUy9EgrijDQFtyT0fPYs31lMPT4pdXiTh4pKke35hPqF1HUod?=
 =?us-ascii?Q?PMim4UQpw6sWmW0yWtoSqYQkC0OwY0LlXMXIo1kLnF84xh0IyNkuYTXwt9QO?=
 =?us-ascii?Q?prWi+Cfrv2I83JFRmI0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fdc53d8-e26a-4869-d3d0-08da86e2bb08
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 21:42:38.4682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7wvW9TaC9EM7GrxBFefviUF5JCCdfvYKYfWu/SDvjSLy5PkZAxRWfdY0YQ0VZHvSfipwHSYuNJu/eq04IPXcQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9221
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Thursday, August 25, 2022 4:22 PM
> To: Frank Li <frank.li@nxp.com>
> Cc: maz@kernel.org; tglx@linutronix.de; krzysztof.kozlowski+dt@linaro.org=
;
> shawnguo@kernel.org; s.hauer@pengutronix.de; kw@linux.com;
> bhelgaas@google.com; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> pci@vger.kernel.org; Peng Fan <peng.fan@nxp.com>; Aisheng Dong
> <aisheng.dong@nxp.com>; jdmason@kudzu.us; kernel@pengutronix.de;
> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>; kishon@ti.com;
> lorenzo.pieralisi@arm.com; ntb@lists.linux.dev; lznuaa@gmail.com
> Subject: [EXT] Re: [PATCH v7 3/4] dt-bindings: irqchip: imx mu work as ms=
i
> controller
>=20
> Caution: EXT Email
>=20
> On Mon, Aug 22, 2022 at 10:51:29AM -0500, Frank Li wrote:
> > I.MX mu support generate irq by write a register. Provide msi controlle=
r
> > support so other driver such as PCI EP can use it by standard msi
> > interface as doorbell.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../interrupt-controller/fsl,mu-msi.yaml      | 98 +++++++++++++++++++
> >  1 file changed, 98 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-
> controller/fsl,mu-msi.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl=
,mu-
> msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-
> msi.yaml
> > new file mode 100644
> > index 0000000000000..ac07b138e24c0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-
> msi.yaml
> > @@ -0,0 +1,98 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
t
> ree.org%2Fschemas%2Finterrupt-controller%2Ffsl%2Cmu-
> msi.yaml%23&amp;data=3D05%7C01%7CFrank.Li%40nxp.com%7Cbff8f186128d
> 44209f4108da86dfc975%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C637970592959950791%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
> 7C%7C&amp;sdata=3DDHCOhmaJAhwb8Gl%2FEbPj32B6lR2zcIvyMY%2BTuPACb
> zI%3D&amp;reserved=3D0
> > +$schema:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
t
> ree.org%2Fmeta-
> schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7CFrank.Li%40nxp.com%7
> Cbff8f186128d44209f4108da86dfc975%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C637970592959950791%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C3000%7C%7C%7C&amp;sdata=3DJ4znEXyHnMyQOssSUsoxE2Mlhe2qCDC%2F
> 9WN6SKv69aM%3D&amp;reserved=3D0
> > +
> > +title: Freescale/NXP i.MX Messaging Unit (MU) work as msi controller
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +description: |
> > +  The Messaging Unit module enables two processors within the SoC to
> > +  communicate and coordinate by passing messages (e.g. data, status
> > +  and control) through the MU interface. The MU also provides the abil=
ity
> > +  for one processor (A side) to signal the other processor (B side) us=
ing
> > +  interrupts.
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
> > +    items:
> > +      - description: a side register base address
> > +      - description: b side register base address
> > +
> > +  reg-names:
> > +    items:
> > +      - const: processor a-facing
> > +      - const: processor b-facing
>=20
> Isn't 'a' and 'b' sufficient to distinguish? Personally, doesn't really
> look like a case that benefits from -names at all.
>=20
> In any case, -names shouldn't have spaces.

I like "a" and "b".

But Marc Zyngier suggested use above name.
https://www.spinics.net/lists/linux-pci/msg128783.html

@Marc Zyngier

best regards
Frank Li

>=20
> > +
> > +  interrupts:
> > +    description: a side interrupt number.
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    items:
> > +      - description: a side power domain
> > +      - description: b side power domain
> > +
> > +  power-domain-names:
> > +    items:
> > +      - const: processor a-facing
> > +      - const: processor b-facing
>=20
> Same here.
>=20
> > +
> > +  interrupt-controller: true
> > +
> > +  msi-controller: true
> > +
> > +  "#msi-cells":
> > +    const: 0
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-controller
> > +  - msi-controller
>=20
> #msi-cells should be required.
>=20
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/firmware/imx/rsrc.h>
> > +
> > +    msi-controller@5d270000 {
> > +        compatible =3D "fsl,imx6sx-mu-msi";
> > +        msi-controller;
> > +        #msi-cells =3D <0>;
> > +        interrupt-controller;
> > +        reg =3D <0x5d270000 0x10000>,     /* A side */
> > +              <0x5d300000 0x10000>;     /* B side */
> > +        reg-names =3D "processor a-facing", "processor b-facing";
> > +        interrupts =3D <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
> > +        power-domains =3D <&pd IMX_SC_R_MU_12A>,
> > +                        <&pd IMX_SC_R_MU_12B>;
> > +        power-domain-names =3D "processor a-facing", "processor b-faci=
ng";
> > +    };
> > --
> > 2.35.1
> >
> >
