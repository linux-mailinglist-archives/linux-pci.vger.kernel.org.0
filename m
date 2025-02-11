Return-Path: <linux-pci+bounces-21207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A67A3156B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE43168AEC
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C1D26E646;
	Tue, 11 Feb 2025 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lGy7MwH5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69A726E63C;
	Tue, 11 Feb 2025 19:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302075; cv=fail; b=fJ/dKnqwnlq2jQdJK7CmIU+NnSb9oMjiZndZicFF+9KrxGOt2N7WV+V0O+KmenVVes1UTrf5vH9TM20HJ4lP9+i8dWtt5feDeXMXksSUb30nIf7LU5A7Tl14rxJh7O8Z5mRO7WZoTNrDj/ZPri4RhxsPf13xgpJIrAf2A19jJwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302075; c=relaxed/simple;
	bh=Z6KSPXK6nyKDrCjnMYm7rmck2P9HjusQ61uFTpL6ojY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pKnfuMUt2tpfzQm2iqwVTKuJGTyDBkyETKPgMF7nNhSqZXQ/RGdG57YEhbj+jN4qcHyesA1KWUsaSdYJfK5/2WxWgwwumVw0oRFQuQMXvkr4Yb3O1aurFQcDKCMhQ+M6wqi+yPBqD//Yi/ecxSkrvwIGrryOqShRoBskAzmddhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lGy7MwH5; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MP1KDnMfhx2ISAJxoDrNhZy5fdZBQITu8XnqANI3V/JVyhPcGEOobu36jF6NCaZwkuMICDTE5CofOMuxRkM5d6hZuyoeW8cXdhgZoZDfvWNcWxDvA46RWCfOiakZMMkjWkuuzWucX9ei9GvB8k9vOOEaiVCIK+aC9C8uqbCAkJvpk1UEvdoiessPmjbhNJI2v5zfr7N/Ct/8P9Pz0AEBftNsDCJhg4zJQqSB5Rd5pxXBvJL6e49Lwvw8Z7Ml//i0n1fzbhHuW6YLvlxYZJHddHnavnIWj9gYb6WCDg48HYXEKKZI1h66Vn/cT07eCwdcHtJYKDKGk2cAxnQowyJ4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaatUn59KYzw7QCeaqbEB5HCp4S0QMFgyzLYaZvRX5c=;
 b=l8lrGMj888bS5M9UD9udi5zSVsOMnepolasXoLJlKW2kmFNpR+1lqdBefN3GbBHwMEOGSrsvuGlBJetTCGwj2T3rn5mwgNIRr1Ea1AnGeJ1P6i62F+OmI9y4Cvx2Xq+918kaoHMYTxflP8gLsxtMfjebndZW4t0/TRwwGvDr5I2yy0710QZ3sJZ+veL2kVOwhUwkQlN2F0B25N7fnVSI2qjMNOqmXJpcY39068xs6b7a9e2aGppu/TMkfGW8MoJ1kiB4R3BreGuHKANfIjSaiQzTDxH7v2GFyISeb8XG/I1hHJTBu5LSUVQ4VHLVPFVV1syAyCLU5txGaBnUinKvDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaatUn59KYzw7QCeaqbEB5HCp4S0QMFgyzLYaZvRX5c=;
 b=lGy7MwH5NOPV8tS8CVqSYC5WdoOcJqMFRY1wqcaMiXOR8Ife8i78w7CtKjMQYDd4M35sTLJQXL/Q92sdBireJjeA4UNVrvyGypFX4pjemcoycrG2KGm0BLDt1/atVqZALK+pSicQDVzYVk9DXs+xCl+iFtg9q+/CKHnFIrhO7F0=
Received: from BY5PR03CA0029.namprd03.prod.outlook.com (2603:10b6:a03:1e0::39)
 by SJ2PR12MB8036.namprd12.prod.outlook.com (2603:10b6:a03:4c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 19:27:49 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::3e) by BY5PR03CA0029.outlook.office365.com
 (2603:10b6:a03:1e0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.16 via Frontend Transport; Tue,
 11 Feb 2025 19:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 19:27:49 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 13:27:48 -0600
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
Subject: [PATCH v7 16/17] PCI/AER: Enable internal errors for CXL Upstream and Downstream Switch Ports
Date: Tue, 11 Feb 2025 13:24:43 -0600
Message-ID: <20250211192444.2292833-17-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211192444.2292833-1-terry.bowman@amd.com>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SJ2PR12MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e1f030b-d1d7-4e80-8ae5-08dd4ad22bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QpaenVqLtOvVux2n+Fu4PW4kJNfxblmaJxkFshuS/EhP1djwU9Km5wAX0W3F?=
 =?us-ascii?Q?ZESf8Vzij/VyvDv4QOSe3opyi4DcxQFREFCsrGkbF7PfOenusRwX0dMr3k7K?=
 =?us-ascii?Q?ejOiat5KLrCRDYhPJrMtvFI1stgb6KE8SwwyNjrMvuzz1lE9PRCKBlkOC784?=
 =?us-ascii?Q?gSC2JVkNdYT5jDqKHK4riaRj2o386h5dXdEqDZOI3Yr66EHyb5sCujZEbr24?=
 =?us-ascii?Q?UDJkZrgGOgHmCjzywVumO/V5CndD2yW136PgGEj3GhpIDxBmdu5AQUw7LcMt?=
 =?us-ascii?Q?+qGBuhJQa8hh6p3T5Q3GuyTNj8/R8QIbE5pan+zKhxjWNUHTqolaqW8kYGlV?=
 =?us-ascii?Q?nmqGv+NXSJKUymohfur/CaE+kZ8wGIQ9Fnf0r0ydO6ski3F6oinB8kVSOPDP?=
 =?us-ascii?Q?K6i0tv8V0qEekhuuoPM3IsQHQwVszyPA5cxyquTPbCaoDYZed3UZ26gFJw+c?=
 =?us-ascii?Q?lHc1/vJlTRtsllaQt0GvJjnOgaBbDr/Y8zDLJrwV1KpGDyUrylUnK8GCP4lc?=
 =?us-ascii?Q?Y9ylJrjGFqLFWUf/Q13fQiyqBLYAWdjevANSCWZqsBQfyCFluHLF6YCr6Qy3?=
 =?us-ascii?Q?yXgJp+j5LudSJ35GYTqtNBrYgKOwHnJO8+eBbb57mGs6N8ddal/uPiCDBWIH?=
 =?us-ascii?Q?36vS+gUjCLf9KWbURN/LaXPTjuECNHMxssk1qtkZ14/6uY78IIBlsBC5/En3?=
 =?us-ascii?Q?MANYmSZzXnR9+cPe//mmHxvSqCYG8nSUDt51sbBXFzClilaPSUDt8oTAJYRi?=
 =?us-ascii?Q?4Fg+Fli765Xzd+zzOLB5EcslxaBoFDcIqbSKwNUUUH29aeerZ3EEdUr7jgwB?=
 =?us-ascii?Q?c0+qOPCnPRKR1aVXbM6qkp0Km1OFzV3/OzK3OdNxzRVPfLOKI6MybDAk9FMa?=
 =?us-ascii?Q?ANBSKPfQN1AL1nLu3hRnFaZE/c0kqR6RpPmsHzZ6oKbpHmY42ZRoW30FwS+E?=
 =?us-ascii?Q?r+83SL8B4gKxkrJBtPBgP/+RWXl5gDP1iK1hB1r8ap8W6KiVHpRxxuzsiDle?=
 =?us-ascii?Q?Tnbk3WhKAtWZV5geFQil+OYhHp+GZM6RLpLUC9oDydxKjB6ED8j8c4AYZ8uH?=
 =?us-ascii?Q?wkW2tO1TWE9u7Mg/WgyaMRxEzMONrOjQEQy3qfR1GxmdyTV+SwnrqmPM95Rm?=
 =?us-ascii?Q?/4+pfFhQZGjetfT29dvlwgsueWHriNefhEPaHA08NZP8oNz3C3wGx1pX/uWR?=
 =?us-ascii?Q?aZYz3BzLFl52yuld5ytz6HAjka5UaxsUhkRFj2MDg+rgbqUpSc2ejSuwKF9x?=
 =?us-ascii?Q?MI8tK+b77gK7lM3JVYzanX8OeWpei2khZ22FMuBa/Vwc35We/YKZooZnxIly?=
 =?us-ascii?Q?B6EK6C5rDzlNvYbUthakQvVFxZagJt6HuuJJIh3NMwmsAHIihJNaIlCu0C7g?=
 =?us-ascii?Q?KaQj+6zXB7j5xReuoUirQufbYE6rS7/4xPpo1Se6/8mmMsGDC+VVal+UhZCZ?=
 =?us-ascii?Q?T/ncjO7/rhLBm/vmQ2X8jdY7ID+C/mGig6VOsvppisA4ycAlUgc0LjzhvEfr?=
 =?us-ascii?Q?xT3bIsAgOWxCeA8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:27:49.4442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1f030b-d1d7-4e80-8ae5-08dd4ad22bdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8036

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


