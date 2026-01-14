Return-Path: <linux-pci+bounces-44819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B90BAD20D4C
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E92330BC72E
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76E53358A0;
	Wed, 14 Jan 2026 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5dOOJLCs"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010054.outbound.protection.outlook.com [52.101.193.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E96233555B;
	Wed, 14 Jan 2026 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415205; cv=fail; b=CDpfRKiOl9XsXnaRSfva+SyKwu0Mnoi6xMA6+myioGc5n9qH7E46fd3NY34fCBLLxnihxhjpZtOL9wcWrAwRzUKUfvZE7o6Nhvf+F2NXhFQigxfHFDvB/r4HIXC0WkL+hC4vcTAqWzNowADjTbuZzQLhur9DrTXoAi9bRc76bVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415205; c=relaxed/simple;
	bh=hV1wCyIMX4rcF/pzsUNELx5DQ5dbvL7fb3vSpX+cf9w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWoqUG3Iqpw6nlUxv5hcz8SVXDhIlJPVXV65elNfFvH44bcpMU09hhBUSB4A4KHrDCeAzMgrzvz2OHLOOj8yM2h/CSdC7AfBhUfZosNmhxFL6xKUH3wRtiDJ/YkJ3bUeWpAJZZjWEALod8VSAGs6ixKhvezUDO11aU+l0m5jphk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5dOOJLCs; arc=fail smtp.client-ip=52.101.193.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHYSuJOmOwb9z2kF9wBA52awvC3wt1cJkKbmlW5/WNcDpfyq95vn9UYARC4S8Kf+WpW3SYHBi4Z6O8vqJtzDDDMlRih/fheySfIh86rQEqt/Tn3VkKPkZhSH+DjCTWjOsyU4o56nlpZKQUcCA9+6zCad0Gzo6yzduVQvIIHQhVM3Ymb0m3/hMHS0DKklHvaDRE0DL+U0q8iOoFV/xpAH1KKDs+KuPnRxNb1pmHPqNcCFbmbNZVEs7e4aSw/O0kIy1ScGd/fNsGmeIkAZ1MLGNCY2N9YiKM2PToL+z0qFIn2Y1P0gFZWSCAY4VgrwIO8QDVS6mqztt2M7CyNZHNoaBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvzD5gaxgmmrg1+5t0zcwvJy8ERr3yzC/DNLAWM15+c=;
 b=PGhXoctcFSxgh88cC/IhxnRf9cg+wjVFwo51N/Dt2fN61YFRmVuCLNcQfbDhGhPslkfrWSz+HI0UxM8OBEVYR7GvtNRRw4LTbjj87yrwEYDm3r8EgnM1swC1ipWizqkJMUCHzyJdSBS8Re5p+oIrm5FFUVcA5l2QzpKF0Y/CdsPJpGoQspBJ1i0fQeresHgD0MEWBXGPsaq7XHitxFc79hmUJ0aPHuNVORUovIx1++vd4ZCGBm/8iBJqeiAaoi8u4Duo9wSuTiuFaRLki8a2UtlNjmlVgM7ChCwreN0y/vtormQ7iNAcbrY2BehbMGpDv91lzfc3Ubz/+zfKmsGOIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvzD5gaxgmmrg1+5t0zcwvJy8ERr3yzC/DNLAWM15+c=;
 b=5dOOJLCsHw7jp7MTKY9S6WKzoQ0mT3abL14M7dEjGUPHLh3WSZEiFieVxbgum4IOUR/8YvExMPX/MiJxs0BgmIMhK2nFDGD673JPN4NZGPNPQ8nJbbauTVJEfGFqrX2mFHAVEJGW7D89bZ0ggUjO47pE9iypgZLTqFm/ihKC/Vk=
Received: from SJ0P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::23)
 by CH8PR12MB9741.namprd12.prod.outlook.com (2603:10b6:610:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Wed, 14 Jan
 2026 18:26:41 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::11) by SJ0P220CA0016.outlook.office365.com
 (2603:10b6:a03:41b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Wed,
 14 Jan 2026 18:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:26:41 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:26:39 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v14 26/34] cxl: Change CXL handlers to use guard() instead of scoped_guard()
Date: Wed, 14 Jan 2026 12:20:47 -0600
Message-ID: <20260114182055.46029-27-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114182055.46029-1-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|CH8PR12MB9741:EE_
X-MS-Office365-Filtering-Correlation-Id: 740c7cfe-e084-4e95-5d47-08de539a768f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|30052699003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TEmhSVtJn2Ykhb+iXN/XeRjoXs6MPVqvsXovrYohQV1HcLmS1yU5MqjaThQY?=
 =?us-ascii?Q?FoJAqcCi5yVQDIcF1t9yA3UEycJl2MHlkG1J3zjVRlbt4U4rzFDkWH+bFwU2?=
 =?us-ascii?Q?bS28O15OckA7KBZ4soWVsXVgC7ViFqF/0HJDRjsvk/lKDX631kPATCM3Dhn+?=
 =?us-ascii?Q?wLmOfUhxEyuI3HhIb4NghDkwdvJClDfcZXo451P9Pj23q9t9PwKcLfwln4jz?=
 =?us-ascii?Q?ydZPrTRHfey14rPySZwy/bfVjYovwLPh/XfgA2maKBSILZ393YgB2KtEdCPt?=
 =?us-ascii?Q?cqmk6hhg7D9or5wFyQzbnt5OHjMuRTebP7ok6K1/kfhIewpbkELwYaaTDCTo?=
 =?us-ascii?Q?2jJexcBYv42wQxKFXd82cli1/oKaAJjmCdtVA4IcwJ4kwObYnNF1oKQ6lgu/?=
 =?us-ascii?Q?QS7Rm3Ya0GwAzJ5j/plZjqCdOIb0KGFD0k8GRyIk9ZjDdKLdPJPScNGD2D/z?=
 =?us-ascii?Q?lvGkZvfCRw91h3oycJk6kVRp5lPjjN0MdrcdzdqreshJ+s3The+yEoxeprTj?=
 =?us-ascii?Q?NRPreiXWkgA4HWKG3yJUVCL2RVwqAGj4m1pzv4IEbPiesbuIi5wSXhf2Qgsg?=
 =?us-ascii?Q?uqKN4FMMq8mIXwtQcjWpyfQOxhsWq6gN0kznXHGwIokantRUBMVkacWVxqD/?=
 =?us-ascii?Q?Ss1cjutBwEV2D7CcUnHzxAaiXUsCBjlod0ugm7Xn+69/Nb9HgraKviR6Gy9z?=
 =?us-ascii?Q?IKffYv5jnHT1qyIweIBPCbJ+IuE8P5spCwxfXjDcXg34pAJA4dR+otav3CzY?=
 =?us-ascii?Q?lC8kaKWBukGeGeDqyMiwjG/kSL3k6p2IXRRu2kcPOY+7KdqKGDmsdAxnaAFW?=
 =?us-ascii?Q?CAZTWKrlHeYQofR59OGuEudRPG3iXfP6QXIlnR48GOHaHs84go/E3KNZlMbn?=
 =?us-ascii?Q?+d/VHUGvu7ZzF5AdEFNbcz7oesZIiywKQLZumtT1Y1f1kaGfj5fSLi1jDkon?=
 =?us-ascii?Q?noiegZbCWq3vvRuugdHdrzb2vRMtOCiMxlJuG01fjLCzaoXxnU1yuzj+/Ijz?=
 =?us-ascii?Q?Dnb7ETJaD00sG2B7eYRb+e+1tnT0/YbiYee1EVvsNMKQYaDut5JnSYGpKxOy?=
 =?us-ascii?Q?agj3dF/lBoQrxigXXbMITYyDjwRUd9T8xcwlkZjg+p72hEtIMr3quolswbp0?=
 =?us-ascii?Q?u3X3GfdWu8fSuPJA5HEcsDtfphHPjcg8N/viNjwPynJd65qPvIn6SENiezjm?=
 =?us-ascii?Q?xaNrK2qnB6NrEW1mUVUpmFxD1mRuVTNK3ND+Su8prCXt52HQmK/I0UCVWhXo?=
 =?us-ascii?Q?NDgk70I6JeGJl9r4FM0G/zIWS7XZlzoQTsxNTwxy484ZAQl+HLdQwmRZfZiq?=
 =?us-ascii?Q?+rejuHTFnK4xeF8plVU876ktr2ezkdrN1jhneqY3cR9o4lpFMjGwiH+xDsjn?=
 =?us-ascii?Q?rd8Vit92U/NAC7Abk+r/26ej/4sexbznUIQ/+qmGKrAwIOGujYo7qo947qHs?=
 =?us-ascii?Q?XxKEj4We0M7tg04aE4SpxYpAe/WEmOap7py0h0ghnP8r2/c8IJqW4Kphz3/B?=
 =?us-ascii?Q?fNGxC0EkCNixb4kEEbsod+vztGA1Fjz+Fpt2qqo95853U9bq2hbU42ATd+KZ?=
 =?us-ascii?Q?jGkyYsQiIRwaD/EUad924lWBQTmIutODUce8SUQJgA00ddNpQdSW9YHHcQYY?=
 =?us-ascii?Q?hUMAx20U3GsqDo/2lhUcJA3PDzugnOnvU2wn/bghvRwULFc6nZv7sSpNAV5X?=
 =?us-ascii?Q?+zwjZXVIi8WYfYxeIbj0XAG0piQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(30052699003)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:26:41.1026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 740c7cfe-e084-4e95-5d47-08de539a768f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9741

The CXL protocol error handlers use scoped_guard() to guarantee access to
the underlying CXL memory device. Improve readability and reduce complexity
by changing the current scoped_guard() to be guard().

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>>

---

Changes in v13->v14:
- Add reviewed-by for Jonathan and Dave Jiang

Changes in v12->v13:
- New patch
---
 drivers/cxl/core/ras.c | 58 +++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index b37108f60c56..bf82880e19b4 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -250,20 +250,20 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 	struct cxl_memdev *cxlmd = cxlds->cxlmd;
 	struct device *dev = &cxlds->cxlmd->dev;
 
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
-			dev_warn(&pdev->dev,
-				 "%s: memdev disabled, abort error handling\n",
-				 dev_name(dev));
-			return;
-		}
+	guard(device)(dev);
 
-		if (cxlds->rcd)
-			cxl_handle_rdport_errors(cxlds);
-
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial,
-				   cxlmd->endpoint->regs.ras);
+	if (!dev->driver) {
+		dev_warn(&pdev->dev,
+			 "%s: memdev disabled, abort error handling\n",
+			 dev_name(dev));
+		return;
 	}
+
+	if (cxlds->rcd)
+		cxl_handle_rdport_errors(cxlds);
+
+	cxl_handle_cor_ras(&cxlmd->dev, cxlds->serial,
+			   cxlmd->endpoint->regs.ras);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
 
@@ -275,26 +275,26 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	struct device *dev = &cxlmd->dev;
 	bool ue;
 
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
-			dev_warn(&pdev->dev,
-				 "%s: memdev disabled, abort error handling\n",
-				 dev_name(dev));
-			return PCI_ERS_RESULT_DISCONNECT;
-		}
+	guard(device)(dev);
 
-		if (cxlds->rcd)
-			cxl_handle_rdport_errors(cxlds);
-		/*
-		 * A frozen channel indicates an impending reset which is fatal to
-		 * CXL.mem operation, and will likely crash the system. On the off
-		 * chance the situation is recoverable dump the status of the RAS
-		 * capability registers and bounce the active state of the memdev.
-		 */
-		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial,
-				    cxlmd->endpoint->regs.ras);
+	if (!dev->driver) {
+		dev_warn(&pdev->dev,
+			 "%s: memdev disabled, abort error handling\n",
+			 dev_name(dev));
+		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
+	if (cxlds->rcd)
+		cxl_handle_rdport_errors(cxlds);
+	/*
+	 * A frozen channel indicates an impending reset which is fatal to
+	 * CXL.mem operation, and will likely crash the system. On the off
+	 * chance the situation is recoverable dump the status of the RAS
+	 * capability registers and bounce the active state of the memdev.
+	 */
+	ue = cxl_handle_ras(&cxlmd->dev, cxlds->serial,
+			    cxlmd->endpoint->regs.ras);
+
 	switch (state) {
 	case pci_channel_io_normal:
 		if (ue) {
-- 
2.34.1


