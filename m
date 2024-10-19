Return-Path: <linux-pci+bounces-14902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94F59A4CD8
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 12:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D672283C94
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 10:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5571CCECB;
	Sat, 19 Oct 2024 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h6YgtZYX"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E019156B81;
	Sat, 19 Oct 2024 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729333328; cv=fail; b=twkdna4D/x3vF2t6vGLLAhJ7ZCaBSQW0Suml0v2uB/XGg4e/FfYGdD/BxBDnwUltia+E8ilKrldb2Llzr2IZdRVuCXBUoxzSJXP7Rz+slANg0WUnfmba3EhKStaF+0HsYdI7DlECUOC3ce7VWAALEb4kQUNfOAw7AmkoICW86W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729333328; c=relaxed/simple;
	bh=loSQGQfg0MfXR8vJ+0H41CJT+Vg2IEYNWAtWa/KzroU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QJKKk7AjDBdIwXtJxpN1UZUuU3nuWrHCAzy7u2HetKoN2tVns8yfPlRKziQxcCSEEjUAhWj9FTuDluhTO8uT0t8doSwPg8SvXJHGAf63nLfh+7DZg8YrozJgSV0sKHIXWaIwMUr4wbavWFAVj1RuENqW0fx2iNqzaj5qNeiNRmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h6YgtZYX; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0oqLjMyXHbequQ5B+VcFXWgcKsHvs3AqQrKlJXwLcf4hhxWV8LRHmB2jR9RkCB9OyHMu7SmQCMwIOsILQilRMWZuyvCA+Zg06E8iAcCkzeRUnxKio05nQCzYXMzyNLxJHF86FyInBmPnhRqk1i/0g4eSv2OPsKVWeAxL3U8omKiGdOcj3Ob2GniKPdzoK43PlFbvLEbEI56Aq+ZNHCC4f1srV/6ZLvGcI2CVkCFiB1v3vF3wNf4WTFZfeTdwOkLBRMQIHkawr8ZIrXGndVXbtitQlTV+gFaJNCYA2BO1bpyOqUywJAetomdUdw5qPflIGiwYjBL2ZfAyQ1Gl6O1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loSQGQfg0MfXR8vJ+0H41CJT+Vg2IEYNWAtWa/KzroU=;
 b=YWTY+cUEUD1TmE8trTzuCQhkgdIa38JngXfwAsh1s2i/F7SQrkOKGT13zdWV6Gk8/qbR6kx96px0KpxAH4n56yI8O77EOqIKbT/zf/3Q/JkqGYn77cCq4ddFEVNav9OLp58goaMZ24/YNSfSdCiZNZ1VEjWz3xdmCZ312XFv1oETXJthZhtIHpm4hxEcMjE4dVoDWG2X5vv7kgwW45QzCEb7oYiFK17Dqz6xnG8X9/r5VogGtGRdPpvALXf8q9uiiEA2/5AbrKo3i9HnqukUDqCiO93UUnzZwnzoyhUkWwAL5R7rjBCKefRXXbN/1LCySDw3jdWvdG/eD4i70Jibuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loSQGQfg0MfXR8vJ+0H41CJT+Vg2IEYNWAtWa/KzroU=;
 b=h6YgtZYXu9NRsBRZAHA8+fjaNrPr7AYk8B9VWnxxt3dq0iVVN1PUt44EzdY9At+3I+KacZjArXm9STl7h98G6sWWsvP67G313sG2NOR7k6CHFwjJPYM7ytuo+FVu2Y/RM8YpwftoviJCBb2qAFWQ7aLFfukLAz8b+32eJ4NI6fqplS4IxV4Dyo9XEb/cs0xttMrZF2jNSrkpnnK37lGT2zE1MEfWV87szhtEU7gtg5fkceLVGq7PRvHZYKm7zd9AChve3wIMIJwbAhboYZbCvVlN8xfkBRf/Pna4CW/027qndsEStyTMVf/ilmsOPCrBK3VHGeNRjwESZNULoinkmg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8686.eurprd04.prod.outlook.com (2603:10a6:102:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Sat, 19 Oct
 2024 10:22:02 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.016; Sat, 19 Oct 2024
 10:22:02 +0000
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
	<bhelgaas@google.com>, "horms@kernel.org" <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 12/13] net: enetc: add preliminary support for
 i.MX95 ENETC PF
Thread-Topic: [PATCH v3 net-next 12/13] net: enetc: add preliminary support
 for i.MX95 ENETC PF
Thread-Index: AQHbIGsGfwE9ZCz3ZEi++6XhhsicXLKLKwWAgACQAXCAABj9wIAA/R2AgAEJKSA=
Date: Sat, 19 Oct 2024 10:22:02 +0000
Message-ID:
 <PAXPR04MB8510E9F80DEAC6982D6D87A388412@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
 <20241017074637.1265584-13-wei.fang@nxp.com>
 <ZxFCcbDqXHdkW18c@lizhi-Precision-Tower-5810>
 <PAXPR04MB8510E7AD1EEAFD9332DAE29788402@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB8510A1664D3CFAACD71872AB88402@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <ZxKkhykJ5joWZxaR@lizhi-Precision-Tower-5810>
In-Reply-To: <ZxKkhykJ5joWZxaR@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB8686:EE_
x-ms-office365-filtering-correlation-id: 7d5729d3-d770-48d9-d707-08dcf027df50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z2FSYWdDbVp5YjRvcWQ1d3FPOCswd1FYWEl6Z25TTVpReHpPZmNqMkJBMmVv?=
 =?utf-8?B?UXNGaURvUjhzak8wVmdzMHk3UEQ5SnlYVWZCYUdTL0J3dW0xY3UvZTNrKzZO?=
 =?utf-8?B?ckF3QURLMlVST3FPbVVYVmNyZ2ZIRllxRjhObWd3WlVHWGxqV201THR2cmc3?=
 =?utf-8?B?aHcydWs1MitoSEtmV0lDcWdwdFdKNjd3SWdXbkVBQk4yVUtkU1ozaTF1WHFj?=
 =?utf-8?B?MHdBVEoyM05HOERmS0g4SXEwRzZKZzVCaEhsRjFheEN4L0dhTFZxd3B2ZDlh?=
 =?utf-8?B?N1BGSmNpSEd0Q3RRazd2eUJhdnd6WHdvam9KdERqRUVSRlBvYWJZbmpWWHFi?=
 =?utf-8?B?MnpobUxDTGFHV1hrT2l4c2F3d2ptd28rZlp3QVpQYW1SNnVrZjdoVkppQjZQ?=
 =?utf-8?B?Z0FtY2VDUEFVM3cxV09yT202eTJwL01wWEMzeVFHQzZ3Y1hiQ2lOeVJ0eTRF?=
 =?utf-8?B?ZzM4L1ZkUm5xZWNyaDVzYytFNlFLOEU5V1dSTGZReE80dDhRaXExODBhQyti?=
 =?utf-8?B?dDhIek5uNFhOTlR0eS95aTlrc2J3MTRmWFdUS0h1aERTelFGWkRzZlNUaGFr?=
 =?utf-8?B?T2V6TDg0U3p1RmJCK1NmTy9Mem9EMFpQQXdOUFJaN1BjbHZRSVhSdUlJRmkr?=
 =?utf-8?B?ZVJtSWtOcUFFdXdzWnovS0hjbCtJWStzYmxWQjNxRThQSkptNW9wWDNWU1VM?=
 =?utf-8?B?NHlwRE9XOTFSQUpXS1RtNTdsTFc4Z2VEYjRmb1N1UWJ6TjZFYzdzZm8yblE1?=
 =?utf-8?B?ZWN6V0tqY1lycnVlOTdNcjNtSGY3YXE1M0VXK0s3TEFxV3VPYzVoaUw1Vy92?=
 =?utf-8?B?czZBOE1jeU1mK3ZNZVRpeE9WSDE2VHdYUHpLMzJXdWtDejJsMlM0ekZRQ0Z2?=
 =?utf-8?B?YXZONVM0KzNFbzhEYlUwWUViNXc4RmZRMzFCOFM5ZVEzOUpHb2xnTndrbUNT?=
 =?utf-8?B?bkl4RGp4dEtmRjJEMElMKytSUmRVWkpqdnpvMDYxQzhPc2NVWDRtSWFadHVo?=
 =?utf-8?B?emFRRUY5RGhTdzI5ZVN2Skl2UjN4eWxTQ0FNVktxL1dLUmVOTWZ5WDdORDAr?=
 =?utf-8?B?OTk0NG4rYWUzSW56QmlydmYvd1hKejh2d1BLakxZYmc4UjV0ejlRRGVmNlEw?=
 =?utf-8?B?d0l4OGxYU0hIL0hLTVJGbytiTkFiU2tIRSs0WlF3ZjNoWWF5WjFWMlR3ZEYx?=
 =?utf-8?B?bmc5OXNVMkczUEZhblZnalgyOW5OZ1ljMWM1TFF6OEVzZVdnWGNhby9NYS9K?=
 =?utf-8?B?ajdKcXdOSGFQd3Rwa3pYTjJISkJ1ZE9nTWFVV3UrWW9UbXd0ZFV5eFJ4cDdR?=
 =?utf-8?B?V3FkS0MyWEZ6QUtWSnNUeHZXcTl4bjZvWG5yMTUvNEZXL2dnaXpBR2pYQi8w?=
 =?utf-8?B?WTRVa3creDZxalJsUHZlWENqbXp6QkZ6cktVeFJvU0xobzVSWUU1VVdBcXFv?=
 =?utf-8?B?amJUUWFyZEFZUWhiam5ta0w5Ky9YbXBQRm9VYTJ3MW1oaHk3Q1FrWE1tUlNC?=
 =?utf-8?B?cFlMVUN1ellVQkxmYTJTczVPRFJLaDdVT2hBTHpqZGNwdU9LOGExenNDU0pk?=
 =?utf-8?B?Ukg4YktPOTZURGV0Z3RacnVHRXMvdHlBQVYwNHBRS2hqSzltUXJyUUNPREMz?=
 =?utf-8?B?c3FaR0EyaEZ0b3E2bWxWMUhSaEsvY3Erc0V0bUE0bXRra1NaL252L3pkZTlJ?=
 =?utf-8?B?TUw5VjlGOTJ5bkZmdXI1Yy9nR1RLOWVxS3IydEhvc2IxZnZobGpHS3lHNmlh?=
 =?utf-8?B?a2QwMnBPbDJOM2VISE81ajA5eUhpNmpYYnpKY0c0aXRlNFdxYVV6ZHVYUWR2?=
 =?utf-8?Q?ANbti8FdRJX07dIOvQnykrnRvEogoWyfW9LyY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alA2bnBzcUdJMWlUWFZRS2ZQN3hUaTQyNGtuOWZ1MVpzTHpwcmd5RjlFMmQr?=
 =?utf-8?B?ams1MDgwUjcvd0l2bDBtOFVrdGlZSTExVFZYV3pTejh3Vml3dDB6SWlUQmRn?=
 =?utf-8?B?NW4vOXBKcUEwK3l3SU0yb2FTbWNmd3I4Unl6N2p2dlQ1VVFUWHhtTnZKU1NO?=
 =?utf-8?B?OFpkdkhUaGJOWHF3L0dOK29rcElkSjNvOUdRUWw4eUZkdnlmUEg5aGNEd2RL?=
 =?utf-8?B?QWhHcVZuaVcvRGlxUXMxQzJqNDY2OUZtMVdyekU0VHg0SzdLb0Vzc2J0ODlX?=
 =?utf-8?B?N0NNZ0NTR2pCTWZEaGdxcHNNYURBYkFtOE92SFRiZU95R1ZGZnc2NXZVWkRL?=
 =?utf-8?B?b1JVR1VVaHZRSU1hak1XVGoxZW01YmVFNENCMTVxYU1uVE1SMGhmeUxWOUFR?=
 =?utf-8?B?RTU1eFFxQUlHTldDbVdmQ2JWQ2RtMXpOMC85dWdCczc3UVNZanpjd08vdG1J?=
 =?utf-8?B?RjRoZ21qeTA4WE94Mnc3VGN5Nzd0MVFwRW1ZcmJsN2psTVBFUlhuY0pBSHJq?=
 =?utf-8?B?QkFuTEpqcXdDTitMV3BFRzNtVEpEWWFrbWpDUXpwOWE0U1l1bmZWMGhiRlJT?=
 =?utf-8?B?bHJhdVlDZW82V0w2OENUVEU5eHpaaU1oclIxeG5CUmNwcXVDTHYvQ2w5UW9M?=
 =?utf-8?B?MWhRSkdpMkR6ZVV0YlJidS8xR2J0ZDU4UlZkdndzcjBGYVd0bjhZSmRWVERh?=
 =?utf-8?B?cWI3bEVsbFBNd2thUFdCWnJuM0JBSFJuYnJRbmYrcHJUR1JUdFprQVIxaWVo?=
 =?utf-8?B?aEZGQ1RjMEF2YmtzL3NsL3B1am1QandFZXk2bndTbEEwbjcxbFlOK2VUQUVJ?=
 =?utf-8?B?N3dad0k5a3dLdXR3dDhrb0NjNlBWS1dBKytzVUNLeUIwZFluemZ5OUhHbm5I?=
 =?utf-8?B?NjhzNkdDRFhqUmpwUy8xWWN6REoxSHRrVDNrMHpobWt0ZmZuMTl0dVVuU1l3?=
 =?utf-8?B?bzhoMzQzb0tJMUVhL3NET1BRSVNRK0daR216N3ZWTUZkZ2JSWkJOYUFTSnE2?=
 =?utf-8?B?eHQwV1k3WnVPd3B4TndpVHRCbXZsUmkwQ2NObU02NWNES2RJNXNYS2RONE1z?=
 =?utf-8?B?N3dxK3hoL2VWU0VlL0MvVERiSk1hQWVqQ0oxaDk4NkxadHYxQVpuU2JyWEla?=
 =?utf-8?B?RlpIZTZxL29hNTlzUXVVRWpjTkN2N1pIN1ZDKzhNTFJBTWNCalFhNDhXRmtC?=
 =?utf-8?B?eG1QWjZKdWpKejc2VEc4alYyM0IwZUJSeGt5Mm9kbWYrRXhVV2w5MUVGVjBw?=
 =?utf-8?B?c3pZZDc0OWMwOUhWRnRMWWdNT3grRHZUdzczbUVEZjZlN0xMaGtRdDkxRGhk?=
 =?utf-8?B?dzhkUHhQRFgrY2JrRlFOcXV5YWw1dkVTcWJaN01nc2Q3d1ZNSnNsdVBFNVY5?=
 =?utf-8?B?YkN1OFo3UFdxcTV6N1VEcC9CamQ4RUVJNWdHVFFBN3RaZmhaeUFjSFNLL3Vl?=
 =?utf-8?B?bmVFNTZtMk10WGtZSjdMKzRTclRNNUgzdTV2NGdQZkRrYlhzNW1DRzl5SktQ?=
 =?utf-8?B?QXFtb3VMREdKWU5pWUF3U3FNQWkwSGpwNm42VEh2NnBIWm1Wa2I5SDkwVjB2?=
 =?utf-8?B?SDBVL2NsaXFMaU10ZWJlUDc2SElVSitFZlN5ajFvclVkUVpIUzRoM0xGM2lk?=
 =?utf-8?B?aWRHUmpYTEt5MlpaNjdiZWZjVkJYVSt6Z2hLamdqc3ZubXhlR3VsM280Rlhq?=
 =?utf-8?B?V1k0OGUwL29FajZ4WUxNcEpoa1VKVDIrWjBRUzlvMU5mQ2NNQS84bzFIT3di?=
 =?utf-8?B?SEVNcWUvZWNxV3orQUhpK2VuOWRnbXZjUHZPdk5sYldDRDArTDhQSG1XMXpz?=
 =?utf-8?B?Zng4aUFTOEVHd3Ftd3BaSGV3T3I1UVJxMExlV1ZTOU81QlZhQkh0cnRSTnVO?=
 =?utf-8?B?ZU9sdk5UYkg0WHpROENuTjduZ1ZUdXd3cU15L3pRZzM5VXRKd1d6WHM5dW9r?=
 =?utf-8?B?alNCNWJSY3JEWjhkTzgrYjhnNmRQWGpCUmgvUzdpeEkzVEpVeVV6RGQwWDVD?=
 =?utf-8?B?QkVSTnZISmUvVzk4NzVlcDRjbGJwdVRvN21nSkh1elc2cXFtWmJtOTliUTRK?=
 =?utf-8?B?RXhoc1dhbmV3eEpFRnpNVXNac2dMc1hoNFNpbThzemtOaEpMQUtyd3JPNmlJ?=
 =?utf-8?Q?BZv0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5729d3-d770-48d9-d707-08dcf027df50
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2024 10:22:02.0261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 38E+KOe209xuinuFOF2+q37i6zpDlSwUBEphg/m1BwLym1zTOM2REBiAEGD1SYmve/ffqdFAcJISnmxuys7ebQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8686

PiA+ID4NCj4gPiA+IFsuLi5dDQo+ID4gPiA+ID4gQEAgLTE3MjEsMTQgKzE3MjQsMjUgQEAgdm9p
ZCBlbmV0Y19nZXRfc2lfY2FwcyhzdHJ1Y3QgZW5ldGNfc2kNCj4gKnNpKQ0KPiA+ID4gPiA+ICAJ
c3RydWN0IGVuZXRjX2h3ICpodyA9ICZzaS0+aHc7DQo+ID4gPiA+ID4gIAl1MzIgdmFsOw0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gKwlpZiAoaXNfZW5ldGNfcmV2MShzaSkpDQo+ID4gPiA+ID4gKwkJ
c2ktPmNsa19mcmVxID0gRU5FVENfQ0xLOw0KPiA+ID4gPiA+ICsJZWxzZQ0KPiA+ID4gPiA+ICsJ
CXNpLT5jbGtfZnJlcSA9IEVORVRDX0NMS18zMzNNOw0KPiA+ID4gPg0KPiA+ID4gPiBjYW4geW91
IHVzZSBjbGtfZ2F0ZV9yYXRlKCkgdG8gZ2V0IGZyZXF1ZW5jeSBpbnN0ZWFkIG9mIGhhcmRjb2Rl
IGhlcmUuDQo+ID4gPg0KPiA+ID4gY2xrX2dhdGVfcmF0ZSgpIGlzIG5vdCBwb3NzaWJsZSB0byBi
ZSB1c2VkIGhlcmUsIGVuZXRjX2dldF9zaV9jYXBzKCkNCj4gPiA+IGlzIHNoYXJlZCBieSBQRiBh
bmQgVkZzLCBidXQgVkYgZG9lcyBub3QgaGF2ZSBEVCBub2RlLiBTZWNvbmQsDQo+ID4gPiBMUzEw
MjhBIGFuZCBTMzIgcGxhdGZvcm0gZG8gbm90IHVzZSB0aGUgY2xvY2tzIHByb3BlcnR5Lg0KPiAN
Cj4gSXQgc2hvdWxkIGJlIHNldCB3aGVuIHBmIHByb2JlLg0KPiANCj4gZW5ldGM0X3BmX25ldGRl
dl9jcmVhdGUoKQ0KPiB7DQo+IAkuLi4NCj4gCXByaXYtPnJlZl9jbGsgPSBkZXZtX2Nsa19nZXRf
b3B0aW9uYWwoZGV2LCAicmVmIik7DQo+IA0KPiAJSSBhbSBzdXJlIGlmIGl0IGlzICJyZWYiIGNs
b2NrLg0KDQpzaS0+Y2xrX2ZyZXEgaW5kaWNhdGVzIHRoZSBORVRDIHN5c3RlbSBjbG9jaywgbm90
IHRoZSBldGhlcm5ldCByZWZlcmVuY2UNCmNsb2NrLCBhbmQgdGhlIHN5c3RlbSBjbG9jayBpcyBu
b3QgZGVmaW5lZCBpbiBmc2wsZW5ldGMueWFtbC4NCg0KPiANCj4gCWlmIChyZWZfY2xrKQ0KPiAJ
CXNpLT5jbGtfZnJlcSA9IGNsa19nZXRfcmF0ZShyZWZfY2xrKTsNCj4gCWVsc2UNCj4gCQlzaS0+
Y2xrX2ZyZXEgPSBFTkVUQ19DTEs7IC8vZGVmYXVsdCBvbmUgZm9yIG9sZCBMUzEwMjhBLg0KDQpJ
IHN0aWxsIHByZWZlciB0aGUgaGFyZGNvZGUgYmFzZWQgb24gdGhlIElQIHJldmlzaW9uLCB0d28g
cmVhc29ucyBhcmUgYXMgZm9sbG93cywNClRoZSBmaXJzdCByZWFzb24gaXMgdGhhdCBFTkVUQyBW
RiBkb2VzIG5vdCBoYXZlIGEgRFQgbm9kZSwgc28gVkYgY2Fubm90IGdldA0KdGhlIHN5c3RlbSBj
bG9jayBmcm9tIERULg0KVGhlIHNlY29uZCByZWFzb24gaXMgdGhhdCBTMzIgcGxhdGZvcm0gYWxz
byBub3QgdXNlIHRoZSBjbG9ja3MgcHJvcGVydHkgaW4gRFQsDQpzbyB0aGlzIHNvbHV0aW9uIGlz
IG5vdCBzdWl0YWJsZSBmb3IgUzMyIHBsYXRmb3JtLiBJbiBhZGRpdGlvbiwgZm9yIGkuTVggcGxh
dGZvcm1zLA0KdGhlcmUgaXMgYSAxLzIgZGl2aWRlciBpbnNpZGUgdGhlIE5FVENNSVgsIHRoZSBj
bG9jayByYXRlIHdlIGdldCBmcm9tIGNsa19nZXRfcmF0ZSgpDQppcyA2NjZNSHosIGFuZCB3ZSBu
ZWVkIHRvIGRpdmlkZSBieSAyIHRvIGdldCB0aGUgY29ycmVjdCBzeXN0ZW0gY2xvY2sgcmF0ZS4g
QnV0DQpTMzIgZG9lcyBub3QgaGF2ZSBhIE5FVENNSVggc28gdGhlcmUgbWF5IG5vdCBoYXZlIGEg
MS8yIGRpdmlkZXIgb3IgbWF5IGhhdmUNCm90aGVyIGRpdmlkZXJzLCBldmVuIGlmIGl0IHN1cHBv
cnQgdGhlIGNsb2NrcyBwcm9wZXJ0eSwgdGhlIGNhbGN1bGF0aW9uIG9mIGdldHRpbmcgdGhlDQpz
eXN0ZW0gY2xvY2sgcmF0ZSBpcyBkaWZmZXJlbnQuIFRoZXJlZm9yZSwgdGhlIGhhcmRjb2RlIGJh
c2VkIG9uIHRoZSBJUCByZXZpc2lvbiBpcw0Kc2ltcGxlciBhbmQgY2xlYXJlciwgYW5kIGNhbiBi
ZSBzaGFyZWQgYnkgYm90aCBQRiBhbmQgVkZzLg0KDQo+IA0KPiAJTmV4dCB0aW1lLCBpdCBtYXkg
YmUgYmVjb21lIDQ0NE1IeiwgNTU1TWh6Li4uDQo+IH0NCj4gDQoNCg==

