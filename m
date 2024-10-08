Return-Path: <linux-pci+bounces-14012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174049959F3
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 00:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C7B1C21E80
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 22:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E0D217307;
	Tue,  8 Oct 2024 22:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZtVHY6yW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A31215029;
	Tue,  8 Oct 2024 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425908; cv=fail; b=gMs0RWgIKZLgDaG1sxQfmxqNZbZp0kla4iRgMtaNLX1PVBTQflahrPHd6xNYDvwfjkf44MKWYaA7S/GgFuGWkqNqmCKegaYQDKF6V78xzF3rlXQt14sdcVOB4IVYdaZrPTDfHmKOy052bh5hCcK2gAhi5BlMAgpcX2TP7WGShRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425908; c=relaxed/simple;
	bh=Kkn8mC2FDHoj+bh80mhCXIfMEzekjwKBPe42FzZ3mzQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGtEGcXt8LELdqT/NbHIktdSGgwIj/Kfob7QEqF0QkUd76YNyWFk9iud9A8LMzDShh4ozwfxZcbKK8CA53R2+epdTT6J44KLawRDDCBMIC4VOBMx8ij7ReOcxeDzPtEWe1o4f7+GK8yZ4JdsGoukX55zxFMiEwt5RddI0+wN0Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZtVHY6yW; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xblk+eptCqKPPIkknDX/4BPMyXttFssdQAlMFdiIUWhVIqnZYrDZYFsDQJ2NIQFCYxUKthIb7oqgd27LxKcvy6y69Pm/fI+nJWdZ6STX2BPo4A73bmHxGS14gHyE5FHiEUQ55MyUVf/98gFASIkSQEqWqDnp92uPUq9+blT0SrVtn19xduikxV2k2zqvhhmteTbCX5nD9ndkXmKa9fzdvjEcPpGlp6bIXAOso+JQjpZfxTp3gYVxQZurncMEQyh2rUWmyt+fdNlxxac/fUpboTPCftoVa2qSY4FGw5HWU+oMiCy4tCWy9YuZMjxfM6NIcFn0f/0K4XQPDA9W6gC2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZfNXx/wbIYcbDTbyhbPWoMTc4wLgREmLHj6HiSJI50=;
 b=QuVY0o4I0grWXgHMhmv92DaM8/NauU8r6PkSHVRHKMY4st5vzd6jto4WCysJ4el/hro7FOBMC7UOjsxpxglSB+Qec8FAyFtbs7M6Ku57p6/pAAl8xs2mK0C2IvJ9MeqEbaNaS+fFfjqF0gpoDuHiSwlbeBse2RIb5AkFChF1438XXkHek94e2WP+4HWqLT2+zC3TcMRdjqxCEjkFwrxSISp+zgl1ARz1eaj56njJZ0xzHNYE35vo1iUrK7YDa5G9jbYbL5y3oSY+1xlSNfdrz3/NNBeNFuy8iXToyfrFm8sB+Kdvd4HKVvn/t+IaGidcp/qBI/lFf1ejsRtf9F/NyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZfNXx/wbIYcbDTbyhbPWoMTc4wLgREmLHj6HiSJI50=;
 b=ZtVHY6yWaD3rMeiLsIr5j1I7vaW6Ugdu8N8GLkafIhyjj25WK06TefzSt1V75dOeGLDpWE6dTtD+IW/hJh3dNEZ8o4+ZB+rBLxIux7YR5Z4AiFILYhBvDZVRosB99tnYbqm6ejHg8CcexjofnOqvCOHfg6eKIO9sb8XE6OeRE8E=
Received: from BLAPR03CA0081.namprd03.prod.outlook.com (2603:10b6:208:329::26)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Tue, 8 Oct
 2024 22:18:21 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::32) by BLAPR03CA0081.outlook.office365.com
 (2603:10b6:208:329::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 22:18:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 22:18:21 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 17:18:20 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <smita.koralahallichannabasappa@amd.com>,
	<terry.bowman@amd.com>
Subject: [PATCH 07/15] cxl/aer/pci: Add CXL PCIe port uncorrectable error recovery in AER service driver
Date: Tue, 8 Oct 2024 17:16:49 -0500
Message-ID: <20241008221657.1130181-8-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: e71c4f5c-825e-4a2c-f40c-08dce7e71e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YpElI/AzMKmrd5q60FXs6QWsCnrjNQ4UagVjpVuNkPYj9p1MHOp3V15wAQQN?=
 =?us-ascii?Q?ew+HJHNlZqyRzHoNNrvK+WJqXP3YlJjrM1GTPlVC1igoQGg7N1DApNvUAoin?=
 =?us-ascii?Q?nv8fUCDN6wiak88klOiEXOjG7A7doCk4eFgqTy/Olyx1dRvFddt+Qrydl7qK?=
 =?us-ascii?Q?s1OkuO1PI8TQfXM295zqS4FNKbRvKHEQ2kzaYVlilrl0/+AxaSyA5dhWvE0V?=
 =?us-ascii?Q?CM00e4sCQRPvHQg2jJjcyEcU9ahnqgp8/Dx2bWxwnNbDvcYco2Yf7WKXFDxj?=
 =?us-ascii?Q?VBPzouHx1pLb5EGHzi4HpxlCDemjAwq1rqATiJQ9QHXxIFd/XyTFB2/gunen?=
 =?us-ascii?Q?Mj5dx/IXYhiQT1CXEB0TzJdo4TjaIn83+ZgI3n7mB4imupW30HraPwos5sdK?=
 =?us-ascii?Q?ZT/EugddHZiAFIeoVNCwwfHSPNqTB7aISz7JaN9IARP4Ja/qIrN1FnF1UfQJ?=
 =?us-ascii?Q?KTzOUjL7qKJHo2czOSoDIfU/QqLS5WpC6ybiiG3jROUmzEEDHfNQV4/LqM2n?=
 =?us-ascii?Q?FhD/wu4GTicZvV396YL0vcubt8lfN6oJiXfRC8RvM67D84fmZW41c+tur3XV?=
 =?us-ascii?Q?rke3in2mFcx+HAtHLuwl3GLrdbSLrcwfTT+7NE8B8tN3dKcBsWPkR4pc+iS7?=
 =?us-ascii?Q?x/zscLoYsCGFI1ot62KNhs1ygzCT8MYySpIV824ZnHCYRjwzLYTMUcRp0+kP?=
 =?us-ascii?Q?320U3VK8l7DyLV/xpbtBeJOpSd+/a9bl33GhGSu2LQo++12SRQxjUwkdXuTC?=
 =?us-ascii?Q?zNjp8FvGTEJTxFiJ7IJXAyIzlAsVALEVDVIQdtPqnbQOCUPbJOLMt5aaFTkX?=
 =?us-ascii?Q?Xo2YDEWNJZxuNSYsHf0Us7/PP/L3pRSgLhAECp4wDnOoy5oJVYSPU56Rg/AC?=
 =?us-ascii?Q?ClvGEgF7b5qDCk2LPa39UdnvaeqPvBPkAyVQqAgL/J+LuUG3v9NZJhvKga4k?=
 =?us-ascii?Q?0sTac0tgMrxgTNj92f2Bmo+7GM12kR3s68lfrT3PtrODxlQmf4DcwYFNLcBJ?=
 =?us-ascii?Q?yyJKD89LGcSkAzRuqdGednrSgkpdXc1uMnLW4PwIFgRBZJcu/M9pwmwRBptP?=
 =?us-ascii?Q?QOHhn2DXZNIZRPk0c6FCaVkyGct2uAjeikU9RId769lZ8D5dfAAUhh/wdm4u?=
 =?us-ascii?Q?d2UI2i6cPGTzjyN/2n4IufAcTomfJyzS54wetIEIJ1x/YfTQjW7X4bemAkMf?=
 =?us-ascii?Q?jOoc0DRgWd7JNsDONQ06Y+OdFvkgHVQ9j/djMhcWN1ge0Wzsh/FHbD4z4M3x?=
 =?us-ascii?Q?I6kbh+r1R7yBAlSJsCnjxapfti+V+zPIapYaQZUIKZuVjY5J0vWfrzD3Sh3a?=
 =?us-ascii?Q?2uD1rgV6yDZOmKKlKsLZWqB9G52iQf/eBxfL+X+gTyVCCysp+8P326CtxHSS?=
 =?us-ascii?Q?UGTdxvDpDfQUrJaNbT1Q17/XkVsA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:18:21.4608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e71c4f5c-825e-4a2c-f40c-08dce7e71e86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269

The current pcie_do_recovery() handles device recovery as result of
uncorrectable errors (UCE). But, CXL port devices require unique
recovery handling.

Create a cxl_do_recovery() function parallel to pcie_do_recovery(). Add CXL
specific handling to the new recovery function.

The CXL port UCE recovery must invoke the AER service driver's CXL port
UCE callback. This is different than the standard pcie_do_recovery()
recovery that calls the pci_driver::err_handler UCE handler instead.

Treat all CXL PCIe port UCE errors as fatal and call kernel panic to
"recover" the error. A panic is called instead of attempting recovery
to avoid potential system corruption.

The uncorrectable support added here will be used to complete CXL PCIe
port error handling in the future.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/pci/pci.h      |   5 ++
 drivers/pci/pcie/aer.c |   5 +-
 drivers/pci/pcie/err.c | 150 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 79c8398f3938..d1f5b42fa48d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -632,6 +632,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pci_channel_state_t state,
 		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev));
 
+/* CXL error reporting and recovery */
+pci_ers_result_t cxl_do_recovery(struct pci_dev *dev,
+		pci_channel_state_t state,
+		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev));
+
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9b2872c8e20d..81a19028c4e7 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1060,7 +1060,10 @@ static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 		if (cxl_port_hndlrs && cxl_port_hndlrs->cor_error_detected)
 			cxl_port_hndlrs->cor_error_detected(dev);
 		pcie_clear_device_status(dev);
-	}
+	} else if (info->severity == AER_NONFATAL)
+		cxl_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
+	else if (info->severity == AER_FATAL)
+		cxl_do_recovery(dev, pci_channel_io_frozen, aer_root_reset);
 }
 
 static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 31090770fffc..de12f2eb19ef 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -86,6 +86,63 @@ static int report_error_detected(struct pci_dev *dev,
 	return 0;
 }
 
+static int cxl_report_error_detected(struct pci_dev *dev,
+				     pci_channel_state_t state,
+				     enum pci_ers_result *result)
+{
+	struct cxl_port_err_hndlrs *cxl_port_hndlrs;
+	struct pci_driver *pdrv;
+	pci_ers_result_t vote;
+
+	device_lock(&dev->dev);
+	cxl_port_hndlrs = find_cxl_port_hndlrs();
+	pdrv = dev->driver;
+	if (pci_dev_is_disconnected(dev)) {
+		vote = PCI_ERS_RESULT_DISCONNECT;
+	} else if (!pci_dev_set_io_state(dev, state)) {
+		pci_info(dev, "can't recover (state transition %u -> %u invalid)\n",
+			dev->error_state, state);
+		vote = PCI_ERS_RESULT_NONE;
+	} else if (!cxl_port_hndlrs || !cxl_port_hndlrs->error_detected) {
+		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
+			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
+			pci_info(dev, "can't recover (no error_detected callback)\n");
+		} else {
+			vote = PCI_ERS_RESULT_NONE;
+		}
+	} else {
+		vote = cxl_port_hndlrs->error_detected(dev, state);
+	}
+	pci_uevent_ers(dev, vote);
+	*result = merge_result(*result, vote);
+	device_unlock(&dev->dev);
+	return 0;
+}
+
+static int cxl_report_frozen_detected(struct pci_dev *dev, void *data)
+{
+	/*
+	 * CXL endpoints report using pci_dev::err_handlers.
+	 * CXL PCIe ports report using aer_rpc::cxl_port_err_handlers.
+	 */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT)
+		return report_error_detected(dev, pci_channel_io_frozen, data);
+	else
+		return cxl_report_error_detected(dev, pci_channel_io_frozen, data);
+}
+
+static int cxl_report_normal_detected(struct pci_dev *dev, void *data)
+{
+	/*
+	 * CXL endpoints report using pci_dev::err_handlers.
+	 * CXL PCIe ports report using aer_rpc::cxl_port_err_handlers.
+	 */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT)
+		return report_error_detected(dev, pci_channel_io_normal, data);
+	else
+		return cxl_report_error_detected(dev, pci_channel_io_normal, data);
+}
+
 static int pci_pm_runtime_get_sync(struct pci_dev *pdev, void *data)
 {
 	pm_runtime_get_sync(&pdev->dev);
@@ -188,6 +245,28 @@ static void pci_walk_bridge(struct pci_dev *bridge,
 		cb(bridge, userdata);
 }
 
+/**
+ * cxl_walk_bridge - walk bridges potentially AER affected
+ * @bridge:	bridge which may be a Port, an RCEC, or an RCiEP
+ * @cb:		callback to be called for each device found
+ * @userdata:	arbitrary pointer to be passed to callback
+ *
+ * If the device provided is a bridge, walk the subordinate bus, including
+ * the device itself and any bridged devices on buses under this bus.  Call
+ * the provided callback on each device found.
+ *
+ * If the device provided has no subordinate bus, e.g., an RCEC or RCiEP,
+ * call the callback on the device itself.
+ */
+static void cxl_walk_bridge(struct pci_dev *bridge,
+			    int (*cb)(struct pci_dev *, void *),
+			    void *userdata)
+{
+	cb(bridge, userdata);
+	if (bridge->subordinate)
+		pci_walk_bus(bridge->subordinate, cb, userdata);
+}
+
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pci_channel_state_t state,
 		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
@@ -276,3 +355,74 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	return status;
 }
+
+pci_ers_result_t cxl_do_recovery(struct pci_dev *bridge,
+				 pci_channel_state_t state,
+				 pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(bridge->bus);
+	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
+	int type = pci_pcie_type(bridge);
+
+	if ((type != PCI_EXP_TYPE_ROOT_PORT) &&
+	    (type != PCI_EXP_TYPE_RC_EC) &&
+	    (type != PCI_EXP_TYPE_DOWNSTREAM) &&
+	    (type != PCI_EXP_TYPE_UPSTREAM)) {
+		pci_dbg(bridge, "Unsupported device type (%x)\n", type);
+		return status;
+	}
+
+	cxl_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL);
+
+	pci_dbg(bridge, "broadcast error_detected message\n");
+	if (state == pci_channel_io_frozen) {
+		cxl_walk_bridge(bridge, cxl_report_frozen_detected, &status);
+		if (reset_subordinates(bridge) != PCI_ERS_RESULT_RECOVERED) {
+			pci_warn(bridge, "subordinate device reset failed\n");
+			goto failed;
+		}
+	} else {
+		cxl_walk_bridge(bridge, cxl_report_normal_detected, &status);
+	}
+
+	if (status == PCI_ERS_RESULT_PANIC)
+		panic("CXL cachemem error. Invoking panic");
+
+	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
+		status = PCI_ERS_RESULT_RECOVERED;
+		pci_dbg(bridge, "broadcast mmio_enabled message\n");
+		cxl_walk_bridge(bridge, report_mmio_enabled, &status);
+	}
+
+	if (status == PCI_ERS_RESULT_NEED_RESET) {
+		status = PCI_ERS_RESULT_RECOVERED;
+		pci_dbg(bridge, "broadcast slot_reset message\n");
+		report_slot_reset(bridge, &status);
+		pci_walk_bridge(bridge, report_slot_reset, &status);
+	}
+
+	if (status != PCI_ERS_RESULT_RECOVERED)
+		goto failed;
+
+	pci_dbg(bridge, "broadcast resume message\n");
+	cxl_walk_bridge(bridge, report_resume, &status);
+
+	if (host->native_aer || pcie_ports_native) {
+		pcie_clear_device_status(bridge);
+		pci_aer_clear_nonfatal_status(bridge);
+	}
+
+	cxl_walk_bridge(bridge, pci_pm_runtime_put, NULL);
+
+	pci_info(bridge, "device recovery successful\n");
+	return status;
+
+failed:
+	cxl_walk_bridge(bridge, pci_pm_runtime_put, NULL);
+
+	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
+
+	pci_info(bridge, "device recovery failed\n");
+
+	return status;
+}
-- 
2.34.1


