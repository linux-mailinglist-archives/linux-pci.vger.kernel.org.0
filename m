Return-Path: <linux-pci+bounces-24627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AB7A6EA4C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 08:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6EF1895336
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 07:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31114253F0E;
	Tue, 25 Mar 2025 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="Hdlxqw0R"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023108.outbound.protection.outlook.com [52.101.72.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2D6252914;
	Tue, 25 Mar 2025 07:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742887133; cv=fail; b=cHEEm1phovfbGp3Gsnz1D/rSE6mrrXU80VH0z9c89jJZikpe/wNcaxu4VtqZP2KeQP8RnVn6og1fOMcdeDB5UhcVaAt8MV5zHVd1ngscPyzoKnrRu91n7f7INhF4mKNA7f+vEgEmEoCkYfgokRKm8W0e29lpTS+KN85C3ZrCJmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742887133; c=relaxed/simple;
	bh=2PTkXYsUZRchIzpzuFOUVs3cyj82NePeHpEGM7q5oSc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IFgMVQd5pnJ3U1hH1iyBmxX+i/g5z7OK+/r+PzfhNvQvO9Yz7xfylZbzHaFsJ1IXrbGTBEKXYcFWdMo1uM0plVUm3L4SQdfELoaShOmnLyz7K59bET3S54kbR+bw6ERewi3BLFQgHNFiS1EbFlEURJlUrAVTRl9M1LXbCyIVq/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=Hdlxqw0R; arc=fail smtp.client-ip=52.101.72.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0XgJ350JyA5tHkyqGELbKZC+lZZYmc9jGX1vDyYWxkUOsPUWbqw+o+f8qd5HvvnGt/PJ+uDqzv9VCcLn5haM420IwHOnNwir9RcufnjD7s0iobPS9z/TU6zCFqKUSjTAB9P1zN4ZWQLj0tyKqu9JU8TaZ99P9rAEIfO52OAmOc+XK11HH1gC7Tc8gml3Bzr5g12W1+NOUWU9Wp9o3zfSFCZe1w4w0d38gXx3I0Rifb8b8xv805IhH/Cxd3zubzVG4MXwuzpOgQfw/FaOS1h8mYpZ8bhD65x19gCLRB4e8aXZfMbU4+fDw5+bRLXXH5HW0i/jZ+v96cWXh0Iihp5pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhFcQ5xPTvcK2iemGk5D+7nAhQZDbMqMW1Nggha0pzc=;
 b=lWiPDww2Bguqi/AveiJXoV2NmZYyNpOMDRtivdDweFlPfErY0w0/c+X18ONjZERTZV6mbAoAM9Vq5DHBpHjnuA7x+fN2R7LN9/UOUCV4gUM1NGbdPhbQf3etfWSZmtlBWRkN9KhvoQ/qzGxF5cmogL99QXVPZ+bjJQhhEa1TD2ZxxnLoSZ9/Wz7UJlYHhvRf9Bl0ccQYJEMBeZ766eUdOLfmo8CjmjENlZ6efRJbrOhanDukQfSkuJijB41E64+PqaDxPg21EhP1Qrfyzp0nZtJompkOiyLTgX2K5/GST92e4G70rvslz+LsIq7pD4PoGiy1nBwVDX3BoOWjXrvKjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhFcQ5xPTvcK2iemGk5D+7nAhQZDbMqMW1Nggha0pzc=;
 b=Hdlxqw0RAugROFNsF/RArgCdFfyp6JvR9hHkPSOXSwdP11DBCb+ghYzjiXwcJ/AejfB40JtvCPKzeGZjETJ0r8OK/jmQOo8IiWvlv2STfVv0JMracjA9mnZl0rix5MGF3Xjzzy3OBuDysYsjSv/hZgM6dAKWkTYERdChymCPtsjGtCwigwCj3qTkaKKq5xJ4YmkWmQgHq91ooysPItvhB/WPKtwuBrNqxI2bdjG+QqkhnD5T7oa/YTzVHH3OEN5aZTP3YMQmx7RI9yQkiYVYpI5McwOmINdfQRQ5v7Q5WILRAmiHuV4HsztAx2OFQFkYriZZEXPh8rDf4+ETdboJlw==
Received: from AM8P190CA0026.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::31)
 by VI0PR04MB11071.eurprd04.prod.outlook.com (2603:10a6:800:262::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 07:18:42 +0000
Received: from AMS0EPF000001A1.eurprd05.prod.outlook.com
 (2603:10a6:20b:219:cafe::91) by AM8P190CA0026.outlook.office365.com
 (2603:10a6:20b:219::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 07:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AMS0EPF000001A1.mail.protection.outlook.com (10.167.16.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 07:18:42 +0000
Received: from AS8PR03CU001.outbound.protection.outlook.com (40.93.65.54) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 25 Mar 2025 07:18:41 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by DB9PR04MB9353.eurprd04.prod.outlook.com (2603:10a6:10:36d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 07:18:39 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 07:18:39 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: PCI: xilinx-pcie: Add reset-gpios for PERST#
Date: Tue, 25 Mar 2025 08:18:26 +0100
Message-ID: <20250325071832.21229-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325071832.21229-1-mike.looijmans@topic.nl>
References: <20250325071832.21229-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.7424060c-f116-40af-8bb3-d789f371b07a@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0013.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::26) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|DB9PR04MB9353:EE_|AMS0EPF000001A1:EE_|VI0PR04MB11071:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e701b04-7760-4ed6-fa6c-08dd6b6d4608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?CnlR+IyMGz0xGBsgjGJyfZ1puYcK+5Ewc4+QmUaB5NSXiKfI9qec1GFiyt9d?=
 =?us-ascii?Q?4UCqRk1lbs/GdqKsbgJCubXR0Xps4vqlElfo3H6qJ9+G21vKMktjDMx3S1s4?=
 =?us-ascii?Q?eGb4f8ahx6CrKYaT4SPjp4ZTRMs+gZOEvJQUfQD5rv1DbAM+11du/BigwQkv?=
 =?us-ascii?Q?hj1TYJoy4OIvZTz9DxkxfzhkjX6wa00fcVp3qZT3dUsImpKw5Gh5eIgNPIl+?=
 =?us-ascii?Q?DwytWOglFqrYQr272+UT36xz62cr9ieg2kipsbAQpQjdCnoppvxcc29Hiv29?=
 =?us-ascii?Q?ULQxpRBNHfRY8zuIWAvtaljOXkKEVygAz+uO7YZX7byBmlYQ5Tmb6kZ0ocMT?=
 =?us-ascii?Q?PWCjl16AcZmM/b5RSnAirE//7oTkRezEhXSUBzLjg/vYu7HS5iKwtOBCf+BV?=
 =?us-ascii?Q?WDAq9ZlLvdFFxaDAQGj86Kj10hAYowz2GPxzg2j/xZ77gU4wqn7UZrWX4UnO?=
 =?us-ascii?Q?3FEMnXN6XFLWCUrebp/5k8juXOLQzTbGv9tIEzKqbVzNJIngqeqWe/URSATC?=
 =?us-ascii?Q?k9ABjWTLPy3ZORL5yslGv3iQyPWpqFykr210fDHsJH/FuCutOPDuc4cfJg4A?=
 =?us-ascii?Q?vl7HG96zALoBEfMFOrLGLTpJpLohgiApEIp4d62GzPxSqGyIPAxpuK6zhQWB?=
 =?us-ascii?Q?prx4/gdEyoCspq514rNDGGgp0lp6gSQIT44YqQ5DZpoGcaelykh4Ub/SxmDm?=
 =?us-ascii?Q?dEFnlYHtfRO6L3v6msqJMSef3QLXVbVWgbgM50QnrOn9WzlMiOyLmr5IS9fF?=
 =?us-ascii?Q?G4KoWgUvGX7Wl5qOcKZnbE483pbgkA6E7V8BptlAvnImrwbm9t6RD7QajGW2?=
 =?us-ascii?Q?Uqb5rDcu5Z3wgszmLII8r9vAXRaFXD/05h2cwXhCScXNpDqBTKt+d+hqR6t2?=
 =?us-ascii?Q?lfQFPBPbkCOcM3eNuz5F1jbZAkQobexfvuWY0n1eNfFtZyGZ8sFK2KycFnUg?=
 =?us-ascii?Q?3ISX4jZ5Ulqo39EhggubPYy0P54N8USkYRTMlADhGZ/jw/X3MluXB6+sSuAL?=
 =?us-ascii?Q?PXUtmUKQZqStYebHG0GbeUhfe+LC9OOnEU3aaRLCU8z0CAVf7Iqf+mWCjm2i?=
 =?us-ascii?Q?TDIfIjIkMGDQZVRwPfmDQrcpeSQmRkL867AS8BtitgJAwI3ucKp/PTNw1mNS?=
 =?us-ascii?Q?LT5jfi26VGQe2K2hGXQ8Z2TqtR+i1udzlhg85TD06ZVcsyhm+teYweH6yj1O?=
 =?us-ascii?Q?/C3WPkRjZc5zUPq8r7le0Vo0CgVYScqNlDtzxbttvCdHwDX4xNuev0PjwXJ+?=
 =?us-ascii?Q?z6M8ZeIenvV146iBX9rUy3ePR4+QDO2Fr8H3bOKUsMoo21YEx9C1tBBoW3oD?=
 =?us-ascii?Q?9zNECwnKx0soiSDNBu4YSpyoUU1FDpqay4guqC8Oh/HgnA7M8gXjf5UQIVoJ?=
 =?us-ascii?Q?PT+mWWK/MlUefQ5fJXYwkoHX8S+NNKKOZpflRXu+8Xyc9w6ImcbTb/3R8LbJ?=
 =?us-ascii?Q?1J5wmkUzqFWueLnPqt+C1QrXmJBXKzuQ?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9353
X-CodeTwo-MessageID: 009c6fe2-c2bf-4351-900e-043b32a9c214.20250325071841@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A1.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4160111f-a6f6-4f50-6d67-08dd6b6d43dc
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|35042699022|36860700013|7416014|376014|14060799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9LmJPUyGx6TwrfyYvkJbra4yMqW1KxMfH+Cpp/M2FcYSm6ftfZlYr0tQccD4?=
 =?us-ascii?Q?qGUZyIzyXp1a9edN+Pdd9haFLv3V26qN5alP7a/o8wjpq2wvi/RYJdIHoCxT?=
 =?us-ascii?Q?A2Lg3eoeLAn232UC/Tm4PAHqDhGew9WYa51Vw/sZAZeS4mPkzdqud3Msv5dE?=
 =?us-ascii?Q?VyBzmhyJ+AjRhFvxpU1UYaCEemQkXma42W6tHk7iRaHSVY077XnfeTWnmutk?=
 =?us-ascii?Q?6NrNN4Ukad0zgEwHdCA7SBgghgSp4fVlLNSMoDZ8siwOa1WtOXHyIYhqT1K0?=
 =?us-ascii?Q?dA19eoSOTNJOa+/4OYjH9YYapEpP2COTmnxDzHDO/VJFAYp7SH7P1rq6aNQq?=
 =?us-ascii?Q?aQNJI5O81T4yTz98tOoV71CT+IQPhLxrHPSpTx9xeCaGuKYALen2FFe4oHCK?=
 =?us-ascii?Q?lXxHk8Ar04/HVS+y69NrV6YVxsfQtAMNdrqUVRHiB3aLkQe3ylGN1mZUCIWX?=
 =?us-ascii?Q?2Hg5EK43G2HdvwEEKwFDniX/A3bPWa62iuB9qh1nvru17HqhiArtU0iUr1PH?=
 =?us-ascii?Q?zX6hQXweZSoearAbs/aRZ07Qf/GRxR9r6F3dcoHtkvvCLiGFbMjcwbGC71MQ?=
 =?us-ascii?Q?4k7zZuYuSxMml4GanOE0O1lPC5tXyd0qm8MAWioQYkXbQ0+HTcTMVfkqElQ4?=
 =?us-ascii?Q?JhT7j14NF1Dd3Gd2lqKKUIfv6TUnUpcQcfUH8fsyTJv2i/2+Rsnk9moGPcR4?=
 =?us-ascii?Q?5tjXr3XaVaYc8Undz7jnUANacu8wCzSmYXW0r4LfKzjOE4MB1qJLzfyxt3fu?=
 =?us-ascii?Q?u6C1OXKmzRFnHjVc+aVhkH8gr1UIGTf5GJwgJkg/NlLCNVMqWAY95AXKX/Rk?=
 =?us-ascii?Q?C99iWW9dgJNPxykS5vtSCm1VhjaV76+J1jXjk25SMm0AAALabDQQu9anGqvS?=
 =?us-ascii?Q?KDXXh/DlYjBKvWTpb+Zk3IEzyT9i3t5twynia58XjHw3OhwrLNONSTADZAsd?=
 =?us-ascii?Q?9VNPbRNx9QxRGScFrm8r6qOnvXkqQqaW8MORuIk1xv7nFoWJYULN34S5ZJ44?=
 =?us-ascii?Q?4lBFC3KazZiKDtfGx5m5GhAPyUXo9dJt+e7MkdstU0PUI9y1aKIBLBzeYBaQ?=
 =?us-ascii?Q?vc1Nztam3qJf2YMeJivaGSp4McVkNmJ/667xiQMFzMsqpZ/SdKKDSsIv79qs?=
 =?us-ascii?Q?feDN80HU3Mhxd7HaXWv8oyr31TCH7jaQM1QxysLKXWgd/6Xqvd9MEHevOTyW?=
 =?us-ascii?Q?t3wD5rWo/rhYATRdDuD903zHReeQGFzUMt1XaZJeNY9V8+iilu8LwR0pDU8G?=
 =?us-ascii?Q?RqjsyY9ZCB4fBGoU7bBYUgEow6T4d5sYNx+QvtLE2kZZH7pGEOWFM2hn1HuM?=
 =?us-ascii?Q?pNyPjJbJKXkeu5lppZ1EvTsK8OX2K/wykaoqLDTzlzOo+2f6WrLv2+chdqUN?=
 =?us-ascii?Q?twLIKOA34JlVvOvINd/cuBowCMUKqTnFjAoK1BkIrhDGU3Zv9/o9flZauazq?=
 =?us-ascii?Q?rkWURKwoyts=3D?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(35042699022)(36860700013)(7416014)(376014)(14060799003)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 07:18:42.6766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e701b04-7760-4ed6-fa6c-08dd6b6d4608
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11071

Introduce optional `reset-gpios` property to enable GPIO-based control
of the PCIe root port PERST# signal, as described in pci.txt.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

Changes in v2:
Add binding for reset-gpios

 .../devicetree/bindings/pci/xlnx,axi-pcie-host.yaml          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml =
b/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
index fb87b960a250..2b0fabdd5e16 100644
--- a/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
@@ -28,6 +28,9 @@ properties:
           ranges for the PCI memory regions (I/O space region is not
           supported by hardware)
=20
+  reset-gpios:
+    maxItems: 1
+
   "#interrupt-cells":
     const: 1
=20
@@ -63,6 +66,7 @@ unevaluatedProperties: false
=20
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
=20
@@ -80,6 +84,7 @@ examples:
                         <0 0 0 3 &pcie_intc 3>,
                         <0 0 0 4 &pcie_intc 4>;
         ranges =3D <0x02000000 0 0x60000000 0x60000000 0 0x10000000>;
+        reset-gpios =3D <&gpio0 9 GPIO_ACTIVE_LOW>;
         pcie_intc: interrupt-controller {
             interrupt-controller;
             #address-cells =3D <0>;
--=20
2.43.0


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

