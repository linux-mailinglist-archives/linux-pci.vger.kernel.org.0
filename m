Return-Path: <linux-pci+bounces-32616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C73E5B0BB6F
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 05:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204D618982D4
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 03:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A251990D8;
	Mon, 21 Jul 2025 03:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="NXKpz6T0"
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022093.outbound.protection.outlook.com [52.101.126.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B236F38DE1;
	Mon, 21 Jul 2025 03:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753068786; cv=fail; b=VpzjiFf5pCstmMIbtBFX6xk5d7CYP1cRYbl+cLTqEyg1W6ViiwJ/bQAfRdKqF2slb0y28Q6uCnYR/tEYNkQG+HzILvTJf2nBRJEzlOaEci2P2kNPjL2h6Amtzb5mk3+PMI0z5dFCRz2Puhyg17Fn+Y2WhYahF8Qbh1gfX3QCQRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753068786; c=relaxed/simple;
	bh=7Thpj7Tt9l8HHmcmbOcR5zxQsB9h1ARXEMFAMK7WNnA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HxcgDlTjjwJgACIv2u9qIHlF20ci3zZBuIAO7EZcSPADAsk2nXHnn+HwCs3NcXD894r3SNhZOBSROYtHOni/sIL5WX/S3zMyg2TYygze+EJGKWTSTcjRQhoLSne9I7Fbm0sgfH+5t8RPEDtoPJLrC5j8fy4rY3ueErTULSf8uwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=NXKpz6T0; arc=fail smtp.client-ip=52.101.126.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHSE68/qI+/qoYTV2WJg3b5qHYo1c2eEqtKMuD50qg1Pogu87szmARE8gv9Wua9fOWBYvTwQXCAqls7u8AyupnOCXC1/mfP8Z0NgXloUtacQ7ln3YwbIl/WyWu/M08XGM42ZpUWb9MZzj9o904jrPw68FHVvqS4kpQ/PS6gVzj3bp5AoI9fvUxrjQkQNf5P2gaF/u3gY8MnUgWSFT8eqAEoea+ybpw9C7YVd9GXYh4e8ygFIdo9ogb156PwwJi6SqU82QL9jXmNArT7fXhDB4Hu8PtLyI4oGJaHsp6cuPPrkryrwpUHpxApXbKAS6FxBuTdCgRQVjho8huVtza2YXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Thpj7Tt9l8HHmcmbOcR5zxQsB9h1ARXEMFAMK7WNnA=;
 b=p/dXtkgKvd3D6lOteY3LFULmhMhdl3ehQBQqGJuUMUEo0gQoSJgYPJqrCWzfbfxc7XFdLipx0xeAJqpJQtckqLSwY1xnY5YOlCfaDVIUW66EWUGYmsc1e/kCJwesCikLfWvt+2eb+y68yccgsjyRVdh67OkVjPm/K1Y2nP/FJhrdhI3ojleO/tFG1G+HtgsY8/508wrkb6IQJyCI+u8Mp08ByzZ/7HlTOtBeseyx0vcPwAZ39TmoitmIDg900bvvIaYLpSl6S+KHXPl9cNLFFbKPQHEx5Ws0u0lGZb0Nojn8DaivsvDHpiwuvAvon2PRx7N4hMa/q85Mt3hNd7728A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Thpj7Tt9l8HHmcmbOcR5zxQsB9h1ARXEMFAMK7WNnA=;
 b=NXKpz6T0Gb3StIhmCJnSRO0Q0USpIpg9vYNyTYej38HEe9hAOIqNlox+y1T58+KJhD91EEb/20hXQC1ngk5Z7RDXK4XGnYsGwxzb51VDMdZpcbmteF+Y6pn0mU879fq4AEr2WfBkIBidrO2G3lilOR369carOC0VY4oc7QCYE/ew3Pn0Eemj8pD254b8kqEeHpMczHKv6cSZUbEhxq1TN1Pggqrk88QQmXHP9akal5Ku1DhQb4dL3WJFSGXBGAsn+O1A1QXtzLFURE26mGMVpR3WVOCSRkz/niF6/ihgwbcIsgfcAYt8fQbadO3dSc7Jn1EdzefPQ2BrA3Pu1f3T/A==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SG2PR06MB5262.apcprd06.prod.outlook.com (2603:1096:4:1d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 03:32:58 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%7]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 03:32:57 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, BMC-SW <BMC-SW@aspeedtech.com>
Subject:
 =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggdjIgMDQvMTBdIGR0LWJpbmRpbmdzOiBwaW5jdHJs?=
 =?utf-8?B?OiBhc3BlZWQsYXN0MjYwMC1waW5jdHJsOiBBZGQgUENJZSBSQyBQRVJTVCMg?=
 =?utf-8?Q?group?=
Thread-Topic: [PATCH v2 04/10] dt-bindings: pinctrl: aspeed,ast2600-pinctrl:
 Add PCIe RC PERST# group
Thread-Index: AQHb9Tqj6jB5s8BcUESNrJkKTb5wt7Q0bJoAgAeIFyA=
Date: Mon, 21 Jul 2025 03:32:57 +0000
Message-ID:
 <SEYPR06MB513445DC86218E0ACDDB90889D5DA@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20250715034320.2553837-1-jacky_chou@aspeedtech.com>
 <20250715034320.2553837-5-jacky_chou@aspeedtech.com>
 <20250716-provocative-worm-of-gallantry-3797f8@krzk-bin>
In-Reply-To: <20250716-provocative-worm-of-gallantry-3797f8@krzk-bin>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SG2PR06MB5262:EE_
x-ms-office365-filtering-correlation-id: 9f167b47-a735-44c7-5b8a-08ddc8074957
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3orQ1VMNUhKY3cyMHl4WmV1SkxiSFV2bEtjTXZPYnZ0VWZ4TGh1TFJXWWZ0?=
 =?utf-8?B?b3BpK1BjYm54aTNzQmNoamQyNEVBY3RvQnQvaUk5NU1ma3NreWw1STJWck92?=
 =?utf-8?B?a3hiMmpXQjVxTXZtOFBhNHZUM3N2ODV6dkJKTm9aVHp5YjdYVndGa1JFYkQ5?=
 =?utf-8?B?RXJoaFFNK2ovMGhoYTVZTGZJNTBJTHg2ajAxMWRTbWhFVVpXbGVWZlhaaHFI?=
 =?utf-8?B?eGpRbU1qMTVzaDB3RlduVXhnTk1Sbk10V3AyQWp4NjVSNkdJSkJudDFlTTVa?=
 =?utf-8?B?N1V0RFRMdU5sNVdQcy9zaUVDZk1HNWxCd0VVRkY0NGpWOTlDdGlWV3dVb1pD?=
 =?utf-8?B?b01OK2xhWC9sZXdpWXpFZDgzTW1tK0RPK25ZbzNPYjNoVm1FQ3ZEajF3TzZy?=
 =?utf-8?B?WjVLTW1jMzM1RmZkTnhmbFRqazBZVjFCcTI4WjVzNkxSdzc4N0d2Ym90d3hZ?=
 =?utf-8?B?cmJCSk4yai9BTFNFbEh6YStOdEpsRk55akF5MGxBZFdMdFZZdmZGdnlQaTZM?=
 =?utf-8?B?SkRXbXA3cDR6S2ltUTZvcE95VnArUmV6WVl5SXlrUGx1UU5YUzQ0SFo4cUhV?=
 =?utf-8?B?SnJqN2hBMWREemkyTlZZNVROMkpxU2NFQzlZK0t5MG9nTmNVZmc1aVBXNmdz?=
 =?utf-8?B?dXllYlp2RHR0Q211RzFCbmNKbjJyNTBtVUdBMkx4MnlnYzdBRGtnUXowOVo4?=
 =?utf-8?B?OWJackpKZis1VFpNNDlaNW9SSTFyNzgzZDcwUTNqdEgrZGlydi9EOXQrRVRa?=
 =?utf-8?B?YWJxWEtIM25TTmRINUdwcEZyM3NFWVZ2Nkk1ODc5MUxQUEg5dUdZQjdRWk9P?=
 =?utf-8?B?a0xwMnZmZFplTFRJYjRMVk83VVdOME9qWTNuNTVqOWZQRnJlbTJhZ055SmpS?=
 =?utf-8?B?aG53Vmx1Ukp0ZFlrUW1TNExqQVNCemtyZTFtcEJub3RyL3ZkUHBGVUg3cVZa?=
 =?utf-8?B?cnd6MEtUQ1FNV2ZUMm5zdHVqa1pEY2FsWmpKUTlVSXBjUlFYTWQ5S05vWnZy?=
 =?utf-8?B?RCtoMmhrT0NDOUI5dElzZjFKaTNYY1NOZjFGZzdYOUs1Nm9xZ25CdG9hdHRu?=
 =?utf-8?B?TUc2OXAyaG40NXhFL3NpSDFSRy9ZWENNTndBaHJseGhwL2dTYkN3WHJUZkg5?=
 =?utf-8?B?YWh0V3pwM1NwY2x5aXIvOVJsZnRQU25heUZSTUdibGVPZzk2eitray82aGVV?=
 =?utf-8?B?cnk2KzBPbUl1eHRMOFBTL2g3Z3lZS2c3UEQxQ0x1bmlyUGdycm5rWDhaNWpZ?=
 =?utf-8?B?WEJHSk1vSlhabjNZdVJOL2txZjJVdjRmalc0cnBGTWI2NmxSWW5aZXBmMzNC?=
 =?utf-8?B?d2lpbVA5cExibGpmL2hBaFJWbjVGaHI2ZDhtYW5uWGlieFRBaHNUZXl6OTYv?=
 =?utf-8?B?TEx1bnc3SWZnWStoK2F5MnZpZzNLd1NzdEFNZXhQdXp0RU1kS2JFVDFGcnNQ?=
 =?utf-8?B?UzF4aUQwQk9nRVRuQlNIblJ0WHJ0MnFwVldWRjBuczV5Vmo2eVZYM3gvenlr?=
 =?utf-8?B?UHBCdHIxM0hzOFVUNlEwaU45aEJyRFM5dnB0bU9MckdydFNRZUlKNDZXTXBO?=
 =?utf-8?B?aS9pQ3puOHBCSm5FaDNhajlDcTY4RVBrYWRQZjFKYXkvNmwxRXBFbGE3VTNC?=
 =?utf-8?B?UjhKVFp0NDU2RTBmM1Y2bjFpRktsMWo0MkhBVG9ER0greFp3S3ZrUXpSbGdq?=
 =?utf-8?B?b05uRE95OWd0NUx0cmRsVUppdUl4ejJmY0lpUUtSQlVNUmRIdkYzUzBPZkZY?=
 =?utf-8?B?ekVEVlJhdm95VEVsWndHUFRxSDVyb210bnloYzRqT25HVkRuZm9vdFdDV2Vw?=
 =?utf-8?B?SENldUZ3OTdyTFFaS2xsVmVPK1BGM1BncjFlRDQ3UWt2aTVmekg5N3JLMVQy?=
 =?utf-8?B?ckFPOWkzNjRvUU1ZdEhkQnA3YmRwWVBDempzZ3V5VDYvZmNsZGRtdUlqTGRz?=
 =?utf-8?B?ZXNMMHc2STRTVjR5Q0FXSzdiT3BIdFp4Q0JxeElwOHkxRXQxdTJlTFpRN0hm?=
 =?utf-8?B?R3ZHZGpOMGl3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1JxMEpjZFpUeXpqK0NQRzRKcE5DUnorend1c1NidzZ5K0k1QksrT2FHd0Fv?=
 =?utf-8?B?amNYUFB1d0xxNkNaWTUyYk1lSXhRbjFLYTA1akhMNGc5aGtBTmhkeFBHZFAz?=
 =?utf-8?B?Vk56Z3dyc1NDSWtXVTYwUWN2N281MWRPNWJNM2xOUVRuVnBKQXU4ZmhHaUFp?=
 =?utf-8?B?KzN2OURpR2tickVyeHh6Nk92dzh4Ykt0WHRtY1A5NjQySHc4T3dIdVNoMFNh?=
 =?utf-8?B?MUhGd3lpWTNMMUlBZFM4bUhRN25qay96M3FKSkZ3c1loeGxpTEd2UFNUL0I3?=
 =?utf-8?B?QWZRRy9Lcm1jR0tUTmNhbFIzZ0VUc0NhYXpwRlFUNkxaVWlCWEVpUFlaVERo?=
 =?utf-8?B?Nnc3VXBXckRUOFJ2ZWNFcW1MSW8vWS92bVZSVjF6OXNyampSVlg0Si9KdGZw?=
 =?utf-8?B?TVZveW9nWDV0OVFib2Q1WlA5UWxVUXVWUnRPMis5V1FFNjRCNWUrcmhBZVNQ?=
 =?utf-8?B?ZHNkU3BadVFtY3NpdkxMbE1hOUxISUN2dWw0WmVzTmNrOHVScWlScm0za3ps?=
 =?utf-8?B?TENHT1VDM1o1SFlMOGMrc1FSaGNRb0xNK0Q5dTRBamdSNGF1aEkyOWgxeElo?=
 =?utf-8?B?U3JlbGxyMmNBbmNFNFJ1NEEzMzY5bU9rTklSV2h3djU5RnZJdURnei9BQTdr?=
 =?utf-8?B?NU5wZjRyK3Y2YU1KY1o4QjV5UVhnZTQvbCtjNXBLYWJYbitrQmdIMHA5Q3h5?=
 =?utf-8?B?Yk5HZXBsSHdUejhKSGtiMzFqUzVDUllkZWYvQS9kRHBHNHMydlcySm1kUlc2?=
 =?utf-8?B?UkhFZytKMktTaGl2Wnp6bWpnVHg0anFzOUlXUm1ZNlNpaExCNjBuU24rL0hT?=
 =?utf-8?B?N1A1Zk1KTllyWWpZSWlFdTV1NTAwL1JILzloTzJJbWZsQlh2ZFNRVkpDb250?=
 =?utf-8?B?aVVpQVlVSzkzdUJiMmVBaE5pVHpxc0tSek1WNkFLNitoYUpIZ2JwRU9wcFZk?=
 =?utf-8?B?aUtNcWZ4ZTYwZTl5ZUZUYVpkZHg1L3JtallHKzVNUy9RL0lXalhTdmZCb1pw?=
 =?utf-8?B?UDZjSnI5SzNybldqVVNrK3pKMEwzb3duekZpNzBkQktSbm1xdW5xVFZwQjB4?=
 =?utf-8?B?anJlMDFuS0I3N1dZb3JpajJ5eC9NenZjeHpPU1VHZ1g0TW1CekovRC9xMFUz?=
 =?utf-8?B?Q1VPajdGN3RMek5JUmdjRmhZNXJDelRIVkJEd1U0RUJtWlFwK2IzcG1ocm1T?=
 =?utf-8?B?ZHBMamhWczBtYWpmSlJnSDROK0pBZG9BVzYyNUVGSXBwOEtHT2lKVjlyTHJk?=
 =?utf-8?B?eEpJVk12Z2s0Ykp5aUllQ2xOR2dpR2wrbjFBRXVHd2hyYkZ6UWFFZHdscHdq?=
 =?utf-8?B?d0NYaE1IOS9ESXVNK0dWOUtVSEtkTmxlWG44bmRsRkRsSUJRdTJ2aDZwNEdF?=
 =?utf-8?B?SlQrZWNzSjluY0N1NVp3YnIxcnE2aTN3cFBVeEs2VVVVaHJvMFgrS24xVXlY?=
 =?utf-8?B?bEpEQlZSQ3JmSFdpTmVNbWV6QTRhSjZodnJ0Um5hRkw4RmtsQW5CUmdpZlkx?=
 =?utf-8?B?NWJuQ3pKdjFieFF0Y1QxUEtKQjBUTURLV1FiL0JYMi9BNmloaUNzY0wrU0hX?=
 =?utf-8?B?RFpzMERiT3RzTkx1eEVQTzlkWUdyWG5GYXVBVnM3cWN1RThoS3E0L1B4Uisv?=
 =?utf-8?B?Z3Z2RUY5SkZ6UUtYdnlENEhrd0hDd3A1NXNXbGFYbWxMZytxVWkxNXpLL0x1?=
 =?utf-8?B?aE9NeC9WSHI5SHNIQkw2TmtKek9uMVpVamVjYmh5T3lrblFrKzRPYnAvUWpM?=
 =?utf-8?B?Y0Rxc3djUXR1QjIvTVVwUjl0THBpQk04RWU0TG1BcDlFWXZhWEVVT2xqNXQr?=
 =?utf-8?B?bStONm5LVnpaWDFRUmZiWjVkS3ZtejZnbzY2MjhIOUJWRk5tODdneStES0Y2?=
 =?utf-8?B?ZmZybHh3VTdSWTlVRlVraFhBelFVSU00b2hNa3JGa1pSVFNYY0MxK2VzN0Q5?=
 =?utf-8?B?SThFMEJHNFkxdkJ4OWtQdGJsV1RhQ0RwR0cvS1VMbk56ak5VSVYwa2g0YXo5?=
 =?utf-8?B?L2Jidmorb1pSVnpJZ3BkYUc3NldHZnd3L3hsajR0TWM4WjQzQkNQTFhlS3BZ?=
 =?utf-8?B?R1hvRFZNK0lhV1J5b2k0S0hmN0JlMHI2Y3dPTjJGaWFrSGZzNGt2dmRORjBx?=
 =?utf-8?Q?tCPKPjrcWgDy8qU07nBnXG03O?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f167b47-a735-44c7-5b8a-08ddc8074957
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 03:32:57.6945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: maynpR9ayZxBtv1sySn3kNdGmRnfsYF82eyiDC60kiiWsleBeULGWyeIHQfAVCGHhc3qkD4Se+QOFnCWiK+vwE/B3zVjrkkNfUsPKnL1imU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5262

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQoNCj4gPiBBZGQgUENJ
ZSBQRVJTVCMgZ3JvdXAgdG8gc3VwcG9ydCBmb3IgUENJZSBSQy4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEphY2t5IENob3UgPGphY2t5X2Nob3VAYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+
ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BpbmN0cmwvYXNwZWVkLGFzdDI2MDAtcGluY3Ry
bC55YW1sICAgICB8IDIgKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BpbmN0cmwvYXNwZWVkLGFzdDI2MDAtcGluY3RybC55YW0NCj4gPiBsDQo+ID4gYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybC9hc3BlZWQsYXN0MjYwMC1waW5j
dHJsLnlhbQ0KPiA+IGwgaW5kZXggODA5NzRjNDZmM2VmLi41ZDdmYmIxYzcyYjcgMTAwNjQ0DQo+
ID4gLS0tDQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybC9h
c3BlZWQsYXN0MjYwMC1waW5jdHJsLnlhbQ0KPiA+IGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybC9hc3BlZWQsYXN0MjYwMC1waW5jdHJsDQo+ID4g
KysrIC55YW1sDQo+ID4gQEAgLTI1NCw2ICsyNTQsNyBAQCBhZGRpdGlvbmFsUHJvcGVydGllczoN
Cj4gPiAgICAgICAgICAtIFdEVFJTVDINCj4gPiAgICAgICAgICAtIFdEVFJTVDMNCj4gPiAgICAg
ICAgICAtIFdEVFJTVDQNCj4gPiArICAgICAgICAtIFBDSUVSQzENCj4gDQo+IFdoYXQgZmVlZGJh
Y2sgQXNwZWVkIHJlY2VpdmVkIGFib3V0IG9yZGVyaW5nIGxpc3RzPyBNb3JlIHRoYW4gb25jZT8N
Cj4gDQoNClRoYW5rIHlvdSBmb3IgcG9pbnRpbmcgdGhpcyBvdXQuDQpXZSB3aWxsIHVwZGF0ZSB0
aGUgb3JkZXJpbmcgYWNjb3JkaW5nbHkgaW4gdGhlIG5leHQgcmV2aXNpb24gdG8ga2VlcCB0aGUg
bGlzdCBzb3J0ZWQuDQoNClRoYW5rcywNCkphY2t5DQoNCg==

