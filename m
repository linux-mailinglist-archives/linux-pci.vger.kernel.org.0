Return-Path: <linux-pci+bounces-15256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D619AF760
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 04:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5261C21884
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 02:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2A116D4EF;
	Fri, 25 Oct 2024 02:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YhY1VUDI"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A829156225;
	Fri, 25 Oct 2024 02:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729823105; cv=fail; b=BnjL0MEv/PxQAPdvp7EEu5fBjvkUOMyc0Amof09B1PDqvou/jAcSJlC8iGmzFNSRkAOWhB9HgOuuOvRv5qu59dx+1jM+vdZykTtUSCSom+o6OG9+3fQprt3Y47FYxO8NSWpXeLCPRFKnWCDfYoCqdBxtYjlUJILRkQ2/2t89N78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729823105; c=relaxed/simple;
	bh=QR+9iVEw9wSUTd9jzmbHWz2uXwEsxQWAotOukDuxfJg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=utN2THjEV86dFd4Gx0xJY3s82DaOWBzmDA2kM3eKlp7TSinYzZHUxv9KUNohNszFRpb2labOYPBNgkxyefk0PoQfgBJRwMGmzEbyZ0XyyR7NSN54TySCoRMTAVLVQoCNtt1vaAoSVZgedPmBjLY2TkgjDmX/ds2kR1Mo0AZDgJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YhY1VUDI; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EB3H/lmIycS2B0S+jIH78WbZnsbXSiyWf/88TfFXYJUn+/DyGdEGt7nh1yV+Kqclvi2eqakjBKfiD5i4EQ7QJQCpYJwarv075troVJBD9I1jc8KFzL7VHn8fgw8rKn8E4H0aV3bczKrmpcZTgTkdJeLA6IXkQOQEUoDT4Oj+fyHr+EkRva59jZhRcWvEveah8BiyPJ7TYGr+QVML+2uIKCxisOmfGesxqyYt8dBH5QenSiiR+szlSyXxL/FA9XflLVbBuxgpSEXu6qDNon7s4KnCfXC93w8SYdnmGDnqLMz58xcwdyWtwsSu5hd6wKi+PQifS6xqy4ez/odto9j/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7crWgtDSyVdcCrQFIFSV9Z9+zTlZQDLjvEs5Q92MDIM=;
 b=yTq1vOUKgO1G4CfvJPwVAClmWy0Blb6AuTeSjFR2tpmoxDhUX8BBhi2M9VjiXU8dctCY0JFo4UtR3/2/BXUAL76EG/CKEtOsw8veQoNYOEkX4ojkBY3wPQ0n/MRoTBo6EzQK0e+kJTDPj7VUQlMqftdFSZgzrOsOeivFNbnThIXieWmzOkDqxRRfKIaD8wTyiz25eVPvZGqPr0vYrgsL0Hpb/naYG+BOBN363j6G4rpHqrCdO5nGOeRtdttyQW2PCVRD1QRb/X+gN1pv8xrqiKPehMMGKuUPRF0L908ca0Q0idIGdNL5+eZ/4KtRpi5TfMsE6rEsR2PGw6yChd2vzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7crWgtDSyVdcCrQFIFSV9Z9+zTlZQDLjvEs5Q92MDIM=;
 b=YhY1VUDI+DCdBrGzl06jE8b5r2CPJtb9mUWsERhv7eYyfWO8Qaf47EGYQR4ahyeyZ5PdF1vn6gfGmr3YmXnjo5+uyyOENXiP0ZyrTZWDtRLxN6XTfhzyBG4ih8zYILbrxpqisv3YM67qCuLAdLFcJ7l5IeOzaXofZlXeSlgwSAlWMCHknhBmTbqw8L1AIbrIUUepcadm6Q5KUizcgz51YMVCLO6EbhwyNrBWprChqBSLYiVKJpCVlym2M3XOgRsLJKt8D9vuRhogzFgccILrGE8P1hlXOfdRkq1NIQdKEjEBQrzRKCtTiuH34B0/wlaoFDI88aqQnLJJE1BizBmfjA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8235.eurprd04.prod.outlook.com (2603:10a6:10:243::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 02:24:59 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Fri, 25 Oct 2024
 02:24:59 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "horms@kernel.org" <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "alexander.stein@ew.tq-group.com"
	<alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH v5 net-next 05/13] net: enetc: extract common ENETC PF
 parts for LS1028A and i.MX95 platforms
Thread-Topic: [PATCH v5 net-next 05/13] net: enetc: extract common ENETC PF
 parts for LS1028A and i.MX95 platforms
Thread-Index: AQHbJeOeizG3BmmBH0WM+L5sB6eS4LKWGmmAgACj04A=
Date: Fri, 25 Oct 2024 02:24:59 +0000
Message-ID:
 <PAXPR04MB85102CA53AC88F5C9B8CEAF0884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-6-wei.fang@nxp.com>
 <20241024163803.2oinbux5l5tw5fy5@skbuf>
In-Reply-To: <20241024163803.2oinbux5l5tw5fy5@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB9PR04MB8235:EE_
x-ms-office365-filtering-correlation-id: 81491b52-6459-43f7-0b7f-08dcf49c3998
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5M6uPy9aql7NyvYv0+uGevqhVSzQTk/pXBFqbjNepSLUXFw7bxKCfRFN+iu8?=
 =?us-ascii?Q?DX4ksNbIIt0luDMQLXmBpDOVakkaFekIFNqzyIMKKAvCLmmR04cIcGZ6PUYJ?=
 =?us-ascii?Q?I9R6FWp6AsVwJvV2HwtS7X8btVY0scE1O/0fgD3sAQAvsrfTPmNiDszq4eq9?=
 =?us-ascii?Q?rKjzZ1KZMRPZjCJRXq3lieZOWE3zfBUYqGJPeDpf+spNcbx5JOlfQVi1qb2R?=
 =?us-ascii?Q?oupMrWQ6/DA2hQH5oazxf0GHbt0Vi9lwx1374e++F/9gSfu43gvJcBeSiDI4?=
 =?us-ascii?Q?uXA1MH9ZgHSm/H3FQG4Ue5hnAF50u06YBkwcrU4DWTJgeetTm+lRP/1cSKhm?=
 =?us-ascii?Q?hGAtuoy2LjzuiQPNx9HYt0GajX9+rdLfYsgz37d33e5Xuc/A4ePeQ8I4k1HV?=
 =?us-ascii?Q?HA0x4whlVYmS3akv8FcEk+sFZrVTlkYE+DHnqycc0+juEMeccy9sj0PKg1ZK?=
 =?us-ascii?Q?b5Xgo69yWzHTZZASsjf50qNcItsvpNh046B+GsmbCjlJ5fG2qRh5KaRoEC+j?=
 =?us-ascii?Q?7t3yJikQVEaRIRwya8RmPQXSq0Hc4agR2a399AMH9hCEaukZ1UawP8J4y8tB?=
 =?us-ascii?Q?PVSzwdeZ+7+Fl2592ycxtzKyFOk3DLMCBNbt1oURZQI+XWFmHu0ge64W/Y1o?=
 =?us-ascii?Q?5S45ZNptZfGQLjE5+bjWR8bGqLk+UtX8hf4t3DqZ3o5uJgXWB3stbiOsIRKT?=
 =?us-ascii?Q?NzEYgMiS6Pgkbr9vI2SWVexLpFRE6ntQSvUQw4yu/VB95IRXWComeaQC+FCG?=
 =?us-ascii?Q?VKFHFurZGY7pp4t4uxzh8sCFUnsqYVLFQhKzxrQ4jdYwFfJ5taQ0wZfmU9Lm?=
 =?us-ascii?Q?FmWqCWsJ1KdD4pY6+q2FlHIw38g0lcdhofzSI3GHApGh5tzSjeG5Amm6/1b0?=
 =?us-ascii?Q?KL7ignXSVOBzYchwumfq65hPSvmvyNeI4SN0aEnQqYBhROz0/1Eo9DX5Prhe?=
 =?us-ascii?Q?VXfx8p5k+GEND9bVQ9HTkgbfUsjoS/ZuFNHHZEnmQJe4RmD6BBmGnc0O0QBi?=
 =?us-ascii?Q?hBGMGxXeemwuP4ApXxMT8T3lr6hNAOZzsFoQ33hlEclrhHfjJemVivAsMnep?=
 =?us-ascii?Q?jIq7RaHbOR2tAFpPtdNM8Zwa0oQs8agxQG0HWouskOAnT+Eun48RJWBr2pQp?=
 =?us-ascii?Q?+KZgLwKox5kxxxn51kJeacwmlJIhunefiI/r+9yyn+EhiZCB4X6Av13l8ZY2?=
 =?us-ascii?Q?Cocx+imXUHIICQ7VIccjZzHIsCwkMw5di0Sl7jSaEsMepknvd7d4d8S45vlv?=
 =?us-ascii?Q?yPDd8zUT0kJYTh+K80NStFkVxToXsN+AGoqaiBY/jFXiEN107oN7aMikEoI0?=
 =?us-ascii?Q?RnvchqtQjr42suztnKbdHbW4bKxIxM/f4xZJqSM+ihNeLuhQNosxQ+Dog4Sv?=
 =?us-ascii?Q?xm/vTBc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?M9INQigMIMv+c8rT7QFmGOItMTBku+K2qnhLVZXWi6+0smvGydHoJqUqqvSF?=
 =?us-ascii?Q?pKtjaeKuSV4yansEeNOXE3bxvcgsMo/v6BtSAJzgBjPc5GwamgLiGA8+pI5z?=
 =?us-ascii?Q?PJZmA5QY7izQ/0qwjXN0iuAwsbVZSEaWXlV49fuI9Ie1BgLkAagfvNKkT26b?=
 =?us-ascii?Q?KNpkK42DdHSRBBLU+vaQ9Z34iqy7YLbIvvPmzoSDHb/DVdmMKzuVa9M0QAIi?=
 =?us-ascii?Q?/5ki9HiBnbPqwwfgIdI4K5mC3vw+3CR5rFGhy0YzuQ3QjgWIf+EeL64HXNX/?=
 =?us-ascii?Q?NcSAO3GLJLPXjJTQP12BX+h5Ffhm0riFTTmH7ZG7+qbG22ED40Vleq+8elZd?=
 =?us-ascii?Q?yp2MldrEoirdO4T3zs0UiTzyCySUCnKSrKFYZiZiL+DWnkwuquvS18sHwDVq?=
 =?us-ascii?Q?PGIJz1y7ylt42sYgqWKXAuSz7rfaEvcVB4SOLmuC/tdTerMFSG0WaXAaRYF+?=
 =?us-ascii?Q?VhwOlHLu4MMILgnEcYrfzjnr8SsD1eKm2FiJ2koZ7dH2haCKKKUYAvZPdjlP?=
 =?us-ascii?Q?9Lb+1MZSxw57FQDYZGhXFIhXefClnPcpinlC3Yj9qVRgfi5jNjgidmfqKOQJ?=
 =?us-ascii?Q?2CzJFzCxuKIIbkgvyn7wDf3HpfQYyUBtCQ97OuGpDQrCpveFUzo8H6iZfKM8?=
 =?us-ascii?Q?/VIFrFBaVMt22nu81vJq9v2SsezaSsu2rL6RfTdoG6ZVufNn1G/9mxPXgA7o?=
 =?us-ascii?Q?XMhhSRLgfAFB3X/dQ9stMCtKMnveEQCINR8N2n9UvGvgsov4ttPWsGSIeHqW?=
 =?us-ascii?Q?ViAxDk+KOZrpSYafy6CSmHRqJZtM0gQ5+5RFvfsBu0bzOKiYhaPVCYTRRawJ?=
 =?us-ascii?Q?/GVZUAKsNx1heduk45883K3OdWSSt9C2sAAC72g5EoBwAXTi8pjUzANnLnay?=
 =?us-ascii?Q?XkYJCiTiLdi3KeGlqdchwW2wl0DeB3MBdgatVbNYyYW0mauG+icxC8SQ/4yk?=
 =?us-ascii?Q?MqzqIdNlBupklhNPFNOhuhvYg6/aneyVZR0OczG9woGqzj+aYPdn8ywAQSS0?=
 =?us-ascii?Q?yiU81Qi6NNab59TnQQ+ZT2qSatAnFJUPo1iCt6lhl/ESDF0sPZT41blB46np?=
 =?us-ascii?Q?EZpnOM1R/Bf+/Hn4z2lWQQXEQFI+/i4f34k0d9oRHUaiRb+URuPLpN3N+Lg9?=
 =?us-ascii?Q?xUaFugiJgtBqcCVvQs3eLM2izLGPzCBfYovjSzr+VNdYaOMnk3FnkLRvRRn4?=
 =?us-ascii?Q?DK25MDOynp8mkqvl+8Ebub0wfoEZur6ZMGoNwlX3qitGPlix9AmdwSEhGCW/?=
 =?us-ascii?Q?7iFHBudw+95Cjgwpicg8vr+9gIGhZbl26/I71pnB6CNIPJMCQSf7LzXqt+CN?=
 =?us-ascii?Q?HNkVAyns5SnCGOyDif+T1J7OV0kPPk1QR81BvZXc7V/kHB0R6fLe8JOx5hKH?=
 =?us-ascii?Q?QYQRyoo13Yr5vXcMq4EhRGzFgAndaddZraGNATQhsG8szoO+KOa+Q0VqZLC1?=
 =?us-ascii?Q?UWgGiF2EGpDQvg+Oyzv72n8v5mTsrqN2SMupc/CIzrMNBQzi09mWCNggBCtf?=
 =?us-ascii?Q?p06/t+PKjTQg/B0xS61qxgrn7DFI7rObKAaepkf9KkBww33k2BDRsUsrA1s0?=
 =?us-ascii?Q?Y6JqJPLR2wca1KpDyJk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 81491b52-6459-43f7-0b7f-08dcf49c3998
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 02:24:59.7681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n7MfS0zsr9EfbGMS0HC3DaIUXE0jO8sNUgunjRCQCWUodqw8Nosyzhp8RPyGHZxFHAOILZH5tMK6xVvl62ZA/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8235

> On Thu, Oct 24, 2024 at 02:53:20PM +0800, Wei Fang wrote:
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> > index c26bd66e4597..92a26b09cf57 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> > @@ -58,3 +58,16 @@ struct enetc_pf {
> >  int enetc_msg_psi_init(struct enetc_pf *pf);
> >  void enetc_msg_psi_free(struct enetc_pf *pf);
> >  void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int mbox_id, u16
> *status);
> > +
> > +void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8
> *addr);
> > +void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
> > +				   const u8 *addr);
> > +int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr);
> > +int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf
> *pf);
> > +void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *nde=
v,
> > +			   const struct net_device_ops *ndev_ops);
> > +int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node=
);
> > +void enetc_mdiobus_destroy(struct enetc_pf *pf);
> > +int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_n=
ode
> *node,
> > +			 const struct phylink_mac_ops *ops);
> > +void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
>=20
> Could you put the prototypes of functions exported by enetc_pf_common.c
> into a header named enetc_pf_common.h? It should be self-contained, i.e.
> a dummy C file with just #include "enetc_pf_common.h" in it should compil=
e
> fine.
>=20

Sure, I'll add a new header file.

> I know the enetc driver isn't there yet when it comes to thoroughly
> respecting that, but for code we touch now, we should try to follow it.

