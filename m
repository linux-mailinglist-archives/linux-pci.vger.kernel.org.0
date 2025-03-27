Return-Path: <linux-pci+bounces-24813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8388BA72875
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 02:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E5417423E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 01:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3926819DF44;
	Thu, 27 Mar 2025 01:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="13ntWkvp"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEA61991C9;
	Thu, 27 Mar 2025 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040199; cv=fail; b=pUHhYfoD027zl+TkATawP3E17rWqIRr7cd79mwNac7BLHg61K3Kr5E83PgrJqfqLW5wKgrW/ZFzbypWxrXL+uZzfnPPnc9cTk1luhVJkNOMgBNNZYRjd0TplDsxGM5Ut6XZRo8tvNRPk+NlfIfryQOH3BCXJ6QqsJbQmxq6zfLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040199; c=relaxed/simple;
	bh=LvB1BJjsJpVmt2ROl0EBiceE273rigb7xnvc1pIntUI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPGkq4MRRooXPE6rH7SS7/ofILXg3fdAGTliQMqbGG+rZ3+k/KNGFAceIoUWSv1uHEPxjUT+v5SOWRtmPQ1AxT9Oq9dkBlLpewhFdxhlu6XPC6LafY6F7gxr+Da0bdMbqpivDWM3fXPbtmuAIt2FSSz3pkzgy/eLLqIVvcSocz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=13ntWkvp; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b66O36h5LgQG+kbPn8D/8op9anb+6BR1Yh8d0wSFDK8v9ac6AIA3Ahn3pPgvozFrRibKe9pYgTTMjdEjpe9H+hmyWye8N/iElsZJAGXTowZl91OTq8xAoMykfRngIwsQtH01ws1QRTRixz/athdnB0Iyt/Vb5SQ9vKioKM40sCV8AVHY97F4PnaHlrvgGC/cpRBnbcD6YjqbuwXblNb19D1+YjumjBAvqkIzo1PLEn6zVEF/n/6EBYgeHZM7gU7VAx+OVZiTvGKSSwLR5vPGHvb1Em0UsyqUoFUEE4Pxe7ka0X38eOU177kywa5IOTejrm+45bp8rsmjISl4eoYtrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+Zx4TJRlY7mSb2pr2TmqDd0lZL4IF2OJ78fwP+tYvo=;
 b=KliEwqyj01LOr3PTdJKT/7i918xwhaFHAP1ZOiTGE8aPN0IZVEsSA53l0YtEZxilUapdPijpINkeP3ZywKL9rSE1Ma93Z5SQ4rgFpCl2MHaIh8o1QOLf1dIEi1u36ZL4HvXflWjAwELzDH8p9se4etMBc2ttE5ynbGo8L9LKzgQTGP1RYfDHcN5CKevXNxYln9kpJLbVSdg9YlcHiMuXBYGPa4n4GhdRw/knKH3pmamd0NgUQEwQWfqFV3h6X6Mj5VLbZCuDXACqc+Z6/xflDTd0qcxmEixJpjSJPxz3ZZYYCfy5dMBy/VrljsUx+cf83LQD0mcDOndBvoIKj0TMOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+Zx4TJRlY7mSb2pr2TmqDd0lZL4IF2OJ78fwP+tYvo=;
 b=13ntWkvpgnkwEsmeLsRRpJujMesVsivLkw6AIT5YIy8RaoAMam18iQZU/BPKkj7W9oPCgE7M4j5xyKwoKA1LKGqGdwoOomL+yQ1XzaG/mQjQJzSpl6OxslNVC/etmJ9ZkWSRgdB7zV1/XYA5o6Bl49urCNynQ77LkKSPqVjFaOc=
Received: from MN0P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::6)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Thu, 27 Mar
 2025 01:49:53 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:531:cafe::2e) by MN0P222CA0001.outlook.office365.com
 (2603:10b6:208:531::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Thu,
 27 Mar 2025 01:49:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 01:49:52 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 20:49:51 -0500
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
Subject: [PATCH v8 13/16] cxl/pci: Assign CXL Endpoint protocol error handlers
Date: Wed, 26 Mar 2025 20:47:14 -0500
Message-ID: <20250327014717.2988633-14-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|SJ2PR12MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b080a7-5421-40d5-c304-08dd6cd1aad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VbHedtpVJZJ5hRh8Q5KheyMs5IcuiwxL+cwux4Ca6r13KrME4gz+qJ/3FwxD?=
 =?us-ascii?Q?1DqzQxtrbLEPgTjw+DLgAc1f0afr9mCVouj2JuKz4LbfbaY+Kb3ex422zWkW?=
 =?us-ascii?Q?F9uEqV3hRI3LNTcFcIAnPB9DZ2cTTN/0bEed5pPNZYRkKRSD3vVGhi8Z5U7Y?=
 =?us-ascii?Q?sD9zDn8kXxIg4Cslgpoo9aThfkqEJgoMuk0kmOF1KXwC2ohuSpjwUWTD1yFb?=
 =?us-ascii?Q?7lfYoNSJk1JAtFDTYz8CM6uSeUm2eeOgKS/yrEfDsawJl5N2NVQ5LSHjovuh?=
 =?us-ascii?Q?3AmZkkg185mdRudRPzFDtlrAJJl2/JmpF6+dGJ3iko/SFgUOchoftRk8Wpsr?=
 =?us-ascii?Q?yezkU1XvwR9KULyDCyHSvcgdI2rlpfSWcyEWI8HNifnVb0NdK7uzC3dJ0Fug?=
 =?us-ascii?Q?19qDjj/ZXcC3Y5k6W3RXmpAKwplmKObo0zT+4C02VDlcnc/DdelElVk/A6XA?=
 =?us-ascii?Q?9IgsXTth/RFFgv/37tqdVHxCArq7Dmt5H5auw6h9fnhqebBBcy6JaJqpwixs?=
 =?us-ascii?Q?c/PRO/7CT9i4HKobCZ35DjmquaqRcToHY7FCw4Enb75bSnb9G6xxlYWU6VAq?=
 =?us-ascii?Q?GH45v2rFkR7zpqCi4vd8j7xCAk2Rz1MhvgZ3T0IZ68gPVIWwglVQow99ApWt?=
 =?us-ascii?Q?uSeWP9ZZxIuWAGl/5bkaH4bNvZFsHOg/nNBJR3nkKrJEWO3KD8IbHs285HiQ?=
 =?us-ascii?Q?tl6gibiL92Hw7k1X6TsYO3RxL0j2nMk9A5K54h8fMoKMxbddrIyAkMnR+2V5?=
 =?us-ascii?Q?47L6U5vRJRszwgcMTJy7ULLTbqJyK8dVsAMXCNnzW6pJqu7c48Zu6Q0LOOeP?=
 =?us-ascii?Q?RFT6SmSeXTsMgsKmIPd5wwxIrMZi3i5+9MVSGC2CTMS5Kd8VdQNyCeuTlZw1?=
 =?us-ascii?Q?+QfcyxAaUf+mB/eTpsNzyrX4pOO27GDebDT1IrnQFGyaQOSBZk1dWkrI/1N9?=
 =?us-ascii?Q?Rq2mHBKFBbUNI6T/xh/icn/Gb/yqfVMb6ZVaLtdFcjbUgKMAQ2W2Di0epvu8?=
 =?us-ascii?Q?kIpwP0IPIA4iebSKQ7QFWLo0Yqf3GLLpRehpIpVPwFZkxsJWaC93Ud0zCDMb?=
 =?us-ascii?Q?9cMGGe2H0MJAwuL3Yc304UJciu7S+bKph6/WCNVvzfnY3BRoY3BaXaZCzbRn?=
 =?us-ascii?Q?f54bCiva9nJ6IwCX83nko2vidmP8fTXtknNGC6hH/9oHzQQhiEfYpLW6rRWC?=
 =?us-ascii?Q?qTU8FgVJWa+hg8TB+ENnQpsZhD4b1j98RYIClskAdfzw8u0DLKIbmbn0qCh9?=
 =?us-ascii?Q?3JqmUIyjXg0qMkTxHocCH9YMPX3xs4toLw4ML/TTDTZ/qcHO2yqsPrJnHSEs?=
 =?us-ascii?Q?3hcfDKwKlVYyk8IBu0q2+LwoayvuSq+xDjFv2TCDZG6/iUDKPiK6ZjQqT4bY?=
 =?us-ascii?Q?QcSD1s8SNwj4g6HEUEQEVS1dLtlrFJi1SnQ4vBAT6Eqh5MbmqvNqXdr2wh1K?=
 =?us-ascii?Q?ngeFpVHl6Fi7kny2M+GjWCN0dDtC0HYzaL9fnfcUHaa+mkqbf6VaTCPKyMUL?=
 =?us-ascii?Q?KXbRloEQ4admRwbWj8cQ/fPx0fX/KPOIHXm8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 01:49:52.5913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b080a7-5421-40d5-c304-08dd6cd1aad2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926

CXL Endpoint protocol errors are currently handled using PCI error
handlers. The CXL Endpoint requires CXL specific handling in the case of
uncorrectable error handling not provided by the PCI handlers.

Add CXL specific handlers for CXL Endpoints. Assign the CXL handlers
during Endpoint Port initialization.

Keep the PCI Endpoint handlers. PCI handlers can be called if the CXL
device is not trained for alternate protocol (CXL). Update the CXL
Endpoint PCI handlers to call the CXL handler. If the CXL
uncorrectable handler returns PCI_ERS_RESULT_PANIC then the PCI
handler invokes panic().

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 65 ++++++++++++++++++++++++------------------
 drivers/cxl/cxl.h      |  5 ++++
 drivers/cxl/cxlpci.h   |  4 +--
 drivers/cxl/pci.c      |  8 +++---
 drivers/cxl/port.c     |  7 +++++
 5 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9ed6f700e132..f2139b382839 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -852,10 +852,10 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
 #endif
 
-void cxl_cor_error_detected(struct pci_dev *pdev)
+void cxl_cor_error_detected(struct device *dev, struct cxl_prot_error_info *err_info)
 {
+	struct pci_dev *pdev = err_info->pdev;
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct device *dev = &cxlds->cxlmd->dev;
 
 	scoped_guard(device, dev) {
 		if (!dev->driver) {
@@ -873,20 +873,30 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
 
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state)
+void pci_cor_error_detected(struct pci_dev *pdev)
+{
+	struct cxl_prot_error_info err_info;
+
+	if (cxl_create_prot_err_info(pdev, AER_CORRECTABLE, &err_info))
+		return;
+
+	cxl_cor_error_detected(err_info.dev, &err_info);
+}
+EXPORT_SYMBOL_NS_GPL(pci_cor_error_detected, "CXL");
+
+pci_ers_result_t cxl_error_detected(struct device *dev,
+				    struct cxl_prot_error_info *err_info)
 {
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct device *dev = &cxlmd->dev;
 	bool ue;
+	struct pci_dev *pdev = err_info->pdev;
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
 
 	scoped_guard(device, dev) {
 		if (!dev->driver) {
 			dev_warn(&pdev->dev,
 				 "%s: memdev disabled, abort error handling\n",
 				 dev_name(dev));
-			return PCI_ERS_RESULT_DISCONNECT;
+			return PCI_ERS_RESULT_PANIC;
 		}
 
 		if (cxlds->rcd)
@@ -900,29 +910,30 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		ue = cxl_handle_endpoint_ras(cxlds);
 	}
 
+	if (ue)
+		return PCI_ERS_RESULT_PANIC;
 
-	switch (state) {
-	case pci_channel_io_normal:
-		if (ue) {
-			device_release_driver(dev);
-			return PCI_ERS_RESULT_NEED_RESET;
-		}
-		return PCI_ERS_RESULT_CAN_RECOVER;
-	case pci_channel_io_frozen:
-		dev_warn(&pdev->dev,
-			 "%s: frozen state error detected, disable CXL.mem\n",
-			 dev_name(dev));
-		device_release_driver(dev);
-		return PCI_ERS_RESULT_NEED_RESET;
-	case pci_channel_io_perm_failure:
-		dev_warn(&pdev->dev,
-			 "failure state error detected, request disconnect\n");
-		return PCI_ERS_RESULT_DISCONNECT;
-	}
-	return PCI_ERS_RESULT_NEED_RESET;
+	return PCI_ERS_RESULT_CAN_RECOVER;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
 
+pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
+				    pci_channel_state_t error)
+{
+	struct cxl_prot_error_info err_info;
+	pci_ers_result_t rc;
+
+	if (cxl_create_prot_err_info(pdev, AER_FATAL, &err_info))
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	rc = cxl_error_detected(err_info.dev, &err_info);
+	if (rc == PCI_ERS_RESULT_PANIC)
+		panic("CXL cachemem error.");
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(pci_error_detected, "CXL");
+
 static int cxl_flit_size(struct pci_dev *pdev)
 {
 	if (cxl_pci_flit_256(pdev))
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 512cc38892ed..c1adf8a3cb9e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -815,6 +815,11 @@ void cxl_port_cor_error_detected(struct device *dev,
 pci_ers_result_t cxl_port_error_detected(struct device *dev,
 					 struct cxl_prot_error_info *err_info);
 
+void cxl_cor_error_detected(struct device *dev,
+			    struct cxl_prot_error_info *err_info);
+pci_ers_result_t cxl_error_detected(struct device *dev,
+				    struct cxl_prot_error_info *err_info);
+
 /**
  * struct cxl_endpoint_dvsec_info - Cached DVSEC info
  * @mem_enabled: cached value of mem_enabled in the DVSEC at init time
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 92d72c0423ab..d277cf048eba 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -133,8 +133,8 @@ struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
 void read_cdat_data(struct cxl_port *port);
-void cxl_cor_error_detected(struct pci_dev *pdev);
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
+void pci_cor_error_detected(struct pci_dev *pdev);
+pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
 int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
 			     struct cxl_prot_error_info *err_info);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4288f4814cc5..c5be4422748e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1108,11 +1108,11 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	}
 }
 
-static const struct pci_error_handlers cxl_error_handlers = {
-	.error_detected	= cxl_error_detected,
+static const struct pci_error_handlers pci_error_handlers = {
+	.error_detected = pci_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
-	.cor_error_detected	= cxl_cor_error_detected,
+	.cor_error_detected	= pci_cor_error_detected,
 	.reset_done	= cxl_reset_done,
 };
 
@@ -1120,7 +1120,7 @@ static struct pci_driver cxl_pci_driver = {
 	.name			= KBUILD_MODNAME,
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
-	.err_handler		= &cxl_error_handlers,
+	.err_handler		= &pci_error_handlers,
 	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 30a4bdb88c31..8e2b70e73582 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -65,6 +65,11 @@ static const struct cxl_error_handlers cxl_port_error_handlers = {
 	.cor_error_detected = cxl_port_cor_error_detected,
 };
 
+const struct cxl_error_handlers cxl_ep_error_handlers = {
+	.error_detected = cxl_error_detected,
+	.cor_error_detected = cxl_cor_error_detected,
+};
+
 static void cxl_assign_error_handlers(struct device *_dev,
 				      const struct cxl_error_handlers *handlers)
 {
@@ -203,6 +208,8 @@ static void cxl_endpoint_port_init_ras(struct cxl_port *port)
 	}
 
 	cxl_dport_init_ras_reporting(dport, cxlmd_dev);
+
+	cxl_assign_error_handlers(cxlmd_dev, &cxl_ep_error_handlers);
 }
 
 #else
-- 
2.34.1


