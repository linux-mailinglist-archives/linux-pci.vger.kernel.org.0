Return-Path: <linux-pci+bounces-37040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53947BA1D21
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D41E16590C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196E3322759;
	Thu, 25 Sep 2025 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EKIfVVWQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013070.outbound.protection.outlook.com [40.93.196.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF135322A13;
	Thu, 25 Sep 2025 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839760; cv=fail; b=XtZuz+/KbR/7GVE0q4faQSFZU/N1CUNNYnopavW1guPgVcY9290SRfp+e0WmNQhuf5AgUKho9j/bqKfznK/omvuwS8Hk8631qmNBv2/x2BtdEV77pd5Lne26khFpM+SZ+mCMZMrcXBrDafotI9bgFE0zHNMJc53MUlny/Hs/H4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839760; c=relaxed/simple;
	bh=wj4mplTGIvaNyvPm/ut/7Dpz+gnxaqKU08f6QeAEC0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mygen1ePO1itcIqfTx/kCb4Ds2xEKXYyUNHC2GcvLSZKpEDwB94+K5nvHA972W/6vOeljEjPAiPMeaLgYIOXt9f+swr9Uyky23J8pUHtRUKv5WweIK7vlpa4Bmppikwtc70dca5AK8YWC6k/IwLi/GVdd17g1Vreh3uFlT0m+DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EKIfVVWQ; arc=fail smtp.client-ip=40.93.196.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DuCKAkWmVYE8SzxiPPuYDx5yUKWz32k8s5m0EzjbK+7tPpmkuZL6uXUD0DZ/Tvak6HCxBgCokU/rORIu66OMw2QG0rWrGfEpKPhUXdK3iCwhu/HDiVwLFe8PC/3scYq4VWnpc37RjskJGUvjbLy35W1RTGd2hVvvpK4MRR88HOAgN2GT7tkRllbKAAxG2525TFC1WIzFLE+sqvRs+wKku6aXk3btbp6r1wmjzwu1tbDnkq/jzg0fDODQkXxkwF/iHa5rkjgrMdeC437iJD3Q8gDgsOY+npcr6kcH/h6jBh50Z2MaJCobZb51H4PDlHNuMu2gO7RMBYwAzbBFd+ZMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sz2syCCGtSp2hfGsBJKl9o7q4+zEPv3MEPNuW1voh98=;
 b=E2yD8AUiY38S+OzFp6LaF/B5Brp3UNrfgj/wb6r5ElQCIkK2VygrT536UsrWuOsnNWdueIxEmiZsTEohNxi9orK+UTVDMTEYOYc0oBPoY0YbEPlfpcag0AydwX50XmrMaJn4OH/jGWFjGOWFtsA4y0ePVER2p6oCYJhsmPA2IMPgDpsZEh3VTQCd27LEF5XU+MuJtjpaqbtnVrX/iciy1Yt6Yt6eMcSmwXfoaOW/HCPTELi22XLnGrmKUGgW5WnOvFt4MaJcXrAuR74ZsySXkZ3Dqyz2NN8P8WOmx8Efql3lRt6stQeG6YoaVf8UJVBFg4BO3y98RyRsLQLh0wEGXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sz2syCCGtSp2hfGsBJKl9o7q4+zEPv3MEPNuW1voh98=;
 b=EKIfVVWQisVwiojuVcZLnxpdTS6ivn3kiZpEK5TxNYADUI/70NBwS8CnnXY6TTkI8P3gYK57fuTn7iisfR0xY5HNL9cv6t0H+a73uOrKIu9FseaiN4vZq0mp4dAOcrGEEtA+nhNouLB0UNDg+NaXbtOWV5z42dl4obwxCVxsjUs=
Received: from BY5PR17CA0003.namprd17.prod.outlook.com (2603:10b6:a03:1b8::16)
 by CH1PPF84B7B0C96.namprd12.prod.outlook.com (2603:10b6:61f:fc00::618) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 22:35:54 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::14) by BY5PR17CA0003.outlook.office365.com
 (2603:10b6:a03:1b8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.23 via Frontend Transport; Thu,
 25 Sep 2025 22:35:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:35:53 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:35:52 -0700
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
Subject: [PATCH v12 06/25] CXL/AER: Introduce aer_cxl_rch.c into AER driver for handling CXL RCH errors
Date: Thu, 25 Sep 2025 17:34:21 -0500
Message-ID: <20250925223440.3539069-7-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|CH1PPF84B7B0C96:EE_
X-MS-Office365-Filtering-Correlation-Id: ac2c4bcd-66c9-4858-f83d-08ddfc83e33f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BNymh+6zVipb0tkgLbLVmKBOvLccwP2A8xlL+w7Ywxhq1NLivZdtr8DrJT1N?=
 =?us-ascii?Q?sKT9tn6S3SXeA/Jf3mCBo+vkX0OU8Wk4gX5RIgnCnSMup3O2CxckgtdWHeWZ?=
 =?us-ascii?Q?yolMQaEvWZ1jvv2LMMc2SDYnAhDqKszUKwcdmBELKOlTKJiSiXjICv5L03Em?=
 =?us-ascii?Q?n4cnIKn5Z9jMeUt6bHjk7ZAPOyAowtNDyAc0w+UlJxSDrRnvl08Xrd5DCfyN?=
 =?us-ascii?Q?nRiwqJuPeNPNBm5REunRr7/VqFp70K3U/sEhZEoWI/BV50nWsRXpv5x6C1ZU?=
 =?us-ascii?Q?EcoD/e58El+9ZU5wS/pzxCM0g6dst6lEWoq4GBO+Ifzx6KSCkiQTTwdBsyZK?=
 =?us-ascii?Q?wHAnxvt9ELK5StahjLEa+LxYyQM1dJPdMi+DQCfgwx+RqA/sgD14guNg/j4F?=
 =?us-ascii?Q?8G8sFMRRMCOlM78FtDFo6otusjuvyxtZwC/kLOWKPY0ES+3xeFEsk43seQTI?=
 =?us-ascii?Q?uMYe8GBz6bFjWk74fmFtDMo+wi/3gze9PXA9GuXp77f15J3OGe6c/s1UnuUt?=
 =?us-ascii?Q?dCGKmQSuGABwQA98pVhgvuWKjBvbOglW1FjHLxXqsU30xGPaccEcPviTWiF1?=
 =?us-ascii?Q?O90ewIXHcUMyeNQ9M3Ym/aj/KdQgoiWVxByjEnXxLmL/acKPWxJkP96Qwj2v?=
 =?us-ascii?Q?0y8pf18umFGqYlBhFCLLb3zgd4iAq35DYWJU7z/b6L6Sb9txqe2kUwUmRab3?=
 =?us-ascii?Q?SnAituAZi2NHTfJx3nBwDWCca2bc91EwIEV0/bGSFM74uRrWbSVlo3BVl69S?=
 =?us-ascii?Q?ICCs/BQb9W6f/wQVwJ7uQaVnmC2/xF1hIoELEw9BopSof/C68UiO+b1+1lCl?=
 =?us-ascii?Q?RDFFY9tiUdJgpoXYa/fV+xxxNbh4fxpkF1R3ogqiuhLrbEVDikx9OgokGGXY?=
 =?us-ascii?Q?TjnLUYegF8n8nXvLH+2vYy74Go95UgdTkI7FfUEOHk0CyOZtC8rhGNjKKxtd?=
 =?us-ascii?Q?mEAuZQudFLE26lYpbf1z8vM8zIZ874GyX4GZRckFKcxUrAWnyFy5mU9Ttbdw?=
 =?us-ascii?Q?LoT0AEpQ8BIl/2vkeOWb6rpbNYPnmdfql+RarFJ3d2B0+CuZt6EsgZa4aR2m?=
 =?us-ascii?Q?7v6hYRlk95XEfBxhwIzWkTX3NTP1tnP5m1X8rzqxyCyCImzT4OXaIem+GCNE?=
 =?us-ascii?Q?BEffGqd9WSWusB2s+s7aqL9TKuady5Lg7ew0zn8vajM7Nccm9K0QoHjFFHXe?=
 =?us-ascii?Q?1T3Cw+VkFqGjHklihqrqrZH17nfifFcQKceJRs2Ga0Kb2VOT90nvuBVr2EqG?=
 =?us-ascii?Q?GXml7rSNXdnSfW0wnyB3ZOIko6KcnSiDqLyZj6KNt45RnCNSJpPLxZzzdTIQ?=
 =?us-ascii?Q?eXUTE54cGVDYx5d24gpHceV+HJSc46y9s/2OT2EXEue9A6/GykMWLC5yqt4B?=
 =?us-ascii?Q?jAxS77olw8Uf5f5gJFMXML1bg66iAtVxmwLxO7xINduCiL+qKEa12/gL8uCV?=
 =?us-ascii?Q?jVZNvg/DTD9iYIS4lahrJeJ1g24lDUUg6kPUc7c3UmIP58bLPQM/luj61GkX?=
 =?us-ascii?Q?O1Qa4QXZS3Nr9j/riY3P+gknkw5uUKGhVDaeloibjjvaUd1gSKUPEp0V1Lss?=
 =?us-ascii?Q?1XgYIOEpWS8l0jcs89VNnbPzLcVU/g6pTK6QqZTw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:35:53.8671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2c4bcd-66c9-4858-f83d-08ddfc83e33f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF84B7B0C96

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
allow for cxl_core access.

Inorder to maintain compilation after the move other changes are required.
Change cxl_rch_handle_error() & cxl_rch_enable_rcec() to be non-static
inorder for accessing from the AER driver in aer.c.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

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
 drivers/pci/pci.h              |  14 +++++
 drivers/pci/pcie/Makefile      |   1 +
 drivers/pci/pcie/aer.c         | 108 +++------------------------------
 drivers/pci/pcie/aer_cxl_rch.c |  99 ++++++++++++++++++++++++++++++
 include/linux/aer.h            |   8 +++
 5 files changed, 129 insertions(+), 101 deletions(-)
 create mode 100644 drivers/pci/pcie/aer_cxl_rch.c

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 34f65d69662e..0c7178d0ef9d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1201,4 +1201,18 @@ static inline int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int inde
 	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
 	 PCI_CONF1_EXT_REG(reg))
 
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
index 7a1dc2a3460b..6e5c9efe2920 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1099,7 +1099,7 @@ static bool find_source_device(struct pci_dev *parent,
  * Note: AER must be enabled and supported by the device which must be
  * checked in advance, e.g. with pcie_aer_is_native().
  */
-static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
+void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
 	u32 mask;
@@ -1112,119 +1112,25 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
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
-	/* Protect dev->driver */
-	device_lock(&dev->dev);
-
-	err_handler = dev->driver ? dev->driver->err_handler : NULL;
-	if (!err_handler)
-		goto out;
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
-out:
-	device_unlock(&dev->dev);
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
index 000000000000..bfe071eebf67
--- /dev/null
+++ b/drivers/pci/pcie/aer_cxl_rch.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
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
+	/* Protect dev->driver */
+	device_lock(&dev->dev);
+
+	err_handler = dev->driver ? dev->driver->err_handler : NULL;
+	if (!err_handler)
+		goto out;
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
+out:
+	device_unlock(&dev->dev);
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


