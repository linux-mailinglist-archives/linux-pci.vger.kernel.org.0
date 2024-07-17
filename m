Return-Path: <linux-pci+bounces-10463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5518893436B
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 22:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0F31C2162B
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 20:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AEF18509D;
	Wed, 17 Jul 2024 20:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ePyAQ5yL"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE7D184129;
	Wed, 17 Jul 2024 20:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721249741; cv=fail; b=RZgUA6K1ThbsUWMKOpZojKrQdibx9k5G2ikV2QbDG82JqT3jCuSDK/ZWxQOu27Bp3isl2KIxtODlDQTY4Esw7C/v+5nPznZyHhXBtU+drq3nAKf6++Y09S2pVOBM9DfYG9cV7oa68pJufdlGAvo8rdb4YI/y2pePRt2RNAoQliE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721249741; c=relaxed/simple;
	bh=/3y93ZKSPqvKf/4zbktH+WrTi0ftQ4s/5zTxN85zmj8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbig5Mm2Fx4e/cWp87ud+M3HDEQ2iU0c4kF396HmCt71LiYQ0J4NKPrN1n96nUQg0ruhhFRhCDlYRySKunt+kFJri/a/d0bIlGDRAiL8n/DcVwOzORU+yab+6gnHN5949Rsu+Zt0/IYtZeCKPb6bYgmO1TkSi+XOvNf9eqokeGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ePyAQ5yL; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/91yzQ+VtLOwd4y/kxHEZigl8MzOVzzfzIWHmOoAjnOGVjZiDmYIySHlx81+ao6RpMNRKiENKX3m3aC+hEK6Lob9sc4wvR7mzXKBgAlWYrtF0PWdOc3g6NWdcDkm5SkhhEVKgq2uD5qUrngyBlfTM7vUnOvX2O1WG0CB6C9DnrwqgItAumwBiSM0pjTQfPVeprsdBysjzfM86eSLliKNM7fy3vOg4U3Gu9y/CER/QG7is5mFFMyy/xVR7+kjVccm9yoKOw2wNe2XikzRSUOqkuAoZ1ragDXalRN2jNgrcwKyc6rmajLDHpHBfkeASIvXJNtdQ3D5Gps61fdBS+0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=try7WXOYOAeNw1OIcDP9smn452DBz5Ocko9albij0zk=;
 b=SD0AF8KO81UyR4+tYckBTSF1Kq3CfkIgp4wLOynuX0e/2brjO5HN1j2QLXReAYqSTiAv0mvMrU6cGXH9dTwGRtYzZHF7jMP6QP4DJ+9TkVjLdboJbXtUs+6YSqGMPzZsM6XRroB1lz1V06ks+ZEA/kMbb7rE2sScrWxhtiZfVMwG/UGlNWVf030HTpVTJIyBGF65/AfeQiehClxl/XgN7R2HFfH9qWY/J5UJuh56vu/nzV/mfdPvkhRwj62hyqmedkb6IkLBp5gUh2uVPlAgfX2X3kG/4vssI/JIKsp4nRHKfWCFpLrxC7fEg4rplmVXpORn9OGBnea9XyVcVuPAyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=try7WXOYOAeNw1OIcDP9smn452DBz5Ocko9albij0zk=;
 b=ePyAQ5yLvLtcpTJjdtgSR3sMI8srxQDt0Inj4fpAvEM3aqHRxLvCqx9TeImllBkKEGb9ktJF9JXnzCSWjiDQZRLT2fLb8nscQo1vOxAVBaQeZgQp7DbTJtAyPqLL1+JeVyGLalEVz3GBxfpW32yp5/YJccMyDHstJdQe6gXgtRo=
Received: from PH7P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::18)
 by SJ0PR12MB6758.namprd12.prod.outlook.com (2603:10b6:a03:44a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Wed, 17 Jul
 2024 20:55:32 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::58) by PH7P223CA0027.outlook.office365.com
 (2603:10b6:510:338::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Wed, 17 Jul 2024 20:55:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 20:55:32 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:55:28 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <Jonathan.Cameron@Huawei.com>, <helgaas@kernel.org>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>,
	<bhelgaas@google.com>
Subject: [PATCH V3 01/10] PCI: Introduce PCIe TPH support framework
Date: Wed, 17 Jul 2024 15:55:02 -0500
Message-ID: <20240717205511.2541693-2-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240717205511.2541693-1-wei.huang2@amd.com>
References: <20240717205511.2541693-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|SJ0PR12MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a0af0b-7367-4c65-d1c8-08dca6a2cc3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RxNhOxSuRZ3+Go1U3uJdwt1onKApuiDcfams5AGHOk+aPZwG2U2XPNljzoGk?=
 =?us-ascii?Q?DIxtpMINnYrWX3qj/UbsOdUxBQsN1Hl0sYkIhgkMDIXQt1e8UxxqhPJ3PgWp?=
 =?us-ascii?Q?Ty8Kho43srJP2y4mZbiPDFRfaItrhLWTzPn6T9FxBXDzOiVCobZVMtqExy8U?=
 =?us-ascii?Q?0AbzY39lQeldw8nqhZkvV9oxyzP0MALyQbtyFwHwkx43W+zDqwQLg6SddOlg?=
 =?us-ascii?Q?tWBN+alHbzcui8th6G9/YqRoJ2XW0SditUxAHu2n2e1TnVouwWDJoSKTwZMW?=
 =?us-ascii?Q?DZYvTyWqRETk45+CTrNQLBLU72O9TNUib9hxUhG0j+0/uZPvs7vxuuTupgnj?=
 =?us-ascii?Q?7ubsk+j7BcrBC0SdTdUjbyHjYV+7wWINpmvBysOuTNvALre/i+EWG9ZAZSKU?=
 =?us-ascii?Q?YwZ2gJg9gF6F4ZXeCHhzs0unvGvxYq2aSfaRokqVCDIaRPDGE0eUUVIK0m1Q?=
 =?us-ascii?Q?dTgnWssFoqHFackYfDe9kntsQIREuhixIIF9FmgXZyWcxYbZlgX3rxDUNAAX?=
 =?us-ascii?Q?S2pU51/CJZRTd7Hi6rcqfzlNK5vSr31PEmWFUSP1GFbMRoEYnlKO01scQxVs?=
 =?us-ascii?Q?IBem+lU3T0wla88fwXu7SR3IpFJFCRwMFW/mi0lRhirwBCiApC9FaKXmHGns?=
 =?us-ascii?Q?wDGBoIl9JvbYXbM1RzgjYDh9r7SC5CJHWfqxIL9KhbFfbg7n8sUulQ8B5jMK?=
 =?us-ascii?Q?OOMTTjT+ayCKUnmoeC8RxVBBvyrZu6X6IeefmucoUfCwDB1uY036/PN/Avsb?=
 =?us-ascii?Q?AXUeC8LC3e2enr5exJN+M0ltV9B/K87hOaCjjG6/ZCiJV1h14qn62PEzUBcm?=
 =?us-ascii?Q?Nm08gCjtP3a1mlf/fne2iF6yE6u1n0kGIOe4ECIdeYFunnEUFtMbzVpv7seI?=
 =?us-ascii?Q?gKo+hu2vF4mVqkCk2TnR0zHfOCcy+ASg4Wgxz8VhW0IHsBydiLUTkrnNjZd+?=
 =?us-ascii?Q?3E+OIFvVu6LvKwZfY2YzCK5xFDZvskf1FqJsudPFLOQ9gX0hnq0aVVAEplE9?=
 =?us-ascii?Q?KU8D/WzFg9jNYKtnesLS9G2YX5bcANQvQ8kuRqAd9OBk5H9Bpij2sEhlTyMi?=
 =?us-ascii?Q?Om05Orj/fdf4KHGMcztWbBEebkyRv/fsVc2i1mGi7SMl7Ckm47PMMlxOzMYo?=
 =?us-ascii?Q?rTA/0PqvqRfhe6i15xADCPlG8jLz6I9kx5ipLVPOm+7B5q7tjw+Do2u3qo+o?=
 =?us-ascii?Q?0Xo1KZCieXeA9xRGy9R8W+UBmpcKX9P8/n1iJNp18Ri+e6R/CNk9pbBdrZhz?=
 =?us-ascii?Q?f9NHd4EmC5IqNWtPd4AN10JFYBVqqcQdquQV/Pi5/+mvSHngDRo3/H+vYCcB?=
 =?us-ascii?Q?h5K/iBkuhjbmBa4tIQVIWxY9cDlh92EsXoyfuHd9ozkmn1Ke22GUQvwBxDib?=
 =?us-ascii?Q?AxJygiZ6vHilwON8rCPBHlVtJpn1GV1NV8VWakaoBVmfBiVLsZkuCWwNKMrq?=
 =?us-ascii?Q?sXVkwhS0c5BTNM+MBsZdxCcWgLoO4fLK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:55:32.0321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a0af0b-7367-4c65-d1c8-08dca6a2cc3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6758

Implement the framework for PCIe TPH support by introducing tph.c
source file, along with CONFIG_PCIE_TPH, to Linux PCIe subsystem.
Add tph_cap in pci_dev to cache TPH capability offset.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pci.h         |  6 ++++++
 drivers/pci/pcie/Kconfig  | 11 +++++++++++
 drivers/pci/pcie/Makefile |  1 +
 drivers/pci/pcie/tph.c    | 15 +++++++++++++++
 drivers/pci/probe.c       |  1 +
 include/linux/pci.h       |  4 ++++
 6 files changed, 38 insertions(+)
 create mode 100644 drivers/pci/pcie/tph.c

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 79c8398f3938..b80342e6b3e8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -571,6 +571,12 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
 
 #endif /* CONFIG_PCI_IOV */
 
+#ifdef CONFIG_PCIE_TPH
+void pcie_tph_init(struct pci_dev *dev);
+#else
+static inline void pcie_tph_init(struct pci_dev *dev) {}
+#endif
+
 #ifdef CONFIG_PCIE_PTM
 void pci_ptm_init(struct pci_dev *dev);
 void pci_save_ptm_state(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 17919b99fa66..c765016a119a 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -155,3 +155,14 @@ config PCIE_EDR
 	  the PCI Firmware Specification r3.2.  Enable this if you want to
 	  support hybrid DPC model which uses both firmware and OS to
 	  implement DPC.
+
+config PCIE_TPH
+	bool "TLP Processing Hints"
+	depends on ACPI
+	default n
+	help
+	  This option adds support for PCIe TLP Processing Hints (TPH).
+	  TPH allows endpoint devices to provide optimization hints, such as
+	  desired caching behavior, for requests that target memory space.
+	  These hints, called steering tags, can empower the system hardware
+	  to optimize the utilization of platform resources.
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 6461aa93fe76..3542b42ea0b9 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
 obj-$(CONFIG_PCIE_EDR)		+= edr.o
+obj-$(CONFIG_PCIE_TPH)		+= tph.o
diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
new file mode 100644
index 000000000000..e385b871333e
--- /dev/null
+++ b/drivers/pci/pcie/tph.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TPH (TLP Processing Hints) support
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ *     Eric Van Tassell <Eric.VanTassell@amd.com>
+ *     Wei Huang <wei.huang2@amd.com>
+ */
+
+#include "../pci.h"
+
+void pcie_tph_init(struct pci_dev *pdev)
+{
+	pdev->tph_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_TPH);
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 20475ca30505..b6bf3559c204 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2498,6 +2498,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_dpc_init(dev);		/* Downstream Port Containment */
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
 	pci_doe_init(dev);		/* Data Object Exchange */
+	pcie_tph_init(dev);             /* TLP Processing Hints */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e83ac93a4dcb..6631ebe80ca9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -532,6 +532,10 @@ struct pci_dev {
 
 	/* These methods index pci_reset_fn_methods[] */
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
+
+#ifdef CONFIG_PCIE_TPH
+	u16 tph_cap; /* TPH capability offset */
+#endif
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
-- 
2.45.1


