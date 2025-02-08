Return-Path: <linux-pci+bounces-21006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3595BA2D242
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 01:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1C7E7A691F
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 00:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8453F5C603;
	Sat,  8 Feb 2025 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FXKLKu2p"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E93F13B2A4;
	Sat,  8 Feb 2025 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974751; cv=fail; b=IQHr74/jUru2RR+JEKzqyCpqeQubSAlXwVbNyHoHPyQwQhzC5Rn5jWfyfgVUR7YCmXqULvrkwoyLyuTunR5coIBI1ULmG3lfA30cUnOOTp+IC5dCxCgDb+ejVy11r3yzCzn42bpb2XZrMXR33Al2hNq/M8rBEP1hmqQeEFZO020=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974751; c=relaxed/simple;
	bh=r2/ls2rEEAOli7c2hu7c/v6GJFSddjpxoyMIEuN3nSM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfqeZiP53erEIjS2GCuCvmNm6wjP5kvS8jXisyZsq9ftVfi/ptrVLgYQNOI2Xmsfwyc2guwxaffxDKAaVdH8WJdh//f00qAhHreQKEHGLG566p6vWg6fSImrdhEuQkCjU495I3UuzmcCcQ2aZZ7zUg8KhKvQe4ikOn3YYd88khI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FXKLKu2p; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIPjWzHdS9mGLDOChYrOTQoihm2rCpkbV4+ttz5hkiIrcKGCzsMhlVhK+8ETCy1CpaK8moa4vqGe7IW1YovdNz+3Hf3utxmw1+zcE9DFP+GheXQUAURsxFuT2304zgUozC0u/6FUtc+8qL0awQtJlqML/+r+2hHkYb95fanzjZtz+V2IKrRCys8QVvG9OOeifOAJaI2JKV2N8MXaEKsDfIH9J4wnpID13h+7lkZ7dgcdxXyEsSyzsm5E1W6aNysurA7PKygN0QT9qZwF9YrTOqYJplTxr13m41NoA7vw6eYHR47WoVuAga0OrikTJDtrFbRw+lQL2Y7J1u0LgP/xuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlnfhzW7P8Z9mDGPuSQpv+AzzgYQtJX+ANjMkNt8Xio=;
 b=bKCo4xw8S5M1x/HFcA9hKak4GEkQdtC+ej6m4pK5fuRwDT+Jg3pYyjVHyC0ILqtJJx2CaHrVXaRTLYhznpd0YGVyeuS2+A8CSodeSrNzN0Ave7kIZ5hpg1+thKc4NgK1a5248k8jXB/QEb7J3UmW9TZfZ6eZapbvpDeYpR/7TUYk+JtXZoDZqCF5VeHJsySezBygPJlnrdKHDO0+OOoPkvul+yJZUV5wW5WdWD8UKLqccSsuC1EJtw8khJ5whcFu+IpehcbhFkFykpsFSk4vx74gsBJiVjP0VT/1j/u7BbO5R+Xmzt32drqMfgeKMLKWlX5y0ofhqJCRQTDz8Tq9LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlnfhzW7P8Z9mDGPuSQpv+AzzgYQtJX+ANjMkNt8Xio=;
 b=FXKLKu2pSm1ytH8pJpco4gu0kjZ8MZJgPpO/WhKAXaBBTrozBJmjBHEFcC+ZsWbaOTQJU4bDrdb30tUaTQnzeAqk+2EbVbLjm7hN1Pp15y42M/Ij6k5fgMz5k6Xn1OnlXv2xnUWb4e3JeY0Z7Rl8waFQYG1l98FajoPOh+LZJxw=
Received: from BY5PR16CA0014.namprd16.prod.outlook.com (2603:10b6:a03:1a0::27)
 by CY5PR12MB6156.namprd12.prod.outlook.com (2603:10b6:930:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Sat, 8 Feb
 2025 00:32:25 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::ee) by BY5PR16CA0014.outlook.office365.com
 (2603:10b6:a03:1a0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.20 via Frontend Transport; Sat,
 8 Feb 2025 00:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 00:32:25 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 18:32:23 -0600
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
Subject: [PATCH v6 14/17] cxl/pci: Update CXL Port RAS logging to also display PCIe SBDF
Date: Fri, 7 Feb 2025 18:29:38 -0600
Message-ID: <20250208002941.4135321-15-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|CY5PR12MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 59077212-e34a-404a-13a8-08dd47d80f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZA5zuhARXH3AEgOXCMj7+8tX+mll2fdz5guPnfrOBNLLuE1fzdvpW0z1Tjpc?=
 =?us-ascii?Q?JHEGgRA1oKcSxPLz8zcD9coTknAn7sWGjKMWxvoIrKKhvcSB1zs871ImqH7Y?=
 =?us-ascii?Q?ZjrdZTx4jfn14z7hR6Uh6basay9fmp7H8Hy3NPvZCloaUghEkK5/PlhjcSpw?=
 =?us-ascii?Q?LGPZ7x1mnMa4MSgwYv8Qy0HBfkVfHKnNYG7u9clw7Nh6vDnJrLT7dlD/UEgv?=
 =?us-ascii?Q?dCO7T1231yNUIATZzUasgZyTCuMOfKQF++akkPfK3Euuxc78wOE8G5j3Y3rv?=
 =?us-ascii?Q?MiSpDWx49fVtX9hhCepmQz6hstjLFm7GE5+wXnGXJetXyYa1e/p3+OWg6fSA?=
 =?us-ascii?Q?MMsCGD/nFDFNBPTRCJKN+3BvCGcWSDcjHoNErL/Eg56Aeoiii5GoQSEiDqTi?=
 =?us-ascii?Q?eMhuVsgGSz6yxIJeDUqIfSaxwEpw13dpezzeiekykGEkwjpWyiJ2a2Z0N5L8?=
 =?us-ascii?Q?CqK9HilTqB9fQOf09bf5jW82OTvxaxACovMQGhgfVHIKkRnK/XPQKn11OksP?=
 =?us-ascii?Q?z/0IkVBr2Bok7HfOC+TrvaYeQaZZvb6MGDb+DiReyv5/3rtw9y4BHSk1DmFf?=
 =?us-ascii?Q?hqlwKVA7TguiEIFamd96ZfpeOoEqQDlhkh2YubGi+uv+tSEoCv13GCTDRAhE?=
 =?us-ascii?Q?PkddBLjUpzskQa8OImbftu/UMP+TOyRDLP89VHD97t9Sg8KiTA0EgLj97Ewi?=
 =?us-ascii?Q?KrMH1QliTlKiLjdXRfPJFglhHkDeWNosRzNbovTVM6rJp75QRTRTOuhAU63n?=
 =?us-ascii?Q?S7/I/VYVAL6LU72lutLXKbtlo2m3sbrrT95+aE/ncH8PM/wbSpQXNVE4tFwn?=
 =?us-ascii?Q?U2v3tqxsEqyp7iSoSkghEHOlg9/YOH+dUVrhBod83CZbfbe6CsNkRvRTm7HJ?=
 =?us-ascii?Q?3molekLyQqy7D0PFx3EQCVTs/qh8BgtoQIWMGAI/7NuLhD3ska2WHbCDpOMN?=
 =?us-ascii?Q?WEt8v7gzLUozZI6yakcjEYstoQQVFUuDpcBf1Q7+yffoAjsO7uLap1uuCj6x?=
 =?us-ascii?Q?+UP0RChYkUa/ceUPpwS7yzSju/hlDHHhzOpy0rArsKAyROyMTeh/vPJ4BG8g?=
 =?us-ascii?Q?RO1D5O8YcOIZJa/27/C8Gf8uliGC4Ix0MsZ9Gx4854sG4alxWr1njFgslXHv?=
 =?us-ascii?Q?c0K3QKRqEucJkfQyW3G6KqvoErQlcxqif4X9nFACOhIESruFGoetK0byTiob?=
 =?us-ascii?Q?5GrhnYRdlF61Mz/7CKgyqv5hHKuWLVC3NLdDlmdiUsHyyvtVb14t2/0xbbX8?=
 =?us-ascii?Q?ZlEZ8BYmAjXegREJxV0ZqqS6mi4FWd5DIKYAEmuZ1CoL505kVM/aNIclWqXh?=
 =?us-ascii?Q?RhrIsah0i4eiYlnwijMNwDXrB2625irmDusE87S+RSd3ZfH92Kj19PvUXvv/?=
 =?us-ascii?Q?upuO7uHCd05oghqvZp6wnSXhJH2e5gQhf96sMug4/fTBJHJSn9QNATw9Iwhi?=
 =?us-ascii?Q?s8aY5YC3JmSMVrJg13Czsgi5lvzXHcLWN9mtLB7dQ9MuIvMlcdx2bVaFRQdJ?=
 =?us-ascii?Q?cuzV95pkKuLSOL7x0JnU/d3a/KdIHq3FtZHP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 00:32:25.3148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59077212-e34a-404a-13a8-08dd47d80f7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6156

CXL RAS errors are currently logged using the associated CXL port's name
returned from devname(). They are typically named with 'port1', 'port2',
etc. to indicate the hierarchial location in the CXL topology. But, this
doesn't clearly indicate the CXL card or slot reporting the error.

Update the logging to also log the corresponding PCIe devname. This will
give a PCIe SBDF or ACPI object name (in case of CXL HB). This will provide
details helping users understand which physical slot and card has the
error.

Below is example output after making these changes.

Correctable error example output:
cxl_port_aer_correctable_error: device=port1 (0000:0c:00.0) parent=root0 (pci0000:0c) status='Received Error From Physical Layer'

Uncorrectable error example output:
cxl_port_aer_uncorrectable_error: device=port1 (0000:0c:00.0) parent=root0 (pci0000:0c) status: 'Memory Byte Enable Parity Error' first_error: 'Memory Byte Enable Parity Error'

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c   | 31 +++++++++++++++--------------
 drivers/cxl/core/trace.h | 42 +++++++++++++++++++++++++---------------
 2 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 61e6d33d2270..f154dcf6dfda 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -652,14 +652,14 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
-static void __cxl_handle_cor_ras(struct device *dev,
+static void __cxl_handle_cor_ras(struct device *cxl_dev, struct device *pcie_dev,
 				 void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
 
 	if (!ras_base) {
-		dev_warn_once(dev, "CXL RAS register block is not mapped");
+		dev_warn_once(cxl_dev, "CXL RAS register block is not mapped");
 		return;
 	}
 
@@ -677,7 +677,7 @@ static void __cxl_handle_cor_ras(struct device *dev,
 
 static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
 {
-	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
+	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, NULL, cxlds->regs.ras);
 }
 
 /* CXL spec rev3.0 8.2.4.16.1 */
@@ -701,7 +701,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
+static pci_ers_result_t __cxl_handle_ras(struct device *cxl_dev, struct device *pcie_dev,
+					 void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -709,7 +710,7 @@ static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_b
 	u32 fe;
 
 	if (!ras_base) {
-		dev_warn_once(dev, "CXL RAS register block is not mapped");
+		dev_warn_once(cxl_dev, "CXL RAS register block is not mapped");
 		return PCI_ERS_RESULT_NONE;
 	}
 
@@ -730,10 +731,10 @@ static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_b
 	}
 
 	header_log_copy(ras_base, hl);
-	if (is_cxl_memdev(dev))
-		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
-	else if (is_cxl_port(dev))
-		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
+	if (is_cxl_memdev(cxl_dev))
+		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(cxl_dev), status, fe, hl);
+	else if (is_cxl_port(cxl_dev))
+		trace_cxl_port_aer_uncorrectable_error(cxl_dev, pcie_dev, status, fe, hl);
 
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
@@ -742,7 +743,7 @@ static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_b
 
 static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 {
-	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
+	return __cxl_handle_ras(&cxlds->cxlmd->dev, NULL, cxlds->regs.ras);
 }
 
 #ifdef CONFIG_PCIEAER_CXL
@@ -814,7 +815,7 @@ static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev, struct device **dev)
 		struct cxl_dport *dport = NULL;
 
 		port = find_cxl_port(&pdev->dev, &dport);
-		if (!port) {
+		if (!port || !is_cxl_port(&port->dev)) {
 			pci_err(pdev, "Failed to find root/dport in CXL topology\n");
 			return NULL;
 		}
@@ -848,7 +849,7 @@ static void cxl_port_cor_error_detected(struct pci_dev *pdev)
 	struct device *dev;
 	void __iomem *ras_base = cxl_pci_port_ras(pdev, &dev);
 
-	__cxl_handle_cor_ras(dev, ras_base);
+	__cxl_handle_cor_ras(dev, &pdev->dev, ras_base);
 }
 
 static pci_ers_result_t cxl_port_error_detected(struct pci_dev *pdev)
@@ -856,7 +857,7 @@ static pci_ers_result_t cxl_port_error_detected(struct pci_dev *pdev)
 	struct device *dev;
 	void __iomem *ras_base = cxl_pci_port_ras(pdev, &dev);
 
-	return __cxl_handle_ras(dev, ras_base);
+	return __cxl_handle_ras(dev, &pdev->dev, ras_base);
 }
 
 void cxl_uport_init_ras_reporting(struct cxl_port *port)
@@ -909,13 +910,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
 {
-	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, NULL, dport->regs.ras);
 }
 
 static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
 				       struct cxl_dport *dport)
 {
-	return __cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+	return __cxl_handle_ras(&cxlds->cxlmd->dev, NULL, dport->regs.ras);
 }
 
 /*
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index b536233ac210..a74803f4aa22 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -49,18 +49,22 @@
 )
 
 TRACE_EVENT(cxl_port_aer_uncorrectable_error,
-	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
-	TP_ARGS(dev, status, fe, hl),
+	TP_PROTO(struct device *cxl_dev, struct device *pcie_dev, u32 status, u32 fe, u32 *hl),
+	TP_ARGS(cxl_dev, pcie_dev, status, fe, hl),
 	TP_STRUCT__entry(
-		__string(devname, dev_name(dev))
-		__string(parent, dev_name(dev->parent))
+		__string(cxl_name, dev_name(cxl_dev))
+		__string(cxl_parent_name, dev_name(cxl_dev->parent))
+		__string(pcie_name, dev_name(pcie_dev))
+		__string(pcie_parent_name, dev_name(pcie_dev->parent))
 		__field(u32, status)
 		__field(u32, first_error)
 		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
 	),
 	TP_fast_assign(
-		__assign_str(devname);
-		__assign_str(parent);
+		__assign_str(cxl_name);
+		__assign_str(cxl_parent_name);
+		__assign_str(pcie_name);
+		__assign_str(pcie_parent_name);
 		__entry->status = status;
 		__entry->first_error = fe;
 		/*
@@ -69,8 +73,9 @@ TRACE_EVENT(cxl_port_aer_uncorrectable_error,
 		 */
 		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
 	),
-	TP_printk("device=%s parent=%s status: '%s' first_error: '%s'",
-		__get_str(devname), __get_str(parent),
+	TP_printk("device=%s (%s) parent=%s (%s) status: '%s' first_error: '%s'",
+		__get_str(cxl_name), __get_str(pcie_name),
+		__get_str(cxl_parent_name), __get_str(pcie_parent_name),
 		show_uc_errs(__entry->status),
 		show_uc_errs(__entry->first_error)
 	)
@@ -125,20 +130,25 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 )
 
 TRACE_EVENT(cxl_port_aer_correctable_error,
-	TP_PROTO(struct device *dev, u32 status),
-	TP_ARGS(dev, status),
+	TP_PROTO(struct device *cxl_dev, struct device *pcie_dev, u32 status),
+	TP_ARGS(cxl_dev, pcie_dev, status),
 	TP_STRUCT__entry(
-		__string(devname, dev_name(dev))
-		__string(parent, dev_name(dev->parent))
+		__string(cxl_name, dev_name(cxl_dev))
+		__string(cxl_parent_name, dev_name(cxl_dev->parent))
+		__string(pcie_name, dev_name(pcie_dev))
+		__string(pcie_parent_name, dev_name(pcie_dev->parent))
 		__field(u32, status)
 	),
 	TP_fast_assign(
-		__assign_str(devname);
-		__assign_str(parent);
+		__assign_str(cxl_name);
+		__assign_str(cxl_parent_name);
+		__assign_str(pcie_name);
+		__assign_str(pcie_parent_name);
 		__entry->status = status;
 	),
-	TP_printk("device=%s parent=%s status='%s'",
-		__get_str(devname), __get_str(parent),
+	TP_printk("device=%s (%s) parent=%s (%s) status='%s'",
+		__get_str(cxl_name), __get_str(pcie_name),
+		__get_str(cxl_parent_name), __get_str(pcie_parent_name),
 		show_ce_errs(__entry->status)
 	)
 );
-- 
2.34.1


