Return-Path: <linux-pci+bounces-33209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62608B16882
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 23:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5A81AA56C9
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 21:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70435222577;
	Wed, 30 Jul 2025 21:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bVmamxWM"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00A0C2C9;
	Wed, 30 Jul 2025 21:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912131; cv=fail; b=dq28XJ9FU0jbz/+nXH9dlrdSGZQo6URK5GzHFkAJoDdZcGr5R62ir7vUFJWsm3qoVqqF1Q2sgZ8ysK9R4ksEB4zwVmGsMDn93PvqDpSOCL4UbFzAZcNnDUBiNX1Fu0CQksqrpjVkAA9MECqaswinGY7ChWvOwYpFoeG3IT8Tt7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912131; c=relaxed/simple;
	bh=yOWRHx+mF9UcnBNCopaGhyvNqr31nGR8mnBc4q4NB2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G7FmIHmJhBy1r9Fc/wDWuDH23jvLKXHGTvALlkt9st9YkjtL9aKE66f0kkOdpAi6xR2xMCvzbU9pe3u5cDmx8Dh3RDTFwnvJwss4OOqrrpaFBexC78qM6McJGTDVqsBSJmlp/4nEn8W+DaCjpp0+mU0GCm8Gu3dEAFspCpJPFjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bVmamxWM; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w76XkfBcH/xY3Diqb3q5PaCILF30NpaGIdFlG0VTwHyKYjXDqlqMv1ojndaxXGB2wD03yOzRTmU7fEdj9AMShRbufOGTRkrUo2EHB5DLqo5lxN5Ir6iSeHuXXmYVPNPZckY9ijFe0hkhWiXhWTVGGPG6pSnkALUNHtTx8+rdlC3suzShZZtGjBUi5nT80iFjIevokC7T0XClQIlRRJ9eq4AWZ1FGQhy8KLKtWOwT8wEb0oV7Lr9LilkHNeLxBT89vroo6fvepZ4bCUQwCv2CASfq3/A3N64Uxkupx1nGhaoj0RKJ6oJQNyvAilcd5wPL7+1b8Jxu06YNmsIrPhlbUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ao9NAZm0YZwjhx3bDrmppQ+Lt2pVhOgoMJuRj5fUkwY=;
 b=kvJk1LxD2CdMGh7vEkPY00K+1ghHQHss26lvQyyIb9RVVs8EsYb+wKjnl1L90XZ6yT+YUEVVNSiR15oTchRV8kt+D+q4tZ/X5n/tdp0yguWvXgf25DmxQ8GFJQiEqtj4qhjdVIRL/UIeIr5c5AdVGsV/juo0VGbazMcHkK7YB41TqjN4smzTQbBqeq1nqVuc9WKzlglcWtzxo3s1UeNYbdZ2pR8Y3P0ecQ28M+c6OAaPpB5X4TQbK15ktayQR4WnstfnSGXb1OGQx5tPrZEtbvofAFfgJFDk4t3779v52HigDWc2jyH7wJ61en4jJJhdHnIBJizWPTJbXoHWR/MR3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ao9NAZm0YZwjhx3bDrmppQ+Lt2pVhOgoMJuRj5fUkwY=;
 b=bVmamxWMshM3vXJdpIPRtAowyEIHDBpgnMmTvjes9RTLX/5KJwmScqR06wRA17LkU2maspIQ0bH1Y/DyNcmM4v/gpNBHinnAijR0N4pTJrvjA8sOziBJhNAlnkGe4BUrmcZpsqmlTflnOAieJLL5q9/9RCpPEtNAa4vXHEu7tdg=
Received: from MN2PR20CA0061.namprd20.prod.outlook.com (2603:10b6:208:235::30)
 by MW4PR12MB7439.namprd12.prod.outlook.com (2603:10b6:303:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 21:48:46 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::1c) by MN2PR20CA0061.outlook.office365.com
 (2603:10b6:208:235::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Wed,
 30 Jul 2025 21:48:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 21:48:46 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 16:48:45 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 05/16] PCI: PCIe portdrv: Add interface for getting CXL isolation IRQ
Date: Wed, 30 Jul 2025 16:47:07 -0500
Message-ID: <20250730214718.10679-6-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|MW4PR12MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a4960b-cbce-428b-ee05-08ddcfb2dc1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NMU+VBvN8ZVoMidi536+DBLZi3AMN2r9wxDdcuvzw/bzf6maqFDUwlgAVJaP?=
 =?us-ascii?Q?bcKEI6RnVHymqRFUrTGWJ886+t7Wt2NHq6FcmCus1QIHqecmc1ysYqC0hBgv?=
 =?us-ascii?Q?P1lC/X8gfMHTPZA1vD6vVAQwiNHwQdHiMI6ctItegJSy7LGuoEovsX1puV8C?=
 =?us-ascii?Q?QeR/2ufZZKvXqR99IpGvhiO31MKgXi58MFZwP9WdnZucNVyJX81zSZmf2JfW?=
 =?us-ascii?Q?F51AdP66qY+KKBiTI322ASg885fHd4EmqoXv4sZa56+fvX4Ax3U6SzkMi5DY?=
 =?us-ascii?Q?yKbgFbHcEYIlKYKTDUT8Zpcl9jL5FkIcnQYwdO/oftM6tDR00jTmtkAbsxtr?=
 =?us-ascii?Q?hBwCzHGaEO+yyQIYRYuv4aA/CCBpqm0sPopSuOC+wrvNV5hUxU5ONjwri1eL?=
 =?us-ascii?Q?MBQzAjKVF5dmMLRIxa3SIk0fpWy5g9yVvf4WG9Kceh+FzOSSTw3G+ON3Bf2S?=
 =?us-ascii?Q?QcfQlsTS4DVrbmZMTsKqg9rmW2dKe1gWcd0IQ2QcbaiMM+1woRh7oDRxe9Sa?=
 =?us-ascii?Q?A2vYD0ZyQygJXxIDYQAnttCUexXb9eWIqea9qjaNRob553GW8XrdS2rAfK8f?=
 =?us-ascii?Q?Zjr73Npr34FuN+ilSNaqt9g+BSeMO7o0YHme5X462C3Uq86rdO3jM3K7nojE?=
 =?us-ascii?Q?aLlZUHlunSAaQ6gX0ZR3KeTjhOEWZNXGcfthplNBwwkll+/Iw2n6lGL5hUv3?=
 =?us-ascii?Q?NDoUobLZvgj7ljmRGd2lSKlXvKDDze/6cVR0/XzA6oRj0hFhGWbSwmnq11kJ?=
 =?us-ascii?Q?lxyxvo8ZPlKZDkBkC5aMimytWkvO/pHW1DgCg5cwfV47j3QH4jRM1qANGEUU?=
 =?us-ascii?Q?rI9o+F7dmojyP3g5FN3JyxZ9QKYe/ZQTTQnyQQUzpyO7X0MkE6gSyZK654+s?=
 =?us-ascii?Q?Rj/30hAGPBW0JIqee0GTgKGfIf8rxDuIeoHZrZBZIQLiYLzdMGXsxevJfvwf?=
 =?us-ascii?Q?z6oL8vGgIZaGEQbiUqQdZnqeH7tQVZ+CSzNT7SkllJMEFFXAiPp1WAhvOhne?=
 =?us-ascii?Q?y6lEzYtFqDT8ODWcvvCwx9VJszBR1aUEL+mch/XxwoNEqaIcod+X131cRgf+?=
 =?us-ascii?Q?FRv/ANx62R0lBEBNToJmyO4ZqL2daMxSYV5B5djGm1PDWo1z3h1jy9VHCQ+V?=
 =?us-ascii?Q?gVjYCdPb4AyVMIgmFM0IU+a7j4Y/gND3kG1m+BGoOjvExA9IaTAOZ3igy5jN?=
 =?us-ascii?Q?uhmh6MD1EC4PHl046Z7sd37aJydL1TUZAj8St92wWOEyv+eFJ48sv572jnVe?=
 =?us-ascii?Q?qaM8DJogBJHYtrzEahN7+8GVjSzQ3Wj3dPPpqY1EYUbV5FCLe28pZWbH3iLc?=
 =?us-ascii?Q?/DULOHxHmHiySCoyTVxYvOl/CA1Q/+dkGbaSKrFGxelszwjxD/IKxtqwDK/Q?=
 =?us-ascii?Q?IzdAE4XEbNs81OujEBERlfWgr/HXKKPgS/n5MV5e3nNoZeNMC1tykT65ZvbC?=
 =?us-ascii?Q?bcyakApIVLCgOT/OCQ/UNmGpKwRFNQc1R8UfOaQbb9xhh0Pvf3K9ynf4uobs?=
 =?us-ascii?Q?ssjH36zvyXdwsbzBOxt3edVYOjhWUHXjY/RY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 21:48:46.0058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a4960b-cbce-428b-ee05-08ddcfb2dc1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7439

Add a function to the CXL isolation service driver that allows the CXL
core to get the necessary information for setting up an interrupt
handler.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/pci/pcie/cxl_isolation.c | 26 +++++++++++++++++++++++++-
 include/cxl/isolation.h          | 26 ++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 include/cxl/isolation.h

diff --git a/drivers/pci/pcie/cxl_isolation.c b/drivers/pci/pcie/cxl_isolation.c
index 550f16271d1c..5a56a327b599 100644
--- a/drivers/pci/pcie/cxl_isolation.c
+++ b/drivers/pci/pcie/cxl_isolation.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/pci.h>
+#include <cxl/isolation.h>
 
 #include "../../cxl/cxlpci.h"
 #include "portdrv.h"
@@ -62,14 +63,37 @@ int pcie_cxliso_get_intr_vec(struct pci_dev *dev, int *vec)
 
 	cxl_unmap_component_regs(&map, &regs, BIT(CXL_CM_CAP_CAP_ID_ISOLATION));
 	return 0;
+}
+
+struct cxl_isolation_info *
+pcie_cxl_dport_get_isolation_info(struct pci_dev *dport_dev)
+{
+	struct device *dev;
 
+	dev = pcie_port_find_device(dport_dev, PCIE_PORT_SERVICE_CXLISO);
+	if (!dev)
+		return NULL;
+
+	return get_service_data(to_pcie_device(dev));
 }
 
 static int cxl_isolation_probe(struct pcie_device *dev)
 {
-	if (!pcie_is_cxl(dev->port) || pcie_cxliso_get_intr_vec(dev->port, NULL))
+	struct cxl_isolation_info *info;
+	if (!pcie_is_cxl(dev->port) ||
+	    pcie_cxliso_get_intr_vec(dev->port, NULL))
 		return -ENXIO;
 
+	info = devm_kzalloc(&dev->device, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	*info = (struct cxl_isolation_info) {
+		.dev = &dev->device,
+		.irq = dev->irq,
+	};
+
+	set_service_data(dev, info);
 	pci_info(dev->port, "CXLISO: Signaling with IRQ %d\n", dev->irq);
 	return 0;
 }
diff --git a/include/cxl/isolation.h b/include/cxl/isolation.h
new file mode 100644
index 000000000000..20a3a8942b2c
--- /dev/null
+++ b/include/cxl/isolation.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __CXL_ISOLATION_H__
+#define __CXL_ISOLATION_H__
+
+#include <linux/pci.h>
+
+/**
+ * struct cxl_isolation_info - Information for mapping CXL Isolation interrupts
+ * @dev: PCIe portdrv service device associated with IRQ
+ * @irq: IRQ line for interrupt
+ */
+struct cxl_isolation_info {
+	struct device *dev;
+	int irq;
+};
+
+#ifdef CONFIG_CXL_ISOLATION
+struct cxl_isolation_info *
+pcie_cxl_dport_get_isolation_info(struct pci_dev *dport_dev);
+#else /* !CONFIG_CXL_ISOLATION */
+static inline struct cxl_isolation_info *
+pcie_cxl_dport_get_isolation_info(struct pci_dev *dport_dev)
+{ return NULL; }
+#endif /* !CONFIG_CXL_ISOLATION */
+
+#endif
-- 
2.34.1


