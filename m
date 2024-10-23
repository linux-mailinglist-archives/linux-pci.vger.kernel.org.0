Return-Path: <linux-pci+bounces-15132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B78F9AD283
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 19:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0AB1F221C9
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 17:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80921D1728;
	Wed, 23 Oct 2024 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cRzf9rZv"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35301D0947;
	Wed, 23 Oct 2024 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704134; cv=fail; b=iNjHeGMqjJYBn6zYF+Cn80OVauowTluwf3ZXNpECHt4rXE38B6UByXYD/LrtSfzsCKfmQmBRxudPVHzibxA1rdAMAzDfuVvniUUO0S7p2eXjZ7iUC7TU9mf4DEnW//VXw7A/Raik5r110rXjWjOUXt1j2XF6FsIF3AUorLLQs0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704134; c=relaxed/simple;
	bh=hpDPDgu9b7KzW3ad4OxPhxZpVar8N6JLSmrG3B1VCdE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2rGljVnDvMatsa5aiZTt4CTYxfZepnGVymi0zsmyh3hdx/Kkun638k1lbuyY2DJXZS4uZiqTLOOZYjnfk6pSGLPPRMBS0iWxU9NgQaGAMmf3Kqpexdpx9tIFxp9VKzShzVcCXAlhXsi4HgB3rsyoufrog8X3LUbAM/YIaIzcrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cRzf9rZv; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7/XEoYo5XI480+LG4pDSH06rDL0GRu4/P0XqorMzTkFr3hDt2+Dq4C6vapPaoo8F80v85hm7Ad1coqT8SO+/jteh+e79J4p4q3gpIYYXAbnnhXAnNZYIMt5rmbg/JFmszRIH85bphM/On42CfrDoGRl9UqbYk7YOKj2A4fQinG2Z5R/xpZf7btq6cLBXrJ0wC5weGf/nUVCHlLdMDzd1qPJYENpfDfch4+txPnLf2uJwW5N/7V90VkjFMLctgkK7IK3BVd1OE36VN+DQxhcbqFiJzf59gITETJFc6/xObfIZRcpnRsbvEGkqU+au9qGk50mNY1T+BHicftLnL0uLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmTOxNtRMJDkbDg7YUqqtG5FptOyVaMKfbRTiBA/tyw=;
 b=lRvNQg3nY+CNVdCbHzr4XhhpseaKArUtow/V0ZNMNRiEvgjDxIFjMWHJQh59p0ITgUkMVW70yrXsQffroPWqx8dQGVZVM2uKsxvyqW101/MxVOaz5+JTrfS480MzzQQHqaXMz9M+7EtmhopNwlnTqptq5+HLdBo6b1Tke6jjWDJzIEVgq2M1EXCO6J1anVjn5KoePwZNopFuiflcDWKENBHKVGlgT8KGrgSznFwLchGs7c4lpYE9cL7SeHFs8SqYRgivaZvFrtxLpEGGIU1amG2zU+1nJEkRg80IsBgTr20l4nrNQakjkeoYNCPnp3PViMaJSzSLH8pNibt/8CwbnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmTOxNtRMJDkbDg7YUqqtG5FptOyVaMKfbRTiBA/tyw=;
 b=cRzf9rZvofcyVYcY2ULyz3OJg8EEiQ26HLypXDZ8fN1aYedilAGEW1GMPnRTz7NvRCvBE52uINgGzqbobuIcDdw49evT38DInhby/xePQ5cChgac1FuNd5ZTE1Dhgw0rv1X7anQIMp0bZd6W4t7JLokQxSs0H2Y3HYpP1MpEHYk=
Received: from BN0PR08CA0008.namprd08.prod.outlook.com (2603:10b6:408:142::30)
 by CYYPR12MB8704.namprd12.prod.outlook.com (2603:10b6:930:c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 17:22:08 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::f2) by BN0PR08CA0008.outlook.office365.com
 (2603:10b6:408:142::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 17:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:22:07 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:22:06 -0500
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
Subject: [PATCH 04/16] x86: Start moving AMD Node functionality out of AMD_NB
Date: Wed, 23 Oct 2024 17:21:38 +0000
Message-ID: <20241023172150.659002-5-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|CYYPR12MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: c915e917-95d5-44fe-bf77-08dcf38738a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XaUyYgEpz9ZHWpHq3qCwkLk8QkrcSl1PaYCtpVX/8MVpaEA/lnmyGMtvhC5X?=
 =?us-ascii?Q?FIb4KUljBwrr1yBI3l7okvNMcj2qc4XnAt8emDOlU/ldvlAWvdbidjq+Ljbt?=
 =?us-ascii?Q?0AQDekEpU2UH8oy27muUSibmYwt0FkQALrEQWlmat3WWmGCzLxQL8KpNLXI5?=
 =?us-ascii?Q?2U0Sq0uop7akrZ19vsiKjCXeJh03SacaOZbVyF7IWXJ+VeQpVfmh2WmiIPBX?=
 =?us-ascii?Q?FeVbr+zqwTmTGADIZnBl4rQ1DPzBW62uU8YdHu+lu4ISo1/2wr0YWwzBw3an?=
 =?us-ascii?Q?Q5F8wbtgkbkp1wOJNeFj63tSszvErjMa2I39MtT5jO87Y0m/lPVPnp/DJdtl?=
 =?us-ascii?Q?8XYOe75Q19QikE032GSoLyYzkf2BheFgRGiQwTM6m00R8p6gWNlfYPQIz/72?=
 =?us-ascii?Q?h7piKN+U14FA0hGzjZcMZ7jEAnzfiPb2lzuC2KRVDA7Bvjtvc2127pPooleF?=
 =?us-ascii?Q?mBKXzDFwB8aq/TahY18y845wHJRrnYDBM/sGSpIkVGLUCNFJ6ueGbrOO6Lt3?=
 =?us-ascii?Q?NSwC1IjFd4UdwGEOtAYcUrMSUTAk9w9i1MvJiQKmuLdylkWQBIEwagh87fAs?=
 =?us-ascii?Q?qgxQQW35O9rDszWj7YqNpwE0e/8z+VZl9k+Q1vuNV4pAgchOArY/K5o6Xhy3?=
 =?us-ascii?Q?B4E+L9fSWdnj7eJB0of8Gabm1Wx8MzmyBkF+CUCfb8icpinAQUaq66b6Z4sY?=
 =?us-ascii?Q?SbDjaDY9zMMTxofqADTmKTn3kBuyUnPBc6AMgcnSuKzwQdOSvzUtqd9qLwYO?=
 =?us-ascii?Q?ZYyX2HAsGdrwt+NQMBDGIpwjr2F2hLvg10ymdyY9Xpo2HCZQNPQwkhuVIBEY?=
 =?us-ascii?Q?vi2BHsadeJeNhO9TcmXkWXSOL1crzjZGQAbnLotxX05voPUwlkYfNKIy9/sV?=
 =?us-ascii?Q?7Th7JHUOrRvv2B6eSuvOxitpoGZLEDzmrXaerYfaVPIB7lBaLfmO3z1BAKpc?=
 =?us-ascii?Q?0Jzcwv90k/lnaxK+KWQNot7mWVRy/zsFY2k6jKrwNrIlx1cG2jMQMUA42l+W?=
 =?us-ascii?Q?DwsC4mnHbN5CftYoTMorBwamTmlgBRSHr1Mh8pfthH0VJrD4bdKz+O0UjIDE?=
 =?us-ascii?Q?KaQ/p5l+L2w7oIcKjaE/mhNahRKrUHytbiMTRRx7NYmnG2pE48UZxF4KWua7?=
 =?us-ascii?Q?u83G5NK7bQJE01SFnpHz4OPp/5DKbL0V8Hm7787JceLABaKqzMx2UVfRlCaE?=
 =?us-ascii?Q?DpY3Qxe3zH4s6B901Rfe9GtTF3oKjwGsqvULdVBeXWSOYrW602Sboa/qYHHs?=
 =?us-ascii?Q?xTcdTUPBaAlrOdDeWubXDpSQMaaGxEZ8w5aYJEzFU69N1Ab4o7eZMJSJTcRw?=
 =?us-ascii?Q?cfYuRs8idk0iwiDQ+y0AAukwnJxf4KnR/YtNKAX6rrYDF9PIGG6Ilux3J/wx?=
 =?us-ascii?Q?63IWLP6xi/u+Sbo2cFV7xx5CwXSqazXfqvWzxy8kWds2VtvB8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:22:07.5285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c915e917-95d5-44fe-bf77-08dcf38738a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8704

The "AMD Node" concept spans many families of systems and applies to a
number of subsystems and drivers.

Currently, the AMD Northbridge code is overloaded with AMD node
functionality. However, the node concept is broader than just
northbridges.

Start files to host common AMD node functions and definitions.
Include a helper to find an AMD node device function based on the
convention described in AMD documentation.

Anything that needs node functionality should include this rather than
amd_nb.h. The AMD_NB code will be reduced to only northbridge-specific
code needed for legacy systems.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 MAINTAINERS                     |  7 +++++++
 arch/x86/Kconfig                |  4 ++++
 arch/x86/include/asm/amd_node.h | 27 ++++++++++++++++++++++++++
 arch/x86/kernel/Makefile        |  1 +
 arch/x86/kernel/amd_node.c      | 34 +++++++++++++++++++++++++++++++++
 5 files changed, 73 insertions(+)
 create mode 100644 arch/x86/include/asm/amd_node.h
 create mode 100644 arch/x86/kernel/amd_node.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cf02cbf4bef1..9ca246aef7ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1106,6 +1106,13 @@ L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-amd-mp2*
 
+AMD NODE DRIVER
+M:	Yazen Ghannam <yazen.ghannam@amd.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	arch/x86/include/asm/amd_node.h
+F:	arch/x86/kernel/amd_node.c
+
 AMD PDS CORE DRIVER
 M:	Shannon Nelson <shannon.nelson@amd.com>
 M:	Brett Creeley <brett.creeley@amd.com>
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c6f917b762c0..ba5252d8e21c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -3121,6 +3121,10 @@ config TS5500
 endif # X86_32
 
 config AMD_NB
+	def_bool y
+	depends on AMD_NODE
+
+config AMD_NODE
 	def_bool y
 	depends on CPU_SUP_AMD && PCI
 
diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
new file mode 100644
index 000000000000..622bd3038eeb
--- /dev/null
+++ b/arch/x86/include/asm/amd_node.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD Node helper functions and common defines
+ *
+ * Copyright (c) 2024, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
+ *
+ * Note:
+ * Items in this file may only be used in a single place.
+ * However, it's prudent to keep all AMD Node functionality
+ * in a unified place rather than spreading throughout the
+ * kernel.
+ */
+
+#ifndef _ASM_X86_AMD_NODE_H_
+#define _ASM_X86_AMD_NODE_H_
+
+#include <linux/pci.h>
+
+#define MAX_AMD_NUM_NODES	8
+#define AMD_NODE0_PCI_SLOT	0x18
+
+struct pci_dev *amd_node_get_func(u16 node, u8 func);
+
+#endif /*_ASM_X86_AMD_NODE_H_*/
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index f7918980667a..b43eb7e384eb 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -119,6 +119,7 @@ obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
 
 obj-$(CONFIG_AMD_NB)		+= amd_nb.o
+obj-$(CONFIG_AMD_NODE)		+= amd_node.o
 obj-$(CONFIG_DEBUG_NMI_SELFTEST) += nmi_selftest.o
 
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvmclock.o
diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
new file mode 100644
index 000000000000..e825cd4426b9
--- /dev/null
+++ b/arch/x86/kernel/amd_node.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Node helper functions and common defines
+ *
+ * Copyright (c) 2024, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
+ */
+
+#include <asm/amd_node.h>
+
+/*
+ * AMD Nodes are a physical collection of I/O devices within an SoC. There can be one
+ * or more nodes per package.
+ *
+ * The nodes are software-visible through PCI config space. All nodes are enumerated
+ * on segment 0 bus 0. The device (slot) numbers range from 0x18 to 0x1F (maximum 8
+ * nodes) with 0x18 corresponding to node 0, 0x19 to node 1, etc. Each node can be a
+ * multi-function device.
+ *
+ * On legacy systems, these node devices represent integrated Northbridge functionality.
+ * On Zen-based systems, these node devices represent Data Fabric functionality.
+ *
+ * See "Configuration Space Accesses" section in BKDGs or
+ * "Processor x86 Core" -> "Configuration Space" section in PPRs.
+ */
+struct pci_dev *amd_node_get_func(u16 node, u8 func)
+{
+	if (node >= MAX_AMD_NUM_NODES)
+		return NULL;
+
+	return pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(AMD_NODE0_PCI_SLOT + node, func));
+}
-- 
2.43.0


