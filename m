Return-Path: <linux-pci+bounces-40240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD19C323AB
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CCC318C57CE
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3343633B96E;
	Tue,  4 Nov 2025 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Frt6FqeR"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B5F3203A3;
	Tue,  4 Nov 2025 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275886; cv=fail; b=TWunu3G7n1DeFUFfa2T3kCVWrqn82hey+hHD1vOTnZ7yfWeJsnTAaysBZLatycy7puvY3Sr26fTC/WPtFAq998+k2STXD0g4ngMWhDIobZ2FvJbVmJbjitCeEbUwoj/Q0fMsiKBcZ+jEdBzA3m+pBpUMc7sVOI3761wb1tBWXx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275886; c=relaxed/simple;
	bh=D6IaG4zkv8vJcMrlJVNbuzFvaXy1MRuW/Jz273ZvSy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWfnW1wVhyGYslh1JomZTI+x87NsrzkflbTN7dOSDxK9XmDY1l81eGyy3dNrgqZXimN+PjIylEhD8og/S6LlKFiOlycc356lxiWjDsCLz1+HlMlX9doSA+stBuyIIclwW0yPgye7OKLcaCWAIYHOLTRmiMmUqXSXNNFwjEqb/5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Frt6FqeR; arc=fail smtp.client-ip=52.101.61.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCPb6oJLNZUJfshbyL7LREcMhFHiyaWS2TlM/IYDJvNn6nq1141xIKhq4RiHQqwDaUHRc8r5hhKr0azqBRBXIzxl6b3Cg/1VG3UeW94BsuwEiXXLjVDPGbSl9j34W+OIrfHiC/Rq12s0jUGxllV51jJDsoSLLcRUF1PajWn3hLyygEXsSLEO6BJfaQ3dJFia/zFvboUSYPNKR1OduPx3oudpycnd11GGsqx6f0ggsveAubV5yTAtjUtV3uBuJEii0en17lBjUhBglfcyA6nJl3qj228QTgyhZJYbxDhjvKAfv5dBwFh276XwyiTPki/4cSkPpM6OBn7/gwT2etSReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHJGTQk7l+jMCiJpIZdDLFaHj2vwMe4lygtyU8ct2z0=;
 b=Ot8BaURYOco0ZDMqxIeuoOds+X/k8JdT2kdP6ytWdg4CfS6xuyNo6nSkPT0gVQe9kgkpsQ/OzP0/eEWmx4FXtOnk1EappgU5UOBQGlX30LJn/bFrgw4eyhieaOebWVZdK55xoLwq/J83ji9nTe84tGBgHzUuuHxJP3zsPKA7xgdzVYFiAXxYpGcTu5FVDtk3QzO9LcaDO/R0dhPHp096UAjNi1GESO6fWDJ+fqCZhd+oTIO2Pg+g8qcP91CRkDEUzo8TXrMUQjEKAj9lcufVT/auWzROFytgRVvMzt/Bi5XMYRDPXAT1PF2fxfJ1C1YXae3BZyThflb1UQbItOuINg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHJGTQk7l+jMCiJpIZdDLFaHj2vwMe4lygtyU8ct2z0=;
 b=Frt6FqeRPr8GZkmkOlUZHwqK7tPCiZgiiYGo+2MwH9XpmXT3yAFYO0JfqM5mHBP46Br5tjDoUkU1p4EJG5Yp/RVG/lIHZrbrCMm1F0WwzSbHtnX7RI9NPk+oqqn+By7Z3OMh1Ly2t6UtCffsvyywDUWV/ellkZgeodOM5O44JD4=
Received: from MN2PR20CA0042.namprd20.prod.outlook.com (2603:10b6:208:235::11)
 by LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:04:41 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::81) by MN2PR20CA0042.outlook.office365.com
 (2603:10b6:208:235::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 17:04:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 4 Nov 2025 17:04:40 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:04:40 -0800
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
Subject: [RESEND v13 08/25] CXL/AER: Move AER drivers RCH error handling into pcie/aer_cxl_rch.c
Date: Tue, 4 Nov 2025 11:02:48 -0600
Message-ID: <20251104170305.4163840-9-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104170305.4163840-1-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|LV8PR12MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: fdfa79f5-8f52-4637-c369-08de1bc43e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gFvcqW0uZY4ZBFVCquGlzVDA/HDg8qSSw92iPL11u3gwNLe6+OLJuj9BuQU6?=
 =?us-ascii?Q?a7Di3XWHFFjHvSbwGEYJfSrZA107/ey/VevXDf8M/vSscz2lb80cffhQnjAM?=
 =?us-ascii?Q?yMWnFwo4WHNxt2C+0BlqVbYANeQF47eEyKO3Xx3FbDMawqgDNZ+eyl25iO31?=
 =?us-ascii?Q?Bp1aBMoUA3bOcxSpGU2XzaWVv9K6LKDcUIUT7PPAYngf51bh6lRBWwCeRaeN?=
 =?us-ascii?Q?FqUY5qjkS8ur8u8ZgWiOmXa03t9la/xrgdd2tCN5Xq20EjMoWAahJ+6XU55D?=
 =?us-ascii?Q?/WfqGOA6t/EuJ6iL4PrcHNFk5RhG0NpGuIHh6lii2a0toyt5abK5/u1VasLc?=
 =?us-ascii?Q?LbA6KeMq7hiw6osWGRNi/oukb22VN16yL7ILEfz3aMBTK5lOS3fM3EXlO+GP?=
 =?us-ascii?Q?GsTM252u53jXs6gMQAkpMW6oSvfjmOLZdzstjvGpSMAD5c8rug47GkReL85N?=
 =?us-ascii?Q?YztGFpchulap6QsKcURO3cpdpm9yz3lR7NB6imiGCPCK3ebudc1Eti2SKCbp?=
 =?us-ascii?Q?HrVzGuupYVhIIRwRoMSrjUfTk3H+Eg1iLyIlR/Z55bsnE9+f7mF3p0lq6Cid?=
 =?us-ascii?Q?Aatj9UrxFGTJ3WvOym/geSeZ9T9o2KiP/Fad/oXi7Jzj674Njn8lkRwo6eVJ?=
 =?us-ascii?Q?VJNkaGCg1rX+5ZhNgxu8LqxiHiBYcg6/tUw8QTgslVcxO36/x6yvmdiiyea/?=
 =?us-ascii?Q?BF5SaNLcQ1gi6c4DZihvMPA9EsagF1760gfCx7WE8kxxhLpFykS7b0wSIy4a?=
 =?us-ascii?Q?k/DYShUqXfzYjaxJgqw1CNbBtjGAHjkXisk5IeBDyHxZ78YhrPF5Uqd9CmNr?=
 =?us-ascii?Q?QcU1HDSOyxoh6WGH4IfdfjiwwgNEJw1oeFDr8On7xLtCvCBUog1uDC2cJStG?=
 =?us-ascii?Q?YSlDot9Uu/QLZsuZVw6e53m9gcF222jYi2jq7V8/0Ov1abdN4CWydHrw+pVW?=
 =?us-ascii?Q?ro49aWOdU4sVg2Y7BsPACC5fb+zDHonRd/aPNKapPsrV4rwuvQE3SLzUhNYc?=
 =?us-ascii?Q?UHxDh4f+4W8JTKUdRoLZydltfftiU0+uEjVOBud8ICpkLBojYG1vh6Q/uRFp?=
 =?us-ascii?Q?XHaKsDVv6hf6CWZXDq3H1LQL+jpmRnaTa13WlpulCCpcutAB3+jGB+rCtKxM?=
 =?us-ascii?Q?NwjGW6d2rRIhKR4qyq3r4i3fJNoDmAOrh90yhzd0QYjE3+mfglWVXfWH1ry5?=
 =?us-ascii?Q?IvV6MauNY8e1hJ/1HwSAz/aCthqP/APj3VHpLpj83+OnUAF3zTJFDbImM3Ma?=
 =?us-ascii?Q?KkbF2Qmjmuoa5XjDiutV4kEcUrZ/VfZ7EH2WutH3SJ4tKlLmRKKTGdp5Mmv9?=
 =?us-ascii?Q?6u+Az1CnaR7b54LQAeh/5fNeFYa6vmZhGBSBAFj+nwiI3uEoK29VJElXF7hp?=
 =?us-ascii?Q?8kVWYV3X5Nz6Y64E+2UmC8MFhqfVyAgr1K/FBy3DQQx42NOWLEHleQjAQ+VO?=
 =?us-ascii?Q?swliz7VPgbJCXbfZzvEzk7HmTSAgnpKKeTOjJzFJfVfm2RfJWGMyFTWMzbt/?=
 =?us-ascii?Q?oZyRCSNRWD5dC9JUS/f90Cj6Kq4PplTT25t/d30K2wrCEpxVZmnuC5fsz8Wj?=
 =?us-ascii?Q?caihbldZTY7ZgsTIhqcjIvETjqb+uXDUbPZKJ8X9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:04:40.9566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfa79f5-8f52-4637-c369-08de1bc43e8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9231

The restricted CXL Host (RCH) AER error handling logic currently resides
in the AER driver file, drivers/pci/pcie/aer.c. CXL specific changes are
conditionally compiled using #ifdefs.

Improve the AER driver maintainability by separating the RCH specific logic
from the AER driver's core functionality and removing the ifdefs. Introduce
drivers/pci/pcie/aer_cxl_rch.c for moving the RCH AER logic into.
Conditionally compile the file using the CONFIG_CXL_RCH_RAS Kconfig.

Move the CXL logic into the new file but leave helper functions in aer.c
for now as they will be moved in future patch for CXL virtual hierarchy
handling. Export the handler functions as needed. Export
pci_aer_unmask_internal_errors() allowing for all subsystems to use.
Avoid multiple declaration moves and export cxl_error_is_native() now to
allow access from cxl_core.

Inorder to maintain compilation after the move other changes are required.
Change cxl_rch_handle_error() & cxl_rch_enable_rcec() to be non-static
inorder for accessing from the AER driver in aer.c.

Update the new file with the SPDX and 2023 AMD copyright notations because
the RCH bits were initally contributed in 2023 by AMD.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

---

Changes in v12->v13:
- Add forward declararation of 'struct aer_err_info' in pci/pci.h (Terry)
- Changed copyright date from 2025 to 2023 (Jonathan)
- Add David Jiang's, Jonathan's, and Ben's review-by
- Readd 'struct aer_err_info' (Bot)

Changes in v11->v12:
- Rename drivers/pci/pcie/cxl_rch.c to drivers/pci/pcie/aer_cxl_rch.c (Lukas)
- Removed forward declararation of 'struct aer_err_info' in pci/pci.h (Terry)

Changes in v10->v11:
- Remove changes in code-split and move to earlier, new patch
- Add #include <linux/bitfield.h> to cxl_ras.c
- Move cxl_rch_handle_error() & cxl_rch_enable_rcec() declarations from pci.h
to aer.h, more localized.
- Introduce CONFIG_CXL_RCH_RAS, includes Makefile changes, ras.c
ifdef changes
---
 drivers/pci/pci.h              |  16 +++++
 drivers/pci/pcie/Makefile      |   1 +
 drivers/pci/pcie/aer.c         | 105 +++------------------------------
 drivers/pci/pcie/aer_cxl_rch.c |  96 ++++++++++++++++++++++++++++++
 include/linux/aer.h            |   8 +++
 5 files changed, 128 insertions(+), 98 deletions(-)
 create mode 100644 drivers/pci/pcie/aer_cxl_rch.c

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4492b809094b..d23430e3eea0 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1295,4 +1295,20 @@ static inline int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int inde
 	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
 	 PCI_CONF1_EXT_REG(reg))
 
+struct aer_err_info;
+
+#ifdef CONFIG_CXL_RCH_RAS
+void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
+void cxl_rch_enable_rcec(struct pci_dev *rcec);
+#else
+static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
+static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
+#endif
+
+#ifdef CONFIG_CXL_RAS
+bool is_internal_error(struct aer_err_info *info);
+#else
+static inline bool is_internal_error(struct aer_err_info *info) { return false; }
+#endif
+
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 173829aa02e6..970e7cbc5b34 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
 
 obj-y				+= aspm.o
 obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
+obj-$(CONFIG_CXL_RCH_RAS)	+= aer_cxl_rch.o
 obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index cbaed65577d9..f5f22216bb41 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1130,7 +1130,7 @@ static bool find_source_device(struct pci_dev *parent,
  * Note: AER must be enabled and supported by the device which must be
  * checked in advance, e.g. with pcie_aer_is_native().
  */
-static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
+void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
 	u32 mask;
@@ -1143,116 +1143,25 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 	mask &= ~PCI_ERR_COR_INTERNAL;
 	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
 }
+EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
 
-static bool is_cxl_mem_dev(struct pci_dev *dev)
-{
-	/*
-	 * The capability, status, and control fields in Device 0,
-	 * Function 0 DVSEC control the CXL functionality of the
-	 * entire device (CXL 3.0, 8.1.3).
-	 */
-	if (dev->devfn != PCI_DEVFN(0, 0))
-		return false;
-
-	/*
-	 * CXL Memory Devices must have the 502h class code set (CXL
-	 * 3.0, 8.1.12.1).
-	 */
-	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
-		return false;
-
-	return true;
-}
-
-static bool cxl_error_is_native(struct pci_dev *dev)
+bool cxl_error_is_native(struct pci_dev *dev)
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 
 	return (pcie_ports_native || host->native_aer);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_error_is_native, "CXL");
 
-static bool is_internal_error(struct aer_err_info *info)
+bool is_internal_error(struct aer_err_info *info)
 {
 	if (info->severity == AER_CORRECTABLE)
 		return info->status & PCI_ERR_COR_INTERNAL;
 
 	return info->status & PCI_ERR_UNC_INTN;
 }
-
-static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
-{
-	struct aer_err_info *info = (struct aer_err_info *)data;
-	const struct pci_error_handlers *err_handler;
-
-	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
-		return 0;
-
-	guard(device)(&dev->dev);
-
-	err_handler = dev->driver ? dev->driver->err_handler : NULL;
-	if (!err_handler)
-		return 0;
-
-	if (info->severity == AER_CORRECTABLE) {
-		if (err_handler->cor_error_detected)
-			err_handler->cor_error_detected(dev);
-	} else if (err_handler->error_detected) {
-		if (info->severity == AER_NONFATAL)
-			err_handler->error_detected(dev, pci_channel_io_normal);
-		else if (info->severity == AER_FATAL)
-			err_handler->error_detected(dev, pci_channel_io_frozen);
-	}
-	return 0;
-}
-
-static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
-{
-	/*
-	 * Internal errors of an RCEC indicate an AER error in an
-	 * RCH's downstream port. Check and handle them in the CXL.mem
-	 * device driver.
-	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
-	    is_internal_error(info))
-		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
-}
-
-static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
-{
-	bool *handles_cxl = data;
-
-	if (!*handles_cxl)
-		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
-
-	/* Non-zero terminates iteration */
-	return *handles_cxl;
-}
-
-static bool handles_cxl_errors(struct pci_dev *rcec)
-{
-	bool handles_cxl = false;
-
-	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
-	    pcie_aer_is_native(rcec))
-		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
-
-	return handles_cxl;
-}
-
-static void cxl_rch_enable_rcec(struct pci_dev *rcec)
-{
-	if (!handles_cxl_errors(rcec))
-		return;
-
-	pci_aer_unmask_internal_errors(rcec);
-	pci_info(rcec, "CXL: Internal errors unmasked");
-}
-
-#else
-static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
-static inline void cxl_rch_handle_error(struct pci_dev *dev,
-					struct aer_err_info *info) { }
-#endif
+EXPORT_SYMBOL_NS_GPL(is_internal_error, "CXL");
+#endif /* CONFIG_CXL_RAS */
 
 /**
  * pci_aer_handle_error - handle logging error into an event log
diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
new file mode 100644
index 000000000000..f4d160f18169
--- /dev/null
+++ b/drivers/pci/pcie/aer_cxl_rch.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 AMD Corporation. All rights reserved. */
+
+#include <linux/pci.h>
+#include <linux/aer.h>
+#include <linux/bitfield.h>
+#include "../pci.h"
+
+static bool is_cxl_mem_dev(struct pci_dev *dev)
+{
+	/*
+	 * The capability, status, and control fields in Device 0,
+	 * Function 0 DVSEC control the CXL functionality of the
+	 * entire device (CXL 3.0, 8.1.3).
+	 */
+	if (dev->devfn != PCI_DEVFN(0, 0))
+		return false;
+
+	/*
+	 * CXL Memory Devices must have the 502h class code set (CXL
+	 * 3.0, 8.1.12.1).
+	 */
+	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
+		return false;
+
+	return true;
+}
+
+static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
+{
+	struct aer_err_info *info = (struct aer_err_info *)data;
+	const struct pci_error_handlers *err_handler;
+
+	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
+		return 0;
+
+	guard(device)(&dev->dev);
+
+	err_handler = dev->driver ? dev->driver->err_handler : NULL;
+	if (!err_handler)
+		return 0;
+
+	if (info->severity == AER_CORRECTABLE) {
+		if (err_handler->cor_error_detected)
+			err_handler->cor_error_detected(dev);
+	} else if (err_handler->error_detected) {
+		if (info->severity == AER_NONFATAL)
+			err_handler->error_detected(dev, pci_channel_io_normal);
+		else if (info->severity == AER_FATAL)
+			err_handler->error_detected(dev, pci_channel_io_frozen);
+	}
+	return 0;
+}
+
+void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
+{
+	/*
+	 * Internal errors of an RCEC indicate an AER error in an
+	 * RCH's downstream port. Check and handle them in the CXL.mem
+	 * device driver.
+	 */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
+	    is_internal_error(info))
+		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
+}
+
+static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
+{
+	bool *handles_cxl = data;
+
+	if (!*handles_cxl)
+		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
+
+	/* Non-zero terminates iteration */
+	return *handles_cxl;
+}
+
+static bool handles_cxl_errors(struct pci_dev *rcec)
+{
+	bool handles_cxl = false;
+
+	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
+	    pcie_aer_is_native(rcec))
+		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
+
+	return handles_cxl;
+}
+
+void cxl_rch_enable_rcec(struct pci_dev *rcec)
+{
+	if (!handles_cxl_errors(rcec))
+		return;
+
+	pci_aer_unmask_internal_errors(rcec);
+	pci_info(rcec, "CXL: Internal errors unmasked");
+}
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 02940be66324..2ef820563996 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -56,12 +56,20 @@ struct aer_capability_regs {
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
+void pci_aer_unmask_internal_errors(struct pci_dev *dev);
 #else
 static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
+static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
+#endif
+
+#ifdef CONFIG_CXL_RAS
+bool cxl_error_is_native(struct pci_dev *dev);
+#else
+static inline bool cxl_error_is_native(struct pci_dev *dev) { return false; }
 #endif
 
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
-- 
2.34.1


