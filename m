Return-Path: <linux-pci+bounces-14017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3A89959FD
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 00:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5A21F22608
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 22:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2C621645A;
	Tue,  8 Oct 2024 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DWoZWGwl"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013E121503B;
	Tue,  8 Oct 2024 22:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425963; cv=fail; b=uaqWCzU3xPL463tS3iobfw+I7+Upd+sgNouKSa/pjzVCVF+GmOctEZX3nYB4Tq1B5CQHeVGJsCMu4duZMyrNxYzlyEg9YN/ATQTIxZMc+hYwOTLunmMdkJCkHtZQum9IFGArNmhZs9IAxAPjn9VwddvMP1Xpf40qtUiI/fZ5M3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425963; c=relaxed/simple;
	bh=GINvX/OHL84YEe4kS7yrZoMXhd5D0jOEt5jDC/9Ml/M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jNZeSwP7/j2WwGek15AwV+gSa3C55mEfOqm+DShLuhawOmSgsti1OFvy8aSDUcM3+q9gbNTpwfS3qL2RCwzAcCxwEDEdysqX9pDfnvqi78wHJE/nHVk4D/9YcJydASlyEcT6lBC6Le0eSF4KA87RnO2M9V4bXllnMWq5qXxL63U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DWoZWGwl; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFKDY/dFGyRQZ+leCVbtEZnA5roK8JrmydzhPmzJYA87P0QqOYbDvURV7IkPyMiHC3rxJ8KLk75SszR8LSFmLLloWzbJlPNt+9IU/7sZMfT/Frpx7tkqwaYgY4uByrAAUfl4MuTpB/2ch+89iqQ/uoY8YXkueqFuejqQ+/I5pETTfUUb3MHub0Irp8p6uzcpwv36JBktCwYuSKBcKsoHhPA/SjSXyGeaAj6tYDIsUyWmKJm36BlHApkthDPktx1xVtsPcjmPLkYmrprqtTc71LBPr1xCpmcKb/qh13xnKFTwv6iFNYbh08RihgILLBU8VzOIJVAw9z1P0+kvllnzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyYdsHelXD/nU7DKZRelNExa46da8MbLvFPrf/G15TQ=;
 b=Uz5JiOeqBjwS9yOwdjGNqzJW/BggPJfKZpsjk2FUWvKyXCe1VK7RCIfgf3NjTU7lHJVmjCkCVZMzv8TEsNzQ7ZNpV7+ybRQr8qbnqk+MsA+ZIMajnflFU872v/wI6n3hK8bw/eD42WjwOXrfumMmnEjl541xvmYgFAAhyKetO8hz9ey1aQLDTpjOvto+xS+gu6Xq52SPGGB1v551CZPDKXFror2mc14kRme5w1BFqtXWEYsa5wYYCdEXrbPACR/X8NaMEBDRaYQhWMHc77ojTqLSIfIESEsoG7LJ+eh9wkpOKDCz/KeSpKmRNnVfgbobE0dLOPcfPItKmO9ee77qGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyYdsHelXD/nU7DKZRelNExa46da8MbLvFPrf/G15TQ=;
 b=DWoZWGwlyjl3Y39hGgxyAvsmOWNtIB/6kpGDEqaYb1tnueM1caopvH6porglPUAsoIgh0SVctrV1xQOWUGeGsuRN80EyHj5WMpEt3aDhXENoONWZBMpUF1XwtqmyI2Ac2PZYzvn7grl8FNj6LrNspkEO4Fn+vW7Nr7VSBgC0D9s=
Received: from BLAPR03CA0085.namprd03.prod.outlook.com (2603:10b6:208:329::30)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 22:19:18 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::d8) by BLAPR03CA0085.outlook.office365.com
 (2603:10b6:208:329::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 22:19:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 22:19:17 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 17:19:16 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <smita.koralahallichannabasappa@amd.com>,
	<terry.bowman@amd.com>
Subject: [PATCH 12/15] cxl/pci: Add error handler for CXL PCIe port RAS errors
Date: Tue, 8 Oct 2024 17:16:54 -0500
Message-ID: <20241008221657.1130181-13-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|BY5PR12MB4084:EE_
X-MS-Office365-Filtering-Correlation-Id: 29edf4d0-e21d-4360-a11e-08dce7e73fd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sGFna7S+qN0f4pLFP/AQs776cXUZQPYWYoWCv3OPz1CkLjuemzNAAGD/3ArD?=
 =?us-ascii?Q?AaLlcqZorWWACxEl05AthGMERoDEUIVEisj6DwSxIgEn7ALPW+oC5gmjwGNU?=
 =?us-ascii?Q?ZmfCJsoMwkzfi5tpI0hz4RU1HMuwVp2cXvuZ/mjP4DN/ikbtmSL37Gb2AVNM?=
 =?us-ascii?Q?3qvMgSXy/hy232MX7tz8OKBIZ9Zaq/0s0RHo3KXpAZjr9Uz4OyWDs7lMiVgz?=
 =?us-ascii?Q?pOOY9I2+EEpbQlqkrlfDiR2bib+tSG/hfQu+/xYEM8swDvhIfweIQPGtN7EE?=
 =?us-ascii?Q?V9XiZrUahA5/WjOA60ocOoRT6QXjq+biJBpykV5maWtHFGXJgb4C0i+M0fZQ?=
 =?us-ascii?Q?wJRjzk3N3iSIHyDtR3MP0ePdR2uhdqQyiCFP8dPT0nWnAGHMPC6rjNQVsSzr?=
 =?us-ascii?Q?p2AxVb8l2uPuMj8kea5rn3Yorw99yrTTc5mjIMWYdXr9yIf4K8D9gHrhhukq?=
 =?us-ascii?Q?O93NtFByi1NEv9AeQEOtLgdRUBiRl0u1m4pp/K0GodVJnqlVC22KcPeFn5QL?=
 =?us-ascii?Q?aZzHBSvfkIEztqWTMu3hiuwthE2vO5woF5/yk1VXalk5KxMVnlVegpiU6iTB?=
 =?us-ascii?Q?9BadPv4mzxv/5vU3Taqd17wWrDP2RqfWpAH4eBYCYvu43TGJ5F9uzaeh3/1a?=
 =?us-ascii?Q?MLWen64FanGRrYRdt6eaU6/ekdLa/1xWf6g7+nNbMJ8OGk7PQ64C3egxsQD1?=
 =?us-ascii?Q?bQnz+leEbYubECn+AyNxzG0/qGIVSersUWZIVo62Eh2HmIxeFacbtrxOQfvM?=
 =?us-ascii?Q?Cf050eUsxHQ8SueiXem6/5tpVD5zvz974L9OXl6jnXNJDrKUjY5tagQhULtd?=
 =?us-ascii?Q?TTSAlrywfmqpi4v61Ei2feZ4VhA6TQJOY8RjY0K6RfB9XoCeCV4WH2SFHAhq?=
 =?us-ascii?Q?wjUXgaU5T0/r3Syif7bK6Qy2qYVDX/2GmKBFsznuRiGSQhRo5b0qg9KyT7EF?=
 =?us-ascii?Q?u3o6m8HJ5VpdiAOjqjtkvHkAfYa38BgL3rhOfpBwdDQzEwuwfWritbdPt6bV?=
 =?us-ascii?Q?u+h/oOLHMGZU+Q1982nPJaaMWPG5By4QlFFTsPbyEtO5FVimy+H+m4uBoVrw?=
 =?us-ascii?Q?kVNNWcmZwnA4GaSzflOxCDNwNHk6qD3q0rH4ifPnm22oOQSdPXhLT0B8G30A?=
 =?us-ascii?Q?jecTUe3p+KprIuEjiCpC8gZcqreCQwFQHFuPaFxLg7KLEvLOAyWBqqgfgKOt?=
 =?us-ascii?Q?J10CSIjyG5PD2D9xnfZuX4C6dbjFats8OIHYCvWfwaCQdHhjX5kJP1Gq4Cma?=
 =?us-ascii?Q?B/qjoemADyZ7eTlvjXPayg/oLwFqlN6mHK5GLreQJMG7CbbvBehnSBHKxjy3?=
 =?us-ascii?Q?QVMaKDfNm23A6jTDMerTqMGtIsQ/6G6rA0r2Q3eOkbvHoPk5ny2XuggGN/wq?=
 =?us-ascii?Q?Lp+xPJYYKkZm4rMKfnAZNpUitkJr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:19:17.3675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29edf4d0-e21d-4360-a11e-08dce7e73fd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084

The CXL drivers do not contain error handlers for CXL PCIe port
device protocol errors. These are needed in order to handle and log
RAS protocol errors.

Add CXL PCIe port protocol error handlers to the CXL driver.

Provide access to RAS registers for the specific CXL PCIe port types:
root port, upstream switch port, and downstream switch port.

Also, register and unregister the CXL PCIe port error handlers with
the AER service driver using register_cxl_port_err_hndlrs() and
unregister_cxl_port_err_hndlrs(). Invoke the registration from
cxl_pci_driver_init() and the unregistration from cxl_pci_driver_exit().

[1] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and
             Upstream Switch Ports

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 83 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h      |  5 +++
 drivers/cxl/pci.c      |  8 ++++
 3 files changed, 96 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c3c82c051d73..7e3770f7a955 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -815,6 +815,89 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 	}
 }
 
+static int match_uport(struct device *dev, const void *data)
+{
+	struct device *uport_dev = (struct device *)data;
+	struct cxl_port *port;
+
+	if (!is_cxl_port(dev))
+		return 0;
+
+	port = to_cxl_port(dev);
+
+	return port->uport_dev == uport_dev;
+}
+
+static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev)
+{
+	void __iomem *ras_base;
+	struct cxl_port *port;
+
+	if (!pdev)
+		return NULL;
+
+	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
+	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
+		struct cxl_dport *dport;
+
+		port = find_cxl_port(&pdev->dev, &dport);
+		ras_base = dport ? dport->regs.ras : NULL;
+		put_device(&port->dev);
+		return ras_base;
+	} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
+		struct device *port_dev __free(put_device);
+
+		port_dev = bus_find_device(&cxl_bus_type, NULL, &pdev->dev, match_uport);
+		if (!port_dev)
+			return NULL;
+
+		port = to_cxl_port(port_dev);
+		if (!port)
+			return NULL;
+
+		ras_base = port ? port->uport_regs.ras : NULL;
+		return ras_base;
+	}
+
+	return NULL;
+}
+
+void cxl_cor_port_err_detected(struct pci_dev *pdev)
+{
+	void __iomem *ras_base = cxl_pci_port_ras(pdev);
+
+	__cxl_handle_cor_ras(&pdev->dev, ras_base);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cor_port_err_detected, CXL);
+
+pci_ers_result_t cxl_port_err_detected(struct pci_dev *pdev, pci_channel_state_t state)
+{
+	void __iomem *ras_base = cxl_pci_port_ras(pdev);
+	bool ue;
+
+	ue = __cxl_handle_ras(&pdev->dev, ras_base);
+	if (ue)
+		return PCI_ERS_RESULT_PANIC;
+
+	switch (state) {
+	case pci_channel_io_normal:
+		dev_err(&pdev->dev, "%s():%d: pci_channel_io_normal\n",
+			__func__, __LINE__);
+		return PCI_ERS_RESULT_CAN_RECOVER;
+	case pci_channel_io_frozen:
+		dev_err(&pdev->dev, "%s():%d: pci_channel_io_frozen\n",
+			__func__, __LINE__);
+		return PCI_ERS_RESULT_NEED_RESET;
+	case pci_channel_io_perm_failure:
+		dev_err(&pdev->dev, "%s():%d: pci_channel_io_perm_failure\n",
+			__func__, __LINE__);
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_err_detected, CXL);
+
 void cxl_uport_init_aer(struct cxl_port *port)
 {
 	/* uport may have more than 1 downstream EP. Check if already mapped. */
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 7a5f2c33223e..06fcde4b88b5 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -10,6 +10,7 @@
 #include <linux/bitops.h>
 #include <linux/log2.h>
 #include <linux/node.h>
+#include <linux/pci.h>
 #include <linux/io.h>
 
 extern const struct nvdimm_security_ops *cxl_security_ops;
@@ -901,6 +902,10 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+pci_ers_result_t cxl_port_err_detected(struct pci_dev *pdev,
+				       pci_channel_state_t state);
+void cxl_cor_port_err_detected(struct pci_dev *pdev);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4be35dc22202..9179b34c35bb 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -978,6 +978,11 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	}
 }
 
+static struct cxl_port_err_hndlrs cxl_port_hndlrs = {
+	.error_detected = cxl_port_err_detected,
+	.cor_error_detected = cxl_cor_port_err_detected
+};
+
 static const struct pci_error_handlers cxl_error_handlers = {
 	.error_detected	= cxl_error_detected,
 	.slot_reset	= cxl_slot_reset,
@@ -1054,11 +1059,14 @@ static int __init cxl_pci_driver_init(void)
 	if (rc)
 		pci_unregister_driver(&cxl_pci_driver);
 
+	register_cxl_port_hndlrs(&cxl_port_hndlrs);
+
 	return rc;
 }
 
 static void __exit cxl_pci_driver_exit(void)
 {
+	unregister_cxl_port_hndlrs();
 	cxl_cper_unregister_work(&cxl_cper_work);
 	cancel_work_sync(&cxl_cper_work);
 	pci_unregister_driver(&cxl_pci_driver);
-- 
2.34.1


