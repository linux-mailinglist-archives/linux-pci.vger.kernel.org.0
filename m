Return-Path: <linux-pci+bounces-18392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D0A9F10C7
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 16:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED53F162851
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 15:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5A51E2312;
	Fri, 13 Dec 2024 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NH8w91lO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD391DFDB8;
	Fri, 13 Dec 2024 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103345; cv=fail; b=aVxxgYP99dxgdILGuzRedCuM/mBxRnNC3OzJH2QN1fHrNWC3+eXkWL1mE0p6H8WeHdrOhG+EmJBGproERBsUFnBVedgem5TBTIwbQrv88E4YnU/SygckVHDDdV+uzVzRECLH0FRru1U8dC9qb8uoZKmrNvXx9MuvIzesfY+sccs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103345; c=relaxed/simple;
	bh=iptci/CjSghrufUB/NjIyi5ygasz+6Gh5eCDSW+W8pg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aIy/5NfBw6fzj3E09JwXImeugpodx8j7M+6cWkdbktH1YQeJ/ucwkO3frUdALZuIU5LU0aQ+jnLGggjvAxGDgykAwEmd8LTCPcXlQnYDPYhruSYydZDJKjDHN6RwpEL7GQdK/4A3CmRzyzL7OHB37qQILMjV7/1oPd6K45vkjYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NH8w91lO; arc=fail smtp.client-ip=40.107.100.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iee8UG6Mredo82NSBCCd0ifh2qOtmZdvL5KWzP7IbjFQfvQF844cqHRzXQ8k6YbPIt/TMRtmglSWHWi4WujqewOUrPBpvfJtV5SBW/udUdysCQZ3t6/umqo4Kecr4G4lTwHxi1QEwkTJrPLkowTfeFVrbUVqmSCz3IMyHAsvahOuFmS6zErOMp9swpQ0J0EsGUttBDZDElNOxEtRrMgsPVvz3Mwy3JGsLBS6Oh2mUBwWJ6eZz6fg6WrPvgENbR/dwQV0IWJuv6b3R8gK6EjbOgCr509ydtNlXm3pVAbdwFEPpL4ol69zxz3LZP+U2CYBINw0i2aca+F+wsbuGEyEbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSZN1AAuiS+MLqT4fdgugjtKwM8e7vSCxQ+r4Jqok60=;
 b=M50N/omYzRcUseVTS186F/A6hhbU7q96HlwzMRv77Ha9DOYmeD24CsOFrrQckEo8VlduiM79cf3GD5enNcfVm2Pf+OeuaQDm+LDP8bdluncTNeuSZwxGNhYzpa/Qu0JtQVxMK5X1H0J5tuAWVbYFzMApIh/eYqtaVYx3oqprjR3mCr+cWCu7igU42vPVRK0/gnyJRkzkTxDJIx2F7CB51E9dGmIk3wpDPLwVxYB42UZB4A7GOar8iH5Ex0pDYeUAH6fnO10NQ+FjIeNzzK2v8sKZt3pWs7OisPTAgRF6yLB44HmEEgjtLOpyw2CTb/DABpH37K6wUKgGDu4GOMnM7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSZN1AAuiS+MLqT4fdgugjtKwM8e7vSCxQ+r4Jqok60=;
 b=NH8w91lOUJq0WadXwvOeKALQ2fQHhL5bAkX981CI43J/5MeqbGUVdehUIACtpjpt3uxbHTC3ChmfoDpPqa7/YLWVWYsVl8omvMMX8b+VM+bQaAG5IVnZX9Vo/tEKVpsqx1SDGffIXXb2Gh/8WjfMlawzV2J4dSG3nlRp6c4RHio=
Received: from DS7PR07CA0016.namprd07.prod.outlook.com (2603:10b6:5:3af::18)
 by CH3PR12MB8546.namprd12.prod.outlook.com (2603:10b6:610:15f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 15:22:19 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::7a) by DS7PR07CA0016.outlook.office365.com
 (2603:10b6:5:3af::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Fri,
 13 Dec 2024 15:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 15:22:18 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 09:22:16 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <yazen.ghannam@amd.com>, <x86@kernel.org>, <tony.luck@intel.com>,
	<mario.limonciello@amd.com>, <bhelgaas@google.com>, <jdelvare@suse.com>,
	<linux@roeck-us.net>, <clemens@ladisch.de>, <Shyam-sundar.S-k@amd.com>,
	<hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<naveenkrishna.chatradhi@amd.com>, <suma.hegde@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>
Subject: [PATCH v2.2] x86/amd_node, platform/x86/amd/hsmp: Have HSMP use SMN through AMD_NODE
Date: Fri, 13 Dec 2024 15:22:06 +0000
Message-ID: <20241213152206.385573-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212172711.1944927-1-yazen.ghannam@amd.com>
References:
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|CH3PR12MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: 522e17c1-b406-419e-1374-08dd1b89eea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?reOALwbqhQ3aXG78/RCcO3xkJpjNVoCgMu9S/sXYNdOhCQv16pxjNKVeoSP0?=
 =?us-ascii?Q?OeJCNlCw2XkYeAOiS+k3TmuaXLcSsIc1e39poral+iJb5a3s+TyuyY5tWZu4?=
 =?us-ascii?Q?s6W5/JV3TNTEsDcv3mkkStfCzZNWPVHNTqhUFWchy18IZzM3rJaRjh66X+mf?=
 =?us-ascii?Q?bn+TjWHTY5nxJAk3N1l61+/T3FpdtxLJpoNV+gWKCg2t/sgrLNDDNNdOZf0a?=
 =?us-ascii?Q?jDDxByG+kly9VIgqWi5On/onzyU6wk8NU8dY4vla50MIGbakyWPY7b4ZUiOk?=
 =?us-ascii?Q?uQKZweGUYmMMGyD6ykhE6CBN4VD5bISnNvxXi3pxbWcDUrV7ZO6XP6i0hkxV?=
 =?us-ascii?Q?Ohi5d96F15/Ktcsjs++7MJll+2ROleiwLR/UilORXVlMy4trh5HIa3LzgOQy?=
 =?us-ascii?Q?R7an4DOsZ5T7usJjcAroxDfafogDoXdxkTgvnIZaaTrJSfP87NpTABdLtAC2?=
 =?us-ascii?Q?K3sPLmQaJmIHFFTjMWwaXYBEIHrksG7yw+GdJr31L+q7Tmtkd7gqT64FvAr9?=
 =?us-ascii?Q?8wa0rWiu7Nlw4Ltmw0gsQAUpyW4WVuJJCLMOwEeuSyczjVhWvAskogSdz+D3?=
 =?us-ascii?Q?AQbWWegW8O2FoK/dgeLrVZfk7P7CjqP0SudJz5K8XVBNnzpwOSQ+POT55MGx?=
 =?us-ascii?Q?7ONQx4WmaQDguy3hpQ4Z913W4tUGIr8k0zqUBeaLg2pKx2iIcOIXwh1CHpny?=
 =?us-ascii?Q?cQQE1e4MBn0nXHN0J2FusbArZ5gNqkq6SbYvZLUN6+n3htruPEZCsXtSjSet?=
 =?us-ascii?Q?KmQpN/GPj7hfXmVoSSTTqMBOad4I/v5mzUIXVQeoR2TWV5l64/NMBbi7vMw8?=
 =?us-ascii?Q?hwUdmDl5QO1+M9appn036d4PSE92+zMGoJQ3/rL/hn8PiLAoVNsBtnbfU2fA?=
 =?us-ascii?Q?fc9HJrj9YPppKZAaDD/HUJpEfexmWYXZGwef9snUtOzW66A/jEO6KMkZmMcx?=
 =?us-ascii?Q?OtG88t4XKOlMVxl4jmkae+uUWpUTnoUlMJZ1REMiVq2ddlTgH4Pytucnha0e?=
 =?us-ascii?Q?wt/B9mlrD57fKGM8hoi5kAAjJZZiXgCf/CEVxz+4XD8Cd3wlvnilbgowmHhi?=
 =?us-ascii?Q?Ai+CNDhjkvrS8w5TWU2+s8bdxzs7PVMcXrEBcM64GDlK0mCilP7H2cfoxkf2?=
 =?us-ascii?Q?JMMEDXjcZMrAcyTeZKRBPNT15X1hlbOcgbiiPvaxEC2Ssa/4BwPmMjoguX6v?=
 =?us-ascii?Q?IHlP0f4+uI4zvuhyJVJcSlk55dGyIbrWDOtbAAfGqtA/DUjhRp4fpL1eTCD7?=
 =?us-ascii?Q?AgUAIftDIUsGbDlhex86+e9adQs6jevPDFHrwxRMLfvgB95jmVY7LE8pol9f?=
 =?us-ascii?Q?RrIWxb70hDf4SdtcDbIi/9xcc2eeGHXBUmpDC8UR+1IdUsA1guFnyCy+cUV9?=
 =?us-ascii?Q?YocPheTgONDcNtuyjdL+Csm5gD2WwVukmYpAf2G9jZ4q0kg7WnW4qdGyXhNk?=
 =?us-ascii?Q?jTurHUU4BfDoC82CKqdNmU8IUcreMS/id6+iIbq+EezC2c9Cp9P5OR37e3ye?=
 =?us-ascii?Q?PYVDRoBJrGdODqzbuMiQOqfa1jJvkjcVmsDE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:22:18.3518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 522e17c1-b406-419e-1374-08dd1b89eea3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546

The HSMP interface is just an SMN interface with different offsets.

Define an HSMP wrapper in the SMN code and have the HSMP platform driver
use that rather than a local solution.

Also, remove the "root" member from AMD_NB, since there are no more
users of it.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/20241212172711.1944927-1-yazen.ghannam@amd.com
    
    v2.1-v2.2:
    * Include <linux/build_bug.h> for static_assert()
    
    v2->v2.1:
    * Include static_assert() and comment for sysfs attributes.
    
    v1->v2:
    * Rebase on recent HSMP rework.

 arch/x86/include/asm/amd_nb.h         |  1 -
 arch/x86/include/asm/amd_node.h       |  3 +++
 arch/x86/kernel/amd_nb.c              |  1 -
 arch/x86/kernel/amd_node.c            |  9 +++++++
 drivers/platform/x86/amd/hsmp/Kconfig |  2 +-
 drivers/platform/x86/amd/hsmp/acpi.c  |  7 +++---
 drivers/platform/x86/amd/hsmp/hsmp.c  |  1 -
 drivers/platform/x86/amd/hsmp/hsmp.h  |  3 ---
 drivers/platform/x86/amd/hsmp/plat.c  | 36 +++++++++------------------
 9 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 4c4efb93045e..adfa0854cf2d 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -27,7 +27,6 @@ struct amd_l3_cache {
 };
 
 struct amd_northbridge {
-	struct pci_dev *root;
 	struct pci_dev *misc;
 	struct pci_dev *link;
 	struct amd_l3_cache l3_cache;
diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
index 113ad3e8ee40..5fe9c6537434 100644
--- a/arch/x86/include/asm/amd_node.h
+++ b/arch/x86/include/asm/amd_node.h
@@ -33,4 +33,7 @@ static inline u16 amd_num_nodes(void)
 int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
 int __must_check amd_smn_write(u16 node, u32 address, u32 value);
 
+/* Should only be used by the HSMP driver. */
+int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool write);
+
 #endif /*_ASM_X86_AMD_NODE_H_*/
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 2729e99806ec..3a20312062af 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -73,7 +73,6 @@ static int amd_cache_northbridges(void)
 	amd_northbridges.nb = nb;
 
 	for (i = 0; i < amd_northbridges.num; i++) {
-		node_to_amd_nb(i)->root = amd_node_get_root(i);
 		node_to_amd_nb(i)->misc = amd_node_get_func(i, 3);
 		node_to_amd_nb(i)->link = amd_node_get_func(i, 4);
 	}
diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index d2ec7fd555c5..65045f223c10 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -97,6 +97,9 @@ static DEFINE_MUTEX(smn_mutex);
 #define SMN_INDEX_OFFSET	0x60
 #define SMN_DATA_OFFSET		0x64
 
+#define HSMP_INDEX_OFFSET	0xc4
+#define HSMP_DATA_OFFSET	0xc8
+
 /*
  * SMN accesses may fail in ways that are difficult to detect here in the called
  * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
@@ -179,6 +182,12 @@ int __must_check amd_smn_write(u16 node, u32 address, u32 value)
 }
 EXPORT_SYMBOL_GPL(amd_smn_write);
 
+int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool write)
+{
+	return __amd_smn_rw(HSMP_INDEX_OFFSET, HSMP_DATA_OFFSET, node, address, value, write);
+}
+EXPORT_SYMBOL_GPL(amd_smn_hsmp_rdwr);
+
 static int amd_cache_roots(void)
 {
 	u16 node, num_nodes = amd_num_nodes();
diff --git a/drivers/platform/x86/amd/hsmp/Kconfig b/drivers/platform/x86/amd/hsmp/Kconfig
index 7d10d4462a45..d6f7a62d55b5 100644
--- a/drivers/platform/x86/amd/hsmp/Kconfig
+++ b/drivers/platform/x86/amd/hsmp/Kconfig
@@ -7,7 +7,7 @@ config AMD_HSMP
 	tristate
 
 menu "AMD HSMP Driver"
-	depends on AMD_NB || COMPILE_TEST
+	depends on AMD_NODE || COMPILE_TEST
 
 config AMD_HSMP_ACPI
 	tristate "AMD HSMP ACPI device driver"
diff --git a/drivers/platform/x86/amd/hsmp/acpi.c b/drivers/platform/x86/amd/hsmp/acpi.c
index e981d45e1c12..28565ca78afd 100644
--- a/drivers/platform/x86/amd/hsmp/acpi.c
+++ b/drivers/platform/x86/amd/hsmp/acpi.c
@@ -10,7 +10,6 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <asm/amd_hsmp.h>
-#include <asm/amd_nb.h>
 
 #include <linux/acpi.h>
 #include <linux/device.h>
@@ -24,6 +23,8 @@
 
 #include <uapi/asm-generic/errno-base.h>
 
+#include <asm/amd_node.h>
+
 #include "hsmp.h"
 
 #define DRIVER_NAME		"amd_hsmp"
@@ -321,8 +322,8 @@ static int hsmp_acpi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	if (!hsmp_pdev->is_probed) {
-		hsmp_pdev->num_sockets = amd_nb_num();
-		if (hsmp_pdev->num_sockets == 0 || hsmp_pdev->num_sockets > MAX_AMD_SOCKETS)
+		hsmp_pdev->num_sockets = amd_num_nodes();
+		if (hsmp_pdev->num_sockets == 0 || hsmp_pdev->num_sockets > MAX_AMD_NUM_NODES)
 			return -ENODEV;
 
 		hsmp_pdev->sock = devm_kcalloc(&pdev->dev, hsmp_pdev->num_sockets,
diff --git a/drivers/platform/x86/amd/hsmp/hsmp.c b/drivers/platform/x86/amd/hsmp/hsmp.c
index 227b4ad4a51a..e04c613ad5d6 100644
--- a/drivers/platform/x86/amd/hsmp/hsmp.c
+++ b/drivers/platform/x86/amd/hsmp/hsmp.c
@@ -8,7 +8,6 @@
  */
 
 #include <asm/amd_hsmp.h>
-#include <asm/amd_nb.h>
 
 #include <linux/acpi.h>
 #include <linux/delay.h>
diff --git a/drivers/platform/x86/amd/hsmp/hsmp.h b/drivers/platform/x86/amd/hsmp/hsmp.h
index e852f0a947e4..af8b21f821d6 100644
--- a/drivers/platform/x86/amd/hsmp/hsmp.h
+++ b/drivers/platform/x86/amd/hsmp/hsmp.h
@@ -21,8 +21,6 @@
 
 #define HSMP_ATTR_GRP_NAME_SIZE	10
 
-#define MAX_AMD_SOCKETS 8
-
 #define HSMP_CDEV_NAME		"hsmp_cdev"
 #define HSMP_DEVNODE_NAME	"hsmp"
 
@@ -41,7 +39,6 @@ struct hsmp_socket {
 	void __iomem *virt_base_addr;
 	struct semaphore hsmp_sem;
 	char name[HSMP_ATTR_GRP_NAME_SIZE];
-	struct pci_dev *root;
 	struct device *dev;
 	u16 sock_ind;
 	int (*amd_hsmp_rdwr)(struct hsmp_socket *sock, u32 off, u32 *val, bool rw);
diff --git a/drivers/platform/x86/amd/hsmp/plat.c b/drivers/platform/x86/amd/hsmp/plat.c
index a61f815c9f80..9452685a2446 100644
--- a/drivers/platform/x86/amd/hsmp/plat.c
+++ b/drivers/platform/x86/amd/hsmp/plat.c
@@ -10,14 +10,16 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <asm/amd_hsmp.h>
-#include <asm/amd_nb.h>
 
+#include <linux/build_bug.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/sysfs.h>
 
+#include <asm/amd_node.h>
+
 #include "hsmp.h"
 
 #define DRIVER_NAME		"amd_hsmp"
@@ -34,28 +36,12 @@
 #define SMN_HSMP_MSG_RESP	0x0010980
 #define SMN_HSMP_MSG_DATA	0x00109E0
 
-#define HSMP_INDEX_REG		0xc4
-#define HSMP_DATA_REG		0xc8
-
 static struct hsmp_plat_device *hsmp_pdev;
 
 static int amd_hsmp_pci_rdwr(struct hsmp_socket *sock, u32 offset,
 			     u32 *value, bool write)
 {
-	int ret;
-
-	if (!sock->root)
-		return -ENODEV;
-
-	ret = pci_write_config_dword(sock->root, HSMP_INDEX_REG,
-				     sock->mbinfo.base_addr + offset);
-	if (ret)
-		return ret;
-
-	ret = (write ? pci_write_config_dword(sock->root, HSMP_DATA_REG, *value)
-		     : pci_read_config_dword(sock->root, HSMP_DATA_REG, value));
-
-	return ret;
+	return amd_smn_hsmp_rdwr(sock->sock_ind, sock->mbinfo.base_addr + offset, value, write);
 }
 
 static ssize_t hsmp_metric_tbl_plat_read(struct file *filp, struct kobject *kobj,
@@ -95,7 +81,12 @@ static umode_t hsmp_is_sock_attr_visible(struct kobject *kobj,
  * Static array of 8 + 1(for NULL) elements is created below
  * to create sysfs groups for sockets.
  * is_bin_visible function is used to show / hide the necessary groups.
+ *
+ * Validate the maximum number against MAX_AMD_NUM_NODES. If this changes,
+ * then the attributes and groups below must be adjusted.
  */
+static_assert(MAX_AMD_NUM_NODES == 8);
+
 #define HSMP_BIN_ATTR(index, _list)					\
 static struct bin_attribute attr##index = {				\
 	.attr = { .name = HSMP_METRICS_TABLE_NAME, .mode = 0444},	\
@@ -159,10 +150,7 @@ static int init_platform_device(struct device *dev)
 	int ret, i;
 
 	for (i = 0; i < hsmp_pdev->num_sockets; i++) {
-		if (!node_to_amd_nb(i))
-			return -ENODEV;
 		sock = &hsmp_pdev->sock[i];
-		sock->root			= node_to_amd_nb(i)->root;
 		sock->sock_ind			= i;
 		sock->dev			= dev;
 		sock->mbinfo.base_addr		= SMN_HSMP_BASE;
@@ -305,11 +293,11 @@ static int __init hsmp_plt_init(void)
 		return -ENOMEM;
 
 	/*
-	 * amd_nb_num() returns number of SMN/DF interfaces present in the system
+	 * amd_num_nodes() returns number of SMN/DF interfaces present in the system
 	 * if we have N SMN/DF interfaces that ideally means N sockets
 	 */
-	hsmp_pdev->num_sockets = amd_nb_num();
-	if (hsmp_pdev->num_sockets == 0 || hsmp_pdev->num_sockets > MAX_AMD_SOCKETS)
+	hsmp_pdev->num_sockets = amd_num_nodes();
+	if (hsmp_pdev->num_sockets == 0 || hsmp_pdev->num_sockets > MAX_AMD_NUM_NODES)
 		return ret;
 
 	ret = platform_driver_register(&amd_hsmp_driver);
-- 
2.43.0


