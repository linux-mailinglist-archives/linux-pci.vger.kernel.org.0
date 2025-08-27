Return-Path: <linux-pci+bounces-34828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742E3B37722
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6C036058A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2881991CB;
	Wed, 27 Aug 2025 01:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L1GE2xFR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3E81D8A10;
	Wed, 27 Aug 2025 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258676; cv=fail; b=JOuFTX454iBuV6UGyJlUiqVxOxusqyBoSkSpEcQcx3HKMfK2F+7+GBTKgH6WKZET0uinOi2c3qAiCdg+QfivPZ+cTfS8Qz6jLyF4PANCX7th/yOiComCEpyD+6bLxROnRAZgTyt16stEgLUhb+kLtZ8YDnU4Hp5SR8dvPDTtpQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258676; c=relaxed/simple;
	bh=I3terxH4cCgWWVIS9ZOdWEyK/Yk2xJ6FKEk5m25o+7s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gg/aWaHPK8hcpkEVfCDVncSzzSATZEcBp5vNXqNs0GLNvOLlcWwMzKc0/JKpzYgltiswfPM1UQFQ+mh5NAp+SW0RN31QcUTLS2WXORt8Qzs9fazJSKZLJXCIlQV4TA7RFwosTvGTylQkimh0QHcBaXYNd0Z4CoITSArzjs3Yb+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L1GE2xFR; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpgJ7bCJ7HV2ROaJ4I5u/QzWbF6VM/GyZzkbMJz+Wp7d2epB3eUGDODphYk7HYFYnR9bpSZO38rpsV7B96zEh9+MgI69UqZBENLzahnl5f+c324T3/iJGeEP74V2W/B2PpgXf5rC0EBkK6EOxOnIv67rHOWWp2fAier0k9l0QKz2s8MXgGqwDDrMFx9FKAm/M/J6R2db+m2BjWbboWdztO3FLSjEmLW5MCTLebbHoWW9h62feqmPfV57DfkWu5+JZE6OCe5t0fBTyhtplftlgpsjUET8K6ioax/vdIJFQ47xY716XJH46fTOE9SCYFzI68+/vHsfnuXa2zlnR9VB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pW3ulZUyXPHu7pR/tsue6OccICIkY7A+VKWvJMo15s=;
 b=bGYbPVHn05OxghNwAMODRkLGwZvqX9VM0g23fvldSeRhDAF4wCJjB73LHplPF+VU17cZW4GXjV1cH54tGnV+GVc6qIMFHkwui8YknyVwe3Kw/aV6ds/EjaRAW2J9pVRP41SnUtwkn0yRNhY9NkY7FJTzZLv4N6dP8nmhKkV25gPUlLgTFtYEtmCemsFNlx+G6geZGmMvY0qwBCkAJa/8Ul7RSp1AqFbK+SLddupwKZrW9pbRzdUMI6V1HhOJVOfS3y2cfPuYXurkVcfW179WAHJLG33u1q7Ys2WcfkXaAXyeo+XBsCY/Tq7VSJVpiELAiRmeAOcA01zSoUqFfgzXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pW3ulZUyXPHu7pR/tsue6OccICIkY7A+VKWvJMo15s=;
 b=L1GE2xFR6GK4Sexuf2rRrBpXNXxrvjOuYqkfBDXgqS6jAoVzOfWId6LyeF/TLPLZ1moa6a6WK3b8nR+lx8zZ4N3ul5NU1kEeDaRfU2twrsaPjxkaQEYUusKI0ASWCUzK67ryWT52cTUThnkD1PhUSPXjOlm8BnkUuCtXIWKkBfE=
Received: from BYAPR02CA0053.namprd02.prod.outlook.com (2603:10b6:a03:54::30)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 01:37:48 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::66) by BYAPR02CA0053.outlook.office365.com
 (2603:10b6:a03:54::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.23 via Frontend Transport; Wed,
 27 Aug 2025 01:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:37:47 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:37:46 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v11 11/23] cxl/pci: Update RAS handler interfaces to also support CXL Ports
Date: Tue, 26 Aug 2025 20:35:26 -0500
Message-ID: <20250827013539.903682-12-terry.bowman@amd.com>
X-Mailer: git-send-email 2.51.0.rc2.21.ge5ab6b3e5a
In-Reply-To: <20250827013539.903682-1-terry.bowman@amd.com>
References: <20250827013539.903682-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: 9424bea5-4643-4f47-6334-08dde50a542e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|82310400026|1800799024|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b1dpH3YB+KP9ITh5p34Jw7Nl26ndNFv6LYAfHBBEX43PuL9CR9xes39KD1JI?=
 =?us-ascii?Q?yrHWSvRiqewpxRlFhnrQwKzrpR70LNu9zYOd7AoMbUBA0HWHJY636N9RQO5D?=
 =?us-ascii?Q?ZwG8J1wC1CxMIpSqQ3BSFeyJSeVpbzkSA1oW8h1r6dAM3jr62nyzyMEqfgPu?=
 =?us-ascii?Q?uODM7Hyor6lwPhi6B+mTbRcHd1e1FNU2gZPVx8ZiPb7klxiSQK0cLYkHh10Z?=
 =?us-ascii?Q?VXLTr7PDSkFBP5AXNMm5S25gM7BQWrttTilR1hsZFboptWvjCehhqnbLIlaf?=
 =?us-ascii?Q?/5v5Dekuo2SSQf+x1g8A4R051bjsNSEeHqQzt51k+VgAVWZKrtpbNRyqE9NO?=
 =?us-ascii?Q?Xqwyyw1uYeD7G4z7g2XewKa6Bbchk8nIESaoNY4GSdriHzxmsDM7bpFg5mtT?=
 =?us-ascii?Q?CmPG+txU/3HXUamDqGU0LioMBZx3Wlja/0T3y06gvCQcPMds4K30bQ4iP+zS?=
 =?us-ascii?Q?KREfikGPAuFrdZIWmmkrepnhXS1TTyM5e7SnlNigVC+Yy3aoSLfkdD68kvNJ?=
 =?us-ascii?Q?cNRHRjb9UZpjALtk/JkOfqzXiKH/5B3ygatyBTDXqPoK/DqupfHB3ooWbX1s?=
 =?us-ascii?Q?1ojobuRr5sCD+YUP4b/6OZ/pn0sOAK+PZej202PcjqtdoAKrpwQdgkKdmTOM?=
 =?us-ascii?Q?IYg/ljBTXtLiQnUiHLYTojUgXo2cg4gUYBiI5OIXt9zscaTaxgpa14L3Dhp+?=
 =?us-ascii?Q?BSQ7i73pBzsCrY3v4Q77gXJSa6nqgJh7+Z/9ZQdynUUbjGTbS8fHeea3AZH/?=
 =?us-ascii?Q?qUNiMcuCVOQ0FFxiRqpFG0IhFgaN1M8nWjATwv/fXdFAe9iN1AurAoPk19oA?=
 =?us-ascii?Q?F9LX+iJaBhP8bKV8wWSFmvYh2EhX2teS7uDSvMJmTmzM8/HOR8txJ7qDJiwM?=
 =?us-ascii?Q?ELHajyMJ1FAaQ5Z86OrEw7r45dkT1D4YrQpCqgUUrmdGJLpPUWdVOjAAMJV3?=
 =?us-ascii?Q?n1VK10P4pGtmpUsw2AFLcMa+1bTopH2wOvRspWYea7laqCZS/Zjx6vek67c6?=
 =?us-ascii?Q?sLCLNkH/6GrU8QWTFRzSZyKMnM9DRJTp6agxtT+DhnBQeZOigEpMsqj0Q/e/?=
 =?us-ascii?Q?fqlMoI41T9n4Yekqs/yxBlZ2LTjRzlDSfIMTE4u1jxp6pGA1/0nEYme/kfpa?=
 =?us-ascii?Q?rKtPwHFB+b9aPbpZVFnpgrWG9K5fYCSOl50RqXNG5tJP4LEoWzDOJMqMK/4h?=
 =?us-ascii?Q?pnjnfZ2jbRrzj0wTTu68+RCuM6VshyyCsJUJ4vmZX08TLTxF5EksRzJp6QjT?=
 =?us-ascii?Q?aFxmJB1wstx2M3Klkdrkg9vGVskmQdzO1U98uOLfpOEVhazaTBkHJJw6VWkm?=
 =?us-ascii?Q?eXJ0TttYGsQ5BMsFiMrMXwz6DYSnpAVQLgvMRBInNVv+wrGmUlyzvBJFPbpI?=
 =?us-ascii?Q?Tlbh0CzoCBKSV71JmwMNNbGCTElJy1q42JNCSHi7PX1y36LPr5WFX/sfMDS1?=
 =?us-ascii?Q?FwOjChuYS1fA+KQKdiwMxZZDZGOzs6OzB+aE8HBaC9pqGsj6AY1DwpMns5X0?=
 =?us-ascii?Q?2mJqXZahIxCWzm8EHP0rCQqlfustr/uDFUOsxYQiJcJhNQNalxpg3/WkiQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(82310400026)(1800799024)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:37:47.9892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9424bea5-4643-4f47-6334-08dde50a542e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461

CXL PCIe Port Protocol Error handling support will be added to the
CXL drivers in the future. In preparation, rename the existing
interfaces to support handling all CXL PCIe Port Protocol Errors.

The driver's RAS support functions currently rely on a 'struct
cxl_dev_state' type parameter, which is not available for CXL Port
devices. However, since the same CXL RAS capability structure is
needed across most CXL components and devices, a common handling
approach should be adopted.

To accommodate this, update the __cxl_handle_cor_ras() and
__cxl_handle_ras() functions to use a `struct device` instead of
`struct cxl_dev_state`.

No functional changes are introduced.

[1] CXL 3.1 Spec, 8.2.4 CXL.cache and CXL.mem Registers

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

---
Changes in v10->v11:
- None
---
 drivers/cxl/core/ras.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index c9f2f0335bfd..f65557e7bfa6 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -126,8 +126,8 @@ void cxl_ras_exit(void)
 	cancel_work_sync(&cxl_cper_prot_err_work);
 }
 
-static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
-static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
+static bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
+static void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
 
 #ifdef CONFIG_CXL_RCH_RAS
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
@@ -237,9 +237,9 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 
 	pci_print_aer(pdev, severity, &aer_regs);
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(cxlds, dport->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
 	else
-		cxl_handle_ras(cxlds, dport->regs.ras);
+		cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
 }
 #else
 static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
@@ -281,7 +281,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
-static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
+static void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -293,7 +293,7 @@ static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_ba
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
 	}
 }
 
@@ -318,7 +318,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
+static bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -345,7 +345,7 @@ static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -367,7 +367,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -396,7 +396,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_ras(cxlds, cxlds->regs.ras);
+		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 	}
 
 
-- 
2.51.0.rc2.21.ge5ab6b3e5a


