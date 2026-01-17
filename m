Return-Path: <linux-pci+bounces-45083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3318FD38C62
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 05:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 256F9300DB1C
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 04:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27E4326D46;
	Sat, 17 Jan 2026 04:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eLZtWJxm"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013069.outbound.protection.outlook.com [40.93.196.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D52FC02F;
	Sat, 17 Jan 2026 04:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768625820; cv=fail; b=nFpYIAIvXQxfNoSujWlFYsD7WUxV7vo373+UqINp5W2dsyBdRqJpTYk38A/Wf3pZVl008Cl4bfzbSyPEodwh40MsvE07sK6t8JZMY6D46QEBLLWQIGgPVj7BxX8LqSHTdoh8XXetpKvmFqWxj0lFi6MJMXco+8SF7eyPUmejBFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768625820; c=relaxed/simple;
	bh=LKhEhBEmKe2eF78BEvp/GuPrO+ORF7E/riTjjiPg3Fk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ifcfRJi3+nlAOgb4q4SXq9reG41g0pcfh48+g/8iOzxvz+M8Xn4keJ2nqpyhczidrlT71m8pyhz29DVYbHkM+5o+9OFFu4P61VHrzoPkHJlI6AX2qJtT3lI7FsRA5hq1G9ZvVEQXA5NZjH2DTYzIB931lSTTEsL7NIb8gkdujCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eLZtWJxm; arc=fail smtp.client-ip=40.93.196.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJL3+4xVwreE8wo/aC2NVwoSWul+GDNGduQ3s0nQET6M1IZcvrcym+kmi5kNylrtTDU1liE8g9qOVC7lep8Rosbvgdvg/3+HeXDe2/hdN3CmaU0Gcdz9azgXoYhmpZscg4dnxso2W0jPY9+YaN7fcjKwJvsOgtyvor9LsgwtluFilf7QGuSaVoED1AwBxSr15h/50yUW5zdg8mqFt3hsrj7piM1QK14r9Jb2+wEHtbadKzBiulU+0KCG5cciQBbygX7CSw+SFyP15WdwNO6kx2Mk9XTeZ4iEIU69U6KBwCUARUPQOtBMPqqSyDJxouBPAZ6ngM0w4Jy6D1BCW9x7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEU2pkGz5zsp4dcRiX6KG8FR11DBlvvKsBRfoySxsKg=;
 b=tlqrU7znRa20UX0HPeHCJQv2+k4EfL2u8dIULFtmdgg2b8+cTSpNGqGWxsDWf2qJ0kK5ZZ5hIMA3Ir02DYiKyRuWWJVuBvICTZ+0hYKvqHeJMovb4nv5UNtCIjm6evf9iWeKxrfDX/XDn6PMZLDnUWY4uYdmMs7DazszjhVBA1QQGU/oCcJ3X8GatpBrtQajdM3LmEZGk3avu3JU09MYC5edbMkpkhm9OWG6Cmx802GeG7iXyOx5btBHTJWqK735GZX3LSA2Eo8RwLrtvpCciYTpn0nA4TmzeY+9Dxl24sbi0rEVJjMkuAQMa6UkNmKOHyauieCz7rxTJjbmegThTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEU2pkGz5zsp4dcRiX6KG8FR11DBlvvKsBRfoySxsKg=;
 b=eLZtWJxmopdsciAYDAVBFZ+ZqJwc8riBjE3YD3kroFtMUx6ztTzH8EDxjMkrTS1dlyHa5ZsMLeJCFpXjEhT+l9LLh65E+y3d4penwPlySuZHnLR3ggzO3HohNMGX/8MP7g1Dy/duF+bk2YsXxLSpE2GPGJRtwsb1RDGcvFaGAqIbjEcs5UsPmdzy40R5PjduGCrPZimrR9+ndpK5qc9thsdzCJKnygYzy5RaPxJ0gYmEPPS3R0xn8D3hPq2kOaV05jgkgGTTkIgFexXRsi9a/Rq2Eg6NCyyi9J2ZnAhR2doyP+g8V0oAJxJ2Ugz34Od+CqfZEf+qO06BiFYcnQN5dA==
Received: from SJ0PR13CA0161.namprd13.prod.outlook.com (2603:10b6:a03:2c7::16)
 by SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Sat, 17 Jan
 2026 04:56:54 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::a9) by SJ0PR13CA0161.outlook.office365.com
 (2603:10b6:a03:2c7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4 via Frontend Transport; Sat,
 17 Jan 2026 04:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Sat, 17 Jan 2026 04:56:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 20:56:50 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 16 Jan 2026 20:56:50 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 20:56:49 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<bhelgaas@google.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache capable devices
Date: Fri, 16 Jan 2026 20:56:40 -0800
Message-ID: <d1768bb6384050a23769f20ca28216f520f77e26.1768624181.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1768624180.git.nicolinc@nvidia.com>
References: <cover.1768624180.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|SA1PR12MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: b6df208a-cb03-466f-d962-08de5584d5a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0t0jkuq1/WdVjkSR70GSbD6z0enfc534ROAIQGSjuLjQDXev6fy3rCG1XU6r?=
 =?us-ascii?Q?py7HX4ybG6sXGGjAAPCLbAFw4ZYVfKF+7NiNEFqUinvPZad2xCVTGoFzg2+T?=
 =?us-ascii?Q?rksticNPhnfljdMDed3SdWkerNhVGFUYk5dMQlex/2oZoRvcLQLv+7v8KQXA?=
 =?us-ascii?Q?nyAurIJAbRd3/M2kgNegv8kECbvDJQTdcs1orHlUFgbErkL4lL1h407oyWpC?=
 =?us-ascii?Q?xBEU1355dPSVji4FgltWC0suoMcWhfRhEM1BWRxYt4VjDEIN2HD90tWXT4XV?=
 =?us-ascii?Q?6+ImWRLh4sB16OjIZCjZSbLe+2tGtJwzAWQhJio3ev1CiUdq4luvcXPDOHW3?=
 =?us-ascii?Q?rv8e+LcWrGUOOTr0K160SOAJCwbAjaqB0yfIyvL8g2UNl/jVe19+apDfdAc+?=
 =?us-ascii?Q?gHulGeo+qKvuMGbEAPSRdgNtv68FmH8KlE78ZKqy6pjPzpIK8Tb8sQqMJlTi?=
 =?us-ascii?Q?2CF1sRH8md4MDUt5TEgbFXBjk+N7QwslV1s1MF8H8eKF918Yzc7XPsWCue6t?=
 =?us-ascii?Q?0ogDhoUyFYZEObE024whsPMxhfajfpCcqX1aDaQMDT8CFr0UtOb3DJy8l7ZY?=
 =?us-ascii?Q?gcq5t1iYh/Fp//0K6nnAelz8wpHiokHTE4SCBgTHqOllpQ1JKNu6PxVpTCLI?=
 =?us-ascii?Q?mNGObYv0kKwOTGmye6AW0FQQBzi0Qh/5l8dy/+E0PxTBbRaVX2Dn3+DGiMgw?=
 =?us-ascii?Q?p4RjTm3demXtLcp8l1iKz6sG+TTbSK8njB33d74J76epoIhHWKNnTHm2OJjh?=
 =?us-ascii?Q?nYyAIBjpU0NAKbnd0QBrYHYv9+H02xTnh+3sVUo1IF42Zl2EYKEwIVGpcQA/?=
 =?us-ascii?Q?P+NV26w0BRW+pkmTMKJMtFxDO0MT008JC/VW+7Me7VeDu+HDKFJ5Kp7C10nT?=
 =?us-ascii?Q?mwigC4ZyVWy0cJ2PR5fiHROxnVce/q2LjhP9dh/anG6mnVprphH3Rq8D3okt?=
 =?us-ascii?Q?9ZWBzxw0/ijpDTD35o0hDmhen5LH2+CdC8AEJ4bqiFsvwIPoFcJvONraXP02?=
 =?us-ascii?Q?1NWbPXTUOBfmPEl1dz6Zm7iY/kjei8D0xpNhawtLXSowOZWu/VNqVaDeATTP?=
 =?us-ascii?Q?Qa0/zaFJ8WLecbuZ/PpuyPKE2j+173LYdASdkZhsN9jUNqTwMAP02QDYRxJO?=
 =?us-ascii?Q?qNdMoFm9B696UZAGtOHJUrlnAwGMfAk9dgkXgOY+dWgaJQhFkqM8Gz5rVU4U?=
 =?us-ascii?Q?Adua8OSUcCf0tSTU4Ri/dA5wny96bxY/oYaabo80NfHW8AbCGNZ1f3phnYPy?=
 =?us-ascii?Q?hOKJdNj+JvdHukqXXp0uYKRLEQ3YcSTdvkX2UkgxpIyITFKvSZxShFMgr4+Z?=
 =?us-ascii?Q?f03JWQDmaalHFli/Lw/hWKR9ohCDYb4tmlhjAmJzQw7XzxJLVldZLEM67w+t?=
 =?us-ascii?Q?n5X1RP8EjR90qCYtcjhfEnOoNNqvc+5inO8cvfmzIfWfv/rRLVjhI/kFaLBb?=
 =?us-ascii?Q?9jjiRjTbYCOAzWE+V1WaLWKEVzqF1+U9pn6nmWfjd7tJmusdglhBLSgRTalf?=
 =?us-ascii?Q?T34sSmdQHOYpoJRuRT2kv6WumZ5RP8o0PbR5LUrv6WlpZtFEId4UkZK7SuQb?=
 =?us-ascii?Q?5eNZOZYfoi8Jmqv7+oPXX0nlISlMF4iTzhRL90adK3CYA4WUKU2Zax7XfRtS?=
 =?us-ascii?Q?DqxLpfjNKHkAHmt/LjImjfi4ToPkUiWOWsDd2l0GNHRqXxjt1OmuaeS6bH04?=
 =?us-ascii?Q?LgZ/wQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2026 04:56:54.1059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6df208a-cb03-466f-d962-08de5584d5a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972

Controlled by the IOMMU driver, ATS is usually enabled "on demand", when a
device requests a translation service from its associated IOMMU HW running
on the channel of a given PASID. This is working even when a device has no
translation on its RID, i.e. RID is IOMMU bypassed.

On the other hand, certain PCIe device requires non-PASID ATS, when its RID
stream is IOMMU bypassed. Call this "always on".

For instance, the CXL spec notes in "3.2.5.13 Memory Type on CXL.cache":
"To source requests on CXL.cache, devices need to get the Host Physical
 Address (HPA) from the Host by means of an ATS request on CXL.io."
In other word, the CXL.cache capability relies on ATS. Otherwise, it won't
have access to the host physical memory.

Introduce a new pci_ats_always_on() for IOMMU driver to scan a PCI device,
to shift ATS policies between "on demand" and "always on".

Add the support for CXL.cache devices first. Non-CXL devices will be added
in quirks.c file.

Suggested-by: Vikram Sethi <vsethi@nvidia.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/pci-ats.h       |  3 +++
 include/uapi/linux/pci_regs.h |  5 ++++
 drivers/pci/ats.c             | 44 +++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 75c6c86cf09d..d14ba727d38b 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -12,6 +12,7 @@ int pci_prepare_ats(struct pci_dev *dev, int ps);
 void pci_disable_ats(struct pci_dev *dev);
 int pci_ats_queue_depth(struct pci_dev *dev);
 int pci_ats_page_aligned(struct pci_dev *dev);
+bool pci_ats_always_on(struct pci_dev *dev);
 #else /* CONFIG_PCI_ATS */
 static inline bool pci_ats_supported(struct pci_dev *d)
 { return false; }
@@ -24,6 +25,8 @@ static inline int pci_ats_queue_depth(struct pci_dev *d)
 { return -ENODEV; }
 static inline int pci_ats_page_aligned(struct pci_dev *dev)
 { return 0; }
+static inline bool pci_ats_always_on(struct pci_dev *dev)
+{ return false; }
 #endif /* CONFIG_PCI_ATS */
 
 #ifdef CONFIG_PCI_PRI
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3add74ae2594..84da6d7645a3 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1258,6 +1258,11 @@
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
 #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
 
+/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
+#define CXL_DVSEC_PCIE_DEVICE				0
+#define   CXL_DVSEC_CAP_OFFSET				0xA
+#define     CXL_DVSEC_CACHE_CAPABLE			BIT(0)
+
 /* Integrity and Data Encryption Extended Capability */
 #define PCI_IDE_CAP			0x04
 #define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index ec6c8dbdc5e9..1795131f0697 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -205,6 +205,50 @@ int pci_ats_page_aligned(struct pci_dev *pdev)
 	return 0;
 }
 
+/*
+ * CXL r4.0, sec 3.2.5.13 Memory Type on CXL.cache notes: to source requests on
+ * CXL.cache, devices need to get the Host Physical Address (HPA) from the Host
+ * by means of an ATS request on CXL.io.
+ *
+ * In other world, CXL.cache devices cannot access physical memory without ATS.
+ */
+static bool pci_cxl_ats_always_on(struct pci_dev *pdev)
+{
+	int offset;
+	u16 cap;
+
+	offset = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					   CXL_DVSEC_PCIE_DEVICE);
+	if (!offset)
+		return false;
+
+	pci_read_config_word(pdev, offset + CXL_DVSEC_CAP_OFFSET, &cap);
+	if (cap & CXL_DVSEC_CACHE_CAPABLE)
+		return true;
+
+	return false;
+}
+
+/**
+ * pci_ats_always_on - Whether the PCI device requires ATS to be always enabled
+ * @pdev: the PCI device
+ *
+ * Returns true, if the PCI device requires non-PASID ATS function on an IOMMU
+ * bypassed configuration.
+ */
+bool pci_ats_always_on(struct pci_dev *pdev)
+{
+	if (pci_ats_disabled() || !pci_ats_supported(pdev))
+		return false;
+
+	/* A VF inherits its PF's requirement for ATS function */
+	if (pdev->is_virtfn)
+		pdev = pci_physfn(pdev);
+
+	return pci_cxl_ats_always_on(pdev);
+}
+EXPORT_SYMBOL_GPL(pci_ats_always_on);
+
 #ifdef CONFIG_PCI_PRI
 void pci_pri_init(struct pci_dev *pdev)
 {
-- 
2.43.0


