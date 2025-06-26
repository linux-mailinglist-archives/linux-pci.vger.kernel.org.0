Return-Path: <linux-pci+bounces-30863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9C9AEA9EB
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFB74E3A3A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B20C233136;
	Thu, 26 Jun 2025 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iuJLAlsS"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E29D230BC9;
	Thu, 26 Jun 2025 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977953; cv=fail; b=a1dNurGFC4JLjPcg9L+ZUFrAbJJTmEwPP0n7HBWlgQR9Cm8DxExgXS9qrLS4bi6COOQ0KnUg0olQrtDoCCbH/Dbu+khsyD7fj0r6RfLHkl2ewkkBGX/PtN3qEVD7DhVk2DN0W2Rr62NQGgQXgggp9GMYb0NTeqrKTBhjR9k9cS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977953; c=relaxed/simple;
	bh=pVQdPL75nteX9cKYXBllv5LlokOz1Az2ik8jeHNApRk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghL5ANrxT11G0l69nvOfHWx0Oth/OA8CvgfEXaXoKJrwLUwUROkFPEMeq5SPSrdhe3LrzVTzzgplO+QP4i+jpCQ1dgP9wO2GdZDF9bcmmhLEOCrfiOSWdY+1XAyzCccYbvBoX2DTCPfr4d7T820IpBsDOD5MEzPDR/owWbPb10w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iuJLAlsS; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfSUI6XxTUgc4rbY/lG105QkXm4AhziuGXRExyHUyq5+Nzn+IIiTbYR+/lQG2UhavkvgS3H4mRqzaefhkeLcgjg1qyUdezssrwl2lj5qk/jmr0I32FEJwNqhurxjjTJhijHaQVVUPQTypR5KBemqOtsZwQZ/NsDUewVnZ+WXmKLVcKJlZkKzHXG3q+aN0bY+lSplU75L7JrSr+2wrvVc5rT2NndyY81V/vhJ/Z42fN7lzaFYb3ft8eUd1oVFa4H1HcG2E3fQ6UfAnPf/IxvM3V35ICDOiwusRyT7Cgnha9b5h4M2nfz266rCxPFa6BXbNWVGuvWSpBxB+ED4kF5mGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDtVtdunecIymHBN2p9HImWkgRE2Eokj//IlDa7A3Jg=;
 b=xz9zAR1L6Td+eeZVrliQ8V19LYPkIUv/sTSPvc/o7BFQLxBQiS1VNI1ToQ7YGJr0FfpFQ2E/R/uk0i14xa7Ink0g4Mt6epMbEW1YkETsZtKINSaz1dcwZLmoxeBO0xez4V6d/qMFla9tvsX79oY/Id2R3hyOmMzJLizAyyFnnIiWMGbc0ZyZjJ8pKf9P+I+DCvO59YxH8bac4MsNSGA70k9FgMsoy/kPAMgQPePoD7naGPL1ogNaiU+ShtACBp2G6V0YKSqhDoMeWyfgk2xXo+6gHwnloPQSayobtOOmIbVaGMlNCgj3scWURQvJdOk0Y0r139P2Vx5MC+4TaKVK+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDtVtdunecIymHBN2p9HImWkgRE2Eokj//IlDa7A3Jg=;
 b=iuJLAlsSuECRpLuBbbhEExtfnyF3QBcV70kqfVXdww54oz/11qO7PeQUrv7jkGW6v4/ZTOsAKML14KZUZbj2SUnXgAx+Tp9xlW3mhC1yjI/F5QW/NYc2uikNhb7RD+/xDQyA5ki6OF6//1a+7E0n3GxvKynI5271ucoWJB0fhyc=
Received: from CH2PR02CA0007.namprd02.prod.outlook.com (2603:10b6:610:4e::17)
 by SA1PR12MB8986.namprd12.prod.outlook.com (2603:10b6:806:375::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.32; Thu, 26 Jun
 2025 22:45:46 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::4f) by CH2PR02CA0007.outlook.office365.com
 (2603:10b6:610:4e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 22:45:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 22:45:45 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 17:45:44 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v10 15/17] CXL/PCI: Introduce CXL Port protocol error handlers
Date: Thu, 26 Jun 2025 17:42:50 -0500
Message-ID: <20250626224252.1415009-16-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626224252.1415009-1-terry.bowman@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|SA1PR12MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a3eff1f-3a93-4e6f-5296-08ddb5033090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bBWJ6N5dFizhDlBW7ripfKm8FrcSpKCR+eJXKGVZykOHmOz0ulIn7H5AiufX?=
 =?us-ascii?Q?vksD3A0Ivh8a738nRZ1MYf46bk9FQedSOGFGGs+6vUu8Hne8gtD4Pp4zq9pE?=
 =?us-ascii?Q?Sw7KIrOJ4dHQGxXVEwiufoZCjr26UF69W6Uzi6zcc5Hdv9/pljxfWtsAQgvh?=
 =?us-ascii?Q?mM+gtNtLqIQzzMViYWLUixC/5rb4cgsYW+Y4shcjFa6RHCd/c5pcDlZJEff1?=
 =?us-ascii?Q?ZpydV5IBVjXLunAPKPVSDrvqresInpLZkH6ok4vc6ftJXtD/a6il2DEC8QRw?=
 =?us-ascii?Q?OB3ZGq7rL73Vn5Sp01AwZSpJ9aQmym8enm2g/oPTkoiqIVtwXvozqaOzG4J+?=
 =?us-ascii?Q?uMZ3FLYLl/ofpR553cdsk4fTmymGM1cJwhYjZOFwrtLfgZlUFR12PWjWk2uk?=
 =?us-ascii?Q?k9Qi1sb43xDcEo1pDEtPgbRJjftcjQBtMQURVXRyOhgtyHv2CFEmDzw+753n?=
 =?us-ascii?Q?7HejqwcqMQX7tgqAPBpHq04maPPWlbDqfMAP4+ZHtCeYyu+sEqS5RuzJzT9y?=
 =?us-ascii?Q?KB71x7F3e6MJZPkgPQ/yuznbcqTEVTUpd61/mUMqAt2P6dS05bZGKX0zgAxr?=
 =?us-ascii?Q?R4Y+fPRN+6YjkrkBY3EmwaSmOdGRsZBI8zNEUpW+wfSt9bBiZsYH3dbf+/wg?=
 =?us-ascii?Q?nTpvw7mrSLvYkvyeO6AtHvuTlCuZuTFdCax77qfS/aTGv/ab/HDPp93hp+jv?=
 =?us-ascii?Q?D0t3MHHbOlSoB+ZMS/Jh2Bqyo59n2QucFe/ebTeh0K2lyxItmnwZpfRKcnxX?=
 =?us-ascii?Q?uLwznacLayvfWyZVNOjH974vbRf7tPFk8gHedw4um+IY5cK0iE/owrE/HCGd?=
 =?us-ascii?Q?gXAm8x4o7M6gXxSwFd9uoaSmUFohYPMtoZZgA920QdCdY2HREdVL3vuwEoxf?=
 =?us-ascii?Q?J5qDKCrl1S2w2lmJ61b9FEOcDVhabYrJ2D6FzAQO8xhwNXV6CVCut9GSl6pR?=
 =?us-ascii?Q?FBh/YcAJhdv66F8vxttWM9bwN80f1YFfDt6196vbdek570SdSFvhgzTRBHM3?=
 =?us-ascii?Q?Syf8p8wE0bV5HnC2R1Am8Gg7TXLi2AbD6iy5N77L8sM8iypfkysTbwlxZjEX?=
 =?us-ascii?Q?hah7UKlLmKiRQJgwqALNulawG+Sv5RbfCttfhSo0hwnWIyBI/ogFn5NULz8N?=
 =?us-ascii?Q?nqihGxACj6jWjuNfh+Ta/PIdjU8yacPzteYO5hdUf+0MlMH6GFjGe35ze9z7?=
 =?us-ascii?Q?aSKwkyxJuSYtL+05OpH0NywhdMpcNG8QZVCsaomoEZSRrQssTMmJU2D8QriH?=
 =?us-ascii?Q?EOpy18fLfKFnL5D7pgP6Nmpx1N+H70azextN1/teTBz9y7WC5xXisAJXOptG?=
 =?us-ascii?Q?3dZVg5QyvLg/KCV+GgDNPDjzHQEvOnwlhsJ0kpZBRBHOf4RUxnqt8sa4tzUP?=
 =?us-ascii?Q?71Py+Y5xppRShI2gYPYeBi5gjFAjzOhkSrqO1Kv4hfgefBrPyev2Dg3tyW7i?=
 =?us-ascii?Q?Ujkfc/IDaBEO4F3ALoB5uFz4/NnjvL2P3VYNeAtSbrOQ6nHYKg7ENK+HCk7b?=
 =?us-ascii?Q?+zFcQdrV6PrdIIbJfAP82Q6m8M+fIeLsCE9q3FZZVWMSho4BUv9GgaNU3A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 22:45:45.9510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3eff1f-3a93-4e6f-5296-08ddb5033090
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8986

Introduce CXL error handlers for CXL Port devices.

Add functions cxl_port_cor_error_detected() and cxl_port_error_detected().
These will serve as the handlers for all CXL Port devices. Introduce
cxl_get_ras_base() to provide the RAS base address needed by the handlers.

Update cxl_handle_proto_error() to call the CXL Port or CXL Endpoint
handler depending on which CXL device reports the error.

Implement cxl_get_ras_base() to return the cached RAS register address of a
CXL Root Port, CXL Downstream Port, or CXL Upstream Port.

Introduce get_pci_cxl_host_dev() to return the host responsible for
releasing the RAS mapped resources. CXL endpoints do not use a host to
manage its resources, allow for NULL in the case of an EP. Use reference
count increment on the host to prevent resource release. Make the caller
responsible for the reference decrement.

Update the AER driver's is_cxl_error() to remove the filter PCI type check
because CXL Port devices are now supported.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/cxl/core/core.h       |  2 +
 drivers/cxl/core/native_ras.c | 74 ++++++++++++++++++++++++++++++++---
 drivers/cxl/core/pci.c        | 60 ++++++++++++++++++++++++++++
 drivers/cxl/core/port.c       |  4 +-
 drivers/cxl/cxl.h             |  5 +++
 drivers/pci/pcie/cxl_aer.c    | 17 ++++----
 6 files changed, 145 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 4c08bb92e2f9..f5a2571fc208 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -122,6 +122,8 @@ void cxl_ras_exit(void);
 int cxl_gpf_port_setup(struct cxl_dport *dport);
 int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
 					    int nid, resource_size_t *size);
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport);
 
 #ifdef CONFIG_PCIEAER_CXL
 void cxl_native_ras_init(void);
diff --git a/drivers/cxl/core/native_ras.c b/drivers/cxl/core/native_ras.c
index 89b65a35f2c0..c7f9a237a1a2 100644
--- a/drivers/cxl/core/native_ras.c
+++ b/drivers/cxl/core/native_ras.c
@@ -9,18 +9,74 @@
 #include <cxlpci.h>
 #include <core/core.h>
 
+int match_uport(struct device *dev, const void *data)
+{
+	const struct device *uport_dev = data;
+	struct cxl_port *port;
+
+	if (!is_cxl_port(dev))
+		return 0;
+
+	port = to_cxl_port(dev);
+
+	return port->uport_dev == uport_dev;
+}
+EXPORT_SYMBOL_NS_GPL(match_uport, "CXL");
+
+/*
+ * Return 'struct device *' responsible for freeing pdev's CXL resources.
+ * Caller is responsible for reference count decrementing the return
+ * 'struct device *'.
+ *
+ * pdev: CXL PCI device to find the host device.
+ */
+static struct device *get_pci_cxl_host_dev(struct pci_dev *pdev)
+{
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_DOWNSTREAM:
+	{
+		struct cxl_dport *dport = NULL;
+		struct cxl_port *port = find_cxl_port(&pdev->dev, &dport);
+
+		if (!port)
+			return NULL;
+
+		return &port->dev;
+	}
+	case PCI_EXP_TYPE_UPSTREAM:
+	{
+		struct device *port_dev = bus_find_device(&cxl_bus_type, NULL,
+							  &pdev->dev, match_uport);
+
+		if (!port_dev || !is_cxl_port(port_dev))
+			return NULL;
+
+		return port_dev;
+	}
+	/* Endpoint resources are managed by endpoint itself */
+	case PCI_EXP_TYPE_ENDPOINT:
+	case PCI_EXP_TYPE_RC_END:
+		return NULL;
+	}
+
+	pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
+	return NULL;
+}
+
 static int cxl_report_error_detected(struct pci_dev *pdev, void *data)
 {
+	struct device *host_dev __free(put_device) = get_pci_cxl_host_dev(pdev);
 	pci_ers_result_t vote, *result = data;
 	struct device *dev = &pdev->dev;
 
-	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
-	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END))
-		return 0;
-
 	guard(device)(dev);
 
-	vote = cxl_error_detected(dev);
+	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
+	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END))
+		vote = cxl_error_detected(dev);
+	else
+		vote = cxl_port_error_detected(dev);
 	*result = merge_result(*result, vote);
 
 	return 0;
@@ -112,6 +168,7 @@ static void cxl_handle_proto_error(struct cxl_proto_error_info *err_info)
 		       PCI_FUNC(err_info->devfn));
 		return;
 	}
+	struct device *host_dev __free(put_device) = get_pci_cxl_host_dev(pdev);
 
 	/*
 	 * Internal errors of an RCEC indicate an AER error in an
@@ -122,6 +179,7 @@ static void cxl_handle_proto_error(struct cxl_proto_error_info *err_info)
 		return pcie_walk_rcec(pdev, cxl_rch_handle_error_iter, err_info);
 
 	if (err_info->severity == AER_CORRECTABLE) {
+		struct device *dev = &pdev->dev;
 		int aer = pdev->aer_cap;
 
 		if (aer)
@@ -129,7 +187,11 @@ static void cxl_handle_proto_error(struct cxl_proto_error_info *err_info)
 						       aer + PCI_ERR_COR_STATUS,
 						       0, PCI_ERR_COR_INTERNAL);
 
-		cxl_cor_error_detected(&pdev->dev);
+		if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
+		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END))
+			cxl_cor_error_detected(dev);
+		else
+			cxl_port_cor_error_detected(dev);
 
 		pcie_clear_device_status(pdev);
 	} else {
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 7209ffb5c2fe..7a83408ad0bb 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -743,6 +743,66 @@ static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial,
 
 #ifdef CONFIG_PCIEAER_CXL
 
+static void __iomem *cxl_get_ras_base(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_DOWNSTREAM:
+	{
+		struct cxl_dport *dport = NULL;
+		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
+
+		if (!dport || !dport->dport_dev) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+
+		if (!dport)
+			return NULL;
+
+		return dport->regs.ras;
+	}
+	case PCI_EXP_TYPE_UPSTREAM:
+	{
+		struct cxl_port *port;
+		struct device *dev __free(put_device) = bus_find_device(&cxl_bus_type, NULL,
+									&pdev->dev, match_uport);
+
+		if (!dev || !is_cxl_port(dev)) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+
+		port = to_cxl_port(dev);
+		if (!port)
+			return NULL;
+
+		return port->uport_regs.ras;
+	}
+	}
+
+	pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
+	return NULL;
+}
+
+void cxl_port_cor_error_detected(struct device *dev)
+{
+	void __iomem *ras_base = cxl_get_ras_base(dev);
+
+	cxl_handle_cor_ras(dev, 0, ras_base);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_cor_error_detected, "CXL");
+
+pci_ers_result_t cxl_port_error_detected(struct device *dev)
+{
+	void __iomem *ras_base = cxl_get_ras_base(dev);
+
+	return cxl_handle_ras(dev, 0, ras_base);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_error_detected, "CXL");
+
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
 {
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8e8f21197c86..c76a1289e24e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1341,8 +1341,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
 	return NULL;
 }
 
-static struct cxl_port *find_cxl_port(struct device *dport_dev,
-				      struct cxl_dport **dport)
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a2eedc8a82e8..19eb33a7de6a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -801,6 +801,9 @@ int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
 void cxl_cor_error_detected(struct device *dev);
 pci_ers_result_t cxl_error_detected(struct device *dev);
 
+void cxl_port_cor_error_detected(struct device *dev);
+pci_ers_result_t cxl_port_error_detected(struct device *dev);
+
 /**
  * struct cxl_endpoint_dvsec_info - Cached DVSEC info
  * @mem_enabled: cached value of mem_enabled in the DVSEC at init time
@@ -915,6 +918,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+int match_uport(struct device *dev, const void *data);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/pci/pcie/cxl_aer.c b/drivers/pci/pcie/cxl_aer.c
index b238791b7101..38dc82df0baf 100644
--- a/drivers/pci/pcie/cxl_aer.c
+++ b/drivers/pci/pcie/cxl_aer.c
@@ -73,11 +73,6 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
 	if (!info || !info->is_cxl)
 		return false;
 
-	/* Only CXL Endpoints are currently supported */
-	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
-	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC))
-		return false;
-
 	return is_internal_error(info);
 }
 
@@ -92,13 +87,17 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
 	return *handles_cxl;
 }
 
-static bool handles_cxl_errors(struct pci_dev *rcec)
+static bool handles_cxl_errors(struct pci_dev *dev)
 {
 	bool handles_cxl = false;
 
-	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
-	    pcie_aer_is_native(rcec))
-		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
+	if (!pcie_aer_is_native(dev))
+		return false;
+
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
+		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
+	else
+		handles_cxl = pcie_is_cxl(dev);
 
 	return handles_cxl;
 }
-- 
2.34.1


