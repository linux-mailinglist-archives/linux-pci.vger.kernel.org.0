Return-Path: <linux-pci+bounces-34434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08ECB2EE36
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 08:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3465A016F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 06:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE3D26E70B;
	Thu, 21 Aug 2025 06:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JU70MmGK"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011036.outbound.protection.outlook.com [52.101.70.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D85154764;
	Thu, 21 Aug 2025 06:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755757715; cv=fail; b=FasjTGOHEPg3EHFYyrmTRkdfb2ZRIr+ddwBQy51r21cs2ckOUTdM98iW9EAob7AYV47OjGo3lE5iye4nybEA7RelVryimoDl7FrrkQFXaBqczR+2tzlSVUD2pyAR6v8phzgD8mVbYoMcUp8dIzWo3YWvgNGyaEsdUMblkQUcQUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755757715; c=relaxed/simple;
	bh=AZC74XqQk+EfTeYGWltctCS5wWlWKxIk6TPZXZLg1l8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IAj5245vaqIj3onrBitYetfyi1zC0VYgeDHMu+9tvqw5VOuUVymBGZHzJRQDdtLGTpcIWG0NPUtRENrJdFMwnCwI3Lht3nIP7V0C4XM7dYXOKt91ABfA3ucXnu0DoJv+qSNHAUfohUKQwT0qmqNyanruz7B5L2IBuRLsGu52Og0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JU70MmGK; arc=fail smtp.client-ip=52.101.70.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyiUrEopiHeDsaWNc8+E9BvcozqIYlt7LURNYzT03W2Z3z/pZyRhCd/d+e7jVUxkhS21BkSHv9+XkLcIaZr/DXN2hxaX9zai0ZvN7yjQ+1L3b7ftaMoglJiZdgchaoMAjYdcjx+JeNEKGzYocgYdU/LttkMCDcroB+au430klzJbTO4+2QKQeVUUUGtwkkDiFWi7KbSk6sOGYnC7+d3qpEro0Ji2gaeRyp8Cn1BghjJPweizWHf2DTqrbnlx/YzzGIylLeRy+fSg0X2MiyQE79RxRM//e15aHTlO+LySB3+0bbJRC48GI9G4D8AtysAbu52APLIWxwucI5EUQW9+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZC74XqQk+EfTeYGWltctCS5wWlWKxIk6TPZXZLg1l8=;
 b=tukaASJc1hIuYkl5Dzee6Xy2Y2OYt1SQIlJiRTYKMQqgLSiqHwGW/WHAJ+jn2uKXWm2zqbkChk8ULmTFsNoJ97Qxm+/hvXy4UPmCEu2Hjhpzz83PYYekQJCD4cGmCs3g5bio9nqYywogqocfU11Y7Kyz5qX5QR1QwURjwg53QLpM4+9CK94VWAdHO2kMKbg3Fi6w0aIy1Sv8pRsMVgbaQYTMzUF1vWeCTzIVNB6svLOx3YOrfSDVCNJ1SMhU4dpSortTH9RuB+s1LQArkChK/le2SiyR2rNiv9xVZhGylvMkUTBv6VODaFSLM3rrT+5FSH79i97zvuEgSaVJv7PcSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZC74XqQk+EfTeYGWltctCS5wWlWKxIk6TPZXZLg1l8=;
 b=JU70MmGKvGtufOFsYQCuRa6mQrENSiMcmLLpPJEhtASkxAahlHxzKwhHPakWg1TGARCBEQJIxt0t1KAHpznNVFqy6zDtukvuhrLk8PwEpWNcI0bhS4JcIUPYXD2ShgVYn+ybxskHjECRiROUhugOr3vfnnB4AbyZyiCtiS2+A9VuQQToUuIgBGrKNBM1ZlCDAEPPcwzRqd0jU3wUZICcQUM6rx/mKkfeJcUh3hp2GvLI2Wo2qpS/IK9qrWYTLCUI719+gseNM3BENyYorto4P+eJFSUDGdIDcLM4W+BQmHVpBe/FH+xHfHGciRrAoLHhBoO6iHK5QZEd7RznrDBMOg==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PAXPR04MB8077.eurprd04.prod.outlook.com (2603:10a6:102:1c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 06:28:30 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 06:28:30 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Frank Li <frank.li@nxp.com>
CC: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] PCI: imx6: Add a method to handle CLKREQ# override
 active low
Thread-Topic: [PATCH v1 2/2] PCI: imx6: Add a method to handle CLKREQ#
 override active low
Thread-Index: AQHcEaoMjRru1StCnESzEOZ/k0fwQrRsAKMAgAAHgQCAAAqVAIAAiLUQ
Date: Thu, 21 Aug 2025 06:28:30 +0000
Message-ID:
 <AS8PR04MB88333851444D5A10A4A8F6668C32A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <aKY35MOg7reH1Fhh@lizhi-Precision-Tower-5810>
 <20250820214020.GA641554@bhelgaas>
In-Reply-To: <20250820214020.GA641554@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|PAXPR04MB8077:EE_
x-ms-office365-filtering-correlation-id: 068120e9-5afd-4fef-3238-08dde07bf237
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|19092799006|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?QlJ4djZnbC9LS3B5WWgycUg0dHlCSWVpZTcrQ1oxU0p3WUJ0T1ZKelRubFRE?=
 =?gb2312?B?SlltZDdZVEVmbUgxY01GbkU5V3BtTUlIQm9GbGs3c0NZVHNBbUV0REN1MU9k?=
 =?gb2312?B?RURaRmtCQis3Q1Z4S1JKeTJyRnYvNnZjNEh5MzVYTFhOcEorR3RXTXVaR3o0?=
 =?gb2312?B?dzBuamN3UnB1b2N1bXhWZVlDMGtkN1o0RFM2QlVqY2paZ3ovNlNvYVJRQTRw?=
 =?gb2312?B?Z0JnYVB3bXZjdVliaXNuNmZ0clJBN20zd21aUW9xSEk4UEpLSWVLWE0xdjFr?=
 =?gb2312?B?Y29UVkxsWlpTMEVFSUE4TkNqbitQQnZlcHVlc0I4eGxJYjB4MnV5RVJQK0Nn?=
 =?gb2312?B?UGxmanA0VElWamMyY3I0MExCZjlZUlMzZHA5ajc4NkVTamtvNy9UeW9abUJY?=
 =?gb2312?B?eXdwQllmY1ZTeXZxYTZKa1VPSnV3dmd1Rk12NU1UbmMxUjNOQldvdTVrb3ZW?=
 =?gb2312?B?UFJ6VnBTak5GMDJvZXBOYWsrbzRyYkRrS29JYXViN3ZaYzNMMGpsRWxPdTRH?=
 =?gb2312?B?QmR4MG5wTnBhRjVLQjd0VGVJVjV2N2w4eXRRR05HUHdnRXh1RHJFV0VSbVZF?=
 =?gb2312?B?eDlJazcwOWVlS3EvSnludDdYMU5WMW5JSXhISHhyUHlSTWZKQ0p5UDdXdlYz?=
 =?gb2312?B?ZkRWc1cxQ0k4L0JXcVdRRm1URGRvaERhNnZ4dnBRaVJXZTFlc3lxSUNzVGlS?=
 =?gb2312?B?MEx1bnFpZG5wQ0oxOFdtWVpoM1NFTXRISHE4SUsxS1V0WEtkKzBscC85T1Z6?=
 =?gb2312?B?SUFxUksyQ01xWE5QdHF5MzYyd1dnVFVXTjQ2cG02aWYzVVM2a1lZZGVwVkRX?=
 =?gb2312?B?Z2UwejcyY3czVm9FaHVMaE1jN0NyNGhZM05lWUhJYlJvelVmYXJuVUtQVHdV?=
 =?gb2312?B?RlRGYmJQcytRL1pPVG0yV3Fvak83U0VOZ0grZEkzWUZac0h1ZGpVZGlvYWJQ?=
 =?gb2312?B?N3R0akQ0MTVVRjJOU2wvdjNPRk9ZeXFNWnZNM1g3UzduaGZtUnJCOStRZVlk?=
 =?gb2312?B?Q21EQTgwdHB4VlZhb2ZRdXhJTkNrSGFlbXFPOXNPdFQ1U0xzNjFnWXdOVHJi?=
 =?gb2312?B?K0ZRR1RsYitaalYwb1IyRlJIM2dHREtGcjFOYTNpc1U3K2ZxK1JzRy9SM3o4?=
 =?gb2312?B?QlZVaGxqRnRXR0IyNEpBVnUwZ3Y5VU1OTlpVUnZEeS91NGZkalFid1gySFg2?=
 =?gb2312?B?ZWFDby9ua2xWamU5NlRUS3hJbDFxdXl2SjVheWRMVklLK21Nbzd1WjVTSFdS?=
 =?gb2312?B?V2pEUCtvQ1dSSnlsbEpwZW1pTmhNTVA2OVRtS1RLbG80bUZRM1kycytZM0M3?=
 =?gb2312?B?Q2I5VlcxakJyeDNVN1B4MVZrUHYxbHU2Z0JWZnZqUzR0SlFQTGRtMUZ2MFBW?=
 =?gb2312?B?VDRDY1lHWU5peHVaRzVyU1ZCaDcyMDRKSVhZL1J1eGpneHlqWlRlMlBFT1Fh?=
 =?gb2312?B?aVhEUHR6L0NiVk4rTGMvWDhpT3BCM3NUcElOWWNpcW10MGxVTEUwd2dONmQ2?=
 =?gb2312?B?UjhkK2FIL25zbjF6eGtBeHR4RzlvNzRva1hxS0NUZXd2ZVNYUWw0dDlXVEg4?=
 =?gb2312?B?ckEzR2EvTlB5b0k4TGFRcVZwMUlKbEJaQllXWjZ6eEpNcXUzUitlbE9ldm5v?=
 =?gb2312?B?aTNRMnJGVFZLL0ZEeXNLNXhjaWpveURMRm9aQ2xWWGltdGM5RXVnTGdZYlVl?=
 =?gb2312?B?RWNZYTlqNW5BdlBzeHUrUWJaZWtMcFkvOFlHSFdoNXU0TDlPZFYzTURoRU5t?=
 =?gb2312?B?SVdDR0dPdWVzNDdXUnJDc2kzVFA4eXROenRubmpReEQ2K1UxS1EvaWhwTkMw?=
 =?gb2312?B?c1BZS01hN0pqTlpzRVYwdWdWRGtBRUkzL2pTbFZzeVQrMVU0L3cxRVM1c2VY?=
 =?gb2312?B?NC9KZFRGUHNLdTlaUThrcXpFNXhBbFpBNGZPKzI4SjhJT0c2RStMK0o5M1pW?=
 =?gb2312?B?Vis5SHpuL2hUOVlUSUN5TUZGV0VLSFdpbUhGVmVWUHMyRzlZNy9xQ2t4Vmk0?=
 =?gb2312?B?K0tySVRYWlZRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Nitha2dmbWM1MFYzS3VOY09WaXpUcVExaldxbDlkd1pSaHhSR3p2NitMQnAy?=
 =?gb2312?B?aXR3bk54OUVLeXYxemErNC9yUnNlVVNwSURCVUV1QjR4VGQ3dGxSV3ZtK2da?=
 =?gb2312?B?TEdHMjhQS05lVjR6T2NQTnNtaTBLZjBoTkJiNEdtMUphU1VCWDVSOUVzMU9v?=
 =?gb2312?B?TzVyQSsveitWc0pOanJVNHVTbUtINmdyNnIzZThJVThIbFVGWU5CN2doNlBa?=
 =?gb2312?B?T1U5enUwN2FGSm0yNkpzaHZRb1BISVQvSmRJcFI0Y2lMRzI5RlpEZFVKcjN6?=
 =?gb2312?B?NjdYSUxGWlQzM0VQZ0ROUnhlVnBGV0Nxd0d3UmZPRDU3Y3ZQNHFMVHdsTjNn?=
 =?gb2312?B?TCt6WTJZbGIvQlNmaEpZOTIwWk1EWXk3SFBBdTE2MGZLQnRwVXhRTzB4VFF0?=
 =?gb2312?B?Mi9FNDY1Z3Y2L1lWUnkybEVoS0dpaFljT0JKRXduQXRMb1JVSEk5R1BEQndG?=
 =?gb2312?B?dlRkakNpVzcrZlhqYXdSamcwM0NhRjBLT1RlZ1FySDhpRjNBS29aSzBKY3Ev?=
 =?gb2312?B?ajlKdkw0bmNrSFNOUnlOaTBNdzdVR2ZNNFRCTEpxeldXUVNDL3IyczdzcEtG?=
 =?gb2312?B?OFVXVXpLQjJudkpqREFieEZUN1pzYnVIbUZBVVd1NVdwejl6Q1ExMnp2U3JG?=
 =?gb2312?B?ZUFRTzV5UlZrM1FGTUh0dUJPQVF0UHhLQlhiK0NsQUVxUzBmUkVLc3F6N3Bx?=
 =?gb2312?B?NmFTMnAvNXdZUDZDdndDdUNOamlEMFBCaDFSUlA3VnBPSVZKcHY0MEN6NGpX?=
 =?gb2312?B?dWlaMTB5ZmhhL09LMjRETjUvTnlBa2VjSndMeUltbVpEd0FHUFgybStXemw2?=
 =?gb2312?B?SGY4WVFmaFc4NGZacGxFWXovNFFVZzk5akRmNnRTZWV4cDdESm9jZkI2VXNz?=
 =?gb2312?B?bzloazExdk1ZeTZKVWNubFF0WkJmZHdlNjIvYkxrL0krNlVlc1NueW1TeGxn?=
 =?gb2312?B?OXhiNFk5K3pWU3FXc0Yvd3JzZm5STG11bE1nbUd6dlg4dmxxQ1phZUdlYUhi?=
 =?gb2312?B?SkRTNmQ4NmpZcUpZblNqOGFwVG9zYkxMWG00Q3huKzhES01md05rd09pUlpv?=
 =?gb2312?B?aktFUEpWOG5HYVM2RDJ3eWJDUnRpcVhuTnAxK01QbS90S2w2b2h4d2pwc1NL?=
 =?gb2312?B?d1lFTC9vWVNFV0FDQy9obE9MRFFvN1dGMGg4VmF0am94VElJUTJEWTA5N0dZ?=
 =?gb2312?B?VEF5Z2JJWFplK0diZGg4d2E2cmNJOWtTeDQ2ZDhtTGpISVhsMjZmbjVDOXRL?=
 =?gb2312?B?WjlOUndvdytMd2VsMG4vRGZNMTAxUTNsNVBqd2owMDdOdHM2ZXkvQzYzUUdu?=
 =?gb2312?B?YmIxaTg1ajVUK3N5MzVTL3ZmNVd4aEM0Q2NhbURYZkdEdUN4am1EZHptYkYx?=
 =?gb2312?B?N1R5S2YrZGxYQnhqV1lwaFVrWjQ2TnRnWExKY3QrS0pGV2dhWXp6S2hNb0Fx?=
 =?gb2312?B?eDJLYXhIT05yVjdkaXNGMW5OZnB1U2JrelBUd1NTdm9ndmRkZ0ZBQTBPSzJ4?=
 =?gb2312?B?aGFaUVdQSVdDWC8va2NSaFIyeVNzRm5mK0I1YkVIT3NvRHRVeG05N2d4RWJX?=
 =?gb2312?B?MEJwRlo2NDQrdll2ZUNBaFo2NEpsSCtsRUltZk9yb2cxRVZTZTFmVHlrc0Q0?=
 =?gb2312?B?Vk9JTkZFSmRlTEM1TnQ3VWd2M1NxSTc4cEFHcURRNWFEbkRPb3U0aURKYUtH?=
 =?gb2312?B?Sm5sdXNzZ2pmZEdsYVJsMFhaYnZNT09mU2o1Vlhmb3hQcURPdFFsNnFLamN4?=
 =?gb2312?B?b0ZKZkR6UWFqZmdTWER1cWoraElsSnJjV2Z2c25VbFl3eEVFd3Q2Sk1NQ2xN?=
 =?gb2312?B?Nlk0Q0dNc1ViTnJWVU5ZT2RCaFY2d1RING9mcTh1NU03TkVFelJBMzJEN0VU?=
 =?gb2312?B?MGRKelVUMWRRRGVoN3IxMGRWakEwQnZQb1JFYTdWV0lkc3ZkSDBUVkhUR1ph?=
 =?gb2312?B?QUN4TVppb0ZnRUcyNktuaGlWNVZCTkxZaGNROTJRTncvMnBiazVMdThVM0NG?=
 =?gb2312?B?d242VWNzcEZ2bzhnNWVJN2J1dVNLL1poYWhqN1FsS1YvaGFHelNIQlNQSE85?=
 =?gb2312?B?TEY1UytMVVBqVjlwSjJYZVNSYk5vQ2VOb05SN3Fzd3grWVc4ajhoeDFsTVVy?=
 =?gb2312?Q?7ARk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 068120e9-5afd-4fef-3238-08dde07bf237
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 06:28:30.5297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/QoaXcIjOH3h1My9qiKjTOWi0s4EuGQrQ4kpY734sjA5YVaPDb/hxjBddAtDZ9ZJV88+CGy9C+7T2XAGfqRsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8077

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXE6jjUwjIxyNUgNTo0MA0KPiBUbzogRnJhbmsg
TGkgPGZyYW5rLmxpQG54cC5jb20+DQo+IENjOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBu
eHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsNCj4gbHBpZXJhbGlzaUBrZXJuZWwub3Jn
OyBrd2lsY3p5bnNraUBrZXJuZWwub3JnOyBtYW5pQGtlcm5lbC5vcmc7DQo+IHJvYmhAa2VybmVs
Lm9yZzsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVl
ckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5j
b207DQo+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldjsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDIvMl0gUENJOiBpbXg2OiBBZGQg
YSBtZXRob2QgdG8gaGFuZGxlIENMS1JFUSMNCj4gb3ZlcnJpZGUgYWN0aXZlIGxvdw0KPiANCj4g
T24gV2VkLCBBdWcgMjAsIDIwMjUgYXQgMDU6MDI6MjhQTSAtMDQwMCwgRnJhbmsgTGkgd3JvdGU6
DQo+ID4gT24gV2VkLCBBdWcgMjAsIDIwMjUgYXQgMDM6MzU6MzZQTSAtMDUwMCwgQmpvcm4gSGVs
Z2FhcyB3cm90ZToNCj4gPiA+IE9uIFdlZCwgQXVnIDIwLCAyMDI1IGF0IDA0OjEwOjQ4UE0gKzA4
MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+ID4gPiBUaGUgQ0xLUkVRIyBpcyBhbiBvcGVuIGRy
YWluLCBhY3RpdmUgbG93IHNpZ25hbCB0aGF0IGlzIGRyaXZlbiBsb3cNCj4gPiA+ID4gYnkgdGhl
IGNhcmQgdG8gcmVxdWVzdCByZWZlcmVuY2UgY2xvY2suDQo+ID4gPiA+DQo+ID4gPiA+IFNpbmNl
IHRoZSByZWZlcmVuY2UgY2xvY2sgbWF5IGJlIHJlcXVpcmVkIGJ5IGkuTVggUENJZSBob3N0IHRv
by4NCj4gPiA+ID4gVG8gbWFrZSBzdXJlIHRoaXMgY2xvY2sgaXMgYXZhaWxhYmxlIGV2ZW4gd2hl
biB0aGUgQ0xLUkVRIyBpc24ndA0KPiA+ID4gPiBkcml2ZW4gbG93IGJ5IHRoZSBjYXJkKGUueCBu
byBjYXJkIGNvbm5lY3RlZCksIGZvcmNlIENMS1JFUSMNCj4gPiA+ID4gb3ZlcnJpZGUgYWN0aXZl
IGxvdyBmb3IgaS5NWCBQQ0llIGhvc3QgZHVyaW5nIGluaXRpYWxpemF0aW9uLg0KPiANCj4gV2hh
dCBpcyB0aGUgZWZmZWN0IG9mIHJlZmNsayBub3QgYmVpbmcgYXZhaWxhYmxlIHdoZW4gbm8gY2Fy
ZCBpcyBjb25uZWN0ZWQ/DQo+IEkgZ3Vlc3Mgc29tZXRoaW5nIGlzIHdyb25nIHdpdGggdGhlIGku
TVggUENJZSBob3N0PyAgTWF5YmUgcmVnaXN0ZXINCj4gYWNjZXNzZXMgZG9uJ3Qgd29yaz8gIFNv
bWV0aGluZyBlbHNlPw0KSWYgdGhlIHJlZmNsayBpcyBub3QgYXZhaWxhYmxlLCBidXQgbWFuZGF0
b3J5IHJlcXVpcmVkIGJ5IFJDIGhvc3Qgd2hlbiBubw0KIGNhcmQgaXMgY29ubmVjdGVkIHRvIGRy
aXZlbiBhY3RpdmUgbG93LiBUaGVyZSB3b3VsZCBiZSBQQ0llIFJDIGRyaXZlciBwcm9iZQ0KIGZh
aWx1cmUgYmVjYXVzZSBvZiB0aGUgcGxsIGxvY2sgZXJyb3IgcmV0dXJuIG9yIHRoZSBmYWlsdXJl
IG9mIFBIWSBwb3dlciBvbi4NCj4gDQo+IEhvdyB3b3VsZCBhIHVzZXIga25vdyB0aGF0IHNvbWV0
aGluZyBpcyB3cm9uZyB3aGVuIHRoZSBzbG90IGlzIGVtcHR5Pw0KPiBQcmVzdW1hYmx5IHRoaXMg
cGF0Y2ggZml4ZXMgd2hhdGV2ZXIgaXMgd3JvbmcgaW4gdGhhdCBjYXNlLiANClRoZSBlcnJvciBt
ZXNzYWdlIHdvdWxkIGJlIGR1bXBlZCB0byBpbmZvcm0gdXNlcnMuDQoNCkJlc3QgUmVnYXJkcw0K
UmljaGFyZCBaaHUNCj4gDQo+ID4gPiA+IFRoZSBDTEtSRVEjIG92ZXJyaWRlIGNhbiBiZSBjbGVh
cmVkIHNhZmVseSB3aGVuIHN1cHBvcnRzLWNsa3JlcSBpcw0KPiA+ID4gPiBwcmVzZW50IGFuZCBQ
Q0llIGxpbmsgaXMgdXAgbGF0ZXIuIEJlY2F1c2UgdGhlIENMS1JFUSMgd291bGQgYmUNCj4gPiA+
ID4gZHJpdmVuIGxvdyBieSB0aGUgY2FyZCBpbiB0aGlzIGNhc2UuDQo+ID4gPiA+DQo+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiA+
ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwg
MzUNCj4gPiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ID4gPiBiL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiA+ID4gaW5kZXggODBlNDg3NDZiYmFm
Ni4uYTczNjMyYjQ3ZTJkMyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2ktaW14Ni5jDQo+ID4gPiA+IEBAIC01Miw2ICs1Miw4IEBADQo+ID4gPiA+ICAjZGVm
aW5lIElNWDk1X1BDSUVfUkVGX0NMS0VOCQkJQklUKDIzKQ0KPiA+ID4gPiAgI2RlZmluZSBJTVg5
NV9QQ0lFX1BIWV9DUl9QQVJBX1NFTAkJQklUKDkpDQo+ID4gPiA+ICAjZGVmaW5lIElNWDk1X1BD
SUVfU1NfUldfUkVHXzEJCQkweGY0DQo+ID4gPiA+ICsjZGVmaW5lIElNWDk1X1BDSUVfQ0xLUkVR
X09WRVJSSURFX0VOCQlCSVQoOCkNCj4gPiA+ID4gKyNkZWZpbmUgSU1YOTVfUENJRV9DTEtSRVFf
T1ZFUlJJREVfVkFMCQlCSVQoOSkNCj4gPiA+ID4gICNkZWZpbmUgSU1YOTVfUENJRV9TWVNfQVVY
X1BXUl9ERVQJCUJJVCgzMSkNCj4gPiA+ID4NCj4gPiA+ID4gICNkZWZpbmUgSU1YOTVfUEUwX0dF
Tl9DVFJMXzEJCQkweDEwNTANCj4gPiA+ID4gQEAgLTEzNiw2ICsxMzgsNyBAQCBzdHJ1Y3QgaW14
X3BjaWVfZHJ2ZGF0YSB7DQo+ID4gPiA+ICAJaW50ICgqZW5hYmxlX3JlZl9jbGspKHN0cnVjdCBp
bXhfcGNpZSAqcGNpZSwgYm9vbCBlbmFibGUpOw0KPiA+ID4gPiAgCWludCAoKmNvcmVfcmVzZXQp
KHN0cnVjdCBpbXhfcGNpZSAqcGNpZSwgYm9vbCBhc3NlcnQpOw0KPiA+ID4gPiAgCWludCAoKndh
aXRfcGxsX2xvY2spKHN0cnVjdCBpbXhfcGNpZSAqcGNpZSk7DQo+ID4gPiA+ICsJdm9pZCAoKmNs
cl9jbGtyZXFfb3ZlcnJpZGUpKHN0cnVjdCBpbXhfcGNpZSAqcGNpZSk7DQo+ID4gPiA+ICAJY29u
c3Qgc3RydWN0IGR3X3BjaWVfaG9zdF9vcHMgKm9wczsgIH07DQo+ID4gPiA+DQo+ID4gPiA+IEBA
IC0xNDksNiArMTUyLDcgQEAgc3RydWN0IGlteF9wY2llIHsNCj4gPiA+ID4gIAlzdHJ1Y3QgZ3Bp
b19kZXNjCSpyZXNldF9ncGlvZDsNCj4gPiA+ID4gIAlzdHJ1Y3QgY2xrX2J1bGtfZGF0YQkqY2xr
czsNCj4gPiA+ID4gIAlpbnQJCQludW1fY2xrczsNCj4gPiA+ID4gKwlib29sCQkJc3VwcG9ydHNf
Y2xrcmVxOw0KPiA+ID4gPiAgCXN0cnVjdCByZWdtYXAJCSppb211eGNfZ3ByOw0KPiA+ID4gPiAg
CXUxNgkJCW1zaV9jdHJsOw0KPiA+ID4gPiAgCXUzMgkJCWNvbnRyb2xsZXJfaWQ7DQo+ID4gPiA+
IEBAIC0yNjcsNiArMjcxLDEzIEBAIHN0YXRpYyBpbnQgaW14OTVfcGNpZV9pbml0X3BoeShzdHJ1
Y3QgaW14X3BjaWUNCj4gKmlteF9wY2llKQ0KPiA+ID4gPiAgCQkJICAgSU1YOTVfUENJRV9SRUZf
Q0xLRU4sDQo+ID4gPiA+ICAJCQkgICBJTVg5NV9QQ0lFX1JFRl9DTEtFTik7DQo+ID4gPiA+DQo+
ID4gPiA+ICsJLyogRm9yY2UgQ0xLUkVRIyBsb3cgYnkgb3ZlcnJpZGUgKi8NCj4gPiA+ID4gKwly
ZWdtYXBfdXBkYXRlX2JpdHMoaW14X3BjaWUtPmlvbXV4Y19ncHIsDQo+ID4gPiA+ICsJCQkgICBJ
TVg5NV9QQ0lFX1NTX1JXX1JFR18xLA0KPiA+ID4gPiArCQkJICAgSU1YOTVfUENJRV9DTEtSRVFf
T1ZFUlJJREVfRU4gfA0KPiA+ID4gPiArCQkJICAgSU1YOTVfUENJRV9DTEtSRVFfT1ZFUlJJREVf
VkFMLA0KPiA+ID4gPiArCQkJICAgSU1YOTVfUENJRV9DTEtSRVFfT1ZFUlJJREVfRU4gfA0KPiA+
ID4gPiArCQkJICAgSU1YOTVfUENJRV9DTEtSRVFfT1ZFUlJJREVfVkFMKTsNCj4gPiA+ID4gIAly
ZXR1cm4gMDsNCj4gPiA+ID4gIH0NCj4gPiA+ID4NCj4gPiA+ID4gQEAgLTEyOTgsNiArMTMwOSwx
OCBAQCBzdGF0aWMgdm9pZCBpbXhfcGNpZV9ob3N0X2V4aXQoc3RydWN0DQo+IGR3X3BjaWVfcnAg
KnBwKQ0KPiA+ID4gPiAgCQlyZWd1bGF0b3JfZGlzYWJsZShpbXhfcGNpZS0+dnBjaWUpOw0KPiA+
ID4gPiAgfQ0KPiA+ID4gPg0KPiA+ID4gPiArc3RhdGljIHZvaWQgaW14OG1tX3BjaWVfY2xyX2Ns
a3JlcV9vdmVycmlkZShzdHJ1Y3QgaW14X3BjaWUNCj4gPiA+ID4gKyppbXhfcGNpZSkgew0KPiA+
ID4gPiArCWlteDhtbV9wY2llX2VuYWJsZV9yZWZfY2xrKGlteF9wY2llLCBmYWxzZSk7IH0NCj4g
PiA+ID4gKw0KPiA+ID4gPiArc3RhdGljIHZvaWQgaW14OTVfcGNpZV9jbHJfY2xrcmVxX292ZXJy
aWRlKHN0cnVjdCBpbXhfcGNpZQ0KPiA+ID4gPiArKmlteF9wY2llKSB7DQo+ID4gPiA+ICsJcmVn
bWFwX3VwZGF0ZV9iaXRzKGlteF9wY2llLT5pb211eGNfZ3ByLA0KPiBJTVg5NV9QQ0lFX1NTX1JX
X1JFR18xLA0KPiA+ID4gPiArCQkJICAgSU1YOTVfUENJRV9DTEtSRVFfT1ZFUlJJREVfRU4gfA0K
PiA+ID4gPiArCQkJICAgSU1YOTVfUENJRV9DTEtSRVFfT1ZFUlJJREVfVkFMLCAwKTsgfQ0KPiA+
ID4gPiArDQo+ID4gPiA+ICBzdGF0aWMgdm9pZCBpbXhfcGNpZV9ob3N0X3Bvc3RfaW5pdChzdHJ1
Y3QgZHdfcGNpZV9ycCAqcHApICB7DQo+ID4gPiA+ICAJc3RydWN0IGR3X3BjaWUgKnBjaSA9IHRv
X2R3X3BjaWVfZnJvbV9wcChwcCk7IEBAIC0xMzIyLDYNCj4gPiA+ID4gKzEzNDUsMTIgQEAgc3Rh
dGljIHZvaWQgaW14X3BjaWVfaG9zdF9wb3N0X2luaXQoc3RydWN0IGR3X3BjaWVfcnANCj4gKnBw
KQ0KPiA+ID4gPiAgCQlkd19wY2llX3dyaXRlbF9kYmkocGNpLCBHRU4zX1JFTEFURURfT0ZGLCB2
YWwpOw0KPiA+ID4gPiAgCQlkd19wY2llX2RiaV9yb193cl9kaXMocGNpKTsNCj4gPiA+ID4gIAl9
DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwkvKiBDbGVhciBDTEtSRVEjIG92ZXJyaWRlIGlmIHN1cHBv
cnRzX2Nsa3JlcSBpcyB0cnVlIGFuZCBsaW5rIGlzIHVwICovDQo+ID4gPiA+ICsJaWYgKGR3X3Bj
aWVfbGlua191cChwY2kpICYmIGlteF9wY2llLT5zdXBwb3J0c19jbGtyZXEpIHsNCj4gPiA+ID4g
KwkJaWYgKGlteF9wY2llLT5kcnZkYXRhLT5jbHJfY2xrcmVxX292ZXJyaWRlKQ0KPiA+ID4gPiAr
CQkJaW14X3BjaWUtPmRydmRhdGEtPmNscl9jbGtyZXFfb3ZlcnJpZGUoaW14X3BjaWUpOw0KPiA+
ID4NCj4gPiA+IEl0IHNlZW1zIHJhY3kgdG8gY2xlYXIgdGhlIG92ZXJyaWRlIHdoZW4gdGhlIGxp
bmsgaXMgdXAuDQo+ID4gPg0KPiA+ID4gU2luY2UgaXQgc291bmRzIGxpa2UgdGhlIGkuTVggaG9z
dCByZXF1aXJlcyByZWZjbG9jayBhbGwgdGhlIHRpbWUsDQo+ID4gPiB3aHkgbm90IGtlZXAgdGhl
IG92ZXJyaWRlIHBlcm1hbmVudGx5Pw0KPiA+DQo+ID4gSXQgd2lsbCBMb3N0IGwxc3Mgc3VwcG9y
dCBpZiBlbmFibGUgb3ZlcnJpZGUgcGVybWFuZXRseS4gSSB0aGluayBvdGhlcg0KPiA+IHBsYXRm
b3JtIGhhdmUgc2ltaWxhciBpc3N1ZXMgKGF0IGxlYXN0IGR3YyBjb250cm9sbGVyKS4gTW9zdCBw
bGF0Zm9ybQ0KPiA+IHVzZQ0KPiA+IG0uMiBzb2NrZXQsIHdoaWNoIHB1bGwgZG93biBjbGtfcmVx
IGJ5IEVQIHNpZGUgZGV2aWNlcy4NCj4gPg0KPiA+IE9ubHkgc3RhbmRhcmQgUENJZSBzbG90cywg
IHdoaWNoIGNsa3JlcSBoYXZlIG5vdCBjb25uZWN0IGJ5IEVQIGRldmljZXMNCj4gPiBiZWNhdXNl
IHN0YXJkYXJkIFBDSWUgc2xvdHMgYWRkICNjbGtyZXEgc2lnbmFsIGhhcHBlbiByZWNlbnQgeWVh
cnMNCj4gPiAobWF5YmUgYWZ0ZXIgbWluaVBDSWUgc2xvdCBzcGVjKS4gU29tZSBvbGQgUENJZSBk
ZXZpY2VzIGhhdmUgbm90IGNvbm5lY3QNCj4gaXQuDQo+ID4NCj4gPiBFdmVuIGxhdGVzdCBQQ0ll
IGRldmljZXMsIEkgc2F3IGhhdmUganVtcGVyIGluIFBDSWUgY2FyZCB0byBjb250cm9sbGVyDQo+
ID4gI2Nsa3JlcS4NCj4gPg0KPiA+ID4gT2J2aW91c2x5IGl0IG11c3QgYmUgb2sgdG8ga2VlcCB0
aGUgb3ZlcnJpZGUgZm9yIGEgd2hpbGUsIGJlY2F1c2UNCj4gPiA+IHRoZXJlIGlzIHNvbWUgaW50
ZXJ2YWwgYmV0d2VlbiB0aGUgbGluayBjb21pbmcgdXAgYW5kIHRoZSBjYWxsIG9mDQo+ID4gPiAu
Y2xyX2Nsa3JlcV9vdmVycmlkZSgpLg0KPiA+ID4NCj4gPiA+IFdvdWxkIHNvbWV0aGluZyBiYWQg
aGFwcGVuIGlmIHdlICpuZXZlciogY2FsbGVkDQo+ID4gPiAuY2xyX2Nsa3JlcV9vdmVycmlkZSgp
Pw0KPiA+DQo+ID4gY2xvY2sgd2lsbCBhbHdheXMgcnVubmluZywgbG9zdCBMMVNTIHBvd2VyIHNh
dmUgZmVhdHVyZS4NCj4gDQo+IFRoYW5rcyEgIExldCdzIGluY2x1ZGUgYSBsaXR0bGUgb2YgdGhp
cyBiYWNrIHN0b3J5IGluIHRoZSBuZXh0IHJldiBvZiB0aGUNCj4gY29tbWl0IGxvZyBhbmQgdGhl
IGNvbW1lbnQgbmVhciB0aGUgLmNscl9jbGtyZXFfb3ZlcnJpZGUoKSBjYWxsLg0KPiANCj4gQmpv
cm4NCg==

