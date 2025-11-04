Return-Path: <linux-pci+bounces-40175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFF1C2E8E4
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A2434F0F52
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512691D5CD9;
	Tue,  4 Nov 2025 00:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b6DNNZ65"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010027.outbound.protection.outlook.com [52.101.193.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D65618DB1F;
	Tue,  4 Nov 2025 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215226; cv=fail; b=rK7AeTIPk/8AQh0GaM6oLzq7MmvKJE0sD/7ha/Wj2xtKIddOdDtO6sM/2LQkAAaOjTdExEsFMvsPIxJbpAbPvHRs0QpZHZZzzuhFjVpJnySd+tjTP1FTCbZRPOcur7NTTf354sIYNA5Qs1YP+i9xUcYvsJouA/QQrQpnniWMm1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215226; c=relaxed/simple;
	bh=FEoIl2aT/URtm+5ey3W8xhGL7dcvFLfQIC6+Sj/T/ZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9oeTSo13MVKrfchKQ3ho48HdiFd5QxrwWckw6Ee0ay2sqI1sI/yd1+Z8EHDf2twRKBUYL1iP/5suLmUVZsQrDb/X6NXeuNlu3V0UIFW7mSSfTsTxNfdhxotkKY37lh9ld7/WrFYx5BpFKCw+7+iWUWVRoz3V8dY7jWnS5jVzdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b6DNNZ65; arc=fail smtp.client-ip=52.101.193.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1YaaMqss5sXsyeGW7gJRQzCLnQ5CYKFnULdm0JbcyBaTocfqutB4k6AI6b+7T2lsDLOhccZVopn+sUU7yaIPsFx7Vd34S870XEQPwNaBwJKLA3mNXaPhtygA5mnHcgwz1Ym+BI16gpcLCW9GZI++5I2Yax30yIL1IZGkABJvDggAb99Y7FN3JzCMSiROC1vdalkViV+mSFp7tyYlvioxX68yHr8cHL+qT3lD8IQWP6XNyOKu6z5ldBQpP0ADbrVAZTLOsbXWHxD7SqrsoFNoqPCdsnC5XfzgeyHh4HI6yADT769Nsr3BPII1vlLO3XAk9HbMr5nUUDiDaE56XX/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpEMol5NnNbmps2Bd1Ahvt79IeekGN1Q5WQ9MrFh1Sk=;
 b=jHQoCerl/0kaZx0KNokFk8YFUcWWGuvKdPNx/AgXU/1whLvAzNZFql1EjtW+AsIgtoQC/trHj0sOvy38F9yDv5aqOuJ7goHJ0unLZFBAmdIiRBDnLG5030asocoVGjWCqOXD2Gen8iARErwUPVpBOG2B1JzNsrUSOr+kn6Mvme7PGYG7HmTG5nO5gfyCbiMvQ4BT9oOmlQvxcQgLwH/0bxmIUwZFLsPvOpCfwPhGUfCj47P7Gcy0HX/StObnNELw4KbwRDMl0E6f0V4g1+ie60QxaEvWOXtOZQ3JTSdwCRA/S+jwhM4Amd2+MD4uiTfpHjmGmCtivT61nwGOTsah6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpEMol5NnNbmps2Bd1Ahvt79IeekGN1Q5WQ9MrFh1Sk=;
 b=b6DNNZ654Kfo9OodogK/J31c1qD8D+qRfazgdNdHGLVKtoAzWkyR02xMGwZfk9PcBibkpY0bGye4irnjJJwJjQkKIiRSX/iwHgmjx7X2aBhCx2GRNQgz/iWLY1LDEV3r+sLKmDFHeSGDPxzFLCK+xczMguNZvISexTtmg8ZPWWs=
Received: from CH5PR04CA0013.namprd04.prod.outlook.com (2603:10b6:610:1f4::13)
 by LV8PR12MB9617.namprd12.prod.outlook.com (2603:10b6:408:2a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 00:13:39 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::4c) by CH5PR04CA0013.outlook.office365.com
 (2603:10b6:610:1f4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 00:13:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:13:38 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:13:37 -0800
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v13 19/25] cxl/pci: Introduce CXL protocol error handlers for Endpoints
Date: Mon, 3 Nov 2025 18:09:55 -0600
Message-ID: <20251104001001.3833651-20-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104001001.3833651-1-terry.bowman@amd.com>
References: <20251104001001.3833651-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|LV8PR12MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 0737b692-174e-4038-be22-08de1b370122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mOCgZiY3TfGlCUdYCfzrSTowR5ZQP0+uALBeL/hoDoCrsttzrjN3kTVZ2/aU?=
 =?us-ascii?Q?LLIQueLD9bbwwCoed1uACKNiSx90UA9gd5TOskK8yPxg0BSlvfAbLRthjqBH?=
 =?us-ascii?Q?vEdV9y4EJgwFWD8HCdOplT5f+7Z+YHTm7blGXONViJFy1ZhFNdUJZp4IxIYY?=
 =?us-ascii?Q?IsNtqRjRQqZ5xkS5JbWXMkh9iZDxWmuAjxIJRfxbbtlAR6/ZcZasKnLd0IJL?=
 =?us-ascii?Q?Ml2B+RGD1CoxBUBlfCXOzSzkKVB9mmSShjJ8ivR7/8rZafghkNY676pMDMOk?=
 =?us-ascii?Q?izyZm2pe6jgq0oKtrlellrkZQxZxWW/zBqys0ImximVWD+7+z1J1pS8ib7Cc?=
 =?us-ascii?Q?6iZexMwAi4O66ZElv71rm/mRzQc2Yk6cNa9X0U4syaElYledyIvzwJ/ZL7P6?=
 =?us-ascii?Q?Pfv0AUcvkWLf5vafsvZXSqcRbuOlbn8oDYy4qdddkK7heoYbmHhoASNw/0nj?=
 =?us-ascii?Q?s1oOSMeYK/FRwXAE7MyV9EUYK9pKGGxJl/4w1WaS21bJ+8worKUs5Wnes5X4?=
 =?us-ascii?Q?iW2Y82vNZ9Fnzv9Ck83NQS5qvl4/8lI7jgrkAV//GWl5cFoqCYFPh43TMQi3?=
 =?us-ascii?Q?r9jKVhBMJoK3xo6V+Y+mfx3WcPbfGfVXUiLN18lmeuRDzQql1K+TiPIVtewI?=
 =?us-ascii?Q?vOrNkV1tnIIes04B8ZMTT7myRitkMYEUt1N7h77Key1aD0/xOIjJOBKCYK+a?=
 =?us-ascii?Q?IX+fMZVQsnu8qCld6RM6dcDEQb76w2toCekeKoO8zSuc/GXnLbWmhJuPG9yY?=
 =?us-ascii?Q?o+x8YtJJm/0bB1XZPV9IUDEA193ynEw675/BzaRxQrSkFiMynvLNQ5KVS4tA?=
 =?us-ascii?Q?7IDX54MiyATVK+vyP4szbnQ/TXHnO8O2WfiQoFAKEA/ictvxB1KM0Eq8Vu25?=
 =?us-ascii?Q?COJgzf+imGzzSAY2qUGMZ4oiZI4mbNGSmKYhFazm7xUSo9JK19/RDyo5c7kc?=
 =?us-ascii?Q?xxOg7z2asRn6Sb4un3jRPPbvXrVitz4/9WPioR3no5Q4LXO8RQE8AKXBxU2k?=
 =?us-ascii?Q?d783zFKAiemdyhfGwnWeEBGhdXbWD570JLIIG7bTcISGqgh5HVe8vUpTxyM+?=
 =?us-ascii?Q?VQ4xjrQ5wzfnM8ISv6N9MMRdk1nawVEu9VRvjPZjqIOMwkfhN6Z9IMJhV264?=
 =?us-ascii?Q?Zq/Ws6D26LLu7VMkX55CJr4J0w2lE9fLBPAPZ0cqLx1Sg/o6Gl2/zoz3SArC?=
 =?us-ascii?Q?suNIVT07iG8aFZHw+OlhZBmH0U6cxBGWOwPYY3mS1qUQdVpfBiKaoOfeWoUq?=
 =?us-ascii?Q?yt/IYW3Ctd7Tbr/t/5/pBFy9YakVzb+IVUKUhTxUMlKA1tXI2WHkJEv+cLKu?=
 =?us-ascii?Q?p7xzMzEcn50915/1BM2DEg4sNfT/JVo8xt83OYL6Q8y8RtTkKrK1rAt6c1gp?=
 =?us-ascii?Q?5GKaMNyP1mSPyKzxVmGJ3yPfHDeVKY8YeKYwzdluHuEhDcuKEhGFSY/fvceD?=
 =?us-ascii?Q?o52NmDbH/9onFais+lYeJBhAFRWEu5NhyGMT1Ig9uOlMCp41RJthXaUkRHrJ?=
 =?us-ascii?Q?qDDJSQxHIPlryuilwu87sLww+eOj9Gsop4nn5CG/WRIn2TRdCPSz3x0mMKQ1?=
 =?us-ascii?Q?Xiod3H77Qm/OjnELrUMq1R+uXsR5wxC0oR7U9sda?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:13:38.8843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0737b692-174e-4038-be22-08de1b370122
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9617

CXL Endpoint protocol errors are currently handled by generic PCI error
handlers. However, uncorrectable errors (UCEs) require CXL.mem protocol-
specific handling logic that the PCI handlers cannot provide.

Add dedicated CXL protocol error handlers for CXL Endpoints. Rename the
existing cxl_error_handlers to pci_error_handlers to better reflect their
purpose and maintain naming consistency. Update the PCI error handlers to
invoke the new CXL protocol handlers when the endpoint is operating in
CXL.mem mode.

Implement cxl_handle_ras() to return PCI_ERS_RESULT_NONE or
PCI_ERS_RESULT_PANIC. Remove unnecessary result checks from the previous
endpoint UCE handler since CXL UCE recovery is not implemented in this
patch.

Add device lock assertions to protect against concurrent device or RAS
register removal during error handling. Two devices require locking for
CXL endpoints:

1. The PCI device (pdev->dev) - RAS registers are allocated and mapped
   using devm_* functions with this device as the host. Locking prevents
   the RAS registers from being unmapped until after error handling
   completes.

2. The CXL memory device (cxlmd->dev) - Holds a reference to the RAS
   registers accessed during error handling. Locking prevents the memory
   device and its RAS register references from being removed during error
   handling.

The lock assertions added here will be satisfied by device locks
introduced in a subsequent patch. A future patch will extend the CXL UCE
handler to support full UCE recovery.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

---

Changes in v12->v13:
- Update commit messaqge (Terry)
- Updated all the implemetnation and commit message. (Terry)
- Refactored cxl_cor_error_detected()/cxl_error_detected() to remove
  pdev (Dave Jiang)

Changes in v11->v12:
- None

Changes in v10->v11:
- cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
- cxl_error_detected() - Remove extra line (Shiju)
- Changes moved to core/ras.c (Terry)
- cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
- Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
- Move #include "pci.h from cxl.h to core.h (Terry)
- Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)
---
 drivers/cxl/core/core.h    | 22 +++++++--
 drivers/cxl/core/pci_drv.c |  9 ++--
 drivers/cxl/core/ras.c     | 97 +++++++++++++++++++++++---------------
 drivers/cxl/cxlpci.h       | 11 -----
 4 files changed, 82 insertions(+), 57 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 61c6726744d7..b2c0ccd6803f 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -149,19 +149,33 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 #ifdef CONFIG_CXL_RAS
 int cxl_ras_init(void);
 void cxl_ras_exit(void);
-bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
+pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial,
+			       void __iomem *ras_base);
 void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base);
+pci_ers_result_t cxl_error_detected(struct device *dev);
+void cxl_cor_error_detected(struct device *dev);
+pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
+				    pci_channel_state_t error);
+void pci_cor_error_detected(struct pci_dev *pdev);
 #else
 static inline int cxl_ras_init(void)
 {
 	return 0;
 }
 static inline void cxl_ras_exit(void) { }
-static inline bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
+static inline pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial,
+					      void __iomem *ras_base)
 {
-	return false;
+	return PCI_ERS_RESULT_NONE;
 }
-static inline void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base) { }
+static inline void cxl_handle_cor_ras(struct device *dev, u64 serial,
+				      void __iomem *ras_base) { }
+static inline pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
+						  pci_channel_state_t error)
+{
+	return PCI_ERS_RESULT_NONE;
+}
+static inline void pci_cor_error_detected(struct pci_dev *pdev) { }
 #endif /* CONFIG_CXL_RAS */
 
 /* Restricted CXL Host specific RAS functions */
diff --git a/drivers/cxl/core/pci_drv.c b/drivers/cxl/core/pci_drv.c
index 06f2fd993cb0..bc3c959f7eb6 100644
--- a/drivers/cxl/core/pci_drv.c
+++ b/drivers/cxl/core/pci_drv.c
@@ -16,6 +16,7 @@
 #include "cxlpci.h"
 #include "cxl.h"
 #include "pmu.h"
+#include "core/core.h"
 
 /**
  * DOC: cxl pci
@@ -1112,11 +1113,11 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	}
 }
 
-static const struct pci_error_handlers cxl_error_handlers = {
-	.error_detected	= cxl_error_detected,
+static const struct pci_error_handlers pci_error_handlers = {
+	.error_detected	= pci_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
-	.cor_error_detected	= cxl_cor_error_detected,
+	.cor_error_detected	= pci_cor_error_detected,
 	.reset_done	= cxl_reset_done,
 };
 
@@ -1124,7 +1125,7 @@ static struct pci_driver cxl_pci_driver = {
 	.name			= KBUILD_MODNAME,
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
-	.err_handler		= &cxl_error_handlers,
+	.err_handler		= &pci_error_handlers,
 	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index cb712772de5c..beb142054bda 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -128,6 +128,11 @@ void cxl_ras_exit(void)
 	cancel_work_sync(&cxl_cper_prot_err_work);
 }
 
+static bool is_pcie_endpoint(struct pci_dev *pdev)
+{
+	return pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT;
+}
+
 static void cxl_dport_map_ras(struct cxl_dport *dport)
 {
 	struct cxl_register_map *map = &dport->reg_map;
@@ -214,7 +219,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
+pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -223,13 +228,13 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 
 	if (!ras_base) {
 		dev_warn_once(dev, "CXL RAS register block is not mapped");
-		return false;
+		return PCI_ERS_RESULT_NONE;
 	}
 
 	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
 	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
-		return false;
+		return PCI_ERS_RESULT_NONE;
 
 	/* If multiple errors, log header points to first error from ctrl reg */
 	if (hweight32(status) > 1) {
@@ -246,18 +251,19 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
-	return true;
+	return PCI_ERS_RESULT_PANIC;
 }
 
-void cxl_cor_error_detected(struct pci_dev *pdev)
+void cxl_cor_error_detected(struct device *dev)
 {
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct device *dev = &cxlds->cxlmd->dev;
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-	guard(device)(dev);
+	device_lock_assert(cxlds->dev);
+	device_lock_assert(&cxlmd->dev);
 
 	if (!dev->driver) {
-		dev_warn(&pdev->dev,
+		dev_warn(cxlds->dev,
 			 "%s: memdev disabled, abort error handling\n",
 			 dev_name(dev));
 		return;
@@ -270,18 +276,31 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
 
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state)
+void pci_cor_error_detected(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds;
+
+	device_lock_assert(&pdev->dev);
+	if (!cxl_pci_drv_bound(pdev))
+		return;
+
+	cxlds = pci_get_drvdata(pdev);
+	guard(device)(&cxlds->cxlmd->dev);
+
+	cxl_cor_error_detected(&pdev->dev);
+}
+EXPORT_SYMBOL_NS_GPL(pci_cor_error_detected, "CXL");
+
+pci_ers_result_t cxl_error_detected(struct device *dev)
 {
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct device *dev = &cxlmd->dev;
-	bool ue;
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-	guard(device)(dev);
+	device_lock_assert(cxlds->dev);
+	device_lock_assert(&cxlmd->dev);
 
 	if (!dev->driver) {
-		dev_warn(&pdev->dev,
+		dev_warn(cxlds->dev,
 			 "%s: memdev disabled, abort error handling\n",
 			 dev_name(dev));
 		return PCI_ERS_RESULT_DISCONNECT;
@@ -289,32 +308,34 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 
 	if (cxlds->rcd)
 		cxl_handle_rdport_errors(cxlds);
+
 	/*
 	 * A frozen channel indicates an impending reset which is fatal to
 	 * CXL.mem operation, and will likely crash the system. On the off
 	 * chance the situation is recoverable dump the status of the RAS
 	 * capability registers and bounce the active state of the memdev.
 	 */
-	ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
-
-	switch (state) {
-	case pci_channel_io_normal:
-		if (ue) {
-			device_release_driver(dev);
-			return PCI_ERS_RESULT_NEED_RESET;
-		}
-		return PCI_ERS_RESULT_CAN_RECOVER;
-	case pci_channel_io_frozen:
-		dev_warn(&pdev->dev,
-			 "%s: frozen state error detected, disable CXL.mem\n",
-			 dev_name(dev));
-		device_release_driver(dev);
-		return PCI_ERS_RESULT_NEED_RESET;
-	case pci_channel_io_perm_failure:
-		dev_warn(&pdev->dev,
-			 "failure state error detected, request disconnect\n");
-		return PCI_ERS_RESULT_DISCONNECT;
-	}
-	return PCI_ERS_RESULT_NEED_RESET;
+	return cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
+
+pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
+				    pci_channel_state_t error)
+{
+	struct cxl_dev_state *cxlds;
+	pci_ers_result_t rc;
+
+	device_lock_assert(&pdev->dev);
+	if (!cxl_pci_drv_bound(pdev))
+		return PCI_ERS_RESULT_NONE;
+
+	cxlds = pci_get_drvdata(pdev);
+	guard(device)(&cxlds->cxlmd->dev);
+
+	rc = cxl_error_detected(&cxlds->cxlmd->dev);
+	if (rc == PCI_ERS_RESULT_PANIC)
+		panic("CXL cachemem error.");
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(pci_error_detected, "CXL");
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index a0a491e7b5b9..3526e6d75f79 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -79,21 +79,10 @@ struct cxl_dev_state;
 void read_cdat_data(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_RAS
-void cxl_cor_error_detected(struct pci_dev *pdev);
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state);
 void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
 void cxl_uport_init_ras_reporting(struct cxl_port *port,
 				  struct device *host);
 #else
-static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
-
-static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-						  pci_channel_state_t state)
-{
-	return PCI_ERS_RESULT_NONE;
-}
-
 static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
 						struct device *host) { }
 static inline void cxl_uport_init_ras_reporting(struct cxl_port *port,
-- 
2.34.1


