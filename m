Return-Path: <linux-pci+bounces-7299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4AA8C12E3
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 18:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557E8282A65
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2641708BA;
	Thu,  9 May 2024 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="089azERu"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0EB1708A0;
	Thu,  9 May 2024 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272107; cv=fail; b=ANsD5Lns5wYmXlneOgYmV1gbaEjUxVPcUodGfDkfUfU/yRyNQfOI0FwZmmjAE65it/hELsui58XTz44uhRI2Eru35GsGhfj9Wo2EMokDF0d4uyfWP2GYzBLqm2rmitPzQf84RMBlRUkGC0rS7F0NdoIKKJb7wnuiU5BFPn2GSmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272107; c=relaxed/simple;
	bh=A+bdPvLNUU7dMpHEg5FyIyNIEF5XonOVfSM8fCRFpV8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mv75sLxHB5ZhDn/F6G2pecbImdpBVV/tXc1vSdesSCavB56l3d3hcH5dcDC/zDy3XUBTXLaJPoOZMCNAAyA0xPEsToBUqS/p5tMkFrdlFfczpp+4umk6vv+e70XnjxVVZlB7AHi9TS7nuOW9KTDgo9vtvjbKrfFsQCakgbadvVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=089azERu; arc=fail smtp.client-ip=40.107.101.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVeyrpTpoU2iXTo+iefISr529t9NAN6gK8kzhVCpdBKY9jnb00mZ1GBjmSDzHNJ7ngH9zsRDbuWZQVuEY8q0QbiUIaWHPYVeM5NmEGdTDvmpkX5CQRh6+GETNZ+j4NOvSPGJeHzMp3eeKf32dku/04JScZGjmJUvdR0UMuktvwXI+BuoQo8VDUMb/e3t7OrvCvtH9eSLd23GlUKgitaG7qF0RxuBPwRk5qMbJWdoVqRlI7NWyWx2U9xsiiwvMnJZaGi9sf5bQYpMRANo+kwm856m6a6a7XrVTCr1jALs/kGPlFr4AGHLabAAJcxx6EY9g3ienC/CTAgjvcPMUNsUJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmT34m7Qpw+VHXVkwStmijxFc0INyq4jf6m5bh6Loz0=;
 b=X7mnMn2qQZl0+yTzriIe1zwnXldNkwp08zRYOHmEdqvgacCKtpuxjQB2rgtx83eZ9uP+vjfOVfEo56GTX2vN9YDIncvkBIys9dLXXEdz8anL9CD+mPyxdGMHPfgP4vesWGkpQBDWNlQ61vOEsv+Qn3rNXIh1HEN1mhnr61s+t3kpAI53TaSH/2LTtjFsx9+mcSRU60axhbqpX2TK1aiILltmy5WyYZX3G2kiqj3pegk34uvQOgLGsl6wjm5by/0Q2TLVwTvm/PdfHsybDwqwXzAa+slVq+gERj4CPLWOr+xZjiTcpDJ2EpvHafJ7V0ZzER3TXFmxrlyx8yTieqOtMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmT34m7Qpw+VHXVkwStmijxFc0INyq4jf6m5bh6Loz0=;
 b=089azERum71ZWllM+6jvQ/6WjrhBSlAIOV7nqFFWwwWvLMxMPznnNHGhuZNvNly85AfKDFwSKlkEOF2lqZFq8gUh4vKd+cqM3Irvia+J1ByfsRFSwg9ji+cYPznGPnGo8HCbjQl45Tw8q7Gs4CEdcIYgiGqwt2UCKKh4s61fNno=
Received: from CH2PR16CA0029.namprd16.prod.outlook.com (2603:10b6:610:50::39)
 by SJ2PR12MB8956.namprd12.prod.outlook.com (2603:10b6:a03:53a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 16:28:21 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:50:cafe::b7) by CH2PR16CA0029.outlook.office365.com
 (2603:10b6:610:50::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Thu, 9 May 2024 16:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Thu, 9 May 2024 16:28:21 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 11:28:20 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <bhelgaas@google.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>
Subject: [PATCH V1 3/9] PCI/TPH: Implement a command line option to disable TPH
Date: Thu, 9 May 2024 11:27:35 -0500
Message-ID: <20240509162741.1937586-4-wei.huang2@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509162741.1937586-1-wei.huang2@amd.com>
References: <20240509162741.1937586-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|SJ2PR12MB8956:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d64f14-c08f-4281-056e-08dc70450ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|7416005|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hAmE9KWOVvXiWfSntRoQVnr2XlHYOzVlRkS8c+zFMVu6TVVLPIIsBrYdZIY+?=
 =?us-ascii?Q?odFrNYxyCPzHP90eHpFVmEkuYpQbLHzjKqQsCD7yJkhV/tov4pZfXgRGnoe0?=
 =?us-ascii?Q?aiBsibb09abbt7N75xy+VWcpBH/mUFmsgLaWnIrICt/JGPPkYKF9iQmO1TqF?=
 =?us-ascii?Q?hDpXvnuAhaKIwj8w2K3b7hm+Sd0bMWJuJmoEx9oOuEiaECwvTX8JIj0KMJ1b?=
 =?us-ascii?Q?3YiAGEQDAdGMUm0yeZcie9vH08zO1Fjg0ZdtI6imJ0pSDoZCskDp7BOiY70c?=
 =?us-ascii?Q?rNf0bXuUo8LtbiZZ3WjmMTgftdvuo6itpNFGW5aMoi7/Hjc7QsLa7dSdDZSD?=
 =?us-ascii?Q?2Er5RVuK0KiBmmC6t+WNimN5xZUdTMeEMM/66jFdOM+73jP1CDapbpjTB3ii?=
 =?us-ascii?Q?ywtK6yJUa8r3gPoUD5KAJVowC0ThvUC1b8o56JRJp8zljD4hXbVhUtT82qFn?=
 =?us-ascii?Q?KOzZSMn+SbgESQcYuRHUCs6ertsqPZHN5cYks1UvuP/nKCl5bT7ZNZAVJA5Z?=
 =?us-ascii?Q?7Ks6ilM9hN10oM6uY6XSEhBKwoUeUI4QLLPs065O8KTFCjY3IMfQpg26gUX0?=
 =?us-ascii?Q?EtWTJ/K4kk2mE4o49lsb37r+oNG3rt4uKgXIBRgj/aXAEOFiJtolOW/oHbRh?=
 =?us-ascii?Q?Mw2s8SDEfdhZp63W7eH+jwO5e2V/kLUufdTm+kFjSVpDKNXnD8L2ixMpUV4W?=
 =?us-ascii?Q?pmjIncplIhKjjhfzARIMBXD0QjmkMmeUWlna6sMWagi7I03ElfowJVqI2p2e?=
 =?us-ascii?Q?KNXRpMEJUadle4NIRdfJYOKzjKgBpVKh/5ABYJ1ymoEY6Tz14zcqPOGMN9G9?=
 =?us-ascii?Q?b3+TpD36RTOqYrVhKmXiSGl5Cq/t71duTZE/NA4H6sqvyNMG5qNECpAapZXd?=
 =?us-ascii?Q?aWGIMhXnDNYLPLhI3k+1mzgn1hLSZ+6G61ONw4btMWXu4UXSa1z6bg8P2RIi?=
 =?us-ascii?Q?LB3FaxI7lkK8MAnunerEnpMBi6M0TRTP5N7IKMaFI1IGZWZkLwB05Z/TqII0?=
 =?us-ascii?Q?WnWq+Oc7Y5/lN0GTVDmtvYb5kpw7ukLR1Q/pyZH2Me2C45vdv1AdwcqqtFSs?=
 =?us-ascii?Q?4PtvvHuDXTEuoYEzYbKLOxGB71eir9SecztjK9q8f9Wbpk0RfimMH4g3MRSd?=
 =?us-ascii?Q?4PeAl0rOXUMXLByEhJSk2osJzSDX1UTECb4GrBW2NBfFhqX5g0NI68MrEdFh?=
 =?us-ascii?Q?ZSlUdYDBRYA6fWe2RvFuqDQMCdTsirU91a+XmKm0j351dIv5Xx8AUILqfxhR?=
 =?us-ascii?Q?8No2HMyJWsywaWZPheg24TrZKAQwDdLHmiTprcEHwQRFIVwuCcraTPZdYIRh?=
 =?us-ascii?Q?BZ6Z6OMj1ZJrY+gWd+K0Af98BuHbx4yInqw/BjPtVpthROREHuwOJPZSCnBP?=
 =?us-ascii?Q?dQmAY8Fb3jpSLLCohTZwc2XFBPhu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 16:28:21.5864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d64f14-c08f-4281-056e-08dc70450ad4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8956

Provide a kernel option, with related helper functions, to completely
disable TPH so that no TPH headers are generated.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |  1 +
 drivers/pci/pci-driver.c                      |  7 ++++-
 drivers/pci/pci.c                             | 12 ++++++++
 drivers/pci/pcie/tph.c                        | 30 +++++++++++++++++++
 include/linux/pci-tph.h                       | 19 ++++++++++++
 include/linux/pci.h                           |  1 +
 6 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/pci-tph.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 396137ee018d..5681600c6941 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4593,6 +4593,7 @@
 		nomio		[S390] Do not use MIO instructions.
 		norid		[S390] ignore the RID field and force use of
 				one PCI domain per PCI function
+		notph		[PCIE] Do not use PCIe TPH
 
 	pcie_aspm=	[PCIE] Forcibly enable or ignore PCIe Active State Power
 			Management.
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index af2996d0d17f..9722d070c0ca 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -21,6 +21,7 @@
 #include <linux/acpi.h>
 #include <linux/dma-map-ops.h>
 #include <linux/iommu.h>
+#include <linux/pci-tph.h>
 #include "pci.h"
 #include "pcie/portdrv.h"
 
@@ -322,8 +323,12 @@ static long local_pci_probe(void *_ddi)
 	pm_runtime_get_sync(dev);
 	pci_dev->driver = pci_drv;
 	rc = pci_drv->probe(pci_dev, ddi->id);
-	if (!rc)
+	if (!rc) {
+		if (pci_tph_disabled())
+			pcie_tph_disable(pci_dev);
+
 		return rc;
+	}
 	if (rc < 0) {
 		pci_dev->driver = NULL;
 		pm_runtime_put_sync(dev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5f243dd4288..06f9656f95bf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -157,6 +157,9 @@ static bool pcie_ari_disabled;
 /* If set, the PCIe ATS capability will not be used. */
 static bool pcie_ats_disabled;
 
+/* If set, the PCIe TPH capability will not be used. */
+static bool pcie_tph_disabled;
+
 /* If set, the PCI config space of each device is printed during boot. */
 bool pci_early_dump;
 
@@ -166,6 +169,12 @@ bool pci_ats_disabled(void)
 }
 EXPORT_SYMBOL_GPL(pci_ats_disabled);
 
+bool pci_tph_disabled(void)
+{
+	return pcie_tph_disabled;
+}
+EXPORT_SYMBOL_GPL(pci_tph_disabled);
+
 /* Disable bridge_d3 for all PCIe ports */
 static bool pci_bridge_d3_disable;
 /* Force bridge_d3 for all PCIe ports */
@@ -6707,6 +6716,9 @@ static int __init pci_setup(char *str)
 				pci_no_domains();
 			} else if (!strncmp(str, "noari", 5)) {
 				pcie_ari_disabled = true;
+			} else if (!strcmp(str, "notph")) {
+				pr_info("PCIe: TPH is disabled\n");
+				pcie_tph_disabled = true;
 			} else if (!strncmp(str, "cbiosize=", 9)) {
 				pci_cardbus_io_size = memparse(str + 9, &str);
 			} else if (!strncmp(str, "cbmemsize=", 10)) {
diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
index 5f0cc06b74bb..5dc533b89a33 100644
--- a/drivers/pci/pcie/tph.c
+++ b/drivers/pci/pcie/tph.c
@@ -16,11 +16,41 @@
 #include <linux/errno.h>
 #include <linux/msi.h>
 #include <linux/pci.h>
+#include <linux/pci-tph.h>
 #include <linux/msi.h>
 #include <linux/pci-acpi.h>
 
 #include "../pci.h"
 
+static int tph_set_reg_field_u32(struct pci_dev *dev, u8 offset, u32 mask,
+				 u8 shift, u32 field)
+{
+	u32 reg_val;
+	int ret;
+
+	if (!dev->tph_cap)
+		return -EINVAL;
+
+	ret = pci_read_config_dword(dev, dev->tph_cap + offset, &reg_val);
+	if (ret)
+		return ret;
+
+	reg_val &= ~mask;
+	reg_val |= (field << shift) & mask;
+
+	ret = pci_write_config_dword(dev, dev->tph_cap + offset, reg_val);
+
+	return ret;
+}
+
+int pcie_tph_disable(struct pci_dev *dev)
+{
+	return  tph_set_reg_field_u32(dev, PCI_TPH_CTRL,
+				      PCI_TPH_CTRL_REQ_EN_MASK,
+				      PCI_TPH_CTRL_REQ_EN_SHIFT,
+				      PCI_TPH_REQ_DISABLE);
+}
+
 void pcie_tph_init(struct pci_dev *dev)
 {
 	dev->tph_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_TPH);
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
new file mode 100644
index 000000000000..e187d7e89e8c
--- /dev/null
+++ b/include/linux/pci-tph.h
@@ -0,0 +1,19 @@
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
+int pcie_tph_disable(struct pci_dev *dev);
+#else
+static inline int pcie_tph_disable(struct pci_dev *dev)
+{ return -EOPNOTSUPP; }
+#endif
+
+#endif /* LINUX_PCI_TPH_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 73d92c7d2c5b..63aa6f888c90 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1866,6 +1866,7 @@ static inline bool pci_aer_available(void) { return false; }
 #endif
 
 bool pci_ats_disabled(void);
+bool pci_tph_disabled(void);
 
 #ifdef CONFIG_PCIE_PTM
 int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
-- 
2.44.0


