Return-Path: <linux-pci+bounces-38707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B1CBEF49F
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 06:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB6E3E0EF9
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 04:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C40A2C2376;
	Mon, 20 Oct 2025 04:29:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022098.outbound.protection.outlook.com [52.101.126.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CF32BFC73;
	Mon, 20 Oct 2025 04:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934549; cv=fail; b=D54ifldF70Ti3GpFJVxR5tJrZNZLHFnBPTujFu9m050FpNgYdCXrangj49N2BL0YCHsy5wn3C+tsGD0hy9XleL2s1cW6goHOPXGH4mYJ5vxtvZwcERKTeksFrgd8cCxdH8cfK5qLWeb7TWV2GxNausbD0lUwPCgwX41zTx57npM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934549; c=relaxed/simple;
	bh=X+k7Iigd2NMGn/R26vLP63F94H9w9AxUntSWq+w6fJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N95W4CsobvSthxlzrm09nl3hXUw1hH+6TSGiBfJW6PiGHVXidZYtixkLKHgreMnBy/a7Qa1ObRLRPChh1NT4fioDCfwK0hh2SounMe2XFAXNv+gzzFm9S5foiPmZsKSGp9vuHynITUW9N0e4Up5Rk2Bs/1NNwjdDW8jnOTQ3qXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZ1YFVbJ6gI0qgM3XolzUrgOGDYlW6tQzSuzMeu+eRFG3/0HCv5RMvqdyHyLAVsoLLGVmUqbeE/2N/DO2ksuQLtzNeD3NjTl3lZXdKEJL/MQFvE7yuVgrRY6USBxwh1nICDOydbDIPXH0ZezlV56QdbI2gbQCgoYyCkNKXFsx10GVlbmzBiIJlo3Xf1v2PaKLIVfXjj67tCdMHdHsPNsr5EIRUWY7/kvuBntJVGILGYeoUbfWRuo616EKzvNfN7zqr07MNwxIodHUFv7zRXHp860NZ8C9bMvtebIPrPrPCC8TtXWyI+v/dTW73Cgoeo6bTFQoeLb5w/Wy2pPV3soXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+udEMxIaEkITBc0fDjiQfdSxHcDgn+KJXyxrpbyPnU=;
 b=pc1GMYYS5obToRyFhgoUt0Yu/t2YrgyXFkv23kcZIqdl8UF2IvfZMy/VOMB/eFZUPFRS2aoBwdh6Nj5J6RDFGPkRpXk3hpqjnITfaSGURJe2reWzr6fV0pUeYvmTZ2P4wICj7tp8v2c2oRE3rz+e/Q3mhZau1ruxXo4azgOIcXauFIqfPcm8rfunMngphtz97ZaCWizMoiARnMZ44KJpfy8WzU01JtI/Yxy3TfNh/IYz9cUOA/D3l1j/EwkVvU5SDjjivuMMAS03i6ctEE+tmVTuly6YWcoNHLdb/gYJ5G9WyQxwp10qAtpewyg9A3a3t2vdBx2yIzLr2YacXljtKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) by TYSPR06MB7046.apcprd06.prod.outlook.com
 (2603:1096:400:46b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 04:29:02 +0000
Received: from SG1PEPF000082E7.apcprd02.prod.outlook.com
 (2603:1096:4:192:cafe::cf) by SI2PR01CA0020.outlook.office365.com
 (2603:1096:4:192::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 04:28:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E7.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 04:29:01 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 100594115DE0;
	Mon, 20 Oct 2025 12:28:58 +0800 (CST)
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
Subject: [PATCH v10 09/10] arm64: dts: cix: Add PCIe Root Complex on sky1
Date: Mon, 20 Oct 2025 12:28:56 +0800
Message-ID: <20251020042857.706786-10-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E7:EE_|TYSPR06MB7046:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 10ad6f16-a02a-4d6b-d03b-08de0f913207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?llWOHvSZ6JKvzpYql3mJwcGLN6aHQTdAn2gUFvJeR2KPj6AQ3Muuox9I1RJ9?=
 =?us-ascii?Q?0Uo3HS3TlIxjvWOr7iPHIMANWSoLdRj4dMR03YDfNNUx+AHkBz56d20WGGw5?=
 =?us-ascii?Q?+L0P8mC+gYKsIP46Ceg7ZkctsmhQL4UAUzwmzG3uYZTmaeuy3ZK66eMfFNfS?=
 =?us-ascii?Q?XOmlTg7oPTHD2es1koOq99hKOCHC496u0NixgQnSDtpfgrb8gaXfduO7kkfH?=
 =?us-ascii?Q?P2Ac/a4QOsORoCVSuJ+LrdCcVWakE3Z4PZ0dikhR7x/9+zFi/DYLbzvMTnkK?=
 =?us-ascii?Q?JmEjtIhCxGEHRDaluBUWZkBUmDRPhLBXPOcivq0jKqX6rPJLuYgKIZIs/eJD?=
 =?us-ascii?Q?Q+ZQczu52Gg+RTafCgzaKLiH5DkbkX/X6iY7kQshDX044AXdaWwVYhtbFhVq?=
 =?us-ascii?Q?jHA/THTvv9HO59TuwB696duyA+J6HDHb1rZtFd2o3cpifqX9D05C4jbL3OQC?=
 =?us-ascii?Q?I7N0mGZ4fTv1UTKZrnAfIdhsie5YJg4jL0py9VFTUo14HspNUbtDaEWPkBDW?=
 =?us-ascii?Q?Jp1BYH9H/8FnFjqnJ3nJcIhiOzdQv6c4dmN4yuWY2wN5j77AgOEVgg7y29K3?=
 =?us-ascii?Q?SmWPdZ9YizwBhu7BkNgEVJRANcZMjm3RQmjulUEtde0v4HbbBXtTBmrC0i9a?=
 =?us-ascii?Q?xI6evfcZ0jEgkc1Y2cOIXNlNgsOlpkJAXYFHJW+1daso+FmK39cRqeWgkqJ9?=
 =?us-ascii?Q?HrP1r3BRY7nHxLcNGbylL6+UUoVHhatgvFHoUaDWUcINUyM+EQVW9jOMIMaF?=
 =?us-ascii?Q?cw3HGaJTC2qE7dibBOZyVVFSdouDGINqK+UG15RK+CS/zcVhBtFCWXrHr2+K?=
 =?us-ascii?Q?OxV63/G9pXmNiHrucg6VJPUBkgYu6mJMo9q4r1pb8Sq4YL/vIH+JKh9wx5cj?=
 =?us-ascii?Q?IS3f+IAVVnRekcK9Gwe8DEgNiI7AjNzdKq49GUbwbScCO8ALuDGC5Cq7Qu8p?=
 =?us-ascii?Q?UGY+URe07/8FWEq5ULcnsNtH75Y0AU6hBsmkBsB9r9q59AMz1ZKdoMYaLP52?=
 =?us-ascii?Q?9BmkTF2bk8ouzMRaXfEyXRCE/4hMENhQ35JakSyNdRdgKeWnHMETPCZl0lgx?=
 =?us-ascii?Q?jQqdCqActgbfFDkNCdsphlE/3x5YPO5i6VH42DyGyNkLu5zyyaopOey6suy1?=
 =?us-ascii?Q?nn6wxKt8m+rkmPu0tEQJeyJrISUitD5D5rql58Hu2i+ytz+gxLhyfXZemg/U?=
 =?us-ascii?Q?pzx+/WALHa4WEt+GTqHjEdnuCOIjZotG1Rab2b8Fnm+VBl0f89p3JhpJqOPQ?=
 =?us-ascii?Q?wPZS8Qc98Ls2tt4Xa3U1U9CQeGbJ6JHG6yT/M47kNlO34sU7LAF9/ZdqR3Ya?=
 =?us-ascii?Q?WztNkdDW1Oqzyh/eCU+kYOCZxlwVQJVlzYrk5jLiO4JtQQU60bL0DiUa48Dy?=
 =?us-ascii?Q?zl382gaBocwq2FB6/fLy1P3Q7gDp8tHev/LoFOc/EM6xpKZBtnOTz2yYL/zC?=
 =?us-ascii?Q?TwAW+/66XQakJMNwhYz2M7kCngY9hG1qsIZEFEqQSb9HbBTHbHdHhBHunsQA?=
 =?us-ascii?Q?+ppoYOKdxF7aPOuTspyUGVdighCtosMoEe4iie6gOcRKJMGO5MM0W6yJDPDA?=
 =?us-ascii?Q?LM5BOWmfWwjDGFINvOs=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 04:29:01.5607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ad6f16-a02a-4d6b-d03b-08de0f913207
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7046

From: Hans Zhang <hans.zhang@cixtech.com>

Add pcie_x*_rc node to support Sky1 PCIe driver based on the
Cadence PCIe core.

Supports Gen1/Gen2/Gen3/Gen4, 1/2/4/8 lane, MSI/MSI-x interrupts
using the ARM GICv3.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 arch/arm64/boot/dts/cix/sky1.dtsi | 126 ++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
index 2fb2c99c0796..1abafbfc3c9b 100644
--- a/arch/arm64/boot/dts/cix/sky1.dtsi
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -388,6 +388,132 @@ mbox_ap2sfh: mailbox@80a0000 {
 			cix,mbox-dir = "tx";
 		};
 
+		pcie_x8_rc: pcie@a010000 {
+			compatible = "cix,sky1-pcie-host";
+			reg = <0x00 0x0a010000 0x00 0x10000>,
+			      <0x00 0x2c000000 0x00 0x4000000>,
+			      <0x00 0x0a000300 0x00 0x100>,
+			      <0x00 0x0a000400 0x00 0x100>,
+			      <0x00 0x60000000 0x00 0x00100000>;
+			reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
+			ranges = <0x01000000 0x0 0x60100000 0x0 0x60100000 0x0 0x00100000>,
+				 <0x02000000 0x0 0x60200000 0x0 0x60200000 0x0 0x1fe00000>,
+				 <0x43000000 0x18 0x00000000 0x18 0x00000000 0x04 0x00000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0xc0 0xff>;
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH 0>;
+			msi-map = <0xc000 &gic_its 0xc000 0x4000>;
+			status = "disabled";
+		};
+
+		pcie_x4_rc: pcie@a070000 {
+			compatible = "cix,sky1-pcie-host";
+			reg = <0x00 0x0a070000 0x00 0x10000>,
+			      <0x00 0x29000000 0x00 0x3000000>,
+			      <0x00 0x0a060300 0x00 0x40>,
+			      <0x00 0x0a060400 0x00 0x40>,
+			      <0x00 0x50000000 0x00 0x00100000>;
+			reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
+			ranges = <0x01000000 0x00 0x50100000 0x00 0x50100000 0x00 0x00100000>,
+				 <0x02000000 0x00 0x50200000 0x00 0x50200000 0x00 0x0fe00000>,
+				 <0x43000000 0x14 0x00000000 0x14 0x00000000 0x04 0x00000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x90 0xbf>;
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH 0>;
+			msi-map = <0x9000 &gic_its 0x9000 0x3000>;
+			status = "disabled";
+		};
+
+		pcie_x2_rc: pcie@a0c0000 {
+			compatible = "cix,sky1-pcie-host";
+			reg = <0x00 0x0a0c0000 0x00 0x10000>,
+			      <0x00 0x26000000 0x00 0x3000000>,
+			      <0x00 0x0a0600340 0x00 0x20>,
+			      <0x00 0x0a0600440 0x00 0x20>,
+			      <0x00 0x40000000 0x00 0x00100000>;
+			reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
+			ranges = <0x01000000 0x0 0x40100000 0x0 0x40100000 0x0 0x00100000>,
+				 <0x02000000 0x0 0x40200000 0x0 0x40200000 0x0 0x0fe00000>,
+				 <0x43000000 0x10 0x00000000 0x10 0x00000000 0x04 0x00000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x60 0x8f>;
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH 0>;
+			msi-map = <0x6000 &gic_its 0x6000 0x3000>;
+			status = "disabled";
+		};
+
+		pcie_x1_0_rc: pcie@a0d0000 {
+			compatible = "cix,sky1-pcie-host";
+			reg = <0x00 0x0a0d0000 0x00 0x10000>,
+			      <0x00 0x20000000 0x00 0x3000000>,
+			      <0x00 0x0a060360 0x00 0x20>,
+			      <0x00 0x0a060460 0x00 0x20>,
+			      <0x00 0x30000000 0x00 0x00100000>;
+			reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
+			ranges = <0x01000000 0x0 0x30100000 0x0 0x30100000 0x0 0x00100000>,
+				 <0x02000000 0x0 0x30200000 0x0 0x30200000 0x0 0x07e00000>,
+				 <0x43000000 0x08 0x00000000 0x08 0x00000000 0x04 0x00000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x00 0x2f>;
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 437 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH 0>;
+			msi-map = <0x0000 &gic_its 0x0000 0x3000>;
+			status = "disabled";
+		};
+
+		pcie_x1_1_rc: pcie@a0e0000 {
+			compatible = "cix,sky1-pcie-host";
+			reg = <0x00 0x0a0e0000 0x00 0x10000>,
+			      <0x00 0x23000000 0x00 0x3000000>,
+			      <0x00 0x0a060380 0x00 0x20>,
+			      <0x00 0x0a060480 0x00 0x20>,
+			      <0x00 0x38000000 0x00 0x00100000>;
+			reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
+			ranges = <0x01000000 0x0 0x38100000 0x0 0x38100000 0x0 0x00100000>,
+				 <0x02000000 0x0 0x38200000 0x0 0x38200000 0x0 0x07e00000>,
+				 <0x43000000 0x0C 0x00000000 0x0C 0x00000000 0x04 0x00000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x30 0x5f>;
+			device_type = "pci";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH 0>;
+			msi-map = <0x3000 &gic_its 0x3000 0x3000>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@e010000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0x0e010000 0 0x10000>,	/* GICD */
-- 
2.49.0


