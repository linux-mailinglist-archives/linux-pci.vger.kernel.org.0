Return-Path: <linux-pci+bounces-8882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF25090BBB6
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 22:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EFC328221D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 20:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FE518FDD6;
	Mon, 17 Jun 2024 20:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="osNUnLv2"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E21518FDCD;
	Mon, 17 Jun 2024 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654758; cv=fail; b=Tu9LkcP+JnGhKVavJsk8chBOTN5XLhpvyXrlqcMYT69A+SCkhWRmDBthNGVQaZWwcxZPXMkqa5icXZAqfrBEbxPcovexoI89tnpd7J4JZzJga6Nm+Z9qqG7A0oycwqK/980depeMpjVy+SRFhYcEYJF51UmWWfGQsTNlT5cujYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654758; c=relaxed/simple;
	bh=m2+M7Uq08F7HibZgF5W8wxOp5E1Evv8hjSsaJ7FLKlk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STsU/R52ky1s8Lp8xAo0TMLGzvp2Q66o1GMLLdmYnvYg6hHJ2KI1XIzt7b5pSYURacx2hQFUmDmOk8JScB18a9PEpZ5H1klVTSG7myHGop2cyDaokFAyhLoqx1QAxalH5iSigzabRDwKccobGPE0Bna+E3X2b+rpUFQYSI6/RnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=osNUnLv2; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBS7bAxeYHjWN+6W9HeY41r16L/oX2cYqmmYNqJraTtMlwm/glKGTfP0wHEsuaAMEowHmuVRhNxtMikg9ZyvoDG1yEPnIzOy7RYIyXEBHU5gopXBNehgNyBdrJnFhcrmX3VGew6KFaSFg+5wF8hrWruQdaa8dicmWni62zS/RO/C/hcbCcAcqnMxaAtXA83xNdetaCMPigOg8E0yN3XCrDYuBSQZPdqhq7TOt7xBVJ9V6wlBKy2DeGVHyt+rJhTKn2eBf8pCdKiDyEOo+VcQeMLtAh+mv2bYC/SgoZEBFsE+foH4t9TEEUSED828IkD1/2BD5WR9l9hw3n94sm4bng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRQup9KGzBjZ10NoITfMp0a+Us+E7VpZ8nL1w13Kflw=;
 b=AAR1X5W2bjapKEEmjFO10EtBOl09e0ZvSILR55f5naxMivPtKHeJwaK3hK848OLBez6qQM/bNwv3bdFBG4kk0IdhpYwl4Cy10xX3+wF6DgZHr2HoA0GzUa+r4Y8gIrviVXRTxWbl5hVXh4w8s4fjuS2eOA+JstEE7I8JlUVt8G6jLHT2VmTvgBmZKZPwCbFCOI91o/R4fb5WnaZYpz3ZvjgzR3dBbz1o2SaFMmSxzx4hrpOsYBm+yk3Vg+OjvgtfSXtYtwQ3GJVVbouusn94zjtaAuB2osQFtp9e/jcd/BHFBlzua1wHJfPI3wNIdrS73M8O90hQqoRZKemtQWRjZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRQup9KGzBjZ10NoITfMp0a+Us+E7VpZ8nL1w13Kflw=;
 b=osNUnLv2kNhLDx9eAlAJxaJ+sIIct5mfJqzjd7JBXWzOF+rHDlm3J3i7DlJu6JBARzvVz98X9G9/8u7nx9oNGaBlsbmyiUInQXr/DxNx5HaT8ryppPuyYZqdEPBkU+cFy0BKaVoGkzhFLKU8CjJf+gFu/X4bjPWio34LMDsgZAs=
Received: from SJ0PR05CA0074.namprd05.prod.outlook.com (2603:10b6:a03:332::19)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 20:05:53 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::a8) by SJ0PR05CA0074.outlook.office365.com
 (2603:10b6:a03:332::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 20:05:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 20:05:53 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 15:05:52 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <terry.bowman@amd.com>,
	<Yazen.Ghannam@amd.com>, <Robert.Richter@amd.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: [RFC PATCH 8/9] PCI/AER: Export pci_aer_unmask_internal_errors()
Date: Mon, 17 Jun 2024 15:04:10 -0500
Message-ID: <20240617200411.1426554-9-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617200411.1426554-1-terry.bowman@amd.com>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb1fedb-f156-4aca-6fc1-08dc8f08e47b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|1800799021|82310400023|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OOaGlpVEo2NB2sHV/PUp8BhSUYlYHFI3i9RvhG/mipjYHrpQUeCpZttkoxYb?=
 =?us-ascii?Q?ttZSPIIk9eTouGxMcPuE1BaANfSmwzlEfCcL2GDMM3AGeLIinLFsaedm0LMY?=
 =?us-ascii?Q?aCVx2kZLTFfwRG396RM3xvGxSgVRn2V2owgheuf2Kxw7kSbeC4oPLOCTju/I?=
 =?us-ascii?Q?5GZK5IBC4RBp4hV9yXRzZT8SE3KCy9c6UW7t72D2xa92Ii9oxPMDDWjKbdq7?=
 =?us-ascii?Q?hDjyLxIpMaPYiKfB0kRv/sLiMASPoYWHzz2Ww9qoREocaAE5b9HSp39pd8tn?=
 =?us-ascii?Q?on6ERpY5PpqH7pYbbi8VqiugQ7HEHpvVjsjjgu0Hvjg+QAq0lZhYDz7FL+/L?=
 =?us-ascii?Q?bi4WdKyCHO807vDUuBxIYYBQfCZMvmL+WRKB2ilVVpNsIo/wSrFHz5v/5/TB?=
 =?us-ascii?Q?ecDPU9uGJl2pr6mLCjRsRBghbKy2kASWb/9+plI+rGwWkI6yGL6julQQbkI7?=
 =?us-ascii?Q?e9MTAAs8eYetX0c9cc64KCo5YA9RH3alJyXBNFAD3qn8zzncA5MDDuT0Ptd9?=
 =?us-ascii?Q?U/ecMiV4jEf5Nq6erYG66v5549hj69zvHhAlPH5dNwD2acnx2i9sBig/jD+s?=
 =?us-ascii?Q?HI1TDBkk8GNIKC5Mv6hYJS8d27l4P+UmiUFio/fDAwxHwxGRFdT5jBQFA6yR?=
 =?us-ascii?Q?2uSn0Dn+CNPUSix6R2RGnh4Q14vthiBTUi+zvbw5Pd0/Rs3eU3KMkg7WVVfd?=
 =?us-ascii?Q?I6mhw6T5H0yMLy8xlYW4qoc65Wcvzk76M1FwvcsF1HhzNpv3moBfvjhXEI2n?=
 =?us-ascii?Q?sQlwOOp0QpfLgGd+mI+P8GpS2/+omCY1gQYTDI/sF7J4W1BMH99KHHr7Xi0J?=
 =?us-ascii?Q?KB5m4pnxziJCuKjcdp75alfKwRXvnFQXwDd0JQH3dxtJucdn4bBwxIoRoZVX?=
 =?us-ascii?Q?v8w0oXN8G4MlwoxIMFihiIKwHM3rFqZEqenOXu8O4uZry3wTQXjTEwdOE0yI?=
 =?us-ascii?Q?r+aLYLhIw+zb8odxGL7hqZmtuvHVh/cML2wTDEl1HOpxbpI7J/9oQyzafz0c?=
 =?us-ascii?Q?FQk22cSSzl62JFk9gGTGo6CeWk9P7AUMF8IGRfJT5V3ZQodo/XG+9E5+rEC1?=
 =?us-ascii?Q?rQXOh07TLnQ3KuHvHFJVscguoKeNPSHXel3uukYkPWjEkO8qv6P7fSO6w4BU?=
 =?us-ascii?Q?ZzOz6EivzBLAOwsDm2vAbWW4H6/DVjvTeyer/9mK0r46wqh1DPjiWT2rEEu5?=
 =?us-ascii?Q?aNHTknoJJVIYYol0Li7oUrSKLOBFDw7axlHLO8nZXbKIB7GOkEInctuAm08z?=
 =?us-ascii?Q?LbC+0jeEYBVS8ZojoyhpbW+1HshmMZZgX4ExzaeGypP5GDV7mFr/drG2KLtG?=
 =?us-ascii?Q?n1th1IetOGzuzwUjHAhE7lj1vA7T/4YUdE7atE1BAQeXvTjjIWCKGhiPx5HG?=
 =?us-ascii?Q?kSUBwKD/kjKFbm+G/GRuZCwrv30tU/2NmZ05JFI1PM0xMAhauEMjADe06AHM?=
 =?us-ascii?Q?63/vm732PtU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(1800799021)(82310400023)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:05:53.3854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb1fedb-f156-4aca-6fc1-08dc8f08e47b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878

AER correctable internal errors (CIE) and AER uncorrectable internal
errors (UIE) are disabled through the AER mask register by default.[1]

CXL PCIe ports use the CIE/UIE to report RAS errors and as a result
need CIE/UIE enabled.[2]

Change pci_aer_unmask_internal_errors() function to be exported for
the CXL driver and other drivers to use.

[1] PCI6.0 - 7.8.4.3 Uncorrectable
[2] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and Upstream
             Switch Ports

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/pcie/aer.c | 3 ++-
 include/linux/aer.h    | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 4dc03cb9aff0..d7a1982f0c50 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -951,7 +951,7 @@ static bool find_source_device(struct pci_dev *parent,
  * Note: AER must be enabled and supported by the device which must be
  * checked in advance, e.g. with pcie_aer_is_native().
  */
-static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
+void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
 	u32 mask;
@@ -964,6 +964,7 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 	mask &= ~PCI_ERR_COR_INTERNAL;
 	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
 }
+EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
 
 static bool is_cxl_mem_dev(struct pci_dev *dev)
 {
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 4b97f38f3fcf..a4fd25ea0280 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -50,6 +50,12 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 #endif
 
+#ifdef CONFIG_PCIEAER_CXL
+void pci_aer_unmask_internal_errors(struct pci_dev *dev);
+#else
+static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
+#endif
+
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		    struct aer_capability_regs *aer);
 int cper_severity_to_aer(int cper_severity);
-- 
2.34.1


