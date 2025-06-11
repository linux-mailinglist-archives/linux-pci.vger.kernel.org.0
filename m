Return-Path: <linux-pci+bounces-29399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B23AD4C3A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 09:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2A317D11B
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 07:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E575C17736;
	Wed, 11 Jun 2025 07:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="LQkvHLDJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11022085.outbound.protection.outlook.com [52.101.71.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66CB801;
	Wed, 11 Jun 2025 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749625253; cv=fail; b=eZ00QSnoXJeqhRkB+Zri/6VwoD5FGDa2m1TDCD88jGdYR0IgT/2QQ+tf8/8DN2a59+cXzn/DlaR8PLRhJPTKZxfaaUtAmBF/pySOyyKa5ND1BNz0K0jRYNK7SgAZ2PnX/hk7aOpF5oG8ojDm5E5a1f0gDNRZ+PS7dtdLFxfASVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749625253; c=relaxed/simple;
	bh=Vk43n2RFYfJBAI2eqcvXXBgd7O4D6dIOZgbAOHzUU38=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=anhb+Eq7N3XyPRI3p/7NVNGk0RKLHIZO2dKokoyjDegxw887yynWtSLPCWZyj3UYr2Zf8JCiH3r1SwWQWhAqGtK3z4D7s8HEGLeMS19BXf4sIZLrRsKXOZ6z3ClfpdfedQCfBtSWDkUsnMF6rEJUoEcL78bnVNjM26ZipkUWMYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=LQkvHLDJ; arc=fail smtp.client-ip=52.101.71.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4KPjuBL17HeOQrAB1hC4c6oVZETv9CrIRXKyJtauCXxpi52hXVqvDqHcHlFSErSlzZNOGCr3caj37cikT5H7xygxNT2HZZqxBT/qTzh/u52f4ji2K8/Oe+sXcPl6GkpA1e6+YrawNKDJxu6OXkl4kkfOhnoCzQO9ooXsrpBRhqUstXuWAH6IEGvGlsGgyPWej2dlWTcKUhNSRa0fcm0oL2rMZM/NNdw1mBk/gey67bDXa2zPKTtVBZWyWQyR637y6udJYo8m198YavY0Jht9WF5RrpOu4vAMga85Aglic7xEpXnMIHx0jdmBS+9E0de2+HCGW73mACzkeeA7IKLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ppcruv/xw+0i7GED1M1YEYah2ZP9QchemAX6mbJxWgE=;
 b=gyoZoBlO4MSsT0KyUStxnfRjYEYUeH6YCKWWluh+EI+ak8VwFYIz43i2dT1jIYZh01PmEphuzhlBpwk4eTE5VZyKGBYJjCUUwVGjvx2l0r5Aa37zlXnk+076j1Dh4suc79/kutEg+bWcMAtfgQVM4rB/V5TCVBAHbaKxVpDLBiA7xv592ywW6gqZJv0/BEB9Q1qoL1+EI2ywmM21uYumR1eITtXMpPTr+7ZVMZ9BlkdLLUEduPLDrr4GQG5w/ex9hV4NG+FskccbTpRYuAk4ChSBQaXpautXtipfG53yL4SGYTxEs+203keTCpuvwENM8B1/FGQeS9lLpyTVcvjfHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=kernel.org smtp.mailfrom=topic.nl; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ppcruv/xw+0i7GED1M1YEYah2ZP9QchemAX6mbJxWgE=;
 b=LQkvHLDJVzy9l7oE2zCqe1HZU24WgQVor6e5xqerQPOj4PYSCHBDHfEWKeaYxZOyGafR2lOKdA0yku5D0Pc/+oDrSYmfpkgp5v67e5I/RTADnr5QKmLGYDTHo7p5pxMya6SCu29sQj+bgzoyd6l3ggun3pJIuqyPu2DO9/SijyQ/IGKSqS+58ePHNWvwYGfDFrJvyUpj+xdhae/FcoCo7FzGh7QMjQzha6Eh0e9buhi9baxkr34pWRVTlGkyfGwBivYkdQqzIeuiR6T2Uk7TteiL/ok9f8s2ZgRXVtxN8cd8zXTOJ56Q1brKU5DjCuua1oEFYC7xgJXvet5WMpbhbg==
Received: from AS4P250CA0018.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::13)
 by PA1PR04MB11359.eurprd04.prod.outlook.com (2603:10a6:102:4f0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 07:00:48 +0000
Received: from AM2PEPF0001C70B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::2e) by AS4P250CA0018.outlook.office365.com
 (2603:10a6:20b:5e3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Wed,
 11 Jun 2025 07:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AM2PEPF0001C70B.mail.protection.outlook.com (10.167.16.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 07:00:48 +0000
Received: from OSPPR02CU001.outbound.protection.outlook.com (40.93.81.75) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 11 Jun 2025 07:00:47 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AM0PR04MB7012.eurprd04.prod.outlook.com (2603:10a6:208:19e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 07:00:45 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 07:00:45 +0000
Message-ID: <cc018fc6-eef4-48b8-a754-f1e5fbce5eab@topic.nl>
Date: Wed, 11 Jun 2025 09:00:44 +0200
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v4 1/2] PCI: xilinx: Wait for link-up status during
 initialization
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Michal Simek
 <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250610191253.GA820218@bhelgaas>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.a0aaecdd-5ffd-4e72-931e-6d8ce7045f3a@emailsignatures365.codetwo.com>
Content-Language: nl, en-US
Organization: TOPIC
In-Reply-To: <20250610191253.GA820218@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::18) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AM0PR04MB7012:EE_|AM2PEPF0001C70B:EE_|PA1PR04MB11359:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a81af6-3976-4ae2-f18f-08dda8b5b205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?L2I5bERWNDJ5bUZBeVRJZ3hPV1FQbVpzY1NqVDAzalp2TVBqbDA4aXFJTzNO?=
 =?utf-8?B?YU5yUUZ6V3ZBU2VPd0xzWGdjR2lpdTN2ek1nL08vNVo5VTRkQjZUMHFjbjBj?=
 =?utf-8?B?Q3dBODNOYWF2dkkyU0NrMWFrc1AySHcyUWsyRXE2MTVQbzdqRnVkTldLcCtj?=
 =?utf-8?B?amNzVEVMMnJ4WTJxSEpZOXdiZVZPRC85c0Voc3pybUl3Uytua1dhdUpmNkdX?=
 =?utf-8?B?c0NuUnFoOUUyU3pweTEydG1qekVFVDBJcGdJSW0wNm55eWU5MzF4NzRmYXlq?=
 =?utf-8?B?Z1U3UDNZWEtlMFpyZGNXdEZ3dDBrc0VBMTQ0QjdTRnlEQm9UMHg1TFJseXI1?=
 =?utf-8?B?VFlpWXZwNGtaS04vZGRIQjBiZzNuMDFmYjNWWnhnb0FPdFdFaDdGVDRUM1Za?=
 =?utf-8?B?WFZRYi9GK2lZcjZhTmY2YjRkMklsb3NHb0MyVFZSOG5tclBXWmNjVEtqQnVr?=
 =?utf-8?B?ZC9MQUVGUjB6c3k2WmNWRUNCQktPNFkyQXVrL09IR0l0NG1xbFZwVVFXcm80?=
 =?utf-8?B?WFBQNWZpNkFSY2psd1VRR0pibTNJSENZY3MxekNjVTJXZ0Y3a1pOME5OT252?=
 =?utf-8?B?VUJuZExUdFJteVFRdDExd1BPNTZUWmRTQzRjOURpZTRXQ1M2cmV6V1EvZ21U?=
 =?utf-8?B?UmJlczZlekhtbDdUZVZPbVhWUkFsNThudlFQMHdlaWZuUS8vd01GN3JuUUds?=
 =?utf-8?B?Z21XMU5jL1ZGd3QwRENhVnZadHVGMTJ5RndXZ0VibmFXcDJlZlFMUUdKZDRS?=
 =?utf-8?B?UTFnVDYySzBQQ3luQjlMNWptdW5JUkFRMk9uSVk2MkdHUElPVk5PYitCbzJF?=
 =?utf-8?B?OE1kbGFhZFlmRXpGSjZwRG9aMm9VUC9Jbm43RWNMVzlmVEdiaUE1VGFHK240?=
 =?utf-8?B?cXBkTjB4ZFlhclBkaUJwazJUZVpKeUlTWmljTk9nZGRiYlRDSjdJeFY1R1NE?=
 =?utf-8?B?OGdZdWg0NlM5MUtGNktYa2VuRDQ0STJaelM0TDFaQmtjcEpVOW9vQ1FXUzFK?=
 =?utf-8?B?SjVCN0c2L2dEaEg0SUhDSlpxNzlaREFvckZSMW54SWVXM05OYW9mZlRobVR1?=
 =?utf-8?B?Vk5ycExXTk5GbGpKTk02STdpMXdXUkVlbWg4aUV5dVVaa1JqLzdSbXZxTWox?=
 =?utf-8?B?Z2k0RWloTnMvc3dUVWQ1ZDZoVWVzOGRGdHJpTGRZeDgvK2xDYzJseUNLK3Uw?=
 =?utf-8?B?QWVXQ0pnOUdhK3BPeEwwS3pBTm0rYS8rWDJsN092SWJzS2lqSWQ3aThJWjRL?=
 =?utf-8?B?M1J2ZmJkZE1lY0FzZG1sY052Q09PZVBsSjZCM0lVOGxhcGVtbkVZVnUreHZQ?=
 =?utf-8?B?LzZscDYrV2NnOWQwaGdOWU5lTVFqcjRDOWptcEdSMW9KbGcrd3V5YXVGdCtH?=
 =?utf-8?B?WldycURaWFBqZzQ2eHlxY01EY3UvNkV3RGk1R0xZVW9ZdFA1T3hNd1BweDlp?=
 =?utf-8?B?TE5rQnJSbUUzQ0JOSlZjYVozQ3ZSZmRpck80bzkrQUZYbVFoaVNYQTdCZ0kx?=
 =?utf-8?B?SzFQRld0Slk2UmFSNlBVeUM0UXBuS2p0V0lGbHZobEhoR0ZlOHNCTFBaZCtp?=
 =?utf-8?B?RDR4TGZ4Y2NHWTVXREt4NFdidlNKZFRuMGYzR1VMY3JuL3dJTGRiVU9SVVJH?=
 =?utf-8?B?K0x0RTVkQ2dlaXpNSEowQWt5aVRzQ01uM1d1dlBQSW52YUpwc0RUdFIxdTlI?=
 =?utf-8?B?MUs3N0UxekcyYTdLZFBsd01kMWFGL1dTVERNQWpiaEdkUlYzZk9yQXlrTHZz?=
 =?utf-8?B?ZFdiSm9YQTBKcThTcndTajZaT3hlbDZUNUdhS3c5WFdWY1ZhaFR1ZGorNWg1?=
 =?utf-8?B?T3hHd0hPSVl4a29FNDIxak5rYmozUmg4bisxdVJtNzF4V3ZvbVVlelJFdFpQ?=
 =?utf-8?B?RXdiNFB3VjBQN1ZnNE5PQllIWkQxY3Z4bXN1MmQ1NDdWN21Za09TckY0aWhS?=
 =?utf-8?Q?pRAWU+sJimc=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7012
X-CodeTwo-MessageID: 3b606f82-913e-4083-b34e-20cf19f0936b.20250611070047@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0ee09ee2-a965-4e2d-4a45-08dda8b5afcf
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|14060799003|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHNnVmFaVnBSa21xRmpFRzRtU05EckV4YytNNE9xd0NzR2VnRzJoYmpWbjNL?=
 =?utf-8?B?RDhhVWRvVnpPei9USlFQdkNRRkIrV3VncEZGRTBBT0lBNDhwbzFqMFN4TTNi?=
 =?utf-8?B?eDVaT0VQY3k2L0UvZUhNeEk0eTVCSWorK0M1YXk5ZmkyMnY4RjVER2lMN3Z3?=
 =?utf-8?B?RGFHQytPVUVObHYzZGxnUVBnR0FBcWVKcFgxWExpeFh4MndsdEtiV3Q3NFVC?=
 =?utf-8?B?SzNKNEpTNmg5dkU4c2tPaU5hakJBSEUxY2VaSE42SzladkR4TTVDdUxHYW81?=
 =?utf-8?B?ZDNNZkZIalJLWnljZmVrbjZwQ25UYVZJRGdDMmw3TTZvR3J0alQ4dU1ydG1I?=
 =?utf-8?B?OFU0ZGJBYnRsV0ovWmtYTVJuZy9icllReGdqN1dKb3hrVmNxbkxqMWszUkZ1?=
 =?utf-8?B?TFdnd0FIc2FwMWVrTUp4MEwwNUJ2Ny9QdW43MG54TFlGMjJBT3JrWU1BMG1P?=
 =?utf-8?B?UDN0WE1Vd2ZDRlV4L3pIZ3FnejVIS09wWk9MMXdvZlFrUUY2TlFDcjNmWGxs?=
 =?utf-8?B?RnV0S2RMNnlmTjRrVy8rei94SzBta1psQ3VPeUc0SmtVM0FRckh0VjhzdGFn?=
 =?utf-8?B?cXpPdkZIWGM2YnZiNkgrdjlZcXJ4KzBTWHBrTU1neEJRZVdPTC9vTmJlV2xa?=
 =?utf-8?B?QTcrSEdZYkZiZlcvbk10ZUxJejJRVUYrMkRJeGs3Qm4wdTF3ZldzVFQ2cXB3?=
 =?utf-8?B?K1FiRmMzOFdTa3hJa2ZxQkoyd1dWK2ZIKytLNGZ5RGJnMU9Kd3R5WnJzUXA0?=
 =?utf-8?B?WjN5SWQ5eWVMN1BRU2lrc01wQ0hsMUJQd1gyMzduYmFUODZvZlhjcHd4VU9p?=
 =?utf-8?B?T3ZkdC9XUGI0MlROTG1nK1cxdERQam5Mc2N0alU5cWw0SFM1OTBNMXpBQXBI?=
 =?utf-8?B?czB0b3dkQ1dCaWc4NWFtQ3pvUHJnUmpJMjVoUVdHVjNlSFhaaHVUK2dTSjA3?=
 =?utf-8?B?aDBrMStva0swTE9NUENmMTVUZ0ZWL1l6dUFYZ1ExYlhJTFVGQ1k4QjlTUUta?=
 =?utf-8?B?eHhrTFIzVm16M2NWZ3BRTEFIK3ZacjE2ZE5vWEVtTTYrY1hRckhiZzV1N0I4?=
 =?utf-8?B?YVFpb01pOFdYb0dla292Qjc5SmdGSERMS0hiWU0zMWJsZE9vVzNGaGJHZ1o1?=
 =?utf-8?B?VUdzSzByTlZUU0xhM21OQnZtSXdBelB3cjM5OGt2NlZzd0w3aUIyazV0akxT?=
 =?utf-8?B?YlJHcDFpMFNURzQ1TFUxbVBIelBncExwSGhITzB0UXp2MGMrWllpakg3UFhm?=
 =?utf-8?B?UTV5TnNaM1ZsMW05UmZWdHZTTzFROXc1U002YkNBQXZwamVhcCtyQUYzYVdI?=
 =?utf-8?B?RU5qMXNzbnNOUklPRWtHOWdUTjJvQmhqMnN0ZERXNWR1OGxLR0FWcjZ2c3M4?=
 =?utf-8?B?dmhjYW9ONjh3Z2VNZENQNDdSZ0FDV2FOQjJKZFpWUVRQcGdXVU1YNWhqZzYx?=
 =?utf-8?B?Z1EwcGRFUEVIRDh4djUxdnlnWXpNMXd6SHVUZFRlSC9sbEJoalpyZWduR0dN?=
 =?utf-8?B?SE03SFMxVUhmZlJTeGVDc2pJZHF0RG5FaFk4OGp0U0lZbFgzWkp0di8zYzdH?=
 =?utf-8?B?aFFla0t1SGxGRzlYdmUvaU5kVDJIYWpHYTN4NFRicHBJbllLaldmRVM5b0lk?=
 =?utf-8?B?SXU5cDlYaXNWVEVobTE2a1hENUNYaWlqZHdMMGU5dWJyZmF2RHJ0UFQ3ZkFh?=
 =?utf-8?B?a3VVeXQ2NGRuUnoxdGhhN3YzOHVCQ1J6OFlRSnJFd0Fvd1c0amZyU3laWHNi?=
 =?utf-8?B?S0RrOVpTbFhpWXJSWCtUZWpKU2wyRTlZbW9qVDdJRUVsMEs1ZWE2blRQTVRM?=
 =?utf-8?B?RkRJRHlxN2FEenpRU0RDT1ViMXphQ2RCRThjNEV3dHppNzVHN01uYUZHb1BJ?=
 =?utf-8?B?MDNzYXBtWmtrVDhJa0pxZFlnb3M2WnFxa3I2cndLeG9lWkRzblJtMGVBNXVq?=
 =?utf-8?B?Ui9kZUFzT3MvVkR5NXNZZzFUZHJIb01UamR1N3h0TEhoeDEyVHVNVHg5bFpT?=
 =?utf-8?B?ZmJFYlkza09RPT0=?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(14060799003)(35042699022);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 07:00:48.5361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a81af6-3976-4ae2-f18f-08dda8b5b205
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11359


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 10-06-2025 21:12, Bjorn Helgaas wrote:
> On Tue, Jun 10, 2025 at 04:39:03PM +0200, Mike Looijmans wrote:
>> When the driver loads, the transceiver and endpoint may still be setting
>> up a link. Wait for that to complete before continuing. This fixes that
>> the PCIe core does not work when loading the PL bitstream from
>> userspace. Existing reference designs worked because the endpoint and
>> PL were initialized by a bootloader. If the endpoint power and/or reset
>> is supplied by the kernel, or if the PL is programmed from within the
>> kernel, the link won't be up yet and the driver just has to wait for
>> link training to finish.
>> +static int xilinx_pci_wait_link_up(struct xilinx_pcie *pcie)
>> +{
>> +	u32 val;
>> +
>> +	/*
>> +	 * PCIe r6.0, sec 6.6.1 provides 100ms timeout. Since this is FPGA
>> +	 * fabric, we're more lenient and allow 200 ms for link training.
> Does this FPGA fabric refer to the Root Port or to the Endpoint?  We
> should know whether this issue is common to all xilinx Root Ports or
> specific to certain Endpoints.

The FPGA is root point. The endpoint is usually some generic PCIe device li=
ke=20
an NVME or Wifi card.


> I assume that even if we wait for the link to come up and then wait
> PCIE_T_RRS_READY_MS before sending config requests, this Endpoint is
> still not ready to return an RRS response?  I'm looking at this text
> from sec 6.6.1:

My initial finding was that usually the endpoint would be ready well within=
 100ms.

The issue at hand here is that Xilinx assumed that their proprietary=20
bootloader would have taken care of power, reset and clock signals and=20
programming the FPGA. Thus, when this driver probes, seconds later, it woul=
d=20
already be in a "link up" state.

In our system, reset, clock and power are under kernel control, so the=20
endpoint (e.g. NVME) has just been powered-up, and the root complex (in the=
=20
FPGA) also got powered up just a millisecond ago. So it would always report=
 a=20
"link down" at startup and give up.

Analysis showed that the PCIe root was just still training the link, and al=
l=20
that's required to make the system work is to wait for the link to be estab=
lished.


>    Unless Readiness Notifications mechanisms are used, the Root Complex
>    and/or system software must allow at least 1.0 s following exit from
>    a Conventional Reset of a device, before determining that the device
>    is broken if it fails to return a Successful Completion status for a
>    valid Configuration Request. This period is independent of how
>    quickly Link training completes.
>
>    Note: This delay is analogous to the Trhfa parameter specified for
>    PCI/PCI-X, and is intended to allow an adequate amount of time for
>    devices which require self initialization.
>
> It seems like the PCI core RRS handling should already account for
> this 1.0 s period.
>
>> +	 */
>> +	return readl_poll_timeout(pcie->reg_base + XILINX_PCIE_REG_PSCR, val,
>> +			(val & XILINX_PCIE_REG_PSCR_LNKUP), 2 * USEC_PER_MSEC,
>> +			2 * PCIE_T_RRS_READY_MS * USEC_PER_MSEC);
>> +}



