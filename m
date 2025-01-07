Return-Path: <linux-pci+bounces-19468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0988FA04C50
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 23:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99B6166598
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 22:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00E11F8668;
	Tue,  7 Jan 2025 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zYqQHv5M"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089D71F76A9;
	Tue,  7 Jan 2025 22:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736288953; cv=fail; b=Cg/9uFQ3p3Y6dyaVAltZU7n9rQ4TTrxXCU9e4BCMGHHSGNXx7/Hhd+VovZweIHQAxSyQj+4943cZZuwefrwKJXhkdQLvHJ5OPZn3f6adQKMpUHbUjUzMVP4CPPi09FkkLCk9IRiMq7COAM2xrk59VHNIzx84oriTD+v969O79Kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736288953; c=relaxed/simple;
	bh=p6NiL4FyASrWCbW1QPglzDEqqmp23KPXDNFoCbrhVw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbADQm3Jv9Fb31uVvRYbvDD6CFiQijHF2EcS0DnXLIbrwxkNt1ktUWw1HJjQoxDdRMtDgmwih9qsii5c16WiXxOpNuYFqvQL5gqcvUDAnlzZJUKlbLbPSinDUqXXRHFt5iSahTjgeR9/b/fCUyKV7blP1zP1Z3DZ30t7TWyvVn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zYqQHv5M; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmfHJY9Y5IqdWomVxpml+M+C9Gjdv18QGsIIJrZJcWQJepl735rFdxa2lguKRij0YalF1JvIF6PNvOQPvWAxRCrdSpSQ3++vMqvCpDBgTnq40zvH+TB/5nyfU+YjIJP3cJqx0sxxvw9qBJ5y7mk7x3XQ5vcnbyozMykpl1ICyRDfrFhyUU47UhXjfcdHqsp1l0OE68K9v/ul6HCkoeFst3II29f1jCyJx6IidNc6nChcP1K6OAPpfORAA22DhqJCDkjit+Tt/BivS6yqcTQeH2b8lkqFZgesT6Nl5LKzUQsC6cajhM5E1PUcoqQWJxVQMCVNX+smRtMZwQp9wXEghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMBVmfxnqh7/iVqivP6yCXSygRtyBsylukcYd0DnEvI=;
 b=azcUhp9NrXMVLiZxKHVeZ4BrWSrxGvbvI0PVudA8ev/10qe/LX8+8elhJ5rKr8vmogyty30Zc4xwkoPcwhUIEeNVTPL2Yj+ZBuT9rEiDK4wQI21NU9bFoXD6WYFfxO5qK/YAvDfAcyg5c7xk5xJO4+9ls+0gMPTz8zqOMmRk2VgOVKU8+1pW7sps/ht3OSOYUc109o9PO9j269f7c/tQNlMCCUKZI3fKuthb/nQVb5Zxgq5zD76pGRs6Lxu/QbGEoEoQUdEfTWbBBlzf/vptVb1r2Ay0xmf1o1UCbKRx5gYuycTkXE8UL4/cmzm7RVR+BVdP5AGYbG87IAvtSlMosw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMBVmfxnqh7/iVqivP6yCXSygRtyBsylukcYd0DnEvI=;
 b=zYqQHv5MRibs+ea5mAhGKUVkCfbVyIPnh0dcGWKB8YauQh/rzo4dmJeA3wSUXB5dpEExb8tffFAVDuTWz9O9Hhn+O6JZQ8viLYg44yfqtthhRQeb6NSBXfQpKsb6nUr2tBjyBC/hmbTh6VjGo9xHd6LWg3J51+SuX9LA14TdjxU=
Received: from SJ0PR13CA0222.namprd13.prod.outlook.com (2603:10b6:a03:2c1::17)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 22:29:04 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::76) by SJ0PR13CA0222.outlook.office365.com
 (2603:10b6:a03:2c1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Tue,
 7 Jan 2025 22:29:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 22:29:04 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 16:29:02 -0600
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
Subject: [PATCH v3 04/12] x86/amd_nb: Simplify function 4 search
Date: Tue, 7 Jan 2025 22:28:39 +0000
Message-ID: <20250107222847.3300430-5-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|MW6PR12MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: 37028f5a-f177-4d32-bddc-08dd2f6ab141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n4eGc791/f+hFv7bB4yeFq+CRqKpG4VvE7toYpE7pw6h7zmHsPSMzIsJ8Tko?=
 =?us-ascii?Q?lZLDC4e4Ug5ASFr7Ba+QZ1P/7uJmXtm2h5CZVqDSt3OL9cUrzlkzJdUFZtEk?=
 =?us-ascii?Q?U574DF5Ny20wsZEjMwXO8oJFM7f1nHIDiwKojo/qNLUmi7BhJ29U8JX14wbp?=
 =?us-ascii?Q?nPZBPxCPmbfYqOFSGwBiRcIM8bD0i7oA3sEk1qH1m8mZmu62PRTsODitNJNM?=
 =?us-ascii?Q?oMHlsyCIQNeFcQISCfq8WsRnBTqsjaB7Qn3y5L03WYDrOZN/qsArJ9dLd3rg?=
 =?us-ascii?Q?z5oM4vl1h0fJ0ePKW36vd0ZLjwmnxCpEOG6nV3b2fe6z/Q6hUxFCN4TQtfaa?=
 =?us-ascii?Q?Tm/u/FRNlsqGQuq1Gg/XV4HQ/PbNqQg/k2xABtaNVa38uRZugSfzt4w95Ehm?=
 =?us-ascii?Q?RjU2O0/vFriWznugDiwJ7kbetKOaOdfUbRHGo7s6Xof0a4e+thvikNHgZbG6?=
 =?us-ascii?Q?yDeW7vJ/X0TeN+ATcy1EYfxfd4dwu8b2pj/D77ytkTTVRaScolnyAxiLAAxE?=
 =?us-ascii?Q?PNy5YHwl2RMroSsBwkGPhkxjoQtJ7COWoNU5DPPG1VUhFOo04HfPFLd/Ew3H?=
 =?us-ascii?Q?oLTIyr6KUNhJ8hLCnjUB33DhPs1W5ScGHKyf9v6uIJMMxZRQF35DhmSjH9OS?=
 =?us-ascii?Q?DDEfepsPN9AlGlFVJWaHFETEnSFtl7OyPXHDxaicIH0+CHSnF08bUbU9YNAC?=
 =?us-ascii?Q?bh1duPmEYLY0QJI4U3Phz/i2yTvpTkXkMf0r/0Tr+Mk0GiRESk1hhGv7KdRu?=
 =?us-ascii?Q?EDMp84K1BLjeyNhDq99M7dmNxRFFsEYpR4wtoOsSzdboVSPuQXrw5amdHf/y?=
 =?us-ascii?Q?juCKwpA2jEVcP9+1Zpac1qqtB1IRjp+Z2kVjYu4b6EBRI7MtYRCIJU8egUyW?=
 =?us-ascii?Q?QeIH+Uet5XUmdau8GlfnJzOGJ4S15jt6OvEa64vf5RLX5CxLP5aqY94EYXSZ?=
 =?us-ascii?Q?OQoM6qM7I/xcAteOYtWfDE51Mr7PigIixYPiYXVp+o+a6+jodAgAU3e5nlIQ?=
 =?us-ascii?Q?lbI2LyVshOHD1NwKJG9hykSNlM7RE1kAd9wnlxnCaGRHg0g42BygNPyT1/dF?=
 =?us-ascii?Q?nzBVR8kLJCod33qe2WjPwtAHmx8wrnuSA/NWJcE2FAkMrYikyqQNOqQ0Qq4G?=
 =?us-ascii?Q?oqMkOHXQMo3DKtcV/6uGZJLDScebSJv8uuc9nJ5vQkv7VpHjnQOHutskckwJ?=
 =?us-ascii?Q?JEpax7Ob8YbyOcCq1gXUq+R9l8NbjYDBkVe+5tOCJxoZvAgQsbZXCC8vjttc?=
 =?us-ascii?Q?ZV092HYWjb4/UGnwuYWXmPf4awKCjGvTECtH9tmTXpLbZv2TfIvAjv40tDgC?=
 =?us-ascii?Q?ehnVzk04vLwLmCOIjXhBqfpVKUI/VBtTLOcFApemG0WO9mBIASU2huuEkw07?=
 =?us-ascii?Q?n0qh84xMdW7mDqt30pRkAB7fU5Ncdlss3vR8rMFUd0PpyERhW+c5wV+HT6jZ?=
 =?us-ascii?Q?7FC7jww01Tf6OiZ/YR1vBW05KQcaOOS+JSN9wkR6q8FYx5HyQ/It6j9chrKT?=
 =?us-ascii?Q?xTJc3poBd/OwGS0ytSwhXAaRLOQks3uDpLRQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 22:29:04.1361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37028f5a-f177-4d32-bddc-08dd2f6ab141
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868

Use the newly added helper function to look up a CPU/Node function to
find "function 4" devices.

Thus, avoid the need to regularly add new PCI IDs for basic discovery.
The unique PCI IDs are still useful in case of quirks or functional
changes. And they should be used only in such a manner.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-6-yazen.ghannam@amd.com
---
 arch/x86/include/asm/amd_nb.h |  2 +-
 arch/x86/kernel/amd_nb.c      | 66 ++---------------------------------
 2 files changed, 4 insertions(+), 64 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index d0caac26533f..b48dc6975da2 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -4,7 +4,7 @@
 
 #include <linux/ioport.h>
 #include <linux/pci.h>
-#include <linux/refcount.h>
+#include <asm/amd_node.h>
 
 struct amd_nb_bus_dev_range {
 	u8 bus;
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index ee20071ced99..7a62c5af2531 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -30,26 +30,6 @@
 #define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
 #define PCI_DEVICE_ID_AMD_MI300_ROOT		0x14f8
 
-#define PCI_DEVICE_ID_AMD_17H_DF_F4		0x1464
-#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4	0x15ec
-#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4	0x1494
-#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4	0x144c
-#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4	0x1444
-#define PCI_DEVICE_ID_AMD_17H_MA0H_DF_F4	0x1728
-#define PCI_DEVICE_ID_AMD_19H_DF_F4		0x1654
-#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F4	0x14b1
-#define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4	0x167d
-#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4	0x166e
-#define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4	0x14e4
-#define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4	0x14f4
-#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4	0x12fc
-#define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4	0x12c4
-#define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F4	0x16fc
-#define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4	0x124c
-#define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F4	0x12bc
-#define PCI_DEVICE_ID_AMD_MI200_DF_F4		0x14d4
-#define PCI_DEVICE_ID_AMD_MI300_DF_F4		0x152c
-
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
 
@@ -73,8 +53,6 @@ static const struct pci_device_id amd_root_ids[] = {
 	{}
 };
 
-#define PCI_DEVICE_ID_AMD_CNB17H_F4     0x1704
-
 static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_MISC) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_10H_NB_MISC) },
@@ -107,35 +85,6 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{}
 };
 
-static const struct pci_device_id amd_nb_link_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_NB_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_M30H_NB_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_M60H_NB_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_NB_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F4) },
-	{}
-};
-
 static const struct pci_device_id hygon_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_ROOT) },
 	{}
@@ -146,11 +95,6 @@ static const struct pci_device_id hygon_nb_misc_ids[] = {
 	{}
 };
 
-static const struct pci_device_id hygon_nb_link_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_DF_F4) },
-	{}
-};
-
 const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[] __initconst = {
 	{ 0x00, 0x18, 0x20 },
 	{ 0xff, 0x00, 0x20 },
@@ -275,13 +219,11 @@ int __must_check amd_smn_write(u16 node, u32 address, u32 value)
 }
 EXPORT_SYMBOL_GPL(amd_smn_write);
 
-
 static int amd_cache_northbridges(void)
 {
 	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
-	const struct pci_device_id *link_ids = amd_nb_link_ids;
 	const struct pci_device_id *root_ids = amd_root_ids;
-	struct pci_dev *root, *misc, *link;
+	struct pci_dev *root, *misc;
 	struct amd_northbridge *nb;
 	u16 roots_per_misc = 0;
 	u16 misc_count = 0;
@@ -294,7 +236,6 @@ static int amd_cache_northbridges(void)
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 		root_ids = hygon_root_ids;
 		misc_ids = hygon_nb_misc_ids;
-		link_ids = hygon_nb_link_ids;
 	}
 
 	misc = NULL;
@@ -328,14 +269,13 @@ static int amd_cache_northbridges(void)
 	amd_northbridges.nb = nb;
 	amd_northbridges.num = misc_count;
 
-	link = misc = root = NULL;
+	misc = root = NULL;
 	for (i = 0; i < amd_northbridges.num; i++) {
 		node_to_amd_nb(i)->root = root =
 			next_northbridge(root, root_ids);
 		node_to_amd_nb(i)->misc = misc =
 			next_northbridge(misc, misc_ids);
-		node_to_amd_nb(i)->link = link =
-			next_northbridge(link, link_ids);
+		node_to_amd_nb(i)->link = amd_node_get_func(i, 4);
 
 		/*
 		 * If there are more PCI root devices than data fabric/
-- 
2.43.0


