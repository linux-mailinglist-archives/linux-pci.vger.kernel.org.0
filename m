Return-Path: <linux-pci+bounces-3545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B21C5856DF1
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 20:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF99F282B2F
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 19:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918B613A248;
	Thu, 15 Feb 2024 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KdhvadMc"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D2C13A254;
	Thu, 15 Feb 2024 19:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026142; cv=fail; b=QNwRF4DMPh02d1HitMXnRRTwqgiyayyPcUnj2grauoIeQZARRTTQR+NLjvo5vB11/T0fyd2E8ybvRV/nKQwoTQ2+JxgbjS6sWI6b5vjVW4cyfwde8H44zIdmh3HIc16C1kGMH5+BJIahwtF13cSdB1sttcDWS3pb08n2ywjqEtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026142; c=relaxed/simple;
	bh=t8QULpJ/kAF3QjKKDaJkpdFEz/LU3ch/TBWILa+D3tQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iVoOoozekrVgp3yZNAGmlsFbzJxj5oanG8aSZiWsbnDbt6yOmtj/HLxVTypdqfFdW0WV3MdmW0GNQ8OTGEPQHVUSDPwcosEsYORdkI69p56n7UHd+j9tCE3mNFkbMxAgPOZ6lD3Z82Qx5WbfCoyuv6Ok9w1OMl+B9iRfE2htfpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KdhvadMc; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQa+Ve2Eq3FkCfeHnvHoI/68MNWOpEwWprj5o85f1PmoLmnWBLCugkncN8J0S/M/bUCVaOvSZbAppiNwgKvs55QKyf4eOnWy+jEzYiSkXT1s7zkvNPh5lUnrwI3HRI35FARnH7yyAz4tkuRCHNW8HSpvGVRR8hGcLyiPpF1SHjY745kqLLDo0WIVlPtGZAOdgJlNG6pUziIf+4uy0lWpPpLkqanAWEmHYBvCNjvDRxTiWzn4KyT0mv8MWuWcvmxsHG5s8wZp0ezkhlWKW8dLYb9dyEuXyMBzfLm4TyFa2Pq/ORldY6px41zRWrIb7VKN0WzXOQNmsYhQ/kg3KpXFZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMESEFzIm0sARyWGAnL5qVWyjZ66O0qVZE9BnsLwK0M=;
 b=HfwVUfQzPek50oIJodjwAlHKbi7yIgSduS7P7YsRuSkKDdeX83rC0prwHFdOpDv4SdYQUKR/ssdfoqaam9kkAzzLYiXBJVBBfs9NMYJrKPKOPq9U6QRMO/O2V6SUXNPPHE/k1M8cFioUZ/tV0qQ8cvCpSUWAEVtbfx9hnamgg3XQscxCT9vrcv8S+Exk5IM+YcySv/ZfP8hR/LW5i5TDjC2a6Ms86CnS9GtKWwW268Q64SYBgAaqtLiXYTooO+eMTh6+BtqY/vi7l7QrULaeZyLrA/7YBcyxSx4TBuxmVm/M7GeSsGniLARBULw9SRcr/+DMwOE5AD5/ktVn6UOCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMESEFzIm0sARyWGAnL5qVWyjZ66O0qVZE9BnsLwK0M=;
 b=KdhvadMch74Y/OQVI5GwMIWF9UQipKoyeSXt/Sj/MgFhOcT4g01MDYqVYvss/nPhv18j738jdZY7M6xz3anAlS1Iv1ysX+63UIKiImSegkP0fMXWkX5DLKAtWE6ZLWVoY1xI8Q3467ULvW8BK7WCgcHW9fMu9w/mDQ711ruwM0E=
Received: from BN9PR03CA0769.namprd03.prod.outlook.com (2603:10b6:408:13a::24)
 by CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Thu, 15 Feb
 2024 19:42:18 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::fa) by BN9PR03CA0769.outlook.office365.com
 (2603:10b6:408:13a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Thu, 15 Feb 2024 19:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 19:42:17 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 13:42:15 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<benjamin.cheatham@amd.com>
Subject: [RFC PATCH 5/6] pcie/portdrv: Add CXL MSI/-X allocation
Date: Thu, 15 Feb 2024 13:40:47 -0600
Message-ID: <20240215194048.141411-6-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215194048.141411-1-Benjamin.Cheatham@amd.com>
References: <20240215194048.141411-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|CY8PR12MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f627258-3b14-4f1e-aea0-08dc2e5e37ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zb1SOSZ3FvtVFCZlJLolcD0odlF82SvDVBhCmChckUD0dbT/zjCuTs/gKqUMZsd2AcsSekBIqg70BPyWbyYSCQWTq7uBh6VlVnG+zMWd2aiRdEEjBtbDcNQ9L6uN1PNPW3oN2HpiqXR6bj3QCoin9w+5mOj5CDlqkxJtZ1QpMwZGeK8gvxqsL0vS+E0GghdjdZlxHjwLNDIXO7nspq1GmU1ppjvQPFfpe8MFAG4KBxyCfNGp8OzSKic3F6wyktjFxOWb1ZyzQKT9qlEfcFxLilrlWre3OqkuzaqUwcqvo438mY+5z9b2x1b0hNdF/1pEAh5zAXrQISGAjWnxNuycs5272y6BHfrqfdk8Ibu7ZYDRdW+AYzV7CbDMj1phOck9KGtSCD1uGwLYL/lRfNtZsGvwRtwrOAflCsH399X+I/rq3YodUMCwzxAaHf22JpXhZX4bZj2bH4PXttH33OwtI9Jwz0PnM4ACVzsPl0jimjBXn4kf2SGpw3DvkooX7w7QqPfK4KYDS9MoQAeVY0L7uSesMRcauEzcPLjHR2j0KgSO0+xhX66iQlnPuXKS3op0kJ/u+nQPQ4doMuwfUf2bK4xg2JFvKFaUu9WMqtV9GEdMFxRFTNB9ZwEk1USYh+xNOsFgmIlz1++9qrvyruty6gSxBX+Novzm/KZPJfhwASI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(451199024)(36860700004)(1800799012)(64100799003)(82310400011)(186009)(40470700004)(46966006)(478600001)(41300700001)(6666004)(7416002)(2906002)(8676002)(8936002)(4326008)(7696005)(316002)(5660300002)(110136005)(70586007)(54906003)(70206006)(83380400001)(86362001)(336012)(426003)(81166007)(2616005)(26005)(356005)(16526019)(1076003)(82740400003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 19:42:17.9360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f627258-3b14-4f1e-aea0-08dc2e5e37ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7657

Allocate an MSI/-X for CXL-enabled PCIe root ports that support
timeout & isolation interrupts. This vector will be used by the
CXL timeout & isolation service driver to disable the root port
in the CXL port hierarchy and any associated memory if the port
enters isolation.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cxl.h              |  2 ++
 drivers/pci/pcie/cxl_timeout.c | 11 ++++++++++-
 drivers/pci/pcie/portdrv.c     | 35 +++++++++++++++++++++++++++++++---
 drivers/pci/pcie/portdrv.h     |  6 ++++++
 4 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b1d5232a0127..3b5645ec95b9 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -132,6 +132,8 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXL_TIMEOUT_CAP_MEM_TIMEOUT_MASK GENMASK(3, 0)
 #define   CXL_TIMEOUT_CAP_MEM_TIMEOUT_SUPP BIT(4)
 #define   CXL_TIMEOUT_CAP_MEM_ISO_SUPP BIT(16)
+#define   CXL_TIMEOUT_CAP_INTR_SUPP BIT(26)
+#define   CXL_TIMEOUT_CAP_INTR_MASK GENMASK(31, 27)
 #define CXL_TIMEOUT_CONTROL_OFFSET 0x8
 #define   CXL_TIMEOUT_CONTROL_MEM_TIMEOUT_MASK GENMASK(3, 0)
 #define   CXL_TIMEOUT_CONTROL_MEM_TIMEOUT_ENABLE BIT(4)
diff --git a/drivers/pci/pcie/cxl_timeout.c b/drivers/pci/pcie/cxl_timeout.c
index 5900239e5bbf..352d9370a999 100644
--- a/drivers/pci/pcie/cxl_timeout.c
+++ b/drivers/pci/pcie/cxl_timeout.c
@@ -99,7 +99,7 @@ static struct cxl_timeout *cxl_create_cxlt(struct pcie_device *dev)
 	return ERR_PTR(rc);
 }
 
-int cxl_find_timeout_cap(struct pci_dev *dev, u32 *cap)
+int pcie_cxl_find_timeout_cap(struct pci_dev *dev, u32 *cap)
 {
 	struct cxl_component_regs regs;
 	struct cxl_register_map map;
@@ -115,6 +115,15 @@ int cxl_find_timeout_cap(struct pci_dev *dev, u32 *cap)
 	return rc;
 }
 
+bool pcie_supports_cxl_timeout_interrupts(u32 cap)
+{
+	if (!(cap & CXL_TIMEOUT_CAP_INTR_SUPP))
+		return false;
+
+	return (cap & CXL_TIMEOUT_CAP_MEM_ISO_SUPP) ||
+		(cap & CXL_TIMEOUT_CAP_MEM_TIMEOUT_SUPP);
+}
+
 static struct pcie_cxlt_data *cxlt_create_pdata(struct pcie_device *dev)
 {
 	struct pcie_cxlt_data *data;
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 7aa0a6f2da4e..c36fe6ccfeae 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -21,6 +21,7 @@
 
 #include "../pci.h"
 #include "portdrv.h"
+#include "../../cxl/cxlpci.h"
 
 /*
  * The PCIe Capability Interrupt Message Number (PCIe r3.1, sec 7.8.2) must
@@ -55,7 +56,7 @@ static void release_pcie_device(struct device *dev)
  * required to accommodate the largest Message Number.
  */
 static int pcie_message_numbers(struct pci_dev *dev, int mask,
-				u32 *pme, u32 *aer, u32 *dpc)
+				u32 *pme, u32 *aer, u32 *dpc, u32 *cxl)
 {
 	u32 nvec = 0, pos;
 	u16 reg16;
@@ -98,6 +99,19 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
 		}
 	}
 
+#ifdef CONFIG_PCIE_CXL_TIMEOUT
+	if (mask & PCIE_PORT_SERVICE_CXLT) {
+		u32 cap;
+
+		if (!pcie_cxl_find_timeout_cap(dev, &cap) &&
+		    pcie_supports_cxl_timeout_interrupts(cap)) {
+			*cxl = FIELD_GET(CXL_TIMEOUT_CAP_INTR_MASK,
+					 pos);
+			nvec = max(nvec, *cxl + 1);
+		}
+	}
+#endif
+
 	return nvec;
 }
 
@@ -113,7 +127,7 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
 static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 {
 	int nr_entries, nvec, pcie_irq;
-	u32 pme = 0, aer = 0, dpc = 0;
+	u32 pme = 0, aer = 0, dpc = 0, cxlt = 0;
 
 	/* Allocate the maximum possible number of MSI/MSI-X vectors */
 	nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSI_ENTRIES,
@@ -122,7 +136,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 		return nr_entries;
 
 	/* See how many and which Interrupt Message Numbers we actually use */
-	nvec = pcie_message_numbers(dev, mask, &pme, &aer, &dpc);
+	nvec = pcie_message_numbers(dev, mask, &pme, &aer, &dpc, &cxlt);
 	if (nvec > nr_entries) {
 		pci_free_irq_vectors(dev);
 		return -EIO;
@@ -163,6 +177,9 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 	if (mask & PCIE_PORT_SERVICE_DPC)
 		irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, dpc);
 
+	if (mask & PCIE_PORT_SERVICE_CXLT)
+		irqs[PCIE_PORT_SERVICE_CXLT_SHIFT] = pci_irq_vector(dev, cxlt);
+
 	return 0;
 }
 
@@ -274,6 +291,18 @@ static int get_port_device_capability(struct pci_dev *dev)
 			services |= PCIE_PORT_SERVICE_BWNOTIF;
 	}
 
+#ifdef CONFIG_PCIE_CXL_TIMEOUT
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
+	    pci_find_dvsec_capability(dev, PCI_DVSEC_VENDOR_ID_CXL,
+				      CXL_DVSEC_PORT_EXTENSIONS)) {
+		u32 cap;
+
+		if (!pcie_cxl_find_timeout_cap(dev, &cap) &&
+		    pcie_supports_cxl_timeout_interrupts(cap))
+			services |= PCIE_PORT_SERVICE_CXLT;
+	}
+#endif
+
 	return services;
 }
 
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 5395a0e36956..f89e7366e986 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -129,4 +129,10 @@ static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
 #endif /* !CONFIG_PCIE_PME */
 
 struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
+
+#ifdef CONFIG_PCIE_CXL_TIMEOUT
+int pcie_cxl_find_timeout_cap(struct pci_dev *dev, u32 *cap);
+bool pcie_supports_cxl_timeout_interrupts(u32 cap);
+#endif
+
 #endif /* _PORTDRV_H_ */
-- 
2.34.1


