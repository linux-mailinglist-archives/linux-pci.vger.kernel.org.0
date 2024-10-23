Return-Path: <linux-pci+bounces-15144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 340C19AD2C1
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 19:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D211C21536
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 17:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13E81FF7AB;
	Wed, 23 Oct 2024 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iPvIQ3ij"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E561D0144;
	Wed, 23 Oct 2024 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704152; cv=fail; b=CVoSb/D3lP7Z0pEIWGB6RIxXOLOWgDHBRdQie7E7ng+z29vaTzSNoJMAkKEXwauMgbo6wpSBfMQ51DY3mp+RW3IPiPArX0IWkoRvoSTqzyXxSyiUFpb/7BGlmuKCBJ6EGwHVbMdsYaERQGIp+q4IwOy8zys5kwRW95iO+hdDHX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704152; c=relaxed/simple;
	bh=woJUv7J2gjhRzxTW9WuXXqCKMVBAsBIvB/5e5OV6ZYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lov8TTj56FwwouSK+b1KOEO6840K0IJuhqgaT1wanFj4HMG3P+D3tUYZMp98qi4JjUEwb4mr57B4aLDZZs2jxRSwES5jveNAzoFwvI/AFccO4wRsY/rmp+XkSIcrk06dmA265AXcC5KPZ29TZYbwzCJhQelGhHXR3rCInYrPKN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iPvIQ3ij; arc=fail smtp.client-ip=40.107.95.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pI3y2fdR8/E4Tp1/ctHUFBB0/NoNOfGvJDEVFw5GgWrkY8o7UKPdvqW6b5E6ijDOo7k3dJoSowDaFGReyxpfUEo306kRSSgWhApVHJj0KyonzIj5ebAo63LCui7TmLUd4nnxZjEGgUXdbOUUVkXpMbCCSjU639SR9F6mrLYHmOra48GOne6IUwRcINKgKSuUUV8+mN1EPnRZu5OzqAkf4HGFeYpE9o60LjBG1gKz7wXXRF+VP5JGzjNOakhV//3v81q2Jjv7UtVIve4G+dcHkyF+hcQjGdLtg3WtMIpkfdnb7075apoPEuH14JBN2xLF5WzLJy9CUiyrIPcJa8DrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6t5SZ8L9ft5wo8owTgcgr9wDdoP3FGUdljNwh4/UNs=;
 b=QyyuTi2xwGKrVjAWAQndbAI/iuCvFNQjt9d16vATpkpgAf1F9LyfEGXa4iBlTFG2tsgRgUqeM6oRsZLOiy8JQRRltLz/hIMr3XAJ7gfozf46L6u7UEpDLWTHE00MvyJNKGcK3YYhdlFzG9B8riMfV/XfqmDP2obDco+JjDWPrXcBQd2rhKvYzHuMYbB2fz7v6SR2e0p6JUJpyD+R6htiXGSW0U32VF/SXgvzrwvj95Oicu00XmMWcqCZQZ2m8X+V45XoQwi7hk/ZwwiUyXIkZstlkePGopFMA+Adid893fSoOYUgyV0mlvRBNxH9933KyV2u4oF8SQY3d4g5tXC0MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6t5SZ8L9ft5wo8owTgcgr9wDdoP3FGUdljNwh4/UNs=;
 b=iPvIQ3ij9pX/TINYNsR4QPZ21Aj0jYs4koY+8P/iWziaHSZGoFB6Gdt9DoVYv5eoy8z+psvMvQweThAYFg107xJD6lfInObq97oZBj4ebPDzjc6dsIB/s2kRkgtOaEqlfGZ6jkZBc6uRIBdmdRie4asbmm1lkOhm8ohrrPg58Gs=
Received: from MN2PR01CA0056.prod.exchangelabs.com (2603:10b6:208:23f::25) by
 BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Wed, 23 Oct 2024 17:22:27 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::f9) by MN2PR01CA0056.outlook.office365.com
 (2603:10b6:208:23f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 17:22:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:22:27 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:22:17 -0500
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
Subject: [PATCH 16/16] x86/amd_smn: Add support for debugfs access to SMN registers
Date: Wed, 23 Oct 2024 17:21:50 +0000
Message-ID: <20241023172150.659002-17-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|BL1PR12MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f102ef4-3a53-480e-3dcd-08dcf3874479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qf5ToSXRWZbo1JJCD5GlkMS7CphGbkYExfxyQLrdynxd0yTAEohpc9zbzQJP?=
 =?us-ascii?Q?+zhVZAOezcuc5/HPe/T/vp1iUzNZm6ybOlPrkaLz1c3aZIlrAdfioBUBNimw?=
 =?us-ascii?Q?EkzT6xndvJldWTEoi1c6erC/ZOj/rCys1i9RPqVHGgEnG+aB8TympJPYdLvl?=
 =?us-ascii?Q?TL0UZhfeK4Cry5fnSR+Vuv9NTJwOgFQ5jLwRIFIhoy9BPc+aA9ApOlGR4qcc?=
 =?us-ascii?Q?7hKtFmnNh6TnyCyEHMe2n4I9d1qMi7I2Up3/1wnkE0CdLOl/N60zcpL5kyX+?=
 =?us-ascii?Q?0b+MenLRKw7kcSGKvT7dWlSq30aya6IN+vrq9YG0mAl/iKTPjKo726Y5LNoy?=
 =?us-ascii?Q?rn6EzAefpd9IdUmiBtrRwLoUxjpv4RnANyqOTMmWHM0ZBpJ6fY1A0q2KnNlc?=
 =?us-ascii?Q?5sswkMe/rTk9Fxq4ISQC69b5OXfbtrmtJNCT5Lq+1p8lgyr1j7UbIdcDuFEz?=
 =?us-ascii?Q?CuNYd6cke93GClobmZBvZmG0Y2LR7cFXxrMEvpsPKAcMKwop6qGRfwVgy8dd?=
 =?us-ascii?Q?mPDBvdJKf44MKNVHCwfYIV6/R5sOrlLm2CW9SH7V6bGW/0z+RgImsfbpTy8w?=
 =?us-ascii?Q?8jUAgtzXVcKZHqW0j98fCyMadI3hJsOGaPr5I9rjFZroTYW/SQAFBGmfCr/M?=
 =?us-ascii?Q?3uk0MkmC2qHka8cNtf9+hypIF9MCK2UFZ7fOhUHuoBxeLdT3rKn0LIh2WMhI?=
 =?us-ascii?Q?ZF2MmsOeXkKS+0902FgmC2z6O8YINjvQ9CVDEHzaTNCtmlTQgdcKSKZPGgNb?=
 =?us-ascii?Q?0kDvfmHueB93vsaZH5bTIjnqcSSlIYkPJQ4tOt826NYDc/Iz1MJaL4A39PQU?=
 =?us-ascii?Q?tJtUEb8VWd1EoaBIueZD6wkf7O5kIa2Sk4y+Q2KWFBkkTGuFZpiioldEcsuz?=
 =?us-ascii?Q?4dgxlmSgNsFdwVAK6FUCK4aMcQzWpAmdxTaA7u3E/VDpSvTQNYGqqI1OjibV?=
 =?us-ascii?Q?h/M2ZIn686LJ6LdJFk+awz6HvcwpFODZ+p39ezA+OIPoc+vFglib22w7hjk2?=
 =?us-ascii?Q?H01YlMPwJXi6CJJ6/b1NNyKVbJJXKImdxZNYP4jyC6EKCVKTLw6UdJe7TorI?=
 =?us-ascii?Q?bnUHBKpwKx3+mb5wHMnnkYnwQLaqgxSfk/Sm+BCVeo9ZQ7ke+r6ZRjD8BBj9?=
 =?us-ascii?Q?K5HGkp1/2vJWIgzZBVR4yNwDS5IULVX4BTPa646TbmoqIyarr4+EPuABLxnB?=
 =?us-ascii?Q?b20Y8hKWlPGeiOOmMoLbSkKKG8ziTEmi9uopgNCIcARFOjgSbvWCkHRvJbe6?=
 =?us-ascii?Q?yKt+4m35L/pkjAl5NjEFqw6bigVUK48DNX4CQk79SinRLHjqwEDT9HSseEfX?=
 =?us-ascii?Q?419AWAbusHeAXtyM9MQL55a1LJFDwHLUdqSM/4l6WWXCl1WDpHKy8jDUIaJP?=
 =?us-ascii?Q?A6R52PT+xr6FM2XmbY4fmeO3a4oIfRCY/4QpGhYj9S523lDkmw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:22:27.3604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f102ef4-3a53-480e-3dcd-08dcf3874479
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946

From: Mario Limonciello <mario.limonciello@amd.com>

There are certain registers on AMD Zen systems that can only be
accessed through SMN.

Introduce a new interface that provides debugfs files for accessing SMN.
As this introduces the capability for userspace to manipulate the
hardware in unpredictable ways, taint the kernel when writing.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/amd_smn.c | 83 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/x86/kernel/amd_smn.c b/arch/x86/kernel/amd_smn.c
index aeebd63234f9..618d9a05f3d7 100644
--- a/arch/x86/kernel/amd_smn.c
+++ b/arch/x86/kernel/amd_smn.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) "amd_smn: " fmt
 
 #include <linux/pci.h>
+#include <linux/debugfs.h>
 
 #include <asm/amd_smn.h>
 
@@ -113,6 +114,82 @@ int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool write
 }
 EXPORT_SYMBOL_GPL(amd_smn_hsmp_rdwr);
 
+static struct dentry *debugfs_dir;
+static u16 debug_node;
+static u32 debug_address;
+
+static ssize_t smn_node_write(struct file *file, const char __user *userbuf,
+			      size_t count, loff_t *ppos)
+{
+	int ret;
+
+	ret = kstrtou16_from_user(userbuf, count, 0, &debug_node);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static int smn_node_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "0x%08x\n", debug_node);
+	return 0;
+}
+
+static ssize_t smn_address_write(struct file *file, const char __user *userbuf,
+				 size_t count, loff_t *ppos)
+{
+	int ret;
+
+	ret = kstrtouint_from_user(userbuf, count, 0, &debug_address);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static int smn_address_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "0x%08x\n", debug_address);
+	return 0;
+}
+
+static int smn_value_show(struct seq_file *m, void *v)
+{
+	u32 val;
+	int ret;
+
+	ret = amd_smn_read(debug_node, debug_address, &val);
+	if (ret)
+		return ret;
+
+	seq_printf(m, "0x%08x\n", val);
+	return 0;
+}
+
+static ssize_t smn_value_write(struct file *file, const char __user *userbuf,
+			       size_t count, loff_t *ppos)
+{
+	u32 val;
+	int ret;
+
+	ret = kstrtouint_from_user(userbuf, count, 0, &val);
+	if (ret)
+		return ret;
+
+	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+
+	ret = amd_smn_write(debug_node, debug_address, val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+DEFINE_SHOW_STORE_ATTRIBUTE(smn_node);
+DEFINE_SHOW_STORE_ATTRIBUTE(smn_address);
+DEFINE_SHOW_STORE_ATTRIBUTE(smn_value);
+
 static int amd_cache_roots(void)
 {
 	u16 node, num_nodes = amd_num_nodes();
@@ -180,6 +257,12 @@ static int __init amd_smn_init(void)
 	if (err)
 		return err;
 
+	debugfs_dir = debugfs_create_dir("amd_smn", arch_debugfs_dir);
+
+	debugfs_create_file("node",	0600, debugfs_dir, NULL, &smn_node_fops);
+	debugfs_create_file("address",	0600, debugfs_dir, NULL, &smn_address_fops);
+	debugfs_create_file("value",	0600, debugfs_dir, NULL, &smn_value_fops);
+
 	return 0;
 }
 
-- 
2.43.0


