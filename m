Return-Path: <linux-pci+bounces-6243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 827088A4B59
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 11:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB898B25533
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 09:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B07A3CF6A;
	Mon, 15 Apr 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="RKTPzYVp"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2080.outbound.protection.outlook.com [40.107.113.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22AF3BBF8;
	Mon, 15 Apr 2024 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713172790; cv=fail; b=km2j6DGBzRIEZfI/3sYcqYP/yNiTvmyScSvSpHUq6dT0EVzgga80KheM1oOfZF+vDD/jza34a7DSm8Q+S2PMSX2vwxI+4QK9B/8wp9NTj0xlSNubDqkbNeGmPGe51uh1a0vsQWGQYP4ruPF+nCVoErxWaVkUhAH1GeIr5FAB13U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713172790; c=relaxed/simple;
	bh=5oUjvLe+lv/bfoHLZ2RbsPpQX2jcIo5MRVFe3+G2h0E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZnZ5UA9eRJ/a2LcpGrMXGY0kg/w6k60lmBU8cTfksNC+M0Z5Lq8Ocb1bANQPX9lt0K+ZFcnFrZVF5DPwS9SDgL3C83tZTQs2IOJbc2Nzp2a5k3zD+TJTlxi3SBbFKW7Lz03CfPjkKjtMMGWCj8F0ld7hEFyv9LAO2EvOthhet5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=RKTPzYVp; arc=fail smtp.client-ip=40.107.113.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9wDZaNuqS6UQS0deU6nb9VIOwBVcV58pI399VAXaG1ysT4GS3d4REO30UMmo8JytHPDfuMQ/tFKvmy5F02l9SvCCNMOegi60rOZHB6PDTLWGPWdPJQ+RgmHybs/sT7+H9I2jOwrMsaCf9wYR8fAwDd9thQl7FwyDEGNPLGXm4hNTZ3fNUh7x+vcX+RZysNm8ma4tr3x94uR5bRtaFC9ekq6FPTrRn0TN/J4A4o7Zl416bJfrY1YScjddKQ8oSz8+kiMqcx0Df3a2PhutP//nQdN7XrloBpHZVkxXen9JL8781CJHm86JqWDc4j0dE1uHZLOZ6WeqU9PZpOSXbi0Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDVheFXN4US2sy4VM14fUy3HZpT+GJbmoKcZTQDys5k=;
 b=iXlfAmC9jFSOWOnDMl1RtWpSLCL/aURi/sqlD5akNIRMiEaySrRazn/mlnSh37f6VZeN9NM8gLhil+TN1APxSU29evzZAoEMvxQb2bEqJ7PlDSPY//WUIQYyw6WQN4Mq4ZtAHf1+GfRZLGON4kXNP5Ab+eYvR48owlsMNBLfdsoBe2mzqjeSRmtfmM/V95SwTmzkBrxLDB5uFcxYvFMjvEazaravkzGz20zm2BxflXbzaHvWFfBXSJfygzNGtpEniRIPWDoz6Q2SIoZceO01goII+JxDD5qCL0WMmdeWm1eCBiNMp1G5cIwbslxFsCF8oTkzf6vimHQySXTfC/ZPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDVheFXN4US2sy4VM14fUy3HZpT+GJbmoKcZTQDys5k=;
 b=RKTPzYVp5I5xBb0Gu098huxJf5m+tO8cBM+F+aN+FJ3bcfSBRM++IusfLEEbJ1ulX5JCcc/qcDEGWsb61k7wdb1pje6tCHlxzVPNJTYKZcb6nUgYC9PCHXC2UCLdwsRjC98a3OBztMq+Y6NnykVamxp2icOM/OiM/i44MeHWBxI=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by TYCPR01MB7074.jpnprd01.prod.outlook.com (2603:1096:400:c1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 09:19:43 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::11c0:4ed:1ee4:d774]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::11c0:4ed:1ee4:d774%5]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 09:19:43 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Niklas Cassel <cassel@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"mani@kernel.org" <mani@kernel.org>, "marek.vasut+renesas@gmail.com"
	<marek.vasut+renesas@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v7 6/7] PCI: rcar-gen4: Add support for r8a779g0
Thread-Topic: [PATCH v7 6/7] PCI: rcar-gen4: Add support for r8a779g0
Thread-Index: AQHajwyNpMSRo2Q6lE2om/RRCvPTULFo/1+AgAAI0PA=
Date: Mon, 15 Apr 2024 09:19:43 +0000
Message-ID:
 <TYCPR01MB11040033FABC78AD0CC459D1BD8092@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240415081135.3814373-1-yoshihiro.shimoda.uh@renesas.com>
 <20240415081135.3814373-7-yoshihiro.shimoda.uh@renesas.com>
 <Zhzk6dOkb8RXjv7o@ryzen>
In-Reply-To: <Zhzk6dOkb8RXjv7o@ryzen>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|TYCPR01MB7074:EE_
x-ms-office365-filtering-correlation-id: 998409c8-295a-46e8-6170-08dc5d2d2fd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 I/TDizYlYEWpaIwCWZ7sy1mW82M86EOqKUTr1Bz7GJNEkVnCeEOPf3Xq987O0+f+p591lfFdN3im/k0YLfiYEcmz98T0jfz/sKDreo/eBrzKZHTHhUuwZzzSwcOyJBhwl/9KM9UUbK2VIoL1wVK2+aVYz3ryDGZ0NTHaY5mCPYFMzBzyM+0vt4IsFR9ysR7bnjb1jB1fV5B/nCeGR0/pQULuQTNO07yJRAqx86+aFtgtkdovycjTitMu7IW8GZiOJ1ghV3R1Ym6gb2sIz4vIjQFaiUODrDzQeqCd9mRnhzpgi2FovBzrCG1K2ARCtmjSxvceumUL8O4MpgEfPmaexDFmzuc5W87p4d+nFhtKrkhM3RiPN1rC4Qb20mM+qDXmS2zy7cylhRRboh+9qXXSF5efkDFn6mZqC+Or4d3AKWiQSNwwQcfXeFQM5s7SX5QBU/is3+czSAMBKDNFyUXcMr3sPr+QnXFsnq8mcktuVQvVV2dcC3GUHDIbJEiZm9MT0657Q5FF7CIO9PQGXMRaNRANZfufjLzcF3vFU63C+NM+RpVyzrQQ37PhfmZXYWf/kw92DeIuJSn7K+EtOtLbH4ZGMoxfLDgDoEvWgxGFmRzibC0xFzgD9ag6UgRGymlJImen9LG08tNiS9f//rBMLmeUgFMLZ6YlpOuAyHeE2wI5Jh3TkiwuVgfXn/d+RI8OTidG/JmS9/I3mvpxA/0z3A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F2q3R9Fh0j7fciMmUNr0c7/zOk+GjVFsM/N81KjOksSu49KnaIFJWUgzdw8X?=
 =?us-ascii?Q?4qeltB8XBsHTI8mtdtmW1sauzZqvzuh5c8oBkjS18lrNozEkxOPtQIAU8MSv?=
 =?us-ascii?Q?2jKkBUydi9k4B3EmdhxSD78KdiE1o8gIHBAGo8jRcPSoNKu/Ai9R1DS472Fu?=
 =?us-ascii?Q?F6ZQ+TZGtNoUW9JUqPF5SBvhjC1uYWX68FAEOyC6WKgfudlYrJ1EfYo/edZt?=
 =?us-ascii?Q?iM6LC2DsUGVmdEgHCzWM56ec7Vf04rtdHoiFdUyxnhIr8W2VLulMVePNHMae?=
 =?us-ascii?Q?OrgyL7JEOz3lmkH0Y8rOxM6UhVnnGvOZrBEJUwWuV4lZVBfuyXsXWIkco6Oh?=
 =?us-ascii?Q?AhJkMS0FVewc9fW0mVj2/6p19Fc4GzFQ/iZsF3rGd56FG7cWkYRitjWzfU3j?=
 =?us-ascii?Q?FRRnPS8LkkmlhNMRnPKhtwYZIAxEAiRrkvsj1L+w4ERWjVukNncvr6s/pxSY?=
 =?us-ascii?Q?7lpzS0+GCz3Qh+qFIFBi5oB3o3drBe8YZVC4d6vwF/XP2LYZgEf0MjZ7uY9Z?=
 =?us-ascii?Q?jl/N6yhwdK1KzK8X7aAoMS82dp8hWXio1wyOcSp+WtP2FDZkyn3lm4Dlc/JZ?=
 =?us-ascii?Q?dd84B8y8uaUZn5QnPV+abSPDQvFHQr2gl7CXm41kIKZWVUtX2P1dgtTCftRT?=
 =?us-ascii?Q?0ntiIVeSNo31VQHF2YLNaDbLb+8T8m/tK94oUwtpNx3Sv7KNynQxVmN7wX5J?=
 =?us-ascii?Q?ABrWzFq0mBRoxCbwgNsAfqhljGe7ZRQootd//OlSQwkJSLXDeCr3KTmFXvAL?=
 =?us-ascii?Q?Aj/3XYRBlF6AWnLxxiNZaFTV7uDjZXYBW9FiLfyyr3cjGaV3N4SCVSCpYmVX?=
 =?us-ascii?Q?HKuet90IakE1/GkPInDIbTPCY+FCcQGGQzFKgT2X7ffsIZ3Ko7TO1dQ0pEuT?=
 =?us-ascii?Q?6qI9t0XlK0Ca6fzgCvZC4iBG9IziC96dWXfCd8abFNpZAPqFnnd0HIFF1qTw?=
 =?us-ascii?Q?q2rWRaDufl3o8HHlUe500KBG6yw8HG1OqWrm38y5ogg8t4AXjHDw/A0MPDhB?=
 =?us-ascii?Q?U9k25Lt2cM0WMn7VxZyL7ZYvpti7dw7Zo0kYpIP2QYIonOJ6P9777N0TDg4X?=
 =?us-ascii?Q?I6gvFPnsxVF3CAtu48tHb/Y3/Dqj/DaPa4fYcCJ/6T6WtaSWJAw1W3b83QxG?=
 =?us-ascii?Q?YKxmXg29GC4ZeaTDguAiLoo5OLd5IXP3cXiyWUskeFch01g+jGk7pShaLuQr?=
 =?us-ascii?Q?lxW4/gsv/FCJc9UdfJG6nsaKt/mhOWGByigM9UUceXEoxqH3B4xoD3lzBQw2?=
 =?us-ascii?Q?zgYpy5fsiT7VGdAWjTja/UJp6s0Lj9KCWHghrt9CzcmAbRzK2mEVAOnvvwc1?=
 =?us-ascii?Q?aXmFOuv+YN9tQtYnRCG2PQC3HcfHf8KlbJVfeHGhcYagmgeilwNvGhyWoWOg?=
 =?us-ascii?Q?6REa8SNk++encaQqu24vtc5Df1jTz2ypb9bS+NxHm1N+JtELracHKRDWRIrd?=
 =?us-ascii?Q?nSImGvO8W4w2vvWYq2mz7r4JNb+l4m2uFSfzHzC/gaYnOJWpLUlEcd/vTIVl?=
 =?us-ascii?Q?+0FP1TuS0sDaJl7v0zkqbXv/CdHmcosJoMMx1Eh67Yf3d09PQ4uxKBBYrhJL?=
 =?us-ascii?Q?QDt+IgADBpKBWF8jNdqWTFNF8BAYD2bMkJtx26aAb4gM44S1sNI/2ydEiym2?=
 =?us-ascii?Q?4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11040.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998409c8-295a-46e8-6170-08dc5d2d2fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 09:19:43.7004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 12wYmf33HaVEO0F12rnDQbSEO87Q7IgKh+96m3tBSb8wdBlJDOFrsHipOh9QYaA4I8EcYaBS8pi2F2xtO7zCb/IlGnTThXisgY6soIlUMlh8h9YpsUSm3OBnPh3LetYe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7074

Hi Niklas,

> From: Niklas Cassel, Sent: Monday, April 15, 2024 5:27 PM
>=20
> On Mon, Apr 15, 2024 at 05:11:34PM +0900, Yoshihiro Shimoda wrote:
> > This driver previously supported r8a779f0 (R-Car S4-8). Add support
> > for r8a779g0 (R-Car V4H). PCIe features of both r8a779f0 and r8a779g0
> > are almost all the same. For example:
> >  - PCI Express Base Specification Revision 4.0
> >  - Root complex mode and endpoint mode are supported
> >
> > However, r8a779g0 requires specific firmware downloading, to
> > initialize the PHY. Otherwise, the PCIe controller cannot work.
> > The firmware is attached in the manual of the r8a779g0 as text.
> > So, convert it to a binary file by using a script.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 201 +++++++++++++++++++-
> >  1 file changed, 200 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/=
controller/dwc/pcie-rcar-gen4.c
> > index 980a916933d6..4e934e9156f2 100644
> > --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > @@ -5,8 +5,10 @@
> >   */
> >
> >  #include <linux/delay.h>
> > +#include <linux/firmware.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/pci.h>
> > @@ -20,9 +22,10 @@
> >  /* Renesas-specific */
> >  /* PCIe Mode Setting Register 0 */
> >  #define PCIEMSR0		0x0000
> > -#define BIFUR_MOD_SET_ON	BIT(0)
> > +#define APP_SRIS_MODE		BIT(6)
> >  #define DEVICE_TYPE_EP		0
> >  #define DEVICE_TYPE_RC		BIT(4)
> > +#define BIFUR_MOD_SET_ON	BIT(0)
> >
> >  /* PCIe Interrupt Status 0 */
> >  #define PCIEINTSTS0		0x0084
> > @@ -37,19 +40,47 @@
> >  #define PCIEDMAINTSTSEN		0x0314
> >  #define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
> >
> > +/* Port Logic Registers 89 */
> > +#define PRTLGC89		0x0b70
> > +
> > +/* Port Logic Registers 90 */
> > +#define PRTLGC90		0x0b74
> > +
> >  /* PCIe Reset Control Register 1 */
> >  #define PCIERSTCTRL1		0x0014
> >  #define APP_HOLD_PHY_RST	BIT(16)
> >  #define APP_LTSSM_ENABLE	BIT(0)
> >
> > +/* PCIe Power Management Control */
> > +#define PCIEPWRMNGCTRL		0x0070
> > +#define APP_CLK_REQ_N		BIT(11)
> > +#define APP_CLK_PM_EN		BIT(10)
> > +
> > +/*
> > + * The R-Car Gen4 documents don't describe the PHY registers' name.
> > + * But, the initialization procedure describes these offsets. So,
> > + * this driver makes up own #defines for the offsets.
> > + */
> > +#define RCAR_GEN4_PCIE_PHY_0f8	0x0f8
> > +#define RCAR_GEN4_PCIE_PHY_148	0x148
> > +#define RCAR_GEN4_PCIE_PHY_1d4	0x1d4
> > +#define RCAR_GEN4_PCIE_PHY_514	0x514
> > +#define RCAR_GEN4_PCIE_PHY_700	0x700
> > +
> >  #define RCAR_NUM_SPEED_CHANGE_RETRIES	10
> >  #define RCAR_MAX_LINK_SPEED		4
> >
> >  #define RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET	0x1000
> >  #define RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET	0x800
> >
> > +#define RCAR_GEN4_PCIE_FIRMWARE_NAME		"rcar_gen4_pcie.bin"
> > +#define RCAR_GEN4_PCIE_FIRMWARE_BASE_ADDR	0xc000
> > +
> > +MODULE_FIRMWARE(RCAR_GEN4_PCIE_FIRMWARE_NAME);
> > +
> >  struct rcar_gen4_pcie;
> >  struct rcar_gen4_pcie_drvdata {
> > +	void (*additional_common_init)(struct rcar_gen4_pcie *rcar);
> >  	int (*ltssm_enable)(struct rcar_gen4_pcie *rcar);
> >  	enum dw_pcie_device_mode mode;
> >  };
> > @@ -57,12 +88,144 @@ struct rcar_gen4_pcie_drvdata {
> >  struct rcar_gen4_pcie {
> >  	struct dw_pcie dw;
> >  	void __iomem *base;
> > +	void __iomem *phy_base;
> >  	struct platform_device *pdev;
> >  	const struct rcar_gen4_pcie_drvdata *drvdata;
> >  };
> >  #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie=
, dw)
> >
> >  /* Common */
> > +static void rcar_gen4_pcie_phy_reg_update_bits(struct rcar_gen4_pcie *=
rcar,
> > +					       u32 offset, u32 mask, u32 val)
> > +{
> > +	u32 tmp;
> > +
> > +	tmp =3D readl(rcar->phy_base + offset);
> > +	tmp &=3D ~mask;
> > +	tmp |=3D val;
> > +	writel(tmp, rcar->phy_base + offset);
> > +}
> > +
> > +static int rcar_gen4_pcie_reg_check(struct rcar_gen4_pcie *rcar,
> > +				    u32 offset, u32 mask)
> > +{
> > +	struct dw_pcie *dw =3D &rcar->dw;
> > +
> > +	if (dw_pcie_readl_dbi(dw, offset) & mask)
> > +		return -EAGAIN;
> > +
> > +	return 0;
> > +}
> > +
> > +static int rcar_gen4_pcie_download_phy_firmware(struct rcar_gen4_pcie =
*rcar)
> > +{
> > +	const u32 check_addr[] =3D { 0x00101018, 0x00101118, 0x00101021, 0x00=
101121};
> > +	struct dw_pcie *dw =3D &rcar->dw;
> > +	const struct firmware *fw;
> > +	unsigned int i, timeout;
> > +	u32 data;
> > +	int ret;
> > +
> > +	ret =3D request_firmware(&fw, RCAR_GEN4_PCIE_FIRMWARE_NAME, dw->dev);
> > +	if (ret) {
> > +		dev_err(dw->dev, "%s: Requesting firmware failed\n", __func__);
> > +		return ret;
> > +	}
> > +
> > +	for (i =3D 0; i < (fw->size / 2); i++) {
> > +		data =3D fw->data[(i * 2) + 1] << 8 | fw->data[i * 2];
> > +		timeout =3D 100;
> > +		do {
> > +			dw_pcie_writel_dbi(dw, PRTLGC89, RCAR_GEN4_PCIE_FIRMWARE_BASE_ADDR =
+ i);
> > +			dw_pcie_writel_dbi(dw, PRTLGC90, data);
> > +			if (rcar_gen4_pcie_reg_check(rcar, PRTLGC89, BIT(30)) >=3D 0)
> > +				break;
> > +			if (!(--timeout)) {
> > +				ret =3D -ETIMEDOUT;
> > +				goto exit;
> > +			}
> > +			usleep_range(100, 200);
> > +		} while (1);
> > +	}
> > +
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_0f8, BIT(=
17), BIT(17));
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(check_addr); i++) {
> > +		timeout =3D 100;
> > +		do {
> > +			dw_pcie_writel_dbi(dw, PRTLGC89, check_addr[i]);
> > +			ret =3D rcar_gen4_pcie_reg_check(rcar, PRTLGC89, BIT(30));
> > +			ret |=3D rcar_gen4_pcie_reg_check(rcar, PRTLGC90, BIT(0));
> > +			if (ret >=3D 0)
> > +				break;
> > +			if (!(--timeout)) {
> > +				ret =3D -ETIMEDOUT;
> > +				goto exit;
> > +			}
> > +			usleep_range(100, 200);
> > +		} while (1);
> > +	}
> > +
> > +	ret =3D 0;
> > +exit:
> > +	release_firmware(fw);
> > +
> > +	return ret;
> > +}
> > +
> > +static int rcar_gen4_pcie_enable_phy(struct rcar_gen4_pcie *rcar)
> > +{
> > +	struct dw_pcie *dw =3D &rcar->dw;
> > +	u32 val;
> > +	int ret;
> > +
> > +	val =3D dw_pcie_readl_dbi(dw, PCIE_PORT_FORCE);
> > +	val |=3D PORT_FORCE_DO_DESKEW_FOR_SRIS;
> > +	dw_pcie_writel_dbi(dw, PCIE_PORT_FORCE, val);
> > +
> > +	val =3D readl(rcar->base + PCIEMSR0);
> > +	val |=3D APP_SRIS_MODE;
> > +	writel(val, rcar->base + PCIEMSR0);
> > +
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_700, BIT(=
28), 0);
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_700, BIT(=
20), 0);
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_700, BIT(=
12), 0);
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_700, BIT(=
4), 0);
> > +
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_148,
> > +					   GENMASK(23, 22), BIT(22));
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_148,
> > +					   GENMASK(18, 16), GENMASK(17, 16));
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_148,
> > +					   GENMASK(7, 6), BIT(6));
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_148,
> > +					   GENMASK(2, 0), GENMASK(11, 0));
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_1d4,
> > +					   GENMASK(16, 15), GENMASK(16, 15));
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_514, BIT(=
26), BIT(26));
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_0f8, BIT(=
16), 0);
> > +	rcar_gen4_pcie_phy_reg_update_bits(rcar, RCAR_GEN4_PCIE_PHY_0f8, BIT(=
19), BIT(19));
> > +
> > +	val =3D readl(rcar->base + PCIERSTCTRL1);
> > +	val &=3D ~APP_HOLD_PHY_RST;
> > +	writel(val, rcar->base + PCIERSTCTRL1);
> > +
> > +	ret =3D readl_poll_timeout(rcar->phy_base + RCAR_GEN4_PCIE_PHY_0f8, v=
al,
> > +				 !(val & BIT(18)), 100, 10000);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D rcar_gen4_pcie_download_phy_firmware(rcar);
> > +	if (ret)
> > +		return ret;
> > +
> > +	val =3D readl(rcar->base + PCIERSTCTRL1);
> > +	val |=3D APP_LTSSM_ENABLE;
> > +	writel(val, rcar->base + PCIERSTCTRL1);
> > +
> > +	return 0;
> > +}
> > +
>=20
> Is there a reason why you didn't chose to implement this as a PHY driver
> in drivers/phy ?

This is because the initialization needs both PCIe and PHY registers' setti=
ngs
alternately like below:
 Write PHY regs
 Write PCI regs
 Read a PHY reg
 Write PCI regs
 Write a PHY reg
 ...

Best regards,
Yoshihiro Shimoda

>=20
> Kind regards,
> Niklas
>=20
>=20
> >  static void rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar,
> >  					 bool enable)
> >  {
> > @@ -200,6 +363,9 @@ static int rcar_gen4_pcie_common_init(struct rcar_g=
en4_pcie *rcar)
> >  	if (ret)
> >  		goto err_unprepare;
> >
> > +	if (rcar->drvdata->additional_common_init)
> > +		rcar->drvdata->additional_common_init(rcar);
> > +
> >  	return 0;
> >
> >  err_unprepare:
> > @@ -241,6 +407,10 @@ static void rcar_gen4_pcie_unprepare(struct rcar_g=
en4_pcie *rcar)
> >
> >  static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
> >  {
> > +	rcar->phy_base =3D devm_platform_ioremap_resource_byname(rcar->pdev, =
"phy");
> > +	if (IS_ERR(rcar->phy_base))
> > +		return PTR_ERR(rcar->phy_base);
> > +
> >  	/* Renesas-specific registers */
> >  	rcar->base =3D devm_platform_ioremap_resource_byname(rcar->pdev, "app=
");
> >
> > @@ -517,6 +687,31 @@ static int r8a779f0_pcie_ltssm_enable(struct rcar_=
gen4_pcie *rcar)
> >  	return 0;
> >  }
> >
> > +static void rcar_gen4_pcie_additional_common_init(struct rcar_gen4_pci=
e *rcar)
> > +{
> > +	struct dw_pcie *dw =3D &rcar->dw;
> > +	u32 val;
> > +
> > +	/*
> > +	 * The SoC manual said the register setting is required. Otherwise,
> > +	 * linkup failed.
> > +	 */
> > +	val =3D dw_pcie_readl_dbi(dw, PCIE_PORT_LANE_SKEW);
> > +	val &=3D ~PORT_LANE_SKEW_INSERT_MASK;
> > +	if (dw->num_lanes < 4)
> > +		val |=3D BIT(6);
> > +	dw_pcie_writel_dbi(dw, PCIE_PORT_LANE_SKEW, val);
> > +
> > +	val =3D readl(rcar->base + PCIEPWRMNGCTRL);
> > +	val |=3D APP_CLK_REQ_N | APP_CLK_PM_EN;
> > +	writel(val, rcar->base + PCIEPWRMNGCTRL);
> > +}
> > +
> > +static int rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar)
> > +{
> > +	return rcar_gen4_pcie_enable_phy(rcar);
> > +}
> > +
> >  static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie =3D {
> >  	.ltssm_enable =3D r8a779f0_pcie_ltssm_enable,
> >  	.mode =3D DW_PCIE_RC_TYPE,
> > @@ -528,10 +723,14 @@ static struct rcar_gen4_pcie_drvdata drvdata_r8a7=
79f0_pcie_ep =3D {
> >  };
> >
> >  static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie =3D {
> > +	.additional_common_init =3D rcar_gen4_pcie_additional_common_init,
> > +	.ltssm_enable =3D rcar_gen4_pcie_ltssm_enable,
> >  	.mode =3D DW_PCIE_RC_TYPE,
> >  };
> >
> >  static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep =3D {
> > +	.additional_common_init =3D rcar_gen4_pcie_additional_common_init,
> > +	.ltssm_enable =3D rcar_gen4_pcie_ltssm_enable,
> >  	.mode =3D DW_PCIE_EP_TYPE,
> >  };
> >
> > --
> > 2.25.1
> >

