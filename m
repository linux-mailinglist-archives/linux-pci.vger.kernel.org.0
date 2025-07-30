Return-Path: <linux-pci+bounces-33218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123D6B16894
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 23:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D313B9052
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 21:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1B52222D8;
	Wed, 30 Jul 2025 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SqJTjeGK"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EAF1E1A05;
	Wed, 30 Jul 2025 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912246; cv=fail; b=iZf9ADZh+EYCw+1Ml+Y6bFAjDch3PFK76kbLqVt8gbtLN4b0Y6x4YtUUb+wjkvaAGKXEyV0vqtPq6cv4jBKLv0gThoBL+vSfC+mQC6uCfXfuNEDhtjIp2W1QcmKtV1cmU1/xUpcc3Xw8BI7Ad+ur5J/veVNQHyajb9csqyZS6y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912246; c=relaxed/simple;
	bh=9qAv+5ai5tCsXXjkF3KIsoT5GSrJpkeck9hxg9vF0cw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFJ5Ryl5qO2ndWWm4YRbrJENpikBkbBNkE5ZQyMgw8+XTVrJPBtmvTYCyYbdcpVqtvjq+fEc+ju5/ILNFcx+R8miyZxAgL37ZEm6S38XFOVVHbPfYoNJHVRvXlgTxkrMb12Q9aEy1u8eqq2Q8k/7uKEEpy0CWaMMEGXrETXsJaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SqJTjeGK; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZG6hk4japiJevSaLonfd/H74yyjdoEp1LopNPULNKmtCm1oyowZFQTndo7yPwIve2kGAsVP6MqM6xxoA7N0ubMfz9ps6wx1xCfcdVc/qCG0qKfh/tSi8m726TSCZrS/Fr/SWkkN5n1XsuDzaGkXJecb76Ewox/hmADlVe2jXBRvnrhoYtDmmBLCHDIlwaX6PgM6Z1ukI7V8p1+niXliQqwwk1k6+uqpXaas+YW/M/Zlhs9I85QCdJvDoA8VR0PGpsKmUHaj2dYWRfOw76/u9iPtMuiLi9rW+XQqFHR3vSs8h/+MW4Usyp/OTb8E+CjZNKLon9pHINQRS+97Jg+HmFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqhBIsQ8MFf5g7tjNh1qWZr16h7G3knpvQ8hWa5BnU0=;
 b=SZ5MfCUizQSg3ECHncFLNYnvYVZNx8qH/YM9GqkXhqaI5F9Jc/kznVTNVTpLnwk4RB8ZUsZpQiVe7aCFG/jS7umOR9ZOeIB9p2f56Yn04i8+88GEpPWOj39djpOcrUsZ+cg/nwlKR0S+oje8Rz3smKgEsYbxBcdu6kwcKPOXnLtpMfjRwg9C38KpSqnViuOqScVwJ7WncYYeD0Z13ODY9eH66JlLJglJGMtJi0xpZZSG1TOQ1PyGjeZ6Rca4yIoitfOuhUC7XTkeMb4JCIoq4m+JF427eV68ADiw+MOq6elPgg0BxNr6A1Gv+xXeXrOhSukDvFdbx83RpXzNuZ0M1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqhBIsQ8MFf5g7tjNh1qWZr16h7G3knpvQ8hWa5BnU0=;
 b=SqJTjeGKFd4v4qIXj1X7GyLenlXSrdZl7ahau77V0gj1OQzeadJSTab9T3YJ5wVIIibnSf73G3b0xM6gyvnUU9jRgjzwoYuNjRwCP9X9jBxPgzJXpPsDGKs0xBsIxrwj0Ss0UU7BKF3zY5czYc87FFSVERFzhG1a1bKtGZ0IKdU=
Received: from BL1PR13CA0290.namprd13.prod.outlook.com (2603:10b6:208:2bc::25)
 by DM4PR12MB8474.namprd12.prod.outlook.com (2603:10b6:8:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 21:50:42 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:2bc:cafe::a7) by BL1PR13CA0290.outlook.office365.com
 (2603:10b6:208:2bc::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 21:50:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 21:50:42 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 16:50:41 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 14/16] ACPI: Add CXL isolation _OSC fields
Date: Wed, 30 Jul 2025 16:47:16 -0500
Message-ID: <20250730214718.10679-15-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DM4PR12MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: ac608dc7-eb71-44a1-b67e-08ddcfb32148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V9FGW4zCXwB8sLRYp1V4AFnVmxlinzwpOdlQbFobsso5xoWp80Ic5BWvE3i/?=
 =?us-ascii?Q?xKM4n4sbPC2H1GquA7HaxTPWObri23csxo0G7q+i8YRPNe/Gqlww8CV521l5?=
 =?us-ascii?Q?Ij+QmCCl/W6z8RiKC1wJg+7IES8tUj5uavc95Kxmsba4+fpB8rTMsAakjjen?=
 =?us-ascii?Q?z2o2+ioRxfuMJulioAM4TRYRK+dJpnQ9EBDqOeSWf6Wo5coxvXSPxJThnsUS?=
 =?us-ascii?Q?dO2yuQ7Vb34MM/beqiRYV+0j66610TrpAf1PBizpyXhOj221BDyfygWnSg+0?=
 =?us-ascii?Q?sgPWnjzzs3AME2OpLQRJ3chjPWVeV0VcOHWc6D1FoMLpkwNWWi6XPJqUyU1g?=
 =?us-ascii?Q?VpP86f3ZJd4ra6HhQaKP89qYt+TJlNso0uca2Mnxu275lWWBDN1GmG6LZFTY?=
 =?us-ascii?Q?3c3TvJvJZAH0tljiNJMRyPMvWmePApL7Zf90ieU6YnT7qoA4E9jLcxm3F92x?=
 =?us-ascii?Q?scTc5/sjVmLeulMVNBWkFyYErcLzdZhXGBsQA/bAAduc0srHxnPjWAEo95jH?=
 =?us-ascii?Q?FcyX8Ledq6o/lexS6ATrxL35zfvU/BeJaSXZrsRwL4h/N/strsoJ8t0bxCxB?=
 =?us-ascii?Q?HZgCOnHBl7ue9XYoKsTTpJM7j7E6aGC3LKf1Z3wFEpmWQMjGby0Jt9EB2eqh?=
 =?us-ascii?Q?kYJ8q6P39dKQPheDXG4ZmWVMt7aVtaQYpHCTBU0NTeaH8DlbdruQ4Cv1anwD?=
 =?us-ascii?Q?lhvGQ9OxswccBMAvK6AOoHNrwjSON2+dCu+sVStLMO9OOVysRbRyvkJRGmO6?=
 =?us-ascii?Q?rYaELpwP/pMRuc5k/lZhiLE7ldWKR0idA96FCw3jR9KBNtDpBdnWe0mdtBG+?=
 =?us-ascii?Q?GdlrePj5QqqNp4JikNcBybJ+uuY794Ng1yyvwUzf7OHvL+AV7YmEECwAkOJI?=
 =?us-ascii?Q?INcsc4XeJfEAnSii16TCy9emmmdStzu6dzH858N4QcAuOqJjwMh78quR+ohY?=
 =?us-ascii?Q?hP3VE/5fTlIDrb9IicRAjNVNz5BrWm90iS0efa4oDA5/iIiREFvyB307v1im?=
 =?us-ascii?Q?14lbUIf6FG3VeIXuqpmdMuvRDlAPEGI6Bp6lWeChxCtKNz1vEr2VTHE/lK22?=
 =?us-ascii?Q?Q72jOS6vE22LRu+Q//bI6/wxQxcmS5y8X4/poZGpQfPcjxOItlb0jOB5vn5p?=
 =?us-ascii?Q?VAlWH8e5/IYAAGRHw2v3mq0TSlaRGczXzhdRlyjCSIH5KuwtJbnbn+r62qjs?=
 =?us-ascii?Q?Lq8pmp1t3R8VGNyHRHct8ZKqGK7BMOkRxSIGxtZcOsAZHyxfld/WheieNwIB?=
 =?us-ascii?Q?vz9fbK2qiLzcwvyOdb3XvCMbGU9I8O0evpCDQXBMZJR2dNs6ZTamkAAwfukk?=
 =?us-ascii?Q?dK7Zme3/iCbI6eTJQ6LzZnuRmYuH6cjiGsXiTYb5JNdRkDzr60U9l4Tkj9yz?=
 =?us-ascii?Q?FWSxTXPaeARiOzW1hpvgEb+Lgo5U+ILjabff97CSccHjah7RJ+TQhELqDjep?=
 =?us-ascii?Q?ziNTKdz9V5RAsqQrUwt4DLJ1Ax/ykJOZ33qLbYVVu/wePuAvV7YTvw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 21:50:42.0534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac608dc7-eb71-44a1-b67e-08ddcfb32148
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8474

Add CXL Timeout and Isolation _OSC support and control fields, as
defined in the ECN at the link below. The ECN contents are expected to
appear in the CXL 4.0 specification. The link is only accessible to CXL
SSWG members, so a brief overview is provided here:

The ECN adds several fields to the CXL _OSC method (CXL 3.2 9.18.2)
for the purpose of reserving CXL isolation features for the platform
firmware's use. The fields introduced for kernel support reserve
toggling the CXL.mem isolation enable bit in the isolation control
register (CXL 3.2 8.2.4.24.2) and how the host is notified isolation has
occurred.

These fields will be used by the CXL driver to enable CXL isolation
according to the result of the handshake. Descriptions of these fields
are included in the commit messages of the commits where they are used.

Link: https://members.computeexpresslink.org/wg/software_systems/document/3118
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/acpi/pci_root.c | 9 +++++++++
 include/linux/acpi.h    | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 74ade4160314..33a922e160fc 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -145,10 +145,13 @@ static struct pci_osc_bit_struct cxl_osc_support_bit[] = {
 	{ OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT, "CXL20PortDevRegAccess" },
 	{ OSC_CXL_PROTOCOL_ERR_REPORTING_SUPPORT, "CXLProtocolErrorReporting" },
 	{ OSC_CXL_NATIVE_HP_SUPPORT, "CXLNativeHotPlug" },
+	{ OSC_CXL_TIMEOUT_ISOLATION_SUPPORT, "CXLTimeoutIsolation" },
 };
 
 static struct pci_osc_bit_struct cxl_osc_control_bit[] = {
 	{ OSC_CXL_ERROR_REPORTING_CONTROL, "CXLMemErrorReporting" },
+	{ OSC_CXL_MEM_ISOLATION_CONTROL, "CXLMemIsolation" },
+	{ OSC_CXL_ISOLATION_NOTIF_CONTROL, "CXLIsolationNotifications" },
 };
 
 static void decode_osc_bits(struct acpi_pci_root *root, char *msg, u32 word,
@@ -493,6 +496,8 @@ static u32 calculate_cxl_support(void)
 		support |= OSC_CXL_PROTOCOL_ERR_REPORTING_SUPPORT;
 	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
 		support |= OSC_CXL_NATIVE_HP_SUPPORT;
+	if (IS_ENABLED(CONFIG_CXL_ISOLATION))
+		support |= OSC_CXL_TIMEOUT_ISOLATION_SUPPORT;
 
 	return support;
 }
@@ -535,6 +540,10 @@ static u32 calculate_cxl_control(void)
 	if (IS_ENABLED(CONFIG_MEMORY_FAILURE))
 		control |= OSC_CXL_ERROR_REPORTING_CONTROL;
 
+	if (IS_ENABLED(CONFIG_CXL_ISOLATION))
+		control |= (OSC_CXL_MEM_ISOLATION_CONTROL |
+			    OSC_CXL_ISOLATION_NOTIF_CONTROL);
+
 	return control;
 }
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index f102c0fe3431..f172182aa029 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -626,9 +626,12 @@ extern u32 osc_sb_native_usb4_control;
 #define OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT	0x00000002
 #define OSC_CXL_PROTOCOL_ERR_REPORTING_SUPPORT	0x00000004
 #define OSC_CXL_NATIVE_HP_SUPPORT		0x00000008
+#define OSC_CXL_TIMEOUT_ISOLATION_SUPPORT	0x00000010
 
 /* CXL _OSC: Capabilities DWORD 5: Control Field */
 #define OSC_CXL_ERROR_REPORTING_CONTROL		0x00000001
+#define OSC_CXL_MEM_ISOLATION_CONTROL		0x00000002
+#define OSC_CXL_ISOLATION_NOTIF_CONTROL		0x00000020
 
 static inline u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *context)
 {
-- 
2.34.1


