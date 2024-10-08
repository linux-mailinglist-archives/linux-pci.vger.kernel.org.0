Return-Path: <linux-pci+bounces-14019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE74995A03
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 00:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894E6283981
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 22:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433BC21642C;
	Tue,  8 Oct 2024 22:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C4T6F4yA"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253FF216429;
	Tue,  8 Oct 2024 22:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425986; cv=fail; b=fAMbJcnqPhYLHQ6DFnYxyulxElIrdNLzCMTmFJ90F46AZ5d+YEAj5M0nABONDpeFRlOx+++/v6KEKkFkfZFIJSSgXsxSiRicp0uiWpbOl9Oe7mdHDRfRSReBZNvIhcS17kIhK53xhJycDrs/okyDD8/1jVV6llmfFsJCvJ4uArI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425986; c=relaxed/simple;
	bh=WnI9cftdckMCCfAB/cCAoK83Qqfp8hCPGKlp157JaRo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NDU60jubb4x23vFR6HEWIbZ7NJ6w4n9xSAszzWzFaO+j+yF+0s4kxy+tcWGuzFQiCYwx+sp1GvFqqvjhH7VezNohWI1ETFhERbTQ9eRhYvjzr0r0M2azvtTdMBxAUkyf0irwZ7+twYdlM5a83FKFwEPaT4JKJ0CXOOo1FsGWeg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C4T6F4yA; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCLPIrZrq6aJk244w7JyaMtCO+7eWsAVCPFvn77ZEHLuzJ0DjReMj2RLXotOW0GKRGWVcgPtdLRAX2NWRipi5IfSn199nEOkP9oReF0l/jPO6bNQpjQcM2F6ug3iqtH4S3jLyl6xBQKIBhwtH6bgyvHu2RRwwa5nMhrXSG4YWftfKowbFuEJjwZvCRZXViqTSb2ZRUEhqPmO5um96VLTdBC9FmQxmBzl9l47WPTNfqNwBRIOm4BD0uMFYco7IzRuS2DWiWUAEx3gFtgiuQbIXa6UNBJlm2+uIxjuQI3iZt7lzqn0KMjOuIKO+KZCjJBowFqZYcbigwR1E6zWFOPyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IJezya7VDFnthrpvmaJErquhXQmSEGt3pjALQGFDAE=;
 b=qZgbUB0hIhoKFfZc946OszK/mi8qCMjcBEy0VK/Fw3mXVseJUOx9tWy4EZ32xidlB1ypVQOpgKkcygH9JcMdV1oiXEiFmwcG9+3UxUB4RtROlEK99JvTl8T34EvhBVfOHs3cK0v+/oaj0TsfCSfFE9ZJSHW1QxdiXXanmfAW82+en8+vCM1PE7UdJQDWH/GqXWN4573L6KT6AxveEJku5Ulo0W4VHSagnsBf7xnOdJg/5WxF0ZwLi9HoqVDzLGxqpYjyFEeFMql2x0G8EMkKvrdMgzwo/GtHe4kW5Yk/ZXUk4sXRSC1QAJQ9mVQ1Gh2LMC9tKc2InK4vJZUhcsasHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IJezya7VDFnthrpvmaJErquhXQmSEGt3pjALQGFDAE=;
 b=C4T6F4yAJbXGBcpxSAS3HoRoQnFMzoEeVRJwsTuhUAu5OVdN9FnLw7hVYdAOSGmfHwFoJaZb6T4fOAYEkRkF5Iz0evx9CT0jPziy8a97srHP5E7fm3SBXKbN4wJqgwr2nqKPJVFk4Febrk9cVYoMhCdtYQ3NSD4+am4T5JSxrho=
Received: from BL0PR02CA0023.namprd02.prod.outlook.com (2603:10b6:207:3c::36)
 by DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Tue, 8 Oct
 2024 22:19:39 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:207:3c:cafe::37) by BL0PR02CA0023.outlook.office365.com
 (2603:10b6:207:3c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24 via Frontend
 Transport; Tue, 8 Oct 2024 22:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 22:19:39 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 17:19:38 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <smita.koralahallichannabasappa@amd.com>,
	<terry.bowman@amd.com>
Subject: [PATCH 14/15] cxl/aer/pci: Export pci_aer_unmask_internal_errors()
Date: Tue, 8 Oct 2024 17:16:56 -0500
Message-ID: <20241008221657.1130181-15-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008221657.1130181-1-terry.bowman@amd.com>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: eb7182a3-222b-4b78-d284-08dce7e74d11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l6vLoN211EEYs94sDCyQeu7KrVVX+Ls2CQGHvfMAavxPDFS8EYlD0gyvEzLA?=
 =?us-ascii?Q?eypAZ82NVp1lRgJ59W0vVIhhAFUNW3PAp618PSTjYhup20BtL7VUdB4yzF+E?=
 =?us-ascii?Q?j3aRiYkYSs3oBHTqQUEx1JA8zoz4rvZ4cCAWUt/KgnzgRoLgsQu9ZZ/4SuRb?=
 =?us-ascii?Q?R6+9jWBRWQQOTM3PQjFgvwVHZkQSUoi6U4wGwTtzG3HEp2ckxsWtqR/jXlq7?=
 =?us-ascii?Q?thjfVNbjqINogGlBAwhJP1J09OY5f+BPYsFXuNJk4DknpXgYExg25OTGxK9r?=
 =?us-ascii?Q?7Dmag3VuLMUNXU4t1PuTZeL7HSr9JdDn4XOP2fl9yidEbX5WaQDf8dllzogg?=
 =?us-ascii?Q?cdBC6Rnm9SR8VHuhW0z2LVlP942ReGl6D3ZFn8QRdkSI5UaOtZ7v3JyUf4Pi?=
 =?us-ascii?Q?4uw33X5edTSz3QDWnzPz5MPQZAO6F3Z+awq6HQlqWmmWk5ax1qU1mtr+Lrwf?=
 =?us-ascii?Q?6HtpJUcFrgOdMPJrgpjm03KcqxvYoWkZRgei+2MSL9AITzKpRVlzd4vNl8j1?=
 =?us-ascii?Q?VxAQDHXjnl1cINBnkKBbp0Py/a/DWsyGtVgXykIB0cupBBSdWRjzmy3PK0Nw?=
 =?us-ascii?Q?AhU1Dif0cKA7KbgvQ6BX0WTA1kTLDhYyRyim53fMJvwsabf5PSEi/bu8zps4?=
 =?us-ascii?Q?nlGSmQM83THJj4sZb2RlLfk+KhYgm4BJv1DEFQWw3q/hCrktPUq9AeJVXFJg?=
 =?us-ascii?Q?uOog3q1SVmyBMa6lFNr7/JsQqH9nh4aefR7K4RL3Jm61tRrKDqKZZimF/8gJ?=
 =?us-ascii?Q?qfzlbhRvR6X0vHCXbOijKFAvpuXnbNqEeJMdFVlfbhZ1fYdGjpfBUHCb5KzA?=
 =?us-ascii?Q?pK0BKXG9T0dNyHR7YfjHkvisPi1DNXlBhglJYuf3TuJcIFaRH13aVODTV+fS?=
 =?us-ascii?Q?qqYjVVoYNdTBtGia1F+sBwjhLBtDYP1x4mFTo0RMO4rTvecGof8lIaBv/a7T?=
 =?us-ascii?Q?ioLFVjfF20S/0/osKhRfBRSR0EFphgO0BHhTJAMFJPHW54MtdK23MCn6f++A?=
 =?us-ascii?Q?T8/PiVk8R4+dYbr0Qi49UbEQNF/LNjavdqeA8NCGzVwKtakS0lCAeuGRG2Aa?=
 =?us-ascii?Q?5IqRG4WoldEoATrTXxhY+0tQPF3+qvkRz5iLBal1NZP6TMRqMovTbP64Dk+E?=
 =?us-ascii?Q?jmwxfLo7YNi68IWGMQr/JWmZRYyAFlqZtI+JIX85e9CPJZLdrQSQ+a1X4dqW?=
 =?us-ascii?Q?pz/MNC9ysgE9pSuDx/GQ4w4MVNCj0Ak0cUUOpMUC/4IdXqreO89r6g6C149J?=
 =?us-ascii?Q?Wy7Qm5Jmv12xfcttSsWeSofqwuI1yhOQU++tMF3/uPFht7R09lYn2Pa1Cy3l?=
 =?us-ascii?Q?ymGeh04FXm6Pqj7uTIUzfSIz2fDgLipfUDeQiyF3NdnvhyAPbcl0cxm1uPZM?=
 =?us-ascii?Q?8xRn1wsgbVRkBfxXS71HNF32zy3F?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:19:39.5618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7182a3-222b-4b78-d284-08dce7e74d11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933

The CXL driver needs to enable AER correctable and uncorrectable internal
errors in order to receive notification of protocol
errors. pci_aer_unmask_internal_errors() is currently defined as
'static' in the AER service driver.

Update the AER service driver, exporting pci_aer_unmask_internal_errors()
to CXL namespace.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/pci/pcie/aer.c | 6 ++++--
 include/linux/aer.h    | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 81a19028c4e7..1b4004932084 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -962,7 +962,6 @@ static bool is_internal_error(struct aer_err_info *info)
 	return info->status & PCI_ERR_UNC_INTN;
 }
 
-#ifdef CONFIG_PCIEAER_CXL
 /**
  * pci_aer_unmask_internal_errors - unmask internal errors
  * @dev: pointer to the pcie_dev data structure
@@ -973,7 +972,7 @@ static bool is_internal_error(struct aer_err_info *info)
  * Note: AER must be enabled and supported by the device which must be
  * checked in advance, e.g. with pcie_aer_is_native().
  */
-static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
+void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
 	u32 mask;
@@ -986,6 +985,9 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 	mask &= ~PCI_ERR_COR_INTERNAL;
 	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
 }
+EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, CXL);
+
+#ifdef CONFIG_PCIEAER_CXL
 
 static bool is_cxl_mem_dev(struct pci_dev *dev)
 {
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 67fd04c5ae2b..c43d2b60b992 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -69,5 +69,7 @@ struct cxl_port_err_hndlrs {
 void register_cxl_port_hndlrs(struct cxl_port_err_hndlrs *_cxl_port_hndlrs);
 void unregister_cxl_port_hndlrs(void);
 struct cxl_port_err_hndlrs *find_cxl_port_hndlrs(void);
+
+void pci_aer_unmask_internal_errors(struct pci_dev *dev);
 #endif //_AER_H_
 
-- 
2.34.1


