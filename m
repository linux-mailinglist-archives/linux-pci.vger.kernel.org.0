Return-Path: <linux-pci+bounces-8881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C05F90BBAD
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 22:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1521F22B24
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 20:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7C818FC93;
	Mon, 17 Jun 2024 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4wFUsUeP"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD76718F2DD;
	Mon, 17 Jun 2024 20:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654710; cv=fail; b=KQEZqOVMEEa8jCbi4kMIws1rwUEqEgrMHL365VFkFEYRF1MBgwGKMJ4grLGmVbf2GUVYymC0sKQJvKDRpf+AJMsbPbejO5pRefcqd1wC8TQOdmaz5W6ibw/NuIFTvDtyMP953/Hi6xGb9zRXr0GrSuW6mwGHFVR7MBT3hY7bm20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654710; c=relaxed/simple;
	bh=bGWHOWnYdZzpBnr1Ho0/KSj4cSY2AxW0AZjSa8HiLzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQxfSbPOdqV5LzbFnMjcCtFPvb4AZ9J06qjZuACUK1CZahjHu0Xtf0+asl+YJzapmEAcw9k9F3uy4CQ4sgqU+kgcYT//Cg2MTELA+PC+AgmW8Xtm1s8ItcT9u/4ywQIWUlT9uMUmi8f1PY55A6dARHuJuo1rdsxsvzL+817YYt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4wFUsUeP; arc=fail smtp.client-ip=40.107.212.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYi0YiiHkv3zCdAWXahIjWdsBCbm1K5b3U446CuY5OmwIPl3/IUeazr16/ZSkcR3P947Hfv8GlPXJLulBFM6DYRnmLtVB2yVrCs3Q4aGOvrk2lJG8meHiM/BwOWrBbY7an5aNjnY/SvR7NzKKV+lTcG3DBYKBNMWYTbAqPD1v467WUIonkjTvCuswxxMirlAx+m7fY6sN63BwIVUa/BJmIZx+BTvzQNIwQPtEoHQsgz+DKapeCOl/EsPqTDQjZpzlQp1SAWCj4kxszIQJ4tGDUXYrcL6vFfG8+Z4R+xn35MX5qg33Ob/YRSvmDiFVdaiy/q/LHWs66zr/rov9cQlTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xh49tAef+SQQ7oq6oMN+78JJGbyZNM8nnh0QiqIgiMs=;
 b=UN4IrlvJ8VNtu0379SJacnmhJzQBXiV1Rq1CHiSS3ee86KprkNSveE+H6nsawsTlec7BoNvinkBpNg9DuVJhqlEix566BtTNJCbVvxfivwFVv0KnRDv7mcUuoKvpUED0CQYtcS8IdvXSIQb5m9qbIGO4TaUP4hn2iz0rXb32FL6PrG4GwiXZGPaWsZ4QwgZiecKu3F7UTkmNrURrB9f38mjnMtlvs75+0oCDfV51RnltXVEt+f894hiQPF5eQaq1nrbv1LCj5P2YRqamBpk6m2V/gNvUYZ/DnX4Z+gIU9TsGldaE/e/RPQ2xOMILQOvuI2J7KiT3dcP4J1OUDZTR+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xh49tAef+SQQ7oq6oMN+78JJGbyZNM8nnh0QiqIgiMs=;
 b=4wFUsUePTWr6D8TCIrtXC3tkx66R/ZrfOWff52SLloAkXl4d3PdgS2JmvnPVx/T2c9p8q2IOGYOjbEL3O9sKvN6pIiw0HpEWd6wVH6RXu8B293nJNtv3gs158ZREFin3BawWCy36enKNJZ/tIasMsLPNMXohGZmjS73JYji8y/E=
Received: from MW4PR03CA0104.namprd03.prod.outlook.com (2603:10b6:303:b7::19)
 by DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 20:04:59 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::23) by MW4PR03CA0104.outlook.office365.com
 (2603:10b6:303:b7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 20:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 20:04:58 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 15:04:56 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <terry.bowman@amd.com>,
	<Yazen.Ghannam@amd.com>, <Robert.Richter@amd.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: [RFC PATCH 3/9] PCI/portdrv: Update portdrv with an atomic notifier for reporting AER internal errors
Date: Mon, 17 Jun 2024 15:04:05 -0500
Message-ID: <20240617200411.1426554-4-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|DS0PR12MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: a44170a4-087f-413c-cbfa-08dc8f08c380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|82310400023|36860700010|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oYjPdXbLzUKiFcskX3EkWEhXU+QEBOBXmy3M3SINpgwxQOC3nclBJUtJQuBE?=
 =?us-ascii?Q?j5TVpRQPXc32SSlDPGjJLQmgtJWOZVQmOwEgBaohg1NAYMwA9JJJUCBlIxGK?=
 =?us-ascii?Q?rbWFB8B1ZoL0x/JTQQQ/SWb/7Q2cpWEzu1QiXMO4Q4Dl9L02vQ5bQRw/kwyc?=
 =?us-ascii?Q?Ltwh3W6vgrnanKE5r9rReIzRBnkf5eD3pzRoiCTkXJ3sQPknU4S2zYSnJjLb?=
 =?us-ascii?Q?8iQY0k6IeCGD6dxDl3a7znicXrRcUiEfLmodK5d11e27fQSnKYhiSoUijVU7?=
 =?us-ascii?Q?4c2xfJ8s7zyh5y44LTV0GenTv5TPDBTIsjS/pHKqJM0nYJwavXEZOWJS88xA?=
 =?us-ascii?Q?0SzBW6qDBVdtfzcmOJbpi6tdT702hG2Nvs0aGlzk6iUHSvB3glkBUpvvOvM+?=
 =?us-ascii?Q?ZbvRTjy4oL1Upn+g3RHvdAzvAkBdmYATA2sXVdBb+6/v0Uh8uTQMAf4nXroM?=
 =?us-ascii?Q?UtMkmy35Ma1NSqAtDmA79ksedHZyhz69MWGeF4EZupgUANNpuJgylAPnaprs?=
 =?us-ascii?Q?eVu8g70W5OrZxaBPorbKiinrfXfySHC7B/LJ/n7R+N2K2nkb2nU+IqjRmmRi?=
 =?us-ascii?Q?coiqN7y78ZEFXTXeLqFgyZlxeHAMyddzfwH54OkIsnT4wuHxxlDNpbeMJSmG?=
 =?us-ascii?Q?Ph6Imua29EXqdc58klOKBb2DrjM7ae/1w3M9hWV2flqIDJu5+1yoU0cS/+3E?=
 =?us-ascii?Q?+1rgKWZi7dFeTSR0c2hpC2uY4A+JbvDW+WqCZqSmtNiHivwjvASFv/PKDiO6?=
 =?us-ascii?Q?pYH0uX5qIRB34Wrqry6j38QS53jU0+yEQrW2BJBiR5RSMVZY9bknMnsgQF6w?=
 =?us-ascii?Q?9pC06rsUG1PbuWGNWswHIvIrxt1pH013Trnfkgz+4Xxr32JO/bBP3S3d9hnJ?=
 =?us-ascii?Q?kSwUcTLatGpXySEF6I9dLNLmDT6WFNUV1dVx92OF3Hq+4d+mSfv1Cwgkq37r?=
 =?us-ascii?Q?R3UEtfkWbShwHDW8nMvNi3LAZXFMRXwvfTvNcQFLA/Kvt6nHdDyBCVpm6xa+?=
 =?us-ascii?Q?ovrGr8Jyjh5VRI6leE8QWq0NvipBHshIGdwj/4nuKwVfUq1MZ5MqGi2JX1Cc?=
 =?us-ascii?Q?UoDtB3D2J5kfg+VacMtDwJ3NjKk817pbkWFc0KqYO3ex+9K802kSiNB+xvi7?=
 =?us-ascii?Q?U089hK1gxNSvDcTzXPSse9bQn5fUdYnD2OHuFAen7xMUkHD4MaLVjDc5H4V8?=
 =?us-ascii?Q?G0y6VxMp7l2ybfFBRbkWIn72zzT+qX6w7hR2cNnFJWQFUg7tYFHipvTcX+jQ?=
 =?us-ascii?Q?oKRsv9/qdT7a5xZ1Jp4mAdkRCA439DweaUa55HFvtPYEVg0I9PRaRRfBoEWE?=
 =?us-ascii?Q?AboHHagvpMAvH3SodyfiLJVhewNnRSt+7hCjFO3uG3rSHePxG+nqlnLdzNEa?=
 =?us-ascii?Q?qSPolxqWUgtM/7Y3RFEs3k7mnZdO8zx4ziYtM9N9YSmcE7PeCHORbY8jhPdO?=
 =?us-ascii?Q?IU9Ex0diF/o=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(7416011)(82310400023)(36860700010)(1800799021)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:04:58.0713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a44170a4-087f-413c-cbfa-08dc8f08c380
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294

PCIe port devices are bound to portdrv, the PCIe port bus driver. portdrv
does not implement an AER correctable handler (CE) but does implement the
AER uncorrectable error (UCE). The UCE handler is fairly straightforward
in that it only checks for frozen error state and returns the next step
for recovery accordingly.

As a result, port devices relying on AER correctable internal errors (CIE)
and AER uncorrectable internal errors (UIE) will not be handled. Note,
the PCIe spec indicates AER CIE/UIE can be used to report implementation
specific errors.[1]

CXL root ports, CXL downstream switch ports, and CXL upstream switch ports
are examples of devices using the AER CIE/UIE for implementation specific
purposes. These CXL ports use the AER interrupt and AER CIE/UIE status to
report CXL RAS errors.[2]

Add an atomic notifier to portdrv's CE/UCE handlers. Use the atomic
notifier to report CIE/UIE errors to the registered functions. This will
require adding a CE handler and updating the existing UCE handler.

For the UCE handler, the CXL spec states UIE errors should return need
reset: "The only method of recovering from an Uncorrectable Internal Error
is reset or hardware replacement."[1]

[1] PCI6.0 - 6.2.10 Internal Errors
[2] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and
             Upstream Switch Ports

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/pcie/portdrv.c | 32 ++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h |  2 ++
 2 files changed, 34 insertions(+)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 14a4b89a3b83..86d80e0e9606 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -37,6 +37,9 @@ struct portdrv_service_data {
 	u32 service;
 };
 
+ATOMIC_NOTIFIER_HEAD(portdrv_aer_internal_err_chain);
+EXPORT_SYMBOL_GPL(portdrv_aer_internal_err_chain);
+
 /**
  * release_pcie_device - free PCI Express port service device structure
  * @dev: Port service device to release
@@ -745,11 +748,39 @@ static void pcie_portdrv_shutdown(struct pci_dev *dev)
 static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
 					pci_channel_state_t error)
 {
+	if (dev->aer_cap) {
+		u32 status;
+
+		pci_read_config_dword(dev, dev->aer_cap + PCI_ERR_UNCOR_STATUS,
+				      &status);
+
+		if (status & PCI_ERR_UNC_INTN) {
+			atomic_notifier_call_chain(&portdrv_aer_internal_err_chain,
+						   AER_FATAL, (void *)dev);
+			return PCI_ERS_RESULT_NEED_RESET;
+		}
+	}
+
 	if (error == pci_channel_io_frozen)
 		return PCI_ERS_RESULT_NEED_RESET;
 	return PCI_ERS_RESULT_CAN_RECOVER;
 }
 
+static void pcie_portdrv_cor_error_detected(struct pci_dev *dev)
+{
+	u32 status;
+
+	if (!dev->aer_cap)
+		return;
+
+	pci_read_config_dword(dev, dev->aer_cap + PCI_ERR_COR_STATUS,
+			      &status);
+
+	if (status & PCI_ERR_COR_INTERNAL)
+		atomic_notifier_call_chain(&portdrv_aer_internal_err_chain,
+					   AER_CORRECTABLE, (void *)dev);
+}
+
 static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
 {
 	size_t off = offsetof(struct pcie_port_service_driver, slot_reset);
@@ -780,6 +811,7 @@ static const struct pci_device_id port_pci_ids[] = {
 
 static const struct pci_error_handlers pcie_portdrv_err_handler = {
 	.error_detected = pcie_portdrv_error_detected,
+	.cor_error_detected = pcie_portdrv_cor_error_detected,
 	.slot_reset = pcie_portdrv_slot_reset,
 	.mmio_enabled = pcie_portdrv_mmio_enabled,
 };
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 12c89ea0313b..8a39197f0203 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -121,4 +121,6 @@ static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
 #endif /* !CONFIG_PCIE_PME */
 
 struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
+
+extern struct atomic_notifier_head portdrv_aer_internal_err_chain;
 #endif /* _PORTDRV_H_ */
-- 
2.34.1


