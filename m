Return-Path: <linux-pci+bounces-30865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C764AAEA9F3
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2359B4A2825
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6D925178F;
	Thu, 26 Jun 2025 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZbGdTCNM"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B452512DD;
	Thu, 26 Jun 2025 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977973; cv=fail; b=PCUKDQGw+dUq1GzptndQ1XzsieWSLn8/f86KrqUjKlgOITj8KB53kVaT0NwLs3rKzxvw2eLizn9KI7pTfdPAaQ5D5XDe9u9XOaEatjA4I5YZnVh109PfLxt8TCQYXcRDRjWOPwoXKlFyRB7jow9hRGk2VcclShrtMt9vNNWXLDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977973; c=relaxed/simple;
	bh=mmninfW6VOFt64e9MlFJX9pSXhLGJjUYoK49E+sfmkQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iLYFxw5Y1Jk7W9Jnhfno/cRlnpnCu8fX2J/gs7pP+MVBEwb+21VFSVhRSQx6DZsvTQoTzf+7SN5rnaFNZ4DS54br3PIBepdOwkdAr+sgqQyp0O4wJfZXyGVkELeF6SLPcvg8chvVJigL7QEXdhQ/ysmX3W+bUfC0QSccWc6zZfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZbGdTCNM; arc=fail smtp.client-ip=40.107.101.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApYinTsq+3gnPxKx6Ovi79sY/8wt83awHGsr3QwZhRT/os8ka0vnLH5CzmdRj4WWJMm6SITiRFPYmTuXop0hft1TkouibOI2ryQWj2wsnkHUSfLjxj3mWDvFG00djSpbBFkqlvtOE6gJU4MbR0yz8Wwgmes4FuJdgEzfF1VixO65gK8DlPwa8sFnl7jYjNcrjAPS3IGlxTuynRE9oyc0Jht3fgUhPlWFYnaRz8Bh7abp5Z+tEM1eIgmfZrZccmNs5ORps+0+kN6S33H7p6uP3y5c0jpdQeOpJ1TYs/28NVBdc618RpNBULsRNd30+FqpTEgeSupV58neB9LAdo5QXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnu07Kkw2exdErqWk0occ44ayTZ/PKyzSWsfTNYsRn0=;
 b=DoUdK+XJN5cGwRLKKTphElwuW9KRIa2Q/5bOS2QusfOa6KbMBhk+VzorcTjhxIXUMiNXKH+Vaobim3sZOaLeWAhBstQ4wRDy3RECAYBatZLPRIvmjlYEHVhzBNhGWSxbRiYYLUjHmAUzRvTkTlsnj0pM692DXXzH8mwmIz5H87O3DoAGSh0vR2gHTLtkbVYBYjfo6cuhiHQ2ZWPth32+bC8StsOoxQLc5H/ty5/TAw9CjKKjRCF1A2sTkHs3gAnqJao2hx9C/qEbZgTIWc5rLliOK/nqkNDwg5kU2O8pTKGllAySEFw/hote9qIm+CXHPXtWpqK89il982h4TZ3bsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnu07Kkw2exdErqWk0occ44ayTZ/PKyzSWsfTNYsRn0=;
 b=ZbGdTCNMpjTFlzSumSJv61uSx9ZIEax2VcfTokFkOrppzTdmqIQPiWvpJKEUoldlG9UO2TfeDHRr+tZXexcl35DYE3hK88hpXOjgg5tIrp/EmtYgWv5Sz3tRp1/ksMTa02Hn7gxXMREmauaPNe8u7C2az6ACe1rWpGPqK0ACzJM=
Received: from CH0P221CA0032.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::11)
 by LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Thu, 26 Jun
 2025 22:46:08 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::15) by CH0P221CA0032.outlook.office365.com
 (2603:10b6:610:11d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Thu,
 26 Jun 2025 22:46:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 22:46:07 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 17:46:07 -0500
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
Subject: [PATCH v10 17/17] CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup
Date: Thu, 26 Jun 2025 17:42:52 -0500
Message-ID: <20250626224252.1415009-18-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|LV5PR12MB9779:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc80ebc-3319-4cf4-df90-08ddb5033da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gSlsSJjTd3jtb2+W1cRJLYlC8FuT0aZTPHp63Y1UmrKVencgRiW7pUt2eiMN?=
 =?us-ascii?Q?ZpD+OTHH06poEWKMO7ecS0SJeQgHatkGYRF7bkzlHkpmbwiI12PI3VgNBGI/?=
 =?us-ascii?Q?RCYCQTSqpsNmb9v9Z3YV3pZHJghFSnKbQzHxL3Dc0EmgXTtaAOX8MBsOWh/1?=
 =?us-ascii?Q?JgikP8y/nEN3A/StUw795OSHZ2xaMU3P+i88eUHTwyP+VJ6GEYU/cC7+yHIB?=
 =?us-ascii?Q?AkyKuOpynHHvjKrVER45tkAOB3uiy2YPrHLM8uuzRPsMHNCO3UCCxmvMG0gv?=
 =?us-ascii?Q?hdpUb1eUOljXO6bcR1zY9ECUuDBoFk4QV3wDAx4Y6CgYDFchWAo4hlt2QGHP?=
 =?us-ascii?Q?g4Ik0lGGxfJy1lLjDXEDgzJuSZ8OSWvXVDghZ5QtxRv/4hQMQPTp1t8z3x0y?=
 =?us-ascii?Q?qOmXTyKEI86SEBkg/5mCDIE70064RBv1JOXUWbTSMCMhUKnuNVAAUZFNVb3u?=
 =?us-ascii?Q?zdb91UrQina6+SaMfiYcA2WrqXIQvQG8FDic4BxHHaruvZ4N5/Dk0xDATaRQ?=
 =?us-ascii?Q?6vzcLpKOi+eQP/V+n3lQE7mmLqA4n7qfjjEUcJeSsbI8OPnX3U5hnRVEDvJM?=
 =?us-ascii?Q?DIwDkmYYm1Zb0/plZHFxtOIetERNFiF7xILhzv7FW42kXm3ajNLJWlwJD7/l?=
 =?us-ascii?Q?dTQaxDhJiQ2pwNRH4+Jo5HaS8tXVx2dYGh02K+nF1YX0rwLXzaxXS++JMW3g?=
 =?us-ascii?Q?bOoe6XAXnc6tYIOCzvN01zhcD6h5KrDkQY5FQsLH3tAKnXZGNGzosebQRHVV?=
 =?us-ascii?Q?cHEY18y3Nd2ErRYEwznW8NT2gohHNzUBbg3jseh5tFIC8k5gznVFp6O8Jsab?=
 =?us-ascii?Q?52Fb8TyPIJa07gCEDvFic65tu3ihyE1yxvSo78Oet9+HfQr2o+KwSu5Shizm?=
 =?us-ascii?Q?MeclsMfa6C+6HY9evj5dIgwvpiqh/iZ7NAWLdyBpvUKqGxYYSG/o+Jsrw/ov?=
 =?us-ascii?Q?xW9lMpSo4LM+O1I4vwQ+DD5lvtswM4u6S8zSZMICW48Oxs4a3GpXc3ZwN+7G?=
 =?us-ascii?Q?9lgk5WVaJ6T0etxF3AZfXr+AZ6lIjS4uliE9/oUd592JeCvI5QScSI/nAnkI?=
 =?us-ascii?Q?BMg2AZwGzHNPmxvQuVAnnKvk6DuzOCgOr0hgwZdphTqAPPh1XxcYLrh+BX5v?=
 =?us-ascii?Q?u0cNWfSkPRt1nAebwoOIZvllmv0aVJVm0zPho5awXb9k8W6S6vtruO7GH1K8?=
 =?us-ascii?Q?gWPxwHn2VycsyXsyZKYNK44fASnG4PcUz884T7sU+eEPS/KdbfKG/tiC1llY?=
 =?us-ascii?Q?iYVNv8+2hURb6kCPVMgCvswhz/xpKQX4WlmsTk4EV5Aj6C+iWyqX5Op/lsJd?=
 =?us-ascii?Q?SR20tnzO6kbGjqZ16Qlff2CAZpjpf2C2vn95o/V1d5lTNGqEjepS2SpTOHNE?=
 =?us-ascii?Q?31WlakcYiviKpe9BTpjkpJkFMW4gplpkAbNhw5j6rbFzuvha5hIULvbrIIdO?=
 =?us-ascii?Q?0+y7UUGbeuOOLrDEJxZ/UUHHfvOPQdd1ceJCkijUIdlCfQSZjnQoajACtoAD?=
 =?us-ascii?Q?MTH2yO156VbCK41SYIPvnbCzeAoXoCBQb7G49f3XZ8nqokiEvMET2jnS7w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 22:46:07.9746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc80ebc-3319-4cf4-df90-08ddb5033da5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9779

During CXL device cleanup the CXL PCIe Port device interrupts remain
enabled. This potentially allows unnecessary interrupt processing on
behalf of the CXL errors while the device is destroyed.

Disable CXL protocol errors by setting the CXL devices' AER mask register.

Introduce pci_aer_mask_internal_errors() similar to pci_aer_unmask_internal_errors().

Introduce cxl_mask_proto_interrupts() to call pci_aer_mask_internal_errors().
Add calls to cxl_mask_proto_interrupts() within CXL Port teardown for CXL
Root Ports, CXL Downstream Switch Ports, CXL Upstream Switch Ports, and CXL
Endpoints. Follow the same "bottom-up" approach used during CXL Port
teardown.

Implement cxl_mask_proto_interrupts() in a header file to avoid introducing
Kconfig ifdefs in cxl/core/port.c.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 drivers/cxl/core/native_ras.c |  9 +++++++++
 drivers/cxl/core/port.c       |  6 ++++++
 drivers/cxl/cxl.h             |  3 +++
 drivers/pci/pcie/cxl_aer.c    | 21 +++++++++++++++++++++
 include/linux/aer.h           |  1 +
 5 files changed, 40 insertions(+)

diff --git a/drivers/cxl/core/native_ras.c b/drivers/cxl/core/native_ras.c
index c7f9a237a1a2..8b8c7b3fba6c 100644
--- a/drivers/cxl/core/native_ras.c
+++ b/drivers/cxl/core/native_ras.c
@@ -9,6 +9,15 @@
 #include <cxlpci.h>
 #include <core/core.h>
 
+void cxl_mask_proto_interrupts(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	guard(device)(dev);
+
+	pci_aer_mask_internal_errors(pdev);
+}
+
 int match_uport(struct device *dev, const void *data)
 {
 	const struct device *uport_dev = data;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index c76a1289e24e..786a036d33cc 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1433,6 +1433,9 @@ EXPORT_SYMBOL_NS_GPL(cxl_endpoint_autoremove, "CXL");
  */
 static void delete_switch_port(struct cxl_port *port)
 {
+	cxl_mask_proto_interrupts(port->uport_dev);
+	cxl_mask_proto_interrupts(port->parent_dport->dport_dev);
+
 	devm_release_action(port->dev.parent, cxl_unlink_parent_dport, port);
 	devm_release_action(port->dev.parent, cxl_unlink_uport, port);
 	devm_release_action(port->dev.parent, unregister_port, port);
@@ -1446,6 +1449,7 @@ static void reap_dports(struct cxl_port *port)
 	device_lock_assert(&port->dev);
 
 	xa_for_each(&port->dports, index, dport) {
+		cxl_mask_proto_interrupts(dport->dport_dev);
 		devm_release_action(&port->dev, cxl_dport_unlink, dport);
 		devm_release_action(&port->dev, cxl_dport_remove, dport);
 		devm_kfree(&port->dev, dport);
@@ -1476,6 +1480,8 @@ static void cxl_detach_ep(void *data)
 {
 	struct cxl_memdev *cxlmd = data;
 
+	cxl_mask_proto_interrupts(cxlmd->cxlds->dev);
+
 	for (int i = cxlmd->depth - 1; i >= 1; i--) {
 		struct cxl_port *port, *parent_port;
 		struct detach_ctx ctx = {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 19eb33a7de6a..95843428be92 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -12,6 +12,7 @@
 #include <linux/node.h>
 #include <linux/io.h>
 #include <linux/pci.h>
+#include <linux/aer.h>
 
 extern const struct nvdimm_security_ops *cxl_security_ops;
 
@@ -771,9 +772,11 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 #ifdef CONFIG_PCIEAER_CXL
 void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
 void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
+void cxl_mask_proto_interrupts(struct device *dev);
 #else
 static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
 						struct device *host) { }
+static inline void cxl_mask_proto_interrupts(struct device *dev) { }
 #endif
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
diff --git a/drivers/pci/pcie/cxl_aer.c b/drivers/pci/pcie/cxl_aer.c
index 3c5bf162607c..bd6660eab87b 100644
--- a/drivers/pci/pcie/cxl_aer.c
+++ b/drivers/pci/pcie/cxl_aer.c
@@ -33,6 +33,27 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
 
+/**
+ * pci_aer_mask_internal_errors - mask internal errors
+ * @dev: pointer to the pcie_dev data structure
+ *
+ * Masks internal errors in the Uncorrectable and Correctable Error
+ * Mask registers.
+ *
+ * Note: AER must be enabled and supported by the device which must be
+ * checked in advance, e.g. with pcie_aer_is_native().
+ */
+void pci_aer_mask_internal_errors(struct pci_dev *dev)
+{
+	int aer = dev->aer_cap;
+
+	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
+				       0, PCI_ERR_UNC_INTN);
+	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_COR_MASK,
+				       0, PCI_ERR_COR_INTERNAL);
+}
+EXPORT_SYMBOL_NS_GPL(pci_aer_mask_internal_errors, "CXL");
+
 static bool is_cxl_mem_dev(struct pci_dev *dev)
 {
 	/*
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 8fb1eca97c37..c0fd627328ae 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -114,5 +114,6 @@ int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		       int severity, struct aer_capability_regs *aer_regs);
 void pci_aer_unmask_internal_errors(struct pci_dev *dev);
+void pci_aer_mask_internal_errors(struct pci_dev *dev);
 #endif //_AER_H_
 
-- 
2.34.1


