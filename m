Return-Path: <linux-pci+bounces-20993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCBAA2D223
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 01:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D5A3A6AF3
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 00:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDFA10F4;
	Sat,  8 Feb 2025 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BlfngzY2"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C270F8BEC;
	Sat,  8 Feb 2025 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974607; cv=fail; b=Yd8qwWFEsFVIsb+0NptcJuM0HYwmHf9AJmLeMEFdkSwQ5VagND2/S2lmFIOYT8GxLS6SkF06lYoK9VSlrf0/yWLG9HsR1Zszto0Kj33Qk3U7f/QIGxZuJmYXq5NsyEWnbhGFVgH8SnoZ8v0CHAZ5hPCINURahxSy4q3R2XvE34w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974607; c=relaxed/simple;
	bh=9JDcgC8d/bCnUZ4kEfK0wY2IIiEY/EpgUp7DX2b/9hY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TId1759nKQy/fQvTnLkeLZt9J0J+2a8Irnjz4H9t8PQwNFTVv8sxWZSAr5kbHJnKnYlhBu11Xh6hHbb/PqHw1p4FQqMwbbG4xl7hi/5YreZXVqFIUn+v/jBfG62ipHxX0hYODFuJn0s1E7XjAy966k5ayYobM+9qLd+MIwyBxgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BlfngzY2; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBxJm3vQeekyJsyteOBH+C054RKPz6pr1j/LtxjE4QrFIZjpstG3DVZL6scED8wcdzwRBfKW9Y6r9rvWDRCEeplknYTPQUMaSD5sCF0Munw7gN65YRzwsuRyjePITLzS9i0TuGzgL6OHnTYj9p6R3T/rEJhrLGwzLVRKtaOPTKwiWNmoeVflLs1Jo9OVXV1GUw4MEFCKvwsvE4BU68wlaA/hn8+20QQJHUBe3McPmPzqjpalibyp11Y2x9U3o99P2nx4cZNo81fFZUoceBmeqo3XsUObqfUFUyIee5jACaZ/kVMuF796DRIvCKcVRviKoBM/W1lJzfqoJYdJGft2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcIayVX5NDpKC7/iFdgEgOr6CFd1VVJEE7NSu3u5fSc=;
 b=jNlmRuirSbHd1fEeyQ4NNCPrh2jOUYn16UrT0IFOSZV7FWJ9X+s1R1gO5M4yDOicVqitrW6vnkIDpYhwtBd0XJUbKXDhWwP9nUwYIG78fbDekQxmJDH12glVUk9pfHMZPe0cxF2KzC8Da3Gm+A1b/c7ZbWkvBG+kc8dLOLgjN2/LsRwQa4VdEEk8WKbR5c/qrMFhifVNVzqqaND2ONleSZSGl2ImxArQIsQVbxs7UH+9Pp2owwCV4ZdtC/1w7Lw3KnrmquLcOlnK/MD9lpudxJtIuFlJMFR/lpp2OafhPLMTOd/UIXOdIJw7cuEp5cEDWBBCIF6htLpyKZtRNgywog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcIayVX5NDpKC7/iFdgEgOr6CFd1VVJEE7NSu3u5fSc=;
 b=BlfngzY2tNx8VHq1nruiW3RWxeXZUS4tcFN3A6BZQLDp/PKX/jywq4FoGWUScmjXte4KeC8prwzTXlBnx2h4kb2qzZbd8DVwtUZ7Rd2ew0He3PI6E6UTSBu2HGGhw+2pREPyALTVv7J3nbq0dX6kJzP16iJoTugyDo4iPIGindU=
Received: from BYAPR05CA0088.namprd05.prod.outlook.com (2603:10b6:a03:e0::29)
 by IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Sat, 8 Feb
 2025 00:30:00 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::79) by BYAPR05CA0088.outlook.office365.com
 (2603:10b6:a03:e0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.13 via Frontend Transport; Sat,
 8 Feb 2025 00:29:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 00:29:59 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 18:29:57 -0600
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
Subject: [PATCH v6 01/17] PCI/AER: Introduce 'struct cxl_err_handlers' and add to 'struct pci_driver'
Date: Fri, 7 Feb 2025 18:29:25 -0600
Message-ID: <20250208002941.4135321-2-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a5cd6b6-4dc3-4807-8038-08dd47d7b871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5EYMZLVXp7cJK/JoS1DaeqGxEII0Tk7Oum1jrG0S/+cnI4Sj5H8/U9WFiGlc?=
 =?us-ascii?Q?Hoq/3usDbirIipS3JUCaOEod4euIVe4QQ37fkOnX+My3wQLXVcsfwHm8XSQN?=
 =?us-ascii?Q?Ua9MpcxEnb8K0Gxfef5QjBZ3pAORfaq9oCkohM6Kd4oXoT448n/zLTt/bN8o?=
 =?us-ascii?Q?uV3rp8XDqGdwQ5c1zYZp7YjBYx4amT7pYiRaNuS+7f/whQa30RG4kKu3MwmM?=
 =?us-ascii?Q?e9sxFpp+ap9BBiDQ+6lsAZrcmRnZGFdTRaJyagtOqSq/fOcshW7+vPv1gxt4?=
 =?us-ascii?Q?twQ08X+kg4Aw3GBYOLQhpC6zxoMuUJ0Jzg1oABure9Itk3FDOeXIzd5nSMw2?=
 =?us-ascii?Q?oOt8y9cw6ZXJIG5Ud+8hQ8R/j10clCCN17b9s0IQSjbLKAi2YMYyRpqSaYQQ?=
 =?us-ascii?Q?MAyPmSCWpy4+AsnmioJDhNNnnTUMoZCUiuZUW4VmIddfVMwMCiT6Xcu77rQ2?=
 =?us-ascii?Q?qDTx0aA5o71wZhxs/AjsB1p8CfI2CwgUdLa3vmMGJwHjGD21bDfND+Npm5NF?=
 =?us-ascii?Q?TtZET+hml9In7TO1C82s5ipcGTpEHxwPZvCe8Me8XtA1MZ4sBCGOD+FxcuQI?=
 =?us-ascii?Q?nusjfG33iAd5dEyFLwiLjshA45svZoJJggEJ7+gTr+bSjNsYCjm9tf6ghwdb?=
 =?us-ascii?Q?T1bfFHdLDmcUsF1K2RfOfB8n0T0vZ/0O+cbKba0veNLmH7H1VqQOZ8fvAal3?=
 =?us-ascii?Q?wAZ3dqqBkuIELww5mqHa1eokMeElT72zOqGKuZTvgeUoWbqAA1zkeCt1Nyf6?=
 =?us-ascii?Q?PCXKVRtRjvsh4GpJM65YyDo0j/p6l5ag2nY1HCUHEmfdCGnUmfFqa/QlIEgy?=
 =?us-ascii?Q?Aggvx4suHM+T+TyLO5dyoaiXPkhfXHDRzb9E5bJTDOjUHFRpMFetnQ0zaqYP?=
 =?us-ascii?Q?Q1l2XqBID+uSZbs6oVxKvr6bfnjHbsv5otqTkPtszMv13qwHTdC5SeDMXX1d?=
 =?us-ascii?Q?uLZ76luSlxZNjlpLo3V/XSuM6fylNsPNdkXPaBUUZP3228g0r3XuwUdTa3x+?=
 =?us-ascii?Q?CCpT/WzjPUTlsbf03ZSzRSoI7jxNWtxlLqhiWr6TXRWHxQo3fJJAZ2B6ypEP?=
 =?us-ascii?Q?wJ74nI2XqYdgWUKteJQGSX3KFTSuhb71spQzbX616rrSJrd8o3bvVlpG2HEX?=
 =?us-ascii?Q?s/4qtipGWUN93QvtL7czgpCePzZBIpqFT8AFO1ETcchICQqWbTI1QrKJjY8V?=
 =?us-ascii?Q?kavllZvWUmhitSUYg19Vy9bCs/CLMWvsVA37Wksl6sJTKppTzjFGAAJ08mkM?=
 =?us-ascii?Q?P6cH5wHjH8HPjYpF073sYgxO5WFUFZa9k3LyBw4kvIFcg00nAk09ouio88+i?=
 =?us-ascii?Q?5nsnz+/dUAemhdoP5KN0RDFRzNS6Kh1gVqnNXWu7IrvYudiPTSAfQqt7FCZu?=
 =?us-ascii?Q?ZtnwXwzcSOa4S76OxBYA7wRV7GVxRQ/Lj+lGbEeSN8B+zpicc9BI1Xif2o/i?=
 =?us-ascii?Q?RqfyscgiRH+gNmpaBkJWfEWFfXttLrQLWE2ymsPav0d1QwdAcrVtxsV6D1TK?=
 =?us-ascii?Q?VLvzFEVBiwB3xlJ+FD7UH/8rVDwyL2cYmuux?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 00:29:59.2902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5cd6b6-4dc3-4807-8038-08dd47d7b871
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520

CXL.io is implemented on top of PCIe Protocol Errors. But, CXL.io and PCIe
have different handling requirements for uncorrectable errors (UCE).

The PCIe AER service driver may attempt recovering PCIe devices with
UCE while recovery is not used for CXL.io. Recovery is not used in the
CXL.io case because of potential corruption on what can be system memory.

Create pci_driver::cxl_err_handlers structure similar to
pci_driver::error_handler. Create handlers for correctable and
uncorrectable CXL.io error handling.

The CXL error handlers will be used in future patches adding CXL PCIe
Port Protocol Error handling.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 include/linux/pci.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..1d62e785ae1f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -884,6 +884,14 @@ struct pci_error_handlers {
 	void (*cor_error_detected)(struct pci_dev *dev);
 };
 
+/* Compute Express Link (CXL) bus error event callbacks */
+struct cxl_error_handlers {
+	/* CXL bus error detected on this device */
+	pci_ers_result_t (*error_detected)(struct pci_dev *dev);
+
+	/* Allow device driver to record more details of a correctable error */
+	void (*cor_error_detected)(struct pci_dev *dev);
+};
 
 struct module;
 
@@ -929,6 +937,7 @@ struct module;
  * @sriov_get_vf_total_msix: PF driver callback to get the total number of
  *              MSI-X vectors available for distribution to the VFs.
  * @err_handler: See Documentation/PCI/pci-error-recovery.rst
+ * @cxl_err_handler: Compute Express Link specific error handlers.
  * @groups:	Sysfs attribute groups.
  * @dev_groups: Attributes attached to the device that will be
  *              created once it is bound to the driver.
@@ -954,6 +963,7 @@ struct pci_driver {
 	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
 	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
 	const struct pci_error_handlers *err_handler;
+	const struct cxl_error_handlers *cxl_err_handler;
 	const struct attribute_group **groups;
 	const struct attribute_group **dev_groups;
 	struct device_driver	driver;
-- 
2.34.1


