Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A5D43AA30
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 04:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhJZCUq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 22:20:46 -0400
Received: from mail-eopbgr00049.outbound.protection.outlook.com ([40.107.0.49]:61702
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233726AbhJZCUn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Oct 2021 22:20:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVEmE8cDiT7t88X3P8AhHumZut9Z+XuNCe2ugOanaq+ac4qG6t2RWf1EP8CBpF8BRB00d3widZi41dgRrPQVGrhA6zsStOvMrXXUBJgEXOMq5G6rYF1cDiFewC99X1IkVWWFPb0zYtk+cKfykY1tdYC627DwFqk2D7KppgSe43oLf12sErcdkFhnxSZCXDvGneySaN8TRAQrKAGzA9+do84r+HVjVkrn+8728u0irtDexZ9K7F+RbcyDeiprTW1mdZG5kJT0ZEyG4zWLFuta5tIz5FAzBGRial0wOAU2c9/PAYFp7WoRacJgU9kIthhL8+yyOdIDLkndLDkhnYqQOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOqu90wkUkVh10ZyFwlVw5IKOUFByZNeFKr+N50of/c=;
 b=ABF9TX++6L3GR8j5/vHIh7rVNWtXEz+TV5N1RdyPBOmYAK9k+T31Rhk/nLY3xABZDBHPZS4hQLsU0v460tosqA3/ChdSD3RjV8y4YyYeNYF2iK/LHStv/+yWX5HhdOBUpMbMiCEW9BndkGCjKUD9HvVTDJ8QIa2LW5Li2ZavlcyB71mKi3aA0UIQ6TYqM2tXpDeM2oY1saFZNKm9J856E5z5FFKqcpBkghZwA1o6ROc4MQ4DVjmOga7rmZJgoJkBybTqgbhE9u716wPaBdeONE45Z1p94BtL5hZmzNJ4odv94QdsY2Kp8pqYNl2dRe6zT5pHXijedH4+aRgTtQXeNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOqu90wkUkVh10ZyFwlVw5IKOUFByZNeFKr+N50of/c=;
 b=dOs/q+G4OY8z0mrsLkQ9zs42Dj9n8A8eU8a2bZKinNtb1zt9vEV/ISfjMgUFz0PSVl4wATo0cZ9X3dtiLADW/4Ffatn3bffrwSBYQyLt6RJh+3MXJH6BD2+M2h2q1vgOFyGf5RZc+BHjewAnWSIAGcNVmJ1AwbrH749jYcky9jg=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8803.eurprd04.prod.outlook.com (2603:10a6:20b:42e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Tue, 26 Oct
 2021 02:18:18 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 02:18:18 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Mark Brown <broonie@kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link never
 came up
Thread-Topic: [PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link never
 came up
Thread-Index: AQHXxxe5hpSrQkcPqkWGr8lEYEKQh6vjlGkAgAAC9gCAAPQyAA==
Date:   Tue, 26 Oct 2021 02:18:18 +0000
Message-ID: <AS8PR04MB8676A0F3DA3248C6A27801148C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
 <1634886750-13861-4-git-send-email-hongxing.zhu@nxp.com>
 <20211025111312.GA31419@francesco-nb.int.toradex.com>
 <YXaTxDJjhpcj5XBV@sirena.org.uk>
In-Reply-To: <YXaTxDJjhpcj5XBV@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 485c7df0-8ca6-4ad8-f4f0-08d99826dff7
x-ms-traffictypediagnostic: AS8PR04MB8803:
x-microsoft-antispam-prvs: <AS8PR04MB88039B111297081CCDFCD9038C849@AS8PR04MB8803.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SZ56z7KI/sk3Ch7x8bUFo6CNoBbe5mYHToCKBqqKudJwD7xHWQaS/vDHMd4XAE+rjrY/WCzwhBMUqtHQnFoh7TfdAyIpz4sijH3XgmtJOU+OqNmBYYS6gLV/dEDI69GKYYMkCnGOvNYLswizpIaX0mHZuBZoupq1LdhHYo06pKqL3WdElcaGP8cAC/NL7XIevIbGL/NjRnD8Ula7z73QLsfey0CwmL8NebQ7LlxUC0BAT2cF1tml4iXkpiZIwJw1RQHF0HKDpsb/rvPoeiZVkiFe7AXh9nwSD71RhsgrEm3dPJV7nPrlv+y0inw2je3qh8q3ImqerM/fNd61oja2GQN7g0m0qRA+//zyj41K8P2sB08G/TjVtQb5FbffKgI1FqmgVoDYK/sUnHpyl6hcGF6MKzYY5k6Shy//JN1cidmev55kYaH1m9smUpFy4BWvjNF7oB57H/CUNZJjkj81KWm8latY1hjqhoWX97ave4D1PmJvr+v2VcJP9uXMeblWWGY93n50B6MMUqzqQtGC4MH2scSsKeWzK0qtL8W7rSseXODzbhx/QfKHEg4saEJG8bE4ddTdAdHGAVprZsJk3IWBO00DMRs7YpNQVrb4/jvdngJWlxPIKxZgJerP2PW45XGEu+KDSOD+35PKw9PxIA768fdhOjx2SAozMBYE0pXk9/UiVYGT4mvvtIJDK2zxJ9E+NHN8TlkxNRr+KPPfTAP6y/dX61W7/wQPIPl2LKZV88LLxItkljA172Gmskr9x0Y/d/qsva6bQoKEef8x7Nfrk7BZ8Uv6aPAbO+NzYqw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(7696005)(53546011)(5660300002)(4326008)(66556008)(122000001)(7416002)(71200400001)(38100700002)(110136005)(54906003)(66946007)(66476007)(64756008)(66446008)(55016002)(86362001)(83380400001)(76116006)(966005)(316002)(186003)(38070700005)(33656002)(8936002)(52536014)(8676002)(508600001)(9686003)(26005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U2OslaCT8kWYdOXu2pRBoORhhSxyKdVh7ZMKs7M3Lgdb4yGO/MJ+HRb3FouF?=
 =?us-ascii?Q?CkBWs5H1V/g2iaMitGSvmw0sxPrb6Jcz20eAWT3+ba8dLFp2mVZdV7g66uUn?=
 =?us-ascii?Q?fjMC/hDrtkkdNxR7gd6zPnN3rVqnTO3FVpLNXQiB8wycXk5xOkJlfrKbDVaU?=
 =?us-ascii?Q?0dn6JWDwLXt3TkrKGeuWa2hsHB92jrkmkMyutvs34SyiZ5514/HIhT3bkgMz?=
 =?us-ascii?Q?96yxl/C4vExEJdBIyOF8EkV4/uiEVF2tjozAED3vCOoTJucjpQEZC51BB3cl?=
 =?us-ascii?Q?rqRA26ujD4esbjl82o2wOz95EBwq8B+t749gBXZnQ65zvd1lt2azNG+gJk+a?=
 =?us-ascii?Q?JE8aEWJ+kqY7f79E787/894fl0KMIi3kv3KB7cCvWP0uvyLSwmhXZNNr2veo?=
 =?us-ascii?Q?0D74S5czNM0xbp15QMFwjTwGyC+R2El+XtTURvFGUxDCmNUr3Q30/u9dV3am?=
 =?us-ascii?Q?fAfIk0aCU2zs+zaAitl452WCeEHIr+wA7tfnY54/NRvFeQDILtZ4+lmn/82B?=
 =?us-ascii?Q?GRiLr8+GnKwluUU8S6dvPX+UcoRkDcTaS88t2wAS4KOUTzsRPahT8e7aD0kt?=
 =?us-ascii?Q?MqxEWrrrOKmZXW8zTLafT1sLoUZ7muiQ7iZuN3xQsBfDd7sMYVRj6r7qX+12?=
 =?us-ascii?Q?pClUkLq+HzwVv2ui4DvTToBxNCKZjKEV/tyrzrX9lXD3q3kG0uss2TTqLxqm?=
 =?us-ascii?Q?tSG4iSBdh57oqR4gfMGg7/9LeXCb6S0VDrueo0hqkT6eyH+Q9Wj1S68yX6U+?=
 =?us-ascii?Q?EQjS/reF2TjS191EXZ9lQFJRjvHAX8FNjwK66IK7r3zVEm5nJlUKeaSjsO0U?=
 =?us-ascii?Q?Bj26XPlr9udbvMe7vq1wbj7XTFq/tw+47Pp2winD/XYZ7sF3MMDxZ8ZnLnsV?=
 =?us-ascii?Q?RxlLnT4ONA0GR01JA8MTvf39Qd6J1nm3CSx5m9vkshdYHrsiHxLr37iaiB7F?=
 =?us-ascii?Q?O0tyDDzf77jDT/2vaMQ47zSSbGxval1KAT33W2hV9a1GpdSJFS/CvBJ+pC1w?=
 =?us-ascii?Q?U2iWiP7+PyPNam+DEr2tHUjCy8YI3Hw10DJhtQDIywsfOLAgLnWa4//bV8Ux?=
 =?us-ascii?Q?B5YFn5BkeK7T9Y1ssTO4SZVYgiEVY+LOh8kIJMZ3hWvwEU5NuuYvvpKaM97y?=
 =?us-ascii?Q?l9D4rEf/f+/p1hnoAUbNQyExbreG+7ptBlr61cOdiikGVpBBR47FslD55zKD?=
 =?us-ascii?Q?1aRMiLClGn1mSJgPNupmhT61t/lpDTXC9XDNy8aKn333wB6NwXHRK5oux/H1?=
 =?us-ascii?Q?DO2VtnoEvtUPWHrWss1gXMS5RY477hdj0NWZb6wHi7Z8Ty1jc8e4XWwIoUGh?=
 =?us-ascii?Q?i16TN9iEfp6Bhkbi6fNeTES2aL1rJ7a+MYsaJFkHYyjS6nZuX5qosAD5Pcu4?=
 =?us-ascii?Q?pjyGLTxBmYuy1ENmgT+T/8ixo2CJfFHN9b2dd6odxngRoBCeTiAdN1X+Ospp?=
 =?us-ascii?Q?5fxL47WaiRgjyUcieS4BgsxcIA/Xy2ZYaUxrSpJD1XhaYzWho/NlQuw1si5C?=
 =?us-ascii?Q?8EDpAYRB3xDfDvfERlpEWTJT8srBMtHR8Nxm1i2XdUxdr2xEe9Q+eTp0z3zB?=
 =?us-ascii?Q?xCL3fQFSQKvVgkJoK4lcOperTGO4jx0ZM87077FITMa7l4OsrYufu7sxc6vH?=
 =?us-ascii?Q?lA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485c7df0-8ca6-4ad8-f4f0-08d99826dff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 02:18:18.2577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z8NmvxsOKnwgBO8cgy4QtBW0EdJG151QXp0lgf5+lrtIRK/vi6x8kKh/MMLxeVcFBKFcRLSUXX4n+P8wXtNdLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8803
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Monday, October 25, 2021 7:24 PM
> To: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>; l.stach@pengutronix.de;
> bhelgaas@google.com; lorenzo.pieralisi@arm.com; jingoohan1@gmail.com;
> linux-pci@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> kernel@pengutronix.de
> Subject: Re: [PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link n=
ever
> came up
>=20
> On Mon, Oct 25, 2021 at 01:13:12PM +0200, Francesco Dolcini wrote:
>=20
> > Hello Richard,
> > please see this comment from Mark,
> https://lore.kernel.org/all/YXaGve1ZJq0DGZ9l@sirena.org.uk/.
>=20
> > > +		if (imx6_pcie->vpcie
> > > +		    && regulator_is_enabled(imx6_pcie->vpcie) > 0)
> > > +			regulator_disable(imx6_pcie->vpcie);
> > >  		return ret;
>=20
> I should probably also say that the check for the regulator looks buggy a=
s well,
> regulators should only be optional if they can be physically absent which=
 does
> not seem likely for PCI devices.  If the driver is not doing something to
> reconfigure the hardware to account for a missing supply this is generall=
y a big
> warning sign.
>=20
> I really don't understand why regulator support is so frequently problema=
tic
> for PCI controllers.  :(
[Richard Zhu] Hi Mark:
The _enabled check is used because that this regulator is optional in the H=
W design.
To make the codes clean and aligned on different HW boards, the _enabled ch=
eck is added.

The root cause is that the error return is not handled properly by the cont=
roller driver.
I.MX PCIe controller doesn't support the Hot-Plug, and it would return -110=
 error
when PCIe link never came up. Thus, the _probe would be failed in the end.
The clocks/regulator usage balance should be considered by i.MX PCIe contro=
ller, that's all.
It's not a general case, and the problem is not caused by the regulator sup=
port.

Best Regards
Richard Zhu

