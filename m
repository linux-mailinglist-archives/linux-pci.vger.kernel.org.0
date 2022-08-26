Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8F85A2F80
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 21:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245076AbiHZTAA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 15:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241984AbiHZS74 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 14:59:56 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00055.outbound.protection.outlook.com [40.107.0.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDD11099;
        Fri, 26 Aug 2022 11:59:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tkka5/EgYFkOhrlXNbE0P8H+tPClwRYAq+I20UaaNKI5upfQYdTR93Lx0p8Bzq2pQRLu+MkY0aVxrduS5idJF3zJRLmu+64/dR8SAbgPw5KdoVNVfHptt21n8LVwteuHnlRBVauyJEhQta+g+WuKmM4v9H+bSoEi7A5QDP3SUJYKs00p3x9N0s4guNIg7sExXf0QKcTLIzZYbo6Ndf0ulnOubLT5MwG9KAnMLC/O+6HAym4BiYtWNxjoVqXjw1RkTtKhUKrYgT0b5ufNxOOOO/OealLYp4RoCM5+VttOWrixk6fg2qApJGBfOkTM7C+wr3tB89TXnj8p/Wptu/4CAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMqsfAMW/gdGKZ1/n2zGKtrQsMdiidYK4icSOpVy1s4=;
 b=HthnQomvlY9Wdaz/Ty+aHHK6CkX3PUMfERnLxM1FlbO5Zs+7G+cMrcDId1M4E7v8qbd3d33FA/jKlF1oYVaiCjVMf4V5vPnNP6NtknqAQdGfX2fR8k0qGDkMHzyVarTdtoJM+mAIOEsOrN4wZuO3uKtEV0a8DA6m5Z3VmEKOao9YbBkbyzqmkJ/oKgpb5ZREUeRoyDgS5Z2C3cPGRuEcdKhbFKs0v5+Manz3Oq7ooVw62Oo7Z6wGqXIRIIM3kxzEr9iCVCfwvSaXnHtOrOoaqn0RF0f8XruW1hf/+qe/AbviQ8nvRFh3WuNMNokwo9uB5gP0yZTaXBuwRIpxzosqrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMqsfAMW/gdGKZ1/n2zGKtrQsMdiidYK4icSOpVy1s4=;
 b=durWO7v7UWxC4hGx3gYo4DVrcCFjYM/BuiXQC0o8TGb9OshvpYI3gngMhkH0uVMRK3L6Dc2F6jGMlnlz0zwDjTkDPyL3v2adztdwV0ycYRoovIPFRp4Fq0XncXOt+UVkXP0tYRwgVb6p/ZIvN2IMA8XvDJKBgsVvSVkK9IxDjDE=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB4868.eurprd04.prod.outlook.com (2603:10a6:208:c7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Fri, 26 Aug
 2022 18:59:44 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::85cb:614b:9f52:2dba]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::85cb:614b:9f52:2dba%4]) with mapi id 15.20.5566.019; Fri, 26 Aug 2022
 18:59:44 +0000
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
Thread-Index: AQHYtj8hCDDK+8gqVE2zOgMsKNOQwK3AJMoAgAAECGCAAV/WAIAAANrA
Date:   Fri, 26 Aug 2022 18:59:44 +0000
Message-ID: <PAXPR04MB918607281F6389092924EE6488759@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220822155130.2491006-1-Frank.Li@nxp.com>
        <20220822155130.2491006-4-Frank.Li@nxp.com>
        <20220825212130.GA1705214-robh@kernel.org>
        <PAXPR04MB9186201A03037BA7DC74D52B88729@PAXPR04MB9186.eurprd04.prod.outlook.com>
 <871qt2x38f.wl-maz@kernel.org>
In-Reply-To: <871qt2x38f.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: robh@kernel.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cfdac46-a7c5-4e21-b8ff-08da879523c0
x-ms-traffictypediagnostic: AM0PR04MB4868:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZZ7Ypl4BuogajSJbuCpCA8b5tCIbtc5z2XXWICB2nNf15SENLky2tmlrHB6XcsHu+zYyFEbctdOo0FlNTSoPBmS/BHdF6ByznV6n27akX9pTD7B7/jKkVnLWyo5DimXkh1oy4RJr7XNdw8wJzSR+xCijDR0e0Lwx/uFZ7OBSFIlnSjDAib2n7nMwlK3fU3ZZZictuszhEkyfh1gljtq4oiJ0Klv/ndRwzMLYZ7zqhpUVRRKOAe+hzQLFStPrTClcWnA3Cv+PbRbN5G4YTkONJ97xCgsLfpO25XKxZWGYTVmH8hvGicAWs/akdUjBx8FPg2ftx/N5KBvS7SkO0RsfntETK3hTkmttGaq9IyDyvCzUN7g16KNtt7cWgoQCfpe9SzEa6KR6OP7RFIWyUsFJWZtz6rvEbcOdZ+3yTr52kkaLRf3PHXt1f1wylfqKiM1W02gsMgygJL/Z3jPYkGS2Kj77Yp4TH4EpUJBPMiZ2sLTJbnb4RO6dwcjTAvIyJQ2jgrXxxRxI8nhJ9nQSYT7WHIz360KdIlDMza9gwHJ8Qtn8VVokkZz0vrWEjuXn3qVY/oULUD7Q0gqPdxpMrjeBHY2f8Vj3qolu4HGaXKc9hGMxfp7GXvhTZBm4FSzjtK6ok9NE5CI16LyUlGOq6Dg0GMdaTMIlFXNV4J4fzRT8wx805TuLwrODnPUnT/HHWwWxYxcs+TGFe+O5ZLWce5oH9IG1fwqtEAFO/VySBmxvH8LIqbAi0fvWsiGBie10MkQJCeD9E9jIrNPj6nH9ZCUg2Vn4Zpgcqt9LFUNKSLSEvqA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(186003)(83380400001)(7696005)(6506007)(26005)(38070700005)(52536014)(8936002)(9686003)(45080400002)(2906002)(55236004)(53546011)(54906003)(44832011)(110136005)(41300700001)(33656002)(4326008)(122000001)(7416002)(71200400001)(55016003)(38100700002)(478600001)(76116006)(316002)(66946007)(86362001)(66556008)(66476007)(5660300002)(966005)(8676002)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rk+7ePuE1h3KTlZUNLm1b1Uk4iTDGttzOck3Qt9XAbLdMOIZPB0ATjy278Bu?=
 =?us-ascii?Q?I83dZ0yYA3jC80vAMTBPE+fIuFuFpVQxPoAdYUyQ96OdS2EFlCG8VtMB2QJ7?=
 =?us-ascii?Q?p7vBmUhl8uzd0NlohVoK5tzOwzQO6cwF8xPf6b8CEbtzkltbj8NmGBMDxBK4?=
 =?us-ascii?Q?wRMzfPO/91LWNR8FE3qZhla2hyzCE4x3nEmZleR3XIXWZEvy1ah1URytcDRS?=
 =?us-ascii?Q?FIy/AkXogSPRZ7BRBfEYoitoJMvJqlCiscXudI//M7x91aacgXfHczRmb+O2?=
 =?us-ascii?Q?S0kJA6mpNUgikf6Y4dafo7AgGV4Sy3+UuxnTDty0kn6EsOGxSxFueBiF+JyN?=
 =?us-ascii?Q?D2ZSZlM1g3b4F5KQZqXZ0aNzlvAMDFu2B/bCPbfFCYw2+gpcN2okvAcAjoUO?=
 =?us-ascii?Q?7vBs71GOhfI1d9JV7IPXc44F4FIgL9ZHEfnY6zMq7TrOH51mxWr4WIKQNHoP?=
 =?us-ascii?Q?X7gnMdNRktlF0cidaKb7/SemTooEWu2ZUWCEBCdRtXMl/nMSNU+erj1FNenc?=
 =?us-ascii?Q?nxCtdSvIlaojLtlrtrmvzdjmTyBjMtUhJT+qNYMH+zs5R1htAr7ix4NnzqL3?=
 =?us-ascii?Q?U9FRmf7dK4n4p+SnkZWxAGmVnhT8drekLerwBST/r4iv4eCs+XDeD0ONDtY7?=
 =?us-ascii?Q?DJedjJZJdU7MdWdGEOZIqLZqU2o6LJRpiS7/ySQE7uCxvtruXWt020nJ4xhz?=
 =?us-ascii?Q?I+ynzGvsEEnQoAbDi+XucBQ69KWiWdK8zHApfwPNn/ePFBysh+z9hoGQSweI?=
 =?us-ascii?Q?mwRk5YDTw/zsR3SvLhCAzJ/y3tkYnuayhR/MxLrYipOt28MjDGSG8Wbx5mYX?=
 =?us-ascii?Q?vWC0a2KT+XbuZEAmkTe7EKIhJvChV1syhi3ApznAsojkvKFzVkZ53BnG5gDj?=
 =?us-ascii?Q?aMZvVOs9ceLH8haeMNTha+GbHwZwh7Vwn5gkDgLcIy1gUP2jjN8dj00XUs4Q?=
 =?us-ascii?Q?stKymYXnJm0EAPGABsh+q0Aj4dIVqSJ8+ubtEIGgVbQSCmkj8pilN4Iw4Zby?=
 =?us-ascii?Q?DPe2618BvxXfZ597ZLI0O8AtRJuYdlQsobtCzslzR5OLp6sAheuuIajS8KAV?=
 =?us-ascii?Q?lpmHqKLfumPohS3103bvu4EZZuxv4EzKbY3ziEnnfu5YY23sXUtxnCxau2iq?=
 =?us-ascii?Q?7HE6FCXmKPHpYG392bzT5Xa6Qr5DX2NSH7AtEBwMorYqOV+gtPc0i6BTW/AM?=
 =?us-ascii?Q?VwfQGiBzaveUlYzUx/6/b/cExcSQ4P8jAft54t0q+UsGRMcvgCIiOtrrb6Ku?=
 =?us-ascii?Q?f/98plY82dBaxa6kKh+qe2fyGGnUG95jv9kH6mY1/DNXCH/qQAoyRRqq/p21?=
 =?us-ascii?Q?I2oOeJoxa6gugyL6cY9/S+DHDviqqf3LjDaFH6LCVoUyVc9fLuq2fqkli5kr?=
 =?us-ascii?Q?foTjNRn367ZVmEK+sgzfPd/M/P7K6KIKHgSYmiemDMNYHKN6WgdpKm8Ji7+o?=
 =?us-ascii?Q?MVrrxpwXu549+dXR2mtzYWvXTbil4CiVlOlwIanF7CppxYKfjYtJFdOmFr1I?=
 =?us-ascii?Q?tBeP023K6mBeDnvClwCY/j+5VWu8bviLu/5TK9FJ+9p9n0CqCHA7MnoWywx8?=
 =?us-ascii?Q?Rb6+ZQXEk7riw7TVzCY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfdac46-a7c5-4e21-b8ff-08da879523c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 18:59:44.5899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70EQ2zuZKZXKVPck3m7Hnj1o9o2Tx/ztoA7+CkeDgkoSbD96eFIXpFtM0YP4iRlnK/uKxAYer5Ooh5Bz/Owt3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4868
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
> Sent: Friday, August 26, 2022 1:35 PM
> To: Frank Li <frank.li@nxp.com>
> Cc: Rob Herring <robh@kernel.org>; tglx@linutronix.de;
> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kw@linux.com; bhelgaas@google.com; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-pci@vger.kernel.org; Peng Fan
> <peng.fan@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> jdmason@kudzu.us; kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
> <linux-imx@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com;
> ntb@lists.linux.dev; lznuaa@gmail.com
> Subject: Re: [EXT] Re: [PATCH v7 3/4] dt-bindings: irqchip: imx mu work a=
s msi
> controller
>=20
> Caution: EXT Email
>=20
> On Thu, 25 Aug 2022 22:42:38 +0100,
> Frank Li <frank.li@nxp.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Rob Herring <robh@kernel.org>
> > > Sent: Thursday, August 25, 2022 4:22 PM
> > > To: Frank Li <frank.li@nxp.com>
> > > Cc: maz@kernel.org; tglx@linutronix.de; krzysztof.kozlowski+dt@linaro=
.org;
> > > shawnguo@kernel.org; s.hauer@pengutronix.de; kw@linux.com;
> > > bhelgaas@google.com; linux-kernel@vger.kernel.org;
> > > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; lin=
ux-
> > > pci@vger.kernel.org; Peng Fan <peng.fan@nxp.com>; Aisheng Dong
> > > <aisheng.dong@nxp.com>; jdmason@kudzu.us; kernel@pengutronix.de;
> > > festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>; kishon@ti.com;
> > > lorenzo.pieralisi@arm.com; ntb@lists.linux.dev; lznuaa@gmail.com
> > > Subject: [EXT] Re: [PATCH v7 3/4] dt-bindings: irqchip: imx mu work a=
s msi
> > > controller
> > >
> > > Caution: EXT Email
> > >
> > > On Mon, Aug 22, 2022 at 10:51:29AM -0500, Frank Li wrote:
> > > > I.MX mu support generate irq by write a register. Provide msi contr=
oller
> > > > support so other driver such as PCI EP can use it by standard msi
> > > > interface as doorbell.
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  .../interrupt-controller/fsl,mu-msi.yaml      | 98 +++++++++++++++=
++++
> > > >  1 file changed, 98 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/interrupt-
> > > controller/fsl,mu-msi.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/interrupt-
> controller/fsl,mu-
> > > msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl=
,mu-
> > > msi.yaml
> > > > new file mode 100644
> > > > index 0000000000000..ac07b138e24c0
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu=
-
> > > msi.yaml
> > > > @@ -0,0 +1,98 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id:
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
t
> > > ree.org%2Fschemas%2Finterrupt-controller%2Ffsl%2Cmu-
> > > msi.yaml%23&amp;data=3D05%7C01%7CFrank.Li%40nxp.com%7Cbff8f186128d
> > > 44209f4108da86dfc975%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> > > %7C637970592959950791%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> > > AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
> > > 7C%7C&amp;sdata=3DDHCOhmaJAhwb8Gl%2FEbPj32B6lR2zcIvyMY%2BTuPACb
> > > zI%3D&amp;reserved=3D0
> > > > +$schema:
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
t
> > > ree.org%2Fmeta-
> > > schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7CFrank.Li%40nxp.com%7
> > > Cbff8f186128d44209f4108da86dfc975%7C686ea1d3bc2b4c6fa92cd99c5c3016
> > > 35%7C0%7C0%7C637970592959950791%7CUnknown%7CTWFpbGZsb3d8eyJ
> > > WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> > > 7C3000%7C%7C%7C&amp;sdata=3DJ4znEXyHnMyQOssSUsoxE2Mlhe2qCDC%2F
> > > 9WN6SKv69aM%3D&amp;reserved=3D0
> > > > +
> > > > +title: Freescale/NXP i.MX Messaging Unit (MU) work as msi controll=
er
> > > > +
> > > > +maintainers:
> > > > +  - Frank Li <Frank.Li@nxp.com>
> > > > +
> > > > +description: |
> > > > +  The Messaging Unit module enables two processors within the SoC =
to
> > > > +  communicate and coordinate by passing messages (e.g. data, statu=
s
> > > > +  and control) through the MU interface. The MU also provides the =
ability
> > > > +  for one processor (A side) to signal the other processor (B side=
) using
> > > > +  interrupts.
> > > > +
> > > > +  Because the MU manages the messaging between processors, the MU
> > > uses
> > > > +  different clocks (from each side of the different peripheral bus=
es).
> > > > +  Therefore, the MU must synchronize the accesses from one side to=
 the
> > > > +  other. The MU accomplishes synchronization using two sets of mat=
ching
> > > > +  registers (Processor A-facing, Processor B-facing).
> > > > +
> > > > +  MU can work as msi interrupt controller to do doorbell
> > > > +
> > > > +allOf:
> > > > +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - fsl,imx6sx-mu-msi
> > > > +      - fsl,imx7ulp-mu-msi
> > > > +      - fsl,imx8ulp-mu-msi
> > > > +      - fsl,imx8ulp-mu-msi-s4
> > > > +
> > > > +  reg:
> > > > +    items:
> > > > +      - description: a side register base address
> > > > +      - description: b side register base address
> > > > +
> > > > +  reg-names:
> > > > +    items:
> > > > +      - const: processor a-facing
> > > > +      - const: processor b-facing
> > >
> > > Isn't 'a' and 'b' sufficient to distinguish? Personally, doesn't real=
ly
> > > look like a case that benefits from -names at all.
> > >
> > > In any case, -names shouldn't have spaces.
> >
> > I like "a" and "b".
> >
> > But Marc Zyngier suggested use above name.
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.s=
pi
> nics.net%2Flists%2Flinux-
> pci%2Fmsg128783.html&amp;data=3D05%7C01%7Cfrank.li%40nxp.com%7Cadd154d
> 4aeda4059c93408da8791ba1b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C637971357205475355%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&a
> mp;sdata=3DvuaoWvu8BYcJ5NjOoUfFhlykBsW8vC2%2FbsrBmfx%2Bfz8%3D&amp;r
> eserved=3D0
> >
> > @Marc Zyngier
>=20
> And I stand by my initial request. "a" doesn't convey any sort of
> useful information. Why not "I" and "II", while we're at it? Or
> something even funkier?

MU spec use term "a" and "b",  user have to map "I" an "II" to=20
"a" and "b" when read MU spec and code. it is not straightforward.

I quote a part of spec.=20
" The MU is connected as a peripheral under the Peripheral bus on both side=
s-on
the Processor A-side, the Processor A Peripheral Bus, and on the Processor =
B side,
the Processor B Peripheral Bus."

Rob Herring and Marc Zynginer:
I can change to any name, which you agree both.=20

Some options:
1. "a", "b"
2. "a-side", "b-side"
3. "a-facing", "b-facing"
4. "I", "II"

>=20
>         M.
>=20
> --
> Without deviation from the norm, progress is not possible.
