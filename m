Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE960465DF9
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 06:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355572AbhLBFrE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 00:47:04 -0500
Received: from mail-db8eur05on2082.outbound.protection.outlook.com ([40.107.20.82]:29345
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1355337AbhLBFrE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Dec 2021 00:47:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4uMiGWQkN+p0HFCBG/1Ss8TSFAs+cLtzu6Cy7dqtK8UbJ5VIt96vdiSmvjyaWr9AQgNo3HDxgZVDgTZpJ+Ci+WoBqLghdA0Wvy6XtQFwgpE2AGCwIVATs+J+W3n00e6My2cpQKFWNhybdod1wTTVrOwtQUWWdIQF6YYPOTE6AKfEzdCAIX7adEm5BE4n/iZDWcc2vkNn555s624o4g9UnwwgFfR9/DTjuZZLk5s9w2BjYsmZKBZMoGLLVQQD7vPBKG98qcXfzUbfLpSQeZHYtAk9pJmivv4P0daYzH2Ehx+5W1Z6h1qpgK8XHspGhpdZtYqxMRL0HvPTMVqAdwpYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oYW37Oro+ExPnTgsTavjehIMt8p2u+XxWoBDS+o6xc=;
 b=JffkbC+GZ2ojnXRCcCRihzeU3iHMPAx+0NE2ZsajTlpwkUemL6lAVeyGN7h8A1L/yD2lkgT8eJ+VsNPg+9iv4FwTEjSJOQ5vdomeVA4OriLgTAyBDEONntXiPInULknwWk6lbed/fZfCT8wQb9FPqL+nekAlQFgerZ4tYoyy7u2fW1uiphBU5JXsu75PeZNx0WZb3xT9QZ1xSRXznS6k55hkiX5q+JtxKTkA/wPTdVlR6fnqghyAgDzeQCHoCryA0vnetRyqsAIGhPTEEBnaP1aBX/d4+iMnmQLaoXo5/CsaYXJkAJTyd9F1kWj1ZiQYwmVJjtwJxWOBAazbIzeWsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oYW37Oro+ExPnTgsTavjehIMt8p2u+XxWoBDS+o6xc=;
 b=oNE8Bllap4Iya6v7ijG48AYzYny+R9ofpgUWP0Pas9v/BdMggHwbohPqs2uziE/k0/D7YX1mm4NIvr03uduVd2HdZsjT3R0nOLPRbc9FsZHRJ9TMbSE+We/ESdESdPXfkXC4Koz6Ktnbf8+ZwoXj3WazAaeRv5iWqYtmKW1rEMI=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB9144.eurprd04.prod.outlook.com (2603:10a6:20b:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 2 Dec
 2021 05:43:34 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%5]) with mapi id 15.20.4734.028; Thu, 2 Dec 2021
 05:43:34 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v6 0/8] Add the imx8m pcie phy driver and imx8mm pcie
 support
Thread-Topic: [PATCH v6 0/8] Add the imx8m pcie phy driver and imx8mm pcie
 support
Thread-Index: AQHX3CMFKmekc+YLiESKUzSHx70p1awdqgqAgAEThyA=
Date:   Thu, 2 Dec 2021 05:43:33 +0000
Message-ID: <AS8PR04MB8676FE0B835E52FDD40816138C699@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1637200489-11855-1-git-send-email-hongxing.zhu@nxp.com>
 <20211201124419.GA13080@lpieralisi>
In-Reply-To: <20211201124419.GA13080@lpieralisi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7c81ea0-e05c-497d-e802-08d9b556ae07
x-ms-traffictypediagnostic: AS8PR04MB9144:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AS8PR04MB9144A31CF218EDE2DC8C8AD78C699@AS8PR04MB9144.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XG6sl8q41aTY5jHzKarjwrFxlWj2CJoS7vRmiQo/NW2uWs2/6rDNg/DZ6yo7yl3ccxSriE3AT1mo0vd0+/lE5NqPYJgi7T41T1qOLesNN1ZDlcRiHTcqBukP35T510NPJnouZQwRH6OURO/dKGnCLsg4vL5xMPOwFYzxBilgaPqBPO36Hfri5FrI3j+Fa+fhbnHBxk+awnrwhMUtWKk9NFdK+lymEBaXOtrIY4iMWe0tBHBYcRAXMwanLsxmRUuboFkrryEiqWQQZJ9TtgWAMMyRcS8ufi5R25huGB3oVb7lOJsKLhHQVV8FTwWeYXMu7Zh8SZlxerpw+ZqR/TyW2eLUdYUIlOKW3WrJ1/x2ShYupn1xMoodjvvU6cOJ4h5BFoxfuHxADkpgQfJdlaqKy+sfCsgPiip3iIL6s6y4J2HQf6dg+qGI10VVaMqHyBEJpTBwdW3atn2+MuVOKDk6UfDP84jCPFHdSNwxpPjNlzuEEVU8zmgDvj9gSmiX/Qxf+4U7fGrhGhfEPa3yL0jkbFjnw3e5OSfTUwxv3N8sMzQrq5zW3YmE31zR1v8yKFQrSKKQXX2f6M8y6SwBQAgybuJIpk8nJ1daWgNuEokX06EwInhyUWemC+HMH+FRayIJ70tOqnX5RaFWWUPt9a0/TtiuMEMpaqRKWa183YYagnskv8Wm7TEhwyr6nrbI/wRo0x9JNS9yQhy5iobAa69p2ZESkCl2bY3Jcxf/NjgTE4o56h4X5UygfeiA0GSOqjOAc6z3LT1m0iie3h3v10NMmo8Ygs0ZCLQTbfabfMtzPoCw0JZIbyfLps/3GSTj0MIE0TN0mnRP82LDVZGQikC4vhWGgOSx87MKcCOJkmzDTlE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(5660300002)(8676002)(316002)(966005)(8936002)(186003)(52536014)(7696005)(6916009)(26005)(9686003)(44832011)(38100700002)(53546011)(6506007)(66946007)(45080400002)(508600001)(122000001)(71200400001)(66476007)(76116006)(33656002)(2906002)(54906003)(64756008)(55016003)(83380400001)(4326008)(38070700005)(66446008)(66556008)(86362001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T6jlymJbmRfLTL+j4ESzvsHnVtIXWEyU87LUZBdtNc4/wJfz99nDAfGcgvEv?=
 =?us-ascii?Q?tPWsaflyjHYw4isnuL1uOMwPdMkRmSGF6qqUuUBW6AmysDu0fdppU9SgghSU?=
 =?us-ascii?Q?Ufou4vzvYDTB0jSmRnUCCPfGQpJY2+KbvgHh9PVTWMh03jX7PzV4RwGO3ltg?=
 =?us-ascii?Q?RS8G3lrUD4W8JOiCKhzQZD3wIwxmk0FXO4zFu1WmdIthz/EtI4mvMB2Y/wZc?=
 =?us-ascii?Q?tyn88+4M2WsV0vyT1ny4kKfem4I3hlV39lev5dJcysPt/qEH9QnaSUsc0x1a?=
 =?us-ascii?Q?LQ+m+3P9nCigtuAMwaQceMfQ1hJCpMFP2CERpYw+f9PrT44od06VFyq+RjUi?=
 =?us-ascii?Q?/2Av1V2FV5P55koPYsgrR4EL863vDRG7qPZ2+JyCVu4nZh+7PeUW/n5dQPWr?=
 =?us-ascii?Q?JwlzbNuY9DW5dhlPFPSGYtZhZFsnOX+XbZu43nvdL1g8cd6lkkz2UOvted2m?=
 =?us-ascii?Q?IGslCp5PLcDTXONnVrp2cA4k+Xi/PXXwpp1kY6X+fBrw319ZkmScIKIlV+bs?=
 =?us-ascii?Q?1rtnNimn2WjO4D00+esn46he5b1LXWpsLyfKIJncFhyVl8ImXmCokLV6xY0w?=
 =?us-ascii?Q?HkqXpPDS3y3CKMGDmY1TVtpTyfZydYC6YqYSyVFS0S+bD5iluDREX9Yb7vty?=
 =?us-ascii?Q?bQxSj6pHaA1fe+07PsbH56tkcpPq0Y1YYWN4euZlReMes79i2ww2uf3zra9c?=
 =?us-ascii?Q?dXc+HkKX+MbHpMkZWupHj0mpCY6GwiH3z+D9E03eZ6DVmIVGYcAOKl5fbhfX?=
 =?us-ascii?Q?AhrAr+OU/Oo0u4+cTPGC6jS0r4CcYumQ2KXhgqAhHcI6ml81OQlsLpkuvQQe?=
 =?us-ascii?Q?U/ThzR1tUsEHqAgE3pcvfMwZhKfYNT9QJugmpmvmdxN/XS3VoCjSlNI86/zv?=
 =?us-ascii?Q?5a7Xl4meYE9KgH66ou6wDYnZZg3iANalOgdhlGX4oAoIkDBW8PM1b49RnkbY?=
 =?us-ascii?Q?LWPN7z0aoza41IhWVcoW9cD3mk9L+ZtBYph2dkc4lfeLyLqnAeJO9LmPXwxx?=
 =?us-ascii?Q?YaGVyGXPdsCo3yn22fZgWaYJRMaiWCzJ7jfvzOtGsGnmHzUMjL/Na60aX/1k?=
 =?us-ascii?Q?Z0EBV7nAjJZzDlPc5ZrOHiLVYpzXqd6I04zunIsUmMqSILlpnJge26Q8sDGi?=
 =?us-ascii?Q?MOJ2BFwa/bP6MNWBQmjtWYvjTWJzcwPKxBsaaA54e8L9ovWHCpfAQZk1CtAm?=
 =?us-ascii?Q?p0NNK6wGnOX/QFSHiEphSZATPVdQX2KETEwt2Uu6v+2joT4R69oEfd56EVn2?=
 =?us-ascii?Q?yDVg08mx5LQUS3JEgFh9qqgD+H1EsyjkUzzSHqd2vX5ehaI4lKS0pStAAUJ/?=
 =?us-ascii?Q?cvKu7XtdO+9wx4zhREAaU3mM6iA8UUd22TmHEM7dE/xvWN1dtAt0Yy+/Tju/?=
 =?us-ascii?Q?FLYkY7v55u/Dxi+GUNRDFYgtoTWQznDlA0MrrXa76567o0KH4ImM+iHnuB+9?=
 =?us-ascii?Q?cnLAVMFjyJM3PcS7zqq/m70Al0oMkdAD/oHpgSdsR38tVwidyWWwm54Qa6cU?=
 =?us-ascii?Q?FNhFzC+K4h/tR9nHV3Est+JNDDddfbmLIA3jiGVlgZXXkcvyb21bqQ9Y7SPJ?=
 =?us-ascii?Q?wTmsBmjFbtoUjefT3gjfO5yyOmEzJ1Vc2TWZRf14i31rxyCMYnAvvFZ0laDC?=
 =?us-ascii?Q?hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c81ea0-e05c-497d-e802-08d9b556ae07
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 05:43:34.0089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /IrWjDonJ39zmGQcNPu0TTQvR7h4cYRFgSj6NzOyxFMtCrJCvuZ5K7GyCjX6MUjOonkXjfGj2bzrLSiA+pOtbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9144
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Wednesday, December 1, 2021 8:44 PM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>
> Cc: l.stach@pengutronix.de; bhelgaas@google.com; Marcel Ziswiler
> <marcel.ziswiler@toradex.com>; tharvey@gateworks.com;
> kishon@ti.com; vkoul@kernel.org; robh@kernel.org;
> galak@kernel.crashing.org; shawnguo@kernel.org;
> linux-phy@lists.infradead.org; devicetree@vger.kernel.org;
> linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: Re: [PATCH v6 0/8] Add the imx8m pcie phy driver and imx8mm
> pcie support
>=20
> On Thu, Nov 18, 2021 at 09:54:41AM +0800, Richard Zhu wrote:
> > Refer to the discussion [1] when try to enable i.MX8MM PCIe support,
> > one standalone PCIe PHY driver should be seperated from i.MX PCIe
> > driver when enable i.MX8MM PCIe support.
> >
> > This patch-set adds the standalone PCIe PHY driver suport[1-5], and
> > i.MX8MM PCIe support[6-8] to have whole view to review this
> patch-set.
> >
> > The PCIe works on i.MX8MM EVK board based the the blkctrl power
> driver
> > [2] and this patch-set. And tested by Tim and Marcel on the different
> > reference clock modes boards.
> >
> > [1]
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> tc
> >
> hwork.ozlabs.org%2Fproject%2Flinux-pci%2Fpatch%2F20210510141509.
> 929120
> >
> -3-l.stach%40pengutronix.de%2F&amp;data=3D04%7C01%7Chongxing.zhu
> %40nxp.c
> >
> om%7C3edb11e040e6412cf91108d9b4c85052%7C686ea1d3bc2b4c6fa9
> 2cd99c5c3016
> >
> 35%7C0%7C1%7C637739594698843569%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLj
> >
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&
> amp;sdata=3D
> >
> 5xlZSnBYs1SIIbMnmlQwi0qtfLDgKbueLNjPWIPD1pw%3D&amp;reserved=3D
> 0
> > [2]
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> tc
> >
> hwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fcover%2F20210910
> 202640
> > .980366-1-l.stach%40pengutronix.de%2F&amp;data=3D04%7C01%7Chon
> gxing.zhu%
> >
> 40nxp.com%7C3edb11e040e6412cf91108d9b4c85052%7C686ea1d3bc2
> b4c6fa92cd99
> >
> c5c301635%7C0%7C1%7C637739594698843569%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjo
> >
> iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C3000&amp
> > ;sdata=3D1388J8dLuKUc6KEUnWj5pLpkaPDC4kTIZFF%2BPTspHZY%3D&a
> mp;reserved=3D0
> >
> > Main changes v5 --> v6:
> > - Add "Reviewed-by: Rob Herring <robh@kernel.org>" into #1 and #3
> patches.
> > - Merge Rob's review comments to the #2 patch.
> >
> > Main changes v4 --> v5:
> > - Set the AUX_EN always 1b'1, thus it can fix the regression introduced
> in v4
> >   series on Marcel's board.
> > - Use the lower-case letter in the devicetreee refer to Marcel's
> comments.
> > _ Since the default value of the deemphasis parameters are zero, only
> set
> >   the deemphasis registers when the input paramters are none zero.
> >
> > Main changes v3 --> v4:
> > - Update the yaml to fix syntax error, add maxitems and drop
> > description of phy
> > - Correct the clock name in PHY DT node.
> > - Squash the EVK board relalted dts changes into one patch, and drop
> the
> >   useless dummy clock and gpio suffix in DT nodes.
> > - Add board specific de-emphasis parameters as DT properties. Thus
> each board
> >   can specify its actual de-emphasis values.
> > - Update the commit log of PHY driver.
> > - Remove the useless codes from PCIe driver, since they are moved to
> > PHY driver
> > - After the discussion and verification of the CLKREQ# configurations
> with Tim,
> >   agree to add an optional boolean property "fsl,clkreq-unsupported",
> indicates
> >   the CLKREQ# signal is hooked or not in HW designs.
> > - Add "Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>" tag,
> since
> >   Marcel help to test the v3 patch-set.
> >
> > Main changes v2 --> v3:
> > - Regarding Lucas' comments.
> >  - to have a whole view to review the patches, send out the i.MX8MM
> PCIe support too.
> >  - move the PHY related bits manipulations of the GPR/SRC to
> standalone PHY driver.
> >  - split the dts changes to SOC and board DT, and use the enum instead
> of raw value.
> >  - update the license of the dt-binding header file.
> >
> > Changes v1 --> v2:
> > - Update the license of the dt-binding header file to make the license
> >   compatible with dts files.
> > - Fix the dt_binding_check errors.
> >
> > Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   6
> +++
> > Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  92
> +++++++++++++++++++++++++++++++
> > arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi                |
> 55 +++++++++++++++++++
> > arch/arm64/boot/dts/freescale/imx8mm.dtsi                    |
> 46 +++++++++++++++-
> > drivers/pci/controller/dwc/pci-imx6.c                        |
> 73 ++++++++++++++++++++++---
> > drivers/phy/freescale/Kconfig                                |
> 9 ++++
> > drivers/phy/freescale/Makefile                               |
> 1 +
> > drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   |
> 237
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> +++++++++++++++++++++
> > include/dt-bindings/phy/phy-imx8-pcie.h                      |
> 14 +++++
> > 9 files changed, 525 insertions(+), 8 deletions(-)
>=20
> Hi Richard,
>=20
> I can pull this series into the PCI tree (but not the dts changes that sh=
ould
> be routed elsewhere) or give an ACK for patch 8, please let me know
> what's the best option.
[Richard Zhu] Hi Lorenzo:
First of all, thanks a lot for your kindly help.
To my original understand, #1-3 patch had been reviewed by Rob, might be
 merged into Rob's dt-binding git repos.
Shawn takes dts changes ( #4, #6 and #7). And PHY driver merged by vkoul
 or Kishon.
In the end, the PCIe changes(#8) are merged into PCIe git repos.

I'm appreciated if you pull this whole series although I'm not sure that
 you can do it or not.
Today, I'm glad to receive vkoul's comments about the PHY driver part.
Let me continue refine the PHY driver, send anther version of this patch-se=
t.
Then, let's figure out what's the best option to merge this series.

BTW, I'm prefer to let the following one patch-set merged firstly.
But I can't get contact and response from Lucas for a while.
Lucas might be on his vocation and limited to access the email.
I will ping him a few days later.
https://patchwork.ozlabs.org/project/linux-pci/cover/1637652717-17313-1-git=
-send-email-hongxing.zhu@nxp.com/

Best Regards
Richard
>=20
> Thanks,
> Lorenzo
>=20
> > [PATCH v6 1/8] dt-bindings: phy: phy-imx8-pcie: Add binding for the
> > [PATCH v6 2/8] dt-bindings: phy: Add imx8 pcie phy driver support
> > [PATCH v6 3/8] dt-bindings: imx6q-pcie: Add PHY phandles and name
> > [PATCH v6 4/8] arm64: dts: imx8mm: Add the pcie phy support [PATCH
> v6
> > 5/8] phy: freescale: pcie: Initialize the imx8 pcie [PATCH v6 6/8]
> > arm64: dts: imx8mm: Add the pcie support [PATCH v6 7/8] arm64: dts:
> > imx8mm-evk: Add the pcie support on imx8mm [PATCH v6 8/8] PCI:
> imx:
> > Add the imx8mm pcie support
