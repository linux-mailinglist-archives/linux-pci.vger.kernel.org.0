Return-Path: <linux-pci+bounces-21197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7673FA31555
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92547166401
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3C02641D6;
	Tue, 11 Feb 2025 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ytl1fENu"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BCC263893;
	Tue, 11 Feb 2025 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301966; cv=fail; b=VNFDta3X1SMebGnKZqwdi4e82swbvzmBaJa7RqgWBV2G7MDXdK32l8kTYDczvx99IKXOC3j+uK0wDQ8tQkEnu8+ebTB+ERl0uHGs43q5MjxvYcUO0od14ERyVKwldYvumqa44t8aNm11iWCGTeSrv0jtGw1/5RUDbCXgfznGd0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301966; c=relaxed/simple;
	bh=TC8ZPMbeQrML8U1xS0lJCU468QUf9hew4qETVb7fObk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUQCpcXogZkUpUepvG7x7SgufKozhchaaMD/mdWO3v6KJS6BKyjg0lAHnd/Thm+FJpBU+d6sa0ALDSPHZ3Bb5l1cOgjLU4Y0agK4QRs/ROOwwOtrhrxloLjMa1/njJDCzT2D8CE6824YJ56WfcIlBrrcKVsqbJUwh8jcq14HBmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ytl1fENu; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMkVDYQCj2Dj3kL7Pew+xaMBWtHe8RHo3gjOvzIUWiA8Voe4MQ2T0QWpiw9zu5j46p2xRRALTwh4aK3r2CBOvUiw0wpYnn/9Kt0Ogo8VfsaoF1eRSvrUCEcQ+pnRZw2PgtgLQY/Hl8h/o2hs8aAV1qAbLCF+5cCBhxCquQtR4DYEoljg5s/J4X0SCjCB+g+wUxlTrq22aei9uLsfavUus9+5pQr1a/ILf+LaTRRouRrvZ4JJCFjq0tM/TA1sEuPm68W0YTG3D8SNkwzauYo+mnWdfXpmI+cDC9DfhO2PKv9JAbMV1E1abDK6fqNRdtivZ+oM8RqRQDCBcOazRafMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFyUtHYjqdQXlQ1QFONP4Ty6KgTyHwieMUuBdADbXlI=;
 b=xmSE5fohF8C9sN/+VnRBHXqbZhK3UTSr8kSMnXBuJDgpzTb9x0dAUBh72qhYXF1jDU+/F/NfpamNhZ9gS3Xw3lGW0TfYQlSD8RBzNq4y7iV6msPde80kITuY3YUklVfewLG9AqJSwRnOICkFHGPCbA3obvoCJIYoPo53fW2lMoyge/+q9XTDN4IIJEEJSuBlYlk2nkS3+Excro8EEUmAo7YbFeb+Odc6Szea0nobyxYJf66kRycCF5XgFUtWm1OqyNslG1nBeQj4NuqLBGS8+gBEVZNp2awziB/vngNNS/c71gHfMaNfTvvuRQPWKv7ZT6nKUITQbhAzkT+hDD7UMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFyUtHYjqdQXlQ1QFONP4Ty6KgTyHwieMUuBdADbXlI=;
 b=ytl1fENuHnS4nVhrUV9zRx8Ty6KCW5Q8CBv5lQ3poUiv460UOU5oU1nsfzNaLPFeNjf/A02Tedsp12grB5+/QsKT0yaEcj8qQUE5BCO1pm+VsxXJADawWT8lh7mLHReegWQzbAOg+ZscWxDJoDB6gAlnpMoj8lW8xE06Ek1w0K8=
Received: from BYAPR07CA0001.namprd07.prod.outlook.com (2603:10b6:a02:bc::14)
 by SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 19:25:58 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::27) by BYAPR07CA0001.outlook.office365.com
 (2603:10b6:a02:bc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 19:25:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 19:25:57 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 13:25:56 -0600
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
Subject: [PATCH v7 06/17] PCI/AER: Add CXL PCIe Port uncorrectable error recovery in AER service driver
Date: Tue, 11 Feb 2025 13:24:33 -0600
Message-ID: <20250211192444.2292833-7-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211192444.2292833-1-terry.bowman@amd.com>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|SN7PR12MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: cedd33ca-1b43-40f6-d3f1-08dd4ad1e95a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I3wXSrpsnbKFb59tJfd+IjN51MixEOiYE1DXtJdqXOspkZFS+aFfGTn5CB9D?=
 =?us-ascii?Q?RMyi6SkcyfGkfkWEWXoQoKKPfNRq9cN9AxbtCmP5FPugzPPdcofDHbxtYfv6?=
 =?us-ascii?Q?rkPF7TQdgorm6OB/2R571hIqvLbbpMK6dPRUZ6RVxclNN+AAFcOta5227Dac?=
 =?us-ascii?Q?+RcwXLEYn9XEjoYS8gxx0EZ55/yaRYcxCyPSVuoNeyj0zXbBshs/JJZqGuxJ?=
 =?us-ascii?Q?qFNYGrghzH3EYhEnuFQNaFbDvo9iapUl0Ta/v1Asjd28Ylq8sNNKpQZbtR0w?=
 =?us-ascii?Q?9jwLBLGhRBM2NxNf7GfltG1phJOsfBKUZGCQ6+V1JgKJwU2xS2Zb1GVbkbC7?=
 =?us-ascii?Q?1DL7MrJDmnxcJCQCoH62WJbhbcTAle6y6W8c2LXle8QL14PYRGAqw77vquK3?=
 =?us-ascii?Q?ZlKWA40XpVuLIYfjUWSakebQC6ehA5NtbEoIePRkd0wZjp6HuSU/TadoRS+n?=
 =?us-ascii?Q?vQLp8QR1dCLm4KWUgJ6ysoPXW3mkelhmWSiGJqdXMEDfWcOmPzql8gRZPfVf?=
 =?us-ascii?Q?0j+ipyXfmUsNoWVScYLlfGTEcX2GXM09IotMS3bvS2qIZ/GVJAXL+8IOfORu?=
 =?us-ascii?Q?sztoouQw3Fv20d/j5lwB6snnsQYHeSL8pdgPLCbv4hf3MDNizrgIUaDPvXuK?=
 =?us-ascii?Q?SdYz3PbFyF7/6TizeyPgpKAOmx5Q//R9Ah8Sk0rMKf0uTLeBMATlqOVrTlS9?=
 =?us-ascii?Q?aExn7wi344HzMGCpSaA3ilclWLM3Bv88o5aX9R2ZPYQ9Ge9UL1IIo5jTLDcx?=
 =?us-ascii?Q?tefPek65Pb3b1lAkuQ/JZvfGedrelcpRFmkMqoXv8GYZzM0+y3uYhE91ALPT?=
 =?us-ascii?Q?9gA0/F+kut2oOBR0vriDWRcNLMq+NdLlA82XTlgR3i9jknHL37pMV/5tZRh4?=
 =?us-ascii?Q?/1MWjjZAZ86RwTzeh6RwyE2G/R7NxEe5T7/W7pM+baFE1l1Qa5PdzU8raiCh?=
 =?us-ascii?Q?5nL2oTO7fkhSIA2QYACizfG9IaRwEPS4boHlP7pnAjdgzi4gev6SEvBkStmW?=
 =?us-ascii?Q?f/+kH/+g7ysbjcPOxVmzybaMSrivTqBoPk13MAtPAfL5rW3IemMhqN+uQLjd?=
 =?us-ascii?Q?LoN3F78M3VcHKOPevtMGjrKFjMc9FRJsgsY3QihocaPed6RnVHB4O7Xkt9bq?=
 =?us-ascii?Q?2/GDzX8PKfinpXUR+YslKzWurg8k4ERN4nLob1Crv4joZK2hUr+m9HEPrB7d?=
 =?us-ascii?Q?8xdKR6UvPEVO4eoAsvL0n9WT+Z9VzMU836IR8rmeXSYqJaH5Umcnl38eMElZ?=
 =?us-ascii?Q?er9glLKUwY0HLJmdA3A3GyZYXxbiErg30i+YEszhpFMXDpGXVhCOYCsUTu3Q?=
 =?us-ascii?Q?fTWyz+iOuRZ8Ne27bba+PaSNKvAEZ5YJgDtC7nIe8o0WahCZM9w49y+6/En1?=
 =?us-ascii?Q?+IYOD8big84IQcufT6rsUChnie+FcXXQmh4V+jjqLpJX2NuoX5my2neIa62G?=
 =?us-ascii?Q?gREX0QXoT6yiu4vnuGaEVayMsahcs8iB/9sLYANTMaHOPoTkYDENO2Xj9+1+?=
 =?us-ascii?Q?IDAhNm3zzNpS9TnW6osKn/OLvn0US3jqseVW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:25:57.8580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cedd33ca-1b43-40f6-d3f1-08dd4ad1e95a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021

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

pci_walk_bridge() is candidate to possibly reuse cxl_walk_bridge() but
needs further investigation. This will be left for future improvement
to make the CXL and PCI handling paths more common.

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
 drivers/pci/pcie/aer.c |  4 +++
 drivers/pci/pcie/err.c | 58 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h    |  3 +++
 4 files changed, 68 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 01e51db8d285..deb193b387af 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -722,6 +722,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pci_channel_state_t state,
 		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev));
 
+/* CXL error reporting and handling */
+void cxl_do_recovery(struct pci_dev *dev);
+
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 34ec0958afff..ee38db08d005 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1012,6 +1012,8 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 			err_handler->error_detected(dev, pci_channel_io_normal);
 		else if (info->severity == AER_FATAL)
 			err_handler->error_detected(dev, pci_channel_io_frozen);
+
+		cxl_do_recovery(dev);
 	}
 out:
 	device_unlock(&dev->dev);
@@ -1041,6 +1043,8 @@ static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 			pdrv->cxl_err_handler->cor_error_detected(dev);
 
 		pcie_clear_device_status(dev);
+	} else {
+		cxl_do_recovery(dev);
 	}
 }
 
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 31090770fffc..05f2d1ef4c36 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -24,6 +24,9 @@
 static pci_ers_result_t merge_result(enum pci_ers_result orig,
 				  enum pci_ers_result new)
 {
+	if (new == PCI_ERS_RESULT_PANIC)
+		return PCI_ERS_RESULT_PANIC;
+
 	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
 		return PCI_ERS_RESULT_NO_AER_DRIVER;
 
@@ -276,3 +279,58 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
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
+	pci_ers_result_t vote, *result = data;
+	struct pci_driver *pdrv;
+
+	device_lock(&dev->dev);
+	pdrv = dev->driver;
+	if (!pdrv || !pdrv->cxl_err_handler ||
+	    !pdrv->cxl_err_handler->error_detected)
+		goto out;
+
+	cxl_err_handler = pdrv->cxl_err_handler;
+	vote = cxl_err_handler->error_detected(dev);
+	*result = merge_result(*result, vote);
+out:
+	device_unlock(&dev->dev);
+	return 0;
+}
+
+void cxl_do_recovery(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
+
+	cxl_walk_bridge(dev, cxl_report_error_detected, &status);
+	if (status == PCI_ERS_RESULT_PANIC)
+		panic("CXL cachemem error.");
+
+	/*
+	 * If we have native control of AER, clear error status in the device
+	 * that detected the error.  If the platform retained control of AER,
+	 * it is responsible for clearing this status.  In that case, the
+	 * signaling device may not even be visible to the OS.
+	 */
+	if (host->native_aer || pcie_ports_native) {
+		pcie_clear_device_status(dev);
+		pci_aer_clear_nonfatal_status(dev);
+		pci_aer_clear_fatal_status(dev);
+	}
+
+	pci_info(dev, "CXL uncorrectable error.\n");
+}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 82a0401c58d3..5b539b5bf0d1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -864,6 +864,9 @@ enum pci_ers_result {
 
 	/* No AER capabilities registered for the driver */
 	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
+
+	/* System is unstable, panic  */
+	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
 };
 
 /* PCI bus error event callbacks */
-- 
2.34.1


