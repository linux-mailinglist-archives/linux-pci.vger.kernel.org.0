Return-Path: <linux-pci+bounces-30852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EEDAEA9D4
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825021899F31
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D77C27814F;
	Thu, 26 Jun 2025 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AfFRo2Rw"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ACE26FD8E;
	Thu, 26 Jun 2025 22:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977831; cv=fail; b=kbNsk0KKAdZpaElMFlRput2a1ELZ+Y1X8RXKBCP+U4jGOYC4NtbaeKK7Qqo/YyFku9DNEXM1BRB62anXUoTgEpA+1oBYDsCXo2K9DTIJlhLYDWHs3Qx4k54kpAjZRSMotWOFYtCdrggne3fYCtCNEDE0NimA53O6LnJJYEU0yuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977831; c=relaxed/simple;
	bh=o9muO6RppQAI/0Eksw6679jGmXsJtLBp4M7n+Ud2Cs0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOJZQ+TO0wffgBwfB5gJSgPafBdxtgoUiKNBJxcUmHGFvKP2UV2ZDESsFwuHqq+e9q94BbDVVaYAZ5XmT296k5ndWZC2MocCUMW4HABTU+K5q3snySaMeMjl/M8V8kIu1iJ5OwTGJylhaZ2097kJLeacnFHQhds6//35wcgzDX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AfFRo2Rw; arc=fail smtp.client-ip=40.107.102.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkRgUbGZed5JcYCZs4ueNy46wmWoUf2Dwg5T6TscSDrznrrsvBAj4GI4h9ZIKxIl0cbbLOsfD3J6F7yW1K3KawxegEtIs1AulCKC8ikoasyUHhKNFx3/VcCM3fqqvI7dEEh3lg1vWWOvlJNJJF6R0oXszrjj8RBXKeJW+40PTL2OIR0EQ0xv5inFYOV7aijWG87kTPaSA9Fw7/+N6G9QlYDvhFYdpZwu9sLnZ05Ne0dHih/VrQXD4h6drSFCc7Rg8Dgrmak+1BapFHN4AO7yRJyjSivB4G+e+dBEa9YvEOT3WnylKJ29r+7cOS977G9RgMIjX2YrIGwcyINYEWpgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4B0csnpEwQySQujqXeH5kYKZF+Pl4gBMdjM3AzMQMqQ=;
 b=pc8vsO08CqeNaCEBPorUSi5Zj8BAuDwCE7rrXiOpEqzVx7hhvQQFkqQ/z9kyd9FKGndjx+rYkF+Y7iHybdlAOnaHDJkRdNv6BbmJQYdmcLigJfbZvP+d4zg433Z1CWGxOFck1/nAphBBn/B42t9CQ98dG+7ol0TrCXAxCqI2zDJnuKYL77ouO8QWPr4T8LcG2Ci/l030/WL4VcNeraEx1ALs1wiHuG3krlhHnBe3l0zmAL5P4FgDVDMGnmiYV9W0EVJjVdJoBjaEhVhv/k3Nkpw3W310FdasFMpyQCEtOWuR76yKo+dS3JhLTm7cBJdkdVZ7Sr9raDysv4ZPH/nH4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4B0csnpEwQySQujqXeH5kYKZF+Pl4gBMdjM3AzMQMqQ=;
 b=AfFRo2Rwfk6LelXFARYGHJZNhhM3ZR9FC4457ClRvV08e2yweAH7thExsnVv0VCI7lXboxbw/u4i7di4ygLw5n4r2TkMka7uMYGoYpszleKGgAL4V4e8qMEh1Yl3BcZ1yyVeDz89n6VoL3bZ9yPnny+f0onwTzcqxEqJ1IQIYfg=
Received: from DM6PR07CA0076.namprd07.prod.outlook.com (2603:10b6:5:337::9) by
 CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Thu, 26 Jun 2025 22:43:44 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::6c) by DM6PR07CA0076.outlook.office365.com
 (2603:10b6:5:337::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 22:43:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 22:43:43 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 17:43:42 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v10 04/17] CXL/AER: Introduce CXL specific AER driver file
Date: Thu, 26 Jun 2025 17:42:39 -0500
Message-ID: <20250626224252.1415009-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626224252.1415009-1-terry.bowman@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|CYXPR12MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e99eb9-511d-4beb-9bfc-08ddb502e7a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BXUmbzgw65sTiGscpfJFeZ97giiShdfbaqrFXAbsShGLcgnhXos3t3pVjXEH?=
 =?us-ascii?Q?3XTSAkb57GcdGh3cuhVi2HUTPpJzGJGIQWp1DbClQ2/HgykKcbu8vmabVoHo?=
 =?us-ascii?Q?u5ZDdhupps2WJHQUX0s8ND2uMpYiKof0oObCPdSeNPkB9gM+KmQlHDip2w+g?=
 =?us-ascii?Q?4xo7qB0bACNkNeMEdoR9yse9yDsI5t2pOjetiEN3PgOhmeCiTvHJObit8icw?=
 =?us-ascii?Q?ec7rCG1o/gJh5bg3PnASqo9A9xVn2DIWsrAqFrVk0ArBstzHKnoaervUvoBL?=
 =?us-ascii?Q?zbfQcqE/Lnjfd9RmexdXkBL14jd4q6OhqnjEH9qxDvj/y/596JF20gIagSXN?=
 =?us-ascii?Q?LgwrmnAGsX3eWAQGv9Wyrcpq0GqDq2qGMN3X+jAMKCh6jIxtHThVUYyoVKPU?=
 =?us-ascii?Q?2LvgWX8zvYM4UzUPJgSK52IcMo4RCTP390+azOninL/mzosE+lVKXCB/0b0P?=
 =?us-ascii?Q?BeU8hxJoynd4b0woYPLM3geqS5ehK/tFadYKjqvgaHZGngINvFUgFHJ4VhPL?=
 =?us-ascii?Q?kTqoPytnL4lTor5Y+5uCjF7UwOKgmbGScrbpwOwM20nLTYNmp6xV/ZZEMfEH?=
 =?us-ascii?Q?jb4c+KKEr4Jlcz7ZOQWmn2GspkimxJVJkN6sQIOwidlfLF2SDUY4HpGRIA7M?=
 =?us-ascii?Q?MPLlL9z9+ljLdAhPyWxyvfJ2x5gb+g5yWW3T+wl9fr2mciEThcK2XTBcQdET?=
 =?us-ascii?Q?Gojp1yCugbE+TBNQDjuDUf7mhR6YXJqWK1o5WsfYT/mVDcZKQUd9WIDV6Gbu?=
 =?us-ascii?Q?tjAWL4jAL/3bNnQi6nKWvTICA0uu74on+XSn6t/hhbTZ8O20icX5uGvfWhFj?=
 =?us-ascii?Q?Huj3t8HNdg45DrwV1deIWxMOlD5qoYJ/xyt/EwhTSsTBhefFJtlBxoqocUUQ?=
 =?us-ascii?Q?6NlBmUdTrX0MRmk7/rU0gizYPQ9xMUcPXm/H/t7hdoied7+SLJJXyi1t2fQI?=
 =?us-ascii?Q?4EzTpYNvrfs9M5n4z7LvAFw+c0gmac6KoKmFSyqbOPsmWVVkrDd1aAE7jfli?=
 =?us-ascii?Q?BMwAolV2j8sB9ADgh+QSTo+sd9Psoj8ckH6Qw2q/zUs8tFX1muf1zWZGMeFH?=
 =?us-ascii?Q?p4WligoQOtMxcrrmBSNPASoyp2mKOAxfL8FBCV0Ls8yTSHr5sCi28t3xwn+0?=
 =?us-ascii?Q?e0kueWvcUTKeP5uNufI9e2rtB6I78YH1N8nVMaMbUMH5GVwO+goY3rY1su3Y?=
 =?us-ascii?Q?V7brINtMBggyZFbb5yr1GdeW3xebZ+Iq43mv4k0knAQLWUw04Uvv5Z4dDHRd?=
 =?us-ascii?Q?wOqyYQoob5mwqYcynlRvy2H2TQBaZ3C6PbFdre91lQ+LvFt9QPjcDgcdmDSD?=
 =?us-ascii?Q?KEc6brcO1yHstvLvnL9yCTqPZwfmDc/HezvDz5h4Y1uPGa25v6z0cvNfyV9Y?=
 =?us-ascii?Q?k9U8AHyYUPCGqeZunsOgrmHRNqbwfNxP1LBPm70UZ2GlezdAf2OROWEUY9VR?=
 =?us-ascii?Q?uzOQADTL1CTOL5z+OHTAKrupVGZRlCxWXZOtUP/Bp8uOyWI3kO/Ug3QZRbi6?=
 =?us-ascii?Q?yTHgXEq/yKiIgCfXnMkzN/DVG/dq60NGsueCjlw7IdmgfL33t7Wii1Y09A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 22:43:43.6867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e99eb9-511d-4beb-9bfc-08ddb502e7a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320

The CXL AER error handling logic currently resides in the AER driver file,
drivers/pci/pcie/aer.c. CXL specific changes are conditionally compiled
using #ifdefs.

Improve the AER driver maintainability by separating the CXL specific logic
from the AER driver's core functionality and removing the #ifdefs.
Introduce drivers/pci/pcie/cxl_aer.c and move the CXL AER logic into the
new file.

Update the makefile to conditionally compile the CXL file using the
existing CONFIG_PCIEAER_CXL Kconfig.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/pci/pci.h          |   8 +++
 drivers/pci/pcie/Makefile  |   1 +
 drivers/pci/pcie/aer.c     | 138 -------------------------------------
 drivers/pci/pcie/cxl_aer.c | 138 +++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h    |   2 +
 5 files changed, 149 insertions(+), 138 deletions(-)
 create mode 100644 drivers/pci/pcie/cxl_aer.c

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a0d1e59b5666..91b583cf18eb 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1029,6 +1029,14 @@ static inline void pci_save_aer_state(struct pci_dev *dev) { }
 static inline void pci_restore_aer_state(struct pci_dev *dev) { }
 #endif
 
+#ifdef CONFIG_PCIEAER_CXL
+void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
+void cxl_rch_enable_rcec(struct pci_dev *rcec);
+#else
+static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
+static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
+#endif
+
 #ifdef CONFIG_ACPI
 bool pci_acpi_preserve_config(struct pci_host_bridge *bridge);
 int pci_acpi_program_hp_params(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 173829aa02e6..cd2cb925dbd5 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
 
 obj-y				+= aspm.o
 obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
+obj-$(CONFIG_PCIEAER_CXL)	+= cxl_aer.o
 obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2df9456595a..0b4d721980ef 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1094,144 +1094,6 @@ static bool find_source_device(struct pci_dev *parent,
 	return true;
 }
 
-#ifdef CONFIG_PCIEAER_CXL
-
-/**
- * pci_aer_unmask_internal_errors - unmask internal errors
- * @dev: pointer to the pci_dev data structure
- *
- * Unmask internal errors in the Uncorrectable and Correctable Error
- * Mask registers.
- *
- * Note: AER must be enabled and supported by the device which must be
- * checked in advance, e.g. with pcie_aer_is_native().
- */
-static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
-{
-	int aer = dev->aer_cap;
-	u32 mask;
-
-	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
-	mask &= ~PCI_ERR_UNC_INTN;
-	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
-
-	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
-	mask &= ~PCI_ERR_COR_INTERNAL;
-	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
-}
-
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
-{
-	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
-
-	return (pcie_ports_native || host->native_aer);
-}
-
-static bool is_internal_error(struct aer_err_info *info)
-{
-	if (info->severity == AER_CORRECTABLE)
-		return info->status & PCI_ERR_COR_INTERNAL;
-
-	return info->status & PCI_ERR_UNC_INTN;
-}
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
 
 /**
  * pci_aer_handle_error - handle logging error into an event log
diff --git a/drivers/pci/pcie/cxl_aer.c b/drivers/pci/pcie/cxl_aer.c
new file mode 100644
index 000000000000..b2ea14f70055
--- /dev/null
+++ b/drivers/pci/pcie/cxl_aer.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
+
+#include <linux/pci.h>
+#include <linux/aer.h>
+#include "../pci.h"
+
+/**
+ * pci_aer_unmask_internal_errors - unmask internal errors
+ * @dev: pointer to the pci_dev data structure
+ *
+ * Unmask internal errors in the Uncorrectable and Correctable Error
+ * Mask registers.
+ *
+ * Note: AER must be enabled and supported by the device which must be
+ * checked in advance, e.g. with pcie_aer_is_native().
+ */
+static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
+{
+	int aer = dev->aer_cap;
+	u32 mask;
+
+	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
+	mask &= ~PCI_ERR_UNC_INTN;
+	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
+
+	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
+	mask &= ~PCI_ERR_COR_INTERNAL;
+	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
+}
+
+static bool is_cxl_mem_dev(struct pci_dev *dev)
+{
+	/*
+	 * The capability, status, and control fields in Device 0,
+	 * Function 0 DVSEC control the CXL functionality of the
+	 * entire device (CXL 3.2, 8.1.3).
+	 */
+	if (dev->devfn != PCI_DEVFN(0, 0))
+		return false;
+
+	/*
+	 * CXL Memory Devices must have the 502h class code set (CXL
+	 * 3.2, 8.1.12.1).
+	 */
+	if (FIELD_GET(PCI_CLASS_CODE_MASK, dev->class) != PCI_CLASS_MEMORY_CXL)
+		return false;
+
+	return true;
+}
+
+static bool cxl_error_is_native(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+
+	return (pcie_ports_native || host->native_aer);
+}
+
+static bool is_internal_error(struct aer_err_info *info)
+{
+	if (info->severity == AER_CORRECTABLE)
+		return info->status & PCI_ERR_COR_INTERNAL;
+
+	return info->status & PCI_ERR_UNC_INTN;
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
+
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index e2d71b6fdd84..31b3935bf189 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -12,6 +12,8 @@
 
 /* Device classes and subclasses */
 
+#define PCI_CLASS_CODE_MASK             0xFFFF00
+
 #define PCI_CLASS_NOT_DEFINED		0x0000
 #define PCI_CLASS_NOT_DEFINED_VGA	0x0001
 
-- 
2.34.1

