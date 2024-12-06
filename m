Return-Path: <linux-pci+bounces-17859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 707319E757A
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 17:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF78416A39A
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 16:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1011D212B25;
	Fri,  6 Dec 2024 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x3canAxr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2D8211481;
	Fri,  6 Dec 2024 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501563; cv=fail; b=mU2tGC+AuTwsUfpbvQvze09LE6eYQ8fyINBWi+WSezzJvpmYC9VWxfqVAD65wjnJhtXx5f4xpgaAhlVesPFNZYD/rvNrBWNxqB59zYuRSe/s0nhMBcjO5jx/Xe9WUAcCPcp//Gvc1hC3skfqCz8a4ZQcejVMoN0vL5Jh6uICds4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501563; c=relaxed/simple;
	bh=SkZ2W5WDeN3bTVJJBbvSdbRxZfppKq4LZDEG1/8SZT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBHwFNoTJBxh0GJqLZ8WMZManwxyx8vFG3trA6YAJH+p0P7wZ2E2Wqn/WmW2csDlGNVdvttamZ3brNw26iyXwIilnczk+8+CQ9N0/lQN/OWkI8nvHLMG1US6wnatgCywVB8yZzynzk5C3omXPsvcZKId2yzaFv/xoBeCAUBYbMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x3canAxr; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AD7yIZRCzpddHnf3t2L0o1eNInu8A+GkGr9XxjZvbTiu2mG4TkRXZ2cMRb2L7HKaZh1NiaFYdnZrO0qrMxa93cTHw5yM6Ii+gx538FJQKZjPwxE5MhkAzlJijMLsLvnoW8lbxy4x+Ip5jSG0OBTDMRllLzYzU477et5TdoFU9ioWiJP96Tp+eE0zhFxrBY750k/dMdeth6G5nHy+aTXHFynAlk7J9AydeYgvIAvs/lPrEMJTGMg5xuIwZS5ofqO61hFCWLi7L2NhWTLY/eLmpQtIu5wtLENRpaqgxvjYTjNvDAUssO1yNPlTKwwaLl9UMQACvS9CXFheJO21VN9g8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGHpQQGP+YVhKbtouiCvmg/ZjtQ7prAcbUk2Lpl+z7E=;
 b=zQODgA6oA81A922h/xfk4XDvV5gQPcVpydCd+IjeNKlv2AIBu+0B2RxXxkyYsI7PjZl5288NTiYCTA/xugYHkNRHd49oFa193p/FrPTY6qk4C6JFtlZtV33YEFQUtGrO3y5S2TUnfWjNQGITiID9xUVSgpnWG9WmVU7IGh+yCTWUKsFTga5jfwyWb5IAL3ZJUJLIFvNWD20PGkgyzAeIzB7yCIhf5lI3SLwASMe8i6breoYgOpRVEWvqcLPHS6+bf/DT9dT1sZjoObNL5z0K3S9HJhiGhqTOk8SsBC/IuL5JDSF/YmHi9/pyr+9B/X9COi52Btm2vRrVauVusWEj8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGHpQQGP+YVhKbtouiCvmg/ZjtQ7prAcbUk2Lpl+z7E=;
 b=x3canAxrRFFASdepxxnvFT0DiaDQ3HYJEOv6PVuRGeuRn3v7ibPZhRCeHAuO2bnnaVI8fkd5aMTb4bWIr33GksVEtSEVnnfwpVE9AX+AV/U5yyrBYLd3PsDZZd6ezLY9X+CSXFa0GwiMUIynoT64bqE9QfWMuu9i5J0wQxVJRfw=
Received: from DS7PR03CA0246.namprd03.prod.outlook.com (2603:10b6:5:3b3::11)
 by SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 16:12:37 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::d5) by DS7PR03CA0246.outlook.office365.com
 (2603:10b6:5:3b3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Fri,
 6 Dec 2024 16:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 16:12:36 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 10:12:35 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <yazen.ghannam@amd.com>, <x86@kernel.org>, Tony Luck
	<tony.luck@intel.com>, Mario Limonciello <mario.limonciello@amd.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Jean Delvare <jdelvare@suse.com>, "Guenter
 Roeck" <linux@roeck-us.net>, Clemens Ladisch <clemens@ladisch.de>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Naveen
 Krishna Chatradhi" <naveenkrishna.chatradhi@amd.com>, Suma Hegde
	<suma.hegde@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>
Subject: [PATCH v2 14/16] x86/amd_node, platform/x86/amd/hsmp: Have HSMP use SMN through AMD_NODE
Date: Fri, 6 Dec 2024 16:12:07 +0000
Message-ID: <20241206161210.163701-15-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206161210.163701-1-yazen.ghannam@amd.com>
References: <20241206161210.163701-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|SJ0PR12MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc53ed3-3fbb-49be-ee83-08dd1610ccf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kxmBPEvqlFDwdmcp+TwGFoRyrKKN6MqCubf/TXjZF6d3UZ3WQEYHNIzHuvHc?=
 =?us-ascii?Q?klwB4gPlOJrQCUCbVWnENwEGUvwFsGwk/HE61GCjZuzUkzgN8h+nlo93z+ve?=
 =?us-ascii?Q?2nG1uGkl1ErgYia/to96EPvQjzSqNYpwH8VYteiGb/zjxG4QPoxes/Da8fip?=
 =?us-ascii?Q?MQnROcfitc0C78ka8ncFYO3LRxGdCYVNlnSGOA9VCZBz/BdqLQ+dYYUKfykn?=
 =?us-ascii?Q?ZRyZWNyccJ7JjODz4QH1PNChaX6pS0uW5EwRL5qExYGkIc+MbdfBRVuzgLBO?=
 =?us-ascii?Q?Bn04wH/l325AjZdiYIBMtTEAWxC7lWuW7fIXEudYDqkoRQir4tgmbRbrBZBs?=
 =?us-ascii?Q?yCaL8EiyTHSrngpCzOpPlO6qclyOWAVjXlYySF6V2QntJEdzmAlIvPLeKdxz?=
 =?us-ascii?Q?KNaomoB9fLXF6EL1/RxyMQ4au9sCgJwTOvZHP/3fV7kqInaDfLPiWQGONRut?=
 =?us-ascii?Q?hWQ0mPQrNYTPzK6Ddw9DTSzqJP34dtjPT3q5mvyYVxLuSjSOcPllQA0CU2re?=
 =?us-ascii?Q?TZwlQOagq0H6j+FdEw6LxJSDzaCgGqkcsACQe08P6LSiWETgJrzTxBQcIwGC?=
 =?us-ascii?Q?CqdRbWNm5PSXAyaeorsLKB2GwwuLPWd7ZvpJoHqC2paEvbjMpvtsR2TYWqpl?=
 =?us-ascii?Q?bBGh1006oGv53ZJeKV6kD6wKVPfoUvhmbJOzc4503JNzyQd9oKmeyY/CBIk3?=
 =?us-ascii?Q?cIw5eqY7XpAM7pWLALguTG5WSstA3ZC/Y/QBtVaKXxr+mi4EKpe7GchXwJ/U?=
 =?us-ascii?Q?sqId4seOOjAfAXo1ITg4ET/egMUROxPBRbakJRteC4mHn01ERH8MxYt5qxfb?=
 =?us-ascii?Q?zwb+iO79bZnskMOxh7BOZObTaaRWIUKMYvYmOK/p+Apa2eXrDIUei0QIFYOX?=
 =?us-ascii?Q?gehigXa5P1Ev47cD4kTuoQTyHoiFILwOyDsKUN2TxCcFkk6PbeircQil0gNv?=
 =?us-ascii?Q?OlwUDi2m9TkRKGY76OX0w4Zrx/TU3rPzwKkig4VhPMHDENFpCzhsOlCc0BCI?=
 =?us-ascii?Q?+0LyxXgopSJ8unpVawTflkheKoLGDgqmDPV2EpKcvAqrrpTUIeGVnRNnIIEg?=
 =?us-ascii?Q?/UbDOjgnzDsHw4SD8KAe3U2TBFVzl1I4XovRhNlrqSHrfcO9aIZuh6n7PQhc?=
 =?us-ascii?Q?4+DRr3NQ/UB2pCFFjjQ0F78tlyotu/IjVLZdiTUARqfCgu9C2Noy7D/yORJa?=
 =?us-ascii?Q?3wMoArJIyjRQdUHCFELu7DfmKFANLFA7o6FDWuOMdQOCHQejHHBdQxrl78cG?=
 =?us-ascii?Q?yy3OzoM5xzi3MpIk/unE3OWEV508Xph4qemVBOUvps8Tk/cIML20LnjL5dhV?=
 =?us-ascii?Q?987e3mZD0VYjD/22Qd+erf/b3Oir3dqx1GKfFJ+0lhgn0jf4WHcHTHoJZq6O?=
 =?us-ascii?Q?Kwg5NsePejsAYTCN8EVA50LD6lcvQowIoWuRbJpMkZ79wEz7imqEtHsL8azy?=
 =?us-ascii?Q?v193MMCyVFl6b9RlkXIl1+aE00s91Kn+qnkaASRevqCASpk+ab8wFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:12:36.9341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc53ed3-3fbb-49be-ee83-08dd1610ccf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7473

The HSMP interface is just an SMN interface with different offsets.

Define an HSMP wrapper in the SMN code and have the HSMP platform driver
use that rather than a local solution.

Also, remove the "root" member from AMD_NB, since there are no more
users of it.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/20241023172150.659002-15-yazen.ghannam@amd.com
    
    v1->v2:
    * Rebase on recent HSMP rework.

 arch/x86/include/asm/amd_nb.h         |  1 -
 arch/x86/include/asm/amd_node.h       |  3 +++
 arch/x86/kernel/amd_nb.c              |  1 -
 arch/x86/kernel/amd_node.c            |  9 ++++++++
 drivers/platform/x86/amd/hsmp/Kconfig |  2 +-
 drivers/platform/x86/amd/hsmp/acpi.c  |  7 ++++---
 drivers/platform/x86/amd/hsmp/hsmp.c  |  1 -
 drivers/platform/x86/amd/hsmp/hsmp.h  |  3 ---
 drivers/platform/x86/amd/hsmp/plat.c  | 30 ++++++---------------------
 9 files changed, 23 insertions(+), 34 deletions(-)

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
index a61f815c9f80..42bd4553bffd 100644
--- a/drivers/platform/x86/amd/hsmp/plat.c
+++ b/drivers/platform/x86/amd/hsmp/plat.c
@@ -10,7 +10,6 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <asm/amd_hsmp.h>
-#include <asm/amd_nb.h>
 
 #include <linux/device.h>
 #include <linux/module.h>
@@ -18,6 +17,8 @@
 #include <linux/platform_device.h>
 #include <linux/sysfs.h>
 
+#include <asm/amd_node.h>
+
 #include "hsmp.h"
 
 #define DRIVER_NAME		"amd_hsmp"
@@ -34,28 +35,12 @@
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
@@ -159,10 +144,7 @@ static int init_platform_device(struct device *dev)
 	int ret, i;
 
 	for (i = 0; i < hsmp_pdev->num_sockets; i++) {
-		if (!node_to_amd_nb(i))
-			return -ENODEV;
 		sock = &hsmp_pdev->sock[i];
-		sock->root			= node_to_amd_nb(i)->root;
 		sock->sock_ind			= i;
 		sock->dev			= dev;
 		sock->mbinfo.base_addr		= SMN_HSMP_BASE;
@@ -305,11 +287,11 @@ static int __init hsmp_plt_init(void)
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


