Return-Path: <linux-pci+bounces-35246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C1DB3DE34
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 11:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F153B42A6
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 09:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF4530E854;
	Mon,  1 Sep 2025 09:21:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023126.outbound.protection.outlook.com [52.101.127.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF95A30E82B;
	Mon,  1 Sep 2025 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718474; cv=fail; b=WmZiXrJExRxRrhopYS2o6l2mYF4TR+E3rzTJqcHOlk42LafgBxJcVv00PpsPo66RUJr51GHTwP/BG9uvg2NXiCjljW/Z+Sw99LopAAgoyV6WwA44vwlUbFAOix4HOfTp0exP7AOvkEFBucpvh8PR/OYbX3Ah/LR+bc4gCu+mEa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718474; c=relaxed/simple;
	bh=mpRj6q9fyfWM6MFZgz4skko2EfI0MPzZsSv4YLxwX4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZwZNj68dRWtGT0gcqTUMbj1OF5Dydpoi2m40bmkIOPZ+VnYp/7jaY6dX8JuH7uR47JPqwTmMsluG1MMHM5PfzhLIxbMdPHjGQ74RwAxPesmZU5Z7FbpSBXAqvkhr7jBVqVwrao0k8i3u/AImLdx96sZe+FBBkmN7q1SszCJyfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYe9RjpWB520F+l9fev19zFo5byXZmOFgaHb7CI+azOg7EE69a93MgEM5OEI3G4ff1bXMdSxj3g0bDZuEquM98x1qR2xnDU1Oc8dEKz6o+y6dFQwsdasbpPxkzymRZBoIcper0tSK7s3Y/dszN/bRJX8gOP0QL0DCCWR7TqLRBmvMHR82TwZ0cM0SG6rMICkF8kaY/h7nvvAlSqzyf3B8OHGCT77PsFV2v4GRmEkV6goQQxqUhr86W4vOQktF2t0GsuGESEVOCdOEnR4tB9E4xORLm+Abc3nGJJZh1Agtmv6Y7Zvb2rPKAPK0tbzX5xpVzXD0vhvQNQIcCcSMQ5f0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVzDq/MBzi476nmOha8F5FUgWvTbGT6u9Ir3ZogFNkc=;
 b=qnLiUEAWXHcPCTfoyVNXDv6DAyUEAhG7q1j4ligYWFK7hDHU0ecNR0H8b4SaoHXepoCHzboExmQo4I+XP9tdap5/oa5PjqRoml6BtxjvxIoLQUtbJym3GhUslrEPlouXcyiyzwxh47gj1oUTON4aI2d6ChWE6rzdrHh3qAyJ9OOlskNzbjLv2ryGCjBhDMCXaa+OYmHxW7X5e147p1TBknbef0NfbrpmnlEgn7KrVrx1mzzMAR4qFVsWowXtdF6GyLoKnqCjpg+ccje6UoA0nd8luqhn02LS5NVb0ize4yupXJttMYsRpTH9pI50txZI0SICaokjsmnMriWout7LRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SE2P216CA0055.KORP216.PROD.OUTLOOK.COM (2603:1096:101:115::12)
 by TY0PR06MB5658.apcprd06.prod.outlook.com (2603:1096:400:276::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 1 Sep
 2025 09:21:07 +0000
Received: from OSA0EPF000000CB.apcprd02.prod.outlook.com
 (2603:1096:101:115:cafe::bc) by SE2P216CA0055.outlook.office365.com
 (2603:1096:101:115::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Mon,
 1 Sep 2025 09:21:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CB.mail.protection.outlook.com (10.167.240.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 09:21:06 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id DE44E41C014B;
	Mon,  1 Sep 2025 17:21:04 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	robh@kernel.org,
	kwilczynski@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mpillai@cadence.com,
	fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com,
	peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v9 01/14] PCI: cadence: Add module support for platform controller driver
Date: Mon,  1 Sep 2025 17:20:39 +0800
Message-ID: <20250901092052.4051018-2-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250901092052.4051018-1-hans.zhang@cixtech.com>
References: <20250901092052.4051018-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CB:EE_|TY0PR06MB5658:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 142d95cf-e2fe-459b-8b9f-08dde938e139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZU/bTG94RFpG6g/TaDYsU7A8Y6aVOiCXlUcoPHOZo1xHWx/kMTGl2BBoou4f?=
 =?us-ascii?Q?M3M+E/iIp3pDbzQAZUdGiiUwpNMlObEe/kie9xu5421lSbF1MigFziIHGPCe?=
 =?us-ascii?Q?0DM/5Mx5yksH5ndazF8GDRTJr8Oqc5mBA9U947xwrXih7e163eufoSz+R6Ur?=
 =?us-ascii?Q?LFmrDJO2C15rTZQf0BcbiBGDcSncPmz+Z6vwnXhY6f0L5zzpEvtxv6tfjYFh?=
 =?us-ascii?Q?LDsQDi0aQtoBfEJlW86WnLkdbJtRIniQQvzXZzAgDYki/oTs5pLFkGG30rBF?=
 =?us-ascii?Q?/OocBozpTCACXdB11RdjpMZZLNDnpEaCu5fDfJIbCzv6phzHXaMOi5xQJAie?=
 =?us-ascii?Q?POdtquurgmWNnPUSg0CK+ZbkhcDXbi/12zFhrF13F2dqBCO/uVEIpB8PfgC9?=
 =?us-ascii?Q?j0ztKV8MNgd7bRlfpEdSitkdRTiq38S0HOivTA+zuqfX7TljSh4wBQ1N9Fmq?=
 =?us-ascii?Q?6DJ3BroVcIkIbEcmJ3IrhB1koY3m3R7+1v2H6AUWwoR5aIfdDslBeQJhQkCN?=
 =?us-ascii?Q?3eOa6E74DyNPGjKixmPy9Pz9sf04EW2f/ZZ3bkZni3BqgqpsaLZdhTmsexPD?=
 =?us-ascii?Q?upb5LTtRNrMDXqE1r0AM+vWHkzMg8e8e9ntTyLlez/Qa1B7kTczGj9+mLa/y?=
 =?us-ascii?Q?1DTNu/W7its0H/Pt93cCzKKLobLyQwdaF7mojfi1EpChs98J/iTG5+KflKeH?=
 =?us-ascii?Q?/bqddXmw+/k8sUJNOn0dctSLNQRsOBZDJ6MfU5/5xUPFlmfcSzEPFeSYVAkm?=
 =?us-ascii?Q?rfxL8uutgrzrOpwI7NMyhobOiG+Ygi03J+DLehEG/E0n+wUFIgKb0LMq4Ybn?=
 =?us-ascii?Q?k/j6DNW/g+VdYoTqK7VYFHu38Jag/j+XYaahzticV2SO4YB154uKXxgtXro/?=
 =?us-ascii?Q?rizTouHSJqlQnDcz4nVxMht/8Nw7pVHU+s0+kTpHyBhbbAFfDePsIuiAu4Oi?=
 =?us-ascii?Q?HNkQH4YFaIdb0uOHzj+zwbL2S4mSribZFdwQaY12glrr9YwJwqL1f34/gGc3?=
 =?us-ascii?Q?KtwfWcP66xME3LtSl/7+ky1mtLAImeHRBn2ST1Cks26Xez547tb147dYiyIZ?=
 =?us-ascii?Q?boNhet2AXryVX/mjFao03Aqh+X94KGA1hEP8BsaS6sTALHIgQg4/l7l1Bk4J?=
 =?us-ascii?Q?cHh0C/RwIt2QZIKoAaSou+MA1IrBrdAJqKJdTQWmofwCkiG5b43cLJ2Gk8pa?=
 =?us-ascii?Q?RZZk0REh/QSoykVqCyYLQw9f8TFZSsn2MJMohXuaWeAIPOcZqCq1xFjjsUkH?=
 =?us-ascii?Q?uMcb/tbCVgmiWuk49spNqv5xQYTGH86/DGKhz4aqRlS1oD4sUasLsVucw2Eu?=
 =?us-ascii?Q?PbuGokLFEFR5g12qyUFk0EIWnQ9jVUA541dlmL3ykZk1fCBfGLoGY53RLXF6?=
 =?us-ascii?Q?K6dcA0bU9gdL1VPEZjiuAYCqN3ua7bkrTMb9mI/t1pHMf8WAra1x2zRnE/cD?=
 =?us-ascii?Q?VORyxcBMOENQeKq190CTOdaOkxwYBNfhSo3S6gTenTJR03AKgsnsyxopuAk6?=
 =?us-ascii?Q?HRi6zGa4jpW3/35YohrY78W99IkP+RCIXf1M?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:21:06.0543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 142d95cf-e2fe-459b-8b9f-08dde938e139
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CB.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5658

From: Manikandan K Pillai <mpillai@cadence.com>

Add support for building PCI cadence platforms as a module.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/controller/cadence/Kconfig             | 6 +++---
 drivers/pci/controller/cadence/pcie-cadence-plat.c | 5 ++++-
 drivers/pci/controller/cadence/pcie-cadence.c      | 1 +
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 666e16b6367f..117677a23d68 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -19,10 +19,10 @@ config PCIE_CADENCE_EP
 	select PCIE_CADENCE
 
 config PCIE_CADENCE_PLAT
-	bool
+	tristate
 
 config PCIE_CADENCE_PLAT_HOST
-	bool "Cadence platform PCIe controller (host mode)"
+	tristate "Cadence platform PCIe controller (host mode)"
 	depends on OF
 	select PCIE_CADENCE_HOST
 	select PCIE_CADENCE_PLAT
@@ -32,7 +32,7 @@ config PCIE_CADENCE_PLAT_HOST
 	  vendors SoCs.
 
 config PCIE_CADENCE_PLAT_EP
-	bool "Cadence platform PCIe controller (endpoint mode)"
+	tristate "Cadence platform PCIe controller (endpoint mode)"
 	depends on OF
 	depends on PCI_ENDPOINT
 	select PCIE_CADENCE_EP
diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index 0456845dabb9..ebd5c3afdfcd 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -177,4 +177,7 @@ static struct platform_driver cdns_plat_pcie_driver = {
 	.probe = cdns_plat_pcie_probe,
 	.shutdown = cdns_plat_pcie_shutdown,
 };
-builtin_platform_driver(cdns_plat_pcie_driver);
+module_platform_driver(cdns_plat_pcie_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cadence PCIe controller platform driver");
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 70a19573440e..5603f214f4c7 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -279,6 +279,7 @@ const struct dev_pm_ops cdns_pcie_pm_ops = {
 	NOIRQ_SYSTEM_SLEEP_PM_OPS(cdns_pcie_suspend_noirq,
 				  cdns_pcie_resume_noirq)
 };
+EXPORT_SYMBOL_GPL(cdns_pcie_pm_ops);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Cadence PCIe controller driver");
-- 
2.49.0


