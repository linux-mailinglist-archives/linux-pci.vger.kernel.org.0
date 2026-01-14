Return-Path: <linux-pci+bounces-44703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C79B9D1CB4F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 07:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C928D3091570
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 06:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4215336CDF9;
	Wed, 14 Jan 2026 06:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TwZ4zSKo"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013009.outbound.protection.outlook.com [52.101.72.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BE52586C2;
	Wed, 14 Jan 2026 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373185; cv=fail; b=QtyLyzLhylPnc9+M5oeNP9vdHFngShUxv7PCkc/s8uzb33ozFU3vxddwIBTAB4FVcSEGq+oBqNGq3SnNFeIM2akdziYx5DR1rsrmAmj6VcBli0xZQCrL8/OX94SBDkQ3JTykoMrrNkuWdAfe+7qyvUW4vgoYRmQ1JoPmEsO1si0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373185; c=relaxed/simple;
	bh=K6PBiEbLtU9kQN/I1jsPPd06kf4TGo71ykQvcr9Ym3Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C8sqms4kvDDkGImijDMg2ZlKqVaw4EzPmbNlCfjqbtFoXTD51xeXJpDIy2BX6hUSnze5ahpm/WtjFywQFfmyLDJnF7jGHFYvXne0NsZe6akITkfH7qln+xy5q4YAL2X+twbaE7ZvxSyKVnfmj8gx4KxKPEi0OFHbO57YGzKEntU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TwZ4zSKo; arc=fail smtp.client-ip=52.101.72.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ckzys7ZlArB0mpDRe76EfnISxw+Odmz4gfu3mK6BB1xdU61W/tanmZKCeY6hrsK0btr+FdlXFn5kG0JXiIp/xY04w17qzbLx25Mkd5bTUe49Mrau7QgS8NRALm6vEtuMFtO7yurfJNoVZn9bhmA/WhKg1Qbh1PwUfEfZIqlGYjvyrzC4cJl8BAITEJOttzzKTB+pOoRVQIxiT6wXcfRTuaw0S0W0jzyhtvJfC2MeOJNwCO/7gvWMkig6iPHCrtUMBNM/HbFSMj2gGK9OhCQKcYgkkfD3GAwE34wakra7qs97mdzICqgKeckLd0AQ43vVeCH/v0pWArWMgJWJ/RZq1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6PBiEbLtU9kQN/I1jsPPd06kf4TGo71ykQvcr9Ym3Y=;
 b=s/306dX9kNtbfKrT+ioQvgEUj7xOqU2C0e7UdjN5xmkGx/hkwrt6Rt9sNgmKLQkh59gWW8LQR2kDsB68ls2PNIpCi1dMId2R0ADCIR9r1IcWTMyMidEilwBG/pOQQ8Ph040fhKNo2QDWSJ1SXqYqdlbf5qAwviWkkuyhg3XI6GqFnA0+fRtDTOXCqlkv7tke/eRB+QCyM/Ye/hww4zEoTm7HIVSUs6TAjcvKUrCDxxhW7s/+dmpPC24urk4ECNhQsFJg2ZEI3E88E++UM3j+eiMM+hokBu92jZF7DydmXkRba0D2B0QjHymFEfIkrM2y6SUcYXFGflSWflwszZt5CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6PBiEbLtU9kQN/I1jsPPd06kf4TGo71ykQvcr9Ym3Y=;
 b=TwZ4zSKoPc+/1mh5tTSwQU7yARcAo3LnlDWonQkPHOMxRyfqW2NkI/OA04NgQY86C5+U14+wlaZnErlb0LD4kBqMmHErPKddKwqqXW4zDH5TSf6LmT8LFjhf2+gsYFyCc4fs5nxr/2+hDoCB1WLQjuRXVr2cPs1rBAVlKgmcjkCFqBkr8iXMB+O4RYp1q0OalN8C9DTj2/XDRZ6enxGUc2GyjwNO885v/O2WNez1fqWd2qPpbfJagQZf8Sp6ZmdOJODWLt1fa1N1m5Driw4OWVUKlJQp0eR9x9qxFRrb+4iWP/9nW8wLkC5BXupKeuiw2BrQk+eW17uAS2fGNjwJmg==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DU2PR04MB8664.eurprd04.prod.outlook.com (2603:10a6:10:2df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 06:46:12 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9499.002; Wed, 14 Jan 2026
 06:46:12 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v8 1/2] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM is
 existing in suspend
Thread-Topic: [PATCH v8 1/2] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM
 is existing in suspend
Thread-Index: AQHcf3/eMURx6QrKcUC2X2xbGJBCkbVQQ0AAgAD+c2A=
Date: Wed, 14 Jan 2026 06:46:12 +0000
Message-ID:
 <AS8PR04MB8833EC1FBEB25BCBD89E65A58C8FA@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20260107024553.3307205-1-hongxing.zhu@nxp.com>
 <20260107024553.3307205-2-hongxing.zhu@nxp.com>
 <g3yuqj2yyq236x7fzwdfl5s7onvuwd2ot7btadf3qs36vchleb@4kwfwpo4ni36>
In-Reply-To: <g3yuqj2yyq236x7fzwdfl5s7onvuwd2ot7btadf3qs36vchleb@4kwfwpo4ni36>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|DU2PR04MB8664:EE_
x-ms-office365-filtering-correlation-id: 5fb7a911-4d1f-4ae8-35a7-08de53389b89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ODJBbjEzY25DY3I3Z3lURXBMaW1YSlNmTFpSV01Yd0FkSjJqbWNXallQQXFL?=
 =?utf-8?B?NlpCTGp5emlmVjd5T1c4Yi91cFJCUVVjQ3pncjV6Vlk1YjFJR1pQbjVjWlNu?=
 =?utf-8?B?bzI5bXlzTno3dXJQbk9BSlk2bHJsZnlIRWRkU0FuTFVkYkNXcjJ1d0lBcjZ5?=
 =?utf-8?B?VkIwZVVzSWplb1I5cGptUnJxam5zcEhzdkwxK00zUkwwZGlnSlM5UVd5Y1pX?=
 =?utf-8?B?VkY4YjJXOEJOemk3aEZyWkdteUR1UXBzd2NSYmxEdmZ5UElYM0F1N3VaSUV4?=
 =?utf-8?B?ZnNxc1pPbUp1K2VzOE9JZFBmY3cwRWtZZUFpTlhndWhWa3N6SjAzWHVuSk1o?=
 =?utf-8?B?RWFHL3RXK3N2Q2ZFcGRTbE1mVTNsVEIxZXVOZ0Z2S0RIUGxKNXI0N0x4enNs?=
 =?utf-8?B?cjlSVFpSZ0IxdU5ha0JNYy9rMzR3OFZLSHFXOGxaU0pVdnEwVlRFWFRMOTVD?=
 =?utf-8?B?NVF2QkVFNFRmU1IvcXMyRWZQUWVsS0p5cjBrUlF3VXpORlpTR2xrNjBZM3Yw?=
 =?utf-8?B?RkZMWFYvalRTd2RaTTlJRjRWd0pOVWhCcUhjN05RVjBHNE8wY2R2TTY4dDcx?=
 =?utf-8?B?c0ZWMFlBTUZWc1Zwb2ZqMDdSTUg5c2I0ZVhzeGxwRll4S3pyaFJVbmtLWTh1?=
 =?utf-8?B?TUdpWk45enE5UlFmUmh2TU16UFJKRWFoTTN3d0dFOUU1Y0xNTmFVajVxeWxo?=
 =?utf-8?B?cDhHMnJOcm1OWHBBcjNLalRMTDRBMXhwNjhuUUhZRm83bzJocy8yWFU5TW5C?=
 =?utf-8?B?c1RwSDdSVWZEK25kVzd3UUxQMUJPU1Zwb0w0TWhOSVRocTJFWWRqWVFGMW8v?=
 =?utf-8?B?b2ZqeFp5T2IwNEhINmVtVjVHcUc0dnJ4a1pra1BqQm5NV2U0VzdXVWdKUFJx?=
 =?utf-8?B?NVIwc3NXM2FOL2JWWm9KNWx2NU9YQUZuaWZrY1BjNERscmVoOTVMRzlnb1Ez?=
 =?utf-8?B?dS9rU01yMkUzMFJiVDUzTUlKZFV3bk9TdngweVZVUmxnUEowMkpzZlE2R2Fi?=
 =?utf-8?B?VEJPWEYvcFc2ejRrUUE0dVp6Y2IwNGx0dEM5bXlJMVRpOWxua1I1d0licXhC?=
 =?utf-8?B?Z2NlK0ltL0tvTjZXNzRwdit6dDk0L0hZdmtzelJFY0ZLTFE1Z3BrV05UWTFy?=
 =?utf-8?B?aTY5TEY4QUVUb3ZMTG5DR2IvaEZmMmQvLzJGMi9rZmoxYjJKeUNvNUM3MTg4?=
 =?utf-8?B?SVV2OTJFWDFqdUs0UTVBYXB6d2Nybkc5b0NERXRCMUZwSS9CTGlXbHgyclVM?=
 =?utf-8?B?V2lyTkQxajQvbVNTTXZkN2tQRS9IYTNGSXQxY0Y4UGc1MEVJS0c1Y1JwUlM0?=
 =?utf-8?B?MlE3aGhuZGpLL2NzMVI4S1pRMm1IVVdhYS9xa1FqVTlZYjBtYkFlQXFYU2I4?=
 =?utf-8?B?NzlPZ2dxaXllOUprcGhYbnJUYmJsZzFiUGdRaVlqa2VMZEJSMGhQbFowaEFi?=
 =?utf-8?B?SDloc1dzQ2d1ckhNc2laMlExOFRPZFk1TzFqVThKMGVTN0J4RXo4WWw4MHYr?=
 =?utf-8?B?TXpCalhpaTh1UWdJOFZKWjQ0VXZmb1h5K0J1djR3RzBMNm9QRW90YmpjcXR0?=
 =?utf-8?B?QklqVVVvejVORmF3QjRRaFRMWDJBN3hhVkNqUS9yNWltWThSSDVBZVF5YVpk?=
 =?utf-8?B?YlRERkVJWTdWV1R0a1dPVWZpOEoweDFxZUVXa2RXWWNNRlI4NVZCMC9JRnB6?=
 =?utf-8?B?Snk2ejJZYklUeGd6RWtXQ1ZuWHVRZXBFdWNHN1NxMmhqQ0t4S1Qya3dZa3JU?=
 =?utf-8?B?VEtZMTdnVkxyRE9kQUhzdVFTTnA1VlBQK1A4ckpad2k1RUErTlpwbnhPWWxz?=
 =?utf-8?B?TlZ6bmF2VVpYSDNJelBVV2NPL3M3dkprRk4rLzBOOVBtVEIrUEtROWNpRms3?=
 =?utf-8?B?MHNDN0daR0ljOWd4SVoramJjVmU2Mk9OMmMwcWZkejhBRWltMDF2Z28zSVhi?=
 =?utf-8?B?RHBKaTY1OUMrVmora29OOFZwaWR6S0p5YzQ5MzVNWVFEeE5xSWpVNEZSOGRa?=
 =?utf-8?B?ZGZ5VnM4NjNRc0dkUmt5anp2UHdmYllFcEZ6Mk1PTHZPVHZqckFIYXZneE1Q?=
 =?utf-8?Q?FMjPmu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGVkL0poc2pyS0Y5dUJPL09vUXFCNkhubFVqaXh6cG0xOEplZENNVVVzMEli?=
 =?utf-8?B?V09BSXB6NGcxUmlRZmJPUlArWVhCaWQ3ODBCR1VaRmhlQWQxZm5Dd0VzV0ZK?=
 =?utf-8?B?VU4yZFlHSkNiVFRLVE1uSkhhUmxwdEs1RVJ1akRuVXlvUmYvdFpsT1dFRTJx?=
 =?utf-8?B?aGxSWjhFMHlNRjRnOWtqcVIxcWJmZW9DVi9jTUZ1RkM4NW8wbUwvekZGeDZT?=
 =?utf-8?B?T2toWEVvT016NnhFd3NqYnNVYnJJQ3lnS0xsakZhRHNXVnBXVmlYbEUreGMx?=
 =?utf-8?B?MkNQaDlJei8rZC9xcFN6MnU4UHpNQ01Jb3VCOHNJVHgva1dsdHVKNXVHL2ph?=
 =?utf-8?B?V2l0SmlMeWo4RmhsL0U4TGwzOFlSVEl3b2RZMnQ3UGluZHV4WEhzUFZ1a3dK?=
 =?utf-8?B?bWlibXp6V0R2aUg2ZSt0TmYyNkdTUUY0eFA0VkY2VUU0SXc0d2NUaUtzNUY2?=
 =?utf-8?B?RUZoeEM0SkFXRXhwbXBsZGljOTgzUjNDWWxUQm0yNmF2YXowcmp3LzYxaitt?=
 =?utf-8?B?WWVlakRVcERzVEZySFVvMjlJcHdQdjFkd21xeEVxUU1QcVhNUXJCbnYzWDM1?=
 =?utf-8?B?U3pIVTZyMkFEL000cTVKTjZVRUJSYjNwSkVvRThoSkxVbS9pOXo1ZFh6VWRs?=
 =?utf-8?B?cEJjMm5ZMzJVL3QvNlE0UzJtaXdDaTB4S2JVNGt3Y0dOY2VWMCt4S24zSWpM?=
 =?utf-8?B?OXZtSEhXeStZMGRZSHRyZjY0N0dvaWYyeFY1VTFMRG5hL2FibHFWa3VnZFdm?=
 =?utf-8?B?QnZMU2Rqb0tRQTR6dzdOYkNFRjZsa3d3clR0djdNWVZuam8xTWpncTR3a2pu?=
 =?utf-8?B?VVpzVFlncjlDcm9hQU1nTnJSTXN5OExKMlBwMytzeHEwQ0Z6bTZxM2E3OUFD?=
 =?utf-8?B?OG41MGYraHJGdGxjYnI5dW1TNEVKaUR1Rk1HZmw4Mzc4NmE0WHFEOE9IWmta?=
 =?utf-8?B?OUVGMUNaMFN3cFRlSFFiL0gxNExwTVNXLzJlbFRSd3BmckZhRUk2cEdKSSsz?=
 =?utf-8?B?cW0wK2dQS0EwN081TUZpMFpmeWx2QjN2R3R2amRMUzFsZ3AvY2xzaGdQQmNX?=
 =?utf-8?B?V1lVSDhpMDMvVHNrc0FWRGJRKzE0bVcvUzFUZGdVOG5QK3BKYUxzam5oVEFJ?=
 =?utf-8?B?c1I2VllIUU5HaXRsQWxiZ3owZnZXUzRkYjU3ekNOL3h0eGZIVm5TamF6MUl4?=
 =?utf-8?B?MXZMRjh3NTFjQ3B4R2FPRjhzcEhSanFBQURXSEp4UnZIWU5RbmZLWE45RVNl?=
 =?utf-8?B?eDVlN2lueUxIS0FSR09wcG5xWFRxTktlNlZNTEdLTlMyK1lWUHRONVRGalpS?=
 =?utf-8?B?QWFxQUpsUkJBQXZQWDMwS0d4Qm9iMTZVTmRMOHkzalU0YzVEYnZWTllKazds?=
 =?utf-8?B?cS92VGg0Nk9lZG52dlBocXBTMWljTjgvdktWc2xxbFNQVnZrVFMxSGc5TjE1?=
 =?utf-8?B?WDFxa3BMV0c1bWppTHBWcjV1d3Z1Wk0zWnEvN244SjFOdEl6eVBrOUxURHdL?=
 =?utf-8?B?OVRMSFBISEZ2a0J0YytsazBVUkhQMTJyMUMyQ3VEL3hVdFRRMnRHa2hPLzJm?=
 =?utf-8?B?M1E2c0lSaEN2Uy9pcEQ4S1lZRUtUQ1dEWDlycDdENWg4U2xXdSs4ajJtdzhz?=
 =?utf-8?B?d2V4dG1hQ2VmdldlNGlvTDNYSVdlRW0weVlEOC9heHVVOThIMFRQUjZ2R3BD?=
 =?utf-8?B?dGhHSFliWWFhV3I0QkpQOVlXZXBxMDBNaTdtRGJoUytFNHRWcXpmMnB5Z0g5?=
 =?utf-8?B?eUdJNjdsT0R2RXcyZEt5dTNuMGEyMElaYWhlSHByS3BDY1BZV252R2VuOEgz?=
 =?utf-8?B?UDJqaFpTdGl3MU1BdkVpa1Qrc2N2UldrZE5pZzdXREo3TS9TajlVOWRheVhL?=
 =?utf-8?B?RjlCanFURlN6Z2tmMlByejMrQnRqSjkrUlREYmFvZEpIcFpYNjhwYk9LTVor?=
 =?utf-8?B?aWJHNVdWWE5XNGh3Qzd0dGN2djViMEFTRGFqNmplUmVHSS9rdURac3BNRXpq?=
 =?utf-8?B?N1FmM1JWNUpmbDJCdFdzcmRmMWphZlZ4T0FrNndkeDdpTUpvT0VHM0VSWEJE?=
 =?utf-8?B?YXVvaUlFbVY3eWdUM2lMdU9qM29PVEZNLzBNTVZEWTBwZWJHS2hYSlNBdDJo?=
 =?utf-8?B?RXZMeHZRcVpiRW0xNmd0VnNRbXZ2RWs3ZzFXQ3lyeWp3am5OeG9vVXB6SmRh?=
 =?utf-8?B?N0pnVEg4bm9zcjlGTWV0WEJtM2ZybVl3TFk4UUxFM1Z5QkRpRWdrYkVNQmxj?=
 =?utf-8?B?aEdhVnErUFpGZUI2c25sSisrZCsvMlZjWHBya1BPUGdqOGVZQzRDYUUzM2Vv?=
 =?utf-8?Q?08PCJ7tVnVc8iciDyW?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb7a911-4d1f-4ae8-35a7-08de53389b89
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 06:46:12.4306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eBgjettPCe15rWnYNawh9JRtDT1OrqJOzPC92DPVPagJ5XDMnYIjpXgrgpTSHLsgiKmPk8FFFc5uCRV2YeD5OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8664

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNuW5tDHmnIgxM+aXpSAyMzoyNw0KPiBU
bzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEZyYW5rIExpIDxm
cmFuay5saUBueHAuY29tPjsgamluZ29vaGFuMUBnbWFpbC5jb207DQo+IGwuc3RhY2hAcGVuZ3V0
cm9uaXguZGU7IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsN
Cj4gcm9iaEBrZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBzaGF3bmd1b0BrZXJuZWwu
b3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZl
c3RldmFtQGdtYWlsLmNvbTsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjggMS8yXSBQQ0k6IGR3YzogRG9uJ3QgcG9sbCBMMiBpZg0KPiBRVUlS
S19OT0wyUE9MTF9JTl9QTSBpcyBleGlzdGluZyBpbiBzdXNwZW5kDQo+IA0KPiBPbiBXZWQsIEph
biAwNywgMjAyNiBhdCAxMDo0NTo1MkFNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBS
ZWZlciB0byBQQ0llIHI2LjAsIHNlYyA1LjIsIGZpZyA1LTEgTGluayBQb3dlciBNYW5hZ2VtZW50
IFN0YXRlIEZsb3cNCj4gPiBEaWFncmFtLiBCb3RoIEwwIGFuZCBMMi9MMyBSZWFkeSBjYW4gYmUg
dHJhbnNmZXJyZWQgdG8gTERuIGRpcmVjdGx5Lg0KPiA+DQo+ID4gSXQncyBoYXJtbGVzcyB0byBs
ZXQgZHdfcGNpZV9zdXNwZW5kX25vaXJxKCkgcHJvY2VlZCBzdXNwZW5kIGFmdGVyIHRoZQ0KPiA+
IFBNRV9UdXJuX09mZiBpcyBzZW50IG91dCwgd2hhdGV2ZXIgdGhlIExUU1NNIHN0YXRlIGlzIGlu
IEwyIG9yIEwzDQo+ID4gYWZ0ZXIgYSByZWNvbW1lbmRlZCAxMG1zIG1heCB3YWl0IHJlZmVyIHRv
IFBDSWUgcjYuMCwgc2VjIDUuMy4zLjIuMQ0KPiA+IFBNRSBTeW5jaHJvbml6YXRpb24uDQo+ID4N
Cj4gPiBUaGUgTFRTU00gc3RhdGVzIGFyZSBpbmFjY2Vzc2libGUgb24gaS5NWDZRUCBhbmQgaS5N
WDdEIGFmdGVyIHRoZQ0KPiA+IFBNRV9UdXJuX09mZiBpcyBzZW50IG91dC4NCj4gPg0KPiA+IFRv
IHN1cHBvcnQgdGhpcyBjYXNlLCBkb24ndCBwb2xsIEwyIHN0YXRlIGFuZCBhcHBseSBhIHNpbXBs
ZSBkZWxheSBvZg0KPiA+IFBDSUVfUE1FX1RPX0wyX1RJTUVPVVRfVVMoMTBtcykgaWYgdGhlIFFV
SVJLX05PTDJQT0xMX0lOX1BNIGZsYWcNCj4gaXMNCj4gPiBzZXQgaW4gc3VzcGVuZC4NCj4gPg0K
PiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gRml4ZXM6IDQ3NzRmYWY4NTRmNSAo
IlBDSTogZHdjOiBJbXBsZW1lbnQgZ2VuZXJpYyBzdXNwZW5kL3Jlc3VtZQ0KPiA+IGZ1bmN0aW9u
YWxpdHkiKQ0KPiA+IEZpeGVzOiBhNTI4ZDFhNzI1OTcgKCJQQ0k6IGlteDY6IFVzZSBEV0MgY29t
bW9uIHN1c3BlbmQgcmVzdW1lDQo+ID4gbWV0aG9kIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNo
YXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEZyYW5rIExp
IDxGcmFuay5MaUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2ktaW14Ni5jICAgICAgICAgfCAgNCArKysNCj4gPiAgLi4uL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jIHwgMzQNCj4gPiArKysrKysrKysrKysrLS0tLS0t
ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaCAgfA0KPiA+IDQg
KysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
LWlteDYuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+
IGluZGV4IDQ2NjhmYzk2NDhiZi4uZDg0YmZjZDEwNzljIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gQEAgLTEyNSw2ICsxMjUsNyBAQCBzdHJ1Y3Qg
aW14X3BjaWVfZHJ2ZGF0YSB7DQo+ID4gIAllbnVtIGlteF9wY2llX3ZhcmlhbnRzIHZhcmlhbnQ7
DQo+ID4gIAllbnVtIGR3X3BjaWVfZGV2aWNlX21vZGUgbW9kZTsNCj4gPiAgCXUzMiBmbGFnczsN
Cj4gPiArCXUzMiBxdWlyazsNCj4gPiAgCWludCBkYmlfbGVuZ3RoOw0KPiA+ICAJY29uc3QgY2hh
ciAqZ3ByOw0KPiA+ICAJY29uc3QgdTMyIGx0c3NtX29mZjsNCj4gPiBAQCAtMTc2NSw2ICsxNzY2
LDcgQEAgc3RhdGljIGludCBpbXhfcGNpZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+
ICpwZGV2KQ0KPiA+ICAJaWYgKHJldCkNCj4gPiAgCQlyZXR1cm4gcmV0Ow0KPiA+DQo+ID4gKwlw
Y2ktPnF1aXJrX2ZsYWcgPSBpbXhfcGNpZS0+ZHJ2ZGF0YS0+cXVpcms7DQo+ID4gIAlwY2ktPnVz
ZV9wYXJlbnRfZHRfcmFuZ2VzID0gdHJ1ZTsNCj4gPiAgCWlmIChpbXhfcGNpZS0+ZHJ2ZGF0YS0+
bW9kZSA9PSBEV19QQ0lFX0VQX1RZUEUpIHsNCj4gPiAgCQlyZXQgPSBpbXhfYWRkX3BjaWVfZXAo
aW14X3BjaWUsIHBkZXYpOyBAQCAtMTg0OSw2ICsxODUxLDcgQEANCj4gc3RhdGljDQo+ID4gY29u
c3Qgc3RydWN0IGlteF9wY2llX2RydmRhdGEgZHJ2ZGF0YVtdID0gew0KPiA+ICAJCS5lbmFibGVf
cmVmX2NsayA9IGlteDZxX3BjaWVfZW5hYmxlX3JlZl9jbGssDQo+ID4gIAkJLmNvcmVfcmVzZXQg
PSBpbXg2cXBfcGNpZV9jb3JlX3Jlc2V0LA0KPiA+ICAJCS5vcHMgPSAmaW14X3BjaWVfaG9zdF9v
cHMsDQo+ID4gKwkJLnF1aXJrID0gUVVJUktfTk9MMlBPTExfSU5fUE0sDQo+ID4gIAl9LA0KPiA+
ICAJW0lNWDdEXSA9IHsNCj4gPiAgCQkudmFyaWFudCA9IElNWDdELA0KPiA+IEBAIC0xODYwLDYg
KzE4NjMsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteF9wY2llX2RydmRhdGEgZHJ2ZGF0YVtd
ID0gew0KPiA+ICAJCS5tb2RlX21hc2tbMF0gPSBJTVg2UV9HUFIxMl9ERVZJQ0VfVFlQRSwNCj4g
PiAgCQkuZW5hYmxlX3JlZl9jbGsgPSBpbXg3ZF9wY2llX2VuYWJsZV9yZWZfY2xrLA0KPiA+ICAJ
CS5jb3JlX3Jlc2V0ID0gaW14N2RfcGNpZV9jb3JlX3Jlc2V0LA0KPiA+ICsJCS5xdWlyayA9IFFV
SVJLX05PTDJQT0xMX0lOX1BNLA0KPiA+ICAJfSwNCj4gPiAgCVtJTVg4TVFdID0gew0KPiA+ICAJ
CS52YXJpYW50ID0gSU1YOE1RLA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gaW5kZXggNDNkMDkxMTI4ZWY3Li4w
NmNiZmQ5ZTFmMWUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiBAQCAtMTE3OSwxNSArMTE3OSwyOSBAQCBp
bnQgZHdfcGNpZV9zdXNwZW5kX25vaXJxKHN0cnVjdCBkd19wY2llDQo+ICpwY2kpDQo+ID4gIAkJ
CXJldHVybiByZXQ7DQo+ID4gIAl9DQo+ID4NCj4gPiAtCXJldCA9IHJlYWRfcG9sbF90aW1lb3V0
KGR3X3BjaWVfZ2V0X2x0c3NtLCB2YWwsDQo+ID4gLQkJCQl2YWwgPT0gRFdfUENJRV9MVFNTTV9M
Ml9JRExFIHx8DQo+ID4gLQkJCQl2YWwgPD0gRFdfUENJRV9MVFNTTV9ERVRFQ1RfV0FJVCwNCj4g
PiAtCQkJCVBDSUVfUE1FX1RPX0wyX1RJTUVPVVRfVVMvMTAsDQo+ID4gLQkJCQlQQ0lFX1BNRV9U
T19MMl9USU1FT1VUX1VTLCBmYWxzZSwgcGNpKTsNCj4gPiAtCWlmIChyZXQpIHsNCj4gPiAtCQkv
KiBPbmx5IGxvZyBtZXNzYWdlIHdoZW4gTFRTU00gaXNuJ3QgaW4gREVURUNUIG9yIFBPTEwgKi8N
Cj4gPiAtCQlkZXZfZXJyKHBjaS0+ZGV2LCAiVGltZW91dCB3YWl0aW5nIGZvciBMMiBlbnRyeSEg
TFRTU006IDB4JXhcbiIsDQo+IHZhbCk7DQo+ID4gLQkJcmV0dXJuIHJldDsNCj4gPiArCWlmIChk
d2NfcXVpcmsocGNpLCBRVUlSS19OT0wyUE9MTF9JTl9QTSkpIHsNCj4gPiArCQkvKg0KPiA+ICsJ
CSAqIEFkZCB0aGUgUVVJUktfTk9MMl9QT0xMX0lOX1BNIGNhc2UgdG8gYXZvaWQgdGhlIHJlYWQg
aGFuZywNCj4gPiArCQkgKiB3aGVuIExUU1NNIGlzIG5vdCBwb3dlcmVkIGluIEwyL0wzL0xEbiBw
cm9wZXJseS4NCj4gPiArCQkgKg0KPiA+ICsJCSAqIFJlZmVyIHRvIFBDSWUgcjYuMCwgc2VjIDUu
MiwgZmlnIDUtMSBMaW5rIFBvd2VyIE1hbmFnZW1lbnQNCj4gPiArCQkgKiBTdGF0ZSBGbG93IERp
YWdyYW0uIEJvdGggTDAgYW5kIEwyL0wzIFJlYWR5IGNhbiBiZQ0KPiA+ICsJCSAqIHRyYW5zZmVy
cmVkIHRvIExEbiBkaXJlY3RseS4gT24gdGhlIExUU1NNIHN0YXRlcyBwb2xsIGJyb2tlbg0KPiA+
ICsJCSAqIHBsYXRmb3JtcywgYWRkIGEgbWF4IDEwbXMgZGVsYXkgcmVmZXIgdG8gUENJZSByNi4w
LA0KPiA+ICsJCSAqIHNlYyA1LjMuMy4yLjEgUE1FIFN5bmNocm9uaXphdGlvbi4NCj4gPiArCQkg
Ki8NCj4gPiArCQltZGVsYXkoUENJRV9QTUVfVE9fTDJfVElNRU9VVF9VUy8xMDAwKTsNCj4gPiAr
CX0gZWxzZSB7DQo+ID4gKwkJcmV0ID0gcmVhZF9wb2xsX3RpbWVvdXQoZHdfcGNpZV9nZXRfbHRz
c20sIHZhbCwNCj4gPiArCQkJCQl2YWwgPT0gRFdfUENJRV9MVFNTTV9MMl9JRExFIHx8DQo+ID4g
KwkJCQkJdmFsIDw9IERXX1BDSUVfTFRTU01fREVURUNUX1dBSVQsDQo+ID4gKwkJCQkJUENJRV9Q
TUVfVE9fTDJfVElNRU9VVF9VUy8xMCwNCj4gPiArCQkJCQlQQ0lFX1BNRV9UT19MMl9USU1FT1VU
X1VTLCBmYWxzZSwgcGNpKTsNCj4gPiArCQlpZiAocmV0KSB7DQo+ID4gKwkJCS8qIE9ubHkgbG9n
IG1lc3NhZ2Ugd2hlbiBMVFNTTSBpc24ndCBpbiBERVRFQ1Qgb3IgUE9MTCAqLw0KPiA+ICsJCQlk
ZXZfZXJyKHBjaS0+ZGV2LCAiVGltZW91dCB3YWl0aW5nIGZvciBMMiBlbnRyeSEgTFRTU006IDB4
JXhcbiIsDQo+IHZhbCk7DQo+ID4gKwkJCXJldHVybiByZXQ7DQo+ID4gKwkJfQ0KPiA+ICAJfQ0K
PiA+DQo+ID4gIAkvKg0KPiA+IEBAIC0xMjA0LDcgKzEyMTgsNyBAQCBpbnQgZHdfcGNpZV9zdXNw
ZW5kX25vaXJxKHN0cnVjdCBkd19wY2llICpwY2kpDQo+ID4NCj4gPiAgCXBjaS0+c3VzcGVuZGVk
ID0gdHJ1ZTsNCj4gPg0KPiA+IC0JcmV0dXJuIHJldDsNCj4gPiArCXJldHVybiAwOw0KPiA+ICB9
DQo+ID4gIEVYUE9SVF9TWU1CT0xfR1BMKGR3X3BjaWVfc3VzcGVuZF9ub2lycSk7DQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJl
LmgNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+
ID4gaW5kZXggMzE2ODU5NTFhMDgwLi5kZDc2MGMxN2JkY2MgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPiArKysgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+IEBAIC0zMDUsNiAr
MzA1LDkgQEANCj4gPiAgLyogRGVmYXVsdCBlRE1BIExMUCBtZW1vcnkgc2l6ZSAqLw0KPiA+ICAj
ZGVmaW5lIERNQV9MTFBfTUVNX1NJWkUJCVBBR0VfU0laRQ0KPiA+DQo+ID4gKyNkZWZpbmUgUVVJ
UktfTk9MMlBPTExfSU5fUE0JCUJJVCgwKQ0KPiA+ICsjZGVmaW5lIGR3Y19xdWlyayhwY2ksIHZh
bCkJCShwY2ktPnF1aXJrX2ZsYWcgJiB2YWwpDQo+ID4gKw0KPiANCj4gVGhvdWdoIEkgbGlrZSB0
aGlzIHF1aXJrIGlkZWEsIEkgdGhpbmsgYXQgdGhpcyBwb2ludCBhIHNpbXBsZSBmbGFnIHdpbGwg
ZG8gdGhlIGpvYi4NCj4NCk9rYXksIG5vIHByb2JsZW0uDQogDQo+ID4gIHN0cnVjdCBkd19wY2ll
Ow0KPiA+ICBzdHJ1Y3QgZHdfcGNpZV9ycDsNCj4gPiAgc3RydWN0IGR3X3BjaWVfZXA7DQo+ID4g
QEAgLTUyMCw2ICs1MjMsNyBAQCBzdHJ1Y3QgZHdfcGNpZSB7DQo+ID4gIAljb25zdCBzdHJ1Y3Qg
ZHdfcGNpZV9vcHMgKm9wczsNCj4gPiAgCXUzMgkJCXZlcnNpb247DQo+ID4gIAl1MzIJCQl0eXBl
Ow0KPiA+ICsJdTMyCQkJcXVpcmtfZmxhZzsNCj4gDQo+IFlvdSBjYW4ganVzdCBhZGQgYSBmbGFn
ICJza2lwX2wyM193YWl0IiBpbiBkd19wY2llX3JwIGFzIHRoaXMgaXMgYSBSb290IFBvcnQNCj4g
YmVoYXZpb3IuDQpPa2F5LiBUaGFua3MuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4g
DQo+IC0gTWFuaQ0KPiANCj4gLS0NCj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCu
pOCuvuCumuCuv+CuteCuruCvjQ0K

