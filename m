Return-Path: <linux-pci+bounces-28902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 730F1ACCC35
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6A2189A0CD
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760141E833C;
	Tue,  3 Jun 2025 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X/UR5vvg"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5DC1D7E54;
	Tue,  3 Jun 2025 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971545; cv=fail; b=l9sYGeQBYOg1Yz+oMIyLQk0zOpyTDfa4iuVZY3g7wPzgFn+a62c5zGn+PcKRFbM4/jzY+r+lrfBmK0ZvIXM8iL3JBDbwOtaWb7QZ+9ls/qcXdpGFlMFYoQ+SBO35j1hXZEifr0cDCr/SkpLKqjm8MP7tEAvfRMcgj1NNpi42AEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971545; c=relaxed/simple;
	bh=LPden8JADMhQgRRuZMkuW0Uh/k9Q0fRp985UEiUtOQQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQWgM9wvK51rNXEXxCTr295ejKeA/0GBQU9dcFP1z4PwmpOMA4pPPjTZBBcFl6Uo6TzW3hR1eW2BCZXnVMGiKr7p6Yhzlf90JfYE4POs8RjQ6Qk0rvTBOA8yfU5sGco8MrfPMTF1GSnRyz2jHGTEr5hT+nRS8VgzylAMFdY/kms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X/UR5vvg; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6k2PhJOOQ60fAJhYx4DyqmvaM8SwPxogOSzB8BLkHrPr6almtzA8FrfOdtLPZLDO7cFxlr43q36r7wqP0Aau1kupJXmT6JmCZSra8KJfwKU5yiHyZFkOh6+jSTtLV1chibkT5JfqGrb97P4prLIhQCHCOId/fTeH4HafvixGxEoRzXCE5o2dYFCqmVXh1t2puS6t+WOOZvHRTmkAKuB1dPnrKhgjrI7c4KU9dy2N+BYGfdE+SC+s2vFcbt8s/h2cdWxCTancBi7p+pFQuwP5Waj57Wdn6127Q6U/8UlvRKH2sIIjydWrJ6QHx0a2PHF2P6EYQ05C5Iq4UjlWr9UaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNMgicyjTK7CCJPhBNHC/eIeexxphbwly0hlkdN1lIE=;
 b=e6YYm6yr5V2dgJGCmVlwKEOpxgtF9qW094b2e8WUicDgSUGY4bvh6rxCEe4Fq8ZRPKwASIgpHq1vVI1GQzEjtyqTrqDI6Ilcirs2XT78xZgaAZzxc4uMPPDiUx6hJmE8SOrYJBy6p8+g3valJWOHXZAF9n9t8t8w4xkY6aj/Qtejn2Fk1SoDk6BBP0qam0QN7HTQc2eMzBlm2kTziZdiF6eRZMNGGg9QbsxXFJJXBNx+dASoGR9mNpwS9N1MoXEwxSr/2kzNalLLhiCvVDZJbqw71DXPR5zm/cBVjGY7vhZ9A2WOPeNOnyWnJDOFWBL+siiES/Xyg5hE9ZCMXGVd0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNMgicyjTK7CCJPhBNHC/eIeexxphbwly0hlkdN1lIE=;
 b=X/UR5vvgpaObKS6ji0dw8wBCBeWRT3RxGKUlteP+GEEuqKAnoIDdaR18So5inWpYfDFdcvWvsZQq3VmZS9DttIUqpZkUZyix3P0Lw8+Je2EFVUwfulyyUSAvEzFeS2KCdw2CAqv6CZCWLq9vWaO+Eg6VGU0S2lRuWZ2pQmVZtFk=
Received: from BN9P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::17)
 by DM4PR12MB6040.namprd12.prod.outlook.com (2603:10b6:8:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 17:25:36 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::a8) by BN9P223CA0012.outlook.office365.com
 (2603:10b6:408:10b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.24 via Frontend Transport; Tue,
 3 Jun 2025 17:25:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 17:25:36 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 12:25:34 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <PradeepVineshReddy.Kodamati@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<bp@alien8.de>, <ming.li@zohomail.com>, <shiju.jose@huawei.com>,
	<dan.carpenter@linaro.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<kobayashi.da-06@fujitsu.com>, <terry.bowman@amd.com>, <yanfei.xu@intel.com>,
	<rrichter@amd.com>, <peterz@infradead.org>, <colyli@suse.de>,
	<uaisheng.ye@intel.com>, <fabio.m.de.francesco@linux.intel.com>,
	<ilpo.jarvinen@linux.intel.com>, <yazen.ghannam@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v9 15/16] CXL/PCI: Enable CXL protocol errors during CXL Port probe
Date: Tue, 3 Jun 2025 12:22:38 -0500
Message-ID: <20250603172239.159260-16-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250603172239.159260-1-terry.bowman@amd.com>
References: <20250603172239.159260-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DM4PR12MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e3248e-3ba9-443f-fea0-08dda2c3a71e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J81qCrD0gyOrmhqiYVbbMsvy1B+RWhOe7q4cR7+PFjTYV28lclGIF1Q7cQlw?=
 =?us-ascii?Q?VzgVKtjVTdl2tuYgp/FMiWNLrQ6JWgsZF4l9+bq8TrB0iiaUARiR2BoPUcPq?=
 =?us-ascii?Q?eBLprEkYgPIOzMIVW8YYlFfb+diM/ZrrlXE+9twIbrVLm/aL+TQt7CKGnh4X?=
 =?us-ascii?Q?XXZOWSCPwOFsDjVIZN7nc6+QEqdSyEoqGCOIJf3kfk3/CZfMA73/Iyh0Ca19?=
 =?us-ascii?Q?goQqkUq237TbPwsH8cJsKLZF1ltGDah1IwiU24+P/DHhbqpHfjKuSe83IexM?=
 =?us-ascii?Q?5lsh03YKKcqpk7Jp+1iMqHX9gqWQ8rwnplTiXy8BIQm6SFp9R0cwamX0aRFB?=
 =?us-ascii?Q?ou0zp3wkH1UnJPb/owjAIoXWWA/BQG3o1NSpm7eo9EJnDreDrgFvJMww/qT5?=
 =?us-ascii?Q?W7Qmp3iQVmu1uCwDbryCs+oEwfnQJnkVnKKhpwWYk07GQHErH8PYNE6czA7i?=
 =?us-ascii?Q?FKyNGgepN0ZzhdmO0AfVAf2AgMI/TYB4YkuAEUHmPfRkbvFu5wtKS2YPlJwh?=
 =?us-ascii?Q?izb4Ufzw7tJHOvPXBjraEMH6NIiyYVqX48mlsFOAGdD2TrEbMrk4DjPRSMwn?=
 =?us-ascii?Q?fQPge617eXGBqYl8AY9rYINROi3eDff8XUu7pJgDc16XeZreLimqDwfISMiq?=
 =?us-ascii?Q?RzSIyaUISi7/tJENjenmEsPS08gbCz/Dfr5GbdPTIvwE9UpXcF5gw7i9KyPe?=
 =?us-ascii?Q?Le/HxulVwSWJLa+bC0qef9HBntuZAe4cqGJjYcBSAcotMD/mHCuNuavBCMoO?=
 =?us-ascii?Q?mGSuD1eijsFEXRBXHbYsIaB44dzyllTMLLg6OvBbx9E4eYI1mqUUM3odtXpQ?=
 =?us-ascii?Q?lOjjP8grlQMNmjU8nYx6Q/M8SDhgq09nvDpwKNTlkXdK9NKOGoEHx+AkvIZq?=
 =?us-ascii?Q?w8JSBxCKslu0dKIJmDwSFPyuvY+ZnRl8pSeox0/75IBN4Gp3CHfJ4+rZpQPg?=
 =?us-ascii?Q?UtxwuKAwWeq+NcDMBWx5E0wlT+93yCuvADSpm/s2UvJM+yLwTJfncPAYRHXo?=
 =?us-ascii?Q?TEsGWhkXag2Wu2FQB3/G9Bm6OBY83C/lhth2IWpTfQ0eLDrD6rMN+wshVJV7?=
 =?us-ascii?Q?qb/AJ4fykkXMKfiGMYBrl3GF5EruSHVwYUIu6dB7SedCSpOuTL3il5kSpkvv?=
 =?us-ascii?Q?UkJqnBP0Rs8XGsPy5SvwnC8+fzOp/A4pSRRXxEI3NE5JHaLP00U2Y1qw2f5T?=
 =?us-ascii?Q?KRoILtgZQbibT5WVV0QrsA8UOaMfsvTtcWgMkdZZd5UPp0XtQoiEAVb4xlmI?=
 =?us-ascii?Q?HLl1yJFQC7I6Sr8OXG5scpePDyvp0bL/9nRWbuozkcq/aJXtzT5aNCoqyM/j?=
 =?us-ascii?Q?Ocs1FJYSCyqL8qfg5BE8jq6SOJMQDcwE+5Xz27wE8xCmd74DR1tzPmt70BBs?=
 =?us-ascii?Q?pORXwurgRvwfO/6M960LIM7TCaKv13ZjtmS+AA+bh4hduvWwG1Lpoz3qKROs?=
 =?us-ascii?Q?4l3LZKsZHl0i8yrptfWE/ZKEvQnOPBxdQB8HfUK/CIcQnCYWWwTiggZL4YSu?=
 =?us-ascii?Q?1z92R3EV4F430pYtrzahQs3W9petjDiGMGJjtEW+GJk8KAlS+nCidNeJeQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:25:36.2174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e3248e-3ba9-443f-fea0-08dda2c3a71e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6040

CXL protocol errors are not enabled for all CXL devices after boot. These
must be enabled inorder to process CXL protocol errors.

Export the AER service driver's pci_aer_unmask_internal_errors().

Introduce cxl_unmask_prot_interrupts() to call pci_aer_unmask_internal_errors().
pci_aer_unmask_internal_errors() expects the pdev->aer_cap is initialized.
But, dev->aer_cap is not initialized for CXL Upstream Switch Ports and CXL
Downstream Switch Ports. Initialize the dev->aer_cap if necessary. Enable AER
correctable internal errors and uncorrectable internal errors for all CXL
devices.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/port.c     | 29 +++++++++++++++++++++++++++--
 drivers/pci/pcie/aer.c |  3 ++-
 include/linux/aer.h    |  1 +
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 0f7c4010ba58..3687848ae772 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -3,6 +3,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
 
 #include "cxlmem.h"
 #include "cxlpci.h"
@@ -60,6 +61,21 @@ static int discover_region(struct device *dev, void *unused)
 
 #ifdef CONFIG_PCIEAER_CXL
 
+static void cxl_unmask_prot_interrupts(struct device *dev)
+{
+	struct pci_dev *pdev __free(pci_dev_put) =
+		pci_dev_get(to_pci_dev(dev));
+
+	if (!pdev->aer_cap) {
+		pdev->aer_cap = pci_find_ext_capability(pdev,
+							PCI_EXT_CAP_ID_ERR);
+		if (!pdev->aer_cap)
+			return;
+	}
+
+	pci_aer_unmask_internal_errors(pdev);
+}
+
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
 {
 	resource_size_t aer_phys;
@@ -118,8 +134,12 @@ static void cxl_uport_init_ras_reporting(struct cxl_port *port,
 
 	map->host = host;
 	if (cxl_map_component_regs(map, &port->uport_regs,
-				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
 		dev_dbg(&port->dev, "Failed to map RAS capability\n");
+		return;
+	}
+
+	cxl_unmask_prot_interrupts(port->uport_dev);
 }
 
 /**
@@ -144,9 +164,12 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 	}
 
 	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
-				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
 		dev_dbg(dport->dport_dev, "Failed to map RAS capability\n");
+		return;
+	}
 
+	cxl_unmask_prot_interrupts(dport->dport_dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
@@ -177,6 +200,8 @@ static void cxl_endpoint_port_init_ras(struct cxl_port *port)
 	}
 
 	cxl_dport_init_ras_reporting(dport, &cxlmd->dev);
+
+	cxl_unmask_prot_interrupts(cxlmd->cxlds->dev);
 }
 
 #else
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 5efe5a718960..2d202ad1453a 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -964,7 +964,7 @@ static bool find_source_device(struct pci_dev *parent,
  * Note: AER must be enabled and supported by the device which must be
  * checked in advance, e.g. with pcie_aer_is_native().
  */
-static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
+void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
 	u32 mask;
@@ -977,6 +977,7 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 	mask &= ~PCI_ERR_COR_INTERNAL;
 	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
 }
+EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
 
 static bool is_cxl_mem_dev(struct pci_dev *dev)
 {
diff --git a/include/linux/aer.h b/include/linux/aer.h
index c9a18eca16f8..74600e75705f 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -107,5 +107,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		       int severity, struct aer_capability_regs *aer_regs);
+void pci_aer_unmask_internal_errors(struct pci_dev *dev);
 #endif //_AER_H_
 
-- 
2.34.1


