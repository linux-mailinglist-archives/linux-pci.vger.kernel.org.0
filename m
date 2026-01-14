Return-Path: <linux-pci+bounces-44808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EC4D20D0D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 403323062D61
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD2A3358A0;
	Wed, 14 Jan 2026 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YYnZb09/"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83CA2FFF8F;
	Wed, 14 Jan 2026 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415066; cv=fail; b=IXaws2npWBqxMx+cEkin8g0UITBSkGDwG+Icby52cwlpARLn5/h689xuL292Dh79ZgBD7fPJWkGTkRJXnjLGmV3hBmTZjbShG+8DPLIzpUZD6t4HSLR36mOjuEQ7WFM/DyJ9lx0/2keV0Sj04Iz3OB8SAPzJhy7yo4sppFt6arA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415066; c=relaxed/simple;
	bh=I2+os5LOLKG4FXaqJWQOap1TzNRcoFsrNHRTRGYd9Y8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1/oXIn3QBJlbDIZNdt0ioqKUpmqWnIlgx4cVrGUQ7htgsnExTAAfbnhVEixbNsFVVw5weWLd0VW8PXlvpfqK5sg//HruQ4Vvb6jTzpFLjq5AgYAUNXuF+XTIILt6E3Qid+eHXcsKq4CA5yqKbo5SWXBqC0G1LBovXqYrH+4024=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YYnZb09/; arc=fail smtp.client-ip=52.101.62.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rl6yHqU2KrHVPgLLHaw2OVZpOAmh4z+MDHyOdt9oDr4kgMKfeM9qHcUIaBeCGXNaIPQBXJj5YSudCbiwLJwMQGlNp56Zkcc9AlLSXKV/Y6f4Strj42/1DjmFrtS3smoIzh4eAxbONprvm6xgySSfV7RjxKYZzSgFNj1rco7LeohZXC3ECz6moK6QMgyQsCbMHHRu67RUi48qHEOOuwF7HQIYj0K5ALG1FMc1XeKQn+HjA1d+lVCHZK9gu56/295okW2f7pN7tWflsXx892HbH7ikDSEtt6aLsJNl3ANCZFNFdDtKeYOThZ3DcqFm2Ncb4aARGrlH9vJiwLb957axGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTvagjfN0/nj097j8/D7x+AXctoiVCNLrNB9HLOkbV4=;
 b=D/sZWJkOw8Wyrcrsn0NXc0YS+TL4APbn5qtBW38RKYcZthW71BLDX8XaqJTDsdoyL3b3UCqzDsmwOBZs/ug+aYXPuEBDnh+x6ZRDYcjGuEmYtFlhfQyK5eVs/bstBZnGA3PAkrHgiIyyXVUFFmAcl/Faz1TbiF4lEqZfFNwDtxLFePx9PExm/E7j/ow0HFYIEQvmw9bFtZgFda8gcD3Yu/q3HFFdm6SZyBCJ7CPzpAw7NmvEfsyrBAPYGcxlsOrYOa4iGbD+cRyChzGCXxAlHzN3SBYSfRrj/LIZcaoWI1wCuUTlGRJT7O2PXYamQy3c9y5fJBnm6GcTV0Gzs+Vuow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTvagjfN0/nj097j8/D7x+AXctoiVCNLrNB9HLOkbV4=;
 b=YYnZb09/2zn983ifmJeLbajflcW6grwSjFdF+dCscIL1cv0yDhezCSRttlgDuDsgGL9w3eqAZThF/BaSiUViBaskDJG/25Fi69Y8roFw5coGcSGlLMND8bnUjvTYtu1HIXehHIfBp4/zj2HkS8kz+ppT116UjoTTOsgkiBQ9bcI=
Received: from DM6PR08CA0014.namprd08.prod.outlook.com (2603:10b6:5:80::27) by
 PH8PR12MB6987.namprd12.prod.outlook.com (2603:10b6:510:1be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 18:24:19 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::c1) by DM6PR08CA0014.outlook.office365.com
 (2603:10b6:5:80::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 18:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:24:18 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:24:17 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v14 15/34] PCI/AER: Update struct aer_err_info with kernel-doc formatting
Date: Wed, 14 Jan 2026 12:20:36 -0600
Message-ID: <20260114182055.46029-16-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114182055.46029-1-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|PH8PR12MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 5efd0c5e-6211-4e48-7ca6-08de539a21be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KVkDVv9BJeCasAP/akqMF1kGS/gprM+EYN0Ht7PXBzlEY+270Arx1X13rJ3r?=
 =?us-ascii?Q?mdC/9siuRsGSeVyta/Hi5QXNOpWlacWauALbV1zpn2oCOghl573DEXArqkkq?=
 =?us-ascii?Q?cDAsqGtRxdcFP64cnAgR2qqoznRUPtcrd54rcMRDJbvGgG+Ff5YfmIM3Ezly?=
 =?us-ascii?Q?upk3nXA2OorkWaI2OTLKk6vJYVdpoeembUD4U2kZEsjKtBS+LVKdt8kLhqKj?=
 =?us-ascii?Q?kE7wetGcLwUueYBAUT63f1/cnY4v9KJZhYm+lHP/2YmguajUzPq9weK218FF?=
 =?us-ascii?Q?/1VlPw/tO8Dsq7ZFSDcOfhRQDssvUFypDJX1pRwpV+xFUd37+U/kVJaogoz1?=
 =?us-ascii?Q?2e8e0TMVYprCkR0wphhW4RyLabHIqTrCEIjRuA0QOnMDlU+25We2wFShtl9g?=
 =?us-ascii?Q?itd+1vkcI+pE7A4l+otVNgWCmi1OGGEwcCnqW9ngyMlDxnHvhRF7x8h+3laV?=
 =?us-ascii?Q?RTM+2swSO4CCANzaShTtAGda3rHLNoJCZ4ev0BX7kp/U2P4fvSUm9ICjXO3k?=
 =?us-ascii?Q?2dAurtThin6mu/jQ3f94BZkTL8wmWRRTMI/TAM0tj8hDYZkyjcohoZcr37nh?=
 =?us-ascii?Q?6csv96l8if4uOlvv3F3YJqPhXmzKSjEPSIxI5Ztn/aZn6eyUjJ8uMh4ZPq2F?=
 =?us-ascii?Q?nLv+zC9yuHv9aBQGOD2ln9fcnNwT9hyopsO72Bypq0H8tX/9cuk5WQJ/N7Ko?=
 =?us-ascii?Q?mWHg3F7r2fo9sj6YTp1fiUDoSrrL1nYSUcw1zmeMBLHkkoQ/sWDL2ktzmZ6S?=
 =?us-ascii?Q?8crUnwDTSmWdXJz7Oqm/+ENWnOIdVBPjmeyFnSqk9MtxhkAhLcDPJHJepf/M?=
 =?us-ascii?Q?cwjZkIHhwFHDijFnogzmG6tmtyKdKHW2EdZeLiRLFcWV8OvehK+DQjkQsQQc?=
 =?us-ascii?Q?DH/DeDVuNwhmY2IVAiM46kXMq5TOhV3QnmcPR3kc6ER2u5+pBRkggxQZeGEX?=
 =?us-ascii?Q?qeaEp1VbzlVT3vAVATgfu7n+5zo4zvZ5j8sJKOd/K4/7h4k2BnPnkNphgax6?=
 =?us-ascii?Q?QrvkPD/dirYaC+XUROmwRN/sg4a7SFrso2aHQYyTJl3vDW3A3FbTBohJmagY?=
 =?us-ascii?Q?xMkwm9CCaUSBH/5/WnXpVm7En7zEiWtwoDSWD838/+0/+aEQtq2Et/J1GOul?=
 =?us-ascii?Q?ZGul+62aaHolaKCo0UDkVr/HVUiOEf3nVoAWBPDycZ4xcMngFCKs7HNMmiGY?=
 =?us-ascii?Q?+I2PDHSpe+ZcSGkEWaLv8F4TAtlw+l/v8391axlF9sKNFgXZybIwDVu0uZ1t?=
 =?us-ascii?Q?eXVEKo6N4GNA9xtIuPn5Y+gWUfXEGZt0b1rlmAHZieX/gJ2banPYZHuMZhzv?=
 =?us-ascii?Q?QAaY7YJe7HmPNW9imp9BTnxapRnH1lLiHZO7ja1/9ku7vMiWzoyF/UkN+Czj?=
 =?us-ascii?Q?4ZEMxIo4L8raVExyHWHRnXRoapBFgI4OY/OmAzGxvqS2ps8hTkUUm/AiaWzL?=
 =?us-ascii?Q?EDFxC1+lbKyMvvqb3wuSbxB/a0PaeI5DIQwHxdarMSwcaoEr8bh7McYOL/3l?=
 =?us-ascii?Q?tzThM8wzw+VRQfbZyIthYs2MAQTEf3Ve2XT7DzFlAicMZLQncntSisnejfpC?=
 =?us-ascii?Q?BKPyWgonHFUJsk7ing9COb2jluov7CECLou4tGg2QOV7mtRGdI7O9NHhlZmc?=
 =?us-ascii?Q?XQfcy/nwoMywd2rYkI6tJpyB4jJoE3LSwr7fKVUUGHKn8HVooFbp2G4e2Gn9?=
 =?us-ascii?Q?zIHHUTVTNtorg7yTXFGIiR7Je40=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:24:18.8525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efd0c5e-6211-4e48-7ca6-08de539a21be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6987

Update the existing 'struct aer_err_info' definition to use kernel-doc
formatting. Remove the inline comments to reduce noise and do not introduce
functional changes. This will improve readability and maintainability.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes in v13->v14:
- New commit
---
 drivers/pci/pci.h | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 41ec38e82c08..dbc547db208a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -724,16 +724,33 @@ static inline bool pci_dev_binding_disallowed(struct pci_dev *dev)
 
 #define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
 
+/**
+ * struct aer_err_info - AER Error Information
+ * @dev: Devices reporting error
+ * @ratelimit_print: Flag to log or not log the devices' error. 0=NotLog/1=Log
+ * @error_dev_num: Number of devices reporting an error
+ * @level: printk level to use in logging
+ * @id: Value from register PCI_ERR_ROOT_ERR_SRC
+ * @severity: AER severity, 0-UNCOR Non-fatal, 1-UNCOR fatal, 2-COR
+ * @root_ratelimit_print: Flag to log or not log the root's error. 0=NotLog/1=Log
+ * @multi_error_valid: If multiple errors are reported
+ * @first_error: First reported error
+ * @is_cxl: Bus type error: 0-PCI Bus error, 1-CXL Bus error
+ * @tlp_header_valid: Indicates if TLP field contains error information
+ * @status: COR/UNCOR error status
+ * @mask: COR/UNCOR mask
+ * @tlp: Transaction packet information
+ */
 struct aer_err_info {
 	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
 	int ratelimit_print[AER_MAX_MULTI_ERR_DEVICES];
 	int error_dev_num;
-	const char *level;		/* printk level */
+	const char *level;
 
 	unsigned int id:16;
 
-	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
-	unsigned int root_ratelimit_print:1;	/* 0=skip, 1=print */
+	unsigned int severity:2;
+	unsigned int root_ratelimit_print:1;
 	unsigned int __pad1:4;
 	unsigned int multi_error_valid:1;
 
@@ -742,9 +759,9 @@ struct aer_err_info {
 	unsigned int is_cxl:1;
 	unsigned int tlp_header_valid:1;
 
-	unsigned int status;		/* COR/UNCOR Error Status */
-	unsigned int mask;		/* COR/UNCOR Error Mask */
-	struct pcie_tlp_log tlp;	/* TLP Header */
+	unsigned int status;
+	unsigned int mask;
+	struct pcie_tlp_log tlp;
 };
 
 int aer_get_device_error_info(struct aer_err_info *info, int i);
-- 
2.34.1


