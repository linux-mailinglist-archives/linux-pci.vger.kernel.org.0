Return-Path: <linux-pci+bounces-17860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD5C9E757E
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 17:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26EC216A48E
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 16:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC18A21323A;
	Fri,  6 Dec 2024 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dpgmnjnI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD24420DD66;
	Fri,  6 Dec 2024 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501564; cv=fail; b=cpd3XeNuYnu/+XnI+4C506YTG+tb6BVj0kIakY/UgRz3bdaBJtXREI5y8qGdDyZ+N3NSpzKzELASOB/XsWXvbTMCbAKvHR8qzo4rbTf8dAUmh/6KWW4qetcIjkzQZLYU07+YUTeJKQmasAErTZNygaU0ZGfPYbCSoZ2Rdnjkcb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501564; c=relaxed/simple;
	bh=RYm8BqMlEH6yyCKTyOl4gvad7YVqLaIy0W2NlwGbZQg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TO4yuHg8aQROz4nyhZvp/g/JqDsoETltcqlOc0OLj+XS9MbJyCbjh9wf96gMGAg5vT2q4uTz/o/a9WnL2gUnSCt/YnOyNgwXAzaKUlqE4BwOXhvXL5b5b9oNrMzen6IzJ95gnbu513jZPBbZ5rW9X8zVicgAJafgbrHm3LHxx4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dpgmnjnI; arc=fail smtp.client-ip=40.107.102.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SL59TV18aPfTsqMqWPLxZONL/kV5/O2TJ3aU5jkdWtvXrIcZqXwV95DrOk3DoJjTjrnkMZVJITrJQjp7ROxHpAh5VUIJs/LqOzu0YRK8A5QCDU+Qc1Xxh34b+grO+9XfcY48D5X1iw1DuSdhu/hAneKfE0tRTUP71NsYqRt55iHeEjM/ftoZ1wE1M/KLj9ZPlUdf0OYpqCew/vmw+QDMjXKhAEF/cnfQaABTtIKrGO/dTOKkN3HLxqdS9m/H8KvJqx2ZpEYqyPdOR6WfE8TERrPgznQT48ldbBfweFZ5A2Wy2wIwymnWjfaJmMl0Lshj9IJSc2xo9vHY/TFtu/CUsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cg8BZBWXBiypPOyCwJ9J2w1f7xTy5DTk2AFBkN7kQ6Y=;
 b=PTbXQMRfF0qScvugni0zHwxINYkmQTH3bhjiJQHYCIzaeV0RuBKis5HxxNIZ/WsQY8TCVOI1ARCj0xcXbINq4TiRLsp+di/iK4paZQru7zYsd/kIxY99UJ38sAjyzEhDia4hcKIQPjVRE80aDjl2dz4/M9MYJ2hX8Smg1Ro2Xi/xCH77aFom3VxKaPJig9JhIaeDleLkGpAUpW76DaImjFiUNhn4GvdDJGGpBzEtchyYwIJksaNr41J3/t5NB9fD3MG+TYvoGF7h7hPOg3ssUnp6RXOHgwoTF7ERIKCTUC3iS2y80E8y7oqcQvwEAtprlSpfz5+EmEN2HhUaghKfIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cg8BZBWXBiypPOyCwJ9J2w1f7xTy5DTk2AFBkN7kQ6Y=;
 b=dpgmnjnI/+XkSZIJKqUuE8xXyvZvgpfKdSaY6oxAMfEMUnrJLTBnbkKIcO5MbwuMyLJVkkOTQbESI32LRUlFF/h4t/v36juy5F6EtdARvQeMvxgFLZD4ZrdMlXbqdhr3RmZtiQFnP8B/zKs5tgnIukG6y669Oxfd2eonnUcJ0xU=
Received: from DS7PR03CA0251.namprd03.prod.outlook.com (2603:10b6:5:3b3::16)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 16:12:38 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::da) by DS7PR03CA0251.outlook.office365.com
 (2603:10b6:5:3b3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Fri,
 6 Dec 2024 16:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 16:12:38 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 10:12:36 -0600
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
Subject: [PATCH v2 16/16] x86/amd_node: Add support for debugfs access to SMN registers
Date: Fri, 6 Dec 2024 16:12:09 +0000
Message-ID: <20241206161210.163701-17-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f56bba-dbb6-4681-97cc-08dd1610cda1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rf/l9LLTh+nqQjgsyO5LA7y2Qjy1gnzPyaKoImLKm7HOt4b22ksHu8vz4kv1?=
 =?us-ascii?Q?FOw22S496ZZQ4Q+nhlLRxsQdJRT1piiwVElp5eRgN0CjAhNvMPwrzcdJvhnU?=
 =?us-ascii?Q?eDcMgfXV9WaLJMibNdacRuyoqBmxIq9AFYQhAU7lRmV4mMIQP0K0nJ6dpvoq?=
 =?us-ascii?Q?HJOAHMWm9ORQVhCZviu6oAriIjRY33+xWnrXeMzWT19DmG1A/LxqJ+1xl3z9?=
 =?us-ascii?Q?GvAWkNZMqCUsFtUs5cPDLz7Qfo7SUcdnXvwg15uINCi5ze0A2fFcOWLjqXXR?=
 =?us-ascii?Q?UfRMfGIgMLXE11XC1sscBmWzyl+CPXqoK/xcx3o1QnSh5LFkx6eNZ43JK3UG?=
 =?us-ascii?Q?ZohKmQccVQct9ErVWqmDTO0RbqlgXVzTLKOhvt54gdzRzoBGg1RlF+Ne110d?=
 =?us-ascii?Q?vaJRhl8GbHIyUL/kv+wAX5v+Tz6BAIBMGw1LzIBNBnggYm0fpS1NyP7zl1YM?=
 =?us-ascii?Q?N2je4CaueXW/M8XEik/YgRH+vMXHxw9uct7esD+vNKpBt1Wlqzc3IOtKFzpW?=
 =?us-ascii?Q?wYUjuUQlTz6t24RuT25eTgmqYW2z/e4ClxeQsPwjvfA87euCuU1MriAbqLYD?=
 =?us-ascii?Q?4I0HLozk6pCsY3Kzq8IphiDtMf8HBLEzA1YIH/YxxbqG/gNj7c4ZQ8yBfzdU?=
 =?us-ascii?Q?tGTb8XOyYzRwpsoIUZopWuV3xTPTIb3db9KVL6pWsQs2/N3a4cfPFfxNEbZ0?=
 =?us-ascii?Q?Ia4ddZ52ZlBkeh91J1hJbQzwXfDvOWyOwT/MTmlM8NbqcpSj59JOvHJYtylp?=
 =?us-ascii?Q?Uz0LtV49EHPeGjjhLxumPiQ7ZKpSdX/uwixHzH2vkfLk0srZIDVdmNwuaGGH?=
 =?us-ascii?Q?kGLnf3As7QkUmvmYDcsAn0QDCpWNlw6hvtkKFEINU0PshSJ+2Ilr4VlK+li3?=
 =?us-ascii?Q?hqtzowsyaYvXZFRisKj5RyVmJqHdnlNBQzFDzVCaW3n7AtEOeW/gjFToT32Y?=
 =?us-ascii?Q?96GRJoUdJGJCgmD80ZgRYGKl7ayFV2TrWUktkWud1iszLcQmYOe2NiMk6nNW?=
 =?us-ascii?Q?SpA9rCgI8ze1FDRJ+hOZP6b1NAYyXq5pHKTvLrgY/LiM1V2xa2OUUkpTxDKN?=
 =?us-ascii?Q?znQhHBpbGCZhRDFfl4x27mKKjmtuICYSPQBBldtrdxG/eiQuiRp88O1yCKXg?=
 =?us-ascii?Q?jT4Qe1nRjAlf1LKcem1YhEiA5xo2vVVM6ktAAAM4pfN6g8MmkZH4LrKwAh/Z?=
 =?us-ascii?Q?g76mqC/ar0BCnMPuRsdhLGvVRRXcX5LI6rXoi7wp7G7Je4JONtWrvQ/Aoxu+?=
 =?us-ascii?Q?x0S6x8J2sJWiLKuDgUg6dDZx910lMTf2nSitUUjFfJYRj0q82NlAY7snINJ4?=
 =?us-ascii?Q?qIGKWKPRGUTL6cBM/9/bgi/iML8GVWScH7B1N1D6K1Rp7XfQwFylO4tCfmbK?=
 =?us-ascii?Q?D8cW5tAWfAW7/HfA30A8sMX4Trt51TJOrxqTg7Z4f9awz6FJluqCTel3TLWT?=
 =?us-ascii?Q?p+I+HYbbIe/mRWWl3Wts3ux7CqNe50GKvFisGmMiyIZDUilDRFwhMBvWqhqF?=
 =?us-ascii?Q?hWlAmDdwSYqxAmg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:12:38.0591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f56bba-dbb6-4681-97cc-08dd1610cda1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121

From: Mario Limonciello <mario.limonciello@amd.com>

There are certain registers on AMD Zen systems that can only be
accessed through SMN.

Introduce a new interface that provides debugfs files for accessing SMN.
As this introduces the capability for userspace to manipulate the
hardware in unpredictable ways, taint the kernel when writing.

Include a kernel parameter to enable the debugfs interface. This is
intentionally left undocumented to discourage use of the interface.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/20241023172150.659002-17-yazen.ghannam@amd.com
    
    v1->v2:
    * Use TAINT_CPU_OUT_OF_SPEC.
    * Add parameter to enable debugfs interface.
    * Validate node input from user.

 arch/x86/kernel/amd_node.c | 99 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index ac571948cb35..b670fa85c61b 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -8,6 +8,7 @@
  * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
  */
 
+#include <linux/debugfs.h>
 #include <asm/amd_node.h>
 
 /*
@@ -192,6 +193,87 @@ int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool write
 }
 EXPORT_SYMBOL_GPL(amd_smn_hsmp_rdwr);
 
+static struct dentry *debugfs_dir;
+static u16 debug_node;
+static u32 debug_address;
+
+static ssize_t smn_node_write(struct file *file, const char __user *userbuf,
+			      size_t count, loff_t *ppos)
+{
+	u16 node;
+	int ret;
+
+	ret = kstrtou16_from_user(userbuf, count, 0, &node);
+	if (ret)
+		return ret;
+
+	if (node >= amd_num_nodes())
+		return -ENODEV;
+
+	debug_node = node;
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
+	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
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
@@ -239,6 +321,15 @@ static int reserve_root_config_spaces(void)
 	return 0;
 }
 
+static bool enable_dfs;
+
+static int __init amd_smn_enable_dfs(char *str)
+{
+	enable_dfs = true;
+	return 1;
+}
+__setup("amd_smn_debugfs_enable", amd_smn_enable_dfs);
+
 static int __init amd_smn_init(void)
 {
 	int err;
@@ -259,6 +350,14 @@ static int __init amd_smn_init(void)
 	if (err)
 		return err;
 
+	if (enable_dfs) {
+		debugfs_dir = debugfs_create_dir("amd_smn", arch_debugfs_dir);
+
+		debugfs_create_file("node",	0600, debugfs_dir, NULL, &smn_node_fops);
+		debugfs_create_file("address",	0600, debugfs_dir, NULL, &smn_address_fops);
+		debugfs_create_file("value",	0600, debugfs_dir, NULL, &smn_value_fops);
+	}
+
 	return 0;
 }
 
-- 
2.43.0


