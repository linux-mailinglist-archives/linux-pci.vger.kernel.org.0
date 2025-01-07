Return-Path: <linux-pci+bounces-19464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93DBA04C3B
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 23:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5902166444
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 22:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0101E47B6;
	Tue,  7 Jan 2025 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FZwvc1ni"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F551DED46;
	Tue,  7 Jan 2025 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736288949; cv=fail; b=N7f1UEhEHGYzECVvGWFEtrzcMpOoQVUsjpqMW0NqQOpgGO3pojkwisthbSs0VOlygeO2cR23KhinEDxJ+kpyu4OJoR+dEYJiwv4qR5M9ZyAquRGKCWIdFsHNsPx/cRoxxyezEUdOHPgB6SMOan3nxjgTSojzp0I7pAMyggkh5YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736288949; c=relaxed/simple;
	bh=9s34ehf/NZbg011f9HwPGO4IwMgemcHSj5Ai17FwQGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNzfkOVTgizso5oks2OryFT/SvfsmMVu6GZOsO3KedKS+ocse4AGBGU78h0g4e2ZhhTKXSjLw2oyyUQr7rR7RNxo0+6QHLxYRuNpBigUKDF1er874lgtP7gJWlebeJDShdEMK1Seq+2p82qzsdurUnMok7mAjOtHzSZzqYX/OQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FZwvc1ni; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdJvKYfEBzZxBRSfLcvDinT1I+gM9375XAJG9zmGd8oSJw+H4Uk9PkTj5PghVBhc7GFyu93CVjURVC6oIqVHgdQUrIIoUEQHgkJiQ5vBJvrbmzl5IrCsFaHXHGymz6OCqVAsCXriu6PWs/l+L7+3VN6Fg7Pc2L0bu29B/hcmQIadoCKALaIrX9gXfgiXqieyi+Ffa61yDesuPgba40AqDGvbUOPokoLCxfmoJoRb4yKZTiN/DVMSmrk0DtVreGHs5INaxX2VVlI2sVnAAZV2F+vOt9ogXdKiYvczCZEr5q+f+KIMHnnK22eC9bXnoUKakOSSvkFKxVO5FH98GHbkcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gfUd3MSM4jybjFO34fAiZ9CLUysLUU2o02V6Tu7CIE=;
 b=pLhxl+LfO3mlG06vnwxBY0xRpX2gGRagMwCYsdflypEHUNqoC8blaCjaGkw9XStF0OlYkqJc+XWPeWVMjIBfGUihzxQDZAvhfuzqM2QyQDMkSyxbRVuJzY0NphA++NnJnK6mLM0YZterYo+MGFi0TWeMbvRibpnVsFvL3ppZQVTnluPGS+2n+3alqcyhulbEW8u/h2zxmYmFHWIdIp56mRwtRVHEVx6xVkMR26O2uSGDOqiCoJTAzR7t2XeliGZtWfekXJqwm2EMvEnAbCCM1luFdculIb/cjfLO4j42WooeCmRNDsnI1rxjXyuoOddxzBOLZTkA00dyHc3ytZOXUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gfUd3MSM4jybjFO34fAiZ9CLUysLUU2o02V6Tu7CIE=;
 b=FZwvc1niohcvGysvSAly2f78f0P86CbSBkblKjizQwLp58GlyOaD4/VTFqHDmQtBakj3JLSItJX/2B9uKkTiZ0cFhuK2btMpY4IgOM6gNmOU029lBJySoxtGQoA/VN98TB4P05ZPdMLvmF4NMO6sK7LzmLPDlVvRVuu4Qa3aL9w=
Received: from SJ0PR13CA0240.namprd13.prod.outlook.com (2603:10b6:a03:2c1::35)
 by DS7PR12MB6216.namprd12.prod.outlook.com (2603:10b6:8:94::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.10; Tue, 7 Jan 2025 22:29:03 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::20) by SJ0PR13CA0240.outlook.office365.com
 (2603:10b6:a03:2c1::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.7 via Frontend Transport; Tue, 7
 Jan 2025 22:29:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 22:29:03 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 16:29:01 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <yazen.ghannam@amd.com>, <x86@kernel.org>, Tony Luck
	<tony.luck@intel.com>, Mario Limonciello <mario.limonciello@amd.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Jean Delvare <jdelvare@suse.com>, "Guenter
 Roeck" <linux@roeck-us.net>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	"Hans de Goede" <hdegoede@redhat.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Naveen Krishna Chatradhi
	<naveenkrishna.chatradhi@amd.com>, Suma Hegde <suma.hegde@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>
Subject: [PATCH v3 03/12] x86: Start moving AMD node functionality out of AMD_NB
Date: Tue, 7 Jan 2025 22:28:38 +0000
Message-ID: <20250107222847.3300430-4-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107222847.3300430-1-yazen.ghannam@amd.com>
References: <20250107222847.3300430-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|DS7PR12MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: 87218519-31d9-47bf-b18d-08dd2f6ab093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kngyncbXIMJ1CXCPvFl032pDYkvz9cgGpPgg/WFRuv/kClfP5GVGkZuv2YRa?=
 =?us-ascii?Q?dtCsjDWBDT9bd8NO8VltaCx7CxOr/kZhepT4XC4EDI28LuSe0bkW/Jf5raQb?=
 =?us-ascii?Q?dVGe061JsVwPIyLo9iBqh5ATZKI+0uhryYQpk0Z9kUF0iZraH1Re8G8MZJaN?=
 =?us-ascii?Q?X6ZRHF3SLAkPtjucZC04k0XDj9jEqe8CtrnEVGE7MSUh8QdzPLNRFhMpjFTv?=
 =?us-ascii?Q?H5EXdf3derEgLlZ4EecsJT/gibtCl0ZPzbBmKjCm15EqDoRJ1E9h6m63bR+v?=
 =?us-ascii?Q?UMBMR47HATlQElZGAyvoyFgr737HB5Ki3L40ykFqdwPANJAEyJ8+ZuqW5uNg?=
 =?us-ascii?Q?wnGTTokCmb/o4/DdQiOXImOL1jwTtOX9jb9T9AYRYEbFpPYjQnJlbnDiJjRi?=
 =?us-ascii?Q?sRa8ugsmLZfWf6uqeffn7yXdvPDnWXr9v4kQf9H3oz+3BxoIInzSTo/BrGtk?=
 =?us-ascii?Q?nuC75DxoX11/rV4oxI1mPqecx5PIjMM5bducir4f2M3lUpfy/e2SuhEOjGBc?=
 =?us-ascii?Q?CF9FvC8IVy06RUHFq76E783ZXXZB4vN0wrz39Nan5919f/lxnimwqpd00XuZ?=
 =?us-ascii?Q?tI46i8vOJp2X6Aq2XpF7k+VRwmMfIQelumVSRBH1eulZJ/EDDBjc8Mhywvwq?=
 =?us-ascii?Q?jESgVNWNI74VF2Hmctc6ZL4/lEg5aGykIEri3fU0SIj7ggVo89R9RTYntBOO?=
 =?us-ascii?Q?Tinejg+nYvg7kFv25NAN+ypnXVd2lxeg836lQTojdzqNm5GgIqb1LnTBv5x5?=
 =?us-ascii?Q?Jro3eT6y8C62jMOcrIJybUzYGJvhWpEqWh3TPEewwWsSENDgG1+W5CmMsXL4?=
 =?us-ascii?Q?n0F8Zo2Qd1yA87vrhfVJySHGs6SrOuzfiw7oEAJE80VPmF4rHHcy94FydKf7?=
 =?us-ascii?Q?BLnHA6uu08RgzRcV0C5qoudaXXWyAomSazaiSERMmZ1no32SZTl6g3ldTHxB?=
 =?us-ascii?Q?hGJyMG8DYXkd6xjOQNVB2HMRz1tjB02ZaJCQKtxg/OjCWwHhS2X3ByB99X3K?=
 =?us-ascii?Q?/98gvjjkiS95922vpWn0zoDTyxUNQ1CufWkNESoIf6ub505hoNEC7Yi4m1ql?=
 =?us-ascii?Q?tjEzfgO+qDDSWebMbqHmHOJqYUbnyKUzvYdKkee38zLdMqbt8yicczIRc2Xj?=
 =?us-ascii?Q?aUQLeuRJCfQ/XkpS+/TZCWAbUgjom8I2A1nbKx0oHVZUrnzQjSqxnmt+bf+c?=
 =?us-ascii?Q?6FNEx9gzEVoWCm1zA54WjMOywDACqhoQ8Ug0suMkXF+5n2QZAFP0e3ocrXBU?=
 =?us-ascii?Q?c8y4CKHLp1RuJVR07lpJh8cEhqlJiwsE3P3rTbpC9XU77qbFFzXxhjXz7UQU?=
 =?us-ascii?Q?9WMhX2TWrzd2bBI4o2yMNIntLiphDo8k1usaq6iQL/HKnSIBU6sRGXZdqa2U?=
 =?us-ascii?Q?ZqOjxTUpCrGCg2PUbkCVhr/LxsCgcaAYEDAh3L2VPOGrzj4xOsEpJ80UO17b?=
 =?us-ascii?Q?0tOX16Wt68CaVBoOPjtT8XhhLM29ddEouPcSzftqrkxyfF9L0ovGMTvJJAAI?=
 =?us-ascii?Q?CWYSXOlXcgmecsB18C33QFB6apICx/tKP/NV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 22:29:03.0424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87218519-31d9-47bf-b18d-08dd2f6ab093
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6216

The "AMD Node" concept spans many families of systems and applies to
a number of subsystems and drivers.

Currently, the AMD Northbridge code is overloaded with AMD node
functionality. However, the node concept is broader than just
northbridges.

Start files to host common AMD node functions and definitions.  Include
a helper to find an AMD node device function based on the convention
described in AMD documentation.

Anything that needs node functionality should include this rather than
amd_nb.h. The AMD_NB code will be reduced to only northbridge-specific
code needed for legacy systems.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-5-yazen.ghannam@amd.com
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
index 1e930c7a58b1..290989ab9f72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1121,6 +1121,13 @@ L:	linux-i2c@vger.kernel.org
 S:	Supported
 F:	drivers/i2c/busses/i2c-amd-asf-plat.c
 
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
index 9d7bd0ae48c4..01a91b22c05f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -3128,6 +3128,10 @@ config TS5500
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


