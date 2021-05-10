Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E043F3779A8
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 03:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhEJBPP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 May 2021 21:15:15 -0400
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:53989
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229941AbhEJBPP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 9 May 2021 21:15:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULp2cGaE9XHOg1P5h0jOzDiGoajVLZsLUUMGH4WvlbgMhG4CiboN7BtJo+wOzc8+Gc5tbKO+xMhvpUHayKKzPSo4MwdfJTXCX8waip4BtKm4AZ+30F5cwtODUXq7eQidGZzJ+0pgfvaq08vE99F0gmo3p9Zp7I3Zx1R9YbOoaRa5CjmwXQoSw5OTR8WP8KzJO42jO5Nc9l5Jo5mQmPd/gD4ydXOaVRHNLZ3W2YR8gb5VHbxJxghDBUlS9tEcld64kO7rbrQCgr/Aj7pixBSOA8xEjmEiF9ezMWmnl8z9yauJCsBeCWlxgAzJpjMWRmfv1QMNuvmD12Zg8tlKX8ewrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elFx6qtLNoUXuk3ebwbyiQ8nL+iU8kE5OezSOH3pWws=;
 b=Cf8DpljtelTXqUQXr1fXNU2Mnhmku/QIvvn7RJAquXNccQ6tkhcZhllj7aSaJhmbh36ZZ2x8l4gMQiujGP9FI6VYfgiyxbho+Xwa/LOJmrGEy1k8AstQ5+usvlVmIKxMwYuFvc90e0+zY6PqPTmJf8toBWfs7SNHV5XzSkk91y9Z1EaftjKKqnS22h/wx2G0Z1lM/xx6v7orbW8SCiWGifBvL8A1jAbmhf5JXrGtezuFz7NBrTbUm4vAiqw36veaLLZTdFH8+GbIq1SNc3pxUIsaFVq0RygeomCVDLqwVoKHk7qlFOCFVTwUj+WWgxGDv7ki5H2MK8bl3t5575491g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elFx6qtLNoUXuk3ebwbyiQ8nL+iU8kE5OezSOH3pWws=;
 b=GMxmAZSyl12EjqFX4sIoyBcbnDhSNMYLK/G3+ppph2C0Jxe1LyrrJflLJUEoGS0w6eh66M/vd4l1U6aevjzgQGLkW/sCY5FeGsPvyEpUYtZlfW76x2Pv37yPZyYvGOJwbx8fDDdRQLXM6nmCPzJ3pQ3irxm02So8LjX49m38UzI=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR0402MB3550.eurprd04.prod.outlook.com (2603:10a6:803:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.27; Mon, 10 May
 2021 01:14:08 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::c830:a7cb:c125:2fb7]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::c830:a7cb:c125:2fb7%6]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 01:14:08 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "stefan@agner.ch" <stefan@agner.ch>
Subject: RE: Re: [RESEND v4 1/2] dt-bindings: imx6q-pcie: add one regulator
 used to power up pcie phy
Thread-Topic: Re: [RESEND v4 1/2] dt-bindings: imx6q-pcie: add one regulator
 used to power up pcie phy
Thread-Index: AddDBHDZpAHyzF/RSbu9bRln4UIDkACNTaWQ
Date:   Mon, 10 May 2021 01:14:08 +0000
Message-ID: <VI1PR04MB585382D3D4EE9264A6C987138C549@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <VI1PR04MB585323D08A483C47E7DDE93E8C579@VI1PR04MB5853.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB585323D08A483C47E7DDE93E8C579@VI1PR04MB5853.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6af5628a-767f-4d5b-dc06-08d91350e991
x-ms-traffictypediagnostic: VI1PR0402MB3550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3550347458AD447E4AE1C9698C549@VI1PR0402MB3550.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IPi6x8Z0t8FRWEygsTc+gwOfeE3JByjZ7i9yN1lxzSBBiwGNjAxUbBD5u1t+0/hJCcNtsHXP+BVAI3StoxFQargyIdIsjVmY6kWKCfx+VQaWZHQA/U1OufXDKpg2h+vbxgVS6RD+sDivaAAU7M7G9Q2Ro8x7AMkQcetZeVKhf0ZoHaR96isK0IGeZ8Ld1mtP5WmWO4wzyhP3QlDpgFxF3mH2Nyuh3OkNyMVU3remeIEDtPnX8QZkVhG1fXxVf+G6SmEBDzgqDY0aHNyx1H6p30Sq7NlibbAHqxBLV3u+PFLuWa8rW1WPF58Z5UDMvfsG2kV4LsIad0pA31Uwzq6tv/D3733Lj8O0056UPZcO55XRBV76Q1Ikqq0HtX9NJKC0QsauwpUBVLgkGk0uJWwyx+gVpMPLMCAVvo2nJoysf3fS8DHhpa6KvJqatz+e5cVMpLarRwLwjoeK1wvaFjBNBQe4cSK1KS07H6r4vMbxUdmnoyKFPWXd6Jqq0hk7U4INBlOFDHYp73WMrV0rXreK77zyrpgD6mWoFGtyrvBQe2AiThK/u6a/6qaAaNZNywpXZZFuCfQLmkNMjsl2Tu913T7hN31Bhy6oc20yoq8NT3tVwqOa9sW2gY9wNrmnLD321HWowVLyG0GbW/l3azER/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(366004)(136003)(396003)(346002)(4326008)(8936002)(9686003)(38100700002)(33656002)(52536014)(122000001)(7696005)(76116006)(83380400001)(55016002)(316002)(71200400001)(6506007)(186003)(66476007)(2906002)(478600001)(66446008)(26005)(86362001)(8676002)(66556008)(64756008)(66946007)(5660300002)(110136005)(7416002)(54906003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AYE5OLyQJeELCuU5bpS1g118k4P0GZ3qfyQhpvqWSJI6vezo97064XbkFPq1?=
 =?us-ascii?Q?Yi8MIjk9kD7bJVSO/zCCshoS0GHFJisTuc+KELuEu2eIzW2brF0fVCQT9SUw?=
 =?us-ascii?Q?mU6rKSbwvPxIYdR37Ucddd9WWH+wZT6MxUpva+/TM5767juMNK5LvaL/ZNPa?=
 =?us-ascii?Q?3t9pNszy+/hYgU4zYlIoV84YX3L3qj1bMqzIoXEdmswrcwxhVJFjQa90o3FE?=
 =?us-ascii?Q?vVE2y+QmZCW8oTfBfL1AYy4DKHb11K+TpSi0kvWh3yZCauXb7x1Gq+dtPI3h?=
 =?us-ascii?Q?AZOwT+OO35MY0XZ0GqqQTEHKJaoEIkGcjrg3wLa3tzwkQWOmp5QYl1oKghlF?=
 =?us-ascii?Q?CO9RojpCYDXAL9sKGKmmihFBpsB4axaM+EYMTD/t+FGR7JlTQrBMPnUZQDJ4?=
 =?us-ascii?Q?MSmQ7RQC7/MsOYkzuQsXKcmirN8nGhfMd62hUL229uW6i3KT/JXMPs95MmJd?=
 =?us-ascii?Q?mAomuTegVoOlpD++FXiU1LUgDFvD4M7pstI0rS3SjyUreLknamPyblHDCBvm?=
 =?us-ascii?Q?UW1OAcZBs4SdWhaPLgBeRNE6GWqwuhJ9PX4qIaOkGXYNe1MSM5Vo7B40fvLM?=
 =?us-ascii?Q?L5mxOKN5tEaOnQzo61z5g4Cgwk6hCUQaqhNOo5utBhaJFBur1OHQ8n7w4Z9W?=
 =?us-ascii?Q?jJDVLa9ExB5DZb/X3Hc11escIF+rlJKUmlirACH2eB3gtGux88T51Z5N3x2q?=
 =?us-ascii?Q?Jh1zTmEy6m3RKHc+bKg/KUD80fO9tgkpMB0fpWO7CHNuZIpt3rg+oHQWJGhr?=
 =?us-ascii?Q?6MY9Gn3SPd5MFnYU+BUcSST8eoduT8N3G1quA2vfmaJnjtUizm0GJtYJCGXm?=
 =?us-ascii?Q?MKRuaXhO9nZOIU9OutUtWIVgj2FtW5sbkHKS+tnG2lL2F9VvhejH/KSekoKF?=
 =?us-ascii?Q?euuMmNMhJlQz86iLmfzB9J0rkjCXGf7Vq5PqKk5FImz0Sm8Y4giBzE/6RGuF?=
 =?us-ascii?Q?wf/b5Ui0iLdo5cqbbjPUNXVwH7JOGPM38Zj9IZy7phHZAz2bwAMsDYPOsVDT?=
 =?us-ascii?Q?YCmdGt+Gl/AmKJenqBgn0528OwjebuUVMp8ro8oNZ/yFcpKbg9COjihlaEcG?=
 =?us-ascii?Q?PyI8PBoPvZedfEhiK1uhvftCyK1TVxA3xlWEy2bISn3624vFPbGNDEZurxYy?=
 =?us-ascii?Q?9kJw/yOFifxjYba5NtpCcQKy1VoEu9lazIZILSPIE+8WMiDn8bZ/SLYAjATl?=
 =?us-ascii?Q?ArmkwV5kIdodEZZRFBo5fbknSnxnp8fVUpzI1uvMIa5x8DkG20jQQw1O7JDb?=
 =?us-ascii?Q?BWo0IJskJ2n/cWBnyOi1f0AnpJCB8g36erkTkWzBOxLc8jkfsdyBGrPGUGH5?=
 =?us-ascii?Q?llWWSEm2xEXBQZNOoh0b+CBV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af5628a-767f-4d5b-dc06-08d91350e991
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 01:14:08.5208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JkddcRtzz0UXuBYzq8OClKD5jFsUjUBWlhtxld5H1cJQrZyzSNDfUx07QzXXefaidEPV88IB1ehLdgZ6H2cKcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3550
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Re-send again.

Best Regards
Richard Zhu

> -----Original Message-----
> From: Richard Zhu
> Subject: RE: Re: [RESEND v4 1/2] dt-bindings: imx6q-pcie: add one regulat=
or
> used to power up pcie phy
>=20
>=20
> > Subject: Re: [RESEND v4 1/2] dt-bindings: imx6q-pcie: add one
> > regulator used to power up pcie phy On Thu, May 06, 2021 at 06:08:24PM
> > +0200, Lucas Stach wrote:
> > > Hi Lorenzo,
> > >
> > > have those two patches fallen through some crack? AFAICS they are
> > > gone from patchwork, but I also can't find them in any branch in the
> > > usual git repos.
> >
> > They were marked "accepted" in patchwork but must have fallen through
> > the cracks.  I reset them to "new" and assigned to Lorenzo.
> [Richard Zhu] Thanks for your help.
>=20
> >
> > Neither one follows the subject line capitalization conventions.
> >
> > The subject line of this patch (1/2) doesn't really make sense.  I
> > *think* this adds a property ("vph-supply") to indicate which
> > regulator supplys power to the PHY.
> >
> > > Am Dienstag, dem 30.03.2021 um 16:08 +0800 schrieb Richard Zhu:
> > > > Both 1.8v and 3.3v power supplies can be used by i.MX8MQ PCIe PHY.
> > > > In default, the PCIE_VPH voltage is suggested to be 1.8v refer to
> > > > data sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic
> > > > design, the VREG_BYPASS bits of GPR registers should be cleared
> > > > from default value 1b'1 to 1b'0. Thus, the internal 3v3 to 1v8
> > > > translator would be turned on.
> >
> > This commit log doesn't describe the patch, either.  Maybe something
> > like
> > this:
> >
> >   dt-bindings: imx6q-pcie: Add "vph-supply" for PHY supply voltage
> >
> >   The i.MX8MQ PCIe PHY can use either a 1.8V or a 3.3V power supply.
> >   Add a "vph-supply" property to indicate which regulator supplies
> >   power for the PHY.
> >
> [Richard Zhu] Okay, will be changed as this way.
>=20
> > > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > > > ---
> > > >  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > > > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > > > index de4b2baf91e8..d8971ab99274 100644
> > > > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > > > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > > > @@ -38,6 +38,9 @@ Optional properties:
> > > >    The regulator will be enabled when initializing the PCIe host an=
d
> > > >    disabled either as part of the init process or when shutting dow=
n the
> > > >    host.
> > > > +- vph-supply: Should specify the regulator in charge of VPH one
> > > > +of the three
> > > > +  PCIe PHY powers. This regulator can be supplied by both 1.8v
> > > > +and 3.3v voltage
> > > > +  supplies.
> >
> > Just going by examples for other drivers, I think this should say
> > something like
> > this:
> >
> >   - vph-supply: Regulator for i.MX8MQ PCIe PHY.  May supply either
> >     1.8V or 3.3V.
> >
> > You mentioned "one of the three PCIe PHY powers"; I don't know what
> > that means, so I don't know whether it's important to include.
> >
> > I also don't know what "vph" means; if the "ph" is part of "phy", it'd
> > be nicer to include the "y", so it would be "vphy-supply".
> [Richard Zhu] There are three power supplies in total required by the PHY=
.
> - vp: PHY analog and digital supply
> - vptxN: PHY transmit supply
> -vph: High-voltage power supply.
> Only vph is handled by SW here.
>=20
> BR
> Richard
> >
> > > >  Additional required properties for imx6sx-pcie:
> > > >  - clock names: Must include the following additional entries:
