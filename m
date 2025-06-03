Return-Path: <linux-pci+bounces-28891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FD3ACCBFA
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12A41898488
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AE91DE2A0;
	Tue,  3 Jun 2025 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tLeWP4B+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AE21CDFD5;
	Tue,  3 Jun 2025 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971427; cv=fail; b=Gf6E96vNTt+hq1d3KF75PS74wG+BmalNLo6PwgFYO4Wvx9avplJaMO+D5LHOcPHNkVNYTSMJ20DY8zXxq1GmHqkp/bZ7bD4DdcVY1X4y7kqCeUs1j7Lab8x4e32JD6pR1NplogXNHtGlyLGYmMxopUHXmVd6g9BVPCgTo+z/YEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971427; c=relaxed/simple;
	bh=xmV8wJjWXtIrI2QGFBw5dZ8hgvYP84pgHkfFZKWq/Xs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QqhF8EtAWMA3i3w99Y6y+JL2AHwJA1SofU5TlyW7iAGwYWuL+TZR2GINPwwSfIK4M264BcY7+09j61jj9pYgQDkjlWudk2fXkNQITdP23cnwZSzaGF3nHcOM6m1p4OhCQo5PqUs7pi2XHb+msE8cAY2ocYVOMO8TwHtf3QPACdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tLeWP4B+; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Co64x9H0D9q8pP5xWT9exYioYcWy4npHvazRd+c33t3qUwnJOXd3Uc4axoi7OZVYwL2jMrkYzeRA34KEXl2iGcseYz5N+xzkMza/BMGkc75CB/GkOHOdds3hevsHLqyO8441buKwljUvWIGeSLrHcw+T4C0GmDj9ZlC0c9iCE297h9ZgX+7w0wV/mho8Ld2TnyEfBeiPlZxEYYGjyIjF+zyeJaqS4hn/qmeRh+QmKdW+KgHuvDjMRKKXFlqfCfPnH6W2j7idTwmMVxoCqDQwk/o/SMpQR98dF7Yz0CpX/2SjqgkmR03LKQhX7wQ2MqxOPA67eikXGf8W7AlVEX7/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeL6V0VSnRJB1hZdh9WgHXOhAUGLbV2d2vJFMQngWlI=;
 b=jiUiL+4OTDNcIp3Gxwv03EY3GugJfqxISM8wELAQTcIhLPkk3bQUAl2d7teogCR0oRY8Iq8hfNRkkvvuiezrCfazEwkCDA+WCWNPyjNJIY1OVKwywb2Elkda14UwzgjNnmBW2J8h6x9y1vZJUr82l8RkksKCyUJivzxZ8Pi4f8chImq4E9K/tS4CZXgFIs+wox/AQGQ9T+EY13azjt9YE8MHm/VoPRt0aPmRI5vLD2Svlywvc5z6U0ZBwc3SVRJsYFFCGejFWJc6v7hh8u4cvZTkcrOiUNZ7i7674hWo9vJM9cKeBUuDxLkPN7/8tlnuAAsTTv83Z9ZeFY/w5m614Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeL6V0VSnRJB1hZdh9WgHXOhAUGLbV2d2vJFMQngWlI=;
 b=tLeWP4B+BqYao8UFIIYJTGdxcLnTesva8toojwSb1S08CAFLXo/zcjP11QaGv8K1gfEn2+LzX6iVHymFngwQOFoH1v7+XVo+HEf2tvvPYK/PNjSw82uD9raxsyOZrsrE8CQjomzlFgbhdy+qCgPvbuYdgzn3zR12j89hi2r3gEc=
Received: from BL1PR13CA0200.namprd13.prod.outlook.com (2603:10b6:208:2be::25)
 by DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 17:23:42 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::8e) by BL1PR13CA0200.outlook.office365.com
 (2603:10b6:208:2be::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Tue,
 3 Jun 2025 17:23:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 17:23:42 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 12:23:41 -0500
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
Subject: [PATCH v9 05/16] CXL/PCI: Introduce CXL uncorrectable protocol error recovery
Date: Tue, 3 Jun 2025 12:22:28 -0500
Message-ID: <20250603172239.159260-6-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|DM4PR12MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f43e6c-4a08-4ed7-2729-08dda2c36335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LFRHsB1ZKqPVvSrFkf7Qt3PSKe8p/TzFGaiSN7kdvMeW77/j/GGnbO/iS7lG?=
 =?us-ascii?Q?Dzr46n5Je2bapeoePWYgwXNWTS3g+aQnI10XyvjKqfmJTeK2JQbWGYkWSESM?=
 =?us-ascii?Q?1DzRWs327DgNdbeS1II3U/0Gu6+hv5jB1ygkxLBH85e3BSgp4lIcXVmBTQ8z?=
 =?us-ascii?Q?8ZuGPWZ92IwVdYQaF3aADlIEVXENrVx4Tf8HIpiQ/B8QDpSBhfkJiohNLzRo?=
 =?us-ascii?Q?i8m5lfNYzsZTl40WB24HyJFjrzKeOiuz3zyDw88QnU8vBd/9BldpwREIPzn6?=
 =?us-ascii?Q?6PfolHdq5NKQHGdjIXr+MH441OXCbWzVd6/wLtz4Im3RDMHMZyWBwoQbddGa?=
 =?us-ascii?Q?cnwWRmHs6dHfEABhIX3UaAYsauQwAAmJOWI75RYfkohd3mVa5kaPJn3VQrmy?=
 =?us-ascii?Q?2NfymlpjhEXgQTdczKCOqY88D8TCXbRG/Jc5WOwXSqf+Ayy2lv5Lhj0ydiVC?=
 =?us-ascii?Q?yjRxxp8/WxLDUnMJ0S1YzA6cYomuFOSumESVLABZMam+ITu86hQX9KeDI/qs?=
 =?us-ascii?Q?xG6WTqoWT/csYC38ZO+71ux2EuVP5xu1mqAudJSJSMI7xanE8fW6BEa4jqee?=
 =?us-ascii?Q?WeHp3aTtP20Mu+U4rmLqvHBxzflK6QMrLCE0PUue/T0xH9XtXtiODDJMolAC?=
 =?us-ascii?Q?QsGzKE8Pdiol/FiBJVxuqTb9IeTL+Dqs2AXgWHrqe3Xoel2aqSowzNYsLtfQ?=
 =?us-ascii?Q?vvkGaXRRz+FvD9jE4Z1mIVFnASzjHXVBWUpPDkFpCnLcWMuw3jAxRRiGun4F?=
 =?us-ascii?Q?d+P89ttn5EvqC8EGTT079PB0Bs7uaA4puoEzHtixJdbNDdCPcltrgBXvjh1w?=
 =?us-ascii?Q?aT5vzuMWSC12wd+YLeNzj4XeUobIry7pqfFG6W9X1I+dKpfTwmPBy2Iq5gtf?=
 =?us-ascii?Q?ddHiDZ+LWXjqVlRAi8q0Me8mUWzOj1WjdAoTVtu9lfoYhQS0ikj00HgL1cYV?=
 =?us-ascii?Q?OoOnwa7CIcdoH7P6wTY6Djhdn8rieDYWT9wZvZSrLfM7J+DToAn9U+88T4UB?=
 =?us-ascii?Q?0B9Ve0KcRnFp6t2yORZfnK7oj5eexuITtuy33VF3z1Vnntq2LYlFB77mFuQs?=
 =?us-ascii?Q?okOOOk9BSuv+yB1Rhn6JbTYSV7UWNK2q4H6N9Jr/g0fsSkhri7UA+N1veKJ4?=
 =?us-ascii?Q?YB1ytKgI9d+nphSS1IHMIqC86gjJ1gT18WLrP5XMW2VTaDqk0VTjKCUkG5kY?=
 =?us-ascii?Q?57UMPL1L1u6lVoQNlEr+lVVXMI2VcZX8Jrljv4Kg0FoKtCmTNljb9a8m8ld5?=
 =?us-ascii?Q?7ZVVkQnfxu0pZPs58Df5jQ3VXxQaOsg0c9G622w2JRzf19p+yslT/SQqFf32?=
 =?us-ascii?Q?QIxSETMLTbWYsb0GTMc1lHgVouxZWhRZkLyP4gJ+2a3KPGnVvxwmoGa82GYC?=
 =?us-ascii?Q?+v5fbl26Ed2uLS9oirrQyRyqk72PN+pgTQYBRjyY6n5Z+fVZdlWvdxEW6qmr?=
 =?us-ascii?Q?vNXZ5kZmKM6EU0FWJttVDbd9FBC+jaVrYGsKoO2sVbeRjcnIwdRq9cjcR+sc?=
 =?us-ascii?Q?ZpfmXUAv3ZfIaRANOrMsm5Q3jwAy2Q2GLNsb5hDmXd2clzRZICzMrIWRRg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:23:42.2783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f43e6c-4a08-4ed7-2729-08dda2c36335
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557

Create cxl_do_recovery() to provide uncorrectable protocol error (UCE)
handling. Follow similar design as found in PCIe error driver,
pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs
as fatal with a kernel panic. This is to prevent corruption on CXL memory.

Copy the PCI error driver's merge_result() and rename as cxl_merge_result().
Introduce PCI_ERS_RESULT_PANIC and add support in the cxl_merge_result()
routine.

Copy pci_walk_bridge() to cxl_walk_bridge(). Make a change to walk the
first device in all cases.

Copy the PCI error driver's report_error_detected() to cxl_report_error_detected().
Note, only CXL Endpoints are currently supported. Add locking for PCI
device as done in PCI's report_error_detected(). Add reference counting for
the CXL device responsible for cleanup of the CXL RAS. This is necessary
to prevent the RAS registers from disappearing before logging is completed.

Call panic() to halt the system in the case of uncorrectable errors (UCE)
in cxl_do_recovery(). Export pci_aer_clear_fatal_status() for CXL to use
if a UCE is not found. In this case the AER status must be cleared and
uses pci_aer_clear_fatal_status().

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/ras.c | 79 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h    |  3 ++
 2 files changed, 82 insertions(+)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 9ed5c682e128..715f7221ea3a 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -110,8 +110,87 @@ static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
 #ifdef CONFIG_PCIEAER_CXL
 
+static pci_ers_result_t cxl_merge_result(enum pci_ers_result orig,
+					 enum pci_ers_result new)
+{
+	if (new == PCI_ERS_RESULT_PANIC)
+		return PCI_ERS_RESULT_PANIC;
+
+	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
+		return PCI_ERS_RESULT_NO_AER_DRIVER;
+
+	if (new == PCI_ERS_RESULT_NONE)
+		return orig;
+
+	switch (orig) {
+	case PCI_ERS_RESULT_CAN_RECOVER:
+	case PCI_ERS_RESULT_RECOVERED:
+		orig = new;
+		break;
+	case PCI_ERS_RESULT_DISCONNECT:
+		if (new == PCI_ERS_RESULT_NEED_RESET)
+			orig = PCI_ERS_RESULT_NEED_RESET;
+		break;
+	default:
+		break;
+	}
+
+	return orig;
+}
+
+static int cxl_report_error_detected(struct pci_dev *pdev, void *data)
+{
+	pci_ers_result_t vote, *result = data;
+	struct cxl_dev_state *cxlds;
+
+	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
+	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END))
+		return 0;
+
+	cxlds = pci_get_drvdata(pdev);
+	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
+
+	device_lock(&pdev->dev);
+	vote = cxl_error_detected(pdev, pci_channel_io_frozen);
+	*result = cxl_merge_result(*result, vote);
+	device_unlock(&pdev->dev);
+
+	return 0;
+}
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
 static void cxl_do_recovery(struct pci_dev *pdev)
 {
+	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
+	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
+
+	cxl_walk_bridge(pdev, cxl_report_error_detected, &status);
+	if (status == PCI_ERS_RESULT_PANIC)
+		panic("CXL cachemem error.");
+
+	/*
+	 * If we have native control of AER, clear error status in the device
+	 * that detected the error.  If the platform retained control of AER,
+	 * it is responsible for clearing this status.  In that case, the
+	 * signaling device may not even be visible to the OS.
+	 */
+	if (host->native_aer) {
+		pcie_clear_device_status(pdev);
+		pci_aer_clear_nonfatal_status(pdev);
+		pci_aer_clear_fatal_status(pdev);
+	}
+
+	pci_info(pdev, "CXL uncorrectable error.\n");
 }
 
 static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cd53715d53f3..b0e7545162de 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -870,6 +870,9 @@ enum pci_ers_result {
 
 	/* No AER capabilities registered for the driver */
 	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
+
+	/* System is unstable, panic  */
+	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
 };
 
 /* PCI bus error event callbacks */
-- 
2.34.1


