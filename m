Return-Path: <linux-pci+bounces-35258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA3FB3DE58
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 11:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3DA1892E37
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 09:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D966530E839;
	Mon,  1 Sep 2025 09:21:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023073.outbound.protection.outlook.com [40.107.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF59630F558;
	Mon,  1 Sep 2025 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718479; cv=fail; b=gI8HsNgabb2zcgQ7cKfqnI5CCepTVrGdFOELBUotkVOlhFYQGxtOdepRo8vA6I37SU3cjFDCEm4bPSRJPP4czp4yCt/Xwx4eKNt0cREOdoKdultBYX9vBS0AZ2HHSNucysSB4B6m737ikSiJARQ4341pzWVQdKLvBugehYWi0zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718479; c=relaxed/simple;
	bh=iBxSvoUnPoBU2EyNQCKIX8gULd/ZDM2MqMSMXOlNsb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVIJJW/JkTMO7ecGqC7wOEycOtjAUXRUS2e5e3dyc8zmLaET+rM2tQABDMKYOJiFWoKrYMWe7EL+AgdV15rWTZKS+z9mKuiNJlVFFbfJzXnZdMQSzy2wrbAdws9GrUM7BCkTZNERPRlu+9sQJgXC1lO3l1UPxDbgnFF2TFakdGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCX3EUJAvRSYFPKzygsID8qJ1OVxOX/Tsi6ADVWAUBqJxW8nDIejUfxrLtecCRGSxjqXAe1uBaGoClINx2DtPRRDbPgzFgT8otLpfQjpXAlVbdy3kPJe3WKlutuLX/0VdoyoDpSGOCMoVZavyz90GNbJYVFEW/yAwfBN8s0IdfJSgeCk8wWRIuJeSbpCzThLabyO1Z7askeQ6HnqV0WQFUaJj6scbBQZkgrBameVCpboxAw0kalSn1GQ2BVXrLZUqL1ZdQ1ZhoOJ4BEbDTyZUDPFykzyG+ZmPnbTk+AS4lPsJ80S5DmGqmOfbS2H1EkUcBWPqMv0e5JGW/OyiTZPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Gq6gbY7jZXNWd/1l+ZBzTZUHx4fNNkL0ZGeuTeLAeI=;
 b=rHv2cxS8ae4gzuj8i2N+Ck25ixaGFspLPNTWV8pdvw+2LONtqWWR5A+TZY2tZ9iMM8FBkV3xC1Gj5OpLZuEPyKR41bA5/VUxoc/nNQ9O1nMLHrMP5iN9gxPmw51/45JbEwGEDGAUEF4D9LaO7c9Ifa4PbtGuOo3i3bxcGweIqb4cUlrGpbjjzrXMZD9DWkw77+tuC/ru19AjV4V3Q7U9+lHGlWkBFm8y3XJgGvpRYg+FbDpX7c3oFylrZba3ymnPVqlvTnQfZfMTFapnwOQ62afyxybMWFAjU1GHpZjEY58tKpPlEmFzvbCjD3Ex1cG3UHPZtVMQHfT8yHwl1/Y6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SEWP216CA0020.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2b6::12)
 by JH0PR06MB6293.apcprd06.prod.outlook.com (2603:1096:990:10::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 09:21:12 +0000
Received: from TY2PEPF0000AB88.apcprd03.prod.outlook.com
 (2603:1096:101:2b6:cafe::83) by SEWP216CA0020.outlook.office365.com
 (2603:1096:101:2b6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Mon,
 1 Sep 2025 09:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB88.mail.protection.outlook.com (10.167.253.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 09:21:10 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 976E941604F1;
	Mon,  1 Sep 2025 17:21:05 +0800 (CST)
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
Subject: [PATCH v9 14/14] arm64: dts: cix: Enable PCIe on the Orion O6 board
Date: Mon,  1 Sep 2025 17:20:52 +0800
Message-ID: <20250901092052.4051018-15-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB88:EE_|JH0PR06MB6293:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3a169766-0c59-45d9-8709-08dde938e3c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nrmbq8sjwtoXIumZN1PZzkrJsz/K4433PXE7GOcY39ISYAMZRkj5kOXA+Cjb?=
 =?us-ascii?Q?Bdb7S+Nun827vH3JkQX81U4gmv8juCASZcB0+tfrPuHHxSr1MOd1jhxBFpPT?=
 =?us-ascii?Q?mCbLKkj7hgsyqepvLf8U9lzlEnw6tgREzNuUyJc+BXP1Ld0lfKHK4zqK5cvq?=
 =?us-ascii?Q?bXCiEVspIZQ85eBnfRGKVSokVDa7WDXV5eLJgAZrdCW5PH/rKSvXPldX5CGz?=
 =?us-ascii?Q?1XnRjW6hvCOADV2yaXAU360laLAT7jRI/keh+G+WttuXPf2PpJb/+QLeCDGH?=
 =?us-ascii?Q?cH8Ql0O8ed3fqGRTTJMHCP/twU8sIpEfTdGr8bVWf9+wY0dlQK91o5ZVDFgO?=
 =?us-ascii?Q?DRDfrVng+zP34QNxMzBZcU/i90rUVTlf1e2TWqqUFV1HzLS+9HnUYRL7KvWq?=
 =?us-ascii?Q?gpLig5COrtJhuCjaI/DCr+Seagb52VOrkj1HmD/iPJRc/kU+y7pj6FaANpDW?=
 =?us-ascii?Q?PmD9rjC+p1zCWai0QFD1V7Ri7F4OnT3ls5Oy9lCmsFDZv4ud9hB4sBsUW7mp?=
 =?us-ascii?Q?Fx5xfAvJgSh1jbIO3XeAZK7HNifHT4DH3WixDkvXWk3Onqryku4LBAmBymnl?=
 =?us-ascii?Q?u4k5aSyOjiF5q/+LIr5wDozfxEtVmIiUvSc4MqA8DVmrEwZoVLuTskGzcqru?=
 =?us-ascii?Q?G4Ekla5kiDfxOi6aNAuzmKf8UcadwvT4RHVBlge3Kj3677qFSYlV31Bq9wWu?=
 =?us-ascii?Q?KzM4G2JR3R/6EWmXP57Q88zKUcsatUszurcoyL7ulVRVQtbYJBZdZsT1/3JR?=
 =?us-ascii?Q?hsUSf5gXE2Gi0wv8z9WMIk9/vgeMBqnidqfCbyJuqIMq5BrW6dng+BR1ks9+?=
 =?us-ascii?Q?Aj9JKhFJ0T+SSLIyeV8otBCglsImyPvnnMTBNAiyVRPcTMOICWGLLoYBxzRE?=
 =?us-ascii?Q?4N1U5sc4K50OgF4mQVIC3O4K4zUfososjMQqg7Eeif3BfrTmef+qr5uansN5?=
 =?us-ascii?Q?UpPAgDYO55u8zpBV0UL7xxMur02Iejmn16pWa7ron9uNv7XimKoKZ9qMEDyl?=
 =?us-ascii?Q?fJXy3ST7AXEcqbb6pXb9vFjk6K8QSzJjbEgPuvzcTvlDCT0hz2AnxZj8Kfc4?=
 =?us-ascii?Q?qJpg0PLlM8f4M8kJ86yKoXn48b22rDe2WiadC1Rp4MBMwsdf7ee6Bf3lF7de?=
 =?us-ascii?Q?LTTdCx2M1MpGPj8eBZgf/XmD0j34Ltf68xx+0vB2UBO2dTOZVi2fvwTGE0fE?=
 =?us-ascii?Q?U4+VEXysfm2xBO2bj+J+4Gc0zZ8KgZ1zqQIfzrmPqlSQh/WekTc4fxA7/FSU?=
 =?us-ascii?Q?MQBdqKXsYusr6ZC5UFaFsQ0uo4CyF4aMaKPKLQfMsDYzqKyKG3mW4B38YE4p?=
 =?us-ascii?Q?bblMxMDiRJfsg+3lzhvMwT+3Hhaa7d5sRI8iM5iP4qpjJr4Uy+M5MhWAJ96c?=
 =?us-ascii?Q?yVBFvdQfxB7/IcMF9cjYUQyc5LTvUhEXwB6hM0KxE/gdiM7BQx+9T5bvJGlg?=
 =?us-ascii?Q?D9AyVBj4ufOTtTMEbH/EmwOSskhcK1WRiI44ak1lLO5RGZI2LR+adAmmK2Gh?=
 =?us-ascii?Q?eKcupT9Y8t6p4vcnh3RJKTpPmuJ3BR3Z/Ddt?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:21:10.2923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a169766-0c59-45d9-8709-08dde938e3c6
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB88.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6293

From: Hans Zhang <hans.zhang@cixtech.com>

Add PCIe RC support on Orion O6 board.

The Orion O6 board includes multiple PCIe root complexes. The current
device tree configuration enables detection and basic operation of PCIe
endpoints on this platform.

GPIO and pinctrl subsystems for this platform are not yet ready for
upstream inclusion. Consequently, attributes such as reset-gpios and
pinctrl configurations are temporarily omitted from the PCIe node
definitions.

Endpoint detection and functionality are confirmed to be operational with
this basic configuration. The missing GPIO and pinctrl support will be
added incrementally in future patches as the dependent subsystems become
available upstream.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
Dear Krzysztof and Mani,

Due to the fact that the GPIO, PINCTRL and other modules of our platform are
not yet ready for upstream. Attributes that PCIe depends on, such as reset-gpios
and pinctrl*, have not been added for the time being. It will be added gradually
in the future.

The following are Arnd's previous comments. We can go to upsteam separately.
https://lore.kernel.org/all/422deb4d-db29-48c1-b0c9-7915951df500@app.fastmail.com/


The following are the situations of five PCIe controller enumeration devices.

root@cix-localhost:~# lspci
0000:c0:00.0 PCI bridge: Device 1f6c:0001
0000:c1:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
0001:90:00.0 PCI bridge: Device 1f6c:0001
0001:91:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller S4LV008[Pascal]
0002:60:00.0 PCI bridge: Device 1f6c:0001
0002:61:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852BE PCIe 802.11ax Wireless Network Controller
0003:00:00.0 PCI bridge: Device 1f6c:0001
0003:01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
0004:30:00.0 PCI bridge: Device 1f6c:0001
0004:31:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
root@cix-localhost:~#
root@cix-localhost:~# uname -a
Linux cix-localhost 6.17.0-rc4-00014-g9549fcfa35ad #204 SMP PREEMPT Mon Sep  1 16:18:41 CST 2025 aarch64 GNU/Linux
---
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
index d74964d53c3b..be3ec4f5d11e 100644
--- a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
+++ b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
@@ -34,6 +34,26 @@ linux,cma {
 
 };
 
+&pcie_x8_rc {
+	status = "okay";
+};
+
+&pcie_x4_rc {
+	status = "okay";
+};
+
+&pcie_x2_rc {
+	status = "okay";
+};
+
+&pcie_x1_0_rc {
+	status = "okay";
+};
+
+&pcie_x1_1_rc {
+	status = "okay";
+};
+
 &uart2 {
 	status = "okay";
 };
-- 
2.49.0


