Return-Path: <linux-pci+bounces-21008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61190A2D246
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 01:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479E03ADAC2
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 00:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1C613B293;
	Sat,  8 Feb 2025 00:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gkKaTKW+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37D6154445;
	Sat,  8 Feb 2025 00:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974776; cv=fail; b=ronF3WCfrjVPxSqVJ9cimgpqo1aCygtp+a1g23hVHnuMFLzWTkYgYlTxTb9dqDSjHU+qQYp+ntIlGYHVeX6PyYUVMNAfQQuIpdqbk30eQ8rLxXEJTnTyFCXeiBmGBSCrsS7LLltVbLuGZ24jA7OhU7YLTaRsq58d3nrP2VP7nhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974776; c=relaxed/simple;
	bh=Z6KSPXK6nyKDrCjnMYm7rmck2P9HjusQ61uFTpL6ojY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqqfF8C1ynkQitnIqRd9VAFafLAdw7KNU8eot9LHszhwnDgAgyLzNaXcphhVua8r9mrRzuC7lp770VEP1KSSHQm+/IQhp8Y6k+n1+wUTBkNnXe+wgfeaM08NyjRS4CUZcDTEEUZn1rRm4tq+CePeC71XgmBXyxbPc7FiByNWv9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gkKaTKW+; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRDmAM4Dof6ue7RN77561D30pPJRJR3z/kHaRlj+1KxixjIU4cuOonhFaLqt2o0SP7wQc14A/DGLAYHSA5vWEN1oZs75jw9UEh/Uav4vblfuZSbtCoW97mUn6FHN3sCDHRb5RjXZ+nYQrcXZLYS4wc6V4yknIlQDz+UNuucUDozsNd/qJ4zftoJm2FGywMBkvNc+zD8IoEY9ByK1GNMJz+k1PkOxLvKPABEhZQn3uVr4NmeFbs2yeur4hPA1KPgHj5fwkVmlViQ5xWuMv8mJ4HNEISeT3RJfPrpTqPC3xwvWqodaauNOMQmvmYNn8v/IWIQQZCaVBIZAPrUOmIz66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaatUn59KYzw7QCeaqbEB5HCp4S0QMFgyzLYaZvRX5c=;
 b=D/RQsyA/VazEboy+kXVf2rjcEimmISzZrZzgxIl102YBYCF4oYWLzxl3TrTs47nUvrpQ8Gli5YqcunT9Egr74bQLgj/cSbgdVQaFPCBRnTwh8p/TmEentdJL04goDp0tyH+zqj3yqqL47uXdcBCmd0y6TGBS0FIjo3PADL3atLBr2LB+774xpNxon4l6sSUxREQ5p66fwoQ3LgGq/SbN5PXnMUXMayIG9+NyXNOjGUwPGZ/WMmWNPdK/FwPrE6mXtJich8mMbUP5I0Agd4l0aR0tbQR74RIDrgjP0XJtQXRU4zajbykIzdIwGbqytyd9FQvxAcqhDYKd87sQiCJy4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaatUn59KYzw7QCeaqbEB5HCp4S0QMFgyzLYaZvRX5c=;
 b=gkKaTKW+YAquoRU8yW3jZjsTY1ECLQcIy9wGvfsFuzd6Wyvox5cRNUI/i3LJe2ocCIJAL2nSoA/C5onxaePFsfyc7sFZU0k5/hfZ9jiI0sCXrx1IxR3L5Y9klQLUajPNlLSK5D1mnhGPSn4KuxBwOZBQ/oz/VrYFDocSgTqtzQ8=
Received: from SJ0PR13CA0129.namprd13.prod.outlook.com (2603:10b6:a03:2c6::14)
 by PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Sat, 8 Feb
 2025 00:32:47 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::8b) by SJ0PR13CA0129.outlook.office365.com
 (2603:10b6:a03:2c6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.8 via Frontend Transport; Sat, 8
 Feb 2025 00:32:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 00:32:47 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 18:32:45 -0600
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
Subject: [PATCH v6 16/17] PCI/AER: Enable internal errors for CXL Upstream and Downstream Switch Ports
Date: Fri, 7 Feb 2025 18:29:40 -0600
Message-ID: <20250208002941.4135321-17-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250208002941.4135321-1-terry.bowman@amd.com>
References: <20250208002941.4135321-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|PH8PR12MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6ab290-1ce5-492e-4b24-08dd47d81c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?el/Tr6T9fpd5BoFJSh7v60xJKG6KnYg43v5IL+IDHMOoPh1s4YYcLqzffnhe?=
 =?us-ascii?Q?702bquh6U/v+rJQbJebWqLEbGASK1fL8OeKRqDmLlVGho+QbgBkSHxnTN9yP?=
 =?us-ascii?Q?zA2CfFO+z6kJ61N4MFWOX6FOkSRpqG519yi0ZYC4+t1WIH0GnYiIBDCGwuCT?=
 =?us-ascii?Q?aEsg9g9U4apQYU3wwDg0tlaJFsH432iQsS4k9fPuIXOvRO4l/3em+KnxBZJf?=
 =?us-ascii?Q?HG9O8v5iZsiyb4B4mgwq7C7ogXYhVUtcCZRjpVNYzotTKas94y48gIsV4I36?=
 =?us-ascii?Q?DuO8Pn6J42rnPmyt35I/EyL8mlkRdlH2pqSeud4cnFL9RNFwT/LeMg8b9FrS?=
 =?us-ascii?Q?n6CaQofOKly3Yv2Cm1flY+9MO/XhRTvAGMraUsw2gD75XyV68C65SwgmFmR+?=
 =?us-ascii?Q?rSTRA8cbJU++MvGYXYJ+xdwlIW2dyH1fVYMYk/JV5Xnvhdok8GkeH9M3p1y/?=
 =?us-ascii?Q?+tdUAn/Mjfox/RtwEGAygQ7a4zpclIzzQ3ExpdvetqiwDDTYjBgmtJEN14qK?=
 =?us-ascii?Q?c3b5NccOur6bI/tosJibo9fERqg0FFrmJh7VtdQBWMGvlL7+KUy3fVJRQOJH?=
 =?us-ascii?Q?NDzVREYqIKp7EhR6TAPP6BR7uutN/0wcEqpROuCp/QH/tRrXTVL8DET949SW?=
 =?us-ascii?Q?K7cft052xHRiJ9ZrSXpMMgRGYKMd7UJ1AXK0OrZEEb6UwOBAVe0jK/0Kpc+J?=
 =?us-ascii?Q?HX0hG5ruzpSXMGMNhH4PKCQMKQrss3B76Vd+sFFDN3DRyCqbojyNzUIR3phJ?=
 =?us-ascii?Q?3nmgOeyw7+PmH7txluPfcl/SkPz5svaZoGFEIXb+kLgrUpjySiL+pOYpCs9z?=
 =?us-ascii?Q?ZUR1nrkuspk2ExAvcBZsp8LbNKAL3JLIVsqt7cA0JHD0SDXeet8jaXmTdKMn?=
 =?us-ascii?Q?bDsDUkdW9FOxtFWeXxuz3P+mh9ZjVxIAB3+akGud1ypcmhH6o7wKkBGYKdnB?=
 =?us-ascii?Q?eyS2616h3mCA2vjK4i8F/ppIfE7tAyK3ZXslabuqHSBUXGNd2hkdu8P1Mpv8?=
 =?us-ascii?Q?rwO6XqnmsWk48Q0iJfOqBPqB9v/tWKQFJ4cwzLtus8FZQvYcy9f+wJiR/YMn?=
 =?us-ascii?Q?lzUH83HVaydukMWW49t3INNqQbnf2iNR8ZSouMjl79buLJOHJUTtImwMTp+D?=
 =?us-ascii?Q?Z80WEUJUIEOBQvOkuztsplH2cQH3PyD1hvPYrYjxokaCjxnSez5HUkykFvoN?=
 =?us-ascii?Q?iZ2QydK9918yfyXAb2I5Yw5t8SvbL2OwceUWai/KxxIlZHhhgOl6Lt//Ug7b?=
 =?us-ascii?Q?rMeh0YnxJhNwtvwiGw8cpGH721w12J6eW5RGHCMeITONZ16a/TVzwU8lKO6v?=
 =?us-ascii?Q?E/b0aK+xJBOgi0t7DZTT1uXsrB/LnZkjd9zccqnsNDeiGvEOqBPC5FfxmHg3?=
 =?us-ascii?Q?Yo2MFu9W4juT19obunJzOCvbULAublgBqnR6jeiwYIvsK38/MDTrk5vYw7X1?=
 =?us-ascii?Q?h0WWZTNyz1NYPlftV229PCpnl7kgGz6HHgxyYOngeHkkJ4izSmPunMPu7bUx?=
 =?us-ascii?Q?ubytxkWsJslkJVs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 00:32:47.2052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6ab290-1ce5-492e-4b24-08dd47d81c87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7110

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
 drivers/pci/pcie/aer.c | 3 ++-
 include/linux/aer.h    | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 03ae21a944e0..36e686a31045 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -912,6 +912,7 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
 
 	cxl_assign_port_error_handlers(pdev);
 	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
+	pci_aer_unmask_internal_errors(pdev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
 
@@ -959,6 +960,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
 	cxl_assign_port_error_handlers(pdev);
 	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
 	put_device(&port->dev);
+	pci_aer_unmask_internal_errors(pdev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ee38db08d005..8e3a60411610 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -948,7 +948,7 @@ static bool find_source_device(struct pci_dev *parent,
  * Note: AER must be enabled and supported by the device which must be
  * checked in advance, e.g. with pcie_aer_is_native().
  */
-static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
+void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
 	u32 mask;
@@ -961,6 +961,7 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 	mask &= ~PCI_ERR_COR_INTERNAL;
 	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
 }
+EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
 
 static bool is_cxl_mem_dev(struct pci_dev *dev)
 {
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 947b63091902..a54545796edc 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -61,5 +61,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		       int severity, struct aer_capability_regs *aer_regs);
+void pci_aer_unmask_internal_errors(struct pci_dev *dev);
 #endif //_AER_H_
 
-- 
2.34.1


