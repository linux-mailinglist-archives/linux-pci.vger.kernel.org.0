Return-Path: <linux-pci+bounces-28887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20818ACCBEA
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABF33A756C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDB11C54AF;
	Tue,  3 Jun 2025 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cn5GVnbm"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566FF1A2547;
	Tue,  3 Jun 2025 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971382; cv=fail; b=hnEetwp2O/yZtnhNtnnSO0FTRVlEUG3/IIR5AcpvoQg0/mBEyrm8ktQPVJSSi9EXhMrb2Q1dZY9oPAzcE18vRujhhSRY+6qhIyBdbb2cJ8inkhmTEnb6GxUJgh323Oo4+u1D7MnwrASZjgQImYsgHDV0OpGcMomxT2Q/xuhKmXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971382; c=relaxed/simple;
	bh=vRFb4Kf1zyQHFZm3yG9NJtXxnUThjBe0qm9rETopzig=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iL339shzEkuCKOOVWXJ3ZGW36GKmSmE/Q52Pq8NMbSYoDU1TYmX2NuYmcV1a61CU7JkKBy549Llk89OgY18dwbq4+GbXmcXEB9EuLBoTXAQf36mts/tKJcRvMOO0iWqGuXHSTkXLT2/cnu3PARihqpOC/mIFbB8T7BYs97ehny8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cn5GVnbm; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vom5G7KsqSkZ1Dy0U8gWSH3LhoFKYUK6hA9lRDQ3lEiUERKPBlZmyHJyFKaxA2cjuSunMiLatb44j+OU5lVpenZYBnl1JVuODbbiut7O0erGNzhViBbOz9MtvFwu8/ALLWbpYG4OvXztYJ+uS9vEWWB/sgAsdd48Yh50FSHHxW2obDZN9HnPi+r85odyY/WGuBBybDerYB2KimRVgaalLHIZyRlV2ikvas7PJDb3sPQC3yLb8pEC94tBG2MYhVUmJWye1Dn+Ux7CQ19NVsR+PXl1lD+L9dkwT+lWnzUKO0QkeAENeSaYC/SZaAWfqsyYu6x1hI15GmQCVpBG/K0Vyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAH8vnSytbnu8wbW8RRM891DW4O6CXLGVKT9aqu9n8U=;
 b=WWRWW9AQuLebB6JUEmRUKRMZeKNn7CnNtVs1KD4Vdr2cYY6BDSs3/XUXn+gQfiYR1KR49k1WPnlmBBFQw+jTF1ciiqakTzh+f9qM1uzZHlDjB5xl/Px076XnDlIzwg9KY3fOyIH6PdI4je62CKupSXP9Apti7gjq4vK3/1Gf5XeOuJEu7eBNS9deWSdDCX0WNW9RxFtT/LiEysRKTsotYRoT2griv6UHI1QCxcGXlNt6OZz5KXlEl0qwhfNJoXXbQ0yaQO764yGjFM9WMd7x45Ghk5y/qez5pDGl+6vszC4KTzoxkZ9Q89TmJf7yxKySWqAa9Zt0ONAHYFerLAAxkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAH8vnSytbnu8wbW8RRM891DW4O6CXLGVKT9aqu9n8U=;
 b=Cn5GVnbmjch/fM1DIG0Tn+Kn7DPqeQVdhfRCCPb1nBQmJYIlp+V+2fiUTzOEGNjy1VDnbzj+uYGyVA3ur80Zt8+yZvKU12lPdjPSR318iUjb5hJRpdDOUpyhjq+MK8Wb11xR1R+qbIsV2mFaGdy+iL73tjlBAaGmTy702/BHGyA=
Received: from MN2PR06CA0026.namprd06.prod.outlook.com (2603:10b6:208:23d::31)
 by IA1PR12MB6020.namprd12.prod.outlook.com (2603:10b6:208:3d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 17:22:57 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::a9) by MN2PR06CA0026.outlook.office365.com
 (2603:10b6:208:23d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 3 Jun 2025 17:22:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 17:22:57 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 12:22:55 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <PradeepVineshReddy.Kodamati@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<bp@alien8.de>, <ming.li@zohomail.com>, <shiju.jose@huawei.com>,
	<dan.carpenter@linaro.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<kobayashi.da-06@fujitsu.com>, <terry.bowman@amd.com>, <yanfei.xu@intel.com>,
	<rrichter@amd.com>, <peterz@infradead.org>, <colyli@suse.de>,
	<uaisheng.ye@intel.com>, <fabio.m.de.francesco@linux.intel.com>,
	<ilpo.jarvinen@linux.intel.com>, <yazen.ghannam@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v9 01/16] PCI/CXL: Add pcie_is_cxl()
Date: Tue, 3 Jun 2025 12:22:24 -0500
Message-ID: <20250603172239.159260-2-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250603172239.159260-1-terry.bowman@amd.com>
References: <20250603172239.159260-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|IA1PR12MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: dc989922-ceee-40c7-0da8-08dda2c3483b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?94ZE79Unk92VWG38Q4BOhiGAykZ4R6wUH/X8CJqxTv5E0+1nN7RVpcQ8xgBm?=
 =?us-ascii?Q?/FG7djZ+5cjU1hHR15Rj5esZT0TDkurTFBOspoMPC1GpUfLJusIexoBI9FvG?=
 =?us-ascii?Q?rws8lnU3lwR1MTtepqAs4pBInrWJYBDyafUtQi/mGQElz+85KY67XsnGDojp?=
 =?us-ascii?Q?CFSjxJiXbnwTIMTNjHSvq/5EseCj1HpxsK0C8c0kwhqnAkMMMcQOe6MSXi+0?=
 =?us-ascii?Q?qJuGqZMi5dZ6WQESbkcokrzumHZ/8jFWnFiBvMhTjgVXbExYKtafbibWcOtI?=
 =?us-ascii?Q?t2V38BEN57zlJXRh3WcGtdwsSaZQND/o2aDYOxIOthP9DNoTkWTrjT1mxKZE?=
 =?us-ascii?Q?bIvcw5giOo36hygtY/Vjn4ZPbQFxOCX+nh0XrnUmqLnykmBr4QNfVMq1PrJq?=
 =?us-ascii?Q?9p9xqeKuTSLm7KQchlT77uUO1apKPhE4edq9sbFCFzDkzg99Sw3uxNMK9Nib?=
 =?us-ascii?Q?p2tJF6K508DAkzEfhuNNWr0ddn4bD8KntGxtXtOVrShBXrRM82pzyHYS5wD1?=
 =?us-ascii?Q?Y1wEeTVpwaYUL82yBqXcR2rG+jv8Gl4yWq7ZW2Ka6LfpB5fn4ftp6pJZ4oHM?=
 =?us-ascii?Q?JFUrUPma7PhW70CsT+OGgn2EXtPWBLZg66/ZsdDfeEK7gvLZAvmc5M090D+x?=
 =?us-ascii?Q?JjU2q7IF204uy6XsVBlzAQVAhUQ9iPBCnRiz06p+16iHgfN7LVZLHOUrJH32?=
 =?us-ascii?Q?YzSoIXAOh6GCwMMrsPhvliGawvR64dvCMI8NLS0vCWW32IMWp+P+aAoXS84m?=
 =?us-ascii?Q?A3RTGzyrawjmnwsmzPG15lTmmcUOnHM9ELMDrZphz+h0FOzV49pN8r2WyvFM?=
 =?us-ascii?Q?5Ak774rVB4s+ywhbmphTosUZUKMWxm5WQVF9pbppF5HhAjbIGZ8wNsC4L5pI?=
 =?us-ascii?Q?xvbZtZeGZbtKjyq6fQgq5Onf7fWxuzMYhPA2KEIjyp7QCk74Oof288wgHjII?=
 =?us-ascii?Q?u5fRCD/9mZ0pYlABIqO71Eg03iYClwHhBEPUDTO3fs3gflcHocjkpvEQ0lvf?=
 =?us-ascii?Q?KY9nvDzvzZmWEqtlc0Mn+f1f5PJzqUE7NAIUXXVay4kO13VGySEDFdTcZwJq?=
 =?us-ascii?Q?rkgho8xd3pWRVmgsAfAUCUfKQTy6yW25Iy9SbIsh2esUIyUQXxyLngxqO9DR?=
 =?us-ascii?Q?JZ6ltktdIEfZhcuOR57+jO9Ys5izDJcvYbdAbTozZxu1sfYW/V/Bt+S9+J8Y?=
 =?us-ascii?Q?U3YfesGgnkej81GKhzeN6YidFm2FWGnbSXe7PDmeuVSuAbxnUkw9s3N9O1eT?=
 =?us-ascii?Q?VmFADDGDFKw4MlTKMh2ncRVBusj/ZrDpxSub4/Ank4rPaXhCsPRgg98MgQbr?=
 =?us-ascii?Q?tOx8Enw4XLNcpTc2NuKtxqgt34LhRSqw3ynRT0LpT1Do+pIGk/93Pgfjsuce?=
 =?us-ascii?Q?3KosYW6gSRXhAoZDDA9zdkAungwpy2yKPjIri5XNYxKSS/syrM5gLePwGr68?=
 =?us-ascii?Q?0eUKnlymBjbP6NvzCkNrukXOoE5TuR0hxCK5BuwhfGktwhi83QPsQpFZvYjJ?=
 =?us-ascii?Q?ZKtZe6L/WR1JL5ANBSq6G69mpOqGvHk0mns5cBCrLvC0BvLJ9So7GB4xow?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:22:57.0180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc989922-ceee-40c7-0da8-08dda2c3483b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6020

CXL and AER drivers need the ability to identify CXL devices.

Add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC presence. The
CXL Flexbus DVSEC presence is used because it is required for all the CXL
PCIe devices.[1]

Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
Flexbus presence.

Add function pcie_is_cxl() to return 'struct pci_dev::is_cxl'.

[1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
    Capability (DVSEC) ID Assignment, Table 8-2

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/pci/probe.c           | 10 ++++++++++
 include/linux/pci.h           |  6 ++++++
 include/uapi/linux/pci_regs.h |  8 +++++++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 364fa2a514f8..aa29b4b98ad1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1691,6 +1691,14 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
 		dev->is_thunderbolt = 1;
 }
 
+static void set_pcie_cxl(struct pci_dev *dev)
+{
+	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
+					      PCI_DVSEC_CXL_FLEXBUS);
+	if (dvsec)
+		dev->is_cxl = 1;
+}
+
 static void set_pcie_untrusted(struct pci_dev *dev)
 {
 	struct pci_dev *parent = pci_upstream_bridge(dev);
@@ -2021,6 +2029,8 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Need to have dev->cfg_size ready */
 	set_pcie_thunderbolt(dev);
 
+	set_pcie_cxl(dev);
+
 	set_pcie_untrusted(dev);
 
 	if (pci_is_pcie(dev))
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 51e2bd6405cd..bff3009f9ff0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -455,6 +455,7 @@ struct pci_dev {
 	unsigned int	is_hotplug_bridge:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
+	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
 	/*
 	 * Devices marked being untrusted are the ones that can potentially
 	 * execute DMA attacks and similar. They are typically connected
@@ -746,6 +747,11 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
 	return false;
 }
 
+static inline bool pcie_is_cxl(struct pci_dev *pci_dev)
+{
+	return pci_dev->is_cxl;
+}
+
 #define for_each_pci_bridge(dev, bus)				\
 	list_for_each_entry(dev, &bus->devices, bus_list)	\
 		if (!pci_is_bridge(dev)) {} else
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index ba326710f9c8..c50ffa75d5fc 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1215,9 +1215,15 @@
 /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
 
-/* Compute Express Link (CXL r3.1, sec 8.1.5) */
+/* Compute Express Link (CXL r3.2, sec 8.1)
+ *
+ * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
+ * is "disconnected" (CXL r3.2, sec 9.12.3). Re-enumerate these
+ * registers on downstream link-up events.
+ */
 #define PCI_DVSEC_CXL_PORT				3
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
 #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
+#define PCI_DVSEC_CXL_FLEXBUS				7
 
 #endif /* LINUX_PCI_REGS_H */
-- 
2.34.1


