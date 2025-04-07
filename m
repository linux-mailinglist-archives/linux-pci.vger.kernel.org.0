Return-Path: <linux-pci+bounces-25360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74232A7D5BE
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 09:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38AB13B4869
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 07:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11DF22DFA1;
	Mon,  7 Apr 2025 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ThZgJr/w"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012047.outbound.protection.outlook.com [52.101.71.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCBD22A7FE;
	Mon,  7 Apr 2025 07:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744010318; cv=fail; b=E1YluP/D9wezYgReOP//d5HSfI33ijlJuOMcvmGiBjV0Www29GEsk/ZZ25K3NJS8wJ1FQwynNkhh5EUVHOo0Lqm2gdIG7zj6IGAWIZrngvvazHDEpUztcuHnxUF+8ojPYt1V0FG3sWW42G5jhaLBkrJ1MvVft62IVaKCg8u3QMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744010318; c=relaxed/simple;
	bh=ROWUsargyfr8ZG+N1WJ5DBvr1QhALHkdfoHdCZSrGF0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eAX4NKl0LyggHYzERxsVAHFZBuj/cuuymEMCJMknLK48e8Ve1AgSnDPSCllLqdDzQ1qT0kLfD+pflFsrrcs1Sc898DmF8O9YvlyPQmbVK1ske5+2pWhyLgCODhK51smEy7MYDJj26GDRvucPQUTMrWvPrLPk9dd8vKoXPLpGfAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ThZgJr/w; arc=fail smtp.client-ip=52.101.71.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UavpF6fWfWVmS/zGSRhO6lUn0wFeBxy85uyPL5LbllVfP7CKt8R+I9IlzwXb0WuomuSq169Jk9IFLGnsvvvYOR/cS6Fqrc1Hr8ztPOlViqmk+V8/8V1GxdTUxy7N2GF41S/iNpWH17nTLVLU/5dWbmFAO6u8lEGF1ca4GU6R3T86xrcFgtVcLEu/ZN4dVHQmeoEdk0qlcmNF+HqMv8ukkJINaA7rx6a+oNzULsOM3Lzt46Gl0aUMb7L7QDdO/bereftlOk5bDuc7zckvCk4ARns2BltjjW6ZQ2RutvRhFxtKNA6Bw7H/MGhZyq1ALZIvGz7IWunmvbL63/YZ1iptzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plncZWp54IVxWWNCLH8XiTMR2lKfeg+TQI/HBHLV7yU=;
 b=VSA6e5qiD/17XSmrqaEyv7GzR0p65FcycKIeAqbRMm7+XAncywNM42IVbNEHDhs9mPJpPYTBRF7GJbR2Qhq4UXSqaPtXntQQYHAuEYE6vaQoEpzkv0VdGeVwZXoGd1qGtNRGi2bQOq8cz6aoTBF9dMUi27stoTdQKAyzR/Krlukr0bcHbaMn8jrVw5quk9NGPDz8jyNDH1wHASZs1zpqHPzEENL1o/Q4BZjsV5GVYGaLq/fjNoFwjb+RkHCWdl+AYnqoOFmOqPUH5B91TDQ0+eUoqbaU4BV7gswU5jof4iv+DeH223VcR5LtUPLpHkTS4tsC7+UHC0ryxhKuJjK6VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plncZWp54IVxWWNCLH8XiTMR2lKfeg+TQI/HBHLV7yU=;
 b=ThZgJr/wPo92Rf7hiaoVtfbP3WGTUD26KB62r6ftq+9WGdWwPZsfLQlm58aMnJsFJBPHnvHsvRBmGmfz6YpO04HYcjO7XkU+HODRxffdgTUJtxBS7CFb0D6wZCLi+LN7gizsPzeUk4/5aCu2gR74SmtO6XvZvf1U+e/42LTyuPIcWlqcsmakwVnK7YMFsa6hhNQlTbhvKkuXI910vZ4UMWiXO3z5ASJ/DtCJp84k2/SVLrV6x3ayRYRh/+0woaQzX9kSwP7XpjmjpgnGnttW5//FRdY9Oh1qRqFJkXZsA2wh/L9d3V3M2b6r5wqx0J4rLbNk5wrUVFMSmqCA2T/jyw==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 07:18:32 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8583.041; Mon, 7 Apr 2025
 07:18:32 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 2/4] dt-bindings: imx6q-pcie: Add wake-gpios property
Thread-Topic: [PATCH V2 2/4] dt-bindings: imx6q-pcie: Add wake-gpios property
Thread-Index: AQHaLabE+/mqsANsskSLK4N2coNpALOWMC4AgASMryA=
Date: Mon, 7 Apr 2025 07:18:32 +0000
Message-ID:
 <DB9PR04MB8429588E7CF00BDC9CDA863F92AA2@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20231213092850.1706042-1-sherry.sun@nxp.com>
 <20231213092850.1706042-3-sherry.sun@nxp.com>
 <20250404094130.GA35433@francesco-nb>
In-Reply-To: <20250404094130.GA35433@francesco-nb>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|DB8PR04MB6858:EE_
x-ms-office365-filtering-correlation-id: 0a90a64a-97ab-423d-1db2-08dd75a46780
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HAPhqp6vLUacYPob+iCQkL697/l1140STVhBs7WDHvwG8g9+Z/UHlC8RuNk/?=
 =?us-ascii?Q?zHYLLgguDkzapmlisrMSzFPScpB0Wya4vhnlXSgwxWQDsP+v/CD7zGDVnGTE?=
 =?us-ascii?Q?pBthPR7h6kyXQD1USvBGR5zfdeGAcEIxMq39SoMwKV+BfjlTXVNdntFJ3quD?=
 =?us-ascii?Q?0cu2pqB9iBjuevshb2s7rFTXGj2cPJ5r6DBrJ7wXrI/FwoLC64MA0ShvCRHs?=
 =?us-ascii?Q?Vu9aJ7dqzrVbmoNlpAXsuqPLJ8zp2t/qEFhNj2oEuVfHCg7dr32+N9iMPQpt?=
 =?us-ascii?Q?3jHiWG5dHjBtc5/qdJR5jtHwK3tTthLFZqQJK5s9UTjs5StmknN1R/7fw98p?=
 =?us-ascii?Q?Jdxj29uCcaJR1Ss7m3vkP3Hk7XEEeUZ8fUTUSQhiMC1u26rYA3lip+mLaeKs?=
 =?us-ascii?Q?jjsb6I71/jHfYCStEZLeWttOxoaN638IiU05YPoaWJHnZvqUK3Y/RuLzyw8x?=
 =?us-ascii?Q?2v4zl9n4h4wLe6H4OWSCMNf2KVmo7WxW2R9KaDA/ye+LDiKxCEsLPpbb+jN2?=
 =?us-ascii?Q?gEKmISgkpM2nka3oX2WQD1ihWZ29hvDP7NsHQX9RcHKl8YNVynKoRW3N9+YZ?=
 =?us-ascii?Q?E7bCN+VZlovCPHfWE2JmDou5K+cHEebp71oQhKXLTngAApb+yU83YBwmbO55?=
 =?us-ascii?Q?YE1+x/yU6UbUNlqFb628Ccx3MmYAdBZPEvutbeBrbi5MFH23dqa9lRoFDvkg?=
 =?us-ascii?Q?y7TrDQytiK03aqUjvjopiUQcPIxCD54i9+e2eqHk5LOsZQNt90wjRmkwoQEL?=
 =?us-ascii?Q?ZoOS+fb12luCnmdsF7fdXJf8hrS8wnu8Ja8lIY2jMsGm8n8KtJcXkAkX3zBU?=
 =?us-ascii?Q?M3uqHrSmo8Ri9qlPQpADq17JJqQej0l8+PgM5bFEuHmgPJFuJcXF85gW8naa?=
 =?us-ascii?Q?gCQePM9LWDzwczCmpyw3nwXgETTdBsSwL2/rr3TglQWnR8xnWmUtBfV5KfLh?=
 =?us-ascii?Q?yLxfko7zi2tnuCyg9Em6gTaSVIkrGnTrETikjxKlsfG4P87uXn1VzWVxXxG1?=
 =?us-ascii?Q?loCkjnIHCqAgaY5rkUramWme4Vrpw9uOOAyj1MgLvBp5mM24DKqBz5Mx7wi+?=
 =?us-ascii?Q?1H7jipQiAm54ePd9B97YrYsh2XX9zOcL3Ts+nynVc+tDzzMfhPEDROw/qd0y?=
 =?us-ascii?Q?9oiUIA7z3ieI/n5KNd3BG8V+OJusJ4KvqQCykPRgawjTIA9Do2BinAba3XvF?=
 =?us-ascii?Q?9JtHU+hVMd8JZrmny2y+4jerTkp+28XWMsDbETeXKHf8eGTW1jzgycFQCyi7?=
 =?us-ascii?Q?xcP9Lmdb+VKBUj0TM0Ry8JnJkwzJK5lf0vqXv6Eq7FE18k2jq20PMiqZxst3?=
 =?us-ascii?Q?WNwFkk3reRcgVHu9u6WV5EB9s8pChFPixqIOTpdpItmmuHh7Pz/czkpzIQqj?=
 =?us-ascii?Q?ssyjbUPV2m5KM82O5Hg6bGsA1t/RJX5DvxRf4z1Wuut403rofMunsCxSsoA/?=
 =?us-ascii?Q?SRQdkXfCWmOPoqbZvy0BnKL2g8B2OVU5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?016VoYNL78HCQQnipc75oFX+A1yW+tjZ8wQpsG3zCEtnjZzJDBovdXqdgwpv?=
 =?us-ascii?Q?S+N6a9odEQ6lCr5BzjW1tJ0+vezyzAhOaKGiTHt5ZVCYOQftLFLqQb69kMUI?=
 =?us-ascii?Q?JX9OOAOJS3dO5mt3bia4pAdtxEqSBXxkcs1OkQv55Wch7bv6WAawxDmnN4nY?=
 =?us-ascii?Q?GwmOKjoO1kP84xM+Crdzyfs+Ibzjst/WP+uyOGrmap9PegYswU98RD3MlXts?=
 =?us-ascii?Q?ZC2jTKLcUfximA6KELQ+Cin6a4AVTnou2e2VFt8WUapXPmEelWIVdpsuBZnr?=
 =?us-ascii?Q?4aETo+HXl9Qj8TqfzT2mZbdyRBJdt8MgVO8DMqMiyH3pY0ugRfkSHIdbHoD3?=
 =?us-ascii?Q?UFGKV1nCwkMVDG7aVmxYncWZXXITx/c7Tb+JLonKFBgnMEY/yLyOX3Lpfr8i?=
 =?us-ascii?Q?KMmcIn2uDMDk7WaCvMp6A0xJrksWqkSzmPib5rku/hqWIr84R7cK73Wi7Vki?=
 =?us-ascii?Q?MmY4Oy7KV3BhIZHptfXHQJ1gKITCBY3UojzcxtXrLIyLHUhjZzljrmStVWa7?=
 =?us-ascii?Q?1Skzf6ju42fzk0AC+R5JX9A3TqEMOFbm0L7yZG7oLogU/0qFa6LSOFphgE2q?=
 =?us-ascii?Q?6VDv4muQvNEI4Uw2qkKz0S7U0LtzpKLm4tsUop3VEzlSgQQ63JAGn1yhXdSi?=
 =?us-ascii?Q?ilZOV0DiSQg8jbO6QtKhxRNpvPEJQIA0hRR2vM+8KDEFjGcmiIaHdgePTM/S?=
 =?us-ascii?Q?A0pnBL6sLSV3rWd+BxL3meIv+dCUZ64kWfBkaekQn3pYJq4JFfb/ubsrNqwm?=
 =?us-ascii?Q?q08rWB5TLWuZGOMcnVmxBuuLAY8LqeAjlTUmlnHXfOKVNiEfaqqGTsRypeMO?=
 =?us-ascii?Q?g/+PZ0/LsG4ItBWHDeHmUggxTjaQdUKwOA04eItG73e2VFPDU3oRXLqBBqLg?=
 =?us-ascii?Q?IdVfiXq0xRfG56DvqiQCx1YJHlGQ255DsZ3HJIRgj2cWa4A/Iv3YRRjVWzuY?=
 =?us-ascii?Q?CRd1bac48fi2H8mP4z9KjJv8ChNmEQIzYLJGlyL2NFsEMdeQDc8bHN+bdTo8?=
 =?us-ascii?Q?ePt4VRICEC9o42n4k1sOKm01PKdapRdOZUYwiGLJySUI1Ssb4XWC5TaF1s1m?=
 =?us-ascii?Q?A/5zBWH5Tqk3SaZ8/YBtoqYNGdUH3vJKVBjQynOvX0JDwU45dMcIi03th8zp?=
 =?us-ascii?Q?j8y7B/H5qcC7gRm4vVDhbp7Kt8X0EBhCR5o0nMkeUerQvf0I/8+hGgOJUKjn?=
 =?us-ascii?Q?k7k+Th6tPbGh0Ma/fXs0D7gXDwHuHdG3dJ3g8diM3HQesYI2KuDOF1CWDljK?=
 =?us-ascii?Q?hZvxbcehPhvE7AT/JhBXcOhfbMq8r83mOYOyRNjj8ExzyXT1rZiDHeNKtEKx?=
 =?us-ascii?Q?K3EwiK7m0+dkZJMCVOdHV/HiyO1hjhCagQixh0/sd+zzfMspe1RM6h8OqE+Z?=
 =?us-ascii?Q?ExdExispzvLmUr2RrVywLnBHQOK8VVHd5V9ZzSioVxQZrwj+kJYoViODJK6s?=
 =?us-ascii?Q?woVXTLeQH755LEZVfCxosBoT4qJquuiCZGTYrq6tgBJdx0D2txq0xelr20DY?=
 =?us-ascii?Q?rW7OnfXargqwWq1GvdjC2pjBNIWeJktl/c5pYb3k4xB/En1nT6csvyHOBQr6?=
 =?us-ascii?Q?tAaZMKMtrP6TmWfXqJA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a90a64a-97ab-423d-1db2-08dd75a46780
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 07:18:32.7500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zePYGErRNsxnqe5jRR07qO3ZKpl02JtMxAmZJsogP8KzSk2Ydg4yUlAV572rpE9W9hcstYQ4MamJq9XB+duy+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858



> -----Original Message-----
> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Friday, April 4, 2025 5:42 PM
> To: Sherry Sun <sherry.sun@nxp.com>
> Cc: Hongxing Zhu <hongxing.zhu@nxp.com>; l.stach@pengutronix.de;
> lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> bhelgaas@google.com; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-
> imx@nxp.com>; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH V2 2/4] dt-bindings: imx6q-pcie: Add wake-gpios prope=
rty
>=20
> Hello
>=20
> On Wed, Dec 13, 2023 at 05:28:48PM +0800, Sherry Sun wrote:
> > Add wake-gpios property that can be used to wakeup the host processor.
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > index 81bbb8728f0f..fba757d937e1 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > @@ -72,6 +72,12 @@ properties:
> >        L=3Doperation state) (optional required).
> >      type: boolean
> >
> > +  wake-gpios:
> > +    description: If present this property specifies WAKE# sideband sig=
naling
> > +      to implement wakeup functionality. This is an input GPIO pin for=
 the
> Root
> > +      Port mode here. Host drivers will wakeup the host using the IRQ
> > +      corresponding to the passed GPIO.
> > +
>=20
> From what I know it is possible to share the same WAKE# signal for multip=
le
> root ports. Is this going to work fine with this binding? Same question o=
n the
> driver.
>=20
> We do have design exactly like that, so it's not a theoretical question.
>=20

Hi Francesco,
The current design doesn't support such case, maybe some changes in the dri=
ver could achieve that (mark the wake-gpio as GPIOD_FLAGS_BIT_NONEXCLUSIVE =
and the interrupt as IRQF_SHARED, etc.).
But usually each RC has its own WAKE# pin assigned. We have not come across=
 a case where multiple RC share the same WAKE# pin.

Best Regards
Sherry

