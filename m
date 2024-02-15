Return-Path: <linux-pci+bounces-3541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C312F856DEA
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 20:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DFC1F22A1F
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 19:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFAF1384B8;
	Thu, 15 Feb 2024 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JWUAXw+g"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FD113A248;
	Thu, 15 Feb 2024 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026078; cv=fail; b=NBIJbCFYJyRjPcssywNB2N6nPKVw6z+Izl2yV1G+cz5F1nlx+6SW/V28h2c+J+u2XTNkZPcmEaDr9MqAlPQ5452GccOXxXhfekFdMU47/pTMaKAChwR5DfZOko2v3c9hmc6m8QjtGiZwFm43KwbwAfg5qW+iW53/b0pNizymbmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026078; c=relaxed/simple;
	bh=JXqPdMXt6CbokhP5mok034N7L/X1CbfuUxIGqdxTGBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jebwBLj4ggdUYL6L0Nph34yvxAkoX+/8KyNYcqG78zAt4rjuTd3UjNiagUkDOd48+5Kb5mXs3n6jp/WbPo3bTnKBAja7liPk8ubaD7C+OQVv+jMn/xsjikUQz5d+N3tl3a4RGTlACiqArFnYlo+jL86LSuG8I3ncbVBfS7t8EyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JWUAXw+g; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTJXViolS9xZ4H7G6YXriQMH86b3DTk5zX2qWIlHxfab5fEuq3yps03k2TeO6z2g9EakuTXtasfgQzSsje1roASghYvIzdBSbqtqlLajuRPe1oPl7OEMg2O5+DyYks19Jx1XGIsZ8wQlOVUD+RH3oQTrzp4pcX+Xg6jOxc45+UjZ3glrxc3oGe1wuc8MUYiZH7aiUBfwuG9dXVcLWtDvmPI+oR5m0/GLETgQe/uNDcW+QEL2TKolZpL7TO/Yv7hBXnaDNfsX5MlZS3rS7Y5VvBoDpOc/x+sIL/v95uLpyxJvCdHrN9ipjfI/lvjLF3y0Sj8kdtUHvJeGb1yXF29jaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7r6sxSfeC4UlsMHFH8tthI3vXsKCT0B14fb8Mhn9aAI=;
 b=a0PtwxiCPd3Nm9kdjM0OtkJUUgYdm6xpYm+oSQPapBg5xGjmaV/HbOGzidcSnKGWlDQE6YXarAysjm97ayV6ivaMWF8j7kkYov3NBLt7fso8g8j3aqxVCgD+LZGJaBC6af9IuiToGMIAa5ZyAKV9v5usZ0WKOQgaPM0q/dEYaA3karWpm4+SjVHC0H/Fu/2Dmyz1rk4Y5hJ/rzBRM6paS7xUt0oXGzyg3Tb7VNAFs3NZDbxmsWecKS1jc8ekKC+eDiLXrDRwXSc9cJmYidJFkV67VrBQp/sxhtGfJIrLBcXi8OF/089XO1YZoL/aBwQChdyjQxwhFWY/6Jp/ycPUsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7r6sxSfeC4UlsMHFH8tthI3vXsKCT0B14fb8Mhn9aAI=;
 b=JWUAXw+gr1MBMaOi49zHQW1Yn6vzuaG5quvm4zX7TMrDhUHRiPxms2qbOb26oUFhgt0xkYvUgjkfN223bUlKA3O8NWMrZg2TyJrbRSrcHYdCCXLL/Z7MnHog3mCWtB9IITJQh7H3MDV6xxASC0S8tqQK3GDLXbqrtycnUpaw5UE=
Received: from BN9PR03CA0199.namprd03.prod.outlook.com (2603:10b6:408:f9::24)
 by SA0PR12MB7092.namprd12.prod.outlook.com (2603:10b6:806:2d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Thu, 15 Feb
 2024 19:41:14 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:f9:cafe::fb) by BN9PR03CA0199.outlook.office365.com
 (2603:10b6:408:f9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Thu, 15 Feb 2024 19:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 19:41:13 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 13:41:13 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<benjamin.cheatham@amd.com>
Subject: [RFC PATCH 1/6] cxl/core: Add CXL Timeout & Isolation capability parsing
Date: Thu, 15 Feb 2024 13:40:43 -0600
Message-ID: <20240215194048.141411-2-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215194048.141411-1-Benjamin.Cheatham@amd.com>
References: <20240215194048.141411-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|SA0PR12MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 62efe75b-01ec-41fc-44a2-08dc2e5e11c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FLAWoY6EF+Rz66MGu1kJ3bAx6o6Us78bbDQOiyZ4SBnfZ1iw63aFyeckD9mcOb5ZQoH0QvpcXXGCRYmUj+CzJCB8yFO3jfEA6IOjEvIJbwBvffakzxEPwNnLDNtM1Q91BXgvPQLB9CLHBLYyY56fbiePKavZ7APo2asBE/aC99D2mCGMFbI4u/F9Ye5ttMdOZ11+fTZOobPCu2mpF/tNx00F8fFIDlaLOW0SHGP2fjazrPvkyx+KY4Uycx7ROq5PZpXrGAIOqr3O+YGspjFNB+wX++Z6x5Pb6qdcABen3yhdrPNFXWyy1ZJHSE7JAcQpRWexO5cr9lOmcE28bcNiP+X/VrgkeAeSrqyZZZeYUoiNTC5VZYClsGxF5b5dNUEfpC9HfFlJFg4k3+/SNL74+cS9BzCh4z/TjJkQKPSNloCz/Z8f9w2D0FLgcGLRHP6SpvvcOH2Q1kjulx4qsRNInnnJVW/fmUkq5NVdVYAGhWx88nv0FkNCmqOfvvyPjrzSWPPuuwfUi4fxFTjshgc+dlI4Cpwk2ZVsrAJpMdU/imLEAgDVX7UYLbXuGk6ReIuGiz7hlEP700P9h7OOAR+Rh/8bVxoAIIsuEcmA8y8oPndmXQpm+OfneAy5LTUdW+XN8DBEAoKAi8TrBsPGzi4LbA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(451199024)(36860700004)(64100799003)(82310400011)(186009)(1800799012)(40470700004)(46966006)(6666004)(478600001)(41300700001)(7416002)(2906002)(8676002)(8936002)(4326008)(5660300002)(7696005)(316002)(54906003)(70586007)(110136005)(70206006)(356005)(83380400001)(16526019)(336012)(426003)(81166007)(2616005)(86362001)(26005)(82740400003)(1076003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 19:41:13.9505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62efe75b-01ec-41fc-44a2-08dc2e5e11c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7092

Add parsing and mapping of the CXL Timeout & Isolation capability
structure (CXL 3.1 8.2.4.24) to regs.c.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/regs.c | 7 +++++++
 drivers/cxl/cxl.h       | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 372786f80955..fe0c19826a6a 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -92,6 +92,12 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			length = CXL_RAS_CAPABILITY_LENGTH;
 			rmap = &map->ras;
 			break;
+		case CXL_CM_CAP_CAP_ID_TIMEOUT:
+			dev_dbg(dev, "found Isolation & Timeout capability (0x%x)\n",
+				offset);
+			length = CXL_TIMEOUT_CAPABILITY_LENGTH;
+			rmap = &map->timeout;
+			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
 				offset);
@@ -211,6 +217,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 	} mapinfo[] = {
 		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
 		{ &map->component_map.ras, &regs->ras },
+		{ &map->component_map.timeout, &regs->timeout },
 	};
 	int i;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b6017c0c57b4..87f3178d6642 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -36,6 +36,7 @@
 
 #define   CXL_CM_CAP_CAP_ID_RAS 0x2
 #define   CXL_CM_CAP_CAP_ID_HDM 0x5
+#define   CXL_CM_CAP_CAP_ID_TIMEOUT 0x9
 #define   CXL_CM_CAP_CAP_HDM_VERSION 1
 
 /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
@@ -126,6 +127,9 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 	return 0;
 }
 
+/* CXL 3.0 8.2.4.23 CXL Timeout and Isolation Capability Structure */
+#define CXL_TIMEOUT_CAPABILITY_OFFSET 0x0
+#define CXL_TIMEOUT_CAPABILITY_LENGTH 0x10
 /* RAS Registers CXL 2.0 8.2.5.9 CXL RAS Capability Structure */
 #define CXL_RAS_UNCORRECTABLE_STATUS_OFFSET 0x0
 #define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))
@@ -208,6 +212,7 @@ struct cxl_regs {
 	struct_group_tagged(cxl_component_regs, component,
 		void __iomem *hdm_decoder;
 		void __iomem *ras;
+		void __iomem *timeout;
 	);
 	/*
 	 * Common set of CXL Device register block base pointers
@@ -242,6 +247,7 @@ struct cxl_reg_map {
 struct cxl_component_reg_map {
 	struct cxl_reg_map hdm_decoder;
 	struct cxl_reg_map ras;
+	struct cxl_reg_map timeout;
 };
 
 struct cxl_device_reg_map {
-- 
2.34.1


