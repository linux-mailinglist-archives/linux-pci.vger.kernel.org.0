Return-Path: <linux-pci+bounces-19441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D58CA042EF
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61CCC7A130C
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E841E47DB;
	Tue,  7 Jan 2025 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5hqwzdaH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B861B1E515;
	Tue,  7 Jan 2025 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260937; cv=fail; b=E8T4yq8rGsgRpNVbZaXfXPIl+FTDa8Ublc7SM8A0SGChX9W0mGqV2ux71j0RReOW2ohyuO1Xg2JG5qZx65rc3uTLM9Z0hUykzYzg60n233KcZF9cgQbTRLToOIsacfM+1CaE08SwKFzT+bc2b0TLvptF/NywVrG3QsmIybwQrP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260937; c=relaxed/simple;
	bh=b0I8ot9Od0jzHT7AyI7oG/4Fl8RW+mObr5waIijrVKI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCgRMjHNVJ26AaLkvYsw316x6i4KHGleCyYVGiMyROoOT3F/N612BECBNfE67g5zL5HFqonf+b1WkKH/GsDmn/YneEZ+kVRmakGAcGyUpDJs4Sk0xsNZh+cXUe7konnfMJF4ZXZuHhPApMsZ3e5jGMizNtsHcerC65IPJQ8yLCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5hqwzdaH; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgy8qQwzWMJv+q5amELgcKprARWvbb/1K1wIZVXOuyq39MBtzc/hJnyJSFiUl08y65eiyyTxEm0oGhLceOC+aAIp56HB7S8pbvszxFMtDQjLYUETlDdZarKGbHNmhUs4BSy1CRzQNA4WGfrEmJ00vlIpAfoSnB+G8P39G+qQx2+MU/ul0I6soOExh5wKPuAFM4zo6Z4h3GBTENM+/2DJ1HgQTjSu/NTT4tbias5Wz95FD4g2qbJhQhGSSHzDxGEguute2ivD3ESZpKOeMgBYQzXt1ugvUHGvmjnOZmCBhPpX48KoB2eadslf9KLOwYsnDXGldbLfdueE23J89tI/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1LuczFXAutkBvfhL29C/aPHNVn2RJvV5OdBofxx6u4=;
 b=ilk6W7bpXtO/bl7osF2mqnmSDNCo8cpFl5dM+/5EdzNUE6a9Ym8nAtB+rO/Ehs7eatzNEbJcZgxE2S8uY4EBPcYxsGZE6rcagubCCUcWraTzleVroS4rWRQEW0aLtzGO0nTADC50ofbAMN/1O+4tW7Jk9eal1dCM/4kDtYWSnwAv8uSACaP8Pv3emINo3u2NIx7Jbgpk6gwtJQsrsEC32PUbLB6uj6LyXj/xoZGCgZDqK4hKBl08tcxY3sDDYveb5pi/fv3JuENG1SIbwwTFMGAA25dkKYhywx9NIw6qHx/qJwUP6K1bnBzR19WTse4I6XaVoFbOGfxBwrcsuD07dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1LuczFXAutkBvfhL29C/aPHNVn2RJvV5OdBofxx6u4=;
 b=5hqwzdaHD2sqOzqr/CXKNFborV2FCnY6JGezOzJmnscif2VEfixkaQVMz6io5OSgldW6LE6ioicHf2oYUOOWiFuLriKDGx0Wy2P3YPx6pywzUJ+3qJ4Ns1GtICy3sSs8/pNb0235eKS4NGoSFz8sXt02yDT6dU+MpjilW3o5cPs=
Received: from BY3PR05CA0042.namprd05.prod.outlook.com (2603:10b6:a03:39b::17)
 by PH8PR12MB6964.namprd12.prod.outlook.com (2603:10b6:510:1bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 14:42:02 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::65) by BY3PR05CA0042.outlook.office365.com
 (2603:10b6:a03:39b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.9 via Frontend Transport; Tue, 7
 Jan 2025 14:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:42:02 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:42:00 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>,
	<alucerop@amd.com>
Subject: [PATCH v5 16/16] PCI/AER: Enable internal errors for CXL Upstream and Downstream Switch Ports
Date: Tue, 7 Jan 2025 08:38:52 -0600
Message-ID: <20250107143852.3692571-17-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107143852.3692571-1-terry.bowman@amd.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|PH8PR12MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 722ac0b4-4adb-4656-dfb0-08dd2f2972ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vrdz8Kbcc5vAmm5r8o0ZlaUuifBCOTIz+otsFLxByHmVqCLs5vvS/XajtMwy?=
 =?us-ascii?Q?EhpEe0kNdjbyNsiczbYwzcwlF99rsIHlnGjhNqVhBPLrBNVJ5FD049MdAAzB?=
 =?us-ascii?Q?Ptfq8Qe9O2Bo8ng8a9ynSXEo3GHjeE01lg5T3lWJS4UoXSyLlQGaCOCuq/K/?=
 =?us-ascii?Q?6DoYlSaiqsuGcYz/T4t52ztZoDq38u/qRrgJfI97OGG+8FaSycMca29D5+kC?=
 =?us-ascii?Q?Rhlj28cyOEBnrBfbQ+8U7ooG9l9P4hK1a6i9fN77RBOftnpBD7RNkJT7LSpt?=
 =?us-ascii?Q?7pPnO6IM5jZWIhoaSiJzN9DI1iQwk1fDq0EtxPFibMn7vUfuyFDyi1m0FhqZ?=
 =?us-ascii?Q?0z+BTy8Qew7L/u6Mc/ghA8AtQ7E3NImoXgMRnJi6gxqfIRTIBmkmc1hNK0Kz?=
 =?us-ascii?Q?7RwAvvF4LWxvKr/KnmQAjMwyEa0CvV+B1wczNXA/AmYdeeoD98pC7wTq1kFg?=
 =?us-ascii?Q?5XT9LROH2Tw3kknzmGRRqL44Ua33cVGdGKA9yI+ryRNP/tfTeTcbhWauw58d?=
 =?us-ascii?Q?LnPLMVEsmQva3gDVwfQVSxaqD+K4pnzjxiDFSkfmeMBHOKn2n4bSGUSGP6fU?=
 =?us-ascii?Q?IIwZtj7ZjcfR9YYaUuFvdY9/+KlZLiGlUo0CdA4Yx8tldPIvghDQWZcWzmYZ?=
 =?us-ascii?Q?/BbQKBQb1U5FlbRrjBObgToLA1KAge66y2nAXliR2qoVhDY9Hmf0AfH9N7q4?=
 =?us-ascii?Q?7BBDma99mpmcQKFWeg/013CU3j83sWpNGrpdJVL08ejltLWpKllDaFmYG6B/?=
 =?us-ascii?Q?gmhgMiYcn0S9/h8KMKQgrdAg02bhh+i2KfrwzxIR3oNC9A0rAeIdhiM2Uaz0?=
 =?us-ascii?Q?ifI16A7Y4L3Ipysd3pdcDDxBQYSWn9hIC0L37bd4nNqiVwBUSmG/pMUHWaNC?=
 =?us-ascii?Q?xLgXb7hNt1hfYlMGUhMo3KUdtqz5W8pNQ+AYN4jManX6K0tsH7eF9qKFVARS?=
 =?us-ascii?Q?rwCfeyraCKvt8uMX6OZ5Ji0S02ipX8mwphWtEFTUES/rK+s5Pllhfq7Ps7YW?=
 =?us-ascii?Q?ElQpRzOE1Z24ub5vNAsCCYbPKztR95tF++lbBWTJrR+HDqM95Of3HKLIf14Y?=
 =?us-ascii?Q?uXjvrEPWxIjQSfFPvfvu8Sd3YvAoAN1mvbhyxX0wWkM/ExHMd7LjZIGgIGEb?=
 =?us-ascii?Q?+5WKqlpKbbCkqWTpszpZ35pogfBc+E4A7U9AM75QWyVVVelu1dpp/0zPz1Bc?=
 =?us-ascii?Q?7T5D7TqkEtvTAcGw3i6J3nr2YRcSFe4uWWfoOUt+n0aqBCmECNy92ajVBhSp?=
 =?us-ascii?Q?oapulYbOH7T3NVu+3eWUpOzty/B6T8nzmfERjjW3Qr2YjLMqL2ANSyr2W5jl?=
 =?us-ascii?Q?Q3L/fQb+DiPYiCRVtvCXfk0EirlwOlqat8rwNfgE1Nq31PiSaqkylSk+hY3H?=
 =?us-ascii?Q?+tU7FYkdkmwW4pPxJtVf0w1F0toe4/bJgf77N2MXxIS+seqZort2fhDbeWMO?=
 =?us-ascii?Q?ZDKKFFs5NuCXKXLYXY4Kn7oktc1l5ebKf3UD8YTDF55ppze5cI7+TDnvGI7e?=
 =?us-ascii?Q?UWnax1jKbhrZ//w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:42:02.3075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 722ac0b4-4adb-4656-dfb0-08dd2f2972ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6964

The AER service driver enables PCIe Uncorrectable Internal Errors (UIE) and
Correctable Internal errors (CIE) for CXL Root Ports. The UIE and CIE are
used in reporting CXL Protocol Errors. The same UIE/CIE enablement is
needed for CXL Upstream Switch Ports and CXL Downstream Switch Ports
inorder to notify the associated Root Port and OS.[1]

Export the AER service driver's pci_aer_unmask_internal_errors() function
to CXL namespace.

Remove the function's dependency on the CONFIG_PCIEAER_CXL kernel config
because it is now an exported function.

Call pci_aer_unmask_internal_errors() during RAS initialization in:
cxl_uport_init_ras_reporting() and cxl_dport_init_ras_reporting().

[1] PCIe Base Spec r6.2-1.0, 6.2.3.2.2 Masking Individual Errors

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/pci.c | 2 ++
 drivers/pci/pcie/aer.c | 5 +++--
 include/linux/aer.h    | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9c162120f0fe..c62329cd9a87 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -895,6 +895,7 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
 
 	cxl_assign_port_error_handlers(pdev);
 	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
+	pci_aer_unmask_internal_errors(pdev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
 
@@ -935,6 +936,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
 	}
 	cxl_assign_port_error_handlers(pdev);
 	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
+	pci_aer_unmask_internal_errors(pdev);
 	put_device(&port->dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 68e957459008..e6aaa3bd84f0 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -950,7 +950,6 @@ static bool is_internal_error(struct aer_err_info *info)
 	return info->status & PCI_ERR_UNC_INTN;
 }
 
-#ifdef CONFIG_PCIEAER_CXL
 /**
  * pci_aer_unmask_internal_errors - unmask internal errors
  * @dev: pointer to the pcie_dev data structure
@@ -961,7 +960,7 @@ static bool is_internal_error(struct aer_err_info *info)
  * Note: AER must be enabled and supported by the device which must be
  * checked in advance, e.g. with pcie_aer_is_native().
  */
-static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
+void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
 	u32 mask;
@@ -974,7 +973,9 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 	mask &= ~PCI_ERR_COR_INTERNAL;
 	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
 }
+EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
 
+#ifdef CONFIG_PCIEAER_CXL
 static bool is_cxl_mem_dev(struct pci_dev *dev)
 {
 	/*
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 4b97f38f3fcf..093293f9f12b 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -55,5 +55,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		       int severity, struct aer_capability_regs *aer_regs);
+void pci_aer_unmask_internal_errors(struct pci_dev *dev);
 #endif //_AER_H_
 
-- 
2.34.1


