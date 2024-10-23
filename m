Return-Path: <linux-pci+bounces-15143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 217439AD2BE
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 19:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5BE51F2188A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 17:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A85B1FF60E;
	Wed, 23 Oct 2024 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wr6xGLLb"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F981CF7BE;
	Wed, 23 Oct 2024 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704152; cv=fail; b=jwVZR+JrmfJ87gJJCUgpC+5wwEnhjBxMDtqmpqAzhGmtKdfjTMZOx2WcojlQtQyQtJAGO7o9d97MyG9ZDPUC8I68KzUqpFKE+SGO4knSOZfRAlu3Xxmnyf+xazL0BHnXKoCr49wo0jgPmnfXrh8+27UsU5rHruGCkKzLw5nwjao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704152; c=relaxed/simple;
	bh=cpaHQNQYKWIBagKXMosbcIT0AOvTwGwycNobHnSYdBQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHuZAvphoEUrufOMAB3t519/TMIyD+Br47Soemf4Gq1NmfP/+GMVEIzAFx2KG8giYe1b/fMWzpHM6OEfsiy4Zqc9P0J6nusvCg6+cO7kX1ufqNx7EYyZLP0Zf/SECrGH7VqWfvGadZOkYUPVEClVLeSVETc3MrV68ojlYLcZepc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wr6xGLLb; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yo17bFs+KCihdj7WeRHgeTNFyNO6cPnNllWGgNL7Xty+TuuElnAGB04ER0nXo66UrKTHGLmgMEfYhN4A1HLTeL1SqgNPuRYVfdW8kBTGxJIUfsOJuZSR3DvMt78RXtB4NY8uxsMQisouwyFdVOfB3lnDujz5YvOjqA8yeV9bZBOuGtRTysnxV/cKnM1l6+6NOgdPmAzfGWtXUGoMgVR6gRAQ4JMV/HPVbQABJQvylPwgYiTWYh1gpF8NthBpnQMqS5XAr94nHM9gi8dUSX/JKRw61wjrRp3svtp/yS2v8Wuw7dpW97sdGnhwBDZgjzaArnDhXlijCLghTDZjokETzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLuTE6hriWkKIFDMSY2Dh/W7vTymR8HiXx5zbjYJhIM=;
 b=WikrF+b3jZw+rA5h3QUyUyyLEkv/mbt7IuwdLlxhh3QKfGa/TG+59SAHk0VhKUohHgX/uytYJBXE2OEldVhFWeKO2CS0ZN117trmA/JHtelFPaypORJuQsWqRJUOcwqTEKbN9gmLG6W29s5ajYgYIFSnO99q2kq8haP6FVhB8nhJB/JztgrD9V2+acz0s6bcUM9SS/0DQKlfw3A9C4v/NxGfsNq+l+ES1IglynJHAs7OWh/Wjn83OJLj3xGKVhgMXvqYK8Vuf2cey3ZPAe+NYQFX4trEHLPon6OtrtFXZTPecj+Poeq8g2ChAKrsq0lTTBc1dBmWXg24QX385P+Plg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLuTE6hriWkKIFDMSY2Dh/W7vTymR8HiXx5zbjYJhIM=;
 b=Wr6xGLLbK/9JYKeRhDAIUk6WxQCcWqu15+JeTBphdB9yBWsIiR0AxmMGVobugzPyyYo0CoVE/NtoTUHT+CTwRf8r3hCzGKgQhjAMC2PfRgF1u3ImVi5hsFvKQ9GNlpAh6sOjHYXdhaOeV0MPvVBI9h7L0vHadk+wZUTuveS2HNY=
Received: from MN2PR01CA0058.prod.exchangelabs.com (2603:10b6:208:23f::27) by
 LV3PR12MB9259.namprd12.prod.outlook.com (2603:10b6:408:1b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Wed, 23 Oct
 2024 17:22:26 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::ec) by MN2PR01CA0058.outlook.office365.com
 (2603:10b6:208:23f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 17:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:22:24 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:22:16 -0500
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
Subject: [PATCH 15/16] x86/amd_smn: Add SMN offsets to exclusive region access
Date: Wed, 23 Oct 2024 17:21:49 +0000
Message-ID: <20241023172150.659002-16-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|LV3PR12MB9259:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c1b791-fff6-4f27-6908-08dcf387427d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZzfoPRc8a4rSSqYFak2+FIrfjpON1jXSxv3QIaQhkWsR8+pPSrJAOxfMHkCY?=
 =?us-ascii?Q?qkrnxQgWWd1aiu3h/J6oeu/uwE8jllDa4BexaimZWKtyxzqAPSPs6PUfVn5P?=
 =?us-ascii?Q?qt/TwcmG5AGxiMCraqQeWBgDJwJYskSRpw9NQUIk1JsOLpGFCjDo0MT4XbFP?=
 =?us-ascii?Q?JfGKBAbRIOIvZurv1e31SVxNaHgFPMJa4XDnX3dG50tCMLSzdUnlKF4JFfc6?=
 =?us-ascii?Q?bASL7/lmgxGPD9Jzh/X6KLpmEFhD9D9fSTSu4Ie06V/L9SnNJldixNzNoQoO?=
 =?us-ascii?Q?XPKKb6QxxxBr3svJPz5rBmV+65665lSKZKQURAeVL6/tI7AxiK34W5X/SKf/?=
 =?us-ascii?Q?Ax/Ddio9P0CLU8QlQAcwuv7lu2k1zsYIP/VB+a6iEqEpdYxR1twdi8joLOdC?=
 =?us-ascii?Q?SztNX3NarRk07+lbuHM86s/cZL+nGsacKxCNKkh3Nb3aW44ZY7+zXrT/ORd0?=
 =?us-ascii?Q?XaZe9f9z54plTkcAAfWNaqsxmv9Y8DpYPv9mDCod1xZCLgCy0+Slfkry6bHW?=
 =?us-ascii?Q?IPAP6I2gA2n1dUFbZ4ibH6u5VvaE39F30fYnBpPCoP10oBpBt4Sm0mNIBSUH?=
 =?us-ascii?Q?DyHlGrJ+VI3Yb5de5p4QyTxcHh5ECCjMD1D01PUfo6YgP9litL/1Q5hFAotG?=
 =?us-ascii?Q?IIvkQ9ta2zxbdp1ocQLLsAPAa2QXtMidF0GMMdjbFHblx4n6eeaADNeN66tk?=
 =?us-ascii?Q?nX2X5h6YllkZVcwgKtnGoLUYbEX2XTAe/RuLm7HY8qniN/9Wt2U89+Ta0xxU?=
 =?us-ascii?Q?nBRtuew8vfDB5EWocPakEAwaORhvJ9MRvA6Bgmb6Yiv0KebXv/IYZ3nHss8v?=
 =?us-ascii?Q?JNwKveRAbtcwxBeykASkexkGJDkFPv+E8HxUkdcgV6UJ7xjZ0fcwor9M9OJJ?=
 =?us-ascii?Q?gUOid08mhbDt3mNfaDAdDfb8WmdmD7x2Znx6zUuECP+mqT2sCAE/slgG02yN?=
 =?us-ascii?Q?VGYK0ZERIei0ABOeHjPT7FKp9qAml1BOmdWgwIDDoblqy13dR5VZhh2ybS/0?=
 =?us-ascii?Q?jdjPFfhwag0QRs0NPVQo9bbTQt3WdqM1UFsfUk6reAIE+DwM9U85+uC2so1k?=
 =?us-ascii?Q?1Vy9Lhj63haLn9SPRn3JVRkVhYPRkBC2g8P9uOQOs3h/nw3IVl+qJ3H/nkI9?=
 =?us-ascii?Q?w2nwxz+WH4vG/VKxuabSTVlaOwFEYHQK8pnTlvwUB3ifPKmcefsM6MeldfHf?=
 =?us-ascii?Q?rxeqlXJGIn8oSEwzemva+1T8RrMEftcta+u0f/wCViUEKcqMiCbPVNBp0Abj?=
 =?us-ascii?Q?/1/4M3zI/lMAhAbZTDOyzV3HvuEAFmru502+GGhW2oVIpHUZTYlKPSAZfg82?=
 =?us-ascii?Q?pRt7/xOdpakSvJCzv5R4LDJmSMenW1ReFBPefFkK3w7JAc3Y4xdg3gYGgO2s?=
 =?us-ascii?Q?5C4kvnryb1INbPG4Qt3ojmD+2ZECljVr63LDCV+Yj6hWrpFMWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:22:24.0011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c1b791-fff6-4f27-6908-08dcf387427d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9259

From: Mario Limonciello <mario.limonciello@amd.com>

Offsets 0x60 and 0x64 are used internally by kernel drivers that call
the amd_smn_read() and amd_smn_write() functions. If userspace accesses
the regions at the same time as the kernel it may cause malfunctions in
drivers using the offsets.

Add these offsets to the exclusions so that the kernel is tainted if a
non locked down userspace tries to access them.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/amd_smn.c | 41 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/x86/kernel/amd_smn.c b/arch/x86/kernel/amd_smn.c
index 527dda8e3a2b..aeebd63234f9 100644
--- a/arch/x86/kernel/amd_smn.c
+++ b/arch/x86/kernel/amd_smn.c
@@ -14,6 +14,7 @@ static struct pci_dev **amd_roots;
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
+static bool smn_exclusive;
 
 #define SMN_INDEX_OFFSET	0x60
 #define SMN_DATA_OFFSET		0x64
@@ -72,6 +73,9 @@ static int __amd_smn_rw(u8 i_off, u8 d_off, u16 node, u32 address, u32 *value, b
 
 	guard(mutex)(&smn_mutex);
 
+	if (!smn_exclusive)
+		return err;
+
 	err = pci_write_config_dword(root, i_off, address);
 	if (err) {
 		pr_warn("Error programming SMN address 0x%x.\n", address);
@@ -123,6 +127,39 @@ static int amd_cache_roots(void)
 	return 0;
 }
 
+static int reserve_root_config_spaces(void)
+{
+	struct pci_dev *root = NULL;
+	struct pci_bus *bus = NULL;
+
+	while ((bus = pci_find_next_bus(bus))) {
+		/* Root device is Device 0 Function 0 on each Primary Bus. */
+		root = pci_get_slot(bus, 0);
+		if (!root)
+			continue;
+
+		if (root->vendor != PCI_VENDOR_ID_AMD &&
+		    root->vendor != PCI_VENDOR_ID_HYGON)
+			continue;
+
+		pci_dbg(root, "Reserving PCI config space\n");
+
+		/*
+		 * There are a few SMN index/data pairs and other registers
+		 * that shouldn't be accessed by user space.
+		 * So reserve the entire PCI config space for simplicity rather
+		 * than covering specific registers piecemeal.
+		 */
+		if (!pci_request_config_region_exclusive(root, 0, PCI_CFG_SPACE_SIZE, NULL)) {
+			pci_err(root, "Failed to reserve config space\n");
+			return -EEXIST;
+		}
+	}
+
+	smn_exclusive = true;
+	return 0;
+}
+
 static int __init amd_smn_init(void)
 {
 	int err;
@@ -139,6 +176,10 @@ static int __init amd_smn_init(void)
 	if (err)
 		return err;
 
+	err = reserve_root_config_spaces();
+	if (err)
+		return err;
+
 	return 0;
 }
 
-- 
2.43.0


