Return-Path: <linux-pci+bounces-24805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2E3A72868
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 02:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE2217C621
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 01:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6414B136337;
	Thu, 27 Mar 2025 01:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q1OSP4Kv"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486F44594A;
	Thu, 27 Mar 2025 01:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040107; cv=fail; b=FYYdWt0X24ZcRWBtzqYe/h9foAi98hnzxYC0K1D9S/838CIttXmpTVLt09NmE4346BQ9NMxaMA9LFWUMyFh0mv/0ijTl8/yPbATkQ+HgzjgHDEx2zOwKbLvZcxtJWu5dIVpLh/ODMOEp/4k8CwvLnD/jAcfBNt5RpganjzEN6hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040107; c=relaxed/simple;
	bh=5kVqgDril1L2zZeKlWa0RV6Cmn6NLmquwG+4f+GDOw8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VwNXrpCov4LP9joSTC/WhaKZuxVIWq5ZydZofWJJjsWgTDOFTSRg+jT2O453WSWcwIl8HGeHRdArfP8xx0y9ZATK+pNCGGhCUjPAlWuQcDZreXW+LEZQ9A87Y+LozFRWiO3U1zb07lsvwFyaOg0F+gOgjshYs8sioMZBWtN7TwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q1OSP4Kv; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHXzhHAQ0zydJinv1jvmQ8KQ7+FkmabBbD8QmO0taEXHNMFE/NyJfk1MpHgJMy/mz09gbNcZ2w6AwRr4Ex3A9sJDmkIr8rjLSt+W6LzwgFGZDPRFSllD/wbeD6FRw+Bs7R4zD3X0+kKTLfRNN2dndurO1o/px6yBWOQgRfh6V2GSUVgyZuQrpDTfePH8edmmq5E6WrQX9fjNbPw+N0P0eohZR0snYHpp4BdXs5I87qmI7zopOee02wrgmidKENGfZle8sFDndXkkHHkTsRiozMjq2Ye8yG+lXeTm75ZCW8Afk1O4TIqwfnKCQAAPhzB2NKdm2y+mN22P9dvW+OcKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xVjEnmkSKzQ57PPSgGQvl7Y89B1rCHgdZHe/jkIgps=;
 b=gxX0dD9Cx2aCgRDaKzZDiQuFlBGwBuy4UukBzsSPhiXt+doOD2u6t5Su3xyyFbNmGGvau9RCm9zCTmlQLBoCE6s4pCtgbnLo0ykxn+F30hYN4RRu3LUCF57x9ln+GIHQ6sSFFjAiEgrsyBlYFl0a38vfqtEcR22kne4oLUWPRYyYExF4W8Vc4SAXA/ODjrM0RZvNlP3jqzXgFRCjyFdTbPpnV6URfLeFbY35Kze0cOAQ2NsrwJkvKXOc4342/1aDCZAtsaFYhfW4kOVb8AQuII0K6UQoK5E8ewH2Fes3SPOt/JHmX0hENQ/v5piYaX0Z2HtucvIspMh7FbwcU7128w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xVjEnmkSKzQ57PPSgGQvl7Y89B1rCHgdZHe/jkIgps=;
 b=Q1OSP4KvKrEMYjTUEMtAnzIRksvmsjDTYM8PxL0XWlzCBrxVSlw/c4yas+dTMnwZOOsdByC6+VukrDQVFkGbNI9fV1rmP+aqeGqM6GfRv+/QlgwWLkMOlLAUmPIVQC7wXEgPS5rQ9NhLhDy8KN+tt7r1n7BDW1MxtaALlx8pv+4=
Received: from BL0PR1501CA0004.namprd15.prod.outlook.com
 (2603:10b6:207:17::17) by BN7PPF02710D35B.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Thu, 27 Mar
 2025 01:48:21 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::dd) by BL0PR1501CA0004.outlook.office365.com
 (2603:10b6:207:17::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 27 Mar 2025 01:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 01:48:21 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 20:48:20 -0500
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
Subject: [PATCH v8 05/16] PCI/AER: CXL driver dequeues CXL error forwarded from AER service driver
Date: Wed, 26 Mar 2025 20:47:06 -0500
Message-ID: <20250327014717.2988633-6-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327014717.2988633-1-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|BN7PPF02710D35B:EE_
X-MS-Office365-Filtering-Correlation-Id: ad31afa6-fae4-44b8-b23d-08dd6cd17480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bKlEbB12KfKGNfZ0h8GOqJlliYEWGn+OwgB/lX26ykQL3RxonoJ/dlasVjPi?=
 =?us-ascii?Q?CQX8pnkQ/tL24s75rQP6oon3VwCiPcDvC0GmW1zB2qPMu2v0BJo3vtHBRv6R?=
 =?us-ascii?Q?IrhKBQz0fumg5G7gEBGKd51cSoN0VlkPC37xnctODCWmgK06PHZstTBBUOkn?=
 =?us-ascii?Q?yg4AlsviSmKijPO5AVEX79loig4Ms15RefqZKWIm20DsX7b6mRP++XcY7Vgu?=
 =?us-ascii?Q?vLhkUC2fAQH+te1QuHq8o6psnopK0YeNDZ7K7qI/G7I2FayhvF7/prMrgqJ3?=
 =?us-ascii?Q?mvVlHjwR9PYxuB3lv7uoGfhBZmtMh1l4jzWkGM6Cem5gZ9dYRahAyv6cwOx9?=
 =?us-ascii?Q?OwY2B+1eJ+eZvJLr4fdAMX9YGd+2tO/IMICFCx0knAchPcygva/jlYbvdCve?=
 =?us-ascii?Q?fYuWxMV5Ta2mhDmdNmWkVc4Z5um6CS+06DLZLXWJucskq9Eo7QedYutmbjMy?=
 =?us-ascii?Q?2QotAr+W/lSvFStB9Mw5N4S0qEfOdPXxu0px0roxRW542CDR5c8TEOSwlVqc?=
 =?us-ascii?Q?yx1KkaOPxtLVpdp3JXurGR/5mt8EkBq0J28feNgztL8MlwvPOm0RsL1N6smn?=
 =?us-ascii?Q?0IDoq1jic2PSEHZXhjLTANVQSMV5kB9fF/wj+E44v6goMwTgHFYuoncsAwqU?=
 =?us-ascii?Q?WxxwqefDdmogIpWmO2Q8SblCzxdfitmU0wRt/1JZ+FxNnDLrUyoofPdRn1nk?=
 =?us-ascii?Q?OOFzc5aw9ZosCrzCAIXytddGqu1ZF36M5K5I5d3OIBhnYV51azVa8IbYGt5b?=
 =?us-ascii?Q?FJquDiEm7wXNtTHFpjRHOnzFyHn16jn9eY7s9hrO4lBiOJuNs8Cxdx2quJIm?=
 =?us-ascii?Q?vAlM2dJSLBm9uXdtviz4mNLmVKXyReQXGKQQLFifAr14FltQDPUI3GNyfeOO?=
 =?us-ascii?Q?5Elmkx7GGPOrR2yatWtdVcpc0Rj5IBeZB72MUQRJHEaw1hv1BAY1rtzpejyX?=
 =?us-ascii?Q?0Kzh2V+EaWfw+RdyugSpLUebVpjGQHXUzmyjSBj4ReC5TXGnkLWySFGGqooU?=
 =?us-ascii?Q?vg1mu0op523qA0q6uYsCk+PJQb2s0k2kGYv/Jy9Uf86eFKLgfUBg7NUHN27D?=
 =?us-ascii?Q?Ik4eXaJIckFXoHcVm0ZWjJCvkmxHuNt6tI2PukFX7XPKcUEh3Gbm6885M/kY?=
 =?us-ascii?Q?0iYm7JnCjSFzkLuindPLlNM/LFPyZaelpTwajukKUQn1eE5KkDrPmsx/857G?=
 =?us-ascii?Q?JHxTuM/pZmSOwuceunTiBFt/loJXPwIh2mW9QFHqZ5Q66LQQajbH7pHKj+bZ?=
 =?us-ascii?Q?wraw1WKMSP8CM1IM9WMH5xP85jz0qsTeiiwnOoAzigLjCVwGwqYgX9OkgUUu?=
 =?us-ascii?Q?pSwkXvw5VyEbIDOVZq5R2puMVA5cuvJc2UhpBsI1hkbilavM0bQcN00C2VIR?=
 =?us-ascii?Q?gH0fCU8DOa+/AMAR1o1W4z/pELFo8ZbqisbgcadermLq97l8E3g72/X9Ldhz?=
 =?us-ascii?Q?h8CQU7IUdP6cZ2+77qIfH7Ns9HG/6BBQ/IBca7u4dKL173EpSNH08XFmbzdg?=
 =?us-ascii?Q?VmpindaQ7Vfp+wV7pFpjL1hkF9JWb7n1od7a?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 01:48:21.4565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad31afa6-fae4-44b8-b23d-08dd6cd17480
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF02710D35B

The AER driver is now designed to forward CXL protocol errors to the CXL
driver. Update the CXL driver with functionality to dequeue the forwarded
CXL error from the kfifo. Also, update the CXL driver to process the CXL
protocol errors using CXL protocol error handlers.

First, move cxl_rch_handle_error_iter() from aer.c to cxl/core/ras.c.
Remove and drop the cxl_rch_handle_error() in aer.c as it is not needed.

Introduce function cxl_prot_err_work_fn() to dequeue work forwarded by the
AER service driver. This will begin the CXL protocol error processing
with the call to cxl_handle_prot_error().

Introduce cxl_handle_prot_error() to differntiate between Restricted CXL
Host (RCH) protocol errors and CXL virtual host (VH) protocol errors.
RCH errors will be processed with a call to walk the associated Root
Complex Event Collector's (RCEC) secondary bus looking for the Root Complex
Integrated Endpoint (RCiEP) to handle the RCH error. Export pcie_walk_rcec()
so the CXL driver can walk the RCEC's downstream bus, searching for
the RCiEP.

VH correctable error (CE) processing will call the CXL CE handler if
present. VH uncorrectable errors (UCE) will call cxl_do_recovery(),
implemented as a stub for now and to be updated in future patch. Export
pci_aer_clean_fatal_status() and pci_clean_device_status() used to clean up
AER status after handling.

Create cxl_driver::error_handler structure similar to
pci_driver::error_handlers. Add handlers for CE and UCE CXL.io errors. Add
'struct cxl_prot_error_info' as a parameter to the CXL CE and UCE error
handlers.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/ras.c  | 102 +++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxl.h       |  17 +++++++
 drivers/pci/pci.c       |   1 +
 drivers/pci/pci.h       |   6 ---
 drivers/pci/pcie/aer.c  |  42 +----------------
 drivers/pci/pcie/rcec.c |   1 +
 include/linux/aer.h     |   2 +
 include/linux/pci.h     |  10 ++++
 8 files changed, 133 insertions(+), 48 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index ecb60a5962de..eca8f11a05d9 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -139,8 +139,108 @@ int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_create_prot_err_info, "CXL");
 
-struct work_struct cxl_prot_err_work;
+static void cxl_do_recovery(struct pci_dev *pdev) { }
+
+static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
+{
+	struct cxl_prot_error_info *err_info = data;
+	const struct cxl_error_handlers *err_handler;
+	struct device *dev = err_info->dev;
+	struct cxl_driver *pdrv;
+
+	/*
+	 * The capability, status, and control fields in Device 0,
+	 * Function 0 DVSEC control the CXL functionality of the
+	 * entire device (CXL 3.0, 8.1.3).
+	 */
+	if (pdev->devfn != PCI_DEVFN(0, 0))
+		return 0;
+
+	/*
+	 * CXL Memory Devices must have the 502h class code set (CXL
+	 * 3.0, 8.1.12.1).
+	 */
+	if ((pdev->class >> 8) != PCI_CLASS_MEMORY_CXL)
+		return 0;
+
+	if (!is_cxl_memdev(dev) || !dev->driver)
+		return 0;
+
+	pdrv = to_cxl_drv(dev->driver);
+	if (!pdrv || !pdrv->err_handler)
+		return 0;
+
+	err_handler = pdrv->err_handler;
+	if (err_info->severity == AER_CORRECTABLE) {
+		if (err_handler->cor_error_detected)
+			err_handler->cor_error_detected(dev, err_info);
+	} else if (err_handler->error_detected) {
+		cxl_do_recovery(pdev);
+	}
+
+	return 0;
+}
+
+static void cxl_handle_prot_error(struct pci_dev *pdev, struct cxl_prot_error_info *err_info)
+{
+	if (!pdev || !err_info)
+		return;
+
+	/*
+	 * Internal errors of an RCEC indicate an AER error in an
+	 * RCH's downstream port. Check and handle them in the CXL.mem
+	 * device driver.
+	 */
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
+		return pcie_walk_rcec(pdev, cxl_rch_handle_error_iter, err_info);
+
+	if (err_info->severity == AER_CORRECTABLE) {
+		struct device *dev __free(put_device) = get_device(err_info->dev);
+		struct cxl_driver *pdrv;
+		int aer = pdev->aer_cap;
+
+		if (!dev || !dev->driver)
+			return;
+
+		if (aer) {
+			int ras_status;
+
+			pci_read_config_dword(pdev, aer + PCI_ERR_COR_STATUS, &ras_status);
+			pci_write_config_dword(pdev, aer + PCI_ERR_COR_STATUS,
+					       ras_status);
+		}
+
+		pdrv = to_cxl_drv(dev->driver);
+		if (!pdrv || !pdrv->err_handler ||
+		    !pdrv->err_handler->cor_error_detected)
+			return;
+
+		pdrv->err_handler->cor_error_detected(dev, err_info);
+		pcie_clear_device_status(pdev);
+	} else {
+		cxl_do_recovery(pdev);
+	}
+}
+
+static void cxl_prot_err_work_fn(struct work_struct *work)
+{
+	struct cxl_prot_err_work_data wd;
+
+	while (cxl_prot_err_kfifo_get(&wd)) {
+		struct cxl_prot_error_info *err_info = &wd.err_info;
+		struct device *dev __free(put_device) = get_device(err_info->dev);
+		struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(err_info->pdev);
+
+		if (!dev || !pdev)
+			continue;
+
+		cxl_handle_prot_error(pdev, err_info);
+	}
+}
+
+static DECLARE_WORK(cxl_prot_err_work, cxl_prot_err_work_fn);
 
 int cxl_ras_init(void)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index be8a7dc77719..73cddd2c921e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -11,6 +11,8 @@
 #include <linux/log2.h>
 #include <linux/node.h>
 #include <linux/io.h>
+#include <linux/pci.h>
+#include <linux/aer.h>
 
 extern const struct nvdimm_security_ops *cxl_security_ops;
 
@@ -786,6 +788,20 @@ static inline int cxl_root_decoder_autoremove(struct device *host,
 }
 int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
 
+int cxl_create_prot_err_info(struct pci_dev *pdev, int severity,
+			     struct cxl_prot_error_info *err_info);
+
+/* CXL bus error event callbacks */
+struct cxl_error_handlers {
+	/* CXL bus error detected on this device */
+	pci_ers_result_t (*error_detected)(struct device *dev,
+					   struct cxl_prot_error_info *err_info);
+
+	/* Allow device driver to record more details of a correctable error */
+	void (*cor_error_detected)(struct device *dev,
+				   struct cxl_prot_error_info *err_info);
+};
+
 /**
  * struct cxl_endpoint_dvsec_info - Cached DVSEC info
  * @mem_enabled: cached value of mem_enabled in the DVSEC at init time
@@ -820,6 +836,7 @@ struct cxl_driver {
 	void (*remove)(struct device *dev);
 	struct device_driver drv;
 	int id;
+	const struct cxl_error_handlers *err_handler;
 };
 
 #define to_cxl_drv(__drv)	container_of_const(__drv, struct cxl_driver, drv)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a1d75f40017e..d80c705d683c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2320,6 +2320,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
 	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
 }
+EXPORT_SYMBOL_NS_GPL(pcie_clear_device_status, "CXL");
 #endif
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index eed098c134a6..c32eab22c0b2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -593,16 +593,10 @@ static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
 void pci_rcec_init(struct pci_dev *dev);
 void pci_rcec_exit(struct pci_dev *dev);
 void pcie_link_rcec(struct pci_dev *rcec);
-void pcie_walk_rcec(struct pci_dev *rcec,
-		    int (*cb)(struct pci_dev *, void *),
-		    void *userdata);
 #else
 static inline void pci_rcec_init(struct pci_dev *dev) { }
 static inline void pci_rcec_exit(struct pci_dev *dev) { }
 static inline void pcie_link_rcec(struct pci_dev *rcec) { }
-static inline void pcie_walk_rcec(struct pci_dev *rcec,
-				  int (*cb)(struct pci_dev *, void *),
-				  void *userdata) { }
 #endif
 
 #ifdef CONFIG_PCI_ATS
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d1df751cfe4b..763ec6aa1a9a 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -288,6 +288,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 	if (status)
 		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
 }
+EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
 
 /**
  * pci_aer_raw_clear_status - Clear AER error registers.
@@ -1018,47 +1019,6 @@ static bool is_cxl_error(struct aer_err_info *info)
 	return is_internal_error(info);
 }
 
-static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
-{
-	struct aer_err_info *info = (struct aer_err_info *)data;
-	const struct pci_error_handlers *err_handler;
-
-	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
-		return 0;
-
-	/* protect dev->driver */
-	device_lock(&dev->dev);
-
-	err_handler = dev->driver ? dev->driver->err_handler : NULL;
-	if (!err_handler)
-		goto out;
-
-	if (info->severity == AER_CORRECTABLE) {
-		if (err_handler->cor_error_detected)
-			err_handler->cor_error_detected(dev);
-	} else if (err_handler->error_detected) {
-		if (info->severity == AER_NONFATAL)
-			err_handler->error_detected(dev, pci_channel_io_normal);
-		else if (info->severity == AER_FATAL)
-			err_handler->error_detected(dev, pci_channel_io_frozen);
-	}
-out:
-	device_unlock(&dev->dev);
-	return 0;
-}
-
-static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
-{
-	/*
-	 * Internal errors of an RCEC indicate an AER error in an
-	 * RCH's downstream port. Check and handle them in the CXL.mem
-	 * device driver.
-	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
-	    is_internal_error(info))
-		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
-}
-
 static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
 {
 	bool *handles_cxl = data;
diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
index d0bcd141ac9c..fb6cf6449a1d 100644
--- a/drivers/pci/pcie/rcec.c
+++ b/drivers/pci/pcie/rcec.c
@@ -145,6 +145,7 @@ void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
 
 	walk_rcec(walk_rcec_helper, &rcec_data);
 }
+EXPORT_SYMBOL_NS_GPL(pcie_walk_rcec, "CXL");
 
 void pci_rcec_init(struct pci_dev *dev)
 {
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 761d6f5cd792..8f815f34d447 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -66,12 +66,14 @@ struct cxl_prot_err_work_data {
 
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
+void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
 #else
 static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 #endif
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index af83230bef1a..56015721be22 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1802,6 +1802,9 @@ extern bool pcie_ports_native;
 
 int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 			  bool use_lt);
+void pcie_walk_rcec(struct pci_dev *rcec,
+		    int (*cb)(struct pci_dev *, void *),
+		    void *userdata);
 #else
 #define pcie_ports_disabled	true
 #define pcie_ports_native	false
@@ -1812,8 +1815,15 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void pcie_walk_rcec(struct pci_dev *rcec,
+				  int (*cb)(struct pci_dev *, void *),
+				  void *userdata) { }
+
 #endif
 
+void pcie_clear_device_status(struct pci_dev *dev);
+
 #define PCIE_LINK_STATE_L0S		(BIT(0) | BIT(1)) /* Upstr/dwnstr L0s */
 #define PCIE_LINK_STATE_L1		BIT(2)	/* L1 state */
 #define PCIE_LINK_STATE_L1_1		BIT(3)	/* ASPM L1.1 state */
-- 
2.34.1


