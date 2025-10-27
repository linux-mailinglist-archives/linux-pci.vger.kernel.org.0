Return-Path: <linux-pci+bounces-39356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CE1C0BF88
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 07:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E26A3B2C66
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 06:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDF82DC34E;
	Mon, 27 Oct 2025 06:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bYCElUXJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013025.outbound.protection.outlook.com [40.107.162.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826FA23A98D;
	Mon, 27 Oct 2025 06:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761547002; cv=fail; b=fMTq3v7CAhDzTq4BgYRGe7wcvj6z/sL2EJOzxhqtLPbd54qQ+ErVPF7CHDNdqz2KlOb+dPFehvjpYR2/fbeE+bWylkzEMj9LIJFXyANe3DizW40hdlsnCWWFptdbcyGe8j6xeqcNHJWBgXkF2KaMNRbjhw28R+lFiGJ3ZVfPdqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761547002; c=relaxed/simple;
	bh=BwoRBlRWo7Dnsm5ykB4E/6UDY9RTKpAtmuuBfAgzP5Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EE9yp23z4fmioaiJGJB97fWwqOS/+J+plY2GqbfLwq7dC4IApTi/W6Nvym2x/aQsZAit/CPWEdMxV3GLzzLdVTkEz4Xy5UgmPsmfEXk4HUI0DOh55gwX+Ugs1M22kA5zdUMe/NzqZvQzshvPxA54BhzNFyCbr3zZtAf70bhSzGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bYCElUXJ; arc=fail smtp.client-ip=40.107.162.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFqel/WNKc7A6i2J1WiLDh05QgtnTDcHahc8IdT5jAMZ0n/H1Kvp12486Ore1LF9dsj6W0W7l/nWtjgrR0jnJ4zv60DXnasR019ZYWH0ls5vNQ7KVksGd2QFe/Z8KOXyALzKK9072TbzUpeZhoXSKiZtcJBKS6qlX1Lsdrp2WTbHW9kEM1OUKYT0Vt6XtkAgMrvv4VLMdXTLJdPgG6rYWHM2gu/s7EfvnlJTEFudGaTgeqquu2IOlh3YvJaRmu4T8HxYqbH4wvAl4clFmbAPF9IoNlkURJRgwYGthfoIObsVZAFzfKDHhTdjYuz7cQWcq6Of8ubZR29iuQqdHnRllA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwoRBlRWo7Dnsm5ykB4E/6UDY9RTKpAtmuuBfAgzP5Q=;
 b=yLN5qkkerEHD3vhBe/7IM+SyqejhuTlqJmtJn4pLC+9oYgQfL0rwFc7A9Hv0CQ6yHUC26qJAfLZgrDCXshFVs9pPcPxfae7rghUrhYB15kZ75QTVWHo4xC61w8FILrCmxXCeV9uvwJfzxrYGjqcJBjM8SHpTPDno6/yXsXFwpl/oIAASa7/TYzXNML0vf0j1cbb3BT0Ygq2wXQyK9znib8rx9tUiDmlZ4CTKV+6Wt43xou9FrzRtqkTlj9Ca8GcXoqBDETUDGBJzqkWD60iY3rmsclHwDBzEn46RkZlw/5gejrBCB/oQpgZiY1ycSd+YkIrGf+nXz8DaCZYiKa9UNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwoRBlRWo7Dnsm5ykB4E/6UDY9RTKpAtmuuBfAgzP5Q=;
 b=bYCElUXJH0KBAZZor4aPjtSud/zA+h6oDXm8QpxZZsO/q8A1OF8JFttIvsN3Z6094o2PZYuQMy2v6wIO+l55K2RF4IpX4CxJjW0OFvT0ge9Frz8b43zc3xsO6ecRj/t7ChVbz8RiVKf06xx3K2UhXfES5mIfW8Gs6IzUfpv9G7m3qdxcStmFpQue4obJFacoOjwUYQlZfe9e0S4+l8BxI9+s3unlU0zHuVxFQzyvSesAhLMblhSN8n7gjv2MZQJAEwgKouHwcGS9ZIrbvShM1np7fuzTK9qECRTyMypPuOXMzMppeblWS1vcR3Z3dNPOpzI4Zrwe5xLa5vk6vvvx0Q==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV1PR04MB11486.eurprd04.prod.outlook.com (2603:10a6:150:281::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 06:36:33 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 06:36:32 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Conor Dooley <conor@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Frank Li <frank.li@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 2/3] dt-bindings: PCI: pci-imx6: Add external reference
 clock input
Thread-Topic: [PATCH v8 2/3] dt-bindings: PCI: pci-imx6: Add external
 reference clock input
Thread-Index: AQHcRI+sdyu3yOSCC0+q89YO6Fq+57TRiAWAgAP/8bA=
Date: Mon, 27 Oct 2025 06:36:32 +0000
Message-ID:
 <AS8PR04MB8833DEEA9CB4CE4968B2B5F18CFCA@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20251024024013.775836-1-hongxing.zhu@nxp.com>
 <20251024024013.775836-3-hongxing.zhu@nxp.com>
 <20251024-unburned-lip-6f142d83ed76@spud>
In-Reply-To: <20251024-unburned-lip-6f142d83ed76@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|GV1PR04MB11486:EE_
x-ms-office365-filtering-correlation-id: c9778e28-ff76-4a57-0d8c-08de15232b61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?gb2312?B?V3BpVjdxelNxWXAxUkV3MFZ2MHZvd3Bic3lNZVF1QnlHTmJPVmREYlM2cmxV?=
 =?gb2312?B?RDJBa0RrQld1NTRIc0hqRUgyeXZUSER5MCtoT2YwMm9IVG5DT2ZyL0tyNngy?=
 =?gb2312?B?SGtvcEIxTFExclhiaEpIM200bURwcWN3SXpMTHplcUloR2xvSXpLbklSZjZG?=
 =?gb2312?B?UENMczJ2aVRkWG02Z0ZWeEVGOXlCZ1UrWDhGbTNmdkxlSWE5a3A3ZERTbWFy?=
 =?gb2312?B?WENVVHdURmZHU2VRY21nLzRIODJydVpvMzlqdytJbVA5cVMxOVZZZUlrK1hL?=
 =?gb2312?B?T3dmTUVKR3dDdTNDTWdmeXVVSDJYdUFiWXRWM2RsTEowTENyNkRiVSt6cTB0?=
 =?gb2312?B?MXcxcUd0SGVJZFpvYTNtMnpYUk92L0hPT3NNY1luK1JQZzk3YUVha1RWdEhm?=
 =?gb2312?B?cGdha3BnMVg2elhxUnBaSFQvUVl5dzRxclhIMlMvOW9IUGlkdnVGOEdDcWFv?=
 =?gb2312?B?N2t3eXRPamZ3c0kzak1rSmNjNzRnQUdkUHkwTTBzQXBOTERPNTlCTXVqSzdl?=
 =?gb2312?B?eWZ1eWNYbDNHc001SXhOVkxTQWszdkxrYWlpdVRnbzNHdHptdHdaN0xiN0RC?=
 =?gb2312?B?cVR2YlJad1RHdGpjejdhR1lzTnZnNGFWSkxJdDZqL3FqaTVyeUpNd1F1UWtI?=
 =?gb2312?B?MXV6eFRWRXY5TlFjN2RrejRVUXZvT0NYTW41enJFYmp2dmRyOHVLekluNjlB?=
 =?gb2312?B?TzU4TmtsRlQ4UVBZTHJaQXF0WXNCbGd2QmdWNDdwV2tQMUwweGkwaFB2ejk0?=
 =?gb2312?B?aGVPMjFNNktGanl4VHp0MWFZTXhOQVFwcmU1anFqVWM0Y0krZVg3cCtabXJ5?=
 =?gb2312?B?QWJoN0l3QjFkS0pxY25KZ0FaVnpYUTJQeEtFSGdyMHNwYzl2SlArVXZlUlRj?=
 =?gb2312?B?cTZUYnM0aXE3MEJ2K3ZzQ05IbDI2bmo5VXZvSHJiUldiUWI2UVArMWZ4ZUtu?=
 =?gb2312?B?aUZzT0dJRHlzR05Tdmwra0xGeDNjalkvKzVEYWZldSt5VUI2Q1pzNk5jVFB3?=
 =?gb2312?B?M0VuSmp3LzRDNWVlMFM1SHdkbCtLeitpWmdPWWx3RzI3Nm5MSktoc1pYcTIw?=
 =?gb2312?B?SUVHWElQUnhKR2tZWXc4ajJ4dW9aczRtcnFrZzJVM2M0NklhYWtGbnNJV21j?=
 =?gb2312?B?alVkUklaTXJCcjFiWjZ5RWhYTHZ5Z3NVS0d0L21wQ2pnVzNRQnhFMmNXVC9p?=
 =?gb2312?B?aUlRbUlVOVpBTzJJZUNyUVNyOEU0aWpOeEJUanRjYkhXaXNFME5HYlBQMGo0?=
 =?gb2312?B?UEgySnhQNXVBdkdFcE5va3hTRHBRTXVvcmR6NW5VMWFNcXVmSVhSemNiNGtU?=
 =?gb2312?B?QTlYMXE0YjF5SCthNk5LSlgxVWl1ZTVUbGU0eVd1N1RiRGMreGViMDZzakI5?=
 =?gb2312?B?aFlSeGp2Ly9xZmFWWGFGVGdFTjI3Y0tzYXg2NGF6OGE0SitzMVJac05OTDdh?=
 =?gb2312?B?MTdLTC9hSHRYaFZOZ1RlTFBuQmN5Z1hxNDl1b21PSjhiaWFjd0RCeCszWlFC?=
 =?gb2312?B?Zms5bXdtMW5IMzNHQWZzQlZaN2tsazI3YXJoWkthc3FKTWhIUy9xRkVDQVJR?=
 =?gb2312?B?ai9LU0dhVkdHRnhDRWovZHBwVGY0QnAxb0Ixbkc1TTJMOG1jL2wyZkx3bDZY?=
 =?gb2312?B?QlFaOVc1dElXVzRlMzNCNnp3TEFkYWxTOVJ2bVFibkFjNFVEdHIrVDJ4YUVy?=
 =?gb2312?B?WCtkL2puQ2d5Qk8xM3RwTXJlZm1QWTl1SHQzQSszTVFxdzRTUGd6Z3I2YVlO?=
 =?gb2312?B?a1A3MEZlWllTTHVHaEVRak56UUwxUldBNHh6MzBHTzk2QkprcG9IcG1LMHdt?=
 =?gb2312?B?MHVRamdITUVaeis3QjZpRVY2UW9EaCtPVWNQdklkT2dOODREbGVUNXY2Yk05?=
 =?gb2312?B?YkVnUEV3Qk1Tam9xTnRTdWpjeExGMEhRSXZZT1hhVzQ1WXd6bk96YTRDb21u?=
 =?gb2312?B?R0cvZThLR2c0SWNQWU5sZkVxazhiR1ZtdlFOclRrazM4SGtnVmR6a3kxeUdp?=
 =?gb2312?B?Vmh6UjA2aHhrQzVRa1Q2Yi9VVGROcEtxV1hnd05vK3hveUNlQnNFKzNhSHk1?=
 =?gb2312?Q?MSFSvz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?M0xEb2JrR2ZiWi9HYVp1M0s0cktSR2x3clBrdExHckc1bzh0dFNBbTdEQXgr?=
 =?gb2312?B?OTF4eHo0dDZodkUzZUgxczNnU0dqSXl6RUJqems0SEFMTXJzeGhKNlloWEMw?=
 =?gb2312?B?N2d3UVVPVTJ6dDBZc1h1S3lOaGhMTkxIN20vM01ySHhOK1VOZzlyNVFWUE9z?=
 =?gb2312?B?cjFZL1luZ2FadE5lNTdDdzA3cUZ1VzQ1WHdXbUtsMFdxQkVTR3dpOC9qZ0Fr?=
 =?gb2312?B?MjZsWExPUHZRVFNLTWpEOTRndDlSeTlXaTQ2dkx0QW1Cckg3blFXQUI4c1ZP?=
 =?gb2312?B?c3Z4U0RidUNaVXN1d0dFVW8wMjdnU0RNRDl4cHRIQjU2a1doTXNHNU81YURL?=
 =?gb2312?B?cXdXL1p4L0d5Q2JoQm1DTDY3dlBCc3VtUG94RTFxYU5nRjZ1bHhHbW1ZWEVK?=
 =?gb2312?B?TENyaE1MTjYwbEpFRHgzdlExamxSNVZRUUxZYUFPSGF5bjdrUGRZWEdFZmpq?=
 =?gb2312?B?SityejJ6SVV6aUJzNGhDSFJIcStNV0R6RTRRTWVobkxSSGhVTStnU3V3QlFV?=
 =?gb2312?B?VWx1MFZMWjIzZFp2RDVBTE9aUHQ2TWRwcWNXcExyeFY1anNCZG9ZbHZhd05z?=
 =?gb2312?B?aFF5WEVJb1R2TndlUDEwQW1TeUpETFdMSXJNdTljT09uS3JBdEZqcUd0SlY0?=
 =?gb2312?B?cDFmZVZ0Sjg1YW9MMWdLZUZ6b3orL3dnTFFmT0Faa0lxV0kzb29IZXdwcFo0?=
 =?gb2312?B?cHgzMWRrY2I0ak9tMm9IeE9kaHo0eUtoRGNTNkJXWHB4V2ZxNWg5QmNsakgv?=
 =?gb2312?B?RmlRUFlZMWw3bGNzQXE0M2ZMaXNpa0xpWGZWQW5SMklpbUNWZFAzSld5VmFV?=
 =?gb2312?B?elVwQUNocG5VU3AvNG1jOUxzZGpmNWJjeERxYkpnRml0RklUZkRrQTh2ZVlO?=
 =?gb2312?B?WnBLU3JpVGoyN3ZhMXlYcDNsVy90QloyazlQZG4xemMxT2R5VzBEN3E5WVZs?=
 =?gb2312?B?MWZNSHpJK0VPYTBBRlpyczhKYS9vT2RGUUVQczV2RjlaL0pHanRRMG5oTExD?=
 =?gb2312?B?MjNJVnBhbGJhL2ZDeVNLNEtpS2FtWEIvajdHTUJibUZNRFcrcDFZSHhHbGpo?=
 =?gb2312?B?MU9vSVJEWll6K3pxNGV5NW56ckw3RG0zR0RtdDNHZ05hZnFIS0oyT3VGZ2R4?=
 =?gb2312?B?aC9HL3N5TUhzZlErKzRsK0JOUEVyOE12Y1I4bFpSenByY2lHMVhkOUVIWDRm?=
 =?gb2312?B?WHh3dnB5eEk3ZnFZNzlWNk9pVVBWV3VDODc4K3VqU1JvMkpoSEY5Q09vTCtp?=
 =?gb2312?B?MWFSQkY1RXNndU9vNWxBb2dvaHE2bHVpbHhqWmdvSjYwWGNETHVHMTNUWGUy?=
 =?gb2312?B?TUtzZkhwWVp2M2FXNE5kVUpoT09lZXdhcmJWSUtIVkoyWUQyYkJQdXoxMXMw?=
 =?gb2312?B?M2RuZDVlSWZER3VNQjh3NFJhYXhNUks3WTBZNUs3VkNyMnk1QVhMcExVYWhR?=
 =?gb2312?B?QmZGUmxYRC9XS1VYenhRQjhlakxEbHJQNGRXNUVJN3JZaE11Yjk2YnBiSE9O?=
 =?gb2312?B?d2k1b2s0c1hIUUlQVEU4Qm5RaDhPZDQ4MldseVUvdEExc1NuNmVGbXlheHpF?=
 =?gb2312?B?bkI2MzRma3I2QUpIV092eUg2SWxaM1YxdFA1ci9vNGRmR0RzVEU1ZU1XYXRP?=
 =?gb2312?B?L0FMUVdPSml5MUEwR1dVN2doa0wwVkpJOGl3ZUlEb3gyOVpnVjQyRENWdDJo?=
 =?gb2312?B?bk95R3diOWFCRHE1MVZPblF1QVpsaE1GSkZaR3BHQVRLeDlHcGhSM1JZUHNl?=
 =?gb2312?B?VEY3c1ZHaEhrUFdFaU9OY1VtNXZCL1lUenpSMnpzWU01OG1Bd2tVMzk2ZVdu?=
 =?gb2312?B?dW5SdDB1TlFIN3hpR3ZzOVVPeG5MMkxsUmM4RUhzOS8yRXNrMlh1QWF0elRn?=
 =?gb2312?B?cFNMTSs5MEVVekRvRHI2UldwZ1dUK1l1eWI0WERvd29pS0h4L0NNRXdFNzdp?=
 =?gb2312?B?ZjBsUXF3SytjQjM0YzdjNEtUZTVQNnVmbGVyb3U5Ni9ZbVZYcXg2YzFjOTF3?=
 =?gb2312?B?amlFZkhUUjdzSXFDeU8yQ1FWSDhzUXdqWFV2NGloaG5BSW5xamVMcFppTU5o?=
 =?gb2312?B?djkyVnA1L0d4VXdpbitqSEJiL2NmU3gycmh0VkRPTFViOVVMakNPNko0RnRv?=
 =?gb2312?Q?FL6Q=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9778e28-ff76-4a57-0d8c-08de15232b61
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 06:36:32.8365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gthe5LMd3KceTcRr4dx/iTXNRJgy6wwYlPLF4CmorpYr0KL7sKXksGeS7736h8AOiYyhjssjUgwcwbFsxWmdKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11486

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9y
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXE6jEw1MIyNcjVIDE6MDcNCj4gVG86IEhvbmd4aW5n
IFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiByb2JoQGtlcm5lbC5vcmc7IGtyemsr
ZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNv
bTsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOw0K
PiBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3aWxjenluc2tpQGtlcm5lbC5vcmc7IG1hbmlAa2Vy
bmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsg
a2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4LXBjaUB2
Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OCAyLzNdIGR0
LWJpbmRpbmdzOiBQQ0k6IHBjaS1pbXg2OiBBZGQgZXh0ZXJuYWwgcmVmZXJlbmNlDQo+IGNsb2Nr
IGlucHV0DQo+IA0KPiBPbiBGcmksIE9jdCAyNCwgMjAyNSBhdCAxMDo0MDoxMkFNICswODAwLCBS
aWNoYXJkIFpodSB3cm90ZToNCj4gPiBpLk1YOTUgUENJZXMgaGF2ZSB0d28gcmVmZXJlbmNlIGNs
b2NrIGlucHV0czogb25lIGZyb20gaW50ZXJuYWwgUExMLA0KPiA+IHRoZSBvdGhlciBmcm9tIG9m
ZiBjaGlwIGNyeXN0YWwgb3NjaWxsYXRvci4gVGhlICJleHRyZWYiIGNsb2NrIHJlZmVycw0KPiA+
IHRvIGEgcmVmZXJlbmNlIGNsb2NrIGZyb20gYW4gZXh0ZXJuYWwgY3J5c3RhbCBvc2NpbGxhdG9y
Lg0KPiA+DQo+ID4gQWRkIGV4dGVybmFsIHJlZmVyZW5jZSBjbG9jayBpbnB1dCBmb3IgaS5NWDk1
IFBDSWVzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpo
dUBueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2ws
aW14NnEtcGNpZS55YW1sIHwgMyArKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wY2kvZnNsLGlteDZxLXBjaWUueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1sDQo+ID4gaW5kZXggY2E1ZjI5NzBm
MjE3Yy4uYjRjNDBkMDU3M2RjZSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLnlhbWwNCj4gPiBA
QCAtMjEyLDE0ICsyMTIsMTcgQEAgYWxsT2Y6DQo+ID4gICAgICB0aGVuOg0KPiA+ICAgICAgICBw
cm9wZXJ0aWVzOg0KPiA+ICAgICAgICAgIGNsb2NrczoNCj4gPiArICAgICAgICAgIG1pbkl0ZW1z
OiA0DQo+ID4gICAgICAgICAgICBtYXhJdGVtczogNQ0KPiA+ICAgICAgICAgIGNsb2NrLW5hbWVz
Og0KPiA+ICsgICAgICAgICAgbWluSXRlbXM6IDQNCj4gPiAgICAgICAgICAgIGl0ZW1zOg0KPiA+
ICAgICAgICAgICAgICAtIGNvbnN0OiBwY2llDQo+IA0KPiAxDQo+IA0KPiA+ICAgICAgICAgICAg
ICAtIGNvbnN0OiBwY2llX2J1cw0KPiANCj4gMg0KPiANCj4gPiAgICAgICAgICAgICAgLSBjb25z
dDogcGNpZV9waHkNCj4gDQo+IDMNCj4gDQo+ID4gICAgICAgICAgICAgIC0gY29uc3Q6IHBjaWVf
YXV4DQo+IA0KPiA0DQo+IA0KPiA+ICAgICAgICAgICAgICAtIGNvbnN0OiByZWYNCj4gDQo+IDUN
Cj4gDQo+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IGV4dHJlZiAgIyBPcHRpb25hbA0KPiANCj4g
Ng0KPiANCj4gVGhlcmUgYXJlIDYgY2xvY2tzIGhlcmUsIGJ1dCBjbG9ja3MgYW5kIGNsb2NrLW5h
bWVzIGluIHRoaXMgYmluZGluZyBkbyBub3QNCj4gcGVybWl0IDY6DQo+IHwgIGNsb2NrczoNCj4g
fCAgICBtaW5JdGVtczogMw0KPiB8ICAgIGl0ZW1zOg0KPiB8ICAgICAgLSBkZXNjcmlwdGlvbjog
UENJZSBicmlkZ2UgY2xvY2suDQo+IHwgICAgICAtIGRlc2NyaXB0aW9uOiBQQ0llIGJ1cyBjbG9j
ay4NCj4gfCAgICAgIC0gZGVzY3JpcHRpb246IFBDSWUgUEhZIGNsb2NrLg0KPiB8ICAgICAgLSBk
ZXNjcmlwdGlvbjogQWRkaXRpb25hbCByZXF1aXJlZCBjbG9jayBlbnRyeSBmb3IgaW14NnN4LXBj
aWUsDQo+IHwgICAgICAgICAgIGlteDZzeC1wY2llLWVwLCBpbXg4bXEtcGNpZSwgaW14OG1xLXBj
aWUtZXAuDQo+IHwgICAgICAtIGRlc2NyaXB0aW9uOiBQQ0llIHJlZmVyZW5jZSBjbG9jay4NCj4g
fA0KPiB8ICBjbG9jay1uYW1lczoNCj4gfCAgICBtaW5JdGVtczogMw0KPiB8ICAgIG1heEl0ZW1z
OiA1DQo+IA0KPiBBRkFJQ1QsIHdoYXQgdGhpcyBwYXRjaCBhY3R1YWxseSBkaWQgaXMgbWFrZSAi
cmVmIiBhbiBvcHRpb25hbCBjbG9jaywgYnV0IHRoZQ0KPiBjbGFpbSBpbiB0aGUgcGF0Y2ggaXMg
dGhhdCBleHRyZWYgaXMgb3B0aW9uYWwuIFdpdGggdGhpcyBwYXRjaCBhcHBsaWVkLCB5b3UgY2Fu
DQo+IGhhdmUgYSkgbm8gcmVmZXJlbmNlIGNsb2NrcyBvciBiKSBvbmx5ICJyZWYiLiAiZXh0cmVm
Ig0KPiBpcyBuZXZlciBhbGxvd2VkLiANCkhpIENvbm9yOg0KVGhhbmtzIGZvciB5b3VyIHJldmll
dyBjb21tZW50cy4NCkp1c3Qgc2FtZSB0byAiZXh0cmVmIiwgdGhlICJyZWYiIHNob3VsZCBiZSBt
YXJrZWQgYXMgb3B0aW9uYWwgY2xvY2sgdG9vLg0KDQo+IA0KPiBJcyBpdCBzdXBwb3NlZCB0byBi
ZSBwb3NzaWJsZSB0byBoYXZlICJyZWYiIGFuZCAiZXh0cmVmIj8NCj4gT3IgImV4dHJlZiIgd2l0
aG91dCAicmVmIj8NCj4gTmVpdGhlciAicmVmIiBvciAiZXh0cmVmIj8NCiJyZWYiIGFuZCAiZXh0
cmVmIiBoYXZlIGFuIGV4Y2x1c2l2ZSByZWxhdGlvbnNoaXAgb2YgY2hvb3Npbmcgb25lIG9mIHRo
ZSB0d28sDQogYW5kIHRoZXkgY2Fubm90IGFsbCBleGlzdCBzaW11bHRhbmVvdXNseS4NCg0KPiBJ
IGRvbid0IGtub3cgdGhlIGFuc3dlciB0byB0aGF0IHF1ZXN0aW9uIGJlY2F1c2UgeW91J3JlIGRv
aW5nIHRoaW5ncyB0aGF0DQo+IGFyZSBjb250cmFkaWN0b3J5IGluIHlvdXIgcGF0Y2ggYW5kIHRo
ZSBjb21taXQgbWVzc2FnZSBpc24ndCBjbGVhci4NCj4gDQpTb3JyeSBmb3IgY2F1c2luZyB5b3Ug
Y29uZnVzaW9uLg0KDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KPiBJIGRvbid0IHNl
ZSBob3cgdGhpcyBjYW4gaGF2ZSBiZWVuIHN1Y2Nlc3NmdWxseSB0ZXN0ZWQuDQo+IA0KPiBwdy1i
b3Q6IGNoYW5nZXMtcmVxdWVzdGVkDQoNCg==

