Return-Path: <linux-pci+bounces-44817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C34D20C98
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 379AD3004298
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC8C335545;
	Wed, 14 Jan 2026 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YL2IBH6h"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3249433509E;
	Wed, 14 Jan 2026 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415183; cv=fail; b=XEBedFslLHXmcvF72OCeFMgqzlckhKUQPfoZeQ0zYf49C/ts7SO+btf1KNZfkZOwwfbibCyHMMDsk8m5ehXwSP3TTpv28i+OW9VM2xQha/fDP0U/KyfRlCc0Ok0NlU+5VFiqCSqyIdZisVl+RliCkqZW3NT5MfuhkXluW1/87Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415183; c=relaxed/simple;
	bh=aX6jpYh39nfj2PHeygGVIfh5c8LPghhRJPqaaVVBU7A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1Kbk1qhpJVlgEWJbeqUTy9vp27/w/G1mXXjL3lG2PwLkohJgI/Kg6M9fwaRnw9vRHu2f6dQnt0VpdY+T8aO0c6z8bSrCZbi23Wj7gCbD5mWX668hoFaN5/Pr7Mnbd1SVJQ4gc29a7gHodTz+NfVushs7+Dqmupk85lphOB1OBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YL2IBH6h; arc=fail smtp.client-ip=52.101.61.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpNGqH+23ib5W+BJ974SbzToGYPy4eHzzOongtIYUtavZqI47oIsZ9BqMAwDUAfpFY4OeLWeIHX+mYWCw6mcAzlQBIli6slO/+JC38QKMFNJlIyDDZTfeOGivRqXqvYrwNpJBv3ErX1dW0M7e9sEwuq9Lwly+/XBhtmzvLOhCf9ZbIuvBv0pXYjIGwLxXPAMHloyV2pJHwUMe9wDBzI7Bv7ypN8NVF1FOPg4DBet2p+MLmCXvdGi40T6ko1/+I99rBDi29e0YWIXh/KVvvvNNKjvpr88DO/M0x46jRQ8elmJtNfD1IRaTL3M9q3pVbuMFmqgOBp2kmk+Qt+ZyGuSUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uAmwKboFhw6PBj2LCjyhzYZueQwAEH/HYZoj5OxSR8=;
 b=FRSRaRIcwbAJ5cpnPcr7CWLpEsobIEFrQZf/+59sR1GSJjvuVPhlKKSqO/8CyZcHmOyGJfAs72GquXomezFDLqa20/e4dhItXnmm2A/u+pYhDnJrHheoFWTIArka0HP3k2t1WyYVY3XLgzhgTH9vOEW9B9Ehp+CX32Wl/lztLbP+FZIL7ttJS57lftUaN2Abkdm3xzs2o2Jd5zwNodOFoHjT8hLtiuSd40gJWu1xz3ZDXIOh6jaDVk+kiV2BaE4flE84nJeVgOfyyGH7wJrQZrQxhLMGsNsORAmuCAuao+7aRuuuJaRy2H6iSQ9lJLLitMd3ux01FB8OcJDVFtW2Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uAmwKboFhw6PBj2LCjyhzYZueQwAEH/HYZoj5OxSR8=;
 b=YL2IBH6hJjFJmeuITo7UotIv7t6E/uAvnGkeb6oWm3tPaTSIyRdSH8mNuLalg/ghD6HlvIdbRka/Op0abhdbLToKKiML9U1k4XyvD0XN20c8ciVGRAN88kC7CNG9OjQAlERZz04LnxBPNs3ZXdkJNYt853pZXjdDM3pMxo3a6HM=
Received: from SJ0PR03CA0335.namprd03.prod.outlook.com (2603:10b6:a03:39c::10)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 18:26:14 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::43) by SJ0PR03CA0335.outlook.office365.com
 (2603:10b6:a03:39c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Wed,
 14 Jan 2026 18:26:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:26:13 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:26:12 -0600
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
Subject: [PATCH v14 24/34] cxl/port: Move endpoint component register management to cxl_port
Date: Wed, 14 Jan 2026 12:20:45 -0600
Message-ID: <20260114182055.46029-25-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: f81f4038-576e-4343-e8b9-08de539a665f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CCTq98L9AvPkPL6hCtmov6bsSBGoDSLlXdAIG499phdA44x2clGMW3Cuh6HJ?=
 =?us-ascii?Q?paXqoKiBOxMQKZLGECyZF816Z0xDvQxeIkMcYM9QqjkhM01Qty4NRoLnJAq3?=
 =?us-ascii?Q?Gob0hBZ8dlvpp7m4fnUf11ITjiNRB52pt71GP3M8GOexy59gjTZ3ZOQDxzim?=
 =?us-ascii?Q?DUZgDczkAu3wNgmdGLTOQa465gfrcE89XxZkIlJ+n/VZY8KvR8Z5q/B2d7GI?=
 =?us-ascii?Q?H287w5cw1A4zEdrcM8i5QQdiTjZrTj2rLHC6vKdMluU7CmvVIsGqk/BAkWXI?=
 =?us-ascii?Q?3SbZX5LVpFvLZEycHfXeQT1kmOpLOjXaDSHL34xYYhURdTLU/8ETTQL18LZ0?=
 =?us-ascii?Q?RuNrbO9uPyGdp20CZUCRKZzonFH09b8M2jQG5cL/eo5iwsreomTgFjYPo/Hg?=
 =?us-ascii?Q?mJDgp+ty18Pbc5mIsececrfVL7jRCvfb+yrC/j027LDefwiXYh5j6775am7b?=
 =?us-ascii?Q?2CTL6bx14ONEVUVnsbbnB08qZfikQiD6NDGV/Kpk66Hl4edkJ/V2GSnB3Dt9?=
 =?us-ascii?Q?Xb9RwsQe7rc6ZBr/yjQLKra8U9+Y8dGQ0S1Uxah/MImT9bob+hPO8CXIyT33?=
 =?us-ascii?Q?GS8SgeDDp2RIjUZ9UyoyjLAk30mStuOq7l+YZv53jVjHUE5uUto6ZT8j6AAR?=
 =?us-ascii?Q?3sF8p2aPL90ikBf3yeL449L/9Ry1H6hwZ6ib6UaIeyR3cZCnz46dQaB9LtNe?=
 =?us-ascii?Q?rvzIi6cpQPTPLHnqzH3w5Bu1S+JNJ8iBPVNhugHQdCq+fqzql0cgRTtEcwSR?=
 =?us-ascii?Q?g2jJXbC+lwX+s/4M1O4QDfyh06IW1u3IhIfleD+Di7V6bVY0mLbl/HgnNNDh?=
 =?us-ascii?Q?9w+x/sVuE5EnvRyi0r1PiSpjsaN1BYQZP37d9zQFUBopiYcsJJWnFIegB+Tx?=
 =?us-ascii?Q?qSuCja2NEYkg3uO9CxDurV6C1OYBqQFQdfqDawxChULpzMotuilJjktoNpY0?=
 =?us-ascii?Q?CTzsmugG4odhdTdq3xxbJVdsGRPc+RD2D1ldh8VL6jfPEbTmOZkifg3AK8HI?=
 =?us-ascii?Q?WOiWEzNAUtYlFrnrm9+SDlb1NKRVydw6Cl37z+zQzpXjodtHZjIVMi3jZvK6?=
 =?us-ascii?Q?KvPDzzAfa7itIUG6RyJLBp192HNUNl+rH/Mfo3YMiJ6IzEeoA73cPMq3BtVN?=
 =?us-ascii?Q?yf70kWmz7XQn9XCCMvLVntVA4Qhmr6HgVO8ULHJuLov5CQjnWn3iVLHNzHLT?=
 =?us-ascii?Q?DW+Ll7+uxMcL9UeYy6qp/66ptrizarWxXftrzf3siYokcMkyg5yD+drFPJqK?=
 =?us-ascii?Q?WgNH9hN1v5G70sgiFnWEfRkSdAO0RZApCEKxV0fkfw8twiCYmEjkhv4MloRs?=
 =?us-ascii?Q?8sH9lcnWBeZu4gRUQz+wV9tqGJdCUCJvChYJf4Z2o3959qA1a6Fz7UzltTI6?=
 =?us-ascii?Q?t+3AKdavr4N4drbuweH7CHYypSyqe6jynZsqzaxXKSYEWQMZzWQWkCuoj10b?=
 =?us-ascii?Q?inc+WG8CvShg5nsEzyrBuelhn75titOlUBsh8w1Y2V/mLgMoymnJ+wNtKb43?=
 =?us-ascii?Q?G1qVua3DXY9gzngxWUf0A72YMJNB/Ulsjyb+ktSC7VmV436NW7VdSbQBBTMF?=
 =?us-ascii?Q?VqPSAF/PLpPTns6YDQJ9oe+CWJyASChRUjXJMzE7Urf98V+M+J+1rh9z6GbK?=
 =?us-ascii?Q?LnILoL1cHg5UiGbH+iFMcuqsgY4cv/w8WXy2FxHo8v5UBn+0oxfNv2UpaEoB?=
 =?us-ascii?Q?/cUATOMxlNd12WwY2gvG9Eu+e/E=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:26:13.9478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f81f4038-576e-4343-e8b9-08de539a665f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783

From: Dan Williams <dan.j.williams@intel.com>

In preparation for generic protocol error handling across CXL endpoints,
whether they be memory expander class devices or accelerators, drop the
endpoint component management from cxl_dev_state.

Organize all CXL port component management through the common cxl_port
driver.

Note that the end game is that drivers/cxl/core/ras.c loses all
dependencies on a 'struct cxl_dev_state' parameter and operates only on
port resources. The removal of component register mapping from cxl_pci is
an incremental step towards that.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v13 -> v14:
- New patch
- Update log message for cxl_ras_unmask() failure (Dan)
---
 drivers/cxl/core/ras.c |  6 ++--
 drivers/cxl/cxlmem.h   |  4 +--
 drivers/cxl/pci.c      | 63 +-----------------------------------------
 drivers/cxl/port.c     | 54 ++++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 67 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 76ac567724e3..b37108f60c56 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -247,6 +247,7 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 void cxl_cor_error_detected(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
 	struct device *dev = &cxlds->cxlmd->dev;
 
 	scoped_guard(device, dev) {
@@ -261,7 +262,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 			cxl_handle_rdport_errors(cxlds);
 
 		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial,
-				   cxlds->regs.ras);
+				   cxlmd->endpoint->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -291,10 +292,9 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * capability registers and bounce the active state of the memdev.
 		 */
 		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial,
-				    cxlds->regs.ras);
+				    cxlmd->endpoint->regs.ras);
 	}
 
-
 	switch (state) {
 	case pci_channel_io_normal:
 		if (ue) {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 434031a0c1f7..ab7201ef3ea6 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -415,7 +415,7 @@ struct cxl_dpa_partition {
  * @dev: The device associated with this CXL state
  * @cxlmd: The device representing the CXL.mem capabilities of @dev
  * @reg_map: component and ras register mapping parameters
- * @regs: Parsed register blocks
+ * @regs: Class device "Device" registers
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
  * @media_ready: Indicate whether the device media is usable
@@ -431,7 +431,7 @@ struct cxl_dev_state {
 	struct device *dev;
 	struct cxl_memdev *cxlmd;
 	struct cxl_register_map reg_map;
-	struct cxl_regs regs;
+	struct cxl_device_regs regs;
 	int cxl_dvsec;
 	bool rcd;
 	bool media_ready;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b7f694bda913..acb0eb2a13c3 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -535,52 +535,6 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	return cxl_setup_regs(map);
 }
 
-static int cxl_pci_ras_unmask(struct pci_dev *pdev)
-{
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	void __iomem *addr;
-	u32 orig_val, val, mask;
-	u16 cap;
-	int rc;
-
-	if (!cxlds->regs.ras) {
-		dev_dbg(&pdev->dev, "No RAS registers.\n");
-		return 0;
-	}
-
-	/* BIOS has PCIe AER error control */
-	if (!pcie_aer_is_native(pdev))
-		return 0;
-
-	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
-	if (rc)
-		return rc;
-
-	if (cap & PCI_EXP_DEVCTL_URRE) {
-		addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
-		orig_val = readl(addr);
-
-		mask = CXL_RAS_UNCORRECTABLE_MASK_MASK |
-		       CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
-		val = orig_val & ~mask;
-		writel(val, addr);
-		dev_dbg(&pdev->dev,
-			"Uncorrectable RAS Errors Mask: %#x -> %#x\n",
-			orig_val, val);
-	}
-
-	if (cap & PCI_EXP_DEVCTL_CERE) {
-		addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
-		orig_val = readl(addr);
-		val = orig_val & ~CXL_RAS_CORRECTABLE_MASK_MASK;
-		writel(val, addr);
-		dev_dbg(&pdev->dev, "Correctable RAS Errors Mask: %#x -> %#x\n",
-			orig_val, val);
-	}
-
-	return 0;
-}
-
 static void free_event_buf(void *buf)
 {
 	kvfree(buf);
@@ -912,13 +866,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	unsigned int i;
 	bool irq_avail;
 
-	/*
-	 * Double check the anonymous union trickery in struct cxl_regs
-	 * FIXME switch to struct_group()
-	 */
-	BUILD_BUG_ON(offsetof(struct cxl_regs, memdev) !=
-		     offsetof(struct cxl_regs, device_regs.memdev));
-
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
@@ -942,7 +889,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
+	rc = cxl_map_device_regs(&map, &cxlds->regs);
 	if (rc)
 		return rc;
 
@@ -957,11 +904,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	else if (!cxlds->reg_map.component_map.ras.valid)
 		dev_dbg(&pdev->dev, "RAS registers not found\n");
 
-	rc = cxl_map_component_regs(&cxlds->reg_map, &cxlds->regs.component,
-				    BIT(CXL_CM_CAP_CAP_ID_RAS));
-	if (rc)
-		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
-
 	rc = cxl_pci_type3_init_mailbox(cxlds);
 	if (rc)
 		return rc;
@@ -1052,9 +994,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	if (cxl_pci_ras_unmask(pdev))
-		dev_dbg(&pdev->dev, "No RAS reporting unmasked\n");
-
 	pci_save_state(pdev);
 
 	return rc;
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 0d6e010e21ca..d76b4b532064 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+#include <linux/aer.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -72,6 +73,55 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 	return 0;
 }
 
+static int cxl_ras_unmask(struct cxl_port *port)
+{
+	struct pci_dev *pdev;
+	void __iomem *addr;
+	u32 orig_val, val, mask;
+	u16 cap;
+	int rc;
+
+	if (!dev_is_pci(port->uport_dev))
+		return 0;
+	pdev = to_pci_dev(port->uport_dev);
+
+	if (!port->regs.ras) {
+		pci_dbg(pdev, "No RAS registers.\n");
+		return 0;
+	}
+
+	/* BIOS has PCIe AER error control */
+	if (!pcie_aer_is_native(pdev))
+		return 0;
+
+	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
+	if (rc)
+		return rc;
+
+	if (cap & PCI_EXP_DEVCTL_URRE) {
+		addr = port->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
+		orig_val = readl(addr);
+
+		mask = CXL_RAS_UNCORRECTABLE_MASK_MASK |
+		       CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
+		val = orig_val & ~mask;
+		writel(val, addr);
+		pci_dbg(pdev, "Uncorrectable RAS Errors Mask: %#x -> %#x\n",
+			orig_val, val);
+	}
+
+	if (cap & PCI_EXP_DEVCTL_CERE) {
+		addr = port->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
+		orig_val = readl(addr);
+		val = orig_val & ~CXL_RAS_CORRECTABLE_MASK_MASK;
+		writel(val, addr);
+		pci_dbg(pdev, "Correctable RAS Errors Mask: %#x -> %#x\n",
+			orig_val, val);
+	}
+
+	return 0;
+}
+
 static int cxl_endpoint_port_probe(struct cxl_port *port)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
@@ -102,6 +152,10 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	if (dport->rch)
 		devm_cxl_dport_ras_setup(dport);
 
+	devm_cxl_port_ras_setup(port);
+	if (cxl_ras_unmask(port))
+		dev_dbg(&port->dev, "failed to unmask RAS interrupts\n");
+
 	/*
 	 * Now that all endpoint decoders are successfully enumerated, try to
 	 * assemble regions from committed decoders
-- 
2.34.1


