Return-Path: <linux-pci+bounces-33900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9058AB23F84
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 06:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2921AA3AD4
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 04:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7922D2BE62E;
	Wed, 13 Aug 2025 04:27:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023115.outbound.protection.outlook.com [52.101.127.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8251C27F003;
	Wed, 13 Aug 2025 04:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755059235; cv=fail; b=gBiTDziwCbIWIDIGcz88ZROQMfgMQMjRgBA5JkCUH60wNeRY8+/Pbdqi4FNr1usTrMsn9I7X1G3VBXhJfgqi6z1KAV+DpAINojTnKLS0mOKJTORQCDzssmlY4dUfnsNc+fh5MWdK9qL9ljP/0Qb1P/WA5mllZYrCmymbOWnMMjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755059235; c=relaxed/simple;
	bh=dL58lVZOV56FjCVqzx7icAqj+w/8ebJ6hDO3ug2e5V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9qBSTPhcvSanSlzKhgJf5x4IEGvCW8RBZ8m/clLo4KQRFEnS5ccsmomFRcTB8jBdthaRRItVthaE5J2YyhBw0b/aPQEJkQhEdJ+Hh/KhMMNfhQ8eEouD6jvLrtQSjVJ5VrN6gROgKjz7qXgakYQKYHtFk/WdojKABEHKwWNGKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUaKJ3G3E948v1nQSYWtU9UZDRdeeen3olNtCrLMfy6GO+0xjTE03k/86zrlwScAwkHQdBeuql/BM04KsIJ0AIBbDe4N0ogQA7SweiLR+YJCbLOpZCshAc4Z1gEWltmZBDbU6W0LfblTMdl3g5iiBDrari5hnbL2AYG1CIaK7YYiHTUYgyz9Ep/DPOHumkdxKwp0ZEEWjkNPkDbw0IlYVu6QjTX4oS04UrHrW0iyv/MSuwnM1zju68Dsdddjr351psEUXYcXQdvrzgZWV08mA+qN/EPtLJ8cbz+Lp/r4+seOfhPQ5TqP50wGRlKyf6nFFX4+9RQ4/zzqz0HE3aFn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFQ3o8Hbl5sVX6EHvA75g7M89vJOrUH+9L38PTkH+ZI=;
 b=TB7VXItMzlkmMSHJwJTC2nsf2ust1/21mMYdLXl/R4+xkALpg7gikbwCsgGh4+rQaaSrbVEVrzSi8GM9qF9apPTMDb/o51HUvpp2M7uv+ZStYCZUkUlVzBop6ugsf16urujjDIAYfYHtuPX3hcqrFqEu/lhilDFxOVlOtg8BS8Pr0PnXdk8toN1SCyIfQIECP5EfDTQ3HBSstyZbWWPsmELcnmcRagVZJCrwm/2bKw58HWbmbT0JUeRmksfgs+VSumD2vbNurjbEs8YLW6DsAYxpaQDdkCFrCk0iKTdl+LQ6rHja7Otei1lq6lRWY9fPjZGlTHWIWTLwGZDTJiiFRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SGAP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::20) by
 SI2PR06MB5244.apcprd06.prod.outlook.com (2603:1096:4:1e4::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.22; Wed, 13 Aug 2025 04:27:06 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:4:b6:cafe::c2) by SGAP274CA0008.outlook.office365.com
 (2603:1096:4:b6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 04:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 04:27:05 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 7F40E400E6CC;
	Wed, 13 Aug 2025 12:27:04 +0800 (CST)
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
Subject: [PATCH v7 01/13] PCI: cadence: Add support for modules for cadence controller builds
Date: Wed, 13 Aug 2025 12:23:19 +0800
Message-ID: <20250813042331.1258272-2-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250813042331.1258272-1-hans.zhang@cixtech.com>
References: <20250813042331.1258272-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|SI2PR06MB5244:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3d86fd7d-ed16-4795-9b7b-08ddda21a8b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uz1A3hclSnvMIs/f0/cDXrhNf2+UtrNnr3eozH/D5VIRE5WHKCCkcC8JR1aR?=
 =?us-ascii?Q?x2a/eg/2rmuqVrN6ywalTIsqTrbDVRK1Lz98w6+TjkVdFUeDMv95pt9sLBa/?=
 =?us-ascii?Q?ESXu7s6R9Z70gBd4j0JTfG+TZ2gnKMxPtb/ztp14Uc5V84v+2maS9dxRqBPK?=
 =?us-ascii?Q?CfDsQeORw7LWX8SNBzmIogS3NwMy2nRroi/OsHPidJgpe4Ok2Ke4Hobs7IjU?=
 =?us-ascii?Q?5VPEDLhmFFk8NNA7cx+Bp6IKWdiWnD8yPb28pw4YoC9ihdstfXpnR7N89zX5?=
 =?us-ascii?Q?8hambk+8ZDNDRe6Dmd7eN0dX9RbqqzA8NImHmCFX6bO1K3psZUvBgjAsTo5a?=
 =?us-ascii?Q?5hbQ1wTvVAijhdZEw1SrfdAM04a/DGcWHZgeLDoy9cPYlD4hR2VDWXRi+UH4?=
 =?us-ascii?Q?gSFtW/pEOp+gsUFXhlvFtJC8/XyaH7vPyiluBpMPxIX8I1VHtIpHTcyPC8+W?=
 =?us-ascii?Q?3xaADDw9ckKHJVJNY1rHx8Tl47A+7Fcg3Db3jxxWmXEfnIUqJ6K9LrGKjfPu?=
 =?us-ascii?Q?I7G/9Y+Tp/D67UL2dDaB4fytWQviS9vpFsNxXPEYtaduZsJKxRN7Gq1QEHDV?=
 =?us-ascii?Q?CdGnPmr/QWW8nRIl2KC//2s8fkFmS6givSUsUzK58UrLG4nDBozqnPtXIF6W?=
 =?us-ascii?Q?PLtlIIc6Ig3CcZnS5fBYUgfW7Gaq3JLvBPbUEZXVU0iAiqVdtwCfZvbr0sLr?=
 =?us-ascii?Q?57XG3rqf6MkmGLw7NLecoT5bhKcnxxGw2MDaq9/NBt9kZwXAFQSNSYmecT0m?=
 =?us-ascii?Q?8mVEjTl5fjZN2bCJXBgys6G04BphNsUdeclKH7yNqnbENgbfLyaBk/X2MCoT?=
 =?us-ascii?Q?9moN+WzxCuhewYaG8bjwWI8M8RKwSDus/uAr0PhSt4pX9y+IHXG/mczzEIcI?=
 =?us-ascii?Q?K+LNl2TVTl/gkWmsUTp8yvyUpKa87M94u3qECca+GQbWtfJ2zqRYl4s0aRB4?=
 =?us-ascii?Q?L6GN8TkqWf+ZjbKjR8NPjH03mRN8qhJ2ZgMFzoyMkL7lO8Uyx0FXsmTrIiKt?=
 =?us-ascii?Q?jIF4kWzDOmEgiTE9omKgkQTGHt1Gp8zGkCxOcmEMOnCZGGwzGIwXTFtw2dsL?=
 =?us-ascii?Q?zSfxjbEz7vATh139um6pwgxc01+dzLI8x51qiw7fpN3H/JCNSZSPuOZ59W7z?=
 =?us-ascii?Q?tChRx1XcAr+0/+r4w2Nzs/4i4RdB6VoiZAHax+F1y8BhK4/5xV5UeRXjeaIl?=
 =?us-ascii?Q?5bwyvpRtLzrPcgZYV06a/wJFx/ZKfKFvi9avJR0avyU4QTAyoWgClV4DbBQc?=
 =?us-ascii?Q?yQLxZjYBMSxm2PEfvsQTPvzVdXVV4eBJokm3GweQntGuUFw/iYLjWPBWBr3L?=
 =?us-ascii?Q?Gi1CA79PK5TY39JKz5tXlB9vhr2+Eg1D+g5IkEedTp/TJKdDU46dwylooVPY?=
 =?us-ascii?Q?Vq5Ajq5tQIVGWiN3W7yr7yK/GXcDMn1uGRkgYqXM9j4g0Youlbur0P+GEv1c?=
 =?us-ascii?Q?7hPzoXNh3O/6YrBqefaUHZUouUpNPofdRXcrDsMBGWxiST+U82b+z4UPo1Xh?=
 =?us-ascii?Q?v7DHwmzADVoxTO9v8YoUokY3H+yaE28JPna+?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 04:27:05.3837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d86fd7d-ed16-4795-9b7b-08ddda21a8b3
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5244

From: Manikandan K Pillai <mpillai@cadence.com>

Add support for building PCI cadence platforms as a module.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/Kconfig             | 6 +++---
 drivers/pci/controller/cadence/pcie-cadence-plat.c | 4 ++++
 drivers/pci/controller/cadence/pcie-cadence.c      | 1 +
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 666e16b6367f..117677a23d68 100644
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
index 0456845dabb9..c9330aa50a88 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -178,3 +178,7 @@ static struct platform_driver cdns_plat_pcie_driver = {
 	.shutdown = cdns_plat_pcie_shutdown,
 };
 builtin_platform_driver(cdns_plat_pcie_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cadence PCIe controller platform driver");
+MODULE_AUTHOR("Manikandan K Pillai <mpillai@cadence.com>");
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 70a19573440e..5603f214f4c7 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -279,6 +279,7 @@ const struct dev_pm_ops cdns_pcie_pm_ops = {
 	NOIRQ_SYSTEM_SLEEP_PM_OPS(cdns_pcie_suspend_noirq,
 				  cdns_pcie_resume_noirq)
 };
+EXPORT_SYMBOL_GPL(cdns_pcie_pm_ops);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Cadence PCIe controller driver");
-- 
2.49.0


