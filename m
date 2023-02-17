Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD74969A311
	for <lists+linux-pci@lfdr.de>; Fri, 17 Feb 2023 01:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBQAqJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 19:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBQAqI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 19:46:08 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2137.outbound.protection.outlook.com [40.107.113.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C951199EF
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 16:46:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ew2SwtjLvOHeZS/A+5KSLRLorAFFn5nvCqJxPVFVaFbTc+Nj5QXiISKe7ohBq6ma2lRURMxT3npXG/yfhmnkcZRq0ubxymJNxAJOomdtpyIbYoMuNjG2/+SUY8kQ7BWhjB0057GhOZEQRy0Ci9saNPzX5rWPVu5jkVgK13UCGVZ1Le4JyE4BmuAyxv8VN1y2Tw41V2Uc+kU2Euu9wPZ616To2e9Wg/O5d87bMQwE4W8urhQ/OWag4gAPMqlouQPsymWywmLeB91hT7YMNa13hCqb7ZCd8N7pAsVGcDuS1h9x1cyPPZdc20EkZdgrulE0Kuf98GZY6CkMPFFRh2wtRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AuYPXt1t8Q/9sdXFaJXZChcp8JlXZNv3FKOzN49SMw=;
 b=fhzY5qB0iZpbRTFBwvM5YJxdILCcbQX0KM/f2asuO86dmApModF+HD4lahUeVYx11liYqGVLPmuAHPmb24Aqc0/9KI8IFlgVU0pBana6Aa2AUl0z+Muc0qPLhyb9WI8eHbRhaIUK3B4lyV6mPqbwuP6h9S+nDqUhxc+wkb1NeqE1qbiz3DkejTZvU0c3V0tbfDa0jQauIfOkqVv08HyaljdMYMK0DqBYTxrz0TYOqX1pvPMsZLZQZBYDezGLI+UnjvuoqfI8eAtsQGerQrcDdzVywWuWjOkR3ZdLP8GldGAnWRujdtxZaZNHJ1tsUtUhLuJacNkcDuCcM5VWuhIkhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AuYPXt1t8Q/9sdXFaJXZChcp8JlXZNv3FKOzN49SMw=;
 b=Px40ertGrIoJ8AKOSgmVlOx8o4x8YNltTw0aOD7G32eTnNkjVfw6Ae6RLhLtx6kOnXWHpe4evBIl2F/zhS6mOjY4khRDXQCqihHe7b3Qz0ThXteKvfz/U46IgOdEKuHkWhS8W8HMnzMQ58KJxlGBualIB+wmB5Xa+AE83k+Kejs=
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com (2603:1096:604:8a::15)
 by TYBPR01MB5519.jpnprd01.prod.outlook.com (2603:1096:404:802c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15; Fri, 17 Feb
 2023 00:46:04 +0000
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::36d0:6f72:47fb:ed43]) by OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::36d0:6f72:47fb:ed43%6]) with mapi id 15.20.6111.015; Fri, 17 Feb 2023
 00:46:04 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI: dwc: Fix writing wrong value if
 snps,enable-cdm-check
Thread-Topic: [PATCH] PCI: dwc: Fix writing wrong value if
 snps,enable-cdm-check
Thread-Index: AQHZQefrB3UXIYQp0kKHlH/3kgeQXq7R3LQAgAAv0ACAAD8G0A==
Date:   Fri, 17 Feb 2023 00:46:03 +0000
Message-ID: <OSYPR01MB5334E428391F68F9CDA1374ED8A19@OSYPR01MB5334.jpnprd01.prod.outlook.com>
References: <20230216092012.3256440-1-yoshihiro.shimoda.uh@renesas.com>
 <20230216175822.GA3321300@bhelgaas>
 <20230216204930.jvxt3ajny2eymbtn@mobilestation>
In-Reply-To: <20230216204930.jvxt3ajny2eymbtn@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5334:EE_|TYBPR01MB5519:EE_
x-ms-office365-filtering-correlation-id: b28e94e7-05e4-49fc-6483-08db10805920
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tYDmCP3scOI6fUDDHa9NZ5A6MKFNGe35uTttfHRnAxgUGaWWjrlCJ4Ohb2J4oHrzTtK4dPobVaHTwviK3B9R+zVuDyFpvzFpwo9IEm5WHvQmlo1wrSyHAuGB8WmRUZyUiBkxxe2mEuOLabaFqf0g8gifwXk5Sl90WojQc1PZR6WIqRcAYeLF+AenU1TotVS1fRjCpx2sfScZgs8T2AmV0XAfpz0wTGp/UJn9nlLWFPCggOzyMCD0lIzB7fVxY/2bI2F1eXmMJCWS0vtyM8SwNbneuWuXmyj5fu/rBwE8pGT3iMEMLlbUzQWxD7j3DTG6+gCkZ7+TZsdlGVgf3agq2V4Y2RaWoKalSXHx0x1kHSNjOg+8kH5/R3A14NFLFAH/wRPWAG1Zp6/yQCiZSIB3WmmwUPht8FBAwMpBJq7YtUU9Z1IhBiqW1/FfZXCbrIy5Xosyt5r2WoARMYcb0+JHNvnyLsl63MRJHqAfroCqzoMbo+KA0Q/nmEDy817LT4SZdrRMqRohTtKZgxWIIRenPrTaqBTM6Yyv20VcQOZguMiQW8WIx8T0++O/7JQw3La2C1Xy7qSn0d+6vD1jQQji3nR843PzMPAEEbXWIglNC+LPz0RX3EagusZq9eWb3RvK409Zl3vYSCaRk3w+IlkspiVSXyslHB9cGeE3z1uELSRhXwAW+746hZhrK0x1LpxRj5dKMIBOU8DM+ybPFpesXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5334.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199018)(5660300002)(8936002)(7416002)(52536014)(41300700001)(86362001)(33656002)(38100700002)(38070700005)(55016003)(2906002)(122000001)(7696005)(6506007)(71200400001)(9686003)(186003)(478600001)(4326008)(8676002)(64756008)(66946007)(66556008)(66476007)(76116006)(66446008)(110136005)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aUfGl6/WNFgEhDVMTttlcyo+9cwXF/+stEEB6GvYWDAAhNtoaRvcl1fKRYjA?=
 =?us-ascii?Q?+Bf4f4oZPFHgRMYbFdGE88cWc430EbKQ8U1i99IiTgXgtdSECCS1lK8yIqCb?=
 =?us-ascii?Q?h4VF6bmt+sWtDZFQQ47BoBuB9tHtGHyakgW3XIukauC1gZmsPYCtBW8ymSpj?=
 =?us-ascii?Q?19LEh+Wvq31X3TnO0DoOsIW6Jg3hKJeD4kbrVbyKxYxxMYp7dNKOsHSev77d?=
 =?us-ascii?Q?7oXEBqV0ivmzSW6z3YZt95w/fbgXFbihDKLrxgqQ8ydcATooPdtdruEla8H5?=
 =?us-ascii?Q?TGvP7mWDeclPoFItkddNyQAWowpGJJogCXA/F/lEjPDfC1WJAL7L4NPS8G4x?=
 =?us-ascii?Q?bGF5ZQM+GDET7WdKAhVW9x4xuJj0m468sEc7bdadc6Kx37vlwPulN7tFzHAW?=
 =?us-ascii?Q?Q8fE4rnVOM6SQCHgKMq61PO42JU2djIN3WL11fyRLq6sKdAoFVgvycDjXJb9?=
 =?us-ascii?Q?qJTJ7TT7HOtxaRNYQWCfeqWi2eVWyUY00zHPVrvvzY1pB+z1DdSP598Ybogx?=
 =?us-ascii?Q?3BAlyZMtiyxf2IT+GgMdu2U472PEecXx3uNt4AiSs6kW5Qi0NMMxqZeXlqwN?=
 =?us-ascii?Q?a8ByUxHdGxtycxFTj61pUA9atoLooGUUbkNvDnJ1+ImFK8lbJM+lDpTv/uuX?=
 =?us-ascii?Q?DPHKIFfWC6cq1Vgzu/KRyCAaziXraRois2EllAOiKFPBDSnaf+0OeQm/u1s2?=
 =?us-ascii?Q?h2iWYr/K1lO2wZaKmWfxK+SkkmfI40wxIYabKX+CoRCOMlILADg99VDuAkMG?=
 =?us-ascii?Q?5dVlT11FZ7vlqKkv/LK+C/ddSvRJXbKQbEhf5FiInviidoQrI55Q31XC8Qnx?=
 =?us-ascii?Q?SP5BryI0y/TtfDHhVeKcoHAHMZSeBSk3xPFZxZQUca+0+/qc8pzhY+gM/SuV?=
 =?us-ascii?Q?onkAik+gDRCJgtiQrIEE53BVCzGb7G2nESj8XTLEiALMN/MbMhqFoWcnEbdu?=
 =?us-ascii?Q?0ysnrNblJUaDuBzRhl5wtm1su60esWEZJmW8ClVyvK8Ipc94SkPzSW2do7nh?=
 =?us-ascii?Q?VlgJfQ4kz54sHme5/YRjuQzpnm+SyAeM8fnSdXlq+FvKnbTvFIyrnu76PqcP?=
 =?us-ascii?Q?aJoAaIP0e96w7V1wF5QNKLxvOepS0+PGo5XjQBs4aWGm7fwCsdQOiSwt3Umx?=
 =?us-ascii?Q?S4zmqr7xQfscUBXuajmHUoOXEdSIbMX72sNymIhrZDswnOQQyW2Fkvdj4Nga?=
 =?us-ascii?Q?xfeh6V3TugADXyr2iRRp1rkckF4W9wYv+xSA/xQqt/F7FuAcXY9gg6/jAoOH?=
 =?us-ascii?Q?3jFLiQ0d25riiKoJbD0WJXr6SNaoABAKpDVrgiW6x2J2ltdd/slEZi2u1g2K?=
 =?us-ascii?Q?vpH1fBh2Q4vAmk07lIXQ+OvUw5BqR/V/t5od+PCCEUh7Tm8fSC9TDp7Tdzri?=
 =?us-ascii?Q?hNBJocL2w0ngW74slmg4Jc/xUHIoNVKfZ4jCjZ3TFcX+z9j5uip9itRGaU7s?=
 =?us-ascii?Q?TSX5XZXCwD3sT/Af7BkYPRysOrq6TEHxis++FN42QU4Hyc7M5l7dW7TbtDQK?=
 =?us-ascii?Q?36JPd9AVSLDsSxd4A+klizGfoFCaqpLm3SyMHcNNajttYbROnhew+K9/zApv?=
 =?us-ascii?Q?TdfBVzWrBrH/m+hTUHM556zl8HwhIZNGTdZ+gVDlJzdn/wQL05fmz5xYmlyr?=
 =?us-ascii?Q?mjB6PjV2OWuvnJZ7BlAIyjNxIrXXe0189WIuaWwlQP47mhYv/Lf1r2NSs8kF?=
 =?us-ascii?Q?XBwxIA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5334.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28e94e7-05e4-49fc-6483-08db10805920
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 00:46:04.0054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: woNwsE/v4tn3mvIqmQ5y+xmSZ0xzF7oE46/EGm1vt1w/qUTZW90fHuMmEEk2UzGXMgXVB9oDCp1VgQT63kMybgkoVH53YNyU7OiuoGwCyK2AOZLT0p7HgRZd44eT1c4L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5519
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn, Serge,

> From: Serge Semin, Sent: Friday, February 17, 2023 5:50 AM
>=20
> On Thu, Feb 16, 2023 at 11:58:22AM -0600, Bjorn Helgaas wrote:
> > On Thu, Feb 16, 2023 at 06:20:12PM +0900, Yoshihiro Shimoda wrote:
> > > The "val" of PCIE_PORT_LINK_CONTROL will be reused on the
> > > "Set the number of lanes". But, if snps,enable-cdm-check" exists,
> > > the "val" will be set to PCIE_PL_CHK_REG_CONTROL_STATUS.
> > > Therefore, unexpected register value is possible to be used
> > > to PCIE_PORT_LINK_CONTROL register if snps,enable-cdm-check" exists.
> > > So, read PCIE_PORT_LINK_CONTROL register again to fix the issue.
> > >
> > > Fixes: ec7b952f453c ("PCI: dwc: Always enable CDM check if "snps,enab=
le-cdm-check" exists")
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/p=
ci/controller/dwc/pcie-designware.c
> > > index 6d5d619ab2e9..3bb9ca14fb9c 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -824,6 +824,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
> > >  	}
> > >
> > >  	/* Set the number of lanes */
> > > +	val =3D dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> >
> > Definitely a bug, thanks for the fix and the Fixes: tag.
> >
>=20
> > But I would like the whole function better if it could be structured
> > so we read PCIE_PORT_LINK_CONTROL once and wrote it once.  And the
> > same for PCIE_LINK_WIDTH_SPEED_CONTROL.
> >
>=20
> I don't see a good looking solution for what you suggest. We'd need to
> use additional temporary vars and gotos to implement that.
>=20
> > Maybe there's a reason PCIE_PL_CHK_REG_CONTROL_STATUS must be written
> > between the two PCIE_PORT_LINK_CONTROL writes or the two
> > PCIE_LINK_WIDTH_SPEED_CONTROL writes, I dunno.  If so, a comment there
> > about why that is would be helpful.
>=20
> There were no sign of dependencies between the CDM-check enabling and
> the rest of the setting performed in the dw_pcie_setup() function.
> Originally the CDM-check was placed at the tail of the function:
> 07f123def73e ("PCI: dwc: Add support to enable CDM register check")
> with no comments why it was placed there exactly. Moreover I got the
> Rb-tag for my fix from Vidya Sagar, the original patch author. So he
> was ok with the suggested solution.

I think so.

And, I think the commit 07f123def73e and commit ec7b952f453c are not
related to PCIE_PORT_LINK_CONTROL. So, PCIE_PL_CHK_REG_CONTROL_STATUS
handling can be moved everywhere in the function, IIUC. So, I think
we can have a solution with two patches like below:
1) Move PCIE_PL_CHK_REG_CONTROL_STATUS handling before reading
   PCIE_PORT_LINK_CONTROL (as a bug fix patch).
2) Refactor PCIE_PORT_LINK_CONTROL handling to avoid writing
   the register twice (as a patch for next).

I made patches for it like below. But, what do you think?
--------------- for 1) ---------------
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -806,11 +806,6 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
 	}
=20
-	val =3D dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
-	val &=3D ~PORT_LINK_FAST_LINK_MODE;
-	val |=3D PORT_LINK_DLL_LINK_EN;
-	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
-
 	if (dw_pcie_cap_is(pci, CDM_CHECK)) {
 		val =3D dw_pcie_readl_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS);
 		val |=3D PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS |
@@ -818,6 +813,11 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
 	}
=20
+	val =3D dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
+	val &=3D ~PORT_LINK_FAST_LINK_MODE;
+	val |=3D PORT_LINK_DLL_LINK_EN;
+	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
+
 	if (!pci->num_lanes) {
 		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
 		return;
---
--------------- for 2) ---------------
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -813,19 +813,13 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
 	}
=20
+	/* Set the number of lanes */
 	val =3D dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
 	val &=3D ~PORT_LINK_FAST_LINK_MODE;
 	val |=3D PORT_LINK_DLL_LINK_EN;
-	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
-
-	if (!pci->num_lanes) {
-		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
-		return;
-	}
-
-	/* Set the number of lanes */
-	val &=3D ~PORT_LINK_FAST_LINK_MODE;
-	val &=3D ~PORT_LINK_MODE_MASK;
+	/* Mask LINK_MODE if num_lanes is not zero */
+	if (pci->num_lanes)
+		val &=3D ~PORT_LINK_MODE_MASK;
 	switch (pci->num_lanes) {
 	case 1:
 		val |=3D PORT_LINK_MODE_1_LANES;
@@ -840,10 +834,12 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		val |=3D PORT_LINK_MODE_8_LANES;
 		break;
 	default:
-		dev_err(pci->dev, "num-lanes %u: invalid value\n", pci->num_lanes);
-		return;
+		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
+		break;
 	}
 	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
+	if (!pci->num_lanes)
+		return;
=20
 	/* Set link width speed control register */
 	val =3D dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
--------------------------------------------

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> >
> > >  	val &=3D ~PORT_LINK_FAST_LINK_MODE;
> > >  	val &=3D ~PORT_LINK_MODE_MASK;
> > >  	switch (pci->num_lanes) {
> > > --
> > > 2.25.1
> > >
> >

