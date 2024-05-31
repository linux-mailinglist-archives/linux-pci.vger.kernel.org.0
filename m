Return-Path: <linux-pci+bounces-8145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 958C38D6BC1
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 23:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05F08B25FB7
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 21:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190837EEF5;
	Fri, 31 May 2024 21:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K+kaaRrt"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487E382486;
	Fri, 31 May 2024 21:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191583; cv=fail; b=DQgo51SdNdjc51kttZJwgWGZLo2bgP9HG1xzQWo8ZSKZq5T2Q71etVVPS3rS6zDXX/HP6BZEJaxO3B20bjg/juFIlOtqs9SBxrBCqZq5aUNJxJdOu4qkbclgLVh6xQSRuYvf6ExivuPmi06AABsfxWCBjNfOoPFvUHt0pH23VL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191583; c=relaxed/simple;
	bh=GrxYnukooNDUViI+nJNy8Janil6rg2fBr24u3k7GREk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVHVTmZvZytajXpgUR2YhOkosDBEBtlKHlw0zRV1cpFhtdQY4axiCLcaixzGX+bk4VCq2xXy9lIg4Du4xooCzpfvglphAd3xJkTZmD6Cic2PsFJmYd6HGn+M6nxz6wy+3eFKWgZqr63/ocKYjAFtxtL4nxGnxmWBalJOPumYTjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K+kaaRrt; arc=fail smtp.client-ip=40.107.102.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcvlsYLHNtgn7XJSMOxKK2hU1YfnFhU2G9QRJC4jrz0I/qfaANZiORxQmD4WcfNGi8XZpayGY1ngv0Vsh8u/bXL3AV8llYWwKasTvUSuzery9VtArMpmXWZ+8NwjSHyOnRDTHP/asJAc3LmMTzHRZMMwxDZf2ntKNE89XMRo68zizGFXn45v9uoOQErTFd9b3uV7ZHqHZrcs7aAs0g0+/ku5PVjS5b41k6LlYTTv1tOvB4jbcrIKRKeGUUOhMD1uKlgo9bJRpBnV8xoZ7zc+8uF5wfxmuxnAkCGxzjVvBjhDuYRxnYL2SH1tWe2TahUO2ljWCZOU5e2ydy1q2qh2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BhhnLBD+BxpmDMXE4whS2a4wCEfWBpWo+i2ezdk+mw=;
 b=QN6KsT4sg7tNwS9+wSWKoCOi9JzEXyjjcT6943C04ZsUQn5OWqZ78pivVzNX0gVOtiUvajT4AxnSZNljFP4mWpb1Mc9HquQ1G96pBOF0AibcX75sEFLV1unT1kcGwrP5afAdj2PYrjM5pD1C8UST4EweQLXlgbMq5o0LQYJLvnxvuj44gV9Eq2DKRP1aNG0pGRSfrPsukSEEENlJIFZ7ei+WXEI73tVL6LWwqjdfFujvZ6WmvaUC5BBzfLuRuFlTPGISnIpjKNv0tWlwO51YVZCwmwOvQf8k/RTzlliPBaUKBbfJzFpY7lZnIQ7cPLc+9Hoto4mCRvTYYnPGYJQGAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BhhnLBD+BxpmDMXE4whS2a4wCEfWBpWo+i2ezdk+mw=;
 b=K+kaaRrtQbegcmUidBBcHw4raHi2DQo5a0oS2G063RUcXUJPYgVjt7UxbbVtINGKJtpPat6m5p2HOT+5tw2d/yNqi6kaIUrGOt5bflcSntAtsx6/MJ8NdquVBoXcUrTKEJzGdyPJMT66tMzZ/3aSnbulhfE8yCjLnaWaikCWZGE=
Received: from DS7PR05CA0105.namprd05.prod.outlook.com (2603:10b6:8:56::19) by
 SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.22; Fri, 31 May 2024 21:39:38 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::d) by DS7PR05CA0105.outlook.office365.com
 (2603:10b6:8:56::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.10 via Frontend
 Transport; Fri, 31 May 2024 21:39:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 21:39:38 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 16:39:35 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <bhelgaas@google.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>
Subject: [PATCH V2 3/9] PCI/TPH: Implement a command line option to disable TPH
Date: Fri, 31 May 2024 16:38:35 -0500
Message-ID: <20240531213841.3246055-4-wei.huang2@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240531213841.3246055-1-wei.huang2@amd.com>
References: <20240531213841.3246055-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SN7PR12MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: a0fee1b1-69af-4884-b4a8-08dc81ba2c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|7416005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kpy49RzKg9fD2zJau67l+CfLyQqFr7VkMwV4EeCpjjTRWVWKYTH+pklHF2cI?=
 =?us-ascii?Q?152pqeWWuG4mntglxyR1i7L/6PTUdDvyQteSaRKA7g4dfWwn+TfIgCxQRI+R?=
 =?us-ascii?Q?KOVo/82ep35KZCKHSVJ8VdM6q5iynnZwYpDfrQ137rbOZaBflHFkwYHIGw7K?=
 =?us-ascii?Q?0r4rm76Dp3gExGx59wkABRwGHjrp+SxqMa86klVPozNi+W7qQl9LhKxHZxnO?=
 =?us-ascii?Q?At+7bjlh9jQXyGH319LzrGYwqI9slajiZ3W0p3pIdPZpGQsyGkoIbMTNL/dY?=
 =?us-ascii?Q?tJIgbYnMoWyNSFR0KnNHB/z5texvjpzc1p/YtCZq7f/oceZeAiXQctSgdEU/?=
 =?us-ascii?Q?Gud1mkw2V35pVTkcLAq30vF3t7EnPUKhjDRRFpjgAaEArTdigedWb5K0S0Yo?=
 =?us-ascii?Q?Ts+PRjFKqyxcmrZ5Zj4O57COqMCo8M2FLxm/vUmxNA+q2lHzkmErbvbs0Bdq?=
 =?us-ascii?Q?vHDd0wMbRuedJSFNrwXQkFtGY3sgVVEmZWC/RCau/QHrqi7QVvr0XICqoWMs?=
 =?us-ascii?Q?kvFYhgpKSlpwKc8E85gU4qjtf+Qlaj9HYjTv1j42XeoeGhpG6yqAQNK5/rXM?=
 =?us-ascii?Q?9gtn+PG6DLKI6ya/R2SsAUUdtmRlgT2n7WVv8bpL/o9ECTxt6nQcnmCH4KB9?=
 =?us-ascii?Q?X33pkMImWSKAnglzaL4K7kulAVykcFZ/fOBEm4dz+6AMwcb9RF7UBuRJ0wSR?=
 =?us-ascii?Q?RQbmefoaaN1YrnUYJ6RPwQx274xpHeKk6j8WKcCE689hlc9vw5soY5cKLJ+A?=
 =?us-ascii?Q?9h1Ekuz4xs7SaEbyLMEySuM10TWTtw6Kz8Xw/UD7M41LdI8tk4Ktow6eiVMp?=
 =?us-ascii?Q?cBcuntZukvRiRVv+NL6Yik4VnlaClUEklLOZ8h8WakT1wOFOYADUr/QKQTPV?=
 =?us-ascii?Q?ff4d6UQdmZpu4YCiPsEgXSm7DVDCcrGGT9yAG8gQ7fNChPbt+8oK3CFnRkAd?=
 =?us-ascii?Q?DBxYgBusz72P6QeohqU6Ewk8iOIT+5+QEeU7Vj0+RbijnU+Jc6RclrIhO50b?=
 =?us-ascii?Q?c1vpB26B+qAxzccXjhz7eCjMc6ugcelVVK87jnOonIg97sb6RqPaAB1QkGkh?=
 =?us-ascii?Q?yR0NKTGQl3XfReIgTa1o8zHLXWo02wTNmKzlr5J9rQN8Wz5nyJ6EtA0Kd4Cz?=
 =?us-ascii?Q?cfiU2qQ/4TL0XSDUZSNwwMZVuRXLJ0aG6rTDlZP5p2BqNJmEJ2w0sQ78QnNr?=
 =?us-ascii?Q?gZv6NgUhUaXffFpNy+bdrGrqkITGEqT6vho/tCuvDWUfS2uTFCFXGjZRU8ii?=
 =?us-ascii?Q?5kMQnerDAAUakS2oUbKPQp//WP9Lo7Mo2EmRI4Cz1cxN/NAMJlFPaABL/dKz?=
 =?us-ascii?Q?50jfh4i4MR3rSUZBWtw0CZ9tOsC3ZpE8smz/HaNGvQjocNMjLXnz60U3xsPN?=
 =?us-ascii?Q?gWWHmdsKYBgQ2jdy6uun8Bdy9FB7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 21:39:38.3268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0fee1b1-69af-4884-b4a8-08dc81ba2c23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8101

Provide a kernel option, with related helper functions, to completely
disable TPH so that no TPH headers are generated.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com> 
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
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
index 500cfa776225..fedcc69e35c1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4623,6 +4623,7 @@
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
index 59e0949fb079..31c443504ce9 100644
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
@@ -6806,6 +6815,9 @@ static int __init pci_setup(char *str)
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
index d75a88ec5136..d88ebe87815a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1841,6 +1841,7 @@ static inline bool pci_aer_available(void) { return false; }
 #endif
 
 bool pci_ats_disabled(void);
+bool pci_tph_disabled(void);
 
 #ifdef CONFIG_PCIE_PTM
 int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
-- 
2.44.0


