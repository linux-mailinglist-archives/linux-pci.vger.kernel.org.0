Return-Path: <linux-pci+bounces-15140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF219AD2AB
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 19:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E01A1C217BF
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 17:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082361FAC2C;
	Wed, 23 Oct 2024 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N40Xe0mh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DA81EF08A;
	Wed, 23 Oct 2024 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704143; cv=fail; b=DhSMhWtF52natHkVrBlXk9/MopIyW56q5HfBZ6XsG3ESBcaUZdXJcHNFS7/Qz20OKwL5/0l3NaP8eWKdHo6BRL6jxznq1F43ZprNM3I6cAz5R7+pgdQrtRuKNAwcxnbop5Toq+bItzrDsualbIB1sBTn6qr2We1e9AT63rUWmhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704143; c=relaxed/simple;
	bh=oNlYWQY7SIdywJGDeVYPBLsBue9CDJoG20OFzIlM5Eg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nst0tMM7WlWpMtOO09ta4V2qYYyPz788A0aqhaBepHAsRcaXbHXqL91n8GoCcNBZ9WiISD6/ZIUQwD+/QSFIEa4URPOhXOn/m2ON/2q+QXxxWyiFR8PzENeILYnQU30Kg3325XZhjBRp7Ng+tzbbX1QgP4+lnnsAACfUWX/HSpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N40Xe0mh; arc=fail smtp.client-ip=40.107.212.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5CkwayWZDJqp84AisDYDuxKNrkBq539CqkTMLJXRVQasgZ2kBdRiHFTfu9n6KWGZ4Fp+OUzxYJIBFRfT8KbT9bgoJ0DbTRAbIWW0qyuJVSKq+gGIwGzIQ1WJhJWbqLqf2R+CbsvCJIQCK8dr3pEx734xUfgvjpZxAE9g99LvF9KRsLwJ8uMhpt0F926Ot/S6E+YWkZN4+0gYKr4nghmWiomyNcyLtlhznvsF3QHr3l49L60M6Ruagrn0VATXkFKr+gMJ3bLQzeAMUUZAPJdqofc3egJAdm1HVu5AJVnotJys3GOyv8W/cbQ/Ja6nYap8W458QcYKmcRSFgxfG14Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UomJ7+o9AXJze22cP4TCbcsv+P4M8b5d1LZmzGuS2Kw=;
 b=F4fkiaulNGjlCN1zt0pHHSVwUfmE1NGei1IPqodP2fcUEm+7HS8flTJKNfcMQs/LRGJelqs1VhD/fHvOudDSWrQzEPAIUbfeXEIVF+Nh2oMHmlat+Hs2C5rlPhaysylTUFg1maa6+1R0MhVcJxEClomWZagakuhs6lzS+Sn4ARGUn5iIhEBKM5z3aJjXueZzFGU3HXGnmNH1NmhgcaPGrLyeULJRrm9SoG55jA/sMQWXRW6Lj1pANQzq+jQsxZXoUiVT9jWIBwwfT3f9exSexEn1OyABv/wtmMJ2GpU6mtONstcRvOgi65nNAt+1iWXaBrGrWJgHCTZnQyxe1HGsCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UomJ7+o9AXJze22cP4TCbcsv+P4M8b5d1LZmzGuS2Kw=;
 b=N40Xe0mhjAAK/lsKQYlgZedfm1j3xYWe+yRfhdIoYLW+2ZFnXw4xfHEU+2F/sY5VRV8gGB1Ny7G6t8XUNsFIRSeN3li+guliOn34x8qV2m5fsoUa9prvefAwVbOM+q7dXj3FXSxsE0DiTY17TaPSwHfGrociIFxiNpA5pvsnRNY=
Received: from MN2PR01CA0062.prod.exchangelabs.com (2603:10b6:208:23f::31) by
 CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Wed, 23 Oct 2024 17:22:18 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::dd) by MN2PR01CA0062.outlook.office365.com
 (2603:10b6:208:23f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 17:22:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:22:18 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:22:13 -0500
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
Subject: [PATCH 12/16] x86/amd_smn: Remove dependency on AMD_NB
Date: Wed, 23 Oct 2024 17:21:46 +0000
Message-ID: <20241023172150.659002-13-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|CY8PR12MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 5603867b-a407-4376-b84d-08dcf3873f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MKm+Cu6Be5m+Su91Uf/8vi3G4aAe/sJrX3XS8KHq1iqb6N2ERGNJ82GSpFTt?=
 =?us-ascii?Q?ablo0hiqNZNwBom28+NXOgVDxZXZQuxoR0cH42HBIrVqtxKQKfzUhfoHPz0I?=
 =?us-ascii?Q?GgaZYQ6aMSYlHCbEPo5FB4GK4eYwmA3lOchftLDJK4qkK/A7mdqUAGTNo9Cd?=
 =?us-ascii?Q?ga26pueQYE8CEDXEIFfpjVz6yUh1CIZG0yUS34IZWwUf68L/GgXRf63PXfsf?=
 =?us-ascii?Q?b0JGXDj/2M9eZeZr56iWbadx6UtmZ2bsQ49opV20RaZaTwlWUuG4UuLJIVD5?=
 =?us-ascii?Q?+qnTM17HyD/0LgHxL0c6NOTr1fph8gG+n5au24f+InDQLM/1Qhm32AVmp8en?=
 =?us-ascii?Q?8GJv+dCCPb7qfZcC2kiUChe0Mwc+Ya9imKPmft1V7CQu7kLk6Q/xG1bBFu+s?=
 =?us-ascii?Q?asuZcWbHA6J25BdvS1ju9kuckGCOz/Ak6zbTgglb4PjvUX+JEHuTj2vog2KP?=
 =?us-ascii?Q?ALLHyyKpRiSzQeMcbfpGK4HGbKNq9QDTNdykK8t3K3Ax7/nXPBcOhw2PpuqK?=
 =?us-ascii?Q?9QJdCq1FD6e1Lzo//nOUVN/RkgPQw/BwKb9b3RIu4/GVuf6Eu5nlXjPrZ7WW?=
 =?us-ascii?Q?hgO1hfAX70Wqu0XtHLp0Vmx3JU1Co/1W4rEA6S8eUhjhnbLhfZRJwPqnuwCQ?=
 =?us-ascii?Q?vJzWK09xwnUTrndTCrI8nt78fjINJz1OhVysY5IPQGElG9VbKN6Eefr5wGN3?=
 =?us-ascii?Q?WMvgmt7oA43Y/uKntOzrnp6U+Y6ruwLbTLeQIa37zfRYsnjwxG31T7vvcIo3?=
 =?us-ascii?Q?KKLn75JAnhMVt3YhkAcYh5NOQ8n/euu4YvocyVFuuPsnop33xNwzBZyzVwKu?=
 =?us-ascii?Q?FQ/9kSSu4JvRAV81KKDj76LgvwIf8w5jynlv41EHS0yeeK9+6GjEbPQzx9cp?=
 =?us-ascii?Q?WAHkkCTHE6AtVZm7ZzdevlHUJy5KVbdeBc8dVhe2Bfo7LwkNh4LNO67bHXNl?=
 =?us-ascii?Q?uMUX0w0ocwfYC/H4ZzG8NuOW/XpZ/38fIC/vlHb19v4bo64NKELWFHJ1w9oY?=
 =?us-ascii?Q?D1/5nQmGrYA3Vb227O40r7eyA+KBKNjXE2G0FOCLSrsrsoaM1UdnsLQtA7tx?=
 =?us-ascii?Q?T8zQWkmOEzUrROaXj85MO2QT6KnJPumvNETfIVFcEPv58rX0XqMu2WSOWVNI?=
 =?us-ascii?Q?TUUTDkZo1KOBAbBxk41D4kv2250XqytmBgdHocmwriqsmd6Crt4evDGrw06O?=
 =?us-ascii?Q?JkjQ7qeECCvCNTgF0p/YlVWugvCjpl1fcmuH+HZSS+3Su9qTNdGtQTDujZ+H?=
 =?us-ascii?Q?QXOg/S3y+3+IZt/jQRELDsnVwEXqSkZF3PMEzgg+YjAmZMutL0qUkeFC/DN5?=
 =?us-ascii?Q?06ZKXADVjEWN6fitbRnaTg4hMR5F8Eukg4Zncmd7mZaqbqtJDi9mS//fkTR4?=
 =?us-ascii?Q?TZw+4VDqvRaYm7qi411Ta2Wk1U0xvFIECtmyT3fegKculfjgQA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:22:18.4386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5603867b-a407-4376-b84d-08dcf3873f20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659

Cache the root devices locally so that there are no more dependencies on
AMD_NB.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/amd_smn.c | 42 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/amd_smn.c b/arch/x86/kernel/amd_smn.c
index e53db07d1a77..45cf86cd9014 100644
--- a/arch/x86/kernel/amd_smn.c
+++ b/arch/x86/kernel/amd_smn.c
@@ -8,9 +8,10 @@
 
 #include <linux/pci.h>
 
-#include <asm/amd_nb.h>
 #include <asm/amd_smn.h>
 
+static struct pci_dev **amd_roots;
+
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
 
@@ -56,10 +57,10 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 	struct pci_dev *root;
 	int err = -ENODEV;
 
-	if (node >= amd_nb_num())
+	if (node >= amd_num_nodes())
 		return err;
 
-	root = node_to_amd_nb(node)->root;
+	root = amd_roots[node];
 	if (!root)
 		return err;
 
@@ -95,3 +96,38 @@ int __must_check amd_smn_write(u16 node, u32 address, u32 value)
 	return __amd_smn_rw(node, address, &value, true);
 }
 EXPORT_SYMBOL_GPL(amd_smn_write);
+
+static int amd_cache_roots(void)
+{
+	u16 node, num_nodes = amd_num_nodes();
+
+	amd_roots = kcalloc(num_nodes, sizeof(struct pci_dev *), GFP_KERNEL);
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


