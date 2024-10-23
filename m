Return-Path: <linux-pci+bounces-15137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C12E9AD29E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 19:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE171C20E03
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 17:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780321E5704;
	Wed, 23 Oct 2024 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V/oErfdo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B0D1D90CC;
	Wed, 23 Oct 2024 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704140; cv=fail; b=fqEcjPZNwNaiAxJAppvpExwmgkhdamzKqjuevk0PXimy5yukydMLeeRJz+xsj3F+R+2OmxZRvD29aUd/Ajx2ILSVeZBVychJMGMcp5WtWyTryUBdvjI9SWORCC4bw3cy+LSBb+D8DjwZ0TS02rlz3/6iWKzkNrbrNUWrGAkbHCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704140; c=relaxed/simple;
	bh=vxnUz39tXhaSF/+EKlfjD3GLnCvo3efmW5433yX4jjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=olbMEOtNqpFXJekWxrkFxZ2DkIw2FdTo9YvY+TC2ipa3smI6SzEsI8Yyeh6ox3PxG0MqGcp7R9cMMeyI2VDDi4fIAvpX1dGaXEqYGl0lYgNcUw7Q0vWrp7KiqKz23XXw4+kCVZ0AW5gT+hsrmHFd+ihzuFIFFCrzG8ByNRKdvkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V/oErfdo; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwEgzUTVNtLVUZ4/vPmAXbBdp0PGyGGpWH0phAXHiSiR3Ax+OxQrCYa1i/WhpyKUS/MseSVc5NMB2mUEFxIVCqx76lB0mayXKx4U+Uy0lLeBp27+B8TwWUqahOdXigkvpjPwYcQQbrYqErwsA3cDqvZuZC53LUYQW2CtRuQATycj5PLF30/HaxxKlypvZV9WFWlP1p5sO7FfjOnXyV1yLkPooSDEf4EBEcJEvvK9fgB1UwjnRcqdwpBZLiTN/VV/yvTmgelxZEv+cu997CYN4KBVUzQxFJ8CRcvPu8gBJlvfNV9GvllIFQ56SswFTQs0WICOldQoT41td+wFdpyekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2qEhf+sZ74FtAnmvgJtWbCI+nEt79U6lU9mDvTbpkM=;
 b=ibMmTc+Ix7XPPDzOeOLpEVuagbCZd9eDOjmQHjsDe3ihxedyfmMKjYIxNNhEbfPZa3inDxPsU6ylcqp71BTXeyxn60liBfBaUlMoZbCeCtanvf2irJvPiTCSc4SXLuKearRpdxtq5pU9w4AfuUyWGhKafJkug6Al1Jyc4Tv73T0gjPKMW+qTspjNSQYOTNx92o8mDeak1D01PYvisc/x+s8m5V1ntujmHpvFgSbiUHXme4rEgwMYZSayew55+Ge8cbvTUK251dolQsYRTZFuU/sPaJapikxbqcSDfnr4mQRaH15d8oh46AAI50YZf8XtUHh3b6Y/c/Oh3qk1o9iBJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2qEhf+sZ74FtAnmvgJtWbCI+nEt79U6lU9mDvTbpkM=;
 b=V/oErfdo5vshbdH9hZJaQmu2s/QTxMvKrKUyDhrlwmI+zYvtCaNhmszEL+o8GKSDE6vZvS9oHn+MHJl599mxMwoUJvV/+TaHwrdQiNgGIkARDbkTmkmmLVQWaU8XTisu6TOxDb3qVswP5jmRLZxlaEsUToJg8RDigAB8Z/rDis8=
Received: from MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28) by
 PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 17:22:13 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::a9) by MN2PR01CA0059.outlook.office365.com
 (2603:10b6:208:23f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Wed, 23 Oct 2024 17:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:22:12 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:22:11 -0500
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
Subject: [PATCH 09/16] x86/amd_nb, x86/amd_node: Simplify amd_pci_dev_to_node_id()
Date: Wed, 23 Oct 2024 17:21:43 +0000
Message-ID: <20241023172150.659002-10-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6bd5cc-3abb-4839-b88d-08dcf3873bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d54rLhiJG3GNDVzTDr2vGFWUw0JZYysE9c4Iw980GCpGCllqC2NdgQll27Ct?=
 =?us-ascii?Q?rLSNWl+/lx8WTDElcnfp5VR5Q135/x6hYhHYAHRDWCn9hz3/E6KsD4R6WBKo?=
 =?us-ascii?Q?uZRa0p/pAon4kPt56U/XaWQzYWkvEyW0iLqkXiq04scfaK6wNVbyUpZpmO8P?=
 =?us-ascii?Q?nIA2OOTq3KtRZaRE+66lIPZ4hk6oyAhBhyvNeW5tdfkjIMTmWMx51U64Abds?=
 =?us-ascii?Q?3TlbkSj6wHYfjbnR0CXdxpW9Nj3piWXzRolIwJIVdu6wTyOnWumIPQpdHZ4W?=
 =?us-ascii?Q?ZuRkpTR8lDB62u/WC7gg4W8A/pjFQEIN0tLymGK/ww6fopP+pLo6nKL+EPhR?=
 =?us-ascii?Q?I8HJ4AfbVhyOY7W6IYPsNx9otsetVi1vjhpbgcxnIeFFUFnfzu6ujxLDb2Y5?=
 =?us-ascii?Q?Y//tMkxN7BNmB8Dolt1pxXXT22ca+ZJwBYDUY+ys8GVY94lXjiKXQv2EEPCg?=
 =?us-ascii?Q?RxBii3uFfZ/HzXzu/rkJm5xLFdA68R/n1S089jjECfVAdIhCDHxt0hIa/ZYk?=
 =?us-ascii?Q?NReLx3Tqj/rNMDr3C4UyN5MHViG3W2RwHEwqb1JcYIOVwKwRumtsLAL6ddVi?=
 =?us-ascii?Q?Qac7Dp5v8EWLkoU1I0DiraUB+P25ckS9so2m3Sc/9dVmtD75zsiCC6ZuGPx4?=
 =?us-ascii?Q?erZWdoK8yHBApw1yGaFVuDcQ3FFFB0Cgihtr87B3mT6QiubboeoOJGx3kNUS?=
 =?us-ascii?Q?4todF7yF5ZSLU5sEMBhrXktHKFp9wTD45JyqYSEcfnMwhrlSu1DPotCrnPJf?=
 =?us-ascii?Q?jLn15YLJ2jAZXt3EtTV22DR2L4N8ti+PKBkurmwPyC37iU37WSU1pp7RFA7R?=
 =?us-ascii?Q?hc91+0b82egTf6BBlp/1POqGrazurugNdRAAwLsn+G5+t9Oj/yqjZR/d4pGS?=
 =?us-ascii?Q?lkQYxLRsA+OfEGGVTz7X250b8fTCRbboKLQ07CB1hU7hc0Ejz4odeqkPaRyd?=
 =?us-ascii?Q?HtZCxWwr6XvzPxb9Rh2QDMhT73qkzzKu7INO5QcdYcBou+vFh787EjO4e1TM?=
 =?us-ascii?Q?YcZrlEF3zGgqfsj9DZp1uZa9T1s5DhroKVszLrsor1vTlj3LsVNE2URvrh6n?=
 =?us-ascii?Q?HT/zcmXD8PudD6oGf6HPehVgFNxVmFzOon+3lnlzxlpUQ4ltrd+0rxm8c2+8?=
 =?us-ascii?Q?wEBVTk3qIzb5RDtfdaCI7tGBdhGF8k+6rpDQhmiTW8hoGs/mALPphbVABaWw?=
 =?us-ascii?Q?qgg7t8zIW4i3prNUNZnqhJxXOWvp9v0q+V0zlwQerg0pn0b4Ooh6XcpGlh/p?=
 =?us-ascii?Q?sJOCCYrgWZn7OAiiWWFpDSVmnOCUVdaD6JB4uPIgbDVLyxoYmkbc9qtB4w/s?=
 =?us-ascii?Q?Ywe1hyEzZqDNoIEl1A1qiLb8A0IzKhpgiVfT/Js5Z28kvQziXc6S9/5Rlc6g?=
 =?us-ascii?Q?zXwolgE+otkEeOlJf468rKWpxk1yNy8VJEn7/dKYwfMjjUwSPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:22:12.7667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6bd5cc-3abb-4839-b88d-08dcf3873bd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997

From: Mario Limonciello <mario.limonciello@amd.com>

amd_pci_dev_to_node_id() tries to find the AMD node ID of a device by
searching and counting devices.

The AMD node ID of an AMD node device is simply its slot number minus
the AMD node 0 slot number.

Simplify this function and move it to amd_node.h.

[Yazen: Update commit message and simplify function]

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/amd_nb.h   | 17 -----------------
 arch/x86/include/asm/amd_node.h |  6 ++++++
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index a0f2182107b0..b3b42e585655 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -52,23 +52,6 @@ u16 amd_nb_num(void);
 bool amd_nb_has_feature(unsigned int feature);
 struct amd_northbridge *node_to_amd_nb(int node);
 
-static inline u16 amd_pci_dev_to_node_id(struct pci_dev *pdev)
-{
-	struct pci_dev *misc;
-	int i;
-
-	for (i = 0; i != amd_nb_num(); i++) {
-		misc = node_to_amd_nb(i)->misc;
-
-		if (pci_domain_nr(misc->bus) == pci_domain_nr(pdev->bus) &&
-		    PCI_SLOT(misc->devfn) == PCI_SLOT(pdev->devfn))
-			return i;
-	}
-
-	WARN(1, "Unable to find AMD Northbridge id for %s\n", pci_name(pdev));
-	return 0;
-}
-
 static inline bool amd_gart_present(void)
 {
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
index 419a0ad13ef2..8e473a293706 100644
--- a/arch/x86/include/asm/amd_node.h
+++ b/arch/x86/include/asm/amd_node.h
@@ -30,4 +30,10 @@ static inline u16 amd_num_nodes(void)
 	return topology_amd_nodes_per_pkg() * topology_max_packages();
 }
 
+/* Caller must ensure the input is an AMD node device. */
+static inline u16 amd_pci_dev_to_node_id(struct pci_dev *pdev)
+{
+	return PCI_SLOT(pdev->devfn) - AMD_NODE0_PCI_SLOT;
+}
+
 #endif /*_ASM_X86_AMD_NODE_H_*/
-- 
2.43.0


