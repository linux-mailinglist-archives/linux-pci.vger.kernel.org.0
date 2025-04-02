Return-Path: <linux-pci+bounces-25123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C35AA788F0
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 09:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F9E3B021F
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 07:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C709823371C;
	Wed,  2 Apr 2025 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AQElNbrc"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013058.outbound.protection.outlook.com [52.101.67.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C949B23237F;
	Wed,  2 Apr 2025 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743579635; cv=fail; b=jZKN6NHCKA0iFf0xczgBZa0kLV8vc4eyJ904DIUcXYCIxKArqvjXmnEh6c8zAqRgk4jsbcPTbExCcHXXMWTL/MnA5zycIO3okBl7wPH84oayHBE+PGtxrVWf0b3M2kwOEOk12ZRpV0SjIY+vlogT6t66ORHNrbNRbA3NITvjS6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743579635; c=relaxed/simple;
	bh=BK1WaomxM6AqQJG/RmjXuJZGz9aqOOubLjosQtkQA6o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YgEQQDKLu6Z1n34EcXemeAIWyZw2ieKUnVLR6L7WfvTa6MJ48aj4+fJ/TansnkuLObJHkXDvCdh1E6lyMbfwHD3U/f2aAxkGnLpqxLedPvs+dYUtXNsxBQCeeyi+GHdkDYUtF5X4o0PUOvznEIzfTjkmznVe4h5qnjBWS3OpP1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AQElNbrc; arc=fail smtp.client-ip=52.101.67.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpIZzgF6xOwS5umFaGtFGM1z9XyLxHmKMRGDM1CzcCsPzzSwWUR0jNRaxW9XKyuZKyh2EKijlybiy3GyBA5T0Ti54bDI3S6Xh079vaLmbnANwo/mJOIKejImrjYxr361wHUrOixUC/m9zc15qFssth7jF5PizVjrBEAmikgXiflIuOTlSG5TnFSH6ePv8l3B/nGD1Sw+5s48hC7VUVJKGpQlY0+6UiaHmwYJ72Fa8dB+Msv4Rn2KCswq6bJrzfQkNJ6+HohVT825w8z6Dr3dATnndUZThNkEJi0yGRRv+IdWLGeLGj89HbqfIe/ahCyqMy8QUJNRCWcKE9RWdhiMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BK1WaomxM6AqQJG/RmjXuJZGz9aqOOubLjosQtkQA6o=;
 b=yDcJd0cav5MeAIvY9gos4AoBGKdZV0XN4GxiaG+VYY5ushjbSkztczzA2gebLk7dlB5zgyP+m139/cYOXgtajGnLDwnTe9UD+C5K0b/Gv62OV+Ib8Wkth98wHWpMl0nh7IbbFPNETNjWi93H+kTHyjJe2MaPvOXRqsB9qijaWIlNXHeeCnafcWCTU9px4X2Z5tllhdhrLy9RSQRLehqTSiwj9D6MgOQCj2/2GYhwILzv9kXfXk0DLA3+fC1uJGbvAVUY4b2WurRsbP+ODqAtFxp7JOX6aHkxR8t0VIqW6oi2ATH7DmZwd5QkwKyeuwd7CF38ZxEELO7BDOpap7zsaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BK1WaomxM6AqQJG/RmjXuJZGz9aqOOubLjosQtkQA6o=;
 b=AQElNbrcMm31IWr0Dd2ieCy1v4rdUlPHZNn/pTmt1fUUA2PXFFSrUE8esAVeXUnorJQuv03GelcNzvnqyXN19sF9BNqqIRsl4wUxeeXWUA4w+AJ7BkIQXW3nxLz7liymrXPbln9/jaxF6WtwS3mKTtVCTv/sIuTnCQb9hHxm1N7dbgzwFSbi8iOlGABKjT/XURvaiw+rg9wdZox1LFc4xsfrrB0qXlWimlOldO6oxCTw8ZFET2K3QsORqtOKTh+igPU2eh5jUksGUMaK35UgXz43smtgNM9oRjZnxqC/Rm7s0VEX3uKcaGR38tWPFJiXBeyqcAFqwJu1McSbQBtZzQ==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GV1PR04MB10775.eurprd04.prod.outlook.com (2603:10a6:150:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 07:40:31 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 07:40:30 +0000
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
Subject: RE: [PATCH v3 5/6] PCI: imx6: Add PLL clock lock check for i.MX95
 PCIe
Thread-Topic: [PATCH v3 5/6] PCI: imx6: Add PLL clock lock check for i.MX95
 PCIe
Thread-Index: AQHbn44J+Wg0L7/NmU6w3Z7f3QoXIrOP/X2AgAAAy3A=
Date: Wed, 2 Apr 2025 07:40:30 +0000
Message-ID:
 <AS8PR04MB8676079CE89A325C2B98A8E98CAF2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
 <20250328030213.1650990-6-hongxing.zhu@nxp.com>
 <y3ys5ojt3cryklqibg4shznkjqije7bturs5ljkjyzbri5dhgu@jeo2mmyv7sci>
In-Reply-To: <y3ys5ojt3cryklqibg4shznkjqije7bturs5ljkjyzbri5dhgu@jeo2mmyv7sci>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|GV1PR04MB10775:EE_
x-ms-office365-filtering-correlation-id: 469c71c8-3de1-4d73-f3e1-08dd71b9a517
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkNmS3dlVGg0NlZac1B3VzIwamRQa1hwK05QdnYycmQ3U3RiUFF3dkpkSHdE?=
 =?utf-8?B?aUNVczBIWENwcnFkNW1JVThTV29nZlVMYWJCNEpaSExiZllpK0FNOGdLRWJs?=
 =?utf-8?B?aVhCYnlEenlsV04yOFczZ1RzMmE2d1dSRTZ2SVZPY2psUlRiK01VMDR3K1I0?=
 =?utf-8?B?K2Q2MDVTc1pCZXBFSnZKTjBzN09NUEhzMHhNRDdjNTUybDZ4bkhETjdsczFa?=
 =?utf-8?B?SnlmaHlkQUgvVkZHdm1BOWtaVGl2VEJ2M09XQmh2eEpIUVF5V1NPVEp2NXpQ?=
 =?utf-8?B?ZW9ocDBURStHRGd0OXFrYWVGZkRFaTVmZEM0cko3Q3BVNGM1bGpqNXcyaHRz?=
 =?utf-8?B?ckZlOUVTUnBtQjdTTVVuN2VHUXFaS3BGYUtPWSthTXp1WDlNS0FyR1JWVjJC?=
 =?utf-8?B?ZFNJSmIxTlFyVkU3R1gvQWNXeXN5Q3R2L2dORDhrTy9zUHNGZVBRVUZ4RGQ0?=
 =?utf-8?B?K2FuSTNublVuMU9RKzB6NHl2WUNBV3Zka0lMdFFXam1BTFNjMUUwYWgyYUVJ?=
 =?utf-8?B?TU5OUmpOUFZIaGh1Q1RmUWtYRFI4ZjQzTDBIQ1d2QnhQZkdkcDI3K3VERk55?=
 =?utf-8?B?Y3pRUnRXeE9Vd29COHI3UUpWT0hXQ1ZPUjB0Y2Fwd1BjM1g5UGtXYkRDMkhr?=
 =?utf-8?B?bnBxTm8zVG1jdmIrb3JsRlJmY3Z4NUNRRVlGUi9aNnAybmZJU0QzRllHN2Z0?=
 =?utf-8?B?UVRxS25oSFdSOG9iWERQeWRkV1ZtRWk1RWFWaWlxN25OVVprMm9BUytmT0xs?=
 =?utf-8?B?MkVlU0MzenYxMEN2cXhkT1BlN29nbmxpcFEvVlpMcEVLYjgxWTFaeXNacStt?=
 =?utf-8?B?Skt1dSt0aW1xYVNwVnlZLzF4TlVEb0xKWVFIeEx3STlubHpEendiamY4WXQ1?=
 =?utf-8?B?ZWpld2o0bzdsd2RtMFJkaXQwZlRvVWRHSGdqVnVOTkNBRXFSYllILzdtMU5U?=
 =?utf-8?B?SytrNUdzeC9QU2lUYnZSME0rTzl2NUJqanZHT2JpaG5ham1PcmZiTzJSWUI4?=
 =?utf-8?B?RXVCcGh0d0RiWFp2SWlpQWxjSXZrOEQ5clMyWVB1V2UxWG9lekpiSXo5RkVE?=
 =?utf-8?B?QUhBaXlON2xZV2JGTVRIdG45YVlDTWVHQm1ZODNWeFhRSGlIaFUwZUFjVWJE?=
 =?utf-8?B?aDdCWkE2cWgzZG1OcHVsRStnVVpkUGhUSjFzSjhqbk5Gam1tQkg1S3hHMlc2?=
 =?utf-8?B?Y2doWG5rcmQrYU1EMGtGWE1PYTRaS3ZoVndQSFZhUG82eFFicFpES0ZYczVL?=
 =?utf-8?B?VUJFVWZoZ3pvalRQbGFlWnJ5RXUwUU9DUytwcEQ0MjRqVi9PdFJramRucnB4?=
 =?utf-8?B?bStGSjVVd1k3MVhoN1JBRjdJVitocFgyenhvbExiM1NOa1E3UWhuUHVTU3kw?=
 =?utf-8?B?ZHh0aGVoT0dhUFpVdUdFTXNJMFZaMFFrb2hGMlVtRlhIbXhibjlteU5xN3pO?=
 =?utf-8?B?amJwbVA1cUlqY3UzVzFuQWowM29kV2FQcFd0Zm1NVEw1dmtST0lRTkF1NHV2?=
 =?utf-8?B?YVBmNWxUS0FORktXTDlGeTR5Mmt0UG1remt3Z2Q3VFdhVjgxKzNGU05TdTFY?=
 =?utf-8?B?UVZHQXNqWkhEVTV6ZmxQUmZOYWlKOXJxMGtvbHkxNXJSVGFML1lDUzhRSm1v?=
 =?utf-8?B?cHNQUnMyWWc0MzkvZXU2NjFvK0N3SitxdzZveDR0RE9CcUtaSDNRZlV6N1dU?=
 =?utf-8?B?aUwyWkt0RHhHakd4K25hK0EydExsb0VCNG1RUHpadWZEZ1dOcGFMN0dFSk42?=
 =?utf-8?B?aWVIV0c3RXdLMVl3dTZabytOTGdQYXdNTVUxSTI5UTRtUmtqUHpHYVNIRE9i?=
 =?utf-8?B?WnZBTTk1akVibEFBaW5kbGRDcTQydFZKUUxtVWo5N2F6NXJJU2VKZ21wcnpw?=
 =?utf-8?B?bThPYVc5OS9FQXhXakZ5aG9DVkZ6NHVFMGRKOTVQakVmMisra2FCRDgza2FU?=
 =?utf-8?B?dGliVE1pZkpTMHVjLzJmQURBVEZjaEhJdlgwTVg1clV0cm5XRmo2KzRiSkM0?=
 =?utf-8?B?bG9ESHVZbHlnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y0tzdEpibWxHdDRzVWJtSnJuS0tXYkExRkFNNWNLYmF3SkVMQ3pSSGV4NXdp?=
 =?utf-8?B?NjhXbk1zMXFQdDdiRUgxZTVEOEtQcENqTWVWVHVqbDJrWkg0VlQ2V2YxSmRZ?=
 =?utf-8?B?YnprNHZEVWprQmh0Q25kOStRVDFUL085cnBlTEx4REJHU205RTBub1IyNWxF?=
 =?utf-8?B?czFCQ2dIZTlEM0JSOVRMUCtNdHBqZXcvTmgxS09tdXhua1EzMTF0b2c5TDNG?=
 =?utf-8?B?UG95ZGtxS3BaQnFRQzR2UzI0RzJqNWxPUERSUDlaaEpDMzRaRHcvQzlUVVZv?=
 =?utf-8?B?bEZPSGdZOThxSVdkZ1BTOHQ0NnpIZ25YOTRvWTc3eENoMjY2ODZUdTV1dFJk?=
 =?utf-8?B?RDhlVnJRaFRHSnlIQUZsU2psdTJtam1qN1VsMnNUOUN4d2NXOVQrZGhIZ3NI?=
 =?utf-8?B?RmFPdmtuOUNTM0RlNlliTE1IRFpJQVhBNWNMR1F3djl4eGtUZnJuTEp5MlE0?=
 =?utf-8?B?RUxkTFJ6d2kvOC8wR2hVNW1PSjU0aWg0TERiUWJaV0RQdkxLTUhvRWhIMTVt?=
 =?utf-8?B?MWhWMGpJelNZajdUZzRKVVVsemRkVzJhNlgva29qSmxHa1MwcUlwb29RWFZq?=
 =?utf-8?B?NkRtNk9OUUptUHVRUTJTZVBiZkZDa3Z4T01BQ2RLWWVUOGR1NGRER3cwRUN3?=
 =?utf-8?B?a2xBV2xqcVpwNWFubGhuaENSa3ZCdXNQU01VTlNqL2o3U2lzR1NxV0htZDF3?=
 =?utf-8?B?WFQwV1RpOHZoU3VydmxEMGl1dG9oS21IYkUyY08vdUk1UXhPcWhSZlZEajNI?=
 =?utf-8?B?ZWJPTmk1b2dFVTdaWVNHVG5QNEdGWkxHOG1ONUpZRlhrVmNxM3VBMjRYSzZT?=
 =?utf-8?B?Ym5BR2NVR3lEa2RnMWs4VC9FTndxbkQ5WWdQd3RJSlFjem45Q3hWRW9TSXNK?=
 =?utf-8?B?QUxrS3dIczJYSklMK0RubjB1UzdDbDM2UmNVaFJjUk9jZnpiZElOY0ZHQUlT?=
 =?utf-8?B?bE9TMm1rYXZ6bzJ2VUU4WHc4eXY3TWpYK0Q4NVczdUwwaGdPMG9JbGN0VWRD?=
 =?utf-8?B?QTdRUTRiRm4rbHl1KzRub3h6Mk1OazlWMCtjT2tIemUwNWhTT1c2emlHbUt0?=
 =?utf-8?B?K2hqb2xMT3VaK3QwaWhzeTVvNmRYblhhSmFaMzNLbm1Cc2xkVW1zZU5pdG5J?=
 =?utf-8?B?UkdsbDlwejlmbUpPWXNVd2czdE1XQmo2UWxyQWNTK0JBQ0RwTWQwS2NFbFUy?=
 =?utf-8?B?RVEvQVo0UERJN1VQVFhpVktKMSsrLy8zNGtZdklaQndmRzhzMERNVGVKck1K?=
 =?utf-8?B?SlBQUnZpSTVWeit6RmEwOW1NT3ZSNHNva2RoWTQyWUNKYnlPZGczcGdSck9E?=
 =?utf-8?B?SGhFVjd3WEpaYzlybyttWVZtSTQzSEluQ2xxcHltZnZCaUQvaTFmd2tpY3hh?=
 =?utf-8?B?UHByTDFMU2FPZjArZ3Y5M2tQUmlucjNxdjMyTWFGWC8zSzc2dUhsOUVqOUJ1?=
 =?utf-8?B?cjd2RnhLc3RUTFNyaUkwTzFvdGZ0dzdCRnVwdmdERXkweU1ZRFRuQWhNalRk?=
 =?utf-8?B?dERkekY5a21OV09zYlRFOHB3Si85NEEvVm5yM0xUMG5XblN3Vm1UdVhkNUk2?=
 =?utf-8?B?OFBJWTFzOU9QVUZLQ3dod1BqVDlPOWRxOFVLTHR6TE5JVVNaTTlLWmg1eGQ0?=
 =?utf-8?B?YWlHRm1QQ3lPY00vZW5kNU1HallMTDNJNmgrWTFPR1JRYXlUNUJoMjY1b2F6?=
 =?utf-8?B?ZE9oR0dRMm9pMW5PZ0lTNmdhMFFSd0ZPOWwvR09EQnJtTGtDbUttelF3NlUw?=
 =?utf-8?B?UldWdGc4b0FhekhyZThidWZFMGRXNDBCZGpLeWFHcm9Cb1BPZFhpUTIzN0tt?=
 =?utf-8?B?RVRrQUlyT3NlaXN2SHlUT1NzYlpXZDNPenB5SWZLcFNCbWFxU2FMVWNUd1Js?=
 =?utf-8?B?VVlHUkRHNjRpY0pkTWJtVkhtMTUvdSszZk9YWHJrazFsTGxIMW8yVHM1RTNr?=
 =?utf-8?B?eUMvK1J3T2k2SjFaMjZCL2xpREx1eVJRMWRQSm5LU2FpMS8yMGpUOVJoL2F6?=
 =?utf-8?B?UkdweVh2dmJuTTlObzE5eHdBQWtkMW1RVjBjSUg3aE05OEZ3TXN4KzRkbnZX?=
 =?utf-8?B?bGx2OEhXdGNGaXVuUE5ueWFLcWRMWGxMSFJYdzB5ZHNVbGxJZkNySkRZQXV4?=
 =?utf-8?Q?lWZokqLQ0hyFsdZRW6JJ25u2L?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 469c71c8-3de1-4d73-f3e1-08dd71b9a517
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 07:40:30.8567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMj1YFym2yAlff/tZXMo8OdSFUkdbiZ4jF823P98N5/uWgFpKukHFE1aXrnd/R//fHTsFfpAijqtjxEn04B3Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10775

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hbml2YW5uYW4gU2FkaGFz
aXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjXlubQ0
5pyIMuaXpSAxNToxMA0KPiBUbzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4N
Cj4gQ2M6IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5k
ZTsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOw0KPiBrd0BsaW51eC5jb207IHJvYmhAa2VybmVsLm9y
ZzsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBw
ZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5j
b207IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4gbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDUvNl0gUENJOiBpbXg2OiBBZGQg
UExMIGNsb2NrIGxvY2sgY2hlY2sgZm9yIGkuTVg5NSBQQ0llDQo+IA0KPiBPbiBGcmksIE1hciAy
OCwgMjAyNSBhdCAxMTowMjoxMkFNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBBZGQg
UExMIGNsb2NrIGxvY2sgY2hlY2sgZm9yIGkuTVg5NSBQQ0llLg0KPiA+DQo+IA0KPiBXaGF0IGFy
ZSB0aGUgaW1wbGljYXRpb25zIG9mIG5vdCB3YWl0aW5nIGZvciBQTEwgbG9jaz8gSSBndWVzcyBj
bG9jayBpbnN0YWJpbGl0eS4NCj4NClllcywgaXQgaXMuIA0KPiA+IFNpZ25lZC1vZmYtYnk6IFJp
Y2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogRnJhbmsg
TGkgPEZyYW5rLkxpQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaS1pbXg2LmMgfCAyOA0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKystLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5j
DQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXgg
MzUxOTRiNTQzNTUxLi40MGVlYjAyZmZiNWQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAtNDUsNiArNDUsOSBAQA0KPiA+ICAjZGVmaW5lIElN
WDk1X1BDSUVfUEhZX0dFTl9DVFJMCQkJMHgwDQo+ID4gICNkZWZpbmUgSU1YOTVfUENJRV9SRUZf
VVNFX1BBRAkJCUJJVCgxNykNCj4gPg0KPiA+ICsjZGVmaW5lIElNWDk1X1BDSUVfUEhZX01QTExB
X0NUUkwJCTB4MTANCj4gPiArI2RlZmluZSBJTVg5NV9QQ0lFX1BIWV9NUExMX1NUQVRFCQlCSVQo
MzApDQo+ID4gKw0KPiA+ICAjZGVmaW5lIElNWDk1X1BDSUVfU1NfUldfUkVHXzAJCQkweGYwDQo+
ID4gICNkZWZpbmUgSU1YOTVfUENJRV9SRUZfQ0xLRU4JCQlCSVQoMjMpDQo+ID4gICNkZWZpbmUg
SU1YOTVfUENJRV9QSFlfQ1JfUEFSQV9TRUwJCUJJVCg5KQ0KPiA+IEBAIC00NzksNiArNDgyLDIz
IEBAIHN0YXRpYyB2b2lkIGlteDdkX3BjaWVfd2FpdF9mb3JfcGh5X3BsbF9sb2NrKHN0cnVjdA0K
PiBpbXhfcGNpZSAqaW14X3BjaWUpDQo+ID4gIAkJZGV2X2VycihkZXYsICJQQ0llIFBMTCBsb2Nr
IHRpbWVvdXRcbiIpOyAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgaW14OTVfcGNpZV93YWl0X2Zv
cl9waHlfcGxsX2xvY2soc3RydWN0IGlteF9wY2llDQo+ID4gKyppbXhfcGNpZSkgew0KPiA+ICsJ
dTMyIHZhbDsNCj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9IGlteF9wY2llLT5wY2ktPmRldjsN
Cj4gPiArDQo+ID4gKwlpZiAocmVnbWFwX3JlYWRfcG9sbF90aW1lb3V0KGlteF9wY2llLT5pb211
eGNfZ3ByLA0KPiA+ICsJCQkJICAgICBJTVg5NV9QQ0lFX1BIWV9NUExMQV9DVFJMLCB2YWwsDQo+
ID4gKwkJCQkgICAgIHZhbCAmIElNWDk1X1BDSUVfUEhZX01QTExfU1RBVEUsDQo+ID4gKwkJCQkg
ICAgIFBIWV9QTExfTE9DS19XQUlUX1VTTEVFUF9NQVgsDQo+ID4gKwkJCQkgICAgIFBIWV9QTExf
TE9DS19XQUlUX1RJTUVPVVQpKSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJQQ0llIFBMTCBsb2Nr
IHRpbWVvdXRcbiIpOw0KPiA+ICsJCXJldHVybiAtRU5PREVWOw0KPiANCj4gLUVUSU1FRE9VVA0K
T2theQ0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiAtIE1hbmkNCj4gDQo+IC0t
DQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40N
Cg==

