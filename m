Return-Path: <linux-pci+bounces-25131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C70A7895F
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 10:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300BD3AB415
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 07:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B9F2F5A;
	Wed,  2 Apr 2025 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hUHFJydu"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24196233707;
	Wed,  2 Apr 2025 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743580772; cv=fail; b=uX/WS+ALCUZwNBpleJtW88y64TX2abbTAiM6LsxGFDjwYaFeo7tuDTzKLo73lm/Uffc2eIngS9BofIehF9hJr4s86fwTm/kR9bVpAXTyqfPEFm+g/6JwIaMevuFnlQ2huE8AGHnctlyUW2EdP5U6OFfrsyRRIzo80vlzmPvuI9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743580772; c=relaxed/simple;
	bh=7gzbsQKET8xLJ0NUgueRMZx5z1u4uFyOR+F9i+Mmok4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ErIPupPxL2z4wh8L3RIY8AHu3mOrO8ksjH3ANNcNcNAlI4Bq297I0J2CIcWCNDVqg9vQbNGKsiQ9PP4LaLooshAyEMDxogMvflGAesnVYDV0DbyYjajMo86DwCHztyqCXspYlPeEloRrnD7DTcVNXzLjff/DpRivEoAi1jFJfww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hUHFJydu; arc=fail smtp.client-ip=40.107.159.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtpQ5nTndD//5ufKHYmYgGcEgBLzGiyRNAR15c79B54pdf8Eq/8eOBLcNPQrIkrXrUD6/c4VMIf3cj+zHXAj2ZR0ym3M7FdPNTcioaGvCZpuY80HTrAJm02b8onZ1rBPO+2DSIPewbXnwPBQ/8ydDD+cLKEYM3KRRkNU71pAKkSTgPu/4zOsg3ynYMVvYDSAC7whVVhkNq34N6+Y+0mK+oYU3d2u+ivkjVIU0qMwKC/3dAihibZ+VZyEU3MbSV+Laj4lNgArUu5g24Ahlhw1dPvvPeSI8vUR5/7VUy9F5zNC4NpY3aLFpslKpOOUWNLMDx1wyXny2l9vvToNA4FprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gzbsQKET8xLJ0NUgueRMZx5z1u4uFyOR+F9i+Mmok4=;
 b=qiOSXWeRvvkVbFN8c4oNQ3itj1BG9b3hxDcXEm3PeRF8TjJ/6K6Ijhr1nN8PpkEKZsBeWRxVdJcSZ68puc+wH0K6wK3pWeD2Lt/7a29XPvB99FLIsMZHOjwwk57tW0SmSQZkS+uhbJN2eQCjGwKnbTNPA4njXZWY+uoh/WGaBMHoEdTPD/W1HddMKaqPXBdRr8FqGWOF/XfSdJ487untEg3aSBkvWRiyshRw3VBdzbd0d9Ohq6k7OPUgGanm5Tm6HMP+eoHZ8+TShqA5cPRUxyi/jJfJ0P2xLwMWD301BPDQEb7/GL+nF06Ndp1C1xHsOVY/GNlLEIuIHwefjxGoxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gzbsQKET8xLJ0NUgueRMZx5z1u4uFyOR+F9i+Mmok4=;
 b=hUHFJyduj/Qi41OWgl4Yfx2x1JmmjKcaO6kKUmDIB2Q+IX6mSxBPUmAbtcwRnfbOyvFzoemWKq1IDBJsz2GuNt/ngd6m4o2wygpQg7ge3/ocwn+H0JLpAI6WXYzyj+wB5KT0Nc6zsqIOEaqwuON53KN0/9PE1EztiXp94xt+IagOs1t0JSyaiR1g/2WIhNAUP/LBTb80f29h870YhodvSQVPID5QRCT75ycx8GVQoxhd1N8Po6khogw8Lq6KkVW6I3kEaKTaOG/B4eN1qgmgG40MXtQmHFvf6Upt0tKznQcY8WyF3LHNfcvxuO9iZSNtgWBqTp1mTo2NT82himHn+w==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DU2PR04MB8744.eurprd04.prod.outlook.com (2603:10a6:10:2e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Wed, 2 Apr
 2025 07:59:26 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 07:59:26 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/6] PCI: imx6: Workaround i.MX95 PCIe may not exit L23
 ready
Thread-Topic: [PATCH v3 3/6] PCI: imx6: Workaround i.MX95 PCIe may not exit
 L23 ready
Thread-Index: AQHbn44DKK1oo7avrE6ytacDA3gL7LOP/LQAgAAFMnA=
Date: Wed, 2 Apr 2025 07:59:26 +0000
Message-ID:
 <AS8PR04MB8676687332C78840B927E7568CAF2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
 <20250328030213.1650990-4-hongxing.zhu@nxp.com>
 <ovaomfvo7b3uxoss3tzhrkgdy6cvxi4kr2zxmqsfjxds5qfohl@t6kc4rswq6gp>
In-Reply-To: <ovaomfvo7b3uxoss3tzhrkgdy6cvxi4kr2zxmqsfjxds5qfohl@t6kc4rswq6gp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DU2PR04MB8744:EE_
x-ms-office365-filtering-correlation-id: bf29f402-bdca-4e5a-af9e-08dd71bc49c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QUtIVHc1amNjSVBKekVzTTRGS0FUc0JxR0oyTjBGclBoMDFPcExKTG5PeGlX?=
 =?utf-8?B?eTE2cHZORDMrc2NPazNhQVVvbUZ4bno1cVRqVmxsb0thSkJHNnVlcXgzS0RG?=
 =?utf-8?B?UDFURHg1NU0rVnNCbFJRVGhBVGpQV056UEpOSDd1dXVrczl5K2NCUGlUaUwv?=
 =?utf-8?B?ZmxsUDAxOEZnbmxPUmppM0NJS0tFYXpyNGlPeVpuekRWTHhMVEI4SkhrVFQz?=
 =?utf-8?B?ZEZtdGMxeVQxZVplbFZPNUVqV0RMRVJUdmNucWZwczVST3VlSDViOGVSdTlV?=
 =?utf-8?B?WDJFYmRsTmdwUzZpUWFXbUR1NUd4eU9tOTdMcUlCL0hKUXVxZUVmcUxsMW10?=
 =?utf-8?B?bGgxV3kveHAyV05OS1JlRStoT2hyR2xPb2JQb21CZnJPNk1nUldyNkQrVi85?=
 =?utf-8?B?NjVUUjdnaklCb3BCT3VBaGc1WXNIam83TlVFcllWM0lwOXN1NUlBS1F4d0Yw?=
 =?utf-8?B?ekgvclJHWk8rWmpsL3VPN3gwMFFSeFkwZ1owbEU0WjQzK01YQlhreTBDUzlu?=
 =?utf-8?B?M01QN1BFMit3elZtMko0a3czVmY1NHFES3pCVUVibC83eFRrenBWckl1MEty?=
 =?utf-8?B?M1VERUh2TWVwdjJPZXNBNmZDVWIvYXZpR1hrak8vZWVDMXYvS0hmM05lVjZj?=
 =?utf-8?B?aFRNTTdJQzNCcHV0M0xBWlliQ0lPaXNFcFBuZWtCeWhRRmZtcHRoRG83ZzJz?=
 =?utf-8?B?dU5DWUVwNEs5MzN0K2xrSXlNTGpHcUJUUGJ2NmZGQnl2NWlLd2ZIRTBMUFI0?=
 =?utf-8?B?SzVrTzhHU1pXbjZTanl4NzhFUE8reVZERXRmWkJhNkR3eVpXbTkzSGdZcGh5?=
 =?utf-8?B?OUFRZ2tiR1pOckNuaUhCeHk5elBaT1FNYVZtSzQ3RklvVHNRY0UzRmRpSmZu?=
 =?utf-8?B?aDE5bHJaMGxMVEdZK0J6ODd4bHk2VEowRVA4U0E2T3R3ZG0wMFVNUVZnZFFW?=
 =?utf-8?B?bmI2QWp3Z01GYXlESm5lSzF3ZVVMREN2aTU4c253UW5XSmU0ZlZudHZ6VzdT?=
 =?utf-8?B?alJhT0FGQ1NiZEJVaENqNklGL21iODFOYm81MWZLQ0pLdUU2OHRudDYwd0Uy?=
 =?utf-8?B?eHFIQ3JEbEJwTzJJdTlSUlBLOTlTK0FSTUJzcXZmSmJuQXR5ZFlETXE1VGIv?=
 =?utf-8?B?c0djRXZvb3M1VTB2MlN4eXpyS2Q5UWVYWXQyUFdDajdaOGxFc2dsSi9yTnR1?=
 =?utf-8?B?a3htWnNMTVEzUCt4U2pEUVIxWUhaRFFMcXcrUDZIMU9iMXlpOGVKQXRlYWMv?=
 =?utf-8?B?K3NDNUNZN2FFbFUzRlV4OU50SEVyOEw0QUZMcktaRDZlVkdjQlp0a1NpYmNa?=
 =?utf-8?B?aUMrZnVPTVFDbndRUGFvRms0amZzTGFHaU5OWjlady8yYlFlRFZQejhXd0ov?=
 =?utf-8?B?bXFlUGRDNEtPckM1ZkJHLzJaVVhELzRSZktvN1lvUUJWWll5dXlnTHB5cmJz?=
 =?utf-8?B?ajUrcGpZMC9lYzB5amZJeXVwSjlxaTY5R1RSQ1laYzNYK1oxOTduZnFialA2?=
 =?utf-8?B?dm1uVGluR3VyVi84NytSNUNpS1RHUVYzcjljMjltUHRvQ0Z1b1pZSzc4cGla?=
 =?utf-8?B?WVRhaUpyL2Q3NmowZzVqNXJBa25od2g2eXdLdzBONHJkVHNaYU1iU1l1RlFX?=
 =?utf-8?B?Uk1HampYOStzQ2NhVU9FMCs5TkFXN1lCY2EyQUVva0IxNFhIdVprSmtISEhK?=
 =?utf-8?B?bEVYWWl3Ym9YcUNzV2Y3M256NUNUbWF5SGptS215M0tld1FrQ0IrWDFWL24v?=
 =?utf-8?B?c0Q4OTU3S0QyWTZIQ1RkWDVFWTk5azExRjh0STJGVklyRUJhUm8zRzBZSTlE?=
 =?utf-8?B?MkxDeDJJcGVGWWdZODZZWGRmVXFRYmIwRk1OZ21yZFI2Y2ppVTV5QXZKbkI4?=
 =?utf-8?B?LzZxQWtsQno1eklPK2ozV0VuWklqNUMwRTBFWVhrd09uWHdkS1VGWEI2dU9B?=
 =?utf-8?Q?ZqsXsppGzO8QPzc0UQZ7Ec/gErY6upZs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WEYwY0NldHVKcDl0aWx1T3o3YjJrbjhXcTNKNHpPcEEwc3A4OUNxWFF2QWZy?=
 =?utf-8?B?d2RGWXg5WWpVb0VVaWdZSXVCdlhEblR6MXNiUXVFL21IcVZ6NDlnSm9oejBY?=
 =?utf-8?B?VjdRYlkxTFBaY0V1ZDdJSXhEVVFNeVRiQmhtY0JGbHgxSEsyUHY4bXRNdWsz?=
 =?utf-8?B?QlFHeEg1dmNqTndrbTB5VEtXbmduazdIOG5hZ1R5QlpqcTJ6YUhxbGlOaUtq?=
 =?utf-8?B?UVdob0ZjdGNIVXB3V01neDh3RTZBTUlFMVNjenNyTTNZL3k2OURJRzJEMHR3?=
 =?utf-8?B?SXhYUXJ5VjYyZnE1aFB3cElVNGk2aWltMFk2ZkpNdnU5TndyMEdPRlJPc05a?=
 =?utf-8?B?c096ODR3YTFhUW5VYk10KzEvZUdYOGNMNnRaNE15VGtkZ0k4d2RUOUVhK2g2?=
 =?utf-8?B?azZ1cXYrRXFEdWg4TDI1YXZjaG42NjhtRmlBZFUxcmNyYVpFNXUyMmVLNVV6?=
 =?utf-8?B?U2MrS3JwdmZ3d1ZpbUVGQnFOK0Erd0lzcFV4MEZqUTU1UkJhdFJPSE43Kzkr?=
 =?utf-8?B?L04yMjR0cVE1MHZpSnhrMXdTTVlLb2JRRjl6SkV5cjhVRWVQd3l4S3dFQ1dH?=
 =?utf-8?B?cmJKaTNVcVIwQlRUTlNyZCtsZTVGaHlwVUptVUZxL2NhaDQwbWxVRHphbTdZ?=
 =?utf-8?B?UlUyZFZ4bXdsSGk1anVJd3RkVUZ4aVJXUzU2dHh0bjJDZEJaZjV5RXYzOU40?=
 =?utf-8?B?QitFRkY4K0FKZFVqZU1yUnUxeGRORlZWQjRubzNTK2NkOHpXV0QzNGhqMHBP?=
 =?utf-8?B?VkdHeWFqUXJzVjVqOUh0eWRtaDI1QWQzVG4zSzVJYXNKd05NaDhRT2tJQzhn?=
 =?utf-8?B?alhrbStyWGpoVHRDVDdNaEZzZ1JGZXZNRDBJKzZHeVB4czQxeHIxL29FTThX?=
 =?utf-8?B?dGZwalQ2TmNuc0xDUlA0enVhNTRuUnpIc0ZxRVlGUXFkM28vSVd1dFg5NGRN?=
 =?utf-8?B?ZitFaXZaaFc3QWsvRUFHUC9ZbzlqZ2hwWGs3OUZMMFFWYmFpd0lnMG9ITWJX?=
 =?utf-8?B?UFVWekpCUEhFZER0M3UrQUh5eUI0dGliZXdhdCtTT0trVFQzbFBFRFZrUjdB?=
 =?utf-8?B?NnJSa1R6OEx3ejl1Y3R6d1dmQ0FJUUkra3Z6bVBENThZRzNzKzhZNDFUOWJU?=
 =?utf-8?B?UUpOcUhoRmVkcVdCUXRPcVcxOFVMWmtYTDY0S2hqaXovTlBFbFhuYzNja1dC?=
 =?utf-8?B?ZklzSExkTlNydjJNcjR1Um1rTkp3ZkdIUEdFUjU1Q1RRYzdZenRsakZEbkd5?=
 =?utf-8?B?MHlrTHZObkIrWmNSZkdtdHZBakUrSCt5OW1JdS9qRGlmak5DNEdPbWlnRTRS?=
 =?utf-8?B?WENrUDhQSk5sby9KV1RPRDVBbjVxWmxOMXVXUml0QnFVZndxNUpFTXgwcTJp?=
 =?utf-8?B?UW1DZXRrbytoVEIrdWduV2tOV3Q0R1I0ckM2MkZLcmgrY3Q0bTFzL0xJTXFU?=
 =?utf-8?B?WS9sRFdOV01rdGRkQzhnWTJ2QXBQOEtSWmZDTnAvNXFOQVpWRXN4bEROOXNm?=
 =?utf-8?B?cEJsSCt0SVN3b3RGdVhHS1RQUmpqQmlwSzBSQ3dlWGRCRThLVi9WaFZzMzFG?=
 =?utf-8?B?VkpjOHZQZHNXRG5vUkgzV2tjbHBPYXFnbG5YcFNPV1lDL3A0TW9uNWVFK2JG?=
 =?utf-8?B?c1lZQzdCZUVPdnBJSFRoQnVIYnlxNml2eTNYMUljWTg5L21EekFJbzlUeDJz?=
 =?utf-8?B?UXltRm50eCs5R3lpcHJLdnZOc05zRWJBMm9rTnphUXB4UDRReDhiM0NCMjFz?=
 =?utf-8?B?NWRDV09UMWZpc05vdFcyOTZrWkU4ZmsydVM3VC9kTGZVLzlQQnZFdjFvV1dN?=
 =?utf-8?B?Wjk1aGdoMlF5d1J2dXUrOEl6SXFOdS8vVHlXRDdub3VyeFh4b2IvVW5LdWF2?=
 =?utf-8?B?YXo1Sm9MRDdEdjR6Y21KczdhTUNDRTd6VEQ2N1AzT24ybzN6bDMwVHZaSGZw?=
 =?utf-8?B?MzIwK3Byb1ZiWTZYWGFEVFhCMlpOdzJ2YWRUdlZZcWxCaSsySmZnRzZJUVYy?=
 =?utf-8?B?VWxYZzRidk1id2ZINU8yTHlqazg0KzNsYXY1MFFiYkU3cE9nekhGYVFSWkpD?=
 =?utf-8?B?RHM4MDgyaENyUEFHWUtxcWc4UDZubzZiai9nVU5ON2UwNlQ2aEpmemJPaHQ0?=
 =?utf-8?Q?1Qs8nj9PrUZkpBcN1qpYVvTtW?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf29f402-bdca-4e5a-af9e-08dd71bc49c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 07:59:26.2192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z4rmsjgCtppOoAQ5Rwd7GW07bTlRkQue7M5swyCXN3qWh2BUxbG7v/cYfmUjbdwBgeflroGi52nXyDk6r+rcCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8744

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI15bm0NOac
iDLml6UgMTU6MDgNCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+
IENjOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7
IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsNCj4ga3dAbGludXguY29tOyByb2JoQGtlcm5lbC5vcmc7
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVu
Z3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29t
OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAzLzZdIFBDSTogaW14NjogV29ya2Fy
b3VuZCBpLk1YOTUgUENJZSBtYXkgbm90IGV4aXQgTDIzDQo+IHJlYWR5DQo+IA0KPiBPbiBGcmks
IE1hciAyOCwgMjAyNSBhdCAxMTowMjoxMEFNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4g
PiBFUlIwNTE2MjQ6IFRoZSBDb250cm9sbGVyIFdpdGhvdXQgVmF1eCBDYW5ub3QgRXhpdCBMMjMg
UmVhZHkgVGhyb3VnaA0KPiA+IEJlYWNvbiBvciBQRVJTVCMgRGUtYXNzZXJ0aW9uDQo+IA0KPiBJ
cyBpdCBwb3NzaWJsZSB0byBzaGFyZSB0aGUgbGluayB0byB0aGUgZXJyYXR1bT8NCj4gDQpTb3Jy
eSwgdGhlIGVycmF0dW0gZG9jdW1lbnQgaXNuJ3QgcmVhZHkgdG8gYmUgcHVibGlzaGVkIHlldC4N
Cj4gPg0KPiA+IFdoZW4gdGhlIGF1eGlsaWFyeSBwb3dlciBpcyBub3QgYXZhaWxhYmxlLCB0aGUg
Y29udHJvbGxlciBjYW5ub3QgZXhpdA0KPiA+IGZyb20NCj4gPiBMMjMgUmVhZHkgd2l0aCBiZWFj
b24gb3IgUEVSU1QjIGRlLWFzc2VydGlvbiB3aGVuIG1haW4gcG93ZXIgaXMgbm90DQo+ID4gcmVt
b3ZlZC4NCj4gPg0KPiANCj4gSSBkb24ndCB1bmRlcnN0YW5kIGhvdyB0aGUgcHJlc2VuY2Ugb2Yg
VmF1eCBhZmZlY3RzIHRoZSBjb250cm9sbGVyLiBTYW1lIGdvZXMNCj4gZm9yIFBFUlNUIyBkZWFz
c2VydGlvbi4gSG93IGRvZXMgdGhhdCByZWxhdGUgdG8gVmF1eD8gSXMgdGhpcyBlcnJhdHVtIGZv
ciBhDQo+IHNwZWNpZmljIGVuZHBvaW50IGJlaGF2aW9yPw0KSU1ITyBJIGRvbid0IGtub3cgdGhl
IGV4YWN0IGRldGFpbHMgb2YgdGhlIHBvd2VyIHN1cHBsaWVzIGluIHRoaXMgSVAgZGVzaWduLg0K
UmVmZXIgdG8gbXkgZ3Vlc3MgLCBtYXliZSB0aGUgYmVhY29uIGRldGVjdCBvciB3YWtlLXVwIGxv
Z2ljIGluIGRlc2lnbnMgaXMNCiByZWxpZWQgb24gdGhlIHN0YXR1cyBvZiBTWVNfQVVYX1BXUl9E
RVQgc2lnbmFscyBpbiB0aGlzIGNhc2UuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4g
DQo+IC0gTWFuaQ0KPiANCj4gLS0NCj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCu
pOCuvuCumuCuv+CuteCuruCvjQ0K

