Return-Path: <linux-pci+bounces-24625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5738FA6EA45
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 08:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A011A1885E3B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 07:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E981A841E;
	Tue, 25 Mar 2025 07:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="PD77xtb8"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023122.outbound.protection.outlook.com [52.101.72.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4AF1891A9;
	Tue, 25 Mar 2025 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742887129; cv=fail; b=Lw/OB3eWTnPhr403HdCqZbJX5VyZVrf1CL8wa1K33/szGC35zVeRls2eTwts54DAoZtswHyHI+0fKC+UeVb7U61FM8lqf7cxCoCozGkQS26HxMUF3WjMXcnCs2UVplSylJp/jJMcr6/73/PSxR6RXBKgPlrgOVXE2pxuMXjc/8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742887129; c=relaxed/simple;
	bh=uVj6NBDJGgAPbEysIw5fhQFau52AWh0K6U9h2HYsaE4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=axSfi75VjpXnSY9rKEKkXfJcYqT4EEvhySHBgDvWpiPX0qMhsKbSUFmVmkDNYI+1BWzQ+9cMNoSulNr/ckDtheMLgKDvh72Q9aHUXtsQVCGSOFRTMJ1YuLw1WJiotz8Jcm0DZ20zEnGvOI1l5lra3Tj+6VE+VR8jgEiupCBlJBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=PD77xtb8; arc=fail smtp.client-ip=52.101.72.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMDmVexTQd/NkG3sy+mruaiVspkGGLAUf+IvDnFByFSsl2SaYGR4nGOFbB5gx3KOhZFexwZw2V+xzeAzAWWRphMsLBGSAe5YFRH9qeqJuP4S6xPSB8q2kanl5bxnPT4nwISZIvhVVilIYwtM+3dwn+XOW7AMvcIPBi0LLb2KZA6XpuH6//2Sc9YJxIc55AzASIxl/UgdYwFqLrUe04t0kbv/karhPKoWvsTE6eDyDIhsp2Oa2JA+cjN7BGOQImiKQbXLmOWeW30iVL08aH9Bg1BlP2BoKPzm3H9b9K2AXLxIFlKUBmT5j/QdTxLjNKluVSiEyOS/1AjJs+t2XUUwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBvua+gENZrYzxeXNsdTJXQUC5BEESbKKt6DLEMsFOs=;
 b=uYpbnLn+gc3C5VS3bFktZMux6LKeF6WS4Hw+5RjJVJPfCOD6hoztnXuynl+1f0eIPEdWBUradV/SIqJioFspUbrkeDijUyjZM2ASvrjODVNF7CHtzkxJskMMKTuNqrBgUGbhYy3DkmrYA3MDOeAyX2EsKTUWi29euG55pw1/hcSI7OHQ1l6cXyj19BQhAjY/kVXgWI8fdM+Dwf4LbvUbPgrEmYMlkesjv7GqLM8z2yMmrDJvhQyXGwVfylRIOIFh1/cMGHTKNCx31uzy1014gm63Kxi1VFTL3rytk7FAWHyS3GhK1lYmzpjP48MPXrICA/gy/+Mmvo4rRHhE/tY8Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBvua+gENZrYzxeXNsdTJXQUC5BEESbKKt6DLEMsFOs=;
 b=PD77xtb8Ft62XXW3bOF5jZznVXRKVA1laIokZOT1RqZiEPGd6s0UHc2wkTYb1JJ6EV5/xGiEETpP4BAZ+FGy1aETZHX3DbIyRRdYQDE/CemLX6bdzWEpgLlmGAfSuGqiFkibFSR+3FexwTkUsJyh3xBvMDvmLhpq3IxBoG0cPIX0C/XImKpb4sgd4QjgoRdf3zR9Ep3pHYL3mVq4SqrZaktFDriwHeBWddZuWLmPaLeNqeS9SLHGEFcdn4x0vneND0Z0e4bUF6wY0IMzXlr407g54AdZ7O27UfaJ/la07BWKz+kGIjKI7H6voHZ7U+tBUSqqeVdJ4/+byYApUO0wew==
Received: from DB8P191CA0014.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::24)
 by DU0PR04MB9494.eurprd04.prod.outlook.com (2603:10a6:10:32e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 07:18:43 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::dd) by DB8P191CA0014.outlook.office365.com
 (2603:10a6:10:130::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 07:18:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 07:18:42 +0000
Received: from AS8PR03CU001.outbound.protection.outlook.com (40.93.65.54) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 25 Mar 2025 07:18:42 +0000
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
 07:18:38 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Michal Simek <michal.simek@amd.com>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] pcie-xilinx: Wait for link-up status during initialization
Date: Tue, 25 Mar 2025 08:18:25 +0100
Message-ID: <20250325071832.21229-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.43.0
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
	AS8PR04MB8644:EE_|DB9PR04MB9353:EE_|DB3PEPF0000885A:EE_|DU0PR04MB9494:EE_
X-MS-Office365-Filtering-Correlation-Id: eef0e732-a619-4ff1-2e5a-08dd6b6d4646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?38JKLL4nQzu5Y1wJMG1fEi8CUCk1HMkJ4pZC9gcEcsv9yPKFujloaCdXoso9?=
 =?us-ascii?Q?3WIYNwiknSV1gDo2p8xtIus2TL67JGvU+qqoSJ/udx8qBGpGAUEnwa9vPmTO?=
 =?us-ascii?Q?dW0/iwE1DPv3N8ZZ53uoT7ARlFrqCqEthTsCyNyhvsecmagVoeJ99lsmSiWk?=
 =?us-ascii?Q?Rcv27E1OAm5zgYytjZpZYOeAZi+aKJgo0KVgl7R0S2n1jPujUw4jYpu6jI/+?=
 =?us-ascii?Q?c+WNsznjj2MYwax6DqA4O7AK+n9F5N7xk50xdpN2fJTSsSBJwnbezqAKS9BD?=
 =?us-ascii?Q?FJ5HIY3YAP65rRT3J5uacKnbSgR41Q1RXCypUFCzlJ44mXNfLXs9Tat/uE6g?=
 =?us-ascii?Q?kJ1O5e4SdYcNYv6yADgz2PNfhkKQHpqwPIHO3NUCldqjZ4Sp7TVZo1tbVLKr?=
 =?us-ascii?Q?7BeCb4q8uR9lOO52hQOwPKBRJ/nkTVq1k0ea3bIPJqNnh5ic9tqMAMd+bVKS?=
 =?us-ascii?Q?G7bpjNcjDZ8Hjn+FpUuO+CIrnPBd52DP3l3RxdSNrh0utsZ/IbqcK8PrGB79?=
 =?us-ascii?Q?a72EgjGmRngYogMvyrsp3Vrf+dIla8jbrYvy37v7arIpp+kxSHmKE43dXzbK?=
 =?us-ascii?Q?L0oOpg/F41QfbKliy5kLq6+ikz97cSRSPbAYiivB5wjGDpH8l/mfItOO7pBY?=
 =?us-ascii?Q?pAHyn2XVbiYy2k3NoioOxoQtonhtj6S+1CgBjilsEO7iyqwMqu6zgvZD+BIl?=
 =?us-ascii?Q?q1ZzbdIpJP2HLCFG2VAA8zExN04kT7l5EHU+iYb4Ly/r3+maDMzBAtRV02a1?=
 =?us-ascii?Q?EkHggHWc4nbT0cjUWmkKh9EPzib0JJolVFy/EmZtzWIrjftRA3GJrYxq0vfc?=
 =?us-ascii?Q?s7KViOzEqdmwaK/dG540pQtq0c+Hzj0h+XsoRKXQXt1pRjUeUtSEyMkMupzF?=
 =?us-ascii?Q?LKX1WePrO2dPBfs2boFlgX0LHbQ4nXcAXauqan4MWZtO+u64LpBJkRjXY+0I?=
 =?us-ascii?Q?AsEQDhWLOAdd0LmBkr7a7zplKaZwgxmJdigaPkXXdXCEyzv3w26MqPJVKwXJ?=
 =?us-ascii?Q?HXQGDLFwM4ZOSYrKD22O9QR1uhLz6y+tiGoJ6uwy+G44XZYurSQCGSiBi0lv?=
 =?us-ascii?Q?itju19RO4W6mqDY5CC1WSeVAkI79EnsGdvCYtST7UFi2xLZHJtozzCbDQqKw?=
 =?us-ascii?Q?PbNnc4ERuhsAmnCxKh1XBbb/qL2yZ4tXcBWi5ynwHtKdf6ThTRnwWAxfniFe?=
 =?us-ascii?Q?1yB36Wglg3dXq9uG8etmUwwiUI3Y2xcVFt2EKJoj99JvPoL005Zga/iPJ7wT?=
 =?us-ascii?Q?hAiUa8WNRm0Z28vEMCKUO+6hJmMlSLu/uIDaPm60eujKPAD+TtJTuE7164QD?=
 =?us-ascii?Q?Z3Jf5grgpUppPS+ymwrVgSkRQ5v6Bwp+Vaz+De0xlknWQfPeAlXQzQTpJ1AN?=
 =?us-ascii?Q?nakiy4tB1w/sDJvmU9llanYPcYAW+d6QGi85AgJE8miXtTYKNpUM5UXTPzCG?=
 =?us-ascii?Q?SXsgvX2t3WsenPQ1MrvqaDoe3iVYEvyp?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9353
X-CodeTwo-MessageID: 80fa15c7-4cbf-4d62-b409-f20133d0a355.20250325071842@westeu12-emailsignatures-cloud.codetwo.com
References:
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.aa50e046-9cb9-4d7e-b920-ce2956412b9d@emailsignatures365.codetwo.com>
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	aaf6df5c-3bed-419f-5aff-08dd6b6d438c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|35042699022|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7N1QwSaUbq1O8einPbXeq9Q3hcUWKDJ3ArblBQoNBgYy8EDkjBJ87wOTjHAl?=
 =?us-ascii?Q?pLys0LDJzNo4wvW59eDdGARZwTTzoegca4c8hEUNAMkihJnt6p2zEs2/p+7r?=
 =?us-ascii?Q?gtQjoivA492ZQlu5LI2cIwyFotaocj2H8eNwA6Vp/YU676ucgft0VASTqB0s?=
 =?us-ascii?Q?VsEDrs2DM6brh+3bBqcq3KNz4KpwklH6PWNFMrZbVSe4PMWmlKIdT2RMtJsH?=
 =?us-ascii?Q?Z27R+RmeyBprHFDsh8HLbFEhtPXINQgAOnLj2XgWm+Dm8YGB93uaY2yWeYF0?=
 =?us-ascii?Q?rHFUHADoFvCpJ2leT+Vfiai5ulZTTzsaVgoXcue2JNvOjYJLV38uq/PzgakA?=
 =?us-ascii?Q?RgEJWQSCitrQvXzn2htbDTl6PTPdByWaO9xsvRCU06ASAfItVuNP/ga8W6kW?=
 =?us-ascii?Q?OllAHvcY3ekZe/JwltOIRaMHhnJTagfSgMK6hz7q9JrQq47YdwOAeF8Vqdid?=
 =?us-ascii?Q?8zca4asS134fORDgE6PAraoTJIZzHsPJ/DokhgYjmDQaod2pw9VzOswIz0mT?=
 =?us-ascii?Q?jIgKYMdQ97weoevbNDPnVJrINwxa36Nr5buDw4xqQyVbnv0U64IAhy0qmITM?=
 =?us-ascii?Q?KGne/DNICtqJ4x91EYoylPr4Mu5c/poX6bt3hrqi52U/7gisaK7hAx2LzEY9?=
 =?us-ascii?Q?FrgkpbxF/r1ahbEjOhayzZdfP8MW7IAPLeUFfFrTd/t3iuo0i3DWGaYfYSFN?=
 =?us-ascii?Q?ceTN7pZEvAUxgE3Gug8qpMNgWhHnN/AEMPEgyUNniyCjjDybdIoqkV7TJQCH?=
 =?us-ascii?Q?Vs/j01do7ErK2c3Mo1tqT4xEI2RLuoKCiEwC2LvUbw01PA4tjBWCtir7TAkL?=
 =?us-ascii?Q?8hoclu4eENH0TzBKrN0U9XgcA60ftfkKh/wLbKPl577dNJn82wqdbbocKuy7?=
 =?us-ascii?Q?IndkfgR8SpAfUIkspklcd240GjsBkRGgMRZvEohyMZD+D0LgXI/LCHVYF5pM?=
 =?us-ascii?Q?mSk0o40JyrYSI9actAN2vxmD/go4oXRh0sNurp0aYBXyEPFNludDoi9mQ1Zy?=
 =?us-ascii?Q?Nt2g2Bo+TJiTfjc9gB7EIKWnXYERds9hhM+2KjVr6S5qIHTGp9I3qD6arC9D?=
 =?us-ascii?Q?Y/3+Pa2htqshSp3utccD40YdaXlL8dDCm8fqgY0WXzG19CJ6X7+soj3htZ0k?=
 =?us-ascii?Q?Aw3iCQIXe2PaY12zCNxqmhGyflC6kWmNlFKBuPg3/OJ6EQIXhLczaYXJch4B?=
 =?us-ascii?Q?oF5xuriAXMOvTsN0Ufb4jzFkp74KCqkvvIbtW4FXylQE6u/ryHWrAWVPIf+9?=
 =?us-ascii?Q?LIKzb214N4h/SUAYPXkkbeirN7QsBPynwICX6yGp7jv6v5mOQ8CFILV6GoTc?=
 =?us-ascii?Q?jqrbWC8zZs1iOln1XacqrMvjSbrkyva7Q8IFr9Rsd3BgKQnK7xD8EzMV8h3W?=
 =?us-ascii?Q?m9R7wQop0xgBo22MiOj+nXpsL205jCDsUgGOr2RcH78TPYsOfLoSymDd7AOf?=
 =?us-ascii?Q?bZThTdlk1ro=3D?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(35042699022)(14060799003);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 07:18:42.9371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eef0e732-a619-4ff1-2e5a-08dd6b6d4646
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9494

When the driver loads, the transceiver may still be in the state of
setting up a link. Wait for that to complete before continuing. This
fixes that the PCIe core does not work when loading the PL bitstream
from userspace. There's only milliseconds between the FPGA boot and the
core initializing in that case, and the link won't be up yet. The design
only worked when the FPGA was programmed in the bootloader, as that will
give the system hundreds of milliseconds to boot.

As the PCIe spec allows up to 100 ms time to establish a link, we'll
allow up to 200ms before giving up.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

Changes in v2:
Split into "reset GPIO" and "wait for link" patches
Add timeout explanation

 drivers/pci/controller/pcie-xilinx.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/=
pcie-xilinx.c
index 0b534f73a942..2e59b91f43e0 100644
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
+			200 * USEC_PER_MSEC);
+}
+
 /**
  * xilinx_pcie_clear_err_interrupts - Clear Error Interrupts
  * @pcie: PCIe port information
@@ -493,7 +507,7 @@ static void xilinx_pcie_init_port(struct xilinx_pcie *p=
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

