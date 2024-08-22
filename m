Return-Path: <linux-pci+bounces-12042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485FC95BFB7
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 22:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39BF51C23500
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 20:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBED1D172F;
	Thu, 22 Aug 2024 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="miPWngqC"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC221CDFD5;
	Thu, 22 Aug 2024 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359327; cv=fail; b=KK8Pj+JL+hoBC3/KuSgn1kFU/AbhgDTZbRymHRrE0cG3jL5EUWlQ0i0eKaqK3ylkcQHIlj+f+iTJXc+KtQ06SmT9DBmi0y+JVZOVWiJDrjay3fkyZmFvmM9KI3fHGlXcCuu70xrrNefRXL2ui9/yuN9jmAVjhwFnJMDlUkgr6Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359327; c=relaxed/simple;
	bh=KMb/7aq2ieYYX9cNCUmLqsA1V1Th9YQx27JplWvuo8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0+5EBh6/f+WxL7ThwQ6KXH+Gd9cWo/wHfAQv//YWdfC5E8hUU3dncTPX/libknz6R5fX4c5LqdRItyh7iU3FZlA4zPQ901XmaYFqVq1k9AY8y4r6szGbt3ByazLt+IUfI3W4zutZEZ6unNd7HicXsSeGXKvVQE3W+34Kh50zwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=miPWngqC; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoVQb9mgzKT1yj+IHyeHyoUzP8o0BBczWkfKjCfFNujh/dK5dK83B7w2U73wTsGosw/aYSf3BiKLat10Hh3s9wWLWNGtjHAMQ+N4qQrrjTLYYPNGHPOTZ9a9ZPQ06odaiIENELH04WXGVX20cCWtuxK0Wns+SezdgnQHiREoe/rBo1bR4kL5JKwiNMCs9hYAovcH1DFsuf/dRlnwi+wcuENnoVNbaaZpwtefcbJhzwvE+kLDw1+Tww7/GyCn5ai6PWdYPDbX+6awmsY5AlTWlM3pFuuat8s9yj31zhfhm9u6HYvSIxfq5rYvlLkDOMPv8ElBlmupKrmfHjEvrnknOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wZCT1U9PS1V2MHoJwpJjQD6lVZXeOAnttu8JvXVIiY=;
 b=t3kg8iBzaJU9Qt4kG1A3l/Y8nIJIyb1l8H/Zky/fw/tM56UZe8s1/cOnTwl8jhecNyCDkOjS2g2BatCLLE53anlMGRYkkswlkFM9tqwwo4oHegH5DCu+NWzMGHKsaRlNWyCzwLxLk8s2PSDguQNNzA/EgQ4bUYrXUpQUD+Y87qT8StZKs1IUlJYM8F+3Xm+uQ6AKafsT2LaFg0TV61cDtRBPeX2AJULjtXtDNp55DdE5SzN/mFALADMNsLd9we6c9YkKtjsHsNywfSVitN95SvdMX7TDxki+dMyRQPncq0u63I3Ioc3IngViYZSn1hdrmc56gjMNh68cv/9S9AaShA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wZCT1U9PS1V2MHoJwpJjQD6lVZXeOAnttu8JvXVIiY=;
 b=miPWngqC9cfLe2K4pEiFWVdh5S+cKs2fbgLTbDDSmzsa4bkz53k94vlogFjkrc5ys0ciC4FilLib9L9WiK+rSTpJB1AGJPrGhBW4Qh1yAn9XMZh9a4GDXmppObbcomKWEuyBZgQe7CFOQLooJQIA+FrwRP1WFm2MN+ye8suH+6s=
Received: from SJ0PR03CA0365.namprd03.prod.outlook.com (2603:10b6:a03:3a1::10)
 by SJ0PR12MB7476.namprd12.prod.outlook.com (2603:10b6:a03:48d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 20:42:02 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::c7) by SJ0PR03CA0365.outlook.office365.com
 (2603:10b6:a03:3a1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Thu, 22 Aug 2024 20:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 20:42:02 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 15:42:00 -0500
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
	<bhelgaas@google.com>, <lukas@wunner.de>, <paul.e.luse@intel.com>,
	<jing2.liu@intel.com>
Subject: [PATCH V4 03/12] PCI/TPH: Add pcie_tph_modes() to query TPH modes
Date: Thu, 22 Aug 2024 15:41:11 -0500
Message-ID: <20240822204120.3634-4-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240822204120.3634-1-wei.huang2@amd.com>
References: <20240822204120.3634-1-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|SJ0PR12MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b90676-c708-45a8-1499-08dcc2eae09a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xT/I3m+Lcw1maHS8p7Q6gpwuFwNm8ZJeKcxSkayhSDwbSMNT4pDphW7bGSxA?=
 =?us-ascii?Q?KW5xHHGxQADegQay3GzicrzvUVXT187STcasPqP0KI5/ciGHv3Oyf+Ww2r14?=
 =?us-ascii?Q?LR65CJGuucqeDSeM+gQBjbwcRBF5O+jhSZua0vUemhRhdvDAO3DtpXpCOCBp?=
 =?us-ascii?Q?rTJBkjbtVoeMwUt1XA+WnctXTcdYm+GilDrFFPrJEBvDMvcgkM3FyQK5WPh6?=
 =?us-ascii?Q?MinJf5sK/Ry+f3p+9fkyDVxwRq+nGv7gwdmBT8twUG7tUzt3/A5A4uX5P+hC?=
 =?us-ascii?Q?wkS6Rd7WLRqYKogrDs0AYS9akoc3EcT+951bzeNnvQl6lqtzeCXStYq4dLKM?=
 =?us-ascii?Q?Shfw1Fdw0z38V/nkdeuGRmwBXefMGSEORXroJfPlktbAFqS8Zhe7zjU+oUdr?=
 =?us-ascii?Q?D6O3pawJKxtwQLXhk+n16dTP+nlXi254MGGR/M4zvAhlONYueKIn6CAxpjGn?=
 =?us-ascii?Q?dz+QhHouFL8YZ5pE4vJWxnB8zta5Ife5fyhnrz8HE1f7d6DxxCJqN/VpA24d?=
 =?us-ascii?Q?bPxiV3VGU5bAH+S0JMDHgdHcPY0RV/Mh7bevSzicjxKpKs0AB4Z3tJ1FE9vM?=
 =?us-ascii?Q?1hecqjhIVhmLW0tRhwBnTyS9iO/6u3HCaqVdc6zYKrraxrU7QSfeJ7XjfyiP?=
 =?us-ascii?Q?E8bqDES4fdu9O8tk01KL7V/qmsXczX87b1FZn/4ohC0nYjxI7El9dIzt5tVc?=
 =?us-ascii?Q?/fMi4cU1MYFZi79nFtw3ITqrYeoARsvB41orYLE2zzuipu6mZOEIFOuA4DOU?=
 =?us-ascii?Q?zZHrO8K7ze524ey4bSk3fxTHkQO8K6MBPYKCQTeEzX+6YZq/BT/PyxrzPnyz?=
 =?us-ascii?Q?YnrJQ7+bAdJDoYi2EwGSs4JtyBjUSCi2FZgnduWvV7XxLW7tevw6IhuFsght?=
 =?us-ascii?Q?lMqnFRU/CBhid+1lOlgLIh/W82ww7lecEW71FyZekMJ+JC/Z1QkxlTYw+wk8?=
 =?us-ascii?Q?eeZ5nw51fOp7ZO6l0rr1obc2f2i28qRB9p4FPwzC5qz7RL4D1HvHU2TBR56/?=
 =?us-ascii?Q?LSI0xoSH3bmBQbJmHCG5KeyZC2INwRgG1GHQa6GkBLVfSBtStKdPzt9V9fJi?=
 =?us-ascii?Q?1zdLK4yrn4zZDZcYnwyLKXn1cVaAJU/kLntXaa49Q3DELy4mGsy0kWTWidAF?=
 =?us-ascii?Q?HpEJhK7qH+UEzKQxewtV0qsfj4RlYohE3a6foyjRk+ObeXSiOcKUwAoyoQ5x?=
 =?us-ascii?Q?2S4/EG8jA9uXhC+sZAJ7ij+IeYBozE84oIUEwl7CoRMAOIoNhpXn3JDcUil0?=
 =?us-ascii?Q?OruFP1gRlZiimhqq9VfeixHra3FRCzFM6VeDqITrVB13/s48tR+zP17V+D0A?=
 =?us-ascii?Q?bG6odxQZwo2c0rJ1I8dpQlkGVJfvDj3/BGgynEXOYrc6BaN0Sk9QFUOEviVb?=
 =?us-ascii?Q?ZxB0eAugnSJp8dVNJfbe6I35V1B6oeUMj5kI0O8xXSQocd/BMEcT3H6fu7K1?=
 =?us-ascii?Q?0IBgj754wIFtbosF4iMDMdEw7MggqUj2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 20:42:02.4379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b90676-c708-45a8-1499-08dcc2eae09a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7476

Add pcie_tph_modes() to allow drivers to query the TPH modes supported
by an endpoint device, as reported in the TPH Requester Capability
register. The modes are reported as a bitmask and current supported
modes include:

 - PCI_TPH_CAP_NO_ST: NO ST Mode Supported
 - PCI_TPH_CAP_INT_VEC: Interrupt Vector Mode Supported
 - PCI_TPH_CAP_DEV_SPEC: Device Specific Mode Supported

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 drivers/pci/pcie/tph.c  | 33 +++++++++++++++++++++++++++++++++
 include/linux/pci-tph.h | 18 ++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 include/linux/pci-tph.h

diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
index a547858c3f68..a28dced3097d 100644
--- a/drivers/pci/pcie/tph.c
+++ b/drivers/pci/pcie/tph.c
@@ -6,9 +6,42 @@
  *     Eric Van Tassell <Eric.VanTassell@amd.com>
  *     Wei Huang <wei.huang2@amd.com>
  */
+#include <linux/pci.h>
+#include <linux/pci-tph.h>
 
 #include "../pci.h"
 
+static u8 get_st_modes(struct pci_dev *pdev)
+{
+	u32 reg;
+
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
+	reg &= PCI_TPH_CAP_NO_ST | PCI_TPH_CAP_INT_VEC | PCI_TPH_CAP_DEV_SPEC;
+
+	return reg;
+}
+
+/**
+ * pcie_tph_modes - Get the ST modes supported by device
+ * @pdev: PCI device
+ *
+ * Returns a bitmask with all TPH modes supported by a device as shown in the
+ * TPH capability register. Current supported modes include:
+ *   PCI_TPH_CAP_NO_ST - NO ST Mode Supported
+ *   PCI_TPH_CAP_INT_VEC - Interrupt Vector Mode Supported
+ *   PCI_TPH_CAP_DEV_SPEC - Device Specific Mode Supported
+ *
+ * Return: 0 when TPH is not supported, otherwise bitmask of supported modes
+ */
+int pcie_tph_modes(struct pci_dev *pdev)
+{
+	if (!pdev->tph_cap)
+		return 0;
+
+	return get_st_modes(pdev);
+}
+EXPORT_SYMBOL(pcie_tph_modes);
+
 void pci_tph_init(struct pci_dev *pdev)
 {
 	pdev->tph_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_TPH);
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
new file mode 100644
index 000000000000..fa378afe9c7e
--- /dev/null
+++ b/include/linux/pci-tph.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * TPH (TLP Processing Hints)
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ *     Eric Van Tassell <Eric.VanTassell@amd.com>
+ *     Wei Huang <wei.huang2@amd.com>
+ */
+#ifndef LINUX_PCI_TPH_H
+#define LINUX_PCI_TPH_H
+
+#ifdef CONFIG_PCIE_TPH
+int pcie_tph_modes(struct pci_dev *pdev);
+#else
+static inline int pcie_tph_modes(struct pci_dev *pdev) { return 0; }
+#endif
+
+#endif /* LINUX_PCI_TPH_H */
-- 
2.45.1


