Return-Path: <linux-pci+bounces-15142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA249AD2B8
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 19:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584B72833FF
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 17:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C3C1FF04C;
	Wed, 23 Oct 2024 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="enX2rlyK"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885221FF030;
	Wed, 23 Oct 2024 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704151; cv=fail; b=RkGtwY1Tb6veLzqFnZY0mah1dD8FxX+jimvM/sGbo6JI3yCD8UbsGCjDtASwUFeFbUmRWQfGI7T0Gg6zxGxiVkCJlyy993llhFTCqVTXBYNfkQq+4CewMyPq2jf7/LQ8nCw/0WC80be2PSVkLzfH6nXsnThvORhT/JggQMGLA7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704151; c=relaxed/simple;
	bh=pDbVg7HJqmlgMsp6/CwOo8NNPuaxwI87QX7YKMHrxOU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHIfQRl2SyJj4pg71GtT7I95/RPHEyklP2XOoGZg9ZQmue09nRjpYr85kKQ7w5kqWutbeVwy2Sse5pffrOIq47Nsj49jYr8FweURdOOfDFbl4IXHKkcgh9E2IbN40KBHpcrEUDisPGSeU+eF35MdnsXk4SBAyxPHC5v1UXF4Zms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=enX2rlyK; arc=fail smtp.client-ip=40.107.100.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4GIHuLG9nMlJPyxG6tju6NUS39x1K4xWwvyf0OH7yYOHhpFfNtTjJGziecMgZvkY+GZklSrZ8t11AOIjaoEcy3G3QyVGYC6HSYW475XeZT8v2qjCQ/3eq9zS7XlR2LUHUIj9yIim5NjxYtn9k3QjhqDmu4n/PPbFL5iDkz8wOoteaMgHSD0UKmuaP6Sf5U/9a264F6py00TORxA4WsxYwpz5GdVm3M3cpSKtuKxxpvrZEyiGPIMF27P0a2P8qadlcGylDTcKxLdu0sMKvaVZMG/NchozwNh8vDZlWrqU5Vpo3cfqLq+u3PKcZXrQCo2uuxbH0uT+R/MPo9LrKO3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZYriPdP1FtI13+3BGXDssloX6NanJfQwcT4c3Jh6b8=;
 b=xMJjcE6wv3qZaDMvLAMlPuJqj67Xlo5H9YSCLbJ1b2WqO42ZJU9pduzSfoNOJGa4Kaph3Q/WxXwsBfgcidjGUCP+qMhnS0FiyCtle5B1sLGufJjetwvauilyEmZFTBejZQCGFbHO2XJKUIqL39hkJ7zrYdGNYxwcEEGimHvjTW1BNb3ZRA8iE/ws3DgKHhFPXXXDG7lIfna+mb0HS1UwFyiBkrjc82JK3rdS9jGRHF7bFDDhCRYEIDCSZA83rSp9NnkJ4HpL4v4StksP5wPBX65vPcjpkKX6V8jVEbLSTw4FQSgICoNnpScEawqs7LdgX5EgzRg1mdovh4gSBPf2Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZYriPdP1FtI13+3BGXDssloX6NanJfQwcT4c3Jh6b8=;
 b=enX2rlyKqu1zNG1QqQuKrMnNrIb6wHe22jWRzth5+FGubHxmHK3lwwfCczNqsCWD4CJ7FbIYMQQMtugVijJ412KLU8V8qN53ON+l+XPekBXfIwL9leBxnRdDV3yhOkEs8poHi8B81Ant1h4vv/S3DUh7YSY7HJ36GC/7UxGVzfA=
Received: from MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18) by
 PH8PR12MB8429.namprd12.prod.outlook.com (2603:10b6:510:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 17:22:23 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::2d) by MN2PR01CA0049.outlook.office365.com
 (2603:10b6:208:23f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19 via Frontend
 Transport; Wed, 23 Oct 2024 17:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:22:19 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:22:15 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, <mario.limonciello@amd.com>,
	<bhelgaas@google.com>, <Shyam-sundar.S-k@amd.com>, <richard.gong@amd.com>,
	<jdelvare@suse.com>, <linux@roeck-us.net>, <clemens@ladisch.de>,
	<hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>, <naveenkrishna.chatradhi@amd.com>,
	<carlos.bilbao.osdev@gmail.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 14/16] x86/amd_smn, platform/x86/amd/hsmp: Have HSMP use SMN
Date: Wed, 23 Oct 2024 17:21:48 +0000
Message-ID: <20241023172150.659002-15-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023172150.659002-1-yazen.ghannam@amd.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|PH8PR12MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d798d64-b4e9-4f99-d6db-08dcf3873fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2MEK5KgRKuZGxnxpkYZZnZM7vTzT17BsLisQGAECDr612sJuj6EWAr4G80Ay?=
 =?us-ascii?Q?funiEqCXMM3XhGszZLOe1nDu4tANBUjravbqvqhbNd3qAvt2/tH3kHdHUXPs?=
 =?us-ascii?Q?z612khOu9m1J+zSYPObBkMNa6bFglJ63jpSwQ3w9ximgOUrMXmzvVHIAsj1X?=
 =?us-ascii?Q?KMWO/8LVRFMnSg+6UGLyWyMqHBzVjPyo1ZxkGHgZWC2jbkhHm6BO578u1pRv?=
 =?us-ascii?Q?jY6ZfIdkhKh52j79/bi4jtc6H/v0Wv04E/bRjLBb+HQVgYxTwNwWNUk09H9w?=
 =?us-ascii?Q?pRGMfs83AbVdUCkaoay7wcj1qb6TA8URq/R4KbJ5qeY5F8DhFGvLZyvGJybg?=
 =?us-ascii?Q?0KgubBHWbV1xIbLlDPfHNDapdKpeNSbh6f+KgfSESRkJQLFLRHp49nfxh5j5?=
 =?us-ascii?Q?XfxWCLYI4ANOCWtWNFeGweGewZhqRdUyGIFByceJIOcsJ0HPQHOhdy5GfK4u?=
 =?us-ascii?Q?FZDE/XLkvMgoXi6yB8wyCmebUC0eb/A+OymgZNYO7cuO0uawuV5DdA4MrZzt?=
 =?us-ascii?Q?Jr+/tO3719nKzC2dkJCK3POthRyLPgKZlrOPxGSR1Tm3Z4gsJNpmAUFC3Hil?=
 =?us-ascii?Q?E2cQax/IeBBw5CMz9j0Y+tBWHE9xByhKiH4nQ2WkJMe2i7FLEiXR/eoh7//4?=
 =?us-ascii?Q?wfWi4wNSHLInJ3b/at7Q4ZjKWaC4AVpy83dC9YGUlFllOAvcxfmMeQjKm+Yx?=
 =?us-ascii?Q?mDpxWj5cbGgpHpdk53s3fmKKEDueytHNFrBpRGbiZh8ZMY5/CquHpr/wejba?=
 =?us-ascii?Q?GIOI22OA6sdq/WWverjmtAzC7lbu4Hlu0aD9OyLVoyepjL0fPZHoprh+7cRM?=
 =?us-ascii?Q?ezF2tbCI/qSn7MqyhjHSgZSpHnf2XMXsvM7V2r15vKr+kUraTgVrG1sBjgVj?=
 =?us-ascii?Q?OJoOJ19DC29nRSonHRquGmpSlaeOVWqIaufl2glv8ZDU55aHlMhEZiv3uIJU?=
 =?us-ascii?Q?pxR0jbyCeLVXltoJSsFp2QZVcM23KdlSp6Com1cFaUYe/5lN16bSQEZBxMXf?=
 =?us-ascii?Q?OaqNgQ/idju0Bg3x15qj6qNdQuTh8pevIE6sNtyDHJiyfMl8bEaXx8niDeSi?=
 =?us-ascii?Q?I0Slw8hP6qtAhBbjgVhZIW+bbAibA9k1QcRV0bGGeSt9a0E0dkgmOAWScPSs?=
 =?us-ascii?Q?WJkI8ZMi/byzNtrefnfNrBk3sFvixb5uCKpF3syYwf94FbHV4GTYwLpLGArG?=
 =?us-ascii?Q?ksEY58x4cfQ6LVexpFxw6SglT2psDyYEZep0TkLj6aG3efGCQ7Ylfpz9uee0?=
 =?us-ascii?Q?p0lQ1oVfRDAsL3cSYWbtLXPNyDgwZpab8ygnFZ8wcsvJpNPQKGL1G4ULeVW3?=
 =?us-ascii?Q?42hwBUCfJkAg9Y+TZCodXj+ddcftr0JZ+3QqtdLk7UCUV0ZUlpqZLUAbjOjw?=
 =?us-ascii?Q?4pa+9WUbiz0FUUsROjgGLcM4jaJmKqwNZBRrj9ob5LrEiCpqaw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:22:19.6886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d798d64-b4e9-4f99-d6db-08dcf3873fe1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8429

The HSMP interface is just an SMN interface with different offsets.

Define an HSMP wrapper in the SMN code and have the HSMP platform driver
use that rather than a local solution.

Also, remove the "root" member from AMD_NB, since there are no more
users of it.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/amd_nb.h    |  1 -
 arch/x86/include/asm/amd_smn.h   |  3 +++
 arch/x86/kernel/amd_nb.c         |  1 -
 arch/x86/kernel/amd_smn.c        |  9 +++++++++
 drivers/platform/x86/amd/Kconfig |  2 +-
 drivers/platform/x86/amd/hsmp.c  | 32 +++++---------------------------
 6 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 55c03d3495bc..cbe31e316e39 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -27,7 +27,6 @@ struct amd_l3_cache {
 };
 
 struct amd_northbridge {
-	struct pci_dev *root;
 	struct pci_dev *misc;
 	struct pci_dev *link;
 	struct amd_l3_cache l3_cache;
diff --git a/arch/x86/include/asm/amd_smn.h b/arch/x86/include/asm/amd_smn.h
index 6850de69f863..f0eb12859c42 100644
--- a/arch/x86/include/asm/amd_smn.h
+++ b/arch/x86/include/asm/amd_smn.h
@@ -8,4 +8,7 @@
 int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
 int __must_check amd_smn_write(u16 node, u32 address, u32 value);
 
+/* Should only be used by the HSMP driver. */
+int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool write);
+
 #endif /* _ASM_X86_AMD_SMN_H */
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 10cdeddeda02..4c22317a6dfe 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -73,7 +73,6 @@ static int amd_cache_northbridges(void)
 	amd_northbridges.nb = nb;
 
 	for (i = 0; i < amd_northbridges.num; i++) {
-		node_to_amd_nb(i)->root = amd_node_get_root(i);
 		node_to_amd_nb(i)->misc = amd_node_get_func(i, 3);
 		node_to_amd_nb(i)->link = amd_node_get_func(i, 4);
 	}
diff --git a/arch/x86/kernel/amd_smn.c b/arch/x86/kernel/amd_smn.c
index 997fd3edd9c0..527dda8e3a2b 100644
--- a/arch/x86/kernel/amd_smn.c
+++ b/arch/x86/kernel/amd_smn.c
@@ -18,6 +18,9 @@ static DEFINE_MUTEX(smn_mutex);
 #define SMN_INDEX_OFFSET	0x60
 #define SMN_DATA_OFFSET		0x64
 
+#define HSMP_INDEX_OFFSET	0xc4
+#define HSMP_DATA_OFFSET	0xc8
+
 /*
  * SMN accesses may fail in ways that are difficult to detect here in the called
  * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
@@ -100,6 +103,12 @@ int __must_check amd_smn_write(u16 node, u32 address, u32 value)
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
diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
index f88682d36447..e100b315c62b 100644
--- a/drivers/platform/x86/amd/Kconfig
+++ b/drivers/platform/x86/amd/Kconfig
@@ -8,7 +8,7 @@ source "drivers/platform/x86/amd/pmc/Kconfig"
 
 config AMD_HSMP
 	tristate "AMD HSMP Driver"
-	depends on AMD_NB && X86_64 && ACPI
+	depends on AMD_SMN && X86_64 && ACPI
 	help
 	  The driver provides a way for user space tools to monitor and manage
 	  system management functionality on EPYC server CPUs from AMD.
diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/hsmp.c
index 8fcf38eed7f0..544efb0255c0 100644
--- a/drivers/platform/x86/amd/hsmp.c
+++ b/drivers/platform/x86/amd/hsmp.c
@@ -10,7 +10,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <asm/amd_hsmp.h>
-#include <asm/amd_nb.h>
+#include <asm/amd_smn.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/miscdevice.h>
@@ -48,9 +48,6 @@
 #define SMN_HSMP_MSG_RESP	0x0010980
 #define SMN_HSMP_MSG_DATA	0x00109E0
 
-#define HSMP_INDEX_REG		0xc4
-#define HSMP_DATA_REG		0xc8
-
 #define HSMP_CDEV_NAME		"hsmp_cdev"
 #define HSMP_DEVNODE_NAME	"hsmp"
 #define HSMP_METRICS_TABLE_NAME	"metrics_bin"
@@ -62,8 +59,6 @@
 #define MSG_ARGOFF_STR		"MsgArgOffset"
 #define MSG_RESPOFF_STR		"MsgRspOffset"
 
-#define MAX_AMD_SOCKETS 8
-
 struct hsmp_mbaddr_info {
 	u32 base_addr;
 	u32 msg_id_off;
@@ -79,7 +74,6 @@ struct hsmp_socket {
 	void __iomem *virt_base_addr;
 	struct semaphore hsmp_sem;
 	char name[HSMP_ATTR_GRP_NAME_SIZE];
-	struct pci_dev *root;
 	struct device *dev;
 	u16 sock_ind;
 };
@@ -98,20 +92,7 @@ static struct hsmp_plat_device plat_dev;
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
 
 static void amd_hsmp_acpi_rdwr(struct hsmp_socket *sock, u32 offset,
@@ -749,10 +730,7 @@ static int init_platform_device(struct device *dev)
 	int ret, i;
 
 	for (i = 0; i < plat_dev.num_sockets; i++) {
-		if (!node_to_amd_nb(i))
-			return -ENODEV;
 		sock = &plat_dev.sock[i];
-		sock->root			= node_to_amd_nb(i)->root;
 		sock->sock_ind			= i;
 		sock->dev			= dev;
 		sock->mbinfo.base_addr		= SMN_HSMP_BASE;
@@ -946,11 +924,11 @@ static int __init hsmp_plt_init(void)
 	int ret = -ENODEV;
 
 	/*
-	 * amd_nb_num() returns number of SMN/DF interfaces present in the system
+	 * amd_num_nodes() returns number of SMN/DF interfaces present in the system
 	 * if we have N SMN/DF interfaces that ideally means N sockets
 	 */
-	plat_dev.num_sockets = amd_nb_num();
-	if (plat_dev.num_sockets == 0 || plat_dev.num_sockets > MAX_AMD_SOCKETS)
+	plat_dev.num_sockets = amd_num_nodes();
+	if (plat_dev.num_sockets == 0 || plat_dev.num_sockets > MAX_AMD_NUM_NODES)
 		return ret;
 
 	ret = platform_driver_register(&amd_hsmp_driver);
-- 
2.43.0


