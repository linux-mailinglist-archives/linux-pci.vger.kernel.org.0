Return-Path: <linux-pci+bounces-8143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 563F18D6BB9
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 23:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB282B2527E
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 21:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C05F1DDD1;
	Fri, 31 May 2024 21:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qjNzGb37"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991A178C9C;
	Fri, 31 May 2024 21:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191550; cv=fail; b=alkNuFLeke4iNnETjiY1CPuMfMw6WmcXdILgj2Ei2CUiFBbjsPVRAjqwuMErw+k7g37U/a9w/4DxqGNexcvAVo+JOmf0EdbG7SWvm2O+OQE4jxkhb7WFLO4G4n++OSpMUSS/qnAnbLa0j9Cv60zqbl2r8ps5XqinJPz0vVsJiQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191550; c=relaxed/simple;
	bh=x4iJYIjZuoFqT+tWZfr25SAwOXOd8EuwGhhWsOBO3Ic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ya3febT7AZdc3do+Df4y+/8P7laTZGw7gdtHgq66qwNHbzKjSPpOMJjW3FfK9160YJhYKjbqLQdAEBLTmNu6uzZgN9aovS9h+mjH2J1nu5yw7IQB9iKrfNMPXrUdPQhsl2n1L4ndhU2XVQ524adODieV2zey6QdS0rIMmbEWuoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qjNzGb37; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKLIUsvifyP1XYwwO7uxHIhfg5eaeIyvBrf+ISYaa+Hnqe1xwT04Ylom4Qugt7vNciypb6reG9AWJNWH3qz3jhwDYaRnMWrLUbak4QbvpTgiaFAddN2zfIRfXWp1lBKq/NMOemjeR4udI0hxPfIOzDL6gPlQPj8FDr4W+eHMriMpIx4thsX8vjial0iy/VGy2EzkC45wGTgTVvdIh90/71MwEanplLLRXmmChbIOAzkc7Ca3QGYyejBs/w4jGEEvusO/0qZgVestaTI2Ki/C0AWeDdp+vKXvDxLhevPbF8c5VG5fW6J8b1THrZMPhL82MzLv+BbMXSvl6vLU6YMHBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvLzinwUQqz7Xakud+KTfFCb38kjnyCVKHafbku1Xo8=;
 b=Jw4kKSxUZVn6GQ1KMTBr7csh4pJ3dkfni3HyKd5pGK0lDO88NG7XxRgREcX7o7zU95IzwyEQ5WVhXRms2oGmbNaCeCTcGQ01VabP9Eq+y6FnbjzZtuR0rRU9xLm+Ql6SCzHotxV8B4THWewF9nEviYvt1Z6dkRNSgz4XD7MkiYZLm4tcsOXytmHXC4Qu7gu+7txPaBQmKUmRtNles8BA2AF1wbnkSIIsrgBOLccMinfYbYz0K4RY8Dp/aJ1C/oAKhSpI8cs5t2zhxidgX3NoXpGMgEUnPsmao674w1mZ85GGnt8wMCWmyqJI5blcL75zfeyrDSRy/qXs+IdGJ/Pa3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvLzinwUQqz7Xakud+KTfFCb38kjnyCVKHafbku1Xo8=;
 b=qjNzGb37cOr06bbQNfMqoCffuRqJuSqj5HR3dXXlzEM7noJWRVAm9pL4bZThzpj+OtHDN1rC5edqj4D6Kmn6/X5/dIWCyitpxgep/Tbu2n9hHgZlJ35E0ypY2ajoE9EzfRo6igebqZg+QlVraD10qveed8cqkwcK/WKCAfwMszY=
Received: from PH8PR20CA0021.namprd20.prod.outlook.com (2603:10b6:510:23c::26)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Fri, 31 May
 2024 21:39:05 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::76) by PH8PR20CA0021.outlook.office365.com
 (2603:10b6:510:23c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25 via Frontend
 Transport; Fri, 31 May 2024 21:39:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 21:39:04 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 16:39:03 -0500
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
Subject: [PATCH V2 1/9] PCI: Introduce PCIe TPH support framework
Date: Fri, 31 May 2024 16:38:33 -0500
Message-ID: <20240531213841.3246055-2-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e8a3cc-48f3-4111-cf9a-08dc81ba180d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UQZSw/Rb9sj7JtGnyWuR2j9D474sYzPaM2LB+ukww+Xo679y2a2SNEA4yHDH?=
 =?us-ascii?Q?ADqVFdogukd82OPM4cIip/gEQMvqWuoSuDahMvqm5d1ftU9+GCa7JyZU47XZ?=
 =?us-ascii?Q?B5uW5V9PKY3KOiWYJ6FaaYaHt5I5hoOov/0giSqcvfQ7H9ecLJac9AmRj+0/?=
 =?us-ascii?Q?d9GvDDejdRGZRrLN4w01vqOu95PWL0jx/QpHX0lnyBGydBh9nizfUKh3zAhs?=
 =?us-ascii?Q?FRyu/dQP5EWrDoquW71kPuCdQZ98KKQWV/dY5jlnZhT9891gt24W4IvCmqdO?=
 =?us-ascii?Q?kAgx0xqxQV7aNcuR9rapF4PmPjHemj30H0Sxgj2cmS+cUJEZEzyXC0y2dt5D?=
 =?us-ascii?Q?XT4PWrAuO4GfC4B7nOzgudTBH+LSWCVb+O7oF7U3zKRRgd8IE8vhO2sxvR0V?=
 =?us-ascii?Q?MtT2Q+D7iMILYsml/wgQWPTXfmuklVaLTCO1Dendr1UXyX/Ore+38RTGK4kL?=
 =?us-ascii?Q?6CHwS9zYb2UPlwWyv9Ov4IOYUfgAqRv8nxwjuXn+j33QGMYkqYUAbwZT3srR?=
 =?us-ascii?Q?JrBOBd3ki5TlEwogCxiHC7dJIK8pHf1mpI6T3ycZCkfCdKgbWnyeZiMDcsdW?=
 =?us-ascii?Q?i+L0yPli4j9smKx65lqb7gDHzUeHWw1xXJ88U39S7T2kDDANu0MaUE4Nhtqh?=
 =?us-ascii?Q?Hmpo0GBxPweHCFmI4C8bKcnkPiM03/vFescM2Lp9RbeRlK8aI3qPc5Q2qadp?=
 =?us-ascii?Q?Au4aYmSOWRMbrLakJ0sa2CSHEOdTjmtuv6QgfRghYH6oupp8n/PG9HqZurmU?=
 =?us-ascii?Q?ohHe4X3cQRwc/ivnYPYjmpgNBZ3wROFZLVNE8vRTFifSIm/buxPZwxhpjKNr?=
 =?us-ascii?Q?TTGIypW+LLIMwLMIvbZEu6Ln01xl8AwTE4euTLH0i2LLTMzzz+FUKoIlQkiq?=
 =?us-ascii?Q?1/2W+agh9NkUo9sRcT+cSMSNg7RClxzddLEAPaTq3JKVbZTKF/1MeYJtxhGH?=
 =?us-ascii?Q?HAV6D19gHFTJ3Ge5V5SDg0dIcbjZKSSF07oOot7hPyGiqw0uo9A5gWBPr3Ic?=
 =?us-ascii?Q?wSpVwfEf8imT5hL8V2nI2+Twn3X+jYtETrl7MSJgRRhAe3Q3VKLNBZ5Tawtp?=
 =?us-ascii?Q?g2Nd09pnKAe5bL+z+9JJDiBglFYXNVyKFCp1B5wFFPbRdp2rtaxU/IKiN3Yb?=
 =?us-ascii?Q?Lqk5uQn6361WPfuXOmiSf9K6nfieaDmSci/Ht22DADXN3CO0H9tmf57uzq9W?=
 =?us-ascii?Q?b6hnuPw79xtCZgdmewqTwf/HKETmI81055SVl9zGeeJuvA6KbFtZrsmmkYIY?=
 =?us-ascii?Q?CEiCd5pnSFBV0z4lms6oi+aU3p3jy1mN9sjgPTr78k5BzLxgYsr2mjBFr8p4?=
 =?us-ascii?Q?6L/JNDVFMRO4Cxf6pzFDj+FyecT4yVMPTpSziENIUqRolwgWfPAzqEcd7FDf?=
 =?us-ascii?Q?f+hqeThdAc89mwlp2EaihGwUe0/x?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 21:39:04.6132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e8a3cc-48f3-4111-cf9a-08dc81ba180d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431

This patch implements the framework for PCIe TPH support. It introduces
tph.c source file, along with CONFIG_PCIE_TPH, to Linux PCIe subsystem.
A new member, named tph_cap, is also introduced in pci_dev to cache TPH
capability offset.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com> 
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 drivers/pci/pci.h         |  6 ++++++
 drivers/pci/pcie/Kconfig  | 10 ++++++++++
 drivers/pci/pcie/Makefile |  1 +
 drivers/pci/pcie/tph.c    | 28 ++++++++++++++++++++++++++++
 drivers/pci/probe.c       |  1 +
 include/linux/pci.h       |  4 ++++
 6 files changed, 50 insertions(+)
 create mode 100644 drivers/pci/pcie/tph.c

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fd44565c4756..b371b5b45f86 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -506,6 +506,12 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
 
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
index 17919b99fa66..d22857325b3e 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -155,3 +155,13 @@ config PCIE_EDR
 	  the PCI Firmware Specification r3.2.  Enable this if you want to
 	  support hybrid DPC model which uses both firmware and OS to
 	  implement DPC.
+
+config PCIE_TPH
+	bool "TLP Processing Hints"
+	default n
+	help
+	  This option adds support for PCIE TLP Processing Hints (TPH).
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
index 000000000000..5f0cc06b74bb
--- /dev/null
+++ b/drivers/pci/pcie/tph.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TPH (TLP Processing Hints) support
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ *     Eric Van Tassell <Eric.VanTassell@amd.com>
+ *     Wei Huang <wei.huang2@amd.com>
+ */
+
+#define pr_fmt(fmt) "TPH: " fmt
+#define dev_fmt pr_fmt
+
+#include <linux/acpi.h>
+#include <uapi/linux/pci_regs.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/msi.h>
+#include <linux/pci.h>
+#include <linux/msi.h>
+#include <linux/pci-acpi.h>
+
+#include "../pci.h"
+
+void pcie_tph_init(struct pci_dev *dev)
+{
+	dev->tph_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_TPH);
+}
+
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 15168881ec94..1f1ae55a5f83 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2484,6 +2484,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_dpc_init(dev);		/* Downstream Port Containment */
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
 	pci_doe_init(dev);		/* Data Object Exchange */
+	pcie_tph_init(dev);             /* TLP Processing Hints */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5bece7fd11f8..d75a88ec5136 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -530,6 +530,10 @@ struct pci_dev {
 
 	/* These methods index pci_reset_fn_methods[] */
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
+
+#ifdef CONFIG_PCIE_TPH
+	u16 tph_cap; /* TPH capability offset */
+#endif
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
-- 
2.44.0


