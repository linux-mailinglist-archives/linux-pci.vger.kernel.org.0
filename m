Return-Path: <linux-pci+bounces-19474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0390A04C70
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 23:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 277C23A56C7
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 22:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06951F9ED1;
	Tue,  7 Jan 2025 22:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sOUG7IuE"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DA11F8F14;
	Tue,  7 Jan 2025 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736288960; cv=fail; b=r3QoOqiNpB8OoFV5v8Ew/Aw2e8Nj+b41dswwHMUGluNRj2AU8E+FdCSws/kJf3/XAkNSRgnsBgp2lfJlrNyDbjD9LOmhVRr4XwStmrBArOTBpfzw7hB0l8kdcN53PlWquJtdHdvCjXkgCCaTqXvpd5kWmcBKDuLGlfWJJAhY6Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736288960; c=relaxed/simple;
	bh=lUEFVKarRqYl7tVRnuju57D5q/Z46DIQVBBMGMJ4Axg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpKFdakX2exv5Z/uNdbDaiTiRoF0EldXTcgiEIoLmd0qPafm3doPOx1VMo2kkqvPSIwaMo8WydDgHX8UINmMQxcK1du/iEM/kp579j9L5wzT1JstKCuRH7ji3w4qM4OJIXovQMuys6mLavDZ1xg8xDr8NEZULuasgCP02XsAcx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sOUG7IuE; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjC+JgCGkg76qWh33vnNFHc/5HlySucVoud7dSm3F2IWVFj6/8+y0cFAJJEddQIoM5AVKeNlRDjyL1itiU+uULZGSDco49dUJHmi3ySMo4qLPfVWoWELwM5Ck4x9ZVx/MX9PmDN6lrw3y0HeemxEU4saZNNoGn0IgMIdfVYaQ3znPaIOSL4t/mQAUgN1E4/YJcEyso98W6Rc4UKxAOTHMadpr2/YG16RyfznjchWeg9Il53D4uEKUbV4XMCffoEDTPgnyuBeQku6ynrXzkc+zWsj3hcuZ3NwofJ6hgfcsOa9+ZZbZf2QCBrQ41HsfLSa3hIVWCe3fHppvoi6JNzk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALVdRDDyyDGpIrHpVDElUdbMdY48dCoNtEHGAEApybA=;
 b=MZ7ZWoQV50k4na/ERRDfWpi9l0isHBiccg+4L/IAX9D3D6KE7lyHCC7gyFHGy7ifZD62smISDcyfO1J0GlJSdXp2ZBV6EO0DEXXV9jBnNLSFo3ChEsupWz6if4agcUrUFU3usZXPXZvr1QYYcxNvFzSCD5fDltT2lRJ0kq5Q/5TYQTr/wYyQhtDCXyimCcmT6nXQ/tlP2A+sH3TnOauY93aMTR3szMXC43XACty7607Pci5r6NdQ+vlWErkfGXGouMrltoAyNomq8mit38JGz7VKiYL2Ky9DGpD4nc9LSrtLYht9bBjOq2h4yibQ2aMvkTow920d74Rdk+J/x7qwgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALVdRDDyyDGpIrHpVDElUdbMdY48dCoNtEHGAEApybA=;
 b=sOUG7IuE7F+vslr+9lQR8MAvNGlytJjP0Z27zdcEsYcBH/S5MOF4TaGiZ9zGW55wHCyiOpZp6dhCchyRNnq+kswAWeXmp1cKlpu5WJybXXGtTxdkokcBukm3FReTPHw9Re0MQmyHnfU6PTTqweYnKDnP57gy67YPl5mmAv7Llg0=
Received: from SJ0PR13CA0240.namprd13.prod.outlook.com (2603:10b6:a03:2c1::35)
 by LV3PR12MB9440.namprd12.prod.outlook.com (2603:10b6:408:215::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Tue, 7 Jan
 2025 22:29:11 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::fe) by SJ0PR13CA0240.outlook.office365.com
 (2603:10b6:a03:2c1::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.7 via Frontend Transport; Tue, 7
 Jan 2025 22:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 22:29:10 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 16:29:08 -0600
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
Subject: [PATCH v3 11/12] x86/amd_node: Remove dependency on AMD_NB
Date: Tue, 7 Jan 2025 22:28:46 +0000
Message-ID: <20250107222847.3300430-12-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|LV3PR12MB9440:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4cfa3c-ca13-4cc8-1eb7-08dd2f6ab50c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hvf6UaNayOUiKy5QcO0xQQ1jF1CSzL3k9NZcypL9FAgS90NkzueQxRMFLAIK?=
 =?us-ascii?Q?hYt+L3hyIG0zhcMw7azqMxkvTii5BGdwppIagtVwrRJEunIGpmr4eVfqjTZp?=
 =?us-ascii?Q?xe0dZqJhYl1K/TCJJhpnd0MCZoGrct77Azb4+cLo4XA59bwfecdhOC8r/7aj?=
 =?us-ascii?Q?Xy2HvpPrWbzJSBdZgBYq7Rjgzr0nXiYoKAyc1CbRxE6kSU5qCC4rOEZkxkaN?=
 =?us-ascii?Q?UGlGPjnnsC6DL7o7L3uJOmGzoCS7YZrw9uNrmeIzh3LZAU0FhyUENWyZ+w3C?=
 =?us-ascii?Q?9E96EmtZWdc5vXyHAnr6fHzoSL57NkCCidgeyxRnNPq+4+Zu3N5FBnGGeSAF?=
 =?us-ascii?Q?pGqqOQmCniFnfgBPkepK5SxBwlUvGCM3UClJrOi/z37M1bV39qRTo+lhsNwX?=
 =?us-ascii?Q?1UUqEsuop++gFxeCTT8ya+5cnWcDAguu6/MVp8bQdU0FmsqNsXWl1SDAg0ME?=
 =?us-ascii?Q?1pWechdnZhH5Stn8LElZBHR0lrX07BQd1KabvNJDfR/uzyBDhOy1wSdixqOo?=
 =?us-ascii?Q?2XVpo3tgLZEoMXS/vsmNivBDB1MtvV+94xY/q/ijBtztNLsxHvaSEam0JAAR?=
 =?us-ascii?Q?15yvFfIo3DpZmZeMH69nKIX9vaa39mixI9JTKi0cHuF+jM7BtFDiF99mDe8t?=
 =?us-ascii?Q?Y0y1fuN3Qwl0VlsWEJzyrJvy1wNkYffkKL7d29Xd74ioHlT0CK/4meGpcXlK?=
 =?us-ascii?Q?eWIlpd8e19a6vR1oVpW7whMAq81rFSi/S/04aioJyPU3LD4pCvbeijTWuA27?=
 =?us-ascii?Q?hgDlIsE+WORpoPYc4moRWC9Ln0lmwsbiChrWi0dkW9FKn02bOI5OqlDydEn2?=
 =?us-ascii?Q?Y1+qnEgOLcUPKJFJlN+JTsL8YhOI0ExKKvJx5ltNBe8qHJ738D6iX7C7Y/r6?=
 =?us-ascii?Q?luFOaWA9lnvhoSvXgK513MaGyoWmb0tVslQRJopGdjTcwLoPZDBV3MicI6vI?=
 =?us-ascii?Q?YRfWAzgG6KUug8pClsyFMgkGUhFNNyopHHw+dbxWw6PkjZPZvAlxmgRkr3Bu?=
 =?us-ascii?Q?wuzBC++ay6AhCW18xEiml1OElB8gYpU1NBKmoTFYQHXAvfvLe9jDJFiPcOxV?=
 =?us-ascii?Q?89d4xJpN64Pxk54mW0Tla5hJyOCEpZG/cEIXAM88mm0NOEcccppSYqTRZkQj?=
 =?us-ascii?Q?jwsGEqncYElhOdxXbrqn5r+/gImUxCFQLVL7TwfcFU1BT+arKflGgeXehTt1?=
 =?us-ascii?Q?T5Yn1+IJYcdqFToPFigZpMaORVye/JRz7PbVbd7k/7le2ap0XUbU/APxwc7s?=
 =?us-ascii?Q?lBLyZNZNl3ppVTR546JGmfom5G1T9QcmNKEtp/72CDxSwLacv8xpGlRr6NtP?=
 =?us-ascii?Q?vG3dfaNjp3qkIDtdYUQi54WvfC6VWIMCB5jeCERyluGX2Y/8fsgDzKRia9DH?=
 =?us-ascii?Q?Ykxiq+OhxZRM4Xv/UJugO7bJs6P0syJ3Bx7ohkXK2gvlUU3QPXetSLlhZuhW?=
 =?us-ascii?Q?jMznhRcrfgYieCIyJa2QPQL4u/21K+ynsgJYuLsXkHi19jLsbwJo5vbRmT+N?=
 =?us-ascii?Q?EMqbmTbSNH/VVZI3PmIehTdRN3TjPVYBCZdW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 22:29:10.5426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4cfa3c-ca13-4cc8-1eb7-08dd2f6ab50c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9440

Cache the root devices locally so that there are no more dependencies on
AMD_NB.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-13-yazen.ghannam@amd.com
---
 arch/x86/kernel/amd_node.c | 42 +++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index 0cca541e18d5..45077e2e6f2f 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -8,7 +8,6 @@
  * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
  */
 
-#include <asm/amd_nb.h>
 #include <asm/amd_node.h>
 
 /*
@@ -90,6 +89,8 @@ struct pci_dev *amd_node_get_root(u16 node)
 	return root;
 }
 
+static struct pci_dev **amd_roots;
+
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
 
@@ -135,10 +136,10 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 	struct pci_dev *root;
 	int err = -ENODEV;
 
-	if (node >= amd_nb_num())
+	if (node >= amd_num_nodes())
 		return err;
 
-	root = node_to_amd_nb(node)->root;
+	root = amd_roots[node];
 	if (!root)
 		return err;
 
@@ -174,3 +175,38 @@ int __must_check amd_smn_write(u16 node, u32 address, u32 value)
 	return __amd_smn_rw(node, address, &value, true);
 }
 EXPORT_SYMBOL_GPL(amd_smn_write);
+
+static int amd_cache_roots(void)
+{
+	u16 node, num_nodes = amd_num_nodes();
+
+	amd_roots = kcalloc(num_nodes, sizeof(*amd_roots), GFP_KERNEL);
+	if (!amd_roots)
+		return -ENOMEM;
+
+	for (node = 0; node < num_nodes; node++)
+		amd_roots[node] = amd_node_get_root(node);
+
+	return 0;
+}
+
+static int __init amd_smn_init(void)
+{
+	int err;
+
+	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
+		return 0;
+
+	guard(mutex)(&smn_mutex);
+
+	if (amd_roots)
+		return 0;
+
+	err = amd_cache_roots();
+	if (err)
+		return err;
+
+	return 0;
+}
+
+fs_initcall(amd_smn_init);
-- 
2.43.0


