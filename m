Return-Path: <linux-pci+bounces-34823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5A4B37714
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1BC7C31FC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025C41FF1D1;
	Wed, 27 Aug 2025 01:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z/KyF3QD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266D51FDE14;
	Wed, 27 Aug 2025 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258618; cv=fail; b=TOpUZ7ypzzEtYN4IP8LSy6XW7KPCoHWcFkZkvyJF1xBkGiEV5HpE1vF0P5UazbFfcAcXdE10Dk5o7OgjaTIDGaqyKw8jrKuUO83nBBdWYBzYPoMn5Fpajx/zqlT8I4mRXR6G438VwCj8CjTQrSemT2HaafGN7dbmLprJYKMkUyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258618; c=relaxed/simple;
	bh=y+inl2hWeeAdkZckCYgKmsr/MVQmicoGH8pu+avhRVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4gvTYbUYD08uz7xU7bE1AUOGHz2O1kny2G7jjjbXU1lAXhGKDmsN3YXp9vgD53UL3PFfLFHQfFjnU8UDatGz0w87BeydyNXf+kYnHAlhPmYnFXsI1nHu5SwG8EL/a1ZY5/T/aTj9G8UmddumNQHOcjCDeKFTTVvy75XSFGVKYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z/KyF3QD; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRDkthXWKsvfuKPI2kv7HfG18DjjROH0dB4GnFvdMnd/4DnSe36ruQNHCrpUi9d/KIPWaaWt6K7vYOhnuzQBzsWCWZq+0f6YoPxckO5PmnANN9QlTFmGL4dNiVETLXTeCtimJP7vnTJpNj2rVZ3ixaahNkk2Qr20DMu+J6Ek4PUSSqeXYhLcUMX6gqvpxWV0UeNO00Cvs/ySWKgfrrpKfSUf5L2zVbmgVPqFLuzSlUda1p/f3G2v/d3BP4Nf6/ogVvhraMglr5Hm7HiC0hazpHh+oPw2Uu2abLir5kCGOM4z6BVf2flRZnEJqCmGOz8D0u8/mfZkP3DQJfT9nFoX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXf2yXL2bMxd7CNt8cG/d6f+XmN2CdBURonAX+N68DQ=;
 b=dFt4puQmmyxDMA0ZfLw7iJSj69UPKSVL/dUYlCYcNqBCu+su5CoJM0ozo5uND7F8fBHDtHcOsw2X0W8f3u6YxAORTGeWMwdpMzqCLG/tUnrnhWwKmXn2tb85Qqg5fDf3Zp+91O8JIFWl9nZ+y52h6n0k3D2wwjoC2Mok6uz4xMQ33j1XtamytKl8TFhCWRbJ4VGeHp/s1LW30FuiDaLTjrQ98h4o1lIT0nwGtxumNVqu+A7dJuv5C6P0Ih7vhk00uht5bfEZvOekPobKuXu97eDI/mLrwwhC8ZTLSEirEifGE3PY4+RgcYcQ70JH0D2pYarfnIneJcdzeEazNjCLhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXf2yXL2bMxd7CNt8cG/d6f+XmN2CdBURonAX+N68DQ=;
 b=z/KyF3QDRnxdt9IsF1GuoTh+kDxtZpeatozyvh9nNaZ9kgwrs4s6pghaDAF9bkghaidX8vPA7lwxRIu9DJC8z61fQEc0K+Bgl1os8BkIa8A4pD1bW6yPXsbWdG3ObvaiumukVdGnRq86pV1mQE/Iz2TN1C3WdBnD3n0jz1Dj93I=
Received: from SJ0PR05CA0181.namprd05.prod.outlook.com (2603:10b6:a03:330::6)
 by LV8PR12MB9261.namprd12.prod.outlook.com (2603:10b6:408:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 27 Aug
 2025 01:36:53 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::2f) by SJ0PR05CA0181.outlook.office365.com
 (2603:10b6:a03:330::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.12 via Frontend Transport; Wed,
 27 Aug 2025 01:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:36:52 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:36:51 -0500
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
Subject: [PATCH v11 06/23] CXL/AER: Introduce rch_aer.c into AER driver for handling CXL RCH errors
Date: Tue, 26 Aug 2025 20:35:21 -0500
Message-ID: <20250827013539.903682-7-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|LV8PR12MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc53df3-0ea0-429e-df91-08dde50a3337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P9bvrL46k/sE60Oms6WPMvXcbrnrxai8AEDzUizAOckQCST0mDcY66w7zGlB?=
 =?us-ascii?Q?x5xqyuvowK7hirwCVaD0GN0s5q5321CE+E028FmUu40+n6ih2A7xBkMNF0Zu?=
 =?us-ascii?Q?zqDLqwrHu8hmvgMm+DZqocfuDffz/sf0JS6E2dezq6N1VXiaDk8/d3tsc0LY?=
 =?us-ascii?Q?RWkePywSYgQ66wwLfWZZmtmCMxmOrpZQYSzNfzqJq3xiO2mravSd5PxkdlVd?=
 =?us-ascii?Q?GB7feyUSNI+18D9eTC+1qkXCBBSPJmJ88R/vBizrOGXJF7UBmXFbHbmpM7Hg?=
 =?us-ascii?Q?E5HiqpyL0xyhIiEM6qsYASkXoStStxjQnqhBFCKgp/cGrf91IIMZT3Pqe4w6?=
 =?us-ascii?Q?4pPtSfe7pCHN3UqnQcvqQuEu0HCWXEp7juqaf+XSBeMBZ0EKA/hAHCDTiQd2?=
 =?us-ascii?Q?FyrKHrbkOjkVgT7ecTZk9xgN65tcQAeR1BRfKGhDdNaANcSHRvfyMKUO4suc?=
 =?us-ascii?Q?7fPKnbySXZvEYZZaqLgPjdCeIwg0FWEfO/VGMyZ/3q74emhVIYQod4KEMjVX?=
 =?us-ascii?Q?lFBW84Ey69dR8dc1eARK+1fsdnlYedIEGRJ4rjBrZ3HnrDIlL8cJNzBTJfoK?=
 =?us-ascii?Q?g14n7HrK+A8nVeDtRxwQjjMtVvitrWFbbscKkqN9ZKsgt4rpRduCTwFxMrGj?=
 =?us-ascii?Q?gGEtI4RwhWl6MOfDB6XrSJQMk5SgWuhM9jBhXZX6jiLobZQIP2BNubOdbpSJ?=
 =?us-ascii?Q?4ytBBLWpEUhiXWXpTH9XkGaANXOXhlbhNwbKEFEVYv1b7DTt8cYZXyrHSLUS?=
 =?us-ascii?Q?NP2UzHlSrqn4esqZ8uXmtn2QJqb21o+95nSEzsYysOFf9O2XTn1m5e9U4wlH?=
 =?us-ascii?Q?ZRiX5fJeoIvTIBmsyVcmlJYXYz0KzVgYUq2M3yXcyu117n/uroiuumlexOXe?=
 =?us-ascii?Q?5nzRiONWMQszaGQzpFGYlrGSfc3DCuauGgXdnQxuS1SQep6zipZ079LCyubR?=
 =?us-ascii?Q?Ne05Urnb+EUgx2FsVs+6g9VYSpz6wuD5qbY1C+szZCOEloG2csdctqWaKwzt?=
 =?us-ascii?Q?0yFtikrGi6iUPcLL8X40DGBZI7NdWyHuETmy/tI2bEVk/SSDG9VxpJE/UI6D?=
 =?us-ascii?Q?8OyGyD3oXKUiTM8nTS5k8iCCUh8dBzHJtoNTXERifK3D5RLhgcp9IYGDhAmt?=
 =?us-ascii?Q?h6TBInrOkhGxUDyLD89siE//eTrdFIB4htHetXRC80oB/hQ4jKP+QvHUv7bu?=
 =?us-ascii?Q?AfBNnouU6h6nbJWZ1Y46zKVSsd0iY6CTzLoDvqJbTc9MDFouWVJ2o3XR7/NW?=
 =?us-ascii?Q?FYJFenI89G5dGMdxJ1YEATx2zJBvX+A4zbkS4QGaSFWG70b+0xcf80bAbhvr?=
 =?us-ascii?Q?cT5bDFmHiNCirx7UpxG5abYlwuOJyQb9wfyI9MKxHciycKwcbqWaIac47Au6?=
 =?us-ascii?Q?BMd8is9YuNSAEf4vwh20KVmcBKxMxwRwI892B2XFPCXYyfzWB8EjCUKNpgpZ?=
 =?us-ascii?Q?JHSakoBwCzkfA7GmJOVINuBIdBb4+raofAbPaw5ziCKhxdRXQvGsth2yT1c1?=
 =?us-ascii?Q?NSdugWSKQrZKFcXhrDH7GINK2lcUcMfWA2lQCSOGk8tAe2pdQpTGsQxYYQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:36:52.6873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc53df3-0ea0-429e-df91-08dde50a3337
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9261

The restricted CXL Host (RCH) AER error handling logic currently resides
in the AER driver file, drivers/pci/pcie/aer.c. CXL specific changes are
conditionally compiled using #ifdefs.

Improve the AER driver maintainability by separating the RCH specific logic
from the AER driver's core functionality and removing the ifdefs. Introduce
drivers/pci/pcie/rch_aer.c for moving the RCH AER logic into.

Move the CXL logic into the new file but leave helper functions in aer.c
for now as they will be moved in future patch for CXL virtual hierarchy
handling.

2 changes are required to maintain compilation after the move. Change
cxl_rch_handle_error() & cxl_rch_enable_rcec() to be non-static inorder for
accessing from the AER driver in aer.c.

Introduce CONFIG_CXL_RCH_RAS in cxl/Kconfig. Update pcie/pcie/Makefile to
conditionally compile rch_aer.c file using CONFIG_CXL_RCH_RAS.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---
Changes in v10->v11:
- Remove changes in code-split and move to earlier, new patch
- Add #include <linux/bitfield.h> to cxl_ras.c
- Move cxl_rch_handle_error() & cxl_rch_enable_rcec() declarations from pci.h
to aer.h, more localized.
- Introduce CONFIG_CXL_RCH_RAS, includes Makefile changes, ras.c ifdef changes
---
 drivers/cxl/Kconfig        |   9 +++-
 drivers/cxl/core/ras.c     |   3 ++
 drivers/pci/pci.h          |  20 +++++++
 drivers/pci/pcie/Makefile  |   1 +
 drivers/pci/pcie/aer.c     | 108 +++----------------------------------
 drivers/pci/pcie/rch_aer.c |  99 ++++++++++++++++++++++++++++++++++
 6 files changed, 138 insertions(+), 102 deletions(-)
 create mode 100644 drivers/pci/pcie/rch_aer.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 1c7c8989fd8b..028201e24523 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -235,5 +235,12 @@ config CXL_MCE
 
 config CXL_RAS
 	def_bool y
-	depends on ACPI_APEI_GHES && PCIEAER_CXL
+	depends on ACPI_APEI_GHES && PCIEAER && CXL_PCI
+
+config CXL_RCH_RAS
+	bool "CXL: Restricted CXL Host (RCH) protocol error handling"
+	def_bool n
+	depends on CXL_RAS
+	help
+	  RAS support for Restricted CXL Host (RCH) defined in CXL1.1.
 endif
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index f42f9a255ef8..c9f2f0335bfd 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -126,6 +126,9 @@ void cxl_ras_exit(void)
 	cancel_work_sync(&cxl_cper_prot_err_work);
 }
 
+static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
+static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
+
 #ifdef CONFIG_CXL_RCH_RAS
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
 {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb..c8a0c0ec0073 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1159,4 +1159,24 @@ static inline int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int inde
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
+void pci_aer_unmask_internal_errors(struct pci_dev *dev);
+bool cxl_error_is_native(struct pci_dev *dev);
+bool is_internal_error(struct aer_err_info *info);
+#else
+static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
+static inline bool cxl_error_is_native(struct pci_dev *dev) { return false; }
+static inline bool is_internal_error(struct aer_err_info *info) { return false; }
+#endif
+
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 173829aa02e6..07c299dbcdd7 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
 
 obj-y				+= aspm.o
 obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
+obj-$(CONFIG_CXL_RCH_RAS)	+= rch_aer.o
 obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 7fe9f883f5c5..29de7ee861f7 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1098,7 +1098,7 @@ static bool find_source_device(struct pci_dev *parent,
  * Note: AER must be enabled and supported by the device which must be
  * checked in advance, e.g. with pcie_aer_is_native().
  */
-static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
+void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
 	u32 mask;
@@ -1111,119 +1111,25 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 	mask &= ~PCI_ERR_COR_INTERNAL;
 	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
 }
+EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
 
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
diff --git a/drivers/pci/pcie/rch_aer.c b/drivers/pci/pcie/rch_aer.c
new file mode 100644
index 000000000000..bfe071eebf67
--- /dev/null
+++ b/drivers/pci/pcie/rch_aer.c
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
-- 
2.51.0.rc2.21.ge5ab6b3e5a


