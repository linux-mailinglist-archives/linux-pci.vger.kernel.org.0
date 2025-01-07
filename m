Return-Path: <linux-pci+bounces-19465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BE0A04C3F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 23:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B8D1664FE
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 22:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D761F471C;
	Tue,  7 Jan 2025 22:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lPRZd6uK"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709F71E105E;
	Tue,  7 Jan 2025 22:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736288950; cv=fail; b=IqT0Nw2T8HXUndtJrX2HYu/rOGvxxRIR0ZRpo8kUqfALxfgSEpBcXscRIXKAAA51hzpcpRyLaFo30LKq2fhsE1Rb0mgu7Y+XPd2PxlspoQYYtz1PRPBh3tFMexaD0fxBKKzA+B7Sltc1QM9JUU0ySZCUDn+R6XU/dbNK0J4mKhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736288950; c=relaxed/simple;
	bh=Zv/sGnkSOPIBgUsbdbUCu5LDnghIa3/exLXpI+zMizw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CaKpLauZQ2eX6+rQ0wwiWIK6vaQn03fVku9TOinlunJLPk/GmnwhWReRUaskXxCerAttDLCONfXa3+8uzLf0/dZAXW/deDAvG1VQ166X1Xp9PqNQcC83WGeYRf9r1huqDe2AbcIOaSpfEI91QGD1RwScUbb/vtyrafxXKXvE9xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lPRZd6uK; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOo8WjfFILrZ51xEoz0AX5QB8xFpCquNx9Y5ZyM7oJ8ilChrPa8GqBCF6h/mHoY/EJgwWgzk/t0pVSMqOwWlhEJx3zKr01u1krwOg4g0vLD5jKWo4+rrtTE4HIH8e0fJdA501fgY+DoTylj3gs4rokfhYCwgr1nK5BCn3vpP69tOk1dauEC4Ym6IBozntFt6dS/PbWyidRrAdW7MiHK87V58EJBo+2DBhif6IqTB6A2y69OPzJXLz6wtLZbshjZTxD2WblS6+aDRQnzprRGBsn2ge4semZwpo3s/mD/Mjgrr/7xRgge93TnKHMWmXwpAuhsY2/iVOywyz/pIT7FYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Am6mjZ2Meg3W4mpiqCzZgyM/3RHma8t/sagRvXgdH0=;
 b=iVVOBtJfVj6GeEDqTwo4uRXHbIVz1qCio+o2Xg3SBbwFNxaQsyn3zvi9Ap+uCdinCefg0Xf4iSFg8Nl2jo4Q2HrmJSNSSa6M8t8hXOSKHTUKgtrnzHpnyMv1W+TBIsmIsXBR96A8hXg+eExsUm/9GDW5dhoIt2b2x+UrgN6EO5/aB4+uUzsdlBdKjtkXEu3xtTZiIeJXkHeRAHw9oQQLJsnz3CtW4aBKOnCEOgixNnm7pJPjfG1DN+avGYTNCBWHygM7juhqjhw+rbwXmsyU4KkABlVu3ih6uwYFnhDn8uGA3fyqmN8+IVpDxeeKtZ08BD9HIXtA/JNrPJ9MarvW+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Am6mjZ2Meg3W4mpiqCzZgyM/3RHma8t/sagRvXgdH0=;
 b=lPRZd6uKxoJf7Hlg0P0LfRAkqPfJoNBL3fmcbEi5hZuXkpJrefIDlKeSv+AXfZoAu7rbsONLw0FohqspIBzISrsFOePpI2olipKRbambvzA9CTzMoSWs/97GtaIQ3KgRzmctviCD3ZYMya04rCaVQgqk0jUcgMOerfYP7b1WomQ=
Received: from SJ0PR13CA0223.namprd13.prod.outlook.com (2603:10b6:a03:2c1::18)
 by MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Tue, 7 Jan
 2025 22:29:02 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::e7) by SJ0PR13CA0223.outlook.office365.com
 (2603:10b6:a03:2c1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 22:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 22:29:02 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 16:29:00 -0600
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
Subject: [PATCH v3 02/12] x86/amd_nb: Clean up early_is_amd_nb()
Date: Tue, 7 Jan 2025 22:28:37 +0000
Message-ID: <20250107222847.3300430-3-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ccc550-84d0-42a6-cb32-08dd2f6ab00b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zJ6Bfrc6PTlOH3kCxqnBCvntXYvCXq3e7Z2Va9Pn2UTopQZN7mcmmH/U7Ars?=
 =?us-ascii?Q?xv5M7blR/tXWYgcV39jKS2U4gy6IFRPZUHpEA6QV8FeybH+qLoxkRUn1XJdJ?=
 =?us-ascii?Q?mOlsal2eFuxKLkogzyiKSN3bp/KcBEY0rCfDrNXfvwAdj27kMEvvwILd+gD0?=
 =?us-ascii?Q?gEoya65YINybjOTZAxnvHpcC82t8fj+Xs/q9m58Byoa16SZQF6ZGX7IEQ9MZ?=
 =?us-ascii?Q?zzOv49vNtbk/RgJwUjqdQr11f1Dl8+iCmpUFqiR7lxgtvnngFEqrHmPRsfdO?=
 =?us-ascii?Q?rQWkDnvSJbJMW3jCV+bcNXez6SwznQKgNerfeSNVwtvG3LW1oFIxEeMtAJpk?=
 =?us-ascii?Q?nfneAWrWx6z9un1L3L27IxEQePJZN8klEzORctIgrKtPoIdoBpn3S8FJzIXI?=
 =?us-ascii?Q?MZXhhSQFJ8T4/WnIYQcovlXArpLd/h46QC8BwBhYY1K/oGhVpf10B328S6uc?=
 =?us-ascii?Q?TpgjdU9C9zFH2wTreI2nHk7aOy6krwtr2SPK5Iu7k1x5DSg5YfjMirwfvKRq?=
 =?us-ascii?Q?yvSEk/GKTM1cUfs4Bdmixf+g8uFWwnwTg+3aHGiRJrlyBFr1UTYbNQJlPYpa?=
 =?us-ascii?Q?haxQM9nEGXR10zMHZRLW+gzLOi++lOFdfSca6npfXs1gtvPGk3sPpR08hhIz?=
 =?us-ascii?Q?H+Ft+BqQjgYIPBi9KizfPG7Xt5VBRsvt7Gr0mcOQIvkTLZM2KiizOstTOt65?=
 =?us-ascii?Q?oH+gmK8pjQOSsXbnay+RjfS1ZM8A7/QJ1VoQl67VFk9tnnXXj0Jcbl0sg6mJ?=
 =?us-ascii?Q?Pe7Nn6yZV3tdxDtxmC1H2LPPqYmSoO81kejIdmWPAOfYY/cELAzwU2VITGlb?=
 =?us-ascii?Q?D0h0bg0HipcFo4czXgf26nnw+K6Dv9LbQgGchGnAGqhapy2JZ3x3NI/eMkDM?=
 =?us-ascii?Q?XWNB7oKdTkUH3wlns1l0dhzUzFgP6k1+oy/for1TiymggpT86gN6xba7aQGP?=
 =?us-ascii?Q?dr7QO2dZ6qHvaZ+/Ks3FlJsIllAqK7tp3xJ1nRraVATeFKG8rhXXzl+sH/uq?=
 =?us-ascii?Q?hLXmxFp3MMyfXy5oemdv6Y4zMRn+HY6A0iH+Yl/2VW7XEjH9QVyDDEBEHxV5?=
 =?us-ascii?Q?ov8pT1rYrLgbG5C0UlC0IeRFTIhYwePyh+BzanBtLRWPxdaKeFOEhi6D5yox?=
 =?us-ascii?Q?DkapqXWLlrybRMZs+g67tNVUjcxGnlhxDvK4gfS6ifA2iPFltfwvuZ20b/Bs?=
 =?us-ascii?Q?BSw6HJt0uveDYC/K9HnxLX2LjsXMrGJVDRq/2dI7UsmDGAFJMAykSwkDCwYR?=
 =?us-ascii?Q?GjhF/zJWc8bsUObCCLv9K51eFu6WuRooVjEupqyuFE6ETvenHXSQk+vu7h7/?=
 =?us-ascii?Q?rfPVLYei02mlDPsVm+Hz1sM/TSjE3b9kYMDH4epLqH7rl4/YEHpGMPFeg1OX?=
 =?us-ascii?Q?Uk8J90f3Q93X9J2HATkm44TFkuATQY2yl6rqaK2rc+I6pDpIV8unulLdGqdP?=
 =?us-ascii?Q?G4KO57pGJpbv2P4OI5yvqNTuoMzSSaXrWc/whsApAwLIRizGhBH8s1qd1wUF?=
 =?us-ascii?Q?noxObtqG17iYJGA5dh/zUE7BHwjXZpu240yD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 22:29:02.1517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ccc550-84d0-42a6-cb32-08dd2f6ab00b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120

The check for early_is_amd_nb() is only useful for systems with GART or
the NB_CFG register.

Zen-based systems (both AMD and Hygon) have neither, so return early for
them.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-4-yazen.ghannam@amd.com
---
 arch/x86/kernel/amd_nb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 37b8244899d8..ee20071ced99 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -385,7 +385,6 @@ static int amd_cache_northbridges(void)
  */
 bool __init early_is_amd_nb(u32 device)
 {
-	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
 	const struct pci_device_id *id;
 	u32 vendor = device & 0xffff;
 
@@ -393,11 +392,11 @@ bool __init early_is_amd_nb(u32 device)
 	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return false;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
-		misc_ids = hygon_nb_misc_ids;
+	if (cpu_feature_enabled(X86_FEATURE_ZEN))
+		return false;
 
 	device >>= 16;
-	for (id = misc_ids; id->vendor; id++)
+	for (id = amd_nb_misc_ids; id->vendor; id++)
 		if (vendor == id->vendor && device == id->device)
 			return true;
 	return false;
-- 
2.43.0


