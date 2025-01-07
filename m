Return-Path: <linux-pci+bounces-19434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD55FA042DE
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA9018823EC
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB521F37C4;
	Tue,  7 Jan 2025 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ck/6BFMB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EA71F1917;
	Tue,  7 Jan 2025 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260884; cv=fail; b=i5A0YeH+CngAmWY707WzYf5DuXzAuvfzUvAJG3oSqWw2lCWB8M3D7puWzWSiN6lni8ToD8NEe5kHNbG6/dS/JY2IdGIRKlzQeMOSEKzrRT4eWzoa44n5a4K0Q68kMLF1VLJKosZysaFYEHLhDumn70a6kkKckbKCuFhWu04GdXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260884; c=relaxed/simple;
	bh=yjOnK51kxwBdCVS9Z34vmImsd1gd8LDa/1mNEAKdrog=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTcUrh5qQI+t6PhBjCbVcVPEJh7ZLvOglIQT7+duEnXwz0CEr/u7KCLKsBo6p3UwopWVXV/7H+XolqlQVwZzA+ofNH90LgO9dVH0GFLjUmLzVqYfqusDd5hGdzgej4JTdGKkLmRxe1GvcjJEOOoBsiJJ+7EFi6zt2vNyzTOK5BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ck/6BFMB; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lbksrmy7+ydvqUiDXzngkINYCX+L0vmlmnXWyua3mbJUeqj65ZygcUKkUqKo52LLYTR9vBIRvDY1Y8g86JcMFG+0vqSIG7GJUHrluQcTUleT1ButJFJVxQPsWtEo3OKRoJcBQ+v4ddAx278QEZXf5L7/HpY6Ban6mxzGWBKH1QSSNREq7QNHcrmss2WMju7/ymwhZNLLa/8yQ4gE9YjM1jcUqeK1urZlkfgrirPmTPsyfvfBuM2LaUOT0iFwEK4dEPm0a3XVA2t9sBQds1E/KHWlHkbL0BVXlYyseI7JMfxCVmskpM5oVQhSzlEPwBwrzxxPg5xCz18MZMQAlWSvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5WdW/NLk4pmSvJ2kM0YgxroGMjhuXWE+plE4YK0o1k=;
 b=QO8EgsUh3TzOyUT3OdHn7Rhd1Q803F3WJfrR+1kYWCCQ1/i+MqeZE3FISZZAWp8WW7F0HhszrwBnlpbsI1bzuldvvArhB8uRT/+z3S3ueH/7Jk38tVohiXjAxVbtpORHyE3WhNmjBlS7kJn7cTH8b9j34sGKar2LtsCm0EljRwgmTyT6LwHG1arr3BAo5TPrF6Rj+I70pP6lTxgBAvE/BOl9958VyDdyOTQSqgsQaujBOXtS0otB2idQEDAiRswHsgYXQnnJ+z4IfR6TUWEjzIs1D/0msY3enrhELjSFwjbufSz7mgFjsixiWf+dI/1pjFhQWeqS3QSAU2gvos5+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5WdW/NLk4pmSvJ2kM0YgxroGMjhuXWE+plE4YK0o1k=;
 b=ck/6BFMBFcaOBs7rntsVUO1YO7dSutxJ+x/8wTDWqZ9lZHCZl27BaLArUNCjnXMIkGDFnBYYzef+/GtdU+gJLjJtNdg4U8kLe60RTXX5cnGtdF3fQG65/VzQRsbGjThi8i7lAkfcACdv5GGn31n2O5PVZEkwPbScgoIC20+IhVo=
Received: from SJ0PR13CA0081.namprd13.prod.outlook.com (2603:10b6:a03:2c4::26)
 by DS0PR12MB7559.namprd12.prod.outlook.com (2603:10b6:8:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 14:41:13 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::d1) by SJ0PR13CA0081.outlook.office365.com
 (2603:10b6:a03:2c4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 14:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:41:12 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:40:15 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>,
	<alucerop@amd.com>
Subject: [PATCH v5 07/16] PCI/AER: Add CXL PCIe Port uncorrectable error recovery in AER service driver
Date: Tue, 7 Jan 2025 08:38:43 -0600
Message-ID: <20250107143852.3692571-8-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107143852.3692571-1-terry.bowman@amd.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|DS0PR12MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: f61cbeb3-522a-45f7-5975-08dd2f295557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zpu/Rs7BZQeii5fRGECFCjjMZ7VYsCsO2mgTf/s7IGV561oaW+Ihfukt4Zd2?=
 =?us-ascii?Q?P1RCBn4BQr0Gn8s/ipl5Cyhb9wlpSKf70+OyEPuBJTWf7adqfN8saIShemry?=
 =?us-ascii?Q?6XcaSzRfPaWSnOEw6IyBTLp7DK2hVw+W8WolINxLP2hEKjBcHo1pqSutxH2f?=
 =?us-ascii?Q?iltS9egfIa+rAKfE3bJac28ODVHrFt01fTxu8OpaCQOcJ1hA8EevHFWZhf2K?=
 =?us-ascii?Q?uem0I1/o6VVCnF3E6B+U9kM6ohHujpnFQ9rGwD/gyD04/TN5dCmq32lGxYrl?=
 =?us-ascii?Q?x+EaFmyZ+pRhyzTB5Bc+k/Yt0577sNrB1q+uMHZMIepUhbdz9j1wIs7aw9d5?=
 =?us-ascii?Q?ZKN5scTkP9IWUjL/pZsY7KBzTGSrZtH1xdPfnLygVE6l7DsJxQO5tNkpHrt3?=
 =?us-ascii?Q?ISS8X3aRURZ/zWlVInYnn6hYcOke+TXUpLrGuRAEPQyKPIB3eccAOLbDRYKA?=
 =?us-ascii?Q?ZomIgdsDjk29C6puSJOSpOmzmSN5PSOihE5gkMnRV0ECqpUcgdeZbSwBvhFK?=
 =?us-ascii?Q?R1yvnaLDwi/KS5Dlt+udCvMUp+riTf3KmlD07WKqHQPYLUGcNXZ/KsXIg9XD?=
 =?us-ascii?Q?uBi53SgbMj0q4Y3UNPfBY/nmKT53bfNTHXLJz3UEOrl+QQ1L/jFqehP1pGhN?=
 =?us-ascii?Q?KK/kMkG7Yo4ydQIfHkxHgNXh0GAvsQkzIUf7kbu5Xop+epco95z8TzKpdVBI?=
 =?us-ascii?Q?UvuEKOiHjOAOlntr7p6niNgPX4xlWgWuQtCJKVFW9HcDsWzGkqWVd8u2vwK3?=
 =?us-ascii?Q?GhhA6FV/Sisf2e8GRooSpELJ8TUhYZjDtiXPyLJGNiaCilFutHa4zA3NV+fC?=
 =?us-ascii?Q?YnHXZgOKLsLhVXD13qxx50s1MQs8yVYZXcmZa27Q1trRhGEs8X23PMwS9LpV?=
 =?us-ascii?Q?WZCd7O1NZIfroYU6lSWqP//S9iDVrZ4bonqPmJ5WHRqKs67re9MCS3OqheUn?=
 =?us-ascii?Q?1l0t7ne6NbPEpBkUQVzV7QMGHDTEnb5yAhlmRLsxADjSRsrN5C3a8MCs6YIc?=
 =?us-ascii?Q?2jN60ywVNOl8OSVky58Fwp+IX1IJ9rl/Bie3mWpiqp7XHtsFXi5HS3LvtzzR?=
 =?us-ascii?Q?l1Y5P7ybY2Pt70Tx8a7pV9Mp9UGC2k2ACk0zdmF8WCfAezsuF5mYdtGB0Gvd?=
 =?us-ascii?Q?Gwz7+r1AkiRoOJ+3FdWNiNkWFmSLIcsV7X9rYF3IhDiZeVDi8Zhaw/yOSLn9?=
 =?us-ascii?Q?sM+rw+lfm3d32rHWFLlmN0l7nY8kCCL+aN61s3Uh2HM3YTzGQ2YvKm5GsGzT?=
 =?us-ascii?Q?oB9EF5E4aDWFSAraJKgTUVJ1L07nsyomc9zIClR9ibc8NXJ8Y/yWgiRLjkYJ?=
 =?us-ascii?Q?VqzbP7L/UXCrmiqIPGtSwnTXVAQiHc6rOnN08h6MfxeQM/AgUQ45j3ywoJYG?=
 =?us-ascii?Q?yi5IwwgEGkLAc/Y5PpDvA3wO6Q+n46no906Cz1FNryof6MdOVUTG5y/ouy4c?=
 =?us-ascii?Q?16uuQ+CanFhxvvikEggXqaNE/4PDOekNNhNk97mhBQzYblhEhcoJJrgz0Dtm?=
 =?us-ascii?Q?6mzggiXL53uDPlwnhHNgkBuH08t9SkvqUy00?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:41:12.7493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f61cbeb3-522a-45f7-5975-08dd2f295557
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7559

Existing recovery procedure for PCIe uncorrectable errors (UCE) does not
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
index 2e40fc63ba31..566ad527e61f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -711,6 +711,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pci_channel_state_t state,
 		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev));
 
+/* CXL error reporting and handling */
+void cxl_do_recovery(struct pci_dev *dev);
+
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 79c828bdcb6d..68e957459008 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1025,6 +1025,8 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 			err_handler->error_detected(dev, pci_channel_io_normal);
 		else if (info->severity == AER_FATAL)
 			err_handler->error_detected(dev, pci_channel_io_frozen);
+
+		cxl_do_recovery(dev);
 	}
 out:
 	device_unlock(&dev->dev);
@@ -1049,6 +1051,8 @@ static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 			pdrv->cxl_err_handler->cor_error_detected(dev);
 
 		pcie_clear_device_status(dev);
+	} else {
+		cxl_do_recovery(dev);
 	}
 }
 
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 31090770fffc..bfa5dbbc0e1a 100644
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
+	if (cb(bridge, userdata))
+		return;
+
+	if (bridge->subordinate)
+		pci_walk_bus(bridge->subordinate, cb, userdata);
+}
+
+static int cxl_report_error_detected(struct pci_dev *dev, void *data)
+{
+	const struct cxl_error_handlers *cxl_err_handler;
+	struct pci_driver *pdrv = dev->driver;
+	bool *status = data;
+
+	device_lock(&dev->dev);
+	if (pdrv && pdrv->cxl_err_handler &&
+	    pdrv->cxl_err_handler->error_detected) {
+		cxl_err_handler = pdrv->cxl_err_handler;
+		*status = cxl_err_handler->error_detected(dev);
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


