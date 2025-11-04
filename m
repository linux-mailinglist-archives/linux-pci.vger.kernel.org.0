Return-Path: <linux-pci+bounces-40164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D49C2E884
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E676E4F4FA0
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE8572631;
	Tue,  4 Nov 2025 00:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nngXg09W"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010018.outbound.protection.outlook.com [52.101.193.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E8217993;
	Tue,  4 Nov 2025 00:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215104; cv=fail; b=Ny4gFaA/3LVRIGnTGNZo/HxhBYEXsf4TsnTXOPBor3N+YMe/VG1HBR/vOhVd0Xf4O7Tg8Y+v5lc2sg144okpWbfSeLhIlL4ky7YzLQ0VB30cLXAdbxYIT3kh9gbyb24gszMIqAvnvmo88chsvZMS1BsSqjJXrW2/u1e13nTxqaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215104; c=relaxed/simple;
	bh=D6IaG4zkv8vJcMrlJVNbuzFvaXy1MRuW/Jz273ZvSy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohHyTXQqKkXYB8cOJJ1dC0Y2dUae89hoIUHgjxFdETMJYzcCYwlepOST2EvhCkAN9148YfqkMYFy8bqdkn50CTgG+YCIJjg6qJZGfA/2MaXkGT+rZinYPLeNw4GJmUfJgSln3Kl90RjT+lSRF8KaMUOaVh5hL6EvC85WMyFh7mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nngXg09W; arc=fail smtp.client-ip=52.101.193.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVpeNjMI7r8TDeciEn7XX+AbVtqnEn9REaa1QGwaEnSl6SIY4cJQu7iojGPo11qMsACrTCMeve8hojvUrAOssDloxI8N9j0yCgcH4r+W+a1dfNN+GnSLNpJSmNNbUvCBHVIFiVPukK8zr3z3mLKSIq8YWOTvoIajdDkWn5gRJnRnOlV2Blny0Ph+lRwUmgBrafKoMWNIAaZp8oVqpzZIRzgCQwl5Tl07IQMpG2ofoJ79Pnb41Ut917wpLUXtZUNAlJ5TmdYf4uzthg4DFeuCZaYC9rg4QH57T44URU8llNX1Iltr/c+WG5znQuoyWbFc8d+2XRSIkkDERac0O5EUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHJGTQk7l+jMCiJpIZdDLFaHj2vwMe4lygtyU8ct2z0=;
 b=g7Tzd0LzcJXeN4UvgNSiJFX2Ptj+QYp7D5TWbe2f9XlDp6NVClEwW2dV+jMlnjiLKYoPqHtINnoJjNQS5R8sLO9Gfxj1sTLKwtbfqXBBtkIzGD9Zd92UHhKfdQBY/hKKTIiBiLcmM56kVxPoDvsgrj/Dzz+0zT6dGB8/S0EVG04nDbIWYH3B+CO4GapXWWNRGsQJm3kivzM93tPxNufrrvZ9uz29dXGBMCQ7PbQg4t0stUHQUCsmmQk9qmtw761xq5OkCz0k/aBVQiIaUt6e+MH+ORL+tE6hzWNskwSPygz3w9N8tuJM74okpfEKPOp5wUmruKxHySRbGSvn5Sn0ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHJGTQk7l+jMCiJpIZdDLFaHj2vwMe4lygtyU8ct2z0=;
 b=nngXg09WOmsDJm9PFv3gRtsTyvg51snxr4fP9ixc7ke/qKXf8uI9CLj6yuzioAjscQsQng8w/38N7D5mI5fEa531KfVpiFBi+AMm4NGt9tMqMOJkxptruc6TzBpSz3kOXKesDtZ9d0gPGtIgec2+zpQmO9YmwYNhP66+1B/WzSk=
Received: from CH0PR13CA0001.namprd13.prod.outlook.com (2603:10b6:610:b1::6)
 by SA1PR12MB6920.namprd12.prod.outlook.com (2603:10b6:806:258::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 00:11:37 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::8f) by CH0PR13CA0001.outlook.office365.com
 (2603:10b6:610:b1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 00:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:11:36 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:11:35 -0800
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
Subject: [PATCH v13 08/25] CXL/AER: Move AER drivers RCH error handling into pcie/aer_cxl_rch.c
Date: Mon, 3 Nov 2025 18:09:44 -0600
Message-ID: <20251104001001.3833651-9-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|SA1PR12MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: 6edda779-8ed0-44e8-19e7-08de1b36b840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wemyCPpo4Bflp13/yWYy+zMy562z3z9llOlyB3jSi7N8vvWXGQNSx9AQLnRJ?=
 =?us-ascii?Q?h728AcqpajlpGd8FmL5AZYqEMgC49yYQdfiTnwFyBrH/PqQsjtIpYZUc0jnY?=
 =?us-ascii?Q?3aid1xKjfMWxSANqbRzugVfFLi0dNsvo9/qGoJ2clk0hK5wfo3vzaQEeq7Ka?=
 =?us-ascii?Q?8RQcjfkpirkKBQuBY/ahKcDnFyvuJPwfktRn18K1BL/c0ylq4ju9kOUnAWPk?=
 =?us-ascii?Q?ogpeN6dzVvqkyS84lW+VskrfLhWgGt/g0Zn/jI+B1oPHugY1qTmra1W3k8HK?=
 =?us-ascii?Q?KImVbKF7t5hL9FGYb2D/6qLCYNFE5JN7oGbiPSOg8zlIS6JBxElH3SoC7sfn?=
 =?us-ascii?Q?sRv+pRAIqzQs4KPiRFpCAMkIj2WNN/upO4lAa/wsTjTJOcWvv45MsMkQe+D0?=
 =?us-ascii?Q?yVcg5BYMraI3Jk/E4nghfvHu6zJxJEA8bPMWUcaKwXzcVyjrGUv2c+o5ukns?=
 =?us-ascii?Q?1MpOTkUL2c16kbix7XWXwEkHoE7Wv8LLQvc3Z9P+6fhugl3B7M8mYS6yst4B?=
 =?us-ascii?Q?8yX9cHptoELMUzA3XNMyEIZBUQM3fn47SCoSeWbVc9DaKLKMGdz4gngPm0ts?=
 =?us-ascii?Q?YAWmw+Fkw1lfZGZTF/YHVqYXGcnCwKhFK17LMQu3frPL91ohf09PorTdodtw?=
 =?us-ascii?Q?rtgoQtJdAQBL/78LHTLppHpeQ50+nwjGWR3uUbhqqjGTHGpnB2VEYOuyzJdv?=
 =?us-ascii?Q?okqWgWBIO2fAC0pX/GG4UNtlLHNHnkhmtsxJpht3n15gyK4vB7/hVmoqJc0j?=
 =?us-ascii?Q?0sVci89PGp4xmN26QUFK1e6ad7NgU+B7tIxv5zRiNLH4uXqLrYD2JnNYRLPf?=
 =?us-ascii?Q?oG62vCGMoMpuYzO6A8YmBwD0IQIvIm56J45tCQA0wJed+9XIrh2F34+bxpFw?=
 =?us-ascii?Q?Aw6czMVLFVXCQDjlDf/kZtcgrgtm4b5wFp9YrHFlhTjvXf2CXZpa8x0Rho/P?=
 =?us-ascii?Q?4VOgFuvH55/dPHceTRV/nJWU8HhE11SDXi2WlO9bYaIhxoUtlEDeulQFhdPc?=
 =?us-ascii?Q?9PIhrYeuUnvFypFhvL3F/+63bsy3fgOQVbn5bSiuin1/eJbMI3x96WmPn1rv?=
 =?us-ascii?Q?2kBwpsD9oxeMkUOyQ6G0uBHu4O8ycxZfEb31B4PP72Kcm4OlizT7IUdezXfR?=
 =?us-ascii?Q?7vIEsmB1ikrmPmltuNCC/yxIUk46lclSsaaUJpkFPGgjzqwU1YvyRGB/f7oB?=
 =?us-ascii?Q?yrxasz1ZIv0DeEbYmr48sBgGIOfuk6w0NuzwMd6sChTWPlsL3v5D4LazMFr9?=
 =?us-ascii?Q?Nr93b4miKSNSF8P4PMMHtn0KHdpCZS7WIS+cLi0xCRzpnqckJf7z/diy/bI1?=
 =?us-ascii?Q?+SyTXRg6+TKMeV0idPpBQWrvoh8kcsZTuEqBURSbqGEzAfCXlKoAd53qSvvK?=
 =?us-ascii?Q?7DnAzjkMuqti1oGiJFSdDbFrgrNCuBoiRG/xSfL9tDbF0MTSBBd77FA4B2fM?=
 =?us-ascii?Q?bYZvWV8+GxZHL1ehIGMIfxVjgG2++veK3Bcvsk51vjQSiDZ8oUhJyD+CdHfj?=
 =?us-ascii?Q?LZ5TUgSnDbmcIm7OL9CEgnCecGOgiHgB1hlxDgQAMfl1+8HANaI2g2+bB+eg?=
 =?us-ascii?Q?+DrvOEiMXk50HWwn7SzdK4HhaFDXbdZAE9Hmk5hQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:11:36.6277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6edda779-8ed0-44e8-19e7-08de1b36b840
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6920

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


