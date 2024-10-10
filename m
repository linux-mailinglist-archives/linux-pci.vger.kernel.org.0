Return-Path: <linux-pci+bounces-14133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B37997C14
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 06:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC9A1F22F68
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 04:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3404A15;
	Thu, 10 Oct 2024 04:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="miA3NePx"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CBD3D6B;
	Thu, 10 Oct 2024 04:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728536392; cv=fail; b=U+pn57gfgkd883E4lCXP+7h3DIgnJJ/sFh2hcy3DeqG1ceZ2JyN51kVMkTKjkOlbzlqDG99f4WVJUuYrORmxpoDjwMegTjnVcTj9MyRqW18vPTjDwjMRmI8jT/powBli2wHET4Vjm4k9p+PjNeG8wSN3P00Zt0kktOn3CDPz1Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728536392; c=relaxed/simple;
	bh=+J4m7XEd60oQfdOSzbsvVsi5y8GjAm1dUOK0HMN/Cvk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ah2ZK9X6WXmHuyGMveZcSwrRYl60OJVQ7VmXYbMK2k0sSs9KgREx0MXdhNhIUkrzu3/JmCWkOOjYY4oYdxFsmOWMkzWw6HmKWDrN0bmqSF64y8DVhuaFxgkNZPpBhuGAbEw5iTht/fUFaHe5tr5o2e/Hpe+Lgf6iAgzCL+tpYOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=miA3NePx; arc=fail smtp.client-ip=52.101.65.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6FdKHFeW4lcFASTqFmdZl5F2ckn9WbTU4dgdpJpb3cUGQoAWSI3hAtIXeOvncEyBs0lbj6WnYIOITBJqpQBCV9ctIfVL4W2NUZLMkcIB4ZNts49V2OCKLCKAf1pf2hLOVr6Wq9O1TbrxK+rB/HcJBLAQ9I2o1vRC3PnwAunBs4vIaEDEC62y+JwCpVyw85N10DV9nzdeSNV/mWNrBEzFrG/4ZTgp45o99jtVUpMGr/N/iJh5pna32uyXpexELzwEbTLc38lGmTAvpPXGzQrn/NTN5Sro/48hCVfqoyH5GK/wfCL7I2xr+0Mjx0c0syuooNoR3r8fYz23J4JsktPXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVASvSTLOll3Xc+pRzRkO08UgkzPZME1ztNdZxKsQnQ=;
 b=mhs8GTjRyzZmZJemmxBz/Q2bVxpIFSGuyZjWYyN0CGbQNxWJoB4BVdKXZFaPzDV/aFKi3WcRye1jJDa1t57qnPvGVWnfd50tNklP1r4Vyb2Cbxr3xE6zUaqrbRTIBBaOGBHZfGu8x6hG9CZ8fcNA0MF3tXbqeuLp+Iwll7UKd2sBP8QKznK/+5+DYeQdJ/3rpw9oqbwVwI/QxzPoGbLdTqes2A0MybohS2GiMDvmftEf6OqF8s/BUcZQ43XqsnNh/ASiJjN+yNIPckklGebLa/Cad8YRGvX0cXU6KUf6E0pFYMlXWxqX8HWjn4RtVj3NhZ6FZjjB9cvguWxs57pAUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVASvSTLOll3Xc+pRzRkO08UgkzPZME1ztNdZxKsQnQ=;
 b=miA3NePx6zKeRrcPMhpw97I/T4afscbLpwTA6l9y7HpW8kYP0WZPOCLaUpg88l6Ew9jLmZn+2q8q8evfcJLGpV7hHbACbKOV5qJuJKT9pPSkIaQ33iPtCpoN5MI2a0VT4K4ns2pktmzu1tNCXhnw27CPbKXabG5K33cyfA6draYm4WtToRV4CbitJ5bwvxWl3mCIFnc/INxCPHO9IH/X4jgU7vhp4NzmM1nkeq3BDRT/1grcyq3gJBP06mp3PJVU4SdhgeNBc+ux9SBpMSTMRh0HjWJ4+kMRqHlXpLtb2+7735CrBKXclf9fNDfNuIY4oAfCmp/8nMibBl8BNLGOyw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7985.eurprd04.prod.outlook.com (2603:10a6:20b:234::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 04:59:45 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Thu, 10 Oct 2024
 04:59:45 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH net-next 10/11] net: enetc: add preliminary support for
 i.MX95 ENETC PF
Thread-Topic: [PATCH net-next 10/11] net: enetc: add preliminary support for
 i.MX95 ENETC PF
Thread-Index: AQHbGjMCRp6WYylLaEyKPUuJKhwhaLJ+sHIAgAClOHA=
Date: Thu, 10 Oct 2024 04:59:45 +0000
Message-ID:
 <PAXPR04MB85100EB2E98527FCC4BAF89B88782@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-11-wei.fang@nxp.com>
 <ZwbANHg93hecW+7c@lizhi-Precision-Tower-5810>
In-Reply-To: <ZwbANHg93hecW+7c@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM8PR04MB7985:EE_
x-ms-office365-filtering-correlation-id: a9c54c83-4592-494f-38a8-08dce8e85bec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wc6WEDo0GCE7dw1sET1BNxCd3gMNRdDY5TTyJcI7PUSi9OoA2cXtcIwWrCHv?=
 =?us-ascii?Q?iLu5WMQ+sca4V+Xp7Uenwi/FMX5By7z1LWVNMq0UVcdqHPIOX0ZaZkKDfU//?=
 =?us-ascii?Q?gbfXmIS8XDI6kDzIxKWaKwlLlhG5WzLJu4jeAWYWeL0TIqANN9fHaio5zJXg?=
 =?us-ascii?Q?+4oCE7Wxn/QCoFT3qDiJNyuZ2jCTJcE6bxZQkmsVRw40q2J1l5r4GOAHszA6?=
 =?us-ascii?Q?K+hTIKSDBPiwPowlfV50nM+vmkz+aFSxFjbxDZ89K2GnZj3nJbDpavozgk22?=
 =?us-ascii?Q?y+LdO+NroC77elv7HKFo1+6v+mlwI3AKVBfhy5jIlYJBeGAmoPFlHfKx2AnD?=
 =?us-ascii?Q?UDSGUQLp2QEqgiu55GoKC1tq2Zu/As4Y73ttedOjXEDZyrz2RLREcnb0w1ON?=
 =?us-ascii?Q?sHFsiQnZLp3eo5nO4+PBZ56P1v45LgKn9OJ+Nv9W1Ej/7sgvpu7MNfi5lZwu?=
 =?us-ascii?Q?vqc7jf9+Zqnd1e1M5EC/Lg49VJTdnUDbDieijq1/Fjd212Kgtq0IgWRnYEsi?=
 =?us-ascii?Q?czgTKG7RkdoY8T7m52nvPRCSelaMuNHhOqHDmFORJJz4y1arikYRoFspFPbk?=
 =?us-ascii?Q?2t1uYJ1LUY5FxJ4I2lYmbxhhkrwSuXQq3b6KU6MU/iPY2bEFwaCoZfGY2vcL?=
 =?us-ascii?Q?A/G2xrlVdSiAYMl6jMZQ6Tpox7F3xHIbm0JMcKQEEHrD5NhfFB7v65Tvr3N+?=
 =?us-ascii?Q?yyFeK3GzJRpw9CqnNsPIWQPvtRe77vSzQ9UlQNRcbZaERyj+bhT88SVdofM+?=
 =?us-ascii?Q?VGsPgwWkSdWwM/0y4Xjh6aWvs2UIwWAriyvB5NxsqXp3OobbDjVscfovLyiQ?=
 =?us-ascii?Q?WL5D2kkqbBa3nL6g4nS4yysrhY+P0PN+PuTkv05g0pvoG8J+O6RLmmtKHZiN?=
 =?us-ascii?Q?sg8FKudMLrgHcntXzod1A2WIRwCklIOeAaSeqA3TQL7mTdiUli6ze3Ayo68A?=
 =?us-ascii?Q?d4kP7e0mT9+B5wYtVCu4vWvNGWbLNX4GlLHCvr/dMCQnQAvuPv2cH1LvSR2x?=
 =?us-ascii?Q?h0DlS/zf9uxb28TkKBjYhcGsx30nHp1ZDnYdopwnt2q/6vhLr+tmhObulYa0?=
 =?us-ascii?Q?JWk16nXEaHgadQNNNvoPWBCFEzZGvU1HM8o7WxEIIXrr+kq+o9XmxFTC+4eh?=
 =?us-ascii?Q?rGHBB2izBQXcJsgIjc/lgVO4ivP6Lc+rCTkFhtkhc7T2I4YzUVDhwvs6FmFA?=
 =?us-ascii?Q?GnjwJsu2pNwwUgKblqndnFjK9Eok9NcCgpi54pGNHESNZrP/Ij6UGOGKLxki?=
 =?us-ascii?Q?bbiAaEgi0H3R2y5jzkU3g9UOz0IIoCiLmHXCDKKIItbGNPtbN+aG+1yQHBjS?=
 =?us-ascii?Q?OBHv7iH6xOe2yc0auyTmq3Mc/ZtFzGQ+fpj70y63IubExA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZTmjDs3IJPvyEwXwR3a84KbVEZqYSS3CFBKFfYnTNWNo2koiL20pvDrHSOtM?=
 =?us-ascii?Q?3xeWATcMEjzj983+vymEx23f8eNW5qkU+os9P4QBlAWg+GGhFxBPmEayx4Fa?=
 =?us-ascii?Q?dxGIfWwuIfYrPxAR4jleZeKnH4wq8y6nRSNb8GrJO3uSqgG5Fbd+OYqdWnNj?=
 =?us-ascii?Q?zx+7aOfnmTin7J+8ZKpUq1LV5mtiCtcR+0yq5jQ949YQDbCMym/0pV4nEJkK?=
 =?us-ascii?Q?ODvZbXNdbk0RNgmhjMxntYcZbxduxzSSMGZ8CMJL2rjkykcU/EuGuKcNyvwx?=
 =?us-ascii?Q?k0YIMkmHulXf8IJ2CmGodws3zK3oeIt402ScT2g2gdTEqI8CCIF+KYqgMIeV?=
 =?us-ascii?Q?tpIjr3ulVP9aozxG8MdCmKA5ixtBDfPcXoSxFv8Yf51Qu3HD1TwejcsNl71Q?=
 =?us-ascii?Q?mZHl9EAdBbzGCqTuuWUoM9XmMIcuLdlDjh+yhTPDkR7osrg47p6MzPYpOIoE?=
 =?us-ascii?Q?+kx8wjRVNM5Mez4/nwmQm36jZNJBBc/GsZITMPKHz78Y2WHtQH92BAiCqEww?=
 =?us-ascii?Q?KbVo7N2iyS8gs1tcTnb73jrNSAhOb6gqt8WsG01QXhtAxOxVvIikTCIgzkXi?=
 =?us-ascii?Q?QvU1XezCVKvtLF4G1O489OPtFrKBfONfn7fQqe9OnAlnxts2+XqnBhJUjRiD?=
 =?us-ascii?Q?OZp0zZmXX55TScfwdyIsQiYue7QE3ZD/3rUTLXZnmyIBDyTM9RrxWHW7hiIc?=
 =?us-ascii?Q?Pi/jeWpgHZf5W6IEQ6XnFLi8ys2kXKHC9HO6lRUGIo90XHX5xNKCPoi6rADr?=
 =?us-ascii?Q?C+st9d5GijsSx1HRaexJ5C/3ZFqw2jV/KBSIcyR2PBOM6PVVCJ/1uyvJu9/O?=
 =?us-ascii?Q?vludy/I5MQIdTGz93kGc7Wi+EE6C2pOG4CGGi8bRMHVATQMRApfnYUA24AOF?=
 =?us-ascii?Q?DTK/k8Qsw7hXBCX1hEFQu8GgyORxPPH1pdGEVAR42XO+QNdcmwhhVtULhY8I?=
 =?us-ascii?Q?hdJmnexYNEpSoV+5WmVVvmhYgNdutDatjVAloGyjOm62E0wQ6UMPE72evsA3?=
 =?us-ascii?Q?4tXlQbAFAAmuSJlIgn3e0o/SMaKP3/qIuXlveehb9ey08IsQkXNI0uMKOI62?=
 =?us-ascii?Q?3xz7F2xfsx6ZRfllhGmoTMsChVSuIXBmkhLJf7uXsBipWpyLjConh5kiQEC5?=
 =?us-ascii?Q?Vtk7u6bPnLB0TfPW5/782vEwPr8ae2zWAGfLBbEQW0ALBqdDSxKDkkGbxUBx?=
 =?us-ascii?Q?pK6n92F+EweHIFXxpbTvZxMcdu5EFDE8yrpuUCyz801NCY/E1M6s+JBMP4KF?=
 =?us-ascii?Q?ueAAQ9f/uKTJPS1CSVYaS5wplcyfY5gAH+JaEEOUwDeK8BBYXx4Zn4S1ywEe?=
 =?us-ascii?Q?dSLj4cVXVtdZ02euvIfb+S3oSAqug8foaKtqGJOSeCh5R1Yd0teTk7TaUswD?=
 =?us-ascii?Q?4VPGMApxiYGBB7+BAXj+E+EhCgjwsrx+9q6i7VcEcszS2pS2VwjwNXTn2Ll2?=
 =?us-ascii?Q?EWEuNeeMXrYCaxK3qHMoo8RfNgxSuZjZaf5OJke/rrSsvm16lf8jGWluRBRi?=
 =?us-ascii?Q?Sw/0W4oqJ5/2qg53vIx9nkRL2CUqDyL7SviSGx8z1cUSz3lTCdvOdpzFXn1Q?=
 =?us-ascii?Q?9b0MHlytAro7PdPpRzU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c54c83-4592-494f-38a8-08dce8e85bec
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 04:59:45.1622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FGPPEz9+/6ANqY5YL7D3HL5QEYh0jx6IJdUKoPPGS6kgN+M2iBssvEUKweEb2MYR0l8NNzH4KEOseI1DcZnyzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7985

> On Wed, Oct 09, 2024 at 05:51:15PM +0800, Wei Fang wrote:
> > The i.MX95 ENETC has been upgraded to revision 4.1, which is very
> > different from the LS1028A ENETC (revision 1.0) except for the SI
> > part. Therefore, the fsl-enetc driver is incompatible with i.MX95
> > ENETC PF. So we developed the nxp-enetc4 driver for i.MX95 ENETC
>             So add new nxp-enetc4 driver for i.MX95 ENETC PF with
> major revision 4.
>=20
> > PF, and this driver will be used to support the ENETC PF with major
> > revision 4 in the future.
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h
> b/drivers/net/ethernet/freescale/enetc/enetc.h
> > index 97524dfa234c..7f1ea11c33a0 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> > @@ -14,6 +14,7 @@
> >  #include <net/xdp.h>
> >
> >  #include "enetc_hw.h"
> > +#include "enetc4_hw.h"
> >
> >  #define ENETC_SI_ALIGN	32
> >
> > +static inline bool is_enetc_rev1(struct enetc_si *si)
> > +{
> > +	return si->pdev->revision =3D=3D ENETC_REV1;
> > +}
> > +
> > +static inline bool is_enetc_rev4(struct enetc_si *si)
> > +{
> > +	return si->pdev->revision =3D=3D ENETC_REV4;
> > +}
> > +
>=20
> Actually, I suggest you check features, instead of check version number.
>=20
This is mainly used to distinguish between ENETC v1 and ENETC v4 in the
general interfaces. See enetc_ethtool.c.

> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > new file mode 100644
> > index 000000000000..e38ade76260b
> > --- /dev/null
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > @@ -0,0 +1,761 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> > +/* Copyright 2024 NXP */
> > +#include <linux/unaligned.h>
> > +#include <linux/module.h>
> > +#include <linux/of_net.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/clk.h>
> > +#include <linux/pinctrl/consumer.h>
> > +#include <linux/fsl/netc_global.h>
>=20
> sort headers.
>=20

Sure

> > +static int enetc4_pf_probe(struct pci_dev *pdev,
> > +			   const struct pci_device_id *ent)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct enetc_si *si;
> > +	struct enetc_pf *pf;
> > +	int err;
> > +
> > +	err =3D enetc_pci_probe(pdev, KBUILD_MODNAME, sizeof(*pf));
> > +	if (err) {
> > +		dev_err(dev, "PCIe probing failed\n");
> > +		return err;
>=20
> use dev_err_probe()
>=20

Okay

> > +	}
> > +
> > +	/* si is the private data. */
> > +	si =3D pci_get_drvdata(pdev);
> > +	if (!si->hw.port || !si->hw.global) {
> > +		err =3D -ENODEV;
> > +		dev_err(dev, "Couldn't map PF only space!\n");
> > +		goto err_enetc_pci_probe;
> > +	}
> > +
> > +	err =3D enetc4_pf_struct_init(si);
> > +	if (err)
> > +		goto err_pf_struct_init;
> > +
> > +	pf =3D enetc_si_priv(si);
> > +	err =3D enetc4_pf_init(pf);
> > +	if (err)
> > +		goto err_pf_init;
> > +
> > +	pinctrl_pm_select_default_state(dev);
> > +	enetc_get_si_caps(si);
> > +	err =3D enetc4_pf_netdev_create(si);
> > +	if (err)
> > +		goto err_netdev_create;
> > +
> > +	return 0;
> > +
> > +err_netdev_create:
> > +err_pf_init:
> > +err_pf_struct_init:
> > +err_enetc_pci_probe:
> > +	enetc_pci_remove(pdev);
>=20
> you can use devm_add_action_or_reset() to remove these goto labels.
>=20
Subsequent patches will have corresponding processing for these labels,
so I don't want to add too many devm_add_action_or_reset ().

