Return-Path: <linux-pci+bounces-37052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD415BA1D75
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAAC21C84104
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B613A3233F8;
	Thu, 25 Sep 2025 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EkGpftp6"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8A0323F48;
	Thu, 25 Sep 2025 22:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839894; cv=fail; b=gogW5RBVR8ZJT6QeIVQAcfs0xWNaBviKwDmKWl7/6BBdINGzT/ZnYOWXVpkkisfmXjWVJZ6nbtmgEdpU6GQioV3Kfhb2ZAeQxpVPqMshePKwBop9QqFO9QvS9qcrrNOQCPBfvo9dadJl3J3fzixb/cHn1yOPmmZiGWKisM0yjuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839894; c=relaxed/simple;
	bh=O0CzrvjnmnE7KHdoYPZVzK6wlBtzzBsuv7l6sRGUKqY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPnqwYERMwPjj+WPIXuNd2+mP7Y4Ukt+liegot8Qe4uwrFkGvj2s3hC6fbe2MgHlTfOMsn3FjjLD3VWVDtDrRXUzKtjRukuAc7y1Q5CB/AB8HCYbi9Q5hcQJis3LuZeXRIYTkhCVl0ZCZHJr+XTrW3I0TnzmhxGFCS91hAdYs4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EkGpftp6; arc=fail smtp.client-ip=40.107.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1f72KXX1lHeCys3EiBYAVSRmDdAkr76tmGYxCJrKTRQ26eEXw3HY+/prAuHmmzpn8WDm3m4CTEPYdw993in0d6AaV0xgrk2Bf+cP6DQrNjh/PdkF90Fe/ga4ncmXRGiXaj7l2jVcXtPf65328ivtEd3wIELkTHXVjw3xBH0SqDj/xklE1EoB+K8oVSgpspAvt0Tgh1nlOitkMDkhtVrvL2Gafy1TFr1ilQB2ADnEpzSieelvdZbMNS01QFfNKnfcVA4xb2aWBPiRiCAhbU6Wst8HNcxgD30I0Dx/Oh6JVpLfBzfzl5wEE9TKeMFpIAdlQDCD2vg5qpQLc/Cw4osjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeQAisd7PfSdR0b/qYB3+/GNwtlTBGyiKBs4MrSwhx4=;
 b=fWhYYw1HV8eSwGD5rDxaVZSilzy8gX/Pqtk/AFLEc9SmSe6cRAAqT+QDHGYQLSK8tGn844jWaoSQs/bgDX/LbMRZFZ8cs74pZ1nN0u9k/oxO2xHILmVyrE8Ox7nIQx33m3pF0n6k6Z9QC9zNQ8Ykk87EN4ZkT1Z0i/xqG3Lvg/GIAM1T4is3DMO0zYVSTWKoKV4Iv+pIUxQtfwiJMwpc75X0WfvWS61hnjnU55G2ZtuC8OHRqUMu72N8CbtRJ2vSNHUYIkAxWiqPHi76Mr30c1eeZgb/BLC2XCv0PW3hbcgUIxQq6Mn2YUwLEHDfWoB+tqB6VXUK3xMJ8EKk7bfBTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeQAisd7PfSdR0b/qYB3+/GNwtlTBGyiKBs4MrSwhx4=;
 b=EkGpftp6iVqlY86lQa5cXQfgdLxDxnatwJ/WWyGKV+EMlkhNXQ1FBezwSf1obsLFbp82gLbczJQlsR1Ig3rfHveCv3h/Ty7Pc29K61IspF9XH4HB8daLgYztiuR8lpNFOs3H5yZ6qbD/aEaMtQlxfgY8vE5YukAFdRzbOCJs2Io=
Received: from BY3PR05CA0014.namprd05.prod.outlook.com (2603:10b6:a03:254::19)
 by DS7PR12MB8347.namprd12.prod.outlook.com (2603:10b6:8:e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 22:38:07 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::5f) by BY3PR05CA0014.outlook.office365.com
 (2603:10b6:a03:254::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Thu,
 25 Sep 2025 22:38:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:38:06 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:38:05 -0700
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v12 18/25] CXL/AER: Introduce aer_cxl_vh.c in AER driver for forwarding CXL errors
Date: Thu, 25 Sep 2025 17:34:33 -0500
Message-ID: <20250925223440.3539069-19-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925223440.3539069-1-terry.bowman@amd.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|DS7PR12MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: 32334eec-70da-4092-dd23-08ddfc843280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0cbk7yL65nEYv0aWi3d1OFlDBW1XxGF99BA4bIt4JdpCZWYwwmu97Tt1AIs8?=
 =?us-ascii?Q?ywSEqbyhTmRGpHnzdjxiuCAS68YV992W8TtJLQ+wRbZXScGcO7fys2oZFHsy?=
 =?us-ascii?Q?Yjo7yib8s6c2bbu6ZtHApcb14me+ynoJvQg0fGarEAU0rNKJjhCnHVUSF/H5?=
 =?us-ascii?Q?8kMiWGbJAXPwgHa4YjTHqPbUm0Fk1TUiwO8K5JKZHVLT7jj7SdFg3ucDLLja?=
 =?us-ascii?Q?dqwaHWFpGjqD7XF6w6Uzb0jqRgpxuYEwIjayrAXKjVZKHh1m9htDMC23+Y6S?=
 =?us-ascii?Q?uDiJEBzMjlds8yy+8T179BwVt/K2aHBn9WHNeTkua7Oeso+XrwGoC48Ml4Zi?=
 =?us-ascii?Q?AjVt2B0KTU3JOTS4Hw4aDOMlJ9u2qXQBWzErQWxXaR1Rfci+X8TSt9M7RtrH?=
 =?us-ascii?Q?9zJPjSE9r795yzQMuGf8BUYWLJ02PrwhA8OEL5HteoNZmyos9gWeRPAjX47S?=
 =?us-ascii?Q?DjiKKO3qIt9k98ad2kWeBYuyYQqK6V2nv/pzFPxp7mHMgWniKT6Pm/sKAhCc?=
 =?us-ascii?Q?0eTVVa8iKaz22U1MFO7f34FcaiwyEFkuH6HXDupYgNqACccDwTOenyuojlMP?=
 =?us-ascii?Q?T+gjX7qhy4lts0Tza4fXpnfwcLWZds9DQz6dsZnZlG0006d7kvri6vsrTDQD?=
 =?us-ascii?Q?GmxxBocX+q+titMqD9+4stWahcrIUOIFrKpJOELwTUrM1N+04NSWd3//7F9v?=
 =?us-ascii?Q?SyQdJPtVxG8MEBXbWk8vISZajmQmj4yFpXwTD3eXVqA61SWewJwIRfFr2ckt?=
 =?us-ascii?Q?BT097qVrExybsszDgTp5H2divBcjsEQtWIebZ6dpw92Z6dOqwG3f7yUPMpTV?=
 =?us-ascii?Q?AcNU9aQK4JrMQKPi5NK6A4PEzDIzYP0U6XrZbc4VWVftm9ukkssrZBKfceAI?=
 =?us-ascii?Q?QUcd/d54YV6BV0sNZVN38LHaD5y6I82M53nbiyVCEUfgi3Omnbg9vjgSq4Xw?=
 =?us-ascii?Q?8RnrDYqFv3dLTcHLBXWeHQWxpZlz7efI7Cfgg0MtQqKpR7KJhkEPFj3feQk5?=
 =?us-ascii?Q?QCFu9OljIjdzNOp2qrHoMAIydDqHLV1zXVPDj1egl2ApX0tNliCORvYVrW9G?=
 =?us-ascii?Q?xbSaHA6XjRipvbRC+XWGuHq1wiKnGSmBkivXqw/R6nk4bLWswCjlOrJYxfwW?=
 =?us-ascii?Q?epGq7Z8SNuKLfY6LDeHoBtgvqD28AsGt5RVCnw3e9kYqbbQyg4vxTHC68MRz?=
 =?us-ascii?Q?WaWUaqQfY0P5wZYksbGfwOdrf07pdxeUypBwjh0K761CZPxaQ+bFyoblgCkL?=
 =?us-ascii?Q?hj2cXo6z3tY1sNdr+wwUlz6E5UQj4NDQlp2EFq85WbAEUF/oLiJFaGgYkIhK?=
 =?us-ascii?Q?yxTYJ0rQaarokOUm1pQF3oMaCiQnqoDbqH+VqOJkwZ9mbh6FTyIE6nJYaZ7V?=
 =?us-ascii?Q?CAwMAT6N/zU4XiGRg7/gGZ9405pUgd2xWD792bGk4M3cD2k8FA77LMDLM/QQ?=
 =?us-ascii?Q?05MablcvHqEiEk4BLdgv7H/53jtPUeu0P9z2rsCtTApQgPqtL3ggm4hvSdA6?=
 =?us-ascii?Q?OZgCrIIIFGk2IVfv/JpcxlK0qkfFoGLN0yfxRmIS08Zy9EscCF5SrhAA1Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:38:06.8312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32334eec-70da-4092-dd23-08ddfc843280
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8347

CXL virtual hierarchy (VH) RAS handling for CXL Port devices will be added
soon. This requires a notification mechanism for the AER driver to share
the AER interrupt with the CXL driver. The notification will be used as an
indication for the CXL drivers to handle and log the CXL RAS errors.

Note, 'CXL protocol error' terminology will refer to CXL VH and not
CXL RCH errors unless specifically noted going forward.

Introduce a new file in the AER driver to handle the CXL protocol errors
named pci/pcie/aer_cxl_vh.c.

Add a kfifo work queue to be used by the AER and CXL drivers. The AER
driver will be the sole kfifo producer adding work and the cxl_core will be
the sole kfifo consumer removing work. Add the boilerplate kfifo support.
Encapsulate the kfifo, RW semaphore, and work pointer in a single structure.

Add CXL work queue handler registration functions in the AER driver. Export
the functions allowing CXL driver to access. Implement registration
functions for the CXL driver to assign or clear the work handler function.
Synchronize accesses using the RW semaphore.

Introduce 'struct cxl_proto_err_work_data' to serve as the kfifo work data.
This will contain a reference to the erring PCI device and the error
severity. This will be used when the work is dequeued by the cxl_core driver.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

---

Changes in v11->v12:
- Rename drivers/pci/pcie/cxl_aer.c to drivers/pci/pcie/aer_cxl_vh.c (Lukas)

Changes in v10->v11:
- cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
- cxl_error_detected() - Remove extra line (Shiju)
- Changes moved to core/ras.c (Terry)
- cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
- Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
- Move #include "pci.h from cxl.h to core.h (Terry)
- Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)
---
 drivers/pci/pci.h             |  4 ++
 drivers/pci/pcie/Makefile     |  1 +
 drivers/pci/pcie/aer.c        | 25 ++-------
 drivers/pci/pcie/aer_cxl_vh.c | 95 +++++++++++++++++++++++++++++++++++
 include/linux/aer.h           | 17 +++++++
 5 files changed, 121 insertions(+), 21 deletions(-)
 create mode 100644 drivers/pci/pcie/aer_cxl_vh.c

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f7631f40e57c..22e8f9a18a09 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1234,8 +1234,12 @@ static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
 
 #ifdef CONFIG_CXL_RAS
 bool is_internal_error(struct aer_err_info *info);
+bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
+void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info);
 #else
 static inline bool is_internal_error(struct aer_err_info *info) { return false; }
+static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
+static inline void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info) { }
 #endif
 
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 970e7cbc5b34..72992b3ea417 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
 obj-y				+= aspm.o
 obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
 obj-$(CONFIG_CXL_RCH_RAS)	+= aer_cxl_rch.o
+obj-$(CONFIG_CXL_RAS)		+= aer_cxl_vh.o
 obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 6ba8f84add70..ccefbcfe5145 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1093,8 +1093,6 @@ static bool find_source_device(struct pci_dev *parent,
 	return true;
 }
 
-#ifdef CONFIG_CXL_RAS
-
 /**
  * pci_aer_unmask_internal_errors - unmask internal errors
  * @dev: pointer to the pci_dev data structure
@@ -1120,24 +1118,6 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
 
-bool cxl_error_is_native(struct pci_dev *dev)
-{
-	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
-
-	return (pcie_ports_native || host->native_aer);
-}
-EXPORT_SYMBOL_NS_GPL(cxl_error_is_native, "CXL");
-
-bool is_internal_error(struct aer_err_info *info)
-{
-	if (info->severity == AER_CORRECTABLE)
-		return info->status & PCI_ERR_COR_INTERNAL;
-
-	return info->status & PCI_ERR_UNC_INTN;
-}
-EXPORT_SYMBOL_NS_GPL(is_internal_error, "CXL");
-#endif /* CONFIG_CXL_RAS */
-
 /**
  * pci_aer_handle_error - handle logging error into an event log
  * @dev: pointer to pci_dev data structure of error source device
@@ -1174,7 +1154,10 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
 	cxl_rch_handle_error(dev, info);
-	pci_aer_handle_error(dev, info);
+	if (is_cxl_error(dev, info))
+		cxl_forward_error(dev, info);
+	else
+		pci_aer_handle_error(dev, info);
 	pci_dev_put(dev);
 }
 
diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
new file mode 100644
index 000000000000..8c0979299446
--- /dev/null
+++ b/drivers/pci/pcie/aer_cxl_vh.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
+
+#include <linux/pci.h>
+#include <linux/aer.h>
+#include <linux/pci.h>
+#include <linux/bitfield.h>
+#include <linux/kfifo.h>
+#include "../pci.h"
+
+#define CXL_ERROR_SOURCES_MAX          128
+
+struct cxl_proto_err_kfifo {
+	struct work_struct *work;
+	struct rw_semaphore rw_sema;
+	DECLARE_KFIFO(fifo, struct cxl_proto_err_work_data,
+		      CXL_ERROR_SOURCES_MAX);
+};
+
+static struct cxl_proto_err_kfifo cxl_proto_err_kfifo = {
+	.rw_sema = __RWSEM_INITIALIZER(cxl_proto_err_kfifo.rw_sema)
+};
+
+bool cxl_error_is_native(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+
+	return (pcie_ports_native || host->native_aer);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_error_is_native, "CXL");
+
+bool is_internal_error(struct aer_err_info *info)
+{
+	if (info->severity == AER_CORRECTABLE)
+		return info->status & PCI_ERR_COR_INTERNAL;
+
+	return info->status & PCI_ERR_UNC_INTN;
+}
+EXPORT_SYMBOL_NS_GPL(is_internal_error, "CXL");
+
+bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
+{
+	if (!info || !info->is_cxl)
+		return false;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+		return false;
+
+	return is_internal_error(info);
+}
+EXPORT_SYMBOL_NS_GPL(is_cxl_error, "CXL");
+
+void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
+{
+	struct cxl_proto_err_work_data wd = (struct cxl_proto_err_work_data) {
+		.severity = info->severity,
+		.pdev = pdev
+	};
+
+	guard(rwsem_write)(&cxl_proto_err_kfifo.rw_sema);
+
+	if (!cxl_proto_err_kfifo.work) {
+		dev_warn_once(&pdev->dev, "CXL driver is not registered for kfifo");
+		return;
+	}
+
+	if (!kfifo_put(&cxl_proto_err_kfifo.fifo, wd)) {
+		dev_err_ratelimited(&pdev->dev, "CXL kfifo overflow\n");
+		return;
+	}
+
+	schedule_work(cxl_proto_err_kfifo.work);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_forward_error, "CXL");
+
+void cxl_register_proto_err_work(struct work_struct *work)
+{
+	guard(rwsem_write)(&cxl_proto_err_kfifo.rw_sema);
+	cxl_proto_err_kfifo.work = work;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_register_proto_err_work, "CXL");
+
+void cxl_unregister_proto_err_work(void)
+{
+	guard(rwsem_write)(&cxl_proto_err_kfifo.rw_sema);
+	cxl_proto_err_kfifo.work = NULL;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_unregister_proto_err_work, "CXL");
+
+int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd)
+{
+	guard(rwsem_read)(&cxl_proto_err_kfifo.rw_sema);
+	return kfifo_get(&cxl_proto_err_kfifo.fifo, wd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_proto_err_kfifo_get, "CXL");
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 2ef820563996..6b2c87d1b5b6 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -10,6 +10,7 @@
 
 #include <linux/errno.h>
 #include <linux/types.h>
+#include <linux/workqueue_types.h>
 
 #define AER_NONFATAL			0
 #define AER_FATAL			1
@@ -53,6 +54,16 @@ struct aer_capability_regs {
 	u16 uncor_err_source;
 };
 
+/**
+ * struct cxl_proto_err_work_data - Error information used in CXL error handling
+ * @severity: AER severity
+ * @pdev: PCI device detecting the error
+ */
+struct cxl_proto_err_work_data {
+	int severity;
+	struct pci_dev *pdev;
+};
+
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
@@ -68,8 +79,14 @@ static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
 
 #ifdef CONFIG_CXL_RAS
 bool cxl_error_is_native(struct pci_dev *dev);
+int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd);
+void cxl_register_proto_err_work(struct work_struct *work);
+void cxl_unregister_proto_err_work(void);
 #else
 static inline bool cxl_error_is_native(struct pci_dev *dev) { return false; }
+static inline int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd) { return 0; }
+static inline void cxl_register_proto_err_work(struct work_struct *work) { }
+static inline void cxl_unregister_proto_err_work(void) { }
 #endif
 
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
-- 
2.34.1


