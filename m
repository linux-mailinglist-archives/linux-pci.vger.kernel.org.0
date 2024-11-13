Return-Path: <linux-pci+bounces-16713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15649C7E03
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 22:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA3DDB23991
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0A818E37D;
	Wed, 13 Nov 2024 21:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wGdGsVGL"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE9C18C353;
	Wed, 13 Nov 2024 21:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731535048; cv=fail; b=qzsNrNruVJE9S5XMgMl5xdJZheK1X9VKEJkBVoMsm++WloIzeNCrUY8UI+v52J36FVhPUCap0fNhuef7Ku1we1iVXb7Qr/r15/4ZdlwZlSxGcokIOW60z5Kdlnm3zQpq+1fDa8Ceabuk7x9vJNNPtuDHP9+cdYdkpUrJQdYH5Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731535048; c=relaxed/simple;
	bh=002E3axX10NWwOscoE8If0labZQsL4xOCkKkWQEdYvY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VA7srIdCBQuzel5EQbkV3S2+U5oIzAI2e8W6JNmYOkAtUJWqe6gpzoj0Y+SuOJ9dhyF0sq1NaV+AqtvUPAm9y+wP2Fk4GbJPv3ZPyQj0eUZPAn0qqGJ6cGnmrAsQsSj0HmQEwDIRE+fPaed1DfMPR5f2sX2w9eSnkyT5jx6ehes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wGdGsVGL; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LduOV1bm9ZG3KaFylspGoxzWkm+3LqobW5/uFuZ5IaqYo5h9mQElFUNnxYEyvB1KClakWKGIqfcVh0fFkLgOyqLOv7rpAQmlcZ0G3sP7cyeYEFBL6KGAMDMrljbi9e8pKT8XDvnsLhIRQj3LvPHm+SXF3EWGHiOU8x6Fmotufv5Xhzu9CgiXU7OshmiRzCcA/EtT3Ri7DuqjLbtRDbJmXzr0WczsmDRJQgv4lQjONyISFZ56HRCCqbPF9+bvlEtTOlmEkYOIkSh/1NgxXc52icnQmtf4tGdbNtAtK/ehqNoMhEEiSgIbDhVjWjv+i5lQlD2ib4fz7Q5b/F+M/DGh5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYAGzdewKAuza5CtTWGSqPUeFUkzZSd2ZjnH9RcAT4Y=;
 b=DfmBv1G9eoy2/WFeF1rKcfKhldXs6Hw2CFNH5ALcK75IVef9tyDqrvTIizpqU3e9KVp3CNYWx3Q+Hmpms33NrIhRe4ctZkRKC99SnBlm6nvsvdXbaW5p4DzlWdfJyaeNQTtMO4CDIk4Ew7ubVf0LeDNCXy9jFqUpAcRWNU8q+i3DQauZ29GUXfwrip1FIbxX1CCTxG5dqEkXfeWdoYW88Eqzj25YKAaOM7dvKJdULYOgOYD/Pi5w29IyRoQPQgoHic7VDh0m4QGbBIFn4rEgKOBnbodH9O+aEZPJzRLHnaxxciA/K9YsOeGtZzhgyNIpVkVJo75MHpuiJqI6Ak8npQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYAGzdewKAuza5CtTWGSqPUeFUkzZSd2ZjnH9RcAT4Y=;
 b=wGdGsVGLNciykq3HiBeAmvhHeM4bZSasyDISQ3ZcXMtNXjdnbn7lAYLQlHQeGoo3VQmNDge939MQXu7WLk2lQ4pUsITw2feodiXirKyl6+n7V6kNR8lcHEJ5kBuCKJ6KrNMfvflsGNGSPMpFGu+UZkgmDsM4SVOKf8soPWIHUuo=
Received: from DS0PR17CA0016.namprd17.prod.outlook.com (2603:10b6:8:191::7) by
 SN7PR12MB8172.namprd12.prod.outlook.com (2603:10b6:806:352::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 21:57:24 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::e5) by DS0PR17CA0016.outlook.office365.com
 (2603:10b6:8:191::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Wed, 13 Nov 2024 21:57:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:57:23 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:57:22 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>
Subject: [PATCH v3 15/15] PCI/AER: Enable internal errors for CXL upstream and downstream switch ports
Date: Wed, 13 Nov 2024 15:54:29 -0600
Message-ID: <20241113215429.3177981-16-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113215429.3177981-1-terry.bowman@amd.com>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|SN7PR12MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e7dbb0-2c60-431c-216b-08dd042e2803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b+B+qh+WCQURa1s/Jcx0djwOmhHTZteGI+I39UJDuGy1/bK90YhG/helZIxk?=
 =?us-ascii?Q?i77cX9TD/5yg7oABA/hqxvzEpwTrxAjoqMZryTwtLa1KMSUXiJUUh2TrhXek?=
 =?us-ascii?Q?HAP9P3U4rIZqKpkgLMMl8qMn4cZoOLFLb0okwzQ+yxKaKQr03xlPGc98JkhM?=
 =?us-ascii?Q?weB9UVo7T41eMDCpAKd52+qExQQS7wrW8fRh5TUGtt3vq8t+I1SVLy/oz5dn?=
 =?us-ascii?Q?lLBWKfRgM7jq4aENuvqde5kftVeaWtx3APryMe2TM6mvpQro7Tn7GcYQi7ad?=
 =?us-ascii?Q?kHB1wQONpK4wUOVeoq5QyRjkuSHeGzUugYulNPeSu2NV6NFmbcckKN7FJDrk?=
 =?us-ascii?Q?IGGKVp+2GBRZw9dMh+I3kUiu98TfG9wx+PRCKfkP6wPl5FK8Tz82bheQzQ9D?=
 =?us-ascii?Q?oxBP15smVvvw33DcKKBWNNLSDpD5Agu0FAX9qGBxdvzLpkmr9x0zDyxXVJJu?=
 =?us-ascii?Q?X93Wr32viuLWuRWejjJDDTuKNAZqnc2ZwogWufPN65EStAQ26Fn+pmMZu+dK?=
 =?us-ascii?Q?3KDdo7M3TbhtjiTvKkd+w6RP1lApwFNqol1RTEzTGDvdt56U1qaEKpZtwxaI?=
 =?us-ascii?Q?m5DVECSNZXsJejSjFJSVRJXPYDnpABwyKexufLaPrEauGNFLz2Z5UWOktmb8?=
 =?us-ascii?Q?LceD+xGObMj4My/7x6Kgzii6baZV0ALXN3Ui6bhSrqQV5eZvh4tT/t20YJCq?=
 =?us-ascii?Q?fmK6Ys5kA0JQFvjlisJQMlAvlJV8duhKCs4c4P/nJjlNoapczWlhLWGjbtgW?=
 =?us-ascii?Q?V160xqLXLuCmRBeRzBi2QYAvXEz+S0FDCySSXwnJlQ4T06/1T27pdkvMd2IL?=
 =?us-ascii?Q?zyQG4dnvbMSQ+tov63BaOY18OHdWiFAToW6tM+5C/pIgvp+cX3iD/Gpc3zkc?=
 =?us-ascii?Q?FT6iCbuYDZxV500SrFmapbKyuuL7tSXFoEWcNIQuTzxqypp3YvqWhW4/MFme?=
 =?us-ascii?Q?mIVDRjX6/TIhGoiF9j5ZctlSWRcS1unsLhgtoV667IhpPqFlwvABd5uHhPfC?=
 =?us-ascii?Q?260aNGaOiJVM9mqj/kWghRVMMNG5ovaSSgt77mqqF6Qd3Ii1HU0RYi8qJ6si?=
 =?us-ascii?Q?MXKdp0gQgnzyBgDZ8+E9EUaivNV60BTpnbFMphHIRcEZSn3J6hNBrdpZ4kpz?=
 =?us-ascii?Q?XXWzfJbogmlKbeminJVb5vjggQA8TYAJK2n57lfACI43899jWfqIXjZzwZkN?=
 =?us-ascii?Q?jS7+ukDIv8QQWuqi1MK1BU4dTz0YwKCyzmIjRhgCdMe7VF5LdDlRCBkHwl3E?=
 =?us-ascii?Q?Lth8FEvZdtRPYASAXJ12dBXEY2whP+XWzfwasj3RNdVG7ojGysl/b/mEtITf?=
 =?us-ascii?Q?+0rh83TbTXGzaRUXHPz/fIgFfhDUIf1QgbLWysEMpQJdlK5PKkHbpkVIT7Fo?=
 =?us-ascii?Q?UHBW2ujbdsM9jXJHBRCxJTPEMy3Sz9RBzu9FtkX1zIyOAmY/Oj5HVxJUOFHv?=
 =?us-ascii?Q?cL3PIhBfbiY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:57:23.9810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e7dbb0-2c60-431c-216b-08dd042e2803
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8172

The AER service driver enables uncorrectable internal errors (UIE) and
correctable internal errors (CIE) for CXL root ports and CXL RCEC's. The
UIE and CIE are used in reporting CXL protocol errors. The same UIE/CIE
enablement is needed for CXL PCIe upstream and downstream ports inorder to
notify the associated root port and OS.[1]

Export the AER service driver's pci_aer_unmask_internal_errors() function
to CXL namsespace.

Remove the function's dependency on the CONFIG_PCIEAER_CXL kernel config
because it is now an exported function.

Call pci_aer_unmask_internal_errors() during RAS initialization in:
cxl_uport_init_ras_reporting() and cxl_dport_init_ras_reporting().

[1] PCIe Base Spec r6.2-1.0, 6.2.3.2.2 Masking Individual Errors

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 2 ++
 drivers/pci/pcie/aer.c | 5 +++--
 include/linux/aer.h    | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index af2ff6936a09..4ede038a7148 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -887,6 +887,7 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
 
 	cxl_assign_port_error_handlers(pdev);
 	devm_add_action_or_reset(port->uport_dev, cxl_clear_port_error_handlers, pdev);
+	pci_aer_unmask_internal_errors(pdev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, CXL);
 
@@ -919,6 +920,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
 
 	cxl_assign_port_error_handlers(pdev);
 	devm_add_action_or_reset(dport_dev, cxl_clear_port_error_handlers, pdev);
+	pci_aer_unmask_internal_errors(pdev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 87fddd514030..1028814379e4 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -949,7 +949,6 @@ static bool is_internal_error(struct aer_err_info *info)
 	return info->status & PCI_ERR_UNC_INTN;
 }
 
-#ifdef CONFIG_PCIEAER_CXL
 /**
  * pci_aer_unmask_internal_errors - unmask internal errors
  * @dev: pointer to the pcie_dev data structure
@@ -960,7 +959,7 @@ static bool is_internal_error(struct aer_err_info *info)
  * Note: AER must be enabled and supported by the device which must be
  * checked in advance, e.g. with pcie_aer_is_native().
  */
-static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
+void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
 	u32 mask;
@@ -973,7 +972,9 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 	mask &= ~PCI_ERR_COR_INTERNAL;
 	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
 }
+EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, CXL);
 
+#ifdef CONFIG_PCIEAER_CXL
 static bool is_cxl_mem_dev(struct pci_dev *dev)
 {
 	/*
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 4b97f38f3fcf..093293f9f12b 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -55,5 +55,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		       int severity, struct aer_capability_regs *aer_regs);
+void pci_aer_unmask_internal_errors(struct pci_dev *dev);
 #endif //_AER_H_
 
-- 
2.34.1


