Return-Path: <linux-pci+bounces-17862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2669E758E
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 17:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A5316AA18
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 16:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927F0211481;
	Fri,  6 Dec 2024 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="duN6B6km"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7336420E012;
	Fri,  6 Dec 2024 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501573; cv=fail; b=aBxqAdZhQE38IpgV531TdBCp8itJK1727srBr9LKtcRINPAoLJoYIBQkRawU0wUgErjhmBGKaBVk8Knczlr0b7qZ7k3PCyoZTZwWRmNIFzNHsyRYapopvQrzGsRINu8X4EhLr4VZFwh+t2+V19Hlje3ohEglscTVy4Us9lqPZ/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501573; c=relaxed/simple;
	bh=CDo+hEBWn8fDB9VZnKoPhXDI6kon5Dl/JqSB2wJ2wps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FurxP7ehOB1o6j6TqvApdGTa3BxLy3lOc28c+tOPEE9pyPXkrWCyzwPVenC/6MefvNXzStYN5R7woh89OLJfY8Y71iYs8p5l4sftgKm6xsrFzEvHvJSlxY5HF7zxjU+dl/QehIhOK0twhe1YvzMCcA7I+9A31yDcJ5Y0kHi7WJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=duN6B6km; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=am1wnlmFdXv/eguMO5XhWJxdSXYevi8E63Tjgx4yzsZ9MXQ8a2//4XwReeGSw8puiixa5YPb3Tt5W+Fp0/GtnGWRpPj7Rr077ZVZyLjrJYhH8aNj0lT18LbsQbw04w09LUzwyxc4SeC7nERXR+zXYZFtYCwOTf4JD5dfjeuBFN6CfRDlWp1+1CkPCX9uPmC9jEYUU+/5V/2wR/t1UiEQnxcKK8S5BG5iUsy44NINyPwCcNlZu1d+1XAEtUs02ngPYujYKF349aN7J2udb+h+HTSi5RpoRlEnRoQ72ccPP1hcADUdH0Szr7+SJcILrxDVP/Ta4u1CkV5Dp85Qu1tAgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byqu+VBXhyRQnZe8soU+QIm5j6cIaK98iGLCFBNB81c=;
 b=qtdgSDb/4qOdw1XcJpgZ4N1I25DrJxL1Xcjww9lThZ/pYj479JwTzi5s3M2q/Eww0dw8U7gt95rB52kfk755PpdJQGs0NAdZGmmtakiqC5GFp4UPYBhmAXC+eGlUxCNiYHpjVt8XKByzit8nfXlTGpDoNk4tfw9YHsQETHRmGA3YyEZVxh9yilz5pAbIbm7fNMjWsh6JhKZyZG9YaYEMs9w+GRLYqmcRWm9f8NzpoNMesXzeXlaf7REx8n/VJY3jZkJ8slHwm8Oe/7w+/1xYx+EF1ELWSZYKVf+t3ykDfZLSuFWA1/c2YWClibjXTRK/bSJL6H4cSL7xWjo4nTjy/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byqu+VBXhyRQnZe8soU+QIm5j6cIaK98iGLCFBNB81c=;
 b=duN6B6km52BqTTqzoWvxAkHCN7LPAmGlSBEbI5lSmG9btMLeu+L4XFm8b60kZW8BWGnnC5iYQ7C9mIn+y6NhuNHcP6N7c+b56e3tLXMO/FC0GyK6B32z4mCBuh/WS9wbRuLDqSgBuIy8rb2thM4JLVWFn3w0TQwkdDIgWi/e6CQ=
Received: from DM6PR02CA0069.namprd02.prod.outlook.com (2603:10b6:5:177::46)
 by LV8PR12MB9083.namprd12.prod.outlook.com (2603:10b6:408:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 16:12:33 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::7f) by DM6PR02CA0069.outlook.office365.com
 (2603:10b6:5:177::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Fri,
 6 Dec 2024 16:12:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 16:12:33 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 10:12:31 -0600
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
Subject: [PATCH v2 10/16] x86/amd_nb: Move SMN access code to a new amd_node driver
Date: Fri, 6 Dec 2024 16:12:03 +0000
Message-ID: <20241206161210.163701-11-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|LV8PR12MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: b5bd210b-22f7-4e7b-9d8d-08dd1610caa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HmaH/4CtGKtAXUB8cBTmc8nRdAS1x1FJTIx2wLzIVlqalA/knVH3GKWARclh?=
 =?us-ascii?Q?RwDsPi2zLaJEN5LQxYHPuVeO885ThuJZhbh84UDAdp/xYrjOO1OUCr7dCKoH?=
 =?us-ascii?Q?fZwhEeETTyhC5/iiOVDoyI3Bzwy5w+W8Mm3BuwUpRJmhRq6TQqucZB1AKH1H?=
 =?us-ascii?Q?Moxi5mk9Ucb9yBC0puBYuttXjWALx4r0bkGn4+OnU52qaxLsxDgGp2Ax+477?=
 =?us-ascii?Q?MiRNYFs0SxOl8hP1gua5bw5inhOytVS8C1eH6IgcKRfwBv56XrwdKLIYgUET?=
 =?us-ascii?Q?mSqNbs1enD33kzzn07d7fOw8EDANnyUDeSnJdAaGVKFSeSzwRGngo3D+03Mj?=
 =?us-ascii?Q?p94UFLIwEyJAs9sl+LX34jMu+4PrPB4TQsNj20fnJ/3ib6V0o5pIIkX4LkhF?=
 =?us-ascii?Q?drzZR0rKSc0bP+TO/EowlljMwKFCQv37GMWirVHXZRdDNc0bZtCv5mwUu3UC?=
 =?us-ascii?Q?m1m5IVYLzD1CC/Me+QN2i6S1mQ1OMrNWYvDy9I87A1d8wKR7eQM0UaMEvn0M?=
 =?us-ascii?Q?Tb50hC+hrK2QIzx6i0FMG2pXNuzu1wuPYv4/JTUPek7OLLlOSxgH+o44DRDk?=
 =?us-ascii?Q?5ZriL2lKG6XkI3yGaLOIQ9US64xhA4VXKMGq16fLIaOoCLsMasnK5vqJd+H6?=
 =?us-ascii?Q?3C8NscdFT4hKfkm0/y1hNbM2Ja+nJgRpSVP5g181pgYH7fQk+I0b1kLdqCXE?=
 =?us-ascii?Q?6nmqzZgUjJOMY+EhpSTxujuRZyv4SLDFENBdZsvoH+OtIrPL72bHT43t+ekC?=
 =?us-ascii?Q?o7xCQi4N9HkrruzyfSo4yZDVeE5WIim4mrRnCHPhPCl9yfOR5m6rIce/0QM2?=
 =?us-ascii?Q?XBX475AXjmwQzRKRa4sYhSEgD5vhkmlyf9gEFHU2PexBqf9AdxeHfrpBavPA?=
 =?us-ascii?Q?zsF95bUeqngo9OikbsHwwGke7vpxFDAPxjqhpmm3xKWNkpQ33M7dTpN/lqQm?=
 =?us-ascii?Q?d21jF4WBHuAbXLL3fqBvdppS2jAFRZZZfN60kbtUV6qqts8/bCF3bY7/JoG7?=
 =?us-ascii?Q?ovKhwDvDs6DJtL7sVZEDPasPPadLDgPqLW/GJlMAge2zyydl2i0RiO/Wn88c?=
 =?us-ascii?Q?CR/4RrgyxRF4L/QfWf/FF0ex9Kq8ch3m9/ALx8J0/gXyt8xipniUEcadcTlB?=
 =?us-ascii?Q?7N6TtDpIM4sKFAEVwcT00S9HwMcoP5CsdXHdgq/ZCqpMYCyTX5H1NUxZ9ljZ?=
 =?us-ascii?Q?9IV6oPRrpCwTGdX9IxepTCaMUZQZJ8z9CDIJ1/e2cNWTgwnbTSJUwCjqK1tF?=
 =?us-ascii?Q?4hRkCPXESDPZjy8iovVFXhNQTdtU22wxHb2SlzTnnrA7MiHmgF7cA8qsbzqe?=
 =?us-ascii?Q?d2C5M+sNjOsdQH1a0UBLq3Nh2DLiUs4smEtds/L4kcbE9o6dTQm1Un4oCYxG?=
 =?us-ascii?Q?DS+q4OL92ODWtSMl236wQ9kwS81LugSor60LyHksimRdqcWbCe4+rsyxm5H0?=
 =?us-ascii?Q?bkiWalTf8In49C10L7Y01u9I0gW5vso8yixRQgB6a1VkiH6CxI+3vw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:12:33.0327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5bd210b-22f7-4e7b-9d8d-08dd1610caa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083

From: Mario Limonciello <mario.limonciello@amd.com>

SMN access was bolted into amd_nb mostly as convenience.  This has
limitations though that require incurring tech debt to keep it working.

Move SMN access to the newly introduced AMD Node driver.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/20241023172150.659002-11-yazen.ghannam@amd.com
    
    v1->v2:
    * Move code to AMD_NODE rather than create a new compilation unit.

 MAINTAINERS                          |  1 +
 arch/x86/include/asm/amd_nb.h        |  3 -
 arch/x86/include/asm/amd_node.h      |  3 +
 arch/x86/kernel/amd_nb.c             | 89 ---------------------------
 arch/x86/kernel/amd_node.c           | 90 ++++++++++++++++++++++++++++
 arch/x86/pci/fixup.c                 |  4 +-
 drivers/edac/Kconfig                 |  1 +
 drivers/edac/amd64_edac.c            |  1 +
 drivers/hwmon/Kconfig                |  2 +-
 drivers/hwmon/k10temp.c              |  2 +-
 drivers/platform/x86/amd/pmc/Kconfig |  2 +-
 drivers/platform/x86/amd/pmc/pmc.c   |  3 +-
 drivers/platform/x86/amd/pmf/Kconfig |  2 +-
 drivers/platform/x86/amd/pmf/core.c  |  2 +-
 drivers/ras/amd/atl/Kconfig          |  1 +
 drivers/ras/amd/atl/internal.h       |  1 +
 16 files changed, 107 insertions(+), 100 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d7617f196bda..ca383cb1539f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1122,6 +1122,7 @@ S:	Supported
 F:	drivers/i2c/busses/i2c-amd-asf-plat.c
 
 AMD NODE DRIVER
+M:	Mario Limonciello <mario.limonciello@amd.com>
 M:	Yazen Ghannam <yazen.ghannam@amd.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 066dc3801430..4c4efb93045e 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -21,9 +21,6 @@ extern int amd_numa_init(void);
 extern int amd_get_subcaches(int);
 extern int amd_set_subcaches(int, unsigned long);
 
-int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
-int __must_check amd_smn_write(u16 node, u32 address, u32 value);
-
 struct amd_l3_cache {
 	unsigned indices;
 	u8	 subcaches[4];
diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
index 419a0ad13ef2..113ad3e8ee40 100644
--- a/arch/x86/include/asm/amd_node.h
+++ b/arch/x86/include/asm/amd_node.h
@@ -30,4 +30,7 @@ static inline u16 amd_num_nodes(void)
 	return topology_amd_nodes_per_pkg() * topology_max_packages();
 }
 
+int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
+int __must_check amd_smn_write(u16 node, u32 address, u32 value);
+
 #endif /*_ASM_X86_AMD_NODE_H_*/
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 2ad67efe9032..2729e99806ec 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -15,9 +15,6 @@
 #include <linux/pci_ids.h>
 #include <asm/amd_nb.h>
 
-/* Protect the PCI config register pairs used for SMN. */
-static DEFINE_MUTEX(smn_mutex);
-
 static u32 *flush_words;
 
 static const struct pci_device_id amd_nb_misc_ids[] = {
@@ -59,92 +56,6 @@ struct amd_northbridge *node_to_amd_nb(int node)
 }
 EXPORT_SYMBOL_GPL(node_to_amd_nb);
 
-/*
- * SMN accesses may fail in ways that are difficult to detect here in the called
- * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
- * their own checking based on what behavior they expect.
- *
- * For SMN reads, the returned value may be zero if the register is Read-as-Zero.
- * Or it may be a "PCI Error Response", e.g. all 0xFFs. The "PCI Error Response"
- * can be checked here, and a proper error code can be returned.
- *
- * But the Read-as-Zero response cannot be verified here. A value of 0 may be
- * correct in some cases, so callers must check that this correct is for the
- * register/fields they need.
- *
- * For SMN writes, success can be determined through a "write and read back"
- * However, this is not robust when done here.
- *
- * Possible issues:
- *
- * 1) Bits that are "Write-1-to-Clear". In this case, the read value should
- *    *not* match the write value.
- *
- * 2) Bits that are "Read-as-Zero"/"Writes-Ignored". This information cannot be
- *    known here.
- *
- * 3) Bits that are "Reserved / Set to 1". Ditto above.
- *
- * Callers of amd_smn_write() should do the "write and read back" check
- * themselves, if needed.
- *
- * For #1, they can see if their target bits got cleared.
- *
- * For #2 and #3, they can check if their target bits got set as intended.
- *
- * This matches what is done for RDMSR/WRMSR. As long as there's no #GP, then
- * the operation is considered a success, and the caller does their own
- * checking.
- */
-static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
-{
-	struct pci_dev *root;
-	int err = -ENODEV;
-
-	if (node >= amd_northbridges.num)
-		goto out;
-
-	root = node_to_amd_nb(node)->root;
-	if (!root)
-		goto out;
-
-	mutex_lock(&smn_mutex);
-
-	err = pci_write_config_dword(root, 0x60, address);
-	if (err) {
-		pr_warn("Error programming SMN address 0x%x.\n", address);
-		goto out_unlock;
-	}
-
-	err = (write ? pci_write_config_dword(root, 0x64, *value)
-		     : pci_read_config_dword(root, 0x64, value));
-
-out_unlock:
-	mutex_unlock(&smn_mutex);
-
-out:
-	return err;
-}
-
-int __must_check amd_smn_read(u16 node, u32 address, u32 *value)
-{
-	int err = __amd_smn_rw(node, address, value, false);
-
-	if (PCI_POSSIBLE_ERROR(*value)) {
-		err = -ENODEV;
-		*value = 0;
-	}
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(amd_smn_read);
-
-int __must_check amd_smn_write(u16 node, u32 address, u32 value)
-{
-	return __amd_smn_rw(node, address, &value, true);
-}
-EXPORT_SYMBOL_GPL(amd_smn_write);
-
 static int amd_cache_northbridges(void)
 {
 	struct amd_northbridge *nb;
diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index 4eea8c7d8090..95e5ca0acc90 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -8,6 +8,7 @@
  * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
  */
 
+#include <asm/amd_nb.h>
 #include <asm/amd_node.h>
 
 /*
@@ -88,3 +89,92 @@ struct pci_dev *amd_node_get_root(u16 node)
 	pci_dbg(root, "is root for AMD node %u\n", node);
 	return root;
 }
+
+/* Protect the PCI config register pairs used for SMN. */
+static DEFINE_MUTEX(smn_mutex);
+
+/*
+ * SMN accesses may fail in ways that are difficult to detect here in the called
+ * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
+ * their own checking based on what behavior they expect.
+ *
+ * For SMN reads, the returned value may be zero if the register is Read-as-Zero.
+ * Or it may be a "PCI Error Response", e.g. all 0xFFs. The "PCI Error Response"
+ * can be checked here, and a proper error code can be returned.
+ *
+ * But the Read-as-Zero response cannot be verified here. A value of 0 may be
+ * correct in some cases, so callers must check that this correct is for the
+ * register/fields they need.
+ *
+ * For SMN writes, success can be determined through a "write and read back"
+ * However, this is not robust when done here.
+ *
+ * Possible issues:
+ *
+ * 1) Bits that are "Write-1-to-Clear". In this case, the read value should
+ *    *not* match the write value.
+ *
+ * 2) Bits that are "Read-as-Zero"/"Writes-Ignored". This information cannot be
+ *    known here.
+ *
+ * 3) Bits that are "Reserved / Set to 1". Ditto above.
+ *
+ * Callers of amd_smn_write() should do the "write and read back" check
+ * themselves, if needed.
+ *
+ * For #1, they can see if their target bits got cleared.
+ *
+ * For #2 and #3, they can check if their target bits got set as intended.
+ *
+ * This matches what is done for RDMSR/WRMSR. As long as there's no #GP, then
+ * the operation is considered a success, and the caller does their own
+ * checking.
+ */
+static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
+{
+	struct pci_dev *root;
+	int err = -ENODEV;
+
+	if (node >= amd_nb_num())
+		goto out;
+
+	root = node_to_amd_nb(node)->root;
+	if (!root)
+		goto out;
+
+	mutex_lock(&smn_mutex);
+
+	err = pci_write_config_dword(root, 0x60, address);
+	if (err) {
+		pr_warn("Error programming SMN address 0x%x.\n", address);
+		goto out_unlock;
+	}
+
+	err = (write ? pci_write_config_dword(root, 0x64, *value)
+		     : pci_read_config_dword(root, 0x64, value));
+
+out_unlock:
+	mutex_unlock(&smn_mutex);
+
+out:
+	return err;
+}
+
+int __must_check amd_smn_read(u16 node, u32 address, u32 *value)
+{
+	int err = __amd_smn_rw(node, address, value, false);
+
+	if (PCI_POSSIBLE_ERROR(*value)) {
+		err = -ENODEV;
+		*value = 0;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(amd_smn_read);
+
+int __must_check amd_smn_write(u16 node, u32 address, u32 value)
+{
+	return __amd_smn_rw(node, address, &value, true);
+}
+EXPORT_SYMBOL_GPL(amd_smn_write);
diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 0681ecfe3430..592fb9d97e77 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -9,7 +9,7 @@
 #include <linux/pci.h>
 #include <linux/suspend.h>
 #include <linux/vgaarb.h>
-#include <asm/amd_nb.h>
+#include <asm/amd_node.h>
 #include <asm/hpet.h>
 #include <asm/pci_x86.h>
 
@@ -828,7 +828,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7910, rs690_fix_64bit_dma);
 
 #endif
 
-#ifdef CONFIG_AMD_NB
+#ifdef CONFIG_AMD_NODE
 
 #define AMD_15B8_RCC_DEV2_EPF0_STRAP2                                  0x10136008
 #define AMD_15B8_RCC_DEV2_EPF0_STRAP2_NO_SOFT_RESET_DEV2_F0_MASK       0x00000080L
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 06f7b43a6f78..cb97d7bdae31 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -78,6 +78,7 @@ config EDAC_GHES
 config EDAC_AMD64
 	tristate "AMD64 (Opteron, Athlon64)"
 	depends on AMD_NB && EDAC_DECODE_MCE
+	depends on AMD_NODE
 	imply AMD_ATL
 	help
 	  Support for error detection and correction of DRAM ECC errors on
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index ddfbdb66b794..29465088639c 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2,6 +2,7 @@
 #include <linux/ras.h>
 #include "amd64_edac.h"
 #include <asm/amd_nb.h>
+#include <asm/amd_node.h>
 
 static struct edac_pci_ctl_info *pci_ctl;
 
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index dd376602f3f1..ea13ea482a63 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -324,7 +324,7 @@ config SENSORS_K8TEMP
 
 config SENSORS_K10TEMP
 	tristate "AMD Family 10h+ temperature sensor"
-	depends on X86 && PCI && AMD_NB
+	depends on X86 && PCI && AMD_NODE
 	help
 	  If you say yes here you get support for the temperature
 	  sensor(s) inside your CPU. Supported are later revisions of
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index cefa8cd184c8..d0b4cc9a5011 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -20,7 +20,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
-#include <asm/amd_nb.h>
+#include <asm/amd_node.h>
 #include <asm/processor.h>
 
 MODULE_DESCRIPTION("AMD Family 10h+ CPU core temperature monitor");
diff --git a/drivers/platform/x86/amd/pmc/Kconfig b/drivers/platform/x86/amd/pmc/Kconfig
index 94f9563d8be7..eeffdafd686e 100644
--- a/drivers/platform/x86/amd/pmc/Kconfig
+++ b/drivers/platform/x86/amd/pmc/Kconfig
@@ -5,7 +5,7 @@
 
 config AMD_PMC
 	tristate "AMD SoC PMC driver"
-	depends on ACPI && PCI && RTC_CLASS && AMD_NB
+	depends on ACPI && PCI && RTC_CLASS && AMD_NODE
 	depends on SUSPEND
 	select SERIO
 	help
diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index 26b878ee5191..941b7753dd78 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -10,7 +10,6 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <asm/amd_nb.h>
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
@@ -28,6 +27,8 @@
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 
+#include <asm/amd_node.h>
+
 #include "pmc.h"
 
 /* SMU communication registers */
diff --git a/drivers/platform/x86/amd/pmf/Kconfig b/drivers/platform/x86/amd/pmf/Kconfig
index 99d67cdbd91e..25b8f7ae3abd 100644
--- a/drivers/platform/x86/amd/pmf/Kconfig
+++ b/drivers/platform/x86/amd/pmf/Kconfig
@@ -7,7 +7,7 @@ config AMD_PMF
 	tristate "AMD Platform Management Framework"
 	depends on ACPI && PCI
 	depends on POWER_SUPPLY
-	depends on AMD_NB
+	depends on AMD_NODE
 	select ACPI_PLATFORM_PROFILE
 	depends on TEE && AMDTEE
 	depends on AMD_SFH_HID
diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index 06a97c533cb8..7f88f3121cf5 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -8,13 +8,13 @@
  * Author: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
  */
 
-#include <asm/amd_nb.h>
 #include <linux/debugfs.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
+#include <asm/amd_node.h>
 #include "pmf.h"
 
 /* PMF-SMU communication registers */
diff --git a/drivers/ras/amd/atl/Kconfig b/drivers/ras/amd/atl/Kconfig
index 551680073e43..6e03942cd7da 100644
--- a/drivers/ras/amd/atl/Kconfig
+++ b/drivers/ras/amd/atl/Kconfig
@@ -10,6 +10,7 @@
 config AMD_ATL
 	tristate "AMD Address Translation Library"
 	depends on AMD_NB && X86_64 && RAS
+	depends on AMD_NODE
 	depends on MEMORY_FAILURE
 	default N
 	help
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 143d04c779a8..f9be26d25348 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -18,6 +18,7 @@
 #include <linux/ras.h>
 
 #include <asm/amd_nb.h>
+#include <asm/amd_node.h>
 
 #include "reg_fields.h"
 
-- 
2.43.0


