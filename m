Return-Path: <linux-pci+bounces-29336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E269AD3B74
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 16:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2623A9B52
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 14:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24051C862C;
	Tue, 10 Jun 2025 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="bWURJu6R"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020137.outbound.protection.outlook.com [52.101.69.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE56E227EBF;
	Tue, 10 Jun 2025 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566378; cv=fail; b=pV090iVZYx2SmjT4M8qNBd5VWi9bzZiFD9fHuixESuINj5Swjm21t6cvn+UDsy7Wik9jLAwy4q2yIXpIwmFDFxhdJSxiH3Ino5MDDSvg4EfUA2jkXois2pyoxze7DDE221K5tNUThHWm0+OUuJLxIzQxwxngSXomX2UasndyRgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566378; c=relaxed/simple;
	bh=vTztvcGcxW3+8ZoMAwlJhimURDlqavFWmFik5DZY5nc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=EssaibfTKdplQ90BJHNPP9xtqUv+LGbfJ7LUoZF7KYyRFt+FDSJQU7KKz8Hck4Ym0FtYRBfIXiPYH5LnxvZkWqGyLqcs/LjE8fTy1j/v6dhQH1QSMGS0l9oEgsdpyAzafN6wQ2Y+Zte1vRO+Z+uR1DQh5IKWHao4iK/WwPsTFtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=bWURJu6R; arc=fail smtp.client-ip=52.101.69.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTe/Vo+sgc9Npfae+wozD/r9ypD1nyiiiNZ//RJLasAVU+z/dDNumzTt3vNwZZ7cAZ1qSIDKMgIfniHTe3oLFu9yHlsXz7IrKoVMfBXKXBLPbKUqNnzHZcf3Sp0lV2H40VQLXLEicp4kU6/uUSXE4FmjsBPLgUM3VwRbe8K28oiNJwE10nG0XxF1TMiA60ff42HJk+xI2nACrv7Cvq6kXQSu9uWxjaDWGfhFikNXvGzCQR3dnLso9FF1vnX7wCuAxNNQRuGnf2HUmV0u/IwitkJipAAiQDhTBLKwmTfhOx2mcI+jTJtYXXDi90NxkxZ3rgCawr6FKkDXB3JzBF1BhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmEI6t6x71GoMQUgciKgwuIDYVccxDQHqhgiOAcWZuY=;
 b=edcDe+7ISCrqna5lTn89P4ncIV4dj6jcCXHWwsml2Mdlxjv0975i0AJnc3fUOyZOHUijau2bWS12AqkbUQo0M3WkQ9MUnkLfadj75hdqsb3r/ojDEkUw9WwVyTF9Uh+HWGWWDm+QMrIBVD9XUu4h1zOTpEFOxtT5bLlr3Mgs4yfpNCHJzaIG7r5rxBOo6LYRm4IBKr7iPqCGikveCI2GGVaoRgAX90oNEKpC7igkTTqwG+yuOin+q5JcHS0XNP6xVRWDcyjt4XDD6zJLF46k0FkvZdocoBdgiogduDM1Gtcz3UI03C/flGBs7SYjzYhcCYy4uLE5u8vRtf1I88lhSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=topic.nl; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmEI6t6x71GoMQUgciKgwuIDYVccxDQHqhgiOAcWZuY=;
 b=bWURJu6RpyhrRxudiZnGspOSWD+3Jt2QjtVfNuELmAMUSksC8fVFruCveATFC6aNwlV93WutoHUNK+aIxPlMEHWO+M6oI4kzQ+KTSMmJufl5YXZcdzdzQnBJGW1gxaX8kRUzNEA7ccyxC/RlNtKQmV0VmukhZgBtE+qDg580BEEh4L4VM40ZdQ7WulZ+iFYELp113MOO++r98HUo4KvK+IZEC1CyP8cjRblHTvFY47vBgJ/7vT8eL3e8Z/afttI+EeLz7UdTXWnHUZkwN7giyyoS51c+9jTSVJ6D33IBkvbVR4nxZdg0vyUNtRpqJuKMKjLlWwEhWkB4VMzdViEbrg==
Received: from AS4PR09CA0009.eurprd09.prod.outlook.com (2603:10a6:20b:5e0::12)
 by DBBPR04MB7897.eurprd04.prod.outlook.com (2603:10a6:10:1e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Tue, 10 Jun
 2025 14:39:30 +0000
Received: from AMS0EPF000001A6.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e0:cafe::fe) by AS4PR09CA0009.outlook.office365.com
 (2603:10a6:20b:5e0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.41 via Frontend Transport; Tue,
 10 Jun 2025 14:39:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AMS0EPF000001A6.mail.protection.outlook.com (10.167.16.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 14:39:30 +0000
Received: from DU2PR03CU002.outbound.protection.outlook.com (40.93.64.31) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 10 Jun 2025 14:39:29 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by VI1PR04MB9907.eurprd04.prod.outlook.com (2603:10a6:800:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 14:39:25 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 14:39:25 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-pci@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] PCI: xilinx: Wait for link-up status during initialization
Date: Tue, 10 Jun 2025 16:39:03 +0200
Message-ID: <20250610143919.393168-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0176.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::45) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|VI1PR04MB9907:EE_|AMS0EPF000001A6:EE_|DBBPR04MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: a758b62e-7a97-492c-24a5-08dda82c9bec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?68PtqnTKGopMntmxqTCUEeXAf8D23g9cO8C2jZ4gc0O3hGkKmcdhFcmma1ly?=
 =?us-ascii?Q?lyLSugGMWv0Eh/9da2coym4MkO4epYDEKEcURtQlgbdXtobhe5Z1cAuH10c1?=
 =?us-ascii?Q?xXTqrchXZePHIBh2oG889fzw6JhNLK4zzJXz5vKdmHNnBnUx1jwhrhwfs9Vy?=
 =?us-ascii?Q?pc2ZmLnTrFs28MGjE8or07zZG1fSO3FkJc4Nl5FuVtX9VRUbnodNuAXcy/dq?=
 =?us-ascii?Q?qCZhqBSCCzgf0/wVx2RpNyhRwbHYbJsMwGotBcklNsMup8GIxMo0A9ZGVkXo?=
 =?us-ascii?Q?518JV1/jFyVSSkUztvGZn3G3Af2WYzTOUHt6c2tQYG8phEU3dzvjfcz6soxf?=
 =?us-ascii?Q?B6OrvFin0VKPf3t8pJpxuvM5Ujb+wwElN5HES2wVUjq+Hwwg08mz9hDJpy2m?=
 =?us-ascii?Q?oi3mSazSThoq5wpAbEqnLtma+hmfIzV84AglmAfUIxzMcKOAvfdnLnsgszTf?=
 =?us-ascii?Q?2OjEeTlY2n2vZCf4aJVif5+Wt0IaBTK/jeFe3+3BP7IT1RhlvZ6fDNPX69yt?=
 =?us-ascii?Q?OrhMIu77lYkVJaIkMLDQj9cLSbQH6VK75v0e1uC/xG7H62mwTMkh4GrNhsjA?=
 =?us-ascii?Q?2NCmde7ZUhT9CKRFn7QZXSGTc27FEjYGY1a79JSf8Jt/FJa4ZcIt2Oc4zTPv?=
 =?us-ascii?Q?6PM+gPexsw3uSyJPzekvMJ5Vu0qxdrfDCPYLAgJUbb3hqOnwXvdDST9wCqay?=
 =?us-ascii?Q?GTYRwbIgyV0oXiWenaSfzC4o7idQSKIbvkJr0Zd7ZOhqbUqbuvEr7XJgPfDw?=
 =?us-ascii?Q?eDp6fGWdPQbITNMV/7tKeU6oLiwoyVjzTEtHuoZorSQAeNoC5F5hdoTgvQbM?=
 =?us-ascii?Q?b5SdEckCGjcGgvCMLIhb9bWvf8J2qlKVxuWtnnQkn1++7Cx0Jap0brOtgC8F?=
 =?us-ascii?Q?6S09yGcuWQb7lplbgschi7D7E2Mn12ALSd2akmIa3a5S71PD6W/WUf00myg9?=
 =?us-ascii?Q?Sa78dJk6XwF+dUUPOPk5RkQWEIcJosyFy7LPVLboqx2vVVIAxOmNx+MQafYS?=
 =?us-ascii?Q?LUu8ZoCKtGfUER3Z/ZO6WXiTOmiOUVoPQsHxe+h8Ydg51tIUGtnrzN72La9f?=
 =?us-ascii?Q?t2sLmymI48KpZzh+7ytJZ5WXLz8EmbF8HBMJaER4UH4JxGLLv5bktmONELGO?=
 =?us-ascii?Q?0d1GwGYISt0Oh1NZn98YSqvmM3KoLWyXkerz2LVkF7KqPGHkpIRUn9W/7+dy?=
 =?us-ascii?Q?6DG4p7IoATjIghuUtWjOLI5A8ewgjxNDedFm3VD3lvcAXmNPV3mzDfpOGnKL?=
 =?us-ascii?Q?Uv6pg0cWV9UiMPmskyH0Xjd2Q4imSY7PuBlpZ3fLIX7Bi6MZeffSqIwtva80?=
 =?us-ascii?Q?is1QThv8D6xQJGmh+KIcR2qB+I78tIZap5tkRW+ydodN/ekBNulxr91H7W71?=
 =?us-ascii?Q?6+iZrvNrbpA1hXSLzNHOgpeIolzhkZyantgEcJ+AlOOhAI4ZNPrvwvIkc7AO?=
 =?us-ascii?Q?ecg8mv/9Hd1zfVQm1yraEBy6bzcrL1bECAoN08zQrvgQ54GyrNoRZQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9907
X-CodeTwo-MessageID: b3643388-7ad1-44be-8ead-0e88bf6e2766.20250610143929@westeu12-emailsignatures-cloud.codetwo.com
References:
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.69fac8ab-ab7f-45b5-992e-b4c97ec31d85@emailsignatures365.codetwo.com>
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	43e82132-e898-4e3a-acc6-08dda82c98bf
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|14060799003|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FBpFtAYbhvLdKwpJ+wiegepgyDYBw83LkirCDoXFgty9Bad4VPY7RwPUet+T?=
 =?us-ascii?Q?CBm5UhkP8ZLaBp3qx/LIfThcpJrCH0TpRedZ8ZloPNG5esZN8zBaRSI8+MrC?=
 =?us-ascii?Q?NIASXLAGLdq6IiTouTRuTEkOEiSdjs/zcqBYfDle1nj3E6Av6Plkm8h+bjwT?=
 =?us-ascii?Q?0raJvnoUMZZ8ekSEiH5eDvkI3tF46jzSZ/BKdVkE25iLzfUbJHnO95MDMA1L?=
 =?us-ascii?Q?cwPKeJAp2syxumUJR6vEzJX6uqmI6+wHpufHi5HGnzbLG+c3nvpf6D+F7AYO?=
 =?us-ascii?Q?kyUe/uc/6N5wvzVCsLIOORl/GwBzpNETYrKiaA7q+dqXwKe93coURrpe2oh8?=
 =?us-ascii?Q?AGfrX2fFM9cAYuRofTef4cEvag63jD+nr/jOqdSpOT4Mh9HTJKsdt/SiUqEk?=
 =?us-ascii?Q?jEDIcVT36yXMTaSTEB95g+eV6ksJm8O73Ppu5kCK/GZcddxqIWoqbmcpYFqt?=
 =?us-ascii?Q?mQ7viFeyWUf27DyWhfPNDGZVDIXyjMtvy2A10ygRXP4eYsxj0tKIbBj8Zi0W?=
 =?us-ascii?Q?XKzv8JFl7MqecvWbeae9iTt7WfUf154+xjvsr5M0KCos/Gz/Q8+za/c795C/?=
 =?us-ascii?Q?HS6ycdvJQS0xkR3mXdJkPqzttHZ5e2CDaytchfgyNh4ZMM7QuS3S2Mzgd4wF?=
 =?us-ascii?Q?iixPo2k/fTM50N9jL4pFUZC6ZdzvLt2DGcPVZLim8BQRCOjEORN1P8UkwgM9?=
 =?us-ascii?Q?h+ojFRwa8XIkZO/Is6nekDXg4lEcJrQT9LsI0vNAEvoTbh/iTRQ1g7qq/UfZ?=
 =?us-ascii?Q?Y2T8ob2yHXim8MMUz2q80qu00ijx/18KPZ+gNtUWVbEpZFUG8Om7KixgG11a?=
 =?us-ascii?Q?vlu+0QOwJPvZ2mHVaQwCOSEiJ494Re3XcXNsQfJzKuLVQrMGIw3zET83SXQG?=
 =?us-ascii?Q?RwgfuWnKebqvC8L+/SBZ2QAN34TWZqVMwm/EV8LApsC3CeVjnrPKz5CFB4jL?=
 =?us-ascii?Q?6C93zLvN9pA49WPCvMPIPjrtQ042Km8NtxfHIQHh35lDZTJh3pGh2zHat4+B?=
 =?us-ascii?Q?ETvCQQS6GH8jCkeGpx91lSRisowO5blzv9V4q0gJLIBnb435/WbVAKciBv2n?=
 =?us-ascii?Q?OwweDKjrOmN1iNKUhZWcW0WF6U7bIcbsdllz3G3EKNYnLPbpA3PbsQx/+SyW?=
 =?us-ascii?Q?d358otmnhNbdHjKG0F4Mcr5gDvkPwG80lVsVdlEbl4kJczou7LJtDzWDh9Lq?=
 =?us-ascii?Q?72fDK76FaCzl124PfEqDlEDY93TO6lfIktCLcC5CB4wlpwJyfVs0gWP+Xj2W?=
 =?us-ascii?Q?yKRW5Okonc0XnGpx+pNEroOro5z+k0AnKNc3//YmrkVTSsrCQ8WaDIfy3Ql/?=
 =?us-ascii?Q?uMUxEsupVRjrS7/KAepA0/F5mXDW20j23sBa+4yNgDzaW/TbY1nf8y85Wdv0?=
 =?us-ascii?Q?q/rCeujaHX1oKJaWAYAuTaHQod7zX23HMsdput6w16gdDpKvogdLkyJ9IWyp?=
 =?us-ascii?Q?hTeqzYGKW64tWFYs81jFlsNAt8CdiATbjKD3I2wk2Npq5jHqc3ybEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(14060799003)(35042699022)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 14:39:30.4069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a758b62e-7a97-492c-24a5-08dda82c9bec
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7897

When the driver loads, the transceiver and endpoint may still be setting
up a link. Wait for that to complete before continuing. This fixes that
the PCIe core does not work when loading the PL bitstream from
userspace. Existing reference designs worked because the endpoint and
PL were initialized by a bootloader. If the endpoint power and/or reset
is supplied by the kernel, or if the PL is programmed from within the
kernel, the link won't be up yet and the driver just has to wait for
link training to finish.

As the PCIe spec allows up to 100 ms time to establish a link, we'll
allow up to 200ms before giving up.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

Changes in v4:
Adapt patch description to "PCI: xilinx:" format
Explain the initialization order issue better
Use PCIE_T_RRS_READY_MS instead of 100ms

Changes in v2:
Split into "reset GPIO" and "wait for link" patches
Add timeout explanation

 drivers/pci/controller/pcie-xilinx.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/=
pcie-xilinx.c
index e36aa874bae9..e8a07535539e 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -15,6 +15,7 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/iopoll.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -126,6 +127,19 @@ static inline bool xilinx_pcie_link_up(struct xilinx_p=
cie *pcie)
 		XILINX_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
 }
=20
+static int xilinx_pci_wait_link_up(struct xilinx_pcie *pcie)
+{
+	u32 val;
+
+	/*
+	 * PCIe r6.0, sec 6.6.1 provides 100ms timeout. Since this is FPGA
+	 * fabric, we're more lenient and allow 200 ms for link training.
+	 */
+	return readl_poll_timeout(pcie->reg_base + XILINX_PCIE_REG_PSCR, val,
+			(val & XILINX_PCIE_REG_PSCR_LNKUP), 2 * USEC_PER_MSEC,
+			2 * PCIE_T_RRS_READY_MS * USEC_PER_MSEC);
+}
+
 /**
  * xilinx_pcie_clear_err_interrupts - Clear Error Interrupts
  * @pcie: PCIe port information
@@ -492,7 +506,7 @@ static void xilinx_pcie_init_port(struct xilinx_pcie *p=
cie)
 {
 	struct device *dev =3D pcie->dev;
=20
-	if (xilinx_pcie_link_up(pcie))
+	if (!xilinx_pci_wait_link_up(pcie))
 		dev_info(dev, "PCIe Link is UP\n");
 	else
 		dev_info(dev, "PCIe Link is DOWN\n");
--=20
2.43.0

base-commit: f09079bd04a924c72d555cd97942d5f8d7eca98c
branch: linux-master-pci-reset

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

