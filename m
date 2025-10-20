Return-Path: <linux-pci+bounces-38698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D80BEF45A
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 06:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59E304E1018
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 04:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6241B2BEC52;
	Mon, 20 Oct 2025 04:29:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023125.outbound.protection.outlook.com [40.107.44.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF913EA8D;
	Mon, 20 Oct 2025 04:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934546; cv=fail; b=K805xbal5iu37l6ovASIsIVTw6V9KGZNqjUv/vehJuoUz5sGn2AQV2LFs42p3Vysk69C2T0Njp4Qih1I7zugSx7jNMXjBy8z89GG+FZma8AhDENmg6/y3Qbe7Pjc5EuVLxvoxVEg+CepZIegBBb4xvojjn+bRrCgv5sNlnDtsQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934546; c=relaxed/simple;
	bh=ESSyOcf1dJH2KJHInIUwfyZ8294fOYNowzhlwYHmeSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViOeh5kUNYOKw8CirLJW8UcJaXm2V0SXOS2qncWbZL4nycT+qA/Sgw+YAc8EhD1K37qVL6P/9qBJuJRPiYJn8iylTADl5RbTjlpMZkmBeaM5DNy89fDVtJfBu8F7VzDjGbl4r0oun4/D3jiFGpzALo6IH143yO4qP2L6A22Fbtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OR+VAiaagcaoFS1DCPNoTBPiQU+VZEZBVDmsoGGQPWEirEKc8mvJP/R3jVjDmvPv437En18y7vzAK0T9osBY1pekiv4cA328X6y+v8Ze8YT2V5914XSuloqhqPcPbN43VJKRGBhHOg+fDy1U/+uhz122jeeJPWZb1wcuS7Wv2vMhBuzqeLplzVx7/h3LyeN/kpmTW5R3F5zKHV9NI9pDjOlJb6yZh2C7c57HDRoBnxD/K4etlMUnP5qS+4vWeOA1YMv3QLoBnMDPZSyaDYABOnVI7XLXrmz51/82kqPZx85AMbI9rsBVQWEu1hHX9w9A1m7GparULtiebLLlyWqbVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGKwFNsS+y6OkyhrS0kWj40aVqcUHSpchK8L1C9LhwM=;
 b=JPMwQPta68IbZuufmeYeNHxE4df8pUce5vrnlUe42G0UJGCFcYn1z2j3EroUgK44943Sc51gPNqmODyiZ0kLN51teCTZQNNYhiaz0Xhy6Ivxy0NVpu0eBBDEI3m6u1r1+ArdUGcSDJ4JmODtEo3YjrqvaIusdrjcFljoHxoqz4jEF5Sogvk3CI2qAVuvEeYqr7s24ZswYjSjBl9362PeLsj/eLQYCdKVGHUUxhzC7yBIHB/tASars9ygha3e/8l6AV4Ki4uF0rWkqO7O03BUBoaSasZagvqFblUNq7imKDVRod/p59AviDd79gy52SqKHjw8pqC1qfA5xQByYhJq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::24) by PS1PPF1CDE4C809.apcprd06.prod.outlook.com
 (2603:1096:308::246) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 04:29:00 +0000
Received: from TY2PEPF0000AB87.apcprd03.prod.outlook.com
 (2603:1096:300:58:cafe::44) by PS2PR01CA0036.outlook.office365.com
 (2603:1096:300:58::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 04:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB87.mail.protection.outlook.com (10.167.253.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 04:28:58 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id CB98241C0159;
	Mon, 20 Oct 2025 12:28:57 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	helgaas@kernel.org,
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
Subject: [PATCH v10 01/10] PCI: cadence: Add module support for platform controller driver
Date: Mon, 20 Oct 2025 12:28:48 +0800
Message-ID: <20251020042857.706786-2-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251020042857.706786-1-hans.zhang@cixtech.com>
References: <20251020042857.706786-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB87:EE_|PS1PPF1CDE4C809:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e0d40da9-fc54-4138-ba94-08de0f91307f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oqmIR1oe2+7jOio1Isg8f3eM9HaGFLvy476MQ24Jx4qe0FsZcMHCUduCbQek?=
 =?us-ascii?Q?dYzRMzSNGOQ/LoNpkJ2clbw6Bowe2XDm2jaVKbXohzhcTsWIiZ4rOeYDzkX5?=
 =?us-ascii?Q?hEn4ToHEaI0tc9lW1iWnSG9Ob9PfRVRAdIm/q5P6O6DoIvAhs5We8R8Ogu6P?=
 =?us-ascii?Q?Jqc34XBLfQ3Azr0W3arazsxiOl4a91vvA8Tawe1Z+2Fvmgm81KafJgraOBYR?=
 =?us-ascii?Q?658karBWfIT9aSuHIMF2BcEz8bR9esTA4R1Pa7obpDRhfFEU5EMmwfS/woyP?=
 =?us-ascii?Q?9K2ZyDl0IFLTe8YUPJ+jo67fJGqPNggRMmCIIIyhdfbVnGGbF4Box/WKUfH/?=
 =?us-ascii?Q?ifRbCIB+OJocDWCL6PO/AMmatmFLL+CuBvb3u5PtZTmWfxE5oPg9yjUaIQVH?=
 =?us-ascii?Q?9oOTLbBHIypBEPAODJkUFrdT0TQzWEovpx/xvAnjywaV5i9ejVHHkLbkSFs8?=
 =?us-ascii?Q?rkc6k+DFIqiGgVJ7Nw/2SXZNNHXKhexHywEDmg0CCGzN0brWe0tdr+zJNqgs?=
 =?us-ascii?Q?WgPNYJUWjqV/mdtZYjY5B1Av/WalB7CYce5CNDcyG2D+VHKR/T0zfngUssIe?=
 =?us-ascii?Q?t9AJJ/sxRxEyQNyCNKKJlIR1MmiFqruqSqmJD/xMUO679lUcCYX/jEYg7Put?=
 =?us-ascii?Q?JTiUu287bqLEOzm1y89+yC1Ddp3QUks8ENkGTP5a6bkH/6ESASqe5jz0UdDE?=
 =?us-ascii?Q?haHAZ/GS/Oh+psJpIP0g5mmE6SluwBelVv7iwjRQV16Hl4Py+AB9+YMEyxni?=
 =?us-ascii?Q?8fcWXbeRD4KiB8Ib+Da8Lp2Wi/eK3gxnPKPjl568s6U2H7phXxeSaERAUbKE?=
 =?us-ascii?Q?HgPrd2kPqu9Qu8ShzjqWWnnjNFsMmdM2+UxThKvTR2vhTrTvnHiFgD+cR7yP?=
 =?us-ascii?Q?jn/DKaqq24M2+aiq8jjqNyMm5HUKg17gsdtke85CVVPOkKrakLxF/wSFPALm?=
 =?us-ascii?Q?FkpNZPpyseyEgDKojjB0CoDxUppPn1efmE/Pgy0GOnV11igyXFLQhxns+EYF?=
 =?us-ascii?Q?ccVZDvdumGpguXECztE27/FoUFOL34BWX2oMQQNg2xKlQkjOvnflGix6I9kv?=
 =?us-ascii?Q?qIZZkI6hhHkQAwpCG5cUoPu/xgmzKZd00jC1MoyCi+T6Bso3FwClNQ/l/82j?=
 =?us-ascii?Q?Aa0tNRP6wvtpC4b/g1w07h584m4NzeizlPjwW17qciGfU/AOmcVJ/xMxcJjy?=
 =?us-ascii?Q?bDMfTL50x72gGF5nv2T5Xqh8nhB0CPe3vzL3yzw+BgK3zYdNPvKls3Pem0aI?=
 =?us-ascii?Q?Il6GbAAqBKSBSxToVZj+nLcUTnJx3/huVKdObYpLpyA04iXwpKhT2+qeGyuJ?=
 =?us-ascii?Q?08e8/46kflqIpTCX0j4lP3Mr6BbnBRiO/6xbzxvYiUnkD+g4xWhtAQhoa3An?=
 =?us-ascii?Q?PoD21fAflch4v2utlH+4l/NOm7rPgtG2F6dxQw0Cfb9mDj/uwRnXysy2EeYk?=
 =?us-ascii?Q?/QGml/bA+C1IFzA/vvtoYi0Xo5cji2gCWrWTO9t7QW06hVpWPxleeaKnqvRr?=
 =?us-ascii?Q?8jJBQbznB0ubslQ4UtVPbI7XIkUKcBkKCe+YHMAHMni3ahSY4Is33C+jAgZf?=
 =?us-ascii?Q?Eq9FNWmILENwq5l2pPs=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 04:28:58.9141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d40da9-fc54-4138-ba94-08de0f91307f
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB87.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF1CDE4C809

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
index 02a639e55fd8..0b96499ae354 100644
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
index bd683d0fecb2..8186947134d6 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -293,6 +293,7 @@ const struct dev_pm_ops cdns_pcie_pm_ops = {
 	NOIRQ_SYSTEM_SLEEP_PM_OPS(cdns_pcie_suspend_noirq,
 				  cdns_pcie_resume_noirq)
 };
+EXPORT_SYMBOL_GPL(cdns_pcie_pm_ops);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Cadence PCIe controller driver");
-- 
2.49.0


