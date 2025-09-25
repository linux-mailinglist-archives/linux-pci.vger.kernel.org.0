Return-Path: <linux-pci+bounces-37039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4ADBA1D15
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DEAB7A26B5
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9311D321F4D;
	Thu, 25 Sep 2025 22:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qEztCKuC"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2697286439;
	Thu, 25 Sep 2025 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839753; cv=fail; b=M0/R59zFBoJAWYhk5AuUxg7dsdEjCMPNllbNuF4wjVJifzQX/3Aa/gINOiNFSq0ylcjKJwAoEBGgyIkrmmyxiz7RqIeOGR72OsGU9B0eCEjAm/7kLxX9CF3QbKWJ4n/gfsh/g6vYK+AZyI3S7svp0HBm9g/5YsJ85dDIdvsqocI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839753; c=relaxed/simple;
	bh=7AnY7UTtCbFpuGF0CTKmFFvr7x+OIiFopiTkUYH+mm0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ml/nvlAhpmkaE5xiZ7rptKta2v9qXhUlE8iiMN7r1WbeXAiVmA9ZzkYZSE+u47Dby+aj7eriSw8xAfEseqvKjYuXrjeaIahN868m3QvZSxbwMlSdC7FCZOSh4m28sB32oUFXirLXCb4ZBngxovHDMpyByNN8tE4pPQx3Ww1bcBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qEztCKuC; arc=fail smtp.client-ip=52.101.61.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBkBNZUfJim6W6fMNOHgz4CY1rzxfxSqOyZqivpE3paOU5e9n/Jw5M52ye5npWF1sJtrv1sr4RKNMdN6aXhIRej6vww3Kwb9Hj09oASzMiiPBy7Mfvy5kSnbXxaQIm/xfWtIkRxldRdaD7xVgoxubtvlNlEpdtV1uQrD74u2e5xFU8VF8Q9bZLbqFxJbNADojNyfOrTFEEOmz7/GW0ybUiLtu96EjepqxhUg2aLXLFGx4PaIuPQ+0W51ZpN0KvpN7AWMxl8ozJBqiczDAGhuI/jCropFNnjYHgv5u5ixH59/NK+gddg+FO7yCenCfWR0tv3TkEles2q5zmFcMdkbMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSQXARceahOLjPn7p8RjLyRbL+e73kxa+DguraJ3pXE=;
 b=FWvhEjEEEPUCN2m68Scv9tKLcCUsBCeDbRnOXx5SZv5JTdXd+2/1O/aYCQ6So6GPuY5pEVtrcrlJ/mR+usSA7imgvfg/lxDN2vENI4ApKxc0rkudZxbH1r2HzBOsPZwn3/4m8px2fW4VGGvd8NH88U2z1daCDeGSzb0SPNcSU2/XuFLM5dLB2LnYpg+kB9GjYFkJTxxRHUc9yb3/+2yTIFqVsQB9J8//7cBCCTyi6836sQ4lxaAHQR9Bd5bzrf+qle+LellNvxw71fVu3iXQWR9istpvV9kgHXKGcjvKBYqfwpbJlFDSpYyppQvtZRXxawwLDloudb+wb1dkrEugtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSQXARceahOLjPn7p8RjLyRbL+e73kxa+DguraJ3pXE=;
 b=qEztCKuCmiF9gQ/BbNasApLaCK/CU/uKmzXjxH6ChU9gDqSzWvdHNJrLsYTcLw+MBjmrd05RWnbhpSLDLQuwOoKINVFkokol0OSVJ1ob1S+UZRKS7JKHMhmnRdR1fDeSpNdoVnoXwDPzCDei36Qcq4PZKLuTRklwvlVCEHc29BE=
Received: from MW4PR03CA0055.namprd03.prod.outlook.com (2603:10b6:303:8e::30)
 by CH2PR12MB9460.namprd12.prod.outlook.com (2603:10b6:610:27f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 22:35:44 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::a9) by MW4PR03CA0055.outlook.office365.com
 (2603:10b6:303:8e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Thu,
 25 Sep 2025 22:35:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:35:43 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:35:41 -0700
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
Subject: [PATCH v12 05/25] cxl: Move CXL driver RCH error handling into CONFIG_CXL_RCH_RAS conditional block
Date: Thu, 25 Sep 2025 17:34:20 -0500
Message-ID: <20250925223440.3539069-6-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925223440.3539069-1-terry.bowman@amd.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|CH2PR12MB9460:EE_
X-MS-Office365-Filtering-Correlation-Id: 4644520b-c4fa-48dc-c502-08ddfc83dd39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8wwoAYAOtHQlGYWzEHEvW4khXrzXdXiiTpnwDpwH8jDKSk4lzr2IxdYyVG9N?=
 =?us-ascii?Q?dSQbCWdc+FD4wQT+dmxUsdlCGWcm0c3fscphghEANDzsgtqBe2BbhyhhSxzE?=
 =?us-ascii?Q?yp8J3aV/jNnmRG5mLKRSJLayaBgWUzIP1RmivYkdWiCOhIXphRWICZpGtKN8?=
 =?us-ascii?Q?xewBt3kLFNMxxRBO82ai4e4iCZIBgxN2RZlRlZiIp5Ml6uCBhvFBYsHU3Art?=
 =?us-ascii?Q?pep02B1zOUqvLfGxf+75rnH7q412SjIz75T36kFOh3XquqcERMza7yLPJMjR?=
 =?us-ascii?Q?C9PVRBC9usTm1qsaG9dmRvivhvDIx67IJ4ICrKlNhEhkW2jxfYDj3Wg79af7?=
 =?us-ascii?Q?j9HKonHlicOCdIibclCBoT/T5Z+9leDbLjudXiJrr8VNLiDSboxXSoRtcq6y?=
 =?us-ascii?Q?4COH3GHnZkiUpDzqiDZwvIQt2GB1Zr7FSNaSoy2Ic6dwSVAm86pzlghPKN2O?=
 =?us-ascii?Q?cF+8dy8k8PQhlftUyGooaoNBMwkjbMSQivDOiN7yVjPgV6baQjX2VdLZoOLX?=
 =?us-ascii?Q?bArn83e7o22UCd1T79NG7oGtLke76yOSMYJkGnmdZTmfGEoQh+fSQtlfVZCu?=
 =?us-ascii?Q?O305rRWgpjIHrt4nUzl++wdb9/cHf72LHF5dbbl3Te4DQt+6mPAAnC4KL41r?=
 =?us-ascii?Q?nUDzCWYpZDxYGhdtICNvPKmkbZTtDxTUETrATCjbbr1HLj1P9IrOgN/ureiD?=
 =?us-ascii?Q?9B+FkglMBT2hiacSuQzSsxnMFys7B/pOD8Ehm4TnEZ878S+RJBeG3mxIEDgz?=
 =?us-ascii?Q?bIvXBHtM/NIv80BKQyDZv+WxbRAXVIlv3eeP6gyZDYAcVDWC2fbgaqXNnZny?=
 =?us-ascii?Q?YrKECIf0VhXUjF0KM0x3kX81wuzInOJFqDM6UslnqTcvQ78TcMwq6jEEY7Ei?=
 =?us-ascii?Q?GvScSuLXHSpGqgligA9zULho9V451BSbC0bPFtHXgGgt3WyuV5/eqXiVSfH6?=
 =?us-ascii?Q?CtSZE5kVOWfvfRr7W8HQihX9MCkPMliERc9m8YO1Ewl5IwRfmD68K4uJHvFc?=
 =?us-ascii?Q?EpkMVULSV/HzZqvJ35P4S9blpwatZznKjhw4CviljAIt0oZdAc4ReNQhm2CL?=
 =?us-ascii?Q?umqMBjtdWZd8+r5gnbE79jXAJN33gXwEG6uLYQAzk20L1euHNcQ0/Ql6XuRs?=
 =?us-ascii?Q?4CgWWRGz9YvanX2i/Z8zoLvCtqEfWYoVca45kO3MfDljPmLHTH9Q/JFsVoSV?=
 =?us-ascii?Q?F+vBsQZ7HA6DRkG++5EfqeBOANE5kEEE35c/aO9MZiu0+vOIQq8ZC/VTP32T?=
 =?us-ascii?Q?nL2cwNqqEnoorTHeIZpo2IAf/5Sfe3GwRerxZIyWutaaJQJ/bHVahWg9Pmhf?=
 =?us-ascii?Q?AZPjoXFlGBckW4AcPIqX8SdjJ6EOaWV5sHAUMx05WDiG0Uo/IaRAcSfMPRqg?=
 =?us-ascii?Q?dpPy6chVTsUyywkPSQQ3+jL+9JqhguJfJA0PUvp5XVpjXuIwRSZsh3lE1Hyo?=
 =?us-ascii?Q?1rrwHIgSKjnbPi/PIhH/grBRv24NiRqb2SDMMzRC7sN7mqdHW66ezoj3KQRf?=
 =?us-ascii?Q?JfcaOyPaWdi0Do69nMXb6ARa2u77w0kP4ehDRpmgr0ukVhrgWVIjdqESJA+n?=
 =?us-ascii?Q?Q54Xvu9+X/zzq9Swh3MVPtd7pNiM9r+nHcp2ZCsT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:35:43.7597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4644520b-c4fa-48dc-c502-08ddfc83dd39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9460

Restricted CXL Host (RCH) protocol error handling uses a procedure distinct
from the CXL Virtual Hierarchy (VH) handling. This is because of the
differences in the RCH and VH topologies. Improve the maintainability and
add ability to enable/disable RCH handling.

Move and combine the RCH handling code into a single block conditionally
compiled with the CONFIG_CXL_RCH_RAS kernel config.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

v11->v12:
- Moved CXL_RCH_RAS Kconfig definition here from following commit.

v10->v11:
- New patch
---
 drivers/cxl/Kconfig    |   7 ++
 drivers/cxl/core/ras.c | 178 +++++++++++++++++++++--------------------
 2 files changed, 100 insertions(+), 85 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index b92d544cfe6f..028201e24523 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -236,4 +236,11 @@ config CXL_MCE
 config CXL_RAS
 	def_bool y
 	depends on ACPI_APEI_GHES && PCIEAER && CXL_PCI
+
+config CXL_RCH_RAS
+	bool "CXL: Restricted CXL Host (RCH) protocol error handling"
+	def_bool n
+	depends on CXL_RAS
+	help
+	  RAS support for Restricted CXL Host (RCH) defined in CXL1.1.
 endif
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 0875ce8116ff..1ec4ea8c56f1 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -126,6 +126,10 @@ void cxl_ras_exit(void)
 	cancel_work_sync(&cxl_cper_prot_err_work);
 }
 
+static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
+static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
+
+#ifdef CONFIG_CXL_RCH_RAS
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
 {
 	resource_size_t aer_phys;
@@ -141,18 +145,6 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
 	}
 }
 
-static void cxl_dport_map_ras(struct cxl_dport *dport)
-{
-	struct cxl_register_map *map = &dport->reg_map;
-	struct device *dev = dport->dport_dev;
-
-	if (!map->component_map.ras.valid)
-		dev_dbg(dev, "RAS registers not found\n");
-	else if (cxl_map_component_regs(map, &dport->regs.component,
-					BIT(CXL_CM_CAP_CAP_ID_RAS)))
-		dev_dbg(dev, "Failed to map RAS capability.\n");
-}
-
 static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 {
 	void __iomem *aer_base = dport->regs.dport_aer;
@@ -177,6 +169,95 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
 }
 
+/*
+ * Copy the AER capability registers using 32 bit read accesses.
+ * This is necessary because RCRB AER capability is MMIO mapped. Clear the
+ * status after copying.
+ *
+ * @aer_base: base address of AER capability block in RCRB
+ * @aer_regs: destination for copying AER capability
+ */
+static bool cxl_rch_get_aer_info(void __iomem *aer_base,
+				 struct aer_capability_regs *aer_regs)
+{
+	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
+	u32 *aer_regs_buf = (u32 *)aer_regs;
+	int n;
+
+	if (!aer_base)
+		return false;
+
+	/* Use readl() to guarantee 32-bit accesses */
+	for (n = 0; n < read_cnt; n++)
+		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
+
+	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
+	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
+
+	return true;
+}
+
+/* Get AER severity. Return false if there is no error. */
+static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
+				     int *severity)
+{
+	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
+		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
+			*severity = AER_FATAL;
+		else
+			*severity = AER_NONFATAL;
+		return true;
+	}
+
+	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
+		*severity = AER_CORRECTABLE;
+		return true;
+	}
+
+	return false;
+}
+
+static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct aer_capability_regs aer_regs;
+	struct cxl_dport *dport;
+	int severity;
+
+	struct cxl_port *port __free(put_cxl_port) =
+		cxl_pci_find_port(pdev, &dport);
+	if (!port)
+		return;
+
+	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
+		return;
+
+	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
+		return;
+
+	pci_print_aer(pdev, severity, &aer_regs);
+	if (severity == AER_CORRECTABLE)
+		cxl_handle_cor_ras(cxlds, dport->regs.ras);
+	else
+		cxl_handle_ras(cxlds, dport->regs.ras);
+}
+#else
+static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
+static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
+static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
+#endif
+
+static void cxl_dport_map_ras(struct cxl_dport *dport)
+{
+	struct cxl_register_map *map = &dport->reg_map;
+	struct device *dev = dport->dport_dev;
+
+	if (!map->component_map.ras.valid)
+		dev_dbg(dev, "RAS registers not found\n");
+	else if (cxl_map_component_regs(map, &dport->regs.component,
+					BIT(CXL_CM_CAP_CAP_ID_RAS)))
+		dev_dbg(dev, "Failed to map RAS capability.\n");
+}
 
 /**
  * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
@@ -270,79 +351,6 @@ static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
 	return true;
 }
 
-/*
- * Copy the AER capability registers using 32 bit read accesses.
- * This is necessary because RCRB AER capability is MMIO mapped. Clear the
- * status after copying.
- *
- * @aer_base: base address of AER capability block in RCRB
- * @aer_regs: destination for copying AER capability
- */
-static bool cxl_rch_get_aer_info(void __iomem *aer_base,
-				 struct aer_capability_regs *aer_regs)
-{
-	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
-	u32 *aer_regs_buf = (u32 *)aer_regs;
-	int n;
-
-	if (!aer_base)
-		return false;
-
-	/* Use readl() to guarantee 32-bit accesses */
-	for (n = 0; n < read_cnt; n++)
-		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
-
-	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
-	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
-
-	return true;
-}
-
-/* Get AER severity. Return false if there is no error. */
-static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
-				     int *severity)
-{
-	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
-		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
-			*severity = AER_FATAL;
-		else
-			*severity = AER_NONFATAL;
-		return true;
-	}
-
-	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
-		*severity = AER_CORRECTABLE;
-		return true;
-	}
-
-	return false;
-}
-
-static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
-{
-	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
-	struct aer_capability_regs aer_regs;
-	struct cxl_dport *dport;
-	int severity;
-
-	struct cxl_port *port __free(put_cxl_port) =
-		cxl_pci_find_port(pdev, &dport);
-	if (!port)
-		return;
-
-	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
-		return;
-
-	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
-		return;
-
-	pci_print_aer(pdev, severity, &aer_regs);
-	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(cxlds, dport->regs.ras);
-	else
-		cxl_handle_ras(cxlds, dport->regs.ras);
-}
-
 void cxl_cor_error_detected(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-- 
2.34.1


