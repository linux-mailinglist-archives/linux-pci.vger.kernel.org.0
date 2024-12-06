Return-Path: <linux-pci+bounces-17852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907809E7559
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 17:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3383016A5C6
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 16:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1781420FAA6;
	Fri,  6 Dec 2024 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hFFhxphB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B3420E6E4;
	Fri,  6 Dec 2024 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501558; cv=fail; b=Jq6FKtI7wL3vqM6q7uQHTnQuvvfmUAskU/7mEc9+SKx6bFwrKGCbAmasZlOcUb8ROzY9YE5Gyi3RrvHjRE4KhEtAQtFnQY1AWW+Knpt2F1eYLET4plNHzPJJ789DR4DQLw36bAufQRDOnBh1ujqM4OdzHM0/kdyh4hdoSU46xRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501558; c=relaxed/simple;
	bh=P3sPgDshuhYTm6D/3VKVhomI4EzX24szkfR7ufyZH28=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYO+KFyfvbaiTyxaLahW/KLAHXka4bPdvu3KIPqT0xD7eF226wATCur0YbSrZENuB4p0MjOtxiah77k1puBlEEmzyUQvkPdTpXh/s0atujl939SgYE/tDrQjZXRXA2b8yGnmARjDgGIEH6ndRIxxeApbeaCfsT52Veje7ooeguk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hFFhxphB; arc=fail smtp.client-ip=40.107.96.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yx2jUqFx/eCU/jrAYjZdAU40+1jqzCS7rGvJLpkwNO7ptvIE+Fixh5bdrX1MAzyaJPHnZapveERviEHwEVVo5Un3QuPPLXgExtZsDXjDpBxEgFPscVlRGBYscot3kfoeKTs1bNjdwkoDIbht6VXcRb/fgNhb4qMVdoVUXGPQq4Y8Hf8ssq6KIxsk8t2PS+GOhTICg4ruN1Df0AO/LTRjqZzGkTBKFj7Cv3XMQM9OMOyw+IvpP/a9DVbpMNfYEiTw+9NCgifstP3q87iGW9r6RM41qDSjPY5nsZYrhJFeZLI4s/Q4JpXDmUWokFU4y0mOcAcs4KKrDg3cRjdIXy+Viw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyTSCnBoWM69YaGUkVY3eEfQ8JWKZ32hNTsfvrEu4e0=;
 b=iRpXzgnaxIbSuAA4n9yHH5bkkvDIYrMwCqk5Yett8g3oV+A7Y3qjgMjC1CEnf7zVrBJy4yUsOKW9/G37aofQzh3XTQYBpUBoEE38iJszqSPiuc7xEipBxW1OQW+ATBAKsDmtMXJlLPbvEv8FugShxfFDniIgEuOhpbc196x5qNEFWlwQTL8hLExsemkItshiawfrRiqqlf2tksArEtuApwltnf/2yh2GH7iO/CWeM6bKhWZz/oJP/LFmN7C+371RZv/ParBi7n4zXBhUyQ4WCn+5e49U4R0lIIK4Vy2W2glY86lYCoDUJpaPstbENyP6qQPr5VDhgWugMN8zBarnEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyTSCnBoWM69YaGUkVY3eEfQ8JWKZ32hNTsfvrEu4e0=;
 b=hFFhxphBpoUm0Q2gOu++xIBrmgBeFbSNZrAiuJlvIgtM40p71CG/blX5gMN9EFsY9rjtJktt5wrxWu5d6VFTDaJfQO5HcjPCz0cMzcUEAAll4kWRoRrBYzC2tCYUlo/RZ3hnq7YqlnnlRC61+paxYn7+W9JbMN+nAcwPuKjm2lc=
Received: from DM6PR02CA0161.namprd02.prod.outlook.com (2603:10b6:5:332::28)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 16:12:29 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:332:cafe::12) by DM6PR02CA0161.outlook.office365.com
 (2603:10b6:5:332::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Fri,
 6 Dec 2024 16:12:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 16:12:28 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 10:12:27 -0600
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
Subject: [PATCH v2 04/16] x86: Start moving AMD Node functionality out of AMD_NB
Date: Fri, 6 Dec 2024 16:11:57 +0000
Message-ID: <20241206161210.163701-5-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: b85070b9-c59e-491a-1db6-08dd1610c7f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BQl27I9U4Yg4g/j2azW51idaudXhaMV4QxfYm8BWd0NVp50jh/kA3g35Qtge?=
 =?us-ascii?Q?VuKBt2MCRLgq5Td2Pa2DJkMWEhpM13CTexXBnp5mM6Fsj03BxiPbTmELa179?=
 =?us-ascii?Q?RmBwsf/2B9mLU0A7BWNcb6i0UO8EVP0bbNPeeuJzZcaAFBGPhCwsbLUKnfuK?=
 =?us-ascii?Q?6Kx0F9YL0PaAg7V/uzJfaDWBPjxBIhqPirgrmxx5ffcy4v6adE1ogTWehGxL?=
 =?us-ascii?Q?de/SHYpEdkUddjPX3NDbW7VkkLfyvfY+sY3P/RmqdwrK8k3OiO3QRfwxN2o0?=
 =?us-ascii?Q?oIVwdFOrCNOc8TYvUYrfRBC+hbKWM5Q5GXSuyfH9L1EjFkEvZv7DwHfRJap/?=
 =?us-ascii?Q?I+LQx7RGWj0uRrW20HFcgVqqLu2h1a4zV3Aja+wkGs3WYcHtS5QlVokcSekq?=
 =?us-ascii?Q?m8THyTXt6oEU6SnL2bIUNETQrsS+ZcNWU4Pd/+ADQdkS9DA52xoEP59haHoP?=
 =?us-ascii?Q?sZJM4rMvk+9lDq+PO7if86LMGQ8m0OoFkX36f8vZX3a+xAKtydEzJ2axhB8h?=
 =?us-ascii?Q?wUdZZ8gnxJ0m29KW5623fgd0on3BMg8cjSoVEHx0BsT6th1a+X8LeffwRL2k?=
 =?us-ascii?Q?I9YN5R01Od1A+XSiYcPsxthEp8B0lgsYrBmZCya/02Os+1Q6wxKNMm9ZkLH6?=
 =?us-ascii?Q?AkR95v4i05HmhmQlTkWv2CpqP/rkayEKKnDf33aA6P2WdtHergJgNHTh+cIn?=
 =?us-ascii?Q?S7nmL0Hu/HE5zRmD7PRZEgnuxv5p+lcA8lxo+C6d+8zPpVZdsERpN6Mk6P0R?=
 =?us-ascii?Q?vT1CoZB83l0p+lip+NCtoyex3ZadH1CzHQj2c5E7g5hLWi5xafGqgYERLsQl?=
 =?us-ascii?Q?QbUO5a4KZd+dbBL+j9Xse95bRHsmdaOw0v8liktQLTkA4I0f7hsBC4cxNEnm?=
 =?us-ascii?Q?oNnXP9Ok+kQJxW5DSpRrBZ1/apIkBQYmVdB7DsSuHzxMM232R1sjHhSCl7Wv?=
 =?us-ascii?Q?qJkiF7fSAtnm0zNYF2/O6LZ5zL5m0sHezuhYlBlVmQpuDjwKPsQqmJLDGR3C?=
 =?us-ascii?Q?57GahvP+dv659P4cpjCzosevEQiOxZphjIzADYr7Zy9JFzOlu+qT43x+mX1F?=
 =?us-ascii?Q?sOITbceetJ1SXOVfnIaJTN9JOjn5Xi5VhwR2u+S0I9RgzNV4/fjA3mnNiQZr?=
 =?us-ascii?Q?7hTnAUQZoL1MuPcwlzoWlPysYpH4I14/sHOjSLFropKHirqyAsWi4Kibi/6M?=
 =?us-ascii?Q?KZOZRLpANhR+rqH+N7VcdEkJDnDL368gQ+1W9FCTMXjZpz7nAo5vcknvumR8?=
 =?us-ascii?Q?TJGrO9CXx6f3TvBke4dsgb7b1MsO5K7axq1rZ+H1IloRpbNtiyCqEi9DVwmm?=
 =?us-ascii?Q?8V3ZCmB/C1iNHWyDCQ36uAFL69Cs43v30xKueJ3nlKhTBnI/Jbw6wWlMgV+5?=
 =?us-ascii?Q?Xg1JFg1hCDXoC0pjMGCA8vIUCvSMpl8BkQQp8zUaB4hmaZ9jdXqF8QwlYLHe?=
 =?us-ascii?Q?gPaYZ9+9QQKx4furSsILZmD46ssDoMSzw8PUfF+u++D2aqtKujJ+0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:12:28.5533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b85070b9-c59e-491a-1db6-08dd1610c7f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114

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

Notes:
    Link:
    https://lore.kernel.org/20241023172150.659002-5-yazen.ghannam@amd.com
    
    v1->v2:
    * No change.

 MAINTAINERS                     |  7 +++++++
 arch/x86/Kconfig                |  4 ++++
 arch/x86/include/asm/amd_node.h | 27 ++++++++++++++++++++++++++
 arch/x86/kernel/Makefile        |  1 +
 arch/x86/kernel/amd_node.c      | 34 +++++++++++++++++++++++++++++++++
 5 files changed, 73 insertions(+)
 create mode 100644 arch/x86/include/asm/amd_node.h
 create mode 100644 arch/x86/kernel/amd_node.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 686109008d8e..d7617f196bda 100644
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
index e4e27d44dc2b..12915f620b12 100644
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


