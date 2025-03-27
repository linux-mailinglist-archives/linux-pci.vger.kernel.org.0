Return-Path: <linux-pci+bounces-24802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA74A7284C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 02:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824C3173B19
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 01:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033091922FD;
	Thu, 27 Mar 2025 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3ngZ6wam"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEE9190664;
	Thu, 27 Mar 2025 01:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040072; cv=fail; b=LLq9rNQ2di5eYgHFOR4oubnlsE+ClIW8VC+ekGmkW7y7dzHJTPfkL4g2Nthoesl5kH7IjQFE1Tw5y8Jl7FvSWSl3Vfi2eXmxnei5XjUF8owatMX5FUsxksmn+hV8EshFPukI3kwL8iDI/nBlozyZTUpwwKyL5BqlFcC1ibsxaTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040072; c=relaxed/simple;
	bh=XwvEiS8cDx/EuhtklG73Cp/2T4HpXtjIkooQdFNfbUc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKmawSfqN6xmawi7UBltcyvuhuJYjG1+4PaqxdQaZGd2lYmv4YbMJLVx0cBczN6eWmYDH6E4NMCIH++H70XN/z8sm55W9hrBqfGToOqN2VBw0XuWGB31wVbz1wqFW31Cca+u3LBoBof7KSnFsZpvusR1hbTGERxilCRmeDBeg+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3ngZ6wam; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDtuKJXBkDqJFXRJF0YKDYLAk16EHwCrCIu/3/L9VBJBwVGh10bbRe+cKL7G23OHGNVsPEQz5YtLgrH2EsdcvaKWq6MS2awkEayjgCWZluwiOmUpf6lA+JWTwAecFZo/izTraR4WBp2uYbX6Iyb+ZPLZt+gBc6CT6UF4zhMXF8FlrMF29BtKsqcMdo8+3IRFhEqzISNVV+XM3lwY7C0sniLTojInRPv6H5kLhQnSnjH0Kql81ho23Ofr2ISN9mZLsuvOgFtOTlZZ5Tmi+pcXmnLGIYmqDsOIyzZ917evkQK8Pg0CMVq19YRlL+EQ/l7u0UmGOtzlXlNVi4t76kpNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jH2P37Wz2Xs60Q9HyBzu4urL0zeiyKS7pjZmXbu5+RM=;
 b=eGHt/+ZPbHpenX5HBQBzKn+DhbnkLE5GiPrhGmRxtc2TQnzlik/+4S5JRsCmwytTIOCXnAuJGdCfe1tBlbeBKYdOAjzfGHIbAPIM+YB6morFa5QGQtp22rPBhV0FXq24GvjO7tY9Qsy5OS7/NzI1Yk/oZa2cqnZqmFjTen9Bg9VkucaozdRrk7sHx6+vuXWCTI5nTM+w7xGbxXPfeYcTLo6heq/cgPjkYD1N3DjGARmzwYvPj5rvsYJc3eKDfOwyrHBwMaPo3kzAivZidx/6jCk+gpYkWlrANpaQ01no+srUYTC9KtllPWX8ucG6IwVli3hqZy8jZiKnx263VWEbcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jH2P37Wz2Xs60Q9HyBzu4urL0zeiyKS7pjZmXbu5+RM=;
 b=3ngZ6wam4Q7Bvi9gPg2v5u+iwWWxlrnppNs9iLZ/y54oPex1vfNTzh9Y8Nx26DZrnAgegeFzoYP0MKdypjwW6AINwEVwKNHhk3rzlJKBHd21EqRzAkpfjWQ8ZQ71VG7Th013rPmombSAkpw7Il/aLfgTg7yLH7QHsY8cvBA0LC8=
Received: from BL0PR1501CA0021.namprd15.prod.outlook.com
 (2603:10b6:207:17::34) by IA0PPF170E97DF1.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 01:47:47 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::24) by BL0PR1501CA0021.outlook.office365.com
 (2603:10b6:207:17::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 27 Mar 2025 01:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 01:47:47 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 20:47:46 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v8 02/16] PCI/AER: Modify AER driver logging to report CXL or PCIe bus error type
Date: Wed, 26 Mar 2025 20:47:03 -0500
Message-ID: <20250327014717.2988633-3-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327014717.2988633-1-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|IA0PPF170E97DF1:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f7651a-e431-49d7-eb40-08dd6cd16018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z1OTxdnmsx/krG7+9WE/vRF26CEdPtw+HsJX7Fs8rJMnvEAq4WWxNuGq0kaK?=
 =?us-ascii?Q?OUSbnv2f0BDEa+INSgVSxI1eEnm+N00KRPCCeFr7B0cPfpuZwdXY8pChmXE/?=
 =?us-ascii?Q?/AAjdt6q8Nl0eDvtyUt7uR6zIDe37xcT5cuWs/yFVcH3fDgLYBOCCctWqNT/?=
 =?us-ascii?Q?k09pkAD7GteBMPl7kIbvYVqdanb/jGyRzy7yRFZ+7QqU54y1KkZtnJys1oqO?=
 =?us-ascii?Q?SQ3pnJBr2TOTXNM8OMxAAzGZl9FCYWC9mpfMf/e3SezTNIVC5fhTsBnjBYAI?=
 =?us-ascii?Q?y+GwhoTwUBjo/cH8ee6wq3S/A7iKxmQIe2zKoY4A2o06IZUgh1zWq1pheLU0?=
 =?us-ascii?Q?Rje1LnBDeC8C65Wm3QebLAUWVKkP1wXDGNiRJkHeX2i+pxSOk++XyleA1Cy6?=
 =?us-ascii?Q?GZUpjHu7PxcyikJjjqLk88BvUmK0Tqb8PEy6UZoeu55W9ixgQvQH3nQWJ5gh?=
 =?us-ascii?Q?VItRQfo+8iAcqtqduUh/gI5+nc0LfXmntolA9Zn0WDvDpmqGlDsw1AZS3MfH?=
 =?us-ascii?Q?gq4w8EMT3kcyp8dUbJsrokkJgsWJ9fnzoDIapAbt+rPdtXEwOszninANyW3k?=
 =?us-ascii?Q?aR8F+VZioyDdobp/UaV8UUZJ3MS/Y9jz4NOkwOpN3LcnfTbycZ8KGx0LDGPW?=
 =?us-ascii?Q?hPE/fZmrlSAo8twNuEcC7hnbJg8tAu6oMzdNG3p4qKzM2waG6gVPsIzF2be/?=
 =?us-ascii?Q?jtG7Tmt4wfd9zOB2eqwpOadtEOD1lLcNxqOpcYoCtd0I8aVsZbRG/WKNOtXi?=
 =?us-ascii?Q?UiNhIZbZytA3A7lecME3i1vfeFxKHIHEP5FhBR879YkQg+C1idG8Z4X/4lNz?=
 =?us-ascii?Q?jJQVNB4j3SThIhYvJkXcMnoK0obh7bQVnVfkZqSVvRgEPprI1Bbf10tfW385?=
 =?us-ascii?Q?howGAluOySxrQ1HWuTBoMMtBFpej34afywcGvzyzi7mld5GC+Yl8SFfD7G4Q?=
 =?us-ascii?Q?fLHv/do3pfRH68Un5V1TnskDEBBKE1xissOvoLBdodzL5OzWcL36wxSxEkxo?=
 =?us-ascii?Q?hjqbsGPvRhvxrRNrOgNsZ2P7ZRTwHwC0NQDDVoyPFaJMp7H/cAKBA1sVK9C0?=
 =?us-ascii?Q?ABKbEseyYNIgL6mp2rr3IWHBvucoO//V/ZhrkgrGcA/mDiPu+aFCvFAPwqT7?=
 =?us-ascii?Q?K/gShUAzasnn+12Zjh3EWGLpl0dUlVD1lRVFlY9H18ZfUN0Ui1euyr8VXjNe?=
 =?us-ascii?Q?9aZ+BDTAL258IYx6/rAsucg0ng/ZbNKlMuumeCZ6Ohsf8OR1Cwx18Rnd96cI?=
 =?us-ascii?Q?Mpa3t8dQVlnJJE5okdxHBC4AsDBFvNqLt13lspJy0+LWGXR3oBH5l3BzuYqq?=
 =?us-ascii?Q?Qjd5d/liu2nVIOZoRSkSK4pvRDefs+UvbX46Vsq8Jfw8UuudpJd9paQJCw2Y?=
 =?us-ascii?Q?5dKMb2mNxjbMUCccQRvZczQ8SM8NjJS0ev8AKYKT1j37c6fHbc8Zft0QQJ5M?=
 =?us-ascii?Q?1iAIvN4qXxrwlfCK7SPrx+7K7oSanC6QMj0hyZykpp1qg7wzPKaaVsD+/amF?=
 =?us-ascii?Q?cbw2hDpf4lwu5oR2Ly0UZcTPS3NFrSxqpXZX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 01:47:47.2376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f7651a-e431-49d7-eb40-08dd6cd16018
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF170E97DF1

The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
for all errors. Update the driver and aer_event tracing to log 'CXL Bus
Type' for CXL device errors.

This requires the AER can identify and distinguish between PCIe errors and
CXL errors.

Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
aer_get_device_error_info() and pci_print_aer().

Update the aer_event trace routine to accept a bus type string parameter.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/pci/pci.h       |  6 ++++++
 drivers/pci/pcie/aer.c  | 18 ++++++++++++------
 include/ras/ras_event.h |  9 ++++++---
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 01e51db8d285..eed098c134a6 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -533,6 +533,7 @@ static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
 struct aer_err_info {
 	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
 	int error_dev_num;
+	bool is_cxl;
 
 	unsigned int id:16;
 
@@ -549,6 +550,11 @@ struct aer_err_info {
 	struct pcie_tlp_log tlp;	/* TLP Header */
 };
 
+static inline const char *aer_err_bus(struct aer_err_info *info)
+{
+	return info->is_cxl ? "CXL" : "PCIe";
+}
+
 int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 508474e17183..83f2069f111e 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -694,13 +694,14 @@ static void __aer_print_error(struct pci_dev *dev,
 
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
+	const char *bus_type = aer_err_bus(info);
 	int layer, agent;
 	int id = pci_dev_id(dev);
 	const char *level;
 
 	if (!info->status) {
-		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
-			aer_error_severity_string[info->severity]);
+		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
+			bus_type, aer_error_severity_string[info->severity]);
 		goto out;
 	}
 
@@ -709,8 +710,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 
 	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
 
-	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
-		   aer_error_severity_string[info->severity],
+	pci_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
+		   bus_type, aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
 
 	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
@@ -725,7 +726,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	if (info->id && info->error_dev_num > 1 && info->id == id)
 		pci_err(dev, "  Error of this Agent is reported first\n");
 
-	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
+	trace_aer_event(dev_name(&dev->dev), bus_type, (info->status & ~info->mask),
 			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
@@ -759,6 +760,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		   struct aer_capability_regs *aer)
 {
+	const char *bus_type;
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
 	struct aer_err_info info;
@@ -780,6 +782,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	info.status = status;
 	info.mask = mask;
 	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
+	info.is_cxl = pcie_is_cxl(dev);
+
+	bus_type = aer_err_bus(&info);
 
 	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
 	__aer_print_error(dev, &info);
@@ -793,7 +798,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	if (tlp_header_valid)
 		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
 
-	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
+	trace_aer_event(dev_name(&dev->dev), bus_type, (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 }
 EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
@@ -1211,6 +1216,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 	/* Must reset in this function */
 	info->status = 0;
 	info->tlp_header_valid = 0;
+	info->is_cxl = pcie_is_cxl(dev);
 
 	/* The device might not support AER */
 	if (!aer)
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index e5f7ee0864e7..1bf8e7050ba8 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -297,15 +297,17 @@ TRACE_EVENT(non_standard_event,
 
 TRACE_EVENT(aer_event,
 	TP_PROTO(const char *dev_name,
+		 const char *bus_type,
 		 const u32 status,
 		 const u8 severity,
 		 const u8 tlp_header_valid,
 		 struct pcie_tlp_log *tlp),
 
-	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
+	TP_ARGS(dev_name, bus_type, status, severity, tlp_header_valid, tlp),
 
 	TP_STRUCT__entry(
 		__string(	dev_name,	dev_name	)
+		__string(	bus_type,	bus_type	)
 		__field(	u32,		status		)
 		__field(	u8,		severity	)
 		__field(	u8, 		tlp_header_valid)
@@ -314,6 +316,7 @@ TRACE_EVENT(aer_event,
 
 	TP_fast_assign(
 		__assign_str(dev_name);
+		__assign_str(bus_type);
 		__entry->status		= status;
 		__entry->severity	= severity;
 		__entry->tlp_header_valid = tlp_header_valid;
@@ -325,8 +328,8 @@ TRACE_EVENT(aer_event,
 		}
 	),
 
-	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
-		__get_str(dev_name),
+	TP_printk("%s %s Bus Error: severity=%s, %s, TLP Header=%s\n",
+		__get_str(dev_name), __get_str(bus_type),
 		__entry->severity == AER_CORRECTABLE ? "Corrected" :
 			__entry->severity == AER_FATAL ?
 			"Fatal" : "Uncorrected, non-fatal",
-- 
2.34.1


