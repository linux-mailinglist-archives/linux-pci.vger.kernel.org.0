Return-Path: <linux-pci+bounces-34280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A590AB2C25F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 13:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B205E579C
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D703314CA;
	Tue, 19 Aug 2025 11:55:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023076.outbound.protection.outlook.com [40.107.44.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B199326D63;
	Tue, 19 Aug 2025 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604517; cv=fail; b=EgN4RhOETtqmiZP0Fz3miLXAQ7Ij2/E7rEwRcUk4jS9xcgwAfOSwVfy8KWF2Q9XdWw2fam/9ijigdZyu/eC2kxhNRH0W4WT290FgzSFNrzWGQsiNe8316oZOK03G1eLGtklnXfFFtENuBy9OIWWSMS1jTE8/qPgDZ260w4LwT8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604517; c=relaxed/simple;
	bh=xB7s/L11s8XafWLm3UDOCd4o5qOzY6amgd4eu1x2OSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATESMJqbvC6wPW4REL6TllSOmiwyKPWWFD/T5j5T86itCspAP7iSsgtInCTmUiUm2smhUu+fd9V8NYAbgdHI4TEZHVxJ6a1Wg/+HfY2dm9+4Bqky+7lU4ro1uzbsi1mCKhxwXhrjXtMJponMeY3pgSyGKmyJAwTAgp0CuHJDmWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJxttdF/hsgI6+jhhhCLNQzTxFkFaFhWlGTU2NtIerlBTEdwt2++FZFYTA1Y1PLwa3KOg5c4/ImuwSOurxoMDsCrnS2TFJa9DngmW7qvbb89+bI+9rOVdvXp2b8PPTNDR/msoxD9j/nFuWNczTdItR3WhtoG68sXxroxFq+m5q/Vw0OKSxdUrCujPsPwSY407kfuAqN8ief04Kr+L2HE2592ryTUVerpJOYHbitAOM2O0PTmSoSrQ7D3FWZiWhOKf2AKN/PvCNyK1ozB79FXn6ss9Ld4Nbyvq68/bDZ9VDn9Ne/QA5iaQpyBxPKmP0BEaTDaqhWIJd9oHJbjrfAzWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1Q++zcAAE1nO+mh6fN6kkVO0qzaDUud0SsrxRUwW9w=;
 b=IY7/AyvgtBwTrKboabe2uQhKngmxbGbSdKDnxv2LJPNKpyEJoLmAGA6GdxbAO3bYDRSg/AXKTLlovaiEozPcYEuyfq2FmmnT3MRemMkheeGCGfWAtPOXLpw+NwyIxvwNhOvvTf5VajmoMf8yPYwMypZjVvr4yvcin44jaMviJ0LwgYeDqM8VP3yMJ0ZyCvhjesHkdibSUeyQ3iGOx9Mta2UjKF6L26hTDan15NEIafbmT2oQZLHsiKySV3UPQrdzVpSAv+VzadR9u0+yqRdRHxuuI4HTiqY1YnPq+tPl88Ye0s/MBjdzzqz6JoX7V4T7Q0wzxwuRzNifxJfhvhIxyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0073.apcprd02.prod.outlook.com (2603:1096:4:90::13) by
 TYZPR06MB5805.apcprd06.prod.outlook.com (2603:1096:400:26a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 11:55:12 +0000
Received: from SG1PEPF000082E7.apcprd02.prod.outlook.com
 (2603:1096:4:90:cafe::fb) by SG2PR02CA0073.outlook.office365.com
 (2603:1096:4:90::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Tue,
 19 Aug 2025 11:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E7.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 11:55:10 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id BE1EB41604F1;
	Tue, 19 Aug 2025 19:55:09 +0800 (CST)
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
Subject: [PATCH v8 09/15] PCI: cadence: Update PCIe platform to use register offsets passed
Date: Tue, 19 Aug 2025 19:52:33 +0800
Message-ID: <20250819115239.4170604-10-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250819115239.4170604-1-hans.zhang@cixtech.com>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E7:EE_|TYZPR06MB5805:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 71a39d6c-ee79-4194-9358-08dddf173fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tyYIJdM18VcdAGDp6ICfELybQFaEN4E0LPduzk9eTbjHwtMLkdz08mlswTW7?=
 =?us-ascii?Q?1eYTH1Ep0amEKDo1lcUnxYx/Kp6+YNAYHhwgeA1vLve7cJyGH//ctBL6m3b3?=
 =?us-ascii?Q?SYDZPhwc9dfnXEobQArAPc9Nqzyy11kb+3onSRThTuHfQYWf0JgaushVOCJO?=
 =?us-ascii?Q?CDvXXrM3FRJbBFUnfc5XjGvktuRtRbFbMtN/Ajzebdmxaa0ShNiYii0n5Vc/?=
 =?us-ascii?Q?l5B6Ppc2DG4A4lEEOFXxfOSN3b4aU9aV1x4aKm9TKw5tFXARA7d/H/I07/4e?=
 =?us-ascii?Q?Y9Gz/BEaLdtpi5W5JYsM3mNKEJEW36sykAFvK8D/GcBRWZV12qEtqFHcgogY?=
 =?us-ascii?Q?EH/OI+xTVW6PzDR9tcGHIg2vqs6Eeh5VHOhduCNwbs54tO9IOYSuAwOq/WD9?=
 =?us-ascii?Q?1oyNN+EvNJRiS4kknVqC68W9sFbky0jWby/w5/K/XcM44CQDVX8J6/ETsz8N?=
 =?us-ascii?Q?e1RCs/cf0qk1aE9gOCsLWKUDNpK7asRMPd0DPglFxcwlrfG8aQaNI4ipjAtl?=
 =?us-ascii?Q?rK0nj6rR8+/ahEqozBF6aaLy1Z0PeyVU9UqQjXc2wX4dXzSeIMfOzQP+sgk2?=
 =?us-ascii?Q?Nd/qSh0KRdQ90agP2zSIl82G/T/39G4JY1ZMUyel3mh75cELf6/wRlRGq5hw?=
 =?us-ascii?Q?02tA/mqPRHNvEIQjfBTFNo+VKkwFTkdigDiSs2XCWoMe8hIJaQMYTaEiZAoE?=
 =?us-ascii?Q?8SFEdjtOtISP4JYX4poxtA329eV/BU6EEXKUAdEIAm1llVmWQm4Vv7Wfj0lC?=
 =?us-ascii?Q?wTwGmq93fy4kYsrQXtgPYbUc6TUvN4pKI5aqbtx/D0PVb8rUf3EQ3L5lrzLO?=
 =?us-ascii?Q?suV3PgQYX6tpKwf+/KYdUBRhQn/dNU7eRwCMpcc/22jVRpxG5szZMT7xan6X?=
 =?us-ascii?Q?nlCceLlKZj6bwgcqqX5CQkEhP038e34MH+mHO7xsdrTyjox7Rl6NTmySv5Xx?=
 =?us-ascii?Q?Hk5YIOZdykzM2yItnRQ/bU9CZYYCKYvNo5ennXzVevRtBM2YImJTIyFsyIaa?=
 =?us-ascii?Q?P8pzJo0aFJn6B04F+VWUQlbzvPN5K0OUHZ+Lma2pyKuauVELEqlPS4J95cmD?=
 =?us-ascii?Q?RR0HI8TVobAy87K0fIgRCHKyMiC5ZYR3J16D95R9D07w++yiO9eM1gQru88X?=
 =?us-ascii?Q?HgtX3u5IZKTsdFwT47lMm+yzBFrO+NVbMkidNy6tmucvyX3ucAUlAPJtn8q6?=
 =?us-ascii?Q?CRy6og9QktUio48G/V+FzxgXA10xVHsXTRjTJXueVobjo5unQhV5JTDZtJLc?=
 =?us-ascii?Q?mTAkDVEdL2AbO8J9FyDn8a4cKuNepOWIYUhQo6iOMrRY9JWp79gpO4MmODm4?=
 =?us-ascii?Q?VDdsCzTM9+LExct0A4rXJi/V2QiIEjaEJBi4/e++SHyf5UUyfHtWqnctPG18?=
 =?us-ascii?Q?vgmIIz1D5BarTnV1fKPv1uCmiHKIkaL1nmI+NBiJyMIZcBcjPy/TRu3cGDOq?=
 =?us-ascii?Q?zliq8+ezCRMylLOtt6dB4llIaPffMa7J7QY/j+/DrSCRMPqZ6QZoyk06BAy7?=
 =?us-ascii?Q?RN2fZ+HrTN7Sw5uwWr26Us0dm/gVOQaiSJTc?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 11:55:10.3568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a39d6c-ee79-4194-9358-08dddf173fde
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5805

From: Manikandan K Pillai <mpillai@cadence.com>

Update the PCIe Cadence platform to use register offsets that
are passed during probe of the platform.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/pcie-cadence-plat.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index b067a3296dd3..927ab5b8477c 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -31,6 +31,7 @@ static u64 cdns_plat_cpu_addr_fixup(struct cdns_pcie *pcie, u64 cpu_addr)
 
 static const struct cdns_pcie_ops cdns_plat_ops = {
 	.cpu_addr_fixup = cdns_plat_cpu_addr_fixup,
+	.link_up = cdns_pcie_linkup,
 };
 
 static int cdns_plat_pcie_probe(struct platform_device *pdev)
@@ -68,6 +69,11 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 		rc = pci_host_bridge_priv(bridge);
 		rc->pcie.dev = dev;
 		rc->pcie.ops = &cdns_plat_ops;
+		rc->pcie.is_rc = data->is_rc;
+
+		/* Store the register bank offsets pointer */
+		rc->pcie.cdns_pcie_reg_offsets = data;
+
 		cdns_plat_pcie->pcie = &rc->pcie;
 
 		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
@@ -95,6 +101,11 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 
 		ep->pcie.dev = dev;
 		ep->pcie.ops = &cdns_plat_ops;
+		ep->pcie.is_rc = data->is_rc;
+
+		/* Store the register bank offset pointer */
+		ep->pcie.cdns_pcie_reg_offsets = data;
+
 		cdns_plat_pcie->pcie = &ep->pcie;
 
 		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
-- 
2.49.0


