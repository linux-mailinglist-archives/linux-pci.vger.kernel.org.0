Return-Path: <linux-pci+bounces-16094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C129BDBB3
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 02:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC401C22C8E
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 01:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F8A18CC13;
	Wed,  6 Nov 2024 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GjBw6tTE"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2051.outbound.protection.outlook.com [40.107.103.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0167218C93F;
	Wed,  6 Nov 2024 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730858387; cv=fail; b=CinQvipfvGF5hjOdFWQ2FZErfwjNi9so4/E9kDdCdYIWfifd6Fxo5hqpMLKczm/1PAmOP0Nuy2rPeKeRrj9RTSfPxb3zKrcvx4z7abz0K7e2uQgWyv6uIAI9L+37/dq9DrI41AuY7lWf6JzWQD1uDr4Q0dDpDaX0lfXFEGfPfB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730858387; c=relaxed/simple;
	bh=x7bpjBEgZ0OPQl2CLQTgw8N74gGQE2666b0SjdUVBao=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qzh5A9Bf4k56YXB6skzw8aFpCqHBxE7XVkFGTB3gIxoX60kR2gRL1FLZX6bfFOEk+E/OKmBCCcuTIMsFaSxcTq0TjDt/Uwcp9dlZlRVgBG6CoB1jkWiq5oy4baPs4ebZKoU9Ga9PZy+KBUlY5WLiyTLbO0Ok215+jTE5YPW6LEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GjBw6tTE; arc=fail smtp.client-ip=40.107.103.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9FI5zwhyWizLAiNfXix1X364F9Ma+27vnReOFCcQ/P9qRldAPjcLgk//B0bRZ70kBdiPXPc8Rv0ro34inq5hnuPe8Q7ghQ9GGLcmfsPpiHSFvXueMpKo+KnRXzPm60Lzm02VSGV89D4fVfXC/tf/f2Xmn6S81nP/HZGscrVomonR9INeoIXreXxo51BYEoeRaVRmuakAjlWwFMDjIziGOOOmVhp4AVhZyayrwWjqvSMZGK4IUZupCir3CSBtKIqPtUW60f0kz6l+1gWz8YVDGS/Z4PQuvYkHlJ9TgYdg6u2mVA/GmU4oYcMmZCLdkVfoyPcCqd8odOW5IHEYL7kUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7bpjBEgZ0OPQl2CLQTgw8N74gGQE2666b0SjdUVBao=;
 b=TD6gEciCmCHzr75a6lRtLQrPq4jpB89dspG5ZFPt40JwulYGBxkS9v/lbu7CEZVFrtm5VOMPa83/HxmJLNq3iDHSyPs5c4XABB4DcLdhe2iDAu6GFT9CsvKzM3blP063betjW7tEOknnthvr3GqqSuKfpXhKu52oFCGsKUbZ4LEFKcqp85XUJHiqBJiuAoLvD+3R3tD4GGq9zw9GCW+4Pvt1f3xfK/JDTmLm2TvP+QzafNwbll7WJqDHs3RTaNNMWBBZPYyuliNX8bOj85BrtD1rxaeUX4niAylA3bXOfQcISrR8Z6+0Aq5efaKl//RJ8Gb9IS8POkB4ewslCJlhYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7bpjBEgZ0OPQl2CLQTgw8N74gGQE2666b0SjdUVBao=;
 b=GjBw6tTE76zNvkjDsSIoCK7F2XS6kiabkwAa+ASxn4l/ZxZ6wjgsrzxSJZXH1fFkUUSuQOW69ui5CvoboB1bq8RdgrYR3KKzFj/k0ayCbHHRmoDcjknCMFzxHtyd7CnpTj4CJy2SiKMUZjXxQwLFFx6wZ73r44R7T8NESQPzXBtmPMm97DG6+hT9cxc1kOJFr6mZF/24Z8kQVyFbvLrd9d9x8rLUHypnfWE4ISNrD3/Vrt4+i7tAz412InKahoXkkIWv1HVPVSSeCPMT3BUBcFoLVGq0uJGtpZ0sdVae0ezLWwaLw89Ky7v9gYpbbiYiMLPixXT+RptAIpqnkQeTWg==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM7PR04MB6775.eurprd04.prod.outlook.com (2603:10a6:20b:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 01:59:41 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 01:59:41 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "kwilczynski@kernel.org" <kwilczynski@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lorenzo.pieralisi@arm.com"
	<lorenzo.pieralisi@arm.com>, Frank Li <frank.li@nxp.com>, "mani@kernel.org"
	<mani@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2] PCI: dwc: Fix resume failure if no EP is connected at
 some platforms
Thread-Topic: [PATCH v2] PCI: dwc: Fix resume failure if no EP is connected at
 some platforms
Thread-Index: AQHa3AEqv5bRdDxqKkSUwsC4eegPdrKp/GuAgAAjY0A=
Date: Wed, 6 Nov 2024 01:59:41 +0000
Message-ID:
 <AS8PR04MB8676998092241543AEABFAAB8C532@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1721628913-1449-1-git-send-email-hongxing.zhu@nxp.com>
 <20241105232701.GA1495103@bhelgaas>
In-Reply-To: <20241105232701.GA1495103@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AM7PR04MB6775:EE_
x-ms-office365-filtering-correlation-id: f99edc40-eb81-4b9f-a400-08dcfe06ad80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?cDZmTEp5Zzh2SUZRYTlNc2xWRHVaSFFHZ3I0ZWtObjAvak1pcU9xUHkySlZn?=
 =?gb2312?B?R1dLanNUeDFKNFZESStFbUE4OGlDdS9mWGl0Sk5aUHdPSGJMWE5TMDlvOHlL?=
 =?gb2312?B?dlNXMitka01nTGZKSzRGbzl5dVZGWElWYm1jYmpFNVd4dGlMSnFYalFtMDJB?=
 =?gb2312?B?dW1wdEM5dllCOWxTQ284UWxJTCtQUGlMb2h2a1RBckN2WkRHcnY5c3lIZVYv?=
 =?gb2312?B?bUlYV2tiQ3BPTHUvVWtjRU55YW56emNWSnhUYVhRL2pYNkZhTkdlUFNKa2hZ?=
 =?gb2312?B?RnVDbURGNmVqb0Y5ZHNBWkZVZmpORU5zTnVmK2lpUDF0a1VJdUk2Zkg0bWpK?=
 =?gb2312?B?WUM2RWo3TGlxVEFMVlI2Tm5PTWhnMkxwbTl4ajRoa0ZRR2syZksyU0V6U3pW?=
 =?gb2312?B?cTcxc0dyVzZWem9xdnhtckxlYndiTXZwUm9JRnNGelhvVGljM2RveStYbzFN?=
 =?gb2312?B?NW9PdTRWK084Rk1TVUUzWlczcGJ4QWdOdGNFY2M1NlZmQ3Ewb3NTUW4yOWd0?=
 =?gb2312?B?NnVQb0plVUVtS3pLQjlRbnNMck9kdm1VSjREWUYvSXJpa3BxSnZFWk9lc000?=
 =?gb2312?B?dlR6QWlsaldhQUdJWHR2c2lVNFF6dW1YWUJCdk8zOHNYSFc5WHFPVW80OEJG?=
 =?gb2312?B?alQyM015TGJCY2h0YnpZUjYzelJST2F2d1dieXMwZlN4NWNhWHBkK0tsNW50?=
 =?gb2312?B?R2ZkWGxsSGRLK2t4YzdzOW1pcnZBbS9OMHh3UkNmVlB2WHFjOTZhSFRGWGdN?=
 =?gb2312?B?THlBcCszSjJBNUNrK1VzRXIzVjFYY2w3ZGVOZzYwT2o3TXVoMU1WOTRGb2dU?=
 =?gb2312?B?YjhPcUR3QWdnbEhwdlUzR1VOYlZRbkNwa2Q5L0xmajF3TW5wY1NJcUtDeTRk?=
 =?gb2312?B?TjVYcWJBWXIyaHArcmlWQXYwUjVPZGhnd1FtK3hwTWtsRGtQT3ViTEdNNjJ0?=
 =?gb2312?B?MC9LeHA5clkycTYvN1NkdlovWU1YakZNMzI0VVRVMWM3dk1hdEtwZWU2MEdt?=
 =?gb2312?B?Umh3bll5UGc3WlVSSnBMenpnaE4wWHl1NFVwMXdHbW5hdDRJaG9JbmkxeTha?=
 =?gb2312?B?SVJZUTVjQ3g5S2w5Z0wxS1oxYkF5a2R2dVlnbDNBeXorUVJJVFN2cC9mMjlK?=
 =?gb2312?B?UzNDTEJ5My8yRzl0VTVSYlptbkV0bEw2R1A4dzFsd2FITlM0bTUzRXI2WjdT?=
 =?gb2312?B?aU1EcmI4aXVkMzJYaXJvUThxa0VpSTRoMGtiQk5SQk1YQ1QzdGZseHZzRTJp?=
 =?gb2312?B?and3ajZPdFkrak5FMFRBUk5hY1V1RzRtM0hTOFBrd2RLRCtYMGwxeGRKcFRW?=
 =?gb2312?B?UkNqUzd0Z0xpOEFpK0NOaE9sWmZFVjhmUEZIUUlvMU9mcU1IWnZuRUVSMnhi?=
 =?gb2312?B?RjgxSXlFWGlsbmZwSU4xRi8veGw5MURuTCthdHJYaU15bURCS2RkN0FtS3JI?=
 =?gb2312?B?Yk1uRzBLVGhRWGlFanFBeUJGQjRTNVRPWUlPSVFKRUF0cTAxN2lRSVNMaU5T?=
 =?gb2312?B?RFBSVlhqZU0yZzJ3TmpEeDRtSGxOeTg3M21EUWJMWW5iQ1FHaHFDc0hlcC93?=
 =?gb2312?B?RTFEWEY3anpZM3hpeVFjYmZaNzFiamYrNzQ0UFNBVWVCV2lqaDE2K0Z0dEho?=
 =?gb2312?B?MExoUkVUYnY3QjVOelNSZldmWEk4RHRjWitZTDI3ZWtsQTNkQmVPUDVtUVc1?=
 =?gb2312?B?UVZ4d2lEYmNtVWVGZU55WUM5WlkvclNWMlpETlZrY1lkTi9TUkEwQTJQNnBq?=
 =?gb2312?B?c3Y1UXQ2M1FxZW1sMjJQTmNRRXhwcTIyWVN2bTBDdEJ0eWRzWVhWNnVNd1pH?=
 =?gb2312?Q?JwfqzaVbiZDPdcFXEUSM3DSguKuOfoDk63YeE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?MW8yVk9DVkhCYzdITHZWaVRMMklxT2lDdDZlUU1DSnZiL3UvRFVuQVlSTzVD?=
 =?gb2312?B?eS9NTEhhSlE0YWlYK1h3QWFoeUZUZ0RESzBYMmV5UDIxSU94L1Z2aXQ2dFdl?=
 =?gb2312?B?dnpvQThheUl0MWw4L0ZMN3d3ZzhYRUZNZHlFVzBTQnZGMU4vVllFQWxwRGFy?=
 =?gb2312?B?VTNRZlFRczNXS0hCMFVsNXc0K1BvSDJ4RGFTSW9zT0d5ZThDTC9Hc0xJUjQy?=
 =?gb2312?B?ZU51ZUpZUGVSZUNOSjhJc0ZrYWNFcGlOL1ZlQStPaWR4TkVIa1hUSkl6ek5u?=
 =?gb2312?B?VG45ZXVQcVp6dGpHNDN0bFpJYUtOUFVOSTFvT0V1MGFuQnp4WW4rVW5BNU5B?=
 =?gb2312?B?ZkNIYTBnZlBtSW5YOWpDVkVkREs5MFJlQWFnYWNPTGtDL2x3Q1AxdW9uci8z?=
 =?gb2312?B?MU5hZ2lheDF1ZUxONFQzL0xia01WSzJZVGhEbHZRNFdxb1RqNitiWlRLUHh3?=
 =?gb2312?B?dHpUV1pPV0h3SlpLRlYxL0I2SUNrUzdOeE5MWE02NjhtdmNLTHN5K2JLRWtM?=
 =?gb2312?B?SHRsUnNkYytCV25aUzkybHVyUlA0dHE3ejF3MmJsNWFiMlZpTDFwWlRNd2ll?=
 =?gb2312?B?OTM1TVNONnloQlp1OGVMWUdKYU90U05oejRvK2ZpLzdoTEIvbjNyWGpmWFJw?=
 =?gb2312?B?S1duWDdZS0s3MHBvR3dPVEZ4QnNKd1B0bG4wN2UwMnR2eUNDSFhJTWk0OWN6?=
 =?gb2312?B?cktLallPbllLd3NGclJETkVxMHdkRXVpbjdpeUpIS2MreFhiajRwWHlDTGdK?=
 =?gb2312?B?cVpSeW1ocGNRMFJJci9rSWc2bi9VLzhCYXpyOTVrMklTOW9UbysyRUtUUUxT?=
 =?gb2312?B?WmtUSnpZY3NoTisrQ0ppTThJYUlpUTFWN3V5NU5RbmUwSmJ0ZkVNWi9sWGt3?=
 =?gb2312?B?RU9xNnRPcm5LZ0lWSjJrQkhoNlBrMzFNMnVyNnpOSGZUb0lBWGNoMmtoVTdw?=
 =?gb2312?B?ME1JZlQ3c3p4STFTYWhDUTlFVlNxUEw1VlBOZ0hrQk5YRXBkbE9HeS96R3Zs?=
 =?gb2312?B?Sno3YzE2ZDN2aXFjMU1LNjczb3Nmb25rOHFEeVR4NFdHMkxkYVBxbUlBZ28w?=
 =?gb2312?B?SUd2eW1IVkFMWTA4NHd5NUIybFk3TzdObjBWUTl5aXgwZW5FUjN2di9MTlcz?=
 =?gb2312?B?RDUvSnEvdWdCcUU0bFkrRDZVaDBPV3o4QndpejhvZVQ0SXQzMmxvaVkwcDlX?=
 =?gb2312?B?cjVuUC9keUFqVm5aV28yaE16WnRBTkpHRWU3ZWpIRUIrRjFPRnlPTDlHRzNh?=
 =?gb2312?B?ODVGMFZDczBLbFBMSFRvQmNHSFRWNDZMZFJaelpYVFVWcmxLWUh2eDVvWEZy?=
 =?gb2312?B?ZWROY0tUN05uOWtJMEVhelFGTDFkSStSREMxR1NjdGFqV1hVUzNKaUhzYjkr?=
 =?gb2312?B?OElCa2dEc0NVbnZqamZySExBek0xUzBTcXREUE55SVA5SEtqcExJa2kxRVdk?=
 =?gb2312?B?S2x4ZXh6QU05bUdHSmJCdnFXLytFcVNGYkFEdGlCYm8zMGZEbnRyN1liY0Nm?=
 =?gb2312?B?VFZrYUFKT25sQXpzWWRSUGZTYTc1ZWhZTXNuYjBrV0ZHNTFWWjdvTHNZeTlT?=
 =?gb2312?B?bXQ5NDBNUE9kcDg0VjZjRHk0a1lMTCt0MVVPeVNDRVdRd1U4ZHJLMVFJTCsy?=
 =?gb2312?B?d1hwZHRrVXZncEpUNTZYcW5hNXhuNTRCYWtSSUFPbXR1dm1CSU9SUDZ5dVZC?=
 =?gb2312?B?Njg2M1E0QjFDcDJYV2V2WGNUbzg1OWJtMWpZc2ZPelNUcG1nT2hUUjBjYld4?=
 =?gb2312?B?elJQNGpPaGZ4M0ROK3p3b25BOEt6ck9PblNsU056Rm5NekFvVmwxQXBLcVV0?=
 =?gb2312?B?WFA1MWFpVDZzY1BWODBOYVlIeTJ5cHZUOGNhVTlFQXdEWjZVTmRNTHlQdHVC?=
 =?gb2312?B?b01qYzFES3hqTHJicVVrZ2lhc090QUMwV0cwWkNVZ3hrRDdPam1KdzlISWpF?=
 =?gb2312?B?cnNUSHlKZU5xa2FTMHlxVmx6bnlZbi8yKzNoVlNVellvcloxWFhMMGNpNDhk?=
 =?gb2312?B?V3NFWk5UcWZhdFVyUnRtaXMzZG1JQXZnSjJaZFU5LzVldmNGVUN3R0t6eGFa?=
 =?gb2312?B?UW9Hb2VsOGlSek45dWdESzk4TjUzcmU2WWxKOTgxSWdJNDBoVk5UZmNPeXRs?=
 =?gb2312?Q?GZFX6w+phF+X5J77Z+0OLYVup?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99edc40-eb81-4b9f-a400-08dcfe06ad80
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 01:59:41.3784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9x4QqK7F5l8f9aCd6Zpl5phRRC7nSnCgHJS5dq/iVuZeDlRHIHq+tuWXf3ml1z0FP3k9puEEuYX5/1wzGCvVPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6775

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTE6jEx1MI2yNUgNzoyNw0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGt3aWxjenluc2tpQGtlcm5lbC5v
cmc7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IEZy
YW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgbWFuaUBrZXJuZWwub3JnOw0KPiBsaW51eC1wY2lA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgaW14
QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBQQ0k6IGR3YzogRml4
IHJlc3VtZSBmYWlsdXJlIGlmIG5vIEVQIGlzIGNvbm5lY3RlZCBhdA0KPiBzb21lIHBsYXRmb3Jt
cw0KPiANCj4gT24gTW9uLCBKdWwgMjIsIDIwMjQgYXQgMDI6MTU6MTNQTSArMDgwMCwgUmljaGFy
ZCBaaHUgd3JvdGU6DQo+ID4gVGhlIGR3X3BjaWVfc3VzcGVuZF9ub2lycSgpIGZ1bmN0aW9uIGN1
cnJlbnRseSByZXR1cm5zIHN1Y2Nlc3MNCj4gPiBkaXJlY3RseSBpZiBubyBlbmRwb2ludCAoRVAp
IGRldmljZSBpcyBjb25uZWN0ZWQuIEhvd2V2ZXIsIG9uIHNvbWUNCj4gPiBwbGF0Zm9ybXMsIHBv
d2VyIGxvc3Mgb2NjdXJzIGR1cmluZyBzdXNwZW5kLCBjYXVzaW5nIGR3X3Jlc3VtZSgpIHRvIGRv
DQo+IG5vdGhpbmcgaW4gdGhpcyBjYXNlLg0KPiA+IFRoaXMgcmVzdWx0cyBpbiBhIHN5c3RlbSBo
YWx0IGJlY2F1c2UgdGhlIERXQyBjb250cm9sbGVyIGlzIG5vdA0KPiA+IGluaXRpYWxpemVkIGFm
dGVyIHBvd2VyLW9uIGR1cmluZyByZXN1bWUuDQo+IA0KPiBkd19yZXN1bWUoKSBkb2Vzbid0IGV4
aXN0LiAgV2hhdCBmdW5jdGlvbiBkaWQgeW91IG1lYW4/DQpBY3R1YWxseSwgaXQgaXMgZHdfcGNp
ZV9yZXN1bWVfbm9pcnEoKQ0KPiANCj4gU3lzdGVtIGhhbHQ/ICBJbiBkd19wY2llX3Jlc3VtZV9u
b2lycSgpPyAgV2hhdCBjYXVzZXMgdGhlIGhhbHQ/ICBBDQo+IE5VTEwgcG9pbnRlciBkZXJlZmVy
ZW5jZT8gIEEgQ1BVIGhhbmcgYmVjYXVzZSBhIHJlYWQgb2Ygc29tZSBjb250cm9sbGVyDQo+IHJl
Z2lzdGVyIG5ldmVyIGNvbXBsZXRlcz8gIEZlZWxzIGEgbGl0dGxlIGhhbmQtd2F2eS4NCldoZW4g
bm8gZW5kcG9pbnQoRVApIGRldmljZSBpcyBjb25uZWN0ZWQuIFBvd2VyIGxvc3Mgb2NjdXJzIGR1
cmluZyBzdXNwZW5kLA0KIHRoZW4gdGhlIGNvbnRyb2xsZXJzIGlzbid0IGEgcmVhZHkgc3RhdCBh
bnltb3JlLiBTaW5jZSBkd19wY2llX3N1c3BlbmRfbm9pcnEoKQ0KIHJldHVybiBkaXJlY3RseSB3
aXRoIHN1Y2Nlc3MsIGR3X3BjaWVfcmVzdW1lX25vaXJxKCkgd291bGQgYXNzdW1lIHRoYXQgdGhl
DQogY29udHJvbGxlciBpcyBzdGlsbCByZWFkeSwgYW5kIHdvdWxkbid0IHJlLWluaXRpYWxpemVk
IHRoZSBjb250cm9sbGVyLg0KQXQgZW5kLCB0aGVyZSB3b3VsZCBiZSBhIGhhbHQgd2hlbiBkcml2
ZXIgYWNjZXNzZXMgY29udHJvbGxlcidzIHJlZ2lzdGVycy4NCg0KPiANCj4gQW5vdGhlciBjb21t
ZW50IGJlbG93Lg0KPiANCj4gPiBDaGFuZ2UgY2FsbCB0byBkZWluaXQoKSBpbiBzdXNwZW5kIGFu
ZCBpbml0KCkgYXQgcmVzdW1lIHJlZ2FyZGxlc3Mgb2YNCj4gPiB3aGV0aGVyIHRoZXJlIGFyZSBF
UCBkZXZpY2UgY29ubmVjdGlvbnMgb3Igbm90LiBJdCBpcyBub3QgaGFybWZ1bCB0bw0KPiA+IHBl
cmZvcm0gZGVpbml0KCkgYW5kIGluaXQoKSBhZ2FpbiBmb3IgdGhlIG5vIHBvd2VyLW9mZiBjYXNl
LCBhbmQgaXQNCj4gPiBrZWVwcyB0aGUgY29kZSBzaW1wbGUgYW5kIGNvbnNpc3RlbnQgaW4gbG9n
aWMuDQo+ID4NCj4gPiBGaXhlczogNDc3NGZhZjg1NGY1ICgiUENJOiBkd2M6IEltcGxlbWVudCBn
ZW5lcmljIHN1c3BlbmQvcmVzdW1lDQo+ID4gZnVuY3Rpb25hbGl0eSIpDQo+ID4gU2lnbmVkLW9m
Zi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5
OiBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jIHwgMzANCj4gPiArKysrKysrKystLS0t
LS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gaW5kZXggYTA4MjJkNTM3MWJjNS4uY2I4YzNjMmJj
Yzc5MCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRl
c2lnbndhcmUtaG9zdC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IEBAIC05MzMsMjMgKzkzMywyMyBAQCBpbnQgZHdfcGNp
ZV9zdXNwZW5kX25vaXJxKHN0cnVjdCBkd19wY2llICpwY2kpDQo+ID4gIAlpZiAoZHdfcGNpZV9y
ZWFkd19kYmkocGNpLCBvZmZzZXQgKyBQQ0lfRVhQX0xOS0NUTCkgJg0KPiBQQ0lfRVhQX0xOS0NU
TF9BU1BNX0wxKQ0KPiA+ICAJCXJldHVybiAwOw0KPiA+DQo+ID4gLQlpZiAoZHdfcGNpZV9nZXRf
bHRzc20ocGNpKSA8PSBEV19QQ0lFX0xUU1NNX0RFVEVDVF9BQ1QpDQo+ID4gLQkJcmV0dXJuIDA7
DQo+ID4gLQ0KPiA+IC0JaWYgKHBjaS0+cHAub3BzLT5wbWVfdHVybl9vZmYpDQo+ID4gLQkJcGNp
LT5wcC5vcHMtPnBtZV90dXJuX29mZigmcGNpLT5wcCk7DQo+ID4gLQllbHNlDQo+ID4gLQkJcmV0
ID0gZHdfcGNpZV9wbWVfdHVybl9vZmYocGNpKTsNCj4gPiArCWlmIChkd19wY2llX2dldF9sdHNz
bShwY2kpID4gRFdfUENJRV9MVFNTTV9ERVRFQ1RfQUNUKSB7DQo+ID4gKwkJLyogT25seSBzZW5k
IG91dCBQTUVfVFVSTl9PRkYgd2hlbiBQQ0lFIGxpbmsgaXMgdXAgKi8NCj4gPiArCQlpZiAocGNp
LT5wcC5vcHMtPnBtZV90dXJuX29mZikNCj4gPiArCQkJcGNpLT5wcC5vcHMtPnBtZV90dXJuX29m
ZigmcGNpLT5wcCk7DQo+ID4gKwkJZWxzZQ0KPiA+ICsJCQlyZXQgPSBkd19wY2llX3BtZV90dXJu
X29mZihwY2kpOw0KPiANCj4gVGhpcyBsb29rcyBwb3NzaWJseSByYWN5IHNpbmNlIHRoZSBsaW5r
IGNhbiBnbyBkb3duIGF0IGFueSBwb2ludC4NCj4gDQpXaGVuIGxpbmsgaXMgZG93biBhbmQgd2l0
aG91dCB0aGlzIGNvbW1pdCBjaGFuZ2VzLCBkd19wY2llX3N1c3BlbmRfbm9pcnEoKQ0KIHJldHVy
biBkaXJlY3RseSwgYW5kIHRoZSBQTUVfVFVSTl9PRkYgd291bGRuJ3QgYmUga2lja2VkIG9mZi4N
Cg0KSSBjaGFuZ2UgdGhlIGJlaGF2aW9yIHRvIGlzc3VlIHRoZSBQTUVfVFVSTl9PRkYgd2hlbiBs
aW5rIGlzIHVwIGhlcmUuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gPiAtCWlmIChy
ZXQpDQo+ID4gLQkJcmV0dXJuIHJldDsNCj4gPiArCQlpZiAocmV0KQ0KPiA+ICsJCQlyZXR1cm4g
cmV0Ow0KPiA+DQo+ID4gLQlyZXQgPSByZWFkX3BvbGxfdGltZW91dChkd19wY2llX2dldF9sdHNz
bSwgdmFsLCB2YWwgPT0NCj4gRFdfUENJRV9MVFNTTV9MMl9JRExFLA0KPiA+IC0JCQkJUENJRV9Q
TUVfVE9fTDJfVElNRU9VVF9VUy8xMCwNCj4gPiAtCQkJCVBDSUVfUE1FX1RPX0wyX1RJTUVPVVRf
VVMsIGZhbHNlLCBwY2kpOw0KPiA+IC0JaWYgKHJldCkgew0KPiA+IC0JCWRldl9lcnIocGNpLT5k
ZXYsICJUaW1lb3V0IHdhaXRpbmcgZm9yIEwyIGVudHJ5ISBMVFNTTTogMHgleFxuIiwNCj4gdmFs
KTsNCj4gPiAtCQlyZXR1cm4gcmV0Ow0KPiA+ICsJCXJldCA9IHJlYWRfcG9sbF90aW1lb3V0KGR3
X3BjaWVfZ2V0X2x0c3NtLCB2YWwsIHZhbCA9PQ0KPiBEV19QQ0lFX0xUU1NNX0wyX0lETEUsDQo+
ID4gKwkJCQkJUENJRV9QTUVfVE9fTDJfVElNRU9VVF9VUy8xMCwNCj4gPiArCQkJCQlQQ0lFX1BN
RV9UT19MMl9USU1FT1VUX1VTLCBmYWxzZSwgcGNpKTsNCj4gPiArCQlpZiAocmV0KSB7DQo+ID4g
KwkJCWRldl9lcnIocGNpLT5kZXYsICJUaW1lb3V0IHdhaXRpbmcgZm9yIEwyIGVudHJ5ISBMVFNT
TToNCj4gMHgleFxuIiwgdmFsKTsNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArCQl9DQo+ID4g
IAl9DQo+ID4NCj4gPiAgCWlmIChwY2ktPnBwLm9wcy0+ZGVpbml0KQ0KPiA+IC0tDQo+ID4gMi4z
Ny4xDQo+ID4NCg==

