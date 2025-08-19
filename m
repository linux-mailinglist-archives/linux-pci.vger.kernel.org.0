Return-Path: <linux-pci+bounces-34290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE5CB2C259
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 13:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2BB1B61AAF
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C0A3375BC;
	Tue, 19 Aug 2025 11:55:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022135.outbound.protection.outlook.com [52.101.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4189432C32C;
	Tue, 19 Aug 2025 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604519; cv=fail; b=lKLRWexBsYyOXsOz3eT+VJyutUJxqmLiN4RcEQqUtwumu2HgNpLYdUDMkZwOGP69+UVT6b5LDsRkyPV4yiprR2R9+hcqBIdhPR7QZDFqMDAXFym0ZqtNr/ww+msLC0c7i7NKzF5ikQYnaO4QzZyVQGLnQubCnepSXzReztkL/yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604519; c=relaxed/simple;
	bh=mpRj6q9fyfWM6MFZgz4skko2EfI0MPzZsSv4YLxwX4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLAm4HbZd4z0Vdpox6qH5M5Nv1jEN8K8C2dGjVcd1iblAMqoe0zPF8cjsc6K6juqpy3pNjbFlo4Cv43OMNoHWmHcOrm6OmKFWjNCkumyrC9BZEUD0Mv/cevjuuKmRcl0MTm0g7K3wTWiSjVA6waEJWHj257dDcV5KgupJbGC3Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhjgNxMG9KGelJrYFXroTCOR+PmsHul3gKNq8ZhdhsaOAcTh20/fNVC7boW2FECggtZ/C4cJQOmgp9nzni3luFB4MpMM9zmLs/GHOIjyLnX+g/2STKY3+PA1eAdYn1aNTgBILHszINeMliIp/0Of4v3XkWsLs4UQM7iPHpci+oDCaEwGs4zUvsBqjAByisB5cn5cBYX15sctyjayedtwB8PJ7s6fXG5TlfQmCJ225g4a0yvz+fXHsBK2wR0QIrrL60XJbkWrV1eEP6G+aA03UQuUwt06KRLtoinBaqwNRr7+j4NRktlO6/upaIryyyyIF19VKpJszKHGSfomzUKHMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVzDq/MBzi476nmOha8F5FUgWvTbGT6u9Ir3ZogFNkc=;
 b=oQcpmlzSwn7Gb5OgxrD6iQHlA693lNFFb+ANldrVKOz5VIYV5pZQW6pKw/mva/D2XoTrszr9uu+WtItlGWl1msEQqjwsYrMO8jiU1ng/u5wjtYCKfnjEoV7Sq5klvnhHU444OOnF9JbiEijRFQNOLVImB+JOtUquaLGcway8oTTKC3DT2gX3UYFZGDMjFxvy6ujI3vHEe63odXCRvyYL+adjVWlZl5/PRt+TapuUy2U6znMrfkJFfncIw0k8ds4HF06Jug9DEot8XzZRKSYBcBXwA+44LGVKid1QC3ndB977HTr3CgLBBTr/AbTfKVmiKywQZ0Qf5sij7mhV3ZSyAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR01CA0173.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::29) by TY1PPF0B80138A3.apcprd06.prod.outlook.com
 (2603:1096:408::906) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 11:55:12 +0000
Received: from SG2PEPF000B66CF.apcprd03.prod.outlook.com
 (2603:1096:4:28:cafe::f7) by SG2PR01CA0173.outlook.office365.com
 (2603:1096:4:28::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.21 via Frontend Transport; Tue,
 19 Aug 2025 11:55:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CF.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 11:55:10 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 73FE841604E0;
	Tue, 19 Aug 2025 19:55:09 +0800 (CST)
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
Subject: [PATCH v8 01/15] PCI: cadence: Add module support for platform controller driver
Date: Tue, 19 Aug 2025 19:52:25 +0800
Message-ID: <20250819115239.4170604-2-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250819115239.4170604-1-hans.zhang@cixtech.com>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CF:EE_|TY1PPF0B80138A3:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c63b6302-dff7-42b5-2788-08dddf173fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KkY9ratcdUwQyu2bZCo30RwcGMBvWqj8mQF3lLGut0kt1ZhVdkLZHwunvjOT?=
 =?us-ascii?Q?SQwlr2Ie4YAqi+JIkZnreCDxHXjkFL/fbenEz4yrAmae1yPxUhJANznCLWI+?=
 =?us-ascii?Q?KY6KCXhAxAMdW5wa6wwLMAdx35Yjx4QyOLPmfjXEeYvVyqOhU7HwXIBD4Z5g?=
 =?us-ascii?Q?jt4e8glTSta5julqb7GE1Gl85NHupnDJONuv98/XFE0OIfiDEBGMQ1L7TnfQ?=
 =?us-ascii?Q?D9uM5ur/2SDpl6Mfjare5Jv1BoPURpw41si5BBnDA+NFQzxNk0NbK5mqPRzV?=
 =?us-ascii?Q?2XCghADqtRpK+xORvbGkbGXifWMWwIybPybZDupAMMCNa1vZPVPW8MxYLhNc?=
 =?us-ascii?Q?oOiRtUHj+jGdLvPa2nsL6uMIWQ0pVBdGytM7K2x1I9qBN5MOQoDq9ytoCpMC?=
 =?us-ascii?Q?U/wyXmk30c0P96VvSCusvXGWoSUAhAPI2Qm4NlGOV8TwoV96SvUx/pNY5Uxl?=
 =?us-ascii?Q?9NSIFhPhHX/CG3t7ElnJUK9XPEnlke+GQ7AZb/4BpxcZ46ZNTso4FFx0FpZL?=
 =?us-ascii?Q?1RfEBiezGXoLige6C9upMl8l7ZmN+UhSydwv/4eIHoK4gH1Z19YT1Jf0XLTB?=
 =?us-ascii?Q?0OIaVeKLzh0pYR9oJWTq8s5d3xxQHXWBZC2DT1TvulS5OYx4jmy/fxE6rp+I?=
 =?us-ascii?Q?WOtKsOdZRP/U5wbQ8x/vkq6WWvLSLAK5a/T0MtGnz7XiqUqzJnayFGIwygI5?=
 =?us-ascii?Q?asu56oh5KUg1PJOuJ7xYoNHmdZuehyVsFO8WcvVpBstVZzIdWKdEbxCzvi9z?=
 =?us-ascii?Q?StgMlsSl8y9Br2nGrc5cQ/A7sZcz1gBKg/pPrAdZH1n5XzW3Iz/ookFYle9o?=
 =?us-ascii?Q?LNPJOfHO6HErJfGXNsEin2/wUgl6QWZFMCSCcL8weuVmAlrb3wgHxupLzT++?=
 =?us-ascii?Q?jjZBDtfQJ6cG30+3UsfRm5fp45IvBumMBehHUPtYijsBH5bKcx1lMywN55zm?=
 =?us-ascii?Q?KvK+gNp53Bs2KYYcnUj89YUYNwvY8BYgp2/8OPwHQqCCI7qi7DzpG2htKV9i?=
 =?us-ascii?Q?iijzpVdD1jC99bqIZJQPKsBp6C+ho/nBaESbOUqDxmaOWYCEbHOQzWulupQ4?=
 =?us-ascii?Q?9hGr5b2qnASk0IfYyA8QoakHODtl9a3Uj4LBXrpjQ9cq92S/RvwgfyjwyiSB?=
 =?us-ascii?Q?j22Y5zdYy366Ip84/Ud8cRRGfa2MIBuQWcolX23XxQJmwZBwnwAag0qqgK0c?=
 =?us-ascii?Q?WcOtzZ7jOK3gwV4+U261HFtibd86qidT6Ua9a65mdFd1aI1jx1+sgdUxdkPa?=
 =?us-ascii?Q?sMCKrEdT/QnGDPd9fSYngwhFHnUnLf9IeOP4uifilypvC0BQjcBBVzXxb5Cb?=
 =?us-ascii?Q?rpR8m5KMvEBg+ix89xMvj8ZEoEGpaFkPZAPO1vTWEvv7RYTi8REy0ToUpnVJ?=
 =?us-ascii?Q?01PWX8zcKE8MfEpZKRx22ZVnYV9dWD0xRNB/25gu038JUHEIq/Vk6xOXY3jX?=
 =?us-ascii?Q?6mNV4vcr3IDMi/cgoPOzF+wr3lBtsvWObjDobRX8tm/93p7zU/OGiOdiNDpB?=
 =?us-ascii?Q?nhFN6uR5xR1cCmTjjJ9wfy0c0KoulrvNUy0f?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 11:55:10.1868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c63b6302-dff7-42b5-2788-08dddf173fc5
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CF.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF0B80138A3

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


