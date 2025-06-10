Return-Path: <linux-pci+bounces-29335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0B2AD3B77
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 16:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3D81715F8
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 14:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEEB227EBD;
	Tue, 10 Jun 2025 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="p0qgoouR"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021084.outbound.protection.outlook.com [52.101.70.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1606228C9D;
	Tue, 10 Jun 2025 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566377; cv=fail; b=kGkQTRhM2qGM+fEwFJrkl4HmiqFxlVDvS04tUJ/B6q9XY5D3pgey3xDOOJlLSAXhSgujf5V1v7Gkp0JWtc0HYOAU1+31jL8FlodFos1E1hgJg3D/VJzaB5oUkYdJG1/RQQzkWcuM0CJMFl9Vf3tgfz2hUFnARiAL8zN3ahFiQ/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566377; c=relaxed/simple;
	bh=uV0G9E9OsGBILQGRNJX+iVYEfd0BqWnKsTQBzmWW1zE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ukoCrfQNX1IGfog423kCaoCCFQmidWeMsF96I8K28drgVnX4QO/tt9IcQ43L74a/xUe+s/cRczvTJPJAHd7EOicEOt7uPy1lW4rp+yJEmJ6oxsR8KQ2PDkiN6Tmpe/LrDC+inBZmA5fE1Qs9HMiMkzO92/M3DXSKQlzH1WxcKn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=p0qgoouR; arc=fail smtp.client-ip=52.101.70.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atXs4Hmq7UhxBnyTe7rehkONzl3gygUAIxBjn1oTVwp6ibrMi/0oWOzMaBg6+qp2//HREaSM+u0BiXQIP0w9o9S/cNKKk2jTm8wCngkWZpDG+6yy+pL59vXpf8tkyLajIReQTGvsQA4p5OygzwS7UE5Mudyyg0Iww+nd8zLV1q/nMTW+mwLgEef7BRwf7Db1k3EZPR4MJezdIqq+GyCAk30L4nqFAM2amHWc2RqLaVsmQ4Z+elqTFLG7Z9Nx5R4vsu8Orl3JyzDKuz6iEwC9nqKW8m46qtvi28BLsojmaQ0RneBRyqGGg7jHDEshEIZPlEuKIwgVqF6i4vj6c2WL8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7jRXDbWKLTMjD8eyA53xKAHo8f9L1JvfJtEiOHkor8=;
 b=hjYhxXtpqmL3Icr672/HKNH8GHlCuMCqdyh0chKtpQF2s/3DPxnvbRIsfutu0ibaZREY8Xiofev+0fbMVnkUxC3avifsQPBdm+nn+7VbYn1TtVA1Bpem/jvHpJu0YRVfIL6i05Ovx5Lrmk6qWI83bo7ywdI5saFADStEQIkQlY+2eddSQH3ihRW8IZA5dAtZLYIoEzym5sL01H/0tBFYipDSqeuxDoXpPvKR+whRmtPpK6v4mhVW6HMy9DKoflE4WPnTxUKwI2Ja2nZGxDtvO7OJjeE4NBo5ECUJsKtF3lHuj2gOGRSprcGrczmRUBFcfdqBEb2nIth5wRYROiPhYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=topic.nl; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7jRXDbWKLTMjD8eyA53xKAHo8f9L1JvfJtEiOHkor8=;
 b=p0qgoouRmXfrdLn4zE3n+x/v8b2V9N3t+Hw3j24q/y12b1vf4Io3xJ7HFk8ajngDaojW80r2Hd4FXaba7t07n/wW9jvcNnOl7oPVQ8XRzKm7udgR/l4h7e5ImdDre/+RpN8lJcaPygqE+qftIzGmlFnEdGnsAxgqcj7XPnFLj/ktPSKLC1tNWyYrHVIM5qbu7NV8cORuUUZOrtDUYB88yHa5rY+Ntmhfv8wsnkgRovUtdiVDPUHlOvzdQXdDy378aUVvKTPzcw0uejb93pwlv4Pio641YTUOk3bdeDFrOjveQTLtgflwAvlMeatiNVkvEBkHtBN76iBqleHgiz3hCQ==
Received: from AM0PR04CA0078.eurprd04.prod.outlook.com (2603:10a6:208:be::19)
 by PA1PR04MB11383.eurprd04.prod.outlook.com (2603:10a6:102:4f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Tue, 10 Jun
 2025 14:39:31 +0000
Received: from AM1PEPF000252DB.eurprd07.prod.outlook.com
 (2603:10a6:208:be:cafe::81) by AM0PR04CA0078.outlook.office365.com
 (2603:10a6:208:be::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 14:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AM1PEPF000252DB.mail.protection.outlook.com (10.167.16.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 14:39:31 +0000
Received: from DU2PR03CU002.outbound.protection.outlook.com (40.93.64.31) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 10 Jun 2025 14:39:30 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by VI1PR04MB9907.eurprd04.prod.outlook.com (2603:10a6:800:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 14:39:26 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 14:39:26 +0000
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
Subject: [PATCH v4 2/2] PCI: xilinx: Support reset GPIO for PERST#
Date: Tue, 10 Jun 2025 16:39:04 +0200
Message-ID: <20250610143919.393168-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610143919.393168-1-mike.looijmans@topic.nl>
References: <20250610143919.393168-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.b77534c3-fdad-41b2-aedc-9cfdab99101e@emailsignatures365.codetwo.com>
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
	AS8PR04MB8644:EE_|VI1PR04MB9907:EE_|AM1PEPF000252DB:EE_|PA1PR04MB11383:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a497a5f-6ed2-4d9a-dad0-08dda82c9c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?+H3Vs4c3JvJTkokHkJ9UgFbhAr4+SBliS80qrbpGYOx83G6mFwTTr/ZiPaNB?=
 =?us-ascii?Q?zH790BgfufiST2bBMd0KDwiml6oWe/cW4YP4L99ocNQXUEhXswnKluq4hZIw?=
 =?us-ascii?Q?YZDK3a0i53oEyr+4Hyas3aEe+aZ4BogcsTsYymVSzm3yTg5Rt9cxtyM54DDu?=
 =?us-ascii?Q?BZ2ZwJF4xk8OvCDzsijXIqhKECIewLBp59eJ5QHRVX5QvPGL749nxnugzBPl?=
 =?us-ascii?Q?N/L5nSBFTje4q3na3Rds4hiwhS52R26mfAi4httZSRKxNuhJG4NQGTF7H/l8?=
 =?us-ascii?Q?guTWpUQrDnUAqxhNHvNMAPDSbZjo+sLnFxr5kKg8aMLLJqhpD3SCizXXdf/h?=
 =?us-ascii?Q?4d8HfLoxWevewGnpOasOIJYInmBrGWWniVnsLQRfWxpDG+KJBA6P//Wp4yYG?=
 =?us-ascii?Q?CJdTnFqxjZG/2j59vByflhUgekYXNnritKB/xUW5uFN23vs6WuVGeius7ELz?=
 =?us-ascii?Q?gL4m8/jQCDWRqCXJB+aolphNOv4oEYIWzcGagjvsYGF8kHDnwxg35DBwwD8t?=
 =?us-ascii?Q?vXGhV0zzUSSJNReKVsvTwVGlooMfrp2ZbMkESfJu7NrVYLjlRQJwF0tiOAW+?=
 =?us-ascii?Q?H11eIsf+bHskKg7kpcMclcndJpiMqjFTHqHoviD5TnDb1GgSnhK0zSjW0I0O?=
 =?us-ascii?Q?ppgQEt7oSWptVeJj1FeEdV0zSj4Wuq+qB+lBWUoHLXLhaJNxpnmepFck7ngU?=
 =?us-ascii?Q?LO6D7C9erhcQ29jwwo2dKr+4OwfJJJErdNvaTkYHfAAAq/rHoywVlw+9KQ3K?=
 =?us-ascii?Q?H36GRCS3yVbQ85JvSsZdkkreSmCp6z0L13DY5r6J3hSMxvw14SDG3/uiwqRi?=
 =?us-ascii?Q?9/spzeCZ7McUM4xXuBv0hiu2u31RZtRuBGIsZYHPas851U5zPTSlf2dmBYhY?=
 =?us-ascii?Q?JRb6gC74RS/6NGb7yWoUFK+SLWFX/IJYcbdM8JbvgXdKzr+Og+y9Y4DhsE/1?=
 =?us-ascii?Q?cSiF3Ei5ifC2hRdyr+VIa5+P9MXrk0baEMIfogdyX5P+1vojr0773HYBnSDE?=
 =?us-ascii?Q?BdQddg0apmltEpu6seY9PZ2jtw31ZH2mgGWr4K8usicRE9H4oBHwbxp6j87n?=
 =?us-ascii?Q?LKz0AqyBAymRbAeQJ6cJHPK+Y2g+3GsSP0almMrmfeEWvMvbtmF9N3nXpu+U?=
 =?us-ascii?Q?HMpzh8siHqLw37IuAi7gKLjtTF2lf4g0HRcYwGUJ9v+Yd/FUvA1ZpHyxtfnW?=
 =?us-ascii?Q?Ts/2XlMzrqprckJwHQxXB3B9x0oDTKFkJjUov3ra5raYPm1X4MkkbmUKKDyR?=
 =?us-ascii?Q?U5qIlFwJNKnfyyuCpyuROE7lkalQZR++5TR26SWjVG3MBg1NB0CeqlRmBikD?=
 =?us-ascii?Q?wMhm8o/we/PdcoVjALm7w/mHXQvfANYbSu98czQGGagPton4Ju355sqfKpIK?=
 =?us-ascii?Q?JI1kl9V9FOXJspTXDo3LAyWDkydGfm27JJr4ycOq0HV4kLdymKSZG1jzy79v?=
 =?us-ascii?Q?fLfRJ28jCfFK96uTFvg16BqyJlB5u1++vrZlpIZIYZRcvKnMFXMCZQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9907
X-CodeTwo-MessageID: b834f37f-ca03-4f57-b3fd-ec60d87abb30.20250610143930@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ea98b229-7b7d-45ee-eaaa-08dda82c991e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|35042699022|14060799003|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6MHSL9adQvziQmbI1EswGI0iJORSu1j18hxrIiSyKXIaxnClxo8alzteuZyr?=
 =?us-ascii?Q?LO2W2Ji3L+OfEARm7RRkqKrH+Ezw1H6LkFLi/KT8uVxfu0DOGp2NLTG1qWAO?=
 =?us-ascii?Q?QBZEpoDmpNgh1ZfZRs1skY+dgbQS6An7Yq5Er/frUqXbBJeo5dBP5768/B51?=
 =?us-ascii?Q?clvYC2th8OwgE7j7PJzG/O4FPsbNu8Grp6Y5s0vW23YOK5TJwng3vLthOc5X?=
 =?us-ascii?Q?PVQTd+nJuAY7k4FSMZwbOEWL+XCZq0fa0oI17KAVOWKTsKhPIP18WpLvi+gA?=
 =?us-ascii?Q?VUWisd4h6quH+ZDvvhAhM/lhKXhHvEYsHMscGOoI3mNyXOodpIpO637Qs2Fa?=
 =?us-ascii?Q?DlmJAgOfS6IIPd1CpSWiATGXuqu9Y3Wlbcg2lW8gCAdtpPDZyotXtcQ/5U8Y?=
 =?us-ascii?Q?jHzoA63WXqJsYPAouTNGHWAut4H7v3jJB5kz/EwDpRJaLH7JRXU626TM4rge?=
 =?us-ascii?Q?zWbhHesKl95CEwjFmXrv+sfSj9hUQSpEA5EAgC5wYgeaVQ+eoV6NRdRcz5Rp?=
 =?us-ascii?Q?3kSKFyRA0QcQ/j5MuqEosPDDm1G4NZLtMmVmrP7HYLIrQQWBahEZ4Ab1fESo?=
 =?us-ascii?Q?3dddh8j6OtTsaKaFGyCzxGrjbVIXQMKaw2aTkY3SG16pCzqk6P1ayaM7lpwk?=
 =?us-ascii?Q?pmNONs9URJuuNwSqs837lN6AQ10N42rGM3NFhmBMIq0fnr4hRBtyClI7jao9?=
 =?us-ascii?Q?A0bkahzJAFYMIUtEjArGHjC96Ov4K3bKtYVtexCRbyCSaZKdGJVBCXkqkAXS?=
 =?us-ascii?Q?9bj357vvO4PLe0KDFMFRUvplR4kGIViQZXlTfoTuCjZXiz0/m5buBwbUV2KI?=
 =?us-ascii?Q?l/VhgDLKBQC2Gd4dGM+hz0yr+pko6A28Arq7aI1W9gS05zqm8NU69czD+pFC?=
 =?us-ascii?Q?TT6ZWO7RJfhD6fOYcQKoQRlHQKyFvcZKLz1qtKxB0Qi463wEIpwij6pOYing?=
 =?us-ascii?Q?anLxxWRq94acFptfH9hA0NxqdbPCiyxDuQbEYF27oxfqYPAXgIC7786kMTQ1?=
 =?us-ascii?Q?/iYbX4PclYT491FJ6Tu90w0w9ULhZCrn6G/3mZXXUrZIBZi7/10vBYxFe7Sz?=
 =?us-ascii?Q?f1ZBr5EZ2JBjP8R9eEoMRk7FwzcTvaGkltzEkA9IooY3r8hJViAX2CrSijBB?=
 =?us-ascii?Q?zZj8JcxGipDsU95OFxAZgyRKAGlEr0aQiyHB0Qy0QzPX+m3L09YbYd1/wh8/?=
 =?us-ascii?Q?k+AuEXWwuEnfcx02jp1FpeP4TX0zc7CGRytdMKtyG3pcVzQX6S1zVaYFTURT?=
 =?us-ascii?Q?H8cfZ/BuWaSa4yF98txM4RfQEj3xD270hQWlLS9ypm72ch6GSJzruhhiz6FS?=
 =?us-ascii?Q?Fzrgm57NnHlZwrv7FCTXvuYDBwEfzh0yzKUl5ghgHokfFGB4Lk3q5yGILSR7?=
 =?us-ascii?Q?7llcH49WP56473Lihv+5JCiH0GiiuI9zCA1jSysPcmD7tbQj1/2Bb5pJcveo?=
 =?us-ascii?Q?mKXYCs0bIozzYOnNYA25+NOqG69682T4qKpRmuwXTOZTOvGXeQR0fQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(35042699022)(14060799003)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 14:39:31.1400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a497a5f-6ed2-4d9a-dad0-08dda82c9c5a
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11383

Support providing the PERST# reset signal through a devicetree binding.
Thus the system no longer relies on external components to perform the
bus reset.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

Changes in v4:
Adapt patch description to "PCI: xilinx:" format

Changes in v3:
Include linux/gpio/consumer.h
Message "Failed to request reset GPIO"
Use PCIE_T_PVPERL_MS and PCIE_T_RRS_READY_MS
Dropped dt-bindings patch, not needed

Changes in v2:
Split into "reset GPIO" and "wait for link" patches
Handle GPIO defer and/or errors

 drivers/pci/controller/pcie-xilinx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/=
pcie-xilinx.c
index e8a07535539e..92aa4f3528aa 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -10,6 +10,7 @@
  * ARM PCI Host generic driver.
  */
=20
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
@@ -576,11 +577,17 @@ static int xilinx_pcie_probe(struct platform_device *=
pdev)
 	struct device *dev =3D &pdev->dev;
 	struct xilinx_pcie *pcie;
 	struct pci_host_bridge *bridge;
+	struct gpio_desc *perst_gpio;
 	int err;
=20
 	if (!dev->of_node)
 		return -ENODEV;
=20
+	perst_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(perst_gpio))
+		return dev_err_probe(dev, PTR_ERR(perst_gpio),
+				     "Failed to request reset GPIO\n");
+
 	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
 		return -ENODEV;
@@ -595,6 +602,13 @@ static int xilinx_pcie_probe(struct platform_device *p=
dev)
 		return err;
 	}
=20
+	if (perst_gpio) {
+		msleep(PCIE_T_PVPERL_MS); /* Minimum assertion time */
+		gpiod_set_value_cansleep(perst_gpio, 0);
+		/* Initial delay to provide endpoint time to initialize */
+		msleep(PCIE_T_RRS_READY_MS);
+	}
+
 	xilinx_pcie_init_port(pcie);
=20
 	err =3D xilinx_pcie_init_irq_domain(pcie);
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

