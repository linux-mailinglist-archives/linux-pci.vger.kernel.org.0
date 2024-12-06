Return-Path: <linux-pci+bounces-17857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B02B39E7574
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 17:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B6016A421
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 16:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E286B2116EF;
	Fri,  6 Dec 2024 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PtLpP+YN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2DD2101B6;
	Fri,  6 Dec 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501562; cv=fail; b=TvHRAJBriIrOF4MBrLZ0Qk4x2C+1mKGba0rNr72n4SvSbpxszaSQR/ovxeuw8FbSEMT5s9O7WANauA5Wrd67hKH4yq9g/k6EByCQhJpGve5PLcMSsIUz1DPEfO0keoR05M3izGG7pPKg5SBz6fFnRQGW7vOdJlP68oFKypI979s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501562; c=relaxed/simple;
	bh=vqzQwMJF9JP9bQWs6+5a8srrKwlPqCtuAWdd/xZesiw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CwehkBGOkV36A3qtJ3STnxWwkQEA35ZTs5uxbBz44jx18Pn+a4zRQqzi8ArKAxG2hdejbbTj1v1ndP5f/8+Nnwlg+LX/q6aXDjVUdFyS9R0PN6EA38e4ZL7Gs9S+/L7NZqGCVZxN6bVyepMIs/xiuXHXbuqTgziRqkU3PuXVzH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PtLpP+YN; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQx+Y9YXkfYKUoXvNcmDfv4WafkQCjfeYU494LetbwsPzREx4gp8b2BU5Y03S3p0EkhEYMpqSDlIEx5RhdD+zQcJtqv1Q9kLtoQd9WzrAV2g6K6Mlh5Y4QmjUimOon+uS9QxAHON8D5717dvttSe5WajjZvx8VNCHpr7q26byr24uftbCBRu58wBvvGgTtniTI/UF/5t1+1vzaj4f2bfhS33eEOvbVOHPUAe4oJvgElcVaVxq3/nZmN4JDAivdIFIRDzpupdfMsZbDGe02/gk/izHtCRrbtVawPbgk7yB9PpqCO+uo1MvCEIfM1ZmnT4JfuxC439o2NkSS9RwzTyQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C++KkPEUXWrS/jmE9Yo2OIssErmMbgM0b0geYt9Kqtg=;
 b=lsA5h5P1RRTLhf9pmEhCoTtF6T5hrb2RspWW0kzzpJ1RGbe4qsVCpbPK21TiJUuS1CCXub+J86LOgyRRlDFEXUvOMxBI+ORh2N9n3s9OYPSEta82QRSlV7uDWGANiey8DZkbmti2M3HLmQm6dl0AlmE21LLzNGCRGBD+M5pKvFL5hU3Li9Fhy3fxK65BYGntu3vfx7ytVbZbEZD3BAd1pj7pxLZBetXTgE1VREwU9qHCtVLUGph8OIwj8qOFs5awTNLupHqUXxyn+uh1Tx2UAQNA4CbuQznWzqA9jgbqaMK0ua8WXAwHdva8uaeiawh60BOiNZCbYjRS2G7Hni6mxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C++KkPEUXWrS/jmE9Yo2OIssErmMbgM0b0geYt9Kqtg=;
 b=PtLpP+YNDJ9d9L3MWW3o8cbJLFV3WbN+KnR7KMOQsD79NNFn6f3+1vkE8GVt8EBVvoFBBfxcPrpseMBCviMPETJu7WMkrS3TK3b/43LYxQYCtYfC+lyF7lQ/7n/UbnKh+VazelPMEVgJuBLg7NvYoM46K4+qJuTs5EAPPWXLfTE=
Received: from DS7PR03CA0250.namprd03.prod.outlook.com (2603:10b6:5:3b3::15)
 by CH3PR12MB8904.namprd12.prod.outlook.com (2603:10b6:610:167::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 16:12:36 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::37) by DS7PR03CA0250.outlook.office365.com
 (2603:10b6:5:3b3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Fri,
 6 Dec 2024 16:12:36 +0000
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
 2024 10:12:34 -0600
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
Subject: [PATCH v2 13/16] x86/amd_node: Use defines for SMN register offsets
Date: Fri, 6 Dec 2024 16:12:06 +0000
Message-ID: <20241206161210.163701-14-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|CH3PR12MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: aea411c9-3af6-491a-8ef8-08dd1610ccb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8+RHHDic/8EpPa1F4MjyL7bT3JgNG1Ylu0YTDtwGlv0TzoEksGnf1Xn2DGAO?=
 =?us-ascii?Q?eO+2mWCgiOD22uT6wwHp6FBxUpw8X89F5PtNWoTvLxtst+evGHEwMZ1nS+Ol?=
 =?us-ascii?Q?OZpn1EzhMXJ2zozoOzORPxWzRJt4CM9L0PRpj6SB3fJht79YACBHeKroDxR+?=
 =?us-ascii?Q?UVI/FfYdsXUTrHRMVIGOaVTZ+qAdgI2MzAKkWZdAHM8K0wv6YJEomkBW9i3y?=
 =?us-ascii?Q?hVFb1EBf/HtTgmCQefpqw935uaIWVQdG5UblCp7dnCg7v/F93IzJfedCtYfT?=
 =?us-ascii?Q?bhetWMFfyBuyfeW3y/+wBqrD8jZ+jQD6sL1O02h81gfRsisbLK3YpsMlqvTn?=
 =?us-ascii?Q?n0CfkQQb9aypIF6cdmhhp2ZtUpYCS9fijr9qhcrev0ZvnsrApuU+M3HFHrts?=
 =?us-ascii?Q?zHZPbYkN8TvRmffQpmVx8DDzM8iXN8WNzwwWoAKHRScT3UFMs7bJ/N0FER55?=
 =?us-ascii?Q?EkVKzl5v1Feft5KpS04dUriMFCGnn1MA6PRIFsIUqXU/f652sWdsG/fm0E6e?=
 =?us-ascii?Q?u5Gr9AeDceAV3mPNjhsWFl9bx0x95lNZhb7J2nl4x17TK/vrq45vg7OZs315?=
 =?us-ascii?Q?S8zSrkWQkUReNl/NgwlCkPYC7dclxWPLSjq5iYloKA7GJn+dECgEA8Hf+UyP?=
 =?us-ascii?Q?gZD9MNzZXQEUSOkJbBqGl4KSdkrcyiLnA/ImXA3TpiZtdORVCUS4ZoujngG+?=
 =?us-ascii?Q?g/2Id0gH4YU0Cs2TuidkPInGucY1CJOP0JA2Lcaun73nW3sGj7eD7QhAabCu?=
 =?us-ascii?Q?LE8pxfDUs69RRlVr8Ca6qGIMzVQz9Lpqfz+5LBdyGujOKQyS04z7pJKp/uNI?=
 =?us-ascii?Q?nSIXgdQ+1TCRF4TRia/C44547yVF0LupNBzNB0V5gGN+8mhSw5nKhwb1VdvS?=
 =?us-ascii?Q?V8opzXes8Bl8KNOLc6nTvm70wYNprMz5cwyvj3WYBVBG6hzwvVDQ6Nab2jXA?=
 =?us-ascii?Q?6Eaug8HABT/oGbX17+pIY17OGiV5p7qb2PWWN8v6PvhFw9By+y9VABN6ysIR?=
 =?us-ascii?Q?XT6Teu8gTwHS2tjyx7qbrsJw/5sbrOdyJ7h5zni97pD7XI+K456MccNug+Pm?=
 =?us-ascii?Q?nqZFnKHY206A54D4Qdc/5ezxQSUzmlb4WMd9adZZQ5n40pkDt5Acg3E41inf?=
 =?us-ascii?Q?OYccuyyOn/vXnqkvv6RgWTUzCiAeOJurGN7aC+58VnC0XbrJ/ukd9utXaygn?=
 =?us-ascii?Q?X7r4fBuhYnCzpANx8AAYlXEIeRdeYTueQFq7K8R2ce5Sy2sAYehLrDFjhOEE?=
 =?us-ascii?Q?5Ygb7AKCD/sds9/MAtgZY/4/4YcFvoyG0+lnxS/VH7VKMnN/HC2H2Lo2oK8t?=
 =?us-ascii?Q?drUn7LuKC0BgjcMtr6/SLvtxLJW5YGi3NGn+P5bG/jxvj/2uhS6N4f+bwQiP?=
 =?us-ascii?Q?TYULN38ru62E1J5U/7D869y1UuYGEtjr4mkzTC+hjfINqM19RlAeD1Jn+6DU?=
 =?us-ascii?Q?WNiFxGAMZOdPBB3K5IeAIwdb00LRR7uDyz21IfbyHFWChsQsVrludw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:12:36.5123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aea411c9-3af6-491a-8ef8-08dd1610ccb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8904

There are more than one SMN index/data pair available for software use.
The register offsets are different, but the protocol is the same.

Use defines for the SMN offset values and allow the index/data offsets
to be passed to the read/write helper function.

This eases code reuse with other SMN users in the kernel.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/20241023172150.659002-14-yazen.ghannam@amd.com
    
    v1->v2:
    * No change.

 arch/x86/kernel/amd_node.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index 45077e2e6f2f..d2ec7fd555c5 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -94,6 +94,9 @@ static struct pci_dev **amd_roots;
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
 
+#define SMN_INDEX_OFFSET	0x60
+#define SMN_DATA_OFFSET		0x64
+
 /*
  * SMN accesses may fail in ways that are difficult to detect here in the called
  * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
@@ -131,7 +134,7 @@ static DEFINE_MUTEX(smn_mutex);
  * the operation is considered a success, and the caller does their own
  * checking.
  */
-static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
+static int __amd_smn_rw(u8 i_off, u8 d_off, u16 node, u32 address, u32 *value, bool write)
 {
 	struct pci_dev *root;
 	int err = -ENODEV;
@@ -145,21 +148,21 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 
 	guard(mutex)(&smn_mutex);
 
-	err = pci_write_config_dword(root, 0x60, address);
+	err = pci_write_config_dword(root, i_off, address);
 	if (err) {
 		pr_warn("Error programming SMN address 0x%x.\n", address);
 		return pcibios_err_to_errno(err);
 	}
 
-	err = (write ? pci_write_config_dword(root, 0x64, *value)
-		     : pci_read_config_dword(root, 0x64, value));
+	err = (write ? pci_write_config_dword(root, d_off, *value)
+		     : pci_read_config_dword(root, d_off, value));
 
 	return pcibios_err_to_errno(err);
 }
 
 int __must_check amd_smn_read(u16 node, u32 address, u32 *value)
 {
-	int err = __amd_smn_rw(node, address, value, false);
+	int err = __amd_smn_rw(SMN_INDEX_OFFSET, SMN_DATA_OFFSET, node, address, value, false);
 
 	if (PCI_POSSIBLE_ERROR(*value)) {
 		err = -ENODEV;
@@ -172,7 +175,7 @@ EXPORT_SYMBOL_GPL(amd_smn_read);
 
 int __must_check amd_smn_write(u16 node, u32 address, u32 value)
 {
-	return __amd_smn_rw(node, address, &value, true);
+	return __amd_smn_rw(SMN_INDEX_OFFSET, SMN_DATA_OFFSET, node, address, &value, true);
 }
 EXPORT_SYMBOL_GPL(amd_smn_write);
 
-- 
2.43.0


