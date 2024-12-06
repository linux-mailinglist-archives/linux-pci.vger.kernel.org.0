Return-Path: <linux-pci+bounces-17850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5319E7556
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 17:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001BA1881647
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 16:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CC020E6FC;
	Fri,  6 Dec 2024 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WE0+2IrU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C2020E31C;
	Fri,  6 Dec 2024 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501557; cv=fail; b=uusuZakci/9b8WtnWaeTCyVjLKARmgSpsATUI+niK1T1K9oddy5ov62AlvOw4K83P5KWwkaqJJ9mhCHHKDicZctPFsE3xqxFKT+FM54XZxWh3w4nTWc47ie0bS2g9d7zYTtCul/ChgKNBcjbGlNlEuHCe196z1bsRBQqT5bhmfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501557; c=relaxed/simple;
	bh=OL3+fkQfzmbFM4bre43jilJwGpwVSBhIrlxdJJ1s5w0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTxFSmBsxbPTd7ITCKNtHkN3pi7mKggJPbxnwWZ9TM8jGmUCygWfEcMUrUfLs5pNrjkQuSGfrQffykptyf26rl1qq5psEHiHdVZHfJuUbHX3FZTSe72/4LReZZnrchm4Mqt9OxKdl5X29uwP2vo4//88T0UheoLDCPumD9foiTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WE0+2IrU; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gp6R0rQZyR9S5EZIL4LsEMaHpIOSTHBF7y3I7sU+cxADmtGv/3iCvCpaxaTvwustYGQyBFxjwF8ty6MSkPYGhHq3J7ooRw1EiwGhkaP9/xcUEMFsmJYwSgmNTaO5FlBBfBU5C6XYOvNA1J/vSgaFiAtzuutJ9dgIjPtq1dv4evFQMAEZGcmM4Tsr/Xg7ZMwZHnGv7bBd41CCHhXU6kAv3ACQn+rMO0eNCVrDK18t8XyQpHcJB+meCLF46A2jFGeilxLfYfVQDtv1FxBc73/H214kQyinniXsgoydREiIp0YYtobuqu+FBgzPAxqAJtGbL/Eq11MAn/j0Bnbbs0CPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpwtKN4gM0LDrWcZURA5GCufwXUnWLxQwBwDsZErTfU=;
 b=PoqoNkt8ZA27098sXiszvgbbfwtkPNRb2DwWg1EwTDh85+trVAE4aVZoQkYAGnYGI4ROL3siJq6mQeOZONsHY7BJ7yn6W6o6hF0HPTpDcojKHbz444cZAmVRM2TIcytUTDM0rjZp8QS9t1OK/HkDVVZLo3oMc9G3dRD1MELCIdWFnh604/t6iQQnbT6Kls0HjZqjDqUfr5cMh0ZS9+CgoZk3Wk1N3aCOYcS2nQhlBsqSr/fi7MxTYIDgSvmeiS0nx4TFerw7zylfzMq/cy+1S5G5lZQxfP97biLETmfpmWVMS+rLrLeBHKALvgq1vKYT9EikzwfCxAjfGj4S13XQUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpwtKN4gM0LDrWcZURA5GCufwXUnWLxQwBwDsZErTfU=;
 b=WE0+2IrULFFIS6XIOpEGjt4njilvuONqlkgyFRGSyujkNsmZkWnB5ZGr2IQuOaLZETWueROFwGOiklFd2Rf+6Ae3NXX8VRhub0hqCbVfcxXJhV9OSMOEqzxBKd9iBAlKwLurFYmwRnOR3aZN/bl0M8Ci+VANghJB8wnTrs+kmgU=
Received: from DM6PR02CA0167.namprd02.prod.outlook.com (2603:10b6:5:332::34)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 16:12:30 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com (2603:10b6:5:332::4)
 by DM6PR02CA0167.outlook.office365.com (2603:10b6:5:332::34) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.11
 via Frontend Transport; Fri, 6 Dec 2024 16:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 16:12:29 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 10:12:28 -0600
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
Subject: [PATCH v2 06/16] x86/amd_nb: Simplify root device search
Date: Fri, 6 Dec 2024 16:11:59 +0000
Message-ID: <20241206161210.163701-7-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 4298b8c3-fdcc-4f96-3bea-08dd1610c8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JHDhywJgwfeJwYype9XuWVyF4KTQQmFYuaz05wgP1Z6kQrbfL04HERo7/Egn?=
 =?us-ascii?Q?rFY48uiS3aMaaCfeVFrClcmhUvfVhB9/WaFgNc0JnALub7I1UCTXPKl/90iN?=
 =?us-ascii?Q?14ObBa7M4mLLnXcLyv+UElTWaNURPQBGEguLKFQrVLu8I64yr029M7nCnd8T?=
 =?us-ascii?Q?HkVBrqkm20OW1T4vihK7UIjX63kxNN7IaddDsH0fYkOhwZX5faytaeDIGzOU?=
 =?us-ascii?Q?P5LhozS0zHmZ5AVyQh30XqFOh8/kKz0cnsyJdoI2NwnJDooNgpALYQlkX2Z9?=
 =?us-ascii?Q?KnL+dfCjWLpCcV0lbFeKLpBtC25nHBGoqN2PjwAxv+zQxEMyeiWR32ay7Zs1?=
 =?us-ascii?Q?KqKDUxwP0bzSa3+Vy8np6EFIxb7wBJKwtRci17wSNFOkXx1RPg2lFg5rkarl?=
 =?us-ascii?Q?nTzLsTM3dQgjqXRLOeW94TTCnLwaeyNYeG1hR2Y3SwL0jCytyj0ef8cf7TuX?=
 =?us-ascii?Q?5bYRL2db8/fH8EJwy1y+KaSX82voAoP52C81qVWdSVdD8w3pjR5M8pvWLREX?=
 =?us-ascii?Q?wKqxd8QGPUEA+WUFR8OPYLfacOjDNI1qmnrsCsXKGiokTVTxxFC1WYc0T2Zo?=
 =?us-ascii?Q?F/U5fafx6KOTJ7eb4UguZtCrPG/ZnCZDkOxFvKX2/XxwE2U45tA7WWVbk0rC?=
 =?us-ascii?Q?K/cG0KXioN61NuD2WyMl5eXBi0KQPxKlJHOWNrgsIBjfo9VTPYjuwIC7cPoZ?=
 =?us-ascii?Q?5obu523q4U2CIOjphBCCe327WM50/gLNZ6D9yqFQ2cVWxrt2nnIIXu2pgsqI?=
 =?us-ascii?Q?sYD9jpJ3cUlJCchgjQpvxk2vlyRaHLDlW/zbR3IRollvutAebG3FNeYkKuqT?=
 =?us-ascii?Q?Ioc8KJQ2q5+Fn4CZhgKAu9+rIVlIPxeDb+uuYQgRYSG19V+zvd0zBtPM4bB8?=
 =?us-ascii?Q?fN37R9iTFG4CufRlSkOC1yz3YoM+/GPKnbW9VH+Y3D6+PwJgpVDpgXlTvkiw?=
 =?us-ascii?Q?h4743yAxIZQ5pR5jQIJ5ihA880rx5v6RcB+rZyZ9XRLPWpd+n2aBD9UFTSPq?=
 =?us-ascii?Q?oNmFpaJJKQG0eCrzYqXeLilD5U+8SmLg5HuBZeq9gRYBOGTMlbVtprG59fCt?=
 =?us-ascii?Q?0jCtI72o6i/w/9jFGhFKhydg//z+/Zo46wHzQollpmCDqBIDfN/kg/poklEA?=
 =?us-ascii?Q?7Y6/v9eLpistG9Wciogo1w2KlFIViQyCkTTh1JDhuRPDGzkLrC9jXckOFHHR?=
 =?us-ascii?Q?ceJPTzG1vu6Fr/VuGxCEVFT3F816iuWtuCcVrOAH8p6tTrcGOs9/OnBi0ntl?=
 =?us-ascii?Q?9YfAUDLfe2jL648G0nKcuIBLh8XcH5J6PukRJFWngvSDB8Fa2AHrImFktcIh?=
 =?us-ascii?Q?sh6UeF+TKD4/SYz7Jn7cRGYPFtq4g5G7WXFKTEvaDCffkCx/S10TwhIk0FkV?=
 =?us-ascii?Q?xm+PcI7F5D5wSnUa4Or0k0RGJwG6Dt3+Ru9LTFffqIRguoKFjpKF2tTNAv+m?=
 =?us-ascii?Q?+ucsUVBIaPkU7qt2HiVNQtUadipDODSS65wiokxahcngW77wM0mFqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:12:29.8189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4298b8c3-fdcc-4f96-3bea-08dd1610c8b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628

The "root" device search was introduced to support SMN access for Zen
systems. This device represents a PCIe root complex. It is not the
same as the "CPU/node" devices found at slots 0x18-0x1F.

There may be multiple PCIe root complexes within an AMD node. Such is
the case with server or High-end Desktop (HEDT) systems, etc. Therefore
it is not enough to assume "root <-> AMD node" is a 1-to-1 association.

Currently, this is handled by skipping "extra" root complexes during the
search. However, the hardware provides the PCI bus number of an AMD
node's root device.

Use the hardware info to get the root device's bus and drop the extra
search code and PCI IDs.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/20241023172150.659002-7-yazen.ghannam@amd.com
    
    v1->v2:
    * Spell out HEDT in commit message.
    * Change boot_cpu_has() to cpu_feature_enabled().
    * Move 'df_f0' declaration to location of first use.

 arch/x86/include/asm/amd_node.h |  1 +
 arch/x86/kernel/amd_nb.c        | 80 ++-------------------------------
 arch/x86/kernel/amd_node.c      | 56 +++++++++++++++++++++++
 3 files changed, 61 insertions(+), 76 deletions(-)

diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
index 622bd3038eeb..3f097dd479f8 100644
--- a/arch/x86/include/asm/amd_node.h
+++ b/arch/x86/include/asm/amd_node.h
@@ -23,5 +23,6 @@
 #define AMD_NODE0_PCI_SLOT	0x18
 
 struct pci_dev *amd_node_get_func(u16 node, u8 func);
+struct pci_dev *amd_node_get_root(u16 node);
 
 #endif /*_ASM_X86_AMD_NODE_H_*/
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 7a62c5af2531..6218a0428c77 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -15,44 +15,11 @@
 #include <linux/pci_ids.h>
 #include <asm/amd_nb.h>
 
-#define PCI_DEVICE_ID_AMD_17H_ROOT		0x1450
-#define PCI_DEVICE_ID_AMD_17H_M10H_ROOT		0x15d0
-#define PCI_DEVICE_ID_AMD_17H_M30H_ROOT		0x1480
-#define PCI_DEVICE_ID_AMD_17H_M60H_ROOT		0x1630
-#define PCI_DEVICE_ID_AMD_17H_MA0H_ROOT		0x14b5
-#define PCI_DEVICE_ID_AMD_19H_M10H_ROOT		0x14a4
-#define PCI_DEVICE_ID_AMD_19H_M40H_ROOT		0x14b5
-#define PCI_DEVICE_ID_AMD_19H_M60H_ROOT		0x14d8
-#define PCI_DEVICE_ID_AMD_19H_M70H_ROOT		0x14e8
-#define PCI_DEVICE_ID_AMD_1AH_M00H_ROOT		0x153a
-#define PCI_DEVICE_ID_AMD_1AH_M20H_ROOT		0x1507
-#define PCI_DEVICE_ID_AMD_1AH_M60H_ROOT		0x1122
-#define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
-#define PCI_DEVICE_ID_AMD_MI300_ROOT		0x14f8
-
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
 
 static u32 *flush_words;
 
-static const struct pci_device_id amd_root_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_ROOT) },
-	{}
-};
-
 static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_MISC) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_10H_NB_MISC) },
@@ -85,11 +52,6 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{}
 };
 
-static const struct pci_device_id hygon_root_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_ROOT) },
-	{}
-};
-
 static const struct pci_device_id hygon_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
@@ -222,19 +184,15 @@ EXPORT_SYMBOL_GPL(amd_smn_write);
 static int amd_cache_northbridges(void)
 {
 	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
-	const struct pci_device_id *root_ids = amd_root_ids;
-	struct pci_dev *root, *misc;
+	struct pci_dev *misc;
 	struct amd_northbridge *nb;
-	u16 roots_per_misc = 0;
 	u16 misc_count = 0;
-	u16 root_count = 0;
-	u16 i, j;
+	u16 i;
 
 	if (amd_northbridges.num)
 		return 0;
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
-		root_ids = hygon_root_ids;
 		misc_ids = hygon_nb_misc_ids;
 	}
 
@@ -245,23 +203,6 @@ static int amd_cache_northbridges(void)
 	if (!misc_count)
 		return -ENODEV;
 
-	root = NULL;
-	while ((root = next_northbridge(root, root_ids)))
-		root_count++;
-
-	if (root_count) {
-		roots_per_misc = root_count / misc_count;
-
-		/*
-		 * There should be _exactly_ N roots for each DF/SMN
-		 * interface.
-		 */
-		if (!roots_per_misc || (root_count % roots_per_misc)) {
-			pr_info("Unsupported AMD DF/PCI configuration found\n");
-			return -ENODEV;
-		}
-	}
-
 	nb = kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
 	if (!nb)
 		return -ENOMEM;
@@ -269,25 +210,12 @@ static int amd_cache_northbridges(void)
 	amd_northbridges.nb = nb;
 	amd_northbridges.num = misc_count;
 
-	misc = root = NULL;
+	misc = NULL;
 	for (i = 0; i < amd_northbridges.num; i++) {
-		node_to_amd_nb(i)->root = root =
-			next_northbridge(root, root_ids);
+		node_to_amd_nb(i)->root = amd_node_get_root(i);
 		node_to_amd_nb(i)->misc = misc =
 			next_northbridge(misc, misc_ids);
 		node_to_amd_nb(i)->link = amd_node_get_func(i, 4);
-
-		/*
-		 * If there are more PCI root devices than data fabric/
-		 * system management network interfaces, then the (N)
-		 * PCI roots per DF/SMN interface are functionally the
-		 * same (for DF/SMN access) and N-1 are redundant.  N-1
-		 * PCI roots should be skipped per DF/SMN interface so
-		 * the following DF/SMN interfaces get mapped to
-		 * correct PCI roots.
-		 */
-		for (j = 1; j < roots_per_misc; j++)
-			root = next_northbridge(root, root_ids);
 	}
 
 	if (amd_gart_present())
diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index e825cd4426b9..4eea8c7d8090 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -32,3 +32,59 @@ struct pci_dev *amd_node_get_func(u16 node, u8 func)
 
 	return pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(AMD_NODE0_PCI_SLOT + node, func));
 }
+
+#define DF_BLK_INST_CNT		0x040
+#define	DF_CFG_ADDR_CNTL_LEGACY	0x084
+#define	DF_CFG_ADDR_CNTL_DF4	0xC04
+
+#define DF_MAJOR_REVISION	GENMASK(27, 24)
+
+static u16 get_cfg_addr_cntl_offset(struct pci_dev *df_f0)
+{
+	u32 reg;
+
+	/*
+	 * Revision fields added for DF4 and later.
+	 *
+	 * Major revision of '0' is found pre-DF4. Field is Read-as-Zero.
+	 */
+	if (pci_read_config_dword(df_f0, DF_BLK_INST_CNT, &reg))
+		return 0;
+
+	if (reg & DF_MAJOR_REVISION)
+		return DF_CFG_ADDR_CNTL_DF4;
+
+	return DF_CFG_ADDR_CNTL_LEGACY;
+}
+
+struct pci_dev *amd_node_get_root(u16 node)
+{
+	struct pci_dev *root;
+	u16 cntl_off;
+	u8 bus;
+
+	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
+		return NULL;
+
+	/*
+	 * D18F0xXXX [Config Address Control] (DF::CfgAddressCntl)
+	 * Bits [7:0] (SecBusNum) holds the bus number of the root device for
+	 * this Data Fabric instance. The segment, device, and function will be 0.
+	 */
+	struct pci_dev *df_f0 __free(pci_dev_put) = amd_node_get_func(node, 0);
+	if (!df_f0)
+		return NULL;
+
+	cntl_off = get_cfg_addr_cntl_offset(df_f0);
+	if (!cntl_off)
+		return NULL;
+
+	if (pci_read_config_byte(df_f0, cntl_off, &bus))
+		return NULL;
+
+	/* Grab the pointer for the actual root device instance. */
+	root = pci_get_domain_bus_and_slot(0, bus, 0);
+
+	pci_dbg(root, "is root for AMD node %u\n", node);
+	return root;
+}
-- 
2.43.0


