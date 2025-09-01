Return-Path: <linux-pci+bounces-35260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A3AB3DE57
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 11:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2830D7A890F
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 09:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3855C31DDAF;
	Mon,  1 Sep 2025 09:21:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023073.outbound.protection.outlook.com [52.101.127.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82F731577A;
	Mon,  1 Sep 2025 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718480; cv=fail; b=WTw/6z0spSW9UrfNhNBPSCGxaLwmVdAg1dsXIWXuNI6ShDe0fRgz6qCKOyycgzfxjI0uEoib8e/ONxKeq3Et1EA1UT8ePSXDsWPS2JGMAqi/5MVr3VA0N6Cbi+WGC1PsYfk1Rm8vG04IGFOJ9OB8SSd9y0M3Fvb6Rdq8s7lJLWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718480; c=relaxed/simple;
	bh=FKVmHbUtv0ZAVLoC9YFxi3k/u06VUW+6gHCCVz+apKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHuFWI2ZFlLO/4guXcbTd0nUWRp3KSDQcTlYW7eRy4TQ/g937Zyjz0ZV/FHTmRNTeeJkd4tHzxQgiHLg0K8S+5J73Y6mOG/LWT+3SQEjE00pRL4LC3fHLT7OEmGzQdgp3gMHTvyX/iYzfrAr20pnyo084xFFAycsDfn/BF3rdZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOO6eeblxDt7579LWPba6jkxfCsIWR4r+7UYxyDNDHUvaAvWiVQBMmHrltZuQIPieDLa/VER30SQF8pa2Y0WMYgX/PIhAv4pnV85URMFbJ1GoYOauCfN3OG+a8wr80XbgdKfXYJ/ui8A5XbPZO8Mq2/biszE2eM4iqrvewhYoGNW9Su1cFv3A913WfZvIp+nr31+jiQp028W4BMus5ud1rp4oI9IXZl1OxklfOvPZLVWbJxxCP/l8LXCu4wCNRve2SFiH8dDZzJjRbfiUiilbUKfm0gIJskc3JYRBRxkpcZiE1eUZTnXhzpaune6W2iOb9WukbbiFFejfCZeOf6yfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZqgQTFCvoZf/I10AGX8nNPYpQuVdUWQURlpZl+xBpk=;
 b=lDTvc3VhJvygDZBX1HXHWbcu5Q9mWCAUFyZyXyo0WpmJ8kTfa+yvEuOmDD2Q1VkVRElaLwQuKBsMxz9yoCbFJXPeEksrTGVdNEsJJHNtIHAf9OCrYKblrGF6+2s+UcbVlwv4KFCDVe6cnk6fzQTYK/Df+WLRjw3cPgqm0IIVLBMxQhqSLGOqa3+7AmLZqpCB8kBac3hCAxR4Uy/bSf51Cu/zmp3NJFKmU3It9X5Xhai8zF7m+S1SrBB2unm4f6BDaaizqyn2MlkzlJoylY1mTUi2Ber7mc6QILQUQC8ibKdl1mE+HKahFhp8EFl4g66GjpNQW9BFa9DfCXIhMKJ2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SEWP216CA0072.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2bc::9)
 by SEZPR06MB7186.apcprd06.prod.outlook.com (2603:1096:101:231::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 09:21:10 +0000
Received: from OSA0EPF000000C8.apcprd02.prod.outlook.com
 (2603:1096:101:2bc:cafe::6e) by SEWP216CA0072.outlook.office365.com
 (2603:1096:101:2bc::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Mon,
 1 Sep 2025 09:21:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C8.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 09:21:09 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 784FD41604ED;
	Mon,  1 Sep 2025 17:21:05 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	robh@kernel.org,
	kwilczynski@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mpillai@cadence.com,
	fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com,
	peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v9 12/14] MAINTAINERS: add entry for CIX Sky1 PCIe driver
Date: Mon,  1 Sep 2025 17:20:50 +0800
Message-ID: <20250901092052.4051018-13-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250901092052.4051018-1-hans.zhang@cixtech.com>
References: <20250901092052.4051018-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C8:EE_|SEZPR06MB7186:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c56fc6bb-39bb-42a1-2645-08dde938e340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xLOZvn4MVCCtwjHbT6HhL61oqbD5RFeuWWL0vt35so7RL93eq8TWv8fB7nzK?=
 =?us-ascii?Q?OJ0sVxQqejVHaxSl6s7rEZ0LTYWwBygH6Q4Y93+sGPi0kT19zvQnkUJxNYa/?=
 =?us-ascii?Q?Si6rpV0BFbMIVGjZEtai5n3Icvf17kQ4TFFK7l5E78RWDIuV3Y3S+QzgrBM3?=
 =?us-ascii?Q?WOve9o6x4QiGDHjQUUccsq8gnUeOghHKdp83LX6gmmVFBASZ0oRCOZK+zGn6?=
 =?us-ascii?Q?+YiuaCh9ienbnG4DqOz1f7HYIeFuu2kPbT4kOavWLhD56Inqg1P09AMhcs8e?=
 =?us-ascii?Q?BbDQd7xoo2F6PZbXcISRgDdAaGNjMIH5J5/9/ASi44X+axbSXGnrnFHayd2r?=
 =?us-ascii?Q?+rjM5OlJ0qgcYP1CJp08DfuJIivDPG0OQwY0LVLnTwfupeBIX5sf0WYMtpxM?=
 =?us-ascii?Q?jqxc1lR3B7myMQ6DkyhNGcuhd3K/c/xVm1+qNOlEpJQNrVUtnH9UrKS/ysmv?=
 =?us-ascii?Q?cEYD9zS1XvHcFaf7rV23ylYTB6fwKd2xSJ4j5HpeTk010SRv2qW1JeBZEBNl?=
 =?us-ascii?Q?/AiBZNw+/Y3hmgSrLiP/VteKCOpBrJF8mp6tv31x8aICijqitRL+5t0ckH+M?=
 =?us-ascii?Q?GD2PXYuGuajyrI0Lnr+Q9LOIvwGgZ7N3cQkDzTIYl/PK7xY7UN2KyaTyJGAX?=
 =?us-ascii?Q?746vd0hVYKh/piKY2+ZIvehfjSolXqPu+/yP3BZdHsm7rUASqL88vEb6z7dn?=
 =?us-ascii?Q?Ka0ZzzWllJy8v6nHccwtLmkd2a8aSc58gc7YKkBn/XcryghBb16SidLmaoeP?=
 =?us-ascii?Q?cl/BJfwLc0w7bjxfrO9esgButJj5GrAAzcmJcIUVkxzxg7bgPJYK441AeHgB?=
 =?us-ascii?Q?wcAwy0Cnt+SISPPi5C72UosxQF63rMzZL8k1Ml5CT8zHWc49a/U4nN/7RO2T?=
 =?us-ascii?Q?ei3B3U2zR/c/8WWoKYX+EBVGcy1ngpPorWBh5YRdMBI7TFUb6EzaPmnNvePm?=
 =?us-ascii?Q?xHsgcpcF/Ox1WAGC6di7mX62POYIGPDm4zjXQWEwtCmCRDggNMLyBKyBwxHY?=
 =?us-ascii?Q?Y18wUoT1IO0dahYaZ2PGLPhovcb/dUO/5p3YzUAHzWhYJEasw2VLMnlG+IcW?=
 =?us-ascii?Q?lqWLx2BqFu0MphV4VaIMVdhG9KxE8t9Gzmq3VHVYOylrvuWjTuYjpSUXIN/1?=
 =?us-ascii?Q?BnZqlzRSbnx6Ttvm02CB1aYlcMq4JaFNQ5+OGFMEgavA/RgWrjk8vCGiqigY?=
 =?us-ascii?Q?MtB4M4iLe4m9mvychNaUZgXSvt7AivLYI5T3xZRAB3Zsw2GJpNW66s2XkYvD?=
 =?us-ascii?Q?iE7x1Vq6V7prqhblcDKJ6cBFE0PBivTWlg0o8b4TVLrP+fUG5agr6Mzu3OkU?=
 =?us-ascii?Q?BjJqw2HAQfkYO1Ay1OXdVR4SNKogzjuDk2oYh+STNL4e85Bvk1JhsZtPAmec?=
 =?us-ascii?Q?7Oy55FVVwh6dIJzfK0bJdfLRq3CAl34qiiVfQ/yBjaSF3fWyD/VrWO28Kk8+?=
 =?us-ascii?Q?k4yCJnLJgXjdjRl53754e3tGczYaS5z0i/jqAA102gEqT4/pnstvydISl8PB?=
 =?us-ascii?Q?38hBXh8vn6cZi6xPgP5004SOx1osPzmweOUj?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:21:09.4479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c56fc6bb-39bb-42a1-2645-08dde938e340
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7186

From: Hans Zhang <hans.zhang@cixtech.com>

Add myself as maintainer of Sky1 PCIe host driver

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dcfbd11efef..965de0bc6fe4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19280,6 +19280,13 @@ S:	Orphan
 F:	Documentation/devicetree/bindings/pci/cdns,*
 F:	drivers/pci/controller/cadence/*cadence*
 
+PCI DRIVER FOR CIX Sky1
+M:	Hans Zhang <hans.zhang@cixtech.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/cix,sky1-pcie-*.yaml
+F:	drivers/pci/controller/cadence/*sky1*
+
 PCI DRIVER FOR FREESCALE LAYERSCAPE
 M:	Minghuan Lian <minghuan.Lian@nxp.com>
 M:	Mingkai Hu <mingkai.hu@nxp.com>
-- 
2.49.0


