Return-Path: <linux-pci+bounces-19471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2A9A04C5F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 23:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B07A1886AA2
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 22:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1251F8AD1;
	Tue,  7 Jan 2025 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kZsQd3aJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E1F1F868C;
	Tue,  7 Jan 2025 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736288956; cv=fail; b=ATZZbSnIixRaXH1TlCfKA6J7/GmAFk1pylDXlJEgJXMrJG704U7GmaJ8QXr30JvcLGdyLhLbGGVJ/CQHZsaY/+T+Q2WynvRHMIuQTMifkYtH6PJpfjm2y544jlK6rMtZaVnlnBhSA30kTBu0iRpHYZ13PPcO8A4MJQ1ZXRK5Lz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736288956; c=relaxed/simple;
	bh=u2S9aZVe7VkTtPyZ6crvTi07twyxSl63c8v3Cu8mGlM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2Lp93EzpCBydVCCKgl8Kc8paNz1+L6PnKBs2LOWaqVN0ITFTyl6waLZ7uWgN4Tc1nJPlHU6G9oqaa6BlzTcNca/pDLN2lvGnyEy+cHaojp+E0VERqcQISbLBZAwuYSUfwZB1JNJ8RzWYvShkIMG2Ibwza02VglO86saABCNunM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kZsQd3aJ; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7AVVHjfIsn0mFI137Jgo3WEP5HEoaP9CbrrjLsiPqZpaYf85TT18kWajaAE97lRofVKN13fQQsPhH87h2y4BLVBBSR5YCHdKPAif6DltPkYA5ysBQ9P30oiVkHC13AKrrWqivUefVs69xha/LBJWAfIcB3yUT7d98kr/wQNQPyjXVUGHYD4F92/nipC3vevcaKZmjxeE/O5iQVkjYHrUFfiIpYTgtE0t9jlnLjTrM09Vs1iq4a+lqdhPPVOHnTfk5AVibEcBE0aWUz3I36KDnDBgeN+SgoNHnZh+fjP9HHLIn1n2py7ukeGuycflQmTOf99E3pHwJwT+TYqSGh6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASLIZt+8VZEvwznx9Extt7ddUnmIOjinyY2p6eMY/ok=;
 b=nueZA02UfnTFBfNDgyJlEJ8Q6fJPvPfD3XCVXVZ5XP2p2CZqBqWfYuetobioj0GU48oMesopieZN08E1tpF0VxFX14CdmnVTK9MY1drcDDNRHYwCfwrhFa6cXEuWJ0a6ViDn75FvrRx8wovLnoHwIBegLF9kvmjSVSt+yYBmse5mSwhRduuRkjdqZao/UeEmNSx8epszP6qMG+3ovafibtAC1Xp73eD8++i6GYHpbEnnOGKESARy28BxTYeEOZOqSMCNC9SsSfNdmHLLmdj2BHvXGM2tXXS7+UswStswcuwBfOUYjHSWPip3iRwuiZW4DOpqtamwoksdE9+Shf2TYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASLIZt+8VZEvwznx9Extt7ddUnmIOjinyY2p6eMY/ok=;
 b=kZsQd3aJbyhM324xn7oItzyM/REoGTzZhTFHUPZ8efY1phypZo6ReIH+5rVhNTkJVFZny7pIA5ThbNRUcV4oDfr/QjZYeBUGAqo8BOLCupLphjWL5C7johPmnqxvLzWkShkmeP32jeb+eCrI406up4J9gmmGcLDnsunbfKSiJfg=
Received: from SJ0PR13CA0212.namprd13.prod.outlook.com (2603:10b6:a03:2c1::7)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 22:29:09 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::76) by SJ0PR13CA0212.outlook.office365.com
 (2603:10b6:a03:2c1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.7 via Frontend Transport; Tue, 7
 Jan 2025 22:29:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 22:29:08 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 16:29:06 -0600
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
Subject: [PATCH v3 09/12] x86/amd_nb: Move SMN access code to a new amd_node driver
Date: Tue, 7 Jan 2025 22:28:44 +0000
Message-ID: <20250107222847.3300430-10-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107222847.3300430-1-yazen.ghannam@amd.com>
References: <20250107222847.3300430-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: 976f082f-b6a0-4d61-168e-08dd2f6ab401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUN0WGVnSUZ3Wk9kTHM5aCt6M0J1YUgyb0h5ejZIdENsODUzQjI1d3VLOXFQ?=
 =?utf-8?B?TFcvYVJNQ0pHOU5uY1gwSkR1VUJ4VmVQWjFTb3Rwa3hXdzdWc0RZRHBveVRK?=
 =?utf-8?B?eVhqN2l6T2VSSmd2OTMwalBRTlAwSDNHdU5mT2h5UjRvNjF0TEdMZEZsc0Ur?=
 =?utf-8?B?OEI1RzFkRmlTRVBIQjVZSFViaVZNTS9PRjdoMmxGN0NTVWhMcnBJeDlCc0pa?=
 =?utf-8?B?aDJRNUZyWmpDcExqbVFEZXI0TzR6MGFOQnBURUczTThqWmpkbFM3RGxMdHpz?=
 =?utf-8?B?Yzk3TnhRcGFFWG9aUVBmNkxhRFBtT2JLd2w5ejNKSzEvL0Mrc2xTM2lYSXU3?=
 =?utf-8?B?bmVFMGhOM3RjYnFKNkgvYUh3Zm5kZmRLanZkdTJWYlpaek1pOHNEMHBSd1Uy?=
 =?utf-8?B?QTlmZFgwNzMxNmhIckJMd3M5UEJ3dFdYcS9BUm5VTjdHSmxpOEhnM25idDdC?=
 =?utf-8?B?YTVEck5OWVdLM080blllYmd6SkNXWnpHUlQyQUxXUHVEQ0I5U0dyMExmOG4x?=
 =?utf-8?B?TUE4d0FWa253aEFKY0doNDJ3R1N3UWN6OGQvT250RjRyM1FuajR1c0xRdVpH?=
 =?utf-8?B?TFpNM2MrdmdyRThHN2JEUzcwWFdraTJZNWlVQ0I0NTNRcmcwVFcyb2RyM24v?=
 =?utf-8?B?WEVjRlZxcDl1UEdMT3BNRlRuN3MyRHZhOEd6SzBiK1ZYN1VDNHN5M1RONW1U?=
 =?utf-8?B?UEZZUHc4YnkrazhyZjN3VjlaSXdZZUZRZHhReEJBcWxxTkozNXpCQjBpSk9E?=
 =?utf-8?B?VmszS0o3V1RRYng4MDh4dy9SMjNSTVBxa09SMHJmd0sxTW9uMVdNemEvTUZm?=
 =?utf-8?B?WXJhc2lOQWtNWTdwTzgrUGFoNHhIYkhIODRkSko5Mlg2eEM5RVd0eWUzVFZt?=
 =?utf-8?B?azdGMEM1c3RVQkQwV1ZYME1TZm1vV1lqU2tGNjR6akNFOEdabjZsOUkrb1I4?=
 =?utf-8?B?T3dlSmRxS1B1ZEF2WTBmU1V6ZzU3a3pFM3lWNDh4cVAwcmx4UEhwZ1Y1M3FO?=
 =?utf-8?B?SGk5M3MwKzNFUWJJMDdlUmNhcVhNYVBZbFJheFhSTWQ4M3BFNHFYN3BWZkJs?=
 =?utf-8?B?bmQzZFBZVVZzY1FQYlNWbWxCTkJXMTBQOFJxVWpNb2hmd2J3cmd4V1F4dS9t?=
 =?utf-8?B?Z3p3K01CMlVpZE5GODdGTzBYRkZjYksyTjkrTWlFL3gzS2Y3cFkrNVdxM0Ji?=
 =?utf-8?B?Y2w0N1hVTXBXY3lmZEIydlJhQWFhcWFVR1N5RnRPNkNjYTlMK0s1OTdVMkdy?=
 =?utf-8?B?REpqbzhZMXNjMGsxNFlIcGV2OGpTU002VW1QVEpPazNMbFc0UkdPSUI4VHk3?=
 =?utf-8?B?RnFHaUNYQVMwbzBiZnRMZEdSQmVrY2RSVk4vLzZOUmxxaWxMNHJjUS96UWhW?=
 =?utf-8?B?cHcyNEhySUduZTg0a1U5blpEY0lWTzNFSXpGZnBoTnlPcUJtUUQ5ZXlUQysy?=
 =?utf-8?B?cHE3aXpWcldjZDU5Q1B6TnBaMnVpN0ZyTWszZjZoWVRncWVQS3VXUWkzR3JZ?=
 =?utf-8?B?aXN3c3dTUW9aUlhJMDIyUTl2Q1lLMDkrbFNJc2RMREIvaE91YWlTUWZ6cmxQ?=
 =?utf-8?B?WldCZnNZY09TbUZ4dEN3NkN4aU5xU0tXdk80a3BqQVZTNldJNis0cVd0UWxE?=
 =?utf-8?B?Rnc0cG9MWHM0T3RNN0R5Vlh0VWpXUndvb0xQdEhGOHVpNGZNS2RVcFJYSmU4?=
 =?utf-8?B?dU1WSVBWV1lZVmdIZEIzQ215V3A2U21MbXNYanlCY2htZzlZMWhlK0llaUkx?=
 =?utf-8?B?aGF6T3dWbEQ4SWlFMkRDMGxRS2dqbEJPRmJkd2lpcXRJN3FvNUNvcEg4aHlI?=
 =?utf-8?B?OVVhZ2gvam1BVjNsMVQ5VFordHFHY0F2WGZQTEU1azBlRjlxQ3Y5V2NpMGph?=
 =?utf-8?B?TTNncjl1eTF2c01QUnBXZC83dHNYZzVidlpuNDlhcDBBMmluYlJLVytZd2Ja?=
 =?utf-8?B?OEtxMFIzTzRiSXRGOGdsS2dkS3VnN0w1M1FPeU44UHYvMEJnYlpETEI0b25m?=
 =?utf-8?B?Wm1HZEJ0czArWEV3d1NtT053R2lQUmd1TGJETDlyYnNDRzE3SDFMSUNLRzMv?=
 =?utf-8?Q?YVQ41n?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 22:29:08.7924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 976f082f-b6a0-4d61-168e-08dd2f6ab401
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799

From: Mario Limonciello <mario.limonciello@amd.com>

SMN access was bolted into amd_nb mostly as convenience.  This has
limitations though that require incurring tech debt to keep it working.

Move SMN access to the newly introduced AMD Node driver.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> # pdx86
Link: https://lore.kernel.org/r/20241206161210.163701-11-yazen.ghannam@amd.com
---
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
index 290989ab9f72..27a5bc2fc49b 100644
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
index 094c3be81a8d..5e0333534abc 100644
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
index e335d89ddad7..11fac09e3a8c 100644
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


