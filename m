Return-Path: <linux-pci+bounces-18199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C1B9EDBDE
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 00:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B3C280C0C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 23:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F92F1F37A0;
	Wed, 11 Dec 2024 23:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wd/MtCHz"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464F41F2C5D;
	Wed, 11 Dec 2024 23:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960492; cv=fail; b=SxH88HPBoFZVAyXso1KW92n5cfOvu1W3Yetf4IkMUQgTrwfcFJrUPlp50WPWCqJtrJFz0a0Sh658DaXtzbGR+eCvKETSNrxGl73u0s2H0CsNBTQvVyo1Brjp339WjnAySJ5zixRV1FixHZCXtASt4cDFAhjIJxBuVwqREl9V36M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960492; c=relaxed/simple;
	bh=4DP2sKE8MMJlnRh1xHiQj/0zMxjVXGZQGxREotjQoJg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFb0sIyzb7fefsTXOHWAYvitstbQW2qH/oqtYLQ+TAc/drAl4klitdTUWpLpl5M6HM3AfWjtIX2sVVPJJ2EP1edQlTUwlW+AI92LJzbiKiIQOI+0+SqLEqFLsMRtjNyaM10AXkXEWRaFJ5weql77SddcokVHOmaCBSMP8nz5EEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wd/MtCHz; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsyUGemx9rs91ofG80CcXLKZ4om7bZFTMqWNGXCMEx8qn6ROuuGEWyi2kc2JxyM2DLULmkCd/RWomTFAo3i1kYxJZERMJ6KZ6ZXJGRi96J2qqRkbJSgkcAucC9bvvcHnv3bkytKmzkHNHOnfh/ff64jfS9bYosv8Ck+sPzDRgOEO7/aCrJDUvtLSolb7pv4aLA9diLH0Bgf5yeyofP1N82N/TMrISXJpH93oKyd8No26Kk9EC+UvTVzgPsNDaV7ZnmSHjxN/ZmLu72Ufd2fQelQLQXS8A3vJMJnVVSzAFzwTziq24IMDXAUykGpOxWJ/nnzz/ISEfwJ0A2mqM0cFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xxn2XskkBLk8N7BvLiL23tQLbCP/TSEdqj0j5KpGR+U=;
 b=s/17HqB1XA2cjtYbd+8tcZeG85ZCuzQCQsCPW6jn8uYlwRwzl848Uh/o1Xus1dQT3NCywTfxiLpVbroVAB0O/S4PooGpyi+tn+fPBUgopD4u5ZOZhgd5RGVaublbeSB2sWwHeLgK8zM+YYeoacE3J0oK+qlcrytGP/BVtJhGvXGcynwEOGzwSFVADyk1RNQ4y1zJi8zlZY0kSU8v54ZBM64GEI9E+y6x9ZEH6cEqgO4KPdD3Tr9sFgllcKQckPhsOxOaXAOsRFajH8H+VHUxVF8NAe/mtGA4+8rw1FpUZp9MAAEB6obld3XT3x7IQMNrDI59qLf3Z9FzkxhWGDX3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xxn2XskkBLk8N7BvLiL23tQLbCP/TSEdqj0j5KpGR+U=;
 b=wd/MtCHzmKyHdovv04VDmoVkNKIbQWfEf9gtHNvHIImqBUebmzpBMI/HeKyXjFvRjDoRFvhAJFYknA1tDxJAxGz/3cA6qRHh4+ddna0Vv3PhVEM4mWLq1RQdUhuf9eHFMteqcNfMPLOlyb9m7+2ZgJOfQ2hBZAh9hIW0IeGir7Q=
Received: from BN9PR03CA0764.namprd03.prod.outlook.com (2603:10b6:408:13a::19)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Wed, 11 Dec
 2024 23:41:26 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::c9) by BN9PR03CA0764.outlook.office365.com
 (2603:10b6:408:13a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 23:41:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 23:41:26 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 17:41:25 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v4 07/15] PCI/AER: Add CXL PCIe Port Uncorrectable Error recovery in AER service driver
Date: Wed, 11 Dec 2024 17:39:54 -0600
Message-ID: <20241211234002.3728674-8-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211234002.3728674-1-terry.bowman@amd.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb67c5c-42c2-4b66-0ef3-08dd1a3d5422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JaDcOCHfjsPVfvlnwCBm4Qp8Ebrj6j6vuxR2OHs1oNH1FtsLmx8PfJMjiHip?=
 =?us-ascii?Q?GQSnOSN7HY8K/HiYbO0Kt7XEvggryrgMRoIsYRXlywSuCtJnx9y867w8/m/P?=
 =?us-ascii?Q?1h57EynrmYPJO6utokT6v7V//r6IE5MeTLfPhr3NJDDFCCf6FgPnmFVNRdIO?=
 =?us-ascii?Q?6vALu0V/MnPH8p31m8HZrijWkujEGf7dIGCsRuwdxTIjswpITHUNSBLnuhXJ?=
 =?us-ascii?Q?weiDxyzD2BJ/qBchx0ZwDXryQuG7twlSh6OHKXgJN8FEkKvAOGf5z8Oqc1Qo?=
 =?us-ascii?Q?/GMbjgClX6GLqXV7ckAR4ELoXvRWLo0cne0/T5aEk+3MoJbfYaFxJLp51a/s?=
 =?us-ascii?Q?ZSk3P7KrdXB90gkEpeWgXQiZ775dMb58/kWJWfgYekMFW1bAWy7XrroeOGlT?=
 =?us-ascii?Q?7tvdu+X/3VEwVvk1cc6LEWz3BzLiAXfErFsGu4Ad79ri0k1x4FfvmXpxQYEX?=
 =?us-ascii?Q?whFHqt+gonQ7x4J+/5+87ZUyrB9wDw9MoxQui2u/fcvqxm0TcyaYCYz2llCl?=
 =?us-ascii?Q?qNh50ZwTFWHlLZCxjw01wXYNgvBsX7b76HmAzUyVlnyWKjHKswYlR7FRCqo4?=
 =?us-ascii?Q?oWGH5p7p5fJOuxOQuZBXCcHmKphAYBzXKVaCgA7RufVRmKEZuGTDuJl+uEau?=
 =?us-ascii?Q?cRonVwZ33eoKE74F6d96Y68GMxPSsyB5k9evuFAJjYRYqT22eNEKl6ebWl6n?=
 =?us-ascii?Q?eLhtkxBd90QajgWHgjshqUKaaOPJVEXzoh7KyyGzrDvdy6bppV7vs9hbzkm7?=
 =?us-ascii?Q?hd5xGYMF23F/c8Yw7fG3ww1V3TvfcZrg8Nulgn7GeLr41I1ocCLelkVJcNL4?=
 =?us-ascii?Q?IDTsjIlCE/5mw35XfPCBiO5J5fKH0KPTpWNEPfvs2jEI5jAYTyinItr20QmA?=
 =?us-ascii?Q?AoyCEb1iTT9+32wFsBGvJLVXysltP4Zt+ibc7TBfdmco0QFXFnIC2ZcQ3Fga?=
 =?us-ascii?Q?4yRWnqkYbAvOKGB5enU/2uc/sHNpCDwaHA/4+80JuJ/oFHqR7bW0UHdOq5qV?=
 =?us-ascii?Q?xO3WbQFkt/3oEDB+kMjmwmN44Qkfjhj2PnI0k/8UbljO4MhFqHWwX2Hmvw5U?=
 =?us-ascii?Q?jDj4aCn30xNteJHggXFn9/IrNGKuK4ONrJz3EWuhIPGRZ4cgz2dXL+xwrKor?=
 =?us-ascii?Q?SVc0m9lJQI2RekNkIT57XOnbXq7YUhFg19epqoAZjQQAydGPINave1JeXnq7?=
 =?us-ascii?Q?2RJyDZzjfBCCiZiTrxUNyhqMCnKHlIIIWze9aNcn25nkbpFPtc3yiuX4kHyc?=
 =?us-ascii?Q?X/3csz90NGDNVtAylMcWsgpaCVawke2ngSePlUGVVnn0R/+66nPYBdDr/K0j?=
 =?us-ascii?Q?BS69TUkiAm+rQX2LogG4YgqV0tLHHZjNLfClpGQwBrNAuGOZPi8RVPA6l/Ma?=
 =?us-ascii?Q?zTOffJEZOuoHCYopeAYrVrc88tE4/0oBV7ZCbl0MW6uZh2LS7Jo1Leanw+lY?=
 =?us-ascii?Q?eHqzS4uQH/3LScckPXWMCm9QoS/zl/svco0LKMyGS11iud8H+5LPnw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 23:41:26.2698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb67c5c-42c2-4b66-0ef3-08dd1a3d5422
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918

Existing recovery procedure for PCIe Uncorrectable Errors (UCE) does not
apply to CXL devices. Recovery can not be used for CXL devices because of
potential corruption on what can be system memory. Also, current PCIe UCE
recovery, in the case of a Root Port (RP) or Downstream Switch Port (DSP),
does not begin at the RP/DSP but begins at the first downstream device.
This will miss handling CXL Protocol Errors in a CXL RP or DSP. A separate
CXL recovery is needed because of the different handling requirements

Add a new function, cxl_do_recovery() using the following.

Add cxl_walk_bridge() to iterate the detected error's sub-topology.
cxl_walk_bridge() is similar to pci_walk_bridge() but the CXL flavor
will begin iteration at the RP or DSP rather than beginning at the
first downstream device.

Add cxl_report_error_detected() as an analog to report_error_detected().
It will call pci_driver::cxl_err_handlers for each iterated downstream
device. The pci_driver::cxl_err_handler's UCE handler returns a boolean
indicating if there was a UCE error detected during handling.

cxl_do_recovery() uses the status from cxl_report_error_detected() to
determine how to proceed. Non-fatal CXL UCE errors will be treated as
fatal. If a UCE was present during handling then cxl_do_recovery()
will kernel panic.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/pci/pci.h      |  3 +++
 drivers/pci/pcie/aer.c |  4 ++++
 drivers/pci/pcie/err.c | 54 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 14d00ce45bfa..5a67e41919d8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -658,6 +658,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pci_channel_state_t state,
 		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev));
 
+/* CXL error reporting and handling */
+void cxl_do_recovery(struct pci_dev *dev);
+
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c1eb939c1cca..861521872318 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1024,6 +1024,8 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 			err_handler->error_detected(dev, pci_channel_io_normal);
 		else if (info->severity == AER_FATAL)
 			err_handler->error_detected(dev, pci_channel_io_frozen);
+
+		cxl_do_recovery(dev);
 	}
 out:
 	device_unlock(&dev->dev);
@@ -1048,6 +1050,8 @@ static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 			pdrv->cxl_err_handler->cor_error_detected(dev);
 
 		pcie_clear_device_status(dev);
+	} else {
+		cxl_do_recovery(dev);
 	}
 }
 
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 31090770fffc..6f7cf5e0087f 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -276,3 +276,57 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	return status;
 }
+
+static void cxl_walk_bridge(struct pci_dev *bridge,
+			    int (*cb)(struct pci_dev *, void *),
+			    void *userdata)
+{
+	bool *status = userdata;
+
+	cb(bridge, status);
+	if (bridge->subordinate && !*status)
+		pci_walk_bus(bridge->subordinate, cb, status);
+}
+
+static int cxl_report_error_detected(struct pci_dev *dev, void *data)
+{
+	struct pci_driver *pdrv = dev->driver;
+	bool *status = data;
+
+	device_lock(&dev->dev);
+	if (pdrv && pdrv->cxl_err_handler &&
+	    pdrv->cxl_err_handler->error_detected) {
+		const struct cxl_error_handlers *cxl_err_handler =
+			pdrv->cxl_err_handler;
+		*status |= cxl_err_handler->error_detected(dev);
+	}
+	device_unlock(&dev->dev);
+	return *status;
+}
+
+void cxl_do_recovery(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+	int type = pci_pcie_type(dev);
+	struct pci_dev *bridge;
+	int status;
+
+	if (type == PCI_EXP_TYPE_ROOT_PORT ||
+	    type == PCI_EXP_TYPE_DOWNSTREAM ||
+	    type == PCI_EXP_TYPE_UPSTREAM ||
+	    type == PCI_EXP_TYPE_ENDPOINT)
+		bridge = dev;
+	else
+		bridge = pci_upstream_bridge(dev);
+
+	cxl_walk_bridge(bridge, cxl_report_error_detected, &status);
+	if (status)
+		panic("CXL cachemem error.");
+
+	if (host->native_aer || pcie_ports_native) {
+		pcie_clear_device_status(dev);
+		pci_aer_clear_nonfatal_status(dev);
+	}
+
+	pci_info(bridge, "CXL uncorrectable error.\n");
+}
-- 
2.34.1


