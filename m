Return-Path: <linux-pci+bounces-40623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7859C42D99
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 15:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A5B3B2D31
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 14:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC221DFE26;
	Sat,  8 Nov 2025 14:03:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023135.outbound.protection.outlook.com [40.107.44.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B347483;
	Sat,  8 Nov 2025 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762610595; cv=fail; b=Oc2MnPaa7Idtr3KM9z2ARcKQkmQecQLLHyqkvt4CMRPZqv91aKRYyLCCe8MjpxvV020TyqYSj9ovKtsHfbmXaP+fVM1wWkqYEVAruxXfL0vQJxZX72kt3UgD4KOvjQ2j6d1lciQDSP+t+KvuUyE87zlAepx6JxdKUUT3fYJu9y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762610595; c=relaxed/simple;
	bh=36sa7N7W4pp5hgCTAKMPUG7EKSUpOY6ybDPscHm8Loo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIyqZNG2aVXk5QcReweq+sxPAcrm2M9oP0cQ8Cypt+H/Dmbnlf2XqDpJptltezA0oMprvaEEgkETJaQ/9dFMjUvB82VEytPMI4H0LQab/O5D17IZNB+wu3D+eCiLv7vSXFwnqV7p2e01LnP0Q7PQ7hTXslnTx8XNGIh7yGZVh0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dc6eWFjLIZ9lO7sXUYC9FZUocu7dd1birEYXHLcJicB2856sI0PRBF1+GnT5jB/I3RpbMEVqel4xrpMsiVXL0mAVTL0wxJAE/KitRiLu2//gTEMZj9sdoBtwus5NZQfyVczcDeqghIbxp8I+EJH803ESMSS+kJ0ZJMCpMGb+yDHTgG7zR5T3JsXFPp1W/V1K0K8YQ5Vd7xXEGhR1M/xO7BD7rNYyZZ9d+bdXgKRreSkReWYUo1u969aj/3SjljuA+Vo0dhpPWxYJWU+Mwvh9u4tgIBH/CZElH92qNI/TG/TosUYPkhNqft811HPKfgTVWGbVBolpHcha5DBxOFTEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBZ8Vp0CpKNoSuRD66X2jaGgh70reHb7BkxjJnYsx8A=;
 b=esXA0uFtKfiC8yUOA1qfVpzqijd5KRS/HbSwtBqAUysatzpGcuy7JJoyfI4TiPRIIZDhzSACuEbSfZ5tII1VSZvUZ3nn0JYGwWVjo5kTk6LfPFG1nYKu3V9JJsBqopyok/Dz4lLwJx/MBSFDj/C+WjHBDF6n199N5LGT+smJh0ipdXdqn0XSu+yt49uoWOMDKjSCuBiD/CRqE+7B7YnRlnuWzu/gdf2TBUmDFic7ohVHLiHjpKvF8sFsuvV8yBftFLb0vmVri1UW+kVZWqmO3JKOzP240U5aPsZo2EeZNkIEu3ZXrD2bN+1mEr103Tyg6jlWioDIsMNMypvMJfxmwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PSBPR02CA0016.apcprd02.prod.outlook.com (2603:1096:301::26) by
 SEZPR06MB6496.apcprd06.prod.outlook.com (2603:1096:101:186::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Sat, 8 Nov
 2025 14:03:07 +0000
Received: from OSA0EPF000000C9.apcprd02.prod.outlook.com
 (2603:1096:301:0:cafe::cc) by PSBPR02CA0016.outlook.office365.com
 (2603:1096:301::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.15 via Frontend Transport; Sat,
 8 Nov 2025 14:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C9.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sat, 8 Nov 2025 14:03:06 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id CD5A941C017A;
	Sat,  8 Nov 2025 22:03:05 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	helgaas@kernel.org,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 01/10] PCI: cadence: Add module support for platform controller driver
Date: Sat,  8 Nov 2025 22:02:56 +0800
Message-ID: <20251108140305.1120117-2-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251108140305.1120117-1-hans.zhang@cixtech.com>
References: <20251108140305.1120117-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C9:EE_|SEZPR06MB6496:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5a3abf19-5498-4333-105c-08de1ecf8ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qNPX97InEuS9pfIauQ6/B7jJ48umaEvCpTzFhjcAmqipJxVzbjtRgqhDca06?=
 =?us-ascii?Q?mN3iF5qAAcOeV6XLLp3a6lsANvC/2/JI4MC5IpakXAuH13I46JD/GW8fB0tm?=
 =?us-ascii?Q?99reLeExE8h33O6LnBrMYT1zBR5CJR2f3vYhUCHX+EnFB3Pt+keGxv/M6CeZ?=
 =?us-ascii?Q?LiYk5alGbQ3wznNbSKrBuHmFQdwiQ7UqUHhi3sBJUDk6MixnT/DD9T1TUo3N?=
 =?us-ascii?Q?HkiENxqAfLxuty2q4CesR/u4Cwzb/bguKpQ3O/JnwjfkofrKlW0NEGCaM6d2?=
 =?us-ascii?Q?4O29Epa2QnN0wCx0ivS2VK3Ckw2c5sHMfNC+LZ4kpuscjTmvqTGJcNxK9x/q?=
 =?us-ascii?Q?nqaUoL/s9DK9rx2W+erErWlGLXk6JK8c97f+i/ESA8F/13bXTd7y7k13+AOj?=
 =?us-ascii?Q?0PhpxqK/KqC2Rh29X33djkviqOjsYFWYT+WLGWlzT84L0Vra3ihbE7Rq9gLL?=
 =?us-ascii?Q?zfCusY3wmnQF1u7FsroYed1nlenHZt/+ZZRHhXy1YS/o28yl0tiyeg6tC7Ob?=
 =?us-ascii?Q?YBa4L8PUPSz36lmXxnkOr/LFJaGi3S11+OTvhUKzOI1C8SRsSN7R5wTZM29P?=
 =?us-ascii?Q?QrAOuEdfYGGoh0eWM1DFX2dbnIcAKMG4S+NgxAsWOqkG5B2eB65qXJpmNZC/?=
 =?us-ascii?Q?1saJw5JzY34ptoTbs9Zk3JCBMK50RhREnJviWKTE+jCnF9FTNk0Gn7OdmO9b?=
 =?us-ascii?Q?nfia11wZyDxEtEc7oSjznu7uPwCl7OrUVOxTWfy88nxDA5R4lIh0P8Gq7iiH?=
 =?us-ascii?Q?5Hpry0ZjecBd1lJb/XCssHU9W+I7INr8pYucEpD9CDE/+pjPD9nwpysQUBWo?=
 =?us-ascii?Q?+lB7xo1W/3sO7F7x1g38gKXw2VQ+KapmIVKxKMrRb1Our+OWaUbtMKNLUMuZ?=
 =?us-ascii?Q?hfFKWutacSkALZUwBV8h/U1IW09vlqsAY8e3bOI4rFycWSljNnECqeOTl+S3?=
 =?us-ascii?Q?0jYFOs6HhHf6BMle+5G3uDHFL/GcWi0eXAz6rn8nNg+VJ2t1fXrFe4rpWePM?=
 =?us-ascii?Q?ieSxgzfC9IW3i4iUGz06TA+QUmriCx4Us6q1/oRKNY3E6YcO0+GtM4O8PmhY?=
 =?us-ascii?Q?zDyMV5GJ23TQ7Dtbn2tRBn7SIP6nbMrMpdCytg3m3uEsuFXtqgxuRSs4aZup?=
 =?us-ascii?Q?JxFSlq9Ye+mnEvyjvwdDnZXc3EOHw427NMczNIv+glqcURD9DQY8cegtTnFH?=
 =?us-ascii?Q?piuHmx6T6QxaCF5BdBaWl1tUKpoanqfy0ZVbX8SSTX42WQeRFFok5Z/xsZ5U?=
 =?us-ascii?Q?UYNZsyHjS6+LxWR2FXgQDJl5suU7DzA3cnc490qcQDPkIopX9Inu4EjGRLgV?=
 =?us-ascii?Q?A+u5pnsnitRrbfGxLd4vvLaoMsWHvojCKaq+J3UN9BbFIOGRF/utm0Re7MSh?=
 =?us-ascii?Q?S8YL0ZtlrPR3yaO45NLqOaiC21eoIGwFLWe0qNvRT+42yo2T33knfkLaTQvn?=
 =?us-ascii?Q?E2iJCaLr8W5SV5ww7+qnNZNeQAZonzZPpNq1FHkP5NnrG24LjUNyqVX9ThVn?=
 =?us-ascii?Q?M706Z4bq0CtR34KSq9Gj+4Tqc037bwDOsqwLwRKn1fHJ6aw056Oxl+zMT4g/?=
 =?us-ascii?Q?aW4UeF585f2CtqsJOBI=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 14:03:06.7166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3abf19-5498-4333-105c-08de1ecf8ad4
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C9.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6496

From: Manikandan K Pillai <mpillai@cadence.com>

Add support for building PCI cadence platforms as a module.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
---
 drivers/pci/controller/cadence/Kconfig             | 6 +++---
 drivers/pci/controller/cadence/pcie-cadence-plat.c | 5 ++++-
 drivers/pci/controller/cadence/pcie-cadence.c      | 1 +
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 02a639e55fd8..0b96499ae354 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -19,10 +19,10 @@ config PCIE_CADENCE_EP
 	select PCIE_CADENCE
 
 config PCIE_CADENCE_PLAT
-	bool
+	tristate
 
 config PCIE_CADENCE_PLAT_HOST
-	bool "Cadence platform PCIe controller (host mode)"
+	tristate "Cadence platform PCIe controller (host mode)"
 	depends on OF
 	select PCIE_CADENCE_HOST
 	select PCIE_CADENCE_PLAT
@@ -32,7 +32,7 @@ config PCIE_CADENCE_PLAT_HOST
 	  vendors SoCs.
 
 config PCIE_CADENCE_PLAT_EP
-	bool "Cadence platform PCIe controller (endpoint mode)"
+	tristate "Cadence platform PCIe controller (endpoint mode)"
 	depends on OF
 	depends on PCI_ENDPOINT
 	select PCIE_CADENCE_EP
diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index 0456845dabb9..ebd5c3afdfcd 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -177,4 +177,7 @@ static struct platform_driver cdns_plat_pcie_driver = {
 	.probe = cdns_plat_pcie_probe,
 	.shutdown = cdns_plat_pcie_shutdown,
 };
-builtin_platform_driver(cdns_plat_pcie_driver);
+module_platform_driver(cdns_plat_pcie_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cadence PCIe controller platform driver");
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index bd683d0fecb2..8186947134d6 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -293,6 +293,7 @@ const struct dev_pm_ops cdns_pcie_pm_ops = {
 	NOIRQ_SYSTEM_SLEEP_PM_OPS(cdns_pcie_suspend_noirq,
 				  cdns_pcie_resume_noirq)
 };
+EXPORT_SYMBOL_GPL(cdns_pcie_pm_ops);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Cadence PCIe controller driver");
-- 
2.49.0


