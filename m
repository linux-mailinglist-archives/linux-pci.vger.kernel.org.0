Return-Path: <linux-pci+bounces-44810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A913D20D07
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3588930150F7
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA972FFF8F;
	Wed, 14 Jan 2026 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yZ9l4Hy7"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5898632A;
	Wed, 14 Jan 2026 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415093; cv=fail; b=k5ED+Jnkg6d9V3t9xotkCOAm8nmJdlfgxRjzJt7JF6+NVCVG3t0UGfgogBc0+qMmdKqnNgogdQm/XLDey2Om9CiX4xrh2nbHDmOv5K+smpB2K/MozKf3gT7FOd89QTqgfyOVmUsrh/88V1dSWmiAXTaw8UhGw1tk2+JyBAfHW3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415093; c=relaxed/simple;
	bh=w9rjqtupr8la22aZF/O9shy/+RDkhceLcPvHmlwzA34=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6+GOyaAh30yt4EBpESNpnSR7YFln1lmdvE1g+XtlmSutjuRqL97adtgfB810Uh3LaVTV98EGMZDK+tqyTp9iFoJ1i69tae4dbPcNDPnt2pT25HXiTQ9V+Z0G4ytasSyrN9ireUl6lmyABa7h2yl45WdRIZ56bH76GNiyakX0Ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yZ9l4Hy7; arc=fail smtp.client-ip=52.101.46.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwshisskeYfi4xCa70dTV/+SVI8F5mEHQp325j0wR1nsE5sqfK/iH+b97aeNFZqQSv+1R4QfeCLYAvoZW5028gbgbM/d217bbVFPLi/Ph/Yrt1VE8dMEjIRvbjDzP550ryleZo4VWIL1P4yNAopSgoMZXiBxvAcrqNDmUfToy59Z1RsO4AjpKBjEeBOuhA/lnq8wpiGanan2UkgSJcQx0l/0Gxn/XX71Qoc72TQK+88O02KMqpcx61WrfRYSUxVNAFJ+syHke9GpNflidv9uanrgibjl420s8Rzuu4qbfv+Fyqojwojpa+o8z6uG6YY4ZtyRKA2cK8PaSIJDrD/m8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkabJxi6VTOFU46HpBUlZFCMOAIFmnBWKOGwUQfsSLM=;
 b=ABCmbZw1+RwrRShb4EK1Wazcq0y5I/1f/EpXNc/qkcGL/CYGLMCssO1lJjuVPT9pygmr/Eh90NhdyakzxaBE36m6r0uAxV2MYBiebtrXdMf9c5avaRnpnBYbd+6ou5ergFoiT2E9DUMUnHIPSJ7w5LwdPxfTXUQ77qW/ee8O7905j+rcnLqJpqufGvH0IMx6O64q41t6BmtCLIytn7sxf+ZeZcVomkr4boQSH5Xz/0Klho7AmfxZyqxXDtqCbws7TanqS8Np8Y+n0N6TIh49n/nLJRLXZ8R1DFVgs12Cv3qNXLwCs5FW0D23htwpetgmVh0CCqlj6P2tAM+GBwl9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkabJxi6VTOFU46HpBUlZFCMOAIFmnBWKOGwUQfsSLM=;
 b=yZ9l4Hy7px0SlmpYSByiScUz+drRRhqz80nvRCxEiimwhBGD7qvBWIcGQiezWng/SSokjk/lo50z8HHaMFdsYrEfdH+OEx2AdCxju3d1pd+vmm/gD/fqqLCR2Dgmdq+RnJuC4JggDbPx/wenx4IWyXEbPBf30kqPhBQlZvLzvNc=
Received: from CY8PR11CA0030.namprd11.prod.outlook.com (2603:10b6:930:4a::15)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 18:24:47 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:4a:cafe::50) by CY8PR11CA0030.outlook.office365.com
 (2603:10b6:930:4a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 18:24:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:24:46 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:24:44 -0600
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
Subject: [PATCH v14 17/34] cxl: Update RAS handler interfaces to also support CXL Ports
Date: Wed, 14 Jan 2026 12:20:38 -0600
Message-ID: <20260114182055.46029-18-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ea3fcf-ccb3-49a9-c8fc-08de539a31ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|30052699003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JogojgF2je7ctgSLYSCTusVsQU4gC3EPx7M06S0wpy7haNSt6mjNBMMDyLoS?=
 =?us-ascii?Q?hNE+240PboS85sPj0C5gRmkeHN4gkaj06LZIi3EqGiQ8EBUemu5VYt2P8HQ8?=
 =?us-ascii?Q?MxrfiYrJ6kUn4MnLs2Un0++hajvV9N/nW4lUaMZunbE/LEjQ+8FUWmExpgLT?=
 =?us-ascii?Q?V5PaDmH6kncTTnPnvZX4nEBM1VLoY+f3bj6KJ1ncrXNryMm9bXJ+Fhiw5p8i?=
 =?us-ascii?Q?1JMtO/CfGBpD044SlGcb1dmONgIf6X2LFQarjim2ZmcJFErcduSD/8M6ycY9?=
 =?us-ascii?Q?WFjz0c8A4WiHKTUMIzl+1pzws7xKNzmiPXvpncguK3royAbgJeOqXCV55Y6o?=
 =?us-ascii?Q?12c4J0e1uPDlo0nYNKgEOsEwBnim8Db48wkFwbp7debYJLECXWOYImjfl5p9?=
 =?us-ascii?Q?J8D9klNDOCuZ1vYSUnn/PSTVKYdlG2qS8IHugRuL1jGPDmuI0opyf/Zt1psn?=
 =?us-ascii?Q?K6ejdJFB6DSPhMbG9k1nrOh7fWEyq9sxovlKl5kdGk/uYPJioWjcRTRfAjQF?=
 =?us-ascii?Q?LZxcybmxZBBVaygMKR4zdosFsv3wcpkluqKx4ZDya1tV4s/2Rm0Ui1GvWcsr?=
 =?us-ascii?Q?+pgW0F4rEHOomo4VXT3j0GPsOYqfnfemInksGhRtrcSHZAx5lgNhRRuG1onT?=
 =?us-ascii?Q?4YUre6lD6gaXe655rt26xbJV/noZREAkTLNLPiPfI/2ykDVFQTPuqyWMCxPl?=
 =?us-ascii?Q?GHlfRFgrcVe+JJht3Y75c7FZ3V+O2ml5D5apKMSke2/oJCaVvriycRmHgk25?=
 =?us-ascii?Q?VaCUoFpjmFjaRyxsKD5Mmfqv71vHXjSUEpRbtnByWgTZ2Zv9xvNFdKDun+8f?=
 =?us-ascii?Q?lnKQXoNwe7Oruq4ccnZrM7YjChvCvyeo2xKdc629tptnjN25bXxFgd4BI5os?=
 =?us-ascii?Q?/T1pZOCoVUwxCykuKEzpnL49VqkIaPMTR73PjcMd955CELUaXNgkczimlrIA?=
 =?us-ascii?Q?S+fGT8Wz9+iKWeaGk48dIG3hDjvUXwJJGs/4b8N0c0nj44peIw+r3ZN3tFNT?=
 =?us-ascii?Q?3IwhAsWtGrZE2lhCw81e8vk+lbGH1xMRJR3cRzObUZyTvrpI5lXukN/fqbpL?=
 =?us-ascii?Q?ahDg1yQ2RsAaJKgc1j+1NF1oJj5eyAJmknlDxzIv3WTYGRalFcREUD4de7Un?=
 =?us-ascii?Q?Ur7Tfeok7ejd8lCrUjaDlusqgiTN08Ahqc1M8zgONS2g54QjUvz/phPh+Hm2?=
 =?us-ascii?Q?4ImNAK2OPSZRnx9YaafmEjDdydV2oxcM9AZoGueiFkG+ls4BZRhT5E/OLuOR?=
 =?us-ascii?Q?OjOZfyFrlTRyTcj96XM/sVTEmyhIs3a5qVZREzIgSkO4+fOvJPmGaESCJhIB?=
 =?us-ascii?Q?smgI17y5dEpRA1effWuEPBoNNmBWfs2RsKgyY2ZvgskTlLhHf5inkqOZFHK8?=
 =?us-ascii?Q?MO9tdaepzRaEjgO4+peRC0TFTYl2oM332evXmX9qogsLHs3Clv2KuB8QoZR5?=
 =?us-ascii?Q?rU/NlDE84QCuMwXTPC4r//2KKIKWg2N8mOkkK8whCSxCPrKiXZ3IZuvp7DXo?=
 =?us-ascii?Q?+/U+FZB01fKggOPyPiJzyDcWd6XWUXPleqlPArSFjTaHvpPWPheI/JrI6nlD?=
 =?us-ascii?Q?ehZ3/9CDmp8C8+f4o7TAvizA1lE9pLWturXnMhQe8eHMHaXwIsfY3jC4xwZn?=
 =?us-ascii?Q?d5jjR70dnzz4XN8AKmEfFVyUVb5f72sUrohPdTUx0NFSMbaEcuUg+wbDGhtP?=
 =?us-ascii?Q?Ahv9BiXcBJ//oFOBj9q9OmtZSKY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(30052699003)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:24:46.0045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ea3fcf-ccb3-49a9-c8fc-08de539a31ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519

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
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes in v13->v14:
- None
---
 drivers/cxl/core/core.h    | 14 +++++---------
 drivers/cxl/core/ras.c     | 12 ++++++------
 drivers/cxl/core/ras_rch.c |  4 ++--
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 724361195057..422531799af2 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -147,8 +147,8 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 #ifdef CONFIG_CXL_RAS
 int cxl_ras_init(void);
 void cxl_ras_exit(void);
-bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
-void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
+bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
+void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
 void cxl_dport_map_rch_aer(struct cxl_dport *dport);
 void cxl_disable_rch_root_ints(struct cxl_dport *dport);
 void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
@@ -157,16 +157,12 @@ static inline int cxl_ras_init(void)
 {
 	return 0;
 }
-
-static inline void cxl_ras_exit(void)
-{
-}
-
-static inline bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
+static inline void cxl_ras_exit(void) { }
+static inline bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 {
 	return false;
 }
-static inline void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base) { }
+static inline void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base) { }
 static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
 static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
 static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index b933030b8e1e..72908f3ced77 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -160,7 +160,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
-void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
+void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -172,7 +172,7 @@ void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
 	}
 }
 
@@ -197,7 +197,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
+bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -224,7 +224,7 @@ bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -246,7 +246,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -275,7 +275,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_ras(cxlds, cxlds->regs.ras);
+		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 	}
 
 
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index ed58afd18ecc..0a8b3b9b6388 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -115,7 +115,7 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 
 	pci_print_aer(pdev, severity, &aer_regs);
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(cxlds, dport->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
 	else
-		cxl_handle_ras(cxlds, dport->regs.ras);
+		cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
 }
-- 
2.34.1


