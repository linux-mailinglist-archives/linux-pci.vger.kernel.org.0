Return-Path: <linux-pci+bounces-13606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE52988C14
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 23:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72F11C22E52
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 21:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3698C18D63F;
	Fri, 27 Sep 2024 21:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lvgPyRmc"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9C714BF8B;
	Fri, 27 Sep 2024 21:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727474240; cv=fail; b=aUb3jBhNLojK9jR1G3JpBr7LsIHz/sJre81C4pQzDUK8X9gWQ8ZtT0PBU6yAnfDTLJ36+Re0qG/ANaXYw//RB4kK/ibQlqdVIPmKOkU6YT4DrDXpg8riQBYTtAgq3sl2v+3F1LYV0qnnqq2vrvlVp0kMImjFAr0x+hSzFteVciw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727474240; c=relaxed/simple;
	bh=Vvw/5o2uBaIdLz5+KnyBbb63im84GEgy7Ffk2hix+Pk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQNby/dcshKI4KJuxo6OwRRpgDD1fmuXWYX+79Pro06v15SDEhcApuUbKw0gDdONvG/yMlFNCj6lR16cMATxWzHGRT9RqtdiM1A/KmvWl2y3vNG/0MASCkNrL7a4k8pphZhxorJEtEPegi/sQfFerajmzegnq0N8w+tw1QQveck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lvgPyRmc; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q57dNR7mZQfZoqz+QMESLCPPaWhmAEh3/dZgfQyePzSrdIqBfkJyhVUcYZrmJOsO6yk4otlpC0TF4MzrVzUCZkjEiXO3r7gre3By1P33XoIL0kT2Ev4SRYw6eJqh+Vxk4yrPIqaAjxoJjARzacRz0Ur3Pp3R0EvXEKqauvnMXmSxWsmqMSKWWQf23MIfixfBu2yeiRmoQ0L1fqnDpLy5Ffweo8R8tyN2PjxoFM268pjOUBEw3knVQ9huFhXKgPhAeBS0ynOjJ27An5k7S/QFD0JnhmZu8z8zQbl4RGIwioulnBHgvGEPNWCZ5CrxiJjR216sp/8EDo/k5GqwNnk33g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8P8vD6LETqW+g2abB4xdtuTuncxFJE7hkDrG314alc=;
 b=reWpXP86Ug4SQh9xDuDqSzlpORLzoql7FqVuPyATA/QBqNOwtkkKP7eQ2084Cm7999E00EF0XGAyeAbejqEZLR/Wp3AGaDSkFkgaaXk2ijflUxmP8vixkp8QNRROrYPuzme2EyoY0+jwFd4nhyFMsOrMpXx+elu/FNRMhCWiWWm5++b50HBq78YVSJ6F8kW5EeEa0wdEHJEN98iA7RBsTpiJ/x7lLepHFx8Q7hwyd4G3KXtxL0LH5rzRgS+LeY6v9O9M3iPx4Bkg9tBaQ6BdHNH+4h2EHxAxtOGlN1ftq9OLOBDaH1hvAhgeu1cSp41kFIKY5yiAyR0qdH6eCcHc3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8P8vD6LETqW+g2abB4xdtuTuncxFJE7hkDrG314alc=;
 b=lvgPyRmcdp1Y6DU8qp4piRYxO7WP7AebmBwgNbKGomG+DQ4/PwtNSQ+2LgyxpcpFbICFPB6Sm4FZpNwXJowUhBFMOWqSr23YUsz89pDBgYLF4/u0ryeaCdj5nCTrd2sq3yOMI3HOoGR5BoqaN964BeK7Moa8bok5qfdnzvaaD9g=
Received: from BYAPR07CA0084.namprd07.prod.outlook.com (2603:10b6:a03:12b::25)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 21:57:13 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::38) by BYAPR07CA0084.outlook.office365.com
 (2603:10b6:a03:12b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27 via Frontend
 Transport; Fri, 27 Sep 2024 21:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 21:57:12 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 16:57:11 -0500
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
Subject: [PATCH V6 1/5] PCI: Add TLP Processing Hints (TPH) support
Date: Fri, 27 Sep 2024 16:56:49 -0500
Message-ID: <20240927215653.1552411-2-wei.huang2@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240927215653.1552411-1-wei.huang2@amd.com>
References: <20240927215653.1552411-1-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|BY5PR12MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: b6fe9fed-5927-4dc6-1ef5-08dcdf3f57dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9s4AkY7/cCOV+JHw8LXOjlFXpZhzt4Zy03RCll3V+uKwVLhctZQYe4yXvou+?=
 =?us-ascii?Q?rKIbnXgj81FBlOLpVcai+jeHazBSK5mSunNc50ZBxsCpSJR6Ott2PhCVOkiY?=
 =?us-ascii?Q?RjPZhMPQpyVZCxtOKP0c4bjI6yZ+9l+x6Sqbl0gEUvKZhMwV+qmW7MD5bDzM?=
 =?us-ascii?Q?wwEn/jwecrnjBjDxE+kGHOyqO/S2RLRhbWTLAvVLLC7QPMqXD0+5C370+OpM?=
 =?us-ascii?Q?xQ4+55B0lgU2bmSsAgTRr3H4xBa7urwplb888UZSWOrxyraTGz64CFU+Kvmc?=
 =?us-ascii?Q?6OssW9ZuVa3Z5KMI9Mlqb8M+99xPKYA4/cWog0JLmZGGlk79YebXt0dxInhJ?=
 =?us-ascii?Q?FDxCQhBujYeAVA6dhND7Zua2xXA0LhisBmoKqccUl+kWQiLsbQXQ1o7zIOos?=
 =?us-ascii?Q?SqEa8Zbh0diThMHaWPKnfs2IDOH5QW4Sc98+aSiwdTsYEDMUqvgLQrTe9TOh?=
 =?us-ascii?Q?hheup4s5LpJJdu0+bpSxyd21GJDKccpPMfqj6VOVq93JAs3oiZeiPuZSdz/g?=
 =?us-ascii?Q?Q/XXy5O08q/3dub+o4q/ObqF/LwpvBcoL7Fzxi24jmrQHhlCORYqLmJymfa8?=
 =?us-ascii?Q?Yddsykuup65VANFR4yG+lXfd19zQPfS/wm2cIgnmiIuWCzLTMBZNGODi6L9j?=
 =?us-ascii?Q?N9qg15PUKsTYgcZW8uTaLFgWVQpaG0//R6/eJ9AGuazB2auq9xxikSGZe4Gz?=
 =?us-ascii?Q?eNby3KTYBvVcci6DJ6LG8J93EWhWePaCx4Fv/RUyROBsK04vjsOQKUd9Vxc8?=
 =?us-ascii?Q?Z05NwfaLSJ3QNxaeESLk2cDyMYqfDilyuCi82KB5rx510RSbtnbDxYOV+hqI?=
 =?us-ascii?Q?Tcjqw7rACQp5ngsPi9TmLwIWbQcPHNSGNAfQxwb3N+hSMa+PDh4joy0ku5EW?=
 =?us-ascii?Q?beFB1sGdFy1CGOx5rcbVwM3rjSSh6Frw0mQ3UsFJqkDiR0uzDZG8G1+4Hekd?=
 =?us-ascii?Q?0SvyMOBzpviQKVqypa6PckWJk7+XkDmQYdGHxMa0iQG3XI2jqRhYbS4te6Lm?=
 =?us-ascii?Q?PHcklfzQ/B/A7vg8Szc6Royvt95PYTYM9IO8BsanXlcOa8/TkxJByhiLY5S3?=
 =?us-ascii?Q?cOCIt3+wb7XJJbUw+iZUPSIwKIBvu6hN0hAuRSH4aINgIW5cehbINn/XnTU2?=
 =?us-ascii?Q?1DN688vWlwV1ZKJn7YSynBhSdHR2VNJoeipJHmMdjz6HGVtGd1Xwa3VG/H2L?=
 =?us-ascii?Q?jCLVbFULj+V16oSfWWFbYbapDKssKbgqbFBplgXSlM2OJr3bjZuTcJ/MJ/jQ?=
 =?us-ascii?Q?jRgJYL5UEzTXFjFXgsOUwR03L0zMQyruWEv/IjpwiuO9uNKuohDGzQBFGp4U?=
 =?us-ascii?Q?IY9hZlpIkOGf2I58ha60x7tMOKR9dBa+Ku286+imjPOOgwhd2bVZzGx5x84V?=
 =?us-ascii?Q?guCfjOoTgFoOvB1UqtmHvmKPb8iK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 21:57:12.8404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fe9fed-5927-4dc6-1ef5-08dcdf3f57dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243

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
 drivers/pci/Kconfig                           |  10 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/pci.c                             |   4 +
 drivers/pci/pci.h                             |  12 ++
 drivers/pci/probe.c                           |   1 +
 drivers/pci/tph.c                             | 197 ++++++++++++++++++
 include/linux/pci-tph.h                       |  21 ++
 include/linux/pci.h                           |   7 +
 include/uapi/linux/pci_regs.h                 |  38 +++-
 10 files changed, 287 insertions(+), 8 deletions(-)
 create mode 100644 drivers/pci/tph.c
 create mode 100644 include/linux/pci-tph.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bb48ae24ae69..20a7a14600b2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4661,6 +4661,10 @@
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
index 0d94e4a967d8..2e2d37f427b5 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -173,6 +173,16 @@ config PCI_PASID
 
 	  If unsure, say N.
 
+config PCIE_TPH
+	bool "TLP Processing Hints"
+	default n
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
index 12323b3334a9..1b6a8575f71c 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -340,7 +340,9 @@
 #define PCI_MSIX_ENTRY_UPPER_ADDR	0x4  /* Message Upper Address */
 #define PCI_MSIX_ENTRY_DATA		0x8  /* Message Data */
 #define PCI_MSIX_ENTRY_VECTOR_CTRL	0xc  /* Vector Control */
-#define  PCI_MSIX_ENTRY_CTRL_MASKBIT	0x00000001
+#define  PCI_MSIX_ENTRY_CTRL_MASKBIT	0x00000001  /* Mask Bit */
+#define  PCI_MSIX_ENTRY_CTRL_ST_LOWER	0x00ff0000  /* ST Lower */
+#define  PCI_MSIX_ENTRY_CTRL_ST_UPPER	0xff000000  /* ST Upper */
 
 /* CompactPCI Hotswap Register */
 
@@ -659,6 +661,7 @@
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP64	0x00000100 /* 64b AtomicOp completion */
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP128	0x00000200 /* 128b AtomicOp completion */
 #define  PCI_EXP_DEVCAP2_LTR		0x00000800 /* Latency tolerance reporting */
+#define  PCI_EXP_DEVCAP2_TPH_COMP_MASK	0x00003000 /* TPH completer support */
 #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
@@ -1023,15 +1026,34 @@
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


