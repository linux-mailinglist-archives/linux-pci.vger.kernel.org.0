Return-Path: <linux-pci+bounces-13719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C74E98E156
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 19:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E051F22BDA
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 17:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E031D14F6;
	Wed,  2 Oct 2024 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cZWj20QI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C081D1CF7D7;
	Wed,  2 Oct 2024 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888421; cv=fail; b=lEiCjC1Pt+ff3YxvM9BoyQ7H/J9ki3PCzCAJ9Rp6/u7t9vYIC0/TmW6u2rt9PRDuALWqmJ+oIM5K2qlzThmpoKC8/A/DvE91MF7aPTBsQ38ynRXSmOiJxIgVoe1ktwUQkahTM46Fp62sX42MMGac1HZpKpS1HvwRjY5V09DTYmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888421; c=relaxed/simple;
	bh=w9/0yLSeXaKwaqnqVIUMAVev0B3eB3agL3VQWboFWQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdqibUpEu1AzrGerVhGywQE9s7j2gc5BgL/riYuUpIsxZbDCmQ2mS3s4V8NsM8wIoFC2OrdaohvM9D34sw5r+yc0t3j9rQhfsv+Xm2vTwuoewGPwIitz7vSxAlpM9IuI2nPkzehJksLoq9o1pa896wxyvU6INep8D8RsDdaeoH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cZWj20QI; arc=fail smtp.client-ip=40.107.102.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqj2QckGBfqXJWmnHIqiY/ERIZ3MFThz5ZERZ/zug+GrpRP43c+R9T6SBxz+hCsDo/VqcBOHEoaS4gQrq6/kUMFkA+HD01EZhaDW1s1mABfbRny7i3KfgCc6OT4O7NrOY2J8XZq5zrFVyppVXhVzktLZX8z1VLm9d58+6tDqJM+Tad3ktmnNbr3RctX7aU847WuxWUiFk3CDmsHStV9AXCLppI6tlwBXyS1siQ6wozpCJ/sh3BRyc2+mQh8HIxK5f6FekgNvA8QdLKmrJ7C4v8nTBU/9widWIGCOoU2PHMwewHR66QTSXmTHvc1HwD3ccw2SnkpkWIK4Dl8YQnQSKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWd3cTd9zrjCpRK7l0azHAaXKPGPz81LrYQE0TmRCFU=;
 b=OR+P7wKoZvZsBCiRTKn1zHbGYFz0M0jzTl5Qa2V24Sd7Iy9ktIwVRwikXiVD7Hfi/Vt13/P36MKH4gACvXNMfuLroJE4t45uw3GcCuiDbPUjQPyHSDtzSLtF6qCwO+lOq5XiFoYGLYwX8Cu9xPppe+co4i/XpVXs3JBBWRHqx83qFniBaLnmyvjsRjBriCCAd9ZHjgRpuJPGxh966a9TyzvKNarVWPGR9bond3FjO+wIAciotM5CkyU3r9OCSB2jI5WYFB7Fg57M6qvpx6hCe1IE6SqOgjYWsmBA1YLm9BAaWlkQahHXaCa3rkn7J6DMuAWYPQQjxCmit3lJ8ijp1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWd3cTd9zrjCpRK7l0azHAaXKPGPz81LrYQE0TmRCFU=;
 b=cZWj20QIyeu5IzF/i2kFpfQHxo4sR05za6h2mED4bnR/GJnDZnI0IhZNxeAbck9fTDuiDlunBesErzrNgHAZ8cSLQB8PMC/kCalXDcKRad+dUw6FlKWM9x2Flmi4C7GeGwr3FbAPapxuJfpIO3iILavgQ5/3Pc03La39tzhpuas=
Received: from SA9PR11CA0002.namprd11.prod.outlook.com (2603:10b6:806:6e::7)
 by PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 17:00:14 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::6a) by SA9PR11CA0002.outlook.office365.com
 (2603:10b6:806:6e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.17 via Frontend
 Transport; Wed, 2 Oct 2024 17:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 17:00:14 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Oct
 2024 12:00:11 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <Jonathan.Cameron@Huawei.com>, <helgaas@kernel.org>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>,
	<bhelgaas@google.com>, <lukas@wunner.de>, <paul.e.luse@intel.com>,
	<jing2.liu@intel.com>
Subject: [PATCH V7 1/5] PCI: Add TLP Processing Hints (TPH) support
Date: Wed, 2 Oct 2024 11:59:50 -0500
Message-ID: <20241002165954.128085-2-wei.huang2@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002165954.128085-1-wei.huang2@amd.com>
References: <20241002165954.128085-1-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|PH7PR12MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 39841d85-8c52-46c2-912e-08dce303af2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kVYUCThjwlGgYhiajUCoM1aZ3Xnd8Y0NAZSpAlLzQ5hvs1Wo+5BpJVifXA+j?=
 =?us-ascii?Q?nKMJJMrtHEvsoSpSyi/mx6vds1VZTaUQcdA3C7o3ux/NJMCzT1dbYKFRWJtf?=
 =?us-ascii?Q?T9PGygWnYwxWZZUcfOip1Aj1nmO+sHQa5DZrCAHxIL+gNKb84Q4CbwqhRsZh?=
 =?us-ascii?Q?fOxbt2x0USbNXVFz0p4XVEpPBHPNOqR/TBv4NnFXp0/Rm3TaGs47HjqOTxcJ?=
 =?us-ascii?Q?Iz4wo7Q525KuCm2YxA6I0OrF6E3inQRWah6qHkxf8Qtkhe9xKonAwdnqCthS?=
 =?us-ascii?Q?94YuVx/H7Hx1fl0vNX9xJMn9cQ7bHe7wtlnv1/TeHVi0iAsFeRGc/CiJw9rH?=
 =?us-ascii?Q?rM9AoRAmmIOze+n5LZl/G4+lPCgoYm5PVkdLdvlXc3JIlj4UxQFLtJjGsRmn?=
 =?us-ascii?Q?r9AsdRH13kazNgsvdcwiEanJCAUOZ8d5JEoaLZdKda4YFHQ46KZGVuxmIovm?=
 =?us-ascii?Q?r/DuOITvhnHA1ly+Jq8TKwCYv4a8st2mgSPB1MRaBj41VWwEg8Aq9agtYFWy?=
 =?us-ascii?Q?AqaZc50wppppzcyT9m96kfwLKbcvSubH2Ug6GcmL5hZstZyQN24o9w5lI9E1?=
 =?us-ascii?Q?xua3VJp3yXOqCM9EltdVKDoljfV9p27L+Ss0oWl3st1jXPzmpHem4te9pA4q?=
 =?us-ascii?Q?3ayzcFORGjZhDImPV97Bps69rz93OZz5QFmpl6vk1wXMrdAbLKWpUlPQtLEo?=
 =?us-ascii?Q?SdiHm5R049KhPNRcAKvX0r5iL9/yekrZr+O0gWrTiMCqMfXj6oYl1GH8iMmd?=
 =?us-ascii?Q?c/rpFORExiptlmGXBK6/EKX72xAB+dMVxzVqJbuOdhJQbBwzjxcFWD7oTqMm?=
 =?us-ascii?Q?1BZW5Y/cZjs8Vuwp14/GnxEcUxQjDm/06ay1DhWEjrhO7pWwqewgdDc2AZKt?=
 =?us-ascii?Q?07ueEBgL3/SYZwEZ6bJW1X+unhUM23vtQdylazKlpUJFP+731WvRV4yjuXjq?=
 =?us-ascii?Q?VkCPDrcoSctt8l9CC28geE2kcgoA12LomMMCW5BcQychwoK20zYOo8M29RCr?=
 =?us-ascii?Q?fpsUpXl40sKP3SScr2nyrZKr/78VAcTqhPR5YQuqeeaDnP0pKVu4m6fIannj?=
 =?us-ascii?Q?uHt9uDl0GRRMKPK6YJqKKWnOAe5U+HO1ghNqyU9gIUOeDJXQxa0E/BYE7erm?=
 =?us-ascii?Q?RSMcCj2hUK1OMuTPHTvK5zLIz8XfGQIQM7Utn7obY9vIpZulp7P5bMwvnn3c?=
 =?us-ascii?Q?xBsXkM1ldl19Puy1oGmtOwNiVsaivxY+P4ZWZcTxx4MaSwrTzgIUjUX6KQ+Q?=
 =?us-ascii?Q?wSFCPxjzpHYsuqPhMOrfvf/Cqz6ejGrpKYEwKORK2Ms9VSJtSiiHOk8jXaeb?=
 =?us-ascii?Q?3BLBIbAGvjgcNIz+R7DkG8b7xjI3jmuthG5fY7CkKqMBgE6sr088lVxSVlKC?=
 =?us-ascii?Q?Lw1KQtIZ8W3VLZnkydXfBhh0EgoP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:00:14.1858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39841d85-8c52-46c2-912e-08dce303af2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817

Add support for PCIe TLP Processing Hints (TPH) support (see PCIe r6.2,
sec 6.17).

Add missing TPH register definitions in pci_regs.h, including the TPH
Requester capability register, TPH Requester control register, TPH
Completer capability, and the ST fields of MSI-X entry.

Introduce pcie_enable_tph() and pcie_disable_tph(), enabling drivers to
toggle TPH support and configure specific ST mode as needed. Also add a
new kernel parameter, "pci=notph", allowing users to disable TPH support
across the entire system.

Co-developed-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
---
 .../admin-guide/kernel-parameters.txt         |   4 +
 drivers/pci/Kconfig                           |   9 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/pci.c                             |   4 +
 drivers/pci/pci.h                             |  12 ++
 drivers/pci/probe.c                           |   1 +
 drivers/pci/tph.c                             | 197 ++++++++++++++++++
 include/linux/pci-tph.h                       |  21 ++
 include/linux/pci.h                           |   7 +
 include/uapi/linux/pci_regs.h                 |  37 +++-
 10 files changed, 285 insertions(+), 8 deletions(-)
 create mode 100644 drivers/pci/tph.c
 create mode 100644 include/linux/pci-tph.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..178995b07451 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4678,6 +4678,10 @@
 		nomio		[S390] Do not use MIO instructions.
 		norid		[S390] ignore the RID field and force use of
 				one PCI domain per PCI function
+		notph		[PCIE] If the PCIE_TPH kernel config parameter
+				is enabled, this kernel boot option can be used
+				to disable PCIe TLP Processing Hints support
+				system-wide.
 
 	pcie_aspm=	[PCIE] Forcibly enable or ignore PCIe Active State Power
 			Management.
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 0d94e4a967d8..2f270e4414b3 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -173,6 +173,15 @@ config PCI_PASID
 
 	  If unsure, say N.
 
+config PCIE_TPH
+	bool "TLP Processing Hints"
+	help
+	  This option adds support for PCIe TLP Processing Hints (TPH).
+	  TPH allows endpoint devices to provide optimization hints, such as
+	  desired caching behavior, for requests that target memory space.
+	  These hints, called Steering Tags, can empower the system hardware
+	  to optimize the utilization of platform resources.
+
 config PCI_P2PDMA
 	bool "PCI peer-to-peer transfer support"
 	depends on ZONE_DEVICE
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 374c5c06d92f..b2a100f2e24a 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 obj-$(CONFIG_PCI_NPEM)		+= npem.o
+obj-$(CONFIG_PCIE_TPH)		+= tph.o
 
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7d85c04fbba2..89dafecc869b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1828,6 +1828,7 @@ int pci_save_state(struct pci_dev *dev)
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
+	pci_save_tph_state(dev);
 	return pci_save_vc_state(dev);
 }
 EXPORT_SYMBOL(pci_save_state);
@@ -1933,6 +1934,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_rebar_state(dev);
 	pci_restore_dpc_state(dev);
 	pci_restore_ptm_state(dev);
+	pci_restore_tph_state(dev);
 
 	pci_aer_clear_status(dev);
 	pci_restore_aer_state(dev);
@@ -6896,6 +6898,8 @@ static int __init pci_setup(char *str)
 				pci_no_domains();
 			} else if (!strncmp(str, "noari", 5)) {
 				pcie_ari_disabled = true;
+			} else if (!strncmp(str, "notph", 5)) {
+				pci_no_tph();
 			} else if (!strncmp(str, "cbiosize=", 9)) {
 				pci_cardbus_io_size = memparse(str + 9, &str);
 			} else if (!strncmp(str, "cbmemsize=", 10)) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 14d00ce45bfa..d89fdbf04f36 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -597,6 +597,18 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
 
 #endif /* CONFIG_PCI_IOV */
 
+#ifdef CONFIG_PCIE_TPH
+void pci_restore_tph_state(struct pci_dev *dev);
+void pci_save_tph_state(struct pci_dev *dev);
+void pci_no_tph(void);
+void pci_tph_init(struct pci_dev *dev);
+#else
+static inline void pci_restore_tph_state(struct pci_dev *dev) { }
+static inline void pci_save_tph_state(struct pci_dev *dev) { }
+static inline void pci_no_tph(void) { }
+static inline void pci_tph_init(struct pci_dev *dev) { }
+#endif
+
 #ifdef CONFIG_PCIE_PTM
 void pci_ptm_init(struct pci_dev *dev);
 void pci_save_ptm_state(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4f68414c3086..b086d53a9048 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2495,6 +2495,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_dpc_init(dev);		/* Downstream Port Containment */
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
 	pci_doe_init(dev);		/* Data Object Exchange */
+	pci_tph_init(dev);		/* TLP Processing Hints */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
new file mode 100644
index 000000000000..6c6b500c2eaa
--- /dev/null
+++ b/drivers/pci/tph.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TPH (TLP Processing Hints) support
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ *     Eric Van Tassell <Eric.VanTassell@amd.com>
+ *     Wei Huang <wei.huang2@amd.com>
+ */
+#include <linux/pci.h>
+#include <linux/bitfield.h>
+#include <linux/pci-tph.h>
+
+#include "pci.h"
+
+/* System-wide TPH disabled */
+static bool pci_tph_disabled;
+
+static u8 get_st_modes(struct pci_dev *pdev)
+{
+	u32 reg;
+
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
+	reg &= PCI_TPH_CAP_ST_NS | PCI_TPH_CAP_ST_IV | PCI_TPH_CAP_ST_DS;
+
+	return reg;
+}
+
+/* Return device's Root Port completer capability */
+static u8 get_rp_completer_type(struct pci_dev *pdev)
+{
+	struct pci_dev *rp;
+	u32 reg;
+	int ret;
+
+	rp = pcie_find_root_port(pdev);
+	if (!rp)
+		return 0;
+
+	ret = pcie_capability_read_dword(rp, PCI_EXP_DEVCAP2, &reg);
+	if (ret)
+		return 0;
+
+	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
+}
+
+/**
+ * pcie_disable_tph - Turn off TPH support for device
+ * @pdev: PCI device
+ *
+ * Return: none
+ */
+void pcie_disable_tph(struct pci_dev *pdev)
+{
+	if (!pdev->tph_cap)
+		return;
+
+	if (!pdev->tph_enabled)
+		return;
+
+	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, 0);
+
+	pdev->tph_mode = 0;
+	pdev->tph_req_type = 0;
+	pdev->tph_enabled = 0;
+}
+EXPORT_SYMBOL(pcie_disable_tph);
+
+/**
+ * pcie_enable_tph - Enable TPH support for device using a specific ST mode
+ * @pdev: PCI device
+ * @mode: ST mode to enable. Current supported modes include:
+ *
+ *   - PCI_TPH_ST_NS_MODE: NO ST Mode
+ *   - PCI_TPH_ST_IV_MODE: Interrupt Vector Mode
+ *   - PCI_TPH_ST_DS_MODE: Device Specific Mode
+ *
+ * Checks whether the mode is actually supported by the device before enabling
+ * and returns an error if not. Additionally determines what types of requests,
+ * TPH or extended TPH, can be issued by the device based on its TPH requester
+ * capability and the Root Port's completer capability.
+ *
+ * Return: 0 on success, otherwise negative value (-errno)
+ */
+int pcie_enable_tph(struct pci_dev *pdev, int mode)
+{
+	u32 reg;
+	u8 dev_modes;
+	u8 rp_req_type;
+
+	/* Honor "notph" kernel parameter */
+	if (pci_tph_disabled)
+		return -EINVAL;
+
+	if (!pdev->tph_cap)
+		return -EINVAL;
+
+	if (pdev->tph_enabled)
+		return -EBUSY;
+
+	/* Sanitize and check ST mode compatibility */
+	mode &= PCI_TPH_CTRL_MODE_SEL_MASK;
+	dev_modes = get_st_modes(pdev);
+	if (!((1 << mode) & dev_modes))
+		return -EINVAL;
+
+	pdev->tph_mode = mode;
+
+	/* Get req_type supported by device and its Root Port */
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
+	if (FIELD_GET(PCI_TPH_CAP_EXT_TPH, reg))
+		pdev->tph_req_type = PCI_TPH_REQ_EXT_TPH;
+	else
+		pdev->tph_req_type = PCI_TPH_REQ_TPH_ONLY;
+
+	rp_req_type = get_rp_completer_type(pdev);
+
+	/* Final req_type is the smallest value of two */
+	pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
+
+	if (pdev->tph_req_type == PCI_TPH_REQ_DISABLE)
+		return -EINVAL;
+
+	/* Write them into TPH control register */
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);
+
+	reg &= ~PCI_TPH_CTRL_MODE_SEL_MASK;
+	reg |= FIELD_PREP(PCI_TPH_CTRL_MODE_SEL_MASK, pdev->tph_mode);
+
+	reg &= ~PCI_TPH_CTRL_REQ_EN_MASK;
+	reg |= FIELD_PREP(PCI_TPH_CTRL_REQ_EN_MASK, pdev->tph_req_type);
+
+	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg);
+
+	pdev->tph_enabled = 1;
+
+	return 0;
+}
+EXPORT_SYMBOL(pcie_enable_tph);
+
+void pci_restore_tph_state(struct pci_dev *pdev)
+{
+	struct pci_cap_saved_state *save_state;
+	u32 *cap;
+
+	if (!pdev->tph_cap)
+		return;
+
+	if (!pdev->tph_enabled)
+		return;
+
+	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_TPH);
+	if (!save_state)
+		return;
+
+	/* Restore control register and all ST entries */
+	cap = &save_state->cap.data[0];
+	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, *cap++);
+}
+
+void pci_save_tph_state(struct pci_dev *pdev)
+{
+	struct pci_cap_saved_state *save_state;
+	u32 *cap;
+
+	if (!pdev->tph_cap)
+		return;
+
+	if (!pdev->tph_enabled)
+		return;
+
+	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_TPH);
+	if (!save_state)
+		return;
+
+	/* Save control register */
+	cap = &save_state->cap.data[0];
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, cap++);
+}
+
+void pci_no_tph(void)
+{
+	pci_tph_disabled = true;
+
+	pr_info("PCIe TPH is disabled\n");
+}
+
+void pci_tph_init(struct pci_dev *pdev)
+{
+	u32 save_size;
+
+	pdev->tph_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_TPH);
+	if (!pdev->tph_cap)
+		return;
+
+	save_size = sizeof(u32);
+	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
+}
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
new file mode 100644
index 000000000000..58654a334ffb
--- /dev/null
+++ b/include/linux/pci-tph.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * TPH (TLP Processing Hints)
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ *     Eric Van Tassell <Eric.VanTassell@amd.com>
+ *     Wei Huang <wei.huang2@amd.com>
+ */
+#ifndef LINUX_PCI_TPH_H
+#define LINUX_PCI_TPH_H
+
+#ifdef CONFIG_PCIE_TPH
+void pcie_disable_tph(struct pci_dev *pdev);
+int pcie_enable_tph(struct pci_dev *pdev, int mode);
+#else
+static inline void pcie_disable_tph(struct pci_dev *pdev) { }
+static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
+{ return -EINVAL; }
+#endif
+
+#endif /* LINUX_PCI_TPH_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..8351d76b6e12 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -434,6 +434,7 @@ struct pci_dev {
 	unsigned int	ats_enabled:1;		/* Address Translation Svc */
 	unsigned int	pasid_enabled:1;	/* Process Address Space ID */
 	unsigned int	pri_enabled:1;		/* Page Request Interface */
+	unsigned int	tph_enabled:1;		/* TLP Processing Hints */
 	unsigned int	is_managed:1;		/* Managed via devres */
 	unsigned int	is_msi_managed:1;	/* MSI release via devres installed */
 	unsigned int	needs_freset:1;		/* Requires fundamental reset */
@@ -534,6 +535,12 @@ struct pci_dev {
 
 	/* These methods index pci_reset_fn_methods[] */
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
+
+#ifdef CONFIG_PCIE_TPH
+	u16		tph_cap;	/* TPH capability offset */
+	u8		tph_mode;	/* TPH mode */
+	u8		tph_req_type;	/* TPH requester type */
+#endif
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 12323b3334a9..155dea741615 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -340,7 +340,8 @@
 #define PCI_MSIX_ENTRY_UPPER_ADDR	0x4  /* Message Upper Address */
 #define PCI_MSIX_ENTRY_DATA		0x8  /* Message Data */
 #define PCI_MSIX_ENTRY_VECTOR_CTRL	0xc  /* Vector Control */
-#define  PCI_MSIX_ENTRY_CTRL_MASKBIT	0x00000001
+#define  PCI_MSIX_ENTRY_CTRL_MASKBIT	0x00000001  /* Mask Bit */
+#define  PCI_MSIX_ENTRY_CTRL_ST		0xffff0000  /* Steering Tag */
 
 /* CompactPCI Hotswap Register */
 
@@ -659,6 +660,7 @@
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP64	0x00000100 /* 64b AtomicOp completion */
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP128	0x00000200 /* 128b AtomicOp completion */
 #define  PCI_EXP_DEVCAP2_LTR		0x00000800 /* Latency tolerance reporting */
+#define  PCI_EXP_DEVCAP2_TPH_COMP_MASK	0x00003000 /* TPH completer support */
 #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
@@ -1023,15 +1025,34 @@
 #define  PCI_DPA_CAP_SUBSTATE_MASK	0x1F	/* # substates - 1 */
 #define PCI_DPA_BASE_SIZEOF	16	/* size with 0 substates */
 
+/* TPH Completer Support */
+#define PCI_EXP_DEVCAP2_TPH_COMP_NONE		0x0 /* None */
+#define PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY	0x1 /* TPH only */
+#define PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH	0x3 /* TPH and Extended TPH */
+
 /* TPH Requester */
 #define PCI_TPH_CAP		4	/* capability register */
-#define  PCI_TPH_CAP_LOC_MASK	0x600	/* location mask */
-#define   PCI_TPH_LOC_NONE	0x000	/* no location */
-#define   PCI_TPH_LOC_CAP	0x200	/* in capability */
-#define   PCI_TPH_LOC_MSIX	0x400	/* in MSI-X */
-#define PCI_TPH_CAP_ST_MASK	0x07FF0000	/* ST table mask */
-#define PCI_TPH_CAP_ST_SHIFT	16	/* ST table shift */
-#define PCI_TPH_BASE_SIZEOF	0xc	/* size with no ST table */
+#define  PCI_TPH_CAP_ST_NS	0x00000001 /* No ST Mode Supported */
+#define  PCI_TPH_CAP_ST_IV	0x00000002 /* Interrupt Vector Mode Supported */
+#define  PCI_TPH_CAP_ST_DS	0x00000004 /* Device Specific Mode Supported */
+#define  PCI_TPH_CAP_EXT_TPH	0x00000100 /* Ext TPH Requester Supported */
+#define  PCI_TPH_CAP_LOC_MASK	0x00000600 /* ST Table Location */
+#define   PCI_TPH_LOC_NONE	0x00000000 /* Not present */
+#define   PCI_TPH_LOC_CAP	0x00000200 /* In capability */
+#define   PCI_TPH_LOC_MSIX	0x00000400 /* In MSI-X */
+#define  PCI_TPH_CAP_ST_MASK	0x07FF0000 /* ST Table Size */
+#define  PCI_TPH_CAP_ST_SHIFT	16	/* ST Table Size shift */
+#define PCI_TPH_BASE_SIZEOF	0xc	/* Size with no ST table */
+
+#define PCI_TPH_CTRL		8	/* control register */
+#define  PCI_TPH_CTRL_MODE_SEL_MASK	0x00000007 /* ST Mode Select */
+#define   PCI_TPH_ST_NS_MODE		0x0 /* No ST Mode */
+#define   PCI_TPH_ST_IV_MODE		0x1 /* Interrupt Vector Mode */
+#define   PCI_TPH_ST_DS_MODE		0x2 /* Device Specific Mode */
+#define  PCI_TPH_CTRL_REQ_EN_MASK	0x00000300 /* TPH Requester Enable */
+#define   PCI_TPH_REQ_DISABLE		0x0 /* No TPH requests allowed */
+#define   PCI_TPH_REQ_TPH_ONLY		0x1 /* TPH only requests allowed */
+#define   PCI_TPH_REQ_EXT_TPH		0x3 /* Extended TPH requests allowed */
 
 /* Downstream Port Containment */
 #define PCI_EXP_DPC_CAP			0x04	/* DPC Capability */
-- 
2.46.0


